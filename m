Return-Path: <linux-arch+bounces-10587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A7A574AE
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0610816CB85
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4278241663;
	Fri,  7 Mar 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mx6aGjtg"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8C1B042E;
	Fri,  7 Mar 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385225; cv=none; b=BYy9HzZ4a/JzdpUGLpfuF/2RCdWfu3t1RyW1JN9eWKdcQlHHplB6sCLG8yrA0OndW0X0qMPwcKQp45ZIsbbctGPA9iLWBVJJBo/cwjCfxic8k69EpDMoF/QNJwwr2rl8MpjSeG8oJiiCfVckYo0bgoiRz8Ob/GdoYzOeIL47VzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385225; c=relaxed/simple;
	bh=wbw4zZuLdJ8TPQ1CGkAz57mIWGyuK2sutPxeVgei0Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8hxsPn+H8afEsMa6hqt6DCGyruTCQAueEBHJsh5G3aQiLO2frSSSdYwvm6NWh16LdXUDBqb5NKGBxwC3Oc4Ai2pA0mAovOxl5Nisdh23xYnOfZBQhSHP8R9nhgn2sR78sVDDX/8adBWGZ9sIELw6wrGrC3xML5Tu/CxRM6U9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mx6aGjtg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 243922038F3D;
	Fri,  7 Mar 2025 14:07:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 243922038F3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741385223;
	bh=0/ocVvSH62mGuq4y8ism5h7T+7GWChnxENwL9KBqKPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mx6aGjtgGhY3S4a5G/RKkNZ9uwr1Gl6w0gRe2w8pVRKZMLMt5ZI8DpQabSoNqbfDt
	 i2iJVYB546I+8ogQYWRyMBRLGejdhO5kzKCvUgI2gBkIQSflUfRvkkKfeT7+EpEDwm
	 G02TMgwWoc8qk1n4Xompjgh6WNlpXMV5S5D3CltY=
Message-ID: <63437aa6-d45a-4b7a-b222-5901c03c48e0@linux.microsoft.com>
Date: Fri, 7 Mar 2025 14:06:46 -0800
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
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157107676CF415A464C2C25D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/2025 9:02 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>
>> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
>> SynIC event ring buffer for each SINT.
>>
>> This will be used by the mshv driver, but must be tracked independently
>> since the driver module could be removed and re-inserted.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Wei Liu <wei.liu@kernel.org>
>> ---
>>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 252fd66ad4db..2763cb6d3678 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
>>
>>  static struct ctl_table_header *hv_ctl_table_hdr;
>>
>> +/*
>> + * Per-cpu array holding the tail pointer for the SynIC event ring buffer
>> + * for each SINT.
>> + *
>> + * We cannot maintain this in mshv driver because the tail pointer should
>> + * persist even if the mshv driver is unloaded.
>> + */
>> +u8 __percpu **hv_synic_eventring_tail;
> 
> I think the "__percpu" is in the wrong place here. This placement
> is likely to cause errors from the "sparse" tool.  It should be
> 
> u8 * __percpu *hv_synic_eventring_tail;
> 
> See the way hyperv_pcpu_input_arg, for example, is defined.  And
> see commit db3c65bc3a13 where I fixed hyperv_pcpu_input_arg.
> 
Thanks. I'll fix it.

>> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
> 
> The "extern" declaration for this variable is in Patch 10 of the series
> in drivers/hv/mshv_root.h. I guess that's OK, but I would normally
> expect to find such a declaration in the header file associated with
> where the variable is defined, which in this case is mshyperv.h.
> Perhaps you are trying to restrict its usage to just mshv?
> 
Yes, that's the idea - it should only be used by the driver.

>> +
>>  /*
>>   * Hyper-V specific initialization and shutdown code that is
>>   * common across all architectures.  Called from architecture
>> @@ -90,6 +100,9 @@ void __init hv_common_free(void)
>>
>>  	free_percpu(hyperv_pcpu_input_arg);
>>  	hyperv_pcpu_input_arg = NULL;
>> +
>> +	free_percpu(hv_synic_eventring_tail);
>> +	hv_synic_eventring_tail = NULL;
>>  }
>>
>>  /*
>> @@ -372,6 +385,11 @@ int __init hv_common_init(void)
>>  		BUG_ON(!hyperv_pcpu_output_arg);
>>  	}
>>
>> +	if (hv_root_partition()) {
>> +		hv_synic_eventring_tail = alloc_percpu(u8 *);
>> +		BUG_ON(hv_synic_eventring_tail == NULL);
>> +	}
>> +
>>  	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
>>  				    GFP_KERNEL);
>>  	if (!hv_vp_index) {
>> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>>  int hv_common_cpu_init(unsigned int cpu)
>>  {
>>  	void **inputarg, **outputarg;
>> +	u8 **synic_eventring_tail;
>>  	u64 msr_vp_index;
>>  	gfp_t flags;
>>  	const int pgcount = hv_output_page_exists() ? 2 : 1;
>> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>>  	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>>
>>  	/*
>> -	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
>> -	 * allocated if this CPU was previously online and then taken offline
>> +	 * The per-cpu memory is already allocated if this CPU was previously
>> +	 * online and then taken offline
>>  	 */
>>  	if (!*inputarg) {
>>  		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
>> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>>  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>  		}
>>
>> +		if (hv_root_partition()) {
>> +			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>> +			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
>> +							sizeof(u8), flags);
>> +
>> +			if (unlikely(!*synic_eventring_tail)) {
>> +				kfree(mem);
>> +				return -ENOMEM;
>> +			}
>> +		}
>> +
> 
> Adding this code under the "if(!*inputarg)" implicitly ties the lifecycle of
> synic_eventring_tail to the lifecycle of hyperv_pcpu_input_arg and
> hyperv_pcpu_output_arg. Is there some logical relationship between the
> two that warrants tying the lifecycles together (other than just both being
> per-cpu)?  hyperv_pcpu_input_arg and hyperv_pcpu_output_arg have an
> unusual lifecycle management in that they aren't freed when a CPU goes
> offline, as described in the comment in hv_common_cpu_die(). Does
> synic_eventring_tail also need that same unusual lifecycle?
> 
I thought about it, and no I don't think it shares the same exact lifecycle.
It's only used by the mshv_root driver - it just needs to remain present
whenever there's a chance the module could be re-inserted and expect it to
be there.

> Assuming there's no logical relationship, I'm thinking synic_eventring_tail
> should be managed independent of the other two. If it does need the
> unusual lifecycle, make sure to add a comment in hv_common_cpu_die()
> explaining why. If it doesn't need the unusual lifecycle, maybe just do
> the normal thing of allocating it in hv_common_cpu_init() and freeing
> it in hv_common_cpu_die().
> 
Yep, I suppose it should just be freed normally then, assuming
hv_common_cpu_die() is only called when the hypervisor is going to reset
(or remove) the synic pages for this partition. Is that the case here?

Otherwise we'd want to retain it, in case mshv_root ever needs it again for
that CPU in the lifetime of this partition.

Nuno

> The code as written in your patch isn't wrong and would work OK. But
> the structure implies a relationship with hyperv_pcpu_*_arg that I
> suspect doesn't exist.
> 
> Michael
> 
>>  		if (!ms_hyperv.paravisor_present &&
>>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>>  			ret = set_memory_decrypted((unsigned long)mem, pgcount);
>> --
>> 2.34.1


