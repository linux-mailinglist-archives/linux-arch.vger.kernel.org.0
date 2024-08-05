Return-Path: <linux-arch+bounces-5987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E3E947F53
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846BDB2182A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BD15C14C;
	Mon,  5 Aug 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M2enHHT1"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0146A15C13D;
	Mon,  5 Aug 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875194; cv=none; b=s74k+eCMCYfLMA9LzRh8ddQ+PwlbRVuwFRJeJuQmmav/pJL9dXwi1pCJqZ3+iEvchFmgMsLrKEz/0Mq9IYBOSyiveEy72PT/mlZODzoSN+cf8tlzk24guEtztG3YRbg64iyBDXxNbrccjFHk4l8KYP6kG6c31geVTzRU0qMnReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875194; c=relaxed/simple;
	bh=YpMvYEsDyIBcNhx0zyCdRa2fNLdcyXBzZRjN3TB+9xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDKHaMwTB5qlmsJ0sX+KF7f4lksqtb5qdLOUpG9eAlRtz8M/qpKx/WKZy14c7IN+uippWTl9yNDq3BZ86FrYNH+G3uLUh+lTcntHvBRoYY1uGBldO67Ranvgx1hrlXEd6vdAw+wfy9UOXbFVBvNi1zoBTxMDIwEN+ApD8uxx15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M2enHHT1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E3CB20B7165;
	Mon,  5 Aug 2024 09:26:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E3CB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722875192;
	bh=/7LJYKqa3LR9nd7+LVTDdKOnQjGAqsUsYobxWuYOmVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M2enHHT1Cs+o6b0L0ThXriYUvccNmN628VwCtO3a45MKicNg3JmOLE3WA/NrOrvdP
	 4i6Eei2U7jkjNnjNzOqyx+KLHeNANBCTliApvHLlzOIX5QCnJs5mD12tnOhIw4nSk1
	 96xEOah2nFxyuf6wrDNtKNLxv4pZ3ZZlCCu50z0M=
Message-ID: <eb0ffccd-4ec8-42c8-86a3-ae1a7f25fc9c@linux.microsoft.com>
Date: Mon, 5 Aug 2024 09:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
To: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
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
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
 <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
 <dd25f792-3ea4-4660-a5cc-79b589b2b881@linux.microsoft.com>
 <SN6PR02MB41571723DB27E0A29877854ED4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571723DB27E0A29877854ED4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 8:03 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 29, 2024 9:51 AM
>>
>>
>> On 7/27/2024 2:17 AM, Arnd Bergmann wrote:
>>> On Sat, Jul 27, 2024, at 10:56, Krzysztof Kozlowski wrote:
>>>> On 27/07/2024 00:59, Roman Kisel wrote:
>>>>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
>>>>>    		cur_res = &res->sibling;
>>>>>    	}
>>>>>
>>>>> +	/*
>>>>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
>>>>> +	 * might default to 'not coherent' on some architectures.
>>>>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
>>>>> +	 */
>>>>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>>>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>>>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>>>>> +
>>>>> +	if (!of_property_read_bool(np, "dma-coherent"))
>>>>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
>>>>
>>>> Why do you need this property at all, if it is allways dma-coherent? Are
>>>> you supporting dma-noncoherent somewhere?
>>>
>>> It's just a sanity check that the DT is well-formed.
> 
> In my view, this chunk of code can be dropped entirely. The guest
> should believe what the Hyper-V host tells it via DT, and that includes
> operating in non-coherent mode. There might be some future case
> where non-coherent DMA is correct. In such a case, we don't want to
> have to come back and remove an overly aggressive sanity test from
> Linux kernel code.
> 
> As Arnd noted, the dma-coherent (or dma-noncoherent) property should
> be interpreted and applied to the device by common code. If that's not
> working for some reason in this case, we should investigate why not.
> 
> Note that the ACPI code for VMBus does the same thing -- it believes and
> uses whatever the _CCA property says. The exception is that there
> are deployed version of Hyper-V that don't set _CCA at all, contrary to the
> ACPI spec. So there's a hack in vmbus_acpi_add() to work around this case
> and force coherent_dma. But that's the only place where the current
> Hyper-V assumption of coherence comes into play. I sincerely hope Hyper-V
> ensures that the DT correctly includes dma-coherent from the start, and
> that we don't have to replicate the hack on the DT side.
> 
I was replicating the _CCA hack diligently a bit much too much, agreed. 
This great conversation really gives me reassurance that the code 
doesn't have to be paranoid, and I can happily remove this if statement.

> Michael
> 
>>>
>>> Since the dma-coherent property is interpreted by common code, it's
>>> not up to hv to change the default for the platform. I'm not sure
>>> if the presence of CONFIG_ARCH_HAS_SYNC_DMA_* options is the correct
>>> check to determine that an architecture defaults to noncoherent
>>> though, as the function may be needed to do something else.
>> I used the ifdef as the dma_coherent field is declared under these macros:
>>
>> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>> 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>> 	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>> extern bool dma_default_coherent;
>> static inline bool dev_is_dma_coherent(struct device *dev)
>> {
>> 	return dev->dma_coherent;
>> }
>> #else
>> #define dma_default_coherent true
>>
>> static inline bool dev_is_dma_coherent(struct device *dev)
>> {
>> 	return true;
>> }
>>
>> i.e., there is no API to set dma_coherent. As I see it, the options
>> are either warn the user if they forgot to add `dma-coherent`
>>
>> if (!dev_is_dma_coherent(dev)) pr_warn("add dma-coherent to be faster\n"),
>>
>> or warn and force the flag to true. Maybe just warn
>> the user I think now... The code will be cleaner (no need to emulate
>> a-would-be set_dma_coherent) , and the user will
>> know how to make the system perform at its best.
>>
>> Appreciate sharing the reservations about that piece!
>>
>>>
>>> The global "dma_default_coherent' may be a better thing to check
>>> for. This is e.g. set on powerpc64, riscv and on specific mips
>>> platforms, but it's never set on arm64 as far as I can tell.
>>>
>>>        Arnd
>>
>> --
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


