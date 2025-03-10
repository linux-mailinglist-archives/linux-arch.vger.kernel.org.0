Return-Path: <linux-arch+bounces-10647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83AA59EE2
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8187A6C82
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD603233703;
	Mon, 10 Mar 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TKhga+c9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827E1DE89C;
	Mon, 10 Mar 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628107; cv=none; b=Q9uOda5Xzf7JVadLcmAHrBRF8YAntdjoY9XvJsopg822dDSDQRQdM3VliqRB5L6ZoU18Cu9ygapgh8UeMPU29C+7HwHGxBg/fDfXL84oQ2JeznZiLdsOGAiRFet+8BPU/ZKKkCKlSM1hv24LIGp0qBkAL3vdLjOaKH3E5Ar66L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628107; c=relaxed/simple;
	bh=Hq7MojTzFFLgMgx4YbvO4dGDGVR8qIrMvtm/qCi9a/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnPGmK/+JGTFazka1m8ehcVlNhF16KCOi4l11svdvxipCE/VWZrdLqcxtG4bA7XQ/3L071Xv3VSbD8ACJugH06YPQwKBElzMCmih+AzqUwG/FRgnrgRRPiRflGjQOevilrqm/6cccIe6QkmoJE1upEoi+G3Pu4anSNNCoiuaB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TKhga+c9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 64E3B2038F33;
	Mon, 10 Mar 2025 10:35:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64E3B2038F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741628105;
	bh=1+ofQwuGVRqhE03VmsYlGEcNUurWgNiie1yoZECtaVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TKhga+c9cuJgMknPM13jAgQP1DCYNGUPpcl+c1m94c8yVqD62xkfoXvk7bLjOxBY2
	 Jd/ln5jDO+gGUjD6Z3n3nQwi1hJPN7SvGVn7aNlAeIKOpA9Lr5y1NMvcg21OqMdsUE
	 Sb7ps3xymomjl6NcnK+v0qVmLnYE/BpYP3OBs4GY=
Message-ID: <e0dce529-0777-491d-aced-1e9ead31ac17@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:35:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
To: Arnd Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, bhelgaas@google.com, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Joey Gouly <joey.gouly@arm.com>,
 krzk+dt@kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 ssengar@linux.microsoft.com, Sudeep Holla <sudeep.holla@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/2025 1:05 PM, Arnd Bergmann wrote:
> On Fri, Mar 7, 2025, at 23:02, Roman Kisel wrote:
>> @@ -5,18 +5,20 @@ menu "Microsoft Hyper-V guest support"
>>   config HYPERV
>>   	tristate "Microsoft Hyper-V client drivers"
>>   	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>> +	depends on (ACPI || HYPERV_VTL_MODE)
>>   	select PARAVIRT
>>   	select X86_HV_CALLBACK_VECTOR if X86
>> -	select OF_EARLY_FLATTREE if OF
>>   	help
>>   	  Select this option to run Linux as a Hyper-V client operating
>>   	  system.
>>
>>   config HYPERV_VTL_MODE
>>   	bool "Enable Linux to boot in VTL context"
>> -	depends on X86_64 && HYPERV
>> +	depends on (X86_64 || ARM64)
>>   	depends on SMP
>> +	select OF_EARLY_FLATTREE
>> +	select OF
>>   	default n
>>   	help
> 
> Having the dependency below the top-level Kconfig entry feels a little
> counterintuitive. You could flip that back as it was before by doing
> 
>        select HYPERV_VTL_MODE if !ACPI
>        depends on ACPI || SMP
> 
> in the HYPERV option, leaving the dependency on HYPERV in
> HYPERV_VTL_MODE.
> 

I was implementing Michael's suggestion, and might've gone a bit
overboard, my bad. I'll fix this, thanks a lot for reviewing!

> Is OF_EARLY_FLATTREE actually needed on x86?
> 

No, it is not needed on x86. It is only needed when VTL mode is used.

>        Arnd

-- 
Thank you,
Roman


