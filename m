Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15DEF8398
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKKXfc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 18:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfKKXfc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Nov 2019 18:35:32 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB7021925;
        Mon, 11 Nov 2019 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573515329;
        bh=KKg7QU75N1zXG/gjhwJY36OdICQm52LxrySeR54MGY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=foOPkDeM2KxJVsS7Takn6Pzko1isfVt9Y86qCkg2sotKyy1uMLQWtM8aZdT4XlFTH
         gfW0a3Gvp6I4CoFav1qutW7K1ghgrhg4iENBrFoeY8OiYlPoI5UcUjLVrTXl8+NjKz
         hZL1OC0aDpYjpAdbIH9dl8WlKpZXQ7Hlt1Xw/1TM=
Date:   Mon, 11 Nov 2019 15:35:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of
 4level-fixup
Message-Id: <20191111153528.6deb93aa821d91cfe52816c5@linux-foundation.org>
In-Reply-To: <CAMuHMdXdoFSVno4WT=F6Q1UwEaZ6AQJmhNUqPpYHJm6uh165iw@mail.gmail.com>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
        <1572938135-31886-6-git-send-email-rppt@kernel.org>
        <20191108113917.a9c6ebb8373cc95fd684b734@linux-foundation.org>
        <CAMuHMdXdoFSVno4WT=F6Q1UwEaZ6AQJmhNUqPpYHJm6uh165iw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 9 Nov 2019 15:26:29 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, Nov 8, 2019 at 8:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue,  5 Nov 2019 09:15:27 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > > m68k has two or three levels of page tables and can use appropriate
> > > pgtable-nopXd and folding of the upper layers.
> > >
> > > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > > adjust page table manipulation macros and functions accordingly.
> >
> > This one was messed up by linux-next changes in arch/m68k/mm/kmap.c.
> > Can you please take a look?
> 
> You mean due to the rename and move of __iounmap() to __free_io_area()
> in commit aa3a1664285d0bec ("m68k: rename __iounmap and mark it static")?
> 
> Commit 42d6c83d6180f800 ("m68k: mm: use pgtable-nopXd instead of
> 4level-fixup") in next-20191108 looks good to me.

I seem to be getting a different reject now and I'm not sure why.

Oh well, I fixed things up.

From: Mike Rapoport <rppt@linux.ibm.com>
Subject: m68k: mm: use pgtable-nopXd instead of 4level-fixup

m68k has two or three levels of page tables and can use appropriate
pgtable-nopXd and folding of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h and explicit
definitions of __PAGETABLE_PxD_FOLDED in m68k with
include/asm-generic/pgtable-nopmd.h for two-level configurations and with
include/asm-generic/pgtable-nopud.h for three-lelve configurations and
adjust page table manipulation macros and functions accordingly.

Link: http://lkml.kernel.org/r/1572938135-31886-6-git-send-email-rppt@kernel.org
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Salter <msalter@redhat.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Peter Rosin <peda@axentia.se>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/m68k/include/asm/mcf_pgalloc.h      |    7 ----
 arch/m68k/include/asm/mcf_pgtable.h      |   28 ++++++------------
 arch/m68k/include/asm/mmu_context.h      |   12 +++++++
 arch/m68k/include/asm/motorola_pgalloc.h |    4 +-
 arch/m68k/include/asm/motorola_pgtable.h |   32 +++++++++++++--------
 arch/m68k/include/asm/page.h             |    9 +++--
 arch/m68k/include/asm/pgtable_mm.h       |   11 ++++---
 arch/m68k/include/asm/sun3_pgalloc.h     |    5 ---
 arch/m68k/include/asm/sun3_pgtable.h     |   18 -----------
 arch/m68k/kernel/sys_m68k.c              |   10 +++++-
 arch/m68k/mm/init.c                      |    6 ++-
 arch/m68k/mm/kmap.c                      |   24 +++++++++++----
 arch/m68k/mm/mcfmmu.c                    |   16 +++++++++-
 arch/m68k/mm/motorola.c                  |   17 +++++++----
 arch/m68k/sun3x/dvma.c                   |    7 +++-
 15 files changed, 118 insertions(+), 88 deletions(-)

--- a/arch/m68k/include/asm/mcf_pgalloc.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/mcf_pgalloc.h
@@ -28,9 +28,6 @@ extern inline pmd_t *pmd_alloc_kernel(pg
 	return (pmd_t *) pgd;
 }
 
-#define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
-#define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
-
 #define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
 	(unsigned long)(page_address(page)))
 
@@ -45,8 +42,6 @@ static inline void __pte_free_tlb(struct
 	__free_page(page);
 }
 
-#define __pmd_free_tlb(tlb, pmd, address) do { } while (0)
-
 static inline struct page *pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_DMA, 0);
@@ -100,6 +95,4 @@ static inline pgd_t *pgd_alloc(struct mm
 	return new_pgd;
 }
 
-#define pgd_populate(mm, pmd, pte) BUG()
-
 #endif /* M68K_MCF_PGALLOC_H */
--- a/arch/m68k/include/asm/mcf_pgtable.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/mcf_pgtable.h
@@ -198,17 +198,9 @@ static inline int pmd_bad2(pmd_t *pmd) {
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
@@ -340,14 +332,6 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD]
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
@@ -360,12 +344,16 @@ static inline pmd_t *pmd_offset(pgd_t *p
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
@@ -376,12 +364,16 @@ static inline void nocache_page(void *va
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
--- a/arch/m68k/include/asm/mmu_context.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/mmu_context.h
@@ -100,6 +100,8 @@ static inline void load_ksp_mmu(struct t
 	struct mm_struct *mm;
 	int asid;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long mmuar;
@@ -127,7 +129,15 @@ static inline void load_ksp_mmu(struct t
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
 
--- a/arch/m68k/include/asm/motorola_pgalloc.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/motorola_pgalloc.h
@@ -106,9 +106,9 @@ static inline void pmd_populate(struct m
 }
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pgd_set(pgd, pmd);
+	pud_set(pud, pmd);
 }
 
 #endif /* _MOTOROLA_PGALLOC_H */
--- a/arch/m68k/include/asm/motorola_pgtable.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/motorola_pgtable.h
@@ -117,14 +117,14 @@ static inline void pmd_set(pmd_t *pmdp,
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
@@ -147,11 +147,11 @@ static inline void pgd_set(pgd_t *pgdp,
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
@@ -209,9 +209,9 @@ static inline pgd_t *pgd_offset_k(unsign
 
 
 /* Find an entry in the second-level page table.. */
-static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
+static inline pmd_t *pmd_offset(pud_t *dir, unsigned long address)
 {
-	return (pmd_t *)__pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PMD-1));
+	return (pmd_t *)pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PMD-1));
 }
 
 /* Find an entry in the third-level page table.. */
@@ -239,11 +239,15 @@ static inline void nocache_page(void *va
 
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
@@ -255,11 +259,15 @@ static inline void cache_page(void *vadd
 
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
--- a/arch/m68k/include/asm/page.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/page.h
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
 
--- a/arch/m68k/include/asm/pgtable_mm.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/pgtable_mm.h
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
--- a/arch/m68k/include/asm/sun3_pgalloc.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,8 +17,6 @@
 
 extern const char bad_pmd_string[];
 
-#define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
-
 #define __pte_free_tlb(tlb,pte,addr)			\
 do {							\
 	pgtable_pte_page_dtor(pte);			\
@@ -41,7 +39,6 @@ static inline void pmd_populate(struct m
  * inside the pgd, so has no extra memory associated with it.
  */
 #define pmd_free(mm, x)			do { } while (0)
-#define __pmd_free_tlb(tlb, x, addr)	do { } while (0)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
@@ -58,6 +55,4 @@ static inline pgd_t * pgd_alloc(struct m
      return new_pgd;
 }
 
-#define pgd_populate(mm, pmd, pte) BUG()
-
 #endif /* SUN3_PGALLOC_H */
--- a/arch/m68k/include/asm/sun3_pgtable.h~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/include/asm/sun3_pgtable.h
@@ -110,11 +110,6 @@ static inline pte_t pte_modify(pte_t pte
 
 #define pmd_set(pmdp,ptep) do {} while (0)
 
-static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
-{
-	pgd_val(*pgdp) = virt_to_phys(pmdp);
-}
-
 #define __pte_page(pte) \
 ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
 #define __pmd_page(pmd) \
@@ -145,16 +140,9 @@ static inline int pmd_present2 (pmd_t *p
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
 
@@ -194,12 +182,6 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD]
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
--- a/arch/m68k/kernel/sys_m68k.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/kernel/sys_m68k.c
@@ -465,6 +465,8 @@ sys_atomic_cmpxchg_32(unsigned long newv
 	for (;;) {
 		struct mm_struct *mm = current->mm;
 		pgd_t *pgd;
+		p4d_t *p4d;
+		pud_t *pud;
 		pmd_t *pmd;
 		pte_t *pte;
 		spinlock_t *ptl;
@@ -474,7 +476,13 @@ sys_atomic_cmpxchg_32(unsigned long newv
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
--- a/arch/m68k/mm/init.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/mm/init.c
@@ -130,8 +130,10 @@ static inline void init_pointer_tables(v
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
--- a/arch/m68k/mm/kmap.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/mm/kmap.c
@@ -159,6 +159,8 @@ void __iomem *__ioremap(unsigned long ph
 	unsigned long virtaddr, retaddr;
 	long offset;
 	pgd_t *pgd_dir;
+	p4d_t *p4d_dir;
+	pud_t *pud_dir;
 	pmd_t *pmd_dir;
 	pte_t *pte_dir;
 
@@ -245,18 +247,23 @@ void __iomem *__ioremap(unsigned long ph
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
@@ -338,16 +345,20 @@ void kernel_set_cachemode(void *addr, un
 			cmode = 0;
 		}
 	}
+#endif
 
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
 
@@ -359,6 +370,7 @@ void kernel_set_cachemode(void *addr, un
 				continue;
 			}
 		}
+#endif
 
 		if (pmd_bad(*pmd_dir)) {
 			printk("iocachemode: bad pmd (%08lx)\n", pmd_val(*pmd_dir));
--- a/arch/m68k/mm/mcfmmu.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/mm/mcfmmu.c
@@ -92,6 +92,8 @@ int cf_tlb_miss(struct pt_regs *regs, in
 	unsigned long flags, mmuar, mmutr;
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	int asid;
@@ -113,7 +115,19 @@ int cf_tlb_miss(struct pt_regs *regs, in
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
--- a/arch/m68k/mm/motorola.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/mm/motorola.c
@@ -82,9 +82,11 @@ static pmd_t * __init kernel_ptr_table(v
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
--- a/arch/m68k/sun3x/dvma.c~m68k-mm-use-pgtable-nopxd-instead-of-4level-fixup
+++ a/arch/m68k/sun3x/dvma.c
@@ -80,6 +80,8 @@ inline int dvma_map_cpu(unsigned long ka
 			       unsigned long vaddr, int len)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	unsigned long end;
 	int ret = 0;
 
@@ -90,12 +92,14 @@ inline int dvma_map_cpu(unsigned long ka
 
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
@@ -196,4 +200,3 @@ void dvma_unmap_iommu(unsigned long badd
 	}
 
 }
-
_

