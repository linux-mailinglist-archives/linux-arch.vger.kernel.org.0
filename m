Return-Path: <linux-arch+bounces-4432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56AC8C6BD3
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C1283EBE
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD43158DAD;
	Wed, 15 May 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="glvQcZr9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56450158845;
	Wed, 15 May 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796255; cv=none; b=Vz4nCJo5PXFhssP05YEIfm9br9vzEIiqM5mQjECyYhG1XnzOvpibt7U4dc4qoDPPfHl4UjL3FoeJkiUKY9F+hwr1AmLM1k0QGGsM8boqrDwHcx0zs7ShAtfvWs4BxP+N1tY6tz/ORkG5iKg72/LUwyO3njh+3p/iwueiw+bHDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796255; c=relaxed/simple;
	bh=/uC6r8iw//SMzZ8NGS9Vxf3Rfafd5om3I6TH7HLW1bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyrENekSeySU8OUGBkzkt5renl5WR0Y1y726T33TMzWFw/PQqZ8+alSfBkoOuNHtM4hZpjNmVs6EhdaRpB7B1r4IFKFH1tS55AT1xJ5HnIM5iF6vsmJjWc35u6+/sgk9tyYkOfnY+JymqQNGxtwRD2QYi0++RWNrnflpLKPK7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=glvQcZr9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id B467520B915A;
	Wed, 15 May 2024 11:04:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B467520B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715796253;
	bh=ScMr1hwCVv5qZHMAEN659FeB99CmF3S+HpysOb7Qq6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glvQcZr9UxFyBDZUkJ7h/dhCU29YraLKpJcAkfJiZcmA7IocRiKi6vhKB6QrQ3ugC
	 MtRTGJZEX2gEJkbhFfm53wk/2lXFWpEVFopy5XF6Lq5R4keOUg8kwHKf/VS5ObjeUZ
	 EqGMgquAB+DH/UnDqqIknS6Sw5SB71iyb3keFUc0=
Message-ID: <a232ddf5-e6ac-41ec-9f53-d5f76f31e970@linux.microsoft.com>
Date: Wed, 15 May 2024 11:04:13 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] drivers/hv: Enable VTL mode for arm64
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
Cc: "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-3-romank@linux.microsoft.com>
 <SN6PR02MB4157E15EFE263BBA3D8DFC51D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E15EFE263BBA3D8DFC51D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 6:37 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 3:44 PM
>>
>> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
>> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
>> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't require
>> arm64 guests on Hyper-V to have ACPI.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 862c47b191af..a5cd1365e248 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>>   config HYPERV
>>   	tristate "Microsoft Hyper-V client drivers"
>>   	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>>   	select PARAVIRT
>>   	select X86_HV_CALLBACK_VECTOR if X86
>>   	select OF_EARLY_FLATTREE if OF
>> @@ -15,7 +15,7 @@ config HYPERV
>>
>>   config HYPERV_VTL_MODE
>>   	bool "Enable Linux to boot in VTL context"
>> -	depends on X86_64 && HYPERV
>> +	depends on HYPERV
>>   	depends on SMP
>>   	default n
>>   	help
> 
> These changes make it possible to build a normal VTL 0 Hyper-V
> guest (i.e., CONFIG_HYPERV_VTL_MODE=n) if CONFIG_ACPI is
> not set, which won't work.  While we can say "don't do that", it
> would be better if the Kconfig dependencies expressed that
> requirement.
> 
> A possible fix is to remove the "depends on HYPERV" from
> HYPERV_VTL_MODE.  Then for HYPERV, make
> the "depends on ACPI" be conditional on !HYPERV_VTL_MODE
> (for both ARM64 and X86).
> 
> I think we originally had "depends on HYPERV" in
> HYPERV_VTL_MODE because there was a VTL-related function
> in a non-Hyper-V code path, and we wanted to prevent that code
> from running in non-Hyper-V environments.  But in practice, that
> turned out not to work well because occasionally people would
> do an "all config" build where both CONFIG_HYPERV and
> CONFIG_HYPERV_VTL_MODE were set, and it would panic during
> boot in their non-Hyper-V environment.  Such people were not
> happy. :-(  So Saurabh made a relatively simple change (see commit
> 14058f72cf13e) that got the VTL code out of that non-Hyper-V code
> path.  With that change, it shouldn't matter if someone sets
> CONFIG_HYPERV_VTL_MODE=y in a build where
> CONFIG_HYPERV=n.
> 
> At least that's my theory. :-)  Someone would need to check
> it carefully.
I'll explore that, appreciate sharing the context!

> 
> Michael

-- 
Thank you,
Roman

