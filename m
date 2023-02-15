Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95EF698544
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 21:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBOUJf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 15:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBOUJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 15:09:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17270244AC;
        Wed, 15 Feb 2023 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WK7WV98DmqNoEol8pKIPxUYYZ9kR5i0EUBhp91OqSig=; b=i50W5RLoKp2u9dkh3sbtVQHYCW
        y4vps7i5Zjb9gRIuKQkcVxkB2ZDAJibcvJZTosxgjyG3hUAKblPrrtsj9vVrGxMJYZ72zUaQQqJ4g
        82FddwyDg7YViumA8bA3rznbcKchmb7M6R9D0M85AF7H1oJI2+FO5QeKbxtDFjDrDyQsxU11jnDtt
        64SCigt+cFtVdBTeqE2xGyWT82tDeJXTKPIHugptpPVoCpe5spakHXlKVf8K/jEPOWv8M7bRUBA4k
        ZEyndIZz9oMorsB32W9pFxCKwVpaXe+b/dXV6+hykrTOgSI0z5P26m7L9DqJm4/IO/S1d/sKWIXoH
        /zTE9Kgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSO5m-007lAU-Rl; Wed, 15 Feb 2023 20:09:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/17] m68k: Implement the new page table range API
Date:   Wed, 15 Feb 2023 20:09:18 +0000
Message-Id: <20230215200920.1849567-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230215200920.1849567-1-willy@infradead.org>
References: <20230215000446.1655635-1-willy@infradead.org>
 <20230215200920.1849567-1-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
flush_dcache_folio().  I'm not entirely certain that the 040/060 case
in __flush_pages_to_ram() is correct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/m68k/include/asm/cacheflush_mm.h | 12 ++++++++----
 arch/m68k/include/asm/pgtable_mm.h    | 21 ++++++++++++++++++---
 arch/m68k/mm/motorola.c               |  2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 1ac55e7b47f0..2244c35178d0 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -220,13 +220,13 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
 
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
@@ -249,10 +249,14 @@ static inline void __flush_page_to_ram(void *vaddr)
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
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index b93c41fe2067..400206c17c97 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -31,8 +31,20 @@
 	do{							\
 		*(pteptr) = (pteval);				\
 	} while(0)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
+}
+
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #if CONFIG_PGTABLE_LEVELS == 3
@@ -138,11 +150,14 @@ extern void kernel_set_cachemode(void *addr, unsigned long size, int cmode);
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
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 2a375637e007..7784d0fcdf6e 100644
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
2.39.1

