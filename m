Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5B76D159
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjHBPOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D72D74;
        Wed,  2 Aug 2023 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rxNaw0xdtXNmDaM3E8zO6BC1jw3LHCvkg9NX/222Fno=; b=MQq3CbMm0q4bCyWXjzX8474UxY
        sCM+NdW28tNCxVit1lDbA82ZHyjSM9fidMkGWVxUNfoPY5QNTfKxgYS25Rlrmk8tWTCwGjOqtREIP
        9+IpTpVeyHXk9imwuybpiqKlumEsBQdv5lHwQsFqon1kVXe8IKZHUMtreh7oJkMYzho6AvZ6cdBK8
        0wfulkr4Pv2h9cU0aO4vCu3Lmo4WFs+fd0j9aYAuEfTlwA2YDcx8U7DL18QolV/fkiaR6fKbHYuy7
        Ihb6lEnNGcMdRl76WbIVw7fOIN7+Ji6RV/iF905xCp+34fiY3q74iMZtUA5fnh/SFOmu6g+UbdM/z
        D1UquHBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY9-00Ffjp-OO; Wed, 02 Aug 2023 15:14:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v6 17/38] mips: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:45 +0100
Message-Id: <20230802151406.3735276-18-willy@infradead.org>
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

Rename _PFN_SHIFT to PFN_PTE_SHIFT.  Convert a few places
to call set_pte() instead of set_pte_at().  Add set_ptes(),
update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().
Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page
to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/bcm47xx/prom.c             |  2 +-
 arch/mips/include/asm/cacheflush.h   | 32 +++++++++-----
 arch/mips/include/asm/pgtable-32.h   | 10 ++---
 arch/mips/include/asm/pgtable-64.h   |  6 +--
 arch/mips/include/asm/pgtable-bits.h |  6 +--
 arch/mips/include/asm/pgtable.h      | 63 ++++++++++++++++++----------
 arch/mips/mm/c-r4k.c                 |  5 ++-
 arch/mips/mm/cache.c                 | 56 ++++++++++++-------------
 arch/mips/mm/init.c                  | 21 ++++++----
 arch/mips/mm/pgtable-32.c            |  2 +-
 arch/mips/mm/pgtable-64.c            |  2 +-
 arch/mips/mm/tlbex.c                 |  2 +-
 12 files changed, 121 insertions(+), 86 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index a9bea411d928..99a1ba5394e0 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -116,7 +116,7 @@ void __init prom_init(void)
 #if defined(CONFIG_BCM47XX_BCMA) && defined(CONFIG_HIGHMEM)
 
 #define EXTVBASE	0xc0000000
-#define ENTRYLO(x)	((pte_val(pfn_pte((x) >> _PFN_SHIFT, PAGE_KERNEL_UNCACHED)) >> 6) | 1)
+#define ENTRYLO(x)	((pte_val(pfn_pte((x) >> PFN_PTE_SHIFT, PAGE_KERNEL_UNCACHED)) >> 6) | 1)
 
 #include <asm/tlbflush.h>
 
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index d8d3f80f9fc0..0f389bc7cb90 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -36,12 +36,12 @@
  */
 #define PG_dcache_dirty			PG_arch_1
 
-#define Page_dcache_dirty(page)		\
-	test_bit(PG_dcache_dirty, &(page)->flags)
-#define SetPageDcacheDirty(page)	\
-	set_bit(PG_dcache_dirty, &(page)->flags)
-#define ClearPageDcacheDirty(page)	\
-	clear_bit(PG_dcache_dirty, &(page)->flags)
+#define folio_test_dcache_dirty(folio)		\
+	test_bit(PG_dcache_dirty, &(folio)->flags)
+#define folio_set_dcache_dirty(folio)	\
+	set_bit(PG_dcache_dirty, &(folio)->flags)
+#define folio_clear_dcache_dirty(folio)	\
+	clear_bit(PG_dcache_dirty, &(folio)->flags)
 
 extern void (*flush_cache_all)(void);
 extern void (*__flush_cache_all)(void);
@@ -50,15 +50,24 @@ extern void (*flush_cache_mm)(struct mm_struct *mm);
 extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
-extern void __flush_dcache_page(struct page *page);
+extern void __flush_dcache_pages(struct page *page, unsigned int nr);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	if (cpu_has_dc_aliases)
+		__flush_dcache_pages(&folio->page, folio_nr_pages(folio));
+	else if (!cpu_has_ic_fills_f_dc)
+		folio_set_dcache_dirty(folio);
+}
+#define flush_dcache_folio flush_dcache_folio
+
 static inline void flush_dcache_page(struct page *page)
 {
 	if (cpu_has_dc_aliases)
-		__flush_dcache_page(page);
+		__flush_dcache_pages(page, 1);
 	else if (!cpu_has_ic_fills_f_dc)
-		SetPageDcacheDirty(page);
+		folio_set_dcache_dirty(page_folio(page));
 }
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
@@ -73,10 +82,11 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 		__flush_anon_page(page, vmaddr);
 }
 
-static inline void flush_icache_page(struct vm_area_struct *vma,
-	struct page *page)
+static inline void flush_icache_pages(struct vm_area_struct *vma,
+		struct page *page, unsigned int nr)
 {
 }
+#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
 extern void (*local_flush_icache_range)(unsigned long start, unsigned long end);
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index ba0016709a1a..0e196650f4f4 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -153,7 +153,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 #if defined(CONFIG_XPA)
 
 #define MAX_POSSIBLE_PHYSMEM_BITS 40
-#define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
+#define pte_pfn(x)		(((unsigned long)((x).pte_high >> PFN_PTE_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
 pfn_pte(unsigned long pfn, pgprot_t prot)
 {
@@ -161,7 +161,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 
 	pte.pte_low = (pfn >> _PAGE_PRESENT_SHIFT) |
 				(pgprot_val(prot) & ~_PFNX_MASK);
-	pte.pte_high = (pfn << _PFN_SHIFT) |
+	pte.pte_high = (pfn << PFN_PTE_SHIFT) |
 				(pgprot_val(prot) & ~_PFN_MASK);
 	return pte;
 }
@@ -184,9 +184,9 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 #else
 
 #define MAX_POSSIBLE_PHYSMEM_BITS 32
-#define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << _PFN_SHIFT) | pgprot_val(prot))
-#define pfn_pmd(pfn, prot)	__pmd(((unsigned long long)(pfn) << _PFN_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)((x).pte >> PFN_PTE_SHIFT))
+#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((unsigned long long)(pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32) */
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 98e24e3e7f2b..20ca48c1b606 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -298,9 +298,9 @@ static inline void pud_clear(pud_t *pudp)
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
-#define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)((x).pte >> PFN_PTE_SHIFT))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
 
 #ifndef __PAGETABLE_PMD_FOLDED
 static inline pmd_t *pud_pgtable(pud_t pud)
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 1c576679aa87..421e78c30253 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -182,10 +182,10 @@ enum pgtable_bits {
 #if defined(CONFIG_CPU_R3K_TLB)
 # define _CACHE_UNCACHED	(1 << _CACHE_UNCACHED_SHIFT)
 # define _CACHE_MASK		_CACHE_UNCACHED
-# define _PFN_SHIFT		PAGE_SHIFT
+# define PFN_PTE_SHIFT		PAGE_SHIFT
 #else
 # define _CACHE_MASK		(7 << _CACHE_SHIFT)
-# define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
+# define PFN_PTE_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 #endif
 
 #ifndef _PAGE_NO_EXEC
@@ -195,7 +195,7 @@ enum pgtable_bits {
 #define _PAGE_SILENT_READ	_PAGE_VALID
 #define _PAGE_SILENT_WRITE	_PAGE_DIRTY
 
-#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
+#define _PFN_MASK		(~((1 << (PFN_PTE_SHIFT)) - 1))
 
 /*
  * The final layouts of the PTE bits are:
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 574fa14ac8b2..cbb93a834f52 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -66,7 +66,7 @@ extern void paging_init(void);
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	return pmd_val(pmd) >> _PFN_SHIFT;
+	return pmd_val(pmd) >> PFN_PTE_SHIFT;
 }
 
 #ifndef CONFIG_MIPS_HUGE_TLB_SUPPORT
@@ -105,9 +105,6 @@ do {									\
 	}								\
 } while(0)
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval);
-
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
 #ifdef CONFIG_XPA
@@ -157,7 +154,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 			null.pte_low = null.pte_high = _PAGE_GLOBAL;
 	}
 
-	set_pte_at(mm, addr, ptep, null);
+	set_pte(ptep, null);
 	htw_start();
 }
 #else
@@ -196,28 +193,41 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 #if !defined(CONFIG_CPU_R3K_TLB)
 	/* Preserve global status for the pair */
 	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
-		set_pte_at(mm, addr, ptep, __pte(_PAGE_GLOBAL));
+		set_pte(ptep, __pte(_PAGE_GLOBAL));
 	else
 #endif
-		set_pte_at(mm, addr, ptep, __pte(0));
+		set_pte(ptep, __pte(0));
 	htw_start();
 }
 #endif
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
+	unsigned int i;
+	bool do_sync = false;
 
-	if (!pte_present(pteval))
-		goto cache_sync_done;
+	for (i = 0; i < nr; i++) {
+		if (!pte_present(pte))
+			continue;
+		if (pte_present(ptep[i]) &&
+		    (pte_pfn(ptep[i]) == pte_pfn(pte)))
+			continue;
+		do_sync = true;
+	}
 
-	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
-		goto cache_sync_done;
+	if (do_sync)
+		__update_cache(addr, pte);
 
-	__update_cache(addr, pteval);
-cache_sync_done:
-	set_pte(ptep, pteval);
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+	}
 }
+#define set_ptes set_ptes
 
 /*
  * (pmds are folded into puds so this doesn't get actually called,
@@ -486,7 +496,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 					pte_t entry, int dirty)
 {
 	if (!pte_same(*ptep, entry))
-		set_pte_at(vma->vm_mm, address, ptep, entry);
+		set_pte(ptep, entry);
 	/*
 	 * update_mmu_cache will unconditionally execute, handling both
 	 * the case that the PTE changed and the spurious fault case.
@@ -568,12 +578,21 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
 
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	__update_tlb(vma, address, pte);
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
+{
+	for (;;) {
+		pte_t pte = *ptep;
+		__update_tlb(vma, address, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		address += PAGE_SIZE;
+	}
 }
+#define update_mmu_cache(vma, address, ptep) \
+	update_mmu_cache_range(NULL, vma, address, ptep, 1)
 
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 4b6554b48923..187d1c16361c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -568,13 +568,14 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
 		vaddr = NULL;
 	else {
+		struct folio *folio = page_folio(page);
 		/*
 		 * Use kmap_coherent or kmap_atomic to do flushes for
 		 * another ASID than the current one.
 		 */
 		map_coherent = (cpu_has_dc_aliases &&
-				page_mapcount(page) &&
-				!Page_dcache_dirty(page));
+				folio_mapped(folio) &&
+				!folio_test_dcache_dirty(folio));
 		if (map_coherent)
 			vaddr = kmap_coherent(page, addr);
 		else
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index d21cf8c6cf6c..02042100e267 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -99,13 +99,15 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 	return 0;
 }
 
-void __flush_dcache_page(struct page *page)
+void __flush_dcache_pages(struct page *page, unsigned int nr)
 {
-	struct address_space *mapping = page_mapping_file(page);
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio_flush_mapping(folio);
 	unsigned long addr;
+	unsigned int i;
 
 	if (mapping && !mapping_mapped(mapping)) {
-		SetPageDcacheDirty(page);
+		folio_set_dcache_dirty(folio);
 		return;
 	}
 
@@ -114,25 +116,21 @@ void __flush_dcache_page(struct page *page)
 	 * case is for exec env/arg pages and those are %99 certainly going to
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
-	if (PageHighMem(page))
-		addr = (unsigned long)kmap_atomic(page);
-	else
-		addr = (unsigned long)page_address(page);
-
-	flush_data_cache_page(addr);
-
-	if (PageHighMem(page))
-		kunmap_atomic((void *)addr);
+	for (i = 0; i < nr; i++) {
+		addr = (unsigned long)kmap_local_page(page + i);
+		flush_data_cache_page(addr);
+		kunmap_local((void *)addr);
+	}
 }
-
-EXPORT_SYMBOL(__flush_dcache_page);
+EXPORT_SYMBOL(__flush_dcache_pages);
 
 void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
 	unsigned long addr = (unsigned long) page_address(page);
+	struct folio *folio = page_folio(page);
 
 	if (pages_do_alias(addr, vmaddr)) {
-		if (page_mapcount(page) && !Page_dcache_dirty(page)) {
+		if (folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
 			void *kaddr;
 
 			kaddr = kmap_coherent(page, vmaddr);
@@ -147,27 +145,29 @@ EXPORT_SYMBOL(__flush_anon_page);
 
 void __update_cache(unsigned long address, pte_t pte)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, addr;
 	int exec = !pte_no_exec(pte) && !cpu_has_ic_fills_f_dc;
+	unsigned int i;
 
 	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn)))
 		return;
-	page = pfn_to_page(pfn);
-	if (Page_dcache_dirty(page)) {
-		if (PageHighMem(page))
-			addr = (unsigned long)kmap_atomic(page);
-		else
-			addr = (unsigned long)page_address(page);
-
-		if (exec || pages_do_alias(addr, address & PAGE_MASK))
-			flush_data_cache_page(addr);
 
-		if (PageHighMem(page))
-			kunmap_atomic((void *)addr);
+	folio = page_folio(pfn_to_page(pfn));
+	address &= PAGE_MASK;
+	address -= offset_in_folio(folio, pfn << PAGE_SHIFT);
+
+	if (folio_test_dcache_dirty(folio)) {
+		for (i = 0; i < folio_nr_pages(folio); i++) {
+			addr = (unsigned long)kmap_local_folio(folio, i);
 
-		ClearPageDcacheDirty(page);
+			if (exec || pages_do_alias(addr, address))
+				flush_data_cache_page(addr);
+			kunmap_local((void *)addr);
+			address += PAGE_SIZE;
+		}
+		folio_clear_dcache_dirty(folio);
 	}
 }
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5a8002839550..5dcb525a8995 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -88,7 +88,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
+	BUG_ON(folio_test_dcache_dirty(page_folio(page)));
 
 	preempt_disable();
 	pagefault_disable();
@@ -169,11 +169,12 @@ void kunmap_coherent(void)
 void copy_user_highpage(struct page *to, struct page *from,
 	unsigned long vaddr, struct vm_area_struct *vma)
 {
+	struct folio *src = page_folio(from);
 	void *vfrom, *vto;
 
 	vto = kmap_atomic(to);
 	if (cpu_has_dc_aliases &&
-	    page_mapcount(from) && !Page_dcache_dirty(from)) {
+	    folio_mapped(src) && !folio_test_dcache_dirty(src)) {
 		vfrom = kmap_coherent(from, vaddr);
 		copy_page(vto, vfrom);
 		kunmap_coherent();
@@ -194,15 +195,17 @@ void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
+	struct folio *folio = page_folio(page);
+
 	if (cpu_has_dc_aliases &&
-	    page_mapcount(page) && !Page_dcache_dirty(page)) {
+	    folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
 		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(vto, src, len);
 		kunmap_coherent();
 	} else {
 		memcpy(dst, src, len);
 		if (cpu_has_dc_aliases)
-			SetPageDcacheDirty(page);
+			folio_set_dcache_dirty(folio);
 	}
 	if (vma->vm_flags & VM_EXEC)
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
@@ -212,15 +215,17 @@ void copy_from_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
+	struct folio *folio = page_folio(page);
+
 	if (cpu_has_dc_aliases &&
-	    page_mapcount(page) && !Page_dcache_dirty(page)) {
+	    folio_mapped(folio) && !folio_test_dcache_dirty(folio)) {
 		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(dst, vfrom, len);
 		kunmap_coherent();
 	} else {
 		memcpy(dst, src, len);
 		if (cpu_has_dc_aliases)
-			SetPageDcacheDirty(page);
+			folio_set_dcache_dirty(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(copy_from_user_page);
@@ -448,10 +453,10 @@ static inline void __init mem_init_free_highmem(void)
 void __init mem_init(void)
 {
 	/*
-	 * When _PFN_SHIFT is greater than PAGE_SHIFT we won't have enough PTE
+	 * When PFN_PTE_SHIFT is greater than PAGE_SHIFT we won't have enough PTE
 	 * bits to hold a full 32b physical address on MIPS32 systems.
 	 */
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
 #ifdef CONFIG_HIGHMEM
 	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index f57fb69472f8..84dd5136d53a 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -35,7 +35,7 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
 {
 	pmd_t pmd;
 
-	pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
+	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
 
 	return pmd;
 }
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index b4386a0e2ef8..c76d21f7dffb 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -93,7 +93,7 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
 {
 	pmd_t pmd;
 
-	pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
+	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
 
 	return pmd;
 }
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 8d514a9082c6..b4e1c783e617 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -253,7 +253,7 @@ static void output_pgtable_bits_defines(void)
 	pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
 	pr_define("_PAGE_VALID_SHIFT %d\n", _PAGE_VALID_SHIFT);
 	pr_define("_PAGE_DIRTY_SHIFT %d\n", _PAGE_DIRTY_SHIFT);
-	pr_define("_PFN_SHIFT %d\n", _PFN_SHIFT);
+	pr_define("PFN_PTE_SHIFT %d\n", PFN_PTE_SHIFT);
 	pr_debug("\n");
 }
 
-- 
2.40.1

