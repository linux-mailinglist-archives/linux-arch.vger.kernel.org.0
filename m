Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BF76D18B
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjHBPPt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjHBPO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E230E8;
        Wed,  2 Aug 2023 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xHJ3sahjoDc/Kc2Nk4ZhiFpGfJHUDLlPdJINUDN/DHI=; b=Wg3QAG+PamdrbtozW/nuOKVAVE
        Uhsr+9akMRePKzrzFkzSNQTekSLb+4x5ks75d7umQupNFhEQZ2+X3NcRb2OXYlMygwheO4gDZgpUj
        BFxsY8JEL5s2P2hdBqwBlvYzOUO7clv9v1uw9ZQucLsjvhCumTWG3vr2KZcgz21lxYkwa69Zs/b+i
        Q7TdD8NB8s1MPAhS+DkpS2mN7M+YKl4B9OmgksEbrvK4b5Az9eQS3KtbZC4q95tKhRuXjASOA+u5Y
        xHZ13/HTR3pQo/enqII9lVt7diyuqSrmaRnyY2jDwV/AUJ2RB1g9NX/rV0CTx1W7dnB0O8dKo9OeP
        QkY73Adg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYA-00Ffkr-VE; Wed, 02 Aug 2023 15:14:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v6 26/38] sparc64: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:54 +0100
Message-Id: <20230802151406.3735276-27-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
flush_icache_pages().  Convert the PG_dcache_dirty flag from being
per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/cacheflush_64.h | 18 ++++--
 arch/sparc/include/asm/pgtable_64.h    | 29 +++++++---
 arch/sparc/kernel/smp_64.c             | 56 +++++++++++-------
 arch/sparc/mm/init_64.c                | 78 +++++++++++++++-----------
 arch/sparc/mm/tlb.c                    |  5 +-
 5 files changed, 119 insertions(+), 67 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index b9341836597e..a9a719f04d06 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -35,20 +35,26 @@ void flush_icache_range(unsigned long start, unsigned long end);
 void __flush_icache_page(unsigned long);
 
 void __flush_dcache_page(void *addr, int flush_icache);
-void flush_dcache_page_impl(struct page *page);
+void flush_dcache_folio_impl(struct folio *folio);
 #ifdef CONFIG_SMP
-void smp_flush_dcache_page_impl(struct page *page, int cpu);
-void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
+void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
+void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
 #else
-#define smp_flush_dcache_page_impl(page,cpu) flush_dcache_page_impl(page)
-#define flush_dcache_page_all(mm,page) flush_dcache_page_impl(page)
+#define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
+#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
 #endif
 
 void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
+#define flush_dcache_folio flush_dcache_folio
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 
 #define flush_icache_page(vma, pg)	do { } while(0)
+#define flush_icache_pages(vma, pg, nr)	do { } while(0)
 
 void flush_ptrace_access(struct vm_area_struct *, struct page *,
 			 unsigned long uaddr, void *kaddr,
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 5563efa1a19f..09aa37cc4469 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -86,6 +86,7 @@ extern unsigned long VMALLOC_END;
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
 #include <linux/sched.h>
+#include <asm/tlbflush.h>
 
 bool kern_addr_valid(unsigned long addr);
 
@@ -927,8 +928,21 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm, PAGE_SHIFT);
 }
 
-#define set_pte_at(mm,addr,ptep,pte)	\
-	__set_pte_at((mm), (addr), (ptep), (pte), 0)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	arch_enter_lazy_mmu_mode();
+	for (;;) {
+		__set_pte_at(mm, addr, ptep, pte, 0);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+		addr += PAGE_SIZE;
+	}
+	arch_leave_lazy_mmu_mode();
+}
+#define set_ptes set_ptes
 
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
@@ -947,8 +961,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 									\
 		if (pfn_valid(this_pfn) &&				\
 		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
-			flush_dcache_page_all(current->mm,		\
-					      pfn_to_page(this_pfn));	\
+			flush_dcache_folio_all(current->mm,		\
+				page_folio(pfn_to_page(this_pfn)));	\
 	}								\
 	newpte;								\
 })
@@ -963,7 +977,10 @@ struct seq_file;
 void mmu_info(struct seq_file *);
 
 struct vm_area_struct;
-void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
+void update_mmu_cache_range(struct vm_fault *, struct vm_area_struct *,
+		unsigned long addr, pte_t *ptep, unsigned int nr);
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd);
@@ -1121,8 +1138,6 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 }
 #define pte_access_permitted pte_access_permitted
 
-#include <asm/tlbflush.h>
-
 /* We provide our own get_unmapped_area to cope with VA holes and
  * SHM area cache aliasing for userland.
  */
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e5964d1d8b37..f3969a3600db 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -921,20 +921,26 @@ extern unsigned long xcall_flush_dcache_page_cheetah;
 #endif
 extern unsigned long xcall_flush_dcache_page_spitfire;
 
-static inline void __local_flush_dcache_page(struct page *page)
+static inline void __local_flush_dcache_folio(struct folio *folio)
 {
+	unsigned int i, nr = folio_nr_pages(folio);
+
 #ifdef DCACHE_ALIASING_POSSIBLE
-	__flush_dcache_page(page_address(page),
+	for (i = 0; i < nr; i++)
+		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
 			    ((tlb_type == spitfire) &&
-			     page_mapping_file(page) != NULL));
+			     folio_flush_mapping(folio) != NULL));
 #else
-	if (page_mapping_file(page) != NULL &&
-	    tlb_type == spitfire)
-		__flush_icache_page(__pa(page_address(page)));
+	if (folio_flush_mapping(folio) != NULL &&
+	    tlb_type == spitfire) {
+		unsigned long pfn = folio_pfn(folio)
+		for (i = 0; i < nr; i++)
+			__flush_icache_page((pfn + i) * PAGE_SIZE);
+	}
 #endif
 }
 
-void smp_flush_dcache_page_impl(struct page *page, int cpu)
+void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
 {
 	int this_cpu;
 
@@ -948,14 +954,14 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
 	this_cpu = get_cpu();
 
 	if (cpu == this_cpu) {
-		__local_flush_dcache_page(page);
+		__local_flush_dcache_folio(folio);
 	} else if (cpu_online(cpu)) {
-		void *pg_addr = page_address(page);
+		void *pg_addr = folio_address(folio);
 		u64 data0 = 0;
 
 		if (tlb_type == spitfire) {
 			data0 = ((u64)&xcall_flush_dcache_page_spitfire);
-			if (page_mapping_file(page) != NULL)
+			if (folio_flush_mapping(folio) != NULL)
 				data0 |= ((u64)1 << 32);
 		} else if (tlb_type == cheetah || tlb_type == cheetah_plus) {
 #ifdef DCACHE_ALIASING_POSSIBLE
@@ -963,18 +969,23 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
 #endif
 		}
 		if (data0) {
-			xcall_deliver(data0, __pa(pg_addr),
-				      (u64) pg_addr, cpumask_of(cpu));
+			unsigned int i, nr = folio_nr_pages(folio);
+
+			for (i = 0; i < nr; i++) {
+				xcall_deliver(data0, __pa(pg_addr),
+					      (u64) pg_addr, cpumask_of(cpu));
 #ifdef CONFIG_DEBUG_DCFLUSH
-			atomic_inc(&dcpage_flushes_xcall);
+				atomic_inc(&dcpage_flushes_xcall);
 #endif
+				pg_addr += PAGE_SIZE;
+			}
 		}
 	}
 
 	put_cpu();
 }
 
-void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
+void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
 {
 	void *pg_addr;
 	u64 data0;
@@ -988,10 +999,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	atomic_inc(&dcpage_flushes);
 #endif
 	data0 = 0;
-	pg_addr = page_address(page);
+	pg_addr = folio_address(folio);
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
-		if (page_mapping_file(page) != NULL)
+		if (folio_flush_mapping(folio) != NULL)
 			data0 |= ((u64)1 << 32);
 	} else if (tlb_type == cheetah || tlb_type == cheetah_plus) {
 #ifdef DCACHE_ALIASING_POSSIBLE
@@ -999,13 +1010,18 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 #endif
 	}
 	if (data0) {
-		xcall_deliver(data0, __pa(pg_addr),
-			      (u64) pg_addr, cpu_online_mask);
+		unsigned int i, nr = folio_nr_pages(folio);
+
+		for (i = 0; i < nr; i++) {
+			xcall_deliver(data0, __pa(pg_addr),
+				      (u64) pg_addr, cpu_online_mask);
 #ifdef CONFIG_DEBUG_DCFLUSH
-		atomic_inc(&dcpage_flushes_xcall);
+			atomic_inc(&dcpage_flushes_xcall);
 #endif
+			pg_addr += PAGE_SIZE;
+		}
 	}
-	__local_flush_dcache_page(page);
+	__local_flush_dcache_folio(folio);
 
 	preempt_enable();
 }
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0d7fd793924c..680ef206565c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -195,21 +195,26 @@ atomic_t dcpage_flushes_xcall = ATOMIC_INIT(0);
 #endif
 #endif
 
-inline void flush_dcache_page_impl(struct page *page)
+inline void flush_dcache_folio_impl(struct folio *folio)
 {
+	unsigned int i, nr = folio_nr_pages(folio);
+
 	BUG_ON(tlb_type == hypervisor);
 #ifdef CONFIG_DEBUG_DCFLUSH
 	atomic_inc(&dcpage_flushes);
 #endif
 
 #ifdef DCACHE_ALIASING_POSSIBLE
-	__flush_dcache_page(page_address(page),
-			    ((tlb_type == spitfire) &&
-			     page_mapping_file(page) != NULL));
+	for (i = 0; i < nr; i++)
+		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
+				    ((tlb_type == spitfire) &&
+				     folio_flush_mapping(folio) != NULL));
 #else
-	if (page_mapping_file(page) != NULL &&
-	    tlb_type == spitfire)
-		__flush_icache_page(__pa(page_address(page)));
+	if (folio_flush_mapping(folio) != NULL &&
+	    tlb_type == spitfire) {
+		for (i = 0; i < nr; i++)
+			__flush_icache_page((pfn + i) * PAGE_SIZE);
+	}
 #endif
 }
 
@@ -218,10 +223,10 @@ inline void flush_dcache_page_impl(struct page *page)
 #define PG_dcache_cpu_mask	\
 	((1UL<<ilog2(roundup_pow_of_two(NR_CPUS)))-1UL)
 
-#define dcache_dirty_cpu(page) \
-	(((page)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
+#define dcache_dirty_cpu(folio) \
+	(((folio)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
 
-static inline void set_dcache_dirty(struct page *page, int this_cpu)
+static inline void set_dcache_dirty(struct folio *folio, int this_cpu)
 {
 	unsigned long mask = this_cpu;
 	unsigned long non_cpu_bits;
@@ -238,11 +243,11 @@ static inline void set_dcache_dirty(struct page *page, int this_cpu)
 			     "bne,pn	%%xcc, 1b\n\t"
 			     " nop"
 			     : /* no outputs */
-			     : "r" (mask), "r" (non_cpu_bits), "r" (&page->flags)
+			     : "r" (mask), "r" (non_cpu_bits), "r" (&folio->flags)
 			     : "g1", "g7");
 }
 
-static inline void clear_dcache_dirty_cpu(struct page *page, unsigned long cpu)
+static inline void clear_dcache_dirty_cpu(struct folio *folio, unsigned long cpu)
 {
 	unsigned long mask = (1UL << PG_dcache_dirty);
 
@@ -260,7 +265,7 @@ static inline void clear_dcache_dirty_cpu(struct page *page, unsigned long cpu)
 			     " nop\n"
 			     "2:"
 			     : /* no outputs */
-			     : "r" (cpu), "r" (mask), "r" (&page->flags),
+			     : "r" (cpu), "r" (mask), "r" (&folio->flags),
 			       "i" (PG_dcache_cpu_mask),
 			       "i" (PG_dcache_cpu_shift)
 			     : "g1", "g7");
@@ -284,9 +289,10 @@ static void flush_dcache(unsigned long pfn)
 
 	page = pfn_to_page(pfn);
 	if (page) {
+		struct folio *folio = page_folio(page);
 		unsigned long pg_flags;
 
-		pg_flags = page->flags;
+		pg_flags = folio->flags;
 		if (pg_flags & (1UL << PG_dcache_dirty)) {
 			int cpu = ((pg_flags >> PG_dcache_cpu_shift) &
 				   PG_dcache_cpu_mask);
@@ -296,11 +302,11 @@ static void flush_dcache(unsigned long pfn)
 			 * in the SMP case.
 			 */
 			if (cpu == this_cpu)
-				flush_dcache_page_impl(page);
+				flush_dcache_folio_impl(folio);
 			else
-				smp_flush_dcache_page_impl(page, cpu);
+				smp_flush_dcache_folio_impl(folio, cpu);
 
-			clear_dcache_dirty_cpu(page, cpu);
+			clear_dcache_dirty_cpu(folio, cpu);
 
 			put_cpu();
 		}
@@ -388,12 +394,14 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 	struct mm_struct *mm;
 	unsigned long flags;
 	bool is_huge_tsb;
 	pte_t pte = *ptep;
+	unsigned int i;
 
 	if (tlb_type != hypervisor) {
 		unsigned long pfn = pte_pfn(pte);
@@ -440,15 +448,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 		}
 	}
 #endif
-	if (!is_huge_tsb)
-		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
-					address, pte_val(pte));
+	if (!is_huge_tsb) {
+		for (i = 0; i < nr; i++) {
+			__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
+						address, pte_val(pte));
+			address += PAGE_SIZE;
+			pte_val(pte) += PAGE_SIZE;
+		}
+	}
 
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
+	unsigned long pfn = folio_pfn(folio);
 	struct address_space *mapping;
 	int this_cpu;
 
@@ -459,35 +473,35 @@ void flush_dcache_page(struct page *page)
 	 * is merely the zero page.  The 'bigcore' testcase in GDB
 	 * causes this case to run millions of times.
 	 */
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(pfn))
 		return;
 
 	this_cpu = get_cpu();
 
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 	if (mapping && !mapping_mapped(mapping)) {
-		int dirty = test_bit(PG_dcache_dirty, &page->flags);
+		bool dirty = test_bit(PG_dcache_dirty, &folio->flags);
 		if (dirty) {
-			int dirty_cpu = dcache_dirty_cpu(page);
+			int dirty_cpu = dcache_dirty_cpu(folio);
 
 			if (dirty_cpu == this_cpu)
 				goto out;
-			smp_flush_dcache_page_impl(page, dirty_cpu);
+			smp_flush_dcache_folio_impl(folio, dirty_cpu);
 		}
-		set_dcache_dirty(page, this_cpu);
+		set_dcache_dirty(folio, this_cpu);
 	} else {
 		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg
 		 * pages and those are %99 certainly going to get
 		 * faulted into the tlb (and thus flushed) anyways.
 		 */
-		flush_dcache_page_impl(page);
+		flush_dcache_folio_impl(folio);
 	}
 
 out:
 	put_cpu();
 }
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(flush_dcache_folio);
 
 void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -2280,10 +2294,10 @@ void __init paging_init(void)
 	setup_page_offset();
 
 	/* These build time checkes make sure that the dcache_dirty_cpu()
-	 * page->flags usage will work.
+	 * folio->flags usage will work.
 	 *
 	 * When a page gets marked as dcache-dirty, we store the
-	 * cpu number starting at bit 32 in the page->flags.  Also,
+	 * cpu number starting at bit 32 in the folio->flags.  Also,
 	 * functions like clear_dcache_dirty_cpu use the cpu mask
 	 * in 13-bit signed-immediate instruction fields.
 	 */
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 7ecf8556947a..0d41c94ec3ac 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -118,6 +118,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 		unsigned long paddr, pfn = pte_pfn(orig);
 		struct address_space *mapping;
 		struct page *page;
+		struct folio *folio;
 
 		if (!pfn_valid(pfn))
 			goto no_cache_flush;
@@ -127,13 +128,13 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 			goto no_cache_flush;
 
 		/* A real file page? */
-		mapping = page_mapping_file(page);
+		mapping = folio_flush_mapping(folio);
 		if (!mapping)
 			goto no_cache_flush;
 
 		paddr = (unsigned long) page_address(page);
 		if ((paddr ^ vaddr) & (1 << 13))
-			flush_dcache_page_all(mm, page);
+			flush_dcache_folio_all(mm, folio);
 	}
 
 no_cache_flush:
-- 
2.40.1

