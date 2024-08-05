Return-Path: <linux-arch+bounces-5990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F06947F98
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C34E1C20F6F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E515B96F;
	Mon,  5 Aug 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b0cIbmyY"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BB4CE13;
	Mon,  5 Aug 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876639; cv=none; b=Ywh3b6k0E+HI0J0Ok10Dh/wYSLmVmxNVp8lqGcAc/5LBOMqkG841sMRxo6k3AZpFqqNZ6oIl3lbl/NmFlm5pLB5Whm3pHmZolaGnWRFBmIgXM+2mMaYYj2l3jFHkArY81+DF9np2C2E/CKxsbXzMl51sMv1mX7dM1/we/bf9r/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876639; c=relaxed/simple;
	bh=zRPdf96RBAF77AeX5XbkzCPA6438Vbgd/UgiRhvChXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMvJK4sKiOxYz5T3NTzvs3BZOlRsPUYmwPZKZNyOitAX1VaRmJlDwF6cRhFTxddNqGU6n3Ft8i7dQ/1FDy9+csxVxAzd9P9awjtqPqlWZnRKpJaGrrs8O35PCacvcniD8/wkuG4wwRr9o1HaJrdhTosMRUOg8IL9Q4RKW5r3As4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b0cIbmyY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC00D20B7165;
	Mon,  5 Aug 2024 09:50:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC00D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722876637;
	bh=uAp9WuXRmAP/u/QupU9OvjGgNMB7svwXsN4K6Bamr5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b0cIbmyYqLAbSQcTHEEnL/mJJbPs0t8mESwi2BWGJqjTwzz85N2o7ggprQxIXI9z+
	 zMehST3SDqRrpNzNyU9uHn3eKdabToQKGZTnR567zDf4rYWZ29fYZz9AP2T8QyKGhn
	 Ms0vQzUStoYvXZexLFCTg1DWpDPXxVV/imJyw2CQ=
Message-ID: <3398a7cb-b366-49e1-ae19-155490b4e42e@linux.microsoft.com>
Date: Mon, 5 Aug 2024 09:50:37 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41573831866B7FC9E267D72DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 8:01 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
>>
>> The arm64 Hyper-V startup path relies on ACPI to detect
>> running under a Hyper-V compatible hypervisor. That
>> doesn't work on non-ACPI systems.
>>
>> Hoist the ACPI detection logic into a separate function,
>> use the new SMC added recently to Hyper-V to use in the
>> non-ACPI case.
> 
> Wording seems slightly messed up.  Perhaps:
> 
>     Hoist the ACPI detection logic into a separate function. Then
>     use the new SMC added recently to Hyper-V in the non-ACPI
>     case.
> 
> Also, the phrase "the new SMC" seems a bit off to me.  The "Terms and
> Abbreviations" section of the SMCCC specification defines "SMC" as
> an instruction:
> 
>     Secure Monitor Call. An Arm assembler instruction that causes an
>     exception that is taken synchronously into EL3.
> 
> More precisely, I think you mean a SMC "function identifier" that is
> newly implemented by Hyper-V.  And the function identifier itself isn't
> new; it's the Hyper-V implementation that's new.
> 
> Similar comment applies in the cover letter for this patch set, and
> perhaps to the Subject line of this patch.
> 
Will fix the wording, appreciate your help with bringing this into the 
best shape possible!

>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
>>   arch/arm64/include/asm/mshyperv.h |  5 +++++
>>   2 files changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index b1a4de4eee29..341f98312667 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -27,6 +27,34 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>   	return 0;
>>   }
>>
>> +static bool hyperv_detect_via_acpi(void)
>> +{
>> +	if (acpi_disabled)
>> +		return false;
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +	/* Hypervisor ID is only available in ACPI v6+. */
>> +	if (acpi_gbl_FADT.header.revision < 6)
>> +		return false;
>> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static bool hyperv_detect_via_smc(void)
>> +{
>> +	struct arm_smccc_res res = {};
>> +
>> +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
>> +		return false;
>> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
>> +
>> +	return res.a0 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
>> +		res.a1 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
>> +		res.a2 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
>> +		res.a3 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
>> +}
>> +
>>   static int __init hyperv_init(void)
>>   {
>>   	struct hv_get_vp_registers_output	result;
>> @@ -35,13 +63,11 @@ static int __init hyperv_init(void)
>>
>>   	/*
>>   	 * Allow for a kernel built with CONFIG_HYPERV to be running in
>> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
>> +	 * a non-Hyper-V environment.
>> +	 *
>>   	 * In such cases, do nothing and return success.
>>   	 */
>> -	if (acpi_disabled)
>> -		return 0;
>> -
>> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
>> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smc())
>>   		return 0;
>>
>>   	/* Setup the guest ID */
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index a975e1a689dd..a7a3586f7cb1 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>>
>>   #include <asm-generic/mshyperv.h>
>>
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
>> +
> 
> Section 6.2 of the SMCCC specification says that the "Call UID Query"
> returns a UUID. The above #defines look like an ASCII string is being
> returned. Arguably the ASCII string can be treated as a set of 128 bits
> just like a UUID, but it doesn't meet the spirit of the spec. Can Hyper-V
> be changed to return a real UUID? While the distinction probably
> won't make a material difference here, we've had problems in the past
> with Hyper-V doing slightly weird things that later caused unexpected
> trouble. Please just get it right. :-)
> 
The above values don't violate anything in the spec, and I think it 
would be hard to give an example of what can be broken in the world by 
using the above values. I do understand what you're saying when you 
mention the UIDs & the spirit of the spec. Put on the quantitative 
footing, the Shannon entropy of these values is much lower than that of 
an UID. A cursory search in the kernel tree does turn up other UIDs that 
don't look too random.

As that is implemented only in the non-release versions, hardly someone 
has taken a dependency on the specific values in their production code. 
I guess that can be changed without causing any disturbance to the 
customers, will report of any concerns though.

> Michael
> 
>>   #endif
>> --
>> 2.34.1
>>

-- 
Thank you,
Roman


