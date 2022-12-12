Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69259649787
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 01:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiLLA7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 19:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLA7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 19:59:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A3BC33;
        Sun, 11 Dec 2022 16:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670806771; x=1702342771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rp5cwQfIlXuenzuD9vH1UwlvcfBSs9i5wXykNs+zb+w=;
  b=ivJjfr5vFLIoveODNiesb/ZB8hhpSKR6WgpGR36ILKDqwatACGRN1Y8A
   xsJ05Z+8ofltA1o5ym7MohPaYbhpAmGQniLKE2QcVGM7E55kEgKwxvMrQ
   yTYkzwRH4ZhCcof41cyqGn6bsvRWfgQdZVBfP78olzpcsranVo4iKaSWD
   gizr1odSrgdDZvYNufFLZg6WpdL+8A/j0qrn45jGy5RExKcvhtSG4o1Zo
   pg7LynXZJtWwa0TrmKZeAHHmlxL3Tnvb+XAU6xWFGEPaQM75saTnpmxN6
   2PhZPUYuSPtadu1F3iYJmT9v7+5m5Wb0k+hkYyRSJzvvy11HKeh6dtl03
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="318888237"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="318888237"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 16:59:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="772416824"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="772416824"
Received: from vasanth1-mobl.amr.corp.intel.com (HELO [10.251.4.160]) ([10.251.4.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 16:59:30 -0800
Message-ID: <e0a5a943-36c7-5378-0707-26cf565607d4@linux.intel.com>
Date:   Sun, 11 Dec 2022 16:59:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect
 TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@linutronix.de,
        tony.luck@intel.com, wei.liu@kernel.org, x86@kernel.org,
        mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-4-decui@microsoft.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221207003325.21503-4-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 12/6/22 4:33 PM, Dexuan Cui wrote:
> No logic change to SNP/VBS guests.
> 
> hv_isolation_type_tdx() wil be used to instruct a TDX guest on Hyper-V to
> do some TDX-specific operations, e.g. hv_do_hypercall() should use
> __tdx_hypercall(), and a TDX guest on Hyper-V should handle the Hyper-V
> Event/Message/Monitor pages specially.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Changes in v2:
>   Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
>     hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.
> 
>     Simplified the changes in ms_hyperv_init_platform().
> 
>  arch/x86/hyperv/ivm.c              | 9 +++++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
>  arch/x86/include/asm/mshyperv.h    | 3 +++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
>  drivers/hv/hv_common.c             | 6 ++++++
>  5 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 1dbcbd9da74d..13ccb52eecd7 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -269,6 +269,15 @@ bool hv_isolation_type_snp(void)
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
> +
> +bool hv_isolation_type_tdx(void)
> +{
> +	return static_branch_unlikely(&isolation_type_tdx);
> +}
> +#endif
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
> index 61f0c206bff0..8a2cafec4675 100644
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
> index 46668e255421..941372449ff2 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -339,9 +339,14 @@ static void __init ms_hyperv_init_platform(void)
>  		}
>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
>  		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> +			if (hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS ||
> +			    hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
>  				cc_set_vendor(CC_VENDOR_HYPERV);
>  		}
> +
> +		if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
> +		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
> +			static_branch_enable(&isolation_type_tdx);
>  	}
>  
>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
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
