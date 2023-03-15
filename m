Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F46BA69C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCOFPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCOFOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096120A08;
        Tue, 14 Mar 2023 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pX110XgjOxNU1/0jgifvLXAw2qvdtN7y604t/uKKQbA=; b=DUKr040m19UcDMTwYOw1FWmIT8
        Ycr2ZYzUlEZjEPA9yHcljJ8KnOsxJhXcv5hL3MMZeuRx7cBxcC8Rm1rwKBLMI3zstWMZirtmwFn8z
        +ObRCfOgFOZPNccC7Inu5j9Zsmrv/fm2mXhshUcJ85SJV7sk/wUVxoiF/JGhHMvtUxAnXmcqCqgIg
        B8MmTJEkQnHyesLec8RgaOh97TdO/qB67Fncn51NXim+GaNF9mso35vTwGe4f8vGxo+/AYTDoOJ1A
        ZMJIjyIpNfgQSzLf0k79dstAyVByyelvHthM3ZC/j+jFdT2xb3mS5poSxNsEbSrmkL9FVBpmHAG+p
        xo5tsUJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTL-00DYBH-7r; Wed, 15 Mar 2023 05:14:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 08/36] arm: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:16 +0000
Message-Id: <20230315051444.3229621-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
flush_icache_pages().  Change the PG_dcache_clear flag from being per-page
to per-folio which makes __dma_page_dev_to_cpu() a bit more exciting.
Also add flush_cache_pages(), even though this isn't used by generic code
(yet?)

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/cacheflush.h | 24 +++++---
 arch/arm/include/asm/pgtable.h    |  5 +-
 arch/arm/include/asm/tlbflush.h   | 13 ++--
 arch/arm/mm/copypage-v4mc.c       |  5 +-
 arch/arm/mm/copypage-v6.c         |  5 +-
 arch/arm/mm/copypage-xscale.c     |  5 +-
 arch/arm/mm/dma-mapping.c         | 24 ++++----
 arch/arm/mm/fault-armv.c          | 14 ++---
 arch/arm/mm/flush.c               | 99 +++++++++++++++++++------------
 arch/arm/mm/mm.h                  |  2 +-
 arch/arm/mm/mmu.c                 | 14 +++--
 11 files changed, 125 insertions(+), 85 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index a094f964c869..841e268d2374 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -231,14 +231,15 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 					vma->vm_flags);
 }
 
-static inline void
-vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
+static inline void vivt_flush_cache_pages(struct vm_area_struct *vma,
+		unsigned long user_addr, unsigned long pfn, unsigned int nr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
 	if (!mm || cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
 		unsigned long addr = user_addr & PAGE_MASK;
-		__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
+		__cpuc_flush_user_range(addr, addr + nr * PAGE_SIZE,
+				vma->vm_flags);
 	}
 }
 
@@ -247,15 +248,17 @@ vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 		vivt_flush_cache_mm(mm)
 #define flush_cache_range(vma,start,end) \
 		vivt_flush_cache_range(vma,start,end)
-#define flush_cache_page(vma,addr,pfn) \
-		vivt_flush_cache_page(vma,addr,pfn)
+#define flush_cache_pages(vma, addr, pfn, nr) \
+		vivt_flush_cache_pages(vma, addr, pfn, nr)
 #else
-extern void flush_cache_mm(struct mm_struct *mm);
-extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
-extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn);
+void flush_cache_mm(struct mm_struct *mm);
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+void flush_cache_pages(struct vm_area_struct *vma, unsigned long user_addr,
+		unsigned long pfn, unsigned int nr);
 #endif
 
 #define flush_cache_dup_mm(mm) flush_cache_mm(mm)
+#define flush_cache_page(vma, addr, pfn) flush_cache_pages(vma, addr, pfn, 1)
 
 /*
  * flush_icache_user_range is used when we want to ensure that the
@@ -289,7 +292,9 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * See update_mmu_cache for the user space part.
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-extern void flush_dcache_page(struct page *);
+void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
 
 #define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
 static inline void flush_kernel_vmap_range(void *addr, int size)
@@ -321,6 +326,7 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
  * duplicate cache flushing elsewhere performed by flush_dcache_page().
  */
 #define flush_icache_page(vma,page)	do { } while (0)
+#define flush_icache_pages(vma, page, nr)	do { } while (0)
 
 /*
  * flush_cache_vmap() is used when creating mappings (eg, via vmap,
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a58ccbb406ad..841001ab495c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -207,8 +207,9 @@ static inline void __sync_icache_dcache(pte_t pteval)
 extern void __sync_icache_dcache(pte_t pteval);
 #endif
 
-void set_pte_at(struct mm_struct *mm, unsigned long addr,
-		      pte_t *ptep, pte_t pteval);
+void set_ptes(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pteval, unsigned int nr);
+#define set_ptes set_ptes
 
 static inline pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
 {
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 0ccc985b90af..7d792e485f4f 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -619,18 +619,21 @@ extern void flush_bp_all(void);
  * If PG_dcache_clean is not set for the page, we need to ensure that any
  * cache entries for the kernels virtual memory range are written
  * back to the page. On ARMv6 and later, the cache coherency is handled via
- * the set_pte_at() function.
+ * the set_ptes() function.
  */
 #if __LINUX_ARM_ARCH__ < 6
-extern void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-	pte_t *ptep);
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, unsigned int nr);
 #else
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-				    unsigned long addr, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 }
 #endif
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
+
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
 #endif
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index f1da3b439b96..7ddd82b9fe8b 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -64,10 +64,11 @@ static void mc_copy_user_page(void *from, void *to)
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
 	unsigned long vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
 	void *kto = kmap_atomic(to);
 
-	if (!test_and_set_bit(PG_dcache_clean, &from->flags))
-		__flush_dcache_page(page_mapping_file(from), from);
+	if (!test_and_set_bit(PG_dcache_clean, &src->flags))
+		__flush_dcache_folio(folio_flush_mapping(src), src);
 
 	raw_spin_lock(&minicache_lock);
 
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index d8a115de5507..a1a71f36d850 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -69,11 +69,12 @@ static void discard_old_kernel_data(void *kto)
 static void v6_copy_user_highpage_aliasing(struct page *to,
 	struct page *from, unsigned long vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
 	unsigned int offset = CACHE_COLOUR(vaddr);
 	unsigned long kfrom, kto;
 
-	if (!test_and_set_bit(PG_dcache_clean, &from->flags))
-		__flush_dcache_page(page_mapping_file(from), from);
+	if (!test_and_set_bit(PG_dcache_clean, &src->flags))
+		__flush_dcache_folio(folio_flush_mapping(src), src);
 
 	/* FIXME: not highmem safe */
 	discard_old_kernel_data(page_address(to));
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index bcb485620a05..f1e29d3e8193 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -84,10 +84,11 @@ static void mc_copy_user_page(void *from, void *to)
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
 	unsigned long vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
 	void *kto = kmap_atomic(to);
 
-	if (!test_and_set_bit(PG_dcache_clean, &from->flags))
-		__flush_dcache_page(page_mapping_file(from), from);
+	if (!test_and_set_bit(PG_dcache_clean, &src->flags))
+		__flush_dcache_folio(folio_flush_mapping(src), src);
 
 	raw_spin_lock(&minicache_lock);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8bc01071474a..5ecfde41d70a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -693,6 +693,7 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
+	struct folio *folio = page_folio(page);
 	phys_addr_t paddr = page_to_phys(page) + off;
 
 	/* FIXME: non-speculating: not required */
@@ -707,19 +708,18 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	 * Mark the D-cache clean for these pages to avoid extra flushing.
 	 */
 	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
-		unsigned long pfn;
-		size_t left = size;
-
-		pfn = page_to_pfn(page) + off / PAGE_SIZE;
-		off %= PAGE_SIZE;
-		if (off) {
-			pfn++;
-			left -= PAGE_SIZE - off;
+		ssize_t left = size;
+		size_t offset = offset_in_folio(folio, paddr);
+
+		if (offset) {
+			left -= folio_size(folio) - offset;
+			folio = folio_next(folio);
 		}
-		while (left >= PAGE_SIZE) {
-			page = pfn_to_page(pfn++);
-			set_bit(PG_dcache_clean, &page->flags);
-			left -= PAGE_SIZE;
+
+		while (left >= (ssize_t)folio_size(folio)) {
+			set_bit(PG_dcache_clean, &folio->flags);
+			left -= folio_size(folio);
+			folio = folio_next(folio);
 		}
 	}
 }
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 0e49154454a6..e2c869b8f012 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -178,8 +178,8 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
  *
  * Note that the pte lock will be held.
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-	pte_t *ptep)
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
 {
 	unsigned long pfn = pte_pfn(*ptep);
 	struct address_space *mapping;
@@ -192,13 +192,13 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	 * The zero page is never written to, so never has any dirty
 	 * cache lines, and therefore never needs to be flushed.
 	 */
-	page = pfn_to_page(pfn);
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(pfn))
 		return;
 
-	mapping = page_mapping_file(page);
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
-		__flush_dcache_page(mapping, page);
+	folio = page_folio(pfn_to_page(pfn));
+	mapping = folio_flush_mapping(page);
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
+		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, ptep, pfn);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7ff9feea13a6..07ea0ab51099 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -95,10 +95,10 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 		__flush_icache_all();
 }
 
-void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
+void flush_cache_pages(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn, unsigned int nr)
 {
 	if (cache_is_vivt()) {
-		vivt_flush_cache_page(vma, user_addr, pfn);
+		vivt_flush_cache_pages(vma, user_addr, pfn, nr);
 		return;
 	}
 
@@ -196,29 +196,31 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 #endif
 }
 
-void __flush_dcache_page(struct address_space *mapping, struct page *page)
+void __flush_dcache_folio(struct address_space *mapping, struct folio *folio)
 {
 	/*
 	 * Writeback any data associated with the kernel mapping of this
 	 * page.  This ensures that data in the physical page is mutually
 	 * coherent with the kernels mapping.
 	 */
-	if (!PageHighMem(page)) {
-		__cpuc_flush_dcache_area(page_address(page), page_size(page));
+	if (!folio_test_highmem(folio)) {
+		__cpuc_flush_dcache_area(folio_address(folio),
+					folio_size(folio));
 	} else {
 		unsigned long i;
 		if (cache_is_vipt_nonaliasing()) {
-			for (i = 0; i < compound_nr(page); i++) {
-				void *addr = kmap_atomic(page + i);
+			for (i = 0; i < folio_nr_pages(folio); i++) {
+				void *addr = kmap_local_folio(folio,
+								i * PAGE_SIZE);
 				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-				kunmap_atomic(addr);
+				kunmap_local(addr);
 			}
 		} else {
-			for (i = 0; i < compound_nr(page); i++) {
-				void *addr = kmap_high_get(page + i);
+			for (i = 0; i < folio_nr_pages(folio); i++) {
+				void *addr = kmap_high_get(folio_page(folio, i));
 				if (addr) {
 					__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-					kunmap_high(page + i);
+					kunmap_high(folio_page(folio, i));
 				}
 			}
 		}
@@ -230,15 +232,14 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * userspace colour, which is congruent with page->index.
 	 */
 	if (mapping && cache_is_vipt_aliasing())
-		flush_pfn_alias(page_to_pfn(page),
-				page->index << PAGE_SHIFT);
+		flush_pfn_alias(folio_pfn(folio), folio_pos(folio));
 }
 
-static void __flush_dcache_aliases(struct address_space *mapping, struct page *page)
+static void __flush_dcache_aliases(struct address_space *mapping, struct folio *folio)
 {
 	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *mpnt;
-	pgoff_t pgoff;
+	struct vm_area_struct *vma;
+	pgoff_t pgoff, pgoff_end;
 
 	/*
 	 * There are possible user space mappings of this page:
@@ -246,21 +247,36 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 	 *   data in the current VM view associated with this page.
 	 * - aliasing VIPT: we only need to find one mapping of this page.
 	 */
-	pgoff = page->index;
+	pgoff = folio->index;
+	pgoff_end = pgoff + folio_nr_pages(folio) - 1;
 
 	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
-		unsigned long offset;
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff_end) {
+		unsigned long start, offset, pfn;
+		unsigned int nr;
 
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		if (mpnt->vm_mm != mm)
+		if (vma->vm_mm != mm)
 			continue;
-		if (!(mpnt->vm_flags & VM_MAYSHARE))
+		if (!(vma->vm_flags & VM_MAYSHARE))
 			continue;
-		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		flush_cache_page(mpnt, mpnt->vm_start + offset, page_to_pfn(page));
+
+		start = vma->vm_start;
+		pfn = folio_pfn(folio);
+		nr = folio_nr_pages(folio);
+		offset = pgoff - vma->vm_pgoff;
+		if (offset > -nr) {
+			pfn -= offset;
+			nr += offset;
+		} else {
+			start += offset * PAGE_SIZE;
+		}
+		if (start + nr * PAGE_SIZE > vma->vm_end)
+			nr = (vma->vm_end - start) / PAGE_SIZE;
+
+		flush_cache_pages(vma, start, pfn, nr);
 	}
 	flush_dcache_mmap_unlock(mapping);
 }
@@ -269,7 +285,7 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 void __sync_icache_dcache(pte_t pteval)
 {
 	unsigned long pfn;
-	struct page *page;
+	struct folio *folio;
 	struct address_space *mapping;
 
 	if (cache_is_vipt_nonaliasing() && !pte_exec(pteval))
@@ -279,14 +295,14 @@ void __sync_icache_dcache(pte_t pteval)
 	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pfn);
+	folio = page_folio(pfn_to_page(pfn));
 	if (cache_is_vipt_aliasing())
-		mapping = page_mapping_file(page);
+		mapping = folio_flush_mapping(folio);
 	else
 		mapping = NULL;
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
-		__flush_dcache_page(mapping, page);
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
+		__flush_dcache_folio(mapping, folio);
 
 	if (pte_exec(pteval))
 		__flush_icache_all();
@@ -312,7 +328,7 @@ void __sync_icache_dcache(pte_t pteval)
  * Note that we disable the lazy flush for SMP configurations where
  * the cache maintenance operations are not automatically broadcasted.
  */
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
 	struct address_space *mapping;
 
@@ -320,31 +336,36 @@ void flush_dcache_page(struct page *page)
 	 * The zero page is never written to, so never has any dirty
 	 * cache lines, and therefore never needs to be flushed.
 	 */
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(folio_pfn(folio)))
 		return;
 
 	if (!cache_ops_need_broadcast() && cache_is_vipt_nonaliasing()) {
-		if (test_bit(PG_dcache_clean, &page->flags))
-			clear_bit(PG_dcache_clean, &page->flags);
+		if (test_bit(PG_dcache_clean, &folio->flags))
+			clear_bit(PG_dcache_clean, &folio->flags);
 		return;
 	}
 
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 
 	if (!cache_ops_need_broadcast() &&
-	    mapping && !page_mapcount(page))
-		clear_bit(PG_dcache_clean, &page->flags);
+	    mapping && !folio_mapped(folio))
+		clear_bit(PG_dcache_clean, &folio->flags);
 	else {
-		__flush_dcache_page(mapping, page);
+		__flush_dcache_folio(mapping, folio);
 		if (mapping && cache_is_vivt())
-			__flush_dcache_aliases(mapping, page);
+			__flush_dcache_aliases(mapping, folio);
 		else if (mapping)
 			__flush_icache_all();
-		set_bit(PG_dcache_clean, &page->flags);
+		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
 
+void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
+EXPORT_SYMBOL(flush_dcache_page);
 /*
  * Flush an anonymous page so that users of get_user_pages()
  * can safely access the data.  The expected sequence is:
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index d7ffccb7fea7..419316316711 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -45,7 +45,7 @@ struct mem_type {
 
 const struct mem_type *get_mem_type(unsigned int type);
 
-extern void __flush_dcache_page(struct address_space *mapping, struct page *page);
+void __flush_dcache_folio(struct address_space *mapping, struct folio *folio);
 
 /*
  * ARM specific vm_struct->flags bits.
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..9947bbc32b04 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1788,7 +1788,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	bootmem_init();
 
 	empty_zero_page = virt_to_page(zero_page);
-	__flush_dcache_page(NULL, empty_zero_page);
+	__flush_dcache_folio(NULL, page_folio(empty_zero_page));
 }
 
 void __init early_mm_init(const struct machine_desc *mdesc)
@@ -1797,8 +1797,8 @@ void __init early_mm_init(const struct machine_desc *mdesc)
 	early_paging_init(mdesc);
 }
 
-void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
+void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval, unsigned int nr)
 {
 	unsigned long ext = 0;
 
@@ -1808,5 +1808,11 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr,
 		ext |= PTE_EXT_NG;
 	}
 
-	set_pte_ext(ptep, pteval, ext);
+	for (;;) {
+		set_pte_ext(ptep, pteval, ext);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pteval) += PAGE_SIZE;
+	}
 }
-- 
2.39.2

