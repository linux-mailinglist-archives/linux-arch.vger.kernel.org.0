Return-Path: <linux-arch+bounces-4430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219668C6B47
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC19F1F24FDA
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B836AF2;
	Wed, 15 May 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bjkvGcg4"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F61E527;
	Wed, 15 May 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792748; cv=none; b=QUU9eGi8leHGtrGKGVKWT+ezZ+49BUuZkW87j7QGbjAEGimUtRp/XY5KEtm3UgLUPcPZXr4lfpKln27bQbu7emlzw0Pta4iNXrjduIUsBxInPCdc1c+Ly2ZU5xf4tvibWe8ki0fpYuH9rRCwrwwUP5/qMq1bppn7jttFIZCI/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792748; c=relaxed/simple;
	bh=3BlrPdBzC3mvUBHtdt+9Ypaev6RoOfs6grz397lU5AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R95yupwfbx57zbiFRCvaqfso2wAuOGxW7cGE+mGeIACphIf+iXdTH7CPiEn2QTFjHl/Y5c2jCbv8dSh7WZmykSPk7XLwb5rY6QYREeOVAa4dtZKKqvktDByTH7Fxz5aDHlgFm74n/hW7aTyy+7IJsWOh7m0EV1wgx3gJ5jl1QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bjkvGcg4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DFF51201F184;
	Wed, 15 May 2024 10:05:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFF51201F184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715792746;
	bh=TlROrZJe+54XR+nvO256Bn9+fCavCEN5dSYWG30Zb5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bjkvGcg4Dak5GjfAg8VmS3mo9TsSsECYXySK9CG/mcqNDyHPDEayGhva/E18FNZnz
	 ad1bkNn3q1zntR8WcaZUfc0ZCinJGcZoW5FeAOhiI2NOcYvsBXuOqJCkywr6zT7E9A
	 vdBbyEJbUS1MMWaj6iDhNpUaEpIPNg+lQ5m25td0=
Message-ID: <9c0dcd26-891e-4ed2-be93-dad6cd65b41e@linux.microsoft.com>
Date: Wed, 15 May 2024 10:05:45 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-6-romank@linux.microsoft.com>
 <ea9ce984-8a07-47a8-9533-a6cea5b318b5@linaro.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <ea9ce984-8a07-47a8-9533-a6cea5b318b5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 12:47 AM, Krzysztof Kozlowski wrote:
> On 15/05/2024 00:43, Roman Kisel wrote:
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
> 
> Where is the binding for this?
> 
Have not added to 
Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml, my bad. Will 
update the file.

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
> 
> Not related and not really helpful. Simple entry/exit tracking is
> provided already by tracing.
> 
True. Will remove.

> 
> Best regards,
> Krzysztof

-- 
Thank you,
Roman

