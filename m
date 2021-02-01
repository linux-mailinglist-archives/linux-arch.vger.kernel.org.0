Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCA30AFDB
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 19:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBASz6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 13:55:58 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54017 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBASz5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2021 13:55:57 -0500
Received: by mail-wm1-f54.google.com with SMTP id j18so234287wmi.3;
        Mon, 01 Feb 2021 10:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLmSIentwLuFLVXnsJMLh0cc8SI2PvhOVhp/gMM3mlA=;
        b=QPcFhK98jL5M+sPlh2sZPlx6eJq6UG4LwgvdFC5FoVqM0LPzVszYQwSCQBUQopmNBU
         +rc35aZCLrUElo6ARraXHNbmKsPv7nFYH8Fwi+8sX5pGA6zLVxRwM5KLWk0ld+9Rtt1+
         dq28U3c5+KnvkexkCdvSL6MsejLxSocR+G3zoreGDTmUVFewXEkrSdB0JKrq72GdenbH
         V5b8Bg10TTgd8mQed+WqDmaCWr2zbboiIamswAuaO26M5t3gPG6zAQ76WS1F5AEGOC2d
         IfY7StZN8hXcz8pMJ4fF5LyiHzt1aEKKfjq9ZpjkBBirtjkw8q6jOWn0Ul1IPrt1IB57
         WzEA==
X-Gm-Message-State: AOAM532r2Nv1q4DremUKdUJe6neIKaeQy9zQbjhcXHNthCylJIn9uZYr
        +u4GpDRlz8hjhSKg+Y2g/bE=
X-Google-Smtp-Source: ABdhPJyvRVCSjNDa60cSoH3aLH+CcVDgVvoBIwyUESbG0jzo2qXpWN/I2vCC3eif+/6T56OcjY8j1w==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr254457wmp.156.1612205715150;
        Mon, 01 Feb 2021 10:55:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v25sm224468wmh.4.2021.02.01.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:55:14 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:55:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Message-ID: <20210201185513.or4eilecqhmxqjme@liuwe-devbox-debian-v2>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:43PM -0800, Michael Kelley wrote:
[...]
> +/*
> + * Reference to pv_ops must be inline so objtool
> + * detection of noinstr violations can work correctly.
> + */
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)

sched_clock_register is not trivial. Having __always_inline here is
going to make the compiled object bloated.

Given this is a static function, I don't think we need to specify any
inline keyword. The compiler should be able to determine whether this
function should be inlined all by itself.

Wei.

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
