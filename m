Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA18E1A73
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbfJWMc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:32:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49112 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391378AbfJWMbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFne-00017q-A1; Wed, 23 Oct 2019 14:31:38 +0200
Message-Id: <20191023123118.386844979@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Interrupt state tracing can be safely done in C code. The few stack
operations in assembly do not need to be covered.

Remove the now pointless indirection via .Lsyscall_32_done and jump to
swapgs_restore_regs_and_return_to_usermode directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |   10 ++++++++++
 arch/x86/entry/entry_32.S        |   17 -----------------
 arch/x86/entry/entry_64.S        |    6 ------
 arch/x86/entry/entry_64_compat.S |   30 ++++--------------------------
 4 files changed, 14 insertions(+), 49 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -218,6 +218,9 @@ static void exit_to_usermode_loop(struct
 	user_enter_irqoff();
 
 	mds_user_clear_cpu_buffers();
+
+	/* The return to usermode reenables interrupts. Tell the tracer */
+	trace_hardirqs_on();
 }
 
 #define SYSCALL_EXIT_WORK_FLAGS				\
@@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
 {
 	struct thread_info *ti;
 
+	/* User to kernel transition disabled interrupts. */
+	trace_hardirqs_off();
+
 	enter_from_user_mode();
 	local_irq_enable();
 	ti = current_thread_info();
@@ -351,6 +357,7 @@ static __always_inline void do_syscall_3
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
 	enter_from_user_mode();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
@@ -367,6 +374,9 @@ static __always_inline void do_syscall_3
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 		vdso_image_32.sym_int80_landing_pad;
 
+	/* User to kernel transition disabled interrupts. */
+	trace_hardirqs_off();
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -924,12 +924,6 @@ ENTRY(entry_SYSENTER_32)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -939,8 +933,6 @@ ENTRY(entry_SYSENTER_32)
 	STACKLEAK_ERASE
 
 /* Opportunistic SYSEXIT */
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
-
 	/*
 	 * Setup entry stack - we keep the pointer in %eax and do the
 	 * switch after almost all user-state is restored.
@@ -1039,12 +1031,6 @@ ENTRY(entry_INT80_32)
 
 	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt gate
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
@@ -1052,11 +1038,8 @@ ENTRY(entry_INT80_32)
 	STACKLEAK_ERASE
 
 restore_all:
-	TRACE_IRQS_IRET
 	SWITCH_TO_ENTRY_STACK
-.Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
-.Lrestore_nocheck:
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -167,15 +167,11 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
-	TRACE_IRQS_OFF
-
 	/* IRQs are off. */
 	movq	%rax, %rdi
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_IRETQ		/* we're about to change IF */
-
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
@@ -342,7 +338,6 @@ ENTRY(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
-	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:
@@ -606,7 +601,6 @@ END(common_spurious)
 GLOBAL(retint_user)
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_IRETQ
 
 GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 #ifdef CONFIG_DEBUG_ENTRY
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -129,17 +129,11 @@ ENTRY(entry_SYSENTER_compat)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -247,17 +241,11 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
@@ -266,7 +254,6 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	 * stack. So let's erase the thread stack right now.
 	 */
 	STACKLEAK_ERASE
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
 	movq	RBX(%rsp), %rbx		/* pt_regs->rbx */
 	movq	RBP(%rsp), %rbp		/* pt_regs->rbp */
 	movq	EFLAGS(%rsp), %r11	/* pt_regs->flags (in r11) */
@@ -403,17 +390,8 @@ ENTRY(entry_INT80_compat)
 	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt
-	 * gate turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
-.Lsyscall_32_done:
 
-	/* Go back to user mode. */
-	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
 END(entry_INT80_compat)


