Return-Path: <linux-arch+bounces-10572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23854A573AD
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE67167B28
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048D1E1DE9;
	Fri,  7 Mar 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ri9FeBsd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D921AA1D9;
	Fri,  7 Mar 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383429; cv=none; b=QpctzgZzQnUat0i9rMNnTkIbkAGUbmqxI1C/Lt1AaqBBnf30Pq8QfvuFcvgN3i+pC5aQ3i2NkuvnA95aT1NRgEGBFz3K8wA7ldFLXTt3VkHjVle0KuqERqVy1v8E4vWnMgvX1TlOhEmqKxAcMZc9fRB+XfZtf1iL5ucoxEfOyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383429; c=relaxed/simple;
	bh=6+fPZruWoV00X+dzjwJA3wJmJj0K4I2p13a8yFKwAWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVdBYkZRlRP3gdE5FhyJBuj99gdwJDTGmo/Q5JYl6tvHXh/kzrtryvWClNsvUgJovjhhMqzKEcwMDFz2lS2wBq0of6nR4CKts8W30PcIgmK06XnktfIpEvtQJZ1fgNtkkgAMbte5MSQGJ8g3G7CDxGwmaGpXDxBUZazmJjyJxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ri9FeBsd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A4072038F3B;
	Fri,  7 Mar 2025 13:37:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A4072038F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741383426;
	bh=AQn5ANn8sPdQThZDb40ZlQuiCV58eIp0gfyjJ434Q7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ri9FeBsdG2ROc74ZZVyndfL8/sgWlsUjKGFmQR0ft2q7cEBE5djWuwF6Ww5NkMOaa
	 O8OXBrORBWvVyXpqCzrNeWmckkZbq8mL9EZ0fXEJd47nUue5TWp9E35X5SwB6miF2f
	 CGgKsRXHGQy2tjtOS98IBThSjmzM1p9VmGwbcf0U=
Message-ID: <7f689725-f676-4465-974d-ca2477d445f7@linux.microsoft.com>
Date: Fri, 7 Mar 2025 13:36:48 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
To: Michael Kelley <mhklinux@outlook.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
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
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
 <5f3d660d-fe2e-4ac1-94a7-66d6c8ffe579@linux.microsoft.com>
 <2fee888a-4f81-40aa-9545-617a49a7fb30@linux.microsoft.com>
 <SN6PR02MB41579F4147561B96A2C1C057D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41579F4147561B96A2C1C057D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/2025 11:05 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, February 27, 2025 4:21 PM
>>
>> On 2/26/2025 9:56 PM, Easwar Hariharan wrote:
>>> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>>>> These non-nested msr and fast hypercall functions are present in x86,
>>>> but they must be available in both architetures for the root partition
>>>
>>> nit: *architectures*
>>>
>>>
>> Thanks!
>>
>>>> driver code.
>>>>
>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> ---
>>>>  arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
>>>>  arch/arm64/include/asm/mshyperv.h | 12 ++++++++++++
>>>>  include/asm-generic/mshyperv.h    |  2 ++
>>>>  3 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
>>>> index 69004f619c57..e33a9e3c366a 100644
>>>> --- a/arch/arm64/hyperv/hv_core.c
>>>> +++ b/arch/arm64/hyperv/hv_core.c
>>>> @@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
>>>>
>>>> +/*
>>>> + * hv_do_fast_hypercall16 -- Invoke the specified hypercall
>>>> + * with arguments in registers instead of physical memory.
>>>> + * Avoids the overhead of virt_to_phys for simple hypercalls.
>>>> + */
>>>> +u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>>>> +{
>>>> +	struct arm_smccc_res	res;
>>>> +	u64			control;
>>>> +
>>>> +	control = (u64)code | HV_HYPERCALL_FAST_BIT;
>>>> +
>>>> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
>>>> +	return res.a0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
>>>> +
>>>
>>> I'd like this to have been in arch/arm64/include/asm/mshyperv.h like its x86
>>> counterpart, but that's just my personal liking of symmetry. I see why it's here
>>> with its slow and 8-byte brethren.
>>>
>> Good point, I don't see a good reason this can't be in the header.
> 
> I was trying to remember if there was some reason I originally put
> hv_do_hypercall() and hv_do_fast_hypercall8() in the .c file instead of
> the header like on x86. But I don't remember a reason. During
> development, the code changed several times, and there might have
> been a reason that didn't persistent in the version that was finally
> accepted upstream.
> 
> My only comment is that hv_do_hypercall() and the 8 and 16 "fast"
> versions should probably stay together one place on the arm64 side,
> even if it doesn't match x86.
> 

I think I'll just keep them together here for now then. They
could be moved to the header in future if it seems worth doing.

>>
>>>>  /*
>>>>   * Set a single VP register to a 64-bit value.
>>>>   */
>>>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>>>> index 2e2f83bafcfb..2a900ba00622 100644
>>>> --- a/arch/arm64/include/asm/mshyperv.h
>>>> +++ b/arch/arm64/include/asm/mshyperv.h
>>>> @@ -40,6 +40,18 @@ static inline u64 hv_get_msr(unsigned int reg)
>>>>  	return hv_get_vpreg(reg);
>>>>  }
>>>>
>>>> +/*
>>>> + * Nested is not supported on arm64
>>>> + */
>>>> +static inline void hv_set_non_nested_msr(unsigned int reg, u64 value)
>>>> +{
>>>> +	hv_set_msr(reg, value);
>>>> +}
>>>
>>> empty line preferred here, also reported by checkpatch
>>>
>> Good point, missed that one...
>>
>>>> +static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>>> +{
>>>> +	return hv_get_msr(reg);
>>>> +}
>>>> +
>>>>  /* SMCCC hypercall parameters */
>>>>  #define HV_SMCCC_FUNC_NUMBER	1
>>>>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
>>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>>> index c020d5d0ec2a..258034dfd829 100644
>>>> --- a/include/asm-generic/mshyperv.h
>>>> +++ b/include/asm-generic/mshyperv.h
>>>> @@ -72,6 +72,8 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>>>>
>>>>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>>>>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>>>> +extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
>>>> +
>>>
>>> checkpatch warns against putting externs in header files, and FWIW, if
>> hv_do_fast_hypercall16()
>>> for arm64 were in arch/arm64/include/asm/mshyperv.h like its x86 counterpart, you
>> probably
>>> wouldn't need this?
>>>
>> Yes I wondered about that warning. That's true, if I just put it in the arm64 header
>> then this won't be needed at all, so I might just do that!
> 
> I always thought the checkpatch warning was simply that "extern" on a function
> declaration is superfluous. You can omit "extern" and nothing changes. Of
> course, the same is not true for data items.
> Good point, I think I'll clean up these "extern"s in the next version.

Nuno

> Michael
> 
>>
>>>>  bool hv_isolation_type_snp(void);
>>>>  bool hv_isolation_type_tdx(void);
>>>>
> 


