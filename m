Return-Path: <linux-arch+bounces-11670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B6A9FBA1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DA94673C0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A720D4F9;
	Mon, 28 Apr 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M3xCB6nI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC41EE7BE;
	Mon, 28 Apr 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874466; cv=none; b=dJhf1s8vp318S037a/jxgpdWmy0CXiDTXVAIYshRi16VFvbrNNF6gxkq+z2ztE4b7je83jRB3dowewaUwI9RwR6JgL0ymCwNgGkk0a16ks1KafUS2RrZavjU/XBx+4adLGkESc3N6uEKblJBoSeFi+UZCucDzmDQbAieiAm/Z4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874466; c=relaxed/simple;
	bh=mAuZnXpIZXza2yqaFmmckcE6EI9/mgIYuU1UPpg+56Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UXmYSsyjpZg3ruJVawPnndopQ/Ouncja+9N+T1leK5iwrGdzAGpS7OTaVTQBywe25wY3DUmFplTnGYBjyQCZy0cjQN54PCm4LNuWLWgiC/CXhkU/T8Hq90ISB7LofJgtnJr8YvO66tH6H7VuhnMNGV2j9GQkMu0nCBYZmE4O8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M3xCB6nI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB61E20BCAD1;
	Mon, 28 Apr 2025 14:07:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB61E20BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745874464;
	bh=QSRzi2tZPIvIrsfPgn9XnDgdRLZDtKC6Y9CQpDRifwU=;
	h=From:To:Cc:Subject:Date:From;
	b=M3xCB6nI4T4edZdfuN4uLmiKdfs9Tkgkm2Xw1x/aOJOEqATA7M2R5w4ioXAc27Mjp
	 lnQgmvPptLQOrU9ARFnraU78ZUBqWG4x0EhOdU96Gwac5vlCWPPK7igMKoyKXZCqUy
	 80ZydzlLKDrOVkva2nuq25JUhTimm6FNSgxcOKns=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	linux-hyperv@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v9 00/11] arm64: hyperv: Support Virtual Trust Level Boot
Date: Mon, 28 Apr 2025 14:07:31 -0700
Message-ID: <20250428210742.435282-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set allows the Hyper-V code to boot on ARM64 inside a Virtual Trust
Level. These levels are a part of the Virtual Secure Mode documented in the
Top-Level Functional Specification available at
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm.

The OpenHCL paravisor https://github.com/microsoft/openvmm/tree/main/openhcl
can serve as a practical application of these patches on ARM64.

For validation, I built kernels for the {x86_64, ARM64} x {VTL0, VTL2} set with
a small initrd embedded into the kernel and booted VMs managed by Hyper-V and
OpenVMM off of that.

Starting from V5, the patch series includes a non-functional change to KVM on
arm64 which I tested as well.

I've kept the Acked-by tags given by Arnd and Bjorn. These patches (1 and 11)
have changed very slightly since then (V5 and V6), no functional changes:
in patch 1, removed macro's in favour of functions as Marc suggested to get rid
of "sparse" warnings, and in patch 11, fixed building as a module. Please let me
know if I should have not kept the tags.

[V9]
    - Fix building the pci-hyperv driver as a module.
      ** Thank you, Micheal! **
  
    - Removed an overzealous check for the ACPI IRQ model on arm64 running with
      Hyper-V -- only GIC is supported. That check belongs to the lower layer
      code, and I took it from the ACPI driver while open-coding getting the
      parent IRQ domain.

[V8]
    https://lore.kernel.org/linux-hyperv/20250414224713.1866095-1-romank@linux.microsoft.com/
    - Use the Linux derfined macro __ASSEMBLY__ instead of the gcc's pre-defined
      macro __ASSEMBLER__ to follow the kernel coding style.
      ** Thank you, Marc! **

[V7]
    https://lore.kernel.org/linux-hyperv/20250407201336.66913-1-romank@linux.microsoft.com/
    - Used another approach not to increase the number of warnings produced when
      building with CHECK_ENDIAN.
      ** Thank you, Arnd! **

     - Adjusted the function parameter formatting to match the rest of the code.
      ** Thank you, Bjorn! **

    - Removed the now unused local variable.
      ** Thank you, kernel robot! **

    - Fixed the description in the VMBus DT binding patch.
      ** Thank you, Krzysztof! **

    - Adjusted the function names and comments to better reflect what they do,
      used the suggested approach to handling UUIDs to make code more readable
      and maintainable on big-endian.
    - Replaced ifdeffery with a stub function to make the code more readable.
      ** Thank you, Mark! **

    - Fixed the Kconfig not to build the VTL mode code on 32-bit kernels.
      ** Thank you, Michael! **

    - Fixed the indentation and the comment style.
      ** Thank you, Rafael! **

[V6]
    https://lore.kernel.org/linux-hyperv/20250315001931.631210-1-romank@linux.microsoft.com/
    - Use more intuitive Kconfig update.
    - Remove ifdef for getting IRQ number
    ** Thank you, Arnd! **

    - Simplify code for finding the parent IRQ domain.
    ** Thank you, Bjorn! **

    - Remove a superfluous check.
    ** Thank you, Dan! **

    - Make the commit title and descrtiption legible.
    - Don't set additionalProperties to true.
    ** Thank you, Krzysztof! **

    - Fix spelling in the commit title and description.
    - Trade-offs for options in Kconfig.
    - Export the new symbol as hyperv-pci can be built as a module.
    ** Thank you, Michael! **

    - Simplify code for getting IRQ number.
    ** Thank you, Rob! **

    - Add comment to clarify when running in VTL mode is reported.
    ** Thank you, Wei! **

[V5]
  https://lore.kernel.org/linux-hyperv/20250307220304.247725-1-romank@linux.microsoft.com/
    - Provide and use a common SMCCC-based infra for the arm64 hypervisor guests
      to detect hypervisor presence.
    ** Thank you, Arnd! **

    - Fix line wraps to follow the rest of the code.
    - Open-code getting IRQ domain parent in the ACPI case to make the code
      better.
    ** Thank you, Bjorn! **

    - Test the binding with the latest dtschema.
    - Clean up the commit title and description.
    - Use proper defines for known constants.
    ** Thank you, Krzysztof! **

    - Extend comment on why ACPI v6 is checked for.
    - Reorder patches to make sure that even with partial series application
      the compilation succeeds.
    - Report VTL the kernel runs in.
    - Use "X86_64" in Kconfig rather than "X86".
    - Extract a non-functional change for hv_get_vmbus_root_device() into
      a separate patch.
    ** Thank you, Michael! **

[V4]
    https://lore.kernel.org/linux-hyperv/20250212014321.1108840-1-romank@linux.microsoft.com/
    - Fixed wording to match acronyms defined in the "Terms and Abbreviations"
      section of the SMCCC specification throughout the patch series.
      **Thank you, Michael!**

    - Replaced the hypervisor ID containing ASCII with an UUID as
      required by the specification.
      **Thank you, Michael!**

    - Added an explicit check for `SMCCC_RET_NOT_SUPPORTED` when discovering the
      hypervisor presence to make the backward compatibility obvious.
      **Thank you, Saurabh!**

    - Split the fix for `get_vtl(void)` out to make it easier to backport.
    - Refactored the configuration options as requested to eliminate the risk
      of building non-functional kernels with randomly selected options.
      **Thank you, Michael!**

    - Refactored the changes not to introduce an additional file with
      a one-line function.
      **Thank you, Wei!**

    - Fixed change description for the VMBus DeviceTree changes, used
      `scripts/get_maintainers.pl` on the latest kernel to get the up-to-date list
      of maintainers as requested.
      **Thank you, Krzysztof!**

    - Removed the added (paranoidal+superfluous) checks for DMA coherence in the
      VMBus driver and instead relied on the DMA and the OF subsystem code.
      **Thank you, Arnd, Krzysztof, Michael!**

    - Used another set of APIs for discovering the hardware interrupt number
      in the VMBus driver to be able to build the driver as a module.
      **Thank you, Michael, Saurabh!**

    - Renamed the newly introduced `get_vmbus_root_device(void)` function to
      `hv_get_vmbus_root_device(void)` as requested.
      **Thank you, Wei!**

    - Applied the suggested small-scale refactoring to simplify changes to the Hyper-V
      PCI driver. Taking the offered liberty of doing the large scale refactoring
      in another patch series.
      **Thank you, Michael!**

    - Added a fix for the issue discovered internally where the CPU would not
      get the interrupt from a PCI device attached to VTL2 as the shared peripheral
      interrupt number (SPI) was not offset by 32 (the first valid SPI number).
      **Thank you, Brian!**

[V3]
    https://lore.kernel.org/lkml/20240726225910.1912537-1-romank@linux.microsoft.com/
    - Employed the SMCCC function recently implemented in the Microsoft Hyper-V
      hypervisor to detect running on Hyper-V/arm64. No dependence on ACPI/DT is
      needed anymore although the source code still falls back to ACPI as the new
      hypervisor might be available only in the Windows Insiders channel just
      yet.
    - As a part of the above, refactored detecting the hypervisor via ACPI FADT.
    - There was a suggestion to explore whether it is feasible or not to express
      that ACPI must be absent for the VTL mode and present for the regular guests
      in the Hyper-V Kconfig file.
      My current conclusion is that this will require refactoring in many places.
      That becomes especially convoluted on x86_64 due to the MSI and APIC
      dependencies. I'd ask to let us tackle that in another patch series (or chalk
      up to nice-have's rather than fires to put out) to separate concerns and
      decrease chances of breakage.
    - While refactoring `get_vtl(void)` and the related code, fixed the hypercall
      output address not to overlap with the input as the Hyper-V TLFS mandates:
      "The input and output parameter lists cannot overlap or cross page boundaries."
      See https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
      for more.
      Some might argue that should've been a topic for a separate patch series;
      I'd counter that the change is well-contained (one line), has no dependencies,
      and makes the code legal.
    - Made the VTL boot code (c)leaner as was suggested.
    - Set DMA cache coherency for the VMBus.
    - Updated DT bindings in the VMBus documentation (separated out into a new patch).
    - Fixed `vmbus_set_irq` to use the API that works both for the ACPI and OF.
    - Reworked setting up the vPCI MSI IRQ domain in the non-ACPI case. The logic
      looks a bit fiddly/ad-hoc as I couldn't find the API that would fit the bill.
      Added comments to explain myself.

[V2]
    https://lore.kernel.org/all/20240514224508.212318-1-romank@linux.microsoft.com/
    - Decreased number of #ifdef's
    - Updated the wording in the commit messages to adhere to the guidlines
    - Sending to the correct set of maintainers and mail lists

[V1]
    https://lore.kernel.org/all/20240510160602.1311352-1-romank@linux.microsoft.com/

Roman Kisel (11):
  arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID
  arm64: hyperv: Use SMCCC to detect hypervisor presence
  Drivers: hv: Enable VTL mode for arm64
  Drivers: hv: Provide arch-neutral implementation of get_vtl()
  arm64: hyperv: Initialize the Virtual Trust Level field
  arm64, x86: hyperv: Report the VTL the system boots in
  dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence
    properties
  Drivers: hv: vmbus: Get the IRQ number from DeviceTree
  Drivers: hv: vmbus: Introduce hv_get_vmbus_root_device()
  ACPI: irq: Introduce acpi_get_gsi_dispatcher()
  PCI: hv: Get vPCI MSI IRQ domain from DeviceTree

 .../bindings/bus/microsoft,vmbus.yaml         | 16 ++++-
 arch/arm64/hyperv/mshyperv.c                  | 53 ++++++++++++--
 arch/arm64/kvm/hypercalls.c                   | 10 +--
 arch/x86/hyperv/hv_init.c                     | 34 ---------
 arch/x86/hyperv/hv_vtl.c                      |  7 +-
 drivers/acpi/irq.c                            | 16 ++++-
 drivers/firmware/smccc/kvm_guest.c            | 10 +--
 drivers/firmware/smccc/smccc.c                | 17 +++++
 drivers/hv/Kconfig                            |  6 +-
 drivers/hv/hv_common.c                        | 31 ++++++++
 drivers/hv/vmbus_drv.c                        | 53 +++++++++++---
 drivers/pci/controller/pci-hyperv.c           | 70 +++++++++++++++++--
 include/asm-generic/mshyperv.h                |  6 ++
 include/hyperv/hvgdk_mini.h                   |  2 +-
 include/linux/acpi.h                          |  5 +-
 include/linux/arm-smccc.h                     | 64 +++++++++++++++--
 include/linux/hyperv.h                        |  2 +
 17 files changed, 323 insertions(+), 79 deletions(-)


base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
-- 
2.43.0


