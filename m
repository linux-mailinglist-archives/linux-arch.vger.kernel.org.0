Return-Path: <linux-arch+bounces-10917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C06A659FB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB37319C27B3
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDDF1AC458;
	Mon, 17 Mar 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MU0M1OS/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E91AAA1E;
	Mon, 17 Mar 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231225; cv=none; b=Oietrk9lBWkm4yi9/m/YASgBp1ABhsNmSu/orC4SCfkjL9Lp21+qK2pkdcjPn7nxdWdljhUT5kiD4kCErdwngbWeguTrf6dnRRg1CW1H0Rrebph5JKoM83nEyxivmmL6XXPMhKlWjbplekrhqNhG9/ndKqsaQUp8KepCESzOMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231225; c=relaxed/simple;
	bh=7tPScfD9PU8GwL510NRuJpyMhhbfKbW53uXGSxQrROM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdA3ehNdmt1Q1c8OvLjRoGUJ1iYWnTc1Dx0CH8nEmObYnmaZ/ijrsiS3uFOdaxjDhdUKuHdujxBGl4gANUBKkcok6iXoOqQOMz52KKhmB+u/jPwx+IAg+35va9TPs5O7D2l4/jLXmw5Fewr2evi9GXACOMnmAjVnLBWuA/tLdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MU0M1OS/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id F377E2033444;
	Mon, 17 Mar 2025 10:07:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F377E2033444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742231223;
	bh=pVVBjR0mSZEIXZn2jj+yPFFn+SpqZ/2BXJvya8/hhRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MU0M1OS/SvjdiBbQjAOJYZVPoksU5Sb1yCAuzxLUPv37SeuxHwFF7pbmInik5NNNf
	 ujAGpzMt6UzTDHpp2h9YUMIjgxST9XFEazJyWc/ho17h+5D8kAGPqKrOHOkNjLv0Ub
	 nO3vFYqx3hqhVWLCI6WxBr/n/WIQUkrc9WLiqbi4=
Message-ID: <9c3f2492-823e-4548-8ad3-6aeb9c86d528@linux.microsoft.com>
Date: Mon, 17 Mar 2025 10:07:02 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org,
 mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org,
 robh@kernel.org, ssengar@linux.microsoft.com, sudeep.holla@arm.com,
 suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250315184903.GA848938@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250315184903.GA848938@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/15/2025 11:49 AM, Bjorn Helgaas wrote:
> On Fri, Mar 14, 2025 at 05:19:31PM -0700, Roman Kisel wrote:
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
>> arm64. It won't be able to do that in the VTL mode where only DeviceTree
>> can be used.
>>
>> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
>> case, too.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Looks good to me; trivial whitespace comment below.
> 

Thanks a bunch!! I'll fix that the whitespace (and remove the unused
variable the robot noticed).

>> ---
>>   drivers/pci/controller/pci-hyperv.c | 73 ++++++++++++++++++++++++++---
>>   1 file changed, 67 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 6084b38bdda1..cbff19e8a07c 100644
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
>> @@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
>>   	int ret;
>>   
>>   	fwspec.fwnode = domain->parent->fwnode;
>> -	fwspec.param_count = 2;
>> -	fwspec.param[0] = hwirq;
>> -	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
>> +	if (is_of_node(fwspec.fwnode)) {
>> +		/* SPI lines for OF translations start at offset 32 */
>> +		fwspec.param_count = 3;
>> +		fwspec.param[0] = 0;
>> +		fwspec.param[1] = hwirq - 32;
>> +		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
>> +	} else {
>> +		fwspec.param_count = 2;
>> +		fwspec.param[0] = hwirq;
>> +		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
>> +	}
>>   
>>   	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>>   	if (ret)
>> @@ -887,10 +896,47 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
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
>> +	parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
>> +	if (!parent)
>> +		return NULL;
>> +	domain = irq_find_host(parent);
>> +	of_node_put(parent);
>> +
>> +	return domain;
>> +}
>> +
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +
>> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
>> +{
>> +	struct irq_domain *domain;
>> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
>> +
>> +	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
>> +		return NULL;
>> +	gsi_domain_disp_fn = acpi_get_gsi_dispatcher();
>> +	if (!gsi_domain_disp_fn)
>> +		return NULL;
>> +	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
>> +				     DOMAIN_BUS_ANY);
>> +}
>> +
>> +#endif
>> +
>>   static int hv_pci_irqchip_init(void)
>>   {
>>   	static struct hv_pci_chip_data *chip_data;
>>   	struct fwnode_handle *fn = NULL;
>> +	struct irq_domain *irq_domain_parent = NULL;
>>   	int ret = -ENOMEM;
>>   
>>   	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
>> @@ -907,9 +953,24 @@ static int hv_pci_irqchip_init(void)
>>   	 * way to ensure that all the corresponding devices are also gone and
>>   	 * no interrupts will be generated.
>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +#ifdef CONFIG_ACPI
>> +	if (!acpi_disabled)
>> +		irq_domain_parent = hv_pci_acpi_irq_domain_parent();
>> +#endif
>> +#if defined(CONFIG_OF)
>> +	if (!irq_domain_parent)
>> +		irq_domain_parent = hv_pci_of_irq_domain_parent();
>> +#endif
>> +	if (!irq_domain_parent) {
>> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
>> +		ret = -EINVAL;
>> +		goto free_chip;
>> +	}
>> +
>> +	hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +		irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
>> +		fn, &hv_pci_domain_ops,
>> +		chip_data);
> 
> This is a different style of indenting the parameters than other
> similar cases in this file, which line up parameters on subsequent
> lines under the open parenthesis.
> 
>>   	if (!hv_msi_gic_irq_domain) {
>>   		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
>> -- 
>> 2.43.0
>>

-- 
Thank you,
Roman


