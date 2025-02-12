Return-Path: <linux-arch+bounces-10133-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF3A32DA7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075807A12B0
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B425A63F;
	Wed, 12 Feb 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+RzxopB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99021255E5D;
	Wed, 12 Feb 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382125; cv=none; b=ARDGUFPdAwGComw3E56+t5pcBhl4driS9y5250HOccxrDR1neIQIyJV3w8X4TXvN8wbVKa32Rx3grGTdcAOe2mQpD8iwLP69PTQjNMyr/V6QQ/RMNyS2+Gxfm/LyEnn4iOxctBskFb8r//2KHrqgQUL7JsUrdC/ODw3RfDEY39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382125; c=relaxed/simple;
	bh=loNBIWe8uSSK8MAm/lf+M/kKR/0mRHHG8PYDOBq+xPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H5wrKrcxRF+MFrSTme/iJkovl0Prhg4F8PMJJUNE2JTvEFTNIt1OLn09oEC407Zc7ucBMYL3UzS4or9bS6uEFdFSzkn4b2/ha5P4sAnPwtYeDUHyRibe/prxO69rS+iy/rm1j7CcoqUWZRdKxEsBk2n81dxgqc3DKQxiwnPpmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+RzxopB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66E2C4CEE2;
	Wed, 12 Feb 2025 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382125;
	bh=loNBIWe8uSSK8MAm/lf+M/kKR/0mRHHG8PYDOBq+xPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W+RzxopBTChGcE+WL5peQSt0RWDQzGw0kUNuri+IQ4+lXJu+zU60qp5tNIotiBATK
	 96RBcAeYiWClh7IBvJYdy14puLeSJyKQirlBYegqIASiHk/iAii68C5UUCZ7RBCxhF
	 0748nlgv7C2Pgn1+QMfqZBY1pn6nPkKbkNi352w8nmyJbuz3ZEIOfKHZEAwnrEUV8q
	 Xv8gHr9cysmZVO1KJLOI8QTw+KHKInXTH7ihIL0NFLcW1/lsQnw/JSRiPevZv+FPTv
	 maOhICE2pw8B796s9kqxur6Ojm+GJ0IXuJ3DyqYrWSN+3AS2toF7Bn6U7wPUz0I9Vd
	 WaVZSuo95ukRQ==
Date: Wed, 12 Feb 2025 11:42:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, krzk+dt@kernel.org,
	kw@linux.com, kys@microsoft.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, mingo@redhat.com, robh@kernel.org,
	ssengar@linux.microsoft.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
Message-ID: <20250212174203.GA81135@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212014321.1108840-7-romank@linux.microsoft.com>

On Tue, Feb 11, 2025 at 05:43:21PM -0800, Roman Kisel wrote:
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
> 
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c              | 23 ++++++----
>  drivers/pci/controller/pci-hyperv.c | 69 ++++++++++++++++++++++++++---
>  include/linux/hyperv.h              |  2 +
>  3 files changed, 80 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 9d0c2dbd2a69..3f0f9f01b520 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>  
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;
>  
>  static int hyperv_cpuhp_online;
>  
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>  
> +struct device *hv_get_vmbus_root_device(void)
> +{
> +	return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
> +
>  static int vmbus_exists(void)
>  {
> -	if (hv_dev == NULL)
> +	if (vmbus_root_device == NULL)
>  		return -ENODEV;
>  
>  	return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_device)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
> +		device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
>  	return 0;
>  }
>  
> @@ -1920,7 +1927,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>  
>  	child_device_obj->device.bus = &hv_bus;
> -	child_device_obj->device.parent = hv_dev;
> +	child_device_obj->device.parent = vmbus_root_device;
>  	child_device_obj->device.release = vmbus_device_release;
>  
>  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> @@ -2282,7 +2289,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>  	struct acpi_device *ancestor;
>  	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  
> -	hv_dev = &device->dev;
> +	vmbus_root_device = &device->dev;
>  
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2373,7 +2380,7 @@ static int vmbus_device_add(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
> -	hv_dev = &pdev->dev;
> +	vmbus_root_device = &pdev->dev;
>  
>  	ret = of_range_parser_init(&parser, np);
>  	if (ret)
> @@ -2692,7 +2699,7 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>  
> -	if (!hv_dev) {
> +	if (!vmbus_root_device) {
>  		ret = -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2723,7 +2730,7 @@ static int __init hv_acpi_init(void)
>  
>  cleanup:
>  	platform_driver_unregister(&vmbus_platform_driver);
> -	hv_dev = NULL;
> +	vmbus_root_device = NULL;
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index cdd5be16021d..24725bea9ef1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>  
>  /*
> @@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
>  	int ret;
>  
>  	fwspec.fwnode = domain->parent->fwnode;
> -	fwspec.param_count = 2;
> -	fwspec.param[0] = hwirq;
> -	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> +	if (is_of_node(fwspec.fwnode)) {
> +		/* SPI lines for OF translations start at offset 32 */
> +		fwspec.param_count = 3;
> +		fwspec.param[0] = 0;
> +		fwspec.param[1] = hwirq - 32;
> +		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +	} else {
> +		fwspec.param_count = 2;
> +		fwspec.param[0] = hwirq;
> +		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> +	}
>  
>  	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>  	if (ret)
> @@ -887,6 +896,35 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
>  	.activate = hv_pci_vec_irq_domain_activate,
>  };
>  
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
> +	domain = NULL;
> +	if (parent) {
> +		domain = irq_find_host(parent);
> +		of_node_put(parent);
> +	}
> +
> +	/*
> +	 * `domain == NULL` shouldn't happen.
> +	 *
> +	 * If somehow the code does end up in that state, treat this as a configuration
> +	 * issue rather than a hard error, emit a warning, and let the code proceed.
> +	 * The NULL parent domain is an acceptable option for the `irq_domain_create_hierarchy`
> +	 * function called later.

The rest of this file fits in 80 columns; please wrap this to match.

> +	 */
> +	if (!domain)
> +		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n");

Is there a way to include a hint about what specific part of the
devicetree to look at, e.g., the node that lacks a parent?

> +	return domain;
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
> @@ -906,10 +944,29 @@ static int hv_pci_irqchip_init(void)
>  	 * IRQ domain once enabled, should not be removed since there is no
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
> +	 *
> +	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
> +	 * subsystem, and it is the default GSI domain pointing to the GIC.
> +	 * Neither is available outside of the ACPI subsystem, cannot avoid
> +	 * the messy ifdef below.

Add a blank line if you intend a new paragraph here.  Otherwise, wrap
to fill 78 columns or so.

> +	 * There is apparently no such default in the OF subsystem, and
> +	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
> +	 * points to the GIC as well.

And here.

> +	 * None of these two cases reaches for the MSI parent domain.

I don't know what "reaches for the MSI parent domain" means.  Neither
"searches for"?

>  	 */
> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif
> +#if defined(CONFIG_OF)
> +	if (!hv_msi_gic_irq_domain)
> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif

I don't know if acpi_irq_create_hierarchy() is helping or hurting
here.  It obscures the fact that the only difference is the first
argument to irq_domain_create_hierarchy().  If we could open-code or
have a helper to figure out that irq_domain "parent" argument for the
ACPI case, then we'd only have one call of
irq_domain_create_hierarchy() here and it seems like it might be
simpler.

>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 4179add2864b..2be4dd83b0e1 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1333,6 +1333,8 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
>  	return dev_get_drvdata(&dev->device);
>  }
>  
> +struct device *hv_get_vmbus_root_device(void);
> +
>  struct hv_ring_buffer_debug_info {
>  	u32 current_interrupt_mask;
>  	u32 current_read_index;
> -- 
> 2.43.0
> 

