Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA8167F2E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgBUNus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45628 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgBUNup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jDaR/sKDJuYfY8Xh5108sRoLM3p41nTkFKZzP2X8LE8=; b=CNpdpjiKFPnLgH/8g5CorgVCTu
        hBwuYmKNteIyb0o/cWUrHf2Ft81UALZNdiiHIjInewab1+QTS2je2MIdsX+WI8aGP4oBKGR0reUpf
        jY3Mpsd/sY1dUsRDNTFG3Tc69qBmJZ6poXAPjzm0YN+DQj3CrVOjVTWKWcfI01iyMVKckkRxWhLZY
        Uw76cElzM5FV28vZ/eilR2SMNbIMt46v85W4i31qbAjmvu9RIcXEuqYm+gwHLlQnFZXFl7OnQuB4i
        PVfCJMMrdaARiMeEE5l058mApaBnUV/zbOMLdo9ykZHv0mxsqB3Fmrd79KZe75ujuobibaxSjX7WT
        y57zUlag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gu-0006Uv-GL; Fri, 21 Feb 2020 13:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A03306151;
        Fri, 21 Feb 2020 14:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A946029B59038; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.149193474@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since there are already a number of sites (ARM64, PowerPC) that
effectively nest nmi_enter(), lets make the primitive support this
before adding even more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/hardirq.h |    4 ++--
 arch/arm64/kernel/sdei.c         |   14 ++------------
 arch/arm64/kernel/traps.c        |    8 ++------
 arch/powerpc/kernel/traps.c      |   22 ++++++----------------
 include/linux/hardirq.h          |    5 ++++-
 include/linux/preempt.h          |    4 ++--
 kernel/printk/printk_safe.c      |    6 ++++--
 7 files changed, 22 insertions(+), 41 deletions(-)

--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -38,7 +38,7 @@ DECLARE_PER_CPU(struct nmi_ctx, nmi_cont
 
 #define arch_nmi_enter()							\
 	do {									\
-		if (is_kernel_in_hyp_mode()) {					\
+		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
 			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
 			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
 			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
@@ -50,7 +50,7 @@ DECLARE_PER_CPU(struct nmi_ctx, nmi_cont
 
 #define arch_nmi_exit()								\
 	do {									\
-		if (is_kernel_in_hyp_mode()) {					\
+		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
 			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
 			if (!(nmi_ctx->hcr & HCR_TGE))				\
 				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -251,22 +251,12 @@ asmlinkage __kprobes notrace unsigned lo
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
 	unsigned long ret;
-	bool do_nmi_exit = false;
 
-	/*
-	 * nmi_enter() deals with printk() re-entrance and use of RCU when
-	 * RCU believed this CPU was idle. Because critical events can
-	 * interrupt normal events, we may already be in_nmi().
-	 */
-	if (!in_nmi()) {
-		nmi_enter();
-		do_nmi_exit = true;
-	}
+	nmi_enter();
 
 	ret = _sdei_handler(regs, arg);
 
-	if (do_nmi_exit)
-		nmi_exit();
+	nmi_exit();
 
 	return ret;
 }
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -906,17 +906,13 @@ bool arm64_is_fatal_ras_serror(struct pt
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	const bool was_in_nmi = in_nmi();
-
-	if (!was_in_nmi)
-		nmi_enter();
+	nmi_enter();
 
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
-	if (!was_in_nmi)
-		nmi_exit();
+	nmi_exit();
 }
 
 asmlinkage void enter_from_user_mode(void)
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -441,15 +441,9 @@ void hv_nmi_check_nonrecoverable(struct
 void system_reset_exception(struct pt_regs *regs)
 {
 	unsigned long hsrr0, hsrr1;
-	bool nested = in_nmi();
 	bool saved_hsrrs = false;
 
-	/*
-	 * Avoid crashes in case of nested NMI exceptions. Recoverability
-	 * is determined by RI and in_nmi
-	 */
-	if (!nested)
-		nmi_enter();
+	nmi_enter();
 
 	/*
 	 * System reset can interrupt code where HSRRs are live and MSR[RI]=1.
@@ -521,8 +515,7 @@ void system_reset_exception(struct pt_re
 		mtspr(SPRN_HSRR1, hsrr1);
 	}
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
@@ -823,9 +816,8 @@ int machine_check_generic(struct pt_regs
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+
+	nmi_enter();
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
@@ -851,8 +843,7 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		goto bail;
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	die("Machine check", regs, SIGBUS);
 
@@ -863,8 +854,7 @@ void machine_check_exception(struct pt_r
 	return;
 
 bail:
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -65,13 +65,16 @@ extern void irq_exit(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+/*
+ * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ */
 #define nmi_enter()						\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
-		BUG_ON(in_nmi());				\
+		BUG_ON(in_nmi() == NMI_MASK);			\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -26,13 +26,13 @@
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00100000
+ *             NMI_MASK:	0x00f00000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	4
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(co
 
 void notrace printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	if (!in_nmi())
+		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
 }
 
 void notrace printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	if (!in_nmi())
+		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
 }
 
 /*


