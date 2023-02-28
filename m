Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798956A618C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjB1VjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjB1ViV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CA3430F;
        Tue, 28 Feb 2023 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bHG0cAAB5y+5Fy2o+LQ/LT1veDA41EiEXJDm/yoHE4w=; b=uuNpaykeiK5frENkfd+aJNrgoD
        zi+BAtfLF/YVlEoNF2/fceWUxc4H557U7VOvkZavRFq+8vH7xnCPti0atW6QBc1YG7hC7hZocJ78G
        yesByn9YVrJPdpmy3ngrYC5YXRqKl+W3RBlRiDnHUDM5/XyrSOyubzsZu01ggy0jmQpkYpGeAWHRm
        lyTL+J5cDDw5ztIpSIT4nE7R5zTUN3fMKKEnnBDpb3ODjFvY1RvBN5YZiCWcuu8BvL9E6xCka7s/7
        keZ7XcWYA1V7/9HEyfngx7D5SXVa9jECUsd7mDWRP2+0I46TYC4G42bdFY12DTKPLXSsurdY6UYLU
        BFkpkq2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fJ-0018q4-Ol; Tue, 28 Feb 2023 21:37:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: [PATCH v3 22/34] superh: Implement the new page table range API
Date:   Tue, 28 Feb 2023 21:37:25 +0000
Message-Id: <20230228213738.272178-23-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
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
flush_icache_pages().  Change the PG_dcache_clean flag from being
per-page to per-folio.  Flush the entire folio containing the pages in
flush_icache_pages() for ease of implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/cacheflush.h | 21 ++++++++-----
 arch/sh/include/asm/pgtable.h    |  6 ++--
 arch/sh/include/asm/pgtable_32.h | 16 ++++++++--
 arch/sh/mm/cache-j2.c            |  4 +--
 arch/sh/mm/cache-sh4.c           | 26 ++++++++++-----
 arch/sh/mm/cache-sh7705.c        | 26 +++++++++------
 arch/sh/mm/cache.c               | 54 ++++++++++++++++++--------------
 arch/sh/mm/kmap.c                |  3 +-
 8 files changed, 101 insertions(+), 55 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 481a664287e2..9fceef6f3e00 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -13,9 +13,9 @@
  *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
- *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
+ *  - flush_dcache_folio(folio) flushes(wback&invalidates) a folio for dcache
  *  - flush_icache_range(start, end) flushes(invalidates) a range for icache
- *  - flush_icache_page(vma, pg) flushes(invalidates) a page for icache
+ *  - flush_icache_pages(vma, pg, nr) flushes(invalidates) pages for icache
  *  - flush_cache_sigtramp(vaddr) flushes the signal trampoline
  */
 extern void (*local_flush_cache_all)(void *args);
@@ -23,9 +23,9 @@ extern void (*local_flush_cache_mm)(void *args);
 extern void (*local_flush_cache_dup_mm)(void *args);
 extern void (*local_flush_cache_page)(void *args);
 extern void (*local_flush_cache_range)(void *args);
-extern void (*local_flush_dcache_page)(void *args);
+extern void (*local_flush_dcache_folio)(void *args);
 extern void (*local_flush_icache_range)(void *args);
-extern void (*local_flush_icache_page)(void *args);
+extern void (*local_flush_icache_folio)(void *args);
 extern void (*local_flush_cache_sigtramp)(void *args);
 
 static inline void cache_noop(void *args) { }
@@ -42,11 +42,18 @@ extern void flush_cache_page(struct vm_area_struct *vma,
 extern void flush_cache_range(struct vm_area_struct *vma,
 				 unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
+
 extern void flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_user_range flush_icache_range
-extern void flush_icache_page(struct vm_area_struct *vma,
-				 struct page *page);
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr);
+#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
 extern void flush_cache_sigtramp(unsigned long address);
 
 struct flusher_data {
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 3ce30becf6df..1a8fdc3bc363 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -102,13 +102,15 @@ extern void __update_cache(struct vm_area_struct *vma,
 extern void __update_tlb(struct vm_area_struct *vma,
 			 unsigned long address, pte_t pte);
 
-static inline void
-update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 	pte_t pte = *ptep;
 	__update_cache(vma, address, pte);
 	__update_tlb(vma, address, pte);
 }
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init(void);
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 21952b094650..03ba1834e126 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -307,7 +307,19 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #endif
 
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + PAGE_SIZE);
+	}
+}
+
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
@@ -323,7 +335,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define pte_none(x)		(!pte_val(x))
 #define pte_present(x)		((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
 
-#define pte_clear(mm,addr,xp) do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pte_clear(mm, addr, ptep) set_pte(ptep, __pte(0))
 
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x))
diff --git a/arch/sh/mm/cache-j2.c b/arch/sh/mm/cache-j2.c
index f277862a11f5..9ac960214380 100644
--- a/arch/sh/mm/cache-j2.c
+++ b/arch/sh/mm/cache-j2.c
@@ -55,9 +55,9 @@ void __init j2_cache_init(void)
 	local_flush_cache_dup_mm = j2_flush_both;
 	local_flush_cache_page = j2_flush_both;
 	local_flush_cache_range = j2_flush_both;
-	local_flush_dcache_page = j2_flush_dcache;
+	local_flush_dcache_folio = j2_flush_dcache;
 	local_flush_icache_range = j2_flush_icache;
-	local_flush_icache_page = j2_flush_icache;
+	local_flush_icache_folio = j2_flush_icache;
 	local_flush_cache_sigtramp = j2_flush_icache;
 
 	pr_info("Initial J2 CCR is %.8x\n", __raw_readl(j2_ccr_base));
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 72c2e1b46c08..862046f26981 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -107,19 +107,29 @@ static inline void flush_cache_one(unsigned long start, unsigned long phys)
  * Write back & invalidate the D-cache of the page.
  * (To avoid "alias" issues)
  */
-static void sh4_flush_dcache_page(void *arg)
+static void sh4_flush_dcache_folio(void *arg)
 {
-	struct page *page = arg;
-	unsigned long addr = (unsigned long)page_address(page);
+	struct folio *folio = arg;
 #ifndef CONFIG_SMP
-	struct address_space *mapping = page_mapping_file(page);
+	struct address_space *mapping = folio_flush_mapping(folio);
 
 	if (mapping && !mapping_mapped(mapping))
-		clear_bit(PG_dcache_clean, &page->flags);
+		clear_bit(PG_dcache_clean, &folio->flags);
 	else
 #endif
-		flush_cache_one(CACHE_OC_ADDRESS_ARRAY |
-				(addr & shm_align_mask), page_to_phys(page));
+	{
+		unsigned long pfn = folio_pfn(folio);
+		unsigned long addr = (unsigned long)folio_address(folio);
+		unsigned int i, nr = folio_nr_pages(folio);
+
+		for (i = 0; i < nr; i++) {
+			flush_cache_one(CACHE_OC_ADDRESS_ARRAY |
+						(addr & shm_align_mask),
+					pfn * PAGE_SIZE);
+			addr += PAGE_SIZE;
+			pfn++;
+		}
+	}
 
 	wmb();
 }
@@ -379,7 +389,7 @@ void __init sh4_cache_init(void)
 		__raw_readl(CCN_PRR));
 
 	local_flush_icache_range	= sh4_flush_icache_range;
-	local_flush_dcache_page		= sh4_flush_dcache_page;
+	local_flush_dcache_folio	= sh4_flush_dcache_folio;
 	local_flush_cache_all		= sh4_flush_cache_all;
 	local_flush_cache_mm		= sh4_flush_cache_mm;
 	local_flush_cache_dup_mm	= sh4_flush_cache_mm;
diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
index 9b63a53a5e46..b509a407588f 100644
--- a/arch/sh/mm/cache-sh7705.c
+++ b/arch/sh/mm/cache-sh7705.c
@@ -132,15 +132,20 @@ static void __flush_dcache_page(unsigned long phys)
  * Write back & invalidate the D-cache of the page.
  * (To avoid "alias" issues)
  */
-static void sh7705_flush_dcache_page(void *arg)
+static void sh7705_flush_dcache_folio(void *arg)
 {
-	struct page *page = arg;
-	struct address_space *mapping = page_mapping_file(page);
+	struct folio *folio = arg;
+	struct address_space *mapping = folio_flush_mapping(folio);
 
 	if (mapping && !mapping_mapped(mapping))
-		clear_bit(PG_dcache_clean, &page->flags);
-	else
-		__flush_dcache_page(__pa(page_address(page)));
+		clear_bit(PG_dcache_clean, &folio->flags);
+	else {
+		unsigned long pfn = folio_pfn(folio);
+		unsigned int i, nr = folio_nr_pages(folio);
+
+		for (i = 0; i < nr; i++)
+			__flush_dcache_page((pfn + i) * PAGE_SIZE);
+	}
 }
 
 static void sh7705_flush_cache_all(void *args)
@@ -176,19 +181,20 @@ static void sh7705_flush_cache_page(void *args)
  * Not entirely sure why this is necessary on SH3 with 32K cache but
  * without it we get occasional "Memory fault" when loading a program.
  */
-static void sh7705_flush_icache_page(void *page)
+static void sh7705_flush_icache_folio(void *arg)
 {
-	__flush_purge_region(page_address(page), PAGE_SIZE);
+	struct folio *folio = arg;
+	__flush_purge_region(folio_address(folio), folio_size(folio));
 }
 
 void __init sh7705_cache_init(void)
 {
 	local_flush_icache_range	= sh7705_flush_icache_range;
-	local_flush_dcache_page		= sh7705_flush_dcache_page;
+	local_flush_dcache_folio	= sh7705_flush_dcache_folio;
 	local_flush_cache_all		= sh7705_flush_cache_all;
 	local_flush_cache_mm		= sh7705_flush_cache_all;
 	local_flush_cache_dup_mm	= sh7705_flush_cache_all;
 	local_flush_cache_range		= sh7705_flush_cache_all;
 	local_flush_cache_page		= sh7705_flush_cache_page;
-	local_flush_icache_page		= sh7705_flush_icache_page;
+	local_flush_icache_folio	= sh7705_flush_icache_folio;
 }
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 3aef78ceb820..93fc5fb8ec1c 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -20,9 +20,9 @@ void (*local_flush_cache_mm)(void *args) = cache_noop;
 void (*local_flush_cache_dup_mm)(void *args) = cache_noop;
 void (*local_flush_cache_page)(void *args) = cache_noop;
 void (*local_flush_cache_range)(void *args) = cache_noop;
-void (*local_flush_dcache_page)(void *args) = cache_noop;
+void (*local_flush_dcache_folio)(void *args) = cache_noop;
 void (*local_flush_icache_range)(void *args) = cache_noop;
-void (*local_flush_icache_page)(void *args) = cache_noop;
+void (*local_flush_icache_folio)(void *args) = cache_noop;
 void (*local_flush_cache_sigtramp)(void *args) = cache_noop;
 
 void (*__flush_wback_region)(void *start, int size);
@@ -61,15 +61,17 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, const void *src,
 		       unsigned long len)
 {
-	if (boot_cpu_data.dcache.n_aliases && page_mapcount(page) &&
-	    test_bit(PG_dcache_clean, &page->flags)) {
+	struct folio *folio = page_folio(page);
+
+	if (boot_cpu_data.dcache.n_aliases && folio_mapped(folio) &&
+	    test_bit(PG_dcache_clean, &folio->flags)) {
 		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(vto, src, len);
 		kunmap_coherent(vto);
 	} else {
 		memcpy(dst, src, len);
 		if (boot_cpu_data.dcache.n_aliases)
-			clear_bit(PG_dcache_clean, &page->flags);
+			clear_bit(PG_dcache_clean, &folio->flags);
 	}
 
 	if (vma->vm_flags & VM_EXEC)
@@ -80,27 +82,30 @@ void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
 			 unsigned long vaddr, void *dst, const void *src,
 			 unsigned long len)
 {
+	struct folio *folio = page_folio(page);
+
 	if (boot_cpu_data.dcache.n_aliases && page_mapcount(page) &&
-	    test_bit(PG_dcache_clean, &page->flags)) {
+	    test_bit(PG_dcache_clean, &folio->flags)) {
 		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(dst, vfrom, len);
 		kunmap_coherent(vfrom);
 	} else {
 		memcpy(dst, src, len);
 		if (boot_cpu_data.dcache.n_aliases)
-			clear_bit(PG_dcache_clean, &page->flags);
+			clear_bit(PG_dcache_clean, &folio->flags);
 	}
 }
 
 void copy_user_highpage(struct page *to, struct page *from,
 			unsigned long vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
 	void *vfrom, *vto;
 
 	vto = kmap_atomic(to);
 
-	if (boot_cpu_data.dcache.n_aliases && page_mapcount(from) &&
-	    test_bit(PG_dcache_clean, &from->flags)) {
+	if (boot_cpu_data.dcache.n_aliases && folio_mapped(src) &&
+	    test_bit(PG_dcache_clean, &src->flags)) {
 		vfrom = kmap_coherent(from, vaddr);
 		copy_page(vto, vfrom);
 		kunmap_coherent(vfrom);
@@ -136,35 +141,37 @@ EXPORT_SYMBOL(clear_user_highpage);
 void __update_cache(struct vm_area_struct *vma,
 		    unsigned long address, pte_t pte)
 {
-	struct page *page;
 	unsigned long pfn = pte_pfn(pte);
 
 	if (!boot_cpu_data.dcache.n_aliases)
 		return;
 
-	page = pfn_to_page(pfn);
 	if (pfn_valid(pfn)) {
-		int dirty = !test_and_set_bit(PG_dcache_clean, &page->flags);
+		struct folio *folio = page_folio(pfn_to_page(pfn));
+		int dirty = !test_and_set_bit(PG_dcache_clean, &folio->flags);
 		if (dirty)
-			__flush_purge_region(page_address(page), PAGE_SIZE);
+			__flush_purge_region(folio_address(folio),
+						folio_size(folio));
 	}
 }
 
 void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
+	struct folio *folio = page_folio(page);
 	unsigned long addr = (unsigned long) page_address(page);
 
 	if (pages_do_alias(addr, vmaddr)) {
-		if (boot_cpu_data.dcache.n_aliases && page_mapcount(page) &&
-		    test_bit(PG_dcache_clean, &page->flags)) {
+		if (boot_cpu_data.dcache.n_aliases && folio_mapped(folio) &&
+		    test_bit(PG_dcache_clean, &folio->flags)) {
 			void *kaddr;
 
 			kaddr = kmap_coherent(page, vmaddr);
 			/* XXX.. For now kunmap_coherent() does a purge */
 			/* __flush_purge_region((void *)kaddr, PAGE_SIZE); */
 			kunmap_coherent(kaddr);
-		} else
-			__flush_purge_region((void *)addr, PAGE_SIZE);
+		} else 
+			__flush_purge_region(folio_address(folio),
+						folio_size(folio));
 	}
 }
 
@@ -215,11 +222,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_cache_range);
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
-	cacheop_on_each_cpu(local_flush_dcache_page, page, 1);
+	cacheop_on_each_cpu(local_flush_dcache_folio, folio, 1);
 }
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
 
 void flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -233,10 +240,11 @@ void flush_icache_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(flush_icache_range);
 
-void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
+		unsigned int nr)
 {
-	/* Nothing uses the VMA, so just pass the struct page along */
-	cacheop_on_each_cpu(local_flush_icache_page, page, 1);
+	/* Nothing uses the VMA, so just pass the folio along */
+	cacheop_on_each_cpu(local_flush_icache_folio, page_folio(page), 1);
 }
 
 void flush_cache_sigtramp(unsigned long address)
diff --git a/arch/sh/mm/kmap.c b/arch/sh/mm/kmap.c
index 73fd7cc99430..fa50e8f6e7a9 100644
--- a/arch/sh/mm/kmap.c
+++ b/arch/sh/mm/kmap.c
@@ -27,10 +27,11 @@ void __init kmap_coherent_init(void)
 
 void *kmap_coherent(struct page *page, unsigned long addr)
 {
+	struct folio *folio = page_folio(page);
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	BUG_ON(!test_bit(PG_dcache_clean, &page->flags));
+	BUG_ON(!test_bit(PG_dcache_clean, &folio->flags));
 
 	preempt_disable();
 	pagefault_disable();
-- 
2.39.1

