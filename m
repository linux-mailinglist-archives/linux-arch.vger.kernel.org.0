Return-Path: <linux-arch+bounces-10640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE9A59B70
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77505188673F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAB2459CE;
	Mon, 10 Mar 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyxqHbUG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB02459C3;
	Mon, 10 Mar 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624884; cv=none; b=Uq88rh7NliFi3c3/dwsPKkj3N0r0mHHK2oAW5Se9mPUihcsUz94LsUrfHO7gcQQpvNCrYq9+MUdKEGWFQnkL86p0HUXXHL4EkKG06BEfnUMo1YTq3AmOBgG57pShE0f4jW3OQgFQwD+ySlmZwu4fLNhvLyOMHgrGaNIy9qjfuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624884; c=relaxed/simple;
	bh=5Zuw8hUznANvPIatpdN56MqZ7+mKjrGRf7vCtpf94D0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WDC2SkrHx2Ed/ZJdZbSPpszf48SdqnV5L7nAyqcS2LSyczP7Ciwy1oUZp8lZ/QN8lFqhlrFt637tkFm6OQX/HJCqo4PYiFN+ozD726NQbMzE5Oc65OWSAob2Jbb2zhNVWLRapXR5bAXf7CXBCc/rH4+HeFH0xFnxXNcELzUMNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyxqHbUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3255C4CEF0;
	Mon, 10 Mar 2025 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741624883;
	bh=5Zuw8hUznANvPIatpdN56MqZ7+mKjrGRf7vCtpf94D0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CyxqHbUGsjYvKn3FVeZW/HuHfKPBRCxzzMTwqiKjtFiHxte4Vl4VInowvl3wTArrR
	 KjsnWZEtuvQbglKKZvNcoKFaIHuNgmgJYhS9Ph1M5IqCLQekQz2MvMokEkOMw7yI4x
	 U3M8RkVwlPfEyTLSdIXuzi2aAGNoryqqYAsha8k6NC8RCKm1qsVPonTRNPoDaqVEwl
	 cHU+8bafTy3sVee3mmZ8P6TDGY0xHFkich12lMdI5zeUF1LZuwel7kFhCcCOMv0fyy
	 keIiZ83UKBImR3PyAuTistfB30rkUl1VlgBzBr/GvKYEr1maJBd8mYEFv91an5Bu4Q
	 ABY+QXm8lP0kA==
Date: Mon, 10 Mar 2025 11:41:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com,
	krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
	lenb@kernel.org, lpieralisi@kernel.org,
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
Subject: Re: [PATCH hyperv-next v5 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Message-ID: <20250310164122.GA551965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307220304.247725-12-romank@linux.microsoft.com>

On Fri, Mar 07, 2025 at 02:03:03PM -0800, Roman Kisel wrote:
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
> 
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

A couple minor comments below, but I don't have any objection to this,
so if it's OK with the pci-hyperv.c folks, it's OK with me.

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
> +	return domain;

I think this would be a little simpler as:

  parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
  if (!parent)
    return NULL;

  domain = irq_find_host(parent);
  of_node_put(parent);
  return domain;

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
> +	domain = irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +				     DOMAIN_BUS_ANY);
> +
> +	if (!domain)
> +		return NULL;
> +
> +	return domain;

  if (!domain)
    return NULL;

  return domain;

is the same as:

  return domain;

or even just:

  return irq_find_matching_fwnode(gsi_domain_disp_fn(0), DOMAIN_BUS_ANY);

> +}

