Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7AB27E45D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgI3I4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgI3I4K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19362C0613D1;
        Wed, 30 Sep 2020 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A5sHIFEBr9P1ebcVO7vFVBeN+9hMK43tFHinn/WC28Y=; b=U7+DOgnE6fHC6YVkVl/3vG169n
        3AuHqpuzJxeCOsFN72gjyLiQCqRZ1orNmik4ljZDXXMl7ctpSZSEwlV+zq8ZPznTS/AbMMxAzBpaZ
        GfPzPDaiWXA1vqvyII0w2qoBZrOrutRaztqCzWn8w4DLn7WJXPGYMd0tRbhGHPKV+VowhGJHaneRa
        yqjjIzI1azgqpuC9RsZCBdk95fk2vtr6OjE8hg5ANPoXyvKyf3xD+ZDRJvBtDoGO8Hd2urbpF5h/j
        eHiqlmtt5OxGAORpHcjKIKPIrepIl0x2j4/9gtkorK/WsvuvsdFo1hbUzS+8xFnZIYfpMVD2Lorh0
        gkmsBihQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXu6-0003te-MN; Wed, 30 Sep 2020 08:56:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 7/9] dma-mapping: move dma-debug.h to kernel/dma/
Date:   Wed, 30 Sep 2020 10:55:46 +0200
Message-Id: <20200930085548.920261-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Most of dma-debug.h is not required by anything outside of kernel/dma.
Move the four declarations needed by dma-mappin.h or dma-ops providers
into dma-mapping.h and dma-map-ops.h, and move the remainder of the
file to kernel/dma/debug.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-iommu.h              |  1 -
 arch/arm/include/asm/dma-mapping.h            |  1 -
 arch/microblaze/kernel/dma.c                  |  1 -
 arch/sh/drivers/pci/pci.c                     |  1 -
 arch/x86/include/asm/dma-mapping.h            |  1 -
 arch/x86/kernel/pci-dma.c                     |  1 -
 drivers/pci/pci-driver.c                      |  1 +
 include/linux/dma-map-ops.h                   | 12 +++++
 include/linux/dma-mapping.h                   | 16 ++++++-
 kernel/dma/debug.c                            |  5 +--
 .../linux/dma-debug.h => kernel/dma/debug.h   | 44 ++-----------------
 kernel/dma/mapping.c                          |  1 +
 mm/memory.c                                   |  1 -
 13 files changed, 34 insertions(+), 52 deletions(-)
 rename include/linux/dma-debug.h => kernel/dma/debug.h (81%)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 86405cc81385c8..fe9ef6f79e9cfe 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -6,7 +6,6 @@
 
 #include <linux/mm_types.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
 #include <linux/kref.h>
 
 struct dma_iommu_mapping {
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 0a1a536368c3a4..77082246a5e121 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -6,7 +6,6 @@
 
 #include <linux/mm_types.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
 
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index d7bebd04247b72..a564863db06e98 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -10,7 +10,6 @@
 #include <linux/device.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
-#include <linux/dma-debug.h>
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 6ab0b7377f6634..a3903304f33faa 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -13,7 +13,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/dma-debug.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index e0c380b3ec1407..bb1654fe0ce74c 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -8,7 +8,6 @@
  */
 
 #include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 4892dd043d414c..de234e7a8962eb 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-debug.h>
 #include <linux/iommu.h>
 #include <linux/dmar.h>
 #include <linux/export.h>
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 449466f71040d2..d1b7169c068403 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/dma-map-ops.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 7912f5d00ed950..9891def42da71f 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -220,6 +220,18 @@ static inline void arch_teardown_dma_ops(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
 
+#ifdef CONFIG_DMA_API_DEBUG
+void dma_debug_add_bus(struct bus_type *bus);
+void debug_dma_dump_mappings(struct device *dev);
+#else
+static inline void dma_debug_add_bus(struct bus_type *bus)
+{
+}
+static inline void debug_dma_dump_mappings(struct device *dev)
+{
+}
+#endif /* CONFIG_DMA_API_DEBUG */
+
 extern const struct dma_map_ops dma_dummy_ops;
 
 #endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9591cd482d7c2d..3f029afdc9dc6a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -6,7 +6,6 @@
 #include <linux/string.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/dma-debug.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
@@ -76,6 +75,21 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+#ifdef CONFIG_DMA_API_DEBUG
+void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
+void debug_dma_map_single(struct device *dev, const void *addr,
+		unsigned long len);
+#else
+static inline void debug_dma_mapping_error(struct device *dev,
+		dma_addr_t dma_addr)
+{
+}
+static inline void debug_dma_map_single(struct device *dev, const void *addr,
+		unsigned long len)
+{
+}
+#endif /* CONFIG_DMA_API_DEBUG */
+
 #ifdef CONFIG_HAS_DMA
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 4211800d9f3e4d..14de1271463fd0 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -9,10 +9,9 @@
 
 #include <linux/sched/task_stack.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/sched/task.h>
 #include <linux/stacktrace.h>
-#include <linux/dma-debug.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/debugfs.h>
@@ -24,8 +23,8 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-
 #include <asm/sections.h>
+#include "debug.h"
 
 #define HASH_SIZE       16384ULL
 #define HASH_FN_SHIFT   13
diff --git a/include/linux/dma-debug.h b/kernel/dma/debug.h
similarity index 81%
rename from include/linux/dma-debug.h
rename to kernel/dma/debug.h
index 7b3b04ba60f32a..83643b3010b2fc 100644
--- a/include/linux/dma-debug.h
+++ b/kernel/dma/debug.h
@@ -5,28 +5,14 @@
  * Author: Joerg Roedel <joerg.roedel@amd.com>
  */
 
-#ifndef __DMA_DEBUG_H
-#define __DMA_DEBUG_H
-
-#include <linux/types.h>
-
-struct device;
-struct scatterlist;
-struct bus_type;
+#ifndef _KERNEL_DMA_DEBUG_H
+#define _KERNEL_DMA_DEBUG_H
 
 #ifdef CONFIG_DMA_API_DEBUG
-
-extern void dma_debug_add_bus(struct bus_type *bus);
-
-extern void debug_dma_map_single(struct device *dev, const void *addr,
-				 unsigned long len);
-
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr);
 
-extern void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
-
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction);
 
@@ -64,31 +50,13 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 struct scatterlist *sg,
 					 int nelems, int direction);
-
-extern void debug_dma_dump_mappings(struct device *dev);
-
 #else /* CONFIG_DMA_API_DEBUG */
-
-static inline void dma_debug_add_bus(struct bus_type *bus)
-{
-}
-
-static inline void debug_dma_map_single(struct device *dev, const void *addr,
-					unsigned long len)
-{
-}
-
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr)
 {
 }
 
-static inline void debug_dma_mapping_error(struct device *dev,
-					  dma_addr_t dma_addr)
-{
-}
-
 static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 					size_t size, int direction)
 {
@@ -150,11 +118,5 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 						int nelems, int direction)
 {
 }
-
-static inline void debug_dma_dump_mappings(struct device *dev)
-{
-}
-
 #endif /* CONFIG_DMA_API_DEBUG */
-
-#endif /* __DMA_DEBUG_H */
+#endif /* _KERNEL_DMA_DEBUG_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 2e13e6d3903fa0..335ba183e0956a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include "debug.h"
 
 /*
  * Managed DMA API
diff --git a/mm/memory.c b/mm/memory.c
index f3eb5597590232..7e4e8b81a73823 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -65,7 +65,6 @@
 #include <linux/gfp.h>
 #include <linux/migrate.h>
 #include <linux/string.h>
-#include <linux/dma-debug.h>
 #include <linux/debugfs.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/dax.h>
-- 
2.28.0

