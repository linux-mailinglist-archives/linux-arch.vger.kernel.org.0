Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C24722545
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjFEMK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFEMK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 08:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34949A1
        for <linux-arch@vger.kernel.org>; Mon,  5 Jun 2023 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685966988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyNLMEK/qC7w8l/0lvyjssmn4HLKuyG6LWu23/AEjzQ=;
        b=V/KJskOdrL0VlBfNQpI0WDJbVtIcFmH5Zilk0YUBqiKoq3Pbw0sFMIhH8QlqwYwcPFU9SG
        cwC7XiXrwCDSxtMkAz4vfdH64crtzbKiqURxHENBV0vW0RMRtsTdknysty88R1EWIb0jmU
        prjwz3vnirgj6vi+q4EuTy5vsXwJQWM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54--SWlLIW4NSG4Lsar7zWCBg-1; Mon, 05 Jun 2023 08:09:47 -0400
X-MC-Unique: -SWlLIW4NSG4Lsar7zWCBg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f6b33be156so41705241cf.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Jun 2023 05:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966987; x=1688558987;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyNLMEK/qC7w8l/0lvyjssmn4HLKuyG6LWu23/AEjzQ=;
        b=Z7RKPtZKTnAK7pcvaWlkg9poUp5CpdQwjlpP+MQX6CHMlwN4HjBjtcXkok3v1Mqf92
         B6uf3ihu+WdoGwtxtd5QPduPcKGkUJw7JlBwNda8/RqobE8jzXcKZujGpdNe5VyO1P1R
         scxoCz6Qp1YUT24sQvVHLD0rxnY4EvXaqKAGtcMlYAgipVzeORuRKWmx2h8v5eeA2jiT
         mgq2RN65gS54li7Av6Z0v4/jC0dqGYmrb5ewVPs3gR85F+6dKlREGBfWRXCfgEh9L9BD
         8C1XAX4BzA0OjuAQHdhCbmLKfKRN/G2oemuRzaVNssf1zLiCiQZfOzjc7/WzDRsqG1//
         pMiA==
X-Gm-Message-State: AC+VfDz78viwZlkE7qchkFBQEzMvWA+rg68vJ5cv5VVgayLp4gKkuHgw
        heeK2+wMAfyK0wTcm1WLrqtM90221nVnYpvdmuMQsWjeyWiqf4CbMR1tqo/mMWMgCzAWkbFt/+I
        sBc9o8y0QWLrwXnbZ1gCOmA==
X-Received: by 2002:a05:622a:1713:b0:3ea:16fe:5c9e with SMTP id h19-20020a05622a171300b003ea16fe5c9emr7465073qtk.31.1685966986767;
        Mon, 05 Jun 2023 05:09:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49GM1/r+VTRTRpsBvLDvQDvXz0N1Hz49WDrKdNHVMD16MG+7ibYjXYcnEolCvYegWF+nQHPg==
X-Received: by 2002:a05:622a:1713:b0:3ea:16fe:5c9e with SMTP id h19-20020a05622a171300b003ea16fe5c9emr7465039qtk.31.1685966986501;
        Mon, 05 Jun 2023 05:09:46 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id z23-20020ac87cb7000000b003e4c6b2cc35sm4648287qtv.24.2023.06.05.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:09:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
In-Reply-To: <20230601151624.1757616-2-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-2-ltykernel@gmail.com>
Date:   Mon, 05 Jun 2023 14:09:42 +0200
Message-ID: <874jnmkt4p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 11 +++++++++++
>  arch/x86/include/asm/mshyperv.h |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++++++--
>  drivers/hv/hv_common.c          |  6 ++++++
>  include/asm-generic/mshyperv.h  | 12 +++++++++---
>  5 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index cc92388b7a99..5d3ee3124e00 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -409,3 +409,14 @@ bool hv_isolation_type_snp(void)
>  {
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
> +
> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +/*
> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isolation enlightened VM.
> + */
> +bool hv_isolation_type_en_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_en_snp);
> +}
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 49bb4f2bd300..31c476f4e656 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -26,6 +26,7 @@
>  union hv_ghcb;
>  
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
>  
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -45,6 +46,8 @@ extern void *hv_hypercall_pg;
>  
>  extern u64 hv_current_partition_id;
>  
> +extern bool hv_isolation_type_en_snp(void);
> +
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index c7969e806c64..9186453251f7 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -402,8 +402,12 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>  
> -		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
> +
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +			static_branch_enable(&isolation_type_en_snp);
> +		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);

Nitpick: In case 'isolation_type_snp' and 'isolation_type_en_snp' are
mutually exclusive, I'd suggest we rename the former: it is quite
un-intuitive that for an enlightened SNP guest '&isolation_type_snp' is
NOT enabled. E.g. we can use

'isol_type_snp_paravisor'
and
'isol_type_snp_enlightened'

(I also don't like 'isolation_type_en_snp' name as 'en' normally stands
for 'enabled')

> +		}
>  	}
>  
>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> @@ -473,7 +477,7 @@ static void __init ms_hyperv_init_platform(void)
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
> -	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP))
> +	    ms_hyperv.paravisor_present)
>  		hv_vtom_init();
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 64f9ceca887b..179bc5f5bf52 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -502,6 +502,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>  
> +bool __weak hv_isolation_type_en_snp(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 402a8c1c202d..d444f831d633 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -36,15 +36,21 @@ struct ms_hyperv_info {
>  	u32 nested_features;
>  	u32 max_vp_index;
>  	u32 max_lp_index;
> -	u32 isolation_config_a;
> +	union {
> +		u32 isolation_config_a;
> +		struct {
> +			u32 paravisor_present : 1;
> +			u32 reserved1 : 31;
> +		};
> +	};
>  	union {
>  		u32 isolation_config_b;
>  		struct {
>  			u32 cvm_type : 4;
> -			u32 reserved1 : 1;
> +			u32 reserved2 : 1;
>  			u32 shared_gpa_boundary_active : 1;
>  			u32 shared_gpa_boundary_bits : 6;
> -			u32 reserved2 : 20;
> +			u32 reserved3 : 20;

Maybe use 'reserved_a1', 'reserved_b1', 'reserved_b2',... to avoid the
need to rename in the future when more bits from isolation_config_a get
used?

>  		};
>  	};
>  	u64 shared_gpa_boundary;

-- 
Vitaly

