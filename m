Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DF269726E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 01:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBOAFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 19:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBOAFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 19:05:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C9E241E8
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 16:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s+L17RxfXCQ5HVPYV7rNHXw7afhlVPPZ+bFT60n+KTA=; b=SEG1Q+pPQu2QJMOI6kaTv2LQv1
        NVAh09QWWSuOAlT5w2SJ/qY2l17fJJ0+WBL79k7sGJLB2eEvwaqf0DNBgmZMqSYOI21T60nNZuc0B
        5dgQ4SJCAQqGZeORfpiPMhqD5/0Ft81JdOy94qCQ8Hv8a2TWikCWigrwSCPhKmnmhV4OtJXJf6FUz
        wYCEKu/O4esYVzZxSG199TLSwoGqDjXJZeCiqX+jsHIZLaS7zyUF9XR5YrPGjtZEwPGOKfGutx3bH
        1uGBJh5rnOvcNzNjsTAz973YyMOMsoJunKCB9ELpfYlgdRzy8UUoVZonGZh5peN82C0D5ubno8Fpr
        AImeRKTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS5II-006wkY-AK; Wed, 15 Feb 2023 00:05:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 9/7] arm64: Implement the new page table range API
Date:   Wed, 15 Feb 2023 00:04:42 +0000
Message-Id: <20230215000446.1655635-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230211033948.891959-1-willy@infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().

The PG_dcache_clear flag changes from being a per-page bit to being a
per-folio bit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm64/include/asm/cacheflush.h |  4 +++-
 arch/arm64/include/asm/pgtable.h    | 25 ++++++++++++++------
 arch/arm64/mm/flush.c               | 36 +++++++++++------------------
 3 files changed, 35 insertions(+), 30 deletions(-)

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
index 69765dc697af..4d1b79dbff16 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -355,12 +355,21 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
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
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /*
  * Huge pte definitions.
@@ -1059,8 +1068,8 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 /*
  * On AArch64, the cache coherency is handled via the set_pte_at() function.
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-				    unsigned long addr, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	/*
 	 * We don't do anything here, so there's a very small chance of
@@ -1069,6 +1078,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 */
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
 #ifdef CONFIG_ARM64_PA_BITS_52
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 5f9379b3c8c8..deb781af0a3a 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -50,20 +50,13 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
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
@@ -73,17 +66,16 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
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
2.39.1

