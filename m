Return-Path: <linux-arch+bounces-10590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70FA5761C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 00:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B4B3B0073
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC520C024;
	Fri,  7 Mar 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fOGcYbIG"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C561624DC;
	Fri,  7 Mar 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390322; cv=none; b=RHsAZ1KcgSIjUcjVmuzIFVMW9kT49NIlf3r77VeDKdyIzKSpV3QyLyfRWP5Btp8m9mdTnykijGfHWo8VLMCojS8qmBcKWHKcGTjNWdqZ9KN/5Cooc0k6MWbXdF/rZvbpLo2J9Rg+XQN0QIkeFl3KUPML6jdDQIO5Y7zfD2LGgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390322; c=relaxed/simple;
	bh=ucX0RaBRa9NkjU23G2OMjxVLiU+Sz0yOllDnrB8fB4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H340w3nJDisJnWU2FTsV6rApvAOyOAAb1ouOaGhZhKvUq0x8TCcHefxn3g7eUgOsrYdqgs8fQaFVxMWXMMREO39Ze6g5CsugQMNNBvGz30YcHAqSrev3uz/A+RH/KJkn/B9dhyiTDnY/H1QT1HV2jkZTlfztOa/ptyt3EomRjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fOGcYbIG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id DFF032038F3C;
	Fri,  7 Mar 2025 15:31:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFF032038F3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741390320;
	bh=R/z26xRYrdOF9/25EAMJ8oFtAqkfyDKd66CIcFmsW4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fOGcYbIGxY0X3G24A//zVNiFIRPoiFY80LL+AXj23EOP8M+ywr+gbKdaQO/Qj+j3a
	 v3+fngnRbCZwDdvAwSMZ52LiSB13x748OSZFZCFZCvAOg45w3DT9CfSg76JZ6Lnbuc
	 NGOzo+XGsNfS5BXfJYkYq4X11bppkU8bw4mmfbsA=
Message-ID: <7de75d5a-c284-4ab8-b275-ec245608ed5c@linux.microsoft.com>
Date: Fri, 7 Mar 2025 15:31:42 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157107676CF415A464C2C25D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <63437aa6-d45a-4b7a-b222-5901c03c48e0@linux.microsoft.com>
 <SN6PR02MB415710BED37BDD375B0D769AD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415710BED37BDD375B0D769AD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/2025 3:21 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March 7, 2025 2:07 PM
>>
>> On 3/7/2025 9:02 AM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>>>
>>>> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
>>>> SynIC event ring buffer for each SINT.
>>>>
>>>> This will be used by the mshv driver, but must be tracked independently
>>>> since the driver module could be removed and re-inserted.
>>>>
>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> Reviewed-by: Wei Liu <wei.liu@kernel.org>
>>>> ---
>>>>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>>> index 252fd66ad4db..2763cb6d3678 100644
>>>> --- a/drivers/hv/hv_common.c
>>>> +++ b/drivers/hv/hv_common.c
>>>> @@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
>>>>
>>>>  static struct ctl_table_header *hv_ctl_table_hdr;
>>>>
>>>> +/*
>>>> + * Per-cpu array holding the tail pointer for the SynIC event ring buffer
>>>> + * for each SINT.
>>>> + *
>>>> + * We cannot maintain this in mshv driver because the tail pointer should
>>>> + * persist even if the mshv driver is unloaded.
>>>> + */
>>>> +u8 __percpu **hv_synic_eventring_tail;
>>>
>>> I think the "__percpu" is in the wrong place here. This placement
>>> is likely to cause errors from the "sparse" tool.  It should be
>>>
>>> u8 * __percpu *hv_synic_eventring_tail;
>>>
>>> See the way hyperv_pcpu_input_arg, for example, is defined.  And
>>> see commit db3c65bc3a13 where I fixed hyperv_pcpu_input_arg.
>>>
>> Thanks. I'll fix it.
>>
>>>> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>>>
>>> The "extern" declaration for this variable is in Patch 10 of the series
>>> in drivers/hv/mshv_root.h. I guess that's OK, but I would normally
>>> expect to find such a declaration in the header file associated with
>>> where the variable is defined, which in this case is mshyperv.h.
>>> Perhaps you are trying to restrict its usage to just mshv?
>>>
>> Yes, that's the idea - it should only be used by the driver.
>>
>>>> +
>>>>  /*
>>>>   * Hyper-V specific initialization and shutdown code that is
>>>>   * common across all architectures.  Called from architecture
>>>> @@ -90,6 +100,9 @@ void __init hv_common_free(void)
>>>>
>>>>  	free_percpu(hyperv_pcpu_input_arg);
>>>>  	hyperv_pcpu_input_arg = NULL;
>>>> +
>>>> +	free_percpu(hv_synic_eventring_tail);
>>>> +	hv_synic_eventring_tail = NULL;
>>>>  }
>>>>
>>>>  /*
>>>> @@ -372,6 +385,11 @@ int __init hv_common_init(void)
>>>>  		BUG_ON(!hyperv_pcpu_output_arg);
>>>>  	}
>>>>
>>>> +	if (hv_root_partition()) {
>>>> +		hv_synic_eventring_tail = alloc_percpu(u8 *);
>>>> +		BUG_ON(hv_synic_eventring_tail == NULL);
>>>> +	}
>>>> +
>>>>  	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
>>>>  				    GFP_KERNEL);
>>>>  	if (!hv_vp_index) {
>>>> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>>>>  int hv_common_cpu_init(unsigned int cpu)
>>>>  {
>>>>  	void **inputarg, **outputarg;
>>>> +	u8 **synic_eventring_tail;
>>>>  	u64 msr_vp_index;
>>>>  	gfp_t flags;
>>>>  	const int pgcount = hv_output_page_exists() ? 2 : 1;
>>>> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>  	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>
>>>>  	/*
>>>> -	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
>>>> -	 * allocated if this CPU was previously online and then taken offline
>>>> +	 * The per-cpu memory is already allocated if this CPU was previously
>>>> +	 * online and then taken offline
>>>>  	 */
>>>>  	if (!*inputarg) {
>>>>  		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
>>>> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>>>  		}
>>>>
>>>> +		if (hv_root_partition()) {
>>>> +			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>>>> +			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
>>>> +							sizeof(u8), flags);
>>>> +
>>>> +			if (unlikely(!*synic_eventring_tail)) {
>>>> +				kfree(mem);
>>>> +				return -ENOMEM;
>>>> +			}
>>>> +		}
>>>> +
>>>
>>> Adding this code under the "if(!*inputarg)" implicitly ties the lifecycle of
>>> synic_eventring_tail to the lifecycle of hyperv_pcpu_input_arg and
>>> hyperv_pcpu_output_arg. Is there some logical relationship between the
>>> two that warrants tying the lifecycles together (other than just both being
>>> per-cpu)?  hyperv_pcpu_input_arg and hyperv_pcpu_output_arg have an
>>> unusual lifecycle management in that they aren't freed when a CPU goes
>>> offline, as described in the comment in hv_common_cpu_die(). Does
>>> synic_eventring_tail also need that same unusual lifecycle?
>>>
>> I thought about it, and no I don't think it shares the same exact lifecycle.
>> It's only used by the mshv_root driver - it just needs to remain present
>> whenever there's a chance the module could be re-inserted and expect it to
>> be there.
>>
>>> Assuming there's no logical relationship, I'm thinking synic_eventring_tail
>>> should be managed independent of the other two. If it does need the
>>> unusual lifecycle, make sure to add a comment in hv_common_cpu_die()
>>> explaining why. If it doesn't need the unusual lifecycle, maybe just do
>>> the normal thing of allocating it in hv_common_cpu_init() and freeing
>>> it in hv_common_cpu_die().
>>>
>> Yep, I suppose it should just be freed normally then, assuming
>> hv_common_cpu_die() is only called when the hypervisor is going to reset
>> (or remove) the synic pages for this partition. Is that the case here?
>>
> 
> Yes, it is the case here. A particular vCPU can be taken offline
> independent of other vCPUs in the VM (such as by writing "0"
> to /sys/devices/system/cpu/cpu<nn>/online). When that happens
> the vCPU going offline runs hv_synic_cleanup() first, and then it
> runs hv_cpu_die(), which calls hv_common_cpu_die(). So by the
> time hv_common_cpu_die() runs, the synic_message_page and
> synic_event_page will have been unmapped and the pointers set
> to NULL.
> 
> On arm64, there is no hv_cpu_init()/die(), and the "common"
> versions are called directly. Perhaps at some point in the future there
> will be arm64 specific things to be done, and hv_cpu_init()/die()
> will need to be added. But the ordering is the same and
> hv_synic_cleanup() runs first.
> 
> So, yes, since synic_eventring_tail is tied to the synic, it sounds like
> the normal lifecycle could be used, like with the VP assist page that
> is handled in hv_cpu_init()/die() on x86.
> 
Great, thanks for the clarification! I'll fix it for v6.

Nuno

>> Otherwise we'd want to retain it, in case mshv_root ever needs it again for
>> that CPU in the lifetime of this partition.
>>
>> Nuno
>>
>>> The code as written in your patch isn't wrong and would work OK. But
>>> the structure implies a relationship with hyperv_pcpu_*_arg that I
>>> suspect doesn't exist.
>>>
>>> Michael
>>>
>>>>  		if (!ms_hyperv.paravisor_present &&
>>>>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>>>>  			ret = set_memory_decrypted((unsigned long)mem, pgcount);
>>>> --
>>>> 2.34.1
> 


