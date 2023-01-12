Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65021667973
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbjALPg5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 10:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjALPf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 10:35:56 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372303AB06;
        Thu, 12 Jan 2023 07:27:06 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4262362wml.0;
        Thu, 12 Jan 2023 07:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUAlS4xgLT+q07oikxtXjHfsLxbnxwYffAIH6pi3rgg=;
        b=WkZEQMr4gO69yvSyT9RS4DuTEmdKb1tiy/3bb4jmWhD/vC1yXVkHCTxU1lGMIcSO/i
         FKqHWsvLP0kaUvkVNNPw5nlDQPWyX/N54hnyVntI0xl8LdF9Nd6AdlV5V+nQLOnifFNb
         UkiDNhRGqcW634bAeNMNHa3TaRu0RSfWuwQC5gkKhHrZhztSj45rrB5T0lN2GCrVm1Sz
         RogDBZrIOtJaal6oLgLDtOpg9s4txc4fdf8UdM7izVvVpwuQ1lofbPMIxexHvUCPCfEd
         zHZAT2qfCcoNG/vwIkDN/WmMWdEyCD78LNrFwlp84aO/E2eI/ijSDgkoHDQNzoQfikK7
         l2qw==
X-Gm-Message-State: AFqh2kotStfWW7ViUXaRA0t8buofTpO7TzQVy07e47lZSudCvSsGOtOc
        jlXVkFV1qP9QD+eqMO5ZMew=
X-Google-Smtp-Source: AMrXdXt6Yb9atDnwfn4DCLxeXNTFRLZ2KSTrWEJF6cTR6nJ7FM3fMnCzprIygcdoPxtJM01Pd96AzQ==
X-Received: by 2002:a05:600c:1d98:b0:3d3:48f4:7a69 with SMTP id p24-20020a05600c1d9800b003d348f47a69mr66277177wms.17.1673537224581;
        Thu, 12 Jan 2023 07:27:04 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003d1f3e9df3csm28746893wmo.7.2023.01.12.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:27:04 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:27:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v10 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Message-ID: <Y8Amxh/FZITobj51@liuwe-devbox-debian-v2>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 02, 2023 at 07:12:55AM +0000, Jinank Jain wrote:
> Traditionally we have been using the HYPERVISOR_CALLBACK_VECTOR to relay
> the VMBus interrupt. But this does not work in case of nested
> hypervisor. Microsoft Hypervisor reserves 0x31 to 0x34 as the interrupt
> vector range for VMBus and thus we have to use one of the vectors from
> that range and setup the IDT accordingly.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>

I've applied all but this patch to hyperv-next.

This patch still needs an ack or nack from x86 maintainers to proceed.

Thanks,
Wei.

> ---
>  arch/x86/include/asm/idtentry.h    |  2 ++
>  arch/x86/include/asm/irq_vectors.h |  6 ++++++
>  arch/x86/kernel/cpu/mshyperv.c     | 15 +++++++++++++++
>  arch/x86/kernel/idt.c              | 10 ++++++++++
>  drivers/hv/vmbus_drv.c             |  3 ++-
>  5 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 72184b0b2219..c0648e3e4d4a 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -686,6 +686,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_INTR_NESTED_VMBUS_VECTOR,
> +			sysvec_hyperv_nested_vmbus_intr);
>  #endif
>  
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 43dcb9284208..729d19eab7f5 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -102,6 +102,12 @@
>  #if IS_ENABLED(CONFIG_HYPERV)
>  #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
>  #define HYPERV_STIMER0_VECTOR		0xed
> +/*
> + * FIXME: Change this, once Microsoft Hypervisor changes its assumption
> + * around VMBus interrupt vector allocation for nested root partition.
> + * Or provides a better interface to detect this instead of hardcoding.
> + */
> +#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31
>  #endif
>  
>  #define LOCAL_TIMER_VECTOR		0xec
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 938fc82edf05..4dfe0f9d7be3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -126,6 +126,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	set_irq_regs(old_regs);
>  }
>  
> +DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_nested_vmbus_intr)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	inc_irq_stat(irq_hv_callback_count);
> +
> +	if (vmbus_handler)
> +		vmbus_handler();
> +
> +	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
> +		ack_APIC_irq();
> +
> +	set_irq_regs(old_regs);
> +}
> +
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  	vmbus_handler = handler;
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index a58c6bc1cd68..3536935cea39 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -160,6 +160,16 @@ static const __initconst struct idt_data apic_idts[] = {
>  # endif
>  	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
>  	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
> +#ifdef CONFIG_HYPERV
> +	/*
> +	 * This is a hack because we cannot install this interrupt handler
> +	 * via alloc_intr_gate as it does not allow interrupt vector less
> +	 * than FIRST_SYSTEM_VECTORS. And hyperv does not want anything other
> +	 * than 0x31-0x34 as the interrupt vector for vmbus interrupt in case
> +	 * of nested setup.
> +	 */
> +	INTG(HYPERV_INTR_NESTED_VMBUS_VECTOR, asm_sysvec_hyperv_nested_vmbus_intr),
> +#endif
>  #endif
>  };
>  
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6324e01d5eec..740878367426 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2768,7 +2768,8 @@ static int __init hv_acpi_init(void)
>  	 * normal Linux IRQ mechanism is not used in this case.
>  	 */
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
> -	vmbus_interrupt = HYPERVISOR_CALLBACK_VECTOR;
> +	vmbus_interrupt = hv_nested ? HYPERV_INTR_NESTED_VMBUS_VECTOR :
> +				      HYPERVISOR_CALLBACK_VECTOR;
>  	vmbus_irq = -1;
>  #endif
>  
> -- 
> 2.25.1
> 
