Return-Path: <linux-arch+bounces-10644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04197A59C32
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C816E01C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE407233724;
	Mon, 10 Mar 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l1AipWqa"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71822D79B;
	Mon, 10 Mar 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626588; cv=none; b=mVe3aiB928ZEqkhgbpofJRFxq1CRpOGXriWhhhmeCr3QWjLierbTXE/90fAtJ1RswfVN2nVQd3nouBbShTrd+casM/xH6br7b2URCp9kIbKq0CCXNVASSniHtBIF5n1Z2sWmlxEuw4iUDP7Gzcbn/H9CVGXwB6F7iRPFFugU3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626588; c=relaxed/simple;
	bh=yVNu05pqKMvUkTRfJJGadIbGslAZMjfMrFefbqDKqXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2RTmOnBwcjSlPXADnO0iaVp7lmFZjUc084/f1+etIhPO59NTbsbaPHB6QpqHtbnAklvGLGILkl0ic5kSLBJFUEdwe0Swm1XzB78IDI8vXNeggsaN7lL7zTWOxrBmQcugIX2giAshJwE3HEeCY42kWeYidOw2138bjFUreGk5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l1AipWqa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DA692038F32;
	Mon, 10 Mar 2025 10:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DA692038F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741626586;
	bh=ZPp0js6+jrg5sVe7XA7ERrTixZv7xjbVVvf7fRlGlAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l1AipWqanSYF7uSInl5in5VBJSpUKdzXNs6Z6Cc5jMQikOncxE6pClVlB5vRa3No/
	 iDoZQTAoQd9hGHqs2vaxzFNRGIT6LEpWYSUp2mlFkdRWAt98W4RXVrPRI1lDqFK6Qv
	 S3kLzNTctjFEFKHQ9Tw6wh1lVjMxr+HbU/Mq8eew=
Message-ID: <e3414583-0437-4fc4-b464-1426e5fe9628@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:09:45 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 09/11] Drivers: hv: vmbus: Introduce
 hv_get_vmbus_root_device()
To: Tianyu Lan <ltykernel@gmail.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-10-romank@linux.microsoft.com>
 <CAMvTesCFZ6sxQp7qqSDjD9idRjVHxh96Sp4betomgFH-OFLZ3Q@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAMvTesCFZ6sxQp7qqSDjD9idRjVHxh96Sp4betomgFH-OFLZ3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/10/2025 6:41 AM, Tianyu Lan wrote:
> On Sat, Mar 8, 2025 at 6:05 AM Roman Kisel <romank@linux.microsoft.com> wrote:
>>
>> The ARM64 PCI code for hyperv needs to know the VMBus root
>> device, and it is private.
>>
>> Provide a function that returns it. Rename it from "hv_dev"
>> as "hv_dev" as a symbol is very overloaded. No functional
>> changes.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> Why change all device's parent to vmbus_root_device?
> 

No changes from my account of the code. Please let me know if I am
misunderstanding the question.

> The ARM64 platform uses the device tree to enumerate vmbus
> devices..  Can we find the root device via device tree? vmbus
> code on the x86 use ACPI and it seems to work via ACPI.
> 
> 

Right, we find it from the DT as shown in the next patch:

+static struct irq_domain *hv_pci_of_irq_domain_parent(void)
+{
+	struct device_node *parent;
+	struct irq_domain *domain;
+
+	parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
+	domain = NULL;
+	if (parent) {
+		domain = irq_find_host(parent);
+		of_node_put(parent);
+	}
+
+	return domain;
+}
+

and later use it for `irq_create_hierarchy()`. Please let me know
if I missed anything in your question.

>> ---
>>   drivers/hv/vmbus_drv.c | 23 +++++++++++++++--------
>>   include/linux/hyperv.h |  2 ++
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index c8474b48dcd2..7bfafe702963 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>>          struct hv_vmbus_device_id id;
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
>> +struct device *hv_get_vmbus_root_device(void)
>> +{
>> +       return vmbus_root_device;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
>> +
>>   static int vmbus_exists(void)
>>   {
>> -       if (hv_dev == NULL)
>> +       if (vmbus_root_device == NULL)
>>                  return -ENODEV;
>>
>>          return 0;
>> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_device)
>>           * On x86/x64 coherence is assumed and these calls have no effect.
>>           */
>>          hv_setup_dma_ops(child_device,
>> -               device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
>> +               device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
>>          return 0;
>>   }
>>
>> @@ -1930,7 +1937,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>>                       &child_device_obj->channel->offermsg.offer.if_instance);
>>
>>          child_device_obj->device.bus = &hv_bus;
>> -       child_device_obj->device.parent = hv_dev;
>> +       child_device_obj->device.parent = vmbus_root_device;
>>          child_device_obj->device.release = vmbus_device_release;
>>
>>          child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
>> @@ -2292,7 +2299,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>>          struct acpi_device *ancestor;
>>          struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>>
>> -       hv_dev = &device->dev;
>> +       vmbus_root_device = &device->dev;
>>
>>          /*
>>           * Older versions of Hyper-V for ARM64 fail to include the _CCA
>> @@ -2383,7 +2390,7 @@ static int vmbus_device_add(struct platform_device *pdev)
>>          struct device_node *np = pdev->dev.of_node;
>>          int ret;
>>
>> -       hv_dev = &pdev->dev;
>> +       vmbus_root_device = &pdev->dev;
>>
>>          ret = of_range_parser_init(&parser, np);
>>          if (ret)
>> @@ -2702,7 +2709,7 @@ static int __init hv_acpi_init(void)
>>          if (ret)
>>                  return ret;
>>
>> -       if (!hv_dev) {
>> +       if (!vmbus_root_device) {
>>                  ret = -ENODEV;
>>                  goto cleanup;
>>          }
>> @@ -2733,7 +2740,7 @@ static int __init hv_acpi_init(void)
>>
>>   cleanup:
>>          platform_driver_unregister(&vmbus_platform_driver);
>> -       hv_dev = NULL;
>> +       vmbus_root_device = NULL;
>>          return ret;
>>   }
>>
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index 7f4f8d8bdf43..1f0851fde041 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -1333,6 +1333,8 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
>>          return dev_get_drvdata(&dev->device);
>>   }
>>
>> +struct device *hv_get_vmbus_root_device(void);
>> +
>>   struct hv_ring_buffer_debug_info {
>>          u32 current_interrupt_mask;
>>          u32 current_read_index;
>> --
>> 2.43.0
>>
>>
> 
> 

-- 
Thank you,
Roman


