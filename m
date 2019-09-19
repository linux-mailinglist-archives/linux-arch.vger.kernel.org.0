Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1810BB7D9D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbfISPJ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:09:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50101 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403949AbfISPJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy47-0006pI-4k; Thu, 19 Sep 2019 17:09:51 +0200
Message-Id: <20190919150809.652455369@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:26 +0200
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
Subject: [RFC patch 12/15] arm64/entry: Use generic exit to usermode
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the exit to usermode code with the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/entry-common.h |   29 +++++++++++++++++++++
 arch/arm64/kernel/entry.S             |   18 ++-----------
 arch/arm64/kernel/signal.c            |   45 ----------------------------------
 3 files changed, 33 insertions(+), 59 deletions(-)

--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -5,6 +5,35 @@
 #ifndef __ASM_ENTRY_COMMON_H
 #define __ASM_ENTRY_COMMON_H
 
+#include <asm/daifflags.h>
+
+#define ARCH_EXIT_TO_USERMODE_WORK	(_TIF_FOREIGN_FPSTATE)
+
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+{
+	if (ti_work & _TIF_NEED_RESCHED)
+		local_daif_restore(DAIF_PROCCTX_NOIRQ);
+	else
+		local_daif_restore(DAIF_PROCCTX);
+}
+#define local_irq_enable_exit_to_user local_irq_enable_exit_to_user
+
+static inline void local_irq_disable_exit_to_user(void)
+{
+	local_daif_mask();
+}
+#define local_irq_disable_exit_to_user local_irq_disable_exit_to_user
+
+static inline void arch_exit_to_usermode_work(struct pt_regs *regs,
+					      unsigned long ti_work)
+{
+	/* Must this be inside the work loop ? */
+	if (ti_work & _TIF_FOREIGN_FPSTATE)
+		fpsimd_restore_current_state();
+
+}
+#define arch_exit_to_usermode_work arch_exit_to_usermode_work
+
 enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_ENTER = 0,
 	PTRACE_SYSCALL_EXIT,
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -971,26 +971,14 @@ ENDPROC(el1_error)
 ENDPROC(el0_error)
 
 /*
- * Ok, we need to do extra processing, enter the slow path.
- */
-work_pending:
-	mov	x0, sp				// 'regs'
-	bl	do_notify_resume
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on		// enabled while in userspace
-#endif
-	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
-	b	finish_ret_to_user
-/*
  * "slow" syscall return path.
  */
 ret_to_user:
 	disable_daif
 	gic_prio_kentry_setup tmp=x3
-	ldr	x1, [tsk, #TSK_TI_FLAGS]
-	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, work_pending
-finish_ret_to_user:
+	mov	x0, sp				// 'regs'
+	bl	exit_to_usermode
+	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	enable_step_tsk x1, x2
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -825,7 +825,7 @@ static void handle_signal(struct ksignal
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-static void do_signal(struct pt_regs *regs)
+void arch_do_signal(struct pt_regs *regs)
 {
 	unsigned long continue_addr = 0, restart_addr = 0;
 	int retval = 0;
@@ -896,49 +896,6 @@ static void do_signal(struct pt_regs *re
 	restore_saved_sigmask();
 }
 
-asmlinkage void do_notify_resume(struct pt_regs *regs,
-				 unsigned long thread_flags)
-{
-	/*
-	 * The assembly code enters us with IRQs off, but it hasn't
-	 * informed the tracing code of that for efficiency reasons.
-	 * Update the trace code with the current status.
-	 */
-	trace_hardirqs_off();
-
-	do {
-		/* Check valid user FS if needed */
-		addr_limit_user_check();
-
-		if (thread_flags & _TIF_NEED_RESCHED) {
-			/* Unmask Debug and SError for the next task */
-			local_daif_restore(DAIF_PROCCTX_NOIRQ);
-
-			schedule();
-		} else {
-			local_daif_restore(DAIF_PROCCTX);
-
-			if (thread_flags & _TIF_UPROBE)
-				uprobe_notify_resume(regs);
-
-			if (thread_flags & _TIF_SIGPENDING)
-				do_signal(regs);
-
-			if (thread_flags & _TIF_NOTIFY_RESUME) {
-				clear_thread_flag(TIF_NOTIFY_RESUME);
-				tracehook_notify_resume(regs);
-				rseq_handle_notify_resume(NULL, regs);
-			}
-
-			if (thread_flags & _TIF_FOREIGN_FPSTATE)
-				fpsimd_restore_current_state();
-		}
-
-		local_daif_mask();
-		thread_flags = READ_ONCE(current_thread_info()->flags);
-	} while (thread_flags & _TIF_WORK_MASK);
-}
-
 unsigned long __ro_after_init signal_minsigstksz;
 
 /*


