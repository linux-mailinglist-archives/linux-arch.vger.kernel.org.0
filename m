Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7ACD3EDD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJKLv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728102AbfJKLv2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A16F1B498;
        Fri, 11 Oct 2019 11:51:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v9 23/28] x86_64/asm: Change all ENTRY+END to SYM_CODE_*
Date:   Fri, 11 Oct 2019 13:51:03 +0200
Message-Id: <20191011115108.12392-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Here, all assembly code which is marked using END (and not ENDPROC) is
changed. All these are switched to appropriate new markings
SYM_CODE_START and SYM_CODE_END.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/entry/entry_64.S        | 52 ++++++++++++++++----------------
 arch/x86/entry/entry_64_compat.S |  8 ++---
 arch/x86/kernel/ftrace_64.S      |  4 +--
 arch/x86/kernel/head_64.S        | 12 ++++----
 arch/x86/xen/xen-asm_64.S        |  8 ++---
 arch/x86/xen/xen-head.S          |  8 ++---
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1568da63bf16..13e4fe378e5a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,11 +46,11 @@
 .section .entry.text, "ax"
 
 #ifdef CONFIG_PARAVIRT
-ENTRY(native_usergs_sysret64)
+SYM_CODE_START(native_usergs_sysret64)
 	UNWIND_HINT_EMPTY
 	swapgs
 	sysretq
-END(native_usergs_sysret64)
+SYM_CODE_END(native_usergs_sysret64)
 #endif /* CONFIG_PARAVIRT */
 
 .macro TRACE_IRQS_FLAGS flags:req
@@ -142,7 +142,7 @@ END(native_usergs_sysret64)
  * with them due to bugs in both AMD and Intel CPUs.
  */
 
-ENTRY(entry_SYSCALL_64)
+SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * Interrupts are off on entry.
@@ -273,13 +273,13 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 	USERGS_SYSRET64
-END(entry_SYSCALL_64)
+SYM_CODE_END(entry_SYSCALL_64)
 
 /*
  * %rdi: prev task
  * %rsi: next task
  */
-ENTRY(__switch_to_asm)
+SYM_CODE_START(__switch_to_asm)
 	UNWIND_HINT_FUNC
 	/*
 	 * Save callee-saved registers
@@ -321,7 +321,7 @@ ENTRY(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -330,7 +330,7 @@ END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
@@ -357,14 +357,14 @@ ENTRY(ret_from_fork)
 	 */
 	movq	$0, RAX(%rsp)
 	jmp	2b
-END(ret_from_fork)
+SYM_CODE_END(ret_from_fork)
 
 /*
  * Build the entry stubs with some assembler magic.
  * We pack 1 stub into every 8-byte block.
  */
 	.align 8
-ENTRY(irq_entries_start)
+SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
@@ -373,10 +373,10 @@ ENTRY(irq_entries_start)
 	.align	8
 	vector=vector+1
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 	.align 8
-ENTRY(spurious_entries_start)
+SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
@@ -385,7 +385,7 @@ ENTRY(spurious_entries_start)
 	.align	8
 	vector=vector+1
     .endr
-END(spurious_entries_start)
+SYM_CODE_END(spurious_entries_start)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
@@ -511,7 +511,7 @@ END(spurious_entries_start)
  * | return address					|
  * +----------------------------------------------------+
  */
-ENTRY(interrupt_entry)
+SYM_CODE_START(interrupt_entry)
 	UNWIND_HINT_FUNC
 	ASM_CLAC
 	cld
@@ -579,7 +579,7 @@ ENTRY(interrupt_entry)
 	TRACE_IRQS_OFF
 
 	ret
-END(interrupt_entry)
+SYM_CODE_END(interrupt_entry)
 _ASM_NOKPROBE(interrupt_entry)
 
 
@@ -795,7 +795,7 @@ _ASM_NOKPROBE(common_interrupt)
  * APIC interrupts.
  */
 .macro apicinterrupt3 num sym do_sym
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	pushq	$~(\num)
 .Lcommon_\sym:
@@ -803,7 +803,7 @@ ENTRY(\sym)
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
-END(\sym)
+SYM_CODE_END(\sym)
 _ASM_NOKPROBE(\sym)
 .endm
 
@@ -968,7 +968,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
@@ -1018,7 +1018,7 @@ ENTRY(\sym)
 	.endif
 
 _ASM_NOKPROBE(\sym)
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 idtentry divide_error			do_divide_error			has_error_code=0
@@ -1135,7 +1135,7 @@ SYM_CODE_END(xen_do_hypervisor_callback)
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-ENTRY(xen_failsafe_callback)
+SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
@@ -1165,7 +1165,7 @@ ENTRY(xen_failsafe_callback)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
-END(xen_failsafe_callback)
+SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 #ifdef CONFIG_XEN_PVHVM
@@ -1384,7 +1384,7 @@ SYM_CODE_END(error_exit)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1719,21 +1719,21 @@ nmi_restore:
 	 * about espfix64 on the way back to kernel mode.
 	 */
 	iretq
-END(nmi)
+SYM_CODE_END(nmi)
 
 #ifndef CONFIG_IA32_EMULATION
 /*
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
  */
-ENTRY(ignore_sysret)
+SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
-END(ignore_sysret)
+SYM_CODE_END(ignore_sysret)
 #endif
 
-ENTRY(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1743,4 +1743,4 @@ ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
 	call	do_exit
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 5c7e71669239..da296435676e 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -196,7 +196,7 @@ ENDPROC(entry_SYSENTER_compat)
  * esp  user stack
  * 0(%esp) arg6
  */
-ENTRY(entry_SYSCALL_compat)
+SYM_CODE_START(entry_SYSCALL_compat)
 	/* Interrupts are off on entry. */
 	swapgs
 
@@ -311,7 +311,7 @@ sysret32_from_system_call:
 	xorl	%r10d, %r10d
 	swapgs
 	sysretl
-END(entry_SYSCALL_compat)
+SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
  * 32-bit legacy system call entry.
@@ -339,7 +339,7 @@ END(entry_SYSCALL_compat)
  * edi  arg5
  * ebp  arg6
  */
-ENTRY(entry_INT80_compat)
+SYM_CODE_START(entry_INT80_compat)
 	/*
 	 * Interrupts are off on entry.
 	 */
@@ -416,4 +416,4 @@ ENTRY(entry_INT80_compat)
 	/* Go back to user mode. */
 	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
-END(entry_INT80_compat)
+SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 3afaaf555637..60f894b018e0 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -296,7 +296,7 @@ ENTRY(ftrace_graph_caller)
 	retq
 ENDPROC(ftrace_graph_caller)
 
-ENTRY(return_to_handler)
+SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_EMPTY
 	subq  $24, %rsp
 
@@ -312,5 +312,5 @@ ENTRY(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	JMP_NOSPEC %rdi
-END(return_to_handler)
+SYM_CODE_END(return_to_handler)
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 10f306e31244..4bbc770af632 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -91,7 +91,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	jmp 1f
 SYM_CODE_END(startup_64)
 
-ENTRY(secondary_startup_64)
+SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
@@ -241,7 +241,7 @@ ENTRY(secondary_startup_64)
 	pushq	%rax		# target address in negative space
 	lretq
 .Lafter_lret:
-END(secondary_startup_64)
+SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
 
@@ -251,11 +251,11 @@ END(secondary_startup_64)
  * up already except stack. We just set up stack here. Then call
  * start_secondary() via .Ljump_to_C_code.
  */
-ENTRY(start_cpu0)
+SYM_CODE_START(start_cpu0)
 	UNWIND_HINT_EMPTY
 	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
-END(start_cpu0)
+SYM_CODE_END(start_cpu0)
 #endif
 
 	/* Both SMP bootup and ACPI suspend change these variables */
@@ -272,7 +272,7 @@ SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
 	__FINITDATA
 
 	__INIT
-ENTRY(early_idt_handler_array)
+SYM_CODE_START(early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
@@ -288,7 +288,7 @@ ENTRY(early_idt_handler_array)
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
 	UNWIND_HINT_IRET_REGS offset=16
-END(early_idt_handler_array)
+SYM_CODE_END(early_idt_handler_array)
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index c209c70fc5e4..0060120f51dd 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -20,11 +20,11 @@
 #include <linux/linkage.h>
 
 .macro xen_pv_trap name
-ENTRY(xen_\name)
+SYM_CODE_START(xen_\name)
 	pop %rcx
 	pop %r11
 	jmp  \name
-END(xen_\name)
+SYM_CODE_END(xen_\name)
 _ASM_NOKPROBE(xen_\name)
 .endm
 
@@ -57,7 +57,7 @@ xen_pv_trap entry_INT80_compat
 xen_pv_trap hypervisor_callback
 
 	__INIT
-ENTRY(xen_early_idt_handler_array)
+SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	pop %rcx
@@ -66,7 +66,7 @@ ENTRY(xen_early_idt_handler_array)
 	i = i + 1
 	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-END(xen_early_idt_handler_array)
+SYM_CODE_END(xen_early_idt_handler_array)
 	__FINIT
 
 hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index c1d8b90aa4e2..1d0cee3163e4 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_XEN_PV
 	__INIT
-ENTRY(startup_xen)
+SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
 	cld
 
@@ -52,13 +52,13 @@ ENTRY(startup_xen)
 #endif
 
 	jmp xen_start_kernel
-END(startup_xen)
+SYM_CODE_END(startup_xen)
 	__FINIT
 #endif
 
 .pushsection .text
 	.balign PAGE_SIZE
-ENTRY(hypercall_page)
+SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_EMPTY
 		.skip 32
@@ -69,7 +69,7 @@ ENTRY(hypercall_page)
 	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
-END(hypercall_page)
+SYM_CODE_END(hypercall_page)
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
-- 
2.23.0

