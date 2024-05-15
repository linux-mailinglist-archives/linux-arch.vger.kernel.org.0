Return-Path: <linux-arch+bounces-4433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E78C6BE5
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D981F22C8B
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D8158DB1;
	Wed, 15 May 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="czDFgkkI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C9158DA9;
	Wed, 15 May 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796695; cv=none; b=NcBDmhCmfoCgSvXQ5fdNlnQ3tT7WyQm4zoIvJS7Bunkb52jiE6Bv5yEbl3cAs7u3AVsBQ9+OKmoDJp9xvXqga8UKFGC0r9hG12ykrF6myy+stVkTWVhKiaeCp7TNxK3IHR6YZglmzn9n4U3VOGhP/+7Wa0lt8dTWvWJT3gMoaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796695; c=relaxed/simple;
	bh=kolY4gpqxNTi/z3uoL9Ny4J6tz26tbXoHj2/11jf3So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=almQU6F8tQ4vJKmnks0d8XyMykcSmz+b4skub8UAXUIQ+HpNjvDXfR5sC52i0eG7/e298IbLOLa95ug/jXajGGqNtGEWRePxhAafyVH3MSQoIRqJ3J3GclI8G2rV79fe7dwR2iVEcmM0kO+cis7d8w/iZZb8cXdSi5kJXQq0deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=czDFgkkI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7626201F184;
	Wed, 15 May 2024 11:11:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7626201F184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715796694;
	bh=MHbsM3k9BYDPr7S4yZzl1y3oe2899Tt/+6ok7Nit0qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czDFgkkINuAcFnSu4m+Ap5N9pyy68duo4nurnPoyvlAVcY6rGyd65WojtjBWTkByu
	 aFtS8SFIEYfDnB5szxuIAqa2QNEcQgP780rvqkZBoz5XbkOH2/J5pThc/FgEf71ipS
	 ze2mc0DqPUy7Aq+rymAD6isq01PFDCl9LkerDy3Y=
Message-ID: <d758d09a-0956-4090-829b-c6bf0b0c1d4d@linux.microsoft.com>
Date: Wed, 15 May 2024 11:11:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drivers/hv: arch-neutral implementation of
 get_vtl()
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
Cc: "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-4-romank@linux.microsoft.com>
 <SN6PR02MB4157A676809A7A97313C909DD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157A676809A7A97313C909DD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 6:38 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 3:44 PM
>>
>> To run in the VTL mode, Hyper-V drivers have to know what
>> VTL the system boots in, and the arm64/hyperv code does not
>> have the means to compute that.
>>
>> Refactor the code to hoist the function that detects VTL,
>> make it arch-neutral to be able to employ it to get the VTL
>> on arm64.
> 
> Nit:  In patches that just refactor and move some code around,
> patch authors will often include a statement like "No functional
> changes" (or the slightly more doubtful "No functional changes
> intended") as a separate line at the end of the commit message.
> It's just something the reader/reviewer can cross-check against.
> 
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c          | 34 -----------------------
>>   arch/x86/include/asm/hyperv-tlfs.h |  7 -----
>>   drivers/hv/hv_common.c             | 43 ++++++++++++++++++++++++++++++
>>   include/asm-generic/hyperv-tlfs.h  |  7 +++++
>>   include/asm-generic/mshyperv.h     |  6 +++++
>>   5 files changed, 56 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 17a71e92a343..c350fa05ee59 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -413,40 +413,6 @@ static void __init hv_get_partition_id(void)
>>   	local_irq_restore(flags);
>>   }
>>
>> -#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>> -static u8 __init get_vtl(void)
>> -{
>> -	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>> -	struct hv_get_vp_registers_input *input;
>> -	struct hv_get_vp_registers_output *output;
>> -	unsigned long flags;
>> -	u64 ret;
>> -
>> -	local_irq_save(flags);
>> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	output = (struct hv_get_vp_registers_output *)input;
>> -
>> -	memset(input, 0, struct_size(input, element, 1));
>> -	input->header.partitionid = HV_PARTITION_ID_SELF;
>> -	input->header.vpindex = HV_VP_INDEX_SELF;
>> -	input->header.inputvtl = 0;
>> -	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
>> -
>> -	ret = hv_do_hypercall(control, input, output);
>> -	if (hv_result_success(ret)) {
>> -		ret = output->as64.low & HV_X64_VTL_MASK;
>> -	} else {
>> -		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>> -		BUG();
>> -	}
>> -
>> -	local_irq_restore(flags);
>> -	return ret;
>> -}
>> -#else
>> -static inline u8 get_vtl(void) { return 0; }
>> -#endif
>> -
>>   /*
>>    * This function is to be invoked early in the boot sequence after the
>>    * hypervisor has been detected.
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 3787d26810c1..9ee68eb8e6ff 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -309,13 +309,6 @@ enum hv_isolation_type {
>>   #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
>>   #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>>
>> -/*
>> - * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
>> - * there is not associated MSR address.
>> - */
>> -#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
>> -#define	HV_X64_VTL_MASK			GENMASK(3, 0)
>> -
>>   /* Hyper-V memory host visibility */
>>   enum hv_mem_host_visibility {
>>   	VMBUS_PAGE_NOT_VISIBLE		= 0,
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index dde3f9b6871a..d4cf477a4d0c 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -660,3 +660,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64
>> param2)
>>   	return HV_STATUS_INVALID_PARAMETER;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>> +
>> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>> +u8 __init get_vtl(void)
>> +{
>> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>> +	struct hv_get_vp_registers_input *input;
>> +	struct hv_get_vp_registers_output *output;
>> +	unsigned long flags;
>> +	u64 ret;
>> +
>> +	local_irq_save(flags);
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	output = (struct hv_get_vp_registers_output *)input;
> 
> I gave some bad advice on the original version of the above code.  Rather
> than allocating a separate hypercall output area, I had suggested just setting
> the hypercall output to be the same as the input area, which is done
> above.  While the overlap doesn't cause any problems for a hypercall returning
> the value of single register, the TLFS says to never set up such an overlap.
> 
> Since this code is being moved anyway, there's an opportunity to fix
> this by setting output to "input" + "struct_size(input, element, 1)".  Or
> put the output at the start of the second half of the page (note that the
> size is HY_HYP_PAGE_SIZE, not PAGE_SIZE).  The input and output for 1
> register are relatively small and both easily fit with either approach. They
> just shouldn't overlap.
> 
> Some might argue this tweak should be made in a separate patch, but
> in my judgment, it's OK to do it here if you note it in the commit
> message.  Your call.  Of course, if you make this change, my previous
> comment about "No functional changes" no longer applies. :-)
I'll update the code to adhere to the TLFS requirements, thank you :)

> 
> Michael
> 
>> +
>> +	memset(input, 0, struct_size(input, element, 1));
>> +	input->header.partitionid = HV_PARTITION_ID_SELF;
>> +	input->header.vpindex = HV_VP_INDEX_SELF;
>> +	input->header.inputvtl = 0;
>> +	input->element[0].name0 = HV_REGISTER_VSM_VP_STATUS;
>> +
>> +	ret = hv_do_hypercall(control, input, output);
>> +	if (hv_result_success(ret)) {
>> +		ret = output->as64.low & HV_VTL_MASK;
>> +	} else {
>> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>> +
>> +		/*
>> +		 * This is a dead end, something fundamental is broken.
>> +		 *
>> +		 * There is no sensible way of continuing as the Hyper-V drivers
>> +		 * transitively depend via the vmbus driver on knowing which VTL
>> +		 * they run in to establish communication with the host. The kernel
>> +		 * is going to be worse off if continued booting than a panicked one,
>> +		 * just hung and stuck, producing second-order failures, with neither
>> +		 * a way to recover nor to provide expected services.
>> +		 */
>> +		BUG();
>> +	}
>> +
>> +	local_irq_restore(flags);
>> +	return ret;
>> +}
>> +#endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 87e3d49a4e29..682bcda3124f 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -75,6 +75,13 @@
>>   /* AccessTscInvariantControls privilege */
>>   #define HV_ACCESS_TSC_INVARIANT			BIT(15)
>>
>> +/*
>> + * This synthetic register is only accessible via the HVCALL_GET_VP_REGISTERS
>> + * hvcall, and there is no an associated MSR on x86.
>> + */
>> +#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
>> +#define	HV_VTL_MASK			GENMASK(3, 0)
>> +
>>   /*
>>    * Group B features.
>>    */
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 99935779682d..ea434186d765 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -301,4 +301,10 @@ static inline enum hv_isolation_type
>> hv_get_isolation_type(void)
>>   }
>>   #endif /* CONFIG_HYPERV */
>>
>> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>> +u8 __init get_vtl(void);
>> +#else
>> +static inline u8 get_vtl(void) { return 0; }
>> +#endif
>> +
>>   #endif
>> --
>> 2.45.0
>>

-- 
Thank you,
Roman

