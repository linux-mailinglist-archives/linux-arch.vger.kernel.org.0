Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B27478613
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 09:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhLQIVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 03:21:14 -0500
Received: from relay.sw.ru ([185.231.240.75]:41350 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhLQIVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 03:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=pDjfFIdDdVXXMPSil9iEKbKF8fJOdHI7/Q0gh6xQ34w=; b=X8RPgZ6yVUZD
        3Y9cBJNTwkeMHdU44vvDRZUupnhQWBJt14hzWPuOzdS9Mwll4Jj7aTjX0kc8ilYdWfHhzEp37xctT
        ZdXsD3/8oYSdihEFcbozYpTV5kvcjDDlzsYf1KIJEIjFR79wJs0gb1qc+kYsreHv9FgJ9Uiifn2Bl
        mhauY=;
Received: from [192.168.15.79] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1my8Te-003jwy-Cd; Fri, 17 Dec 2021 11:20:30 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, kernel@openvz.org
Subject: [PATCH/RFC] mm: add and use batched version of __tlb_remove_table()
Date:   Fri, 17 Dec 2021 11:19:10 +0300
Message-Id: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When batched page table freeing via struct mmu_table_batch is used, the
final freeing in __tlb_remove_table_free() executes a loop, calling
arch hook __tlb_remove_table() to free each table individually.

Shift that loop down to archs. This allows archs to optimize it, by
freeing multiple tables in a single release_pages() call. This is
faster than individual put_page() calls, especially with memcg
accounting enabled.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 arch/arm/include/asm/tlb.h                   |  5 ++++
 arch/arm64/include/asm/tlb.h                 |  5 ++++
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  8 +++++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h |  1 +
 arch/powerpc/include/asm/nohash/pgalloc.h    |  8 +++++++
 arch/powerpc/mm/book3s64/pgtable.c           |  8 +++++++
 arch/s390/include/asm/tlb.h                  |  1 +
 arch/s390/mm/pgalloc.c                       |  8 +++++++
 arch/sparc/include/asm/pgalloc_64.h          |  8 +++++++
 arch/x86/include/asm/tlb.h                   |  5 ++++
 include/asm-generic/tlb.h                    |  2 +-
 include/linux/swap.h                         |  5 +++-
 mm/mmu_gather.c                              |  6 +----
 mm/swap_state.c                              | 24 +++++++++++++++-----
 14 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..37f8a5193581 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -34,6 +34,11 @@ static inline void __tlb_remove_table(void *_table)
 	free_page_and_swap_cache((struct page *)_table);
 }
 
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	free_pages_and_swap_cache_nolru((struct page **)tables, nr);
+}
+
 #include <asm-generic/tlb.h>
 
 static inline void
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..c70dd428e1f6 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -16,6 +16,11 @@ static inline void __tlb_remove_table(void *_table)
 	free_page_and_swap_cache((struct page *)_table);
 }
 
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	free_pages_and_swap_cache_nolru((struct page **)tables, nr);
+}
+
 #define tlb_flush tlb_flush
 static void tlb_flush(struct mmu_gather *tlb);
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index dc5c039eb28e..880369de688a 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -66,6 +66,14 @@ static inline void __tlb_remove_table(void *_table)
 	pgtable_free(table, shift);
 }
 
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
+
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index e1af0b394ceb..f3dcd735e4ce 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -20,6 +20,7 @@ extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 extern void __tlb_remove_table(void *_table);
+extern void __tlb_remove_tables(void **tables, int nr);
 void pte_frag_destroy(void *pte_frag);
 
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 29c43665a753..170f5fda3dc1 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -63,6 +63,14 @@ static inline void __tlb_remove_table(void *_table)
 	pgtable_free(table, shift);
 }
 
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
+
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 9e16c7b1a6c5..f95fb42fadfa 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -412,6 +412,14 @@ void __tlb_remove_table(void *_table)
 	return pgtable_free(table, index);
 }
 
+void __tlb_remove_tables(void **tables, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
+
 #ifdef CONFIG_PROC_FS
 atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index fe6407f0eb1b..144d3db1441e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -23,6 +23,7 @@
  */
 
 void __tlb_remove_table(void *_table);
+void __tlb_remove_tables(void **tables, int nr);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 					  struct page *page, int page_size);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 781965f7210e..6a685a895fdb 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -315,6 +315,14 @@ void __tlb_remove_table(void *_table)
 	}
 }
 
+void __tlb_remove_tables(void **tables, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 7b5561d17ab1..eb7c9bf46747 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -92,6 +92,14 @@ static inline void __tlb_remove_table(void *_table)
 		is_page = true;
 	pgtable_free(table, is_page);
 }
+
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
 #else /* CONFIG_SMP */
 static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, bool is_page)
 {
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 1bfe979bb9bc..253a62be888c 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -37,4 +37,9 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	free_pages_and_swap_cache_nolru((struct page **)tables, nr);
+}
+
 #endif /* _ASM_X86_TLB_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..923c65d986dc 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -148,7 +148,7 @@
  *  Useful if your architecture has non-page page directories.
  *
  *  When used, an architecture is expected to provide __tlb_remove_table()
- *  which does the actual freeing of these pages.
+ *  and __tlb_remove_tables() which do the actual freeing of these pages.
  *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..86a1b0a61889 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -460,6 +460,7 @@ extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
 extern void free_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
+extern void free_pages_and_swap_cache_nolru(struct page **, int);
 extern struct page *lookup_swap_cache(swp_entry_t entry,
 				      struct vm_area_struct *vma,
 				      unsigned long addr);
@@ -565,7 +566,9 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 #define free_page_and_swap_cache(page) \
 	put_page(page)
 #define free_pages_and_swap_cache(pages, nr) \
-	release_pages((pages), (nr));
+	release_pages((pages), (nr))
+#define free_pages_and_swap_cache_nolru(pages, nr) \
+	release_pages((pages), (nr))
 
 static inline void free_swap_cache(struct page *page)
 {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9..2faa0d59aeca 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -95,11 +95,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 static void __tlb_remove_table_free(struct mmu_table_batch *batch)
 {
-	int i;
-
-	for (i = 0; i < batch->nr; i++)
-		__tlb_remove_table(batch->tables[i]);
-
+	__tlb_remove_tables(batch->tables, batch->nr);
 	free_page((unsigned long)batch);
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..76c3d4a756a3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -307,17 +307,29 @@ void free_page_and_swap_cache(struct page *page)
 
 /*
  * Passed an array of pages, drop them all from swapcache and then release
- * them.  They are removed from the LRU and freed if this is their last use.
+ * them.  They are optionally removed from the LRU and freed if this is their
+ * last use.
  */
-void free_pages_and_swap_cache(struct page **pages, int nr)
+static void __free_pages_and_swap_cache(struct page **pages, int nr,
+		bool do_lru)
 {
-	struct page **pagep = pages;
 	int i;
 
-	lru_add_drain();
+	if (do_lru)
+		lru_add_drain();
 	for (i = 0; i < nr; i++)
-		free_swap_cache(pagep[i]);
-	release_pages(pagep, nr);
+		free_swap_cache(pages[i]);
+	release_pages(pages, nr);
+}
+
+void free_pages_and_swap_cache(struct page **pages, int nr)
+{
+	__free_pages_and_swap_cache(pages, nr, true);
+}
+
+void free_pages_and_swap_cache_nolru(struct page **pages, int nr)
+{
+	__free_pages_and_swap_cache(pages, nr, false);
 }
 
 static inline bool swap_use_vma_readahead(void)
-- 
2.30.2

