Return-Path: <linux-arch+bounces-15329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FECB412C
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 22:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BD73087D6A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578C329C77;
	Wed, 10 Dec 2025 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT/0M17v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BC302CD0;
	Wed, 10 Dec 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402789; cv=none; b=LPEIQA36s24THg1hGOlKfbV0K97zNS/aqCiKTTP0yLAMSA+e4HNfCwkFq4e/nfDTVP/pH85xnq9BMOJHE6AFLHqSu0JH3R1OqecM71tNSHJclts3lGBLMStXnydHbLoaVd1FiDCVHr3FQQ75n5QOLDYaWGZj4bfKBLYX8zK0SAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402789; c=relaxed/simple;
	bh=5pRIxpBxRl7AulJUBlK43AxD0UvUN1i64TGtHpo8nE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FvaaRlsKW+SoEYy6nyIvKqmZjyK+8m/obF+zNs8nOfSNGgCNxNIo0UaO06uhLUgyTzBeRLEc9ueZA3hA2fv9h10evPC5fe99V/jKwJ0yaY6gpTU533ymPfuZH6TJsSjmzrE8w5QNXnhb+fjsayATKVDW2eSQ4jv7fCQ27BBPMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT/0M17v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FECC4CEF1;
	Wed, 10 Dec 2025 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765402787;
	bh=5pRIxpBxRl7AulJUBlK43AxD0UvUN1i64TGtHpo8nE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RT/0M17v5pqvDKvkWhG6SvnyBVuypV2tRmP26c9Wl83/u5rWFLOS27O4ySBP7DZIP
	 4swIvxphfWya1QIcBUwgvfmck7j3R70RQOHFuDEZnP7xbf7McDMOi7g0ZDd/Qmvr9E
	 TGTOz3/dHk+yy7i2AK/C4WgyPogmZFmpaDZziwwdEO4BkMWtA0JMyrAKa7KJZ2fthX
	 bqywMkgtxi0P6pQZFxq4ais/oXJ67nuwcfVJXMX2a4Y82BiRgvbUURLDJ2W8ilUArP
	 FknpLAhMkQWlxvDDkaS7SGpCIR0KRX/Vi1hxyhZNU6AFOgppuUABjEGcEHvjcbPoHx
	 gximRenkH8xDg==
Date: Wed, 10 Dec 2025 15:39:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, mrathor@linux.microsoft.com,
	mhklinux@outlook.com, peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
Message-ID: <20251210213945.GA3541010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209051128.76913-2-zhangyu1@linux.microsoft.com>

On Tue, Dec 09, 2025 at 01:11:24PM +0800, Yu Zhang wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> 
> Hyper-V uses a logical device ID to identify a PCI endpoint device for
> child partitions. This ID will also be required for future hypercalls
> used by the Hyper-V IOMMU driver.
> 
> Refactor the logic for building this logical device ID into a standalone
> helper function and export the interface for wider use.
> 
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>  include/asm-generic/mshyperv.h      |  2 ++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 146b43981b27..4b82e06b5d93 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  
>  #define hv_msi_prepare		pci_msi_prepare
>  
> +/**
> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
> + * function number of the device.
> + */
> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
> +{
> +	struct pci_bus *pbus = pdev->bus;
> +	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
> +						struct hv_pcibus_device, sysdata);
> +
> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
> +		     (hbus->hdev->dev_instance.b[4] << 16) |
> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +		     PCI_FUNC(pdev->devfn));
> +}
> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
> +
>  /**
>   * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
>   * Build new a destination for the MSI and make a hypercall to
> - * update the Interrupt Redirection Table. "Device Logical ID"
> - * is built out of this PCI bus's instance GUID and the function
> - * number of the device.
> + * update the Interrupt Redirection Table.
>   */
>  static void hv_irq_retarget_interrupt(struct irq_data *data)
>  {
> @@ -642,11 +658,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
>  	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
> -	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> -			   (hbus->hdev->dev_instance.b[4] << 16) |
> -			   (hbus->hdev->dev_instance.b[7] << 8) |
> -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> -			   PCI_FUNC(pdev->devfn);
> +	params->device_id = hv_build_logical_dev_id(pdev);
>  	params->int_target.vector = hv_msi_get_int_vector(data);
>  
>  	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 64ba6bc807d9..1a205ed69435 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -71,6 +71,8 @@ extern enum hv_partition_type hv_curr_partition_type;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>  
> +extern u64 hv_build_logical_dev_id(struct pci_dev *pdev);

Curious why you would include the "extern" in this declaration?  It's
not *wrong*, but it's not necessary, and other declarations in this
file omit it, e.g., the ones below:

>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> -- 
> 2.49.0
> 

