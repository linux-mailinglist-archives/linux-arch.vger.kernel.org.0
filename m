Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E51ED95E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 07:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfKDG5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 01:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfKDG5i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 01:57:38 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28CB21D7D;
        Mon,  4 Nov 2019 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572850657;
        bh=CW7Gp1IjfwDkl8IVaPenEWtXdVAOv0d2q6q7M1mNsx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5+2VGWQAEhBPt0NQk+3HwP7KhHMokG0+tlOFgiWEj4pwCR9AnxP9lkaTf4zU3Ci0
         dVQiTFAe7NV894NUh4hXiA0riLuyJ7q6dg2BYbxiT8UgZeBzzLEZAK1OoPU/wczLi0
         wu0u91ibNsAIl4BRvRAFxiAx+vVvrpV4xswb3jyc=
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
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
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
Subject: [PATCH v3 06/13] microblaze: use pgtable-nopmd instead of 4level-fixup
Date:   Mon,  4 Nov 2019 08:56:20 +0200
Message-Id: <1572850587-20314-7-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572850587-20314-1-git-send-email-rppt@kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

microblaze has only two-level page tables and can use pgtable-nopmd and
folding of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h and explicit definition
of __PAGETABLE_PMD_FOLDED in microblaze with
include/asm-generic/pgtable-nopmd.h and adjust page table manipulation
macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/microblaze/include/asm/page.h    |  3 ---
 arch/microblaze/include/asm/pgalloc.h | 16 ----------------
 arch/microblaze/include/asm/pgtable.h | 32 ++------------------------------
 arch/microblaze/kernel/signal.c       | 10 +++++++---
 arch/microblaze/mm/init.c             |  7 +++++--
 arch/microblaze/mm/pgtable.c          | 13 +++++++++++--
 6 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index d506bb0..f4b44b2 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -90,7 +90,6 @@ typedef struct { unsigned long	pte; }		pte_t;
 typedef struct { unsigned long	pgprot; }	pgprot_t;
 /* FIXME this can depend on linux kernel version */
 #   ifdef CONFIG_MMU
-typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #   else /* CONFIG_MMU */
 typedef struct { unsigned long	ste[64]; }	pmd_t;
@@ -103,7 +102,6 @@ typedef struct { p4d_t		pge[1]; }	pgd_t;
 # define pgprot_val(x)	((x).pgprot)
 
 #   ifdef CONFIG_MMU
-#   define pmd_val(x)      ((x).pmd)
 #   define pgd_val(x)      ((x).pgd)
 #   else  /* CONFIG_MMU */
 #   define pmd_val(x)	((x).ste[0])
@@ -112,7 +110,6 @@ typedef struct { p4d_t		pge[1]; }	pgd_t;
 #   endif  /* CONFIG_MMU */
 
 # define __pte(x)	((pte_t) { (x) })
-# define __pmd(x)	((pmd_t) { (x) })
 # define __pgd(x)	((pgd_t) { (x) })
 # define __pgprot(x)	((pgprot_t) { (x) })
 
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index 7ecb05b..fcf1e23 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -41,13 +41,6 @@ static inline void free_pgd(pgd_t *pgd)
 
 #define pmd_pgtable(pmd)	pmd_page(pmd)
 
-/*
- * We don't have any real pmd's, and this code never triggers because
- * the pgd will always be present..
- */
-#define pmd_alloc_one_fast(mm, address)	({ BUG(); ((pmd_t *)1); })
-#define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
-
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
@@ -58,15 +51,6 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 #define pmd_populate_kernel(mm, pmd, pte) \
 		(pmd_val(*(pmd)) = (unsigned long) (pte))
 
-/*
- * We don't have any real pmd's, and this code never triggers because
- * the pgd will always be present..
- */
-#define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, x)			do { } while (0)
-#define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
-#define pgd_populate(mm, pmd, pte)	BUG()
-
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_MICROBLAZE_PGALLOC_H */
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 954b69a..2def331 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -59,9 +59,7 @@ extern int mem_init_done;
 
 #else /* CONFIG_MMU */
 
-#include <asm-generic/4level-fixup.h>
-
-#define __PAGETABLE_PMD_FOLDED 1
+#include <asm-generic/pgtable-nopmd.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -138,13 +136,8 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
  *
  */
 
-/* PMD_SHIFT determines the size of the area mapped by the PTE pages */
-#define PMD_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
 /* PGDIR_SHIFT determines what a top-level page table entry can map */
-#define PGDIR_SHIFT	PMD_SHIFT
+#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -165,9 +158,6 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 #define pte_ERROR(e) \
 	printk(KERN_ERR "%s:%d: bad pte "PTE_FMT".\n", \
 		__FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pmd %08lx.\n", \
-		__FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n", \
 		__FILE__, __LINE__, pgd_val(e))
@@ -314,18 +304,6 @@ extern unsigned long empty_zero_page[1024];
 
 #ifndef __ASSEMBLY__
 /*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
- * into the pgd entry)
- */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-#define pgd_clear(xp)				do { } while (0)
-#define pgd_page(pgd) \
-	((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
-
-/*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
@@ -479,12 +457,6 @@ static inline void ptep_mkdirty(struct mm_struct *mm,
 #define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-/* Find an entry in the second-level page table.. */
-static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
-{
-	return (pmd_t *) dir;
-}
-
 /* Find an entry in the third-level page table.. */
 #define pte_index(address)		\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index cdd4feb..c9125c3 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -160,6 +160,9 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	int err = 0, sig = ksig->sig;
 	unsigned long address = 0;
 #ifdef CONFIG_MMU
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 #endif
@@ -195,9 +198,10 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	address = ((unsigned long)frame->tramp);
 #ifdef CONFIG_MMU
-	pmdp = pmd_offset(pud_offset(
-			pgd_offset(current->mm, address),
-					address), address);
+	pgdp = pgd_offset(current->mm, address);
+	p4dp = p4d_offset(pgdp, address);
+	pudp = pud_offset(p4dp, address);
+	pmdp = pmd_offset(pudp, address);
 
 	preempt_disable();
 	ptep = pte_offset_map(pmdp, address);
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index a015a95..050fc62 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -53,8 +53,11 @@ EXPORT_SYMBOL(kmap_prot);
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
 {
-	return pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr),
-			vaddr), vaddr);
+	pgd_t *pgd = pgd_offset_k(vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
+
+	return pte_offset_kernel(pmd_offset(pud, vaddr), vaddr);
 }
 
 static void __init highmem_init(void)
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 010bb9c..68c26ca 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -134,11 +134,16 @@ EXPORT_SYMBOL(iounmap);
 
 int map_page(unsigned long va, phys_addr_t pa, int flags)
 {
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pd;
 	pte_t *pg;
 	int err = -ENOMEM;
+
 	/* Use upper 10 bits of VA to index the first level map */
-	pd = pmd_offset(pgd_offset_k(va), va);
+	p4d = p4d_offset(pgd_offset_k(va), va);
+	pud = pud_offset(p4d, va);
+	pd = pmd_offset(pud, va);
 	/* Use middle 10 bits of VA to index the second-level map */
 	pg = pte_alloc_kernel(pd, va); /* from powerpc - pgtable.c */
 	/* pg = pte_alloc_kernel(&init_mm, pd, va); */
@@ -188,13 +193,17 @@ void __init mapin_ram(void)
 static int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep)
 {
 	pgd_t	*pgd;
+	p4d_t	*p4d;
+	pud_t	*pud;
 	pmd_t	*pmd;
 	pte_t	*pte;
 	int     retval = 0;
 
 	pgd = pgd_offset(mm, addr & PAGE_MASK);
 	if (pgd) {
-		pmd = pmd_offset(pgd, addr & PAGE_MASK);
+		p4d = p4d_offset(pgd, addr & PAGE_MASK);
+		pud = pud_offset(p4d, addr & PAGE_MASK);
+		pmd = pmd_offset(pud, addr & PAGE_MASK);
 		if (pmd_present(*pmd)) {
 			pte = pte_offset_kernel(pmd, addr & PAGE_MASK);
 			if (pte) {
-- 
2.7.4

