Return-Path: <linux-arch+bounces-6024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555759484FD
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ECC1F20B66
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12D16B386;
	Mon,  5 Aug 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BqLnGLWX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665114B07C;
	Mon,  5 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894259; cv=none; b=NdJ1Rm3BcNeRZNJr7AhJToTUvDLl7btTb+md0wOZvPmauHCvr7aDHGgX24VXNkVLW+Ldc8GJ2ZIVGaM8DZ7VDKC9lTysXwzfHQkNF6vSaj6ChdtJ+xawvs0RPzlT/Gsu9VaVyvqza4vqQznNy1YykDgHf+wIV2EpIk/5rQ7ttZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894259; c=relaxed/simple;
	bh=x26vedxZaBNEMW7p7sbkcxlmhtU53pXThFDWuZoJnjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRyUrPJ1F1W18eyruSH4Qz0e7dQbGyMDpm8yyCW+3rjVRq4ukULInji+is6ojH4qVD7S43Qp50oA/Oya3H6Jmwze2fozXA6D9lYp3oGW0vQm69RdKGcQH6NrU+H3Cc7XO430n7TQDaRCR7XVPIKJwvkJazvdXs/vgKe0REpdSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BqLnGLWX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF6AF20B7165;
	Mon,  5 Aug 2024 14:44:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF6AF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722894257;
	bh=Jv7fd/dhJMwXj8aizbSd9o1qD71YjlRNPh+UMAm7ULs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BqLnGLWXKd6WP99927/ANF6rhqkA2su4hWgKM9qyW+Tc8KwvhyaN5hbqm7QOcn0gI
	 5eZqwpX14YfvqR0giQ9ut6H+pCeTYVAP/APHCmrkf6XM7dTZeyz3WQdv+hNnvnrIxQ
	 yF14o40moTl13uhQP4gnrZwTR5br75wlq+L3akRo=
Message-ID: <2ad7731a-b56b-415d-acb1-907fa7224671@linux.microsoft.com>
Date: Mon, 5 Aug 2024 14:44:17 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
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
 <20240726225910.1912537-2-romank@linux.microsoft.com>
 <SN6PR02MB41573831866B7FC9E267D72DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3398a7cb-b366-49e1-ae19-155490b4e42e@linux.microsoft.com>
 <SN6PR02MB41571669ED254773D05E2721D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571669ED254773D05E2721D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/2024 1:30 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, August 5, 2024 9:51 AM
> 
> [snip]
> 
>>>> diff --git a/arch/arm64/include/asm/mshyperv.h
>>>> b/arch/arm64/include/asm/mshyperv.h
>>>> index a975e1a689dd..a7a3586f7cb1 100644
>>>> --- a/arch/arm64/include/asm/mshyperv.h
>>>> +++ b/arch/arm64/include/asm/mshyperv.h
>>>> @@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>>>>
>>>>    #include <asm-generic/mshyperv.h>
>>>>
>>>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
>>>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570
>>>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
>>>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
>>>> +
>>>
>>> Section 6.2 of the SMCCC specification says that the "Call UID Query"
>>> returns a UUID. The above #defines look like an ASCII string is being
>>> returned. Arguably the ASCII string can be treated as a set of 128 bits
>>> just like a UUID, but it doesn't meet the spirit of the spec. Can Hyper-V
>>> be changed to return a real UUID? While the distinction probably
>>> won't make a material difference here, we've had problems in the past
>>> with Hyper-V doing slightly weird things that later caused unexpected
>>> trouble. Please just get it right. :-)
>>>
>> The above values don't violate anything in the spec, and I think it
>> would be hard to give an example of what can be broken in the world by
>> using the above values.
> 
> Agreed.  However, note that UUIDs *do* have some internal structure.
> See https://www.uuidtools.com/decode, for example. The UUID above
> is:
> 
> 4d734879-7065-7256-0000-000000000000
> 
> It has a version digit of "7", which is "unknown".  I'm no expert on UUIDs,
> but apparently the "7" isn't necessarily invalid, though perhaps a bit unexpected.
> 
Understood! I made an assumption that's just an array of random bytes.
Thank you very much for explaining that to me :)

>> I do understand what you're saying when you
>> mention the UIDs & the spirit of the spec. Put on the quantitative
>> footing, the Shannon entropy of these values is much lower than that of
>> an UID. A cursory search in the kernel tree does turn up other UIDs that
>> don't look too random.
>>
>> As that is implemented only in the non-release versions, hardly someone
>> has taken a dependency on the specific values in their production code.
>> I guess that can be changed without causing any disturbance to the
>> customers, will report of any concerns though.
> 
> My last thought is that when dealing with the open source world, and
> with published standards, it's usually best to do what's normal and
> expected, rather than trying to make the case that something unexpected
> is allowed by the spec. Doing the latter can come back to bite you in
> completely unexpected ways. :-)
> 
Agreed, thanks for the discussion! I've discussed changing the values,
and a pull request to the hypervisor has been put up for that. So far, 
going well.

> With that, I won't make any further comments on the topic. You do
> whatever you can do in working with Hyper-V. Either way, it won't be
> a blocker to my giving "Reviewed-by" on the next version of the
> patch.
> 
Will be a badge of honor to me! Again, appreciate your words of advise 
and caution, and helping in bringing these patches into the best shape 
possible!

> Michael

-- 
Thank you,
Roman


