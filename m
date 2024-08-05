Return-Path: <linux-arch+bounces-5973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04F947D47
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D01F2160F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA70155A3C;
	Mon,  5 Aug 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IN4D5riN"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5E155351;
	Mon,  5 Aug 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869629; cv=none; b=pLov2/oJc0Itq2xwZ3fUNWgbDn2LFzlq1PVdpbvtPlVYCj3Z2gmq9r6MO9de4wKfSBmCSjTJVxhsgVdAnz066kW0S2FQqrt6nl5VMcD+zpbFKmmcyuHy6dNEA+VaszVCtbi0V7n0aPe8t4W8HWjV8fQQz1pczh/5Fvvs/YyKP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869629; c=relaxed/simple;
	bh=l9GHBf5lEXBfP23Q0VoSrTlU2NIqrcb0uXRtz4Fzhfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaGuaRcXCN7n8tMiwVKY0Pq30x2jtTGlCup1qZvJ4/LRStCSFDJgjHEHKwpYEvD9CGCDeEM1qgJ7ZRyfIknSbbphRZ4VTPz1k9SnzvJN2WasfxfdHnpowjgktW9iNA89ikxpHLuXi/ZXXl8IQg9cIdUF4LSxq/5c4Jb/bkXTIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IN4D5riN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 791C720B7165;
	Mon,  5 Aug 2024 07:53:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 791C720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722869627;
	bh=IXvFEV23D3inzoK9UHnV6MZ+wdpqlZ9BXm/gNbTle7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IN4D5riNkq/m8Ez+7VFOpa+SbYTTmcw2byacu+s6unfL5coCZYaPsNjYfpA6WehQQ
	 Uuf1oq8U/XBpaU5Fh3R4Sy8bPnyDv+t2JANo0+mH7W4qbAPTDrY+rtUn+mkvq3EnNW
	 GzSNvWTcQvxuyk/9WjtFRNWJkIpqql+P5jcO7muc=
Message-ID: <e6861e7f-4cc9-4186-99cd-77ba52b30ebe@linux.microsoft.com>
Date: Mon, 5 Aug 2024 07:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
To: Wei Liu <wei.liu@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
 robh@kernel.org, tglx@linutronix.de, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
 <Zq2GGfsHjpoacdy_@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Zq2GGfsHjpoacdy_@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/2/2024 6:21 PM, Wei Liu wrote:
> On Fri, Jul 26, 2024 at 03:59:04PM -0700, Roman Kisel wrote:
>> The arm64 Hyper-V startup path relies on ACPI to detect
>> running under a Hyper-V compatible hypervisor. That
>> doesn't work on non-ACPI systems.
>>
>> Hoist the ACPI detection logic into a separate function,
>> use the new SMC added recently to Hyper-V to use in the
>> non-ACPI case.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> The change looks sensible.
> 
> Within one minor comment fixed below:
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> 
> However I would also like to get an Acked-by or reivewed-by from someone
> who works on the ARM64 side of things -- Saurabh, Boqun, Srivatsa, and
> Jinank?
> 
>> ---
>>   arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
>>   arch/arm64/include/asm/mshyperv.h |  5 +++++
>>   2 files changed, 36 insertions(+), 5 deletions(-)
>>
> [...]
>> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
>> index a975e1a689dd..a7a3586f7cb1 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>>   
>>   #include <asm-generic/mshyperv.h>
>>   
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570
> 
> Presumably these are ASCII codes for an identifier string, please
> provide comments to explain what they are.
> 
Michael posted a suggestion to change that altogether; will elaborate on 
the topic in the thread with Michael.

>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
>> +
>>   #endif
>> -- 
>> 2.34.1
>>

-- 
Thank you,
Roman


