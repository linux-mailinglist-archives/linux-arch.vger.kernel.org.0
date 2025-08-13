Return-Path: <linux-arch+bounces-13162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4DB252F4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622F31C83E4D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA652E54D8;
	Wed, 13 Aug 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qKhTYfjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEF29B8E0;
	Wed, 13 Aug 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109331; cv=none; b=i0oco+aUghxcTcvL3XogY0iR+H6sCBHkMwjgD8YxG89R31GSMyAFk5Ffg1JCNVgox/ZRgy8PYdKXpE0f5+tfC2sAYSFuLhqdQhRaB0XaRX4FdECsBU3Qib2lKuJNjc1aeq8/CysLKnvtGudCZdQf/2gY1VKbJiMTjRcYTaTWGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109331; c=relaxed/simple;
	bh=AqU2IMFeqOxQWj657QC74iFAE/hXe6S6OPaLerga4nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYNvKwzmD/beHYB5x7JDe2CmEh7JbJyntTl8MKI8ZFogRhoYnlyHsKTes4L2Is9q8U3dSqdApMgKlIcKukr6Vt38A9/JTykBkiAVTwmalWWAeT/t3pphlt8cTGTOHGEpj/K8nKnDLyaMpo15adXCGei3b5Lt/jiFUov80sUNbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qKhTYfjX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.193.61] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E1282015E4F;
	Wed, 13 Aug 2025 11:22:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E1282015E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755109328;
	bh=t2ywwPFabVnOG15AO5jidTUL84ffRSYWWqYPwdh+S1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qKhTYfjX03HueRY03FRqUnqtfItWTFNq5PNyXPaPRDPDOD7BctBhTPCWXkTXTxgpD
	 oQKB3+gb8LLKa9MBXN4XS+aRUAtLEzHnE59nbprYmhgjbXYXFJTUQLS++TS28N1wck
	 v3kABbnnVVpwQpS2VY1xSgsW1JHcK6kBYBvMCjAU=
Message-ID: <09481080-314f-4664-96ea-e34bc35dde08@linux.microsoft.com>
Date: Wed, 13 Aug 2025 11:22:07 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] x86/hyperv: Use hv_setup_*() to set up hypercall
 arguments -- part 1
To: Wei Liu <wei.liu@kernel.org>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org,
 kw@linux.com, mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 arnd@arndb.de, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-3-mhklinux@outlook.com>
 <252e58be-4377-49b7-a572-0d40f54993d1@linux.microsoft.com>
 <aJvfMN5BhyO5Ap5m@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aJvfMN5BhyO5Ap5m@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/2025 7:41 PM, Wei Liu wrote:
> On Tue, Aug 12, 2025 at 05:22:29PM -0700, Nuno Das Neves wrote:
>> On 7/17/2025 11:55 PM, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> Update hypercall call sites to use the new hv_setup_*() functions
>>> to set up hypercall arguments. Since these functions zero the
>>> fixed portion of input memory, remove now redundant calls to memset()
>>> and explicit zero'ing of input fields.
>>>
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>>
>>> Notes:
>>>     Changes in v4:
>>>     * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
>>>     * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
>>>       [Easwar Hariharan]
>>>     
>>>     Changes in v2:
>>>     * Fixed get_vtl() and hv_vtl_apicid_to_vp_id() to properly treat the input
>>>       and output arguments as arrays [Nuno Das Neves]
>>>     * Enhanced __send_ipi_mask_ex() and hv_map_interrupt() to check the number
>>>       of computed banks in the hv_vpset against the batch_size. Since an
>>>       hv_vpset currently represents a maximum of 4096 CPUs, the hv_vpset size
>>>       does not exceed 512 bytes and there should always be sufficent space. But
>>>       do the check just in case something changes. [Nuno Das Neves]
>>>
>>
>> <snip>
>>
>>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>>> index 090f5ac9f492..87ebe43f58cf 100644
>>> --- a/arch/x86/hyperv/irqdomain.c
>>> +++ b/arch/x86/hyperv/irqdomain.c
>>> @@ -21,15 +21,15 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
>>>  	struct hv_device_interrupt_descriptor *intr_desc;
>>>  	unsigned long flags;
>>>  	u64 status;
>>> -	int nr_bank, var_size;
>>> +	int batch_size, nr_bank, var_size;
>>>  
>>>  	local_irq_save(flags);
>>>  
>>> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>> +	batch_size = hv_setup_inout_array(&input, sizeof(*input),
>>> +			sizeof(input->interrupt_descriptor.target.vp_set.bank_contents[0]),
>>> +			&output, sizeof(*output), 0);
>>>  
>>
>> Hi Michael, I finally managed to test this series on (nested) root
>> partition and encountered an issue when I applied this patch.
>>
>> With the above change, I saw HV_STATUS_INVALID_ALIGNMENT from this
>> hypercall. I printed out the addresses and sizes and everything looked
>> correct. The output seemed to be correctly placed at the end of the
>> percpu page. E.g. if input was allocated at an address ending in 0x3000,
>> output would be at 0x3ff0, because hv_output_map_device_interrupt is
>> 0x10 bytes in size.
>>
>> But it turns out, the definition for hv_output_map_device_interrupt
>> is out of date (or was never correct)! It should be:
>>
>> struct hv_output_map_device_interrupt {
>> 	struct hv_interrupt_entry interrupt_entry;
>> 	u64 extended_status_deprecated[5];
>> } __packed;
>>
>> (The "extended_status_deprecated" field is missing in the current code.)
>>
>> Due to this, when the hypervisor validates the hypercall input/output,
>> it sees that output is going across a page boundary, because it knows
>> sizeof(hv_output_map_device_interrupt) is actually 0x58.
>>
>> I confirmed that adding the "extended_status_deprecated" field fixes the
>> issue. That should be fixed either as part of this patch or an additional
>> one.
> 
> Thanks for testing this, Nuno. In that case, can you please submit a
> patch for hv_output_map_device_interrupt? That can go in via the fixes
> tree.
> 
> Thanks,
> Wei
> 

Sent the fix:
https://lore.kernel.org/linux-hyperv/1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com/T/#u

>>
>> Nuno
>>
>> PS. I have yet to test the mshv driver changes in patch 6, I'll try to
>> do so this week.
>>
>>>  	intr_desc = &input->interrupt_descriptor;
>>> -	memset(input, 0, sizeof(*input));
>>>  	input->partition_id = hv_current_partition_id;
>>>  	input->device_id = device_id.as_uint64;
>>>  	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
>>> @@ -41,7 +41,6 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
>>>  	else
>>>  		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
>>>  
>>> -	intr_desc->target.vp_set.valid_bank_mask = 0;
>>>  	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>>>  	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));
>>>  	if (nr_bank < 0) {
>>> @@ -49,6 +48,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
>>>  		pr_err("%s: unable to generate VP set\n", __func__);
>>>  		return -EINVAL;
>>>  	}
>>> +	if (nr_bank > batch_size) {
>>> +		local_irq_restore(flags);
>>> +		pr_err("%s: nr_bank too large\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>>  	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
>>>  
>>>  	/*
>>> @@ -78,9 +82,8 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
>>>  	u64 status;
>>>  
>>>  	local_irq_save(flags);
>>> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>  
>>> -	memset(input, 0, sizeof(*input));
>>> +	hv_setup_in(&input, sizeof(*input));
>>>  	intr_entry = &input->interrupt_entry;
>>>  	input->partition_id = hv_current_partition_id;
>>>  	input->device_id = id;
>>
>>


