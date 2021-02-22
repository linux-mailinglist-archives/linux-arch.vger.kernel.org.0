Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7B320FE1
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBVDzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBVDzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:55:35 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D85C061574;
        Sun, 21 Feb 2021 19:54:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 204so6502809qke.11;
        Sun, 21 Feb 2021 19:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IbCa8cEsqXZpEgPQ4xNJV1VB0+cK4PhZk8+tQ3bQ6Z0=;
        b=IiHW6dN2YQG9XXfY+15A52gH89xP5cllVEmExxVsGko016LUDoUtgtOes8rEoAVPpW
         DmWLYyuiDXJfWvP8yyFq28+GeTJHmTOtd1CXB9BdU+TCsD73Xhjw0QsZFHdQmuz7KkQy
         d2bdeSNvE0inxUw3jvcYo8u3rwYpPOIMQtvPCFpLlEonknCVEdMf41lRZdowETCEEFnm
         Y44M/BNRdymxTVyJgTurNm5b5mmuL0xmdiGigSY1uW7no/TyIMhzpUNLsljao7dr4r+a
         mJ+kftuDTmEIaKBUHWd/sidnpVwAO7qSWRBk4X7CUjnC0emRLFx3AIfzSsKIHA0yDMZj
         LbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IbCa8cEsqXZpEgPQ4xNJV1VB0+cK4PhZk8+tQ3bQ6Z0=;
        b=BUu5+kdqTyc52bGyLgdxCeJLop9HNlJdgteE0SGHZzwiKby1LlQ/y2I+RYrCyzVbxR
         5eYFwKtM5CtbUfTS7M8GxkySexVdauqoaa/5q4B2YA2hcUGAK9/Z68nw/no1QhGfKrKJ
         a1j4mHm2BFTW8rwv1+KrbaGqQE6XlAa6c3iCEF9WAC3zFsJ4KGM8EOd7rzWvKjyCwNPs
         eNDFkGbWpzjvsmNJRgLk9VUPNeIK7B+GnVNmODeRZDkFvEnPnELF7ctONx/Eny9UTDwe
         QcsfBsDbXcCLIC6hEDhJ38x0Qa1UWJnVfxQBQd4Dm/ohX4xe44wZpm0S8yaEVSgcdeZG
         ulmw==
X-Gm-Message-State: AOAM5304KVgtbzw6EEs5+ZK8IeeoVhALTS4HWNgX2rWwTsk78CdXv0lF
        bgVx1lB2CR6iYhY/TCequdw=
X-Google-Smtp-Source: ABdhPJymLLZm1yghf1vdTsyHNDZkjlnwzriwtCKr6CqqedBJ3T94rf3GQLyGvpxO6elQCXFSq8q5Vg==
X-Received: by 2002:a37:7744:: with SMTP id s65mr18921169qkc.357.1613966094531;
        Sun, 21 Feb 2021 19:54:54 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l65sm3730139qkf.113.2021.02.21.19.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:54:54 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6EFAB27C0054;
        Sun, 21 Feb 2021 22:54:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 21 Feb 2021 22:54:53 -0500
X-ME-Sender: <xms:CyszYBZ0XYuSh6Cm6l2D3M1JvrtYLWH-CCxSRbtXZUQySqe3LXLWkg>
    <xme:CyszYCDk8kBfztTbNwecSPsZtxRMxvAyU0Iky3Sj8sVryR-XTAKWfi6Y9ya1WdHQ4
    x-mQdhrD6kaxJ6M2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CyszYD_ZsZ_Xkd295KxYwPvOC1ObeFHT_3Z0NPN47hB7P7cyoGMHUw>
    <xmx:CyszYC8ieuQxcMPcIGL9CRjPqi2QyWLYtOkyDQaVBbjNXkggJ65KBQ>
    <xmx:CyszYKdL1TAPOPMXpmPEBDCzEwZG3kLeT4JQnOaNhfeawsgeabrwKg>
    <xmx:DSszYBRwvZiKjIKD_bYqECJ8Lp_XnZXbFudJ5GBYPI0fIz6Ora8EYgz-bqg>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9604024005A;
        Sun, 21 Feb 2021 22:54:51 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:54:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 06/10] Drivers: hv: vmbus: Move handling of VMbus
 interrupts
Message-ID: <YDMq67DpGaMC2yfI@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-7-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-7-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:41PM -0800, Michael Kelley wrote:
> VMbus interrupts are most naturally modelled as per-cpu IRQs.  But
> because x86/x64 doesn't have per-cpu IRQs, the core VMbus interrupt
> handling machinery is done in code under arch/x86 and Linux IRQs are
> not used.  Adding support for ARM64 means adding equivalent code
> using per-cpu IRQs under arch/arm64.
> 
> A better model is to treat per-cpu IRQs as the normal path (which it is
> for modern architectures), and the x86/x64 path as the exception.  Do this
> by incorporating standard Linux per-cpu IRQ allocation into the main VMbus
> driver, and bypassing it in the x86/x64 exception case. For x86/x64,
> special case code is retained under arch/x86, but no VMbus interrupt
> handling code is needed under arch/arm64.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/mshyperv.h |  1 -
>  arch/x86/kernel/cpu/mshyperv.c  | 13 +++------
>  drivers/hv/hv.c                 |  8 +++++-
>  drivers/hv/vmbus_drv.c          | 63 ++++++++++++++++++++++++++++++++++++-----
>  include/asm-generic/mshyperv.h  |  7 ++---
>  5 files changed, 70 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index d12a188..4d3e0c5 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -32,7 +32,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  #define hv_enable_vdso_clocksource() \
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>  #define hv_get_raw_timer() rdtsc_ordered()
> -#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
>  
>  /*
>   * Reference to pv_ops must be inline so objtool
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f628e3dc..5679100a1 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -55,23 +55,18 @@
>  	set_irq_regs(old_regs);
>  }
>  
> -int hv_setup_vmbus_irq(int irq, void (*handler)(void))
> +void hv_setup_vmbus_handler(void (*handler)(void))
>  {
> -	/*
> -	 * The 'irq' argument is ignored on x86/x64 because a hard-coded
> -	 * interrupt vector is used for Hyper-V interrupts.
> -	 */
>  	vmbus_handler = handler;
> -	return 0;
>  }
> +EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
>  
> -void hv_remove_vmbus_irq(void)
> +void hv_remove_vmbus_handler(void)
>  {
>  	/* We have no way to deallocate the interrupt gate */
>  	vmbus_handler = NULL;
>  }
> -EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
> -EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
> +EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
>  
>  /*
>   * Routines to do per-architecture handling of stimer0
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index afe7a62..917b29e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -16,6 +16,7 @@
>  #include <linux/version.h>
>  #include <linux/random.h>
>  #include <linux/clockchips.h>
> +#include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -214,10 +215,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>  
>  	/* Setup the shared SINT. */
> +	if (vmbus_irq != -1)
> +		enable_percpu_irq(vmbus_irq, 0);
>  	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
>  					VMBUS_MESSAGE_SINT);
>  
> -	shared_sint.vector = hv_get_vector();
> +	shared_sint.vector = vmbus_interrupt;
>  	shared_sint.masked = false;
>  
>  	/*
> @@ -285,6 +288,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable = 0;
>  	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +
> +	if (vmbus_irq != -1)
> +		disable_percpu_irq(vmbus_irq);
>  }
>  
>  
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8affe68..62721a7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -48,8 +48,10 @@ struct vmbus_dynid {
>  
>  static void *hv_panic_page;
>  
> +static long __percpu *vmbus_evt;
> +
>  /* Values parsed from ACPI DSDT */
> -static int vmbus_irq;
> +int vmbus_irq;
>  int vmbus_interrupt;
>  
>  /*
> @@ -1354,7 +1356,13 @@ static void vmbus_isr(void)
>  			tasklet_schedule(&hv_cpu->msg_dpc);
>  	}
>  
> -	add_interrupt_randomness(hv_get_vector(), 0);
> +	add_interrupt_randomness(vmbus_interrupt, 0);
> +}
> +
> +static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> +{
> +	vmbus_isr();
> +	return IRQ_HANDLED;
>  }
>  
>  /*
> @@ -1469,9 +1477,28 @@ static int vmbus_bus_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = hv_setup_vmbus_irq(vmbus_irq, vmbus_isr);
> -	if (ret)
> -		goto err_setup;
> +	/*
> +	 * VMbus interrupts are best modeled as per-cpu interrupts. If
> +	 * on an architecture with support for per-cpu IRQs (e.g. ARM64),
> +	 * allocate a per-cpu IRQ using standard Linux kernel functionality.
> +	 * If not on such an architecture (e.g., x86/x64), then rely on
> +	 * code in the arch-specific portion of the code tree to connect
> +	 * the VMbus interrupt handler.
> +	 */
> +
> +	if (vmbus_irq == -1) {
> +		hv_setup_vmbus_handler(vmbus_isr);
> +	} else {
> +		vmbus_evt = alloc_percpu(long);
> +		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
> +				"Hyper-V VMbus", vmbus_evt);
> +		if (ret) {
> +			pr_err("Can't request Hyper-V VMbus IRQ %d, Err %d",
> +					vmbus_irq, ret);
> +			free_percpu(vmbus_evt);
> +			goto err_setup;
> +		}
> +	}
>  
>  	ret = hv_synic_alloc();
>  	if (ret)
> @@ -1532,7 +1559,12 @@ static int vmbus_bus_init(void)
>  err_cpuhp:
>  	hv_synic_free();
>  err_alloc:
> -	hv_remove_vmbus_irq();
> +	if (vmbus_irq == -1) {
> +		hv_remove_vmbus_handler();
> +	} else {
> +		free_percpu_irq(vmbus_irq, vmbus_evt);
> +		free_percpu(vmbus_evt);
> +	}
>  err_setup:
>  	bus_unregister(&hv_bus);
>  	unregister_sysctl_table(hv_ctl_table_hdr);
> @@ -2649,6 +2681,18 @@ static int __init hv_acpi_init(void)
>  		ret = -ETIMEDOUT;
>  		goto cleanup;
>  	}
> +
> +	/*
> +	 * If we're on an architecture with a hardcoded hypervisor
> +	 * vector (i.e. x86/x64), override the VMbus interrupt found
> +	 * in the ACPI tables. Ensure vmbus_irq is not set since the
> +	 * normal Linux IRQ mechanism is not used in this case.
> +	 */
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	vmbus_interrupt = HYPERVISOR_CALLBACK_VECTOR;
> +	vmbus_irq = -1;
> +#endif
> +
>  	hv_debug_init();
>  
>  	ret = vmbus_bus_init();
> @@ -2679,7 +2723,12 @@ static void __exit vmbus_exit(void)
>  	vmbus_connection.conn_state = DISCONNECTED;
>  	hv_stimer_global_cleanup();
>  	vmbus_disconnect();
> -	hv_remove_vmbus_irq();
> +	if (vmbus_irq == -1) {
> +		hv_remove_vmbus_handler();
> +	} else {
> +		free_percpu_irq(vmbus_irq, vmbus_evt);
> +		free_percpu(vmbus_evt);
> +	}
>  	for_each_online_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 6a8072f..9f4089b 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -89,10 +89,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  	}
>  }
>  
> -int hv_setup_vmbus_irq(int irq, void (*handler)(void));
> -void hv_remove_vmbus_irq(void);
> -void hv_enable_vmbus_irq(void);
> -void hv_disable_vmbus_irq(void);
> +void hv_setup_vmbus_handler(void (*handler)(void));
> +void hv_remove_vmbus_handler(void);
>  
>  void hv_setup_kexec_handler(void (*handler)(void));
>  void hv_remove_kexec_handler(void);
> @@ -100,6 +98,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  void hv_remove_crash_handler(void);
>  
>  extern int vmbus_interrupt;
> +extern int vmbus_irq;
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
> -- 
> 1.8.3.1
> 
