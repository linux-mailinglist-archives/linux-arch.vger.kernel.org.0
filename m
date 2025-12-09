Return-Path: <linux-arch+bounces-15311-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D18FFCAEEB6
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E9C303FA5E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41252D3A70;
	Tue,  9 Dec 2025 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I/o9M7ko"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E84427AC28;
	Tue,  9 Dec 2025 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257107; cv=none; b=I5eeyRuRc3Z5A5QTwCh+MSiPUNPxrWXgUghLcZlIU9m9iwB+2u8q11N0+sjEO3XovHaiJ5ahYRU2wtvu+DBCGnl5zie5IPoXEaFBtOGLyIT+O2qzVDotdlw56X9zJrWYm8nzPjPwI66xOfmpa38OZu3/shzq3NOrr24mlhVwTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257107; c=relaxed/simple;
	bh=yxkvay7ppUK7zCSPMJkz9Is50IBjl8OT4F5+03I2GCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYR1VNB3WyV9TpWpfmJY/rjvoh0o/d2GjJ1OtOoSv6BKd+g5EyYnkZeUO8XcsDQWImvgFR9wWbBEVXO4PrPF9SO+IWIEQ1yGjGZ+CM28S8GSG3O1wVx5Mvb8tB19psmo3mlMfszMrAQ8xfJYIna6BhKVdwEPS2j6+50vOJKi9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I/o9M7ko; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B4D42015694;
	Mon,  8 Dec 2025 21:11:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B4D42015694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257105;
	bh=bB0p607TmqfIyRyLHIvV0ENjbM1faRQmO8b1AjVjqs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/o9M7koGFvYC6fY5jwYqKhJMq2SyL3Db/EhdSGEwwwocxD2mun7RMkPKSc9n2ojk
	 YGE4RxoQ/kZ8hEcm7S6GldWHlCvehzdycvft6bvd9PHnJfUVCsSyYCXMgB2cagFrvP
	 jPYWwT2zhCNRcv48snn3FDU4q7UxoD9VukFzLInU=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 2/5] iommu: Move Hyper-V IOMMU driver to its own subdirectory
Date: Tue,  9 Dec 2025 13:11:25 +0800
Message-ID: <20251209051128.76913-3-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <eahariha@linux.microsoft.com>

The Hyper-V IOMMU driver currently only supports IRQ remapping.
As it will be adding DMA remapping support, prepare a directory
to contain all the different feature files.

This is a simple rename commit and has no functional changes.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/iommu/Kconfig                                  | 10 +---------
 drivers/iommu/Makefile                                 |  2 +-
 drivers/iommu/hyperv/Kconfig                           | 10 ++++++++++
 drivers/iommu/hyperv/Makefile                          |  2 ++
 .../iommu/{hyperv-iommu.c => hyperv/irq_remapping.c}   |  2 +-
 5 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/Makefile
 rename drivers/iommu/{hyperv-iommu.c => hyperv/irq_remapping.c} (99%)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c9ae3221cd6f..661ff4e764cc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -194,6 +194,7 @@ config MSM_IOMMU
 source "drivers/iommu/amd/Kconfig"
 source "drivers/iommu/arm/Kconfig"
 source "drivers/iommu/intel/Kconfig"
+source "drivers/iommu/hyperv/Kconfig"
 source "drivers/iommu/iommufd/Kconfig"
 source "drivers/iommu/riscv/Kconfig"
 
@@ -350,15 +351,6 @@ config MTK_IOMMU_V1
 
 	  if unsure, say N here.
 
-config HYPERV_IOMMU
-	bool "Hyper-V IRQ Handling"
-	depends on HYPERV && X86
-	select IOMMU_API
-	default HYPERV
-	help
-	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
-	  guest and root partitions.
-
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index b17ef9818759..757dc377cb66 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
 obj-$(CONFIG_INTEL_IOMMU) += intel/
 obj-$(CONFIG_RISCV_IOMMU) += riscv/
 obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
+obj-$(CONFIG_HYPERV_IOMMU) += hyperv/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
@@ -29,7 +30,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
new file mode 100644
index 000000000000..30f40d867036
--- /dev/null
+++ b/drivers/iommu/hyperv/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# HyperV paravirtualized IOMMU support
+config HYPERV_IOMMU
+	bool "Hyper-V IRQ Handling"
+	depends on HYPERV && X86
+	select IOMMU_API
+	default HYPERV
+	help
+	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
+	  guest and root partitions.
diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
new file mode 100644
index 000000000000..9f557bad94ff
--- /dev/null
+++ b/drivers/iommu/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_HYPERV_IOMMU) += irq_remapping.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv/irq_remapping.c
similarity index 99%
rename from drivers/iommu/hyperv-iommu.c
rename to drivers/iommu/hyperv/irq_remapping.c
index 0961ac805944..f2c4c7d67302 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv/irq_remapping.c
@@ -22,7 +22,7 @@
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 #ifdef CONFIG_IRQ_REMAP
 
-- 
2.49.0


