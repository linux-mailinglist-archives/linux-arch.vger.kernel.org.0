Return-Path: <linux-arch+bounces-5985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1417947F17
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CC61C21806
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4015B552;
	Mon,  5 Aug 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r6FDircP"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EC2E3E5;
	Mon,  5 Aug 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874783; cv=none; b=HxlrxdzbKoCZ8TociS44LF6lfzbTJVN0lcNjfD1NhGmf5XqYsn+36DajX87CRFM3yC321OJIOnPR7Yj4bdrgHELmptftjPd+F9tXAh2I3JHUAnDIos2pQ4j7A6oAGe7uBEnojMxEzR2nBTj4aB4zAcM8HeXRspxayfXHRzYYSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874783; c=relaxed/simple;
	bh=jE/ecRrzy84Gg1F8WWB3dmUjR5kbfyfULWcT3x+8Iso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQRYk1SfTcMYNIZbC0p2AkwqBeOZ/DFyI2oJtDl0UA6JsMh8AhEdiXJf/uEGFQ1eJ1jgBT5cZPbYQoGkMcvxBidy8NXmtVdtVdhSf4+6Obht3D2xYczighKPYCSjSg+9gv0WVn69LkYFzjs91vAkS16dnsw0phwsngkmHa0jmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r6FDircP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 67E8820B7165;
	Mon,  5 Aug 2024 09:19:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67E8820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722874781;
	bh=PnJhRU/o7zKptlxn1JF9R9grOV/DPueLnz5JS4Vzy4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6FDircPBBVCNGFeE+ojO03xhCdFnEeHq4tpakkmZQbuU8eJtxxNHCRnxQydUJ0Sx
	 g/oPY85jaPGNkgE+UK86epvicFcnoCLk4AwUS6KjueNKRxGyl5G1P7KUK/ai11n05Z
	 rXhkRDDlIN79paGXxwjOWLyetp74Tz5nZuZgS1wg=
Message-ID: <8df77874-0852-4bc2-bf8d-aa7dca031736@linux.microsoft.com>
Date: Mon, 5 Aug 2024 09:19:41 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415759676AEF931F030430FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 8:02 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
>>
>> To run in the VTL mode, Hyper-V drivers have to know what
>> VTL the system boots in, and the arm64/hyperv code does not
>> have the means to compute that.
>>
>> Refactor the code to hoist the function that detects VTL,
>> make it arch-neutral to be able to employ it to get the VTL
>> on arm64. Fix the hypercall output address in `get_vtl(void)`
>> not to overlap with the hypercall input area to adhere to
>> the Hyper-V TLFS.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c          | 34 ---------------------
>>   arch/x86/include/asm/hyperv-tlfs.h |  7 -----
>>   drivers/hv/hv_common.c             | 47 ++++++++++++++++++++++++++++--
>>   include/asm-generic/hyperv-tlfs.h  |  7 +++++
>>   include/asm-generic/mshyperv.h     |  6 ++++
>>   5 files changed, 58 insertions(+), 43 deletions(-)
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
>> index 9c452bfbd571..7d6c1523b0b5 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -339,8 +339,8 @@ int __init hv_common_init(void)
>>   	hyperv_pcpu_input_arg = alloc_percpu(void  *);
>>   	BUG_ON(!hyperv_pcpu_input_arg);
>>
>> -	/* Allocate the per-CPU state for output arg for root */
>> -	if (hv_root_partition) {
>> +	/* Allocate the per-CPU state for output arg for root or a VTL */
>> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>   		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>   		BUG_ON(!hyperv_pcpu_output_arg);
>>   	}
>> @@ -656,3 +656,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64
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
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> 
> Rather than use the hyperv_pcpu_output_arg here, it's OK to
> use a different area of the hyperv_pcpu_input_arg page.  For
> example,
> 
> 	output = (void *)input + HV_HYP_PAGE_SIZE/2;
> 
> The TLFS does not require that the input and output be in
> separate pages.
> 
> While using the hyperv_pcpu_output_arg is conceptually a
> bit cleaner, doing so requires allocating a 4K page per CPU that
> is not otherwise used. The VTL 2 code wants to be frugal with
> memory, and this seems like a good step in that direction. :-)
> 
I agree on the both counts: the code looks conceptually cleaner now and 
VTL2 wants to be frugal with memory, esp that the output hypercall page 
is per-CPU so we have O(n) as the CPU count increases. Still, the output 
page will be needed for VTL2 (say to get/set registers just as done 
here). That said, with this patch we can achieve both the conceptual 
cleanliness and being ready to grow more on the primitives being built 
out in the VTL support patches.

> The hyperv_pcpu_output_arg was added for the cases where up
> to a full page is needed for input and output on the same hypercall.
> So far, the only case of that is when running in the root partition.
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
>> index 814207e7c37f..271c365973d6 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -75,6 +75,13 @@
>>   /* AccessTscInvariantControls privilege */
>>   #define HV_ACCESS_TSC_INVARIANT			BIT(15)
>>
>> +/*
>> + * This synthetic register is only accessible via the HVCALL_GET_VP_REGISTERS
>> + * hvcall, and there is no an associated MSR on x86.
> 
> s/there is no an associated/there is no associated/
> 
Much appreciated, will fix this!

>> + */
>> +#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
>> +#define	HV_VTL_MASK			GENMASK(3, 0)
> 
> Further down in hyperv-tlfs.h is a section devoted to register
> definitions. It seems like this definition should go there in
> numeric order, which is after HV_REGISTER_STIMER0_COUNT.
> 
Agreed, will fix, thanks!

> Michael
> 
>> +
>>   /*
>>    * Group B features.
>>    */
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 8fe7aaab2599..85a5b8cb1702 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -315,4 +315,10 @@ static inline enum hv_isolation_type
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
>> 2.34.1
>>

-- 
Thank you,
Roman


