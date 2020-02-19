Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17625164811
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBSPO0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QFHgOH6S3AfalQFNA2OtdJ+0cM9mrfqdqHGJCieOJmI=; b=uzDOXK0R63Q0+XXmw/54vt/IE8
        Ss6kiCjtFferUkZf032zsLjRmS7+4axQJ+89AkghX/sS2ktxifaZUgtuCMrRRD+jhythP+ux/piwI
        ZO3sBpEVtnEBPjlEGZ4XwploNriFjG1huOkAkYP280QEvRipjYFu10FbRP+kUNXaSPPhc0gjDYsYm
        4bT9qaNP1nJ/iFU5sn+0cOGvdB8VvqS1UqPQnYgJcDWMITOfKg56QcADfgG3eeNOFqSYY5PnS97az
        pLxdkF19KchlTOhvWVDktOMsoXoPDJI7hphWABFOOz8N5nhWPLVXGybxPzRDtPRNkNHJEn3Ep585+
        6ORFarxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3A-000119-2K; Wed, 19 Feb 2020 15:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29A383062BA;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A15B20D96A35; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.428764577@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since there are already a number of sites (ARM64, PowerPC) that
effectively nest nmi_enter(), lets make the primitive support this
before adding even more.

Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/hardirq.h |    4 ++--
 arch/arm64/kernel/sdei.c         |   14 ++------------
 arch/arm64/kernel/traps.c        |    8 ++------
 arch/powerpc/kernel/traps.c      |   19 +++++--------------
 include/linux/hardirq.h          |    2 +-
 include/linux/preempt.h          |    4 ++--
 kernel/printk/printk_safe.c      |    6 ++++--
 7 files changed, 18 insertions(+), 39 deletions(-)

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
 
@@ -863,8 +855,7 @@ void machine_check_exception(struct pt_r
 	return;
 
 bail:
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -71,7 +71,7 @@ extern void irq_exit(void);
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


