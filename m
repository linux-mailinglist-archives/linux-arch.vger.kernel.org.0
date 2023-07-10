Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C424E74DF86
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGJUob (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGJUoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FFE6D;
        Mon, 10 Jul 2023 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ppdmkbhn3pdci2A5T+8/PDoAOO4tRHFDpMfgtHEjIi8=; b=lPuyuN9/kfzzegkfuFmcsaU9fF
        Lc/9z5kp4JaqUHiiCtO4bct9lDeuZEuBbGVmD75jHyod+q5OS9/E33T+yVfXQq56C7GARJp6DyjIR
        o3UuxEY0HJslmfgdR+bF9veKcWu1b4C+HRsH7/UYSDnz5jP8cDnvYdYrQQcgREzKagDeWJNfCOHL1
        ZwfyY7vuDOw4waS2NW2CPa2NjUUcSm0wjYA9qAvsyhqfVtNiBplyeqAYGg44dbIwl3lVtJ3jc3T7f
        oQ1o/qpbmedQ7/dlvUjfDX9dJeYTDR6bleepVfHIh67aOcZYvrfvBEeXRe2a+li5dwtQXgjm2SZ/3
        VDeFgVJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjS-00Euon-AG; Mon, 10 Jul 2023 20:43:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 10/38] arm64: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:11 +0100
Message-Id: <20230710204339.3554919-11-willy@infradead.org>
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/cacheflush.h |  4 +++-
 arch/arm64/include/asm/pgtable.h    | 26 +++++++++++++++------
 arch/arm64/mm/flush.c               | 36 +++++++++++------------------
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 37185e978aeb..d115451ed263 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -114,7 +114,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 #define copy_to_user_page copy_to_user_page
 
 /*
- * flush_dcache_page is used when the kernel has written to the page
+ * flush_dcache_folio is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
  * If this page isn't mapped (ie, page_mapping == NULL), or it might
@@ -127,6 +127,8 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *);
+#define flush_dcache_folio flush_dcache_folio
 
 static __always_inline void icache_inval_all_pou(void)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a44a150e0318..c1c4abf75217 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -345,12 +345,21 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, pte);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
-	return __set_pte_at(mm, addr, ptep, pte);
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
+
+	for (;;) {
+		__set_pte_at(mm, addr, ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+		pte_val(pte) += PAGE_SIZE;
+	}
 }
+#define set_ptes set_ptes
 
 /*
  * Huge pte definitions.
@@ -1049,8 +1058,9 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 /*
  * On AArch64, the cache coherency is handled via the set_pte_at() function.
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-				    unsigned long addr, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		unsigned int nr)
 {
 	/*
 	 * We don't do anything here, so there's a very small chance of
@@ -1059,6 +1069,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 */
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
 #ifdef CONFIG_ARM64_PA_BITS_52
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 4e6476094952..013eead9b695 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -51,20 +51,13 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
 void __sync_icache_dcache(pte_t pte)
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
-		sync_icache_aliases((unsigned long)page_address(page),
-				    (unsigned long)page_address(page) +
-					    page_size(page));
-		set_bit(PG_dcache_clean, &page->flags);
+	if (!test_bit(PG_dcache_clean, &folio->flags)) {
+		sync_icache_aliases((unsigned long)folio_address(folio),
+				    (unsigned long)folio_address(folio) +
+					    folio_size(folio));
+		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
 EXPORT_SYMBOL_GPL(__sync_icache_dcache);
@@ -74,17 +67,16 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
  * it as dirty for later flushing when mapped in user space (if executable,
  * see __sync_icache_dcache).
  */
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
-	/*
-	 * HugeTLB pages are always fully mapped and only head page will be
-	 * set PG_dcache_clean (see comments in __sync_icache_dcache()).
-	 */
-	if (PageHuge(page))
-		page = compound_head(page);
+	if (test_bit(PG_dcache_clean, &folio->flags))
+		clear_bit(PG_dcache_clean, &folio->flags);
+}
+EXPORT_SYMBOL(flush_dcache_folio);
 
-	if (test_bit(PG_dcache_clean, &page->flags))
-		clear_bit(PG_dcache_clean, &page->flags);
+void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
-- 
2.39.2

