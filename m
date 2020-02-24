Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43B016AB17
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBXQNv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 11:13:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgBXQNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 11:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NO21zwFdqpu/weoM9tn/iJhZEF/u/8RdieTUDh+pJxo=; b=Pm/f1X/m6b8y5upqQPbSQMJWE1
        PH5lKwn+gLwpf7qDd+/YsKWxLUBHtzqU0NDw7ut9NV+4G/oc+WLV7d0kpFLlTkKcs+BgU/yizDbG+
        z4avraDnM/9k8G4eAmF9rSHSfntNK6Tc9l/FR17NUepU0ou5AjsPii3BMWPDE77rYYSRMk2Pb+RPr
        kaJuWRrgnNgqTf7M/hGoHdoTx3PGx7aSBkntAneF6Qik9bs9oF6NQYFrC6DItYlmW6Z5scrvvlfI+
        DoFyWvns4YCGl2daOlK4BJNguiQH5iV+rRqYUiDQmUTvI81bh3BndSrMW5F3Wdfw2pxZL/jPpNskM
        rQJtGR+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6GME-0002cN-3Q; Mon, 24 Feb 2020 16:13:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 611A930605A;
        Mon, 24 Feb 2020 17:11:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA8522B9A66D8; Mon, 24 Feb 2020 17:13:18 +0100 (CET)
Date:   Mon, 24 Feb 2020 17:13:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200224161318.GG14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221222129.GB28251@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 11:21:30PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 21, 2020 at 02:34:18PM +0100, Peter Zijlstra wrote:
> > Since there are already a number of sites (ARM64, PowerPC) that
> > effectively nest nmi_enter(), lets make the primitive support this
> > before adding even more.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/hardirq.h |    4 ++--
> >  arch/arm64/kernel/sdei.c         |   14 ++------------
> >  arch/arm64/kernel/traps.c        |    8 ++------
> >  arch/powerpc/kernel/traps.c      |   22 ++++++----------------
> >  include/linux/hardirq.h          |    5 ++++-
> >  include/linux/preempt.h          |    4 ++--
> >  kernel/printk/printk_safe.c      |    6 ++++--
> >  7 files changed, 22 insertions(+), 41 deletions(-)
> > 
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(co
> >  
> >  void notrace printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> >  }
> >  
> >  void notrace printk_nmi_exit(void)
> >  {
> > -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> >  }
> 
> If the outermost NMI is interrupted while between printk_nmi_enter()
> and preempt_count_add(), there is still a risk that we race and clear?

Damn, true. That also means I need to fix the arm64 bits, and that's a
little more tricky.

Something like so perhaps.. hmm?

---
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -32,30 +32,52 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
 
 struct nmi_ctx {
 	u64 hcr;
+	unsigned int cnt;
 };
 
 DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
-#define arch_nmi_enter()							\
-	do {									\
-		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
-			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
-				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
-				isb();						\
-			}							\
-		}								\
-	} while (0)
+#define arch_nmi_enter()						\
+do {									\
+	struct nmi_ctx *___ctx;						\
+	unsigned int ___cnt;						\
+									\
+	if (!is_kernel_in_hyp_mode() || in_nmi())			\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	___cnt = ___ctx->cnt;						\
+	if (!(___cnt & 1) && __cnt) {					\
+		___ctx->cnt += 2;					\
+		break;							\
+	}								\
+									\
+	___ctx->cnt |= 1;						\
+	barrier();							\
+	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
+	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
+		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
+		isb();							\
+	}								\
+	barrier();							\
+	if (!(___cnt & 1))						\
+		___ctx->cnt++;						\
+} while (0)
 
-#define arch_nmi_exit()								\
-	do {									\
-		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			if (!(nmi_ctx->hcr & HCR_TGE))				\
-				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
-		}								\
-	} while (0)
+#define arch_nmi_exit()							\
+do {									\
+	struct nmi_ctx *___ctx;						\
+									\
+	if (!is_kernel_in_hyp_mode() || in_nmi())			\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	if ((___ctx->cnt & 1) || (___ctx->cnt -= 2))			\
+		break;							\
+									\
+	if (!(nmi_ctx->hcr & HCR_TGE))					\
+		write_sysreg(nmi_ctx->hcr, hcr_el2);			\
+} while (0)
 
 static inline void ack_bad_irq(unsigned int irq)
 {
