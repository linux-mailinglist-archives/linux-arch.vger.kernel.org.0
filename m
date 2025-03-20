Return-Path: <linux-arch+bounces-10995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56962A6AD43
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0AE1885C99
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34213226D1C;
	Thu, 20 Mar 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dGoE1WIY"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD01953A1;
	Thu, 20 Mar 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496448; cv=none; b=WibKbz6wfassP8PWgzjV0zLczJYa+xdcgw8J7iuoMwPJs03lluF46hC3T0OGWsh0bi7OSOxOcE6TmLOTGh7kVXPduom3K9cgI1ZpjcFPwple3chq5T0WdlzbypKX1TGhDFgqSb16XgGLbL9VPXDzhK1ItvEQBoazayIG7On5u6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496448; c=relaxed/simple;
	bh=p7MoLMJgztUeM2mOX1O2C/+yxOVVFon1dqzplcanEj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzVPYnR0k64XEBGOunxlXuu8HxItst9h8qTWdC+iYb70LIki3wDGu8X25ek9tx1YStPEBhkKOK+cYMKcSpnxJhUbVz47g4AEPeIJfubiVd/DdDp33l/RPGaPblGSJJ0Dofx4P+lWWvdb8vXbkGmpylDMSnxu/7mhPxqQUjjOSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dGoE1WIY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6483B2116B4D;
	Thu, 20 Mar 2025 11:47:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6483B2116B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742496439;
	bh=2L2Q31XCa0Xdbd9gsYILKzkM4+b+VTYhlEAF67KZJpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dGoE1WIYcV3miDSU7tnIjSORwMD3YiiuMtgapwqYs3PxoUrikjyglFZJEbSJEaC1I
	 qppAONaKxLV3qmJYo7gpaRMBNla6xREmO+/WMeSBr/85MzxtUvCAfKqrGUxvaVfV3z
	 LX02uwyNNHxgqfnDJgcNePxL4YNOD7FoIVq49fLM=
Message-ID: <42a1a90b-ae3e-47df-ad6c-500055e69218@linux.microsoft.com>
Date: Thu, 20 Mar 2025 11:47:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
To: Michael Kelley <mhklinux@outlook.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-3-romank@linux.microsoft.com>
 <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
 <BN7PR02MB414871F1A3D8EF3809391F2FD4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <BN7PR02MB414871F1A3D8EF3809391F2FD4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2025 3:11 PM, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, March 17, 2025 4:38 AM

>>
>> The 'acpi_disabled' variable doesn't exist for !CONFIG_ACPI, so its use
>> prior to the ifdeffery looks misplaced.
> 
> FWIW, include/linux/acpi.h has
> 
> #define acpi_disabled 1
> 
> when !CONFIG_ACPI.  But I agree that using a stub is better.

Thanks, Michael! I didn't "fact-checked" what was suggested indeed.
Agreed that the stub makes the code look better.

> 
> Michael
> 
>>
>> Usual codestyle is to avoid ifdeffery if possible, using IS_ENABLED().
>> Otherwise, use a stub, e.g.
>>
>> | #ifdef CONFIG_ACPI
>> | static bool __init hyperv_detect_via_acpi(void)
>> | {
>> | 	if (acpi_disabled)
>> | 		return false;
>> |
>> | 	if (acpi_gbl_FADT.header.revision < 6)
>> | 		return false;
>> |
>> | 	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
>> | }
>> | #else
>> | static inline bool hyperv_detect_via_acpi(void) { return false; }
>> | #endif
>>
>> Mark.
>>
>>> +static bool __init hyperv_detect_via_smccc(void)
>>> +{
>>> +	uuid_t hyperv_uuid = UUID_INIT(
>>> +		0x4d32ba58, 0x4764, 0xcd24,
>>> +		0x75, 0x6c, 0xef, 0x8e,
>>> +		0x24, 0x70, 0x59, 0x16);
>>> +
>>> +	return arm_smccc_hyp_present(&hyperv_uuid);
>>> +}
>>> +
>>>   static int __init hyperv_init(void)
>>>   {
>>>   	struct hv_get_vp_registers_output	result;
>>> @@ -35,13 +70,11 @@ static int __init hyperv_init(void)
>>>
>>>   	/*
>>>   	 * Allow for a kernel built with CONFIG_HYPERV to be running in
>>> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
>>> +	 * a non-Hyper-V environment.
>>> +	 *
>>>   	 * In such cases, do nothing and return success.
>>>   	 */
>>> -	if (acpi_disabled)
>>> -		return 0;
>>> -
>>> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
>>> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>>>   		return 0;
>>>
>>>   	/* Setup the guest ID */
>>> --
>>> 2.43.0
>>>
> 

-- 
Thank you,
Roman


