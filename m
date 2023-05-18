Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA287708280
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjERNQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjERNO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D121BE6;
        Thu, 18 May 2023 06:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EFB64F44;
        Thu, 18 May 2023 13:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06522C433D2;
        Thu, 18 May 2023 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415606;
        bh=loRMXj/Jtry2vTMuauCwislja/wKPX3g/6GWiON8UaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMf3iV5NkSovwuZFZhmG8wW/MPKahKbqdP5Dz/Z+o3EXnXIfegc2QlXPk7bzgeN2l
         DJgsF9iOo0D2T7AzHweeXKvY6bDppptTPFktLCXt7aFdVBVeume3q2a4ZCkftoLbWn
         QCYBP8Y11fDgTty+VzA/r9+yC2d+9rSavL9eG4KhUA2s+Cp/RIE62txAh8q7wB/lej
         H1ku9o7kheYQajxN7Nt8ZGB7nXuO8xJXUuArCmlTgqizjEdvSTb+cEQ3SMX/1OKQyF
         0oVij/BuCiRQBsVS5BlcSISiG4TOPfyEwGdojb6e6KesfoMdxCLeFbGjSK730Hl2w3
         ze4z32o3tXTJQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 14/22] riscv: s64ilp32: Add MMU_SV39 mode support for 32BIT
Date:   Thu, 18 May 2023 09:10:05 -0400
Message-Id: <20230518131013.3366406-15-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
 arch/riscv/Kconfig                  | 10 ++++++-
 arch/riscv/include/asm/page.h       | 24 ++++++++++++-----
 arch/riscv/include/asm/pgtable-64.h | 42 ++++++++++++++---------------
 arch/riscv/include/asm/pgtable.h    | 18 ++++++++-----
 arch/riscv/kernel/cpu.c             |  4 +--
 arch/riscv/mm/fault.c               | 11 ++++++++
 arch/riscv/mm/init.c                | 29 ++++++++++++++++----
 7 files changed, 96 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d824fcf3cc1c..9c458496ec3a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -233,7 +233,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
-	default 5 if 64BIT
+	default 5 if !MMU_SV32
 	default 2
 
 config LOCKDEP_SUPPORT
@@ -293,6 +293,8 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select MMU
+	select MMU_SV32
 
 config ARCH_RV64I
 	bool "RV64I"
@@ -531,6 +533,12 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config MMU_SV32
+	bool "MMU using Sv32 mode"
+	depends on ARCH_RV32I
+	help
+	  Say N here if you have a 64-bit processor without satp-sv32 mode support.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
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
index 7a5097202e15..3da589de28a0 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
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
index d7b8eff0ade9..c5e915f21354 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -34,7 +34,11 @@
  * Half of the kernel address space (1/4 of the entries of the page global
  * directory) is for the direct mapping.
  */
+#if IS_ENABLED(CONFIG_ARCH_RV64ILP32) && !IS_ENABLED(CONFIG_MMU_SV32)
+#define KERN_VIRT_SIZE          (PTRS_PER_PGD * PMD_SIZE)
+#else
 #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
+#endif
 
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
 #define VMALLOC_END      PAGE_OFFSET
@@ -86,11 +90,7 @@
 #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
 
 #define FIXADDR_TOP      PCI_IO_START
-#ifdef CONFIG_64BIT
 #define FIXADDR_SIZE     PMD_SIZE
-#else
-#define FIXADDR_SIZE     PGDIR_SIZE
-#endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
 #endif
@@ -110,11 +110,11 @@
 
 #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
 
-#ifdef CONFIG_64BIT
+#ifndef CONFIG_MMU_SV32
 #include <asm/pgtable-64.h>
 #else
 #include <asm/pgtable-32.h>
-#endif /* CONFIG_64BIT */
+#endif /* !CONFIG_MMU_SV32 */
 
 #include <linux/page_table_check.h>
 
@@ -524,7 +524,11 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
+#ifndef CONFIG_MMU_SV32
+	pte_t pte = __pte(atomic64_xchg((atomic64_t *)ptep, 0));
+#else
 	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+#endif
 
 	page_table_check_pte_clear(mm, address, pte);
 
@@ -538,7 +542,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	if (!pte_young(*ptep))
 		return 0;
-	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, (unsigned long *)&pte_val(*ptep));
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3df38052dcbd..1c8d880a5c7e 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -241,9 +241,9 @@ static void print_mmu(struct seq_file *f)
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
index 1b0bd0683766..56eae0deefd2 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -131,7 +131,18 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
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
index bce899b180cd..3ee5b80affce 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -43,8 +43,12 @@ EXPORT_SYMBOL(kernel_map);
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
@@ -60,7 +64,12 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
+#if IS_ENABLED(CONFIG_ARCH_RV64ILP32) && !IS_ENABLED(CONFIG_MMU_SV32)
+#define DTB_EARLY_BASE_VA      PGDIR_SIZE
+#else
 #define DTB_EARLY_BASE_VA      (ADDRESS_SPACE_END - (PTRS_PER_PGD / 2 * PGDIR_SIZE) + 1)
+#endif
+
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
@@ -656,16 +665,26 @@ void __init create_pgd_mapping(pgd_t *pgdp,
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
@@ -918,9 +937,9 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
+			   !IS_ENABLED(CONFIG_MMU_SV32) ? early_dtb_pgd_next : pa,
 			   PGDIR_SIZE,
-			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
+			   !IS_ENABLED(CONFIG_MMU_SV32) ? PAGE_TABLE : PAGE_KERNEL);
 
 	if (pgtable_l5_enabled)
 		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
@@ -930,7 +949,7 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
 				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
 
-	if (IS_ENABLED(CONFIG_64BIT)) {
+	if (!IS_ENABLED(CONFIG_MMU_SV32)) {
 		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
 				   pa, PMD_SIZE, PAGE_KERNEL);
 		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
@@ -1149,7 +1168,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
 	if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
 		WARN_ON(1);
-		pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
+		pr_warn("fixmap btmap start [" PTE_FMT "] != end [" PTE_FMT "]\n",
 			pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
 		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
 			fix_to_virt(FIX_BTMAP_BEGIN));
-- 
2.36.1

