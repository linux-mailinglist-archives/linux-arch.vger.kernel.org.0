Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481DE17EDBA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 02:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCJBJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 21:09:38 -0400
Received: from foss.arm.com ([217.140.110.172]:58710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgCJBJi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 21:09:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D755630E;
        Mon,  9 Mar 2020 18:09:36 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2D6D3F67D;
        Mon,  9 Mar 2020 18:09:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/special: Create generic fallbacks for pte_special() and pte_mkspecial()
Date:   Tue, 10 Mar 2020 06:39:11 +0530
Message-Id: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently there are many platforms that dont enable ARCH_HAS_PTE_SPECIAL
but required to define quite similar fallback stubs for special page table
entry helpers such as pte_special() and pte_mkspecial(), as they get build
in generic MM without a config check. This creates two generic fallback
stub definitions for these helpers, eliminating much code duplication.

mips platform has a special case where pte_special() and pte_mkspecial()
visibility is wider than what ARCH_HAS_PTE_SPECIAL enablement requires.
This restricts those symbol visibility in order to avoid redefinitions
which is now exposed through this new generic stubs and subsequent build
failure. arm platform set_pte_at() definition needs to be moved into a C
file just to prevent a build failure.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>			# csky
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>	# m68k
Acked-by: Stafford Horne <shorne@gmail.com>		# openrisc
Acked-by: Helge Deller <deller@gmx.de>			# parisc
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Build tested on multiple platforms but boot tested only for arm64.

Changes in V2:

- s/HAVE_ARCH_PTE_SPECIAL/ARCH_HAS_PTE_SPECIAL per Geert

Changes in V1: (https://patchwork.kernel.org/patch/11414613/)

 arch/alpha/include/asm/pgtable.h         |  2 --
 arch/arm/include/asm/pgtable-2level.h    |  2 --
 arch/arm/include/asm/pgtable.h           | 15 ++------
 arch/arm/mm/mmu.c                        | 14 ++++++++
 arch/csky/include/asm/pgtable.h          |  3 --
 arch/hexagon/include/asm/pgtable.h       |  2 --
 arch/ia64/include/asm/pgtable.h          |  2 --
 arch/m68k/include/asm/mcf_pgtable.h      | 10 ------
 arch/m68k/include/asm/motorola_pgtable.h |  2 --
 arch/m68k/include/asm/sun3_pgtable.h     |  2 --
 arch/microblaze/include/asm/pgtable.h    |  4 ---
 arch/mips/include/asm/pgtable.h          | 44 ++++++++++++++++--------
 arch/nds32/include/asm/pgtable.h         |  9 -----
 arch/nios2/include/asm/pgtable.h         |  3 --
 arch/openrisc/include/asm/pgtable.h      |  2 --
 arch/parisc/include/asm/pgtable.h        |  2 --
 arch/sparc/include/asm/pgtable_32.h      |  7 ----
 arch/um/include/asm/pgtable.h            | 10 ------
 arch/unicore32/include/asm/pgtable.h     |  3 --
 arch/xtensa/include/asm/pgtable.h        |  3 --
 include/linux/mm.h                       | 12 +++++++
 21 files changed, 58 insertions(+), 95 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 299791ce14b6..0267aa8a4f86 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -268,7 +268,6 @@ extern inline void pud_clear(pud_t * pudp)	{ pud_val(*pudp) = 0; }
 extern inline int pte_write(pte_t pte)		{ return !(pte_val(pte) & _PAGE_FOW); }
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-extern inline int pte_special(pte_t pte)	{ return 0; }
 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_FOW; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~(__DIRTY_BITS); return pte; }
@@ -276,7 +275,6 @@ extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~(__ACCESS_BITS); ret
 extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_FOW; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
-extern inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 0d3ea35c97fe..9e084a464a97 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -211,8 +211,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
-#define pte_special(pte)	(0)
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 /*
  * We don't have huge page support for short descriptors, for the moment
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index eabcb48a7840..556468240ba5 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -252,19 +252,8 @@ static inline void __sync_icache_dcache(pte_t pteval)
 extern void __sync_icache_dcache(pte_t pteval);
 #endif
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
-{
-	unsigned long ext = 0;
-
-	if (addr < TASK_SIZE && pte_valid_user(pteval)) {
-		if (!pte_special(pteval))
-			__sync_icache_dcache(pteval);
-		ext |= PTE_EXT_NG;
-	}
-
-	set_pte_ext(ptep, pteval, ext);
-}
+void set_pte_at(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pteval);
 
 static inline pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
 {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5d0d0f86e790..16e9b041d7cf 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1672,3 +1672,17 @@ void __init early_mm_init(const struct machine_desc *mdesc)
 	build_mem_type_table();
 	early_paging_init(mdesc);
 }
+
+void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	unsigned long ext = 0;
+
+	if (addr < TASK_SIZE && pte_valid_user(pteval)) {
+		if (!pte_special(pteval))
+			__sync_icache_dcache(pteval);
+		ext |= PTE_EXT_NG;
+	}
+
+	set_pte_ext(ptep, pteval, ext);
+}
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 9b7764cb7645..9ab4a445ad99 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -110,9 +110,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 extern void load_pgd(unsigned long pg_dir);
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 
-static inline int pte_special(pte_t pte) { return 0; }
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 static inline void set_pte(pte_t *p, pte_t pte)
 {
 	*p = pte;
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 2fec20ad939e..d383e8bea5b2 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -158,8 +158,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
 /* Seems to be zero even in architectures where the zero page is firewalled? */
 #define FIRST_USER_ADDRESS 0UL
-#define pte_special(pte)	0
-#define pte_mkspecial(pte)	(pte)
 
 /*  HUGETLB not working currently  */
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index d602e7c622db..0e7b645b76c6 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -298,7 +298,6 @@ extern unsigned long VMALLOC_END;
 #define pte_exec(pte)		((pte_val(pte) & _PAGE_AR_RX) != 0)
 #define pte_dirty(pte)		((pte_val(pte) & _PAGE_D) != 0)
 #define pte_young(pte)		((pte_val(pte) & _PAGE_A) != 0)
-#define pte_special(pte)	0
 
 /*
  * Note: we convert AR_RWX to AR_RX and AR_RW to AR_R by clearing the 2nd bit in the
@@ -311,7 +310,6 @@ extern unsigned long VMALLOC_END;
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte)))
-#define pte_mkspecial(pte)	(pte)
 
 /*
  * Because ia64's Icache and Dcache is not coherent (on a cpu), we need to
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index b9f45aeded25..0031cd387b75 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -235,11 +235,6 @@ static inline int pte_young(pte_t pte)
 	return pte_val(pte) & CF_PAGE_ACCESSED;
 }
 
-static inline int pte_special(pte_t pte)
-{
-	return 0;
-}
-
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	pte_val(pte) &= ~CF_PAGE_WRITABLE;
@@ -312,11 +307,6 @@ static inline pte_t pte_mkcache(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	return pte;
-}
-
 #define swapper_pg_dir kernel_pg_dir
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 62bedc61f110..a6f4b96d674e 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -168,7 +168,6 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 static inline int pte_write(pte_t pte)		{ return !(pte_val(pte) & _PAGE_RONLY); }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
@@ -186,7 +185,6 @@ static inline pte_t pte_mkcache(pte_t pte)
 	pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_supervisor_cachemode;
 	return pte;
 }
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index bc4155264810..0caa18a08437 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -155,7 +155,6 @@ static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_WRITEABLE; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
@@ -168,7 +167,6 @@ static inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_NOCACHE
 //static inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) &= SUN3_PAGE_NOCACHE; return pte; }
 // until then, use:
 static inline pte_t pte_mkcache(pte_t pte)	{ return pte; }
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 2def331f9e2c..db9bdfcf46b7 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -80,10 +80,6 @@ extern pte_t *va_to_pte(unsigned long address);
  * Undefined behaviour if not..
  */
 
-static inline int pte_special(pte_t pte)	{ return 0; }
-
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
-
 /* Start and end of the vmalloc area. */
 /* Make sure to map the vmalloc area above the pinned kernel memory area
    of 32Mb.  */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index aef5378f909c..8e4e4be1ca00 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -269,6 +269,36 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
  */
 extern pgd_t swapper_pg_dir[];
 
+/*
+ * Platform specific pte_special() and pte_mkspecial() definitions
+ * are required only when ARCH_HAS_PTE_SPECIAL is enabled.
+ */
+#if !defined(CONFIG_32BIT) && !defined(CONFIG_CPU_HAS_RIXI)
+#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+static inline int pte_special(pte_t pte)
+{
+	return pte.pte_low & _PAGE_SPECIAL;
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte.pte_low |= _PAGE_SPECIAL;
+	return pte;
+}
+#else
+static inline int pte_special(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SPECIAL;
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SPECIAL;
+	return pte;
+}
+#endif
+#endif
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -277,7 +307,6 @@ extern pgd_t swapper_pg_dir[];
 static inline int pte_write(pte_t pte)	{ return pte.pte_low & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)	{ return pte.pte_low & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)	{ return pte.pte_low & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte) { return pte.pte_low & _PAGE_SPECIAL; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -338,17 +367,10 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	}
 	return pte;
 }
-
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	pte.pte_low |= _PAGE_SPECIAL;
-	return pte;
-}
 #else
 static inline int pte_write(pte_t pte)	{ return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)	{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte) { return pte_val(pte) & _PAGE_SPECIAL; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -392,12 +414,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_SPECIAL;
-	return pte;
-}
-
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 6abc58ac406d..476cc4dd1709 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -286,15 +286,6 @@ PTE_BIT_FUNC(mkclean, &=~_PAGE_D);
 PTE_BIT_FUNC(mkdirty, |=_PAGE_D);
 PTE_BIT_FUNC(mkold, &=~_PAGE_YOUNG);
 PTE_BIT_FUNC(mkyoung, |=_PAGE_YOUNG);
-static inline int pte_special(pte_t pte)
-{
-	return 0;
-}
-
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	return pte;
-}
 
 /*
  * Mark the prot value as uncacheable and unbufferable.
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 99985d8b7166..f98b7f4519ba 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -113,7 +113,6 @@ static inline int pte_dirty(pte_t pte)		\
 	{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		\
 	{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte)	{ return 0; }
 
 #define pgprot_noncached pgprot_noncached
 
@@ -168,8 +167,6 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
-
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 248d22d8faa7..7f3fb9ceb083 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -236,8 +236,6 @@ static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_exec(pte_t pte)  { return pte_val(pte) & _PAGE_EXEC; }
 static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte) { return 0; }
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index f0a365950536..9832c73a7021 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -377,7 +377,6 @@ static inline void pud_clear(pud_t *pud) {
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_WRITE; }
-static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
@@ -385,7 +384,6 @@ static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_WRITE; ret
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_WRITE; return pte; }
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 /*
  * Huge pte definitions.
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 6d6f44c0cad9..0de659ae0ba4 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -223,11 +223,6 @@ static inline int pte_young(pte_t pte)
 	return pte_val(pte) & SRMMU_REF;
 }
 
-static inline int pte_special(pte_t pte)
-{
-	return 0;
-}
-
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~SRMMU_WRITE);
@@ -258,8 +253,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return __pte(pte_val(pte) | SRMMU_REF);
 }
 
-#define pte_mkspecial(pte)    (pte)
-
 #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
 static inline unsigned long pte_pfn(pte_t pte)
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 2daa58df2190..b5ddf5d98bd5 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -167,11 +167,6 @@ static inline int pte_newprot(pte_t pte)
 	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
 }
 
-static inline int pte_special(pte_t pte)
-{
-	return 0;
-}
-
 /*
  * =================================
  * Flags setting section.
@@ -247,11 +242,6 @@ static inline pte_t pte_mknewpage(pte_t pte)
 	return(pte);
 }
 
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	return(pte);
-}
-
 static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	pte_copy(*pteptr, pteval);
diff --git a/arch/unicore32/include/asm/pgtable.h b/arch/unicore32/include/asm/pgtable.h
index c8f7ba12f309..3b8731b3a937 100644
--- a/arch/unicore32/include/asm/pgtable.h
+++ b/arch/unicore32/include/asm/pgtable.h
@@ -177,7 +177,6 @@ extern struct page *empty_zero_page;
 #define pte_dirty(pte)		(pte_val(pte) & PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & PTE_YOUNG)
 #define pte_exec(pte)		(pte_val(pte) & PTE_EXEC)
-#define pte_special(pte)	(0)
 
 #define PTE_BIT_FUNC(fn, op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
@@ -189,8 +188,6 @@ PTE_BIT_FUNC(mkdirty,   |= PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |= PTE_YOUNG);
 
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 /*
  * Mark the prot value as uncacheable.
  */
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 27ac17c9da09..8be0c0568c50 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -266,7 +266,6 @@ static inline void paging_init(void) { }
 static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_WRITABLE; }
 static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte) { return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	
 	{ pte_val(pte) &= ~(_PAGE_WRITABLE | _PAGE_HW_WRITE); return pte; }
@@ -280,8 +279,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)
 	{ pte_val(pte) |= _PAGE_WRITABLE; return pte; }
-static inline pte_t pte_mkspecial(pte_t pte)
-	{ return pte; }
 
 #define pgprot_noncached(prot) (__pgprot(pgprot_val(prot) & ~_PAGE_CA_MASK))
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..b2b43c88bff2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1720,6 +1720,18 @@ static inline void sync_mm_rss(struct mm_struct *mm)
 }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
+#endif
+
 #ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline int pte_devmap(pte_t pte)
 {
-- 
2.20.1

