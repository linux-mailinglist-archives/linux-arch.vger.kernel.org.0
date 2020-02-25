Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFABB16B7ED
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 04:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgBYDJK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 22:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgBYDJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 22:09:09 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6685722525;
        Tue, 25 Feb 2020 03:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582600148;
        bh=2ugqGAfgR7XY1wEzho4bIPRcCNr3Gcnq7CFvoR6LJAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyOo4CvMazKWjax1ssMAtII/j0lZ9iWkyM1/JwJuHO/j2Ve03aV3zvOjEeZ4ZqQU6
         u5DHEmpaOeeQgV+ZzLBDPu6IFkHzct7XGGmBjRfxbZ3MlqcpVUkYw9V2i58qU+6l8V
         pk4RNyy4j2CHgR6TZ5eLz6ifnlXUsAnpT3lIFq/A=
Date:   Tue, 25 Feb 2020 04:09:06 +0100
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
Message-ID: <20200225030905.GB28329@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224161318.GG14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 05:13:18PM +0100, Peter Zijlstra wrote:
> Damn, true. That also means I need to fix the arm64 bits, and that's a
> little more tricky.
> 
> Something like so perhaps.. hmm?
> 
> ---
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -32,30 +32,52 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
>  
>  struct nmi_ctx {
>  	u64 hcr;
> +	unsigned int cnt;
>  };
>  
>  DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
>  
> -#define arch_nmi_enter()							\
> -	do {									\
> -		if (is_kernel_in_hyp_mode() && !in_nmi()) {			\
> -			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
> -			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
> -			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
> -				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
> -				isb();						\
> -			}							\
> -		}								\
> -	} while (0)
> +#define arch_nmi_enter()						\
> +do {									\
> +	struct nmi_ctx *___ctx;						\
> +	unsigned int ___cnt;						\
> +									\
> +	if (!is_kernel_in_hyp_mode() || in_nmi())			\
> +		break;							\
> +									\
> +	___ctx = this_cpu_ptr(&nmi_contexts);				\
> +	___cnt = ___ctx->cnt;						\
> +	if (!(___cnt & 1) && __cnt) {					\
> +		___ctx->cnt += 2;					\
> +		break;							\
> +	}								\
> +									\
> +	___ctx->cnt |= 1;						\
> +	barrier();							\
> +	nmi_ctx->hcr = read_sysreg(hcr_el2);				\
> +	if (!(nmi_ctx->hcr & HCR_TGE)) {				\
> +		write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);		\
> +		isb();							\
> +	}								\
> +	barrier();							\

Suppose the first NMI is interrupted here. nmi_ctx->hcr has HCR_TGE unset.
The new NMI is going to overwrite nmi_ctx->hcr with HCR_TGE set. Then the
first NMI will not restore the correct value upon arch_nmi_exit().

So perhaps the below, but I bet I overlooked something obvious.

#define arch_nmi_enter()                                             \
do {                                                                 \
     struct nmi_ctx *___ctx;                                         \
     u64 ___hcr;                                                     \
                                                                     \
     if (!is_kernel_in_hyp_mode())                                   \
             break;                                                  \
                                                                     \
     ___ctx = this_cpu_ptr(&nmi_contexts);                           \
     if (___ctx->cnt) {                                              \
             ___ctx->cnt++;                                          \
             break;                                                  \
     }                                                               \
                                                                     \
     ___hcr = read_sysreg(hcr_el2);                                  \
     if (!(___hcr & HCR_TGE)) {                                      \
             write_sysreg(___hcr | HCR_TGE, hcr_el2);                \
             isb();                                                  \
     }                                                               \
     ___ctx->cnt = 1;                                                \
     barrier();                                                      \
     ___ctx->hcr = ___hcr;                                           \
} while (0)

#define arch_nmi_exit()                                         \
do {                                                            \
        struct nmi_ctx *___ctx;                                 \
        u64 ___hcr;                                             \
                                                                \
        if (!is_kernel_in_hyp_mode())                           \
            break;                                              \
                                                                \
        ___ctx = this_cpu_ptr(&nmi_contexts);                   \
	___hcr = nmi_ctx->hcr;                                  \
        barrier();                                              \
        --___ctx->cnt;                                          \
	barrier();                                              \
	if (!___ctx->cnt && !(___hcr & HCR_TGE))                  \
            write_sysreg(___hcr, hcr_el2);                       \
} while (0)

