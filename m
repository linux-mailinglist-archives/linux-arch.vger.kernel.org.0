Return-Path: <linux-arch+bounces-10457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6985A48D8A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8CF16DFAD
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D4276D36;
	Fri, 28 Feb 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dp4k76aS"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB654C91;
	Fri, 28 Feb 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703792; cv=none; b=q6Ac4utC8MuPVRXws6LWfJ8wdX9tX5BlhRhZQYpC9A+2epVgQHwrjQBsCnDV/TcFwgJ+cY3egzwu2j0nmmL43jjWZq3DZAz9kRqcYNbN1o8xEXHUFopolyu1cwZc3KuQhictXqcyu77h4mSpq7Nu0fc8H9hGNwRZeJ8RddWLU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703792; c=relaxed/simple;
	bh=RZOZhKZG97cc3kiuh/tSMwsvbhs2LaEXa504/fIDzag=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qK9nSIG/RypaA7myZ19Xdui3lAUSx1JFJFMM+uuISr6ZpJqYsUjEhhIaFcQPja6v82S65Y8kJ2vSVtHcAFispvujFDYjkM2G/boaHeMEmhd7hf3p2Il7ojQ0Mk0rZaW0VYsS+2jUs07/KyoAk+iYtiIXTFvsD7oywcxaMxKwGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dp4k76aS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id E62E0210EAC0;
	Thu, 27 Feb 2025 16:49:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E62E0210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740703791;
	bh=IeG+L7E6vDHSVo89AbkHHb4yGQsBoZrk+/JOHuRUWmk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Dp4k76aSEZqb6H3+dvFgTwwZRo4thgbYprD3kCbGuLWdX84AVVpbmoIW9R9cc/MJC
	 c2h2/nX/mor1D1qXiM3EHVMVfGzckNut8HcRMHBaoEseJ9v8JXPURG4QlrYM5RB7mO
	 CHOCamiMpBDkgF62+jVdA8A0oVR4RMcZD64bdz8k=
Message-ID: <57426824-5302-4200-8560-8eb67be6b378@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:49:48 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-acpi@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
 <7749367d-d87d-43f0-8c24-cd08bb4ce1a8@linux.microsoft.com>
 <b243fabe-cc96-46ea-9efc-68b0d5b379ef@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b243fabe-cc96-46ea-9efc-68b0d5b379ef@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2025 4:33 PM, Nuno Das Neves wrote:
> On 2/27/2025 3:03 PM, Easwar Hariharan wrote:
>> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>>> Factor out the check for enabling auto eoi, to be reused in root
>>> partition code.
>>>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>>  drivers/hv/hv.c                | 12 +-----------
>>>  include/asm-generic/mshyperv.h | 13 +++++++++++++
>>>  2 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index 258034dfd829..1f46d19a16aa 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -77,6 +77,19 @@ extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
>>>  bool hv_isolation_type_snp(void);
>>>  bool hv_isolation_type_tdx(void);
>>>  
>>> +/*
>>> + * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>>> + * it doesn't provide a recommendation flag and AEOI must be disabled.
>>> + */
>>> +static inline bool hv_recommend_using_aeoi(void)
>>> +{
>>> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
>>> +	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
>>> +#else
>>> +	return false;
>>> +#endif
>>> +}
>>> +
>>
>> I must be missing something very basic here, and if so, I apologize, and please enlighten me.
>>
>> HV_DEPRECATING_AEOI_RECOMMENDED is defined as BIT(9) in include/hyperv/hvgdk_mini.h, and
>> asm-generic/mshyperv.h includes that via include/hyperv/hvhdk.h.
>>
>> If this is the case, when would HV_DEPRECATING_AEOI_RECOMMENDED ever be not defined?
>> If it's always defined, do we need the #ifdef?
>>
> HV_DEPRECATING_AEOI_RECOMMENDED is only defined on x86 (it used to live in x86 hyperv-tlfs.h).
> It lives inside a #if defined(CONFIG_X86) block in hvgdk_mini.h. It is a bit confusing since
> it is surrounded by other x86-only definitions which are prefixed with HV_X64_.
> 

Ah, thank you. I knew it must be something glaringly obvious in hindsight. With that resolved,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

