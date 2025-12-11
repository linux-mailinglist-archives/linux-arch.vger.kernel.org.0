Return-Path: <linux-arch+bounces-15339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3DCB51E0
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 09:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1BF53001E1A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE412E093A;
	Thu, 11 Dec 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NkXIZp2t"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF72D5959;
	Thu, 11 Dec 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441882; cv=none; b=Sz7oBTBMSytBBkhbZtoGGOEjfwW9fijYAPoK9ZGmhP78gTeXYQQuWz8FFMaMZb5fOKCqy+aKveuykGbYITjWCB57WNUtWHt5O4iFILv1SFLyG84WF0dZNObFhjVMjGpJabnjdLheWDU0N5DTdnsNK2KQT8UQojPkvGTt8F2B+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441882; c=relaxed/simple;
	bh=ijyecVlGRghY3cjM7gKx+/ozmDBdpqLFKBVGoxUFLL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBvMNKQNhBJIWq2c0uYSYZY8rZ4+iCIevA6LIJUUeiyAcjzFPBX4Z6z+uq6mLlq37h7vgsX3i39FkgsleNj5+kUb6XDgdXgejS7A0deWKsnrtGajobPZwKYE+AiQgtacylK0QVZAHV635Sb0Mhw4H5Oc1riBpgzsAIpgW5acufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NkXIZp2t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24ACD2120EB9;
	Thu, 11 Dec 2025 00:31:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24ACD2120EB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765441880;
	bh=4uKKF6ilF0G3qsBBt++MJsscl/aBH34AhodmDMUwqI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkXIZp2tmECE4hLehiMXm+vs4En0DMNgjDcPT3CA7OPQYtwM0Ci28wXlmcLd87q8r
	 5KMr6OajWTy3ZFLT3uO56dZlxcTNOButWe3RmHh5VSna1lDzW2lC7LW6iLvX+hMk0n
	 BvE6gBLJiAmtfsCAwnzdlA3IZedxyKcIjVHFlLlQ=
Date: Thu, 11 Dec 2025 16:31:18 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	arnd@arndb.de, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com, nunodasneves@linux.microsoft.com, 
	mrathor@linux.microsoft.com, mhklinux@outlook.com, peterz@infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
Message-ID: <oqpivhhbgcc3hcmkq3cumn6d7rxxjgqmmdwlfpejjo2ztsth6u@ejhydql5xmsx>
References: <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
 <20251210213945.GA3541010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210213945.GA3541010@bhelgaas>

On Wed, Dec 10, 2025 at 03:39:45PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 09, 2025 at 01:11:24PM +0800, Yu Zhang wrote:
> > From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > 
> > Hyper-V uses a logical device ID to identify a PCI endpoint device for
> > child partitions. This ID will also be required for future hypercalls
> > used by the Hyper-V IOMMU driver.
> > 
> > Refactor the logic for building this logical device ID into a standalone
> > helper function and export the interface for wider use.
> > 
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
> >  include/asm-generic/mshyperv.h      |  2 ++
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 146b43981b27..4b82e06b5d93 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> >  
> >  #define hv_msi_prepare		pci_msi_prepare
> >  
> > +/**
> > + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
> > + * function number of the device.
> > + */
> > +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
> > +{
> > +	struct pci_bus *pbus = pdev->bus;
> > +	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
> > +						struct hv_pcibus_device, sysdata);
> > +
> > +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
> > +		     (hbus->hdev->dev_instance.b[4] << 16) |
> > +		     (hbus->hdev->dev_instance.b[7] << 8)  |
> > +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > +		     PCI_FUNC(pdev->devfn));
> > +}
> > +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
> > +
> >  /**
> >   * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
> >   * affinity.
> >   * @data:	Describes the IRQ
> >   *
> >   * Build new a destination for the MSI and make a hypercall to
> > - * update the Interrupt Redirection Table. "Device Logical ID"
> > - * is built out of this PCI bus's instance GUID and the function
> > - * number of the device.
> > + * update the Interrupt Redirection Table.
> >   */
> >  static void hv_irq_retarget_interrupt(struct irq_data *data)
> >  {
> > @@ -642,11 +658,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
> >  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
> >  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> >  	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
> > -	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> > -			   (hbus->hdev->dev_instance.b[4] << 16) |
> > -			   (hbus->hdev->dev_instance.b[7] << 8) |
> > -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > -			   PCI_FUNC(pdev->devfn);
> > +	params->device_id = hv_build_logical_dev_id(pdev);
> >  	params->int_target.vector = hv_msi_get_int_vector(data);
> >  
> >  	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index 64ba6bc807d9..1a205ed69435 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -71,6 +71,8 @@ extern enum hv_partition_type hv_curr_partition_type;
> >  extern void * __percpu *hyperv_pcpu_input_arg;
> >  extern void * __percpu *hyperv_pcpu_output_arg;
> >  
> > +extern u64 hv_build_logical_dev_id(struct pci_dev *pdev);
> 
> Curious why you would include the "extern" in this declaration?  It's
> not *wrong*, but it's not necessary, and other declarations in this
> file omit it, e.g., the ones below:
> 

Thank you, Bjorn.
Actually I don't think it is necessary. Will remove it in v2. :)

B.R.
Yu

