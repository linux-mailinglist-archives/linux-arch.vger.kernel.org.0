Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B148601F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfHHKjf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:47946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403899AbfHHKjQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC9A9B117;
        Thu,  8 Aug 2019 10:39:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 26/28] x86_32/asm: change all ENTRY+END to SYM_CODE_*
Date:   Thu,  8 Aug 2019 12:38:52 +0200
Message-Id: <20190808103854.6192-27-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Here, we change all assembly code which is marked using END (and not
ENDPROC). We switch all these to appropriate new markings SYM_CODE_START
and SYM_CODE_END.

And since we removed the last user of END on X86, make sure, that END is
not defined there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/entry_32.S   | 104 ++++++++++++++++++------------------
 arch/x86/kernel/ftrace_32.S |   8 +--
 include/linux/linkage.h     |   2 +
 3 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 64fe7aa50ad2..0ecc12fcfc05 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -709,7 +709,7 @@
  * %eax: prev task
  * %edx: next task
  */
-ENTRY(__switch_to_asm)
+SYM_CODE_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in struct inactive_task_frame
@@ -748,7 +748,7 @@ ENTRY(__switch_to_asm)
 	popl	%ebp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * The unwinder expects the last frame on the stack to always be at the same
@@ -774,7 +774,7 @@ ENDPROC(schedule_tail_wrapper)
  * ebx: kernel thread func (NULL for user thread)
  * edi: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	call	schedule_tail_wrapper
 
 	testl	%ebx, %ebx
@@ -797,7 +797,7 @@ ENTRY(ret_from_fork)
 	 */
 	movl	$0, PT_EAX(%esp)
 	jmp	2b
-END(ret_from_fork)
+SYM_CODE_END(ret_from_fork)
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -1161,7 +1161,7 @@ ENDPROC(entry_INT80_32)
  * We pack 1 stub into every 8-byte block.
  */
 	.align 8
-ENTRY(irq_entries_start)
+SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
@@ -1169,11 +1169,11 @@ ENTRY(irq_entries_start)
 	jmp	common_interrupt
 	.align	8
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	.align 8
-ENTRY(spurious_entries_start)
+SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
@@ -1181,7 +1181,7 @@ ENTRY(spurious_entries_start)
 	jmp	common_spurious
 	.align	8
     .endr
-END(spurious_entries_start)
+SYM_CODE_END(spurious_entries_start)
 
 SYM_CODE_START_LOCAL(common_spurious)
 	ASM_CLAC
@@ -1230,14 +1230,14 @@ ENDPROC(name)
 /* The include is where all of the SMP etc. interrupts come from */
 #include <asm/entry_arch.h>
 
-ENTRY(coprocessor_error)
+SYM_CODE_START(coprocessor_error)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_coprocessor_error
 	jmp	common_exception
-END(coprocessor_error)
+SYM_CODE_END(coprocessor_error)
 
-ENTRY(simd_coprocessor_error)
+SYM_CODE_START(simd_coprocessor_error)
 	ASM_CLAC
 	pushl	$0
 #ifdef CONFIG_X86_INVD_BUG
@@ -1249,96 +1249,96 @@ ENTRY(simd_coprocessor_error)
 	pushl	$do_simd_coprocessor_error
 #endif
 	jmp	common_exception
-END(simd_coprocessor_error)
+SYM_CODE_END(simd_coprocessor_error)
 
-ENTRY(device_not_available)
+SYM_CODE_START(device_not_available)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 	pushl	$do_device_not_available
 	jmp	common_exception
-END(device_not_available)
+SYM_CODE_END(device_not_available)
 
 #ifdef CONFIG_PARAVIRT
-ENTRY(native_iret)
+SYM_CODE_START(native_iret)
 	iret
 	_ASM_EXTABLE(native_iret, iret_exc)
-END(native_iret)
+SYM_CODE_END(native_iret)
 #endif
 
-ENTRY(overflow)
+SYM_CODE_START(overflow)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_overflow
 	jmp	common_exception
-END(overflow)
+SYM_CODE_END(overflow)
 
-ENTRY(bounds)
+SYM_CODE_START(bounds)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_bounds
 	jmp	common_exception
-END(bounds)
+SYM_CODE_END(bounds)
 
-ENTRY(invalid_op)
+SYM_CODE_START(invalid_op)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_invalid_op
 	jmp	common_exception
-END(invalid_op)
+SYM_CODE_END(invalid_op)
 
-ENTRY(coprocessor_segment_overrun)
+SYM_CODE_START(coprocessor_segment_overrun)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_coprocessor_segment_overrun
 	jmp	common_exception
-END(coprocessor_segment_overrun)
+SYM_CODE_END(coprocessor_segment_overrun)
 
-ENTRY(invalid_TSS)
+SYM_CODE_START(invalid_TSS)
 	ASM_CLAC
 	pushl	$do_invalid_TSS
 	jmp	common_exception
-END(invalid_TSS)
+SYM_CODE_END(invalid_TSS)
 
-ENTRY(segment_not_present)
+SYM_CODE_START(segment_not_present)
 	ASM_CLAC
 	pushl	$do_segment_not_present
 	jmp	common_exception
-END(segment_not_present)
+SYM_CODE_END(segment_not_present)
 
-ENTRY(stack_segment)
+SYM_CODE_START(stack_segment)
 	ASM_CLAC
 	pushl	$do_stack_segment
 	jmp	common_exception
-END(stack_segment)
+SYM_CODE_END(stack_segment)
 
-ENTRY(alignment_check)
+SYM_CODE_START(alignment_check)
 	ASM_CLAC
 	pushl	$do_alignment_check
 	jmp	common_exception
-END(alignment_check)
+SYM_CODE_END(alignment_check)
 
-ENTRY(divide_error)
+SYM_CODE_START(divide_error)
 	ASM_CLAC
 	pushl	$0				# no error code
 	pushl	$do_divide_error
 	jmp	common_exception
-END(divide_error)
+SYM_CODE_END(divide_error)
 
 #ifdef CONFIG_X86_MCE
-ENTRY(machine_check)
+SYM_CODE_START(machine_check)
 	ASM_CLAC
 	pushl	$0
 	pushl	machine_check_vector
 	jmp	common_exception
-END(machine_check)
+SYM_CODE_END(machine_check)
 #endif
 
-ENTRY(spurious_interrupt_bug)
+SYM_CODE_START(spurious_interrupt_bug)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_spurious_interrupt_bug
 	jmp	common_exception
-END(spurious_interrupt_bug)
+SYM_CODE_END(spurious_interrupt_bug)
 
 #ifdef CONFIG_XEN_PV
 ENTRY(xen_hypervisor_callback)
@@ -1442,11 +1442,11 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 #endif /* CONFIG_HYPERV */
 
-ENTRY(page_fault)
+SYM_CODE_START(page_fault)
 	ASM_CLAC
 	pushl	$do_page_fault
 	jmp	common_exception_read_cr2
-END(page_fault)
+SYM_CODE_END(page_fault)
 
 SYM_CODE_START_LOCAL_NOALIGN(common_exception_read_cr2)
 	/* the function address is in %gs's slot on the stack */
@@ -1495,7 +1495,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
-ENTRY(debug)
+SYM_CODE_START(debug)
 	/*
 	 * Entry from sysenter is now handled in common_exception
 	 */
@@ -1503,7 +1503,7 @@ ENTRY(debug)
 	pushl	$-1				# mark this as an int
 	pushl	$do_debug
 	jmp	common_exception
-END(debug)
+SYM_CODE_END(debug)
 
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
@@ -1512,7 +1512,7 @@ END(debug)
  * switched stacks.  We handle both conditions by simply checking whether we
  * interrupted kernel code running on the SYSENTER stack.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	ASM_CLAC
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1577,9 +1577,9 @@ ENTRY(nmi)
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-END(nmi)
+SYM_CODE_END(nmi)
 
-ENTRY(int3)
+SYM_CODE_START(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 
@@ -1590,22 +1590,22 @@ ENTRY(int3)
 	movl	%esp, %eax			# pt_regs pointer
 	call	do_int3
 	jmp	ret_from_exception
-END(int3)
+SYM_CODE_END(int3)
 
-ENTRY(general_protection)
+SYM_CODE_START(general_protection)
 	pushl	$do_general_protection
 	jmp	common_exception
-END(general_protection)
+SYM_CODE_END(general_protection)
 
 #ifdef CONFIG_KVM_GUEST
-ENTRY(async_page_fault)
+SYM_CODE_START(async_page_fault)
 	ASM_CLAC
 	pushl	$do_async_page_fault
 	jmp	common_exception_read_cr2
-END(async_page_fault)
+SYM_CODE_END(async_page_fault)
 #endif
 
-ENTRY(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
@@ -1614,4 +1614,4 @@ ENTRY(rewind_stack_do_exit)
 
 	call	do_exit
 1:	jmp 1b
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a43ed4c0402d..b4f495bbd5a1 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -25,7 +25,7 @@ SYM_FUNC_START(function_hook)
 	ret
 SYM_FUNC_END(function_hook)
 
-ENTRY(ftrace_caller)
+SYM_CODE_START(ftrace_caller)
 
 #ifdef CONFIG_FRAME_POINTER
 	/*
@@ -87,7 +87,7 @@ ftrace_graph_call:
 /* This is weak to keep gas from relaxing the jumps */
 WEAK(ftrace_stub)
 	ret
-END(ftrace_caller)
+SYM_CODE_END(ftrace_caller)
 
 SYM_CODE_START(ftrace_regs_caller)
 	/*
@@ -166,7 +166,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 SYM_CODE_END(ftrace_regs_caller)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ENTRY(ftrace_graph_caller)
+SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
 	pushl	%ecx
 	pushl	%edx
@@ -180,7 +180,7 @@ ENTRY(ftrace_graph_caller)
 	popl	%ecx
 	popl	%eax
 	ret
-END(ftrace_graph_caller)
+SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
 return_to_handler:
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 19f3d796ab5b..5ffcf72c8f87 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -129,11 +129,13 @@
 	SYM_FUNC_START_WEAK(name)
 #endif
 
+#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
 	.size name, .-name
 #endif
+#endif /* CONFIG_X86 */
 
 #ifndef CONFIG_X86_64
 /* If symbol 'name' is treated as a subroutine (gets called, and returns)
-- 
2.22.0

