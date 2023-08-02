Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13376D143
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjHBPOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FE72D63;
        Wed,  2 Aug 2023 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VNpFvvJuxNncni/NZj8MqUaBRQkp6jW1k1zH+muyRMk=; b=noGvCnhS9S4mgWHMRm9TXvx40M
        TCeYeWtmyAT9uWLfWJpesadFa0pXWjz2gE4OdZD8eTAypBDZqw2iKRpqTjIDZ2avPr0EULQzAyrMz
        7bZoL+hXe9Vo93OQj3Ibqe49WWSrxBLT5EMQDTDTSDEZRYIiQHaqnznlVh8bUNDuv205uuSvqY2fS
        6kfggKqXVAhQNd4ztc+q6VCyzpJgwellAvJFm0b2AGFrhU66ESrhJ8d9BEnP05Mkg1Nf9Nhlb+5gp
        z/gnJSLlCGOQQpRSDrZmSty7pBGapaY4WiqyyO6OoAnkGkzw4qFMNjbfufjGXEz6qLpe/zdpo8SDS
        e17P3+Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY9-00Ffj7-05; Wed, 02 Aug 2023 15:14:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH v6 11/38] csky: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:39 +0100
Message-Id: <20230802151406.3735276-12-willy@infradead.org>
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

Add PFN_PTE_SHIFT, update_mmu_cache_range() and flush_dcache_folio().
Change the PG_dcache_clean flag from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/abiv1/cacheflush.c         | 32 +++++++++++++++++-----------
 arch/csky/abiv1/inc/abi/cacheflush.h |  2 ++
 arch/csky/abiv2/cacheflush.c         | 32 ++++++++++++++--------------
 arch/csky/abiv2/inc/abi/cacheflush.h | 10 +++++++--
 arch/csky/include/asm/pgtable.h      |  8 ++++---
 5 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index 94fbc03cbe70..171e8fb32285 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -15,45 +15,51 @@
 
 #define PG_dcache_clean		PG_arch_1
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(folio_pfn(folio)))
 		return;
 
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 
-	if (mapping && !page_mapcount(page))
-		clear_bit(PG_dcache_clean, &page->flags);
+	if (mapping && !folio_mapped(folio))
+		clear_bit(PG_dcache_clean, &folio->flags);
 	else {
 		dcache_wbinv_all();
 		if (mapping)
 			icache_inv_all();
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
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-	pte_t *ptep)
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	unsigned long pfn = pte_pfn(*ptep);
-	struct page *page;
+	struct folio *folio;
 
 	flush_tlb_page(vma, addr);
 
 	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pfn);
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(pfn))
 		return;
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+	folio = page_folio(pfn_to_page(pfn));
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
 		dcache_wbinv_all();
 
-	if (page_mapping_file(page)) {
+	if (folio_flush_mapping(folio)) {
 		if (vma->vm_flags & VM_EXEC)
 			icache_inv_all();
 	}
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index ed62e2066ba7..0d6cb65624c4 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -9,6 +9,8 @@
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *);
+#define flush_dcache_folio flush_dcache_folio
 
 #define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 9923cd24db58..d05a551af5d5 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -7,32 +7,32 @@
 #include <asm/cache.h>
 #include <asm/tlbflush.h>
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *pte)
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *pte, unsigned int nr)
 {
-	unsigned long addr;
-	struct page *page;
+	unsigned long pfn = pte_pfn(*pte);
+	struct folio *folio;
+	unsigned int i;
 
 	flush_tlb_page(vma, address);
 
-	if (!pfn_valid(pte_pfn(*pte)))
+	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pte_pfn(*pte));
-	if (page == ZERO_PAGE(0))
-		return;
+	folio = page_folio(pfn_to_page(pfn));
 
-	if (test_and_set_bit(PG_dcache_clean, &page->flags))
+	if (test_and_set_bit(PG_dcache_clean, &folio->flags))
 		return;
 
-	addr = (unsigned long) kmap_atomic(page);
-
-	dcache_wb_range(addr, addr + PAGE_SIZE);
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		unsigned long addr = (unsigned long) kmap_local_folio(folio,
+								i * PAGE_SIZE);
 
-	if (vma->vm_flags & VM_EXEC)
-		icache_inv_range(addr, addr + PAGE_SIZE);
-
-	kunmap_atomic((void *) addr);
+		dcache_wb_range(addr, addr + PAGE_SIZE);
+		if (vma->vm_flags & VM_EXEC)
+			icache_inv_range(addr, addr + PAGE_SIZE);
+		kunmap_local((void *) addr);
+	}
 }
 
 void flush_icache_deferred(struct mm_struct *mm)
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index a565e00c3f70..9c728933a776 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -18,11 +18,17 @@
 
 #define PG_dcache_clean		PG_arch_1
 
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	if (test_bit(PG_dcache_clean, &folio->flags))
+		clear_bit(PG_dcache_clean, &folio->flags);
+}
+#define flush_dcache_folio flush_dcache_folio
+
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
 {
-	if (test_bit(PG_dcache_clean, &page->flags))
-		clear_bit(PG_dcache_clean, &page->flags);
+	flush_dcache_folio(page_folio(page));
 }
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index d4042495febc..42405037c871 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -28,6 +28,7 @@
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#define PFN_PTE_SHIFT	PAGE_SHIFT
 #define pmd_pfn(pmd)	(pmd_phys(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
@@ -90,7 +91,6 @@ static inline void set_pte(pte_t *p, pte_t pte)
 	/* prevent out of order excution */
 	smp_mb();
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
@@ -263,8 +263,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init(void);
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *pte);
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *pte, unsigned int nr);
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
 	remap_pfn_range(vma, vaddr, pfn, size, prot)
-- 
2.40.1

