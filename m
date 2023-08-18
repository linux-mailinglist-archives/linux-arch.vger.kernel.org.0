Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07A780DD2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbjHROSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377063AbjHROSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 10:18:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBCD272D;
        Fri, 18 Aug 2023 07:18:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68876bbecb6so793771b3a.1;
        Fri, 18 Aug 2023 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692368301; x=1692973101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wto+R/pwAtZu+OAScHxoYW4hGhVsJhO4pIWd7518M1Q=;
        b=NQVm83i98ZzuOj2BhRjWble1dNvZrqknPQJkoLmHMwXPzUxZRPjQF8eq93c8VLJ7wB
         6FSP8DFD/5nNFjm9iOwXMJkPqisEV5SImdGQsGXg3/qOHAHPKGZuPFPlb019kamxNQFa
         LdKOtReh3/h+vtq4IGDNquO7CUfkO1sDx0HcxSappv6a2cJujIK38X8x5eMKZ1Oe+BzV
         GhCtezyVSNOVIGR0ndnrB7XdRwEXakfhL4pzbTB0nND7KAyojamAtc4PfYJxLaKvp7ad
         Ife3aeYVAByH+zmsMEJgLbwDT9LLIamlFbSjjUkYx9cNDo6/vL2cEm4lF5ARk2Xn9abC
         QaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368301; x=1692973101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wto+R/pwAtZu+OAScHxoYW4hGhVsJhO4pIWd7518M1Q=;
        b=LUOiNJQKntxd9VDk8v9Zam8HOnlvuHqd3Uq6/9E2XiEHQF4e4ClvUYXzY9rfxnStF8
         Dks+AzXBzFAZ7+YGVRIh87AUz2MmuWtSpp0Hr/LCJWw1Rr5czHRm9SUj4CI+oxsMcAHN
         KYc+lIE/iJOgCehWuMkppcDr2Ydsne9dA3BPonpe0PXBsdUDGWigxweIlXyp8XQdSTLz
         SM8DjNhvt02XevgcQCJMSEl+QgJX0N8EVV3/zFcP/rcIzWjr5HWr32TLYQYChENRMXjO
         cuBo/pw7SYdwxbA3e5tc5+t+KG5pSRsXJHZfDzLchgmcw6BjFDWkejqgb6DVvAWO4wUm
         A0Qg==
X-Gm-Message-State: AOJu0Yx3f5yVfhQGW3bXdf0VmYZsKUUyBE+5Dya4jq5VmIxbcySOrGDL
        su8WH0bex8gea89f7L+1UDQ=
X-Google-Smtp-Source: AGHT+IF2M4SN/IAWkX2sMfsEtmmJM2jFqdHT71yWDhNzW8tK7ucEp8RvNg9VKal3iMdsahGH8WHhzw==
X-Received: by 2002:a05:6a00:1952:b0:671:4b06:4ea7 with SMTP id s18-20020a056a00195200b006714b064ea7mr2856335pfk.15.1692368300583;
        Fri, 18 Aug 2023 07:18:20 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id j22-20020aa79296000000b0068709861cb6sm1583877pfa.137.2023.08.18.07.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:18:20 -0700 (PDT)
Message-ID: <0012002e-5f4d-5687-f2f7-7ad792ed053f@gmail.com>
Date:   Fri, 18 Aug 2023 22:18:09 +0800
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
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
