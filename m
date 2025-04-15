Return-Path: <linux-arch+bounces-11414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F6A8A950
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05F017BDE6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48D25392D;
	Tue, 15 Apr 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmgVVnQF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D292522BD;
	Tue, 15 Apr 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748941; cv=none; b=UckMfeDkT3Y4GmyA0i1dsWZ6GW0h2UuHPgtdu6R5TGEl/CxWgQr8QQTh3V/4TvGFQHD5zeHHYpCCiPgbWnRJbZwkYpRIAbtOfhsAOW0XyjNOstUJgQ3CVxf6LcROBBnsoNDRJkJ2PIuZNZBAlCmURN9RYQFcI8Z2OMdIN9Me11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748941; c=relaxed/simple;
	bh=jhmgcrVvRSWvseHbMT4BLgdJrHTfg3fksurfggWZDuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uEMK7SNYfEnMdGIprvVB2E67C3z1pOxciiM8GIcrUf1sIBE67VBgI0lK4kv9MX2lmxL61aNfbTqgTQ9ab/YHjju6ybCR/OPEgtoSbOq2f8tkHnVTQBKe+ogyajUkrxhFt94c76OVemVFU5kjOiBVLbpwtMSFfEa6WJX4xQzzC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmgVVnQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F52C4CEE7;
	Tue, 15 Apr 2025 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748941;
	bh=jhmgcrVvRSWvseHbMT4BLgdJrHTfg3fksurfggWZDuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OmgVVnQFRpAUE4sbxQdpTUKihQd/NCzT5wc+h4shGkYztX8rSaxIxf/BE4iSLDr8e
	 5C+JKR1TqoEURkakPjQGWL3XBKZuNRr6CQYr2d85aUTbTKILGfmlna9bUblBhfdY3f
	 eSSRu4U03nUyNZMbAzoumyoxJYEafIIkfecr0tcMgZcPKYSAW3LPs4POAU9FWLv1+E
	 nWJd/odTxddk6M8QLpTDFOFWAP6qW0MM12oJ3TDHqJJH6sUAC7oz/X54W/Pj9aCdq0
	 unJ37njflK0+nMMyneqjSA0EFDYzPeD5/7UHpExAvLSVda0tQhSB5BFbnVwaPtjydK
	 91NzfOlvRlpZA==
Date: Tue, 15 Apr 2025 15:28:59 -0500
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
Subject: Re: [RFC PATCH v2 21/22] pci: Allow encrypted MMIO mapping via sysfs
Message-ID: <20250415202859.GA33242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-22-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:08PM +1100, Alexey Kardashevskiy wrote:
> Add another resource#d_enc to allow mapping MMIO as
> an encrypted/private region.

I guess this means a sysfs file.  Document alongside the others.

> Unlike resourceN_wc, the node is added always as ability to
> map MMIO as private depends on negotiation with the TSM which
> happens quite late.

Match capitalization (subject) and wrap to fill 75 columns.

> +++ b/include/linux/pci.h
> @@ -2129,7 +2129,7 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>   */
>  int pci_mmap_resource_range(struct pci_dev *dev, int bar,
>  			    struct vm_area_struct *vma,
> -			    enum pci_mmap_state mmap_state, int write_combine);
> +			    enum pci_mmap_state mmap_state, int write_combine, int enc);

Wrap to fit in 80 columns.

>  
>  #ifndef arch_can_pci_mmap_wc
>  #define arch_can_pci_mmap_wc()		0
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index 8da3347a95c4..4fd522aeb767 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -23,7 +23,7 @@ static const struct vm_operations_struct pci_phys_vm_ops = {
>  
>  int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
>  			    struct vm_area_struct *vma,
> -			    enum pci_mmap_state mmap_state, int write_combine)
> +			    enum pci_mmap_state mmap_state, int write_combine, int enc)

Ditto.

>  {
>  	unsigned long size;
>  	int ret;
> @@ -46,6 +46,15 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
>  
>  	vma->vm_ops = &pci_phys_vm_ops;
>  
> +	/*
> +	 * Calling remap_pfn_range() directly as io_remap_pfn_range()
> +	 * enforces shared mapping.

s/Calling/Call/

> +	 */
> +	if (enc)
> +		return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +				       vma->vm_end - vma->vm_start,
> +				       vma->vm_page_prot);
> +
>  	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>  				  vma->vm_end - vma->vm_start,
>  				  vma->vm_page_prot);

