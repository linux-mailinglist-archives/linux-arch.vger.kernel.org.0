Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A476D160
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjHBPOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjHBPOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F330C7;
        Wed,  2 Aug 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mgSRsBuZwAxpA55hxS9bw6q/jUx3mEY9QYeL/14gdEs=; b=m2nhsFKC/z/frhghKqW4xYfvlf
        1e219T68traQOXiSiDDZ4G8arXqZoZyLAbAFiBETBn60Ivi1fORm0n/IbuWcSIPfscbWxp3GLBFLK
        EQRrHCWD6OT/5mToOLh7gsyWzsccpl56Ga9sI028K2qtHA8dnLiucAZpyKjpzXDGD7kKcSrOQxggu
        YD95HWIrKmmJLT21MmN7jwxuYRna42EpEB+ubdoyTT3/9W1VXGHh5yVs991G1XbJdmEX3Myi6QnBn
        1XAvszyFtItLZgM9oplYfy0/nLBk4V53r8vLSVbmyj281T9AMRqEZrRJ8Amf5t6w9ZFxKh4m+MP89
        OOwZk8Yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffj4-TB; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 10/38] arm64: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:38 +0100
Message-Id: <20230802151406.3735276-11-willy@infradead.org>
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
index 445b18d7a47c..76bba654b5d7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -345,12 +345,21 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, pte);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	page_table_check_ptes_set(mm, ptep, pte, 1);
-	return __set_pte_at(mm, addr, ptep, pte);
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	page_table_check_ptes_set(mm, ptep, pte, nr);
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
2.40.1

