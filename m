Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4727E460
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgI3I4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgI3I4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14CC0613D5;
        Wed, 30 Sep 2020 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=k3N/J9vjWrXqp4RBm9WLMthbWgeVyH8ElD/H4klikM8=; b=NtuRmt/3YTvPGMJFztZ387kPRd
        m8UVHZ1cAxiJivn45xbQQhiL12f7Go3ah0tb1hHu8ThN2VeiKWFpS7GYQi5/Sktrtl4eBmFGVptWR
        A7s1rGZ+SdKlSp/r0Js30pM3dsEWR8INhIRGwDEsE//Oz2hRAga2LPYDOerOutjMV+jHtExa7Xyd/
        koaavb6gIrQGQF1OCjGpmPDxeG9yxW2tlwjLpc6LPt53FrtY0GvZqtScu+hTVjJse8zssDS54jqRR
        IGh2rcVRWFS3LoGdQa44Svxkxs6bjXPw/6HaZPT2ECduV9UKrRj2h3VvRK3AtIJ7WAuPaFXn07rSO
        qVWVf/YQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXu3-0003sp-TM; Wed, 30 Sep 2020 08:56:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 5/9] dma-mapping: merge <linux/dma-contiguous.h> into <linux/dma-map-ops.h>
Date:   Wed, 30 Sep 2020 10:55:44 +0200
Message-Id: <20200930085548.920261-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Merge dma-contiguous.h into dma-map-ops.h, after removing the comment
describing the contiguous allocator into kernel/dma/contigous.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../admin-guide/kernel-parameters.txt         |   2 +-
 arch/arm/mach-davinci/devices-da8xx.c         |   2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c      |   2 +-
 arch/arm/mm/dma-mapping.c                     |   1 -
 arch/arm/mm/init.c                            |   2 +-
 arch/arm64/mm/init.c                          |   3 +-
 arch/csky/kernel/setup.c                      |   2 +-
 arch/csky/mm/dma-mapping.c                    |   3 +-
 arch/microblaze/mm/init.c                     |   2 +-
 arch/mips/kernel/setup.c                      |   2 +-
 arch/mips/mm/dma-noncoherent.c                |   1 -
 arch/s390/kernel/setup.c                      |   2 +-
 arch/x86/include/asm/dma-mapping.h            |   1 -
 arch/x86/kernel/setup.c                       |   2 +-
 arch/xtensa/kernel/pci-dma.c                  |   2 +-
 arch/xtensa/mm/init.c                         |   2 +-
 drivers/dma-buf/heaps/cma_heap.c              |   2 +-
 drivers/iommu/amd/iommu.c                     |   3 +-
 drivers/iommu/dma-iommu.c                     |   1 -
 drivers/iommu/intel/iommu.c                   |   2 +-
 drivers/media/platform/exynos4-is/fimc-is.c   |   1 -
 include/linux/dma-contiguous.h                | 135 ------------------
 include/linux/dma-map-ops.h                   |  65 +++++++++
 kernel/dma/Kconfig                            |   2 +-
 kernel/dma/contiguous.c                       |  30 +++-
 kernel/dma/direct.c                           |   1 -
 kernel/dma/ops_helpers.c                      |   1 -
 kernel/dma/pool.c                             |   2 +-
 28 files changed, 112 insertions(+), 164 deletions(-)
 delete mode 100644 include/linux/dma-contiguous.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e464cf0b502591..7657e00e83ca38 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -597,7 +597,7 @@
 			placement constraint by the physical address range of
 			memory allocations. A value of 0 disables CMA
 			altogether. For more information, see
-			include/linux/dma-contiguous.h
+			kernel/dma/contiguous.c
 
 	cma_pernuma=nn[MG]
 			[ARM64,KNL]
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 1207eabe8d1cc4..bb368938fc4921 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -10,7 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index c42ff8c314c82d..e00f5b3b929362 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -9,7 +9,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/device.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8bf0bc6bc31172..154c24cec94c74 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -17,7 +17,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 000c1b48e9734f..ab1d1931a3525e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -18,7 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
 #include <linux/swiotlb.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f1c75957ff3c24..1b591ddb28b01b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -21,8 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 0481f4e34538ea..e4cab16056d606 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -7,7 +7,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/start_kernel.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/screen_info.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 8f6571ae27c867..3d9ff26c4bb4d8 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -2,8 +2,7 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/cache.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/genalloc.h>
 #include <linux/highmem.h>
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 3344d4a1fe890c..7659a8b86580fd 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -7,7 +7,7 @@
  * for more details.
  */
 
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bf5f5acab0a82f..464bfd3957ae96 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -24,7 +24,7 @@
 #include <linux/kexec.h>
 #include <linux/sizes.h>
 #include <linux/device.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/decompress/generic.h>
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index f4e8404ee0490d..22d99ccc70c81e 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -7,7 +7,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c2c1b4e723eafb..151092565a2704 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -37,7 +37,7 @@
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/kernel_stat.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/pfn.h>
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index fed67eafcaccc2..e0c380b3ec1407 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -11,7 +11,6 @@
 #include <linux/dma-debug.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
-#include <linux/dma-contiguous.h>
 
 extern int iommu_merge;
 extern int panic_on_overflow;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9286fa9d575e6d..e8155e85bd8f34 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -7,7 +7,7 @@
  */
 #include <linux/console.h>
 #include <linux/crash_dump.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/init_ohci1394_dma.h>
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 17c4384f849558..790dbe022a0796 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -11,7 +11,7 @@
  * Joe Taylor <joe@tensilica.com, joetylr@yahoo.com>
  */
 
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-direct.h>
 #include <linux/gfp.h>
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index a05b306cf371bf..8079007842ac8e 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -26,7 +26,7 @@
 #include <linux/nodemask.h>
 #include <linux/mm.h>
 #include <linux/of_fdt.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 
 #include <asm/bootparam.h>
 #include <asm/page.h>
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 626cf7fd033afd..e55384dc115ba2 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/highmem.h>
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 10e4200d355204..5396eb8d730bca 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/iommu-helper.h>
@@ -28,7 +28,6 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
-#include <linux/dma-contiguous.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/iova.h>
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d2e3f26228151f..22c221bba13e2f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -11,7 +11,6 @@
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bd3470142b0678..0c5b4500ae83d3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -37,7 +37,7 @@
 #include <linux/dmi.h>
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index a474014f0a0fa5..32f5982afa1ab2 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -12,7 +12,6 @@
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/dma-contiguous.h>
 #include <linux/errno.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
deleted file mode 100644
index f9ce1ee58d4180..00000000000000
--- a/include/linux/dma-contiguous.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef __LINUX_CMA_H
-#define __LINUX_CMA_H
-
-/*
- * Contiguous Memory Allocator for DMA mapping framework
- * Copyright (c) 2010-2011 by Samsung Electronics.
- * Written by:
- *	Marek Szyprowski <m.szyprowski@samsung.com>
- *	Michal Nazarewicz <mina86@mina86.com>
- */
-
-/*
- * Contiguous Memory Allocator
- *
- *   The Contiguous Memory Allocator (CMA) makes it possible to
- *   allocate big contiguous chunks of memory after the system has
- *   booted.
- *
- * Why is it needed?
- *
- *   Various devices on embedded systems have no scatter-getter and/or
- *   IO map support and require contiguous blocks of memory to
- *   operate.  They include devices such as cameras, hardware video
- *   coders, etc.
- *
- *   Such devices often require big memory buffers (a full HD frame
- *   is, for instance, more then 2 mega pixels large, i.e. more than 6
- *   MB of memory), which makes mechanisms such as kmalloc() or
- *   alloc_page() ineffective.
- *
- *   At the same time, a solution where a big memory region is
- *   reserved for a device is suboptimal since often more memory is
- *   reserved then strictly required and, moreover, the memory is
- *   inaccessible to page system even if device drivers don't use it.
- *
- *   CMA tries to solve this issue by operating on memory regions
- *   where only movable pages can be allocated from.  This way, kernel
- *   can use the memory for pagecache and when device driver requests
- *   it, allocated pages can be migrated.
- *
- * Driver usage
- *
- *   CMA should not be used by the device drivers directly. It is
- *   only a helper framework for dma-mapping subsystem.
- *
- *   For more information, see kernel-docs in kernel/dma/contiguous.c
- */
-
-#ifdef __KERNEL__
-
-#include <linux/device.h>
-#include <linux/mm.h>
-
-struct cma;
-struct page;
-
-#ifdef CONFIG_DMA_CMA
-
-extern struct cma *dma_contiguous_default_area;
-
-static inline struct cma *dev_get_cma_area(struct device *dev)
-{
-	if (dev && dev->cma_area)
-		return dev->cma_area;
-	return dma_contiguous_default_area;
-}
-
-void dma_contiguous_reserve(phys_addr_t addr_limit);
-
-int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
-				       phys_addr_t limit, struct cma **res_cma,
-				       bool fixed);
-
-struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn);
-bool dma_release_from_contiguous(struct device *dev, struct page *pages,
-				 int count);
-struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
-void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
-
-#else
-
-static inline struct cma *dev_get_cma_area(struct device *dev)
-{
-	return NULL;
-}
-
-static inline void dma_contiguous_reserve(phys_addr_t limit) { }
-
-static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
-				       phys_addr_t limit, struct cma **res_cma,
-				       bool fixed)
-{
-	return -ENOSYS;
-}
-
-static inline
-struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn)
-{
-	return NULL;
-}
-
-static inline
-bool dma_release_from_contiguous(struct device *dev, struct page *pages,
-				 int count)
-{
-	return false;
-}
-
-/* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
-static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
-		gfp_t gfp)
-{
-	return NULL;
-}
-
-static inline void dma_free_contiguous(struct device *dev, struct page *page,
-		size_t size)
-{
-	__free_pages(page, get_order(size));
-}
-
-#endif
-
-#ifdef CONFIG_DMA_PERNUMA_CMA
-void dma_pernuma_cma_reserve(void);
-#else
-static inline void dma_pernuma_cma_reserve(void) { }
-#endif
-
-#endif
-
-#endif
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4b4ba5bdcf6a8d..474fc81bd4921c 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -8,6 +8,8 @@
 
 #include <linux/dma-mapping.h>
 
+struct cma;
+
 struct dma_map_ops {
 	void *(*alloc)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, gfp_t gfp,
@@ -94,6 +96,69 @@ static inline void set_dma_ops(struct device *dev,
 }
 #endif /* CONFIG_DMA_OPS */
 
+#ifdef CONFIG_DMA_CMA
+extern struct cma *dma_contiguous_default_area;
+
+static inline struct cma *dev_get_cma_area(struct device *dev)
+{
+	if (dev && dev->cma_area)
+		return dev->cma_area;
+	return dma_contiguous_default_area;
+}
+
+void dma_contiguous_reserve(phys_addr_t addr_limit);
+int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
+		phys_addr_t limit, struct cma **res_cma, bool fixed);
+
+struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
+				       unsigned int order, bool no_warn);
+bool dma_release_from_contiguous(struct device *dev, struct page *pages,
+				 int count);
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
+void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
+#else /* CONFIG_DMA_CMA */
+static inline struct cma *dev_get_cma_area(struct device *dev)
+{
+	return NULL;
+}
+static inline void dma_contiguous_reserve(phys_addr_t limit)
+{
+}
+static inline int dma_contiguous_reserve_area(phys_addr_t size,
+		phys_addr_t base, phys_addr_t limit, struct cma **res_cma,
+		bool fixed)
+{
+	return -ENOSYS;
+}
+static inline struct page *dma_alloc_from_contiguous(struct device *dev,
+		size_t count, unsigned int order, bool no_warn)
+{
+	return NULL;
+}
+static inline bool dma_release_from_contiguous(struct device *dev,
+		struct page *pages, int count)
+{
+	return false;
+}
+/* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
+static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
+		gfp_t gfp)
+{
+	return NULL;
+}
+static inline void dma_free_contiguous(struct device *dev, struct page *page,
+		size_t size)
+{
+	__free_pages(page, get_order(size));
+}
+#endif /* CONFIG_DMA_CMA*/
+
+#ifdef CONFIG_DMA_PERNUMA_CMA
+void dma_pernuma_cma_reserve(void);
+#else
+static inline void dma_pernuma_cma_reserve(void) { }
+#endif /* CONFIG_DMA_PERNUMA_CMA */
+
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c5f717021f5654..598e772baebb10 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -118,7 +118,7 @@ config DMA_CMA
 	  You can disable CMA by specifying "cma=0" on the kernel's command
 	  line.
 
-	  For more information see <include/linux/dma-contiguous.h>.
+	  For more information see <kernel/dma/contiguous.c>.
 	  If unsure, say "n".
 
 if  DMA_CMA
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index bf05ec2256e149..6bfb763fff6fca 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -5,6 +5,34 @@
  * Written by:
  *	Marek Szyprowski <m.szyprowski@samsung.com>
  *	Michal Nazarewicz <mina86@mina86.com>
+ *
+ * Contiguous Memory Allocator
+ *
+ *   The Contiguous Memory Allocator (CMA) makes it possible to
+ *   allocate big contiguous chunks of memory after the system has
+ *   booted.
+ *
+ * Why is it needed?
+ *
+ *   Various devices on embedded systems have no scatter-getter and/or
+ *   IO map support and require contiguous blocks of memory to
+ *   operate.  They include devices such as cameras, hardware video
+ *   coders, etc.
+ *
+ *   Such devices often require big memory buffers (a full HD frame
+ *   is, for instance, more then 2 mega pixels large, i.e. more than 6
+ *   MB of memory), which makes mechanisms such as kmalloc() or
+ *   alloc_page() ineffective.
+ *
+ *   At the same time, a solution where a big memory region is
+ *   reserved for a device is suboptimal since often more memory is
+ *   reserved then strictly required and, moreover, the memory is
+ *   inaccessible to page system even if device drivers don't use it.
+ *
+ *   CMA tries to solve this issue by operating on memory regions
+ *   where only movable pages can be allocated from.  This way, kernel
+ *   can use the memory for pagecache and when device driver requests
+ *   it, allocated pages can be migrated.
  */
 
 #define pr_fmt(fmt) "cma: " fmt
@@ -21,7 +49,7 @@
 #include <linux/memblock.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/cma.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8cf5689a8c4044..87697c86f0b82a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -10,7 +10,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-contiguous.h>
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 60d7b6cdfd8d15..bc80fd2648bcf2 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -3,7 +3,6 @@
  * Helpers for DMA ops implementations.  These generally rely on the fact that
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
-#include <linux/dma-contiguous.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index fe11643ff9cc7b..c9fb5c3d8bd002 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -5,7 +5,7 @@
  */
 #include <linux/cma.h>
 #include <linux/debugfs.h>
-#include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/init.h>
-- 
2.28.0

