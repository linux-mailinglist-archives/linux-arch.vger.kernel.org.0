Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A420C248
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgF0Ofo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgF0Ofm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:35:42 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D816420757;
        Sat, 27 Jun 2020 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268539;
        bh=j5xZgcFfVTDxdq8ek7evbbCRwziPSxC5JN7pXp1Ub14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IubaLiwxkYxVnX9ncXuZNkotQ5Sy0iy0AbkVzMsj3Hja3T1qb8aMO2mz6b1Mfc9ow
         cdHmfpTYNUSXleIP/cXyBxeSzcyWvj00xb/snuyWSZjho5Y/wHAu+Oi5FOEtbuN/PM
         fLrpGjpAltlgtqn1F/Cv0pYDHNRLBxMmFkMavFSQ=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 4/8] asm-generic: pgalloc: provide generic pmd_alloc_one() and pmd_free_one()
Date:   Sat, 27 Jun 2020 17:34:49 +0300
Message-Id: <20200627143453.31835-5-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

For most architectures that support >2 levels of page tables,
pmd_alloc_one() is a wrapper for __get_free_pages(), sometimes with
__GFP_ZERO and sometimes followed by memset(0) instead.

More elaborate versions on arm64 and x86 account memory for the user page
tables and call to pgtable_pmd_page_ctor() as the part of PMD page
initialization.

Move the arm64 version to include/asm-generic/pgalloc.h and use the generic
version on several architectures.

The pgtable_pmd_page_ctor() is a NOP when ARCH_ENABLE_SPLIT_PMD_PTLOCK is
not enabled, so there is no functional change for most architectures except
of the addition of __GFP_ACCOUNT for allocation of user page tables.

The pmd_free() is a wrapper for free_page() in all the cases, so no
functional change here.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/pgalloc.h     | 15 +---------
 arch/arm/include/asm/pgalloc.h       | 11 -------
 arch/arm64/include/asm/pgalloc.h     | 27 +----------------
 arch/ia64/include/asm/pgalloc.h      | 10 -------
 arch/mips/include/asm/pgalloc.h      |  8 ++----
 arch/parisc/include/asm/pgalloc.h    | 11 ++-----
 arch/riscv/include/asm/pgalloc.h     | 13 +--------
 arch/sh/include/asm/pgalloc.h        |  3 ++
 arch/um/include/asm/pgalloc.h        |  8 +-----
 arch/um/include/asm/pgtable-3level.h |  3 --
 arch/um/kernel/mem.c                 | 12 --------
 arch/x86/include/asm/pgalloc.h       | 26 +----------------
 include/asm-generic/pgalloc.h        | 43 ++++++++++++++++++++++++++++
 13 files changed, 55 insertions(+), 135 deletions(-)

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index a1a29f60934c..4834cd52e9d0 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -5,7 +5,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 /*      
  * Allocate and free page tables. The xxx_kernel() versions are
@@ -40,17 +40,4 @@ pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long)pgd);
 }
 
-static inline pmd_t *
-pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	pmd_t *ret = (pmd_t *)__get_free_page(GFP_PGTABLE_USER);
-	return ret;
-}
-
-static inline void
-pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_page((unsigned long)pmd);
-}
-
 #endif /* _ALPHA_PGALLOC_H */
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 069da393110c..c5bdfd404ea5 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -22,17 +22,6 @@
 
 #ifdef CONFIG_ARM_LPAE
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return (pmd_t *)get_zeroed_page(GFP_KERNEL);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	free_page((unsigned long)pmd);
-}
-
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
 	set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 58e93583ddb6..7246d0a662e1 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -13,37 +13,12 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	gfp_t gfp = GFP_PGTABLE_USER;
-	struct page *page;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-
-	page = alloc_page(gfp);
-	if (!page)
-		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page_address(page);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
-{
-	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
-	pgtable_pmd_page_dtor(virt_to_page(pmdp));
-	free_page((unsigned long)pmdp);
-}
-
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
 	set_pud(pudp, __pud(__phys_to_pud_val(pmdp) | prot));
diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index 2a3050345099..5da1fc76477b 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -59,16 +59,6 @@ pud_populate(struct mm_struct *mm, pud_t * pud_entry, pmd_t * pmd)
 	pud_val(*pud_entry) = __pa(pmd);
 }
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return (pmd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_page((unsigned long)pmd);
-}
-
 #define __pmd_free_tlb(tlb, pmd, address)	pmd_free((tlb)->mm, pmd)
 
 static inline void
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index fa77cb71f303..eed1b3e8c642 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -13,7 +13,8 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#define __HAVE_ARCH_PMD_ALLOC_ONE
+#include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte)
@@ -70,11 +71,6 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	return pmd;
 }
 
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_pages((unsigned long)pmd, PMD_ORDER);
-}
-
 #define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
 
 #endif
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 9ac74da256b8..689766b914ed 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -10,7 +10,8 @@
 
 #include <asm/cache.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#define __HAVE_ARCH_PMD_FREE
+#include <asm-generic/pgalloc.h>
 
 /* Allocate the top level pgd (page directory)
  *
@@ -65,14 +66,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
 }
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	pmd_t *pmd = (pmd_t *)__get_free_pages(GFP_KERNEL, PMD_ORDER);
-	if (pmd)
-		memset(pmd, 0, PAGE_SIZE<<PMD_ORDER);
-	return pmd;
-}
-
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 3f601ee8233f..8d3135f05b8e 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -11,7 +11,7 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
 	pmd_t *pmd, pte_t *pte)
@@ -62,17 +62,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return (pmd_t *)__get_free_page(
-		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_page((unsigned long)pmd);
-}
-
 #define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 22d968bfe9bb..59263df76f51 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -3,6 +3,9 @@
 #define __ASM_SH_PGALLOC_H
 
 #include <asm/page.h>
+
+#define __HAVE_ARCH_PMD_ALLOC_ONE
+#define __HAVE_ARCH_PMD_FREE
 #include <asm-generic/pgalloc.h>
 
 extern pgd_t *pgd_alloc(struct mm_struct *);
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 881e76da1938..bdde433dbdec 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -10,7 +10,7 @@
 
 #include <linux/mm.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
@@ -34,12 +34,6 @@ do {							\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_page((unsigned long)pmd);
-}
-
 #define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_page(x))
 #endif
 
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 36f452957cef..7e6a4180db9d 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -78,9 +78,6 @@ static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 #endif
 
-struct mm_struct;
-extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
-
 static inline void pud_clear (pud_t *pud)
 {
 	set_pud(pud, __pud(_PAGE_NEWPAGE));
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index c2ff76c8981e..a4accb14cbd5 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -201,18 +201,6 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long) pgd);
 }
 
-#ifdef CONFIG_3_LEVEL_PGTABLES
-pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
-
-	if (pmd)
-		memset(pmd, 0, PAGE_SIZE);
-
-	return pmd;
-}
-#endif
-
 void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 29aa7859bdee..25feaa117c40 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -7,7 +7,7 @@
 #include <linux/pagemap.h>
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
@@ -86,30 +86,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	struct page *page;
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
-
-	if (mm == &init_mm)
-		gfp &= ~__GFP_ACCOUNT;
-	page = alloc_pages(gfp, 0);
-	if (!page)
-		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_pages(page, 0);
-		return NULL;
-	}
-	return (pmd_t *)page_address(page);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
-	free_page((unsigned long)pmd);
-}
-
 extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 73f7421413cb..1bc027891a00 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -102,6 +102,49 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 	__free_page(pte_page);
 }
 
+
+#if CONFIG_PGTABLE_LEVELS > 2
+
+#ifndef __HAVE_ARCH_PMD_ALLOC_ONE
+/**
+ * pmd_alloc_one - allocate a page for PMD-level page table
+ * @mm: the mm_struct of the current context
+ *
+ * Allocates a page and runs the pgtable_pmd_page_ctor().
+ * Allocations use %GFP_PGTABLE_USER in user context and
+ * %GFP_PGTABLE_KERNEL in kernel context.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	struct page *page;
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	page = alloc_pages(gfp, 0);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_pages(page, 0);
+		return NULL;
+	}
+	return (pmd_t *)page_address(page);
+}
+#endif
+
+#ifndef __HAVE_ARCH_PMD_FREE
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	free_page((unsigned long)pmd);
+}
+#endif
+
+#endif /* CONFIG_PGTABLE_LEVELS > 2 */
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
-- 
2.26.2

