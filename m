Return-Path: <linux-arch+bounces-10417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D331FA473E8
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 05:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F076188BC6A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB371922D4;
	Thu, 27 Feb 2025 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd9X2fgw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323A1FAA;
	Thu, 27 Feb 2025 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628879; cv=none; b=auZhcbYP/KuDtPbjDJrFW/Hjc9C/uGn+fLF6dhMvAyncA8etykoGrIOKJyWIBu5c1H2At1JkE/+lJDrttvk8c67miyclfjnE0YoOSnlSrU+5cKllwe7BGfVHtAv4GxhEltyKlR/Yy5xloiF8018qujmjEiklaXrArdbrcRxP1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628879; c=relaxed/simple;
	bh=IEjTmlHtu/G6YONIHp7Nc7Bjed+wo/mNljfTGEMgYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf/ADUtpFTbKXGWi+64014aaIzxWC0yjw2JYA1XfVq0jbwL/WHeWvvkiWuNHg25RGRa/uJvX3Nf9QVVkhi6NJFL2j1Y+8Ho+ftSMB4osm88tIYKl5TmJXpkf2PdyuEU8oT61upZvY7KXbcVMHMIMpKIBSn1NgeDlT1PNFjAN22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd9X2fgw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740628878; x=1772164878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEjTmlHtu/G6YONIHp7Nc7Bjed+wo/mNljfTGEMgYoU=;
  b=Pd9X2fgwid4qKtl0iI2E/iRAqmnOmn+3x5xPGvTWN2R6nzmHr296/85n
   Iik76mRPuhyb2W1PUFsUIPFiJn5wGvALoXHhAXu14heH35hm48Y7hc5J7
   0PY0eEHJmekgymiXLCJOZlPpleYv0KFbmkyW9UQItSKFccl2vG0rui9Gd
   cPiBlFvqogNyB+/VoMIzwBlJssOVfxZjUhEZTyLAYVlrhCWXGvS2mDlXX
   XNYWKJ0c+CX81emJ1Jc98fbW9CPh+HkIeZNMq5e4P+j5LmsJjCb0Ve4JQ
   oBJwxWoPwlBkanLlos+TxTsSs7ZPzzfa0Q9Xo76O0LWAVokazAOAKkRGW
   A==;
X-CSE-ConnectionGUID: fBgsCYisS8Gz5Ly79cBOxw==
X-CSE-MsgGUID: n4Dwb/ZFQKOzB8RAi26kaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="59039514"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="59039514"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:01:17 -0800
X-CSE-ConnectionGUID: 28vhRiITRbmufxYLAhfSWw==
X-CSE-MsgGUID: Lc4yBGteRBCDAlNlAOIahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117075567"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 20:01:10 -0800
Date: Thu, 27 Feb 2025 11:59:18 +0800
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
Message-ID: <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226131202.GH5011@ziepe.ca>

On Wed, Feb 26, 2025 at 09:12:02AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> 
> > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > failed without knowing what happened.
> 
> What do people expect to happen here anyhow? Do you still intend to
> mmap any of the MMIO into the hypervisor? No, right? It is all locked

Not expecting mmap the MMIO, but I switched to another way. VFIO doesn't
disallow mmap until bind, and if there is mmap on bind, bind failed.
That's my understanding of your comments.

https://lore.kernel.org/kvm/Z4Hp9jvJbhW0cqWY@yilunxu-OptiPlex-7050/#t


Another concern is about dma-buf importer (e.g. KVM) mapping the MMIO.
Recall we are working on the VFIO dma-buf solution, on bind/unbind the
MMIO accessibility is being changed and importers should be notified to
remove their mapping beforehand, and rebuild later if possible.
An immediate requirement for Intel TDX is, KVM should remove secure EPT
mapping for MMIO before unbind.

So I think device is all locked down into CC mode AFTER bind and BEFORE
unbind. It doesn't seems viommu/vdevice could control bind/unbind.

There are other bus error handling cases, like AER when TDISP/SPDM/IDE
state broken, that I don't have a clear solution now. But I cannot
imagine they could be correctly handled without pci_driver support.

> down?
> 
> So perhaps the answer is that the VFIO side has to put the device into
> CC mode which disables MMAP/etc, then the viommu/vdevice iommufd
> object can control it.
> 
> > Back to your concern, I don't think it is a problem. From your patch,
> > vIOMMU doesn't know the guest BDFn by nature, it is just the user
> > stores the id in vdevice via iommufd_vdevice_alloc_ioctl(). A proper
> > VFIO API could also do this work.
> 
> We don't want duplication though. If the viommu/vdevice/vbdf are owned
> and lifecycle controlled by iommufd then the operations against them
> must go through iommufd and through it's locking regime.
> > 
> > The implementation is basically no difference from:
> > 
> > +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +                                              IOMMUFD_OBJ_VDEVICE),
> > 
> > The real concern is the device owner, VFIO, should initiate the bind.
> 
> There is a big different, the above has correct locking, the other
> does not :)

Could you elaborate more on that? Any locking problem if we implement
bind/unbind outside iommufd. Thanks in advance.

Thanks,
Yilun

> 
> Jason

