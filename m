Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7516EB3F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgBYQVZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 11:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYQVZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 11:21:25 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D0A2082F;
        Tue, 25 Feb 2020 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582647684;
        bh=VtQY2mCmUh7VCyLEDecUcNrtXfnW5VJRfcEoBJHt+JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns40aypklqKuUib1m+hVxyk4tzndPZn+0n2YHFsg/Mu/i6dixmRh51yNFslCwXZ7H
         lMfJapxdHIoPdvn51ZLCmVcjEXIc7zWO+4LnkmQtz/HJBYI1aoP3gqjq4HUdUwj2G1
         aSw2SlVYtE5XSpJtvskYH64IiSVFA8YBr+9q9AZk=
Date:   Tue, 25 Feb 2020 17:21:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200225162121.GA9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225154111.GM18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 25, 2020 at 04:41:11PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 04:09:06AM +0100, Frederic Weisbecker wrote:
> > On Mon, Feb 24, 2020 at 05:13:18PM +0100, Peter Zijlstra wrote:
> 
> > > +#define arch_nmi_enter()						\
> > > +do {									\
> > > +	struct nmi_ctx *___ctx;						\
> > > +	unsigned int ___cnt;						\
> > > +									\
> > > +	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> > > +		break;							\
> > > +									\
> > > +	___ctx = this_cpu_ptr(&nmi_contexts);				\
> > > +	___cnt = ___ctx->cnt;						\
> > > +	if (!(___cnt & 1) && __cnt) {					\
> > > +		___ctx->cnt += 2;					\
> > > +		break;							\
> > > +	}								\
> > > +									\
> > > +	___ctx->cnt |= 1;						\
> > > +	barrier();							\
> > > +	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
> > > +	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
> > > +		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
> > > +		isb();							\
> > > +	}								\
> > > +	barrier();							\
> > 
> > Suppose the first NMI is interrupted here. nmi_ctx->hcr has HCR_TGE unset.
> > The new NMI is going to overwrite nmi_ctx->hcr with HCR_TGE set. Then the
> > first NMI will not restore the correct value upon arch_nmi_exit().
> > 
> > So perhaps the below, but I bet I overlooked something obvious.
> 
> Well, none of this is obvious :/
> 
> The basic idea was that the LSB signifies 'pending/in-progress' and when
> that is set, nobody else touches no nothing. Enter will unconditionally
> (re) write_sysreg(), exit will nothing.
> 
> Obviously I messed that up.
> 
> How's this? 
> 
> #define arch_nmi_enter()						\
> do {									\
> 	struct nmi_ctx *___ctx;						\
> 	unsigned int ___cnt;						\
> 									\
> 	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> 		break;							\
> 									\
> 	___ctx = this_cpu_ptr(&nmi_contexts);				\
> 	___cnt = ___ctx->cnt;						\
> 	if (!(___cnt & 1)) { /* !IN-PROGRESS */				\
> 		if (___cnt) {						\
> 			___ctx->cnt += 2;				\
> 			break;						\
> 		}							\
> 									\
> 		___ctx->hcr = read_sysreg(hcr_el2);			\
> 		barrier();						\
> 		___ctx->cnt |= 1; /* IN-PROGRESS */			\
> 		barrier();						\
> 	}								\
> 									\
> 	if (!(___ctx->hcr & HCR_TGE)) {					\
> 		write_sysreg(___ctx->hcr | HCR_TGE, hcr_el2);		\
> 		isb();							\
> 	}								\
> 	barrier();							\
> 	if (!(___cnt & 1))						\
> 		___ctx->cnt++; /* COMPLETE */				\
> } while (0)
> 
> #define arch_nmi_exit()							\
> do {									\
> 	struct nmi_ctx *___ctx;						\
> 									\
> 	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> 		break;							\
> 									\
> 	___ctx = this_cpu_ptr(&nmi_contexts);				\
> 	if ((___ctx->cnt & 1) || (___ctx->cnt -= 2))			\
> 		break;							\

If you're interrupted here and __ctx->cnt == 0, the new NMI is in its right
to overwrite __ctx->hcr. It will find HCR_TGE set in the sysreg and write it back to
___ctx->hcr. So the following restore will fail.

\
> 	if (!(___ctx->hcr & HCR_TGE))					\
> 		write_sysreg(___ctx->hcr, hcr_el2);			\
> } while (0)
