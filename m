Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8728320FF6
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 05:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBVEJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 23:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBVEJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 23:09:07 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A271C061574;
        Sun, 21 Feb 2021 20:08:26 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id k8so5057252qvm.6;
        Sun, 21 Feb 2021 20:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LczEaE48F+utnjkPuq1s+xKVZFE6A8WhpTBcnEGpZa8=;
        b=Z3Ijjw6imodIyhMz0xEu6y5v5oVzoG6wjpJtA9SBmmBW/poIe3ffZ/aDEIOakFR5YT
         F3yLV/TvG+8BCjVxzs7ZwkanmbIIufGlFhy++9Ykv8xTE0xs2KM2Ls9jNcM4X5fXT75r
         7guy1ID2ep+Vtc1Cwl/aoXt2t08fv2tLf5g1Q7hriA47rMHFYiwABUXDsLnwUUBGOf2p
         3taSTA/JMr5oDdOXMPIj0kNP6aEvguI7PAzxg7Zdjxx6K5N5QkzyO8F+P1t36DX+OajS
         xsMFtGfuyZu81q2rlhCHZZ5LAlrvM2e34mJmpG4qRH+TltU8MEdpCasxrV7UFBaEO9js
         +zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LczEaE48F+utnjkPuq1s+xKVZFE6A8WhpTBcnEGpZa8=;
        b=NrTkgfTlQ1IvcvlfKkB31/yyIJWcK9EadwUubthDnpr2W8t8/UcmZfrbFFOFlr8F0d
         VAIRmeS+xwvDngxpEK6lWjtG1FqzIo3KxYeU7fjdMs9HVjcsXrxttEGtVqeDP4nvknwK
         DceVd3V/tWBvhIgcDJQctJ9NxhvRNcWtxNCMQ/8oyVQVQZ9+757SJ4pUlJa32AsBG4/A
         eFB7em//FWH18MRdCU0KiGgPbWuzjtElmzhv5+d4/OOh0YuiL7TxMMKx7V1Jg16ZXoOA
         ZlLuWGWNWK9+hcnlucIQ2x9SaoRHbtf7tBVy/Gj61/mAc38ixC5OkrzciQSJfxV86qS+
         ilVw==
X-Gm-Message-State: AOAM533CTxdW+4Xr9V/JEiAP/FthOqQobJy/uZMd0L7cJ5MlGqpWBZ3c
        GWzB3zrGat7XAH+1O6cMcGM=
X-Google-Smtp-Source: ABdhPJyZZuUV5ti70yxIfWmrKFvIqr6NKFZ1SgpPQw5j4CIKgZcP8bsbkgVwjFZnQrBQJwNc1PMelA==
X-Received: by 2002:a05:6214:38c:: with SMTP id l12mr11430205qvy.20.1613966905662;
        Sun, 21 Feb 2021 20:08:25 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z31sm3844191qtb.0.2021.02.21.20.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 20:08:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B427B27C0054;
        Sun, 21 Feb 2021 23:08:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 23:08:24 -0500
X-ME-Sender: <xms:Mi4zYA9oFh8DDxaRMYzJVlqRv1rVec9mbZ_fmqRAe44zqx9FF7hhAQ>
    <xme:Mi4zYIvk0ZU7snXRoFbu0WF0ozGWZwXsoZouF30sg-y3FoqiXV7vfWIxg6m6LzGWB
    x8zP6moaEJb-vM-rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Mi4zYGCJN4-afnZaO0dYB1mgLM5X39dtGS86QG8itNV8L3vwhtilqA>
    <xmx:Mi4zYAcqdQnu1LB7qzn7qfvAbfQNxOSCbO_vvmWpONf_oVGYBK1FUw>
    <xmx:Mi4zYFPzXFcfpBuFzYx3FcQMTEoIJV8-NUTCaR2xAoTQq7jW47F3uA>
    <xmx:My4zYJms5RCuXN-skRCvTXIg8Ni2caCJ8Z4Yigmah50qZjaGGaAo4LYrgew>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D71824005C;
        Sun, 21 Feb 2021 23:08:18 -0500 (EST)
Date:   Mon, 22 Feb 2021 12:07:46 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
Message-ID: <YDMuEvgRMF152DbS@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-8-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-8-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:42PM -0800, Michael Kelley wrote:
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

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/mshyperv.h    |  4 ----
>  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 4d3e0c5..ed9dc56 100644
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
> index 9425308..9cee6db 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -372,7 +372,9 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>  
>  static int hv_cs_enable(struct clocksource *cs)
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
>  };
>  
>  static u64 notrace read_hv_clock_msr(void)
> @@ -439,7 +446,6 @@ static bool __init hv_init_tsc_clocksource(void)
>  	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  
> -	hv_set_clocksource_vdso(hyperv_cs_tsc);
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>  
>  	hv_sched_clock_offset = hv_read_reference_counter();
> -- 
> 1.8.3.1
> 
