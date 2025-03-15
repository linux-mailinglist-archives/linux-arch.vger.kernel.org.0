Return-Path: <linux-arch+bounces-10891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3EA631E2
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF947A9614
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9B195808;
	Sat, 15 Mar 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC2mtGbh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F0189916;
	Sat, 15 Mar 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064546; cv=none; b=on/vNjQsMBtG3fbaWYmRFU1YNGW99tJruuOmfkMTwOs8nL/fBEOZao2TQIhMCR15PFUKvUgPxfZ7pMh3gxtv+dJd0HN+rhzDYrsgEm988tEoWQq+1AqSOqAh2hDRM82LrBdXa4fjO2mqqwEPsSkWd2kUZ5IvFpjdmM48nraBI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064546; c=relaxed/simple;
	bh=OnKnsixMsIfR9PWM2GKcKb1NM2Qu2lps2DgKe5a/iVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r1BfnLxOBNdRXT3chfqL7LhFiiZsERPdKkpa0tcmdgaXGr2DLnzB6EaLXd0FKAG7Tpk8IE7Nqzpw+dJxld53r6uO4G9kpEQNW63w+sDnetIp9pr3FtIEme38BaSFP/Ex3QQaPiNFGQExwPWC6EhZjqIiWm9EFFihhaxcp/t+i2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC2mtGbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D6FC4CEE5;
	Sat, 15 Mar 2025 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064544;
	bh=OnKnsixMsIfR9PWM2GKcKb1NM2Qu2lps2DgKe5a/iVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SC2mtGbhf3T7iUSmBYdVeklwCEwI13OQ6a3CqVJG9hdTduV8tMC8viwCK5PQ5svgt
	 yEFwpbQLSaMovvNo1DNNefn270I4Y9SmAYepdWmGF1MrsZeUpF0i3fAo4inK54pOG0
	 L1gMGSoCR0of0daaOOodYfCP662k/xMF040MMUZ9NsYjiQXym4MYKxKO7qDvid3sTo
	 WkOrWCyoYBuXRICkq5ZpEQyirDW90mN0J2qI74H3xxsjoI9IxeZATbGITayZiz9pZQ
	 AIQvWwR+kA/Me6BczXJbR4gkhcjMt2l5z0GTgKpd4AhA2hUQVs02M2A1EHulV0TXJU
	 dR2CF94O0F6cw==
Date: Sat, 15 Mar 2025 13:49:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dan.carpenter@linaro.org, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
	kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
	maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev,
	rafael@kernel.org, robh@kernel.org, ssengar@linux.microsoft.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com,
	devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Message-ID: <20250315184903.GA848938@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315001931.631210-12-romank@linux.microsoft.com>

On Fri, Mar 14, 2025 at 05:19:31PM -0700, Roman Kisel wrote:
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
> 
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me; trivial whitespace comment below.

> ---
>  drivers/pci/controller/pci-hyperv.c | 73 ++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6084b38bdda1..cbff19e8a07c 100644
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
> @@ -887,10 +896,47 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
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
> +	if (!parent)
> +		return NULL;
> +	domain = irq_find_host(parent);
> +	of_node_put(parent);
> +
> +	return domain;
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
> +{
> +	struct irq_domain *domain;
> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
> +
> +	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
> +		return NULL;
> +	gsi_domain_disp_fn = acpi_get_gsi_dispatcher();
> +	if (!gsi_domain_disp_fn)
> +		return NULL;
> +	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +				     DOMAIN_BUS_ANY);
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
>  	struct fwnode_handle *fn = NULL;
> +	struct irq_domain *irq_domain_parent = NULL;
>  	int ret = -ENOMEM;
>  
>  	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> @@ -907,9 +953,24 @@ static int hv_pci_irqchip_init(void)
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
>  	 */
> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		irq_domain_parent = hv_pci_acpi_irq_domain_parent();
> +#endif
> +#if defined(CONFIG_OF)
> +	if (!irq_domain_parent)
> +		irq_domain_parent = hv_pci_of_irq_domain_parent();
> +#endif
> +	if (!irq_domain_parent) {
> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
> +		ret = -EINVAL;
> +		goto free_chip;
> +	}
> +
> +	hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
> +		irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
> +		fn, &hv_pci_domain_ops,
> +		chip_data);

This is a different style of indenting the parameters than other
similar cases in this file, which line up parameters on subsequent
lines under the open parenthesis.

>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> -- 
> 2.43.0
> 

