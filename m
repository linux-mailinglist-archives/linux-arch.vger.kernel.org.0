Return-Path: <linux-arch+bounces-10372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EDA45C27
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C4F188E990
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1D2459D4;
	Wed, 26 Feb 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlE9sQot"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6661E1E06;
	Wed, 26 Feb 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567081; cv=none; b=CGp7vPlQ30eR1u/iq+eusSl++KY/YcJSibu17LZZ0dswyYIov2IB6AjEJIeRHYMVmg0YQAbDRmr5vo4EB4b3iT4hA0JWoF88HRmMbTbs4eMVsfSZUPjUH9ryvSQ4+J07R4CzJtV7D+PO4p13yEK/qszFp2jsc2eAvquKbxBztKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567081; c=relaxed/simple;
	bh=EJRmzJTFJ8NjApj/tf5SNaCRDGeunDMttv5+CnuEb8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o18l93/Cw/mGvg/pEFfcHJIfhrAVEE3FSVVIJjbDCxA1VNY8uevD0HGuMAS53ghr2ddy1PiMRHtKvR9NJXfvbB3e2ALL5xZkn14TzZ7UaHSt3HZJSH1vfA5O06+xQFbnHOKd/21TCvfXduPQTBoWyrA2thGPHjwt+e/1dCGUi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlE9sQot; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740567080; x=1772103080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJRmzJTFJ8NjApj/tf5SNaCRDGeunDMttv5+CnuEb8g=;
  b=UlE9sQotNuJP83URwUVTRDNCrtJ0cn8w3IYzUFK/t0XbwkygwmzMFLKQ
   Lg6I52zLO9O48c/I+bZE/PnTB1I+dtfJNyhL/U6PVIn5NLWNrisnIRbiN
   TnG9QGYkQYk5cyQPysaGPITigr/3PPe69ytVObfWqs9eKHb64cDD3Iaim
   PU2gWWERqUYrtEUbkoSwsDAjZvEeHTR8UuUyAqZVCTSLA6Kc4AripAYXC
   7RBmionF/lhRXpi+1obxhMQry+7mkXrhqmzHNPpfOEPcCE1lW5EoNHDXo
   aw4cPHXwRrigGXbQZEBHxBLlS5oKiz9teAWJ7udxzFIfwF74W1/m52DNM
   g==;
X-CSE-ConnectionGUID: SNaOmWMVRH+D9KDR6a6Dcg==
X-CSE-MsgGUID: 91xqQ0xKQA63LOhGDqCOkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41603139"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41603139"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 02:51:18 -0800
X-CSE-ConnectionGUID: Sp/DqdCSR8Glw85ZGwduvg==
X-CSE-MsgGUID: ixcL/gLGQqim/7ZZJYfvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147490774"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 26 Feb 2025 02:51:09 -0800
Date: Wed, 26 Feb 2025 18:49:18 +0800
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
Message-ID: <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>

On Wed, Feb 26, 2025 at 11:12:32AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 25/2/25 20:00, Xu Yilun wrote:
> > On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
> > > When a TDISP-capable device is passed through, it is configured as
> > > a shared device to begin with. Later on when a VM probes the device,
> > > detects its TDISP capability (reported via the PCIe ExtCap bit
> > > called "TEE-IO"), performs the device attestation and transitions it
> > > to a secure state when the device can run encrypted DMA and respond
> > > to encrypted MMIO accesses.
> > > 
> > > Since KVM is out of the TCB, secure enablement is done in the secure
> > > firmware. The API requires PCI host/guest BDFns, a KVM id hence such
> > > calls are routed via IOMMUFD, primarily because allowing secure DMA
> > > is the major performance bottleneck and it is a function of IOMMU.
> > 
> > I still have concern about the vdevice interface for bind. Bind put the
> > device to LOCKED state, so is more of a device configuration rather
> > than an iommu configuration. So seems more reasonable put the API in VFIO?
> 
> IOMMUFD means pretty much VFIO (in the same way "VFIO means KVM" as 95+% of
> VFIO users use it from KVM, although VFIO works fine without KVM) so not
> much difference where to put this API and can be done either way. VFIO is

Er... I cannot agree. There are clear responsibilities for
VFIO/IOMMUFD/KVM each. They don't overlap each other. So I don't think
either way is OK. VFIO still controls the overall device behavior
and it is VFIO's decision to hand over user DMA setup to IOMMUFD. IIUC
that's why VFIO_DEVICE_ATTACH_IOMMUFD_PT should be a VFIO API.

E.g. I don't think VFIO driver would expect its MMIO access suddenly
failed without knowing what happened.

> reasonable, the immediate problem is that IOMMUFD's vIOMMU knows the guest
> BDFn (well, for AMD) and VFIO PCI does not.

For Intel, it is host BDF. But I think this is TSM architecture
difference that could be hidden in TSM framework. From TSM caller's POV,
it could just be a magic number identifying the TDI.

Back to your concern, I don't think it is a problem. From your patch,
vIOMMU doesn't know the guest BDFn by nature, it is just the user
stores the id in vdevice via iommufd_vdevice_alloc_ioctl(). A proper
VFIO API could also do this work.

I'm suggesting a VFIO API:

/*
 * @tdi_id: A TSM recognizable TDI identifier
 *	    On input, user suggests the TDI identifier number for TSM.
 *	    On output, TSM's decision of the TDI identifier number.
 */
struct vfio_pci_tsm_bind {
	__u32 argsz;
	__u32 flags;
	__u32 tdi_id;
	__u32 pad;
};

#define VFIO_DEVICE_TSM_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)

I need the tdi_id as output cause I don't want any outside TSM user and
Guest to assume what the TDI id should be.

static int vfio_pci_ioctl_tsm_bind(struct vfio_pci_core_device *vdev,
				   void __user *arg)
{
	unsigned long minsz = offsetofend(struct vfio_pci_tsm_bind, tdi_id);
	struct pci_dev *pdev = vdev->pdev;
	struct kvm *kvm = vdev->vdev.kvm;
	struct vfio_pci_tsm_bind bind;

	if (copy_from_user(&bind, arg, minsz))
		return -EFAULT;

	ret = pci_tsm_dev_bind(pdev, kvm, &bind.tdi_id);

}

A call to TSM makes TSM driver know the tdi_id and could find the real
device inside TSM via tdi_id. Following TSM call could directly use
tdi_id as parameter.

The implementation is basically no difference from:

+       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+                                              IOMMUFD_OBJ_VDEVICE),

The real concern is the device owner, VFIO, should initiate the bind.

> 
> 
> > > Add TDI bind to do the initial binding of a passed through PCI
> > > function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
> > > call into the TSM which forwards the calls to the PSP.
> > > 
> > > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > > ---
> > > 
> > > Both enabling secure DMA (== "SDTE Write") and secure MMIO (== "MMIO
> > > validate") are TIO GUEST REQUEST messages. These are encrypted and
> > > the HV (==IOMMUFD or KVM or VFIO) cannot see them unless the guest
> > > shares some via kvm_run::kvm_user_vmgexit (and then QEMU passes those
> > > via ioctls).
> > > 
> > > This RFC routes all TIO GUEST REQUESTs via IOMMUFD which arguably should
> > > only do so only for "SDTE Write" and leave "MMIO validate" for VFIO.
> > 
> > The fact is HV cannot see the guest requests, even I think HV never have
> > to care about the guest requests. HV cares until bind, then no HV side
> > MMIO & DMA access is possible, any operation/state after bind won't
> > affect HV more. And HV could always unbind to rollback guest side thing.
> > 
> > That said guest requests are nothing to do with any host side component,
> > iommu or vfio. It is just the message posting between VM & firmware. I
> > suppose KVM could directly do it by calling TSM driver API.
> 
> No, it could not as the HV needs to add the host BDFn to the guest's request
> before calling the firmware and KVM does not have that knowledge.

I think if TSM has knowledge about tdi_id, KVM doesn't have to know host BDFn.
Just let TSM handle the vendor difference. Not sure if this solves all
the problem.

> 
> These guest requests are only partly encrypted as the guest needs
> cooperation from the HV. The guest BDFn comes unencrypted from the VM to let
> the HV find the host BDFn and do the bind.

It is not about HV never touch any message content. It is about HV
doesn't (and shouldn't, since some info is encrypted) influence any host
behavior by executing guest request, so no need to route to any other
component.

Thanks,
Yilun

> 
> Also, say, in order to enable MMIO range, the host needs to "rmpupdate"
> MMIOs first (and then the firmware does "pvalidate") so it needs to know the
> range which is in unencrypted part of guest request.
> 
> Here is a rough idea: https://github.com/aik/qemu/commit/f804b65aff5b
> 
> A TIO Guest request is made of:
> - guest page with unencrypted header (msg type is essential) and encrypted
> body for consumption by the firmware;
> - a couple of 64bit bit fields and RAX/RBX/... in shared GHCB page.
> 
> Thanks,
> 
> > Thanks,
> > Yilun
> 
> -- 
> Alexey
> 

