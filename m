Return-Path: <linux-arch+bounces-4428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF38C6A9E
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527561F23616
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BB3214;
	Wed, 15 May 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jYM0jIAS"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86365A2A;
	Wed, 15 May 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790711; cv=none; b=utv8/JONUZmHjBKXdbc7KeX5v+CL6UQ8EfQCLMNiO6eZcFXHnbpixBGPJiYTfKysPH6FbvCMZddMYnYS+qkpsbBMFBeM4aW4MSJIfJVbqwmY3PXxQB+10tX0DRJj1gMbB6/ztvmPPpMSXSGSlN6fLgLFnAbssEb1Vc0fBmNEvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790711; c=relaxed/simple;
	bh=oV9BF8gsqJXZ5npFONZC3KLX75Rp4oYygO22udBsXIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQPtiCzp16hLU6rvGRcrINu7t9ZX8P4OWS+tnX8PX8i5lL6bcFp212YHjhTE3mIbnmUTWUwAo2OMKEga/tXMysYMRF8hTMX6EW0jgfojZPdMgLV+ZhbrAJcqk3t5Auo+abeRmvXE7i1y17nlf/9nx89h50Yjib1OZXBTcV6nbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jYM0jIAS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A2FCF20B915A;
	Wed, 15 May 2024 09:31:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2FCF20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715790708;
	bh=zfT5j7bYJM4DBZSc/Ycy5/9qcDO07bVAvevEiPC83k8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jYM0jIAS40gZnVu5608YVfpID3a7+2njxvkoEidPMcsRJTvmB1BnJSa74t0o27bvo
	 jzh+nEcM9FlOT9rA7SFJp3qAjB5iPk0rVeqT8eLK6NOW9+ZmGxHiSyReCuRVbOiJUn
	 O8c3032PpeKyyZ1i2pceaLxfa6pwPNCFu+//afBU=
Message-ID: <810369de-077a-412f-b524-6528317c1506@linux.microsoft.com>
Date: Wed, 15 May 2024 09:31:48 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, mingo@redhat.com,
 mhklinux@outlook.com, rafael@kernel.org, robh@kernel.org,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-6-romank@linux.microsoft.com>
 <20240515094225.GA22844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240515094225.GA22844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 2:42 AM, Saurabh Singh Sengar wrote:
> On Tue, May 14, 2024 at 03:43:52PM -0700, Roman Kisel wrote:
>> The vmbus driver uses ACPI for interrupt assignment on
> 
> In subject use the prefix "Drivers: hv: vmbus:".
> It is preferred to us "VMbus/VMBus" instead of "vmbus" for all the
> commit message and comments.
> 
I can see "Drivers: hv: vmbus:" as a convention from the data[1], will 
update the commit message per that.

The recent Michael Kelly's patchset where the Hyper-V documentation is 
updated to use "VMBus" instead of the incorrect one (iiuc) "VMbus" 
compels me to use "VMBus" out of the options you have enumerated, in the 
commit description.

[1]
The data mining device was

git log --all --grep='Drivers: hv: vmbus:'

and variations thereof.

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
>> +		return -ENODEV;
>> +	}
>> +
>> +	vmbus_irq = irq;
>> +	vmbus_interrupt = desc->irq_data.hwirq;
>> +	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
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

-- 
Thank you,
Roman

