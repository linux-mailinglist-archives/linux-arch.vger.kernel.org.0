Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970F085C10
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfHHHw0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 03:52:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731657AbfHHHwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Aug 2019 03:52:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x787qF2D019713
        for <linux-arch@vger.kernel.org>; Thu, 8 Aug 2019 03:52:23 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8cjqxy9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2019 03:52:23 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Aug 2019 08:52:19 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 08:52:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x787qDN436765734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 07:52:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC61652051;
        Thu,  8 Aug 2019 07:52:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0A93852050;
        Thu,  8 Aug 2019 07:52:11 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 08 Aug 2019 10:52:11 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/3] mm: remove quicklist page table caches
Date:   Thu,  8 Aug 2019 10:52:06 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
References: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080807-0020-0000-0000-0000035D2ABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080807-0021-0000-0000-000021B22C73
Message-Id: <1565250728-21721-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Remove page table allocator "quicklists". These have been around for a
long time, but have not got much traction in the last decade and are
only used on ia64 and sh architectures.

The numbers in the initial commit look interesting but probably don't
apply anymore. If anybody wants to resurrect this it's in the git
history, but it's unhelpful to have this code and divergent allocator
behaviour for minor archs.

Also it might be better to instead make more general improvements to
page allocator if this is still so slow.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/pgalloc.h      |   2 -
 arch/arc/include/asm/pgalloc.h        |   1 -
 arch/arm/include/asm/pgalloc.h        |   2 -
 arch/arm64/include/asm/pgalloc.h      |   2 -
 arch/csky/include/asm/pgalloc.h       |   2 -
 arch/hexagon/include/asm/pgalloc.h    |   2 -
 arch/ia64/Kconfig                     |   4 --
 arch/ia64/include/asm/pgalloc.h       |  32 ++++-------
 arch/m68k/include/asm/pgtable_mm.h    |   2 -
 arch/m68k/include/asm/pgtable_no.h    |   2 -
 arch/microblaze/include/asm/pgalloc.h |  89 +++--------------------------
 arch/microblaze/mm/pgtable.c          |   4 --
 arch/mips/include/asm/pgalloc.h       |   2 -
 arch/nds32/include/asm/pgalloc.h      |   2 -
 arch/nios2/include/asm/pgalloc.h      |   2 -
 arch/openrisc/include/asm/pgalloc.h   |   2 -
 arch/parisc/include/asm/pgalloc.h     |   2 -
 arch/powerpc/include/asm/pgalloc.h    |   2 -
 arch/riscv/include/asm/pgalloc.h      |   4 --
 arch/s390/include/asm/pgtable.h       |   1 -
 arch/sh/include/asm/pgalloc.h         |  22 ++------
 arch/sh/mm/Kconfig                    |   3 -
 arch/sparc/include/asm/pgalloc_32.h   |   2 -
 arch/sparc/include/asm/pgalloc_64.h   |   2 -
 arch/sparc/mm/init_32.c               |   1 -
 arch/um/include/asm/pgalloc.h         |   2 -
 arch/unicore32/include/asm/pgalloc.h  |   2 -
 arch/x86/include/asm/pgtable_32.h     |   1 -
 arch/x86/include/asm/pgtable_64.h     |   1 -
 arch/xtensa/include/asm/tlbflush.h    |   3 -
 fs/proc/meminfo.c                     |   4 --
 include/asm-generic/pgalloc.h         |   5 --
 include/linux/quicklist.h             |  94 -------------------------------
 kernel/sched/idle.c                   |   1 -
 lib/show_mem.c                        |   5 --
 mm/Kconfig                            |   5 --
 mm/Makefile                           |   1 -
 mm/mmu_gather.c                       |   2 -
 mm/quicklist.c                        | 103 ----------------------------------
 39 files changed, 25 insertions(+), 395 deletions(-)
 delete mode 100644 include/linux/quicklist.h
 delete mode 100644 mm/quicklist.c

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 71ded3b..eb91f1e 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -53,6 +53,4 @@ pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	free_page((unsigned long)pmd);
 }
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _ALPHA_PGALLOC_H */
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 9bdb8ed..4751f22 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -129,7 +129,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptep)
 
 #define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
 
-#define check_pgt_cache()   do { } while (0)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
 
 #endif /* _ASM_ARC_PGALLOC_H */
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a2a68b7..069da39 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -15,8 +15,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#define check_pgt_cache()		do { } while (0)
-
 #ifdef CONFIG_MMU
 
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 14d0bc4..172d76f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -15,8 +15,6 @@
 
 #include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
 
-#define check_pgt_cache()		do { } while (0)
-
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 98c571670..d089113 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -75,8 +75,6 @@ do {							\
 	tlb_remove_page(tlb, pte);			\
 } while (0)
 
-#define check_pgt_cache()	do {} while (0)
-
 extern void pagetable_init(void);
 extern void pre_mmu_init(void);
 extern void pre_trap_init(void);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index d6544dc..5a6e79e 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -13,8 +13,6 @@
 
 #include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
 
-#define check_pgt_cache() do {} while (0)
-
 extern unsigned long long kmap_generation;
 
 /*
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7468d8e..69bb405 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -68,10 +68,6 @@ config ZONE_DMA32
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
index c9e4810..b03d993 100644
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
+	free_page((unsigned long)pgd);
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
+	free_page((unsigned long)pud);
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
+	free_page((unsigned long)pmd);
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
+		__free_page(page);
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
+	free_page((unsigned long)pte);
 }
 
 #define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index fe3ddd7..b5269f1 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -178,6 +178,4 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 #define pgtable_cache_init()	do { } while (0)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _M68K_PGTABLE_H */
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c..69e2711 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -60,6 +60,4 @@ extern void paging_init(void);
 
 #include <asm-generic/pgtable.h>
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _M68KNOMMU_PGTABLE_H */
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index f4cc9ff..ac07318 100644
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
+	return (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
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
+	int flags = GFP_KERNEL | __GFP_ZERO | __GFP_HIGHMEM;
 #else
-	int flags = GFP_KERNEL;
+	int flags = GFP_KERNEL | __GFP_ZERO;
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
index 8fe54fd..010bb9c 100644
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
index aa16b85..aa73cb1 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -105,8 +105,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
-#define check_pgt_cache()	do { } while (0)
-
 extern void pagetable_init(void);
 
 #endif /* _ASM_PGALLOC_H */
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index e78b43d..37125e6 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -23,8 +23,6 @@
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
 
-#define check_pgt_cache()		do { } while (0)
-
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	pgtable_t pte;
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 4bc8cf7..750d18d 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -45,6 +45,4 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 		tlb_remove_page((tlb), (pte));			\
 	} while (0)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3d4b397c..787c1b9 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -101,6 +101,4 @@ do {					\
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-#define check_pgt_cache()          do { } while (0)
-
 #endif
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 4f2059a..d98647c 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -124,6 +124,4 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 2b2c60a..6dd78a2 100644
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
index 56a67d6..f66a00d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -82,8 +82,4 @@ do {                                    \
 	tlb_remove_page((tlb), pte);    \
 } while (0)
 
-static inline void check_pgt_cache(void)
-{
-}
-
 #endif /* _ASM_RISCV_PGALLOC_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9b274fc..c3309ef 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1685,7 +1685,6 @@ extern void s390_reset_cmma(struct mm_struct *mm);
  * No page table caches to initialise
  */
 static inline void pgtable_cache_init(void) { }
-static inline void check_pgt_cache(void) { }
 
 #include <asm-generic/pgtable.h>
 
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index b56f908..9e15054 100644
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
+		__free_page(page);
 		return NULL;
 	}
 	return page;
@@ -55,13 +50,13 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	quicklist_free(QUICK_PT, NULL, pte);
+	free_page((unsigned long)pte);
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
index 02ed2df..5c8a2eb 100644
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
index 282be50..10538a4 100644
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
index 48abccb..9d3e5cc 100644
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
index 046ab11..906eda11 100644
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
index d7b282e..7104b05 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -43,7 +43,5 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 #define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_page(x))
 #endif
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif
 
diff --git a/arch/unicore32/include/asm/pgalloc.h b/arch/unicore32/include/asm/pgalloc.h
index 3f0903b..ba1c9a7 100644
--- a/arch/unicore32/include/asm/pgalloc.h
+++ b/arch/unicore32/include/asm/pgalloc.h
@@ -18,8 +18,6 @@
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #include <asm-generic/pgalloc.h>
 
-#define check_pgt_cache()		do { } while (0)
-
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_PRESENT)
 #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_PRESENT)
 
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index c78da8e..b9b9f8a 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -30,7 +30,6 @@ extern pgd_t initial_page_table[1024];
 extern pmd_t initial_pg_pmd[];
 
 static inline void pgtable_cache_init(void) { }
-static inline void check_pgt_cache(void) { }
 void paging_init(void);
 void sync_initial_page_table(void);
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 4990d26..a26d2d5 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -242,7 +242,6 @@ extern void cleanup_highmap(void);
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
 #define pgtable_cache_init()   do { } while (0)
-#define check_pgt_cache()      do { } while (0)
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index 06875feb..856e2da 100644
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
index 465ea01..4bd80e6 100644
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
index 8476175..6f8cc06 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -102,11 +102,6 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 	__free_page(pte_page);
 }
 
-#else /* CONFIG_MMU */
-
-/* This is enough for a nommu architecture */
-#define check_pgt_cache()          do { } while (0)
-
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/include/linux/quicklist.h b/include/linux/quicklist.h
deleted file mode 100644
index 034982c..0000000
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
index 8094093..aa796cb 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -238,7 +238,6 @@ static void do_idle(void)
 	tick_nohz_idle_enter();
 
 	while (!need_resched()) {
-		check_pgt_cache();
 		rmb();
 
 		if (cpu_is_offline(cpu)) {
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 5c86ef4..1c26c14 100644
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
index 56cec63..a8519e7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -273,11 +273,6 @@ config BOUNCE
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
index d0b295c..d11de59 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-obj-$(CONFIG_QUICKLIST) += quicklist.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 8c943a6..7d70e5c 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -271,8 +271,6 @@ void tlb_finish_mmu(struct mmu_gather *tlb,
 
 	tlb_flush_mmu(tlb);
 
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
 #endif
diff --git a/mm/quicklist.c b/mm/quicklist.c
deleted file mode 100644
index 5e98ac7..0000000
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
2.7.4

