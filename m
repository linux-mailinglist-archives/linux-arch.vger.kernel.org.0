Return-Path: <linux-arch+bounces-5678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83C93FBD3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B851F2041D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B97156654;
	Mon, 29 Jul 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cAnu5aOE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051B62AD22;
	Mon, 29 Jul 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271867; cv=none; b=GQ1SPSVSHhWBv2aSpyHgoiI6tSmBM+QE55e1UtMGIIXR0mxE9oYdPKRztUX+HIR0ByGpIM7W6YsvrkxK75YcOX1RHRYefSHznMXONiBNZv3qh+OuYbDUG7m4vQNEQPx54qfM0rAlJKkUdBNZp0qJX1SEVMPrKaRmDydMQW8VhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271867; c=relaxed/simple;
	bh=tpiIBI/XLHi/5xgbxI4SzoqzwjrDyP7UJ+SV9h01uUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4kYztLXuU5endEl4Uzt/AW600MP7YRrqr05YKt7OGsSQo7tKYaWrH+kj3lJ88//1T1tj9/Rqg/VAGEZa3FW00VfWYJO/JUtULFTthTNTOhiUctm4S3ohuWC8Gh7pz/5ZfIUxK9wwEXqF/q/GY/GfLOurDxRDn2jh4/monh+Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cAnu5aOE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 576B620B7165;
	Mon, 29 Jul 2024 09:51:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 576B620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722271864;
	bh=+cXxOiDKrFT9b5NlMgR7bH2wonHbOte3VUO2//bA1jM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cAnu5aOEkHh7wxXbogTb1Cop95sAfjfbO6Fw31tIR4cHaVDOUVNcmci5CV+FTodxU
	 2hFQZTn0VXTMRnbETa7vKc9SRTH3mFJ8pocSP9iggoq5Wp3rZGswCxndPgnRoMD0px
	 8uhorG0O/RjITxfLaGDscHaSu2QcqX6qnqfiH1uM=
Message-ID: <dd25f792-3ea4-4660-a5cc-79b589b2b881@linux.microsoft.com>
Date: Mon, 29 Jul 2024 09:51:07 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 bhelgaas@google.com, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
 <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2024 2:17 AM, Arnd Bergmann wrote:
> On Sat, Jul 27, 2024, at 10:56, Krzysztof Kozlowski wrote:
>> On 27/07/2024 00:59, Roman Kisel wrote:
>>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
>>>   		cur_res = &res->sibling;
>>>   	}
>>>   
>>> +	/*
>>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
>>> +	 * might default to 'not coherent' on some architectures.
>>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
>>> +	 */
>>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>>> +
>>> +	if (!of_property_read_bool(np, "dma-coherent"))
>>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
>>
>> Why do you need this property at all, if it is allways dma-coherent? Are
>> you supporting dma-noncoherent somewhere?
> 
> It's just a sanity check that the DT is well-formed.
> 
> Since the dma-coherent property is interpreted by common code, it's
> not up to hv to change the default for the platform. I'm not sure
> if the presence of CONFIG_ARCH_HAS_SYNC_DMA_* options is the correct
> check to determine that an architecture defaults to noncoherent
> though, as the function may be needed to do something else.
I used the ifdef as the dma_coherent field is declared under these macros:

#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
extern bool dma_default_coherent;
static inline bool dev_is_dma_coherent(struct device *dev)
{
	return dev->dma_coherent;
}
#else
#define dma_default_coherent true

static inline bool dev_is_dma_coherent(struct device *dev)
{
	return true;
}

i.e., there is no API to set dma_coherent. As I see it, the options
are either warn the user if they forgot to add `dma-coherent`

if (!dev_is_dma_coherent(dev)) pr_warn("add dma-coherent to be faster\n"),

or warn and force the flag to true. Maybe just warn
the user I think now... The code will be cleaner (no need to emulate
a-would-be set_dma_coherent) , and the user will
know how to make the system perform at its best.

Appreciate sharing the reservations about that piece!

> 
> The global "dma_default_coherent' may be a better thing to check
> for. This is e.g. set on powerpc64, riscv and on specific mips
> platforms, but it's never set on arm64 as far as I can tell.
> 
>       Arnd

-- 
Thank you,
Roman


