Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579E73745D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 20:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFTSem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjFTSel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 14:34:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D410C2;
        Tue, 20 Jun 2023 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687286079; x=1718822079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7wOYvg1PU199MGs3s9q0fJPuRo9zPR+Rxyq5xsvig9s=;
  b=fNfm000NvG30KuV79I1/O/qHl7r8GxEZ5uVLVzl4dyiwLeJuqphaj5jt
   E2RVHj2Gt8WfS9XiSbpOxSJU2gQoNHAw6y4rwwQTV/1i5D3MOJ+UoycuP
   flJisCPgeOsREcG2fYcXszrq4dsS6vUiI7tzx0371FSSlXsRgA/Jjl+PI
   oq3s7chx32cO5bXFAC1EfjfMaML7aeFmqKniuvQwZwEq7+ECewTJBvSS5
   xFSuyIwc3L0O1PF77tSdlXb9cbgmUXGW5SM0lmQxO8A0mwp630nqXIe5E
   pm0E+3YOgPRU9J1AJ9YGupUmTRmWTY+towwa2So5xZr+QgmCD+XgvSf7c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340291597"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="340291597"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="960883657"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="960883657"
Received: from oyloh-mobl.amr.corp.intel.com (HELO [10.209.25.231]) ([10.209.25.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:34:18 -0700
Message-ID: <d20baf1e-a736-667f-2082-0c0539013f2b@linux.intel.com>
Date:   Tue, 20 Jun 2023 11:34:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v8 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
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
 <20230620154830.25442-3-decui@microsoft.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230620154830.25442-3-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/20/23 8:48 AM, Dexuan Cui wrote:
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.
> 
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> Changes in v2:
>   Changed tdx_enc_status_changed() in place.
> 
> Changes in v3:
>   No change since v2.
> 
> Changes in v4:
>   Added Kirill's Co-developed-by since Kirill helped to improve the
>     code by adding tdx_enc_status_changed_phys().
> 
>   Thanks Kirill for the clarification on load_unaligned_zeropad()!
> 
> Changes in v5:
>   Added Kirill's Signed-off-by.
>   Added Michael's Reviewed-by.
> 
> Changes in v6: None.
> 
> Changes in v7: None.
>   Note: there was a race between set_memory_encrypted() and
>   load_unaligned_zeropad(), which has been fixed by the 3 patches of
>   Kirill in the x86/tdx branch of the tip tree.
> 
> Changes in v8:
>   Rebased to tip.git's master branch.
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 0c198ab73aa7..a313d5ab42f1 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/mm.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
>  #include <asm/insn.h>
> @@ -752,6 +753,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>  	return false;
>  }
>  
> +static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
> +					bool enc)
> +{
> +	if (!tdx_map_gpa(start, end, enc))
> +		return false;
> +
> +	/* shared->private conversion requires memory to be accepted before use */
> +	if (enc)
> +		return tdx_accept_memory(start, end);
> +
> +	return true;
> +}
> +
>  /*
>   * Inform the VMM of the guest's intent for this physical page: shared with
>   * the VMM or private to the guest.  The VMM is expected to change its mapping
> @@ -759,15 +773,24 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>   */
>  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	unsigned long start = vaddr;
> +	unsigned long end = start + numpages * PAGE_SIZE;
>  
> -	if (!tdx_map_gpa(start, end, enc))
> +	if (offset_in_page(start) != 0)
>  		return false;
>  
> -	/* shared->private conversion requires memory to be accepted before use */
> -	if (enc)
> -		return tdx_accept_memory(start, end);
> +	if (!is_vmalloc_addr((void *)start))
> +		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
> +
> +	while (start < end) {
> +		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
> +		phys_addr_t end_pa = start_pa + PAGE_SIZE;
> +
> +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
> +			return false;
> +
> +		start += PAGE_SIZE;
> +	}
>  
>  	return true;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
