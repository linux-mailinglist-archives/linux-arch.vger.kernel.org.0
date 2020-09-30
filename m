Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB27527E45E
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgI3I4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgI3I4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22787C0613D4;
        Wed, 30 Sep 2020 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Te/3Ibwqk+ElqBAHs1+TvHOGRh1COGKRDAKkpm/LB54=; b=gNjWwpWQuiJ9+XThegmowHShsT
        CKHrq/tyTACZRLhmy/gFbG0BspKoLofXHLT4tVReVxCzIhptmhoCIgBtBN+cIC1eN0XQDCRCVPN2X
        wfr1ka6GozVYKIGwWtFIoa6MxD/KFJQwVW6EeTrmbqmjqAVVf5M3mhhqIPBFHJtloMioMJis2yq2P
        FZdIY9dUm6FbOJJ4ytFGyi1GuYyI4YMxrPcQO2z2DYFESHfp3FtFpj2WH0TmM9Nt/iRGcMnSEwDlJ
        9mZFqPr92Aa2/pO2UfT+WZ8bpzHhYLjYr1Cn2OE/ZVHzamXEVatkATdNAhhx/Zd7RqMcHS55qlp5r
        m9s+4iBw==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXuA-0003uP-Ba; Wed, 30 Sep 2020 08:56:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 9/9] dma-mapping: merge <linux/dma-noncoherent.h> into <linux/dma-map-ops.h>
Date:   Wed, 30 Sep 2020 10:55:48 +0200
Message-Id: <20200930085548.920261-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move more nitty gritty DMA implementation details into the common
internal header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                       |   1 -
 arch/arc/mm/dma.c                 |   1 -
 arch/arm/mm/dma-mapping.c         |   1 -
 arch/arm/xen/mm.c                 |   2 +-
 arch/arm64/mm/dma-mapping.c       |   1 -
 arch/c6x/mm/dma-coherent.c        |   2 +-
 arch/csky/mm/dma-mapping.c        |   1 -
 arch/hexagon/kernel/dma.c         |   2 +-
 arch/ia64/mm/init.c               |   2 +-
 arch/m68k/kernel/dma.c            |   2 +-
 arch/microblaze/kernel/dma.c      |   2 +-
 arch/microblaze/mm/consistent.c   |   2 +-
 arch/mips/jazz/jazzdma.c          |   1 -
 arch/mips/mm/dma-noncoherent.c    |   1 -
 arch/nds32/kernel/dma.c           |   2 +-
 arch/openrisc/kernel/dma.c        |   2 +-
 arch/parisc/kernel/pci-dma.c      |   2 +-
 arch/powerpc/mm/dma-noncoherent.c |   2 +-
 arch/sh/kernel/dma-coherent.c     |   2 +-
 arch/sparc/kernel/ioport.c        |   2 +-
 arch/xtensa/kernel/pci-dma.c      |   1 -
 drivers/iommu/dma-iommu.c         |   1 -
 drivers/xen/swiotlb-xen.c         |   3 +-
 include/linux/dma-direct.h        |   2 +-
 include/linux/dma-map-ops.h       | 102 ++++++++++++++++++++++++++++
 include/linux/dma-noncoherent.h   | 109 ------------------------------
 kernel/dma/ops_helpers.c          |   1 -
 kernel/dma/pool.c                 |   1 -
 kernel/dma/swiotlb.c              |   2 +-
 29 files changed, 118 insertions(+), 137 deletions(-)
 delete mode 100644 include/linux/dma-noncoherent.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b13fc17943079a..c0dbe6e9de6549 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5203,7 +5203,6 @@ F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
-F:	include/linux/dma-noncoherent.h
 F:	kernel/dma/
 
 DMA-BUF HEAPS FRAMEWORK
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index a8c453e98d753b..517988e60cfc4d 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 911fc6ea26071e..c4b8df2ad32850 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 396797ffe2b1df..5c80088db13b59 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/cpu.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3afd3bd659d8de..93e87b2875567e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -7,7 +7,6 @@
 #include <linux/gfp.h>
 #include <linux/cache.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/dma-iommu.h>
 #include <xen/xen.h>
 #include <xen/swiotlb-xen.h>
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index a5909091cb1424..03df07a831fc99 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -15,7 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 3d9ff26c4bb4d8..c3a775a7e8f9d8 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -3,7 +3,6 @@
 
 #include <linux/cache.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/genalloc.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 25f388d9cfcc36..00b9a81075dd54 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/memblock.h>
 #include <linux/genalloc.h>
 #include <linux/module.h>
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 02e5aa08294ee0..ccba04d1267182 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmar.h>
 #include <linux/efi.h>
 #include <linux/elf.h>
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index b1ca3522eccc2f..1c1b875fadc180 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -6,7 +6,7 @@
 
 #undef DEBUG
 
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index a564863db06e98..04d091ade4172b 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
 #include <linux/bug.h>
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index e09b66e43cb63f..81dffe43b18c1e 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <asm/cpuinfo.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index b8fb42e56da0a8..461457b289828a 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -17,7 +17,6 @@
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
 #include <asm/io.h>
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 22d99ccc70c81e..38d3d9143b47fb 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -6,7 +6,6 @@
  */
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 69d762182d49bf..2ac8e6c82a61a5 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -3,7 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/cache.h>
 #include <linux/highmem.h>
 #include <asm/cacheflush.h>
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 345727638d52da..1b16d97e7da7f9 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -13,7 +13,7 @@
  * DMA mapping callbacks...
  */
 
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/pagewalk.h>
 
 #include <asm/cpuinfo.h>
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ce38c0b9158125..36610a5c029fc2 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -26,7 +26,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 
 #include <asm/cacheflush.h>
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 5ab4f868e919b8..30260b5d146da3 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 
 #include <asm/tlbflush.h>
 #include <asm/dma.h>
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index cd46a9825e3c59..6a44c0e7ba40ef 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2004 - 2007  Paul Mundt
  */
 #include <linux/mm.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index d6874c9b639f8d..8e1d72a1675949 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -38,7 +38,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/of_device.h>
 
 #include <asm/io.h>
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 790dbe022a0796..94955caa4488c8 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/dma-direct.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 22c221bba13e2f..3a00fb64477b0c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -12,7 +12,6 @@
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-iommu.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 71ff4bf380738c..71ce1b7a23d1cc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -27,9 +27,8 @@
 #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
 
 #include <linux/memblock.h>
-#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <xen/swiotlb-xen.h>
 #include <xen/page.h>
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index a2d6640c42c04e..18aade195884d7 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -7,7 +7,7 @@
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
 #include <linux/swiotlb.h>
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9891def42da71f..33c6e24707a94b 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -7,6 +7,7 @@
 #define _LINUX_DMA_MAP_OPS_H
 
 #include <linux/dma-mapping.h>
+#include <linux/pgtable.h>
 
 struct cma;
 
@@ -202,6 +203,107 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
+#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
+#include <asm/dma-coherence.h>
+#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+static inline bool dev_is_dma_coherent(struct device *dev)
+{
+	return dev->dma_coherent;
+}
+#else
+static inline bool dev_is_dma_coherent(struct device *dev)
+{
+	return true;
+}
+#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
+
+/*
+ * Check if an allocation needs to be marked uncached to be coherent.
+ */
+static __always_inline bool dma_alloc_need_uncached(struct device *dev,
+		unsigned long attrs)
+{
+	if (dev_is_dma_coherent(dev))
+		return false;
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return false;
+	return true;
+}
+
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs);
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs);
+
+#ifdef CONFIG_MMU
+/*
+ * Page protection so that devices that can't snoop CPU caches can use the
+ * memory coherently.  We default to pgprot_noncached which is usually used
+ * for ioremap as a safe bet, but architectures can override this with less
+ * strict semantics if possible.
+ */
+#ifndef pgprot_dmacoherent
+#define pgprot_dmacoherent(prot)	pgprot_noncached(prot)
+#endif
+
+pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs);
+#else
+static inline pgprot_t dma_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
+	return prot;	/* no protection bits supported without page tables */
+}
+#endif /* CONFIG_MMU */
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+#else
+static inline void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE */
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+#else
+static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+void arch_sync_dma_for_cpu_all(void);
+#else
+static inline void arch_sync_dma_for_cpu_all(void)
+{
+}
+#endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
+
+#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
+void arch_dma_prep_coherent(struct page *page, size_t size);
+#else
+static inline void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+}
+#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
+
+#ifdef CONFIG_ARCH_HAS_DMA_MARK_CLEAN
+void arch_dma_mark_clean(phys_addr_t paddr, size_t size);
+#else
+static inline void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
+{
+}
+#endif /* ARCH_HAS_DMA_MARK_CLEAN */
+
+void *arch_dma_set_uncached(void *addr, size_t size);
+void arch_dma_clear_uncached(void *addr, size_t size);
+
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent);
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
deleted file mode 100644
index e61283e06576a8..00000000000000
--- a/include/linux/dma-noncoherent.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_DMA_NONCOHERENT_H
-#define _LINUX_DMA_NONCOHERENT_H 1
-
-#include <linux/dma-mapping.h>
-#include <linux/pgtable.h>
-
-#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
-#include <asm/dma-coherence.h>
-#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-static inline bool dev_is_dma_coherent(struct device *dev)
-{
-	return dev->dma_coherent;
-}
-#else
-static inline bool dev_is_dma_coherent(struct device *dev)
-{
-	return true;
-}
-#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
-
-/*
- * Check if an allocation needs to be marked uncached to be coherent.
- */
-static __always_inline bool dma_alloc_need_uncached(struct device *dev,
-		unsigned long attrs)
-{
-	if (dev_is_dma_coherent(dev))
-		return false;
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
-		return false;
-	return true;
-}
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs);
-void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_addr, unsigned long attrs);
-
-#ifdef CONFIG_MMU
-/*
- * Page protection so that devices that can't snoop CPU caches can use the
- * memory coherently.  We default to pgprot_noncached which is usually used
- * for ioremap as a safe bet, but architectures can override this with less
- * strict semantics if possible.
- */
-#ifndef pgprot_dmacoherent
-#define pgprot_dmacoherent(prot)	pgprot_noncached(prot)
-#endif
-
-pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs);
-#else
-static inline pgprot_t dma_pgprot(struct device *dev, pgprot_t prot,
-		unsigned long attrs)
-{
-	return prot;	/* no protection bits supported without page tables */
-}
-#endif /* CONFIG_MMU */
-
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir);
-#else
-static inline void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-}
-#endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE */
-
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir);
-#else
-static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-}
-#endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
-
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
-void arch_sync_dma_for_cpu_all(void);
-#else
-static inline void arch_sync_dma_for_cpu_all(void)
-{
-}
-#endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
-
-#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
-void arch_dma_prep_coherent(struct page *page, size_t size);
-#else
-static inline void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-}
-#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
-
-#ifdef CONFIG_ARCH_HAS_DMA_MARK_CLEAN
-void arch_dma_mark_clean(phys_addr_t paddr, size_t size);
-#else
-static inline void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
-{
-}
-#endif /* ARCH_HAS_DMA_MARK_CLEAN */
-
-void *arch_dma_set_uncached(void *addr, size_t size);
-void arch_dma_clear_uncached(void *addr, size_t size);
-
-#endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index bc80fd2648bcf2..910ae69cae7774 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -4,7 +4,6 @@
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
 #include <linux/dma-map-ops.h>
-#include <linux/dma-noncoherent.h>
 
 /*
  * Create scatter-list for the already allocated DMA buffer.
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index c9fb5c3d8bd002..d4637f72239b40 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -7,7 +7,6 @@
 #include <linux/debugfs.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
 #include <linux/set_memory.h>
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4ea72d145cd27d..2be1e8b34ae3b9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -22,7 +22,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
+#include <linux/dma-map-ops.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
-- 
2.28.0

