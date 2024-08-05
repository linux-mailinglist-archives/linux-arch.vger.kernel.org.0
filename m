Return-Path: <linux-arch+bounces-5986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB00947F1F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 18:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE860281DD3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D3A15B559;
	Mon,  5 Aug 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Spc/40ko"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2015B13B;
	Mon,  5 Aug 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874847; cv=none; b=OgBWPBTlVcL1cjpLemrhFYJOAODvzInlWMPeu1heVIwbzqIGn5W1UK5CltZ7IDqky0iLb+2g4KkbQ05jK0ydxveNQrOCZhjW8IplUnIXqbTzQa5nTFnYn9gGwmEZSy19NS0kOfwle3Hxvbh21yvTOg8l1ZUXQEQxiwj7A0gJXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874847; c=relaxed/simple;
	bh=/L2ZmKVsnMnMzzDATRh01PFyiIKGURwsJUcC5trdz74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7s8Jz43MdHqRQ010Bun7/oBUg32zB3PwrdYSEOJyfZjmt7mIQq0kNalHPqBGdXns6fNH0Xv8TXQjC432O2EFZfp91dWejkO+gUpuch7iPFKa+vb6GFkY7y26ndGd1yBCVoc1FNAYIc4jemhUXXQNeZ2wO84/5sGUT7siaSGiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Spc/40ko; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4441820B7165;
	Mon,  5 Aug 2024 09:20:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4441820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722874845;
	bh=x7RmYwcl8Np2r9CgaT28u+v74Tee49QBXTpKkw+aDMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Spc/40kowD2L/9j9rxEhbXM8jNL0yKIWWH3nPryKvtsxxcfqWkcOw1zNQytspaDf9
	 ka/+E7NGxcSj+aJgyTJGArS23Gp704ZXooexFtXYIgNn4M29vMSEH0AfRwo2jjCzW0
	 Tc0i9erquhfjLy2nTZu3FyLDYvVHvhwaSygalWN8=
Message-ID: <40a0853f-52e1-4f44-a7bd-aa5b732c07a9@linux.microsoft.com>
Date: Mon, 5 Aug 2024 09:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
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
 <20240726225910.1912537-5-romank@linux.microsoft.com>
 <SN6PR02MB41575867724F85CB7A1551E6D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41575867724F85CB7A1551E6D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 8:02 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
>>
>> To run in the VTL mode, Hyper-V drivers have to know what
>> VTL the system boots in, and the arm64/hyperv code does not
>> update the variable that stores the value.
>>
>> Update the variable to enable the Hyper-V drivers to boot
>> in the VTL mode and print the VTL the code runs in.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/Makefile        |  1 +
>>   arch/arm64/hyperv/hv_vtl.c        | 13 +++++++++++++
>>   arch/arm64/hyperv/mshyperv.c      |  4 ++++
>>   arch/arm64/include/asm/mshyperv.h |  7 +++++++
>>   4 files changed, 25 insertions(+)
>>   create mode 100644 arch/arm64/hyperv/hv_vtl.c
>>
>> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
>> index 87c31c001da9..9701a837a6e1 100644
>> --- a/arch/arm64/hyperv/Makefile
>> +++ b/arch/arm64/hyperv/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-y		:= hv_core.o mshyperv.o
>> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
>> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
>> new file mode 100644
>> index 000000000000..38642b7b6be0
>> --- /dev/null
>> +++ b/arch/arm64/hyperv/hv_vtl.c
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024, Microsoft, Inc.
>> + *
>> + * Author : Roman Kisel <romank@linux.microsoft.com>
>> + */
>> +
>> +#include <asm/mshyperv.h>
>> +
>> +void __init hv_vtl_init_platform(void)
>> +{
>> +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>> +}
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 341f98312667..8fd04d6e4800 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -98,6 +98,10 @@ static int __init hyperv_init(void)
>>   		return ret;
>>   	}
>>
>> +	/* Find the VTL */
>> +	ms_hyperv.vtl = get_vtl();
>> +	hv_vtl_init_platform();
>> +
>>   	ms_hyperv_late_init();
>>
>>   	hyperv_initialized = true;
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index a7a3586f7cb1..63d6bb6998fc 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -49,6 +49,13 @@ static inline u64 hv_get_msr(unsigned int reg)
>>   				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>   				HV_SMCCC_FUNC_NUMBER)
>>
>> +#ifdef CONFIG_HYPERV_VTL_MODE
>> +void __init hv_vtl_init_platform(void);
>> +int __init hv_vtl_early_init(void);
> 
> This declaration is spurious since you removed the function.
> 
Will clean this up, thanks!

> Michael
> 
>> +#else
>> +static inline void __init hv_vtl_init_platform(void) {}
>> +#endif
>> +
>>   #include <asm-generic/mshyperv.h>
>>
>>   #define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
>> --
>> 2.34.1
>>

-- 
Thank you,
Roman


