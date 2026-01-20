Return-Path: <linux-arch+bounces-15875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B55D3BF9C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18A5F4F8D05
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A26392817;
	Tue, 20 Jan 2026 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KObiO0Lo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADD379983;
	Tue, 20 Jan 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891418; cv=none; b=gVm92zJsX2vPScVSG3H3iQGbp23lXdXpCqUkUcm834TfMc8hI+YmE0MZR41CrAKqjZIzpyhmQSHZNaggsp7yALS4aPMjkpCjs5Lkz5k9n4Ib8Yl7JEdJxya4S1M+bGOXVLJHi4QKIkGPRr2sOp4p9ka+Mk7cQAhiK7q62OIjqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891418; c=relaxed/simple;
	bh=aui/GkbBtiPVTkiX6Ow6xlf/6VpgjOm3x7ay4MlRlI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueRSFcSTXZVZzUiSijSbB752Sc6Nm+Remuy1/ixBVfIT3IkHjIEEmGzCmwecjLy5/g361uyr18CzkWoSX8D8BMBr4vJQbMPjF1/nk0y3dftNHvEHwoFWJAxevzD+nHXz5FLgmQO+SiRCyRN1IKrqhVgo6xDnpDk2AILk7FA8e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KObiO0Lo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 894FA20B7167;
	Mon, 19 Jan 2026 22:43:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 894FA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891402;
	bh=WHhmto1NMo2mPctdS5EAM5h05xQRsGXKjEkSKa5x4SQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KObiO0LomVdnCGD0qJjSQFMugy3J6V/LNLQqjcITWX2EUOrCCdurSu1HImxVLcr9N
	 3MwXDYf6nYuzcPQtFGaAcZ/0ED0nqox5DvQaa/ce3LgiEL7QPLorMKSkRaPU10acE3
	 3s6EcGCdwRVhQkwXMaos7Jb786KoxYs/lY2njGww=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joro@8bytes.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	nunodasneves@linux.microsoft.com,
	mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: [PATCH v0 00/15] PCI passthru on Hyper-V (Part I)
Date: Mon, 19 Jan 2026 22:42:15 -0800
Message-ID: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

Implement passthru of PCI devices to unprivileged virtual machines
(VMs) when Linux is running as a privileged VM on Microsoft Hyper-V
hypervisor. This support is made to fit within the workings of VFIO
framework, and any VMM needing to use it must use the VFIO subsystem.
This supports both full device passthru and SR-IOV based VFs.

There are 3 cases where Linux can run as a privileged VM (aka MSHV):
  Baremetal root (meaning Hyper-V+Linux), L1VH, and Nested.

At a high level, the hypervisor supports traditional mapped iommu domains
that use explicit map and unmap hypercalls for mapping and unmapping guest
RAM into the iommu subsystem. Hyper-V also has a concept of direct attach
devices whereby the iommu subsystem simply uses the guest HW page table
(ept/npt/..). This series adds support for both, and both are made to
work in VFIO type1 subsystem.

While this Part I focuses on memory mappings, upcoming Part II
will focus on irq bypass along with some minor irq remapping 
updates.

This patch series was tested using Cloud Hypervisor verion 48. Qemu
support of MSHV is in the works, and that will be extended to include
PCI passthru and SR-IOV support also in near future.

Based on: 8f0b4cce4481 (origin/hyperv-next)

Thanks,
-Mukesh

Mukesh Rathor (15):
  iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
  x86/hyperv: cosmetic changes in irqdomain.c for readability
  x86/hyperv: add insufficient memory support in irqdomain.c
  mshv: Provide a way to get partition id if running in a VMM process
  mshv: Declarations and definitions for VFIO-MSHV bridge device
  mshv: Implement mshv bridge device for VFIO
  mshv: Add ioctl support for MSHV-VFIO bridge device
  PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
  mshv: Import data structs around device domains and irq remapping
  PCI: hv: Build device id for a VMBus device
  x86/hyperv: Build logical device ids for PCI passthru hcalls
  x86/hyperv: Implement hyperv virtual iommu
  x86/hyperv: Basic interrupt support for direct attached devices
  mshv: Remove mapping of mmio space during map user ioctl
  mshv: Populate mmio mappings for PCI passthru

 MAINTAINERS                         |    1 +
 arch/arm64/include/asm/mshyperv.h   |   15 +
 arch/x86/hyperv/irqdomain.c         |  314 ++++++---
 arch/x86/include/asm/mshyperv.h     |   21 +
 arch/x86/kernel/pci-dma.c           |    2 +
 drivers/hv/Makefile                 |    3 +-
 drivers/hv/mshv_root.h              |   24 +
 drivers/hv/mshv_root_main.c         |  296 +++++++-
 drivers/hv/mshv_vfio.c              |  210 ++++++
 drivers/iommu/Kconfig               |    1 +
 drivers/iommu/Makefile              |    2 +-
 drivers/iommu/hyperv-iommu.c        | 1004 +++++++++++++++++++++------
 drivers/iommu/hyperv-irq.c          |  330 +++++++++
 drivers/pci/controller/pci-hyperv.c |  207 ++++--
 include/asm-generic/mshyperv.h      |    1 +
 include/hyperv/hvgdk_mini.h         |   11 +
 include/hyperv/hvhdk_mini.h         |  112 +++
 include/linux/hyperv.h              |    6 +
 include/uapi/linux/mshv.h           |   31 +
 19 files changed, 2182 insertions(+), 409 deletions(-)
 create mode 100644 drivers/hv/mshv_vfio.c
 create mode 100644 drivers/iommu/hyperv-irq.c

-- 
2.51.2.vfs.0.1


