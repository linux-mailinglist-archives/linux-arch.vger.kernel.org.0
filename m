Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6376D140
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjHBPOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B622D73;
        Wed,  2 Aug 2023 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h5KotGOxfSMXY8fe7KxTuI9F43npGySISQvI5VQ05oU=; b=I44KS4FB452HPp48QodUbfZi7K
        VFo8WExJRs/Uj2pef3hcImNYHq2mc2hOhnIj3QwRCEicZD7sYFdGy6obWtCrypWZcfxTU6NTTUyn0
        PKgPzw85VzYKgKHwi4uL8AHfm7mTNtvJE0z6IVJgcTDdn+v9d15d/lFKNeK0HlX0ATOAlEhjwZweW
        uryt+CqRccf7pFhmw9+Q6ORzk0k23sgLPP19MvGPE3+QNtJI342iLNq/5Y7H4uh6itb5I/D7U1XIW
        w6qmkunGbZ2Nmv8xasLFTnAKWQKDYfwsIcNrA+aa/wZokglL+vYUXOABMuISBZl3zCvKJyJqBd7bK
        asc+Jqgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY9-00Ffju-SI; Wed, 02 Aug 2023 15:14:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v6 18/38] nios2: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:46 +0100
Message-Id: <20230802151406.3735276-19-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/cacheflush.h |  6 ++-
 arch/nios2/include/asm/pgtable.h    | 28 ++++++----
 arch/nios2/mm/cacheflush.c          | 79 ++++++++++++++++-------------
 3 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
index d0b71dd71287..8624ca83cffe 100644
--- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -29,9 +29,13 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
 	unsigned long pfn);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
 
 extern void flush_icache_range(unsigned long start, unsigned long end);
-extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr);
+#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1);
 
 #define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
 #define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 0f5c2564e9f5..be6bf3e0bd7a 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -178,14 +178,21 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	*ptep = pteval;
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	unsigned long paddr = (unsigned long)page_to_virt(pte_page(pteval));
-
-	flush_dcache_range(paddr, paddr + PAGE_SIZE);
-	set_pte(ptep, pteval);
+	unsigned long paddr = (unsigned long)page_to_virt(pte_page(pte));
+
+	flush_dcache_range(paddr, paddr + nr * PAGE_SIZE);
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += 1;
+	}
 }
+#define set_ptes set_ptes
 
 static inline int pmd_none(pmd_t pmd)
 {
@@ -202,7 +209,7 @@ static inline void pte_clear(struct mm_struct *mm,
 
 	pte_val(null) = (addr >> PAGE_SHIFT) & 0xf;
 
-	set_pte_at(mm, addr, ptep, null);
+	set_pte(ptep, null);
 }
 
 /*
@@ -273,7 +280,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 extern void __init paging_init(void);
 extern void __init mmu_init(void);
 
-extern void update_mmu_cache(struct vm_area_struct *vma,
-			     unsigned long address, pte_t *pte);
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr);
+
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #endif /* _ASM_NIOS2_PGTABLE_H */
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 6aa9257c3ede..28b805f465a8 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -71,26 +71,26 @@ static void __flush_icache(unsigned long start, unsigned long end)
 	__asm__ __volatile(" flushp\n");
 }
 
-static void flush_aliases(struct address_space *mapping, struct page *page)
+static void flush_aliases(struct address_space *mapping, struct folio *folio)
 {
 	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *mpnt;
+	struct vm_area_struct *vma;
 	pgoff_t pgoff;
+	unsigned long nr = folio_nr_pages(folio);
 
-	pgoff = page->index;
+	pgoff = folio->index;
 
 	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
-		unsigned long offset;
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + nr - 1) {
+		unsigned long start;
 
-		if (mpnt->vm_mm != mm)
+		if (vma->vm_mm != mm)
 			continue;
-		if (!(mpnt->vm_flags & VM_MAYSHARE))
+		if (!(vma->vm_flags & VM_MAYSHARE))
 			continue;
 
-		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		flush_cache_page(mpnt, mpnt->vm_start + offset,
-			page_to_pfn(page));
+		start = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+		flush_cache_range(vma, start, start + nr * PAGE_SIZE);
 	}
 	flush_dcache_mmap_unlock(mapping);
 }
@@ -138,10 +138,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		__flush_icache(start, end);
 }
 
-void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr)
 {
 	unsigned long start = (unsigned long) page_address(page);
-	unsigned long end = start + PAGE_SIZE;
+	unsigned long end = start + nr * PAGE_SIZE;
 
 	__flush_dcache(start, end);
 	__flush_icache(start, end);
@@ -158,19 +159,19 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
 		__flush_icache(start, end);
 }
 
-void __flush_dcache_page(struct address_space *mapping, struct page *page)
+static void __flush_dcache_folio(struct folio *folio)
 {
 	/*
 	 * Writeback any data associated with the kernel mapping of this
 	 * page.  This ensures that data in the physical page is mutually
 	 * coherent with the kernels mapping.
 	 */
-	unsigned long start = (unsigned long)page_address(page);
+	unsigned long start = (unsigned long)folio_address(folio);
 
-	__flush_dcache(start, start + PAGE_SIZE);
+	__flush_dcache(start, start + folio_size(folio));
 }
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
 	struct address_space *mapping;
 
@@ -178,32 +179,38 @@ void flush_dcache_page(struct page *page)
 	 * The zero page is never written to, so never has any dirty
 	 * cache lines, and therefore never needs to be flushed.
 	 */
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(folio_pfn(folio)))
 		return;
 
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 
 	/* Flush this page if there are aliases. */
 	if (mapping && !mapping_mapped(mapping)) {
-		clear_bit(PG_dcache_clean, &page->flags);
+		clear_bit(PG_dcache_clean, &folio->flags);
 	} else {
-		__flush_dcache_page(mapping, page);
+		__flush_dcache_folio(folio);
 		if (mapping) {
-			unsigned long start = (unsigned long)page_address(page);
-			flush_aliases(mapping,  page);
-			flush_icache_range(start, start + PAGE_SIZE);
+			unsigned long start = (unsigned long)folio_address(folio);
+			flush_aliases(mapping, folio);
+			flush_icache_range(start, start + folio_size(folio));
 		}
-		set_bit(PG_dcache_clean, &page->flags);
+		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
+EXPORT_SYMBOL(flush_dcache_folio);
+
+void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 EXPORT_SYMBOL(flush_dcache_page);
 
-void update_mmu_cache(struct vm_area_struct *vma,
-		      unsigned long address, pte_t *ptep)
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 	pte_t pte = *ptep;
 	unsigned long pfn = pte_pfn(pte);
-	struct page *page;
+	struct folio *folio;
 	struct address_space *mapping;
 
 	reload_tlb_page(vma, address, pte);
@@ -215,19 +222,19 @@ void update_mmu_cache(struct vm_area_struct *vma,
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
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
+		__flush_dcache_folio(folio);
 
-	if(mapping)
-	{
-		flush_aliases(mapping, page);
+	mapping = folio_flush_mapping(folio);
+	if (mapping) {
+		flush_aliases(mapping, folio);
 		if (vma->vm_flags & VM_EXEC)
-			flush_icache_page(vma, page);
+			flush_icache_pages(vma, &folio->page,
+					folio_nr_pages(folio));
 	}
 }
 
-- 
2.40.1

