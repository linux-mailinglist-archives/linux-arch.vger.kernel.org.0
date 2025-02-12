Return-Path: <linux-arch+bounces-10137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B768A3335F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 00:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B14188B4E6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3883209F55;
	Wed, 12 Feb 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S6dRB+1X"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445D205E09;
	Wed, 12 Feb 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403028; cv=none; b=h9i7eoyFTqeso7NxB4MXcyCQWzUzvsqLYu0sEFGfepgMc7Vd0OmvSijfyl7Aiaxaj1dmVObUpmwrr9qvU/YakNm0Rd1ID6Skil/NVBszIJIBamIBMfpNcfuupPs07jVCMdQYIBRkso7CrC6J3OeShLexFY017m1JKV9DIlMhlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403028; c=relaxed/simple;
	bh=h+O34qJmo4kq5EdbtBBVzKh0xqe0FaurwgsyUwRsOoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b14sj6S2HTVxO5aNfODP9AdeVPsP1tBPSWI721GA4cyJUVMTE/2HW+S7dcQuoMsPtAn3rR+37Eqvq3gl+jmFgJXlFjWJDUaWpSB90RzhYRSgbblZcqpTyMm2IKWDPkOgVhc7cCU8jyomn/4bcBjG9DR7CPb0xShSu9whEuoZk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S6dRB+1X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2384C203F3F9;
	Wed, 12 Feb 2025 15:30:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2384C203F3F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739403026;
	bh=ODC9Ouj1/B90tnoSWW5TZSEyYIq64Wr1UQQ/C0UM2pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S6dRB+1XRlCioxY51JSTHkznizpwDYHJwxb0DwLfl0N/tYnEwFOtwl2cyqcdjBG6O
	 LdAtLK4F0c3ukaJEhpkaIF10RdopSQ9csoB6B2R/ob3Y4sJisejlYdlNcKW9oyTrpO
	 UaZNX0JPlRUlVQar8UmUX8/lBl2E1TRY5TLWO5v0=
Message-ID: <ffd59623-8e39-4bf0-9131-4984c7d7271f@linux.microsoft.com>
Date: Wed, 12 Feb 2025 15:30:25 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, daniel.lezcano@linaro.org, joro@8bytes.org,
 robin.murphy@arm.com, arnd@arndb.de, jinankjain@linux.microsoft.com,
 muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
 mukeshrathor@microsoft.com
References: <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20ba4b7c-bebb-4b1f-8c6c-4cd52a5083b5@linux.microsoft.com>
 <f7ce3ca7-e555-418d-9c88-6df379a3ec56@linux.microsoft.com>
 <3263d63d-29bb-4c5d-81cb-f37eff442fb7@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <3263d63d-29bb-4c5d-81cb-f37eff442fb7@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/2025 3:25 PM, Easwar Hariharan wrote:
> On 2/12/2025 3:01 PM, Nuno Das Neves wrote:
>> On 2/11/2025 9:47 PM, Easwar Hariharan wrote:
>>> On 2/11/2025 2:21 PM, Nuno Das Neves wrote:
>>>> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
>>>> booting and future mshv driver functionality.
>>>>
>>>> Change hv_root_partition into a function which always returns false
>>>> if CONFIG_MSHV_ROOT=n.
>>>>
>>>> Introduce hv_current_partition_type to store the type of partition
>>>> (guest, root, or other kinds in future), and hv_identify_partition_type()
>>>> to it up early in Hyper-V initialization.
>>>
>>> ...to *set* it up early?
>>>
>> Yep! Thanks for catching that
>>
>>>>
>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> ---
>>>> Depends on
>>>> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com/
>>>>
>>>>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>>>>  arch/x86/hyperv/hv_init.c          | 10 ++++----
>>>>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
>>>>  drivers/clocksource/hyperv_timer.c |  4 +--
>>>>  drivers/hv/Kconfig                 | 12 +++++++++
>>>>  drivers/hv/Makefile                |  3 ++-
>>>>  drivers/hv/hv.c                    | 10 ++++----
>>>>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
>>>>  drivers/hv/vmbus_drv.c             |  2 +-
>>>>  drivers/iommu/hyperv-iommu.c       |  4 +--
>>>>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++-----
>>>>  11 files changed, 92 insertions(+), 50 deletions(-)
>>>>
>>>
>>> <snip>
>>>
>>>> +
>>>> +void hv_identify_partition_type(void)
>>>> +{
>>>> +	/*
>>>> +	 * Check partition creation and cpu management privileges
>>>> +	 *
>>>> +	 * Hyper-V should never specify running as root and as a Confidential
>>>> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
>>>> +	 * to exploit root behavior to expose Confidential VM memory, ignore
>>>> +	 * the root partition setting if also a Confidential VM.
>>>> +	 */
>>>> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>>>> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>>>> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>>>> +		hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
>>>> +		pr_info("Hyper-V: running as root partition\n");
>>>> +	} else {
>>>> +		hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
>>>> +	}
>>>> +}
>>>
>>> This should assume GUEST as default and modify to ROOT if all the checks pass.
>>>
>> It is doing that, isn't it?
>>
>> In fact the 'else' branch here is redundant and just there for additional clarity.
>>
>> hv_current_partition_type is zeroed (so GUEST) by default, but I could make that explicit
>> if you prefer:
> 
> Yes, explicit is better, but see comment below.
> 
>> +enum hv_partition_type hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
>>
>> How does that sound? Am I misunderstanding something here?
> 
> I'd suggest centralizing that in this function, instead of having it spread in 2 places.
> Since your commit message hints at future partition types, it's ideal to have this function be
> a central clearing house, which I suppose is the intent. The preferred pattern in general, and what I'm
> suggesting, is something like this:
> 
> void hv_identify_partition_type(void)
> {
> 	/* Assume guest role */
> 	hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
> 
> 	/*
> 	 * Check partition creation and cpu management privileges
> 	 *
> 	 * Hyper-V should never specify running as root and as a Confidential
> 	 * VM. But to protect against a compromised/malicious Hyper-V trying
> 	 * to exploit root behavior to expose Confidential VM memory, ignore
> 	 * the root partition setting if also a Confidential VM.
> 	 */
> 	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> 	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> 	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> 		hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
> 		pr_info("Hyper-V: running as root partition\n");
> 	}
> }
> 
Fair enough, happy to do it this way.

>>
>>> <snip>
>>>
>>>> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>>> +{
>>>> +	return hv_result(U64_MAX);
>>>> +}
>>>
>>> Is there value in perhaps #defining hv_result_<whatever this is> as U64_MAX and returning that for documentation?
>>> For e.g. assuming this is something like EOPNOTSUPP
>>>
>>> #define HV_RESULT_NOT_SUPP U64_MAX
>>>
>>> static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>> { return hv_result(HV_RESULT_NOT_SUPP); }
>>>
>> The idea here was to copy what hv_do_hypercall does returning U64_MAX in case the hypercall
>> page is missing, which will hv_result() into an invalid status code. A special value for
>> that status could make this pattern clearer.
> 
> Agreed, having a name for that status would be helpful, but we don't want to diverge too much from the hypervisor
> definitions, especially if we're going to change it later again anyway.
> 
>> I'd want to call out that this isn't a "real"
>> Hyper-V status code somehow. HV_STATUS's are 16 bits, so it would look more like:
>>
>> /* "LINUX" because this isn't really a status from the hypervisor.. */
>> #define HV_STATUS_LINUX_FAIL 0xFFFF
>> static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> { return HV_STATUS_LINUX_FAIL; }
>>
>> Another option: there is another patch coming (which you know of) which maps hypercall
>> status codes to regular Linux errors like -EOPNOTSUPP. I could simply merge that patch
>> with this one (or make this a series for v2), and that would result in less churn.
>> (And leave alone the current use of U64_MAX in hv_do_hypercall, for now).
>>
> 
> I think that second option is a good idea. The hypervisor status should remain restricted to the functions that are
> hv_do_hypercall() or call it directly, while the rest of the code uses standard errno values. I'd suggest making
> it a series so each commit does 1 thing.
> 
Ok I'll do that, thanks.

Nuno

> Thanks,
> Easwar (he/him)


