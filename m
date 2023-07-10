Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1E74DF94
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjGJUpB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjGJUoF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB3E73;
        Mon, 10 Jul 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n5JuGTxMehujF2hW5yjYC2rYcF2MyOBRN8Ek1lm+OQ8=; b=v6vtdEYGO07DAE5iFQ66CUz422
        4gRsIdrkhM465InPQ8/JnqOq0IG7KzUhaCoe3gRmSP4XJCbA1zUml/Y4VS6dAKxZZ4N/5RZjHuN87
        qFAsrNfw7teoWxYTYbZCiF8pFZnjmUgiRCzzjcwDtmgtr8VAUvFeuhmF6ab90f3xCGgsog6KA9feL
        W5DhRN/ugE2aKKCau9+a+puGlTUVZRO+aEhD4bYP+PsCwD2qvvkUWtuFTy9VYMt8pfiQ9Y3V/60BF
        /hxmrNg806AS1AMQX5X5zpKy/CC56VqSPSMoXWpMaWWUUVHCgBTLtfpRRCK/7rtJ4XjW3BA93ABwT
        inAW3qHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjT-00Eupy-NG; Mon, 10 Jul 2023 20:43:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 22/38] riscv: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:23 +0100
Message-Id: <20230710204339.3554919-23-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
Change the PG_dcache_clean flag from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/cacheflush.h | 19 +++++++--------
 arch/riscv/include/asm/pgtable.h    | 38 +++++++++++++++++++----------
 arch/riscv/mm/cacheflush.c          | 13 +++-------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8091b8bf4883..0d8c92c5dfb7 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -15,20 +15,19 @@ static inline void local_flush_icache_all(void)
 
 #define PG_dcache_clean PG_arch_1
 
-static inline void flush_dcache_page(struct page *page)
+static inline void flush_dcache_folio(struct folio *folio)
 {
-	/*
-	 * HugeTLB pages are always fully mapped and only head page will be
-	 * set PG_dcache_clean (see comments in flush_icache_pte()).
-	 */
-	if (PageHuge(page))
-		page = compound_head(page);
-
-	if (test_bit(PG_dcache_clean, &page->flags))
-		clear_bit(PG_dcache_clean, &page->flags);
+	if (test_bit(PG_dcache_clean, &folio->flags))
+		clear_bit(PG_dcache_clean, &folio->flags);
 }
+#define flush_dcache_folio flush_dcache_folio
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
+
 /*
  * RISC-V doesn't have an instruction to flush parts of the instruction cache,
  * so instead we just flush the whole thing.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2137e36595b3..c8f897ed5fd0 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -445,8 +445,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 
 /* Commit new configuration to MMU hardware */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
 {
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
@@ -455,8 +456,11 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
-	local_flush_tlb_page(address);
+	while (nr--)
+		local_flush_tlb_page(address + nr * PAGE_SIZE);
 }
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb update_mmu_cache
@@ -487,8 +491,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 
 void flush_icache_pte(pte_t pte);
 
-static inline void __set_pte_at(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep, pte_t pteval)
+static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
 {
 	if (pte_present(pteval) && pte_exec(pteval))
 		flush_icache_pte(pteval);
@@ -496,17 +499,26 @@ static inline void __set_pte_at(struct mm_struct *mm,
 	set_pte(ptep, pteval);
 }
 
-static inline void set_pte_at(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pteval, unsigned int nr)
 {
-	page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
-	__set_pte_at(mm, addr, ptep, pteval);
+	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
+
+	for (;;) {
+		__set_pte_at(ptep, pteval);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
+	}
 }
+#define set_ptes set_ptes
 
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
-	__set_pte_at(mm, addr, ptep, __pte(0));
+	__set_pte_at(ptep, __pte(0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
@@ -515,7 +527,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 					pte_t entry, int dirty)
 {
 	if (!pte_same(*ptep, entry))
-		set_pte_at(vma->vm_mm, address, ptep, entry);
+		__set_pte_at(ptep, entry);
 	/*
 	 * update_mmu_cache will unconditionally execute, handling both
 	 * the case that the PTE changed and the spurious fault case.
@@ -688,14 +700,14 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(mm, addr, pmdp, pmd);
-	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+	return __set_pte_at((pte_t *)pmdp, pmd_pte(pmd));
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
 {
 	page_table_check_pud_set(mm, addr, pudp, pud);
-	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
+	return __set_pte_at((pte_t *)pudp, pud_pte(pud));
 }
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fbc59b3f69f2..f1387272a551 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -82,18 +82,11 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 #ifdef CONFIG_MMU
 void flush_icache_pte(pte_t pte)
 {
-	struct page *page = pte_page(pte);
+	struct folio *folio = page_folio(pte_page(pte));
 
-	/*
-	 * HugeTLB pages are always fully mapped, so only setting head page's
-	 * PG_dcache_clean flag is enough.
-	 */
-	if (PageHuge(page))
-		page = compound_head(page);
-
-	if (!test_bit(PG_dcache_clean, &page->flags)) {
+	if (!test_bit(PG_dcache_clean, &folio->flags)) {
 		flush_icache_all();
-		set_bit(PG_dcache_clean, &page->flags);
+		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
 #endif /* CONFIG_MMU */
-- 
2.39.2

