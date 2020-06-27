Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5420C254
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgF0Of6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgF0Of6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:35:58 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBD620FC3;
        Sat, 27 Jun 2020 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268556;
        bh=nq/GJ3bVjcU32FBhL0HJSrQpHkiF2L5ZOjOgh+5/sMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmaDDCPUOh46Hv/gc9MKJafkQGReoVe5ws4Jq6w91zZx+Tv/vEv/l3Mg33Iikh9vt
         GosBb+A3COpOB4igTMACJrHN7fTDwU990HxXA4AbcDtBmhnfG50/sv3HAQpj4hkzgG
         WFvYVhPppiVA/kvSqtVh7rNouXnmvS9M/mExbE30=
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
Subject: [PATCH 6/8] asm-generic: pgalloc: provide generic pgd_free()
Date:   Sat, 27 Jun 2020 17:34:51 +0300
Message-Id: <20200627143453.31835-7-rppt@kernel.org>
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

Most architectures define pgd_free() as a wrapper for free_page().

Provide a generic version in asm-generic/pgalloc.h and enable its use for
most architectures.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/pgalloc.h      | 6 ------
 arch/arm/include/asm/pgalloc.h        | 1 +
 arch/arm64/include/asm/pgalloc.h      | 1 +
 arch/csky/include/asm/pgalloc.h       | 7 +------
 arch/hexagon/include/asm/pgalloc.h    | 7 +------
 arch/ia64/include/asm/pgalloc.h       | 5 -----
 arch/m68k/include/asm/sun3_pgalloc.h  | 7 +------
 arch/microblaze/include/asm/pgalloc.h | 6 ------
 arch/mips/include/asm/pgalloc.h       | 5 -----
 arch/nds32/mm/mm-nds32.c              | 2 ++
 arch/nios2/include/asm/pgalloc.h      | 7 +------
 arch/parisc/include/asm/pgalloc.h     | 1 +
 arch/riscv/include/asm/pgalloc.h      | 5 -----
 arch/sh/include/asm/pgalloc.h         | 1 +
 arch/um/include/asm/pgalloc.h         | 1 -
 arch/um/kernel/mem.c                  | 5 -----
 arch/x86/include/asm/pgalloc.h        | 1 +
 arch/xtensa/include/asm/pgalloc.h     | 5 -----
 include/asm-generic/pgalloc.h         | 7 +++++++
 19 files changed, 18 insertions(+), 62 deletions(-)

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 4834cd52e9d0..9c6a24fe493d 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -34,10 +34,4 @@ pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-static inline void
-pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
 #endif /* _ALPHA_PGALLOC_H */
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index c5bdfd404ea5..15f4674715f8 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -65,6 +65,7 @@ static inline void clean_pte_table(pte_t *pte)
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
 #define __HAVE_ARCH_PTE_ALLOC_ONE
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline pte_t *
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 0965945b595d..3c6a7f5988b1 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -13,6 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index c7c1ed27e348..d58d8146b729 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -9,7 +9,7 @@
 #include <linux/sched.h>
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 					pte_t *pte)
@@ -42,11 +42,6 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_pages((unsigned long)pgd, PGD_ORDER);
-}
-
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index cc9be514a676..f0c47e6a7427 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -11,7 +11,7 @@
 #include <asm/mem-layout.h>
 #include <asm/atomic.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 extern unsigned long long kmap_generation;
 
@@ -41,11 +41,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return pgd;
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long) pgd);
-}
-
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte)
 {
diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index 06f80358e20f..9601cfe83c94 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -29,11 +29,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
 #if CONFIG_PGTABLE_LEVELS == 4
 static inline void
 p4d_populate(struct mm_struct *mm, p4d_t * p4d_entry, pud_t * pud)
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 11b95dadf7c0..000f64869b91 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -13,7 +13,7 @@
 
 #include <asm/tlb.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 extern const char bad_pmd_string[];
 
@@ -40,11 +40,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
  */
 #define pmd_free(mm, x)			do { } while (0)
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-        free_page((unsigned long) pgd);
-}
-
 static inline pgd_t * pgd_alloc(struct mm_struct *mm)
 {
      pgd_t *new_pgd;
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index ebb6b7939bb8..8839ce00ea05 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -28,12 +28,6 @@ static inline pgd_t *get_pgd(void)
 	return (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
 }
 
-static inline void free_pgd(pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
-#define pgd_free(mm, pgd)	free_pgd(pgd)
 #define pgd_alloc(mm)		get_pgd()
 
 #define pmd_pgtable(pmd)	pmd_page(pmd)
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index e5a840910ce0..8b18424b3120 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -49,11 +49,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(unsigned long page);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_pages((unsigned long)pgd, PGD_ORDER);
-}
-
 #define __pte_free_tlb(tlb,pte,address)			\
 do {							\
 	pgtable_pte_page_dtor(pte);			\
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
index 8503bee882d1..55bec50ccc03 100644
--- a/arch/nds32/mm/mm-nds32.c
+++ b/arch/nds32/mm/mm-nds32.c
@@ -2,6 +2,8 @@
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <linux/init_task.h>
+
+#define __HAVE_ARCH_PGD_FREE
 #include <asm/pgalloc.h>
 
 #define FIRST_KERNEL_PGD_NR	(USER_PTRS_PER_PGD)
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 0b146d773c85..e6600d2a5ae0 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -12,7 +12,7 @@
 
 #include <linux/mm.h>
 
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+#include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte)
@@ -34,11 +34,6 @@ extern void pmd_init(unsigned long page, unsigned long pagetable);
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_pages((unsigned long)pgd, PGD_ORDER);
-}
-
 #define __pte_free_tlb(tlb, pte, addr)				\
 	do {							\
 		pgtable_pte_page_dtor(pte);			\
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 689766b914ed..cc7ecc2ef55d 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -11,6 +11,7 @@
 #include <asm/cache.h>
 
 #define __HAVE_ARCH_PMD_FREE
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 /* Allocate the top level pgd (page directory)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 8d3135f05b8e..23b1544e0ca5 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -55,11 +55,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return pgd;
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
 #ifndef __PAGETABLE_PMD_FOLDED
 
 #define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 59263df76f51..3d832472cbab 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -6,6 +6,7 @@
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PMD_FREE
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 extern pgd_t *pgd_alloc(struct mm_struct *);
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index bdde433dbdec..5393e13e07e0 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,7 +25,6 @@
  * Allocate and free page tables.
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
-extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 #define __pte_free_tlb(tlb,pte, address)		\
 do {							\
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index a4accb14cbd5..9242dc91d751 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -196,11 +196,6 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	return pgd;
 }
 
-void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long) pgd);
-}
-
 void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 3d1085a14347..62ad61d6fefc 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -7,6 +7,7 @@
 #include <linux/pagemap.h>
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 60ee94b42850..699a8fdf9005 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -33,11 +33,6 @@ pgd_alloc(struct mm_struct *mm)
 	return (pgd_t*) __get_free_pages(GFP_KERNEL | __GFP_ZERO, PGD_ORDER);
 }
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
-}
-
 static inline void ptes_clear(pte_t *ptep)
 {
 	int i;
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index d361574aaadf..6f44810921aa 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -175,6 +175,13 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
 
+#ifndef __HAVE_ARCH_PGD_FREE
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	free_page((unsigned long)pgd);
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
-- 
2.26.2

