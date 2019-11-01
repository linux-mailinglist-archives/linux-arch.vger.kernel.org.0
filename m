Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52374EBF80
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 09:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKAIlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 04:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfKAIlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 04:41:00 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A61D21924;
        Fri,  1 Nov 2019 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572597658;
        bh=E0BDuoRZQeTjF4nz9E/q7biOG/ySIjksDw4YyyLV0BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STu4+9xVvJiDLN3ydWT5Tmt9CLCG12U/dQWq7NaeDGt2QEHX/lafZQ+F9rqVc4fle
         JquIbMSdQ6hiEVpBegrFjJZNfbtotigub7xHCA87DYGk4aweCb/5jefFmjY2L439tm
         NiWensCF06Bx7qf9Ft3PgEtauy+glk7Q8hTasILw=
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
Subject: [PATCH v2 07/13] nds32: use pgtable-nopmd instead of 4level-fixup
Date:   Fri,  1 Nov 2019 10:39:38 +0200
Message-Id: <1572597584-6390-8-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572597584-6390-1-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

nds32 has only two-level page tables and can use pgtable-nopmd and folding
of the upper layers.

Replace usage of include/asm-generic/4level-fixup.h and explicit definition
of __PAGETABLE_PMD_FOLDED in nds32 with include/asm-generic/pgtable-nopmd.h
and adjust page table manipulation macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/include/asm/page.h    |  3 ---
 arch/nds32/include/asm/pgalloc.h |  3 ---
 arch/nds32/include/asm/pgtable.h | 12 +-----------
 arch/nds32/include/asm/tlb.h     |  1 -
 arch/nds32/kernel/pm.c           |  4 +++-
 arch/nds32/mm/fault.c            | 16 +++++++++++++---
 arch/nds32/mm/init.c             | 11 ++++++++---
 arch/nds32/mm/mm-nds32.c         |  6 +++++-
 arch/nds32/mm/proc.c             | 26 +++++++++++++++++---------
 9 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
index 8feb1fa..86b3201 100644
--- a/arch/nds32/include/asm/page.h
+++ b/arch/nds32/include/asm/page.h
@@ -41,17 +41,14 @@ void clear_page(void *page);
 void copy_page(void *to, void *from);
 
 typedef unsigned long pte_t;
-typedef unsigned long pmd_t;
 typedef unsigned long pgd_t;
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)      (x)
-#define pmd_val(x)      (x)
 #define pgd_val(x)	(x)
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)
-#define __pmd(x)        (x)
 #define __pgd(x)        (x)
 #define __pgprot(x)     (x)
 
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 37125e6..85c1173 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -15,9 +15,6 @@
 /*
  * Since we have only two-level page tables, these are trivial
  */
-#define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, pmd)			do { } while (0)
-#define pgd_populate(mm, pmd, pte)	BUG()
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 0588ec9..a80b9c6 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -4,8 +4,7 @@
 #ifndef _ASMNDS32_PGTABLE_H
 #define _ASMNDS32_PGTABLE_H
 
-#define __PAGETABLE_PMD_FOLDED 1
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopmd.h>
 #include <linux/sizes.h>
 
 #include <asm/memory.h>
@@ -19,26 +18,20 @@
 #ifdef CONFIG_ANDES_PAGE_SIZE_4KB
 #define PGDIR_SHIFT      22
 #define PTRS_PER_PGD     1024
-#define PMD_SHIFT        22
-#define PTRS_PER_PMD     1
 #define PTRS_PER_PTE     1024
 #endif
 
 #ifdef CONFIG_ANDES_PAGE_SIZE_8KB
 #define PGDIR_SHIFT      24
 #define PTRS_PER_PGD     256
-#define PMD_SHIFT        24
-#define PTRS_PER_PMD     1
 #define PTRS_PER_PTE     2048
 #endif
 
 #ifndef __ASSEMBLY__
 extern void __pte_error(const char *file, int line, unsigned long val);
-extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
-#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 #endif /* !__ASSEMBLY__ */
 
@@ -366,9 +359,6 @@ static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
 
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(dir, addr)	((pmd_t *)(dir))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const unsigned long mask = 0xfff;
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
index a8aff1c..6726038 100644
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -7,6 +7,5 @@
 #include <asm-generic/tlb.h>
 
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tln)->mm, pmd)
 
 #endif
diff --git a/arch/nds32/kernel/pm.c b/arch/nds32/kernel/pm.c
index ffa8040..e25700e 100644
--- a/arch/nds32/kernel/pm.c
+++ b/arch/nds32/kernel/pm.c
@@ -14,6 +14,7 @@ unsigned int *phy_addr_sp_tmp;
 static void nds32_suspend2ram(void)
 {
 	pgd_t *pgdv;
+	p4d_t *p4dv;
 	pud_t *pudv;
 	pmd_t *pmdv;
 	pte_t *ptev;
@@ -21,7 +22,8 @@ static void nds32_suspend2ram(void)
 	pgdv = (pgd_t *)__va((__nds32__mfsr(NDS32_SR_L1_PPTB) &
 		L1_PPTB_mskBASE)) + pgd_index((unsigned int)cpu_resume);
 
-	pudv = pud_offset(pgdv, (unsigned int)cpu_resume);
+	p4dv = p4d_offset(pgdv, (unsigned int)cpu_resume);
+	pudv = pud_offset(p4dv, (unsigned int)cpu_resume);
 	pmdv = pmd_offset(pudv, (unsigned int)cpu_resume);
 	ptev = pte_offset_map(pmdv, (unsigned int)cpu_resume);
 
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 064ae5d..906dfb2 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -31,6 +31,8 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 	pr_alert("[%08lx] *pgd=%08lx", addr, pgd_val(*pgd));
 
 	do {
+		p4d_t *p4d;
+		pud_t *pud;
 		pmd_t *pmd;
 
 		if (pgd_none(*pgd))
@@ -41,7 +43,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 		}
 
-		pmd = pmd_offset(pgd, addr);
+		p4d = p4d_offset(pgd, addr);
+		pud = pud_offset(p4d, addr);
+		pmd = pmd_offset(pud, addr);
 #if PTRS_PER_PMD != 1
 		pr_alert(", *pmd=%08lx", pmd_val(*pmd));
 #endif
@@ -359,6 +363,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 
 		unsigned int index = pgd_index(addr);
 		pgd_t *pgd, *pgd_k;
+		p4d_t *p4d, *p4d_k;
 		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
@@ -369,8 +374,13 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		if (!pgd_present(*pgd_k))
 			goto no_context;
 
-		pud = pud_offset(pgd, addr);
-		pud_k = pud_offset(pgd_k, addr);
+		p4d = p4d_offset(pgd, addr);
+		p4d_k = p4d_offset(pgd_k, addr);
+		if (!p4d_present(*p4d_k))
+			goto no_context;
+
+		pud = pud_offset(p4d, addr);
+		pud_k = pud_offset(p4d_k, addr);
 		if (!pud_present(*pud_k))
 			goto no_context;
 
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 55703b0..0be3833f 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -54,6 +54,7 @@ static void __init map_ram(void)
 {
 	unsigned long v, p, e;
 	pgd_t *pge;
+	p4d_t *p4e;
 	pud_t *pue;
 	pmd_t *pme;
 	pte_t *pte;
@@ -69,7 +70,8 @@ static void __init map_ram(void)
 
 	while (p < e) {
 		int j;
-		pue = pud_offset(pge, v);
+		p4e = p4d_offset(pge, v);
+		pue = pud_offset(p4e, v);
 		pme = pmd_offset(pue, v);
 
 		if ((u32) pue != (u32) pge || (u32) pme != (u32) pge) {
@@ -100,6 +102,7 @@ static void __init fixedrange_init(void)
 {
 	unsigned long vaddr;
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 #ifdef CONFIG_HIGHMEM
@@ -111,7 +114,8 @@ static void __init fixedrange_init(void)
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pud = pud_offset(pgd, vaddr);
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 	pmd = pmd_offset(pud, vaddr);
 	fixmap_pmd_p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!fixmap_pmd_p)
@@ -126,7 +130,8 @@ static void __init fixedrange_init(void)
 	vaddr = PKMAP_BASE;
 
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pud = pud_offset(pgd, vaddr);
+	p4d = p4d_offset(pgd, vaddr);
+	pud = pud_offset(p4d, vaddr);
 	pmd = pmd_offset(pud, vaddr);
 	pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!pte)
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
index 3b43798..8503bee 100644
--- a/arch/nds32/mm/mm-nds32.c
+++ b/arch/nds32/mm/mm-nds32.c
@@ -74,6 +74,8 @@ void setup_mm_for_reboot(char mode)
 {
 	unsigned long pmdval;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	int i;
 
@@ -84,7 +86,9 @@ void setup_mm_for_reboot(char mode)
 
 	for (i = 0; i < USER_PTRS_PER_PGD; i++) {
 		pmdval = (i << PGDIR_SHIFT);
-		pmd = pmd_offset(pgd + i, i << PGDIR_SHIFT);
+		p4d = p4d_offset(pgd, i << PGDIR_SHIFT);
+		pud = pud_offset(p4d, i << PGDIR_SHIFT);
+		pmd = pmd_offset(pud + i, i << PGDIR_SHIFT);
 		set_pmd(pmd, __pmd(pmdval));
 	}
 }
diff --git a/arch/nds32/mm/proc.c b/arch/nds32/mm/proc.c
index ba80992..837ae77 100644
--- a/arch/nds32/mm/proc.c
+++ b/arch/nds32/mm/proc.c
@@ -16,10 +16,14 @@ extern struct cache_info L1_cache_info[2];
 
 int va_kernel_present(unsigned long addr)
 {
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
-	pmd = pmd_offset(pgd_offset_k(addr), addr);
+	p4d = p4d_offset(pgd_offset_k(addr), addr);
+	pud = pud_offset(p4d, addr);
+	pmd = pmd_offset(pud, addr);
 	if (!pmd_none(*pmd)) {
 		ptep = pte_offset_map(pmd, addr);
 		pte = *ptep;
@@ -32,20 +36,24 @@ int va_kernel_present(unsigned long addr)
 pte_t va_present(struct mm_struct * mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
-		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd)) {
-				ptep = pte_offset_map(pmd, addr);
-				pte = *ptep;
-				if (pte_present(pte))
-					return pte;
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_none(*p4d)) {
+			pud = pud_offset(p4d, addr);
+			if (!pud_none(*pud)) {
+				pmd = pmd_offset(pud, addr);
+				if (!pmd_none(*pmd)) {
+					ptep = pte_offset_map(pmd, addr);
+					pte = *ptep;
+					if (pte_present(pte))
+						return pte;
+				}
 			}
 		}
 	}
-- 
2.7.4

