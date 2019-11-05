Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA9EF5F7
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 08:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfKEHQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 02:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbfKEHQB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 02:16:01 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0F32190F;
        Tue,  5 Nov 2019 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572938160;
        bh=7M6lCVb2ncno6ELpErw9X3BH6KNLAI04t4hzOFAV4Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4lYC+VwAqL/wrBeIL0PXJkrohmh8zrEZaicRNwd6B92Wn2f2kUGiHULfpWGLaWRj
         unmogm9FFcZjXNmkGW+xyvZWqkMLEA8d6pe3VnOGeqNx63ErqQ+0aHO/58q3dXe1X0
         SQtXOjfWAGfN+r+1bJCehp3tGGPSheRGeD63KEpM=
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
Subject: [PATCH v4 01/13] alpha: use pgtable-nopud instead of 4level-fixup
Date:   Tue,  5 Nov 2019 09:15:23 +0200
Message-Id: <1572938135-31886-2-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572938135-31886-1-git-send-email-rppt@kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

It is not likely alpha will have 5-level page tables.

Replace usage of include/asm-generic/4level-fixup.h and implied
__ARCH_HAS_4LEVEL_HACK with include/asm-generic/pgtable-nopud.h and adjust
page table manipulation macros and functions accordingly.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/mmzone.h  |  1 -
 arch/alpha/include/asm/pgalloc.h |  4 ++--
 arch/alpha/include/asm/pgtable.h | 24 ++++++++++++------------
 arch/alpha/mm/init.c             | 12 ++++++++----
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
index 889b5d3..7ee144f 100644
--- a/arch/alpha/include/asm/mmzone.h
+++ b/arch/alpha/include/asm/mmzone.h
@@ -73,7 +73,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, int n)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> 32))
-#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> 32))
 #define pte_pfn(pte)		(pte_val(pte) >> 32)
 
 #define mk_pte(page, pgprot)						     \
diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index eb91f1e..a1a29f6 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -27,9 +27,9 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 }
 
 static inline void
-pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pgd_set(pgd, pmd);
+	pud_set(pud, pmd);
 }
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 065b57f..299791c 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -2,7 +2,7 @@
 #ifndef _ALPHA_PGTABLE_H
 #define _ALPHA_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 
 /*
  * This file contains the functions and defines necessary to modify and use
@@ -226,8 +226,8 @@ extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 extern inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
 { pmd_val(*pmdp) = _PAGE_TABLE | ((((unsigned long) ptep) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
-extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ pgd_val(*pgdp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
+extern inline void pud_set(pud_t * pudp, pmd_t * pmdp)
+{ pud_val(*pudp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
 
 extern inline unsigned long
@@ -238,11 +238,11 @@ pmd_page_vaddr(pmd_t pmd)
 
 #ifndef CONFIG_DISCONTIGMEM
 #define pmd_page(pmd)	(mem_map + ((pmd_val(pmd) & _PFN_MASK) >> 32))
-#define pgd_page(pgd)	(mem_map + ((pgd_val(pgd) & _PFN_MASK) >> 32))
+#define pud_page(pud)	(mem_map + ((pud_val(pud) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pgd_page_vaddr(pgd_t pgd)
-{ return PAGE_OFFSET + ((pgd_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+extern inline unsigned long pud_page_vaddr(pud_t pgd)
+{ return PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
@@ -256,10 +256,10 @@ extern inline int pmd_bad(pmd_t pmd)		{ return (pmd_val(pmd) & ~_PFN_MASK) != _P
 extern inline int pmd_present(pmd_t pmd)	{ return pmd_val(pmd) & _PAGE_VALID; }
 extern inline void pmd_clear(pmd_t * pmdp)	{ pmd_val(*pmdp) = 0; }
 
-extern inline int pgd_none(pgd_t pgd)		{ return !pgd_val(pgd); }
-extern inline int pgd_bad(pgd_t pgd)		{ return (pgd_val(pgd) & ~_PFN_MASK) != _PAGE_TABLE; }
-extern inline int pgd_present(pgd_t pgd)	{ return pgd_val(pgd) & _PAGE_VALID; }
-extern inline void pgd_clear(pgd_t * pgdp)	{ pgd_val(*pgdp) = 0; }
+extern inline int pud_none(pud_t pud)		{ return !pud_val(pud); }
+extern inline int pud_bad(pud_t pud)		{ return (pud_val(pud) & ~_PFN_MASK) != _PAGE_TABLE; }
+extern inline int pud_present(pud_t pud)	{ return pud_val(pud) & _PAGE_VALID; }
+extern inline void pud_clear(pud_t * pudp)	{ pud_val(*pudp) = 0; }
 
 /*
  * The following only work if pte_present() is true.
@@ -301,9 +301,9 @@ extern inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
  */
 
 /* Find an entry in the second-level page table.. */
-extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *) pgd_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 	smp_read_barrier_depends(); /* see above */
 	return ret;
 }
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index e2cbec3..12e218d 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -146,6 +146,8 @@ callback_init(void * kernel_end)
 {
 	struct crb_struct * crb;
 	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
 	pmd_t *pmd;
 	void *two_pages;
 
@@ -184,8 +186,10 @@ callback_init(void * kernel_end)
 	memset(two_pages, 0, 2*PAGE_SIZE);
 
 	pgd = pgd_offset_k(VMALLOC_START);
-	pgd_set(pgd, (pmd_t *)two_pages);
-	pmd = pmd_offset(pgd, VMALLOC_START);
+	p4d = p4d_offset(pgd, VMALLOC_START);
+	pud = pud_offset(p4d, VMALLOC_START);
+	pud_set(pud, (pmd_t *)two_pages);
+	pmd = pmd_offset(pud, VMALLOC_START);
 	pmd_set(pmd, (pte_t *)(two_pages + PAGE_SIZE));
 
 	if (alpha_using_srm) {
@@ -214,9 +218,9 @@ callback_init(void * kernel_end)
 				/* Newer consoles (especially on larger
 				   systems) may require more pages of
 				   PTEs. Grab additional pages as needed. */
-				if (pmd != pmd_offset(pgd, vaddr)) {
+				if (pmd != pmd_offset(pud, vaddr)) {
 					memset(kernel_end, 0, PAGE_SIZE);
-					pmd = pmd_offset(pgd, vaddr);
+					pmd = pmd_offset(pud, vaddr);
 					pmd_set(pmd, (pte_t *)kernel_end);
 					kernel_end += PAGE_SIZE;
 				}
-- 
2.7.4

