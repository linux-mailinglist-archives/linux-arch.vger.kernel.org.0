Return-Path: <linux-arch+bounces-5988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604A947F5D
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 18:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85561C21168
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8C1591F0;
	Mon,  5 Aug 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nGWIptCO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8E2D7B8;
	Mon,  5 Aug 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875455; cv=none; b=MMQbfDLqp+9f41qFoYscZ73odgJsUssI9n1HghJMHrJ818PyvsG4McwTCMya5AyyXe2V3fUORXP30pxoNFGMQUoOXHYDPywPK6jKoGnSuodgQEjWQ2xen4P4JHUgVCWL+YDD6WjLAyRbNLE0F/8RlVxQoOQbo+Fhcnzv3w7kyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875455; c=relaxed/simple;
	bh=Iva8b8kTU8b/cjbIgVQupXCjkBRFLveCYsjechSqTsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpE4UAAGsxGq/hVqpiAl6d8xF7IP49VZeAokGH1hwUJOnDaxJSny25S3Lp6N9pYlNMMuSNp/BJ6sCK7Q/uEe7MsCkDQ5VRUaQNdvFHWCAtrFJP+YQxkL9Y+n2J5STeEcfvnBunHJ5WJMN3ju0xntBiS05UOFdI1NTfL92XUZUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nGWIptCO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id B79D420B7165;
	Mon,  5 Aug 2024 09:30:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B79D420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722875453;
	bh=OdRa7JogdAe4OsRKdZDtCLOwSHuOnd3sa5a9IhaNzD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nGWIptCOU3Hw/uCeSLbzwgPrYaldsRGyYFPpHR2hegELwsFlZ+ae6voF1g+6F46qh
	 rLV3C6fJ7vfGmqLm8yEsWhgqmZeHoGGh1fOSe7tlh6WI1yM0nKfTxILmVKLNDaHYAs
	 DpNY6G432ORc9dXW36yO7m93gg9zCJka7njvFSgw=
Message-ID: <a8e4cd69-9920-458e-b405-a9a72ecd0b4b@linux.microsoft.com>
Date: Mon, 5 Aug 2024 09:30:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
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
 <20240726225910.1912537-8-romank@linux.microsoft.com>
 <SN6PR02MB4157D5A2DA10658D506EA1B1D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D5A2DA10658D506EA1B1D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2024 8:03 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 3:59 PM
>>
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
>> arm64. It won't be able to do that in the VTL mode where only DeviceTree
>> can be used.
>>
>> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
>> case, too.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> Overall, this makes sense to me, and I think it works. As you noted in the cover
> letter for the patch series, it's a bit messy.  But see my two comments below.
> 
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
> 
> I think the above can be simplified to:
> 
> 	parent = of_irq_find_parent(get_vmbus_root_device()->of_node);
> 
> Converting the vmbus_root_device to the platform device, and then accessing
> the "dev" field of the platform device puts you back where you started with
> the vmbus_root_device.  See the code in vmbus_device_add() where the
> vmbus_root_device is set to the dev field of the platform device.
> 
Appreciate your help with making this code looks better! Will try your 
suggestion out!

>> +	domain = NULL;
>> +	if (parent) {
>> +		domain = irq_find_host(parent);
>> +		of_node_put(parent);
>> +	}
>> +
>> +	/*
>> +	 * `domain == NULL` shouldn't happen.
>> +	 *
>> +	 * If somehow the code does end up in that state, treat this as a configuration
>> +	 * issue rather than a hard error, emit a warning, and let the code proceed.
>> +	 * The NULL parent domain is an acceptable option for the `irq_domain_create_hierarchy`
>> +	 * function called later.
>> +	 */
>> +	if (!domain)
>> +		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n");
>> +	return domain;
>> +}
> 
> Here's a thought, which may or may not be a good one:  Push some or all
> the functionality of hv_pci_of_irq_domain_parent() into vmbus_device_add().
> In the simplest case, have vmbus_device_add() store the of_node (which is
> already the "np" local variable) in a global static variable, and provide
> hv_get_vmbus_of_node() instead of get_vmbus_root_device().
> 
> The next step to consider would be to compute the parent in
> vmbus_device_add(), and provide hv_get_vmbus_parent_of_node() instead
> of hv_get_vmbus_of_node(). One difference is that vmbus_device_add()
> runs for both x86 and arm64, while hv_pci_of_irq_domain_parent() is for
> arm64 only.  The parent node may not exist on x86, but maybe that isn't
> really a problem.
> 
> Pushing everything into vmbus_device_add() would entail doing the
> irq_find_host(parent) as well, and the accessor function would just
> return the IRQ domain. In that case, hv_pci_of_irq_domain_parent()
> can go away. The domain might be NULL on x86, but that's OK
> because the accessor function won't be called on x86.
> 
> Maybe there's a snag that prevents this idea from working well,
> particularly on x86 where the domain will be NULL. But if it works,
> it seems slightly less messy to me, though that is a judgment call.
> I'll leave it to you to decide, and I'm OK either way. :-)
> 
I'll explore your great idea, thanks for sharing! Since v1 this code has 
improved quite a bit thanks to your suggestions :)

> Michael
> 
>> +
>> +#endif
>> +
>>   static int hv_pci_irqchip_init(void)
>>   {
>>   	static struct hv_pci_chip_data *chip_data;
>> @@ -906,10 +936,29 @@ static int hv_pci_irqchip_init(void)
>>   	 * IRQ domain once enabled, should not be removed since there is no
>>   	 * way to ensure that all the corresponding devices are also gone and
>>   	 * no interrupts will be generated.
>> +	 *
>> +	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
>> +	 * subsystem, and it is the default GSI domain pointing to the GIC.
>> +	 * Neither is available outside of the ACPI subsystem, cannot avoid
>> +	 * the messy ifdef below.
>> +	 * There is apparently no such default in the OF subsystem, and
>> +	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
>> +	 * points to the GIC as well.
>> +	 * None of these two cases reaches for the MSI parent domain.
>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +#ifdef CONFIG_ACPI
>> +	if (!acpi_disabled)
>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
>> +#if defined(CONFIG_OF)
>> +	if (!hv_msi_gic_irq_domain)
>> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
>>
>>   	if (!hv_msi_gic_irq_domain) {
>>   		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index 5e39baa7f6cb..b4aa1f579a97 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -1346,6 +1346,8 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
>>   	return dev_get_drvdata(&dev->device);
>>   }
>>
>> +struct device *get_vmbus_root_device(void);
>> +
>>   struct hv_ring_buffer_debug_info {
>>   	u32 current_interrupt_mask;
>>   	u32 current_read_index;
>> --
>> 2.34.1
>>

-- 
Thank you,
Roman


