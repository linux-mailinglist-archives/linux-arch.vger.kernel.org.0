Return-Path: <linux-arch+bounces-15728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CFD0BE59
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25F2307446D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221A29D29E;
	Fri,  9 Jan 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XoCTjqjf"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989529AB11;
	Fri,  9 Jan 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984059; cv=none; b=ZwLB0n4XbRVTiYTfFwQJl4RLooi477fkQP0KUW1Qg56RwXZeOBQy/nsQ4sWbhnblra2DB9CgMkhSaCs2x9Aqr2V0WbnHN8FqIGpDa3S9zh4sg6paxd1n9cnF6ll9YLyX3oPnFQiV+4RgMBH0lGfw1Xj6L6HC+0IfWZmRyx4g7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984059; c=relaxed/simple;
	bh=DVq+iGiTpsM0PMC6tUEaMCxyeanmPJ7pPH4Fuz4eSW4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NvMmgqPR338CuBFVqGkTkTHeL583/u68jWoPr7jk+/5LQfYeHVjhewFMbgvEGp6qFhrWaa+gi1NLS33bqNjcyk0exKvbYDuUTFoDqOW0f9HaFsYPFOMfjaKumk/0GEHWpP7DAdfuO653/eO2ZcHKs7O4wp4OCEv530QE+m7aMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XoCTjqjf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33C37201AC63;
	Fri,  9 Jan 2026 10:40:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33C37201AC63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767984048;
	bh=kAjbPy112sQr9pnjoL+tUHNQcw11KZSGpWO64sBkgeE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XoCTjqjf+0cTQ6+NtsMwPbX50/W1KMFtwywbDEjthV4ZPrQ3/CmR7oiAwy21nY7rJ
	 Y2odzPK/fEx7S4+CSSS5DZS4wC4zfamvChcOdOiGiDhUTiF/DzCeaYKBZqseFb96HY
	 s0nYe32guvtm4GRcc3F0wToZT7BPJK4ayFHtHr/w=
Message-ID: <162c901f-69a7-420a-9148-a469d5a8ca4f@linux.microsoft.com>
Date: Fri, 9 Jan 2026 10:40:38 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 easwar.hariharan@linux.microsoft.com, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
To: Michael Kelley <mhklinux@outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41570FC0D7EA1364FB48CD1ED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB41570FC0D7EA1364FB48CD1ED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2026 10:46 AM, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
>>
>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>
>> Hyper-V uses a logical device ID to identify a PCI endpoint device for
>> child partitions. This ID will also be required for future hypercalls
>> used by the Hyper-V IOMMU driver.
>>
>> Refactor the logic for building this logical device ID into a standalone
>> helper function and export the interface for wider use.
>>
>> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
>> ---
>>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>>  include/asm-generic/mshyperv.h      |  2 ++
>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 146b43981b27..4b82e06b5d93 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>>
>>  #define hv_msi_prepare		pci_msi_prepare
>>
>> +/**
>> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
>> + * function number of the device.
>> + */
>> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
>> +{
>> +	struct pci_bus *pbus = pdev->bus;
>> +	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
>> +						struct hv_pcibus_device, sysdata);
>> +
>> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
>> +		     (hbus->hdev->dev_instance.b[4] << 16) |
>> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
>> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
>> +		     PCI_FUNC(pdev->devfn));
>> +}
>> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
> 
> This change is fine for hv_irq_retarget_interrupt(), it doesn't help for the
> new IOMMU driver because pci-hyperv.c can (and often is) built as a module.
> The new Hyper-V IOMMU driver in this patch series is built-in, and so it can't
> use this symbol in that case -- you'll get a link error on vmlinux when building
> the kernel. Requiring pci-hyperv.c to *not* be built as a module would also
> require that the VMBus driver not be built as a module, so I don't think that's
> the right solution.
> 
> This is a messy problem. The new IOMMU driver needs to start with a generic
> "struct device" for the PCI device, and somehow find the corresponding VMBus
> PCI pass-thru device from which it can get the VMBus instance ID. I'm thinking
> about ways to do this that don't depend on code and data structures that are
> private to the pci-hyperv.c driver, and will follow-up if I have a good suggestion.

Thank you, Michael. FWIW, I did try to pull out the device ID components out of 
pci-hyperv into include/linux/hyperv.h and/or a new include/linux/pci-hyperv.h
but it was just too messy as you say.

> I was wondering if this "logical device id" is actually parsed by the hypervisor,
> or whether it is just a unique ID that is opaque to the hypervisor. From the
> usage in the hypercalls in pci-hyperv.c and this new IOMMU driver, it appears
> to be the former. Evidently the hypervisor is taking this logical device ID and
> and matching against bytes 4 thru 7 of the instance GUIDs of PCI pass-thru
> devices offered to the guest, so as to identify a particular PCI pass-thru device.
> If that's the case, then Linux doesn't have the option of choosing some other
> unique ID that is easier to generate and access. 

Yes, the device ID is actually used by the hypervisor to find the corresponding PCI
pass-thru device and the physical IOMMUs the device is behind and execute the
requested operation for those IOMMUs.

> There's a uniqueness issue with this kind of logical device ID that has been
> around for years, but I had never thought about before. In hv_pci_probe()
> instance GUID bytes 4 and 5 are used to generate the PCI domain number for
> the "fake" PCI bus that the PCI pass-thru device resides on. The issue is the
> lack of guaranteed uniqueness of bytes 4 and 5, so there's code to deal with
> a collision. (The full GUID is unique, but not necessarily some subset of the
> GUID.) It seems like the same kind of uniqueness issue could occur here. Does
> the Hyper-V host provide any guarantees about the uniqueness of bytes 4 thru
> 7 as a unit, and if not, what happens if there is a collision? Again, this
> uniqueness issue has existed for years, so it's not new to this patch set, but
> with new uses of the logical device ID, it seems relevant to consider.
 
Thank you for bringing that up, I was aware of the uniqueness workaround but, like you,
I had not considered that the workaround could prevent matching the device ID with the
record the hypervisor has of the PCI pass-thru device assigned to us. I will work with
the hypervisor folks to resolve this before this patch series is posted for merge.

Thanks,
Easwar (he/him)

