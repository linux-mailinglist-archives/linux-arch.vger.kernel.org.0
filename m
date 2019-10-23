Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0593EE1A3F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfJWMbl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389776AbfJWMbl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFnd-00017N-B9; Wed, 23 Oct 2019 14:31:37 +0200
Message-Id: <20191023123118.191230255@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 06/17] x86/entry/32: Remove redundant interrupt disable
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the trap handlers return with interrupts disabled, the
unconditional disabling of interrupts in the low level entry code can be
removed along with the trace calls and the misnomed preempt_stop macro.
As a consequence ret_from_exception and ret_from_intr collapse.

Add a debug check to verify that interrupts are disabled depending on
CONFIG_DEBUG_ENTRY.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -63,12 +63,6 @@
  * enough to patch inline, increasing performance.
  */
 
-#ifdef CONFIG_PREEMPTION
-# define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
-#else
-# define preempt_stop(clobbers)
-#endif
-
 .macro TRACE_IRQS_IRET
 #ifdef CONFIG_TRACE_IRQFLAGS
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)     # interrupts off?
@@ -809,8 +803,7 @@ END(ret_from_fork)
 	# userspace resumption stub bypassing syscall exit tracing
 	ALIGN
 ret_from_exception:
-	preempt_stop(CLBR_ANY)
-ret_from_intr:
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb	PT_CS(%esp), %al
@@ -825,8 +818,6 @@ END(ret_from_fork)
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
 
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
 	jmp	restore_all
@@ -1084,7 +1075,7 @@ ENTRY(entry_INT80_32)
 
 restore_all_kernel:
 #ifdef CONFIG_PREEMPTION
-	DISABLE_INTERRUPTS(CLBR_ANY)
+	/* Interrupts are disabled and debug-checked */
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	.Lno_preempt
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
@@ -1189,7 +1180,7 @@ END(spurious_entries_start)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
-	jmp	ret_from_intr
+	jmp	ret_from_exception
 ENDPROC(common_spurious)
 #endif
 
@@ -1207,7 +1198,7 @@ ENDPROC(common_spurious)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	do_IRQ
-	jmp	ret_from_intr
+	jmp	ret_from_exception
 ENDPROC(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)			\
@@ -1219,7 +1210,7 @@ ENTRY(name)						\
 	TRACE_IRQS_OFF					\
 	movl	%esp, %eax;				\
 	call	fn;					\
-	jmp	ret_from_intr;				\
+	jmp	ret_from_exception;				\
 ENDPROC(name)
 
 #define BUILD_INTERRUPT(name, nr)		\
@@ -1366,7 +1357,7 @@ ENTRY(xen_do_upcall)
 #ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
 #endif
-	jmp	ret_from_intr
+	jmp	ret_from_exception
 ENDPROC(xen_hypervisor_callback)
 
 /*


