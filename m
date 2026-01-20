Return-Path: <linux-arch+bounces-15876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD82D3BF9B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5409A4F4F2F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9EF392820;
	Tue, 20 Jan 2026 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HGdtXVc2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53F36D518;
	Tue, 20 Jan 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891419; cv=none; b=gbqAay4NBERbaaGx6FJLHAPBQPjkMhhaXyJt8Kpupr48NkrVMUnQ4LSzJLsz1KjSdl8HLrGlGvdXVHku4FMAkf/lZH0nqnpCDUBYAIKX7fAwhNmCVVsY1Lfzd2rgFZk81oySS8dWOqQNFYjRJkq7UyV4L0pPrnEKyuLT8Ff0Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891419; c=relaxed/simple;
	bh=ngFAuJnfcfXBr4kJX71bsAIldIKd7TgtHjND03nfXww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDhghRBkU9u4ugzuAtGbMJliQtJVjlz8uTzFWPX3NurK5dsLVYQJdLO9dku7P8BhuDOwUAOVttW8N+IS9sNNwHFoyT5Bmt/G9Kjn7SWDtKZfWY3LWUyq7pc3NoEbPUnE26sDjnTJGnIPJs+yGXGt+0HW73nFqMtltPYfUaRP1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HGdtXVc2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BA9720B716A;
	Mon, 19 Jan 2026 22:43:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BA9720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891408;
	bh=m45lmngnneFEFrRyGJR4mUwoMKqxtY0RUEN+/lvw4/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGdtXVc2BXgm92n5ocikgwapcrs0HLEgrr6+dxRy3TgP+wqnISmLINE6igxoPsAeS
	 8r68DlGdoTXyTpQ6RkFDSB8egv/wuwQ58Vk4Hwoa5+iO6ykl7h6FsRiDhqXdYbN7qB
	 ejPq68EVm2n6fmepTibXWl9+2yJi+M/QsFhPfD/Q=
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
Subject: [PATCH v0 01/15] iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
Date: Mon, 19 Jan 2026 22:42:16 -0800
Message-ID: <20260120064230.3602565-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

This file actually implements irq remapping, so rename to more appropriate
hyperv-irq.c. A new file named hyperv-iommu.c will be introduced later.
Also, move CONFIG_IRQ_REMAP out of the file and add to Makefile.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 MAINTAINERS                                    | 2 +-
 drivers/iommu/Kconfig                          | 1 +
 drivers/iommu/Makefile                         | 2 +-
 drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 4 ----
 4 files changed, 3 insertions(+), 6 deletions(-)
 rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..381a0e086382 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11741,7 +11741,7 @@ F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/infiniband/hw/mana/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/iommu/hyperv-iommu.c
+F:	drivers/iommu/hyperv-irq.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 99095645134f..b4cc2b42b338 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -355,6 +355,7 @@ config HYPERV_IOMMU
 	bool "Hyper-V IRQ Handling"
 	depends on HYPERV && X86
 	select IOMMU_API
+	select IRQ_REMAP
 	default HYPERV
 	help
 	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8e8843316c4b..598c39558e7d 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
+obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-irq.c
similarity index 99%
rename from drivers/iommu/hyperv-iommu.c
rename to drivers/iommu/hyperv-irq.c
index 0961ac805944..1944440a5004 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-irq.c
@@ -24,8 +24,6 @@
 
 #include "irq_remapping.h"
 
-#ifdef CONFIG_IRQ_REMAP
-
 /*
  * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
  * Redirection Table. Hyper-V exposes one single IO-APIC and so define
@@ -330,5 +328,3 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 	.alloc = hyperv_root_irq_remapping_alloc,
 	.free = hyperv_root_irq_remapping_free,
 };
-
-#endif
-- 
2.51.2.vfs.0.1


