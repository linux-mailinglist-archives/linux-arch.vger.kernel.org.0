Return-Path: <linux-arch+bounces-5974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA02947D51
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DDC281922
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19A13C3F9;
	Mon,  5 Aug 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mf5l3Bha"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406538F97;
	Mon,  5 Aug 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869761; cv=none; b=RX/tz1VIbjpLJ9LrkXspVSk42pVVwecK7zottag0ja8cfx+BgRsKD1/VM89tiMKoyGW/5lA24oRG8CGwtrrY5xJqr+tV5c2VhNYbhEGab0BzQs5cjNzX7rNQE1dc2uvQ0Y/TZdup7xvFNEshOsLwoT3pWomWvqjHsWX/MKapum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869761; c=relaxed/simple;
	bh=tUEC8kwq4v7O+YnkMq2wWdWfUhXmYzgfRssA3X9OC5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saPT4gT3QuBgaFgj7nWm39M+AB7J+Jtf+mXCjuwIhnEcfZ48gro23UgpLYZ5ltSxfDreD9eKVpOV9YcdU/Qyko+bV3tJ46W4/JTYDaeNXIjhTOhl1RInDbftf2efchlUGDEWpoDNS8hJiKOQeQffoqav7k8Q+OCYeJDnWaV7eZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mf5l3Bha; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25F1420B7165;
	Mon,  5 Aug 2024 07:55:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25F1420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722869759;
	bh=Y0KT8B5PCn6F8od6tqfxDCAzLuPu/RKwVWyWjc2Gssw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mf5l3BhaMO2QYZ65LW49/czN0ifOeTtP47h24c0C0W3pPrbZrcIzqA/alBHbE4X6J
	 HPtAonjTYyMbb/DqSMh4B6GkJEbAKJWuvCAs5T1VCEs7jSPjcATsKLmbcUrbo7sV8w
	 cosTxRvtEXxuyWIX4EPT/gsJdfHJdLoRFEIWcqzE=
Message-ID: <cca36d1f-a1f3-4d5c-a7ea-6c434903b9ed@linux.microsoft.com>
Date: Mon, 5 Aug 2024 07:55:59 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
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
 <20240726225910.1912537-5-romank@linux.microsoft.com>
 <Zq2GOzYAC8WdaUTk@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Zq2GOzYAC8WdaUTk@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/2/2024 6:22 PM, Wei Liu wrote:
> On Fri, Jul 26, 2024 at 03:59:07PM -0700, Roman Kisel wrote:
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
> 
> It doesn't make sense to me because this function unconditionally prints
> Linux runs in Hyper-V Virtual Trust Level.
> 
Thought to structure this as the similar parts of the VTL support are. 
Will remove, thank you!

> Thanks,
> Wei.
> 
>> +
>>   	ms_hyperv_late_init();
>>   
>>   	hyperv_initialized = true;
>> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
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


