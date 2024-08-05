Return-Path: <linux-arch+bounces-5972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF4947D39
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76781C21C94
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268C13C9C4;
	Mon,  5 Aug 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X8ffdVm0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150813C684;
	Mon,  5 Aug 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869481; cv=none; b=teCxQbrishUMDt6x4zyV4Fkc1XYI7VRkeo9oRA5fUfWh2XtSll1HaV57EM/GSWD0hulKI+jen5ExCt59RnXFA7zB39M6fkwe6DhrdDp/YTd/ww7FIGiKxiVES48oMPY6UR5c5o+tyOXlLaWBQYLPImCsxO4HjOiimTVG9VLtIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869481; c=relaxed/simple;
	bh=7ykty8/x0wz5UdqrPTbpaCVE/KB7yVy+KsHezueQZPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZfO4wqSAWHw8B4wapcrT5vC9yBpv6P9zDyvDhIV7zhHksQiFcSSus/A+220W8YFz8nDdgg+6C8BLWmSJLYz6OG21KSZuhMk/njrhrg54k9NbPYacwhLR4OBmSUj33a94fWBcShHLpKHF0z4ATUrVAN9kiNUqilBN/hs/SL2FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X8ffdVm0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F41B20B7165;
	Mon,  5 Aug 2024 07:51:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F41B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722869478;
	bh=pauF332H9RYtwbTh4jt8TXNF4EdtpJCWqYxBIdY4ptU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X8ffdVm0EwvH9cISLR9ZZZRKprEo04Um0VqddaKwHaaG5FXXTy/B3AVHowWL2FIkF
	 vn6mm0I6ZO0vdpHX+1dlYa6XsD2FOGm9nrXMQFEXjkEePfTn662n16Sr99C7sAz/Ii
	 ACauUgAQ7XzRLcxcOjk8N8fMfsudY9DdAsBUfPJI=
Message-ID: <2679199c-3f73-4326-85ee-622541d26153@linux.microsoft.com>
Date: Mon, 5 Aug 2024 07:51:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
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
 <20240726225910.1912537-8-romank@linux.microsoft.com>
 <Zq2F-l2FWIrQ2Jt1@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Zq2F-l2FWIrQ2Jt1@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/2/2024 6:20 PM, Wei Liu wrote:
> On Fri, Jul 26, 2024 at 03:59:10PM -0700, Roman Kisel wrote:
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
>> arm64. It won't be able to do that in the VTL mode where only DeviceTree
>> can be used.
>>
>> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
>> case, too.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c              | 23 +++++++-----
>>   drivers/pci/controller/pci-hyperv.c | 55 +++++++++++++++++++++++++++--
>>   include/linux/hyperv.h              |  2 ++
>>   3 files changed, 69 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 7eee7caff5f6..038bd9be64b7 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>>   	struct hv_vmbus_device_id id;
>>   };
>>   
>> -static struct device  *hv_dev;
>> +/* VMBus Root Device */
>> +static struct device  *vmbus_root_device;
> 
> You're changing the name of the variable. That should preferably be done
> in a separate patch. That's going to make this patch shorter and easier
> to review.
> 
Will fix in v4, thanks!

>>   
>>   static int hyperv_cpuhp_online;
>>   
>> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>>   static struct resource *hyperv_mmio;
>>   static DEFINE_MUTEX(hyperv_mmio_lock);
>>   
>> +struct device *get_vmbus_root_device(void)
>> +{
>> +	return vmbus_root_device;
>> +}
>> +EXPORT_SYMBOL_GPL(get_vmbus_root_device);
> 
> I would like you to add "hv_" prefix to this exported symbol, or rename
> it to "vmbus_get_root_device()".
> 
>> +
>>   static int vmbus_exists(void)
>>   {
>> -	if (hv_dev == NULL)
>> +	if (vmbus_root_device == NULL)
>>   		return -ENODEV;
>>   
>>   	return 0;
>> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_device)
>>   	 * On x86/x64 coherence is assumed and these calls have no effect.
>>   	 */
>>   	hv_setup_dma_ops(child_device,
>> -		device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
>> +		device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
>>   	return 0;
>>   }
>>   
>> @@ -1892,7 +1899,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>>   		     &child_device_obj->channel->offermsg.offer.if_instance);
>>   
>>   	child_device_obj->device.bus = &hv_bus;
>> -	child_device_obj->device.parent = hv_dev;
>> +	child_device_obj->device.parent = vmbus_root_device;
>>   	child_device_obj->device.release = vmbus_device_release;
>>   
>>   	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
>> @@ -2253,7 +2260,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>>   	struct acpi_device *ancestor;
>>   	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>>   
>> -	hv_dev = &device->dev;
>> +	vmbus_root_device = &device->dev;
>>   
>>   	/*
>>   	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
>> @@ -2342,7 +2349,7 @@ static int vmbus_device_add(struct platform_device *pdev)
>>   	struct device_node *np = pdev->dev.of_node;
>>   	int ret;
>>   
>> -	hv_dev = &pdev->dev;
>> +	vmbus_root_device = &pdev->dev;
>>   
>>   	ret = of_range_parser_init(&parser, np);
>>   	if (ret)
>> @@ -2675,7 +2682,7 @@ static int __init hv_acpi_init(void)
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (!hv_dev) {
>> +	if (!vmbus_root_device) {
>>   		ret = -ENODEV;
>>   		goto cleanup;
>>   	}
>> @@ -2706,7 +2713,7 @@ static int __init hv_acpi_init(void)
>>   
>>   cleanup:
>>   	platform_driver_unregister(&vmbus_platform_driver);
>> -	hv_dev = NULL;
>> +	vmbus_root_device = NULL;
>>   	return ret;
>>   }
>>   
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 5992280e8110..cdecefd1f9bd 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -50,6 +50,7 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/acpi.h>
>>   #include <linux/sizes.h>
>> +#include <linux/of_irq.h>
>>   #include <asm/mshyperv.h>
>>   
>>   /*
>> @@ -887,6 +888,35 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
>>   	.activate = hv_pci_vec_irq_domain_activate,
>>   };
>>   
>> +#ifdef CONFIG_OF
>> +
>> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
>> +{
>> +	struct device_node *parent;
>> +	struct irq_domain *domain;
>> +
>> +	parent = of_irq_find_parent(to_platform_device(get_vmbus_root_device())->dev.of_node);
>> +	domain = NULL;
>> +	if (parent) {
>> +		domain = irq_find_host(parent);
>> +		of_node_put(parent);
>> +	}
>> +
> 
> I cannot really comment on the ARM side of things around how this system
> is set up. I will leave that to someone who's more familiar with the
> matter to review.
> 
> Thanks,
> Wei.

-- 
Thank you,
Roman


