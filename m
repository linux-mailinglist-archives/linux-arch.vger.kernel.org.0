Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BC6BA6A1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCOFPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCOFOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E2231FD;
        Tue, 14 Mar 2023 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4pf/rLft+uZgd6JDRs5O+Xa8ZHam0KkL1tl8wFZFlZk=; b=cf+tbcgA7nZNIVAuMabdqjl6VU
        F5KZvf8zJ+HKhlelPGfge4a8lxHFrx76gg7vi5JO7EEDZXRnP+Z9NBhRNnMC4CaHY1TAicWGG/kdb
        5uyAK7J8ZfRNMeVfR1ImsPMfnGNs/iaODI8VVJvU0tioNwVM72nOtg/EhCnBo7te4Wjn1wlcmHIel
        4Rd74dCa26lGODfVfEiQB2pxIYQpcuAYkI9gSy7+EaezwJD0swkW6gWR9RVWVqPBAF4Y3RUUil4ky
        B5aWaCvP2rYuJu+m7dEIuLvZEgh3yrakeOLBArHKNip9eyO02qUAiIcwFIzf/w0wvj0nin63z49St
        sP2Krppg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTL-00DYBe-Pc; Wed, 15 Mar 2023 05:14:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Subject: [PATCH v4 12/36] ia64: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:20 +0000
Message-Id: <20230315051444.3229621-13-willy@infradead.org>
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

Add PFN_PTE_SHIFT, update_mmu_cache_range() and flush_dcache_folio().
Change the PG_arch_1 (aka PG_dcache_clean) flag from being per-page to
per-folio, which makes arch_dma_mark_clean() and mark_clean() a little
more exciting.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/hp/common/sba_iommu.c    | 26 +++++++++++++++-----------
 arch/ia64/include/asm/cacheflush.h | 14 ++++++++++----
 arch/ia64/include/asm/pgtable.h    |  4 ++--
 arch/ia64/mm/init.c                | 28 +++++++++++++++++++---------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 8ad6946521d8..48d475f10003 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -798,22 +798,26 @@ sba_io_pdir_entry(u64 *pdir_ptr, unsigned long vba)
 #endif
 
 #ifdef ENABLE_MARK_CLEAN
-/**
+/*
  * Since DMA is i-cache coherent, any (complete) pages that were written via
  * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
  * flush them when they get mapped into an executable vm-area.
  */
-static void
-mark_clean (void *addr, size_t size)
+static void mark_clean(void *addr, size_t size)
 {
-	unsigned long pg_addr, end;
-
-	pg_addr = PAGE_ALIGN((unsigned long) addr);
-	end = (unsigned long) addr + size;
-	while (pg_addr + PAGE_SIZE <= end) {
-		struct page *page = virt_to_page((void *)pg_addr);
-		set_bit(PG_arch_1, &page->flags);
-		pg_addr += PAGE_SIZE;
+	struct folio *folio = virt_to_folio(addr);
+	ssize_t left = size;
+	size_t offset = offset_in_folio(folio, addr);
+
+	if (offset) {
+		left -= folio_size(folio) - offset;
+		folio = folio_next(folio);
+	}
+
+	while (left >= folio_size(folio)) {
+		set_bit(PG_arch_1, &folio->flags);
+		left -= folio_size(folio);
+		folio = folio_next(folio);
 	}
 }
 #endif
diff --git a/arch/ia64/include/asm/cacheflush.h b/arch/ia64/include/asm/cacheflush.h
index 708c0fa5d975..eac493fa9e0d 100644
--- a/arch/ia64/include/asm/cacheflush.h
+++ b/arch/ia64/include/asm/cacheflush.h
@@ -13,10 +13,16 @@
 #include <asm/page.h>
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-#define flush_dcache_page(page)			\
-do {						\
-	clear_bit(PG_arch_1, &(page)->flags);	\
-} while (0)
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	clear_bit(PG_arch_1, &folio->flags);
+}
+#define flush_dcache_folio flush_dcache_folio
+
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 
 extern void flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_range flush_icache_range
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 21c97e31a28a..5450d59e4fb9 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -206,6 +206,7 @@ ia64_phys_addr_valid (unsigned long addr)
 #define RGN_MAP_SHIFT (PGDIR_SHIFT + PTRS_PER_PGD_SHIFT - 3)
 #define RGN_MAP_LIMIT	((1UL << RGN_MAP_SHIFT) - PAGE_SIZE)	/* per region addr limit */
 
+#define PFN_PTE_SHIFT	PAGE_SHIFT
 /*
  * Conversion functions: convert page frame number (pfn) and a protection value to a page
  * table entry (pte).
@@ -303,8 +304,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	*ptep = pteval;
 }
 
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 /*
  * Make page protection values cacheable, uncacheable, or write-
  * combining.  Note that "protection" is really a misnomer here as the
@@ -396,6 +395,7 @@ pte_same (pte_t a, pte_t b)
 	return pte_val(a) == pte_val(b);
 }
 
+#define update_mmu_cache_range(vma, address, ptep, nr) do { } while (0)
 #define update_mmu_cache(vma, address, ptep) do { } while (0)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 7f5353e28516..b95debabdc2a 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -50,30 +50,40 @@ void
 __ia64_sync_icache_dcache (pte_t pte)
 {
 	unsigned long addr;
-	struct page *page;
+	struct folio *folio;
 
-	page = pte_page(pte);
-	addr = (unsigned long) page_address(page);
+	folio = page_folio(pte_page(pte));
+	addr = (unsigned long)folio_address(folio);
 
-	if (test_bit(PG_arch_1, &page->flags))
+	if (test_bit(PG_arch_1, &folio->flags))
 		return;				/* i-cache is already coherent with d-cache */
 
-	flush_icache_range(addr, addr + page_size(page));
-	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
+	flush_icache_range(addr, addr + folio_size(folio));
+	set_bit(PG_arch_1, &folio->flags);	/* mark page as clean */
 }
 
 /*
- * Since DMA is i-cache coherent, any (complete) pages that were written via
+ * Since DMA is i-cache coherent, any (complete) folios that were written via
  * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
  * flush them when they get mapped into an executable vm-area.
  */
 void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
 {
 	unsigned long pfn = PHYS_PFN(paddr);
+	struct folio *folio = page_folio(pfn_to_page(pfn));
+	ssize_t left = size;
+	size_t offset = offset_in_folio(folio, paddr);
 
-	do {
+	if (offset) {
+		left -= folio_size(folio) - offset;
+		folio = folio_next(folio);
+	}
+
+	while (left >= (ssize_t)folio_size(folio)) {
 		set_bit(PG_arch_1, &pfn_to_page(pfn)->flags);
-	} while (++pfn <= PHYS_PFN(paddr + size - 1));
+		left -= folio_size(folio);
+		folio = folio_next(folio);
+	}
 }
 
 inline void
-- 
2.39.2

