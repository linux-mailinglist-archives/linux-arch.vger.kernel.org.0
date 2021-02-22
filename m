Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B126321B41
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBVPVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhBVPTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Feb 2021 10:19:14 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A854C061786;
        Mon, 22 Feb 2021 07:18:30 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q8so6147074qvx.11;
        Mon, 22 Feb 2021 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4EJ0/4j1CzdgzvXDHv2DPblNta/CmD3j5e8XxFsSk4w=;
        b=cYSGZHgBzK2QU3KVvyZHXZP7WB82KLEvLy0xoP0+sGX0jk4BC7/nVfGNCn36t8Y84q
         kGYEqIFVVuwGHrkoYJKLOFGI+R3SD0k2RtI0Ouug3abayu8nnD242aVeQZFT9fyrnVL4
         sI2Ysz/lbqT26B0N76wI3OoCfEwLCaq9EMEOJ9zEminZyFJmSxStyotdl5B6DdJP07q3
         wIOq0P/mzNyDc8qkle9TRWUz/uUhZHqSuymVsQX7d03s/QyRJjV5P9xdHM+UnsoVnKv2
         N76zYkH36fQ7e23Q1uFelCi6oRJj1t5U1cT9yTTMiF24YhmFfn41CYNU0RBb5+0nhYoi
         VQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4EJ0/4j1CzdgzvXDHv2DPblNta/CmD3j5e8XxFsSk4w=;
        b=Kfag/6DvGyPRwh43Ink4U1+6//PBq+uRBtCk3toLOYlYo2mbLhZyicZvgoDJaqODEP
         r6S0k7NGuTxBundylFXzdhZ8cmAfUtLKL5G6G+S+cW59jWYbHOxahKyLbo4rJ97JPLhU
         FexKkR2xuzUcMm56sIQH9xjO6N3QsaNwG6emyWqAnQjG7ErQwq+qLY2SGovkXlxSbCCJ
         f2dGDV3Y/Wo50RW9hh7CYzC0Ou3s8yVXagAiDWn4zBg4EIBpdBsUGS74aRs3mnzb/F8e
         JwBohZvKRUu69PuBbxmwJpGk1DSXiEW5IHtS3psWnLcnH6u5rkc+UmMvGYCF0Wp+zwzO
         RiHQ==
X-Gm-Message-State: AOAM530Bq0cShbkDb1Me+OFwwbz0u9KNx0aPFy2ll3nn1RbLBFz55TDa
        Z7R8ghq81cpUOc/iq90iQZo=
X-Google-Smtp-Source: ABdhPJwQUaMvorV/rbNg1h7/jQUZRc5+Neh2y9JEETaw/cfCRdGpk4UJTjhoJ8NC7wk8zMfFCKz6Jw==
X-Received: by 2002:a0c:ea87:: with SMTP id d7mr10789742qvp.27.1614007109406;
        Mon, 22 Feb 2021 07:18:29 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t16sm1847514qto.58.2021.02.22.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:18:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC9F127C0054;
        Mon, 22 Feb 2021 10:18:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Feb 2021 10:18:27 -0500
X-ME-Sender: <xms:QMszYBnHag5WcKzBCKYGW9t1zIy_c-OnjvO71mKYcu31Rscz5ndeGA>
    <xme:QMszYM1XWZNpZ7rd2cMRM0-M2cf5GAU2U8JEyTVnBq05_hjoXVhz8nDgMqQQ-31rC
    27QDWXQah4Wv2e3tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:QMszYHroSLAeqWA4nlcXGxCZrf58U3DMySWpY7Is7pOlFLgbyEeXJQ>
    <xmx:QMszYBkERPGWGuk1Ik00HzshNuvo2l7L4j_q4pEqXR_Polq_ZRbw5g>
    <xmx:QMszYP3484Z2FE8RHH-PB0VOoeJsnKswALY_x3wLTooPsF7YOMwz8Q>
    <xmx:QcszYNPFgj5DoPcv-2NSzyxgvkXVz_iLoWJh-i1odoj9n9Vul3PFpBb3VAw>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7D57724005C;
        Mon, 22 Feb 2021 10:18:24 -0500 (EST)
Date:   Mon, 22 Feb 2021 23:17:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Message-ID: <YDPLH8zkczusJ66B@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:43PM -0800, Michael Kelley wrote:
> While the Hyper-V Reference TSC code is architecture neutral, the
> pv_ops.time.sched_clock() function is implemented for x86/x64, but not
> for ARM64. Current code calls a utility function under arch/x86 (and
> coming, under arch/arm64) to handle the difference.
> 
> Change this approach to handle the difference inline based on whether
> GENERIC_SCHED_CLOCK is present.  The new approach removes code under
> arch/* since the difference is tied more to the specifics of the Linux
> implementation than to the architecture.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/mshyperv.h    | 11 -----------
>  drivers/clocksource/hyperv_timer.c | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ed9dc56..5ccbba8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -29,17 +29,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  
>  #define hv_get_raw_timer() rdtsc_ordered()
>  
> -/*
> - * Reference to pv_ops must be inline so objtool
> - * detection of noinstr violations can work correctly.
> - */
> -static __always_inline void hv_setup_sched_clock(void *sched_clock)
> -{
> -#ifdef CONFIG_PARAVIRT
> -	pv_ops.time.sched_clock = sched_clock;
> -#endif
> -}
> -
>  void hyperv_vector_handler(struct pt_regs *regs);
>  
>  static inline void hv_enable_stimer0_percpu_irq(int irq) {}
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 9cee6db..a2bee50 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -423,6 +423,27 @@ static u64 notrace read_hv_sched_clock_msr(void)
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +/*
> + * Reference to pv_ops must be inline so objtool
> + * detection of noinstr violations can work correctly.
> + */
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> +	/*
> +	 * We're on an architecture with generic sched clock (not x86/x64).
> +	 * The Hyper-V sched clock read function returns nanoseconds, not
> +	 * the normal 100ns units of the Hyper-V synthetic clock.
> +	 */
> +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
> +#else
> +#ifdef CONFIG_PARAVIRT
> +	/* We're on x86/x64 *and* using PV ops */
> +	pv_ops.time.sched_clock = sched_clock;
> +#endif
> +#endif
> +}
> +
>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	u64		tsc_msr;
> -- 
> 1.8.3.1
> 
