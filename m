Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34722639EC9
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 02:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiK1BVu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 20:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1BVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 20:21:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E6FCFB;
        Sun, 27 Nov 2022 17:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669598503; x=1701134503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r61SsXAyev91uYbbkVujAH0tLH2sRDxOUT3Tk9XkWHM=;
  b=blPjvFA3XOYWkZlDoNwb7G8vdiJ4l8Z49jWEMBjwEoGVvs1xY/2eXYKm
   e/4fS2xZq7R3cvC6ulkQc49YnmX1MSHsAqpDXFjuKmEwn0MqEobuL24X2
   z0RqZaHPoTX/viyzHQJmxu8gDHhz8hd6gCHsg+TMU2o4+SNXuxQFHekuR
   qt/LBb9npUd+u2FgpyfPuesTMBekoNgPJVNHzMAkCvETCHzpYdlB4MhFm
   4J/2AgcB72TcI5TaTXzLQdq10sAVZezKEvBzdT6P8KRVAcwzQj55W+5Up
   xORAb4xjFTCJDuUj67Vk0I8ml5z9HMtGC5SDQaGyHLRDO4TUzZ+nQvgaC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="341636446"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="341636446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 17:21:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="785451126"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="785451126"
Received: from sjahmed-mobl2.amr.corp.intel.com (HELO [10.209.65.248]) ([10.209.65.248])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 17:21:41 -0800
Message-ID: <2708216c-9914-e49b-72eb-a2995ee68259@linux.intel.com>
Date:   Sun, 27 Nov 2022 17:21:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/27/22 4:58 PM, Dexuan Cui wrote:
>> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
>> Sent: Wednesday, November 23, 2022 6:45 AM
>> To: Dexuan Cui <decui@microsoft.com>; ak@linux.intel.com; arnd@arndb.de;
>>
>> Two thoughts:
>>
>> 1)  The #ifdef CONFIG_INTEL_TDX_GUEST could probably be removed
>> entirely
>> with a tweak.  hv_isolation_type_tdx() already doesn't need the #ifdef as
>> there's
>> already a stub that returns 'false'.   Then you just need a way to handle
>> __tdx_ms_hv_hypercall(), or whatever it becomes based on the other
>> discussion.
>> As long as you can provide a stub that does nothing, the #ifdef won't be
>> needed.
>>
>> 2)  Assuming that we end up with some kind of Hyper-V specific version of
>> __tdx_hypercall(), and hopefully as a "C" function, could you move the
>> handling
>> of  ms_hyperv.shared_gpa_boundary into that function?  Then you won't
>> need
>> to break out a separate include file for struct ms_hyperv.  The Hyper-V TDX
>> hypercall function must handle both normal and "fast" hypercalls, and the
>> shared_gpa_boundary adjustment is needed only for normal hypercalls,
>> but you can check the "fast" bit in the control word to decide.
>>
>> I haven't coded these ideas, so maybe there are snags I haven't thought of.
>> But I'm really hoping we can avoid having to create a separate include
>> file for struct ms_hyperv.
>>
>> Michael
> 
> Thanks for the great suggestions! Now the code looks like this:
> (the full list of v2 patches are still WIP: 
>  https://github.com/dcui/tdx/commits/decui/hyperv-next/2022-1121/v6.1-rc5/v2)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 13ccb52eecd7..00e5c84e380b 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -276,6 +276,27 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> +{
> +	struct tdx_hypercall_args args = { };

I think you mean initialize to 0.

> +
> +	if (!(control & HV_HYPERCALL_FAST_BIT)) {
> +		if (input_addr)
> +			input_addr += ms_hyperv.shared_gpa_boundary;
> +
> +		if (output_addr)
> +			output_addr += ms_hyperv.shared_gpa_boundary;
> +	}
> +
> +	args.r10 = control;
> +	args.rdx = input_addr;
> +	args.r8  = output_addr;
> +
> +	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	return args.r11;
> +}
>  #endif
>  
>  /*
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 8a2cafec4675..1be7bcf0d7d1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -39,6 +39,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>  
> +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr);
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> @@ -46,6 +48,9 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input_address, output_address);
> +
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>  
> @@ -83,6 +88,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -114,6 +122,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>  	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>  
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
