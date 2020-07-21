Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E318F227E6F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgGULKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgGULIk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC3C061794;
        Tue, 21 Jul 2020 04:08:40 -0700 (PDT)
Message-Id: <20200721110808.671110583@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2ema8GOO9QedoLE6kTXXPFQCUYhcbcOy34hGc3/+UgQ=;
        b=KWGGIXe4+lIthBZ7N7mU/R9DyZjEts53BQQxFPIt24tTYv/Lj84aa+ZqUB2AWOG/7Nh+UR
        E3dBprzyZFJVL04r908lCLn2tg6uUouGcZB3ZRQVkB7HchwST25qPFQn+4+RvazwGVNiky
        Zuzo3wWV8sw5OLMTZflgv4zugOkUslQDB468IFW43AHY62XY2JKkTjiKH2E2HgTYNg2h7f
        fpvDEMtJgRDF6s81ZXGLuNF0LTbIOcHH1kplMpKv0dGHnKsEQ3Jf41/3xYTS8HIeBK1EHe
        ALVV+83+GRU74p6tSawBQqqRQrxBUnpwaqyVLRbu1O49m+svs3i7Iw64q4K50g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2ema8GOO9QedoLE6kTXXPFQCUYhcbcOy34hGc3/+UgQ=;
        b=NaT4PoUt6xrcmTF1pNbWmedVIHjCrQRCCCXlnvo/kfVy5PHBiNiXcENNKIm7zlhqUuYwAO
        iJ2WejPiTQ/BInAQ==
Date:   Tue, 21 Jul 2020 12:57:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 04/15] entry: Provide generic interrupt entry/exit code
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Like the syscall entry/exit code interrupt/exception entry after the real
low level ASM bits should not be different accross architectures.

Provide a generic version based on the x86 code.

irqentry_enter() is called after the low level entry code and
irqentry_exit() must be invoked right before returning to the low level
code which just contains the actual return logic. The code before
irqentry_enter() and irqentry_exit() must not be instrumented. Code after
irqentry_enter() and before irqentry_exit() can be instrumented.

irqentry_enter() invokes irqentry_enter_from_user_mode() if the
interrupt/exception came from user mode. If if entered from kernel mode it
handles the kernel mode variant of establishing state for lockdep, RCU and
tracing depending on the kernel context it interrupted (idle, non-idle).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/entry-common.h |   62 ++++++++++++++++++++++
 kernel/entry/common.c        |  117 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -307,4 +307,66 @@ void irqentry_enter_from_user_mode(struc
  */
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
+#ifndef irqentry_state
+typedef struct irqentry_state {
+	bool	exit_rcu;
+} irqentry_state_t;
+#endif
+
+/**
+ * irqentry_enter - Handle state tracking on ordinary interrupt entries
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
+ * invoked on entry and rcu_irq_exit() on exit.
+ *
+ * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking rcu_irq_enter() without undoing it.
+ *
+ * For user mode entries irqentry_enter_from_user_mode() is invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: An opaque object that must be passed to idtentry_exit()
+ */
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ *
+ * Conditional reschedule with additional sanity checks.
+ */
+void irqentry_exit_cond_resched(void);
+
+/**
+ * irqentry_exit - Handle return from exception that used irqentry_enter()
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @state:	Return value from matching call to irqentry_enter()
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to irqentry_enter().
+ */
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -255,3 +255,120 @@ noinstr void irqentry_exit_to_user_mode(
 	instrumentation_end();
 	exit_to_user_mode();
 }
+
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs)
+{
+	irqentry_state_t ret = {
+		.exit_rcu = false,
+	};
+
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+		return ret;
+	}
+
+	/*
+	 * If this entry hit the idle task invoke rcu_irq_enter() whether
+	 * RCU is watching or not.
+	 *
+	 * Interupts can nest when the first interrupt invokes softirq
+	 * processing on return which enables interrupts.
+	 *
+	 * Scheduler ticks in the idle task can mark quiescent state and
+	 * terminate a grace period, if and only if the timer interrupt is
+	 * not nested into another interrupt.
+	 *
+	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
+	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
+	 * assume that it is the first interupt and eventually claim
+	 * quiescient state and end grace periods prematurely.
+	 *
+	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
+	 * consistent.
+	 *
+	 * TINY_RCU does not support EQS, so let the compiler eliminate
+	 * this part when enabled.
+	 */
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+		/*
+		 * If RCU is not watching then the same careful
+		 * sequence vs. lockdep and tracing is required
+		 * as in irq_enter_from_user_mode().
+		 */
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_finish();
+		instrumentation_end();
+
+		ret.exit_rcu = true;
+		return ret;
+	}
+
+	/*
+	 * If RCU is watching then RCU only wants to check whether it needs
+	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
+	 * already contains a warning when RCU is not watching, so no point
+	 * in having another one here.
+	 */
+	instrumentation_begin();
+	rcu_irq_enter_check_tick();
+	/* Use the combo lockdep/tracing function */
+	trace_hardirqs_off();
+	instrumentation_end();
+
+	return ret;
+}
+
+void irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		/* Sanity check RCU and thread stack */
+		rcu_irq_exit_check_preempt();
+		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+			WARN_ON_ONCE(!on_thread_stack());
+		if (need_resched())
+			preempt_schedule_irq();
+	}
+}
+
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		irqentry_exit_to_user_mode(regs);
+	} else if (!regs_irqs_disabled(regs)) {
+		/*
+		 * If RCU was not watching on entry this needs to be done
+		 * carefully and needs the same ordering of lockdep/tracing
+		 * and RCU as the return to user mode path.
+		 */
+		if (state.exit_rcu) {
+			instrumentation_begin();
+			/* Tell the tracer that IRET will enable interrupts */
+			trace_hardirqs_on_prepare();
+			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			instrumentation_end();
+			rcu_irq_exit();
+			lockdep_hardirqs_on(CALLER_ADDR0);
+			return;
+		}
+
+		instrumentation_begin();
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			irqentry_exit_cond_resched();
+		/* Covers both tracing and lockdep */
+		trace_hardirqs_on();
+		instrumentation_end();
+	} else {
+		/*
+		 * IRQ flags state is correct already. Just tell RCU if it
+		 * was not watching on entry.
+		 */
+		if (state.exit_rcu)
+			rcu_irq_exit();
+	}
+}

