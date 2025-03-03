Return-Path: <linux-arch+bounces-10486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF87A4B798
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 06:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DC63AC947
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 05:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A11DDA3C;
	Mon,  3 Mar 2025 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqzVwvQM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600658635C;
	Mon,  3 Mar 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980100; cv=none; b=nn5EVYStP4eQFrhrhQhcEy13qsDQBdK17PBQ8TaFcrc8CIpnq0ySGGSmb/qQdQuAhk7ZpAwyzJjuJ2H2hvaXN3JG0dz3UaPbC3nup2VLdYw9vF+0QwrF4hEJCnDD27wjJvZjALp77hjmQG21s0DnnwaSSe92incjThgFZFJ0upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980100; c=relaxed/simple;
	bh=hD6xzP3FpFewH9I665wRKi/LE9Ov9GLuAPFoz3tFtBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KraR2gLMV8PV1LbFyZkr2yKr4tQbIiwbcMn4APrYZNcqmTjL87J630oBUUhcEz1vXW8y0nyvJ9k6BDVpDrwUuzyXymP7Q/z0991USx1lyrBFSKmqZfzJWuHlnR8mvakQ1WDO7EXABvVQ2kN/Zm6pgVTtNIuJDewspPF7kAkaZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqzVwvQM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740980100; x=1772516100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hD6xzP3FpFewH9I665wRKi/LE9Ov9GLuAPFoz3tFtBo=;
  b=dqzVwvQMVEaBYLAiIyDrTH5mmjTlFFLLhGUp08JyFIyzPnB5AZlarXUe
   Ng7761e37Ln2bmPINWx9mpE7tJ39EeVy2lrSms/YgKsU3arWTjcXZsJM9
   KYh7XSSUlBrGgk6/4tmT/xgQdSYbJ0hoOmP3ekZFVb1bNhDyXCOOSMCYm
   eu8xnbA2EZjrQFavAWd2D6LuLoF43uZqw8hsmbydMOVou9GNdBR7/uNV7
   Rdqf1DFj7kUlodfDm8lb/YWICXNdVgqQcd0LNTLb2QCs+XUKTgSJdIt9P
   xDWBEacXwWBfCkXIebAvVrSJGWLuQm4PDJezTdS0EWS1Z79Iz0Su6eumE
   g==;
X-CSE-ConnectionGUID: kX6/eKeBRI6DJF684CsS2w==
X-CSE-MsgGUID: AmT8OIObQ4C1I37c3firDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64301592"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="64301592"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 21:34:59 -0800
X-CSE-ConnectionGUID: 0DG/Qx3+S8OpHKZszWb+pg==
X-CSE-MsgGUID: kxKYVUmhSwaPW7RpjZz9WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="122499750"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 02 Mar 2025 21:34:51 -0800
Date: Mon, 3 Mar 2025 13:32:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
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
Message-ID: <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301003711.GR5011@ziepe.ca>

On Fri, Feb 28, 2025 at 08:37:11PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 11:59:18AM +0800, Xu Yilun wrote:
> > On Wed, Feb 26, 2025 at 09:12:02AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> > > 
> > > > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > > > failed without knowing what happened.
> > > 
> > > What do people expect to happen here anyhow? Do you still intend to
> > > mmap any of the MMIO into the hypervisor? No, right? It is all locked
> > 
> > Not expecting mmap the MMIO, but I switched to another way. VFIO doesn't
> > disallow mmap until bind, and if there is mmap on bind, bind failed.
> > That's my understanding of your comments.
> 
> That seems reasonable
> 
> > Another concern is about dma-buf importer (e.g. KVM) mapping the MMIO.
> > Recall we are working on the VFIO dma-buf solution, on bind/unbind the
> > MMIO accessibility is being changed and importers should be notified to
> > remove their mapping beforehand, and rebuild later if possible.
> > An immediate requirement for Intel TDX is, KVM should remove secure EPT
> > mapping for MMIO before unbind.
> 
> dmabuf can do that..

Yes, dmabuf can do that via notify. dmabuf is implemented in VFIO,
so iommufd/vdevice couldn't operate on dmabuf and send the notify.

> 
> > > > The implementation is basically no difference from:
> > > > 
> > > > +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > > > +                                              IOMMUFD_OBJ_VDEVICE),
> > > > 
> > > > The real concern is the device owner, VFIO, should initiate the bind.
> > > 
> > > There is a big different, the above has correct locking, the other
> > > does not :)
> > 
> > Could you elaborate more on that? Any locking problem if we implement
> > bind/unbind outside iommufd. Thanks in advance.
> 
> You will be unable to access any information iommufd has in the viommu
> and vdevice objects. So you will not be able to pass a viommu ID or
> vBDF to the secure world unless you enter through an iommufd path, and
> use iommufd_get_object() to obtain the required locks.
>  
> I don't know what the API signatures are for all three platforms to
> tell if this is a problem or not.

Seems not a problem for Intel TDX. Basically secure DMA settings for TDX
is just to build the secure IOMMUPT, only need host BDF. Also secure
device setting needs no secure DMA info.

All these settings cannot really take function until guest verifies them
and does TDISP start. Guest verification does not (should not) need host
awareness.

Our solution is, separate the secure DMA setting and secure device setting
in different components, iommufd & vfio.

Guest require bind:
  - ioctl(iommufd, IOMMU_VIOMMU_ALLOC, {.type = IOMMU_VIOMMU_TYPE_KVM_VALID,
					.kvm_fd = kvm_fd,
					.out_viommu_id = &viommu_id});
  - ioctl(iommufd, IOMMU_HWPT_ALLOC, {.flag = IOMMU_HWPT_ALLOC_TRUSTED,
				      .pt_id = viommu_id,
				      .out_hwpt_id = &hwpt_id});
  - ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, {.pt_id = hwpt_id})
    - do secure DMA setting in Intel iommu driver.

  - ioctl(vfio_fd, VFIO_DEVICE_TSM_BIND, ...)
    - do bind in Intel TSM driver.

Thanks,
Yilun

> 
> Jason

