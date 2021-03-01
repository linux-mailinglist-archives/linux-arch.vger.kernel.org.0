Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F010328C52
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhCAStV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 13:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbhCASp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2021 13:45:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C1C06178A
        for <linux-arch@vger.kernel.org>; Mon,  1 Mar 2021 10:44:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so220793wml.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Mar 2021 10:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iiJdRDjWUFbp3m7znHMOgxB7I0EJzPWYd34O1BbcPEg=;
        b=AgPf59Bnpu82d0gde43PZP43b+zjJ6cOmOUtiBQlKXV7J8FMsvu5MJ0IB/4qhvr6+U
         V0ytDEsg75YZ6tjJwzG/kNCj2kcYmdOojaL/iXwJmURqMbsqxQunb67gJXOOX4IkOCri
         OI5rBl09tnYy+K/rsTR6/ioA7/2aBg1mKfu07JnDJcX6jZuQo+LwBDxZCteT2ITRGpVV
         WqoDXixpDH6ir6NV6bWH3sdZ3StdleWjF3s5HlSY2zWynOqSaLtb8xCRIkXPDPVQ+w8L
         fja7CFDh+GdxyYYmvbzA5TsWUJFh5HHsAjR5X8yV930vi1vlpZMoGaM55G9+TgZd+s3o
         hc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iiJdRDjWUFbp3m7znHMOgxB7I0EJzPWYd34O1BbcPEg=;
        b=F1Mb3t3P6MRNFxq0b7ntVHneB9ZG8ggSpG9hQN9zaJgAlX4uq38eTtVGhCA4wuKW8n
         RruwVOeTqvduOb/Iv+wfjpkbLKm1FuLBsJaCIUC/VYQnTZzJFIUIYREgp5g9p9yAJoLn
         709dprmHlDicxegIjgzSNSIMHdKDzV4UyPV8eiRYvWSeaXjGthvqFkzrZbI0GwNf3XE/
         4K1273T6uFomBcEtTL5Ysb6dABWXHf/uNhe4M3m9yCpkQqCTnhB12CaFIne9wSPHevkk
         cKK+23UOYlTImpxcjgrC666qqx5JMnQbmY1YrO+LODYo4NT2sfmpNUGbafCXpUOOP3Xl
         wOUg==
X-Gm-Message-State: AOAM532sQN7K5XzUyFfY0z3NjqIS/SC4yF4Y3L2To2FAgFAy7xzJQhGU
        b1BuTHqX5vsUxke9Ti2P3jHOQE4PF+y87Q==
X-Google-Smtp-Source: ABdhPJzxOFSWK0My0Zl9EB1Bd1pzqlb0aS0lxIYWo5GQwaneUzKtXMvCBOSqeAgmwxFEJRpktg1iOw==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr274467wmf.68.1614624282168;
        Mon, 01 Mar 2021 10:44:42 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id p16sm13286308wrt.54.2021.03.01.10.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 10:44:41 -0800 (PST)
Subject: Re: [PATCH v2 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-11-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cb190ed5-66f3-bdf7-aa97-b1fe0c49e282@linaro.org>
Date:   Mon, 1 Mar 2021 19:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614561332-2523-11-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01/03/2021 02:15, Michael Kelley wrote:
> STIMER0 interrupts are most naturally modeled as per-cpu IRQs. But
> because x86/x64 doesn't have per-cpu IRQs, the core STIMER0 interrupt
> handling machinery is done in code under arch/x86 and Linux IRQs are
> not used. Adding support for ARM64 means adding equivalent code
> using per-cpu IRQs under arch/arm64.
> 
> A better model is to treat per-cpu IRQs as the normal path (which it is
> for modern architectures), and the x86/x64 path as the exception. Do this
> by incorporating standard Linux per-cpu IRQ allocation into the main
> SITMER0 driver code, and bypass it in the x86/x64 exception case. For
> x86/x64, special case code is retained under arch/x86, but no STIMER0
> interrupt handling code is needed under arch/arm64.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          |   2 +-
>  arch/x86/include/asm/mshyperv.h    |   4 -
>  arch/x86/kernel/cpu/mshyperv.c     |  10 +--
>  drivers/clocksource/hyperv_timer.c | 180 ++++++++++++++++++++++++++-----------
>  include/asm-generic/mshyperv.h     |   5 --
>  include/clocksource/hyperv_timer.h |   3 +-
>  6 files changed, 132 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9af4f8a..9d10025 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -327,7 +327,7 @@ static void __init hv_stimer_setup_percpu_clockev(void)
>  	 * Ignore any errors in setting up stimer clockevents
>  	 * as we can run with the LAPIC timer as a fallback.
>  	 */
> -	(void)hv_stimer_alloc();
> +	(void)hv_stimer_alloc(false);
>  
>  	/*
>  	 * Still register the LAPIC timer, because the direct-mode STIMER is
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 5433312..6d4891b 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -31,10 +31,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  
>  void hyperv_vector_handler(struct pt_regs *regs);
>  
> -static inline void hv_enable_stimer0_percpu_irq(int irq) {}
> -static inline void hv_disable_stimer0_percpu_irq(int irq) {}
> -
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern int hyperv_init_cpuhp;
>  
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 41fd84a..cebed53 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -90,21 +90,17 @@ void hv_remove_vmbus_handler(void)
>  	set_irq_regs(old_regs);
>  }
>  
> -int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
> +/* For x86/x64, override weak placeholders in hyperv_timer.c */
> +void hv_setup_stimer0_handler(void (*handler)(void))
>  {
> -	*vector = HYPERV_STIMER0_VECTOR;
> -	*irq = -1;   /* Unused on x86/x64 */
>  	hv_stimer0_handler = handler;
> -	return 0;
>  }
> -EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
>  
> -void hv_remove_stimer0_irq(int irq)
> +void hv_remove_stimer0_handler(void)
>  {
>  	/* We have no way to deallocate the interrupt gate */
>  	hv_stimer0_handler = NULL;
>  }
> -EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
>  
>  void hv_setup_kexec_handler(void (*handler)(void))
>  {
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index cdb8e0c..b2bf5e5 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -18,6 +18,9 @@
>  #include <linux/sched_clock.h>
>  #include <linux/mm.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/acpi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
> @@ -43,14 +46,13 @@
>   */
>  static bool direct_mode_enabled;
>  
> -static int stimer0_irq;
> -static int stimer0_vector;
> +static int stimer0_irq = -1;
> +static long __percpu *stimer0_evt;

Why not

static DEFINE_PER_CPU(long, stimer0_evt);

no need of allocation /free ?






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
