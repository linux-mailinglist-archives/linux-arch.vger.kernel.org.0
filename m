Return-Path: <linux-arch+bounces-4436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842538C6C15
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3899A283128
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD49158DBF;
	Wed, 15 May 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SGy/SNbL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6F158DB7;
	Wed, 15 May 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797308; cv=none; b=RDL0mOJwahRgZGD9NvDdC6NXRXjCFM0ZSuyIPDZdCD6YLoEDBC/dPWiFoYYXPIsBn3VLUvDP/wNl6ZfxsZAxmTffixWXXJP+V+idt6Ov7YDxVHcisGjNjGwfG+O+mQzo3u4sdnj3F9zhAC77Ze5YE00kPbYF96dG83oUtIgksuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797308; c=relaxed/simple;
	bh=e8ttiAemtFgcKjlFj7AZuGWtGde8VsUbQHI5auT9tmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DClNFzXjoGCNTr9mLHwT4Hq/QQOviYsK+iJipzla3Ao3OHxWLZ/rS+yVy/onFiHsH22LWT+Y/lch1Iz5NnDWQ8oR4F/6ZNKl4yT2FLqhI+h6B3AbhlHr547ohKwBGH/5wtFRAhDWjGy0zKg6es1Epn+iwz2wVuR32IM6LSIsfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SGy/SNbL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FE7720B915A;
	Wed, 15 May 2024 11:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FE7720B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715797306;
	bh=UvII0U5FgfFQDZQ3NT21zj0ni0imPoIcxup69WeWcAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SGy/SNbL/qrNmz/echRqY+IgHUmBp1Sr4HAj9GhSGwUddaTaWqqAOdjxRhVX+wwjz
	 2ixfAFv7q3V5BD7ewz16gbekjG9lIj4U/edzjWduKCcNKcAUwgSxU8BZs/fQ5tgc1D
	 ENhasCnVgsDXRep8wKswSKV4mn0kETt5sVYYLXxQ=
Message-ID: <dc7db611-c4f7-412d-8ace-f675a068f966@linux.microsoft.com>
Date: Wed, 15 May 2024 11:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
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
 <20240514224508.212318-6-romank@linux.microsoft.com>
 <SN6PR02MB4157473A48D58D545102614BD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157473A48D58D545102614BD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 6:44 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 3:44 PM
>>
>> The vmbus driver uses ACPI for interrupt assignment on
>> arm64 hence it won't function in the VTL mode where only
>> DeviceTree can be used.
>>
>> Update the vmbus driver to discover interrupt configuration
>> via DeviceTree.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index e25223cee3ab..52f01bd1c947 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/syscore_ops.h>
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/pci.h>
>> +#include <linux/of_irq.h>
>>   #include <clocksource/hyperv_timer.h>
>>   #include <asm/mshyperv.h>
>>   #include "hyperv_vmbus.h"
>> @@ -2316,6 +2317,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>>   }
>>   #endif
>>
>> +static int __maybe_unused vmbus_of_set_irq(struct device_node *np)
>> +{
>> +	struct irq_desc *desc;
>> +	int irq;
>> +
>> +	irq = of_irq_get(np, 0);
>> +	if (irq == 0) {
>> +		pr_err("VMBus interrupt mapping failure\n");
>> +		return -EINVAL;
>> +	}
>> +	if (irq < 0) {
>> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
>> +		return irq;
>> +	}
>> +
>> +	desc = irq_to_desc(irq);
>> +	if (!desc) {
>> +		pr_err("VMBus interrupt description can't be found for virq %d\n", irq);
> 
> s/description/descriptor/
> 
> Or maybe slightly more compact overall:  "No interrupt descriptor for VMBus virq %d\n".
> 
Yep, thanks!

>> +		return -ENODEV;
>> +	}
>> +
>> +	vmbus_irq = irq;
>> +	vmbus_interrupt = desc->irq_data.hwirq;
>> +	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
> 
> How does device DMA cache coherency get handled in the DeviceTree case on
> arm64? For vmbus_acpi_add(), there's code to look at the _CCA flag, which is
> required in ACPI for arm64.  (There's also code to handle the Hyper-V bug where
> _CCA is omitted.)  I don't know DeviceTree, but is there a similar flag to indicate
> device cache coherency?  Of course, Hyper-V always assumes DMA cache
> coherency, and that's a valid assumption for the server-class systems that
> would run Hyper-V VMs on arm64.  But the Linux DMA subsystem needs to be
> told, and vmbus_dma_configure() needs to propagate the setting from the
> VMBus device to the child VMBus devices. Everything still works if the Linux
> DMA subsystem isn't told, but you end up with a perf hit.  The DMA code
> defaults to "not coherent" on arm64, and you'll get a lot of high-cost cache
> coherency maintenance done by the CPU when it is unnecessary.  This issue
> doesn't arise on x86 since the architecture requires DMA cache coherency, and
> the Linux default is "coherent".
> 
Appreciate the indispensable insight! I'll straighten this out.

>> +
>> +	return 0;
>> +}
>> +
>>   static int vmbus_device_add(struct platform_device *pdev)
>>   {
>>   	struct resource **cur_res = &hyperv_mmio;
>> @@ -2324,12 +2353,20 @@ static int vmbus_device_add(struct platform_device *pdev)
>>   	struct device_node *np = pdev->dev.of_node;
>>   	int ret;
>>
>> +	pr_debug("VMBus is present in DeviceTree\n");
>> +
> 
> I'm not clear on how interpret this debug message.  Reaching this point in the code
> path just means that acpi_disabled is "true".  DeviceTree hasn't yet been searched to
> see if VMBus is found.
> 
True. Will remove.

>>   	hv_dev = &pdev->dev;
>>
>>   	ret = of_range_parser_init(&parser, np);
>>   	if (ret)
>>   		return ret;
>>
>> +#ifndef HYPERVISOR_CALLBACK_VECTOR
>> +	ret = vmbus_of_set_irq(np);
>> +	if (ret)
>> +		return ret;
>> +#endif
>> +
>>   	for_each_of_range(&parser, &range) {
>>   		struct resource *res;
>>
>> --
>> 2.45.0
>>
> 

-- 
Thank you,
Roman

