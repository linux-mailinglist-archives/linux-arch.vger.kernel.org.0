Return-Path: <linux-arch+bounces-15340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC1CB5233
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 09:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EE893011A8A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031762D9488;
	Thu, 11 Dec 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S3Rb3DgF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C8225390;
	Thu, 11 Dec 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442486; cv=none; b=ip1VFIhY+gw8hi1YRXQVSf9FGzokeDcjnL+1B7AbRDp2Tagk0L/kLej9gFHleda1j7Qeqnmce1vuGEmYU5TpGF9zqSZtGNv6PPMvzU5PSY/cNjgh+7JS7fsBnTZBiM6TIjxyF+mqAIdY5Kj235eUSht2gnnOMvryB7inXXOh/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442486; c=relaxed/simple;
	bh=qh6uoyFWCAiLpVcYSsMjXXl3mTq1SLUhBwLWV0YWqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8rkgPfspXpF430KCnfk2m0Xvn7Se2lXsbKD3xXvdoucQUMKTR2ol7NWlcvDfmh0sgMOND2TC9BOCjfwDZ5sw1RNqoMBJlYiDDN9e9FhF5ABoMqStwQES7LfIw/qSBgVJ4y2a28WRd9DHPX2/cvGPqS4y3zxxW76xTXTCCyzqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S3Rb3DgF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id 66014201569E;
	Thu, 11 Dec 2025 00:41:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66014201569E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765442484;
	bh=8Z0I857mqII7HIw/I3XMs9wedEMJ2wEwf9oiJXhMi6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3Rb3DgFUw/FOFXU3hkFwILm0nSev31yTEBtE+pA43mwKUpJGMAhrgn7ZMNIu6xDY
	 w9UfWY6OwloEOLkOB88VMPplUeLs/vvHLRaPZryq89kDbMdoGfXZzSMp4uX7hyTlTH
	 yx57sS57HDJPcAZ+XEOfNSlNUsFNbCWKjADbxQ88=
Date: Thu, 11 Dec 2025 16:41:23 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	arnd@arndb.de, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	jacob.pan@linux.microsoft.com, nunodasneves@linux.microsoft.com, mrathor@linux.microsoft.com, 
	mhklinux@outlook.com, peterz@infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <u7j6pq2yhbxsa76p4lyidozjrrokpb76pul7foxfrbqxyf3vgz@cfr6zmej3nhs>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
 <0c34e66f-7766-4b4f-a04d-77dbc330f1fe@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c34e66f-7766-4b4f-a04d-77dbc330f1fe@linux.microsoft.com>

On Wed, Dec 10, 2025 at 09:15:18AM -0800, Easwar Hariharan wrote:
> On 12/8/2025 9:11 PM, Yu Zhang wrote:
> > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > This driver implements stage-1 IO translation within the guest OS.
> > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > for:
> >  - Capability discovery
> >  - Domain allocation, configuration, and deallocation
> >  - Device attachment and detachment
> >  - IOTLB invalidation
> > 
> > The driver constructs x86-compatible stage-1 IO page tables in the
> > guest memory using consolidated IO page table helpers. This allows
> > the guest to manage stage-1 translations independently of vendor-
> > specific drivers (like Intel VT-d or AMD IOMMU).
> > 
> > Hyper-v consumes this stage-1 IO page table, when a device domain is
> > created and configured, and nests it with the host's stage-2 IO page
> > tables, therefore elemenating the VM exits for guest IOMMU mapping
> > operations.
> > 
> > For guest IOMMU unmapping operations, VM exits to perform the IOTLB
> > flush(and possibly the device TLB flush) is still unavoidable. For
> > now, HVCALL_FLUSH_DEVICE_DOMAIN	is used to implement a domain-selective
> > IOTLB flush. New hypercalls for finer-grained hypercall will be provided
> > in future patches.
> > 
> > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  drivers/iommu/hyperv/Kconfig  |  14 +
> >  drivers/iommu/hyperv/Makefile |   1 +
> >  drivers/iommu/hyperv/iommu.c  | 608 ++++++++++++++++++++++++++++++++++
> >  drivers/iommu/hyperv/iommu.h  |  53 +++
> >  4 files changed, 676 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv/iommu.c
> >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > 
> 
> <snip>
> 
> > +
> > +static int __init hv_iommu_init(void)
> > +{
> > +	int ret = 0;
> > +	struct hv_iommu_dev *hv_iommu = NULL;
> > +	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
> > +
> > +	if (no_iommu || iommu_detected)
> > +		return -ENODEV;
> > +
> > +	if (!hv_is_hyperv_initialized())
> > +		return -ENODEV;
> > +
> > +	if (hv_iommu_detect(&hv_iommu_cap) ||
> > +	    !hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> > +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap))
> > +		return -ENODEV;
> > +
> > +	iommu_detected = 1;
> > +	pci_request_acs();
> > +
> > +	hv_iommu = kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
> > +	if (!hv_iommu)
> > +		return -ENOMEM;
> > +
> > +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> > +
> > +	ret = hv_initialize_static_domains();
> > +	if (ret) {
> > +		pr_err("hv_initialize_static_domains failed: %d\n", ret);
> > +		goto err_sysfs_remove;
> 
> This should be goto err_free since we haven't done the sysfs_add yet
> 
> > +	}
> > +
> > +	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
> > +	if (ret) {
> > +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> > +		goto err_free;
> 
> And this should be probably a goto delete_static_domains that cleans up the allocated static
> domains...
> 

Nice catch. And thanks! :)

Yu

