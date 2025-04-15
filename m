Return-Path: <linux-arch+bounces-11415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D1A8A958
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 22:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6CB17C5C7
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FA25523C;
	Tue, 15 Apr 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvYdAmJ6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90C254AFB;
	Tue, 15 Apr 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749039; cv=none; b=WaRD78r86wzArqzFn2YI/IsCgckAgCSREOMhmDCxwbD2M3BzRJzeOM+kqk+VLzpVKRKTvGuCC1xCdQt09YbnaPQXRFEf3RwgeCdW8sslS6t63T4dK6x8rjpyNLsvWTzVC/huSXq+I65n8oz7CzjL0Ycms/yn6yFfxzzdPcJLea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749039; c=relaxed/simple;
	bh=eAzrZMpfYl8YyWeHTfn8zWcb6mjKHP1QmYgGKXBsFZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JpoLZGB8eGIBolgtpmPZM7ibZaeWJ6nUJfUDsontLnGoEaPUEh55yjIUtlcBW9G+Cu8dJlzLzvnzhxEBZEp6ewHt/aSJZIUADmF+sex9NhXe7mS4gxLWoI7QZn3DTzcdo0OQ9XbUpQ6yBR/fnqSsmbl9Pa7mhOr120tSv1gASZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvYdAmJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EF5C4CEE7;
	Tue, 15 Apr 2025 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749039;
	bh=eAzrZMpfYl8YyWeHTfn8zWcb6mjKHP1QmYgGKXBsFZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WvYdAmJ6l1x9+nEqcqMT/XrbQP+6RhRj0oPKQ0O10yBH/8NSmmPR99027+BU1fLRk
	 rj9mqHR2q4E6YVWTxAyOYzKwSfnFzZZiYRCf47aFSVZk18m29vPVqTXgOL0xlpFBzp
	 hJLpzU48/NWZ7RXODFBANu87u41woLI/D1JXJZJpJT61CnU9arbwbrwlgPreGNehX6
	 Z6N/vfG87EkkI449WdC0T1bWJQA6AYOifGFGr+wq0b1cieINYrULAti9H199i63Ekf
	 WG5r/XlVpy8UXNHbRThgiPFYkYiUEHh/WTxDTB8c8IYnRKbfAh0LeFpQTXzYqTqvs3
	 ms9RHjazUxR/g==
Date: Tue, 15 Apr 2025 15:30:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 22/22] pci: Define pci_iomap_range_encrypted
Message-ID: <20250415203037.GA33341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-23-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:09PM +1100, Alexey Kardashevskiy wrote:
> So far PCI BARs could not be mapped as encrypted so there was no
> need in API supporting encrypted mappings. TDISP is adding such
> support so add pci_iomap_range_encrypted() to allow PCI drivers
> do the encrypted mapping when needed.

Match subject capitalization, rewrap.

> +void __iomem *pci_iomap_range_encrypted(struct pci_dev *dev,
> +					int bar,
> +					unsigned long offset,
> +					unsigned long maxlen)
> +{
> +	resource_size_t start = pci_resource_start(dev, bar);
> +	resource_size_t len = pci_resource_len(dev, bar);
> +	unsigned long flags = pci_resource_flags(dev, bar);
> +
> +	if (len <= offset || !start)
> +		return NULL;
> +	len -= offset;
> +	start += offset;
> +	if (maxlen && len > maxlen)
> +		len = maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return NULL;
> +	if ((flags & IORESOURCE_MEM) && (flags & IORESOURCE_VALIDATED))
> +		return ioremap_encrypted(start, len);
> +	/* What? */

"What?" indeed.  This could be removed or made to say something
intelligible.

> +	return NULL;
> +}
> +EXPORT_SYMBOL(pci_iomap_range_encrypted);
> +
>  /**
>   * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> -- 
> 2.47.1
> 

