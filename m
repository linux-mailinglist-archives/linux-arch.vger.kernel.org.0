Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532CF327E31
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 13:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhCAMWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhCAMWZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2021 07:22:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA6C061756
        for <linux-arch@vger.kernel.org>; Mon,  1 Mar 2021 04:21:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d11so15912009wrj.7
        for <linux-arch@vger.kernel.org>; Mon, 01 Mar 2021 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gw7vh21OA2GN+c4vAdueJEzrkOpCd8FahG3FhqVfJSo=;
        b=QbOaPeYXxavfvWwZm75sM0iJMXhJmsLHuf+hAYClzhVA+k+iWTuWFkSmQpQj4TWhTi
         5jJ3v1RCIl0+4sZwAl6Bf3S5eMx133iTAwJjvmiA/wdo7WaBJQzCVKAw5v0r3yOnfkwj
         z5mDwqKrhyEIBZH2s3WkV0KYfIXD/OCNLAQbyywDzOTqOTi3tU80m2iPq9Mv5URuoM9H
         IaRpk8Hh2o107WFgw948pOoaDej0ZI40URY5EILj+OZzYHfeOsrFOR6dErzbsbgXeMCg
         WNUKrV/BkQb9BgGKS5U2NwiYs+i96RrymY6EUGXEGS6Ful4HE/5aoyjHMfndVcn+K/NJ
         fWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gw7vh21OA2GN+c4vAdueJEzrkOpCd8FahG3FhqVfJSo=;
        b=NAq5IIGy7qUU9LgwfDS6+DJbA+bu8PEwjQOUUPRJbp+747S48DSeI9RsMq5LV3rH56
         hv+0QG0YQ62kKb4+GEsZq4Px8gP6udwrg/CjCvTz8DGVxD8Gy3znHT/QeJaMr2+URayb
         YrCcrFrwxdXw+2NKQIXCpsg6Zux0dTuRDIWDo8I91MZQmG6s5vLvTngAcP25kbBKSOhH
         EQq7HAygLFntwVuOETN17k6v8BdqharvCF/i521KhShijGthLk6ebMXiLcXz3heT6Z/R
         zIgosaNdr7mnBXiORmAmaLxo0dxzIfvP512n37Bn91ilw2/9PX96flfYjkeaIIFJpucJ
         1ydA==
X-Gm-Message-State: AOAM530NHvSMg96HWIzaLEvN0p6QWhqbCM2fWaVHcc1Di2e3qjz4ItJc
        bsDzd6Lau6Ahp2HJ397+tSPUvJ/4SuIp6g==
X-Google-Smtp-Source: ABdhPJzS7WpgzqniNfjBwwdPG7kTr25w9/adiWOz65ygaVjjmtBJcd7QUoFMbNKuSB7q8BbAxrmEsQ==
X-Received: by 2002:a05:6000:1545:: with SMTP id 5mr16505065wry.90.1614601303562;
        Mon, 01 Mar 2021 04:21:43 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id g202sm3775569wme.20.2021.03.01.04.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 04:21:43 -0800 (PST)
Subject: Re: [PATCH v2 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-8-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <42dc252a-b09a-afeb-6792-9b77669c16e9@linaro.org>
Date:   Mon, 1 Mar 2021 13:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614561332-2523-8-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01/03/2021 02:15, Michael Kelley wrote:
> While the driver for the Hyper-V Reference TSC and STIMERs is architecture
> neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current code
> calls into utility functions under arch/x86 (and coming, under arch/arm64)
> to handle the difference.
> 
> Change this approach to handle the difference inline based on whether
> VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code under
> arch/* since the difference is tied more to the specifics of the Linux
> implementation than to the architecture.
> 
> No functional change.

A suggestion below


> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/mshyperv.h    |  4 ----
>  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index c10dd1c..4f566db 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -27,10 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  	return value;
>  }
>  
> -#define hv_set_clocksource_vdso(val) \
> -	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
> -#define hv_enable_vdso_clocksource() \
> -	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>  #define hv_get_raw_timer() rdtsc_ordered()
>  
>  /*
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index c73c127..5e5e08aa 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -372,7 +372,9 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>  
>  static int hv_cs_enable(struct clocksource *cs)

static __maybe_unused int hv_cs_enable(struct clocksource *cs)

>  {
> -	hv_enable_vdso_clocksource();
> +#ifdef VDSO_CLOCKMODE_HVCLOCK
> +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> +#endif
>  	return 0;
>  }
>  
> @@ -385,6 +387,11 @@ static int hv_cs_enable(struct clocksource *cs)
>  	.suspend= suspend_hv_clock_tsc,
>  	.resume	= resume_hv_clock_tsc,
>  	.enable = hv_cs_enable,
> +#ifdef VDSO_CLOCKMODE_HVCLOCK
> +	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
> +#else
> +	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
> +#endif

#ifdef VDSO_CLOCKMODE_HVCLOCK
	.enable = hv_cs_enable,
	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
#else
	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
#endif



>  };
>  
>  static u64 notrace read_hv_clock_msr(void)
> @@ -442,7 +449,6 @@ static bool __init hv_init_tsc_clocksource(void)
>  	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  
> -	hv_set_clocksource_vdso(hyperv_cs_tsc);
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>  
>  	hv_sched_clock_offset = hv_read_reference_counter();
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
