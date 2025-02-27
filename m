Return-Path: <linux-arch+bounces-10427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B2A48379
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D6F1735AD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DE190661;
	Thu, 27 Feb 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bhB7HFJJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1418D63A;
	Thu, 27 Feb 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671332; cv=none; b=JHKqMdbu1xl8Ns/Tj5Yii3my1ry44Lib9FTQ2M/Hac2J4hSlqB+sgw4/Chy3HCC279wNuCIYxg6d4J0/PX6ST1dKgguPrO2xDeKQ2GLwDZ9LuczwjuhzoWOoIkLJcwDg7cb9yjwyHtnVoT6Jjrzitr6+HWEMRQB8VA0X1s4YMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671332; c=relaxed/simple;
	bh=0wcPQPb2fNJUO+Eb0zzXVRSq1giqQ/8OloyEuJ66EuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5A6g+OKUkJnpr4xiqTrHGTP1bE/2t49E9vOiKvnO/in/rSMby56zAkuFL7FhBvZd0F22UtMAoVUY4cY1qb0Mjooeott98NT+4H4o80A8Smi2DlnpcI2pbxvu9gRCFpcJndItqPbTz5jpDRndeuLAuuPhq25pCQJf4SsOHjx24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bhB7HFJJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C698740E0202;
	Thu, 27 Feb 2025 15:48:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BNABbrUU7UVH; Thu, 27 Feb 2025 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740671322; bh=RfLqHPbgshcEvdoRTouaG0WtklGb1Cpk3e2N6dqyufI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhB7HFJJTzYFiNtEQ7Ry4AOSt+vubFQzRFpl8pLH6lPdQY/vQZbECcxmJVRXwDmP+
	 Ty0v2D0PZSVvAiKSlknFOnYeY6hmAdymwquUcvE8s+lnlKzU5oN6xiCKrGigmQHZlA
	 HUKlzBCh2DSBLhqseypFt3nfP87QHViv09pPRZ9cStHVwu9Ra7yxH0iUukeCynPVfu
	 pE0hWYT3MCM8WDmTZNIZ0pGVkm0lIbvDE+kkqcjQyVp3Q+8NOl6yqga2XySI3G2d8d
	 Hk0iNfyWnrbHCnkOEWfR5Zo7Jgk0tbkq6z34pfF5c6TYjT3xUD+aZKxjk+XKGlnJtS
	 F507b++2ioSacDGZCMftapo8KZpR9qMEs8SaaLG+bm2KBuqO1tJBr9kHV3xAJXLhGU
	 MjN69DOjsUWpB369Cg+waI3WeAJbXZLnmOjtn1OwfrU9zgtbmwJmAv++V62xOSjkWu
	 FzpO1lFiY2aGpM9CKQt/N1KqdBR7XbmF7R6/Qwrp3Oaz6e+cJUIMKND2uwUfkzvWgx
	 F8mCAiny/KwMv+psAH0hvJIKcvgFo+z4ic3PdzQtIdB8K8LZy49D2Qdu5hBzdb22m7
	 dL77myrMRKlvcfeXqdmanb+iCtPV1R+CJeNIDaG59kRGo9BR0uzrxrPQOuxkN0HhFH
	 7ihXLCSdSnOlQm3BClQguJvM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBBA240E01A3;
	Thu, 27 Feb 2025 15:48:06 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:48:00 +0100
From: Borislav Petkov <bp@alien8.de>
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
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 00/22] TSM: Secure VFIO, TDISP, SEV TIO
Message-ID: <20250227154800.GBZ8CJMCH9wIptw1jd@fat_crate.local>
References: <20250218111017.491719-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-1-aik@amd.com>

FWIW,

I really appreciate this mail which explains to unenlightened people like me
what this is all about.

Especially the Acronyms, Flow, Specs pointers etc. I wish I could see this
type of writeups in all patchsets' 0th messages, leading in the reader into
the topic while not expecting the latter to actually *know* all those things
because, d0h, it is obvious. You can read my mind, right? :-)

So thanks for taking the time - it is very helpful!

On Tue, Feb 18, 2025 at 10:09:47PM +1100, Alexey Kardashevskiy wrote:
> Here are some patches to enable SEV-TIO on AMD Turin. It's been a while
> and got quiet and I kept fixing my tree and wondering if I am going in
> the right direction.
> 
> SEV-TIO allow a guest to establish trust in a device that supports TEE
> Device Interface Security Protocol (TDISP, defined in PCIe r6.0+) and
> then interact with the device via private memory.
> 
> These include both guest and host support. QEMU also requires changes.
> This is more to show what it takes on AMD EPYC to pass through TDISP
> devices, hence "RFC".
> 
> Components affected:
> KVM
> IOMMUFD
> CCP (AMD)
> SEV-GUEST (AMD)
> 
> New components:
> PCI IDE
> PCI TSM
> VIRT CoCo TSM
> VIRT CoCo TSM-HOST
> VIRT CoCo TSM-GUEST
> 
> 
> This is based on a merge of Lukas'es CMA and 1 week old upstream + some of Dan's patches:
> 
> https://github.com/aik/linux/tree/tsm
> https://github.com/aik/qemu/tree/tsm
> 
> Not using "[PATCH 03/11] coco/tsm: Introduce a class device for TEE Security Managers"
> yet as may be (may be) my approach makes sense too. Tried to stick to the terminology.
> I have done some changes on top of that, these are on github, not posting here as
> I expect those to be addressed in that thread:
> https://lore.kernel.org/linux-coco/173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com/T/
> 
> 
> SEV TIO spec:
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58271_0_70.pdf
> Whitepaper:
> https://www.amd.com/content/dam/amd/en/documents/epyc-business-docs/white-papers/sev-tio-whitepaper.pdf
> 
> 
> Acronyms:
> 
> TEE - Trusted Execution Environments, a concept of managing trust between the host
> 	and devices
> TSM - TEE Security Manager (TSM), an entity which ensures security on the host
> PSP - AMD platform secure processor (also "ASP", "AMD-SP"), acts as TSM on AMD.
> SEV TIO - the TIO protocol implemented by the PSP and used by the host
> GHCB - guest/host communication block - a protocol for guest-to-host communication
> 	via a shared page
> TDISP - TEE Device Interface Security Protocol (PCIe).
> 
> 
> Flow:
> 
> - Boot host OS, load CCP and PCI TSM (they will load TSM-HOST too)
> - PCI TSM creates sysfs nodes in "coco/tsm: Add tsm and tsm-host modules" for all TDISP-capable devices
> - Enable IDE via "echo 0 > /sys/bus/pci/devices/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_connect"
> - Examine certificates/measurements/status via sysfs
> 
> - run an SNP VM _without_ VFIO PCI device, wait till it is booted
> - hotplug a TDISP-capable PCI function, IOMMUFD must be used (not a VFIO container)
> - QEMU pins all guest memory via IOMMUFD map-from-fd ioctl()
> - the VM detects a TDISP-capable device, creates sysfs nodes in "coco/tsm: Add tsm-guest module"
> - the VM loads the device driver which goes as usual till enabling bus master (for convinience)
> - TSM-GUEST modules listens for bus master event (hacked in "pci: Add BUS_NOTIFY_PCI_BUS_MASTER event")
> - TSM-GUEST requests TDI ("trusted PCI VF") info, traps into QEMU
> - QEMU binds the VF to the Coco VM in the secure fw (AMD PSP) via IOMMUFD ioctl
> - QEMU reads certificates/measurements/interface report from the hosts sysfs and writes to the guest memory
> - the guest receives all the data, examines it (not in this series though)
> - the guest enables secure DMA and MMIO by calling GHCB which traps into QEMU
> - QEMU calls IOMMUFD ioctl to enable secure DMA and MMIO
> - the guest can now stop sharing memory for DMA (and expect DMA to encrypted memory to work) and
> start accessing validated MMIO with Cbit set.
> 
> 
> 
> Assumptions
> 
> This requires hotpligging into the VM vs passing the device via the command line as
> VFIO maps all guest memory as the device init step which is too soon as
> SNP LAUNCH UPDATE happens later and will fail if VFIO maps private memory before that.
> 
> This requires the BME hack as MMIO and BusMaster enable bits cannot be 0 after MMIO
> validation is done and there are moments in the guest OS booting process when this
> appens.
> 
> SVSM could help addressing these (not implemented).
> 
> QEMU advertises TEE-IO capability to the VM. An additional x-tio flag is added to
> vfio-pci.
> 
> Trying to avoid the device driver modification as much as possible at
> the moment as my test devices already exist in non-TDISP form and need to work without
> modification. Arguably this may not be always the case.
> 
> 
> TODOs
> 
> Deal with PCI reset. Hot unplug+plug? Power states too.
> Actually collaborate with CMA.
> Other tons of things.
> 
> 
> The previous conversation is here:
> https://lore.kernel.org/r/20240823132137.336874-1-aik@amd.com
> 
> 
> Changes:
> v2:
> * redid the whole thing pretty much
> * RMPUPDATE API for QEMU
> * switched to IOMMUFD
> * mapping guest memory via IOMMUFD map-from-fd
> * marking resouces as validated
> * more modules
> * moved tons to the userspace (QEMU), such as TDI bind and GHCB guest requests
> 
> 
> Sean, get_maintainer.pl produced more than 100 emails for the entire
> patchset, should I have posted them all anyway?
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (22):
>   pci/doe: Define protocol types and make those public
>   PCI/IDE: Fixes to make it work on AMD SNP-SEV
>   PCI/IDE: Init IDs on all IDE streams beforehand
>   iommu/amd: Report SEV-TIO support
>   crypto: ccp: Enable SEV-TIO feature in the PSP when supported
>   KVM: X86: Define tsm_get_vmid
>   coco/tsm: Add tsm and tsm-host modules
>   pci/tsm: Add PCI driver for TSM
>   crypto/ccp: Implement SEV TIO firmware interface
>   KVM: SVM: Add uAPI to change RMP for MMIO
>   KVM: SEV: Add TIO VMGEXIT
>   iommufd: Allow mapping from guest_memfd
>   iommufd: amd-iommu: Add vdevice support
>   iommufd: Add TIO calls
>   KVM: X86: Handle private MMIO as shared
>   coco/tsm: Add tsm-guest module
>   resource: Mark encrypted MMIO resource on validation
>   coco/sev-guest: Implement the guest support for SEV TIO
>   RFC: pci: Add BUS_NOTIFY_PCI_BUS_MASTER event
>   sev-guest: Stop changing encrypted page state for TDISP devices
>   pci: Allow encrypted MMIO mapping via sysfs
>   pci: Define pci_iomap_range_encrypted
> 
>  drivers/crypto/ccp/Makefile                 |   13 +
>  drivers/pci/Makefile                        |    3 +
>  drivers/virt/coco/Makefile                  |    2 +
>  drivers/virt/coco/guest/Makefile            |    3 +
>  drivers/virt/coco/host/Makefile             |    6 +
>  drivers/virt/coco/sev-guest/Makefile        |    2 +-
>  arch/x86/include/asm/kvm-x86-ops.h          |    1 +
>  arch/x86/include/asm/kvm_host.h             |    2 +
>  arch/x86/include/asm/sev.h                  |   31 +
>  arch/x86/include/uapi/asm/kvm.h             |   11 +
>  arch/x86/include/uapi/asm/svm.h             |    2 +
>  drivers/crypto/ccp/sev-dev-tio.h            |  111 ++
>  drivers/crypto/ccp/sev-dev.h                |   19 +
>  drivers/iommu/amd/amd_iommu_types.h         |    3 +
>  drivers/iommu/iommufd/iommufd_private.h     |    3 +
>  include/asm-generic/pci_iomap.h             |    4 +
>  include/linux/amd-iommu.h                   |    2 +
>  include/linux/device.h                      |    4 +
>  include/linux/device/bus.h                  |    3 +
>  include/linux/dma-direct.h                  |    8 +
>  include/linux/ioport.h                      |    2 +
>  include/linux/kvm_host.h                    |    2 +
>  include/linux/pci-doe.h                     |    4 +
>  include/linux/pci-ide.h                     |   19 +-
>  include/linux/pci.h                         |    2 +-
>  include/linux/psp-sev.h                     |   61 +-
>  include/linux/swiotlb.h                     |    8 +
>  include/linux/tsm.h                         |  315 ++++
>  include/uapi/linux/iommufd.h                |   26 +
>  include/uapi/linux/kvm.h                    |   24 +
>  include/uapi/linux/pci_regs.h               |    5 +-
>  include/uapi/linux/psp-sev.h                |    6 +-
>  include/uapi/linux/sev-guest.h              |   39 +
>  arch/x86/coco/sev/core.c                    |   19 +-
>  arch/x86/kvm/mmu/mmu.c                      |    6 +-
>  arch/x86/kvm/svm/sev.c                      |  205 +++
>  arch/x86/kvm/svm/svm.c                      |   12 +
>  arch/x86/mm/ioremap.c                       |    2 +
>  arch/x86/mm/mem_encrypt.c                   |    6 +
>  arch/x86/virt/svm/sev.c                     |   34 +-
>  drivers/crypto/ccp/sev-dev-tio.c            | 1664 ++++++++++++++++++++
>  drivers/crypto/ccp/sev-dev-tsm.c            |  709 +++++++++
>  drivers/crypto/ccp/sev-dev.c                |   94 +-
>  drivers/iommu/amd/init.c                    |    9 +
>  drivers/iommu/amd/iommu.c                   |   60 +-
>  drivers/iommu/iommufd/main.c                |    6 +
>  drivers/iommu/iommufd/pages.c               |   88 +-
>  drivers/iommu/iommufd/viommu.c              |  112 ++
>  drivers/pci/doe.c                           |    2 -
>  drivers/pci/ide.c                           |  103 +-
>  drivers/pci/iomap.c                         |   24 +
>  drivers/pci/mmap.c                          |   11 +-
>  drivers/pci/pci-sysfs.c                     |   27 +-
>  drivers/pci/pci.c                           |    3 +
>  drivers/pci/proc.c                          |    2 +-
>  drivers/pci/tsm.c                           |  233 +++
>  drivers/virt/coco/guest/tsm-guest.c         |  326 ++++
>  drivers/virt/coco/host/tsm-host.c           |  551 +++++++
>  drivers/virt/coco/sev-guest/sev_guest.c     |   10 +
>  drivers/virt/coco/sev-guest/sev_guest_tio.c |  738 +++++++++
>  drivers/virt/coco/tsm.c                     |  638 ++++++++
>  kernel/resource.c                           |   48 +
>  virt/kvm/kvm_main.c                         |    6 +
>  Documentation/virt/coco/tsm.rst             |  132 ++
>  drivers/crypto/ccp/Kconfig                  |    2 +
>  drivers/pci/Kconfig                         |   15 +
>  drivers/virt/coco/Kconfig                   |   14 +
>  drivers/virt/coco/guest/Kconfig             |    3 +
>  drivers/virt/coco/host/Kconfig              |    6 +
>  drivers/virt/coco/sev-guest/Kconfig         |    1 +
>  70 files changed, 6614 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/virt/coco/host/Makefile
>  create mode 100644 drivers/crypto/ccp/sev-dev-tio.h
>  create mode 100644 drivers/crypto/ccp/sev-dev-tio.c
>  create mode 100644 drivers/crypto/ccp/sev-dev-tsm.c
>  create mode 100644 drivers/pci/tsm.c
>  create mode 100644 drivers/virt/coco/guest/tsm-guest.c
>  create mode 100644 drivers/virt/coco/host/tsm-host.c
>  create mode 100644 drivers/virt/coco/sev-guest/sev_guest_tio.c
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 Documentation/virt/coco/tsm.rst
>  create mode 100644 drivers/virt/coco/host/Kconfig
> 
> -- 
> 2.47.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

