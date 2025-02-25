Return-Path: <linux-arch+bounces-10356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7EA438B2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 10:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC99172FE1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B02673A5;
	Tue, 25 Feb 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfeOS8Gn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E994264A96;
	Tue, 25 Feb 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474127; cv=none; b=sJEbHCqVzdA1Y0h6X93Z3o6qJFH0oEJDUX/APIlQW10eH6ZnkV988keDNoYp+UL3WMUbcdAXLClDR+2nJkOFqtAC/rGMzz4KHEvzVSsZd4FWTyiocigZWacefiFkHUpq6ZdDnEXbGSpl5FDIFOm5kvcbjTobjcur1CvOvmSH2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474127; c=relaxed/simple;
	bh=P7wGXl6L+JiS80sbHu1yQj/GBe4Om+RVsXyVTHV9wEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpHD8mi6TyDIeJXTfU2yddQZWiXBcNb3sgMKdTTsZqe1z/62+xBKrYkzmbR0/AN4Fb42/dR8GEZg50W18RYK4IB97Z4AIPZtQmg93x686tKv8y3sBhJEN/1BtcXXB4ZnDhNrkwQbD/LWDVCqYr+B/301o2eEGUzXiSXlIp411DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfeOS8Gn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474126; x=1772010126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P7wGXl6L+JiS80sbHu1yQj/GBe4Om+RVsXyVTHV9wEA=;
  b=hfeOS8GnIj8WMV5Ma+uwnWIYYekbCK/DFRqvH8sSBxzHxWbyinxKw9WQ
   RndNuqOqRuoabRdQRv1g8EegKfNsfUySKtM60Ld10epxJVyIYkRY2HM/Y
   ypcOSZxNrpfJ76OYyAOByLHqedEofmfkyglmYmLWDPxOAjg4KZjl1gCw/
   JIgvGjANThpBzpmRURiKwJ6irFLJscZZII4Llh4Ka0vGdeZY+RQpzYAjy
   hGBTB3PrngSuUMTR6+NHlFDeJb3ASjbivGicNZFYrcKFV9GosNI1ud7Wg
   o6quWR/DP7AHQ8aCPh4JqOh+whnQmoyktj9lO/7HDZ3FanRh+pBLJmnKE
   g==;
X-CSE-ConnectionGUID: zRj746+9RwuRGZywYtnfkQ==
X-CSE-MsgGUID: iXeYqbBLQQmnS6zgftaoFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41525380"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41525380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:02:05 -0800
X-CSE-ConnectionGUID: nvV+a7ZESHqd57n+v5TJvg==
X-CSE-MsgGUID: wv7919uFStKCA1I3Tr8raw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116528155"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 25 Feb 2025 01:01:57 -0800
Date: Tue, 25 Feb 2025 17:00:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-15-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
> When a TDISP-capable device is passed through, it is configured as
> a shared device to begin with. Later on when a VM probes the device,
> detects its TDISP capability (reported via the PCIe ExtCap bit
> called "TEE-IO"), performs the device attestation and transitions it
> to a secure state when the device can run encrypted DMA and respond
> to encrypted MMIO accesses.
> 
> Since KVM is out of the TCB, secure enablement is done in the secure
> firmware. The API requires PCI host/guest BDFns, a KVM id hence such
> calls are routed via IOMMUFD, primarily because allowing secure DMA
> is the major performance bottleneck and it is a function of IOMMU.

I still have concern about the vdevice interface for bind. Bind put the
device to LOCKED state, so is more of a device configuration rather
than an iommu configuration. So seems more reasonable put the API in VFIO?

> 
> Add TDI bind to do the initial binding of a passed through PCI
> function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
> call into the TSM which forwards the calls to the PSP.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> 
> Both enabling secure DMA (== "SDTE Write") and secure MMIO (== "MMIO
> validate") are TIO GUEST REQUEST messages. These are encrypted and
> the HV (==IOMMUFD or KVM or VFIO) cannot see them unless the guest
> shares some via kvm_run::kvm_user_vmgexit (and then QEMU passes those
> via ioctls).
> 
> This RFC routes all TIO GUEST REQUESTs via IOMMUFD which arguably should
> only do so only for "SDTE Write" and leave "MMIO validate" for VFIO.

The fact is HV cannot see the guest requests, even I think HV never have
to care about the guest requests. HV cares until bind, then no HV side
MMIO & DMA access is possible, any operation/state after bind won't
affect HV more. And HV could always unbind to rollback guest side thing.

That said guest requests are nothing to do with any host side component,
iommu or vfio. It is just the message posting between VM & firmware. I
suppose KVM could directly do it by calling TSM driver API.

Thanks,
Yilun

