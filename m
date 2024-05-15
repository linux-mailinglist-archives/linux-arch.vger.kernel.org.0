Return-Path: <linux-arch+bounces-4416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1498C641F
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 11:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F61E1F21395
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012835916B;
	Wed, 15 May 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sbsC2YkB"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856331DFFD;
	Wed, 15 May 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766501; cv=none; b=LGDa+XMBs2ZNoY51t1yKqJZH02JCW9OBgtc9QR4UX03+KPKoSzjOW582jj8xGF6RLR9cKk3oN9DM65oYbubS32HCkZEva5L8XO3f8XdqmyVzWI/RfJzujwbjdjiAk6Meew7yDoPSD+X/ajAGfK4/bPkPceY9zf5zJMws9pStJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766501; c=relaxed/simple;
	bh=DWMXLBoPPceddodR+n4Z64JB4Nh2VGdGGIpJtZw0Vks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEWB+RRS03Eck9wUGbJxa9gmpVRootmyoekgi0wUudAFLAY37onHzxWijnN4m5dHg6de3qnJOb/a7hPzHxFVIWbOwNN+IW6wRSfrlQyWax51uzycll9l1+P/wfpjgRbVDaC23hk2L3r+pf/vBgYGKeO7XNRpW++RUM3HivjpvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sbsC2YkB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1FB0C20B2C82; Wed, 15 May 2024 02:48:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FB0C20B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715766500;
	bh=RP6KAOAdizMehQEBvNjNqD2oKi1HizOL3blKYGvIfEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbsC2YkBDl7aC0npjPyjeCm95s6BBpPfjSk3E8X2TeZQwS5J2/1yIFjgCGxnuSsQU
	 ujq0fSAdTMPJl9hvAwZKYr7KhdPGT5h9ZJ2fjwT1quUd4+zKqBhr4WqcGAXGW+8ssf
	 V+qbxOCk4LCO5W6A63L+E2x2aTAL6PjVkGTAiqDw=
Date: Wed, 15 May 2024 02:48:20 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
	rafael@kernel.org, robh@kernel.org, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain
 from DT
Message-ID: <20240515094820.GB22844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-7-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224508.212318-7-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
> on arm64 thereby it won't be able to do that in the VTL mode where
> only DeviceTree can be used.
> 
> Update the hyperv-pci driver to discover interrupt configuration
> via DeviceTree.

Subject prefix should be "PCI: hv:"

> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
>  include/linux/acpi.h                |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1eaffff40b8d..ccc2b54206f4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -906,9 +906,16 @@ static int hv_pci_irqchip_init(void)
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
>  	 */
> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +	if (acpi_disabled)
> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
> +			irq_find_matching_fwnode(fn, DOMAIN_BUS_ANY),
> +			0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +	else
> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);

Upto 100 characters per line are supported now, we can have less
line breaks.

>  
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..498cbb2c40a1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1077,6 +1077,15 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>  	return false;
>  }
>  
> +static inline struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> +					     unsigned int size,
> +					     struct fwnode_handle *fwnode,
> +					     const struct irq_domain_ops *ops,
> +					     void *host_data)
> +{
> +	return NULL;
> +}
> +
>  #endif	/* !CONFIG_ACPI */
>  
>  extern void arch_post_acpi_subsys_init(void);
> -- 
> 2.45.0
> 

