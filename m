Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652A632E51
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKUVAz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 16:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUVAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 16:00:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE18CE9DC;
        Mon, 21 Nov 2022 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669064453; x=1700600453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wjfARnG71fsJHl7savTpEsBWA10xYLnS3ZDT8xUWyJA=;
  b=Os47vSkeOYjXAig5aprJanLsfmzkfg+YmYMzcwZg+WicLl+wYIBZymJ3
   3wTiZDeH85ju7bsX7fmBpXpWrxY79TTy9DzVFNvcGIvALEFFW6uAuf0A/
   RFlancpQEis+JpZkY+Ru19xlVFFstpyBS4L2HOmXJ+VFlpZWhS3QKs3pR
   moIu7zpT7RkKX3rVQi029okiu0SrPvePZDIxftYvcRz1ymn0MwvfPbTyl
   tnZE89MhW0gJSNpJeTeEWaUO+qf2OKWMAlISLNVYQXGyPP74bELt4Dfq5
   XwC9Ivy/fX12JwNwg6F3Kel6n6+IQ5nBWLZW9EGKbeLY+x7m2nPfkypBU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313690577"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="313690577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:00:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="766101463"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="766101463"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:00:36 -0800
Message-ID: <8d3ac4ca-055a-5d54-602c-e378643ad9cd@intel.com>
Date:   Mon, 21 Nov 2022 13:00:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121195151.21812-4-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/21/22 11:51, Dexuan Cui wrote:
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +static bool tdx_enc_status_changed_for_contiguous_pages(unsigned long vaddr,
> +							int numpages, bool enc)

That naming is unfortunate.

First, it's getting way too long.

Second, you don't need two of these functions because it's contiguous or
not.  It's because tdx_enc_status_changed() only works on the direct map.

>  {
>  	phys_addr_t start = __pa(vaddr);
>  	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> @@ -798,6 +800,47 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  	return true;
>  }
>  
> +static bool tdx_enc_status_changed_for_vmalloc(unsigned long vaddr,
> +					       int numpages, bool enc)
> +{
> +	void *start_va = (void *)vaddr;
> +	void *end_va = start_va + numpages * PAGE_SIZE;
> +	phys_addr_t pa;
> +
> +	if (offset_in_page(vaddr) != 0)
> +		return false;
> +
> +	while (start_va < end_va) {
> +		pa = slow_virt_to_phys(start_va);
> +		if (!enc)
> +			pa |= cc_mkdec(0);
> +
> +		if (!tdx_map_gpa(pa, pa + PAGE_SIZE, enc))
> +			return false;
> +
> +		/*
> +		 * private->shared conversion requires only MapGPA call.
> +		 *
> +		 * For shared->private conversion, accept the page using
> +		 * TDX_ACCEPT_PAGE TDX module call.
> +		 */
> +		if (enc && !try_accept_one(&pa, PAGE_SIZE, PG_LEVEL_4K))
> +			return false;

Don't we support large vmalloc() mappings these days?

> +		start_va += PAGE_SIZE;
> +	}
> +
> +	return true;
> +}

I really don't like the copy-and-paste fork here.

I'd almost just rather have this *one* "vmalloc" copy that does
slow_virt_to_phys() on direct map addresses than have two copies.

Can you please look into making *one* function that works on either kind
of mapping?

> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +{
> +	if (is_vmalloc_addr((void *)vaddr))
> +		return tdx_enc_status_changed_for_vmalloc(vaddr, numpages, enc);
> +
> +	return tdx_enc_status_changed_for_contiguous_pages(vaddr, numpages, enc);
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	u64 cc_mask;

