Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812BF377A44
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhEJDCy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 May 2021 23:02:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230143AbhEJDCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 9 May 2021 23:02:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE25ED1;
        Sun,  9 May 2021 20:01:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.77.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 594BF3F718;
        Sun,  9 May 2021 20:01:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: [PATCH V2 RESEND] mm: Define default value for FIRST_USER_ADDRESS
Date:   Mon, 10 May 2021 08:32:05 +0530
Message-Id: <1620615725-24623-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently most platforms define FIRST_USER_ADDRESS as 0UL duplication the
same code all over. Instead just define a generic default value (i.e 0UL)
for FIRST_USER_ADDRESS and let the platforms override when required. This
makes it much cleaner with reduced code.

The default FIRST_USER_ADDRESS here would be skipped in <linux/pgtable.h>
when the given platform overrides its value via <asm/pgtable.h>.

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
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> #m68k
Acked-by: Guo Ren <guoren@kernel.org>               #csky
Acked-by: Stafford Horne <shorne@gmail.com>         #openrisc
Acked-by: Catalin Marinas <catalin.marinas@arm.com> #arm64
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc1 and has been boot tested on arm64 platform.
But has been cross compiled on multiple other platforms.

Changes in V2:

- Dropped ARCH_HAS_FIRST_USER_ADDRESS construct

Changes in V1:

https://patchwork.kernel.org/project/linux-mm/patch/1618368899-20311-1-git-send-email-anshuman.khandual@arm.com/

 arch/alpha/include/asm/pgtable.h             | 1 -
 arch/arc/include/asm/pgtable.h               | 6 ------
 arch/arm64/include/asm/pgtable.h             | 2 --
 arch/csky/include/asm/pgtable.h              | 1 -
 arch/hexagon/include/asm/pgtable.h           | 3 ---
 arch/ia64/include/asm/pgtable.h              | 1 -
 arch/m68k/include/asm/pgtable_mm.h           | 1 -
 arch/microblaze/include/asm/pgtable.h        | 2 --
 arch/mips/include/asm/pgtable-32.h           | 1 -
 arch/mips/include/asm/pgtable-64.h           | 1 -
 arch/nios2/include/asm/pgtable.h             | 2 --
 arch/openrisc/include/asm/pgtable.h          | 1 -
 arch/parisc/include/asm/pgtable.h            | 2 --
 arch/powerpc/include/asm/book3s/pgtable.h    | 1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h | 1 -
 arch/powerpc/include/asm/nohash/64/pgtable.h | 2 --
 arch/riscv/include/asm/pgtable.h             | 2 --
 arch/s390/include/asm/pgtable.h              | 2 --
 arch/sh/include/asm/pgtable.h                | 2 --
 arch/sparc/include/asm/pgtable_32.h          | 1 -
 arch/sparc/include/asm/pgtable_64.h          | 3 ---
 arch/um/include/asm/pgtable-2level.h         | 1 -
 arch/um/include/asm/pgtable-3level.h         | 1 -
 arch/x86/include/asm/pgtable_types.h         | 2 --
 arch/xtensa/include/asm/pgtable.h            | 1 -
 include/linux/pgtable.h                      | 9 +++++++++
 26 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 8d856c62e22a..1a2fb0dc905b 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -46,7 +46,6 @@ struct vm_area_struct;
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 /* Number of pointers that fit on a page:  this will go away. */
 #define PTRS_PER_PAGE	(1UL << (PAGE_SHIFT-3))
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 163641726a2b..a9fabfb70664 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -228,12 +228,6 @@
  */
 #define	USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
-/*
- * No special requirements for lowest virtual address we permit any user space
- * mapping to be mapped at.
- */
-#define FIRST_USER_ADDRESS      0UL
-
 
 /****************************************************************
  * Bucket load of VM Helpers
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b10204e72fc..25f5c04b43ce 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -26,8 +26,6 @@
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
-#define FIRST_USER_ADDRESS	0UL
-
 #ifndef __ASSEMBLY__
 
 #include <asm/cmpxchg.h>
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 0d60367b6bfa..151607ed5158 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -14,7 +14,6 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(PAGE_OFFSET/PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 /*
  * C-SKY is two-level paging structure:
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index dbb22b80b8c4..e4979508cddf 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -155,9 +155,6 @@ extern unsigned long _dflt_cache_att;
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
-/* Seems to be zero even in architectures where the zero page is firewalled? */
-#define FIRST_USER_ADDRESS 0UL
-
 /*  HUGETLB not working currently  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define pte_mkhuge(pte) __pte((pte_val(pte) & ~0x3) | HVM_HUGEPAGE_SIZE)
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index d765fd948fae..3f5dbbd8b9d8 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -128,7 +128,6 @@
 #define PTRS_PER_PGD_SHIFT	PTRS_PER_PTD_SHIFT
 #define PTRS_PER_PGD		(1UL << PTRS_PER_PGD_SHIFT)
 #define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
-#define FIRST_USER_ADDRESS	0UL
 
 /*
  * All the normal masks have the "page accessed" bits on, as any time
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index aca22c2c1ee2..143ba7de9bda 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -72,7 +72,6 @@
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 /* Virtual address region for use by kernel_map() */
 #ifdef CONFIG_SUN3
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 9ae8d2c17dd5..71cd547655d9 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -25,8 +25,6 @@ extern int mem_init_done;
 #include <asm/mmu.h>
 #include <asm/page.h>
 
-#define FIRST_USER_ADDRESS	0UL
-
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
 
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 6c0532d7b211..95df9c293d8d 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -93,7 +93,6 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 #endif
 
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 #define VMALLOC_START	  MAP_BASE
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1e7d6ce9d8d6..046465906c82 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -137,7 +137,6 @@
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
-#define FIRST_USER_ADDRESS	0UL
 
 /*
  * TLB refill handlers also map the vmalloc area into xuseg.  Avoid
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 2600d76c310c..4a995fa628ee 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -24,8 +24,6 @@
 #include <asm/pgtable-bits.h>
 #include <asm-generic/pgtable-nopmd.h>
 
-#define FIRST_USER_ADDRESS	0UL
-
 #define VMALLOC_START		CONFIG_NIOS2_KERNEL_MMU_REGION_BASE
 #define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
 
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 9425bedab4fc..4ac591c9ca33 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -73,7 +73,6 @@ extern void paging_init(void);
  */
 
 #define USER_PTRS_PER_PGD       (TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_ADDRESS      0UL
 
 /*
  * Kernels own virtual memory area.
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 39017210dbf0..7f33c29764cc 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -171,8 +171,6 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
  * pgd entries used up by user/kernel:
  */
 
-#define FIRST_USER_ADDRESS	0UL
-
 /* NB: The tlb miss handlers make certain assumptions about the order */
 /*     of the following bits, so be careful (One example, bits 25-31  */
 /*     are moved together in one instruction).                        */
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index 0e1263455d73..ad130e15a126 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -8,7 +8,6 @@
 #include <asm/book3s/32/pgtable.h>
 #endif
 
-#define FIRST_USER_ADDRESS	0UL
 #ifndef __ASSEMBLY__
 /* Insert a PTE, top-level function is out of line. It uses an inline
  * low level function in the respective pgtable-* files
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 96522f7f0618..f06ae00f2a65 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -54,7 +54,6 @@ extern int icache_44x_need_flush;
 #define PGD_MASKED_BITS		0
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 57cd3892bfe0..53fbfdfac93d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -12,8 +12,6 @@
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
 
-#define FIRST_USER_ADDRESS	0UL
-
 /*
  * Size of EA range mapped by our pagetables.
  */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9469f464e71a..286870765b49 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -537,8 +537,6 @@ void setup_bootmem(void);
 void paging_init(void);
 void misc_mem_init(void);
 
-#define FIRST_USER_ADDRESS  0
-
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 29c7ecd5ad1d..4ee49bb98f34 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -65,8 +65,6 @@ extern unsigned long zero_page_mask;
 
 /* TODO: s390 cannot support io_remap_pfn_range... */
 
-#define FIRST_USER_ADDRESS  0UL
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p.\n", __FILE__, __LINE__, (void *) pte_val(e))
 #define pmd_ERROR(e) \
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 27751e9470df..d7ddb1ec86a0 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -59,8 +59,6 @@ static inline unsigned long long neff_sign_extend(unsigned long val)
 /* Entries per level */
 #define PTRS_PER_PTE	(PAGE_SIZE / (1 << PTE_MAGNITUDE))
 
-#define FIRST_USER_ADDRESS	0UL
-
 #define PHYS_ADDR_MASK29		0x1fffffff
 #define PHYS_ADDR_MASK32		0xffffffff
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index a5cf79c149fe..0888bda245f5 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -48,7 +48,6 @@ unsigned long __init bootmem_init(unsigned long *pages_avail);
 #define PTRS_PER_PMD    	64
 #define PTRS_PER_PGD    	256
 #define USER_PTRS_PER_PGD	PAGE_OFFSET / PGDIR_SIZE
-#define FIRST_USER_ADDRESS	0UL
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
 #define PAGE_NONE	SRMMU_PAGE_NONE
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 550d3904de65..57460b7ada7b 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -95,9 +95,6 @@ bool kern_addr_valid(unsigned long addr);
 #define PTRS_PER_PUD	(1UL << PUD_BITS)
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
 
-/* Kernel has a separate 44bit address space. */
-#define FIRST_USER_ADDRESS	0UL
-
 #define pmd_ERROR(e)							\
 	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
 	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 32106d31e4ab..8256ecc5b919 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -23,7 +23,6 @@
 #define PTRS_PER_PTE	1024
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD	1024
-#define FIRST_USER_ADDRESS	0UL
 
 #define pte_ERROR(e) \
         printk("%s:%d: bad pte %p(%08lx).\n", __FILE__, __LINE__, &(e), \
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 7e6a4180db9d..9289a86643a9 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -41,7 +41,6 @@
 #endif
 
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 
 #define pte_ERROR(e) \
         printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f24d7ef8fffa..40497a9020c6 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -7,8 +7,6 @@
 
 #include <asm/page_types.h>
 
-#define FIRST_USER_ADDRESS	0UL
-
 #define _PAGE_BIT_PRESENT	0	/* is present */
 #define _PAGE_BIT_RW		1	/* writeable */
 #define _PAGE_BIT_USER		2	/* userspace addressable */
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index d7fc45c920c2..bd5aeb795567 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -59,7 +59,6 @@
 #define PTRS_PER_PGD		1024
 #define PGD_ORDER		0
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
 #define FIRST_USER_PGD_NR	(FIRST_USER_ADDRESS >> PGDIR_SHIFT)
 
 #ifdef CONFIG_MMU
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 46b13780c2c8..1bed8b82e59d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -28,6 +28,15 @@
 #define USER_PGTABLES_CEILING	0UL
 #endif
 
+/*
+ * This defines the first usable user address. Platforms
+ * can override its value with custom FIRST_USER_ADDRESS
+ * defined in their respective <asm/pgtable.h>.
+ */
+#ifndef FIRST_USER_ADDRESS
+#define FIRST_USER_ADDRESS	0UL
+#endif
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.20.1

