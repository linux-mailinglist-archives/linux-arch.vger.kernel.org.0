Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6763315B
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKVAcS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 19:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKVAcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 19:32:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA55C4C12;
        Mon, 21 Nov 2022 16:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077136; x=1700613136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z/+R+/w3zQvhxn2LwrZjgbCdUX05O3tOxVPTKYj1Fao=;
  b=lmR5V34rUQWndSy1p9msp58dq6bHyV+WzstfiEvuyMNtN50s73MXNT1K
   o3CXXAZl+erfiDuyQt6qrxhS+taoYosju/WP5gENKwti1RgZLYEjIxqCM
   5agkrI1/ChtW/pz8hZ20zGGvcaHvfl8rpIF4wknc8k5lwq4HnObSBStai
   PR/rY2q8nUz62xNci1zgCkg4pnOElWwzj6H+M+7G2tTUTpK67Pf4GuGf2
   emZH+31o/wLYL/ktCZyy7JCEeBnc8wBN3l0ls8ZQz1uxC1qu7QGV8UbSA
   U4bjFenCjphaiMrTEph8A8RDJtCNtsrDM0+GcHOMYt8MSbUGYC4DMDmLE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340560334"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="340560334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:32:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="674162738"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="674162738"
Received: from dylanhol-mobl.amr.corp.intel.com (HELO [10.212.242.103]) ([10.212.242.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:32:13 -0800
Message-ID: <bad51bc6-c52e-dd71-1ee7-7f64140eadfb@linux.intel.com>
Date:   Mon, 21 Nov 2022 16:32:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX
 guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@linutronix.de,
        tony.luck@intel.com, wei.liu@kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-5-decui@microsoft.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221121195151.21812-5-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/21/22 11:51 AM, Dexuan Cui wrote:
> No logic change to SNP/VBS guests.

Add some info on how and where you are going to use this function.

> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c              |  7 +++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
>  arch/x86/include/asm/mshyperv.h    |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c     | 18 ++++++++++++++++--
>  drivers/hv/hv_common.c             |  6 ++++++
>  5 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 1dbcbd9da74d..0c219f163f71 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -269,6 +269,13 @@ bool hv_isolation_type_snp(void)
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
> +
> +bool hv_isolation_type_tdx(void)
> +{
> +	return static_branch_unlikely(&isolation_type_tdx);
> +}

Does it need #ifdef CONFIG_INTEL_TDX_GUEST? If not TDX, you can
live with weak reference.

> +
>  /*
>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>   *
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6d9368ea3701..6c0a04d078f5 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -161,7 +161,8 @@
>  enum hv_isolation_type {
>  	HV_ISOLATION_TYPE_NONE	= 0,
>  	HV_ISOLATION_TYPE_VBS	= 1,
> -	HV_ISOLATION_TYPE_SNP	= 2
> +	HV_ISOLATION_TYPE_SNP	= 2,
> +	HV_ISOLATION_TYPE_TDX	= 3
>  };
>  
>  /* Hyper-V specific model specific registers (MSRs) */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index fc09b6739922..9d593ab2be26 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -14,6 +14,7 @@
>  union hv_ghcb;
>  
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
>  
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -32,6 +33,8 @@ extern u64 hv_current_partition_id;
>  
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
> +extern bool hv_isolation_type_tdx(void);
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 831613959a92..9ad0b0abf0e0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -338,9 +338,23 @@ static void __init ms_hyperv_init_platform(void)
>  #endif
>  		}
>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
> -		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> +		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) ||
> +		    IS_ENABLED(CONFIG_INTEL_TDX_GUEST)) {
> +
> +			switch (hv_get_isolation_type()) {
> +			case HV_ISOLATION_TYPE_VBS:
> +			case HV_ISOLATION_TYPE_SNP:
>  				cc_set_vendor(CC_VENDOR_HYPERV);
> +				break;
> +
> +			case HV_ISOLATION_TYPE_TDX:
> +				static_branch_enable(&isolation_type_tdx);
> +				break;
> +

It is not clear why you need special handling for TDX?

> +			default:
> +				WARN_ON(1);
> +				break;
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ae68298c0dca..a9a03ab04b97 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -268,6 +268,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>  
> +bool __weak hv_isolation_type_tdx(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
