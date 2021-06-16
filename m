Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC983AA72E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 01:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFPXKN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 19:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhFPXKN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 19:10:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6CDF61027;
        Wed, 16 Jun 2021 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623884885;
        bh=EmQ78NetVi6dpbGcWRaa9YJ5VKzTJl5902fRKkfj4VM=;
        h=Date:From:To:Subject:From;
        b=lBlxM+8Xto1kBWUuzb9Nvqcv1UJVwVFDMMVKbfsjQcloHm1Aao75xPo23aQtohF6C
         W8fg6VIuWhNvr+uvPeJI3w6m/gi0vgFhfkw5uJANA1Te4pS1rEoGx9zneQoTiHcBLX
         cJ47pZivMdmMjj/sQjSoDmno3320wcoaw4lazDnE=
Date:   Wed, 16 Jun 2021 16:08:04 -0700
From:   akpm@linux-foundation.org
To:     aneesh.kumar@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mm-commits@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject:  [to-be-updated]
 mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
 removed from -mm tree
Message-ID: <20210616230804.7nsBdkkF4%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


The patch titled
     Subject: mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *
has been removed from the -mm tree.  Its filename was
     mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch

This patch was dropped because an updated version will be merged

------------------------------------------------------
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *

No functional change in this patch.

Link: https://lkml.kernel.org/r/20210615110859.320299-1-aneesh.kumar@linux.ibm.com
Link: https://lore.kernel.org/linuxppc-dev/CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com/
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-ia64@vger.kernel.org>
Cc: <linux-m68k@lists.linux-m68k.org>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-parisc@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-riscv@lists.infradead.org>
Cc: <linux-sh@vger.kernel.org>
Cc: <sparclinux@vger.kernel.org>
Cc: <linux-um@lists.infradead.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/alpha/include/asm/pgtable.h             |    8 +++++---
 arch/arm/include/asm/pgtable-3level.h        |    2 +-
 arch/arm64/include/asm/pgtable.h             |    4 ++--
 arch/ia64/include/asm/pgtable.h              |    2 +-
 arch/m68k/include/asm/motorola_pgtable.h     |    2 +-
 arch/mips/include/asm/pgtable-64.h           |    4 ++--
 arch/parisc/include/asm/pgtable.h            |    4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |    6 +++++-
 arch/powerpc/include/asm/nohash/64/pgtable.h |    6 +++++-
 arch/powerpc/mm/book3s64/radix_pgtable.c     |    4 ++--
 arch/powerpc/mm/pgtable_64.c                 |    2 +-
 arch/riscv/include/asm/pgtable-64.h          |    4 ++--
 arch/sh/include/asm/pgtable-3level.h         |    4 ++--
 arch/sparc/include/asm/pgtable_32.h          |    4 ++--
 arch/sparc/include/asm/pgtable_64.h          |    6 +++---
 arch/um/include/asm/pgtable-3level.h         |    2 +-
 arch/x86/include/asm/pgtable.h               |    4 ++--
 arch/x86/mm/pat/set_memory.c                 |    4 ++--
 arch/x86/mm/pgtable.c                        |    2 +-
 include/asm-generic/pgtable-nopmd.h          |    2 +-
 include/asm-generic/pgtable-nopud.h          |    2 +-
 include/linux/pgtable.h                      |    2 +-
 22 files changed, 45 insertions(+), 35 deletions(-)

--- a/arch/alpha/include/asm/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/alpha/include/asm/pgtable.h
@@ -236,8 +236,10 @@ pmd_page_vaddr(pmd_t pmd)
 #define pmd_page(pmd)	(pfn_to_page(pmd_val(pmd) >> 32))
 #define pud_page(pud)	(pfn_to_page(pud_val(pud) >> 32))
 
-extern inline unsigned long pud_page_vaddr(pud_t pgd)
-{ return PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+static inline pmd_t *pud_pgtable(pud_t pgd)
+{
+	return (pmd_t *)(PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)));
+}
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
@@ -287,7 +289,7 @@ extern inline pte_t pte_mkyoung(pte_t pt
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	pmd_t *ret = pud_pgtable(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 	smp_rmb(); /* see above */
 	return ret;
 }
--- a/arch/arm64/include/asm/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/arm64/include/asm/pgtable.h
@@ -633,9 +633,9 @@ static inline phys_addr_t pud_page_paddr
 	return __pud_to_phys(pud);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_page_paddr(pud));
+	return (pmd_t *)__va(pud_page_paddr(pud));
 }
 
 /* Find an entry in the second-level page table. */
--- a/arch/arm/include/asm/pgtable-3level.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/arm/include/asm/pgtable-3level.h
@@ -130,7 +130,7 @@
 		flush_pmd_entry(pudp);	\
 	} while (0)
 
-static inline pmd_t *pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
--- a/arch/ia64/include/asm/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/ia64/include/asm/pgtable.h
@@ -273,7 +273,7 @@ ia64_phys_addr_valid (unsigned long addr
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page_vaddr(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_pgtable(pud)		((pmd_t *) __va(pud_val(pud) & _PFN_MASK))
 #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #if CONFIG_PGTABLE_LEVELS == 4
--- a/arch/m68k/include/asm/motorola_pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/m68k/include/asm/motorola_pgtable.h
@@ -131,7 +131,7 @@ static inline void pud_set(pud_t *pudp,
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define pmd_page_vaddr(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
-#define pud_page_vaddr(pud) ((unsigned long)__va(pud_val(pud) & _TABLE_MASK))
+#define pud_pgtable(pud) ((pmd_t *)__va(pud_val(pud) & _TABLE_MASK))
 
 
 #define pte_none(pte)		(!pte_val(pte))
--- a/arch/mips/include/asm/pgtable-64.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/mips/include/asm/pgtable-64.h
@@ -313,9 +313,9 @@ static inline void pud_clear(pud_t *pudp
 #endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
--- a/arch/parisc/include/asm/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/parisc/include/asm/pgtable.h
@@ -322,8 +322,8 @@ static inline void pmd_clear(pmd_t *pmd)
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_address(pud)))
-#define pud_page(pud)	virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_address(pud)))
+#define pud_page(pud)	virt_to_page((void *)pud_pgtable(pud))
 
 /* For 64 bit we have three level tables */
 
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1048,9 +1048,13 @@ extern struct page *p4d_page(p4d_t p4d);
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
-#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 #define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)__va(pud_val(pud) & ~PUD_MASKED_BITS);
+}
+
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -162,7 +162,11 @@ static inline void pud_clear(pud_t *pudp
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)(pud_val(pud) & ~PUD_MASKED_BITS);
+}
 
 extern struct page *pud_page(pud_t pud);
 
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -826,7 +826,7 @@ static void __meminit remove_pud_table(p
 			continue;
 		}
 
-		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+		pmd_base = pud_pgtable(*pud);
 		remove_pmd_table(pmd_base, addr, next);
 		free_pmd_table(pmd_base, pud);
 	}
@@ -1111,7 +1111,7 @@ int pud_free_pmd_page(pud_t *pud, unsign
 	pmd_t *pmd;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pud_clear(pud);
 
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
--- a/arch/powerpc/mm/pgtable_64.c~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/powerpc/mm/pgtable_64.c
@@ -115,7 +115,7 @@ struct page *pud_page(pud_t pud)
 		VM_WARN_ON(!pud_huge(pud));
 		return pte_page(pud_pte(pud));
 	}
-	return virt_to_page(pud_page_vaddr(pud));
+	return virt_to_page(pud_pgtable(pud));
 }
 
 /*
--- a/arch/riscv/include/asm/pgtable-64.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/riscv/include/asm/pgtable-64.h
@@ -59,9 +59,9 @@ static inline void pud_clear(pud_t *pudp
 	set_pud(pudp, __pud(0));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
--- a/arch/sh/include/asm/pgtable-3level.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/sh/include/asm/pgtable-3level.h
@@ -32,9 +32,9 @@ typedef struct { unsigned long long pmd;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
--- a/arch/sparc/include/asm/pgtable_32.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/sparc/include/asm/pgtable_32.h
@@ -151,13 +151,13 @@ static inline unsigned long pmd_page_vad
 	return (unsigned long)__nocache_va(v << 4);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
 		return ~0;
 	} else {
 		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
-		return (unsigned long)__nocache_va(v << 4);
+		return (pmd_t *)__nocache_va(v << 4);
 	}
 }
 
--- a/arch/sparc/include/asm/pgtable_64.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/sparc/include/asm/pgtable_64.h
@@ -841,18 +841,18 @@ static inline unsigned long pmd_page_vad
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 	unsigned long pfn;
 
 	pfn = pte_pfn(pte);
 
-	return ((unsigned long) __va(pfn << PAGE_SHIFT));
+	return ((pmd_t *) __va(pfn << PAGE_SHIFT));
 }
 
 #define pmd_page(pmd) 			virt_to_page((void *)pmd_page_vaddr(pmd))
-#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_page(pud)			virt_to_page((void *)pud_pgtable(pud))
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
--- a/arch/um/include/asm/pgtable-3level.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/um/include/asm/pgtable-3level.h
@@ -83,7 +83,7 @@ static inline void pud_clear (pud_t *pud
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
--- a/arch/x86/include/asm/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/x86/include/asm/pgtable.h
@@ -865,9 +865,9 @@ static inline int pud_present(pud_t pud)
 	return pud_flags(pud) & _PAGE_PRESENT;
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_val(pud) & pud_pfn_mask(pud));
+	return (pmd_t *)__va(pud_val(pud) & pud_pfn_mask(pud));
 }
 
 /*
--- a/arch/x86/mm/pat/set_memory.c~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/x86/mm/pat/set_memory.c
@@ -1134,7 +1134,7 @@ static void __unmap_pmd_range(pud_t *pud
 			      unsigned long start, unsigned long end)
 {
 	if (unmap_pte_range(pmd, start, end))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
@@ -1178,7 +1178,7 @@ static void unmap_pmd_range(pud_t *pud,
 	 * Try again to free the PMD page if haven't succeeded above.
 	 */
 	if (!pud_none(*pud))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
--- a/arch/x86/mm/pgtable.c~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/arch/x86/mm/pgtable.c
@@ -801,7 +801,7 @@ int pud_free_pmd_page(pud_t *pud, unsign
 	pte_t *pte;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
 		return 0;
--- a/include/asm-generic/pgtable-nopmd.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/include/asm-generic/pgtable-nopmd.h
@@ -51,7 +51,7 @@ static inline pmd_t * pmd_offset(pud_t *
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
+#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
--- a/include/asm-generic/pgtable-nopud.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/include/asm-generic/pgtable-nopud.h
@@ -49,7 +49,7 @@ static inline pud_t *pud_offset(p4d_t *p
 #define __pud(x)				((pud_t) { __p4d(x) })
 
 #define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_page_vaddr(p4d)			(pud_page_vaddr((pud_t){ p4d }))
+#define p4d_page_vaddr(p4d)			(pud_pgtable((pud_t){ p4d }))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
--- a/include/linux/pgtable.h~mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t
+++ a/include/linux/pgtable.h
@@ -106,7 +106,7 @@ static inline pte_t *pte_offset_kernel(p
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
+	return pud_pgtable(*pud) + pmd_index(address);
 }
 #define pmd_offset pmd_offset
 #endif
_

Patches currently in -mm which might be from aneesh.kumar@linux.ibm.com are

mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t-fix-2.patch
mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t.patch
mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t-fix.patch

