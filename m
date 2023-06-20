Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422CA7377F2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 01:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFTXeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 19:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFTXeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 19:34:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE2C170A;
        Tue, 20 Jun 2023 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687304059; x=1718840059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4p6fgptBfYm9lNriizCwBuqL8+VvZ2ABtujsr03ZCJo=;
  b=fD7GQoQNEbsu3puNr7fQohOXatF+Xve7gpetXbwWYJZHcVhUvXrt2i5r
   vcaiVXh8AAjHDKxuLaFQVK/qBh8YiR9QHvcUzolzUv5PuubFNmhacht2B
   RecZ/nBFt6UlWiz6DBzJEVihaChgPy7EUqdGwl8kQiRBTEMdp7ZCsyBUD
   FpeqkrffPIzGYxjhl/b4v/0G8PDFHDHZUoMGv2qeqBXLJc0Cm4ztkucdo
   R8CYj80455B3u8yYqOGPAA1qYZnaS1+hwpjSsgV4pY5lDBFXDCxNLCs4q
   f6ShiDW3p57XMUgRLRyRwN13iG4bJhbHlnx/ZPHqMyTcyn7SWgzjRAC5N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340352261"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340352261"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888427785"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="888427785"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO [10.255.228.28]) ([10.255.228.28])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:34:08 -0700
Message-ID: <90ff7c36-9b2e-c791-dc26-3644b9ff20df@intel.com>
Date:   Tue, 20 Jun 2023 16:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
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
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com
References: <20230620154830.25442-1-decui@microsoft.com>
 <20230620154830.25442-2-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230620154830.25442-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/20/23 08:48, Dexuan Cui wrote:
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	const int max_retries_per_page = 3;
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

What's wrong with:

	while (retry_count < max_retries_per_page) {
		struct tdx_hypercall_args args = {
			.r10 = TDX_HYPERCALL_STANDARD,
			.r11 = TDVMCALL_MAP_GPA,
			.r12 = start,
			.r13 = end - start };

?

Or maybe with the brackets slightly differently arranged.

Why'd you declare all the variables outside the while() loop anyway?
