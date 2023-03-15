Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883F6BA6A8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCOFPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCOFPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383125B9D;
        Tue, 14 Mar 2023 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u7otEQw0drUncgREmlSs4Hr4la1Rulf+32AXxHFo/oI=; b=vJinA88ZRxgb83sfXWCSnbOI/6
        nlXdQ3RerziKOmizgXaq3IAhFcsCLehGop592Wf3RQpHVJdreA/c/t78ENF4YUkjqmryDMRXFvDUK
        VkARHWGsl/03/0AgiGHT1K4LdeAoeT9Hhp8uAObzm62xgtr7fRXWXeNwi/8nIZnX99J/Ye00i4/Fn
        wi8vHT9WPqCwuYBsYOl+G191vCuIr03Zkp8JlyY1GiaZ4GF+g7Hqyw+2f1hzWGlw4+rPruor3p8ko
        pdCXWQPBAGs2yBfSkjfJu3tiupgkkY8cmW/Y9pFAnfncae0KGmYYVxwxywGzCRBPLKKlN/Ns2O/Lj
        TL1y9Y6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTM-00DYBq-1G; Wed, 15 Mar 2023 05:14:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 14/36] m68k: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:22 +0000
Message-Id: <20230315051444.3229621-15-willy@infradead.org>
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

Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_icache_pages() and
flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/include/asm/cacheflush_mm.h    | 27 ++++++++++++++++--------
 arch/m68k/include/asm/mcf_pgtable.h      |  1 +
 arch/m68k/include/asm/motorola_pgtable.h |  1 +
 arch/m68k/include/asm/pgtable_mm.h       |  9 ++++----
 arch/m68k/include/asm/sun3_pgtable.h     |  1 +
 arch/m68k/mm/motorola.c                  |  2 +-
 6 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 1ac55e7b47f0..88eb85e81ef6 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -220,24 +220,29 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
 
 /* Push the page at kernel virtual address and clear the icache */
 /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-static inline void __flush_page_to_ram(void *vaddr)
+static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
 {
 	if (CPU_IS_COLDFIRE) {
 		unsigned long addr, start, end;
 		addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
 		start = addr & ICACHE_SET_MASK;
-		end = (addr + PAGE_SIZE - 1) & ICACHE_SET_MASK;
+		end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
 		if (start > end) {
 			flush_cf_bcache(0, end);
 			end = ICACHE_MAX_ADDR;
 		}
 		flush_cf_bcache(start, end);
 	} else if (CPU_IS_040_OR_060) {
-		__asm__ __volatile__("nop\n\t"
-				     ".chip 68040\n\t"
-				     "cpushp %%bc,(%0)\n\t"
-				     ".chip 68k"
-				     : : "a" (__pa(vaddr)));
+		unsigned long paddr = __pa(vaddr);
+
+		do {
+			__asm__ __volatile__("nop\n\t"
+					     ".chip 68040\n\t"
+					     "cpushp %%bc,(%0)\n\t"
+					     ".chip 68k"
+					     : : "a" (paddr));
+			paddr += PAGE_SIZE;
+		} while (--nr);
 	} else {
 		unsigned long _tmp;
 		__asm__ __volatile__("movec %%cacr,%0\n\t"
@@ -249,10 +254,14 @@ static inline void __flush_page_to_ram(void *vaddr)
 }
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-#define flush_dcache_page(page)		__flush_page_to_ram(page_address(page))
+#define flush_dcache_page(page)	__flush_pages_to_ram(page_address(page), 1)
+#define flush_dcache_folio(folio)		\
+	__flush_pages_to_ram(folio_address(folio), folio_nr_pages(folio))
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
+#define flush_icache_pages(vma, page, nr)	\
+	__flush_pages_to_ram(page_address(page), nr)
+#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
 
 extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 				    unsigned long addr, int len);
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 13741c1245e1..1414b607eff4 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -292,6 +292,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index ec0dc19ab834..38d5e5edc3e1 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -112,6 +112,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 #define pte_present(pte)	(pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(mm,addr,ptep)		({ pte_val(*(ptep)) = 0; })
 
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_page(pte)		virt_to_page(__va(pte_val(pte)))
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index b93c41fe2067..8c2db20abdb6 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -31,8 +31,6 @@
 	do{							\
 		*(pteptr) = (pteval);				\
 	} while(0)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #if CONFIG_PGTABLE_LEVELS == 3
@@ -138,11 +136,14 @@ extern void kernel_set_cachemode(void *addr, unsigned long size, int cmode);
  * tables contain all the necessary information.  The Sun3 does, but
  * they are updated on demand.
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-				    unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
+
 #endif /* !__ASSEMBLY__ */
 
 /* MMU-specific headers */
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index e582b0484a55..feae73b3b342 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -105,6 +105,7 @@ static inline void pte_clear (struct mm_struct *mm, unsigned long addr, pte_t *p
 	pte_val (*ptep) = 0;
 }
 
+#define PFN_PTE_SHIFT		0
 #define pte_pfn(pte)            (pte_val(pte) & SUN3_PAGE_PGNUM_MASK)
 #define pfn_pte(pfn, pgprot) \
 ({ pte_t __pte; pte_val(__pte) = pfn | pgprot_val(pgprot); __pte; })
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 911301224078..790666c6d146 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -81,7 +81,7 @@ static inline void cache_page(void *vaddr)
 
 void mmu_page_ctor(void *page)
 {
-	__flush_page_to_ram(page);
+	__flush_pages_to_ram(page, 1);
 	flush_tlb_kernel_page(page);
 	nocache_page(page);
 }
-- 
2.39.2

