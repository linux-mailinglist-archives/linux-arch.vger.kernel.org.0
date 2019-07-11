Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D956505A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 05:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfGKDGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 23:06:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35709 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDGl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 23:06:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2243089plp.2;
        Wed, 10 Jul 2019 20:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2UyoDFeHmP5fnUWQIEY/nqbjSPPX8xRQostYuk+zG0=;
        b=kqEvAV2dqOwtIkQL+OT3w8q2YL1jJaLJ5yebSV3WODlYzHKy+tNrmMayq2SMasEfhU
         v8okYh+50tjnGwjr/0cDsvyvfDXAuGGa5oZto43ZC4ckPawStx/6e94qLcYJLNir0FMa
         Ge0UzOadUMbM/nd0VKnY8MDZzp0GiiebuoDOc+0FaXdkBxZ9epIQ9Zg4/lPeb3gXjnS8
         N31hiJYHayPlikJD1vKlpdqitVknAilpj57cVWYRwM2vpKnqCx2U+UpWP+HRze+Hq/HG
         UTKdxbP3MSif6D7eMmcKALG8KXvxjobds1HW8v74XT2By9LWWj09LbyK5hdpQnKnLFZp
         M48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2UyoDFeHmP5fnUWQIEY/nqbjSPPX8xRQostYuk+zG0=;
        b=n5wDKbx/SKfTfO2KBvUlgW6k1TqMBD92uDtTeRzUJd2iZ6Gywjhk0QPQIWIgp2KaVp
         CTQyvpXzEy28FE1oKhWyUq0v8qkj4bjfk43OuvAwKq0ugJ2B+LTPhF3uQ42dNJuh6K9m
         XZi4MBz3cXIbtIb5qhuXjTJWWHdhBQwP1hMw/DC+quM9eLIq0r/WQgf+gR/dQtz31Zo1
         oXI5T0CTaXe0RI0hyMdn/LxtWf2eENwdAQ6AYgyhnG5PH2L4kfvABViElYKjAuRnDvgi
         TSMHdshZRwXypRKq0KqO8IL8VFh1c9ESMj+jhKw6xGCrzfFKmVwPJ8C//zqnwu4ow8rf
         nkdA==
X-Gm-Message-State: APjAAAVU2kGNRmJflvzjgszpskKZsyuQiTBCPv5yfNxN7X3lXs1NqBIL
        J5XE+EkXh3+mokTIvewREbvnqlGT
X-Google-Smtp-Source: APXvYqxx/PGhwctWgTCH8QNR4PC86ALD3GEZWhWDLkOeKMYV5Q8Ul2QyMlqBCfFNVk45liM+BOJk+g==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr1911597plr.195.1562814399335;
        Wed, 10 Jul 2019 20:06:39 -0700 (PDT)
Received: from bobo.local0.net (203-213-47-85.tpgi.com.au. [203.213.47.85])
        by smtp.gmail.com with ESMTPSA id v13sm4233021pfe.105.2019.07.10.20.06.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 20:06:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
Subject: [RFC PATCH] mm: remove quicklist page table caches
Date:   Thu, 11 Jul 2019 13:03:39 +1000
Message-Id: <20190711030339.20892-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove page table allocator "quicklists". These have been around for a
long time, but have not got much traction in the last decade and are
only used on ia64 and sh architectures.

The numbers in the initial commit look interesting but probably don't
apply anymore. If anybody wants to resurrect this it's in the git
history, but it's unhelpful to have this code and divergent allocator
behaviour for minor archs.

Also it might be better to instead make more general improvements to
page allocator if this is still so slow.
---
 arch/alpha/include/asm/pgalloc.h      |   2 -
 arch/arc/include/asm/pgalloc.h        |   1 -
 arch/arm/include/asm/pgalloc.h        |   2 -
 arch/arm64/include/asm/pgalloc.h      |   2 -
 arch/csky/include/asm/pgalloc.h       |   2 -
 arch/hexagon/include/asm/pgalloc.h    |   2 -
 arch/ia64/Kconfig                     |   4 -
 arch/ia64/include/asm/pgalloc.h       |  32 +++-----
 arch/m68k/include/asm/pgtable_mm.h    |   2 -
 arch/m68k/include/asm/pgtable_no.h    |   2 -
 arch/microblaze/include/asm/pgalloc.h |  89 ++--------------------
 arch/microblaze/mm/pgtable.c          |   4 -
 arch/mips/include/asm/pgalloc.h       |   2 -
 arch/nds32/include/asm/pgalloc.h      |   2 -
 arch/nios2/include/asm/pgalloc.h      |   2 -
 arch/openrisc/include/asm/pgalloc.h   |   2 -
 arch/parisc/include/asm/pgalloc.h     |   2 -
 arch/powerpc/include/asm/pgalloc.h    |   2 -
 arch/riscv/include/asm/pgalloc.h      |   4 -
 arch/s390/include/asm/pgtable.h       |   1 -
 arch/sh/include/asm/pgalloc.h         |  22 ++----
 arch/sh/mm/Kconfig                    |   3 -
 arch/sparc/include/asm/pgalloc_32.h   |   2 -
 arch/sparc/include/asm/pgalloc_64.h   |   2 -
 arch/sparc/mm/init_32.c               |   1 -
 arch/um/include/asm/pgalloc.h         |   2 -
 arch/unicore32/include/asm/pgalloc.h  |   2 -
 arch/x86/include/asm/pgtable_32.h     |   1 -
 arch/x86/include/asm/pgtable_64.h     |   1 -
 arch/xtensa/include/asm/tlbflush.h    |   3 -
 fs/proc/meminfo.c                     |   4 -
 include/asm-generic/pgalloc.h         |   2 -
 include/linux/quicklist.h             |  94 -----------------------
 kernel/sched/idle.c                   |   1 -
 lib/show_mem.c                        |   5 --
 mm/Kconfig                            |   5 --
 mm/Makefile                           |   1 -
 mm/mmu_gather.c                       |   2 -
 mm/quicklist.c                        | 103 --------------------------
 39 files changed, 25 insertions(+), 392 deletions(-)
 delete mode 100644 include/linux/quicklist.h
 delete mode 100644 mm/quicklist.c

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 02f9f91bb4f0..0912e37c3a56 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -87,6 +87,4 @@ pte_free(struct mm_struct *mm, pgtable_t page)
 	__free_page(page);
 }
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _ALPHA_PGALLOC_H */
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 9c9b5a5ebf2e..e35b00e8cc4c 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -132,7 +132,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptep)
 
 #define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
 
-#define check_pgt_cache()   do { } while (0)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
 
 #endif /* _ASM_ARC_PGALLOC_H */
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 17ab72f0cc4e..5e2ec767de8e 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -18,8 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#define check_pgt_cache()		do { } while (0)
-
 #ifdef CONFIG_MMU
 
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index dabba4b2c61f..6554426d4953 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -24,8 +24,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#define check_pgt_cache()		do { } while (0)
-
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index d213bb47b717..21533eb04747 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -99,8 +99,6 @@ do {							\
 	tlb_remove_page(tlb, pte);			\
 } while (0)
 
-#define check_pgt_cache()	do {} while (0)
-
 extern void pagetable_init(void);
 extern void pre_mmu_init(void);
 extern void pre_trap_init(void);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index d36183887b60..1ee911d79bad 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -24,8 +24,6 @@
 #include <asm/mem-layout.h>
 #include <asm/atomic.h>
 
-#define check_pgt_cache() do {} while (0)
-
 extern unsigned long long kmap_generation;
 
 /*
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 73a26f04644e..e910cc44e1c3 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -69,10 +69,6 @@ config ZONE_DMA32
 	def_bool y
 	depends on !IA64_SGI_SN2
 
-config QUICKLIST
-	bool
-	default y
-
 config MMU
 	bool
 	default y
diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index c9e481023c25..ffd58bab8a76 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -19,18 +19,17 @@
 #include <linux/mm.h>
 #include <linux/page-flags.h>
 #include <linux/threads.h>
-#include <linux/quicklist.h>
 
 #include <asm/mmu_context.h>
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	quicklist_free(0, NULL, pgd);
+	__free_page(pgd);
 }
 
 #if CONFIG_PGTABLE_LEVELS == 4
@@ -42,12 +41,12 @@ pgd_populate(struct mm_struct *mm, pgd_t * pgd_entry, pud_t * pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return (pud_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	quicklist_free(0, NULL, pud);
+	__free_page(pud);
 }
 #define __pud_free_tlb(tlb, pud, address)	pud_free((tlb)->mm, pud)
 #endif /* CONFIG_PGTABLE_LEVELS == 4 */
@@ -60,12 +59,12 @@ pud_populate(struct mm_struct *mm, pud_t * pud_entry, pmd_t * pmd)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return (pmd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	quicklist_free(0, NULL, pmd);
+	__free_page(pmd);
 }
 
 #define __pmd_free_tlb(tlb, pmd, address)	pmd_free((tlb)->mm, pmd)
@@ -86,14 +85,12 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmd_entry, pte_t * pte)
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page;
-	void *pg;
 
-	pg = quicklist_alloc(0, GFP_KERNEL, NULL);
-	if (!pg)
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
 		return NULL;
-	page = virt_to_page(pg);
 	if (!pgtable_page_ctor(page)) {
-		quicklist_free(0, NULL, pg);
+		free_page(page);
 		return NULL;
 	}
 	return page;
@@ -101,23 +98,18 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
 	pgtable_page_dtor(pte);
-	quicklist_free_page(0, NULL, pte);
+	__free_page(pte);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	quicklist_free(0, NULL, pte);
-}
-
-static inline void check_pgt_cache(void)
-{
-	quicklist_trim(0, NULL, 25, 16);
+	free_page(pte);
 }
 
 #define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index fe3ddd73a0cc..b5269f1ce313 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -178,6 +178,4 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 #define pgtable_cache_init()	do { } while (0)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _M68K_PGTABLE_H */
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c77bd8..69e271101223 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -60,6 +60,4 @@ extern void paging_init(void);
 
 #include <asm-generic/pgtable.h>
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _M68KNOMMU_PGTABLE_H */
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index f4cc9ffc449e..c62837073c14 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -21,83 +21,20 @@
 #include <asm/cache.h>
 #include <asm/pgtable.h>
 
-#define PGDIR_ORDER	0
-
-/*
- * This is handled very differently on MicroBlaze since out page tables
- * are all 0's and I want to be able to use these zero'd pages elsewhere
- * as well - it gives us quite a speedup.
- * -- Cort
- */
-extern struct pgtable_cache_struct {
-	unsigned long *pgd_cache;
-	unsigned long *pte_cache;
-	unsigned long pgtable_cache_sz;
-} quicklists;
-
-#define pgd_quicklist		(quicklists.pgd_cache)
-#define pmd_quicklist		((unsigned long *)0)
-#define pte_quicklist		(quicklists.pte_cache)
-#define pgtable_cache_size	(quicklists.pgtable_cache_sz)
-
-extern unsigned long *zero_cache; /* head linked list of pre-zero'd pages */
-extern atomic_t zero_sz; /* # currently pre-zero'd pages */
-extern atomic_t zeropage_hits; /* # zero'd pages request that we've done */
-extern atomic_t zeropage_calls; /* # zero'd pages request that've been made */
-extern atomic_t zerototal; /* # pages zero'd over time */
-
-#define zero_quicklist		(zero_cache)
-#define zero_cache_sz	 	(zero_sz)
-#define zero_cache_calls	(zeropage_calls)
-#define zero_cache_hits		(zeropage_hits)
-#define zero_cache_total	(zerototal)
-
-/*
- * return a pre-zero'd page from the list,
- * return NULL if none available -- Cort
- */
-extern unsigned long get_zero_page_fast(void);
-
 extern void __bad_pte(pmd_t *pmd);
 
-static inline pgd_t *get_pgd_slow(void)
+static inline pgd_t *get_pgd(void)
 {
-	pgd_t *ret;
-
-	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGDIR_ORDER);
-	if (ret != NULL)
-		clear_page(ret);
-	return ret;
+	return (pgd_t *)__get_free_pages(GFP_KERNEL|GFP_ZERO, 0);
 }
 
-static inline pgd_t *get_pgd_fast(void)
-{
-	unsigned long *ret;
-
-	ret = pgd_quicklist;
-	if (ret != NULL) {
-		pgd_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	} else
-		ret = (unsigned long *)get_pgd_slow();
-	return (pgd_t *)ret;
-}
-
-static inline void free_pgd_fast(pgd_t *pgd)
-{
-	*(unsigned long **)pgd = pgd_quicklist;
-	pgd_quicklist = (unsigned long *) pgd;
-	pgtable_cache_size++;
-}
-
-static inline void free_pgd_slow(pgd_t *pgd)
+static inline void free_pgd(pgd_t *pgd)
 {
 	free_page((unsigned long)pgd);
 }
 
-#define pgd_free(mm, pgd)        free_pgd_fast(pgd)
-#define pgd_alloc(mm)		get_pgd_fast()
+#define pgd_free(mm, pgd)	free_pgd(pgd)
+#define pgd_alloc(mm)		get_pgd()
 
 #define pmd_pgtable(pmd)	pmd_page(pmd)
 
@@ -115,15 +52,14 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
 	struct page *ptepage;
 
 #ifdef CONFIG_HIGHPTE
-	int flags = GFP_KERNEL | __GFP_HIGHMEM;
+	int flags = GFP_KERNEL | GFP_ZERO | __GFP_HIGHMEM;
 #else
-	int flags = GFP_KERNEL;
+	int flags = GFP_KERNEL | GFP_ZERO;
 #endif
 
 	ptepage = alloc_pages(flags, 0);
 	if (!ptepage)
 		return NULL;
-	clear_highpage(ptepage);
 	if (!pgtable_page_ctor(ptepage)) {
 		__free_page(ptepage);
 		return NULL;
@@ -131,13 +67,6 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
 	return ptepage;
 }
 
-static inline void pte_free_fast(pte_t *pte)
-{
-	*(unsigned long **)pte = pte_quicklist;
-	pte_quicklist = (unsigned long *) pte;
-	pgtable_cache_size++;
-}
-
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
@@ -171,10 +100,6 @@ static inline void pte_free(struct mm_struct *mm, struct page *ptepage)
 #define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
 #define pgd_populate(mm, pmd, pte)	BUG()
 
-extern int do_check_pgt_cache(int, int);
-
 #endif /* CONFIG_MMU */
 
-#define check_pgt_cache()		do { } while (0)
-
 #endif /* _ASM_MICROBLAZE_PGALLOC_H */
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 8fe54fda31dc..010bb9cee2e4 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -44,10 +44,6 @@ unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);
 
-#ifndef CONFIG_SMP
-struct pgtable_cache_struct quicklists;
-#endif
-
 static void __iomem *__ioremap(phys_addr_t addr, unsigned long size,
 		unsigned long flags)
 {
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 27808d9461f4..fbaddb12ea2b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -134,8 +134,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
-#define check_pgt_cache()	do { } while (0)
-
 extern void pagetable_init(void);
 
 #endif /* _ASM_PGALLOC_H */
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 3c5fee5b5759..95fee5f930c0 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -20,8 +20,6 @@
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
 
-#define check_pgt_cache()		do { } while (0)
-
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *pte;
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 3a149ead1207..58417affacbc 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -78,6 +78,4 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte)
 		tlb_remove_page((tlb), (pte));			\
 	} while (0)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 149c82ee4b8b..dafc6f5aee6a 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -105,6 +105,4 @@ do {					\
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-#define check_pgt_cache()          do { } while (0)
-
 #endif
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index ea75cc966dae..ee042753fbb4 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -153,6 +153,4 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte)
 	pte_free_kernel(mm, page_address(pte));
 }
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 2b2c60a1a66d..6dd78a2dc03a 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -64,8 +64,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
-static inline void check_pgt_cache(void) { }
-
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
 #else
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 94043cf83c90..5b6a4a07d130 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -115,8 +115,4 @@ do {                                    \
 	tlb_remove_page((tlb), pte);    \
 } while (0)
 
-static inline void check_pgt_cache(void)
-{
-}
-
 #endif /* _ASM_RISCV_PGALLOC_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9f0195d5fa16..938472aa084c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1691,7 +1691,6 @@ extern void s390_reset_cmma(struct mm_struct *mm);
  * No page table caches to initialise
  */
 static inline void pgtable_cache_init(void) { }
-static inline void check_pgt_cache(void) { }
 
 #include <asm-generic/pgtable.h>
 
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index b56f908b1395..160308a35fa3 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,11 +2,8 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
-#include <linux/quicklist.h>
 #include <asm/page.h>
 
-#define QUICK_PT 0	/* Other page table pages that are zero on free */
-
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
@@ -34,20 +31,18 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
  */
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return quicklist_alloc(QUICK_PT, GFP_KERNEL, NULL);
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page;
-	void *pg;
 
-	pg = quicklist_alloc(QUICK_PT, GFP_KERNEL, NULL);
-	if (!pg)
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
 		return NULL;
-	page = virt_to_page(pg);
 	if (!pgtable_page_ctor(page)) {
-		quicklist_free(QUICK_PT, NULL, pg);
+		free_page(page);
 		return NULL;
 	}
 	return page;
@@ -55,13 +50,13 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	quicklist_free(QUICK_PT, NULL, pte);
+	free_page(pte);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
 	pgtable_page_dtor(pte);
-	quicklist_free_page(QUICK_PT, NULL, pte);
+	__free_page(pte);
 }
 
 #define __pte_free_tlb(tlb,pte,addr)			\
@@ -79,9 +74,4 @@ do {							\
 } while (0);
 #endif
 
-static inline void check_pgt_cache(void)
-{
-	quicklist_trim(QUICK_PT, NULL, 25, 16);
-}
-
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 02ed2df25a54..5c8a2ebfc720 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Memory management options"
 
-config QUICKLIST
-	def_bool y
-
 config MMU
         bool "Support for memory management hardware"
 	depends on !CPU_SH2
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 282be50a4adf..10538a4d1a1e 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -17,8 +17,6 @@ void srmmu_free_nocache(void *addr, int size);
 
 extern struct resource sparc_iomap;
 
-#define check_pgt_cache()	do { } while (0)
-
 pgd_t *get_pgd_fast(void);
 static inline void free_pgd_fast(pgd_t *pgd)
 {
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 48abccba4991..9d3e5cc95bbb 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -69,8 +69,6 @@ void pte_free(struct mm_struct *mm, pgtable_t ptepage);
 #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
 #define pmd_pgtable(PMD)			((pte_t *)__pmd_page(PMD))
 
-#define check_pgt_cache()	do { } while (0)
-
 void pgtable_free(void *table, bool is_page);
 
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index a8ff29821bdb..5f482e6e2ad1 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -31,7 +31,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/vaddrs.h>
-#include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
 #include <asm/setup.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 99eb5682792a..d601937b632b 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -55,7 +55,5 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 #define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_page(x))
 #endif
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif
 
diff --git a/arch/unicore32/include/asm/pgalloc.h b/arch/unicore32/include/asm/pgalloc.h
index 7cceabecf4e3..56056e2369a4 100644
--- a/arch/unicore32/include/asm/pgalloc.h
+++ b/arch/unicore32/include/asm/pgalloc.h
@@ -17,8 +17,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#define check_pgt_cache()		do { } while (0)
-
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_PRESENT)
 #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_PRESENT)
 
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 4fe9e7fc74d3..7d0c8cac88a8 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -30,7 +30,6 @@ extern pgd_t initial_page_table[1024];
 extern pmd_t initial_pg_pmd[];
 
 static inline void pgtable_cache_init(void) { }
-static inline void check_pgt_cache(void) { }
 void paging_init(void);
 void sync_initial_page_table(void);
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 0bb566315621..08b1106834eb 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -242,7 +242,6 @@ extern void cleanup_highmap(void);
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
 #define pgtable_cache_init()   do { } while (0)
-#define check_pgt_cache()      do { } while (0)
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index 06875feb27c2..856e2da2e397 100644
--- a/arch/xtensa/include/asm/tlbflush.h
+++ b/arch/xtensa/include/asm/tlbflush.h
@@ -160,9 +160,6 @@ static inline void invalidate_dtlb_mapping (unsigned address)
 		invalidate_dtlb_entry(tlb_entry);
 }
 
-#define check_pgt_cache()	do { } while (0)
-
-
 /*
  * DO NOT USE THESE FUNCTIONS.  These instructions aren't part of the Xtensa
  * ISA and exist only for test purposes..
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..131bca8db1a1 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -8,7 +8,6 @@
 #include <linux/mmzone.h>
 #include <linux/proc_fs.h>
 #include <linux/percpu.h>
-#include <linux/quicklist.h>
 #include <linux/seq_file.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
@@ -106,9 +105,6 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   global_zone_page_state(NR_KERNEL_STACK_KB));
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
-#ifdef CONFIG_QUICKLIST
-	show_val_kb(m, "Quicklists:     ", quicklist_total_size());
-#endif
 
 	show_val_kb(m, "NFS_Unstable:   ",
 		    global_node_page_state(NR_UNSTABLE_NFS));
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 948714c1535a..500feb7b838a 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -8,6 +8,4 @@
 #error need to implement an architecture specific asm/pgalloc.h
 #endif
 
-#define check_pgt_cache()          do { } while (0)
-
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/include/linux/quicklist.h b/include/linux/quicklist.h
deleted file mode 100644
index 034982c98c8b..000000000000
--- a/include/linux/quicklist.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_QUICKLIST_H
-#define LINUX_QUICKLIST_H
-/*
- * Fast allocations and disposal of pages. Pages must be in the condition
- * as needed after allocation when they are freed. Per cpu lists of pages
- * are kept that only contain node local pages.
- *
- * (C) 2007, SGI. Christoph Lameter <cl@linux.com>
- */
-#include <linux/kernel.h>
-#include <linux/gfp.h>
-#include <linux/percpu.h>
-
-#ifdef CONFIG_QUICKLIST
-
-struct quicklist {
-	void *page;
-	int nr_pages;
-};
-
-DECLARE_PER_CPU(struct quicklist, quicklist)[CONFIG_NR_QUICK];
-
-/*
- * The two key functions quicklist_alloc and quicklist_free are inline so
- * that they may be custom compiled for the platform.
- * Specifying a NULL ctor can remove constructor support. Specifying
- * a constant quicklist allows the determination of the exact address
- * in the per cpu area.
- *
- * The fast patch in quicklist_alloc touched only a per cpu cacheline and
- * the first cacheline of the page itself. There is minmal overhead involved.
- */
-static inline void *quicklist_alloc(int nr, gfp_t flags, void (*ctor)(void *))
-{
-	struct quicklist *q;
-	void **p = NULL;
-
-	q =&get_cpu_var(quicklist)[nr];
-	p = q->page;
-	if (likely(p)) {
-		q->page = p[0];
-		p[0] = NULL;
-		q->nr_pages--;
-	}
-	put_cpu_var(quicklist);
-	if (likely(p))
-		return p;
-
-	p = (void *)__get_free_page(flags | __GFP_ZERO);
-	if (ctor && p)
-		ctor(p);
-	return p;
-}
-
-static inline void __quicklist_free(int nr, void (*dtor)(void *), void *p,
-	struct page *page)
-{
-	struct quicklist *q;
-
-	q = &get_cpu_var(quicklist)[nr];
-	*(void **)p = q->page;
-	q->page = p;
-	q->nr_pages++;
-	put_cpu_var(quicklist);
-}
-
-static inline void quicklist_free(int nr, void (*dtor)(void *), void *pp)
-{
-	__quicklist_free(nr, dtor, pp, virt_to_page(pp));
-}
-
-static inline void quicklist_free_page(int nr, void (*dtor)(void *),
-							struct page *page)
-{
-	__quicklist_free(nr, dtor, page_address(page), page);
-}
-
-void quicklist_trim(int nr, void (*dtor)(void *),
-	unsigned long min_pages, unsigned long max_free);
-
-unsigned long quicklist_total_size(void);
-
-#else
-
-static inline unsigned long quicklist_total_size(void)
-{
-	return 0;
-}
-
-#endif
-
-#endif /* LINUX_QUICKLIST_H */
-
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..8fb03bc55e69 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -237,7 +237,6 @@ static void do_idle(void)
 	tick_nohz_idle_enter();
 
 	while (!need_resched()) {
-		check_pgt_cache();
 		rmb();
 
 		if (cpu_is_offline(cpu)) {
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 6a042f53e7bb..b0950ab534ab 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/mm.h>
-#include <linux/quicklist.h>
 #include <linux/cma.h>
 
 void show_mem(unsigned int filter, nodemask_t *nodemask)
@@ -39,10 +38,6 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_CMA
 	printk("%lu pages cma reserved\n", totalcma_pages);
 #endif
-#ifdef CONFIG_QUICKLIST
-	printk("%lu pages in pagetable cache\n",
-		quicklist_total_size());
-#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..971cc961453e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -271,11 +271,6 @@ config BOUNCE
 	  by default when ZONE_DMA or HIGHMEM is selected, but you
 	  may say n to override this.
 
-config NR_QUICK
-	int
-	depends on QUICKLIST
-	default "1"
-
 config VIRT_TO_BUS
 	bool
 	help
diff --git a/mm/Makefile b/mm/Makefile
index d210cc9d6f80..f6ea80fd9329 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -67,7 +67,6 @@ obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-obj-$(CONFIG_QUICKLIST) += quicklist.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99740e1dd273..093196839b6e 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -257,8 +257,6 @@ void tlb_finish_mmu(struct mmu_gather *tlb,
 
 	tlb_flush_mmu(tlb);
 
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
 #endif
diff --git a/mm/quicklist.c b/mm/quicklist.c
deleted file mode 100644
index 5e98ac78e410..000000000000
--- a/mm/quicklist.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Quicklist support.
- *
- * Quicklists are light weight lists of pages that have a defined state
- * on alloc and free. Pages must be in the quicklist specific defined state
- * (zero by default) when the page is freed. It seems that the initial idea
- * for such lists first came from Dave Miller and then various other people
- * improved on it.
- *
- * Copyright (C) 2007 SGI,
- * 	Christoph Lameter <cl@linux.com>
- * 		Generalized, added support for multiple lists and
- * 		constructors / destructors.
- */
-#include <linux/kernel.h>
-
-#include <linux/gfp.h>
-#include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/quicklist.h>
-
-DEFINE_PER_CPU(struct quicklist [CONFIG_NR_QUICK], quicklist);
-
-#define FRACTION_OF_NODE_MEM	16
-
-static unsigned long max_pages(unsigned long min_pages)
-{
-	unsigned long node_free_pages, max;
-	int node = numa_node_id();
-	struct zone *zones = NODE_DATA(node)->node_zones;
-	int num_cpus_on_node;
-
-	node_free_pages =
-#ifdef CONFIG_ZONE_DMA
-		zone_page_state(&zones[ZONE_DMA], NR_FREE_PAGES) +
-#endif
-#ifdef CONFIG_ZONE_DMA32
-		zone_page_state(&zones[ZONE_DMA32], NR_FREE_PAGES) +
-#endif
-		zone_page_state(&zones[ZONE_NORMAL], NR_FREE_PAGES);
-
-	max = node_free_pages / FRACTION_OF_NODE_MEM;
-
-	num_cpus_on_node = cpumask_weight(cpumask_of_node(node));
-	max /= num_cpus_on_node;
-
-	return max(max, min_pages);
-}
-
-static long min_pages_to_free(struct quicklist *q,
-	unsigned long min_pages, long max_free)
-{
-	long pages_to_free;
-
-	pages_to_free = q->nr_pages - max_pages(min_pages);
-
-	return min(pages_to_free, max_free);
-}
-
-/*
- * Trim down the number of pages in the quicklist
- */
-void quicklist_trim(int nr, void (*dtor)(void *),
-	unsigned long min_pages, unsigned long max_free)
-{
-	long pages_to_free;
-	struct quicklist *q;
-
-	q = &get_cpu_var(quicklist)[nr];
-	if (q->nr_pages > min_pages) {
-		pages_to_free = min_pages_to_free(q, min_pages, max_free);
-
-		while (pages_to_free > 0) {
-			/*
-			 * We pass a gfp_t of 0 to quicklist_alloc here
-			 * because we will never call into the page allocator.
-			 */
-			void *p = quicklist_alloc(nr, 0, NULL);
-
-			if (dtor)
-				dtor(p);
-			free_page((unsigned long)p);
-			pages_to_free--;
-		}
-	}
-	put_cpu_var(quicklist);
-}
-
-unsigned long quicklist_total_size(void)
-{
-	unsigned long count = 0;
-	int cpu;
-	struct quicklist *ql, *q;
-
-	for_each_online_cpu(cpu) {
-		ql = per_cpu(quicklist, cpu);
-		for (q = ql; q < ql + CONFIG_NR_QUICK; q++)
-			count += q->nr_pages;
-	}
-	return count;
-}
-
-- 
2.20.1

