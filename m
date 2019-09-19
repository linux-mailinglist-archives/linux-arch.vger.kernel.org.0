Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC61BB7DB4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390991AbfISPK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403922AbfISPJz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy45-0006oz-4o; Thu, 19 Sep 2019 17:09:49 +0200
Message-Id: <20190919150809.446771597@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 10/15] x86/entry: Move irq tracing to C code
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To prepare for converting the exit to usermode code to the generic version,
move the irqflags tracing into C code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |   10 ++++++++++
 arch/x86/entry/entry_32.S        |   11 +----------
 arch/x86/entry/entry_64.S        |   10 ++--------
 arch/x86/entry/entry_64_compat.S |   21 ---------------------
 4 files changed, 13 insertions(+), 39 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -102,6 +102,8 @@ static void exit_to_usermode_loop(struct
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
 
+	trace_hardirqs_off();
+
 	addr_limit_user_check();
 
 	lockdep_assert_irqs_disabled();
@@ -137,6 +139,8 @@ static void exit_to_usermode_loop(struct
 	user_enter_irqoff();
 
 	mds_user_clear_cpu_buffers();
+
+	trace_hardirqs_on();
 }
 
 /*
@@ -154,6 +158,8 @@ static void exit_to_usermode_loop(struct
 #ifdef CONFIG_X86_64
 __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+	/* User to kernel transition disabled interrupts. */
+	trace_hardirqs_off();
 	enter_from_user_mode();
 	local_irq_enable();
 
@@ -221,6 +227,7 @@ static __always_inline void do_syscall_3
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
 	enter_from_user_mode();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
@@ -237,6 +244,9 @@ static __always_inline void do_syscall_3
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
@@ -827,7 +827,6 @@ END(ret_from_fork)
 
 ENTRY(resume_userspace)
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
 	jmp	restore_all
@@ -1049,12 +1048,6 @@ ENTRY(entry_INT80_32)
 
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
@@ -1062,11 +1055,8 @@ ENTRY(entry_INT80_32)
 	STACKLEAK_ERASE
 
 restore_all:
-	TRACE_IRQS_IRET
 	SWITCH_TO_ENTRY_STACK
-.Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
-.Lrestore_nocheck:
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 
@@ -1086,6 +1076,7 @@ ENTRY(entry_INT80_32)
 restore_all_kernel:
 #ifdef CONFIG_PREEMPTION
 	DISABLE_INTERRUPTS(CLBR_ANY)
+	TRACE_IRQS_OFF
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	.Lno_preempt
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
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
@@ -608,7 +603,6 @@ END(common_spurious)
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 
 	LEAVE_IRQ_STACK
 
@@ -619,7 +613,6 @@ END(common_spurious)
 GLOBAL(retint_user)
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_IRETQ
 
 GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 #ifdef CONFIG_DEBUG_ENTRY
@@ -666,6 +659,7 @@ GLOBAL(swapgs_restore_regs_and_return_to
 retint_kernel:
 #ifdef CONFIG_PREEMPTION
 	/* Interrupts are off */
+	TRACE_IRQS_OFF
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
@@ -1367,9 +1361,9 @@ ENTRY(error_entry)
 END(error_entry)
 
 ENTRY(error_exit)
-	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
+	UNWIND_HINT_REGS
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
 	jmp	retint_user
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -129,12 +129,6 @@ ENTRY(entry_SYSENTER_compat)
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
@@ -247,12 +241,6 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
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
@@ -266,7 +254,6 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	 * stack. So let's erase the thread stack right now.
 	 */
 	STACKLEAK_ERASE
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
 	movq	RBX(%rsp), %rbx		/* pt_regs->rbx */
 	movq	RBP(%rsp), %rbp		/* pt_regs->rbp */
 	movq	EFLAGS(%rsp), %r11	/* pt_regs->flags (in r11) */
@@ -403,17 +390,9 @@ ENTRY(entry_INT80_compat)
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
 .Lsyscall_32_done:
 
-	/* Go back to user mode. */
-	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
 END(entry_INT80_compat)


