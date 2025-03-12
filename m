Return-Path: <linux-arch+bounces-10677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E0A5D3E5
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 02:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD7F3AAB05
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710E139CE3;
	Wed, 12 Mar 2025 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQ5xbV8u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ACE5CB8;
	Wed, 12 Mar 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742029; cv=none; b=q6LncpD+fZ2iDOG2wSeRTAXj9R9IDqSOwUrCkQ4jAZPzhRv4esh3hBP+lcO4Wxp9+/M5X7CnxXjQDJpAW3FvFFWCFwUDDRfGdsJqhEL6//hu7Uj1fXs09QTgbBlciSugeRmp0ArwpJgKC5brYQ73ubh6cBEsVpNOZUDoSzHRPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742029; c=relaxed/simple;
	bh=+RZZ7dldifWWO9KJpQQJzaN1oqzmUvwKYrniOyXt/Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A18X1o3AyxnEKZyZnFay1BSgyBgsk2xxAN6LOKs23nZx3W4xhPoa1dnObn6D10gs9koBEkAXzY06eUtINWJOHXWVQpnKB8YRqtLXoN+dvKw0dFw0+M5izUTUbrx/NjlTJz85YAqmAEjm2zHWmfjxjptUXfNBNqx6Y3VQ2tUi6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQ5xbV8u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741742028; x=1773278028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RZZ7dldifWWO9KJpQQJzaN1oqzmUvwKYrniOyXt/Dc=;
  b=dQ5xbV8ul0YjycD+MymH6UJ5uHbNo+3HUvSxDhhgyPEDzPLFsP9Ll7H1
   6HRqJG53EJTiGtfn2ascqjlWdK1aC5tQtC++eVK5KXIZmkQdJk1Or5M7V
   jHp+hA4inmQQQayIPiZVE/3cqq5GR5YqSdLTOQwrbGI7uJfvWXVROGM5c
   JSQ0BYiGa+Uad2hfULiTdrPyvPCPVA05p4uZWxptuOywQTn0b8t5E6Hs4
   iXnHD2SO92ls4bg4jFl6K3PnKJHO/A0M3SRLf7uimH+3DYQLnzoQwmWjT
   uHnE67gC/87fuYLaVAVaLksn+YGOBZ76NJlIDNVWsxMOJQZwxjhRrK9x8
   g==;
X-CSE-ConnectionGUID: w5cLbFRNSz+AyX7A5DoucA==
X-CSE-MsgGUID: 4w839Y+0T3mgUlwmnRQRwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42936200"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42936200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 18:13:47 -0700
X-CSE-ConnectionGUID: u38PE43hRciZlNtVu9D/dQ==
X-CSE-MsgGUID: eMPyhx1JRFGVHJBvNOHpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="151443309"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2025 18:13:39 -0700
Date: Wed, 12 Mar 2025 09:11:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <Z9DfLQtmq7GGXlBb@yilunxu-OptiPlex-7050>
References: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
 <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>

On Fri, Mar 07, 2025 at 01:19:11PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 6/3/25 17:47, Xu Yilun wrote:
> > On Wed, Mar 05, 2025 at 03:28:42PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Mar 03, 2025 at 01:32:47PM +0800, Xu Yilun wrote:
> > > > All these settings cannot really take function until guest verifies them
> > > > and does TDISP start. Guest verification does not (should not) need host
> > > > awareness.
> > > > 
> > > > Our solution is, separate the secure DMA setting and secure device setting
> > > > in different components, iommufd & vfio.
> > > > 
> > > > Guest require bind:
> > > >    - ioctl(iommufd, IOMMU_VIOMMU_ALLOC, {.type = IOMMU_VIOMMU_TYPE_KVM_VALID,
> > > > 					.kvm_fd = kvm_fd,
> > > > 					.out_viommu_id = &viommu_id});
> > > >    - ioctl(iommufd, IOMMU_HWPT_ALLOC, {.flag = IOMMU_HWPT_ALLOC_TRUSTED,
> > > > 				      .pt_id = viommu_id,
> > > > 				      .out_hwpt_id = &hwpt_id});
> > > >    - ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, {.pt_id = hwpt_id})
> > > >      - do secure DMA setting in Intel iommu driver.
> > > > 
> > > >    - ioctl(vfio_fd, VFIO_DEVICE_TSM_BIND, ...)
> > > >      - do bind in Intel TSM driver.
> > > 
> > > Except what do command do you issue to the secure world for TSM_BIND
> > > and what are it's argument? Again you can't include the vBDF or vIOMMU
> > > ID here.
> > 
> > Bind for TDX doesn't require vBDF or vIOMMU ID. The seamcall is like:
> > 
> > u64 tdh_devif_create(u64 stream_id,     // IDE stream ID, PF0 stuff
> >                       u64 devif_id,      // TDI ID, it is the host BDF
> >                       u64 tdr_pa,        // TDX VM core metadate page, TDX Connect uses it as CoCo-VM ID
> >                       u64 devifcs_pa)    // metadate page provide to firmware
> 
> 
> (offtopic) is there a public spec with this command defined?

Sorry, there is no public TDX Connect SPEC yet.

Thanks,
Yilun

