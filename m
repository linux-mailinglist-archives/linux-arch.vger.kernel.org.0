Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540273743A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFTSbv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjFTSbt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 14:31:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEE19AD;
        Tue, 20 Jun 2023 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687285892; x=1718821892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MGK1v29PlpQ4gM+C4AVD7bAgauo2HgqlxyHUJfasklE=;
  b=JdplwFrkdpQJ9xkLf+JaDG9YL3ukiu7IIUZmpNlNg0M6dB3TE4o8QMFQ
   Mj2uWNATEqcMbD6SMYWiR6ZdiVlAQ+Q9dBcCZCbsqsAhnRbow/9LoGQF+
   A4YtSBJZ6QaevrCa8JxJki/N/BSh5QDjtN5125n6Rq6B+XqVGfNU9VxSK
   qTJR17BTo3ugfWxRmiXdpLyCc2fDRWBxuk3QGCjUG6+QtAVaau5bkUEcU
   Ac0eai/F6j20EFAebr3PUllQAcPIKNI1dCg3PGfv6/2/BIRWrE424l0PS
   0MErYx/lpvyQd9rJy5OUdSJ7KbDOj1Gm/GXjB2F3kAW+7s2plzzs6oQzh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344693992"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="344693992"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888347339"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="888347339"
Received: from oyloh-mobl.amr.corp.intel.com (HELO [10.209.25.231]) ([10.209.25.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:30:51 -0700
Message-ID: <49cb0f01-f1c2-8812-7f2f-9a70ff576085@linux.intel.com>
Date:   Tue, 20 Jun 2023 11:30:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com
References: <20230620154830.25442-1-decui@microsoft.com>
 <20230620154830.25442-2-decui@microsoft.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230620154830.25442-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/20/23 8:48 AM, Dexuan Cui wrote:
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
> 
> When a fully enlightened TDX guest runs on Hyper-V, Hyper-V can return
> the retry error when set_memory_decrypted() is called to decrypt up to
> 1GB of swiotlb bounce buffers.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
>  arch/x86/coco/tdx/tdx.c           | 63 +++++++++++++++++++++++++------
>  arch/x86/include/asm/shared/tdx.h |  2 +
>  2 files changed, 53 insertions(+), 12 deletions(-)
> 
> Changes in v2:
>   Used __tdx_hypercall() directly in tdx_map_gpa().
>   Added a max_retry_cnt of 1000.
>   Renamed a few variables, e.g., r11 -> map_fail_paddr.
> 
> Changes in v3:
>   Changed max_retry_cnt from 1000 to 3.
> 
> Changes in v4:
>   __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
>   Added Kirill's Acked-by.
> 
> Changes in v5:
>   Added Michael's Reviewed-by.
> 
> Changes in v6: None.
> 
> Changes in v7:
>   Addressed Dave's comments:
>   see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com
> 
> Changes in v8:
>   Rebased to tip.git's master branch.
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..0c198ab73aa7 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -703,14 +703,16 @@ static bool tdx_cache_flush_required(void)
>  }
>  
>  /*
> - * Inform the VMM of the guest's intent for this physical page: shared with
> - * the VMM or private to the guest.  The VMM is expected to change its mapping
> - * of the page in response.
> + * Notify the VMM about page mapping conversion. More info about ABI
> + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> + * section "TDG.VP.VMCALL<MapGPA>".
>   */
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	const int max_retries_per_page = 3;

Add some details about why you chose 3? Maybe you can also use macro for it.

> +	struct tdx_hypercall_args args;
> +	u64 map_fail_paddr, ret;
> +	int retry_count = 0;
>  
>  	if (!enc) {
>  		/* Set the shared (decrypted) bits: */
> @@ -718,12 +720,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  		end   |= cc_mkdec(0);
>  	}
>  
> -	/*
> -	 * Notify the VMM about page mapping conversion. More info about ABI
> -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> -	 * section "TDG.VP.VMCALL<MapGPA>"
> -	 */
> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +	while (retry_count < max_retries_per_page) {
> +		memset(&args, 0, sizeof(args));
> +		args.r10 = TDX_HYPERCALL_STANDARD;
> +		args.r11 = TDVMCALL_MAP_GPA;
> +		args.r12 = start;
> +		args.r13 = end - start;
> +
> +		ret = __tdx_hypercall_ret(&args);
> +		if (ret != TDVMCALL_STATUS_RETRY)
> +			return !ret;
> +		/*
> +		 * The guest must retry the operation for the pages in the
> +		 * region starting at the GPA specified in R11. R11 comes
> +		 * from the untrusted VMM. Sanity check it.
> +		 */
> +		map_fail_paddr = args.r11;

Do you really need map_fail_paddr? Why not directly use args.r11?

> +		if (map_fail_paddr < start || map_fail_paddr >= end)
> +			return false;
> +
> +		/* "Consume" a retry without forward progress */
> +		if (map_fail_paddr == start) {
> +			retry_count++;
> +			continue;
> +		}
> +
> +		start = map_fail_paddr;
> +		retry_count = 0;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Inform the VMM of the guest's intent for this physical page: shared with
> + * the VMM or private to the guest.  The VMM is expected to change its mapping
> + * of the page in response.
> + */
> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +{
> +	phys_addr_t start = __pa(vaddr);
> +	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +
> +	if (!tdx_map_gpa(start, end, enc))
>  		return false;
>  
>  	/* shared->private conversion requires memory to be accepted before use */
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 90ea813c4b99..9db89a99ae5b 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -24,6 +24,8 @@
>  #define TDVMCALL_MAP_GPA		0x10001
>  #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
>  
> +#define TDVMCALL_STATUS_RETRY		1
> +
>  #ifndef __ASSEMBLY__
>  
>  /*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
