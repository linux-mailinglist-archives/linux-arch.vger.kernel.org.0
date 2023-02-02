Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99734688AA9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 00:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjBBXUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 18:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjBBXUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 18:20:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099523DA5;
        Thu,  2 Feb 2023 15:20:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y2so1389651iot.4;
        Thu, 02 Feb 2023 15:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dfZ4v62pjQj0TuluE13IPjxtTM0Id6gJo0ci9KxdmA=;
        b=mSk0WkhttHo5ynuQo5kFJSowJQ+4JgBBaP2qbuZrj070IUC1ar1kFEl70ZXWbI/rp2
         6d0cNjTNJIBYikgZhn5XyykI6n1e+X3Dg2lfYdnvfypdg8i6CVoaqIpGsLRU9sMnNT7l
         Lw/zHxulzuh3AeNos+brLrRVGelJ/Ako8UUXe8DPFcdy1j9PR+uT4Vg0DFCdu6aAzORv
         /nELtxspW7/DcHOMJIEq0d/yWWEDJuJow2YHaKT5T4D86YpEuH5NuQJ0YWRlIbMYWZbR
         gTZlVUhNF3NZLisgn8FfcARXFGThmTMTJh0+S0ZL9BOHN/Yq0/IZmaxHVbNa5K5kRUBY
         LUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dfZ4v62pjQj0TuluE13IPjxtTM0Id6gJo0ci9KxdmA=;
        b=xdjwkEJDXfqRmeD1GiF/MBjWrfu7z3LtCTY3+9DxyJVNSvhs56E6yqgBAmIgnmH1PE
         fAiSlzL39FMYoqy7CDSTIovTgSedchwt39L755Z2dWucuM//1lxlOVDrlLsOM23SmRQK
         DwB/d+haKd3GKl+G+Pf/C6VPennRCaWG4HGkKTg0Cpz+I1mWl44tJ7ppf9ecySoH7lOH
         zS5M/VF2Fo19d4kRoXVLFJ84GjudpS9Dq3WpjfNK5fPHJjalcDexEPrK9ZR2al8eaoBX
         X2nHH1tKJw0h5KBQLfADQ6yWfJMcPpcC+FserPb3J0Ct0yg7cHnXH+7r9FmxV7FuBn6i
         lJiQ==
X-Gm-Message-State: AO0yUKWU9wMc8Sj153Fc13PaKCWtulA8AJC3IexkoWYec8Fte5ukMAe+
        vL9Bq6HTYTn1HpEq1DY/0Eo=
X-Google-Smtp-Source: AK7set9H9yqaImbLa7wPdJqvlZ7WUQMNTDNrQ+nC8EOkHAJw8RFd+BdL//vXJb4KrkqYkr/kfyUeMQ==
X-Received: by 2002:a5e:aa01:0:b0:722:b5a6:bde9 with SMTP id s1-20020a5eaa01000000b00722b5a6bde9mr4451598ioe.0.1675380038382;
        Thu, 02 Feb 2023 15:20:38 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id x8-20020a6bd008000000b0071732d8a444sm281794ioa.48.2023.02.02.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:20:38 -0800 (PST)
Date:   Fri, 3 Feb 2023 01:20:28 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V3 16/16] x86/sev: Fix interrupt exit code paths
 from #HV exception
Message-ID: <20230203012028.00005ff3@gmail.com>
In-Reply-To: <20230122024607.788454-17-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
        <20230122024607.788454-17-ltykernel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 21 Jan 2023 21:46:06 -0500
Tianyu Lan <ltykernel@gmail.com> wrote:

> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Add checks in interrupt exit code paths in case of returns
> to user mode to check if currently executing the #HV handler
> then don't follow the irqentry_exit_to_user_mode path as
> that can potentially cause the #HV handler to be
> preempted and rescheduled on another CPU. Rescheduled #HV
> handler on another cpu will cause interrupts to be handled
> on a different cpu than the injected one, causing
> invalid EOIs and missed/lost guest interrupts and
> corresponding hangs and/or per-cpu IRQs handled on
> non-intended cpu.
> 

Why doesn't this problem happen in #VC handler? As #VC handler doesn't have
this special handling.

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/sev.c           | 30 +++++++++++++++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 652fea10d377..45b47132be7c 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,10 @@
>  
>  #include <asm/irq_stack.h>
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
> +#endif
> +
>  /**
>   * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>   *		      No error code pushed by hardware
> @@ -176,6 +180,7 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
>  #define DECLARE_IDTENTRY_IRQ(vector, func)				\
>  	DECLARE_IDTENTRY_ERRORCODE(vector, func)
>  
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>  /**
>   * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
>   * @func:	Function name of the entry point
> @@ -205,6 +210,26 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#else
> +
> +#define DEFINE_IDTENTRY_IRQ(func)					\
> +static void __##func(struct pt_regs *regs, u32 vector);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs,			\
> +			    unsigned long error_code)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +	u32 vector = (u32)(u8)error_code;				\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_irq_on_irqstack_cond(__##func, regs, vector);		\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#endif
>  
>  /**
>   * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
> @@ -221,6 +246,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
>  #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
>  	DECLARE_IDTENTRY(vector, func)
>  
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>  /**
>   * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>   * @func:	Function name of the entry point
> @@ -245,6 +271,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC(func)					\
> +static void __##func(struct pt_regs *regs);				\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_sysvec_on_irqstack_cond(__##func, regs);			\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs)
> +#endif
> +
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>  
>  /**
>   * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
> @@ -274,6 +320,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
> +static __always_inline void __##func(struct pt_regs *regs);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	__irq_enter_raw();						\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	__##func(regs);						\
> +	__irq_exit_raw();						\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static __always_inline void __##func(struct pt_regs *regs)
> +#endif
>  
>  /**
>   * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b1a98c2a52f8..23f15e95838b 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -147,6 +147,10 @@ struct sev_hv_doorbell_page {
>  
>  struct sev_snp_runtime_data {
>  	struct sev_hv_doorbell_page hv_doorbell_page;
> +	/*
> +	 * Indication that we are currently handling #HV events.
> +	 */
> +	bool hv_handling_events;
>  };
>  
>  static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
> @@ -200,6 +204,8 @@ static void do_exc_hv(struct pt_regs *regs)
>  	union hv_pending_events pending_events;
>  	u8 vector;
>  
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
> +
>  	while (sev_hv_pending()) {
>  		pending_events.events = xchg(
>  			&sev_snp_current_doorbell_page()->pending_events.events,
> @@ -234,6 +240,8 @@ static void do_exc_hv(struct pt_regs *regs)
>  			common_interrupt(regs, pending_events.vector);
>  		}
>  	}
> +
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
>  }
>  
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
> @@ -2529,3 +2537,25 @@ static int __init snp_init_platform_device(void)
>  	return 0;
>  }
>  device_initcall(snp_init_platform_device);
> +
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
> +{
> +	/*
> +	 * Check whether this returns to user mode, if so and if
> +	 * we are currently executing the #HV handler then we don't
> +	 * want to follow the irqentry_exit_to_user_mode path as
> +	 * that can potentially cause the #HV handler to be
> +	 * preempted and rescheduled on another CPU. Rescheduled #HV
> +	 * handler on another cpu will cause interrupts to be handled
> +	 * on a different cpu than the injected one, causing
> +	 * invalid EOIs and missed/lost guest interrupts and
> +	 * corresponding hangs and/or per-cpu IRQs handled on
> +	 * non-intended cpu.
> +	 */
> +	if (user_mode(regs) &&
> +	    this_cpu_read(snp_runtime_data)->hv_handling_events)
> +		return;
> +
> +	/* follow normal interrupt return/exit path */
> +	irqentry_exit(regs, state);
> +}

