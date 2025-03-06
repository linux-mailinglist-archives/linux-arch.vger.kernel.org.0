Return-Path: <linux-arch+bounces-10540-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9396A55532
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD99B3A7504
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785526B2C4;
	Thu,  6 Mar 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RvXAotkX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8E1DE4EC;
	Thu,  6 Mar 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286445; cv=none; b=pjUrmp3UThQRBpFubcFz/cSdRrPID0Gw9MmmbMDnAmEYyzSVs41c6ZqE4x0OCzwMeV9XiZkCoWVSwFcX8ccY4/210/ccnDHX9cgqit8Fgo6uXTQQLlB36YW9qh2HyYc29RhLpZiypoRF4tddcl4EqGOOKr42WfBNHfyXxeQCttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286445; c=relaxed/simple;
	bh=sRFO7PCYbFU0nj0ofW9VfqWOBfCazZa4ih1Upbeqg9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNz9TCLPT5IFkbSrI7yU/QG2AQN/Jhge9IeJtK4DMKER0yRZe2tJnLp63udQC6JJ0rNw74Pl2aL+OK/cBhJ/F6CIYqyATL9knGIJWzNlap+MGNDxzJuXyZxXIE+PfizMJ6ne/yAXtASv7Nkc7FhpYfudH3rfwCQai5jA67QgcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RvXAotkX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2CB2210EAFD;
	Thu,  6 Mar 2025 10:40:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2CB2210EAFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741286442;
	bh=Pt+Q7ht3AhnugEHbu9jM29WLMOV6R6cpgBm7yDdOmI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RvXAotkXsVNPl95MOg6Uq/Wny/i6873I+B2RsRJbkpebrKLzlP3l6rQlkTVLzn17I
	 q//txb2AfRgNN+XPBOkUYvbfzveUAIc50dGar7vmFW4VER6m2Rzf3dqZwCzkrQSCvH
	 QLQbPV68EWDCjrQr27ObjMSZGS38jVXIDV9lUtZk=
Message-ID: <9123b404-f6f8-464b-bad8-b793ea6fb21e@linux.microsoft.com>
Date: Thu, 6 Mar 2025 10:40:30 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
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
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41577560030C55503D1BAFDCD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157629A6197A8A6C992BB75D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157629A6197A8A6C992BB75D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/2025 10:09 AM, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, March 6, 2025 9:58 AM
> 
>>
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February
>> 26, 2025 3:08 PM
>>>
>>> Introduce hv_result_to_string() for this purpose. This allows
>>> hypercall failures to be debugged more easily with dmesg.
>>>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>>  drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
>>>  drivers/hv/hv_proc.c           | 13 ++++---
>>>  include/asm-generic/mshyperv.h |  1 +
>>>  3 files changed, 74 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>> index 9804adb4cc56..ce20818688fe 100644
>>> --- a/drivers/hv/hv_common.c
>>> +++ b/drivers/hv/hv_common.c
>>> @@ -740,3 +740,68 @@ void hv_identify_partition_type(void)
>>>  			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>>>  	}
>>>  }
>>> +
>>> +const char *hv_result_to_string(u64 hv_status)
>>> +{
>>> +	switch (hv_result(hv_status)) {
>>> +	case HV_STATUS_SUCCESS:
>>> +		return "HV_STATUS_SUCCESS";
>>> +	case HV_STATUS_INVALID_HYPERCALL_CODE:
>>> +		return "HV_STATUS_INVALID_HYPERCALL_CODE";
>>> +	case HV_STATUS_INVALID_HYPERCALL_INPUT:
>>> +		return "HV_STATUS_INVALID_HYPERCALL_INPUT";
>>> +	case HV_STATUS_INVALID_ALIGNMENT:
>>> +		return "HV_STATUS_INVALID_ALIGNMENT";
>>> +	case HV_STATUS_INVALID_PARAMETER:
>>> +		return "HV_STATUS_INVALID_PARAMETER";
>>> +	case HV_STATUS_ACCESS_DENIED:
>>> +		return "HV_STATUS_ACCESS_DENIED";
>>> +	case HV_STATUS_INVALID_PARTITION_STATE:
>>> +		return "HV_STATUS_INVALID_PARTITION_STATE";
>>> +	case HV_STATUS_OPERATION_DENIED:
>>> +		return "HV_STATUS_OPERATION_DENIED";
>>> +	case HV_STATUS_UNKNOWN_PROPERTY:
>>> +		return "HV_STATUS_UNKNOWN_PROPERTY";
>>> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
>>> +		return "HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE";
>>> +	case HV_STATUS_INSUFFICIENT_MEMORY:
>>> +		return "HV_STATUS_INSUFFICIENT_MEMORY";
>>> +	case HV_STATUS_INVALID_PARTITION_ID:
>>> +		return "HV_STATUS_INVALID_PARTITION_ID";
>>> +	case HV_STATUS_INVALID_VP_INDEX:
>>> +		return "HV_STATUS_INVALID_VP_INDEX";
>>> +	case HV_STATUS_NOT_FOUND:
>>> +		return "HV_STATUS_NOT_FOUND";
>>> +	case HV_STATUS_INVALID_PORT_ID:
>>> +		return "HV_STATUS_INVALID_PORT_ID";
>>> +	case HV_STATUS_INVALID_CONNECTION_ID:
>>> +		return "HV_STATUS_INVALID_CONNECTION_ID";
>>> +	case HV_STATUS_INSUFFICIENT_BUFFERS:
>>> +		return "HV_STATUS_INSUFFICIENT_BUFFERS";
>>> +	case HV_STATUS_NOT_ACKNOWLEDGED:
>>> +		return "HV_STATUS_NOT_ACKNOWLEDGED";
>>> +	case HV_STATUS_INVALID_VP_STATE:
>>> +		return "HV_STATUS_INVALID_VP_STATE";
>>> +	case HV_STATUS_NO_RESOURCES:
>>> +		return "HV_STATUS_NO_RESOURCES";
>>> +	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
>>> +		return "HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED";
>>> +	case HV_STATUS_INVALID_LP_INDEX:
>>> +		return "HV_STATUS_INVALID_LP_INDEX";
>>> +	case HV_STATUS_INVALID_REGISTER_VALUE:
>>> +		return "HV_STATUS_INVALID_REGISTER_VALUE";
>>> +	case HV_STATUS_OPERATION_FAILED:
>>> +		return "HV_STATUS_OPERATION_FAILED";
>>> +	case HV_STATUS_TIME_OUT:
>>> +		return "HV_STATUS_TIME_OUT";
>>> +	case HV_STATUS_CALL_PENDING:
>>> +		return "HV_STATUS_CALL_PENDING";
>>> +	case HV_STATUS_VTL_ALREADY_ENABLED:
>>> +		return "HV_STATUS_VTL_ALREADY_ENABLED";
>>> +	default:
>>> +		return "Unknown";
>>> +	};
>>> +	return "Unknown";
>>> +}
>>> +EXPORT_SYMBOL_GPL(hv_result_to_string);
>>> +
>>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>>> index 2fae18e4f7d2..8fc30f509fa7 100644
>>> --- a/drivers/hv/hv_proc.c
>>> +++ b/drivers/hv/hv_proc.c
>>> @@ -87,7 +87,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32
>>> num_pages)
>>>  				     page_count, 0, input_page, NULL);
>>>  	local_irq_restore(flags);
>>>  	if (!hv_result_success(status)) {
>>> -		pr_err("Failed to deposit pages: %lld\n", status);
>>> +		pr_err("%s: Failed to deposit pages: %s\n", __func__,
>>> +		       hv_result_to_string(status));
>>>  		ret = hv_result_to_errno(status);
>>>  		goto err_free_allocations;
>>>  	}
>>> @@ -137,8 +138,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>>>
>>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>>  			if (!hv_result_success(status)) {
>>> -				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
>>> -				       lp_index, apic_id, status);
>>> +				pr_err("%s: cpu %u apic ID %u, %s\n",
>>> +				       __func__, lp_index, apic_id,
>>> +				       hv_result_to_string(status));
>>>  				ret = hv_result_to_errno(status);
>>>  			}
>>>  			break;
>>> @@ -179,8 +181,9 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index,
>>> u32 flags)
>>>
>>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>>  			if (!hv_result_success(status)) {
>>> -				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
>>> -				       vp_index, flags, status);
>>> +				pr_err("%s: vcpu %u, lp %u, %s\n",
>>> +				       __func__, vp_index, flags,
>>> +				       hv_result_to_string(status));
>>>  				ret = hv_result_to_errno(status);
>>>  			}
>>>  			break;
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index b13b0cda4ac8..dc4729dba9ef 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -298,6 +298,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
>>>  	return __cpumask_to_vpset(vpset, cpus, func);
>>>  }
>>>
>>> +const char *hv_result_to_string(u64 hv_status);
>>>  int hv_result_to_errno(u64 status);
>>>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>>>  bool hv_is_hyperv_initialized(void);
>>> --
>>> 2.34.1
>>
>> I've read through the other comments on this patch. I definitely vote
>> for outputting both the hex code along with a string translation, which
>> could be empty if the hex code is unrecognized by the translation code.
>>
>> I can see providing something like hv_hvcall_err() as Nuno proposed, since
>> that standardizes the text output. But I wonder if it would be too limiting.
>> For example, in the changes above, both hv_call_add_logical_proc() and
>> hv_call_create_vp() output additional debugging values, which we probably
>> don't want to give up.
>>
>> Lastly, from an implementation standpoint, rather than using a big
>> switch statement, build a static array of entries that each have the
>> hex code and string equivalent. Then hv_result_to_string() loops through
>> the array looking for a match. This won't be any slower than the big switch
>> statement. I've seen other places in the kernel where string names are
>> output, and looking up the strings in a static array is the typical approach.
>> You'll have to work through the details and see if avoids being too clumsy,
>> but I think it will be OK.
>>
> 
> Better yet, also include the translated errno in each static array entry.
> Then hv_result_to_errno() can do the same kind of lookup instead of
> having its own switch statement. I did a quick look to see if the two
> functions might be combined to do only a single lookup, but that looks
> somewhat clumsy unless someone else spots a better way to handle it.
> The cost of doing two lookups doesn't really matter in an error case.
> 
> FWIW, hv_result_to_errno() and the new hv_result_to_string() are both
> slightly misnamed. The input argument is a full 64-bit hv_status, not the
> smaller 16-bit result field. hv_status_to_errno() and hv_status_to_string()
> would be more precise.
> 
Hmm, well I'll admit I was and still am rather confused on this point.

In the TLFS (section 3.8) the entire 64-bit return value is called the
"hypercall result value".
The 16-bit HV_STATUS part is *also* called the "result" in this section.
Later, in section 3.12, the 16-bit field is referred to as a "status value
field".
Furthermore, the name of the 16-bit value, itself, is HV_STATUS.

Despite the inconsistency, in my mind it makes the most sense that the
16-bit HV_STATUS part the "status" and the entire 64-bit return value the
"result". I am aware that elsewhere (and in the driver patches in this
series), the name "status" is used to refer to the entire 64-bit return
value.

These functions were actually called hv_status_to_errno() and hv_status_to_string()
in the past, but I changed them to use "result" by following my own logic, and I
thought this also matched the naming of hv_result() and hv_result_success().
However I now realize that the "result" in these names refers to the *output* of
these functions... they take a u64 status as a parameter after all..

So in the end I'm rather bothered by this whole situation. I can change these
names back to "status" (although hv_result_to_errno() is already merged, I
could send a fixup), or I could keep "result", which I think is a more
logical name for the 64-bit value, even though it somewhat contradicts how
the term is already used in the kernel.

Given it doesn't seem to be well-defined in the first place, I'm not really
sure the best route.

Nuno

> Michael


