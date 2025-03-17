Return-Path: <linux-arch+bounces-10920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2CA65A78
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C73A1897561
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FE1F4629;
	Mon, 17 Mar 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pp4LLRMe"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA891A38E3;
	Mon, 17 Mar 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231575; cv=none; b=XYPX1Pu7kR993wNiTRFTaC50XK/Ijw4lHmhQUP2NuizH6+Ko3y5ZfEjhFV4o+yi4xiZf7o6KzFLE2wQBQZ9sQ+f7GkeHQ7/ZIqD54ASodz/myfgfJpGCQgtVJzP7CH3T512pZ1s9Z8AkA0TQw1N/VyGwcD9FW8tzs9/E1CBP6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231575; c=relaxed/simple;
	bh=19mD3T5UABjRrmPrE1p6fr8i+EGJB3J1k1iwFJ6REoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3sXF1HDIr91LbT8iPv4jhnj9p42D2x0LmI5gZxI+rmDOiLxpRACbU1G39ys7Xypx9K14s8J1ezp5j3Bd2L1sTbbyp7Xtf2d/37Wf1Culki4Vy1KKitgPi+79PnFFn8ZIgEjhvSY414Xi/dK4iZ/wjQwv28lIPywlTeEdA2LGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pp4LLRMe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D524C2033446;
	Mon, 17 Mar 2025 10:12:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D524C2033446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742231574;
	bh=NB4fqdojx7nwho6V/Wqpk0F8wPdUrsMy+Cc8gR0lJx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pp4LLRMeLW/Iyda8Sngc/0xWytsDSpkGOz1lBb7O7x5IbTDnPTe+Yp/JnsLZoOx5e
	 B9LJG4uglL6w32K1ebxPFOrJfVRh02GeQ3KX0x4/yoqQvlCDju/k74hz7WFBMdx6Fp
	 Fly/svj5TvLrFY4OVkoCfg985ETQmsdbb16fzu/Q=
Message-ID: <c0f51574-d31f-47e0-a4c0-6e6d0fbe1804@linux.microsoft.com>
Date: Mon, 17 Mar 2025 10:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
To: Mark Rutland <mark.rutland@arm.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-3-romank@linux.microsoft.com>
 <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/2025 4:37 AM, Mark Rutland wrote:
> On Fri, Mar 14, 2025 at 05:19:22PM -0700, Roman Kisel wrote:

[...]

> The 'acpi_disabled' variable doesn't exist for !CONFIG_ACPI, so its use
> prior to the ifdeffery looks misplaced.
> 
> Usual codestyle is to avoid ifdeffery if possible, using IS_ENABLED().
> Otherwise, use a stub, e.g.
> 

That looks much better, thanks for the review! Will implement in
the next version.

> | #ifdef CONFIG_ACPI
> | static bool __init hyperv_detect_via_acpi(void)
> | {
> | 	if (acpi_disabled)
> | 		return false;
> | 	
> | 	if (acpi_gbl_FADT.header.revision < 6)
> | 		return false;
> | 	
> | 	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
> | }
> | #else
> | static inline bool hyperv_detect_via_acpi(void) { return false; }
> | #endif
> 
> Mark.
> 
>> +static bool __init hyperv_detect_via_smccc(void)
>> +{
>> +	uuid_t hyperv_uuid = UUID_INIT(
>> +		0x4d32ba58, 0x4764, 0xcd24,
>> +		0x75, 0x6c, 0xef, 0x8e,
>> +		0x24, 0x70, 0x59, 0x16);
>> +
>> +	return arm_smccc_hyp_present(&hyperv_uuid);
>> +}
>> +
>>   static int __init hyperv_init(void)
>>   {
>>   	struct hv_get_vp_registers_output	result;
>> @@ -35,13 +70,11 @@ static int __init hyperv_init(void)
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
>> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>>   		return 0;
>>   
>>   	/* Setup the guest ID */
>> -- 
>> 2.43.0
>>

-- 
Thank you,
Roman


