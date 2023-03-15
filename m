Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8206BA6AA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCOFPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCOFOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B0234D4;
        Tue, 14 Mar 2023 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Myd/TJquUeBRJJmNm7edaVKXciXbBFqA65N1Zs0hkYU=; b=lLPhB4hhCA92m/nHhAdrTjgLDi
        ljABKmqA9dzFdy6p46XK4Ii84j/CojehkzhLZszJYd+mUB8CckHeBTXjLe3Ot0oeLDpVHw8i4WjZL
        uuiwYDKeg2MSAxhtcNglHAClEhzgm0TZu9W14yZeiLmU56nFhUjM8ogxx1xvggkkF9ekeZLcAZYe7
        qweDJESuH0R/LQbVfXoXXxUFkbXZ37Wd0UTAVmORUIHW7BBZcW3kTcaK9e4R2VB+k6sZZgrJ3ZY37
        Pcst8OKqCnAWTqES8KUlIQDQSUOhaH+MP+ZY9OWWJGGjAb6Pk6bm8jD30tjjeDUHa7+a4oTCEiK68
        o4MeBPvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTM-00DYC0-9L; Wed, 15 Mar 2023 05:14:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 17/36] nios2: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:25 +0000
Message-Id: <20230315051444.3229621-18-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/cacheflush.h |  6 ++-
 arch/nios2/include/asm/pgtable.h    | 28 ++++++++-----
 arch/nios2/mm/cacheflush.c          | 61 ++++++++++++++++-------------
 3 files changed, 58 insertions(+), 37 deletions(-)

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
index 0f5c2564e9f5..4bb5f4dfff82 100644
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
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr);
+
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
 
 #endif /* _ASM_NIOS2_PGTABLE_H */
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 6aa9257c3ede..471485a84b2c 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
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
+void __flush_dcache_folio(struct address_space *mapping, struct folio *folio)
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
+		__flush_dcache_folio(mapping, folio);
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
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
+
+void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
+EXPORT_SYMBOL(flush_dcache_folio);
 
-void update_mmu_cache(struct vm_area_struct *vma,
-		      unsigned long address, pte_t *ptep)
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
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
+	mapping = folio_flush_mapping(folio);
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
+		__flush_dcache_folio(mapping, folio);
 
-	if(mapping)
-	{
-		flush_aliases(mapping, page);
+	if (mapping) {
+		flush_aliases(mapping, folio);
 		if (vma->vm_flags & VM_EXEC)
-			flush_icache_page(vma, page);
+			flush_icache_pages(vma, &folio->page,
+					folio_nr_pages(folio));
 	}
 }
 
-- 
2.39.2

