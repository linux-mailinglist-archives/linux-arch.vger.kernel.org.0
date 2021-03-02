Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8232B4E1
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450152AbhCCFaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838061AbhCBWPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 17:15:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0AFC061797
        for <linux-arch@vger.kernel.org>; Tue,  2 Mar 2021 14:14:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so21520211wri.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Mar 2021 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M1/m/gd9FGC+n/OV39jRVRgV/wdTA/bprzwjyOWO+Ik=;
        b=GIB6d97DF+Qq6qu+TXbhAjQDObZROxJLVp+TdNEZUVGR5T/0NqF53IaOnKWOqHmTzx
         jnxPItI0hKKRgB/vCEbSfd/cUMPprqejrC7iC9lK81l8NIn8wB6RENHbI1ud8aQ+erFT
         gVmjOhvKgWI/+5weX60PPb1TYnfj3LvYeAWzaAdjz3R58Nms0DSpCeMtxCkeC2czmt5N
         Txlh9oAj6HEnXNbKQ0tIHJgGa2zxGlN125wvGgTZf4H/wflFr654dq5J4l6CoSPWu1Dn
         WmS4oqPEk42C/y9XXuG7dMbEaUzZ8EGRrFusvMRTUYiBEKkRgBrAKmhykdIFiq7iW3b/
         7uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M1/m/gd9FGC+n/OV39jRVRgV/wdTA/bprzwjyOWO+Ik=;
        b=sU+t3ughdoZGZ/6HHruVtM+LptZbZGS7z3HjqQkDzSjUJiVITKponPDUfbkXgTxcyM
         BG+VZ/SfkS8+r6horxE0C0FF1vm06TaOvUMxYwh9N8RgQXrZYPEiiVN1pBmwJPiJUAUS
         8EgXO6YrQ/ZB3sXcVWn1gEOmDNp/ix9AWT3hPH94LiU8BpDfEc/JI4nBNG9mTQ6MimSI
         G/MKC8BMsDaJJSunzw/4yJlvorJrJREBhClYBU5appwgsqKZ9mEnxyXAcunRyAS6tqzY
         5vwugu4DR8DvHjmzN4p5FefRs0kDW1kAZZmMRDKcfqq680p7wpIfa1cKJaMhinrH0M3C
         wwKQ==
X-Gm-Message-State: AOAM530pQNnrCxufThyGBqm/Yw8XYTf9y+SKsF7ZZleiwyO0xh6kxF2o
        N+d3Ax19bzF2EVIdhcnU7WrBs+Phb5eTvg==
X-Google-Smtp-Source: ABdhPJxMNHtZ9W5GJwP7uaL12fOHEnJa1tDSkjhHzAB6spwKCJ7cGfD2teG0nf74dKR0qXPLyoIwxQ==
X-Received: by 2002:adf:e603:: with SMTP id p3mr21234023wrm.360.1614723264090;
        Tue, 02 Mar 2021 14:14:24 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id z2sm11707388wrm.0.2021.03.02.14.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:14:23 -0800 (PST)
Subject: Re: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <25234414-d905-0f9c-af92-9a9e4cde30c4@linaro.org>
Date:   Tue, 2 Mar 2021 23:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/03/2021 22:38, Michael Kelley wrote:
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
> 
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
> index c73c127..06984fa 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -370,11 +370,13 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>  
> +#ifdef VDSO_CLOCKMODE_HVCLOCK
>  static int hv_cs_enable(struct clocksource *cs)
>  {
> -	hv_enable_vdso_clocksource();
> +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>  	return 0;
>  }
> +#endif

We had a confusion here. The suggestion was to remove the #ifdef here
and add the __maybe_unused annotation to the function.

>  static struct clocksource hyperv_cs_tsc = {
>  	.name	= "hyperv_clocksource_tsc_page",
> @@ -384,7 +386,12 @@ static int hv_cs_enable(struct clocksource *cs)
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend= suspend_hv_clock_tsc,
>  	.resume	= resume_hv_clock_tsc,
> +#ifdef VDSO_CLOCKMODE_HVCLOCK
>  	.enable = hv_cs_enable,
> +	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
> +#else
> +	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
> +#endif
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
