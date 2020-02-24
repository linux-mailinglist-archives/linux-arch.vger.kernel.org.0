Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9516B06D
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXTpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 14:45:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBXTpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 14:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ehuEnMa40tVXLpF/glmGVXLJpTa9E2IWiFFmlUlfLg0=; b=ku0MraN/rswEKoLi7Z3VUhdezm
        dWszo1vN0N4b9PlU97AKsjSLgmEuF5S5NptUZEKWkFbuEULgisaEg31ThaW8p09mVitqfxCQeALtz
        7+cjqwpHhKtKAIH5pJrcO0WHHlWx9xGpUqKIWieckkVAbEVA2svWffALvHr4klOIiso1ys4NvdWnz
        nZj1AGw3knw5t6SI+iMaAIAPtm8oF/q1RSZEezIjenxTs8NtKIx/6pYt3hTWQjqqlAK2fxOwIwUDi
        6AuR0KYQAEs/xsBFRiWg0hXLDVtAHQ1k4+6ZDtOUH5Ln8+50l6sYoc3sXrmQX23lJnFiSVhqzx5so
        hu6jSdpw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Jes-0006XH-JW; Mon, 24 Feb 2020 19:44:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dma-direct: make uncached_kernel_address more general
Date:   Mon, 24 Feb 2020 11:44:43 -0800
Message-Id: <20200224194446.690816-4-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rename the symbol to arch_dma_set_uncached, and pass a size to it as
well as allow an error return.  That will allow reusing this hook for
in-place pagetable remapping.

As the in-place remap doesn't always require an explicit cache flush,
also detangle ARCH_HAS_DMA_PREP_COHERENT from ARCH_HAS_DMA_SET_UNCACHED.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                    |  8 ++++----
 arch/microblaze/Kconfig         |  2 +-
 arch/microblaze/mm/consistent.c |  2 +-
 arch/mips/Kconfig               |  3 ++-
 arch/mips/mm/dma-noncoherent.c  |  2 +-
 arch/nios2/Kconfig              |  3 ++-
 arch/nios2/mm/dma-mapping.c     |  2 +-
 arch/xtensa/Kconfig             |  2 +-
 arch/xtensa/kernel/pci-dma.c    |  2 +-
 include/linux/dma-noncoherent.h |  2 +-
 kernel/dma/direct.c             | 10 ++++++----
 11 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7994b239f155..090cfe0c82a7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -248,11 +248,11 @@ config ARCH_HAS_SET_DIRECT_MAP
 	bool
 
 #
-# Select if arch has an uncached kernel segment and provides the
-# uncached_kernel_address symbol to use it
+# Select if the architecture provides the arch_dma_set_uncached symbol to
+# either provide an uncached segement alias for a DMA allocation, or
+# to remap the page tables in place.
 #
-config ARCH_HAS_UNCACHED_SEGMENT
-	select ARCH_HAS_DMA_PREP_COHERENT
+config ARCH_HAS_DMA_SET_UNCACHED
 	bool
 
 # Select if arch init_task must go in the __init_task_data section
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 6a331bd57ea8..9606c244b5b8 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -8,7 +8,7 @@ config MICROBLAZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_UNCACHED_SEGMENT if !MMU
+	select ARCH_HAS_DMA_SET_UNCACHED if !MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index cede7c5e8135..e09b66e43cb6 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -40,7 +40,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 #define UNCACHED_SHADOW_MASK 0
 #endif /* CONFIG_XILINX_UNCACHED_SHADOW */
 
-void *uncached_kernel_address(void *ptr)
+void *arch_dma_set_uncached(void *ptr, size_t size)
 {
 	unsigned long addr = (unsigned long)ptr;
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797d7f1ad5fe..489185db501e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1187,8 +1187,9 @@ config DMA_NONCOHERENT
 	# significant advantages.
 	#
 	select ARCH_HAS_DMA_WRITE_COMBINE
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_UNCACHED_SEGMENT
+	select ARCH_HAS_DMA_SET_UNCACHED
 	select DMA_NONCOHERENT_MMAP
 	select DMA_NONCOHERENT_CACHE_SYNC
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 77dce28ad0a0..fcea92d95d86 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -49,7 +49,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	dma_cache_wback_inv((unsigned long)page_address(page), size);
 }
 
-void *uncached_kernel_address(void *addr)
+void *arch_dma_set_uncached(void *addr, size_t size)
 {
 	return (void *)(__pa(addr) + UNCAC_BASE);
 }
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 44b5da37e8bd..2fc4ed210b5f 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,9 +2,10 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_UNCACHED_SEGMENT
+	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index f30f2749257c..fd887d5f3f9a 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -67,7 +67,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	flush_dcache_range(start, start + size);
 }
 
-void *uncached_kernel_address(void *ptr)
+void *arch_dma_set_uncached(void *ptr, size_t size)
 {
 	unsigned long addr = (unsigned long)ptr;
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 32ee759a3fda..de229424b659 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -6,7 +6,7 @@ config XTENSA
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
-	select ARCH_HAS_UNCACHED_SEGMENT if MMU
+	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 6a685545d5c9..17c4384f8495 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -92,7 +92,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
  * coherent DMA memory operations when CONFIG_MMU is not enabled.
  */
 #ifdef CONFIG_MMU
-void *uncached_kernel_address(void *p)
+void *arch_dma_set_uncached(void *p, size_t size)
 {
 	return p + XCHAL_KSEG_BYPASS_VADDR - XCHAL_KSEG_CACHED_VADDR;
 }
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index b6b72e19b0cd..1a4039506673 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -108,6 +108,6 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
-void *uncached_kernel_address(void *addr);
+void *arch_dma_set_uncached(void *addr, size_t size);
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9dfcc7be4903..f01a8191fd59 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -180,10 +180,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	memset(ret, 0, size);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    dma_alloc_need_uncached(dev, attrs)) {
 		arch_dma_prep_coherent(page, size);
-		ret = uncached_kernel_address(ret);
+		ret = arch_dma_set_uncached(ret, size);
+		if (IS_ERR(ret))
+			goto out_free_pages;
 	}
 done:
 	if (force_dma_unencrypted(dev))
@@ -224,7 +226,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
@@ -234,7 +236,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs))
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
-- 
2.24.1

