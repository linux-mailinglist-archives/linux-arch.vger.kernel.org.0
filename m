Return-Path: <linux-arch+bounces-10456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16972A48D77
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474F9188EC17
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737F276D3A;
	Fri, 28 Feb 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OhdMfpg6"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F50276D37;
	Fri, 28 Feb 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702834; cv=none; b=uhQTeuMzo/44n6eQu140Flb3i4fzRPArbqyDwCAVg7yswZPey6JuspBVQ0btvJf7XAxn181dL3Y8LzE/Rd19SMp2+xl6jtoNKj+gLzjr4SLpcfkHb/KNAsQQqOzvR8ISmyjLdas2IkVOWa93mTKhpchwudS15L8fFkgpnul998w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702834; c=relaxed/simple;
	bh=uSiAHFLVRv6umWTFQsiQ9R+80xHNxCFw0ORS6aNt5Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV2sixPc0qMsbPx7+SDS5P6wl+sBx2gCa29uzmNfZudV9VeV3r2lehJgLBF7P2XN5h0pLBweGrfL2Ho1Qn2fGwL/eZm/g+sXJU/Y7JibWwktY1joiom4SpGznl0A8VRJW/g0eTB/Xy0mk6239tckAiroZbO238VsgNYxA7ZgYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OhdMfpg6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id B650B210EAC1;
	Thu, 27 Feb 2025 16:33:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B650B210EAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740702832;
	bh=Gjw5PWt223rowDGBZCHjxly1p9HKhMMUyejuy/vZ6SQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhdMfpg6TnWLYiIbw4OJuQd8Wsm8rSa1YurhPYrpIe8O3euI5oQ5lJmeONznXNRxS
	 4OQzDNVRzOZ3uOPsAf+3/RyIwPBiVEdYCemBj0FQ3SG7WnpEI44kUMqPPyGKfKR8ig
	 Q/KV0deHXyad8Du90EGHDx5mjjnuwv4bfiN47SSE=
Message-ID: <b243fabe-cc96-46ea-9efc-68b0d5b379ef@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:33:51 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
 <7749367d-d87d-43f0-8c24-cd08bb4ce1a8@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <7749367d-d87d-43f0-8c24-cd08bb4ce1a8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2025 3:03 PM, Easwar Hariharan wrote:
> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>> Factor out the check for enabling auto eoi, to be reused in root
>> partition code.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/hv.c                | 12 +-----------
>>  include/asm-generic/mshyperv.h | 13 +++++++++++++
>>  2 files changed, 14 insertions(+), 11 deletions(-)
>>
> 
> <snip>
> 
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 258034dfd829..1f46d19a16aa 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -77,6 +77,19 @@ extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
>>  bool hv_isolation_type_snp(void);
>>  bool hv_isolation_type_tdx(void);
>>  
>> +/*
>> + * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
>> + * it doesn't provide a recommendation flag and AEOI must be disabled.
>> + */
>> +static inline bool hv_recommend_using_aeoi(void)
>> +{
>> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
>> +	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
> 
> I must be missing something very basic here, and if so, I apologize, and please enlighten me.
> 
> HV_DEPRECATING_AEOI_RECOMMENDED is defined as BIT(9) in include/hyperv/hvgdk_mini.h, and
> asm-generic/mshyperv.h includes that via include/hyperv/hvhdk.h.
> 
> If this is the case, when would HV_DEPRECATING_AEOI_RECOMMENDED ever be not defined?
> If it's always defined, do we need the #ifdef?
> 
HV_DEPRECATING_AEOI_RECOMMENDED is only defined on x86 (it used to live in x86 hyperv-tlfs.h).
It lives inside a #if defined(CONFIG_X86) block in hvgdk_mini.h. It is a bit confusing since
it is surrounded by other x86-only definitions which are prefixed with HV_X64_.

Thanks
Nuno

> Thanks,
> Easwar (he/him)


