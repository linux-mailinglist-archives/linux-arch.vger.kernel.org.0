Return-Path: <linux-arch+bounces-10563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B0A56131
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 07:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A63C3AE2D5
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3619F13F;
	Fri,  7 Mar 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4Kfm9ma"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E819DFA7;
	Fri,  7 Mar 2025 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330329; cv=none; b=a45OsXWJytHK2SmAPF8nWxKuszscPtkz/SYmhIlctA6FPMj/LqkozImElRHLed22ceP8eoN2wPdHcCk9yA34ysCSiXccegsaQNDj1I/EmANWNxLJoT2AADCv3LGHxZKb/MxK4AcqPnLqbwjpR/NZMPY+WwLsS9C2zmdckB/iEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330329; c=relaxed/simple;
	bh=0FboRi4T5lRhBpOLmxfTGg8DNG9FS+J/OvKiP4g1uVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzRlJLFGhFTksWNeuIl12MmiEP3ZBrB/sZWwwW/cJwFbitPkVAp68lqD3/9jervXGvzb0SBExouqTYRTJDmRwu/39VwISNe0m5cx3uBe1yWItN5XdOaPc2BL5L+XkRF8L+1bauBjdXySbpg7DAsBeDz0qOpAKNmp5Eh9fcPETpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4Kfm9ma; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741330328; x=1772866328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0FboRi4T5lRhBpOLmxfTGg8DNG9FS+J/OvKiP4g1uVM=;
  b=Z4Kfm9makxyVipxRXMcPGI4emlaIPxZqFUh8PAWEzx8OQ+K9DEcmoP6u
   Ekt2QKkJ8pkNE76WmBG/QM31ah7zfqrGV2JNMvtQB1qwiA8smhUI4CwmC
   p/y96BkgrGoimVQ1tZtju2INIvV3qx0UcRz6Dlz+X+gUjo98e0xo4JsLn
   WDcksOu637MJXlwO/XHesSdmaBvsNypVIBTyJiGd9NsSzssQcPDiRFMOR
   BXKbsjSMmyvvJLzLVS7Z2XVLQim+Idxgg9bqs26/dNvpB4xiUDzXIuFEE
   VlNcUnGFlNPDnyh5mBSaHABi+Y/7vcGYhEvp97vXbsGIBdt/ZcQMNNrIG
   A==;
X-CSE-ConnectionGUID: 7bYbQ2y5Rryz5wQ4o7dKzA==
X-CSE-MsgGUID: kcLRTQY8TReadBGDPm66Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53769939"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53769939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 22:52:07 -0800
X-CSE-ConnectionGUID: fMKAQkc6S7ifR+dbATnnfQ==
X-CSE-MsgGUID: 7tBYnb24QYOZP5v4PpdyhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123425163"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 06 Mar 2025 22:52:00 -0800
Date: Fri, 7 Mar 2025 14:49:44 +0800
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
Message-ID: <Z8qXCI6Wwygvwhya@yilunxu-OptiPlex-7050>
References: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
 <20250306182614.GF354403@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306182614.GF354403@ziepe.ca>

On Thu, Mar 06, 2025 at 02:26:14PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2025 at 02:47:23PM +0800, Xu Yilun wrote:
> 
> > While for AMD:
> >         ...
> >         b.guest_device_id = guest_rid;  //TDI ID, it is the vBDF
> >         b.gctx_paddr = gctx_paddr;      //AMDs CoCo-VM ID
> > 
> >         ret = sev_tio_do_cmd(SEV_CMD_TIO_TDI_BIND, &b, ...
> > 
> > 
> > Neither of them use vIOMMU ID or any IOMMU info, so the only concern is
> > vBDF.
> 
> I think that is enough, we should not be putting this in VFIO if it
> cannot execute it for AMD :\

OK. With these discussion, my understanding is it can execute for AMD
but we don't duplicate the effort for vdevice->id.

We can swtich to vdevice and try to solve the rest problems.

> 
> > > You could also issue the TSM bind against the idev on the iommufd
> > > side..
> > 
> > But I cannot figure out how idev could ensure no mmap on VFIO, and how
> > idev could call dma_buf_move_notify.
> 
> I suggest you start out this way from the VFIO. Put the device in a CC
> mode which bans the mmap entirely and pass that CC capable as a flag
> into iommufd when creating the idev.

IIUC, it basically switches back to my previous implementation for mmap.

https://lore.kernel.org/kvm/20250107142719.179636-9-yilun.xu@linux.intel.com/

I can do that.

Thanks,
yilun

> 
> If it really needs to be dyanmic a VFIO feature could change the CC
> mode and that could call back to iommufd to synchronize if that is
> allowed.
> 
> Jason

