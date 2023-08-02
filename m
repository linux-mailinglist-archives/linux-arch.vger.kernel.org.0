Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617976D14A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHBPO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40110EA;
        Wed,  2 Aug 2023 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dN6TKlj9sMiRY0mz1iXvxydzplvaifkpqpAhfj55T04=; b=ohWPgQCCUdv/0jA4AADtiTMs71
        Cl66u8vu9i1UyyvrzJNP+agvituxFg3uyC6RWrHOgM6aYeOKzZT7BXKXiVq1Ewf7Eo6bp2ChOJzBi
        HbTeL4ephEJLM3ecBws7B2Le4Z/BjYwlqEdcqhtb4IpM0navdkUL1/yfkv8DUySFX5dKScNlGHVhI
        lDDsHC0RbuHOPO6VU5IKbdm69wdpNMxvYK5RCtzrMc5paeFo+Ba20sJzmQoyjaCA/x7MJO4fBymeH
        gwoClQN3HvtMSaIS0znAmt8KNv7FC+MN0rIC+LtJoZ1OQR8UYdvIQxsY53U+Zq1L8FfNu0V2iOxkS
        P6wo720w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffit-MR; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v6 08/38] arc: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:36 +0100
Message-Id: <20230802151406.3735276-9-willy@infradead.org>
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

Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_dcache_folio()
and flush_icache_pages().

Change the PG_dc_clean flag from being per-page to per-folio (which
means it cannot always be set as we don't know that all pages in this
folio were cleaned).  Enhance the internal flush routines to take the
number of pages to flush.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/cacheflush.h         |  7 ++-
 arch/arc/include/asm/pgtable-bits-arcv2.h | 12 ++---
 arch/arc/include/asm/pgtable-levels.h     |  1 +
 arch/arc/mm/cache.c                       | 61 ++++++++++++++---------
 arch/arc/mm/tlb.c                         | 18 ++++---
 5 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index e201b4b1655a..04f65f588510 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -25,17 +25,20 @@
  * in update_mmu_cache()
  */
 #define flush_icache_page(vma, page)
+#define flush_icache_pages(vma, page, nr)
 
 void flush_cache_all(void);
 
 void flush_icache_range(unsigned long kstart, unsigned long kend);
 void __sync_icache_dcache(phys_addr_t paddr, unsigned long vaddr, int len);
-void __inv_icache_page(phys_addr_t paddr, unsigned long vaddr);
-void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr);
+void __inv_icache_pages(phys_addr_t paddr, unsigned long vaddr, unsigned nr);
+void __flush_dcache_pages(phys_addr_t paddr, unsigned long vaddr, unsigned nr);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
 void flush_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
 
 void dma_cache_wback_inv(phys_addr_t start, unsigned long sz);
 void dma_cache_inv(phys_addr_t start, unsigned long sz);
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 6e9f8ca6d6a1..ee78ab30958d 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -100,14 +100,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
-{
-	set_pte(ptep, pteval);
-}
+struct vm_fault;
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr);
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *ptep);
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index ef68758b69f7..fc417c75c24d 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -169,6 +169,7 @@
 #define pte_ERROR(e) \
 	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_none(x)		(!pte_val(x))
 #define pte_present(x)		(pte_val(x) & _PAGE_PRESENT)
 #define pte_clear(mm,addr,ptep)	set_pte_at(mm, addr, ptep, __pte(0))
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 55c6de138eae..3c16ee942a5c 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -752,17 +752,17 @@ static inline void arc_slc_enable(void)
  * There's a corollary case, where kernel READs from a userspace mapped page.
  * If the U-mapping is not congruent to K-mapping, former needs flushing.
  */
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
 	struct address_space *mapping;
 
 	if (!cache_is_vipt_aliasing()) {
-		clear_bit(PG_dc_clean, &page->flags);
+		clear_bit(PG_dc_clean, &folio->flags);
 		return;
 	}
 
 	/* don't handle anon pages here */
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 	if (!mapping)
 		return;
 
@@ -771,17 +771,27 @@ void flush_dcache_page(struct page *page)
 	 * Make a note that K-mapping is dirty
 	 */
 	if (!mapping_mapped(mapping)) {
-		clear_bit(PG_dc_clean, &page->flags);
-	} else if (page_mapcount(page)) {
-
+		clear_bit(PG_dc_clean, &folio->flags);
+	} else if (folio_mapped(folio)) {
 		/* kernel reading from page with U-mapping */
-		phys_addr_t paddr = (unsigned long)page_address(page);
-		unsigned long vaddr = page->index << PAGE_SHIFT;
+		phys_addr_t paddr = (unsigned long)folio_address(folio);
+		unsigned long vaddr = folio_pos(folio);
 
+		/*
+		 * vaddr is not actually the virtual address, but is
+		 * congruent to every user mapping.
+		 */
 		if (addr_not_cache_congruent(paddr, vaddr))
-			__flush_dcache_page(paddr, vaddr);
+			__flush_dcache_pages(paddr, vaddr,
+						folio_nr_pages(folio));
 	}
 }
+EXPORT_SYMBOL(flush_dcache_folio);
+
+void flush_dcache_page(struct page *page)
+{
+	return flush_dcache_folio(page_folio(page));
+}
 EXPORT_SYMBOL(flush_dcache_page);
 
 /*
@@ -921,18 +931,18 @@ void __sync_icache_dcache(phys_addr_t paddr, unsigned long vaddr, int len)
 }
 
 /* wrapper to compile time eliminate alignment checks in flush loop */
-void __inv_icache_page(phys_addr_t paddr, unsigned long vaddr)
+void __inv_icache_pages(phys_addr_t paddr, unsigned long vaddr, unsigned nr)
 {
-	__ic_line_inv_vaddr(paddr, vaddr, PAGE_SIZE);
+	__ic_line_inv_vaddr(paddr, vaddr, nr * PAGE_SIZE);
 }
 
 /*
  * wrapper to clearout kernel or userspace mappings of a page
  * For kernel mappings @vaddr == @paddr
  */
-void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)
+void __flush_dcache_pages(phys_addr_t paddr, unsigned long vaddr, unsigned nr)
 {
-	__dc_line_op(paddr, vaddr & PAGE_MASK, PAGE_SIZE, OP_FLUSH_N_INV);
+	__dc_line_op(paddr, vaddr & PAGE_MASK, nr * PAGE_SIZE, OP_FLUSH_N_INV);
 }
 
 noinline void flush_cache_all(void)
@@ -962,10 +972,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,
 
 	u_vaddr &= PAGE_MASK;
 
-	__flush_dcache_page(paddr, u_vaddr);
+	__flush_dcache_pages(paddr, u_vaddr, 1);
 
 	if (vma->vm_flags & VM_EXEC)
-		__inv_icache_page(paddr, u_vaddr);
+		__inv_icache_pages(paddr, u_vaddr, 1);
 }
 
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
@@ -978,9 +988,9 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page,
 		     unsigned long u_vaddr)
 {
 	/* TBD: do we really need to clear the kernel mapping */
-	__flush_dcache_page((phys_addr_t)page_address(page), u_vaddr);
-	__flush_dcache_page((phys_addr_t)page_address(page),
-			    (phys_addr_t)page_address(page));
+	__flush_dcache_pages((phys_addr_t)page_address(page), u_vaddr, 1);
+	__flush_dcache_pages((phys_addr_t)page_address(page),
+			    (phys_addr_t)page_address(page), 1);
 
 }
 
@@ -989,6 +999,8 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page,
 void copy_user_highpage(struct page *to, struct page *from,
 	unsigned long u_vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
+	struct folio *dst = page_folio(to);
 	void *kfrom = kmap_atomic(from);
 	void *kto = kmap_atomic(to);
 	int clean_src_k_mappings = 0;
@@ -1005,7 +1017,7 @@ void copy_user_highpage(struct page *to, struct page *from,
 	 * addr_not_cache_congruent() is 0
 	 */
 	if (page_mapcount(from) && addr_not_cache_congruent(kfrom, u_vaddr)) {
-		__flush_dcache_page((unsigned long)kfrom, u_vaddr);
+		__flush_dcache_pages((unsigned long)kfrom, u_vaddr, 1);
 		clean_src_k_mappings = 1;
 	}
 
@@ -1019,17 +1031,17 @@ void copy_user_highpage(struct page *to, struct page *from,
 	 * non copied user pages (e.g. read faults which wire in pagecache page
 	 * directly).
 	 */
-	clear_bit(PG_dc_clean, &to->flags);
+	clear_bit(PG_dc_clean, &dst->flags);
 
 	/*
 	 * if SRC was already usermapped and non-congruent to kernel mapping
 	 * sync the kernel mapping back to physical page
 	 */
 	if (clean_src_k_mappings) {
-		__flush_dcache_page((unsigned long)kfrom, (unsigned long)kfrom);
-		set_bit(PG_dc_clean, &from->flags);
+		__flush_dcache_pages((unsigned long)kfrom,
+					(unsigned long)kfrom, 1);
 	} else {
-		clear_bit(PG_dc_clean, &from->flags);
+		clear_bit(PG_dc_clean, &src->flags);
 	}
 
 	kunmap_atomic(kto);
@@ -1038,8 +1050,9 @@ void copy_user_highpage(struct page *to, struct page *from,
 
 void clear_user_page(void *to, unsigned long u_vaddr, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	clear_page(to);
-	clear_bit(PG_dc_clean, &page->flags);
+	clear_bit(PG_dc_clean, &folio->flags);
 }
 EXPORT_SYMBOL(clear_user_page);
 
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 5f71445f26bd..6f40f37e6550 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -467,8 +467,8 @@ void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
  * Note that flush (when done) involves both WBACK - so physical page is
  * in sync as well as INV - so any non-congruent aliases don't remain
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr_unaligned,
-		      pte_t *ptep)
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long vaddr_unaligned, pte_t *ptep, unsigned int nr)
 {
 	unsigned long vaddr = vaddr_unaligned & PAGE_MASK;
 	phys_addr_t paddr = pte_val(*ptep) & PAGE_MASK_PHYS;
@@ -491,15 +491,19 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr_unaligned,
 	 */
 	if ((vma->vm_flags & VM_EXEC) ||
 	     addr_not_cache_congruent(paddr, vaddr)) {
-
-		int dirty = !test_and_set_bit(PG_dc_clean, &page->flags);
+		struct folio *folio = page_folio(page);
+		int dirty = !test_and_set_bit(PG_dc_clean, &folio->flags);
 		if (dirty) {
+			unsigned long offset = offset_in_folio(folio, paddr);
+			nr = folio_nr_pages(folio);
+			paddr -= offset;
+			vaddr -= offset;
 			/* wback + inv dcache lines (K-mapping) */
-			__flush_dcache_page(paddr, paddr);
+			__flush_dcache_pages(paddr, paddr, nr);
 
 			/* invalidate any existing icache lines (U-mapping) */
 			if (vma->vm_flags & VM_EXEC)
-				__inv_icache_page(paddr, vaddr);
+				__inv_icache_pages(paddr, vaddr, nr);
 		}
 	}
 }
@@ -531,7 +535,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 				 pmd_t *pmd)
 {
 	pte_t pte = __pte(pmd_val(*pmd));
-	update_mmu_cache(vma, addr, &pte);
+	update_mmu_cache_range(NULL, vma, addr, &pte, HPAGE_PMD_NR);
 }
 
 void local_flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.40.1

