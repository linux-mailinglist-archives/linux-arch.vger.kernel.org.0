Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAD39EE24
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHFdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 01:33:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHFdd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 01:33:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD412101E;
        Mon,  7 Jun 2021 22:31:40 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.83.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F59B3F73D;
        Mon,  7 Jun 2021 22:31:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Define default pmd_pgtable()
Date:   Tue,  8 Jun 2021 11:02:07 +0530
Message-Id: <1623130327-13325-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
same code all over. Instead just define a default value i.e pmd_page() for
pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
All the existing platform that override pmd_pgtable() have been moved into
their respective <asm/pgtable.h> header in order to precede before the new
generic definition. This makes it much cleaner with reduced code.

Cc: Nick Hu <nickhu@andestech.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on linux-next (20210607) as there is a merge conflict
dependency on the following commit.

40762590e8be ("mm: define default value for FIRST_USER_ADDRESS").

This patch has been built tested across multiple platforms. But the m68k
changes in particular might not be optimal, followed the existing switch
from (arch/m68k/include/asm/pgalloc.h).

 arch/alpha/include/asm/pgalloc.h         | 1 -
 arch/arc/include/asm/pgalloc.h           | 2 --
 arch/arc/include/asm/pgtable.h           | 2 ++
 arch/arm/include/asm/pgalloc.h           | 1 -
 arch/arm64/include/asm/pgalloc.h         | 1 -
 arch/csky/include/asm/pgalloc.h          | 2 --
 arch/hexagon/include/asm/pgtable.h       | 1 -
 arch/ia64/include/asm/pgalloc.h          | 1 -
 arch/m68k/include/asm/mcf_pgalloc.h      | 2 --
 arch/m68k/include/asm/motorola_pgalloc.h | 1 -
 arch/m68k/include/asm/pgtable.h          | 9 +++++++++
 arch/m68k/include/asm/sun3_pgalloc.h     | 1 -
 arch/microblaze/include/asm/pgalloc.h    | 2 --
 arch/mips/include/asm/pgalloc.h          | 1 -
 arch/nds32/include/asm/pgalloc.h         | 5 -----
 arch/nios2/include/asm/pgalloc.h         | 1 -
 arch/openrisc/include/asm/pgalloc.h      | 2 --
 arch/parisc/include/asm/pgalloc.h        | 1 -
 arch/powerpc/include/asm/pgalloc.h       | 5 -----
 arch/powerpc/include/asm/pgtable.h       | 6 ++++++
 arch/riscv/include/asm/pgalloc.h         | 2 --
 arch/s390/include/asm/pgalloc.h          | 3 ---
 arch/s390/include/asm/pgtable.h          | 3 +++
 arch/sh/include/asm/pgalloc.h            | 1 -
 arch/sparc/include/asm/pgalloc_32.h      | 1 -
 arch/sparc/include/asm/pgalloc_64.h      | 1 -
 arch/sparc/include/asm/pgtable_32.h      | 2 ++
 arch/sparc/include/asm/pgtable_64.h      | 2 ++
 arch/um/include/asm/pgalloc.h            | 1 -
 arch/x86/include/asm/pgalloc.h           | 2 --
 arch/xtensa/include/asm/pgalloc.h        | 2 --
 include/linux/pgtable.h                  | 9 +++++++++
 32 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 9c6a24fe493d..68be7adbfe58 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -18,7 +18,6 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
 {
 	pmd_set(pmd, (pte_t *)(page_to_pa(pte) + PAGE_OFFSET));
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 6147db925248..a32ca3104ced 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -129,6 +129,4 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptep)
 
 #define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
 
-#define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
-
 #endif /* _ASM_ARC_PGALLOC_H */
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 577682e8cc7f..320cc0ae8a08 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -350,6 +350,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 
 #define kern_addr_valid(addr)	(1)
 
+#define pmd_pgtable(pmd)       ((pgtable_t) pmd_page_vaddr(pmd))
+
 /*
  * remap a physical page `pfn' of size `size' with page protection `prot'
  * into virtual address `from'
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index fdee1f04f4f3..a17f01235c29 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -143,7 +143,6 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 
 	__pmd_populate(pmdp, page_to_phys(ptep), prot);
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 #endif /* CONFIG_MMU */
 
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 31fbab3d6f99..8433a2058eb1 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -86,6 +86,5 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 	VM_BUG_ON(mm == &init_mm);
 	__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TABLE_PXN);
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 #endif
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index cd211aabbefd..bbbd0698b397 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -22,8 +22,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd(__pa(page_address(pte))));
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
-
 extern void pgd_init(unsigned long *p);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index e4979508cddf..18cd6ea9ab23 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -239,7 +239,6 @@ static inline int pmd_bad(pmd_t pmd)
  * pmd_page - converts a PMD entry to a page pointer
  */
 #define pmd_page(pmd)  (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 /**
  * pte_none - check if pte is mapped
diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index 9601cfe83c94..0fb2b6291d58 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -52,7 +52,6 @@ pmd_populate(struct mm_struct *mm, pmd_t * pmd_entry, pgtable_t pte)
 {
 	pmd_val(*pmd_entry) = page_to_phys(pte);
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmd_entry, pte_t * pte)
diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index bc1228e00518..5c2c0a864524 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -32,8 +32,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 
 #define pmd_populate_kernel pmd_populate
 
-#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index b4fc3b4f6bb3..74a817d9387f 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -88,7 +88,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
 {
 	pmd_set(pmd, page);
 }
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgtable.h
index ad15d655a9bf..7be5e5e712b2 100644
--- a/arch/m68k/include/asm/pgtable.h
+++ b/arch/m68k/include/asm/pgtable.h
@@ -4,3 +4,12 @@
 #else
 #include <asm/pgtable_mm.h>
 #endif
+
+
+#if defined(CONFIG_COLDFIRE)
+#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
+#elif defined(CONFIG_SUN3)
+#define pmd_pgtable(pmd) pmd_page(pmd)
+#else
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
+#endif
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 000f64869b91..198036aff519 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -32,7 +32,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
 {
 	pmd_val(*pmd) = __pa((unsigned long)page_address(page));
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index d56b9f670ad1..6c33b05f730f 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -28,8 +28,6 @@ static inline pgd_t *get_pgd(void)
 
 #define pgd_alloc(mm)		get_pgd()
 
-#define pmd_pgtable(pmd)	pmd_page(pmd)
-
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 8b18424b3120..dd53d0f79cb3 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -28,7 +28,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 {
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 /*
  * Initialize a new pmd table with invalid pointers.
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 85c117347c86..a08e1ebca70e 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -12,11 +12,6 @@
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
 
-/*
- * Since we have only two-level page tables, these are trivial
- */
-#define pmd_pgtable(pmd) pmd_page(pmd)
-
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
 
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index e6600d2a5ae0..3c4ae74d5798 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -25,7 +25,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 {
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 /*
  * Initialize a new pmd table with invalid pointers.
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 88820299ecc4..b7b2b8d16fad 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -72,6 +72,4 @@ do {					\
 	tlb_remove_page((tlb), (pte));	\
 } while (0)
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
-
 #endif
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index dda557085311..6a7e98e71f1d 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -69,6 +69,5 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 
 #define pmd_populate(mm, pmd, pte_page) \
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 #endif
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 6dd78a2dc03a..3360cad78ace 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -70,9 +70,4 @@ extern struct kmem_cache *pgtable_cache[];
 #include <asm/nohash/pgalloc.h>
 #endif
 
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)pmd_page_vaddr(pmd);
-}
-
 #endif /* _ASM_POWERPC_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index c6a676714f04..5969743719bc 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -152,6 +152,12 @@ static inline bool p4d_is_leaf(p4d_t p4d)
 }
 #endif
 
+#define pmd_pgtable pmd_pgtable
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return (pgtable_t)pmd_page_vaddr(pmd);
+}
+
 #ifdef CONFIG_PPC64
 #define is_ioremap_addr is_ioremap_addr
 static inline bool is_ioremap_addr(const void *x)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 23b1544e0ca5..0af6933a7100 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -38,8 +38,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define pmd_pgtable(pmd)	pmd_page(pmd)
-
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 6b187cd72251..f14a555eff74 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -134,9 +134,6 @@ static inline void pmd_populate(struct mm_struct *mm,
 
 #define pmd_populate_kernel(mm, pmd, pte) pmd_populate(mm, pmd, pte)
 
-#define pmd_pgtable(pmd) \
-	((pgtable_t)__va(pmd_val(pmd) & -sizeof(pte_t)*PTRS_PER_PTE))
-
 /*
  * page table entry allocation/free routines.
  */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7c66ae5d7e32..b9760abe0c98 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1730,4 +1730,7 @@ extern void s390_reset_cmma(struct mm_struct *mm);
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
+#define pmd_pgtable(pmd) \
+	((pgtable_t)__va(pmd_val(pmd) & -sizeof(pte_t)*PTRS_PER_PTE))
+
 #endif /* _S390_PAGE_H */
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 0e6b0be25e33..a9e98233c4d4 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -30,7 +30,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 {
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 #define __pte_free_tlb(tlb,pte,addr)			\
 do {							\
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 9d353e6dc5a9..4f73e87b22a3 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -51,7 +51,6 @@ static inline void free_pmd_fast(pmd_t * pmd)
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
 
 #define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
-#define pmd_pgtable(pmd)		(pgtable_t)__pmd_page(pmd)
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep);
 #define pmd_populate_kernel		pmd_populate
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index a8dafc550985..7b5561d17ab1 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -67,7 +67,6 @@ void pte_free(struct mm_struct *mm, pgtable_t ptepage);
 
 #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(MM, PMD, PTE)
 #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
-#define pmd_pgtable(PMD)			((pte_t *)pmd_page_vaddr(PMD))
 
 void pgtable_free(void *table, bool is_page);
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 0888bda245f5..ebaf374b55ab 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -432,4 +432,6 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
 
+#define pmd_pgtable(pmd)	((pgtable_t)__pmd_page(pmd))
+
 #endif /* !(_SPARC_PGTABLE_H) */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index a400e0f23046..e0ee48ec3903 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1117,6 +1117,8 @@ extern unsigned long cmdline_memory_size;
 
 asmlinkage void do_sparc64_fault(struct pt_regs *regs);
 
+#define pmd_pgtable(PMD)	((pte_t *)pmd_page_vaddr(PMD))
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define pud_leaf_size pud_leaf_size
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 2bbf28cf3aa9..8ec7cd46dd96 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -19,7 +19,6 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
 			(unsigned long long) PAGE_SHIFT)))
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 62ad61d6fefc..c7ec5bb88334 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -84,8 +84,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd(((pteval_t)pfn << PAGE_SHIFT) | _PAGE_TABLE));
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
-
 #if CONFIG_PGTABLE_LEVELS > 2
 extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
 
diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index d3a22da4d2c9..eeb2de3a89e5 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -25,7 +25,6 @@
 	(pmd_val(*(pmdp)) = ((unsigned long)ptep))
 #define pmd_populate(mm, pmdp, page)					     \
 	(pmd_val(*(pmdp)) = ((unsigned long)page_to_virt(page)))
-#define pmd_pgtable(pmd) pmd_page(pmd)
 
 static inline pgd_t*
 pgd_alloc(struct mm_struct *mm)
@@ -63,7 +62,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 	return page;
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
 #endif /* CONFIG_MMU */
 
 #endif /* _XTENSA_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9e6f71265f72..5fa6d69759ef 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -37,6 +37,15 @@
 #define FIRST_USER_ADDRESS	0UL
 #endif
 
+/*
+ * This defines the generic helper for accessing PMD page
+ * table page. Although platforms can still override this
+ * via their respective <asm/pgtable.h>.
+ */
+#ifndef pmd_pgtable
+#define pmd_pgtable(pmd) pmd_page(pmd)
+#endif
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.20.1

