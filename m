Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2332B4E2
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450156AbhCCFas (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360119AbhCBWQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 17:16:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F8C06178A
        for <linux-arch@vger.kernel.org>; Tue,  2 Mar 2021 14:16:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so4257024wmq.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Mar 2021 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0KoC52/OhyByIZz76tXoXDzs+xfPJOsQW1wOukb2Dr0=;
        b=K2lY7I0r5hFw8DG5EJd659cbaFGi3SglYroCNRItp8E/06lbc+qlAasYJxwQD8sHVe
         CvBnAuIHv+P36EnJgWYWRjRH27OjVrWUvP9IABp+Ygt3KW2A+PwMHlTgsM6r+TOPY4KV
         W74IMOpEQFPtFsnK5+Td4UQTy9UO72izKfBdqzQnCdxUOtqrx3YAFUYTpz85KGQHTGMB
         iCqkOU/dQ7iTnYHqqSwqyeo7TixnuLN9YF8RIohP45X1z7kog0AqaDZ7rqadS8aa9AQ9
         mzM156Fa7oE5slhrysmBts0PwsivyFaJGkS+yq/yLFvHIRCwvaSHBwCfMvfaTVVjGlHO
         waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KoC52/OhyByIZz76tXoXDzs+xfPJOsQW1wOukb2Dr0=;
        b=Q9OdUhAYqRXuMKGTYUETMKDYK1cZ84AuOgT67k4GF4M3SNYrOOtAmEWYNoEf3hGU+P
         zOes23u4AkWrz8x7Kp97XAGhoPfQkrXCWYVEficQnf6OvBimzr0+EtbT4McxoWPxXFGv
         SKRe110T7o0wbXGPgi/Vap40x4yV7yTYV0MqWSnERy2m0E9bU7qWltGd4+oWx5Zm4wHo
         BvVt9jjVJuXdVoqmB4vsPc8IJncYj2vukYtxhTXTTOxR138g/iFmFeSGkqRviB72U8MW
         lk1eFN80dwRcZYB2DmE+k6THfNPPerQm1d83Cu86SNtzs7dMGmt3HmImjF0Lx4vJ/L6G
         LqZA==
X-Gm-Message-State: AOAM531d3hWVtHfxuv7CeLRh/kGbSHstJJYdJ/RWDuJObpagCnbA2rR0
        uQRBYYQXa6mnqCLLKphAr89CP4IHKqCvUQ==
X-Google-Smtp-Source: ABdhPJz10wicz8sO2wh9H482rMWHdf3Ne7aJ3fWg/xXlXOxdwPzqDo/9psXXTFpJcsYWHB6SDSvc6g==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr6300509wmd.0.1614723329324;
        Tue, 02 Mar 2021 14:15:29 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id r10sm4943020wmh.45.2021.03.02.14.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:15:26 -0800 (PST)
Subject: Re: [PATCH v3 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-9-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85283676-a0aa-6934-116b-98f2c5dece9f@linaro.org>
Date:   Tue, 2 Mar 2021 23:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614721102-2241-9-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/03/2021 22:38, Michael Kelley wrote:
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
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/x86/include/asm/mshyperv.h    | 11 -----------
>  drivers/clocksource/hyperv_timer.c | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 4f566db..5433312 100644
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
> index 06984fa..10eb5c6 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -423,6 +423,30 @@ static u64 notrace read_hv_sched_clock_msr(void)
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +/*
> + * Reference to pv_ops must be inline so objtool
> + * detection of noinstr violations can work correctly.
> + */
> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +	/*
> +	 * We're on an architecture with generic sched clock (not x86/x64).
> +	 * The Hyper-V sched clock read function returns nanoseconds, not
> +	 * the normal 100ns units of the Hyper-V synthetic clock.
> +	 */
> +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
> +}
> +#elif defined CONFIG_PARAVIRT
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +	/* We're on x86/x64 *and* using PV ops */
> +	pv_ops.time.sched_clock = sched_clock;
> +}
> +#else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
> +static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
> +#endif /* CONFIG_GENERIC_SCHED_CLOCK */
> +
>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	u64		tsc_msr;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
