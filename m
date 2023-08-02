Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6323776D156
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHBPOf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjHBPOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F3C2D76;
        Wed,  2 Aug 2023 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xd+rUk+JorrUD2fntdyOGw757rx3p3JMpmCuxu2/HT0=; b=f9xsucpSyz6ryOrM5zQqqRhfqa
        +3sAFzDTVEfnykYvhr8ndbPq8z1HFUnJYrOR5gYjiQoIUOAkQqDcxqBDJUIKRXsZzxz8QWnKw87rq
        dPQC1Kh8N6OCNRFrm7UNsDiaDMuXpihpN0+soarb0NPmcGhsMnx/SPLd4M73Jo5l30pOoiX1/CXY1
        OgEXpW690lxpVfCzEj5N5+tbOpIBfIVUtYImUmoI5hpUKxFeDKVWdDLeltduEEMwqAzFnZGr2IQBz
        XOTkoYxkcI70XvTkV/u5yqGSV+wDFNuQMscjEYMaCRhhYp+UuzjVmz86fxNl306/5pCE5awoa1Jbu
        nlkiCkPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYA-00FfkH-8O; Wed, 02 Aug 2023 15:14:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v6 20/38] parisc: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:48 +0100
Message-Id: <20230802151406.3735276-21-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio()
and flush_icache_pages().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/cacheflush.h |  14 ++--
 arch/parisc/include/asm/pgtable.h    |  37 +++++----
 arch/parisc/kernel/cache.c           | 107 ++++++++++++++++++---------
 3 files changed, 105 insertions(+), 53 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index c8b6928cee1e..b77c3e0c37d3 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -43,8 +43,13 @@ void invalidate_kernel_vmap_range(void *vaddr, int size);
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *page);
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
@@ -53,10 +58,9 @@ void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
 		xa_unlock_irqrestore(&mapping->i_pages, flags)
 
-#define flush_icache_page(vma,page)	do { 		\
-	flush_kernel_dcache_page_addr(page_address(page)); \
-	flush_kernel_icache_page(page_address(page)); 	\
-} while (0)
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr);
+#define flush_icache_page(vma, page)	flush_icache_pages(vma, page, 1)
 
 #define flush_icache_range(s,e)		do { 		\
 	flush_kernel_dcache_range_asm(s,e); 		\
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 5656395c95ee..ce38bb375b60 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -73,15 +73,6 @@ extern void __update_cache(pte_t pte);
 		mb();				\
 	} while(0)
 
-#define set_pte_at(mm, addr, pteptr, pteval)	\
-	do {					\
-		if (pte_present(pteval) &&	\
-		    pte_user(pteval))		\
-			__update_cache(pteval);	\
-		*(pteptr) = (pteval);		\
-		purge_tlb_entries(mm, addr);	\
-	} while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #define pte_ERROR(e) \
@@ -285,7 +276,7 @@ extern unsigned long *empty_zero_page;
 #define pte_none(x)     (pte_val(x) == 0)
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_user(x)	(pte_val(x) & _PAGE_USER)
-#define pte_clear(mm, addr, xp)  set_pte_at(mm, addr, xp, __pte(0))
+#define pte_clear(mm, addr, xp)  set_pte(xp, __pte(0))
 
 #define pmd_flag(x)	(pmd_val(x) & PxD_FLAG_MASK)
 #define pmd_address(x)	((unsigned long)(pmd_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
@@ -391,11 +382,29 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 
 extern void paging_init (void);
 
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	if (pte_present(pte) && pte_user(pte))
+		__update_cache(pte);
+	for (;;) {
+		*ptep = pte;
+		purge_tlb_entries(mm, addr);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += 1 << PFN_PTE_SHIFT;
+		addr += PAGE_SIZE;
+	}
+}
+#define set_ptes set_ptes
+
 /* Used for deferring calls to flush_dcache_page() */
 
 #define PG_dcache_dirty         PG_arch_1
 
-#define update_mmu_cache(vms,addr,ptep) __update_cache(*ptep)
+#define update_mmu_cache_range(vmf, vma, addr, ptep, nr) __update_cache(*ptep)
+#define update_mmu_cache(vma, addr, ptep) __update_cache(*ptep)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
@@ -450,7 +459,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned
 	if (!pte_young(pte)) {
 		return 0;
 	}
-	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
+	set_pte(ptep, pte_mkold(pte));
 	return 1;
 }
 
@@ -460,14 +469,14 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	pte_t old_pte;
 
 	old_pte = *ptep;
-	set_pte_at(mm, addr, ptep, __pte(0));
+	set_pte(ptep, __pte(0));
 
 	return old_pte;
 }
 
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	set_pte_at(mm, addr, ptep, pte_wrprotect(*ptep));
+	set_pte(ptep, pte_wrprotect(*ptep));
 }
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index b55b35c89d6a..442109a48940 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -94,11 +94,11 @@ static inline void flush_data_cache(void)
 /* Kernel virtual address of pfn.  */
 #define pfn_va(pfn)	__va(PFN_PHYS(pfn))
 
-void
-__update_cache(pte_t pte)
+void __update_cache(pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
-	struct page *page;
+	struct folio *folio;
+	unsigned int nr;
 
 	/* We don't have pte special.  As a result, we can be called with
 	   an invalid pfn and we don't need to flush the kernel dcache page.
@@ -106,13 +106,17 @@ __update_cache(pte_t pte)
 	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pfn);
-	if (page_mapping_file(page) &&
-	    test_bit(PG_dcache_dirty, &page->flags)) {
-		flush_kernel_dcache_page_addr(pfn_va(pfn));
-		clear_bit(PG_dcache_dirty, &page->flags);
+	folio = page_folio(pfn_to_page(pfn));
+	pfn = folio_pfn(folio);
+	nr = folio_nr_pages(folio);
+	if (folio_flush_mapping(folio) &&
+	    test_bit(PG_dcache_dirty, &folio->flags)) {
+		while (nr--)
+			flush_kernel_dcache_page_addr(pfn_va(pfn + nr));
+		clear_bit(PG_dcache_dirty, &folio->flags);
 	} else if (parisc_requires_coherency())
-		flush_kernel_dcache_page_addr(pfn_va(pfn));
+		while (nr--)
+			flush_kernel_dcache_page_addr(pfn_va(pfn + nr));
 }
 
 void
@@ -366,6 +370,20 @@ static void flush_user_cache_page(struct vm_area_struct *vma, unsigned long vmad
 	preempt_enable();
 }
 
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr)
+{
+	void *kaddr = page_address(page);
+
+	for (;;) {
+		flush_kernel_dcache_page_addr(kaddr);
+		flush_kernel_icache_page(kaddr);
+		if (--nr == 0)
+			break;
+		kaddr += PAGE_SIZE;
+	}
+}
+
 static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *ptep = NULL;
@@ -394,27 +412,30 @@ static inline bool pte_needs_flush(pte_t pte)
 		== (_PAGE_PRESENT | _PAGE_ACCESSED);
 }
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping_file(page);
-	struct vm_area_struct *mpnt;
-	unsigned long offset;
+	struct address_space *mapping = folio_flush_mapping(folio);
+	struct vm_area_struct *vma;
 	unsigned long addr, old_addr = 0;
+	void *kaddr;
 	unsigned long count = 0;
-	unsigned long flags;
+	unsigned long i, nr, flags;
 	pgoff_t pgoff;
 
 	if (mapping && !mapping_mapped(mapping)) {
-		set_bit(PG_dcache_dirty, &page->flags);
+		set_bit(PG_dcache_dirty, &folio->flags);
 		return;
 	}
 
-	flush_kernel_dcache_page_addr(page_address(page));
+	nr = folio_nr_pages(folio);
+	kaddr = folio_address(folio);
+	for (i = 0; i < nr; i++)
+		flush_kernel_dcache_page_addr(kaddr + i * PAGE_SIZE);
 
 	if (!mapping)
 		return;
 
-	pgoff = page->index;
+	pgoff = folio->index;
 
 	/*
 	 * We have carefully arranged in arch_get_unmapped_area() that
@@ -424,20 +445,33 @@ void flush_dcache_page(struct page *page)
 	 * on machines that support equivalent aliasing
 	 */
 	flush_dcache_mmap_lock_irqsave(mapping, flags);
-	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
-		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		addr = mpnt->vm_start + offset;
-		if (parisc_requires_coherency()) {
-			bool needs_flush = false;
-			pte_t *ptep;
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + nr - 1) {
+		unsigned long offset = pgoff - vma->vm_pgoff;
+		unsigned long pfn = folio_pfn(folio);
+
+		addr = vma->vm_start;
+		nr = folio_nr_pages(folio);
+		if (offset > -nr) {
+			pfn -= offset;
+			nr += offset;
+		} else {
+			addr += offset * PAGE_SIZE;
+		}
+		if (addr + nr * PAGE_SIZE > vma->vm_end)
+			nr = (vma->vm_end - addr) / PAGE_SIZE;
 
-			ptep = get_ptep(mpnt->vm_mm, addr);
-			if (ptep) {
-				needs_flush = pte_needs_flush(*ptep);
+		if (parisc_requires_coherency()) {
+			for (i = 0; i < nr; i++) {
+				pte_t *ptep = get_ptep(vma->vm_mm,
+							addr + i * PAGE_SIZE);
+				if (!ptep)
+					continue;
+				if (pte_needs_flush(*ptep))
+					flush_user_cache_page(vma,
+							addr + i * PAGE_SIZE);
+				/* Optimise accesses to the same table? */
 				pte_unmap(ptep);
 			}
-			if (needs_flush)
-				flush_user_cache_page(mpnt, addr);
 		} else {
 			/*
 			 * The TLB is the engine of coherence on parisc:
@@ -450,27 +484,32 @@ void flush_dcache_page(struct page *page)
 			 * in (until the user or kernel specifically
 			 * accesses it, of course)
 			 */
-			flush_tlb_page(mpnt, addr);
+			for (i = 0; i < nr; i++)
+				flush_tlb_page(vma, addr + i * PAGE_SIZE);
 			if (old_addr == 0 || (old_addr & (SHM_COLOUR - 1))
 					!= (addr & (SHM_COLOUR - 1))) {
-				__flush_cache_page(mpnt, addr, page_to_phys(page));
+				for (i = 0; i < nr; i++)
+					__flush_cache_page(vma,
+						addr + i * PAGE_SIZE,
+						(pfn + i) * PAGE_SIZE);
 				/*
 				 * Software is allowed to have any number
 				 * of private mappings to a page.
 				 */
-				if (!(mpnt->vm_flags & VM_SHARED))
+				if (!(vma->vm_flags & VM_SHARED))
 					continue;
 				if (old_addr)
 					pr_err("INEQUIVALENT ALIASES 0x%lx and 0x%lx in file %pD\n",
-						old_addr, addr, mpnt->vm_file);
-				old_addr = addr;
+						old_addr, addr, vma->vm_file);
+				if (nr == folio_nr_pages(folio))
+					old_addr = addr;
 			}
 		}
 		WARN_ON(++count == 4096);
 	}
 	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
 
 /* Defined in arch/parisc/kernel/pacache.S */
 EXPORT_SYMBOL(flush_kernel_dcache_range_asm);
-- 
2.40.1

