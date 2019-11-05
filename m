Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44170EF60F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 08:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbfKEHQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 02:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbfKEHQi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 02:16:38 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01E821D6C;
        Tue,  5 Nov 2019 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572938196;
        bh=SbwuSK/jnfT7wtgg5uMdAhrK89vfVuS63wksX1ogeVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7e+Zsal7TMjIGer7b+ewtkQMq/z4J0r2cPHmZM3rs3Ucd4MrOUvko0UR3IiVTI0T
         g04aN0Xgu05DwMrsokC+aweW24mwTrT0eHrELuGo1GIz+UPKV1ZUGoHcMQNkgZkl1n
         w6PHigtMBDxvP/5dnvm+sjVpYMzXWK3/uHsoUCr8=
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
Subject: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Date:   Tue,  5 Nov 2019 09:15:27 +0200
Message-Id: <1572938135-31886-6-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572938135-31886-1-git-send-email-rppt@kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

m68k has two or three levels of page tables and can use appropriate
pgtable-nopXd and folding of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h and explicit
definitions of __PAGETABLE_PxD_FOLDED in m68k with
include/asm-generic/pgtable-nopmd.h for two-level configurations and with
include/asm-generic/pgtable-nopud.h for three-lelve configurations and
adjust page table manipulation macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/mcf_pgalloc.h      |  7 ------
 arch/m68k/include/asm/mcf_pgtable.h      | 28 ++++++++---------------
 arch/m68k/include/asm/mmu_context.h      | 12 +++++++++-
 arch/m68k/include/asm/motorola_pgalloc.h |  4 ++--
 arch/m68k/include/asm/motorola_pgtable.h | 32 ++++++++++++++++----------
 arch/m68k/include/asm/page.h             |  9 +++++---
 arch/m68k/include/asm/pgtable_mm.h       | 11 +++++----
 arch/m68k/include/asm/sun3_pgalloc.h     |  5 ----
 arch/m68k/include/asm/sun3_pgtable.h     | 18 ---------------
 arch/m68k/kernel/sys_m68k.c              | 10 +++++++-
 arch/m68k/mm/init.c                      |  6 +++--
 arch/m68k/mm/kmap.c                      | 39 ++++++++++++++++++++++++--------
 arch/m68k/mm/mcfmmu.c                    | 16 ++++++++++++-
 arch/m68k/mm/motorola.c                  | 17 +++++++++-----
 arch/m68k/sun3x/dvma.c                   |  7 ++++--
 15 files changed, 129 insertions(+), 92 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index b34d44d..82ec54c 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -28,9 +28,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 	return (pmd_t *) pgd;
 }
 
-#define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
-#define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
-
 #define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
 	(unsigned long)(page_address(page)))
 
@@ -45,8 +42,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
 	__free_page(page);
 }
 
-#define __pmd_free_tlb(tlb, pmd, address) do { } while (0)
-
 static inline struct page *pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_DMA, 0);
@@ -100,6 +95,4 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return new_pgd;
 }
 
-#define pgd_populate(mm, pmd, pte) BUG()
-
 #endif /* M68K_MCF_PGALLOC_H */
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 5d5502c..b9f45ae 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -198,17 +198,9 @@ static inline int pmd_bad2(pmd_t *pmd) { return 0; }
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
 static inline void pmd_clear(pmd_t *pmdp) { pmd_val(*pmdp) = 0; }
 
-static inline int pgd_none(pgd_t pgd) { return 0; }
-static inline int pgd_bad(pgd_t pgd) { return 0; }
-static inline int pgd_present(pgd_t pgd) { return 1; }
-static inline void pgd_clear(pgd_t *pgdp) {}
-
 #define pte_ERROR(e) \
 	printk(KERN_ERR "%s:%d: bad pte %08lx.\n",	\
 	__FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	printk(KERN_ERR "%s:%d: bad pmd %08lx.\n",	\
-	__FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	printk(KERN_ERR "%s:%d: bad pgd %08lx.\n",	\
 	__FILE__, __LINE__, pgd_val(e))
@@ -340,14 +332,6 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 #define pgd_offset_k(address)	pgd_offset(&init_mm, address)
 
 /*
- * Find an entry in the second-level pagetable.
- */
-static inline pmd_t *pmd_offset(pgd_t *pgd, unsigned long address)
-{
-	return (pmd_t *) pgd;
-}
-
-/*
  * Find an entry in the third-level pagetable.
  */
 #define __pte_offset(address)	((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
@@ -360,12 +344,16 @@ static inline pmd_t *pmd_offset(pgd_t *pgd, unsigned long address)
 static inline void nocache_page(void *vaddr)
 {
 	pgd_t *dir;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 	unsigned long addr = (unsigned long) vaddr;
 
 	dir = pgd_offset_k(addr);
-	pmdp = pmd_offset(dir, addr);
+	p4dp = p4d_offset(dir, addr);
+	pudp = pud_offset(p4dp, addr);
+	pmdp = pmd_offset(pudp, addr);
 	ptep = pte_offset_kernel(pmdp, addr);
 	*ptep = pte_mknocache(*ptep);
 }
@@ -376,12 +364,16 @@ static inline void nocache_page(void *vaddr)
 static inline void cache_page(void *vaddr)
 {
 	pgd_t *dir;
+	p4d_t *p4dp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 	unsigned long addr = (unsigned long) vaddr;
 
 	dir = pgd_offset_k(addr);
-	pmdp = pmd_offset(dir, addr);
+	p4dp = p4d_offset(dir, addr);
+	pudp = pud_offset(p4dp, addr);
+	pmdp = pmd_offset(pudp, addr);
 	ptep = pte_offset_kernel(pmdp, addr);
 	*ptep = pte_mkcache(*ptep);
 }
diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index f5b1852..cac9f28 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -100,6 +100,8 @@ static inline void load_ksp_mmu(struct task_struct *task)
 	struct mm_struct *mm;
 	int asid;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long mmuar;
@@ -127,7 +129,15 @@ static inline void load_ksp_mmu(struct task_struct *task)
 	if (pgd_none(*pgd))
 		goto bug;
 
-	pmd = pmd_offset(pgd, mmuar);
+	p4d = p4d_offset(pgd, mmuar);
+	if (p4d_none(*p4d))
+		goto bug;
+
+	pud = pud_offset(p4d, mmuar);
+	if (pud_none(*pud))
+		goto bug;
+
+	pmd = pmd_offset(pud, mmuar);
 	if (pmd_none(*pmd))
 		goto bug;
 
diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index acab315..ff9cc40 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -106,9 +106,9 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
 }
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pgd_set(pgd, pmd);
+	pud_set(pud, pmd);
 }
 
 #endif /* _MOTOROLA_PGALLOC_H */
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 7f66a7b..62bedc6 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -117,14 +117,14 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 	}
 }
 
-static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
+static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 {
-	pgd_val(*pgdp) = _PAGE_TABLE | _PAGE_ACCESSED | __pa(pmdp);
+	pud_val(*pudp) = _PAGE_TABLE | _PAGE_ACCESSED | __pa(pmdp);
 }
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define __pmd_page(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
-#define __pgd_page(pgd) ((unsigned long)__va(pgd_val(pgd) & _TABLE_MASK))
+#define pud_page_vaddr(pud) ((unsigned long)__va(pud_val(pud) & _TABLE_MASK))
 
 
 #define pte_none(pte)		(!pte_val(pte))
@@ -147,11 +147,11 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 #define pmd_page(pmd)		virt_to_page(__va(pmd_val(pmd)))
 
 
-#define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_bad(pgd)		((pgd_val(pgd) & _DESCTYPE_MASK) != _PAGE_TABLE)
-#define pgd_present(pgd)	(pgd_val(pgd) & _PAGE_TABLE)
-#define pgd_clear(pgdp)		({ pgd_val(*pgdp) = 0; })
-#define pgd_page(pgd)		(mem_map + ((unsigned long)(__va(pgd_val(pgd)) - PAGE_OFFSET) >> PAGE_SHIFT))
+#define pud_none(pud)		(!pud_val(pud))
+#define pud_bad(pud)		((pud_val(pud) & _DESCTYPE_MASK) != _PAGE_TABLE)
+#define pud_present(pud)	(pud_val(pud) & _PAGE_TABLE)
+#define pud_clear(pudp)		({ pud_val(*pudp) = 0; })
+#define pud_page(pud)		(mem_map + ((unsigned long)(__va(pud_val(pud)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -209,9 +209,9 @@ static inline pgd_t *pgd_offset_k(unsigned long address)
 
 
 /* Find an entry in the second-level page table.. */
-static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
+static inline pmd_t *pmd_offset(pud_t *dir, unsigned long address)
 {
-	return (pmd_t *)__pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PMD-1));
+	return (pmd_t *)pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PMD-1));
 }
 
 /* Find an entry in the third-level page table.. */
@@ -239,11 +239,15 @@ static inline void nocache_page(void *vaddr)
 
 	if (CPU_IS_040_OR_060) {
 		pgd_t *dir;
+		p4d_t *p4dp;
+		pud_t *pudp;
 		pmd_t *pmdp;
 		pte_t *ptep;
 
 		dir = pgd_offset_k(addr);
-		pmdp = pmd_offset(dir, addr);
+		p4dp = p4d_offset(dir, addr);
+		pudp = pud_offset(p4dp, addr);
+		pmdp = pmd_offset(pudp, addr);
 		ptep = pte_offset_kernel(pmdp, addr);
 		*ptep = pte_mknocache(*ptep);
 	}
@@ -255,11 +259,15 @@ static inline void cache_page(void *vaddr)
 
 	if (CPU_IS_040_OR_060) {
 		pgd_t *dir;
+		p4d_t *p4dp;
+		pud_t *pudp;
 		pmd_t *pmdp;
 		pte_t *ptep;
 
 		dir = pgd_offset_k(addr);
-		pmdp = pmd_offset(dir, addr);
+		p4dp = p4d_offset(dir, addr);
+		pudp = pud_offset(p4dp, addr);
+		pmdp = pmd_offset(pudp, addr);
 		ptep = pte_offset_kernel(pmdp, addr);
 		*ptep = pte_mkcache(*ptep);
 	}
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 700d819..05e1e1e 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -21,19 +21,22 @@
 /*
  * These are used to make use of C type-checking..
  */
-typedef struct { unsigned long pte; } pte_t;
+#if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
 typedef struct { unsigned long pmd[16]; } pmd_t;
+#define pmd_val(x)	((&x)->pmd[0])
+#define __pmd(x)	((pmd_t) { { (x) }, })
+#endif
+
+typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pte_val(x)	((x).pte)
-#define pmd_val(x)	((&x)->pmd[0])
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
 
 #define __pte(x)	((pte_t) { (x) } )
-#define __pmd(x)	((pmd_t) { { (x) }, })
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 646c174f..2bf5c35 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -2,7 +2,12 @@
 #ifndef _M68K_PGTABLE_H
 #define _M68K_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
+
+#if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
+#include <asm-generic/pgtable-nopmd.h>
+#else
+#include <asm-generic/pgtable-nopud.h>
+#endif
 
 #include <asm/setup.h>
 
@@ -30,9 +35,7 @@
 
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-#ifdef CONFIG_SUN3
-#define PMD_SHIFT       17
-#else
+#if CONFIG_PGTABLE_LEVELS == 3
 #define PMD_SHIFT	22
 #endif
 #define PMD_SIZE	(1UL << PMD_SHIFT)
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 8561211..11b95da 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,8 +17,6 @@
 
 extern const char bad_pmd_string[];
 
-#define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
-
 #define __pte_free_tlb(tlb,pte,addr)			\
 do {							\
 	pgtable_pte_page_dtor(pte);			\
@@ -41,7 +39,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
  * inside the pgd, so has no extra memory associated with it.
  */
 #define pmd_free(mm, x)			do { } while (0)
-#define __pmd_free_tlb(tlb, x, addr)	do { } while (0)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
@@ -58,6 +55,4 @@ static inline pgd_t * pgd_alloc(struct mm_struct *mm)
      return new_pgd;
 }
 
-#define pgd_populate(mm, pmd, pte) BUG()
-
 #endif /* SUN3_PGALLOC_H */
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index c987d50..bc41552 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -110,11 +110,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 #define pmd_set(pmdp,ptep) do {} while (0)
 
-static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
-{
-	pgd_val(*pgdp) = virt_to_phys(pmdp);
-}
-
 #define __pte_page(pte) \
 ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
 #define __pmd_page(pmd) \
@@ -145,16 +140,9 @@ static inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_V
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
 static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 
-static inline int pgd_none (pgd_t pgd) { return 0; }
-static inline int pgd_bad (pgd_t pgd) { return 0; }
-static inline int pgd_present (pgd_t pgd) { return 1; }
-static inline void pgd_clear (pgd_t *pgdp) {}
-
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
@@ -194,12 +182,6 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 /* Find an entry in a kernel pagetable directory. */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
-/* Find an entry in the second-level pagetable. */
-static inline pmd_t *pmd_offset (pgd_t *pgd, unsigned long address)
-{
-	return (pmd_t *) pgd;
-}
-
 /* Find an entry in the third-level pagetable. */
 #define pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) ((pte_t *) __pmd_page(*pmd) + pte_index(address))
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec8..18a4de7 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -465,6 +465,8 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 	for (;;) {
 		struct mm_struct *mm = current->mm;
 		pgd_t *pgd;
+		p4d_t *p4d;
+		pud_t *pud;
 		pmd_t *pmd;
 		pte_t *pte;
 		spinlock_t *ptl;
@@ -474,7 +476,13 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 		pgd = pgd_offset(mm, (unsigned long)mem);
 		if (!pgd_present(*pgd))
 			goto bad_access;
-		pmd = pmd_offset(pgd, (unsigned long)mem);
+		p4d = p4d_offset(pgd, (unsigned long)mem);
+		if (!p4d_present(*p4d))
+			goto bad_access;
+		pud = pud_offset(p4d, (unsigned long)mem);
+		if (!pud_present(*pud))
+			goto bad_access;
+		pmd = pmd_offset(pud, (unsigned long)mem);
 		if (!pmd_present(*pmd))
 			goto bad_access;
 		pte = pte_offset_map_lock(mm, pmd, (unsigned long)mem, &ptl);
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 778cacb..27c453f 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -130,8 +130,10 @@ static inline void init_pointer_tables(void)
 	/* insert pointer tables allocated so far into the tablelist */
 	init_pointer_table((unsigned long)kernel_pg_dir);
 	for (i = 0; i < PTRS_PER_PGD; i++) {
-		if (pgd_present(kernel_pg_dir[i]))
-			init_pointer_table(__pgd_page(kernel_pg_dir[i]));
+		pud_t *pud = (pud_t *)(&kernel_pg_dir[i]);
+
+		if (pud_present(*pud))
+			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]));
 	}
 
 	/* insert also pointer table that we used to unmap the zero page */
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 40a3b32..49390dc 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -110,6 +110,8 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
 	unsigned long virtaddr, retaddr;
 	long offset;
 	pgd_t *pgd_dir;
+	p4d_t *p4d_dir;
+	pud_t *pud_dir;
 	pmd_t *pmd_dir;
 	pte_t *pte_dir;
 
@@ -196,18 +198,23 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
 			printk ("\npa=%#lx va=%#lx ", physaddr, virtaddr);
 #endif
 		pgd_dir = pgd_offset_k(virtaddr);
-		pmd_dir = pmd_alloc(&init_mm, pgd_dir, virtaddr);
+		p4d_dir = p4d_offset(pgd_dir, virtaddr);
+		pud_dir = pud_offset(p4d_dir, virtaddr);
+		pmd_dir = pmd_alloc(&init_mm, pud_dir, virtaddr);
 		if (!pmd_dir) {
 			printk("ioremap: no mem for pmd_dir\n");
 			return NULL;
 		}
 
+#if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
 			pmd_dir->pmd[(virtaddr/PTRTREESIZE) & 15] = physaddr;
 			physaddr += PTRTREESIZE;
 			virtaddr += PTRTREESIZE;
 			size -= PTRTREESIZE;
-		} else {
+		} else
+#endif
+		{
 			pte_dir = pte_alloc_kernel(pmd_dir, virtaddr);
 			if (!pte_dir) {
 				printk("ioremap: no mem for pte_dir\n");
@@ -258,18 +265,23 @@ void __iounmap(void *addr, unsigned long size)
 {
 	unsigned long virtaddr = (unsigned long)addr;
 	pgd_t *pgd_dir;
+	p4d_t *p4d_dir;
+	pud_t *pud_dir;
 	pmd_t *pmd_dir;
 	pte_t *pte_dir;
 
 	while ((long)size > 0) {
 		pgd_dir = pgd_offset_k(virtaddr);
-		if (pgd_bad(*pgd_dir)) {
-			printk("iounmap: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
-			pgd_clear(pgd_dir);
+		p4d_dir = p4d_offset(pgd_dir, virtaddr);
+		pud_dir = pud_offset(p4d_dir, virtaddr);
+		if (pud_bad(*pud_dir)) {
+			printk("iounmap: bad pgd(%08lx)\n", pud_val(*pud_dir));
+			pud_clear(pud_dir);
 			return;
 		}
-		pmd_dir = pmd_offset(pgd_dir, virtaddr);
+		pmd_dir = pmd_offset(pud_dir, virtaddr);
 
+#if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
 			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
 			int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
@@ -282,6 +294,7 @@ void __iounmap(void *addr, unsigned long size)
 			} else if (pmd_type == 0)
 				continue;
 		}
+#endif
 
 		if (pmd_bad(*pmd_dir)) {
 			printk("iounmap: bad pmd (%08lx)\n", pmd_val(*pmd_dir));
@@ -307,6 +320,8 @@ void kernel_set_cachemode(void *addr, unsigned long size, int cmode)
 {
 	unsigned long virtaddr = (unsigned long)addr;
 	pgd_t *pgd_dir;
+	p4d_t *p4d_dir;
+	pud_t *pud_dir;
 	pmd_t *pmd_dir;
 	pte_t *pte_dir;
 
@@ -341,13 +356,16 @@ void kernel_set_cachemode(void *addr, unsigned long size, int cmode)
 
 	while ((long)size > 0) {
 		pgd_dir = pgd_offset_k(virtaddr);
-		if (pgd_bad(*pgd_dir)) {
-			printk("iocachemode: bad pgd(%08lx)\n", pgd_val(*pgd_dir));
-			pgd_clear(pgd_dir);
+		p4d_dir = p4d_offset(pgd_dir, virtaddr);
+		pud_dir = pud_offset(p4d_dir, virtaddr);
+		if (pud_bad(*pud_dir)) {
+			printk("iocachemode: bad pud(%08lx)\n", pud_val(*pud_dir));
+			pud_clear(pud_dir);
 			return;
 		}
-		pmd_dir = pmd_offset(pgd_dir, virtaddr);
+		pmd_dir = pmd_offset(pud_dir, virtaddr);
 
+#if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
 			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
 
@@ -359,6 +377,7 @@ void kernel_set_cachemode(void *addr, unsigned long size, int cmode)
 				continue;
 			}
 		}
+#endif
 
 		if (pmd_bad(*pmd_dir)) {
 			printk("iocachemode: bad pmd (%08lx)\n", pmd_val(*pmd_dir));
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 6cb1e41..0ea3756 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -92,6 +92,8 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 	unsigned long flags, mmuar, mmutr;
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	int asid;
@@ -113,7 +115,19 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 		return -1;
 	}
 
-	pmd = pmd_offset(pgd, mmuar);
+	p4d = p4d_offset(pgd, mmuar);
+	if (p4d_none(*p4d)) {
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	pud = pud_offset(p4d, mmuar);
+	if (pud_none(*pud)) {
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	pmd = pmd_offset(pud, mmuar);
 	if (pmd_none(*pmd)) {
 		local_irq_restore(flags);
 		return -1;
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 356601b..4857985 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -82,9 +82,11 @@ static pmd_t * __init kernel_ptr_table(void)
 		 */
 		last = (unsigned long)kernel_pg_dir;
 		for (i = 0; i < PTRS_PER_PGD; i++) {
-			if (!pgd_present(kernel_pg_dir[i]))
+			pud_t *pud = (pud_t *)(&kernel_pg_dir[i]);
+
+			if (!pud_present(*pud))
 				continue;
-			pmd = __pgd_page(kernel_pg_dir[i]);
+			pmd = pgd_page_vaddr(kernel_pg_dir[i]);
 			if (pmd > last)
 				last = pmd;
 		}
@@ -118,6 +120,8 @@ static void __init map_node(int node)
 #define ROOTTREESIZE (32*1024*1024)
 	unsigned long physaddr, virtaddr, size;
 	pgd_t *pgd_dir;
+	p4d_t *p4d_dir;
+	pud_t *pud_dir;
 	pmd_t *pmd_dir;
 	pte_t *pte_dir;
 
@@ -149,14 +153,16 @@ static void __init map_node(int node)
 				continue;
 			}
 		}
-		if (!pgd_present(*pgd_dir)) {
+		p4d_dir = p4d_offset(pgd_dir, virtaddr);
+		pud_dir = pud_offset(p4d_dir, virtaddr);
+		if (!pud_present(*pud_dir)) {
 			pmd_dir = kernel_ptr_table();
 #ifdef DEBUG
 			printk ("[new pointer %p]", pmd_dir);
 #endif
-			pgd_set(pgd_dir, pmd_dir);
+			pud_set(pud_dir, pmd_dir);
 		} else
-			pmd_dir = pmd_offset(pgd_dir, virtaddr);
+			pmd_dir = pmd_offset(pud_dir, virtaddr);
 
 		if (CPU_IS_020_OR_030) {
 			if (virtaddr) {
@@ -304,4 +310,3 @@ void __init paging_init(void)
 			node_set_state(i, N_NORMAL_MEMORY);
 	}
 }
-
diff --git a/arch/m68k/sun3x/dvma.c b/arch/m68k/sun3x/dvma.c
index 89e630e..c4b8aa1 100644
--- a/arch/m68k/sun3x/dvma.c
+++ b/arch/m68k/sun3x/dvma.c
@@ -80,6 +80,8 @@ inline int dvma_map_cpu(unsigned long kaddr,
 			       unsigned long vaddr, int len)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	unsigned long end;
 	int ret = 0;
 
@@ -90,12 +92,14 @@ inline int dvma_map_cpu(unsigned long kaddr,
 
 	pr_debug("dvma: mapping kern %08lx to virt %08lx\n", kaddr, vaddr);
 	pgd = pgd_offset_k(vaddr);
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 
 	do {
 		pmd_t *pmd;
 		unsigned long end2;
 
-		if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) == NULL) {
+		if((pmd = pmd_alloc(&init_mm, pud, vaddr)) == NULL) {
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -196,4 +200,3 @@ void dvma_unmap_iommu(unsigned long baddr, int len)
 	}
 
 }
-
-- 
2.7.4

