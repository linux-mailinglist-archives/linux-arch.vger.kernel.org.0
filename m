Return-Path: <linux-arch+bounces-10251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C9A3E0FF
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B673B3B5A9C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980520DD43;
	Thu, 20 Feb 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FabHF0Pv"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279320C034;
	Thu, 20 Feb 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069302; cv=none; b=nXctkDc+BVjyCcYji0tC+C3YT0inVUVdGh+xZOmsw939rpiYRKubSq5NFr+CDBwxXGaPJ1tVl0NU2NouSjcZAhADQWtPhdzFwsU3V4YiaR1YVIb+t+Q8OFyJqCKrXn86q8HlMxw38vhV7yl1JTKOaAs3e23K2C/uaGOUnuIb4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069302; c=relaxed/simple;
	bh=nKjCl1G2XWM1G1+RZhmlvTS4AT+mLpwU0ZzysKzfjOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvKy8sEyoBPGwDPY1s+Fia9eAZ7zymtzAf/x0jhMySwdW9HVtNQofOab8J6mKtkAKSo+Yw3hK/0XJxP2PVpXgPL33M/n0WM28DazmgqgPxhRxnQfNWF8tBjFCCIWQ6lmwd23Sb0LUVQsPlbU3uIzqvsuVnLnEVPb1NpS6ZDAj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FabHF0Pv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1D8920376F8;
	Thu, 20 Feb 2025 08:34:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1D8920376F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740069300;
	bh=ll4MapV9YYQHwTCOG3xJfA+Sudr/vOAtL9iS2dtf3J0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FabHF0Pv9CtkRuEY+LxCxEqw+PX7OOBIDPKEL29N2aeyIMDHzhOQg1gf0RQO2lmoI
	 CRtE1nDhCVV6idmCw6GqON120UCb0TBOM/r9zx91h9wa8UVVHQqcoz2IlXj6lCCtm7
	 rQnELxtu7vmnEMRCugYJDyI4Tay8IR8t3zOiFDTo=
Message-ID: <fa2d9e8d-7897-44eb-87e2-3a9118deb18a@linux.microsoft.com>
Date: Thu, 20 Feb 2025 08:34:59 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
 <SN6PR02MB4157DB2F52501309D52D0870D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157DB2F52501309D52D0870D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/2025 3:13 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, 2025 5:43 PM
>>

[...]

>>   }
>>
>> +static bool hyperv_detect_via_acpi(void)
>> +{
>> +	if (acpi_disabled)
>> +		return false;
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +	/* Hypervisor ID is only available in ACPI v6+. */
> 
> The comment is correct, but to me doesn't tell the full story.
> I initially wondered why the revision test < 6 was being done,
> since Hyper-V for ARM64 always provides ACPI 6.x or greater.
> But the test is needed to catch running in some unknown
> non-Hyper-V environment that has ACPI 5.x or less. In such a
> case, it can't be Hyper-V, so just return false instead of testing
> a bogus hypervisor_id field. Maybe a comment would help
> explain it to someone like me who was confused. :-)
> 

Thanks, I'll extend the comment to tell the whole story!

[...]

>> +	ms_hyperv.vtl = get_vtl();
> 
> The above statement looks like it will fail to compile on
> arm64 since the get_vtl() function is entirely on the x86
> side until Patch 3 of this series. As of this Patch 1, there's
> no declaration of get_vtl() available to arm64.
> 

I used my working branch for testing
https://github.com/romank-msft/linux-hyperv/tree/vtl_mode_arm64_v4
and didn't move that code around when chunking into patches.
Will fix the workflow, thanks for catching this!

>> +	/* Report if non-default VTL */
>> +	if (ms_hyperv.vtl > 0)
>> +		pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> 
> Could this message include the VTL number as well? In the long
> run, I think there will be code at non-zero VTLs other than VTL 2.
> 

Absolutely, will add!

>> +
>>   	ms_hyperv_late_init();
>>
>>   	hyperv_initialized = true;
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index 2e2f83bafcfb..a6d7eb9e167b 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -50,4 +50,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>>
>>   #include <asm-generic/mshyperv.h>
>>
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x4d32ba58U
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0xcd244764U
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0x8eef6c75U
>> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0x16597024U
>> +
>>   #endif
>> --
>> 2.43.0
>>

-- 
Thank you,
Roman


