Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21EA32260B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBWGsf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 01:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhBWGsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 01:48:33 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B6C06174A;
        Mon, 22 Feb 2021 22:47:53 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b14so15285911qkk.0;
        Mon, 22 Feb 2021 22:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcCVSRunsRaYJB4Bhip3trLdPuKiGPq3n/KQOf4/vbo=;
        b=jg3yv/XxYojyFsbv9zkw0b8MM7eb3FvOIzfOG5qHnsQ3f3ESXLVV4E3W08xPmsGvXb
         HC4eS5hGHNuiDC2NgdzO8YiSXetSs6agjCDE92nUSW6RZUWRD1BACtOGXbaejwdg+AFC
         TO6dfAczcPFArZZ+j/9lbVh4n/dsDrIBE+ZDgEalRsLPArtQpAIL+J5JmaEY2/8tCAFX
         f0GPz01jaq76ABJ4/w0RUiXUsEj9mc1nV8tHq6BwZdpCO5HBirh97ghs0auChkNHjeWg
         VWWssXyyhyv4wgH7l9D+a0/yUD8IKTnpoHmGxpFwYrb/yyHmtZCs+bYlS7kw0yajscJB
         qIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcCVSRunsRaYJB4Bhip3trLdPuKiGPq3n/KQOf4/vbo=;
        b=fJ9ghee34cnTBYt5y3lwJ/oIx78llfcgAo3t8d078/i9mcDWLMuG3QkSixyYEn96oK
         mAKP9oNAbcUkWdW4mmtVL7WVe0oINyojGLp/r4FdWlufhDXYFZNcG4ctBxrKHQgPWUeT
         oD0+m10LjW/SCPDGGUlrg7zgQNCz1I5F+Wcr1PZpuechqD+8NJtVxAO0r80I8/xJHxGc
         zniT+4M2Z4Azu/KTkQrzWYLAXHzu7iDkj0lEPdNCF5HrNErAv7GoFwtVnJr8YGZANQvB
         8SSbmOVt2xHc5DyPPOtBP0dEegaqvujgmDm60kJAlb2d1OutspEmGWNh7YA8YQy+mDoo
         mJ5A==
X-Gm-Message-State: AOAM531TqFVOauKLtRSIMkUGRjrFnNNWFq4sjJMYkidmXgFcKU6tV4Mb
        x3IaYJEFk+O/HYYaZk9Tewg=
X-Google-Smtp-Source: ABdhPJxxAfubaw/aypIkCwhRIagg6VJlGlWtbWg2KIzDKzRILRH37zQ1fLkTaAviCPkH+21ueU03+w==
X-Received: by 2002:a05:620a:851:: with SMTP id u17mr24375745qku.129.1614062872188;
        Mon, 22 Feb 2021 22:47:52 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f9sm14061725qkm.28.2021.02.22.22.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:47:51 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B1F6D27C0054;
        Tue, 23 Feb 2021 01:47:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Feb 2021 01:47:50 -0500
X-ME-Sender: <xms:EaU0YDN9OErC0pcSakdQmELRprvP8ksFZ9AJ8mBdAoak29yXeQagWg>
    <xme:EaU0YN88g0dsEAnkU4XqeoBb-cEUPw7PmtYHYlXJJni6TIlr1qhPTPdDzd2cJUWpO
    CHW26cblFupkSWPxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:EaU0YCSdhdLighGMk4yEMNExvKgMLf2kopsMm1nf-1isi2dXUp8nLg>
    <xmx:EaU0YHusJQjAUPf_EyuxQPrBbReMdaggVEhtGBTYPch7GK9JEoiYTQ>
    <xmx:EaU0YLe2qDh8t52ilOEB_XTybDrtRNrlcVQfnXBYvmClQfh43ez8Mw>
    <xmx:E6U0YJ3BRS2i84v-ClR7trkLBdvCrh2KGGEnl57-woEyaET5dUcRvFwT5qQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id A47F61080057;
        Tue, 23 Feb 2021 01:47:45 -0500 (EST)
Date:   Tue, 23 Feb 2021 14:47:10 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Message-ID: <YDSk7scPgUZdwyMd@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:45PM -0800, Michael Kelley wrote:
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
>  drivers/clocksource/hyperv_timer.c | 170 +++++++++++++++++++++++++------------
>  include/asm-generic/mshyperv.h     |   5 --
>  include/clocksource/hyperv_timer.h |   3 +-
>  6 files changed, 123 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 22e9557..fe37546 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -371,7 +371,7 @@ void __init hyperv_init(void)
>  	 * Ignore any errors in setting up stimer clockevents
>  	 * as we can run with the LAPIC timer as a fallback.
>  	 */
> -	(void)hv_stimer_alloc();
> +	(void)hv_stimer_alloc(false);
>  
>  	hv_apic_init();
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 5ccbba8..941dd55 100644
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
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 5679100a1..440507e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -85,21 +85,17 @@ void hv_remove_vmbus_handler(void)
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
> index edf2d43..c553b8c 100644
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
>  static int stimer0_message_sint;
>  
>  /*
> - * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
> - * does not use VMbus or any VMbus messages, so process here and not
> - * in the VMbus driver code.
> + * Common code for stimer0 interrupts coming via Direct Mode or
> + * as a VMbus message.
>   */
>  void hv_stimer0_isr(void)
>  {
> @@ -61,6 +63,16 @@ void hv_stimer0_isr(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_stimer0_isr);
>  
> +/*
> + * stimer0 interrupt handler for architectures that support
> + * per-cpu interrupts, which also implies Direct Mode.
> + */
> +static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
> +{
> +	hv_stimer0_isr();
> +	return IRQ_HANDLED;
> +}
> +
>  static int hv_ce_set_next_event(unsigned long delta,
>  				struct clock_event_device *evt)
>  {
> @@ -76,8 +88,8 @@ static int hv_ce_shutdown(struct clock_event_device *evt)
>  {
>  	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
>  	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
> -	if (direct_mode_enabled)
> -		hv_disable_stimer0_percpu_irq(stimer0_irq);
> +	if (direct_mode_enabled && stimer0_irq >= 0)
> +		disable_percpu_irq(stimer0_irq);
>  
>  	return 0;
>  }
> @@ -95,8 +107,9 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
>  		 * on the specified hardware vector/IRQ.
>  		 */
>  		timer_cfg.direct_mode = 1;
> -		timer_cfg.apic_vector = stimer0_vector;
> -		hv_enable_stimer0_percpu_irq(stimer0_irq);
> +		timer_cfg.apic_vector = HYPERV_STIMER0_VECTOR;
> +		if (stimer0_irq >= 0)
> +			enable_percpu_irq(stimer0_irq, IRQ_TYPE_NONE);
>  	} else {
>  		/*
>  		 * When it expires, the timer will generate a VMbus message,
> @@ -169,10 +182,67 @@ int hv_stimer_cleanup(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
>  
> +/*
> + * These placeholders are overridden by arch specific code on
> + * architectures that need special setup of the stimer0 IRQ because
> + * they don't support per-cpu IRQs (such as x86/x64).
> + */
> +void __weak hv_setup_stimer0_handler(void (*handler)(void))
> +{
> +};
> +
> +void __weak hv_remove_stimer0_handler(void)
> +{
> +};
> +
> +static int hv_setup_stimer0_irq(void)
> +{
> +	int ret;
> +
> +	ret = acpi_register_gsi(NULL, HYPERV_STIMER0_VECTOR,
> +			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
> +	if (ret < 0) {
> +		pr_err("Can't register Hyper-V stimer0 GSI. Error %d", ret);
> +		return ret;
> +	}
> +	stimer0_irq = ret;
> +
> +	stimer0_evt = alloc_percpu(long);
> +	if (!stimer0_evt) {
> +		ret = -ENOMEM;
> +		goto unregister_gsi;
> +	}
> +	ret = request_percpu_irq(stimer0_irq, hv_stimer0_percpu_isr,
> +		"Hyper-V stimer0", stimer0_evt);
> +	if (ret) {
> +		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
> +			stimer0_irq, ret);
> +		goto free_stimer0_evt;
> +	}
> +	return ret;
> +
> +free_stimer0_evt:
> +	free_percpu(stimer0_evt);
> +unregister_gsi:
> +	acpi_unregister_gsi(stimer0_irq);
> +	stimer0_irq = -1;
> +	return ret;
> +}
> +
> +static void hv_remove_stimer0_irq(void)
> +{
> +	if (stimer0_irq != -1) {
> +		free_percpu_irq(stimer0_irq, stimer0_evt);
> +		free_percpu(stimer0_evt);
> +		acpi_unregister_gsi(stimer0_irq);
> +		stimer0_irq = -1;
> +	}

I think we need:

	else {
		hv_remove_stimer0_handler();
	}

here?

Because previously, on x86 we set hv_stimer0_handler to NULL in
hv_remove_stimer0_irq(), however, this patch doesn't keep this behavior
any more.

Thoughts?

Regards,
Boqun

> +}
> +
>  /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
> -int hv_stimer_alloc(void)
> +int hv_stimer_alloc(bool have_percpu_irqs)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	/*
>  	 * Synthetic timers are always available except on old versions of
> @@ -188,29 +258,37 @@ int hv_stimer_alloc(void)
>  
>  	direct_mode_enabled = ms_hyperv.misc_features &
>  			HV_STIMER_DIRECT_MODE_AVAILABLE;
> -	if (direct_mode_enabled) {
> -		ret = hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
> -				hv_stimer0_isr);
> +
> +	/*
> +	 * If Direct Mode isn't enabled, the remainder of the initialization
> +	 * is done later by hv_stimer_legacy_init()
> +	 */
> +	if (!direct_mode_enabled)
> +		return 0;
> +
> +	if (have_percpu_irqs) {
> +		ret = hv_setup_stimer0_irq();
>  		if (ret)
> -			goto free_percpu;
> +			goto free_clock_event;
> +	} else {
> +		hv_setup_stimer0_handler(hv_stimer0_isr);
> +	}
>  
> -		/*
> -		 * Since we are in Direct Mode, stimer initialization
> -		 * can be done now with a CPUHP value in the same range
> -		 * as other clockevent devices.
> -		 */
> -		ret = cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
> -				"clockevents/hyperv/stimer:starting",
> -				hv_stimer_init, hv_stimer_cleanup);
> -		if (ret < 0)
> -			goto free_stimer0_irq;
> +	/*
> +	 * Since we are in Direct Mode, stimer initialization
> +	 * can be done now with a CPUHP value in the same range
> +	 * as other clockevent devices.
> +	 */
> +	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
> +			"clockevents/hyperv/stimer:starting",
> +			hv_stimer_init, hv_stimer_cleanup);
> +	if (ret < 0) {
> +		hv_remove_stimer0_irq();
> +		goto free_clock_event;
>  	}
>  	return ret;
>  
> -free_stimer0_irq:
> -	hv_remove_stimer0_irq(stimer0_irq);
> -	stimer0_irq = 0;
> -free_percpu:
> +free_clock_event:
>  	free_percpu(hv_clock_event);
>  	hv_clock_event = NULL;
>  	return ret;
> @@ -254,23 +332,6 @@ void hv_stimer_legacy_cleanup(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(hv_stimer_legacy_cleanup);
>  
> -
> -/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
> -void hv_stimer_free(void)
> -{
> -	if (!hv_clock_event)
> -		return;
> -
> -	if (direct_mode_enabled) {
> -		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
> -		hv_remove_stimer0_irq(stimer0_irq);
> -		stimer0_irq = 0;
> -	}
> -	free_percpu(hv_clock_event);
> -	hv_clock_event = NULL;
> -}
> -EXPORT_SYMBOL_GPL(hv_stimer_free);
> -
>  /*
>   * Do a global cleanup of clockevents for the cases of kexec and
>   * vmbus exit
> @@ -287,12 +348,17 @@ void hv_stimer_global_cleanup(void)
>  		hv_stimer_legacy_cleanup(cpu);
>  	}
>  
> -	/*
> -	 * If Direct Mode is enabled, the cpuhp teardown callback
> -	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
> -	 * stimers.
> -	 */
> -	hv_stimer_free();
> +	if (!hv_clock_event)
> +		return;
> +
> +	if (direct_mode_enabled) {
> +		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
> +		hv_remove_stimer0_irq();
> +		stimer0_irq = -1;
> +	}
> +	free_percpu(hv_clock_event);
> +	hv_clock_event = NULL;
> +
>  }
>  EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
>  
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 9f4089b..c271870 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -178,9 +178,4 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
>  static inline void hyperv_cleanup(void) {}
>  #endif /* CONFIG_HYPERV */
>  
> -#if IS_ENABLED(CONFIG_HYPERV)
> -extern int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
> -extern void hv_remove_stimer0_irq(int irq);
> -#endif
> -
>  #endif
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
> index 34eef083..b6774aa 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -21,8 +21,7 @@
>  #define HV_MIN_DELTA_TICKS 1
>  
>  /* Routines called by the VMbus driver */
> -extern int hv_stimer_alloc(void);
> -extern void hv_stimer_free(void);
> +extern int hv_stimer_alloc(bool have_percpu_irqs);
>  extern int hv_stimer_cleanup(unsigned int cpu);
>  extern void hv_stimer_legacy_init(unsigned int cpu, int sint);
>  extern void hv_stimer_legacy_cleanup(unsigned int cpu);
> -- 
> 1.8.3.1
> 
