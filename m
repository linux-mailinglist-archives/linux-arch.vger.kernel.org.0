Return-Path: <linux-arch+bounces-5976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53805947E07
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC742843C7
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DEA15B13B;
	Mon,  5 Aug 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kqMkzBxA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653B4D8BA;
	Mon,  5 Aug 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871450; cv=none; b=mZ52+T6SIfiIhs7W5tZ3rlNY68W85WOSjvKi36KSnSG1uEnw+MCMGJrLGUGj9ilrFyWhyNdJGyKvNV0QKBI3CnT7ead+4aAI3zxqzMM5030WlfqVNx5CHn27QJVOGikJPyRdpTlU9rkd+RukV43W1LaVv0o74gioRtagsAwv6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871450; c=relaxed/simple;
	bh=yfp+KBeumGc23QyM92iFE44G1mhcxNzjY770EDwX1xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CabxsKf3aYrwxFKtVkCvuWe6+u/iB/2wBg2hMilAI5EJY1Cff5KKP63UG4/3sw+bapJ+t4w5h+hHR02XhXzt1AIlwqx+UZmsvnKWrl/+OjFa/9cXELWOoQ/0TVqKf/ge2iywG37tEfdvK4pOiWNlSQw4aPkc2n2ey3mTYar7z8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kqMkzBxA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11CE620B7165;
	Mon,  5 Aug 2024 08:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11CE620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722871448;
	bh=QuEJrK0D5kQCcWKVWtCoRbpp6/KKUx8WzOZV7/m9JlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kqMkzBxA0guj+0Nluky99E7furHm8m6bJYlAyDxh83soIbFBudqjQ2ZS4p85y5daU
	 4kCyCMprtbfEls3EJKzShUkMyDn/syu1KJgyJRd9GcU2LTdB5tSKtZU3pzUq96G5wA
	 sn1Xb8uFpM4zE9eHUxY04fXR282757A+4LO9qHB0=
Message-ID: <ebac7069-0396-4b33-88b8-60d5e2594c88@linux.microsoft.com>
Date: Mon, 5 Aug 2024 08:24:08 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
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
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-3-romank@linux.microsoft.com>
 <SN6PR02MB4157824AC8ECA000559F5160D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240805040503.GA14919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240805040503.GA14919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 9:05 PM, Saurabh Singh Sengar wrote:
> On Mon, Aug 05, 2024 at 03:01:58AM +0000, Michael Kelley wrote:
>> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
>>>
>>> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
>>> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
>>> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't require
>>> arm64 guests on Hyper-V to have ACPI.
>>>
>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>> ---
>>>   drivers/hv/Kconfig | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>> index 862c47b191af..a5cd1365e248 100644
>>> --- a/drivers/hv/Kconfig
>>> +++ b/drivers/hv/Kconfig
>>> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>>>   config HYPERV
>>>   	tristate "Microsoft Hyper-V client drivers"
>>>   	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>>> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>>> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>>>   	select PARAVIRT
>>>   	select X86_HV_CALLBACK_VECTOR if X86
>>>   	select OF_EARLY_FLATTREE if OF
>>> @@ -15,7 +15,7 @@ config HYPERV
>>>
>>>   config HYPERV_VTL_MODE
>>>   	bool "Enable Linux to boot in VTL context"
>>> -	depends on X86_64 && HYPERV
>>> +	depends on HYPERV
>>>   	depends on SMP
>>>   	default n
>>>   	help
>>> @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
>>>
>>>   	  Select this option to build a Linux kernel to run at a VTL other than
>>>   	  the normal VTL0, which currently is only VTL2.  This option
>>> -	  initializes the x86 platform for VTL2, and adds the ability to boot
>>> +	  initializes the kernel to run in VTL2, and adds the ability to boot
>>>   	  secondary CPUs directly into 64-bit context as required for VTLs other
>>>   	  than 0.  A kernel built with this option must run at VTL2, and will
>>>   	  not run as a normal guest.
>>> --
>>> 2.34.1
>>>
>>
>> In v2 of this patch, I suggested [1] making a couple additional minor changes
>> so that kernels built *without* HYPER_VTL_MODE would still require
>> ACPI.  Did that suggestion not work out?  If that's the case, I'm curious
>> about what goes wrong.
> 
> Hi Michael/Roman,
> I was considering making HYPERV_VTL_MODE depend on CONFIG_OF. That should address
> above concern as well. Do you see any potential issue with it.
> 
Michael,

I ran into a pretty gnarly recursive dependencies which in all fairness 
might stem from not being fluent enough in the Kconfig language. Any 
help of how to approach implementing your idea would be greatly appreciated!

Saurabh,

I could try out the idea you're offering if you folks are fine with 
that. Or, we could let this be for the time being and grapple with that 
in a separate patch series :)

> - Saurabh

-- 
Thank you,
Roman


