Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73C7843C7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjHVOTC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjHVOTC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 10:19:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C136CEC;
        Tue, 22 Aug 2023 07:18:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565e395e7a6so2272122a12.0;
        Tue, 22 Aug 2023 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692713932; x=1693318732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wto+R/pwAtZu+OAScHxoYW4hGhVsJhO4pIWd7518M1Q=;
        b=l5QtfNZ6Z8FTVUTOWi3QXpSmkPogCFuhWE6Z3hn5zWiR9wj7Z5Wj/ygvTdIJsr4PEq
         G7bgcyULDSd8NeCioQj7LGXJUYx5b03fi7ePwRTcgY359HeJleTzcpNeaa3OeV/URsf/
         ZAcPGhk/z+vHUYT9EawP5L/YlYGcXVkkBnHsinKGOpc1QBLgTW8Nryb+hpkFKw4V7h9v
         hbpLK5REmmyuW70S6GFX1eblaOh0iaZM+5cCCFa/yU+lxhQ3GzY5+PGuKSXo8nrWYSUS
         +M5LtPkKHeu/hCZpwzr3m1WmQLb3KiXq55AIdoEr1I88EsXnhCNud+cWBHRHtz5kdry2
         H9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713932; x=1693318732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wto+R/pwAtZu+OAScHxoYW4hGhVsJhO4pIWd7518M1Q=;
        b=GeTXgxhsPvrfsfiLLk9mE1qzhGZjUiOVxZvQmjsN3f6oRvOfBt5E8Xz7yS98YyfmpN
         AGAEDwY6+cEpP+OV9KmqwuFeb76WN1zkPDW6rK0jA/7gDz8GmYPqzL1DYj8AzXePS9hf
         pZ/Uc3yFOsfxIhVJwT2M0KYZxNpqPcqOFQ1AaLu8Zk4t75wufJKfkXLE5C8+Tb0ZRVKo
         QA24lCqddVSwy3Twi063oXoC2nv10OuUak3f/n+WRY6xygzwgtFXxDuhcpmVjtyZlgD6
         fs1QqUU0VOL6T+inOcHRL/7Eq/sec3YIZKBpUxHWwrWyIApBcSaJI6cXmQfwOffwRn/4
         Osfw==
X-Gm-Message-State: AOJu0YxhiWea3h0x0xspbAGePRaW8R9RKuOXvK0hqxd0Lp+7kSs7Jd9A
        QU+pEDYHpwSP1wo4sNUNsBg=
X-Google-Smtp-Source: AGHT+IE9KwhpwrFbIukPEqvcbgOjh7c0pPMFqq/gj/IcafR6fmndFP8nyetCpeh57XjcUBT2zkF4Wg==
X-Received: by 2002:a17:90a:f3cf:b0:268:d716:4b62 with SMTP id ha15-20020a17090af3cf00b00268d7164b62mr6502213pjb.0.1692713932406;
        Tue, 22 Aug 2023 07:18:52 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b002630c9d78aasm7839481pjl.5.2023.08.22.07.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:18:51 -0700 (PDT)
Message-ID: <c06aa27a-54b6-877b-224e-b0da615f4b55@gmail.com>
Date:   Tue, 22 Aug 2023 22:18:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/9] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX
 guests
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-2-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230811221851.10244-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/12/2023 6:18 AM, Dexuan Cui wrote:
> No logic change to SNP/VBS guests.
> 
> hv_isolation_type_tdx() will be used to instruct a TDX guest on Hyper-V to
> do some TDX-specific operations, e.g. for a fully enlightened TDX guest
> (i.e. without the paravisor), hv_do_hypercall() should use
> __tdx_hypercall() and such a guest on Hyper-V should handle the Hyper-V
> Event/Message/Monitor pages specially.
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

> ---
>   arch/x86/hyperv/ivm.c              | 9 +++++++++
>   arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
>   arch/x86/include/asm/mshyperv.h    | 3 +++
>   arch/x86/kernel/cpu/mshyperv.c     | 2 ++
>   drivers/hv/hv_common.c             | 6 ++++++
>   include/asm-generic/mshyperv.h     | 1 +
>   6 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index ee08a0cd6da38..d4aafe8b6b50d 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -524,3 +524,12 @@ bool hv_isolation_type_en_snp(void)
>   	return static_branch_unlikely(&isolation_type_en_snp);
>   }
>   
> +DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
> +/*
> + * hv_isolation_type_tdx - Check if the system runs in an Intel TDX based
> + * isolated VM.
> + */
> +bool hv_isolation_type_tdx(void)
> +{
> +	return static_branch_unlikely(&isolation_type_tdx);
> +}
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 4bf0b315b0ce9..2ff26f53cd624 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -169,7 +169,8 @@
>   enum hv_isolation_type {
>   	HV_ISOLATION_TYPE_NONE	= 0,
>   	HV_ISOLATION_TYPE_VBS	= 1,
> -	HV_ISOLATION_TYPE_SNP	= 2
> +	HV_ISOLATION_TYPE_SNP	= 2,
> +	HV_ISOLATION_TYPE_TDX	= 3
>   };
>   
>   /* Hyper-V specific model specific registers (MSRs) */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 0b0d1eb249d0a..83fc3a79f1557 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -27,6 +27,7 @@ union hv_ghcb;
>   
>   DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
>   DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
>   
>   typedef int (*hyperv_fill_flush_list_func)(
>   		struct hv_guest_mapping_flush_list *flush,
> @@ -59,6 +60,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>   int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>   
> +bool hv_isolation_type_tdx(void);
> +
>   static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>   {
>   	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index b7d73f3107c63..a50fd3650ea9b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -418,6 +418,8 @@ static void __init ms_hyperv_init_platform(void)
>   			static_branch_enable(&isolation_type_en_snp);
>   		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
>   			static_branch_enable(&isolation_type_snp);
> +		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
> +			static_branch_enable(&isolation_type_tdx);
>   		}
>   	}
>   
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2d43ba2bc925d..da3307533f4d7 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -521,6 +521,12 @@ bool __weak hv_isolation_type_en_snp(void)
>   }
>   EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
>   
> +bool __weak hv_isolation_type_tdx(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
> +
>   void __weak hv_setup_vmbus_handler(void (*handler)(void))
>   {
>   }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index efd0d2aedad39..c5e657c3cdf4c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -66,6 +66,7 @@ extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>   extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>   extern bool hv_isolation_type_snp(void);
>   extern bool hv_isolation_type_en_snp(void);
> +extern bool hv_isolation_type_tdx(void);
>   
>   /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
>   static inline int hv_result(u64 status)
