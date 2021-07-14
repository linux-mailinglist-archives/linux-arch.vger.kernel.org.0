Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2EF3C821D
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhGNJzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 05:55:39 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37850 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhGNJzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 05:55:39 -0400
Received: by mail-wr1-f46.google.com with SMTP id i94so2450824wri.4;
        Wed, 14 Jul 2021 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWsoJYpAqFmZPTRUz9svqFQdcUeWi60L6XgpUAVLGJU=;
        b=nfbYNkA++yUxbIVPYjp4qfGbKR3d43icwB8USVmNwvm28Fgs5H+7H6ifO5yeiF5AlO
         rCXuMaBZxzNX3+LlfxfJsVpczgwQGUy7TgMUZqqD7AJ8Ag4FS2iubrfkAfhSMMEguegN
         9o1nHy/7eRXUiyolEFYR2FaDBPdN5VJ1IuDOzHleuKgnVDjbauS/bxXgJ+8RabH/uVLm
         eBcMje2U0RMPmc9O+7JcqbR+WOWTRgCgyb/bsVUYJQY+eOLr63Eb9cr4u/pjyecK9yjb
         e1mK4t1JaW5y7IU39ZCwwxGZr5ifG2aoqh52ggw9lST5NXY728UoJr5Dah/wUwf2plxk
         055A==
X-Gm-Message-State: AOAM531lleq7uBdd3EAU7ZoimDCqkgRoON7TIqFpmLxLpe7DrUgwJkne
        1mkLJ9lt1vPhbP4Gwz+FMCQ=
X-Google-Smtp-Source: ABdhPJxReumJcBMMF1clrowhgbOzCKNtBJCgSfbw6atAEpQJleGdC6tv70xw47y0ri5aQM/GVnl8YA==
X-Received: by 2002:adf:b605:: with SMTP id f5mr11728606wre.419.1626256366636;
        Wed, 14 Jul 2021 02:52:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r15sm1959191wrx.94.2021.07.14.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:52:46 -0700 (PDT)
Date:   Wed, 14 Jul 2021 09:52:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers: hv: Decouple Hyper-V clock/timer code from
 VMbus drivers
Message-ID: <20210714095244.wcnmp5mxvehdq3zj@liuwe-devbox-debian-v2>
References: <1626220906-22629-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626220906-22629-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 13, 2021 at 05:01:46PM -0700, Michael Kelley wrote:
[...]
>  
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
> index b6774aa..1c566c7 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -20,6 +20,8 @@
>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>  #define HV_MIN_DELTA_TICKS 1
>  
> +#ifdef CONFIG_HYPERV_TIMER
> +
>  /* Routines called by the VMbus driver */
>  extern int hv_stimer_alloc(bool have_percpu_irqs);
>  extern int hv_stimer_cleanup(unsigned int cpu);
> @@ -28,8 +30,6 @@
>  extern void hv_stimer_global_cleanup(void);
>  extern void hv_stimer0_isr(void);
>  
> -#ifdef CONFIG_HYPERV_TIMER
> -extern u64 (*hv_read_reference_counter)(void);
>  extern void hv_init_clocksource(void);
>  
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> @@ -100,6 +100,13 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>  {
>  	return U64_MAX;
>  }
> +
> +static inline int hv_stimer_cleanup(unsigned int cpu) {return 0; }

Nit: missing space before "return". No need to resend just for this.

Wei.
