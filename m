Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383E573753B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFTTo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjFTTof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 15:44:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EF1727;
        Tue, 20 Jun 2023 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687290249; x=1718826249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f+w6go31yHxWwSLI+NSniMCiVZ2yAZABHchBThsxXBo=;
  b=m3YCqcyxsES9cy5IidULcMU5tezC1C0e5MevCDQ/w4gTNbjcyEgqxMtp
   ejeizZW3H8Gk24Bw6UzZ9mLoAA9O2v10QOfN1vPF/06K2ve2N2bvo0mg8
   tihofQ6oDN2No3WDk14yZ3SYBWz+McYlYF2TJ2NbGf551qOLWngC/ZW0J
   0jDZ92acKJTL4m0bw7yIeTUAYHe+ob0MhXJy7A0NG/9xBkOs2hV00paXg
   c1irsbjIMcB/hLI/f4G1uJrnkF53NDf4tYHhFi4qOlEBrd9VEYAAuUaAY
   Xoki/FzD3KAWCdgDtiIlUrSft3zd+52B47bB4mS6YbynBGgWrG6yHKAZy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344710193"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="344710193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 12:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888366294"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="888366294"
Received: from oyloh-mobl.amr.corp.intel.com (HELO [10.209.25.231]) ([10.209.25.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 12:44:06 -0700
Message-ID: <17ea653f-215d-0bd4-e8b0-5188e5a5ffbd@linux.intel.com>
Date:   Tue, 20 Jun 2023 12:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
References: <20230620154830.25442-1-decui@microsoft.com>
 <20230620154830.25442-2-decui@microsoft.com>
 <49cb0f01-f1c2-8812-7f2f-9a70ff576085@linux.intel.com>
 <SA1PR21MB13359EB1A88FC676C2269318BF5CA@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SA1PR21MB13359EB1A88FC676C2269318BF5CA@SA1PR21MB1335.namprd21.prod.outlook.com>
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

On 6/20/23 12:23 PM, Dexuan Cui wrote:
>> From: Sathyanarayanan Kuppuswamy
>> Sent: Tuesday, June 20, 2023 11:31 AM
>>> ...
>>> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
>> bool enc)
>>> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>>>  {
>>> -	phys_addr_t start = __pa(vaddr);
>>> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
>>> +	const int max_retries_per_page = 3;
>>
>> Add some details about why you chose 3? Maybe you can also use macro for it.
> 
> It's a small number recommended by Kirill:
> https://lwn.net/ml/linux-kernel/20221208194800.n27ak4xj6pmyny46@box.shutemov.name/
> 
> The spec doesn't define a max retry count. Normally I guess a max retry count
> of 2 should be enough, at least for Hyper-V according to my testing.
> 
> Maybe we can add a comment like this:
> 
> /* Retrying the hypercall a second time should succeed; use 3 just in case. */
> 
> Does this look good to all?

Looks fine to me.

> 
>>> +	struct tdx_hypercall_args args;
>>> +	u64 map_fail_paddr, ret;
>>> +	int retry_count = 0;
>>>
>>>  	if (!enc) {
>>>  		/* Set the shared (decrypted) bits: */
>>> @@ -718,12 +720,49 @@ static bool tdx_enc_status_changed(unsigned long
>> vaddr, int numpages, bool enc)
>>>  		end   |= cc_mkdec(0);
>>>  	}
>>>
>>> -	/*
>>> -	 * Notify the VMM about page mapping conversion. More info about ABI
>>> -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
>>> -	 * section "TDG.VP.VMCALL<MapGPA>"
>>> -	 */
>>> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
>>> +	while (retry_count < max_retries_per_page) {
>>> +		memset(&args, 0, sizeof(args));
>>> +		args.r10 = TDX_HYPERCALL_STANDARD;
>>> +		args.r11 = TDVMCALL_MAP_GPA;
>>> +		args.r12 = start;
>>> +		args.r13 = end - start;
>>> +
>>> +		ret = __tdx_hypercall_ret(&args);
>>> +		if (ret != TDVMCALL_STATUS_RETRY)
>>> +			return !ret;
>>> +		/*
>>> +		 * The guest must retry the operation for the pages in the
>>> +		 * region starting at the GPA specified in R11. R11 comes
>>> +		 * from the untrusted VMM. Sanity check it.
>>> +		 */
>>> +		map_fail_paddr = args.r11;
>>
>> Do you really need map_fail_paddr? Why not directly use args.r11?
>>
>>> +		if (map_fail_paddr < start || map_fail_paddr >= end)
>>> +			return false;
> 
> Originally, I used r11. 
> 
> Dave says " 'r11' needs a real, logical name":
> https://lwn.net/ml/linux-kernel/6bb65614-d420-49d3-312f-316dc8ca4cc4@intel.com/

Got it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
