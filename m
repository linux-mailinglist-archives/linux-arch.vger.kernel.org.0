Return-Path: <linux-arch+bounces-10868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8EA622C4
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F49C7A7536
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC51802B;
	Sat, 15 Mar 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AHVPYber"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C22E3387;
	Sat, 15 Mar 2025 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997975; cv=none; b=rr9Bd58BaBRNOM56WNNwGXXkHvsZA4HqhVLNyL+mRGzBUTWuRI+NwtVYaB/ws06WS2S18FNS94zyBA71HVRJ10tQZ16V6k6Ilp1z+z2Jw80p2UkDZmheGWZ0QLkGIk6DGSC2rAath0lL6EVR+BRHFyUlu8y1P0/IicIO/RyxMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997975; c=relaxed/simple;
	bh=jqQL/axxeVbP6FsyRUY66C53ezuUX9eX9SGH4v/OLEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pFE4gPkBXYRd8bK4Z9nsImidWA9m+tMNlS3fQ3z3m4ZBhz7NVPCti9iVos88denc1S/iaSthQTqnk0WOX1vVn+zl9F9nZuyqdp4Nmvt1wM5b/YPm6FSsDnYZYP7YZ/PUi04uhpDr9dxGj9eHc2vu/7k98hsuEQTfhhe73HL81GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AHVPYber; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4EB02033459;
	Fri, 14 Mar 2025 17:19:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4EB02033459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741997973;
	bh=IFDGTilfS/bhksZe1/+y1s5O6KhZVkjslHMlSRzOeLw=;
	h=From:To:Cc:Subject:Date:From;
	b=AHVPYberswjwKcT6Z77GLpqu3dEV9bow+4NNwPmPVXC8jNOSVCwAftXKyFC4iOBwa
	 6zVpXN4gOHy9ZubjASdeyzlqaN2gCJZAfAzmNxPZICtqSWezuX/ebu5eyWbfKQ1DAI
	 7kvgRfFBf6WbJLAIeBc05WzefEpZfCws0jVyHsd0=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
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
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v6 00/11] arm64: hyperv: Support Virtual Trust Level Boot
Date: Fri, 14 Mar 2025 17:19:20 -0700
Message-ID: <20250315001931.631210-1-romank@linux.microsoft.com>
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

[V6]
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
  arm64: kvm, smccc: Introduce and use API for detecting hypervisor
    presence
  arm64: hyperv: Use SMCCC to detect hypervisor presence
  Drivers: hv: Enable VTL mode for arm64
  Drivers: hv: Provide arch-neutral implementation of get_vtl()
  arm64: hyperv: Initialize the Virtual Trust Level field
  arm64, x86: hyperv: Report the VTL the system boots in
  dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence
    properties
  Drivers: hv: vmbus: Get the IRQ number from DeviceTree
  Drivers: hv: vmbus: Introduce hv_get_vmbus_root_device()
  ACPI: irq: Introduce  acpi_get_gsi_dispatcher()
  PCI: hv: Get vPCI MSI IRQ domain from DeviceTree

 .../bindings/bus/microsoft,vmbus.yaml         | 17 ++++-
 arch/arm64/hyperv/mshyperv.c                  | 46 ++++++++++--
 arch/arm64/kvm/hypercalls.c                   |  5 +-
 arch/x86/hyperv/hv_init.c                     | 34 ---------
 arch/x86/hyperv/hv_vtl.c                      |  7 +-
 drivers/acpi/irq.c                            | 15 +++-
 drivers/firmware/smccc/kvm_guest.c            | 10 +--
 drivers/firmware/smccc/smccc.c                | 19 +++++
 drivers/hv/Kconfig                            |  6 +-
 drivers/hv/hv_common.c                        | 31 ++++++++
 drivers/hv/vmbus_drv.c                        | 53 ++++++++++++--
 drivers/pci/controller/pci-hyperv.c           | 73 +++++++++++++++++--
 include/asm-generic/mshyperv.h                |  6 ++
 include/hyperv/hvgdk_mini.h                   |  2 +-
 include/linux/acpi.h                          |  5 +-
 include/linux/arm-smccc.h                     | 55 +++++++++++++-
 include/linux/hyperv.h                        |  2 +
 17 files changed, 307 insertions(+), 79 deletions(-)


base-commit: d9608f6dc3e3229a40e1db1dab573d6882f38c2a
-- 
2.43.0


