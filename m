Return-Path: <linux-arch+bounces-15752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0094D14354
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7BC8300D56F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005E37418C;
	Mon, 12 Jan 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iyp0LtXm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22B374162;
	Mon, 12 Jan 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236972; cv=none; b=RpscMs6RGycK7Ie0aWoVlPVmicDOvdtp1pBidGcvI53ztIyJLwJ8VaSfNYskSACTiSNt0+uXe6XM5lWcKizqTr4h2JwdKpDGPYU0kZ3jER6oB+1LTDJ1K4/GTe54wRuFW6rit+MmqNFD5pg1WnSMr9N4cnHhHnk05l5iukisS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236972; c=relaxed/simple;
	bh=4AIR4AvPq3Ns2DHXtbzi9LyzcVtMVSrGcoQEOK0g09A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg6pFJP8egcgQlabLKjaIEiCNNdCxBhDeJpl8QdXhNfIXSkDuUq7wPriD8I2jHmLd9LmEBTMmLPnluJmGP7gEKUZs3dUFQY8MyBSvywJiKJ1WDiO0Bebv6IEWGhwoCTZRFTgTRc3qTGkmZhDGSYnd9RhwreyIWV6kIwiqy9YrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iyp0LtXm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93229200DF42;
	Mon, 12 Jan 2026 08:56:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93229200DF42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768236969;
	bh=9ykwBAFENziY1dzJcAT4kgTGes6gFi0zDtJJzU5PgnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iyp0LtXm9vd9sZCnHL6bXM+gkE0eeFFH98lUF/kx/XqkyQbpU9X6DKxz3Qx+rVkKj
	 fZp7Agbify5AcXGt5NCQ4D1W+o+apsAGDsr6GxRJ9S40te3+XTZnGMMBADAlFSTiwP
	 0WOfJ/1Kf+DazvD7YnO2+X6pV3abncilnzFsCGPo=
Date: Tue, 13 Jan 2026 00:56:07 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, 
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <dws34g6znmam7eabwetg722b4wgf2wxufcqxqphhbqlryx23mb@we5utwanawe2>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jan 08, 2026 at 06:48:59PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM

<snip>
Thank you so much, Michael, for the thorough review!

I've snipped some comments I fully agree with and will address in 
next version. Actually, I have to admit I agree with your remaining
comments below as well. :)

> > +struct hv_iommu_dev *hv_iommu_device;
> > +static struct hv_iommu_domain hv_identity_domain;
> > +static struct hv_iommu_domain hv_blocking_domain;
> 
> Why is hv_iommu_device allocated dynamically while the two
> domains are allocated statically? Seems like the approach could
> be consistent, though maybe there's some reason I'm missing.
> 

On second thought, `hv_identity_domain` and `hv_blocking_domain` should
likely be allocated dynamically as well, consistent with `hv_iommu_device`.

<snip>
> > +static int hv_iommu_get_logical_device_property(struct device *dev,
> > +					enum hv_logical_device_property_code code,
> > +					struct hv_output_get_logical_device_property *property)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_get_logical_device_property *input;
> > +	struct hv_output_get_logical_device_property *output;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	memset(output, 0, sizeof(*output));
> 
> General practice is to *not* zero the output area prior to a hypercall. The hypervisor
> should be correctly setting all the output bits. There are a couple of cases in the new
> MSHV code where the output is zero'ed, but I'm planning to submit a patch to
> remove those so that hypercall call sites that have output are consistent across the
> code base. Of course, it's possible to have a Hyper-V bug where it doesn't do the
> right thing, and zero'ing the output could be done as a workaround. But such cases
> should be explicitly known with code comments indicating the reason for the
> zero'ing.
> 
> Same applies in hv_iommu_detect().
> 

Thanks for the information! Just to clarify: this is only because Hyper-V is
supposed to zero the output page, and for input page, memset is still needed.
Am I correct?

<snip>

> > +static void hv_iommu_shutdown(void)
> > +{
> > +	iommu_device_sysfs_remove(&hv_iommu_device->iommu);
> > +
> > +	kfree(hv_iommu_device);
> > +}
> > +
> > +static struct syscore_ops hv_iommu_syscore_ops = {
> > +	.shutdown = hv_iommu_shutdown,
> > +};
> 
> Why is a shutdown needed at all?  hv_iommu_shutdown() doesn't do anything
> that really needed, since sysfs entries are transient, and freeing memory isn't
> relevant for a shutdown.
> 

For iommu_device_sysfs_remove(), I guess they are not necessary, and
I will need to do some homework to better understand the sysfs. :)
Originally, we wanted a shutdown routine to trigger some hypercall,
so that Hyper-V will disable the DMA translation, e.g., during the VM
reboot process. 

<snip>

> > +device_initcall(hv_iommu_init);
> 
> I'm concerned about the timing of this initialization. VMBus is initialized with
> subsys_initcall(), which is initcall level 4 while device_initcall() is initcall level 6.
> So VMBus initialization happens quite a bit earlier, and the hypervisor starts
> offering devices to the guest, including PCI pass-thru devices, before the
> IOMMU initialization starts. I cobbled together a way to make this IOMMU code
> run in an Azure VM using the identity domain. The VM has an NVMe OS disk,
> two NVMe data disks, and a MANA NIC. The NVMe devices were offered, and
> completed hv_pci_probe() before this IOMMU initialization was started. When
> IOMMU initialization did run, it went back and found the NVMe devices. But
> I'm unsure if that's OK because my hacked together environment obviously
> couldn't do real IOMMU mapping. It appears that the NVMe device driver
> didn't start its initialization until after the IOMMU driver was setup, which
> would probably make everything OK. But that might be just timing luck, or
> maybe there's something that affirmatively prevents the native PCI driver
> (like NVMe) from getting started until after all the initcalls have finished.
> 

This is yet another immature attempt by me to do the hv_iommu_init() in
an arch-independent path. And I do not think using device_initcall() is
harmless. This patch set was tested using an assigned Intel DSA device,
and the DMA tests succeeded w/o any error. But that is not enough to
justify using device_initcall(): I reset the idxd driver as kernel
builtin and realized, just like you said, both hv_pci_probe() and
idxd_pci_probe() were triggered before hv_iommu_init(), and when pvIOMMU
tries to probe the endpoint device, a warning is printed:

[    3.609697] idxd 13d7:00:00.0: late IOMMU probe at driver bind, something fishy here!

> I'm planning to look at this further to see if there's a way for a PCI driver
> to try initializing a pass-thru device *before* this IOMMU driver has initialized.
> If so, a different way to do the IOMMU initialization will be needed that is
> linked to VMBus initialization so things can't happen out-of-order. Establishing
> such a linkage is probably a good idea regardless.
> 
> FWIW, the Azure VM with the 3 NVMe devices and MANA, and operating with
> the identity IOMMU domain, all seemed to work fine! Got 4 IOMMU groups,
> and devices coming and going dynamically all worked correctly. When a device
> was removed, it was moved to the blocking domain, and then flushed before
> being finally removed. All good! I wish I had a way to test with an IOMMU
> paging domain that was doing real translation.
> 

Thank you, Michael! I really appreciate you running these extra experiments!

My tests on this DSA device passed (using paging domain) too, with no DMA
errors observed (regardless its driver is builtin or as a kernel module).
But that doesn't make me confident about using `device_initcall`. I believe
your concern is valid. E.g., an endpoint device might allocate a DMA address(
using a raw GPA, instead of gIOVA) before pvIOMMU is initialized, and then
use that address for DMA later, after a paging domain is attached?

> > diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
> > new file mode 100644
> > index 000000000000..c8657e791a6e
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv/iommu.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Hyper-V IOMMU driver.
> > + *
> > + * Copyright (C) 2024-2025, Microsoft, Inc.
> > + *
> > + */
> > +
> > +#ifndef _HYPERV_IOMMU_H
> > +#define _HYPERV_IOMMU_H
> > +
> > +struct hv_iommu_dev {
> > +	struct iommu_device iommu;
> > +	struct ida domain_ids;
> > +
> > +	/* Device configuration */
> > +	u8  max_iova_width;
> > +	u8  max_pasid_width;
> > +	u64 cap;
> > +	u64 pgsize_bitmap;
> > +
> > +	struct iommu_domain_geometry geometry;
> > +	u64 first_domain;
> > +	u64 last_domain;
> > +};
> > +
> > +struct hv_iommu_domain {
> > +	union {
> > +		struct iommu_domain    domain;
> > +		struct pt_iommu        pt_iommu;
> > +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> > +	};
> > +	struct hv_iommu_dev *hv_iommu;
> > +	struct hv_input_device_domain device_domain;
> > +	u64		pgsize_bitmap;
> > +
> > +	spinlock_t lock; /* protects dev_list and TLB flushes */
> > +	/* List of devices in this DMA domain */
> 
> It appears that this list is really a list of endpoints (i.e., struct
> hv_iommu_endpoint), not devices (which I read to be struct
> hv_iommu_dev). 
> 
> But that said, what is the list used for?  I see code to add
> endpoints to the list, and to remove then, but the list is never
> walked by any code in this patch set. If there is an anticipated
> future use, it would be better to add the list as part of the code
> for that future use.
> 

Yes, we do not really need this list for this patch set. Thanks!

B.R.
Yu

