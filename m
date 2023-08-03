Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A876DC68
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHCAKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjHCAKO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:10:14 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C23598;
        Wed,  2 Aug 2023 17:10:10 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a38953c928so278062b6e.1;
        Wed, 02 Aug 2023 17:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021409; x=1691626209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOSDZ8OL0UiQZVyYk0lTuuVm/SjnI4aI4oQHKVpBxmU=;
        b=IujxPc9Y15v49kuNOBREo+HjWZZ0+dNJZygCl7Kf8IYdUk7KcvaMu7PdHs74AjB09H
         b8DOQX5D75tLxFdZm+UVu3l/JMrK1HCWAY1eUhJBSXc+D639dyYQALEd7IAzaJ0VFlbY
         A9+iJ73UUOMiRLuoxYMIzf5lzbs4jZHQkPqQHTmZZLuJVq2LaT755jkBXaCaflaUdMJR
         GYviWjGLvYRnNRSYh/eiczhvP5t6CVi2pPdUlhuH7FeQpBRFzH1ZeJWU4hA8TXtBaD8Q
         OfG0u3yiNNDmhQUhCCrRqhj2YGZyVNy1PVBzYVtYZtXMGWK+/Wyw8IbtFY1ZUzkUpkov
         kw4g==
X-Gm-Message-State: ABy/qLZd1g2cUX3CR2I4fZuZtsIcVR8PwkVqdramyHGUFWkFazM4k74+
        IZ1BSVqC4MGZ0zVuHsgQtk6g6mFP8Ds=
X-Google-Smtp-Source: APBJJlGJuUgeaX5hUASc4468mdN2X3XK5fAI+FdbKgJSUsP6MGjW+9jgQv5ggG+vYzY3yXWZAoDU3w==
X-Received: by 2002:aca:f14:0:b0:3a7:8f7:62ee with SMTP id 20-20020aca0f14000000b003a708f762eemr15154852oip.12.1691021409620;
        Wed, 02 Aug 2023 17:10:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v14-20020a63bf0e000000b0055c558ac4edsm11069481pgf.46.2023.08.02.17.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:10:09 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:10:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 08/15] Drivers: hv: Introduce per-cpu event ring tail
Message-ID: <ZMrwW1m65V1flOpi@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-9-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:43PM -0700, Nuno Das Neves wrote:
> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
> SynIC event ring buffer for each SINT.
> This will be used by the mshv driver, but must be tracked independently
> since the driver module could be removed and re-inserted.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

I understand the general idea, but see below.

> ---
>  drivers/hv/hv_common.c         | 25 +++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9f9c3dc89bb2..99d9b262b8a7 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -61,6 +61,16 @@ static void hv_kmsg_dump_unregister(void);
>  
>  static struct ctl_table_header *hv_ctl_table_hdr;
>  
> +/*
> + * Per-cpu array holding the tail pointer for the SynIC event ring buffer
> + * for each SINT.
> + *
> + * We cannot maintain this in mshv driver because the tail pointer should
> + * persist even if the mshv driver is unloaded.
> + */
> +u8 __percpu **hv_synic_eventring_tail;
> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -332,6 +342,8 @@ int __init hv_common_init(void)
>  	if (hv_root_partition) {
>  		hyperv_pcpu_output_arg = alloc_percpu(void *);
>  		BUG_ON(!hyperv_pcpu_output_arg);
> +		hv_synic_eventring_tail = alloc_percpu(u8 *);
> +		BUG_ON(hv_synic_eventring_tail == NULL);
>  	}
>  
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
> @@ -356,6 +368,7 @@ int __init hv_common_init(void)
>  int hv_common_cpu_init(unsigned int cpu)
>  {
>  	void **inputarg, **outputarg;
> +	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount = hv_root_partition ? 2 : 1;
> @@ -371,6 +384,14 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (hv_root_partition) {
>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> +		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> +		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
> +						flags);
> +
> +		if (unlikely(!*synic_eventring_tail)) {
> +			kfree(*inputarg);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	msr_vp_index = hv_get_register(HV_MSR_VP_INDEX);
> @@ -387,6 +408,7 @@ int hv_common_cpu_die(unsigned int cpu)
>  {
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
> +	u8 **synic_eventring_tail;
>  	void *mem;
>  
>  	local_irq_save(flags);
> @@ -398,6 +420,9 @@ int hv_common_cpu_die(unsigned int cpu)
>  	if (hv_root_partition) {
>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg = NULL;
> +		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> +		kfree(*synic_eventring_tail);
> +		*synic_eventring_tail = NULL;

The upstream code looks different now. See 9636be85cc.

>  	}
>  
>  	local_irq_restore(flags);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 0c94d20b4d44..9118d678b27a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -73,6 +73,8 @@ extern bool hv_nested;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>  
> +extern u8 __percpu **hv_synic_eventring_tail;
> +
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
> -- 
> 2.25.1
> 
