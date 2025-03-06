Return-Path: <linux-arch+bounces-10531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C729A54314
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 07:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F97B7A67FB
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888D1A23BC;
	Thu,  6 Mar 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8cJypSN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7619C556;
	Thu,  6 Mar 2025 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243787; cv=none; b=JjAsez+ZEfT62mXQeI4W9UnPdfvw/7it1QFaVmI978TKRWU4p/W2cQ/+duZhRaQy58ms3McI09zrbZFR0ANwncJxP///mCIDADD30r9McFTK/Uif1QZKP5Pp0N3ucAqhhPv0SJ7sxJRWAGF13+Xz45nxpU6XeSFiZXE9az+V5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243787; c=relaxed/simple;
	bh=nihPbFWpYPqsBosZAhoIw4NpSVYZ7ujfvelE5cg2qlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSK/mmRjUfX+psHW+FPPQ9FW/ppqceTvMRA79uGjWAhiQOl4R2QawoWzztRkayvdk2xDCCszLFDw/zuA3T4JKSNMq+5TluIYgGpUXy9wUXgEsnpZS77oibaB9zEo1lutLEew56vub1lCpGj92ZcTDaCfishNqmEReebvloXSavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8cJypSN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741243786; x=1772779786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nihPbFWpYPqsBosZAhoIw4NpSVYZ7ujfvelE5cg2qlQ=;
  b=l8cJypSNKs+Tt3tSJtZPaE1YYYsmzOBytiKizccEkjQFmDJHR/rjR9SL
   71G4THNnbki4NNOPFeHrJW5UAjNwbSC53xOhvIaHeTcKdhwgTbTHGHYnD
   JQs3IMrVqcDB4TVDr51aKKLSgdR8BeZ1vAbLKL3E1YXXlAmHIbcLTkHMN
   Z6aVq3pr/UpzhYnJsbieCcAuknUNmPARYLjCLVy9XAzHL24OrP0Re7OdJ
   4u3b62gbTbqutW7A1r8O65HGaMZh47gUX16DaHSCK+x4QNuFvdMfzNYeS
   I09Piene9hR96XNdARYyTLqxcqubMici7vMo6r5HZ95NFa4asf6lUQ41E
   A==;
X-CSE-ConnectionGUID: iJDp6BPvS+qJyim822jdFw==
X-CSE-MsgGUID: 3arLx5d1RYWyHY1EScb8Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41488707"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41488707"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:49:45 -0800
X-CSE-ConnectionGUID: 0YQ+ToHsQFqTfy8LYBXmaA==
X-CSE-MsgGUID: eXWNYvDpQmebOFbpoNF84w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123948108"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 22:49:37 -0800
Date: Thu, 6 Mar 2025 14:47:23 +0800
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
Message-ID: <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305192842.GE354403@ziepe.ca>

On Wed, Mar 05, 2025 at 03:28:42PM -0400, Jason Gunthorpe wrote:
> On Mon, Mar 03, 2025 at 01:32:47PM +0800, Xu Yilun wrote:
> > All these settings cannot really take function until guest verifies them
> > and does TDISP start. Guest verification does not (should not) need host
> > awareness.
> > 
> > Our solution is, separate the secure DMA setting and secure device setting
> > in different components, iommufd & vfio.
> > 
> > Guest require bind:
> >   - ioctl(iommufd, IOMMU_VIOMMU_ALLOC, {.type = IOMMU_VIOMMU_TYPE_KVM_VALID,
> > 					.kvm_fd = kvm_fd,
> > 					.out_viommu_id = &viommu_id});
> >   - ioctl(iommufd, IOMMU_HWPT_ALLOC, {.flag = IOMMU_HWPT_ALLOC_TRUSTED,
> > 				      .pt_id = viommu_id,
> > 				      .out_hwpt_id = &hwpt_id});
> >   - ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, {.pt_id = hwpt_id})
> >     - do secure DMA setting in Intel iommu driver.
> > 
> >   - ioctl(vfio_fd, VFIO_DEVICE_TSM_BIND, ...)
> >     - do bind in Intel TSM driver.
> 
> Except what do command do you issue to the secure world for TSM_BIND
> and what are it's argument? Again you can't include the vBDF or vIOMMU
> ID here.

Bind for TDX doesn't require vBDF or vIOMMU ID. The seamcall is like:

u64 tdh_devif_create(u64 stream_id,     // IDE stream ID, PF0 stuff
                     u64 devif_id,      // TDI ID, it is the host BDF
                     u64 tdr_pa,        // TDX VM core metadate page, TDX Connect uses it as CoCo-VM ID
                     u64 devifcs_pa)    // metadate page provide to firmware

While for AMD:
        ...
        b.guest_device_id = guest_rid;  //TDI ID, it is the vBDF
        b.gctx_paddr = gctx_paddr;      //AMDs CoCo-VM ID

        ret = sev_tio_do_cmd(SEV_CMD_TIO_TDI_BIND, &b, ...


Neither of them use vIOMMU ID or any IOMMU info, so the only concern is
vBDF.

Basically from host POV the two interfaces does the same thing, connect
the CoCo-VM ID with the TDI ID, for which Intel uses host BDF while AMD
uses vBDF. But AMD firmware cannot know anything meaningful about the
vBDF, it is just a magic number to index TDI metadata.

So I don't think we have to introduce vBDF concept in kernel. AMD uses
QEMU created vBDF as TDI ID, that's fine, QEMU should ensure the
validity of the vBDF.

> 
> vfio also can't validate that the hwpt is in the right state when it
> executes this function.

Not sure if VFIO has to validate, or is there a requirement that
secure DMA should be in right state before bind. TDX doesn't require
this, and I didn't see the requirement in SEV-TIO spec. I.e. the
bind firmware calls don't check DMA state.

In my opinion, TDI bind means put device in LOCKED state and related
metadate management in firmware. After bind the DMA cannot work. It
is the guest's resposibility to validate everything (including DMA)
is in the right state, then issues RUN, then DMA works. I.e. guest tsm
calls check DMA state.  That's why I think Secure DMA configuration
on host could be in a separated flow from bind.

> 
> You could also issue the TSM bind against the idev on the iommufd
> side..

But I cannot figure out how idev could ensure no mmap on VFIO, and how
idev could call dma_buf_move_notify.

Thanks,
Yilun

> 
> Part of my problem here is I don't see anyone who seems to have read
> all three specs and is trying to mush them together. Everyone is
> focused on their own spec. I know there are subtle differences :\
> 
> Jason

