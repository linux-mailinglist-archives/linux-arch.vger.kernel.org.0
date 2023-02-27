Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC736A48D1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjB0R6O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjB0R54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:57:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E42449B;
        Mon, 27 Feb 2023 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FcAVSqRhOvKHjYDKfG+YKts/V6VftTlUNnoYvCjS+is=; b=oduE/873LY4TwSZyoAOMOKJOyP
        xXxts9JED1MF554jNMWSsOvEsnO0EYuncvAN9hjmrTJayQ7UIXPyYXZZKT6a79DJGzELdLksphJDy
        5W+dTaVULNh+n0yLtuQvxjwgSn7gdjgmj0Q1dgtw79FhvhrjJC9yanZ7AOlHIUwnAkl1C1xUDWAqp
        C8nv7A4sS7Jx43txb8g3DOXFYnsd7dEhPX+y8Vu96gdfUu6Yd32TcgZ2nUR7DQ+u7Fp6rV/Z5zVjD
        lImQ23LRH//blmVTQ0btFdu/WJMWymPs+f3H9BABVs/jMbMwtxdJHobktTIBKoL+BbMDepenzzCAr
        CBDR2xng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkw-000IYf-EB; Mon, 27 Feb 2023 17:57:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 26/30] xtensa: Implement the new page table range API
Date:   Mon, 27 Feb 2023 17:57:37 +0000
Message-Id: <20230227175741.71216-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
flush_icache_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/include/asm/cacheflush.h |  9 ++-
 arch/xtensa/include/asm/pgtable.h    | 24 +++++---
 arch/xtensa/mm/cache.c               | 83 ++++++++++++++++------------
 3 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 7b4359312c25..35153f6725e4 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -119,8 +119,14 @@ void flush_cache_page(struct vm_area_struct*,
 #define flush_cache_vmap(start,end)	flush_cache_all()
 #define flush_cache_vunmap(start,end)	flush_cache_all()
 
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
+
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *);
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 
 void local_flush_cache_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
@@ -156,6 +162,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 
 /* This is not required, see Documentation/core-api/cachetlb.rst */
 #define	flush_icache_page(vma,page)			do { } while (0)
+#define	flush_icache_pages(vma, page, nr)		do { } while (0)
 
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index fc7a14884c6c..293101530541 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -301,17 +301,25 @@ static inline void update_pte(pte_t *ptep, pte_t pteval)
 
 struct mm_struct;
 
-static inline void
-set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pteval)
+static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	update_pte(ptep, pteval);
+	update_pte(ptep, pte);
 }
 
-static inline void set_pte(pte_t *ptep, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	update_pte(ptep, pteval);
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+
 static inline void
 set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
@@ -407,8 +415,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 
 #else
 
-extern  void update_mmu_cache(struct vm_area_struct * vma,
-			      unsigned long address, pte_t *ptep);
+void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr);
+#define update_mmu_cache(vma, address, ptep) \
+	update_mmu_cache_range(vma, address, ptep, 1)
 
 typedef pte_t *pte_addr_t;
 
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index 19e5a478a7e8..65c0d5298041 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -121,9 +121,9 @@ EXPORT_SYMBOL(copy_user_highpage);
  *
  */
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping_file(page);
+	struct address_space *mapping = folio_flush_mapping(folio);
 
 	/*
 	 * If we have a mapping but the page is not mapped to user-space
@@ -132,14 +132,14 @@ void flush_dcache_page(struct page *page)
 	 */
 
 	if (mapping && !mapping_mapped(mapping)) {
-		if (!test_bit(PG_arch_1, &page->flags))
-			set_bit(PG_arch_1, &page->flags);
+		if (!test_bit(PG_arch_1, &folio->flags))
+			set_bit(PG_arch_1, &folio->flags);
 		return;
 
 	} else {
-
-		unsigned long phys = page_to_phys(page);
-		unsigned long temp = page->index << PAGE_SHIFT;
+		unsigned long phys = folio_pfn(folio) * PAGE_SIZE;
+		unsigned long temp = folio_pos(folio);
+		unsigned int i, nr = folio_nr_pages(folio);
 		unsigned long alias = !(DCACHE_ALIAS_EQ(temp, phys));
 		unsigned long virt;
 
@@ -154,22 +154,26 @@ void flush_dcache_page(struct page *page)
 			return;
 
 		preempt_disable();
-		virt = TLBTEMP_BASE_1 + (phys & DCACHE_ALIAS_MASK);
-		__flush_invalidate_dcache_page_alias(virt, phys);
+		for (i = 0; i < nr; i++) {
+			virt = TLBTEMP_BASE_1 + (phys & DCACHE_ALIAS_MASK);
+			__flush_invalidate_dcache_page_alias(virt, phys);
 
-		virt = TLBTEMP_BASE_1 + (temp & DCACHE_ALIAS_MASK);
+			virt = TLBTEMP_BASE_1 + (temp & DCACHE_ALIAS_MASK);
 
-		if (alias)
-			__flush_invalidate_dcache_page_alias(virt, phys);
+			if (alias)
+				__flush_invalidate_dcache_page_alias(virt, phys);
 
-		if (mapping)
-			__invalidate_icache_page_alias(virt, phys);
+			if (mapping)
+				__invalidate_icache_page_alias(virt, phys);
+			phys += PAGE_SIZE;
+			temp += PAGE_SIZE;
+		}
 		preempt_enable();
 	}
 
 	/* There shouldn't be an entry in the cache for this page anymore. */
 }
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
 
 /*
  * For now, flush the whole cache. FIXME??
@@ -207,45 +211,52 @@ EXPORT_SYMBOL(local_flush_cache_page);
 
 #endif /* DCACHE_WAY_SIZE > PAGE_SIZE */
 
-void
-update_mmu_cache(struct vm_area_struct * vma, unsigned long addr, pte_t *ptep)
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
 {
 	unsigned long pfn = pte_pfn(*ptep);
-	struct page *page;
+	struct folio *folio;
+	unsigned int i;
 
 	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pfn);
+	folio = page_folio(pfn_to_page(pfn));
 
-	/* Invalidate old entry in TLBs */
-
-	flush_tlb_page(vma, addr);
+	/* Invalidate old entries in TLBs */
+	for (i = 0; i < nr; i++)
+		flush_tlb_page(vma, addr + i * PAGE_SIZE);
+	nr = folio_nr_pages(folio);
 
 #if (DCACHE_WAY_SIZE > PAGE_SIZE)
 
-	if (!PageReserved(page) && test_bit(PG_arch_1, &page->flags)) {
-		unsigned long phys = page_to_phys(page);
+	if (!folio_test_reserved(folio) && test_bit(PG_arch_1, &folio->flags)) {
+		unsigned long phys = folio_pfn(folio) * PAGE_SIZE;
 		unsigned long tmp;
 
 		preempt_disable();
-		tmp = TLBTEMP_BASE_1 + (phys & DCACHE_ALIAS_MASK);
-		__flush_invalidate_dcache_page_alias(tmp, phys);
-		tmp = TLBTEMP_BASE_1 + (addr & DCACHE_ALIAS_MASK);
-		__flush_invalidate_dcache_page_alias(tmp, phys);
-		__invalidate_icache_page_alias(tmp, phys);
+		for (i = 0; i < nr; i++) {
+			tmp = TLBTEMP_BASE_1 + (phys & DCACHE_ALIAS_MASK);
+			__flush_invalidate_dcache_page_alias(tmp, phys);
+			tmp = TLBTEMP_BASE_1 + (addr & DCACHE_ALIAS_MASK);
+			__flush_invalidate_dcache_page_alias(tmp, phys);
+			__invalidate_icache_page_alias(tmp, phys);
+			phys += PAGE_SIZE;
+		}
 		preempt_enable();
 
-		clear_bit(PG_arch_1, &page->flags);
+		clear_bit(PG_arch_1, &folio->flags);
 	}
 #else
-	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)
+	if (!folio_test_reserved(folio) && !test_bit(PG_arch_1, &folio->flags)
 	    && (vma->vm_flags & VM_EXEC) != 0) {
-		unsigned long paddr = (unsigned long)kmap_atomic(page);
-		__flush_dcache_page(paddr);
-		__invalidate_icache_page(paddr);
-		set_bit(PG_arch_1, &page->flags);
-		kunmap_atomic((void *)paddr);
+		for (i = 0; i < nr; i++) {
+			void *paddr = kmap_local_folio(folio, i * PAGE_SIZE);
+			__flush_dcache_page((unsigned long)paddr);
+			__invalidate_icache_page((unsigned long)paddr);
+			kunmap_atomic(paddr);
+		}
+		set_bit(PG_arch_1, &folio->flags);
 	}
 #endif
 }
-- 
2.39.1

