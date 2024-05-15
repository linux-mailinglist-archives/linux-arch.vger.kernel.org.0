Return-Path: <linux-arch+bounces-4435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4D8C6BF3
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FF31C210F3
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBE158DB5;
	Wed, 15 May 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ixc5rLLC"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069FB433BC;
	Wed, 15 May 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796829; cv=none; b=J8xC9ygOyKfjOWJ+T6OEMvCEMMnrbLTc3Pq8PmeN6E4yZtd004ksnEDDFgX1Ra19XHleBKZd4NJiX6XXXleiwI7whwp51+EYiNWR+cehv1BNr3aqEdzhbvbNtDjhILJEH1AI17M8Fr6qGTj1xLF47qj2G0eOOQ2/nCjzE4f1i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796829; c=relaxed/simple;
	bh=HWCevqPUtqkh+N6A41HKCdDCDTkbdm7gME68btyoeks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhtp+ZfnF8ahvIVTVskWDGNK1AjpwbPOHkQ95i+9HP/KfomTrIj4o8HnDxRnyLLdAKPZ0RU+o0izgYnseATN0wKKKmGpqNioKqe6bKwYa6YVOtK7nefwceXn43sBsXdC7KgDLThRrBC7PstNNwy03YxTThJvp0kQvRYf8geC16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ixc5rLLC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6509120BE570;
	Wed, 15 May 2024 11:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6509120BE570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715796827;
	bh=AHKWJF8nm5miX2UApnb2dUoKaj7GWJg9H8YznRUr3R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ixc5rLLCMkyJtA4esUykBJndyXziXrYCLkwz2FnP/ZdCeuabNttOFqDrzl3//5WH1
	 RpyncfDZtLMba7fV/Cex+ptU4+jvM4OU/0fvdxCSmAwWwxHm4yihZcBayA/xIwveVu
	 msKnaup6NO7XdgsxzMmrlbO7EnZnBGIcLMSGK3S8=
Message-ID: <dd052178-bcdb-489b-832b-429566171cf0@linux.microsoft.com>
Date: Wed, 15 May 2024 11:13:47 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64/hyperv: Boot in a Virtual Trust Level
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
 <20240514224508.212318-5-romank@linux.microsoft.com>
 <SN6PR02MB415778D73832B587A2758BD0D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415778D73832B587A2758BD0D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 6:39 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 3:44 PM
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
>>   arch/arm64/hyperv/hv_vtl.c        | 19 +++++++++++++++++++
>>   arch/arm64/hyperv/mshyperv.c      |  6 ++++++
>>   arch/arm64/include/asm/mshyperv.h |  8 ++++++++
>>   arch/x86/hyperv/hv_vtl.c          |  2 +-
>>   5 files changed, 35 insertions(+), 1 deletion(-)
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
>> index 000000000000..9b44cc49594c
>> --- /dev/null
>> +++ b/arch/arm64/hyperv/hv_vtl.c
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023, Microsoft, Inc.
>> + *
>> + * Author : Roman Kisel <romank@linux.microsoft.com>
>> + */
>> +
>> +#include <asm/mshyperv.h>
>> +
>> +void __init hv_vtl_init_platform(void)
>> +{
>> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
>> +}
>> +
>> +int __init hv_vtl_early_init(void)
>> +{
>> +	return 0;
>> +}
>> +early_initcall(hv_vtl_early_init);
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 208a3bcb9686..cbde483b167a 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -96,6 +96,12 @@ static int __init hyperv_init(void)
>>   		return ret;
>>   	}
>>
>> +	/* Find the VTL */
>> +	ms_hyperv.vtl = get_vtl();
>> +	if (ms_hyperv.vtl > 0) /* non default VTL */
>> +		hv_vtl_early_init();
> 
> Since hv_vtl_early_init() doesn't do anything on arm64, is the above
> and the empty implementation of hv_vtl_early_init() really needed?
> I thought maybe a subsequent patch in this series would populate
> hv_vtl_early_init() to do something, but I didn't see such.  I realize
> the functions hv_vtl_init_platform() and hv_vtl_early_init() parallel
> equivalent functions on x86, but I'd say drop hv_vtl_early_init() on
> arm64 if it isn't needed.
> 
> Note too that the naming on the x86 side is arguably a bit messed
> up. hv_vtl_init_platform() runs *before* hv_vtl_early_init().  But
> typically in the Linux kernel, functions with "early init" in the name
> run very early in boot, and that's not the case here.  hv_vtl_init_platform()
> is actually the function that runs very early in boot, but its name is
> set up to parallel ms_hyperv_init_platform(), which calls it.  On the
> x86 side, I'd would argue for renaming hv_vtl_init_platform() to
> hv_vtl_early_init(), and then hv_vtl_early_init() becomes hv_vtl_init().
> But that's probably a separate patch.  Here on arm64, perhaps all
> you need is hv_vtl_init().
> 
I'll clean that up, appreciate the thorough explanation!

> Michael
> 
>> +
>> +	hv_vtl_init_platform();
>>   	ms_hyperv_late_init();
>>
>>   	hyperv_initialized = true;
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index a975e1a689dd..4a8ff6be389c 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -49,6 +49,14 @@ static inline u64 hv_get_msr(unsigned int reg)
>>   				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>   				HV_SMCCC_FUNC_NUMBER)
>>
>> +#ifdef CONFIG_HYPERV_VTL_MODE
>> +void __init hv_vtl_init_platform(void);
>> +int __init hv_vtl_early_init(void);
>> +#else
>> +static inline void __init hv_vtl_init_platform(void) {}
>> +static inline int __init hv_vtl_early_init(void) { return 0; }
>> +#endif
>> +
>>   #include <asm-generic/mshyperv.h>
>>
>>   #endif
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 92bd5a55f093..ae3105375a12 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -19,7 +19,7 @@ static struct real_mode_header hv_vtl_real_mode_header;
>>
>>   void __init hv_vtl_init_platform(void)
>>   {
>> -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
>>
>>   	x86_platform.realmode_reserve = x86_init_noop;
>>   	x86_platform.realmode_init = x86_init_noop;
>> --
>> 2.45.0
>>

-- 
Thank you,
Roman

