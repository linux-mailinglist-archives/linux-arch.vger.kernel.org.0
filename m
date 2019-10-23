Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADFE1603
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbfJWJa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 05:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404008AbfJWJa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 05:30:28 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624FD21D7E;
        Wed, 23 Oct 2019 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571823027;
        bh=EN/2QNdcqzEAwdUuThUk/AmaSKEp2SwWDa6q9OAGcAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBAW2BcKb+vCfSfRjMLQaGBCGy8RY1PjqH4iiD4xQ79yo4oAKb223zTkBaJ4CJteg
         /vK7+i/fXh+TJaq6ARWHqBG0Z0pEfJ2odXrjJovxlyQMKYfe4IIDFNOUMa5JNmNdzy
         XFluANglX2YQcOaMwBusxwTcTKsuErMzUEvukdBU=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Date:   Wed, 23 Oct 2019 12:28:57 +0300
Message-Id: <1571822941-29776-9-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

parisc has two or three levels of page tables and can use appropriate
pgtable-nopXd and folding of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h and explicit
definitions of __PAGETABLE_PxD_FOLDED in parisc with
include/asm-generic/pgtable-nopmd.h for two-level configurations and with
include/asm-generic/pgtable-nopmd.h for three-lelve configurations and
adjust page table manipulation macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/include/asm/page.h    | 30 +++++++++++++---------
 arch/parisc/include/asm/pgalloc.h | 41 +++++++++++-------------------
 arch/parisc/include/asm/pgtable.h | 52 +++++++++++++++++++--------------------
 arch/parisc/include/asm/tlb.h     |  2 ++
 arch/parisc/kernel/cache.c        | 13 ++++++----
 arch/parisc/kernel/pci-dma.c      |  9 +++++--
 arch/parisc/mm/fixmap.c           | 10 +++++---
 7 files changed, 81 insertions(+), 76 deletions(-)

diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 93caf17..1d339ee 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -42,48 +42,54 @@ typedef struct { unsigned long pte; } pte_t; /* either 32 or 64bit */
 
 /* NOTE: even on 64 bits, these entries are __u32 because we allocate
  * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
-typedef struct { __u32 pmd; } pmd_t;
 typedef struct { __u32 pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
-#define pte_val(x)	((x).pte)
-/* These do not work lvalues, so make sure we don't use them as such. */
+#if CONFIG_PGTABLE_LEVELS == 3
+typedef struct { __u32 pmd; } pmd_t;
+#define __pmd(x)	((pmd_t) { (x) } )
+/* pXd_val() do not work lvalues, so make sure we don't use them as such. */
 #define pmd_val(x)	((x).pmd + 0)
+#endif
+
+#define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd + 0)
 #define pgprot_val(x)	((x).pgprot)
 
 #define __pte(x)	((pte_t) { (x) } )
-#define __pmd(x)	((pmd_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-#define __pmd_val_set(x,n) (x).pmd = (n)
-#define __pgd_val_set(x,n) (x).pgd = (n)
-
 #else
 /*
  * .. while these make it easier on the compiler
  */
 typedef unsigned long pte_t;
+
+#if CONFIG_PGTABLE_LEVELS == 3
 typedef         __u32 pmd_t;
+#define pmd_val(x)      (x)
+#define __pmd(x)	(x)
+#endif
+
 typedef         __u32 pgd_t;
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)      (x)
-#define pmd_val(x)      (x)
 #define pgd_val(x)      (x)
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)
-#define __pmd(x)	(x)
 #define __pgd(x)        (x)
 #define __pgprot(x)     (x)
 
-#define __pmd_val_set(x,n) (x) = (n)
-#define __pgd_val_set(x,n) (x) = (n)
-
 #endif /* STRICT_MM_TYPECHECKS */
 
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#if CONFIG_PGTABLE_LEVELS == 3
+#define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
+#endif
+
 typedef struct page *pgtable_t;
 
 typedef struct __physmem_range {
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index d98647c..9ac74da 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -34,13 +34,13 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 		/* Populate first pmd with allocated memory.  We mark it
 		 * with PxD_FLAG_ATTACHED as a signal to the system that this
 		 * pmd entry may not be cleared. */
-		__pgd_val_set(*actual_pgd, (PxD_FLAG_PRESENT | 
-				        PxD_FLAG_VALID | 
-					PxD_FLAG_ATTACHED) 
-			+ (__u32)(__pa((unsigned long)pgd) >> PxD_VALUE_SHIFT));
+		set_pgd(actual_pgd, __pgd((PxD_FLAG_PRESENT |
+				        PxD_FLAG_VALID |
+					PxD_FLAG_ATTACHED)
+			+ (__u32)(__pa((unsigned long)pgd) >> PxD_VALUE_SHIFT)));
 		/* The first pmd entry also is marked with PxD_FLAG_ATTACHED as
 		 * a signal that this pmd may not be freed */
-		__pgd_val_set(*pgd, PxD_FLAG_ATTACHED);
+		set_pgd(pgd, __pgd(PxD_FLAG_ATTACHED));
 #endif
 	}
 	spin_lock_init(pgd_spinlock(actual_pgd));
@@ -59,10 +59,10 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 /* Three Level Page Table Support for pmd's */
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	__pgd_val_set(*pgd, (PxD_FLAG_PRESENT | PxD_FLAG_VALID) +
-		        (__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT));
+	set_pud(pud, __pud((PxD_FLAG_PRESENT | PxD_FLAG_VALID) +
+			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -88,19 +88,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	free_pages((unsigned long)pmd, PMD_ORDER);
 }
 
-#else
-
-/* Two Level Page Table Support for pmd's */
-
-/*
- * allocating and freeing a pmd is trivial: the 1-entry pmd is
- * inside the pgd, so has no extra memory associated with it.
- */
-
-#define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, x)			do { } while (0)
-#define pgd_populate(mm, pmd, pte)	BUG()
-
 #endif
 
 static inline void
@@ -110,14 +97,14 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 	/* preserve the gateway marker if this is the beginning of
 	 * the permanent pmd */
 	if(pmd_flag(*pmd) & PxD_FLAG_ATTACHED)
-		__pmd_val_set(*pmd, (PxD_FLAG_PRESENT |
-				 PxD_FLAG_VALID |
-				 PxD_FLAG_ATTACHED) 
-			+ (__u32)(__pa((unsigned long)pte) >> PxD_VALUE_SHIFT));
+		set_pmd(pmd, __pmd((PxD_FLAG_PRESENT |
+				PxD_FLAG_VALID |
+				PxD_FLAG_ATTACHED)
+			+ (__u32)(__pa((unsigned long)pte) >> PxD_VALUE_SHIFT)));
 	else
 #endif
-		__pmd_val_set(*pmd, (PxD_FLAG_PRESENT | PxD_FLAG_VALID) 
-			+ (__u32)(__pa((unsigned long)pte) >> PxD_VALUE_SHIFT));
+		set_pmd(pmd, __pmd((PxD_FLAG_PRESENT | PxD_FLAG_VALID)
+			+ (__u32)(__pa((unsigned long)pte) >> PxD_VALUE_SHIFT)));
 }
 
 #define pmd_populate(mm, pmd, pte_page) \
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 4ac374b..f0a3659 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -3,7 +3,12 @@
 #define _PARISC_PGTABLE_H
 
 #include <asm/page.h>
-#include <asm-generic/4level-fixup.h>
+
+#if CONFIG_PGTABLE_LEVELS == 3
+#include <asm-generic/pgtable-nopud.h>
+#elif CONFIG_PGTABLE_LEVELS == 2
+#include <asm-generic/pgtable-nopmd.h>
+#endif
 
 #include <asm/fixmap.h>
 
@@ -101,8 +106,10 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+#if CONFIG_PGTABLE_LEVELS == 3
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, (unsigned long)pmd_val(e))
+#endif
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, (unsigned long)pgd_val(e))
 
@@ -132,19 +139,18 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #define PTRS_PER_PTE    (1UL << BITS_PER_PTE)
 
 /* Definitions for 2nd level */
+#if CONFIG_PGTABLE_LEVELS == 3
 #define PMD_SHIFT       (PLD_SHIFT + BITS_PER_PTE)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#if CONFIG_PGTABLE_LEVELS == 3
 #define BITS_PER_PMD	(PAGE_SHIFT + PMD_ORDER - BITS_PER_PMD_ENTRY)
+#define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
 #else
-#define __PAGETABLE_PMD_FOLDED 1
 #define BITS_PER_PMD	0
 #endif
-#define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
 
 /* Definitions for 1st level */
-#define PGDIR_SHIFT	(PMD_SHIFT + BITS_PER_PMD)
+#define PGDIR_SHIFT	(PLD_SHIFT + BITS_PER_PTE + BITS_PER_PMD)
 #if (PGDIR_SHIFT + PAGE_SHIFT + PGD_ORDER - BITS_PER_PGD_ENTRY) > BITS_PER_LONG
 #define BITS_PER_PGD	(BITS_PER_LONG - PGDIR_SHIFT)
 #else
@@ -317,6 +323,8 @@ extern unsigned long *empty_zero_page;
 
 #define pmd_flag(x)	(pmd_val(x) & PxD_FLAG_MASK)
 #define pmd_address(x)	((unsigned long)(pmd_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
+#define pud_flag(x)	(pud_val(x) & PxD_FLAG_MASK)
+#define pud_address(x)	((unsigned long)(pud_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
 #define pgd_flag(x)	(pgd_val(x) & PxD_FLAG_MASK)
 #define pgd_address(x)	((unsigned long)(pgd_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
 
@@ -334,42 +342,32 @@ static inline void pmd_clear(pmd_t *pmd) {
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED)
 		/* This is the entry pointing to the permanent pmd
 		 * attached to the pgd; cannot clear it */
-		__pmd_val_set(*pmd, PxD_FLAG_ATTACHED);
+		set_pmd(pmd, __pmd(PxD_FLAG_ATTACHED));
 	else
 #endif
-		__pmd_val_set(*pmd,  0);
+		set_pmd(pmd,  __pmd(0));
 }
 
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define pgd_page_vaddr(pgd) ((unsigned long) __va(pgd_address(pgd)))
-#define pgd_page(pgd)	virt_to_page((void *)pgd_page_vaddr(pgd))
+#define pud_page_vaddr(pud) ((unsigned long) __va(pud_address(pud)))
+#define pud_page(pud)	virt_to_page((void *)pud_page_vaddr(pud))
 
 /* For 64 bit we have three level tables */
 
-#define pgd_none(x)     (!pgd_val(x))
-#define pgd_bad(x)      (!(pgd_flag(x) & PxD_FLAG_VALID))
-#define pgd_present(x)  (pgd_flag(x) & PxD_FLAG_PRESENT)
-static inline void pgd_clear(pgd_t *pgd) {
+#define pud_none(x)     (!pud_val(x))
+#define pud_bad(x)      (!(pud_flag(x) & PxD_FLAG_VALID))
+#define pud_present(x)  (pud_flag(x) & PxD_FLAG_PRESENT)
+static inline void pud_clear(pud_t *pud) {
 #if CONFIG_PGTABLE_LEVELS == 3
-	if(pgd_flag(*pgd) & PxD_FLAG_ATTACHED)
-		/* This is the permanent pmd attached to the pgd; cannot
+	if(pud_flag(*pud) & PxD_FLAG_ATTACHED)
+		/* This is the permanent pmd attached to the pud; cannot
 		 * free it */
 		return;
 #endif
-	__pgd_val_set(*pgd, 0);
+	set_pud(pud, __pud(0));
 }
-#else
-/*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
- * into the pgd entry)
- */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-static inline void pgd_clear(pgd_t * pgdp)	{ }
 #endif
 
 /*
@@ -452,7 +450,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #if CONFIG_PGTABLE_LEVELS == 3
 #define pmd_index(addr)         (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 #define pmd_offset(dir,address) \
-((pmd_t *) pgd_page_vaddr(*(dir)) + pmd_index(address))
+((pmd_t *) pud_page_vaddr(*(dir)) + pmd_index(address))
 #else
 #define pmd_offset(dir,addr) ((pmd_t *) dir)
 #endif
diff --git a/arch/parisc/include/asm/tlb.h b/arch/parisc/include/asm/tlb.h
index 8c0446b..44235f3 100644
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -4,7 +4,9 @@
 
 #include <asm-generic/tlb.h>
 
+#if CONFIG_PGTABLE_LEVELS == 3
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
+#endif
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
 
 #endif
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index a82b3ea..7b2e0ab 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -534,11 +534,14 @@ static inline pte_t *get_ptep(pgd_t *pgd, unsigned long addr)
 	pte_t *ptep = NULL;
 
 	if (!pgd_none(*pgd)) {
-		pud_t *pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd_t *pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd))
-				ptep = pte_offset_map(pmd, addr);
+		p4d_t *p4d = p4d_offset(pgd, addr);
+		if (!p4d_none(*p4d)) {
+			pud_t *pud = pud_offset(p4d, addr);
+			if (!pud_none(*pud)) {
+				pmd_t *pmd = pmd_offset(pud, addr);
+				if (!pmd_none(*pmd))
+					ptep = pte_offset_map(pmd, addr);
+			}
 		}
 	}
 	return ptep;
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ca35d9a..8859c71 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -133,9 +133,14 @@ static inline int map_uncached_pages(unsigned long vaddr, unsigned long size,
 
 	dir = pgd_offset_k(vaddr);
 	do {
+		p4d_t *p4d;
+		pud_t *pud;
 		pmd_t *pmd;
-		
-		pmd = pmd_alloc(NULL, dir, vaddr);
+
+		p4d = p4d_offset(dir, vaddr);
+		pud = pud_offset(p4d, vaddr);
+		pmd = pmd_alloc(NULL, pud, vaddr);
+
 		if (!pmd)
 			return -ENOMEM;
 		if (map_pmd_uncached(pmd, vaddr, end - vaddr, &paddr))
diff --git a/arch/parisc/mm/fixmap.c b/arch/parisc/mm/fixmap.c
index 474cd24..e2d8b0a 100644
--- a/arch/parisc/mm/fixmap.c
+++ b/arch/parisc/mm/fixmap.c
@@ -14,11 +14,13 @@ void notrace set_fixmap(enum fixed_addresses idx, phys_addr_t phys)
 {
 	unsigned long vaddr = __fix_to_virt(idx);
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = pmd_offset(pgd, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte;
 
 	if (pmd_none(*pmd))
-		pmd = pmd_alloc(NULL, pgd, vaddr);
+		pmd = pmd_alloc(NULL, pud, vaddr);
 
 	pte = pte_offset_kernel(pmd, vaddr);
 	if (pte_none(*pte))
@@ -32,7 +34,9 @@ void notrace clear_fixmap(enum fixed_addresses idx)
 {
 	unsigned long vaddr = __fix_to_virt(idx);
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = pmd_offset(pgd, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
 	pte_t *pte = pte_offset_kernel(pmd, vaddr);
 
 	if (WARN_ON(pte_none(*pte)))
-- 
2.7.4

