Return-Path: <linux-arch+bounces-158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE407E8EAC
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C1B280A70
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE53440E;
	Sun, 12 Nov 2023 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN6yTfKY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C5440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCA0C43395;
	Sun, 12 Nov 2023 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769861;
	bh=aTovK/sGx3wduvwHHzP4k5hY0TmVrj1ye2Y4kPuJg5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN6yTfKYq2dSCw5oS475aELuIEDSdloXqsXgydFt/c7M5VP7bnk5fwRsPCiB5gBai
	 J1WWb6Dz9tf8jHWgwDQB62+620TLIzFmCPl+OTioRvf+R6kUrwYUBmiGDC0cVfU60Q
	 5XJkKDD1oi7BP47QzYfULgnM1Zl/beoefR7agITCCziONL38No1PaneOa2SsZJXadn
	 Mj90UKMhWD1VUWR4I3+3m0kNvqs1NpZKTD4BObScnPbHek28p9HNYaQL/1U1V6DhoD
	 I+TiQ1YGoENrvbXfe/TmlDZHBO5fZV+z/Rb5ucU1VbtTP4gM9LEa/pKc/tSK3PPVSE
	 zsSHh6yIwb4Yw==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 22/38] riscv: s64ilp32: Add MMU_SV39 mode support
Date: Sun, 12 Nov 2023 01:14:58 -0500
Message-Id: <20231112061514.2306187-23-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

There is no MMU_SV32 support in xlen=64 ISA generally, but s64ilp32
selects 32BIT, which uses MMU_SV32 default. This commit enables MMU_SV39
for 32BIT to satisfy the 4GB mapping requirement. The Sv39 is the
mandatory MMU mode in RVA20S64 and RVA22S64, so we needn't care about
Sv48 & Sv57.

We use duplicate remapping to solve the address sign extension problem
from the compiler. Make the address of 0xffffffff80000000 equal to
0x80000000 by pg_dir[2] = pg_dir[510] and pg_dir[3] = pg_dir[511] of the
page table.

Why didn't we prevent address sign extension in the compiler?
 - Additional zero extension reduces the performance
 - Prevent complex and unnecessary work for compiler guys.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                  |  4 ++-
 arch/riscv/include/asm/page.h       | 24 ++++++++++----
 arch/riscv/include/asm/pgtable-64.h | 50 ++++++++++++++---------------
 arch/riscv/include/asm/pgtable.h    | 19 ++++++++---
 arch/riscv/kernel/cpu.c             |  4 +--
 arch/riscv/mm/fault.c               | 11 +++++++
 arch/riscv/mm/init.c                | 24 +++++++++++---
 7 files changed, 92 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d3a236d2c45..f364d2436b1d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -257,7 +257,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
-	default 5 if 64BIT
+	default 5 if !MMU_SV32
 	default 2
 
 config LOCKDEP_SUPPORT
@@ -327,6 +327,8 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select MMU
+	select MMU_SV32
 
 config ARCH_RV64I
 	bool "RV64I"
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b55ba20903ec..7c535e88cf91 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -61,16 +61,28 @@ void clear_page(void *page);
 
 /* Page Global Directory entry */
 typedef struct {
-	unsigned long pgd;
+#ifndef CONFIG_MMU_SV32
+	u64 pgd;
+#else
+	u32 pgd;
+#endif
 } pgd_t;
 
 /* Page Table entry */
 typedef struct {
-	unsigned long pte;
+#ifndef CONFIG_MMU_SV32
+	u64 pte;
+#else
+	u32 pte;
+#endif
 } pte_t;
 
 typedef struct {
-	unsigned long pgprot;
+#ifndef CONFIG_MMU_SV32
+	u64 pgprot;
+#else
+	u32 pgprot;
+#endif
 } pgprot_t;
 
 typedef struct page *pgtable_t;
@@ -83,10 +95,10 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#ifdef CONFIG_64BIT
-#define PTE_FMT "%016lx"
+#ifndef CONFIG_MMU_SV32
+#define PTE_FMT "%016llx"
 #else
-#define PTE_FMT "%08lx"
+#define PTE_FMT "%08x"
 #endif
 
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7a5097202e15..2e57378731f4 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -16,12 +16,12 @@ extern bool pgtable_l5_enabled;
 #define PGDIR_SHIFT_L3  30
 #define PGDIR_SHIFT_L4  39
 #define PGDIR_SHIFT_L5  48
-#define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
+#define PGDIR_SIZE_L3   (_AC(1, ULL) << PGDIR_SHIFT_L3)
 
 #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
 		(pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
 /* Size of region mapped by a page global directory */
-#define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_SIZE      (_AC(1, ULL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
 /* p4d is folded into pgd in case of 4-level page table */
@@ -30,7 +30,7 @@ extern bool pgtable_l5_enabled;
 #define P4D_SHIFT_L5   39
 #define P4D_SHIFT      (pgtable_l5_enabled ? P4D_SHIFT_L5 : \
 		(pgtable_l4_enabled ? P4D_SHIFT_L4 : P4D_SHIFT_L3))
-#define P4D_SIZE       (_AC(1, UL) << P4D_SHIFT)
+#define P4D_SIZE       (_AC(1, ULL) << P4D_SHIFT)
 #define P4D_MASK       (~(P4D_SIZE - 1))
 
 /* pud is folded into pgd in case of 3-level page table */
@@ -45,7 +45,7 @@ extern bool pgtable_l5_enabled;
 
 /* Page 4th Directory entry */
 typedef struct {
-	unsigned long p4d;
+	u64 p4d;
 } p4d_t;
 
 #define p4d_val(x)	((x).p4d)
@@ -54,7 +54,7 @@ typedef struct {
 
 /* Page Upper Directory entry */
 typedef struct {
-	unsigned long pud;
+	u64 pud;
 } pud_t;
 
 #define pud_val(x)      ((x).pud)
@@ -63,7 +63,7 @@ typedef struct {
 
 /* Page Middle Directory entry */
 typedef struct {
-	unsigned long pmd;
+	u64 pmd;
 } pmd_t;
 
 #define pmd_val(x)      ((x).pmd)
@@ -76,7 +76,7 @@ typedef struct {
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
  */
-#define _PAGE_PFN_MASK  GENMASK(53, 10)
+#define _PAGE_PFN_MASK  GENMASK_ULL(53, 10)
 
 /*
  * [63] Svnapot definitions:
@@ -103,7 +103,7 @@ enum napot_cont_order {
 
 #define napot_cont_shift(order)	((order) + PAGE_SHIFT)
 #define napot_cont_size(order)	BIT(napot_cont_shift(order))
-#define napot_cont_mask(order)	(~(napot_cont_size(order) - 1UL))
+#define napot_cont_mask(order)	(~(napot_cont_size(order) - 1ULL))
 #define napot_pte_num(order)	BIT(order)
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
@@ -120,8 +120,8 @@ enum napot_cont_order {
  *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
  *  11 - Rsvd   Reserved for future standard use
  */
-#define _PAGE_NOCACHE_SVPBMT	(1UL << 61)
-#define _PAGE_IO_SVPBMT		(1UL << 62)
+#define _PAGE_NOCACHE_SVPBMT	(1ULL << 61)
+#define _PAGE_IO_SVPBMT		(1ULL << 62)
 #define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
 
 /*
@@ -131,10 +131,10 @@ enum napot_cont_order {
  * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
  * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
  */
-#define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	0UL
-#define _PAGE_IO_THEAD		(1UL << 63)
-#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
+#define _PAGE_PMA_THEAD		((1ULL << 62) | (1ULL << 61) | (1ULL << 60))
+#define _PAGE_NOCACHE_THEAD	0ULL
+#define _PAGE_IO_THEAD		(1ULL << 63)
+#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1ULL << 59))
 
 static inline u64 riscv_page_mtmask(void)
 {
@@ -165,7 +165,7 @@ static inline u64 riscv_page_io(void)
 #define _PAGE_MTMASK		riscv_page_mtmask()
 
 /* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+#define _PAGE_CHG_MASK  (~(u64)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
 					  _PAGE_USER | _PAGE_GLOBAL |	\
 					  _PAGE_MTMASK))
@@ -206,12 +206,12 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
-static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+static inline pud_t pfn_pud(u64 pfn, pgprot_t prot)
 {
 	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
-static inline unsigned long _pud_pfn(pud_t pud)
+static inline u64 _pud_pfn(pud_t pud)
 {
 	return __page_val_to_pfn(pud_val(pud));
 }
@@ -246,16 +246,16 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
 
 #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 
-static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+static inline pmd_t pfn_pmd(u64 pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	u64 prot_val = pgprot_val(prot);
 
 	ALT_THEAD_PMA(prot_val);
 
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
-static inline unsigned long _pmd_pfn(pmd_t pmd)
+static inline u64 _pmd_pfn(pmd_t pmd)
 {
 	return __page_val_to_pfn(pmd_val(pmd));
 }
@@ -263,13 +263,13 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
 
 #define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+	pr_err("%s:%d: bad pmd " PTE_FMT ".\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_ERROR(e)   \
-	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
+	pr_err("%s:%d: bad pud " PTE_FMT ".\n", __FILE__, __LINE__, pud_val(e))
 
 #define p4d_ERROR(e)   \
-	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
+	pr_err("%s:%d: bad p4d " PTE_FMT ".\n", __FILE__, __LINE__, p4d_val(e))
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
@@ -309,12 +309,12 @@ static inline void p4d_clear(p4d_t *p4d)
 		set_p4d(p4d, __p4d(0));
 }
 
-static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
+static inline p4d_t pfn_p4d(u64 pfn, pgprot_t prot)
 {
 	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
-static inline unsigned long _p4d_pfn(p4d_t p4d)
+static inline u64 _p4d_pfn(p4d_t p4d)
 {
 	return __page_val_to_pfn(p4d_val(p4d));
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e5e7a929949a..645cc6e69373 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -34,7 +34,11 @@
  * Half of the kernel address space (1/4 of the entries of the page global
  * directory) is for the direct mapping.
  */
-#define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
+#if IS_ENABLED(CONFIG_ARCH_RV64ILP32) && !IS_ENABLED(CONFIG_MMU_SV32)
+#define KERN_VIRT_SIZE          (ulong)(PTRS_PER_PGD * PMD_SIZE)
+#else
+#define KERN_VIRT_SIZE          (ulong)((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
+#endif
 
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
 #define VMALLOC_END      PAGE_OFFSET
@@ -86,7 +90,7 @@
 #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
 
 #define FIXADDR_TOP      PCI_IO_START
-#ifdef CONFIG_64BIT
+#ifndef CONFIG_MMU_SV32
 #define MAX_FDT_SIZE	 PMD_SIZE
 #define FIX_FDT_SIZE	 (MAX_FDT_SIZE + SZ_2M)
 #define FIXADDR_SIZE     (PMD_SIZE + FIX_FDT_SIZE)
@@ -114,11 +118,11 @@
 
 #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
 
-#ifdef CONFIG_64BIT
+#ifndef CONFIG_MMU_SV32
 #include <asm/pgtable-64.h>
 #else
 #include <asm/pgtable-32.h>
-#endif /* CONFIG_64BIT */
+#endif /* !CONFIG_MMU_SV32 */
 
 #include <linux/page_table_check.h>
 
@@ -527,7 +531,11 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
+#ifndef CONFIG_MMU_SV32
+	pte_t pte = __pte(atomic64_xchg((atomic64_t *)ptep, 0));
+#else
 	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+#endif
 
 	page_table_check_pte_clear(mm, address, pte);
 
@@ -541,7 +549,8 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	if (!pte_young(*ptep))
 		return 0;
-	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET,
+					(unsigned long *)&pte_val(*ptep));
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..bc39fd16ab64 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -274,9 +274,9 @@ static void print_mmu(struct seq_file *f)
 	char sv_type[16];
 
 #ifdef CONFIG_MMU
-#if defined(CONFIG_32BIT)
+#if defined(CONFIG_MMU_SV32)
 	strncpy(sv_type, "sv32", 5);
-#elif defined(CONFIG_64BIT)
+#else
 	if (pgtable_l5_enabled)
 		strncpy(sv_type, "sv57", 5);
 	else if (pgtable_l4_enabled)
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3d410dad28f8..85165fe438d8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -140,7 +140,18 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 		no_context(regs, addr);
 		return;
 	}
+#if !IS_ENABLED(CONFIG_MMU_SV32) && IS_ENABLED(CONFIG_ARCH_RV64ILP32)
+	/*
+	 * The pg_dir[2,510,3,511] has been set during early
+	 * boot, so we only make a check here.
+	 */
+	if (pgd_val(*pgd) != pgd_val(*pgd_k)) {
+		no_context(regs, addr);
+		return;
+	}
+#else
 	set_pgd(pgd, *pgd_k);
+#endif
 
 	p4d_k = p4d_offset(pgd_k, addr);
 	if (!p4d_present(*p4d_k)) {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 70fb31960b63..80c6c381f3f2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -44,8 +44,12 @@ EXPORT_SYMBOL(kernel_map);
 #ifdef CONFIG_64BIT
 u64 satp_mode __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_57 : SATP_MODE_39;
 #else
+#ifndef CONFIG_MMU_SV32
+u64 satp_mode __ro_after_init = SATP_MODE_39;
+#else
 u64 satp_mode __ro_after_init = SATP_MODE_32;
 #endif
+#endif
 EXPORT_SYMBOL(satp_mode);
 
 bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
@@ -639,16 +643,26 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	pgd_next_t *nextp;
 	phys_addr_t next_phys;
 	uintptr_t pgd_idx = pgd_index(va);
+#if !IS_ENABLED(CONFIG_MMU_SV32) && IS_ENABLED(CONFIG_ARCH_RV64ILP32)
+	uintptr_t pgd_idh = pgd_index(sign_extend64((u64)va, 31));
+#endif
 
 	if (sz == PGDIR_SIZE) {
-		if (pgd_val(pgdp[pgd_idx]) == 0)
+		if (pgd_val(pgdp[pgd_idx]) == 0) {
 			pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(pa), prot);
+#if !IS_ENABLED(CONFIG_MMU_SV32) && IS_ENABLED(CONFIG_ARCH_RV64ILP32)
+			pgdp[pgd_idh] = pfn_pgd(PFN_DOWN(pa), prot);
+#endif
+		}
 		return;
 	}
 
 	if (pgd_val(pgdp[pgd_idx]) == 0) {
 		next_phys = alloc_pgd_next(va);
 		pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+#if !IS_ENABLED(CONFIG_MMU_SV32) && IS_ENABLED(CONFIG_ARCH_RV64ILP32)
+		pgdp[pgd_idh] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+#endif
 		nextp = get_pgd_next_virt(next_phys);
 		memset(nextp, 0, PAGE_SIZE);
 	} else {
@@ -930,7 +944,7 @@ static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
 	/* In 32-bit only, the fdt lies in its own PGD */
-	if (!IS_ENABLED(CONFIG_64BIT)) {
+	if (IS_ENABLED(CONFIG_MMU_SV32)) {
 		create_pgd_mapping(early_pg_dir, fix_fdt_va,
 				   pa, MAX_FDT_SIZE, PAGE_KERNEL);
 	} else {
@@ -1152,7 +1166,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
 	if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
 		WARN_ON(1);
-		pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
+		pr_warn("fixmap btmap start [" PTE_FMT "] != end [" PTE_FMT "]\n",
 			pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
 		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
 			fix_to_virt(FIX_BTMAP_BEGIN));
@@ -1248,7 +1262,7 @@ static void __init create_linear_mapping_page_table(void)
 static void __init setup_vm_final(void)
 {
 	/* Setup swapper PGD for fixmap */
-#if !defined(CONFIG_64BIT)
+#if defined(CONFIG_MMU_SV32)
 	/*
 	 * In 32-bit, the device tree lies in a pgd entry, so it must be copied
 	 * directly in swapper_pg_dir in addition to the pgd entry that points
@@ -1266,7 +1280,7 @@ static void __init setup_vm_final(void)
 	create_linear_mapping_page_table();
 
 	/* Map the kernel */
-	if (IS_ENABLED(CONFIG_64BIT))
+	if (!IS_ENABLED(CONFIG_MMU_SV32))
 		create_kernel_page_table(swapper_pg_dir, false);
 
 #ifdef CONFIG_KASAN
-- 
2.36.1


