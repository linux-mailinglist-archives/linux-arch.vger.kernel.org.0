Return-Path: <linux-arch+bounces-6025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54322948516
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 23:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0B11F233C3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03C16C426;
	Mon,  5 Aug 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qqvFjCss"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B114A099;
	Mon,  5 Aug 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894939; cv=none; b=CAB1r5dwq9lzq4SSpWiI15Wu6M9XOApx5LfySby05tRYS08pl+MzvEp033bafKWrQF+R1DPXwToi5RLFQL09cv10GSk77Go5ZROGV7AFkcVdHN0ECmzZJLnLxxDVonQSOfcbGutKefkakaDoP5H3JzT4qQAO/kVFNgREpbH0pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894939; c=relaxed/simple;
	bh=DXbYLfLgSrqqIHrQTmgZ6iU+iz4R0x9ItApuIWwVLE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3ZafQpi5AzsXVmeqR9wul90+Gb7qNwoozwJsEwSFoDCQAxoRpniPZp76J0YAWZ8F7cFt3/62011D69CiVc89wimAlO4amanyTwEEw3UU8RSCKvUm45cjF4bYZUK9ZN8Q0LJCGPQPmrfUsxcwULAaLkvZKO8OhBCEtNP5yn4FhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qqvFjCss; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A208C20B7165;
	Mon,  5 Aug 2024 14:55:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A208C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722894937;
	bh=VJoVZsfYenFh8ZsF1uS3QBiSncBJfFtzA2OwFWvN3sU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqvFjCss8XUUuxfv0siquASw69kkQua1uyVqTAPTAGMfj4JCkT0WIiqrwX4KQ3imm
	 MPNfVEUGF6T6IEQZ1Ff2Dp5v2yuvTmXR+J777mfHV+/1LRyjz9VEMZVVMBDxMOo49w
	 bx9DnR2Lw4Bm4T1/6EsAf5ij+dvHZARCNYNDvHIY=
Message-ID: <3c10189e-4a04-4b67-9cdf-37e24e3086a5@linux.microsoft.com>
Date: Mon, 5 Aug 2024 14:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-4-romank@linux.microsoft.com>
 <SN6PR02MB415759676AEF931F030430FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8df77874-0852-4bc2-bf8d-aa7dca031736@linux.microsoft.com>
 <SN6PR02MB415780EB5A50A1AB769CA657D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415780EB5A50A1AB769CA657D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/2024 1:13 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, August 5, 2024 9:20 AM
>>
>> On 8/4/2024 8:02 PM, Michael Kelley wrote:
>>> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59
>> PM
>>>>
>>>> To run in the VTL mode, Hyper-V drivers have to know what
>>>> VTL the system boots in, and the arm64/hyperv code does not
>>>> have the means to compute that.
>>>>
>>>> Refactor the code to hoist the function that detects VTL,
>>>> make it arch-neutral to be able to employ it to get the VTL
>>>> on arm64. Fix the hypercall output address in `get_vtl(void)`
>>>> not to overlap with the hypercall input area to adhere to
>>>> the Hyper-V TLFS.
>>>>
>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>> ---
>>>>    arch/x86/hyperv/hv_init.c          | 34 ---------------------
>>>>    arch/x86/include/asm/hyperv-tlfs.h |  7 -----
>>>>    drivers/hv/hv_common.c             | 47 ++++++++++++++++++++++++++++--
>>>>    include/asm-generic/hyperv-tlfs.h  |  7 +++++
>>>>    include/asm-generic/mshyperv.h     |  6 ++++
>>>>    5 files changed, 58 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>>>> index 17a71e92a343..c350fa05ee59 100644
>>>> --- a/arch/x86/hyperv/hv_init.c
>>>> +++ b/arch/x86/hyperv/hv_init.c
>>>> @@ -413,40 +413,6 @@ static void __init hv_get_partition_id(void)
>>>>    	local_irq_restore(flags);
>>>>    }
>>>>
>>>> -#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>>> -static u8 __init get_vtl(void)
>>>> -{
>>>> -	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>>>> -	struct hv_get_vp_registers_input *input;
>>>> -	struct hv_get_vp_registers_output *output;
>>>> -	unsigned long flags;
>>>> -	u64 ret;
>>>> -
>>>> -	local_irq_save(flags);
>>>> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> -	output = (struct hv_get_vp_registers_output *)input;
>>>> -
>>>> -	memset(input, 0, struct_size(input, element, 1));
>>>> -	input->header.partitionid = HV_PARTITION_ID_SELF;
>>>> -	input->header.vpindex = HV_VP_INDEX_SELF;
>>>> -	input->header.inputvtl = 0;
>>>> -	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
>>>> -
>>>> -	ret = hv_do_hypercall(control, input, output);
>>>> -	if (hv_result_success(ret)) {
>>>> -		ret = output->as64.low & HV_X64_VTL_MASK;
>>>> -	} else {
>>>> -		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>>>> -		BUG();
>>>> -	}
>>>> -
>>>> -	local_irq_restore(flags);
>>>> -	return ret;
>>>> -}
>>>> -#else
>>>> -static inline u8 get_vtl(void) { return 0; }
>>>> -#endif
>>>> -
>>>>    /*
>>>>     * This function is to be invoked early in the boot sequence after the
>>>>     * hypervisor has been detected.
>>>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>>>> index 3787d26810c1..9ee68eb8e6ff 100644
>>>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>>>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>>>> @@ -309,13 +309,6 @@ enum hv_isolation_type {
>>>>    #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
>>>>    #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>>>>
>>>> -/*
>>>> - * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
>>>> - * there is not associated MSR address.
>>>> - */
>>>> -#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
>>>> -#define	HV_X64_VTL_MASK			GENMASK(3, 0)
>>>> -
>>>>    /* Hyper-V memory host visibility */
>>>>    enum hv_mem_host_visibility {
>>>>    	VMBUS_PAGE_NOT_VISIBLE		= 0,
>>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>>> index 9c452bfbd571..7d6c1523b0b5 100644
>>>> --- a/drivers/hv/hv_common.c
>>>> +++ b/drivers/hv/hv_common.c
>>>> @@ -339,8 +339,8 @@ int __init hv_common_init(void)
>>>>    	hyperv_pcpu_input_arg = alloc_percpu(void  *);
>>>>    	BUG_ON(!hyperv_pcpu_input_arg);
>>>>
>>>> -	/* Allocate the per-CPU state for output arg for root */
>>>> -	if (hv_root_partition) {
>>>> +	/* Allocate the per-CPU state for output arg for root or a VTL */
>>>> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>>>    		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>>>    		BUG_ON(!hyperv_pcpu_output_arg);
>>>>    	}
>>>> @@ -656,3 +656,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
>>>>    	return HV_STATUS_INVALID_PARAMETER;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>>>> +
>>>> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>>> +u8 __init get_vtl(void)
>>>> +{
>>>> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>>>> +	struct hv_get_vp_registers_input *input;
>>>> +	struct hv_get_vp_registers_output *output;
>>>> +	unsigned long flags;
>>>> +	u64 ret;
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>>
>>> Rather than use the hyperv_pcpu_output_arg here, it's OK to
>>> use a different area of the hyperv_pcpu_input_arg page.  For
>>> example,
>>>
>>> 	output = (void *)input + HV_HYP_PAGE_SIZE/2;
>>>
>>> The TLFS does not require that the input and output be in
>>> separate pages.
>>>
>>> While using the hyperv_pcpu_output_arg is conceptually a
>>> bit cleaner, doing so requires allocating a 4K page per CPU that
>>> is not otherwise used. The VTL 2 code wants to be frugal with
>>> memory, and this seems like a good step in that direction. :-)
>>>
>> I agree on the both counts: the code looks conceptually cleaner now and
>> VTL2 wants to be frugal with memory, esp that the output hypercall page
>> is per-CPU so we have O(n) as the CPU count increases. Still, the output
>> page will be needed for VTL2 (say to get/set registers just as done
>> here). That said, with this patch we can achieve both the conceptual
>> cleanliness and being ready to grow more on the primitives being built
>> out in the VTL support patches.
>>
> 
> Could you elaborate further on why the output page is needed for
> VTL2? The get/set register hypercalls can operate with just the input
> page (again, splitting it into two halves for input and output args) as
> long as the number of registers acted on by a single hypercall isn't
> more than a few dozen.
> 
> If you really *do* need the output page in VTL2 for other reasons
> that I'm not aware of, then my suggestion isn't relevant and there's
> no memory to be saved.
VTL2 might potentially use any hypercalls being in some sense an exclave 
of the hypervisor living inside the guest quite similarly to the 
VBS/VTL1/SecureKernel.

The tradeoff here would be to save a page per processor at the cost of 
specializing the hypercall issuing code that would use a part of the 
input page to save memory (quite likely limiting which hypercalls can be 
used), or use the common implementation at the cost of spending one more 
page per processor. Less code means less maintenance usually so seems 
beneficial to choose the latter option although at the cost of using 
more memory.

> 
> Michael

-- 
Thank you,
Roman


