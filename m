Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058A8363FD5
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhDSKsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 06:48:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34184 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237914AbhDSKsA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 06:48:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FP3Rc2nNMzB09b5;
        Mon, 19 Apr 2021 12:47:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nOaOGEopWB7L; Mon, 19 Apr 2021 12:47:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FP3Rc1rT3zB09Zy;
        Mon, 19 Apr 2021 12:47:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12B788B7BB;
        Mon, 19 Apr 2021 12:47:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FbvfnbP2J4Qu; Mon, 19 Apr 2021 12:47:28 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF9698B7B4;
        Mon, 19 Apr 2021 12:47:28 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C91E4679FC; Mon, 19 Apr 2021 10:47:28 +0000 (UTC)
Message-Id: <a9399f392edbae96748eb0662b10678e5b0ec513.1618828806.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618828806.git.christophe.leroy@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/4] powerpc/mm: Convert powerpc to GENERIC_PTDUMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        dja@axtens.net
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 19 Apr 2021 10:47:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch converts powerpc to the generic PTDUMP implementation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/Kconfig.debug        |  30 ------
 arch/powerpc/mm/Makefile          |   2 +-
 arch/powerpc/mm/mmu_decl.h        |   2 +-
 arch/powerpc/mm/ptdump/8xx.c      |   6 +-
 arch/powerpc/mm/ptdump/Makefile   |   9 +-
 arch/powerpc/mm/ptdump/book3s64.c |   6 +-
 arch/powerpc/mm/ptdump/ptdump.c   | 165 ++++++++----------------------
 arch/powerpc/mm/ptdump/shared.c   |   6 +-
 9 files changed, 68 insertions(+), 160 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 475d77a6ebbe..40259437a28f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -120,6 +120,7 @@ config PPC
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
+	select ARCH_HAS_DEBUG_WX		if STRICT_KERNEL_RWX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
@@ -177,6 +178,7 @@ config PPC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
+	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 6342f9da4545..05b1180ea502 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -360,36 +360,6 @@ config FAIL_IOMMU
 
 	  If you are unsure, say N.
 
-config PPC_PTDUMP
-	bool "Export kernel pagetable layout to userspace via debugfs"
-	depends on DEBUG_KERNEL && DEBUG_FS
-	help
-	  This option exports the state of the kernel pagetables to a
-	  debugfs file. This is only useful for kernel developers who are
-	  working in architecture specific areas of the kernel - probably
-	  not a good idea to enable this feature in a production kernel.
-
-	  If you are unsure, say N.
-
-config PPC_DEBUG_WX
-	bool "Warn on W+X mappings at boot"
-	depends on PPC_PTDUMP && STRICT_KERNEL_RWX
-	help
-	  Generate a warning if any W+X mappings are found at boot.
-
-	  This is useful for discovering cases where the kernel is leaving
-	  W+X mappings after applying NX, as such mappings are a security risk.
-
-	  Note that even if the check fails, your kernel is possibly
-	  still fine, as W+X mappings are not a security hole in
-	  themselves, what they do is that they make the exploitation
-	  of other unfixed kernel bugs easier.
-
-	  There is no runtime or memory usage effect of this option
-	  once the kernel has booted up - it's a one time check.
-
-	  If in doubt, say "Y".
-
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
 	depends on DEBUG_KERNEL && PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index c3df3a8501d4..c90d58aaebe2 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,5 +18,5 @@ obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
-obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
+obj-$(CONFIG_PTDUMP_CORE)	+= ptdump/
 obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 7dac910c0b21..dd1cabc2ea0f 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -180,7 +180,7 @@ static inline void mmu_mark_rodata_ro(void) { }
 void __init mmu_mapin_immr(void);
 #endif
 
-#ifdef CONFIG_PPC_DEBUG_WX
+#ifdef CONFIG_DEBUG_WX
 void ptdump_check_wx(void);
 #else
 static inline void ptdump_check_wx(void) { }
diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index 86da2a669680..fac932eb8f9a 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -75,8 +75,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
diff --git a/arch/powerpc/mm/ptdump/Makefile b/arch/powerpc/mm/ptdump/Makefile
index 712762be3cb1..4050cbb55acf 100644
--- a/arch/powerpc/mm/ptdump/Makefile
+++ b/arch/powerpc/mm/ptdump/Makefile
@@ -5,5 +5,10 @@ obj-y	+= ptdump.o
 obj-$(CONFIG_4xx)		+= shared.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= shared.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= shared.o bats.o segment_regs.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64.o hashpagetable.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= shared.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64.o
+
+ifdef CONFIG_PTDUMP_DEBUGFS
+obj-$(CONFIG_PPC_BOOK3S_32)	+= bats.o segment_regs.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= hashpagetable.o
+endif
diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
index 14f73868db66..5ad92d9dc5d1 100644
--- a/arch/powerpc/mm/ptdump/book3s64.c
+++ b/arch/powerpc/mm/ptdump/book3s64.c
@@ -103,8 +103,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 5062c58b1e5b..57d1270689c6 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/ptdump.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <asm/fixmap.h>
@@ -54,11 +55,12 @@
  *
  */
 struct pg_state {
+	struct ptdump_state ptdump;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	unsigned long start_address;
 	unsigned long start_pa;
-	unsigned int level;
+	int level;
 	u64 current_flags;
 	bool check_wx;
 	unsigned long wx_pages;
@@ -189,9 +191,9 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page_update_state(struct pg_state *st, unsigned long addr,
-				   unsigned int level, u64 val, unsigned long page_size)
+				   unsigned int level, u64 val)
 {
-	u64 flag = val & pg_level[level].mask;
+	u64 flag = level >= 0 ? val & pg_level[level].mask : 0;
 	u64 pa = val & PTE_RPN_MASK;
 
 	st->level = level;
@@ -205,15 +207,15 @@ static void note_page_update_state(struct pg_state *st, unsigned long addr,
 	}
 }
 
-static void note_page(struct pg_state *st, unsigned long addr,
-	       unsigned int level, u64 val, unsigned long page_size)
+static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level, u64 val)
 {
-	u64 flag = val & pg_level[level].mask;
+	u64 flag = level >= 0 ? val & pg_level[level].mask : 0;
+	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 
 	/* At first no level is set */
-	if (!st->level) {
+	if (st->level == -1) {
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-		note_page_update_state(st, addr, level, val, page_size);
+		note_page_update_state(st, addr, level, val);
 	/*
 	 * Dump the section of virtual memory when:
 	 *   - the PTE flags from one entry to the next differs.
@@ -242,95 +244,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		 * Address indicates we have passed the end of the
 		 * current section of virtual memory
 		 */
-		note_page_update_state(st, addr, level, val, page_size);
-	}
-}
-
-static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
-{
-	pte_t *pte = pte_offset_kernel(pmd, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
-		addr = start + i * PAGE_SIZE;
-		note_page(st, addr, 4, pte_val(*pte), PAGE_SIZE);
-
-	}
-}
-
-static void walk_hugepd(struct pg_state *st, hugepd_t *phpd, unsigned long start,
-			int pdshift, int level)
-{
-#ifdef CONFIG_ARCH_HAS_HUGEPD
-	unsigned int i;
-	int shift = hugepd_shift(*phpd);
-	int ptrs_per_hpd = pdshift - shift > 0 ? 1 << (pdshift - shift) : 1;
-
-	if (start & ((1 << shift) - 1))
-		return;
-
-	for (i = 0; i < ptrs_per_hpd; i++) {
-		unsigned long addr = start + (i << shift);
-		pte_t *pte = hugepte_offset(*phpd, addr, pdshift);
-
-		note_page(st, addr, level + 1, pte_val(*pte), 1 << shift);
-	}
-#endif
-}
-
-static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
-{
-	pmd_t *pmd = pmd_offset(pud, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
-		addr = start + i * PMD_SIZE;
-		if (!pmd_none(*pmd) && !pmd_is_leaf(*pmd))
-			/* pmd exists */
-			walk_pte(st, pmd, addr);
-		else
-			note_page(st, addr, 3, pmd_val(*pmd), PMD_SIZE);
-	}
-}
-
-static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
-{
-	pud_t *pud = pud_offset(p4d, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
-		addr = start + i * PUD_SIZE;
-		if (!pud_none(*pud) && !pud_is_leaf(*pud))
-			/* pud exists */
-			walk_pmd(st, pud, addr);
-		else
-			note_page(st, addr, 2, pud_val(*pud), PUD_SIZE);
-	}
-}
-
-static void walk_pagetables(struct pg_state *st)
-{
-	unsigned int i;
-	unsigned long addr = st->start_address & PGDIR_MASK;
-	pgd_t *pgd = pgd_offset_k(addr);
-
-	/*
-	 * Traverse the linux pagetable structure and dump pages that are in
-	 * the hash pagetable.
-	 */
-	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
-		p4d_t *p4d = p4d_offset(pgd, 0);
-
-		if (p4d_none(*p4d) || p4d_is_leaf(*p4d))
-			note_page(st, addr, 1, p4d_val(*p4d), PGDIR_SIZE);
-		else if (is_hugepd(__hugepd(p4d_val(*p4d))))
-			walk_hugepd(st, (hugepd_t *)p4d, addr, PGDIR_SHIFT, 1);
-		else
-			/* p4d exists */
-			walk_pud(st, p4d, addr);
+		note_page_update_state(st, addr, level, val);
 	}
 }
 
@@ -383,32 +297,29 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct pg_state st = {
 		.seq = m,
 		.marker = address_markers,
-		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
+		.level = -1,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]){
+				{TASK_SIZE, ~0UL},
+				{0, 0}
+			}
+		}
 	};
 
 #ifdef CONFIG_PPC64
 	if (!radix_enabled())
-		st.start_address = KERN_VIRT_START;
+		st.ptdump.range.start = KERN_VIRT_START;
+	else
+		st.ptdump.range.start = PAGE_OFFSET;
 #endif
 
 	/* Traverse kernel page tables */
-	walk_pagetables(&st);
-	note_page(&st, 0, 0, 0, 0);
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 	return 0;
 }
 
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 static void build_pgtable_complete_mask(void)
 {
@@ -420,22 +331,34 @@ static void build_pgtable_complete_mask(void)
 				pg_level[i].mask |= pg_level[i].flag[j].mask;
 }
 
-#ifdef CONFIG_PPC_DEBUG_WX
+#ifdef CONFIG_DEBUG_WX
 void ptdump_check_wx(void)
 {
 	struct pg_state st = {
 		.seq = NULL,
-		.marker = address_markers,
+		.marker = (struct addr_marker[]) {
+			{ 0, NULL},
+			{ -1, NULL},
+		},
+		.level = -1,
 		.check_wx = true,
-		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
+		.ptdump = {
+			.note_page = note_page,
+			.range = (struct ptdump_range[]){
+				{TASK_SIZE, ~0UL},
+				{0, 0}
+			}
+		}
 	};
 
 #ifdef CONFIG_PPC64
 	if (!radix_enabled())
-		st.start_address = KERN_VIRT_START;
+		st.ptdump.range.start = KERN_VIRT_START;
+	else
+		st.ptdump.range.start = PAGE_OFFSET;
 #endif
 
-	walk_pagetables(&st);
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 
 	if (st.wx_pages)
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
@@ -449,8 +372,10 @@ static int ptdump_init(void)
 {
 	populate_markers();
 	build_pgtable_complete_mask();
-	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
-			    &ptdump_fops);
+
+	if (IS_ENABLED(CONFIG_PTDUMP_DEBUGFS))
+		debugfs_create_file("kernel_page_tables", 0400, NULL, NULL, &ptdump_fops);
+
 	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index c005fe041c18..03607ab90c66 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -68,8 +68,10 @@ static const struct flag_info flag_array[] = {
 };
 
 struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
+	{ /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* p4d */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
 	}, { /* pud */
-- 
2.25.0

