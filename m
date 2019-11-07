Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2204F35E5
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 18:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfKGRlK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 12:41:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKGRlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lnLOVpQdpg/WXuB9MxQ8JFYhZaENZTFWxiP/OhMVsRk=; b=d8E72FmQdvR38A8RpWVMsV8Mf
        +JqYCCQm5uf4bsYr+IuhfB9CTCDqm+DG1gr7xOF7XlsEbFqO0KzDw7MhdIlM5jTmPf5NJZ+r4THUf
        L+kDdHvtsiVdeADpxzHPVNiEI63fAsSyHyJjkYjE/rGitdCA5R9cY2IIJi/BLl+b/q6t77+l4Wm1J
        EYTxz7g2ri+/1vQOUZYr1otLoFEO9o2lLYWOTJjbT4pEH7EskxhE98JnSN4qNKmRPX80lATDXWCJy
        TRJBJlPNigqqdrdVpXgv+GbV/17j186IYQYrLPaTWSPRMyISqNhi0CqdJY91cwxx7Ok4wOWgvWoWG
        gYejiOYMw==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSlmO-0002sZ-R5; Thu, 07 Nov 2019 17:41:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org
Subject: [PATCH] dma-mapping: drop the dev argument to arch_sync_dma_for_*
Date:   Thu,  7 Nov 2019 18:41:05 +0100
Message-Id: <20191107174105.13842-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These are pure cache maintainance routines, so drop the unused
struct device argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/mm/dma.c                 |  8 ++++----
 arch/arm/mm/dma-mapping.c         |  8 ++++----
 arch/arm/xen/mm.c                 | 12 ++++++------
 arch/arm64/mm/dma-mapping.c       |  8 ++++----
 arch/c6x/mm/dma-coherent.c        |  8 ++++----
 arch/csky/mm/dma-mapping.c        |  8 ++++----
 arch/hexagon/kernel/dma.c         |  4 ++--
 arch/ia64/mm/init.c               |  4 ++--
 arch/m68k/kernel/dma.c            |  4 ++--
 arch/microblaze/kernel/dma.c      |  8 ++++----
 arch/mips/bmips/dma.c             |  2 +-
 arch/mips/jazz/jazzdma.c          | 17 ++++++++---------
 arch/mips/mm/dma-noncoherent.c    |  8 ++++----
 arch/nds32/kernel/dma.c           |  8 ++++----
 arch/nios2/mm/dma-mapping.c       |  8 ++++----
 arch/openrisc/kernel/dma.c        |  2 +-
 arch/parisc/kernel/pci-dma.c      |  8 ++++----
 arch/powerpc/mm/dma-noncoherent.c |  8 ++++----
 arch/sh/kernel/dma-coherent.c     |  6 +++---
 arch/sparc/kernel/ioport.c        |  4 ++--
 arch/xtensa/kernel/pci-dma.c      |  8 ++++----
 drivers/iommu/dma-iommu.c         | 10 +++++-----
 drivers/xen/swiotlb-xen.c         |  8 ++++----
 include/linux/dma-noncoherent.h   | 20 ++++++++++----------
 include/xen/swiotlb-xen.h         |  8 ++++----
 kernel/dma/direct.c               | 14 +++++++-------
 26 files changed, 105 insertions(+), 106 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 73a7e88a1e92..e947572a521e 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -48,8 +48,8 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
  * upper layer functions (in include/linux/dma-mapping.h)
  */
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
@@ -69,8 +69,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f3cbeba7f9cb..da1a32b5e192 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2332,15 +2332,15 @@ void arch_teardown_dma_ops(struct device *dev)
 }
 
 #ifdef CONFIG_SWIOTLB
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_page_cpu_to_dev(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
 			      size, dir);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_page_dev_to_cpu(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
 			      size, dir);
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 38fa917c8585..a6a2514e5fe8 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -70,20 +70,20 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
  * pfn_valid returns true the pages is local and we can use the native
  * dma-direct functions, otherwise we call the Xen specific version.
  */
-void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+void xen_dma_sync_for_cpu(dma_addr_t handle, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (pfn_valid(PFN_DOWN(handle)))
-		arch_sync_dma_for_cpu(dev, paddr, size, dir);
+		arch_sync_dma_for_cpu(paddr, size, dir);
 	else if (dir != DMA_TO_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 }
 
-void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+void xen_dma_sync_for_device(dma_addr_t handle, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (pfn_valid(PFN_DOWN(handle)))
-		arch_sync_dma_for_device(dev, paddr, size, dir);
+		arch_sync_dma_for_device(paddr, size, dir);
 	else if (dir == DMA_FROM_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 	else
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 9239416e93d4..6c45350e33aa 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -13,14 +13,14 @@
 
 #include <asm/cacheflush.h>
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_map_area(phys_to_virt(paddr), size, dir);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index b319808e8f6b..399ceb3f167d 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -160,14 +160,14 @@ static void c6x_dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
 	}
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	return c6x_dma_sync(dev, paddr, size, dir);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	return c6x_dma_sync(dev, paddr, size, dir);
 }
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 06e85b565454..8f6571ae27c8 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -58,8 +58,8 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	cache_op(page_to_phys(page), size, dma_wbinv_set_zero_range);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-			      size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
@@ -74,8 +74,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-			   size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index f561b127c4b4..25f388d9cfcc 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -55,8 +55,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	void *addr = phys_to_virt(paddr);
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index bf9df2625bc8..58fd67068bac 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -73,8 +73,8 @@ __ia64_sync_icache_dcache (pte_t pte)
  * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
  * flush them when they get mapped into an executable vm-area.
  */
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	unsigned long pfn = PHYS_PFN(paddr);
 
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 3fab684cc0db..871a0e11da34 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -61,8 +61,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 
 #endif /* CONFIG_MMU && !CONFIG_COLDFIRE */
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t handle,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t handle, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index a89c2d4ed5ff..a9016c5ff5a4 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -31,14 +31,14 @@ static void __dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
 	}
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_sync(dev, paddr, size, dir);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_sync(dev, paddr, size, dir);
 }
diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3d13c77c125f..df56bf4179e3 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -64,7 +64,7 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 	return dma_addr;
 }
 
-void arch_sync_dma_for_cpu_all(struct device *dev)
+void arch_sync_dma_for_cpu_all(void)
 {
 	void __iomem *cbr = BMIPS_GET_CBR();
 	u32 cfg;
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index a01e14955187..c64a297e82b3 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -592,7 +592,7 @@ static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(dev, phys, size, dir);
+		arch_sync_dma_for_device(phys, size, dir);
 	return vdma_alloc(phys, size);
 }
 
@@ -600,7 +600,7 @@ static void jazz_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_cpu(dev, vdma_log2phys(dma_addr), size, dir);
+		arch_sync_dma_for_cpu(vdma_log2phys(dma_addr), size, dir);
 	vdma_free(dma_addr);
 }
 
@@ -612,7 +612,7 @@ static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	for_each_sg(sglist, sg, nents, i) {
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+			arch_sync_dma_for_device(sg_phys(sg), sg->length,
 				dir);
 		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
@@ -631,8 +631,7 @@ static void jazz_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 
 	for_each_sg(sglist, sg, nents, i) {
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length,
-				dir);
+			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 		vdma_free(sg->dma_address);
 	}
 }
@@ -640,13 +639,13 @@ static void jazz_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static void jazz_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
-	arch_sync_dma_for_device(dev, vdma_log2phys(addr), size, dir);
+	arch_sync_dma_for_device(vdma_log2phys(addr), size, dir);
 }
 
 static void jazz_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
-	arch_sync_dma_for_cpu(dev, vdma_log2phys(addr), size, dir);
+	arch_sync_dma_for_cpu(vdma_log2phys(addr), size, dir);
 }
 
 static void jazz_dma_sync_sg_for_device(struct device *dev,
@@ -656,7 +655,7 @@ static void jazz_dma_sync_sg_for_device(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i)
-		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
 static void jazz_dma_sync_sg_for_cpu(struct device *dev,
@@ -666,7 +665,7 @@ static void jazz_dma_sync_sg_for_cpu(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i)
-		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 }
 
 const struct dma_map_ops jazz_dma_ops = {
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index fcf6d3eaac66..11f4d917fa2e 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -112,15 +112,15 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 	} while (left);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	dma_sync_phys(paddr, size, dir);
 }
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (cpu_needs_post_dma_flush(dev))
 		dma_sync_phys(paddr, size, dir);
diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 4206d4b6c8ce..69d762182d49 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -46,8 +46,8 @@ static inline void cache_op(phys_addr_t paddr, size_t size,
 	} while (left);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_FROM_DEVICE:
@@ -61,8 +61,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 9cb238664584..0ed711e37902 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -18,8 +18,8 @@
 #include <linux/cache.h>
 #include <asm/cacheflush.h>
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	void *vaddr = phys_to_virt(paddr);
 
@@ -42,8 +42,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	void *vaddr = phys_to_virt(paddr);
 
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 4d5b8bd1d795..adec711ad39d 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -125,7 +125,7 @@ arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t addr, size_t size,
+void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 		enum dma_data_direction dir)
 {
 	unsigned long cl;
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ca35d9a76e50..a60d47fd4d55 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -439,14 +439,14 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages((unsigned long)__va(dma_handle), order);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 2a82984356f8..5ab4f868e919 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -104,14 +104,14 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
 #endif
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_sync_page(paddr, size, dir);
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	__dma_sync_page(paddr, size, dir);
 }
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index b17514619b7e..eeb25a4fa55f 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -25,7 +25,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * Pages from the page allocator may have data present in
 	 * cache. So flush the cache before using uncached memory.
 	 */
-	arch_sync_dma_for_device(dev, virt_to_phys(ret), size,
+	arch_sync_dma_for_device(virt_to_phys(ret), size,
 			DMA_BIDIRECTIONAL);
 
 	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
@@ -59,8 +59,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	iounmap(vaddr);
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	void *addr = sh_cacheop_vaddr(phys_to_virt(paddr));
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index f89603855f1e..e59461d03b9a 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -366,8 +366,8 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 /* IIep is write-through, not flushing on cpu to device transfer. */
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (dir != PCI_DMA_TODEVICE)
 		dma_make_coherent(paddr, PAGE_ALIGN(size));
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 1c82e21de4f6..72b6222daa0b 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -44,8 +44,8 @@ static void do_cache_op(phys_addr_t paddr, size_t size,
 		}
 }
 
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
@@ -62,8 +62,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f321279baf9e..0fa8c1d818b7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -659,7 +659,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_cpu(dev, phys, size, dir);
+	arch_sync_dma_for_cpu(phys, size, dir);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -671,7 +671,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_device(dev, phys, size, dir);
+	arch_sync_dma_for_device(phys, size, dir);
 }
 
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
@@ -685,7 +685,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -699,7 +699,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -714,7 +714,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	dma_handle =__iommu_dma_map(dev, phys, size, prot);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
-		arch_sync_dma_for_device(dev, phys, size, dir);
+		arch_sync_dma_for_device(phys, size, dir);
 	return dma_handle;
 }
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index bd3a10dfac15..3f8b2cdb4acb 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -405,7 +405,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 done:
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xen_dma_sync_for_device(dev, dev_addr, phys, size, dir);
+		xen_dma_sync_for_device(dev_addr, phys, size, dir);
 	return dev_addr;
 }
 
@@ -425,7 +425,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	BUG_ON(dir == DMA_NONE);
 
 	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xen_dma_sync_for_cpu(hwdev, dev_addr, paddr, size, dir);
+		xen_dma_sync_for_cpu(dev_addr, paddr, size, dir);
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(dev_addr))
@@ -439,7 +439,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
 	if (!dev_is_dma_coherent(dev))
-		xen_dma_sync_for_cpu(dev, dma_addr, paddr, size, dir);
+		xen_dma_sync_for_cpu(dma_addr, paddr, size, dir);
 
 	if (is_xen_swiotlb_buffer(dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
@@ -455,7 +455,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
-		xen_dma_sync_for_device(dev, dma_addr, paddr, size, dir);
+		xen_dma_sync_for_device(dma_addr, paddr, size, dir);
 }
 
 /*
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index e30fca1f1b12..ca9b5770caee 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -73,29 +73,29 @@ static inline void arch_dma_cache_sync(struct device *dev, void *vaddr,
 #endif /* CONFIG_DMA_NONCOHERENT_CACHE_SYNC */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
-void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir);
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
 #else
-static inline void arch_sync_dma_for_device(struct device *dev,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+static inline void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
-void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir);
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
 #else
-static inline void arch_sync_dma_for_cpu(struct device *dev,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
-void arch_sync_dma_for_cpu_all(struct device *dev);
+void arch_sync_dma_for_cpu_all(void);
 #else
-static inline void arch_sync_dma_for_cpu_all(struct device *dev)
+static inline void arch_sync_dma_for_cpu_all(void)
 {
 }
 #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index d71380f6ed0b..ffc0d3902b71 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -4,10 +4,10 @@
 
 #include <linux/swiotlb.h>
 
-void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
-void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
-		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
+void xen_dma_sync_for_cpu(dma_addr_t handle, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void xen_dma_sync_for_device(dma_addr_t handle, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
 
 extern int xen_swiotlb_init(int verbose, bool early);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index e37e7ab6e2ee..29e5a6d10e9c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -268,7 +268,7 @@ void dma_direct_sync_single_for_device(struct device *dev,
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_device(dev, paddr, size, dir);
+		arch_sync_dma_for_device(paddr, size, dir);
 }
 EXPORT_SYMBOL(dma_direct_sync_single_for_device);
 
@@ -286,7 +286,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir, SYNC_FOR_DEVICE);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(dev, paddr, sg->length,
+			arch_sync_dma_for_device(paddr, sg->length,
 					dir);
 	}
 }
@@ -302,8 +302,8 @@ void dma_direct_sync_single_for_cpu(struct device *dev,
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
 	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(dev, paddr, size, dir);
-		arch_sync_dma_for_cpu_all(dev);
+		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_for_cpu_all();
 	}
 
 	if (unlikely(is_swiotlb_buffer(paddr)))
@@ -321,7 +321,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(dev, paddr, sg->length, dir);
+			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
 		if (unlikely(is_swiotlb_buffer(paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
@@ -329,7 +329,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	}
 
 	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_cpu_all(dev);
+		arch_sync_dma_for_cpu_all();
 }
 EXPORT_SYMBOL(dma_direct_sync_sg_for_cpu);
 
@@ -380,7 +380,7 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	}
 
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(dev, phys, size, dir);
+		arch_sync_dma_for_device(phys, size, dir);
 	return dma_addr;
 }
 EXPORT_SYMBOL(dma_direct_map_page);
-- 
2.20.1

