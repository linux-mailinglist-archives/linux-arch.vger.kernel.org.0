Return-Path: <linux-arch+bounces-14862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD068C69148
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F59B365A0A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A0353893;
	Tue, 18 Nov 2025 11:28:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15158351FCA;
	Tue, 18 Nov 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465339; cv=none; b=pF/q9bNrDFugzBHtkAWZ6loh5WfEh3mKiOXrH3g3qchX4BBbAYMzmkFXsZOnL9O0wZf8Pe2xeS8v2k+o6qc+8F5h5qbgwr/Z8FsScuKkxTBu2nqDTPQ1G22v6rVjgKTAoh53AiEN8Eo3LF0d+kZ7IDCkZailTOeOtc1EmBjrRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465339; c=relaxed/simple;
	bh=FWAvhYdzVhE+4MBpwBJxQupLKrXupsYNU1N8D6M1Mi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZfSGr+CxBVNFgLt7TsoPz7bO2fNF2yN/06U2/CxZAO2rJF2EpcvVRcQ0zcVBApZCeIbEUAJhtF9NfDKrFWd86eDSajUY85piFWy+fZzY57/NEWN2boDR7ljhChgutF0n6KPmoXPfSGIcS4jV209dS1ZSzsgy3LpTOLEe1hw+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D95C19425;
	Tue, 18 Nov 2025 11:28:54 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yawei Li <liyawei@loongson.cn>
Subject: [PATCH V2 05/14] LoongArch: Adjust memory management for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:19 +0800
Message-ID: <20251118112728.571869-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust memory management for both 32BIT and 64BIT, including: address
space definition, DMW CSR definition, page table bits definition, boot
time detection of VA/PA bits, page table init, tlb exception handling,
copy_page/clear_page/dump_tlb libraries, etc.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yawei Li <liyawei@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/addrspace.h    |  13 +
 arch/loongarch/include/asm/cpu-features.h |   3 -
 arch/loongarch/include/asm/loongarch.h    |  24 ++
 arch/loongarch/include/asm/page.h         |   2 +-
 arch/loongarch/include/asm/pgtable-bits.h |  36 ++-
 arch/loongarch/include/asm/pgtable.h      |  74 +++--
 arch/loongarch/kernel/cpu-probe.c         |   6 +-
 arch/loongarch/lib/dump_tlb.c             |   8 +
 arch/loongarch/mm/init.c                  |   4 +-
 arch/loongarch/mm/page.S                  | 118 ++++----
 arch/loongarch/mm/tlb.c                   |   2 +
 arch/loongarch/mm/tlbex.S                 | 322 +++++++++++++++-------
 12 files changed, 418 insertions(+), 194 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index 9766a100504a..d6472cafb32c 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -38,11 +38,20 @@ extern unsigned long vm_map_base;
 #endif
 
 #ifndef WRITECOMBINE_BASE
+#ifdef CONFIG_32BIT
+#define WRITECOMBINE_BASE	CSR_DMW0_BASE
+#else
 #define WRITECOMBINE_BASE	CSR_DMW2_BASE
 #endif
+#endif
 
+#ifdef CONFIG_32BIT
+#define DMW_PABITS	29
+#define TO_PHYS_MASK	((_UL(1) << _UL(DMW_PABITS)) - 1)
+#else
 #define DMW_PABITS	48
 #define TO_PHYS_MASK	((_ULL(1) << _ULL(DMW_PABITS)) - 1)
+#endif
 
 /*
  * Memory above this physical address will be considered highmem.
@@ -112,7 +121,11 @@ extern unsigned long vm_map_base;
 /*
  * Returns the physical address of a KPRANGEx / XKPRANGE address
  */
+#ifdef CONFIG_32BIT
+#define PHYSADDR(a)		((_ACAST32_(a)) & TO_PHYS_MASK)
+#else
 #define PHYSADDR(a)		((_ACAST64_(a)) & TO_PHYS_MASK)
+#endif
 
 /*
  * On LoongArch, I/O ports mappring is following:
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index bd5f0457ad21..3745d991a99a 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -20,16 +20,13 @@
 #define cpu_has_loongarch64		(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
 
 #ifdef CONFIG_32BIT
-# define cpu_has_64bits			(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
 # define cpu_vabits			31
 # define cpu_pabits			31
 #endif
 
 #ifdef CONFIG_64BIT
-# define cpu_has_64bits			1
 # define cpu_vabits			cpu_data[0].vabits
 # define cpu_pabits			cpu_data[0].pabits
-# define __NEED_ADDRBITS_PROBE
 #endif
 
 /*
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 9f71a79271da..804341bd8d2e 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -912,6 +912,26 @@
 #define LOONGARCH_CSR_DMWIN3		0x183	/* 64 direct map win3: MEM */
 
 /* Direct Map window 0/1/2/3 */
+
+#ifdef CONFIG_32BIT
+
+#define CSR_DMW0_PLV0		(1 << 0)
+#define CSR_DMW0_VSEG		(0x4)
+#define CSR_DMW0_BASE		(CSR_DMW0_VSEG << DMW_PABITS)
+#define CSR_DMW0_INIT		(CSR_DMW0_BASE | CSR_DMW0_PLV0)
+
+#define CSR_DMW1_PLV0		(1 << 0)
+#define CSR_DMW1_MAT		(1 << 4)
+#define CSR_DMW1_VSEG		(0x5)
+#define CSR_DMW1_BASE		(CSR_DMW1_VSEG << DMW_PABITS)
+#define CSR_DMW1_INIT		(CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_PLV0)
+
+#define CSR_DMW2_INIT		0x0
+
+#define CSR_DMW3_INIT		0x0
+
+#else
+
 #define CSR_DMW0_PLV0		_CONST64_(1 << 0)
 #define CSR_DMW0_VSEG		_CONST64_(0x8000)
 #define CSR_DMW0_BASE		(CSR_DMW0_VSEG << DMW_PABITS)
@@ -931,6 +951,8 @@
 
 #define CSR_DMW3_INIT		0x0
 
+#endif
+
 /* Performance Counter registers */
 #define LOONGARCH_CSR_PERFCTRL0		0x200	/* 32 perf event 0 config */
 #define LOONGARCH_CSR_PERFCNTR0		0x201	/* 64 perf event 0 count value */
@@ -1388,8 +1410,10 @@ __BUILD_CSR_OP(tlbidx)
 #define ENTRYLO_C_SHIFT		4
 #define ENTRYLO_C		(_ULCAST_(3) << ENTRYLO_C_SHIFT)
 #define ENTRYLO_G		(_ULCAST_(1) << 6)
+#ifdef CONFIG_64BIT
 #define ENTRYLO_NR		(_ULCAST_(1) << 61)
 #define ENTRYLO_NX		(_ULCAST_(1) << 62)
+#endif
 
 /* Values for PageSize register */
 #define PS_4K		0x0000000c
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index a3aaf34fba16..256d1ff7a1e3 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -10,7 +10,7 @@
 
 #include <vdso/page.h>
 
-#define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
+#define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - PTRLOG)
 #define HPAGE_SIZE	(_AC(1, UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 2fc3789220ac..b565573cd82e 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -6,6 +6,26 @@
 #define _ASM_PGTABLE_BITS_H
 
 /* Page table bits */
+
+#ifdef CONFIG_32BIT
+#define	_PAGE_VALID_SHIFT	0
+#define	_PAGE_ACCESSED_SHIFT	0  /* Reuse Valid for Accessed */
+#define	_PAGE_DIRTY_SHIFT	1
+#define	_PAGE_PLV_SHIFT		2  /* 2~3, two bits */
+#define	_CACHE_SHIFT		4  /* 4~5, two bits */
+#define	_PAGE_GLOBAL_SHIFT	6
+#define	_PAGE_HUGE_SHIFT	6  /* HUGE is a PMD bit */
+#define	_PAGE_PRESENT_SHIFT	7
+#define	_PAGE_PFN_SHIFT		8
+#define	_PAGE_HGLOBAL_SHIFT	12 /* HGlobal is a PMD bit */
+#define	_PAGE_SWP_EXCLUSIVE_SHIFT 13
+#define	_PAGE_PFN_END_SHIFT	28
+#define	_PAGE_WRITE_SHIFT	29
+#define	_PAGE_MODIFIED_SHIFT	30
+#define	_PAGE_PRESENT_INVALID_SHIFT 31
+#endif
+
+#ifdef CONFIG_64BIT
 #define	_PAGE_VALID_SHIFT	0
 #define	_PAGE_ACCESSED_SHIFT	0  /* Reuse Valid for Accessed */
 #define	_PAGE_DIRTY_SHIFT	1
@@ -18,14 +38,15 @@
 #define	_PAGE_MODIFIED_SHIFT	9
 #define	_PAGE_PROTNONE_SHIFT	10
 #define	_PAGE_SPECIAL_SHIFT	11
-#define	_PAGE_HGLOBAL_SHIFT	12 /* HGlobal is a PMD bit */
 #define	_PAGE_PFN_SHIFT		12
+#define	_PAGE_HGLOBAL_SHIFT	12 /* HGlobal is a PMD bit */
 #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
 #define	_PAGE_PFN_END_SHIFT	48
 #define	_PAGE_PRESENT_INVALID_SHIFT 60
 #define	_PAGE_NO_READ_SHIFT	61
 #define	_PAGE_NO_EXEC_SHIFT	62
 #define	_PAGE_RPLV_SHIFT	63
+#endif
 
 /* Used by software */
 #define _PAGE_PRESENT		(_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
@@ -33,10 +54,15 @@
 #define _PAGE_WRITE		(_ULCAST_(1) << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
+#ifdef CONFIG_32BIT
+#define _PAGE_PROTNONE		0
+#define _PAGE_SPECIAL		0
+#else
 #define _PAGE_PROTNONE		(_ULCAST_(1) << _PAGE_PROTNONE_SHIFT)
 #define _PAGE_SPECIAL		(_ULCAST_(1) << _PAGE_SPECIAL_SHIFT)
+#endif
 
-/* We borrow bit 23 to store the exclusive marker in swap PTEs. */
+/* We borrow bit 13/23 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	(_ULCAST_(1) << _PAGE_SWP_EXCLUSIVE_SHIFT)
 
 /* Used by TLB hardware (placed in EntryLo*) */
@@ -46,9 +72,15 @@
 #define _PAGE_GLOBAL		(_ULCAST_(1) << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_HUGE		(_ULCAST_(1) << _PAGE_HUGE_SHIFT)
 #define _PAGE_HGLOBAL		(_ULCAST_(1) << _PAGE_HGLOBAL_SHIFT)
+#ifdef CONFIG_32BIT
+#define _PAGE_NO_READ		0
+#define _PAGE_NO_EXEC		0
+#define _PAGE_RPLV		0
+#else
 #define _PAGE_NO_READ		(_ULCAST_(1) << _PAGE_NO_READ_SHIFT)
 #define _PAGE_NO_EXEC		(_ULCAST_(1) << _PAGE_NO_EXEC_SHIFT)
 #define _PAGE_RPLV		(_ULCAST_(1) << _PAGE_RPLV_SHIFT)
+#endif
 #define _CACHE_MASK		(_ULCAST_(3) << _CACHE_SHIFT)
 #define PFN_PTE_SHIFT		(PAGE_SHIFT - 12 + _PAGE_PFN_SHIFT)
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 03fb60432fde..9ed2ea23c580 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -11,6 +11,7 @@
 
 #include <linux/compiler.h>
 #include <asm/addrspace.h>
+#include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 
@@ -23,37 +24,45 @@
 #endif
 
 #if CONFIG_PGTABLE_LEVELS == 2
-#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - PTRLOG))
 #elif CONFIG_PGTABLE_LEVELS == 3
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - PTRLOG))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - 3))
+#define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - PTRLOG))
 #elif CONFIG_PGTABLE_LEVELS == 4
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - 3))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT - PTRLOG))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - 3))
+#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT - PTRLOG))
 #define PUD_SIZE	(1UL << PUD_SHIFT)
 #define PUD_MASK	(~(PUD_SIZE-1))
-#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT - 3))
+#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT - PTRLOG))
 #endif
 
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define VA_BITS		(PGDIR_SHIFT + (PAGE_SHIFT - 3))
+#ifdef CONFIG_32BIT
+#define VA_BITS		32
+#else
+#define VA_BITS		(PGDIR_SHIFT + (PAGE_SHIFT - PTRLOG))
+#endif
 
-#define PTRS_PER_PGD	(PAGE_SIZE >> 3)
+#define PTRS_PER_PGD	(PAGE_SIZE >> PTRLOG)
 #if CONFIG_PGTABLE_LEVELS > 3
-#define PTRS_PER_PUD	(PAGE_SIZE >> 3)
+#define PTRS_PER_PUD	(PAGE_SIZE >> PTRLOG)
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-#define PTRS_PER_PMD	(PAGE_SIZE >> 3)
+#define PTRS_PER_PMD	(PAGE_SIZE >> PTRLOG)
 #endif
-#define PTRS_PER_PTE	(PAGE_SIZE >> 3)
+#define PTRS_PER_PTE	(PAGE_SIZE >> PTRLOG)
 
+#ifdef CONFIG_32BIT
+#define USER_PTRS_PER_PGD       (TASK_SIZE / PGDIR_SIZE)
+#else
 #define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
+#endif
 
 #ifndef __ASSEMBLER__
 
@@ -74,11 +83,15 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 
 #define ZERO_PAGE(vaddr)	virt_to_page(empty_zero_page)
 
-/*
- * TLB refill handlers may also map the vmalloc area into xkvrange.
- * Avoid the first couple of pages so NULL pointer dereferences will
- * still reliably trap.
- */
+#ifdef CONFIG_32BIT
+
+#define VMALLOC_START	(vm_map_base + PCI_IOSIZE + (2 * PAGE_SIZE))
+#define VMALLOC_END	(FIXADDR_START - (2 * PAGE_SIZE))
+
+#endif
+
+#ifdef CONFIG_64BIT
+
 #define MODULES_VADDR	(vm_map_base + PCI_IOSIZE + (2 * PAGE_SIZE))
 #define MODULES_END	(MODULES_VADDR + SZ_256M)
 
@@ -106,6 +119,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define KFENCE_AREA_START	(VMEMMAP_END + 1)
 #define KFENCE_AREA_END		(KFENCE_AREA_START + KFENCE_AREA_SIZE - 1)
 
+#endif
+
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
@@ -277,7 +292,16 @@ extern void kernel_pte_init(void *addr);
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
  *
- * Format of swap PTEs:
+ * Format of 32bit swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <------------ offset -------------> E <- type -> <-- zeroes -->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   The zero'ed bits include _PAGE_PRESENT.
+ *
+ * Format of 64bit swap PTEs:
  *
  *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
  *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
@@ -290,11 +314,21 @@ extern void kernel_pte_init(void *addr);
  *   E is the exclusive marker that is not stored in swap entries.
  *   The zero'ed bits include _PAGE_PRESENT and _PAGE_PROTNONE.
  */
+
+#define __SWP_TYPE_BITS		(IS_ENABLED(CONFIG_32BIT) ? 5 : 7)
+#define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
+#define __SWP_TYPE_SHIFT	(IS_ENABLED(CONFIG_32BIT) ? 8 : 16)
+#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT + 1)
+
 static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = ((type & 0x7f) << 16) | (offset << 24); return pte; }
+{
+	pte_t pte;
+	pte_val(pte) = ((type & __SWP_TYPE_MASK) << __SWP_TYPE_SHIFT) | (offset << __SWP_OFFSET_SHIFT);
+	return pte;
+}
 
-#define __swp_type(x)		(((x).val >> 16) & 0x7f)
-#define __swp_offset(x)		((x).val >> 24)
+#define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
+#define __swp_offset(x)		((x).val >> __SWP_OFFSET_SHIFT)
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 97933e9e2aa3..a10e902a9888 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,7 +106,11 @@ EXPORT_SYMBOL(vm_map_base);
 
 static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
 {
-#ifdef __NEED_ADDRBITS_PROBE
+#ifdef CONFIG_32BIT
+	c->pabits = cpu_pabits;
+	c->vabits = cpu_vabits;
+	vm_map_base = KVRANGE;
+#else
 	c->pabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_PABITS) >> 4;
 	c->vabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_VABITS) >> 12;
 	vm_map_base = 0UL - (1UL << c->vabits);
diff --git a/arch/loongarch/lib/dump_tlb.c b/arch/loongarch/lib/dump_tlb.c
index 116f21ea4e2c..e1cdad7a676e 100644
--- a/arch/loongarch/lib/dump_tlb.c
+++ b/arch/loongarch/lib/dump_tlb.c
@@ -73,12 +73,16 @@ static void dump_tlb(int first, int last)
 			vwidth, (entryhi & ~0x1fffUL), asidwidth, asid & asidmask);
 
 		/* NR/NX are in awkward places, so mask them off separately */
+#ifdef CONFIG_64BIT
 		pa = entrylo0 & ~(ENTRYLO_NR | ENTRYLO_NX);
+#endif
 		pa = pa & PAGE_MASK;
 		pr_cont("\n\t[");
+#ifdef CONFIG_64BIT
 		pr_cont("nr=%d nx=%d ",
 			(entrylo0 & ENTRYLO_NR) ? 1 : 0,
 			(entrylo0 & ENTRYLO_NX) ? 1 : 0);
+#endif
 		pr_cont("pa=0x%0*llx c=%d d=%d v=%d g=%d plv=%lld] [",
 			pwidth, pa, c0,
 			(entrylo0 & ENTRYLO_D) ? 1 : 0,
@@ -86,11 +90,15 @@ static void dump_tlb(int first, int last)
 			(entrylo0 & ENTRYLO_G) ? 1 : 0,
 			(entrylo0 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
 		/* NR/NX are in awkward places, so mask them off separately */
+#ifdef CONFIG_64BIT
 		pa = entrylo1 & ~(ENTRYLO_NR | ENTRYLO_NX);
+#endif
 		pa = pa & PAGE_MASK;
+#ifdef CONFIG_64BIT
 		pr_cont("nr=%d nx=%d ",
 			(entrylo1 & ENTRYLO_NR) ? 1 : 0,
 			(entrylo1 & ENTRYLO_NX) ? 1 : 0);
+#endif
 		pr_cont("pa=0x%0*llx c=%d d=%d v=%d g=%d plv=%lld]\n",
 			pwidth, pa, c1,
 			(entrylo1 & ENTRYLO_D) ? 1 : 0,
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 6bfd4b8dad1b..0946662afdd6 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -224,7 +224,7 @@ EXPORT_SYMBOL(invalid_pmd_table);
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
 
-#ifdef CONFIG_EXECMEM
+#if defined(CONFIG_EXECMEM) && defined(MODULES_VADDR)
 static struct execmem_info execmem_info __ro_after_init;
 
 struct execmem_info __init *execmem_arch_setup(void)
@@ -242,4 +242,4 @@ struct execmem_info __init *execmem_arch_setup(void)
 
 	return &execmem_info;
 }
-#endif /* CONFIG_EXECMEM */
+#endif /* CONFIG_EXECMEM && MODULES_VADDR */
diff --git a/arch/loongarch/mm/page.S b/arch/loongarch/mm/page.S
index 7ad76551d313..7286b804756d 100644
--- a/arch/loongarch/mm/page.S
+++ b/arch/loongarch/mm/page.S
@@ -10,75 +10,75 @@
 
 	.align 5
 SYM_FUNC_START(clear_page)
-	lu12i.w	t0, 1 << (PAGE_SHIFT - 12)
-	add.d	t0, t0, a0
+	lu12i.w		t0, 1 << (PAGE_SHIFT - 12)
+	PTR_ADD		t0, t0, a0
 1:
-	st.d	zero, a0, 0
-	st.d	zero, a0, 8
-	st.d	zero, a0, 16
-	st.d	zero, a0, 24
-	st.d	zero, a0, 32
-	st.d	zero, a0, 40
-	st.d	zero, a0, 48
-	st.d	zero, a0, 56
-	addi.d	a0,   a0, 128
-	st.d	zero, a0, -64
-	st.d	zero, a0, -56
-	st.d	zero, a0, -48
-	st.d	zero, a0, -40
-	st.d	zero, a0, -32
-	st.d	zero, a0, -24
-	st.d	zero, a0, -16
-	st.d	zero, a0, -8
-	bne	t0,   a0, 1b
+	LONG_S		zero, a0, (LONGSIZE * 0)
+	LONG_S		zero, a0, (LONGSIZE * 1)
+	LONG_S		zero, a0, (LONGSIZE * 2)
+	LONG_S		zero, a0, (LONGSIZE * 3)
+	LONG_S		zero, a0, (LONGSIZE * 4)
+	LONG_S		zero, a0, (LONGSIZE * 5)
+	LONG_S		zero, a0, (LONGSIZE * 6)
+	LONG_S		zero, a0, (LONGSIZE * 7)
+	PTR_ADDI	a0,   a0, (LONGSIZE * 16)
+	LONG_S		zero, a0, -(LONGSIZE * 8)
+	LONG_S		zero, a0, -(LONGSIZE * 7)
+	LONG_S		zero, a0, -(LONGSIZE * 6)
+	LONG_S		zero, a0, -(LONGSIZE * 5)
+	LONG_S		zero, a0, -(LONGSIZE * 4)
+	LONG_S		zero, a0, -(LONGSIZE * 3)
+	LONG_S		zero, a0, -(LONGSIZE * 2)
+	LONG_S		zero, a0, -(LONGSIZE * 1)
+	bne		t0,   a0, 1b
 
-	jr	ra
+	jr		ra
 SYM_FUNC_END(clear_page)
 EXPORT_SYMBOL(clear_page)
 
 .align 5
 SYM_FUNC_START(copy_page)
-	lu12i.w	t8, 1 << (PAGE_SHIFT - 12)
-	add.d	t8, t8, a0
+	lu12i.w		t8, 1 << (PAGE_SHIFT - 12)
+	PTR_ADD		t8, t8, a0
 1:
-	ld.d	t0, a1, 0
-	ld.d	t1, a1, 8
-	ld.d	t2, a1, 16
-	ld.d	t3, a1, 24
-	ld.d	t4, a1, 32
-	ld.d	t5, a1, 40
-	ld.d	t6, a1, 48
-	ld.d	t7, a1, 56
+	LONG_L		t0, a1, (LONGSIZE * 0)
+	LONG_L		t1, a1, (LONGSIZE * 1)
+	LONG_L		t2, a1, (LONGSIZE * 2)
+	LONG_L		t3, a1, (LONGSIZE * 3)
+	LONG_L		t4, a1, (LONGSIZE * 4)
+	LONG_L		t5, a1, (LONGSIZE * 5)
+	LONG_L		t6, a1, (LONGSIZE * 6)
+	LONG_L		t7, a1, (LONGSIZE * 7)
 
-	st.d	t0, a0, 0
-	st.d	t1, a0, 8
-	ld.d	t0, a1, 64
-	ld.d	t1, a1, 72
-	st.d	t2, a0, 16
-	st.d	t3, a0, 24
-	ld.d	t2, a1, 80
-	ld.d	t3, a1, 88
-	st.d	t4, a0, 32
-	st.d	t5, a0, 40
-	ld.d	t4, a1, 96
-	ld.d	t5, a1, 104
-	st.d	t6, a0, 48
-	st.d	t7, a0, 56
-	ld.d	t6, a1, 112
-	ld.d	t7, a1, 120
-	addi.d	a0, a0, 128
-	addi.d	a1, a1, 128
+	LONG_S		t0, a0, (LONGSIZE * 0)
+	LONG_S		t1, a0, (LONGSIZE * 1)
+	LONG_L		t0, a1, (LONGSIZE * 8)
+	LONG_L		t1, a1, (LONGSIZE * 9)
+	LONG_S		t2, a0, (LONGSIZE * 2)
+	LONG_S		t3, a0, (LONGSIZE * 3)
+	LONG_L		t2, a1, (LONGSIZE * 10)
+	LONG_L		t3, a1, (LONGSIZE * 11)
+	LONG_S		t4, a0, (LONGSIZE * 4)
+	LONG_S		t5, a0, (LONGSIZE * 5)
+	LONG_L		t4, a1, (LONGSIZE * 12)
+	LONG_L		t5, a1, (LONGSIZE * 13)
+	LONG_S		t6, a0, (LONGSIZE * 6)
+	LONG_S		t7, a0, (LONGSIZE * 7)
+	LONG_L		t6, a1, (LONGSIZE * 14)
+	LONG_L		t7, a1, (LONGSIZE * 15)
+	PTR_ADDI	a0, a0, (LONGSIZE * 16)
+	PTR_ADDI	a1, a1, (LONGSIZE * 16)
 
-	st.d	t0, a0, -64
-	st.d	t1, a0, -56
-	st.d	t2, a0, -48
-	st.d	t3, a0, -40
-	st.d	t4, a0, -32
-	st.d	t5, a0, -24
-	st.d	t6, a0, -16
-	st.d	t7, a0, -8
+	LONG_S		t0, a0, -(LONGSIZE * 8)
+	LONG_S		t1, a0, -(LONGSIZE * 7)
+	LONG_S		t2, a0, -(LONGSIZE * 6)
+	LONG_S		t3, a0, -(LONGSIZE * 5)
+	LONG_S		t4, a0, -(LONGSIZE * 4)
+	LONG_S		t5, a0, -(LONGSIZE * 3)
+	LONG_S		t6, a0, -(LONGSIZE * 2)
+	LONG_S		t7, a0, -(LONGSIZE * 1)
 
-	bne	t8, a0, 1b
-	jr	ra
+	bne		t8, a0, 1b
+	jr		ra
 SYM_FUNC_END(copy_page)
 EXPORT_SYMBOL(copy_page)
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 6e474469e210..6a3c91b9cacd 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -251,8 +251,10 @@ static void output_pgtable_bits_defines(void)
 	pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
 	pr_define("_PAGE_PRESENT_SHIFT %d\n", _PAGE_PRESENT_SHIFT);
 	pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
+#ifdef CONFIG_64BIT
 	pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
 	pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
+#endif
 	pr_define("PFN_PTE_SHIFT %d\n", PFN_PTE_SHIFT);
 	pr_debug("\n");
 }
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index c08682a89c58..84a881a339a7 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -11,10 +11,18 @@
 
 #define INVTLB_ADDR_GFALSE_AND_ASID	5
 
-#define PTRS_PER_PGD_BITS	(PAGE_SHIFT - 3)
-#define PTRS_PER_PUD_BITS	(PAGE_SHIFT - 3)
-#define PTRS_PER_PMD_BITS	(PAGE_SHIFT - 3)
-#define PTRS_PER_PTE_BITS	(PAGE_SHIFT - 3)
+#define PTRS_PER_PGD_BITS	(PAGE_SHIFT - PTRLOG)
+#define PTRS_PER_PUD_BITS	(PAGE_SHIFT - PTRLOG)
+#define PTRS_PER_PMD_BITS	(PAGE_SHIFT - PTRLOG)
+#define PTRS_PER_PTE_BITS	(PAGE_SHIFT - PTRLOG)
+
+#ifdef CONFIG_32BIT
+#define PTE_LL	ll.w
+#define PTE_SC	sc.w
+#else
+#define PTE_LL	ll.d
+#define PTE_SC	sc.d
+#endif
 
 	.macro tlb_do_page_fault, write
 	SYM_CODE_START(tlb_do_page_fault_\write)
@@ -60,52 +68,61 @@ SYM_CODE_START(handle_tlb_load)
 
 vmalloc_done_load:
 	/* Get PGD offset in bytes */
-	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
-	alsl.d		t1, ra, t1, 3
+#ifdef CONFIG_32BIT
+	PTR_BSTRPICK	ra, t0, 31, PGDIR_SHIFT
+#else
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+#endif
+	PTR_ALSL	t1, ra, t1, _PGD_T_LOG2
+
 #if CONFIG_PGTABLE_LEVELS > 3
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
+
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
+
 #endif
-	ld.d		ra, t1, 0
+	PTR_L		ra, t1, 0
 
 	/*
 	 * For huge tlb entries, pmde doesn't contain an address but
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	rotri.d		ra, ra, _PAGE_HUGE_SHIFT + 1
+	PTR_ROTRI	ra, ra, _PAGE_HUGE_SHIFT + 1
 	bltz		ra, tlb_huge_update_load
 
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
-	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
-	alsl.d		t1, t0, ra, _PTE_T_LOG2
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
+	PTR_BSTRPICK	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	PTR_ALSL	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_load:
-	ll.d		t0, t1, 0
+	PTE_LL		t0, t1, 0
 #else
-	ld.d		t0, t1, 0
+	PTR_L		t0, t1, 0
 #endif
 	andi		ra, t0, _PAGE_PRESENT
 	beqz		ra, nopage_tlb_load
 
 	ori		t0, t0, _PAGE_VALID
+
 #ifdef CONFIG_SMP
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, smp_pgtable_change_load
 #else
-	st.d		t0, t1, 0
+	PTR_S		t0, t1, 0
 #endif
+
 	tlbsrch
-	bstrins.d	t1, zero, 3, 3
-	ld.d		t0, t1, 0
-	ld.d		t1, t1, 8
+	PTR_BSTRINS	t1, zero, _PTE_T_LOG2, _PTE_T_LOG2
+	PTR_L		t0, t1, 0
+	PTR_L		t1, t1, _PTE_T_SIZE
 	csrwr		t0, LOONGARCH_CSR_TLBELO0
 	csrwr		t1, LOONGARCH_CSR_TLBELO1
 	tlbwr
@@ -115,30 +132,28 @@ smp_pgtable_change_load:
 	csrrd		ra, EXCEPTION_KS2
 	ertn
 
-#ifdef CONFIG_64BIT
 vmalloc_load:
 	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_load
-#endif
 
 	/* This is the entry point of a huge page. */
 tlb_huge_update_load:
 #ifdef CONFIG_SMP
-	ll.d		ra, t1, 0
+	PTE_LL		ra, t1, 0
 #else
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
 #endif
 	andi		t0, ra, _PAGE_PRESENT
 	beqz		t0, nopage_tlb_load
 
 #ifdef CONFIG_SMP
 	ori		t0, ra, _PAGE_VALID
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, tlb_huge_update_load
 	ori		t0, ra, _PAGE_VALID
 #else
 	ori		t0, ra, _PAGE_VALID
-	st.d		t0, t1, 0
+	PTR_S		t0, t1, 0
 #endif
 	csrrd		ra, LOONGARCH_CSR_ASID
 	csrrd		t1, LOONGARCH_CSR_BADV
@@ -158,27 +173,27 @@ tlb_huge_update_load:
 	xori		t0, t0, _PAGE_HUGE
 	lu12i.w		t1, _PAGE_HGLOBAL >> 12
 	and		t1, t0, t1
-	srli.d		t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
+	PTR_SRLI	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or		t0, t0, t1
 
 	move		ra, t0
 	csrwr		ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
-	addi.d		t1, zero, 1
-	slli.d		t1, t1, (HPAGE_SHIFT - 1)
-	add.d		t0, t0, t1
+	PTR_ADDI	t1, zero, 1
+	PTR_SLLI	t1, t1, (HPAGE_SHIFT - 1)
+	PTR_ADD		t0, t0, t1
 	csrwr		t0, LOONGARCH_CSR_TLBELO1
 
 	/* Set huge page tlb entry size */
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	tlbfill
 
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	csrrd		t0, EXCEPTION_KS0
@@ -216,53 +231,71 @@ SYM_CODE_START(handle_tlb_store)
 
 vmalloc_done_store:
 	/* Get PGD offset in bytes */
-	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
-	alsl.d		t1, ra, t1, 3
+#ifdef CONFIG_32BIT
+	PTR_BSTRPICK	ra, t0, 31, PGDIR_SHIFT
+#else
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+#endif
+	PTR_ALSL	t1, ra, t1, _PGD_T_LOG2
+
 #if CONFIG_PGTABLE_LEVELS > 3
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
 #endif
-	ld.d		ra, t1, 0
+	PTR_L		ra, t1, 0
 
 	/*
 	 * For huge tlb entries, pmde doesn't contain an address but
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	rotri.d		ra, ra, _PAGE_HUGE_SHIFT + 1
+	PTR_ROTRI	ra, ra, _PAGE_HUGE_SHIFT + 1
 	bltz		ra, tlb_huge_update_store
 
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
-	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
-	alsl.d		t1, t0, ra, _PTE_T_LOG2
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
+	PTR_BSTRPICK	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	PTR_ALSL	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_store:
-	ll.d		t0, t1, 0
+	PTE_LL		t0, t1, 0
 #else
-	ld.d		t0, t1, 0
+	PTR_L		t0, t1, 0
 #endif
+
+#ifdef CONFIG_64BIT
 	andi		ra, t0, _PAGE_PRESENT | _PAGE_WRITE
 	xori		ra, ra, _PAGE_PRESENT | _PAGE_WRITE
+#else
+	PTR_LI		ra, _PAGE_PRESENT | _PAGE_WRITE
+	and		ra, ra, t0
+	nor		ra, ra, zero
+#endif
 	bnez		ra, nopage_tlb_store
 
+#ifdef CONFIG_64BIT
 	ori		t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+#else
+	PTR_LI		ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	or		t0, ra, t0
+#endif
+
 #ifdef CONFIG_SMP
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, smp_pgtable_change_store
 #else
-	st.d		t0, t1, 0
+	PTR_S		t0, t1, 0
 #endif
 	tlbsrch
-	bstrins.d	t1, zero, 3, 3
-	ld.d		t0, t1, 0
-	ld.d		t1, t1, 8
+	PTR_BSTRINS	t1, zero, _PTE_T_LOG2, _PTE_T_LOG2
+	PTR_L		t0, t1, 0
+	PTR_L		t1, t1, _PTE_T_SIZE
 	csrwr		t0, LOONGARCH_CSR_TLBELO0
 	csrwr		t1, LOONGARCH_CSR_TLBELO1
 	tlbwr
@@ -272,31 +305,42 @@ smp_pgtable_change_store:
 	csrrd		ra, EXCEPTION_KS2
 	ertn
 
-#ifdef CONFIG_64BIT
 vmalloc_store:
 	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_store
-#endif
 
 	/* This is the entry point of a huge page. */
 tlb_huge_update_store:
 #ifdef CONFIG_SMP
-	ll.d		ra, t1, 0
+	PTE_LL		ra, t1, 0
 #else
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
 #endif
+
+#ifdef CONFIG_64BIT
 	andi		t0, ra, _PAGE_PRESENT | _PAGE_WRITE
 	xori		t0, t0, _PAGE_PRESENT | _PAGE_WRITE
+#else
+	PTR_LI		t0, _PAGE_PRESENT | _PAGE_WRITE
+	and		t0, t0, ra
+	nor		t0, t0, zero
+#endif
+
 	bnez		t0, nopage_tlb_store
 
 #ifdef CONFIG_SMP
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, tlb_huge_update_store
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 #else
+#ifdef CONFIG_64BIT
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
-	st.d		t0, t1, 0
+#else
+	PTR_LI		t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	or		t0, ra, t0
+#endif
+	PTR_S		t0, t1, 0
 #endif
 	csrrd		ra, LOONGARCH_CSR_ASID
 	csrrd		t1, LOONGARCH_CSR_BADV
@@ -316,28 +360,28 @@ tlb_huge_update_store:
 	xori		t0, t0, _PAGE_HUGE
 	lu12i.w		t1, _PAGE_HGLOBAL >> 12
 	and		t1, t0, t1
-	srli.d		t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
+	PTR_SRLI	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or		t0, t0, t1
 
 	move		ra, t0
 	csrwr		ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
-	addi.d		t1, zero, 1
-	slli.d		t1, t1, (HPAGE_SHIFT - 1)
-	add.d		t0, t0, t1
+	PTR_ADDI	t1, zero, 1
+	PTR_SLLI	t1, t1, (HPAGE_SHIFT - 1)
+	PTR_ADD		t0, t0, t1
 	csrwr		t0, LOONGARCH_CSR_TLBELO1
 
 	/* Set huge page tlb entry size */
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	tlbfill
 
 	/* Reset default page size */
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	csrrd		t0, EXCEPTION_KS0
@@ -375,52 +419,69 @@ SYM_CODE_START(handle_tlb_modify)
 
 vmalloc_done_modify:
 	/* Get PGD offset in bytes */
-	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
-	alsl.d		t1, ra, t1, 3
+#ifdef CONFIG_32BIT
+	PTR_BSTRPICK	ra, t0, 31, PGDIR_SHIFT
+#else
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+#endif
+	PTR_ALSL	t1, ra, t1, _PGD_T_LOG2
+
 #if CONFIG_PGTABLE_LEVELS > 3
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	ld.d		t1, t1, 0
-	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
-	alsl.d		t1, ra, t1, 3
+	PTR_L		t1, t1, 0
+	PTR_BSTRPICK	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	PTR_ALSL	t1, ra, t1, _PMD_T_LOG2
 #endif
-	ld.d		ra, t1, 0
+	PTR_L		ra, t1, 0
 
 	/*
 	 * For huge tlb entries, pmde doesn't contain an address but
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	rotri.d		ra, ra, _PAGE_HUGE_SHIFT + 1
+	PTR_ROTRI	ra, ra, _PAGE_HUGE_SHIFT + 1
 	bltz		ra, tlb_huge_update_modify
 
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
-	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
-	alsl.d		t1, t0, ra, _PTE_T_LOG2
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
+	PTR_BSTRPICK	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	PTR_ALSL	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_modify:
-	ll.d		t0, t1, 0
+	PTE_LL		t0, t1, 0
 #else
-	ld.d		t0, t1, 0
+	PTR_L		t0, t1, 0
 #endif
+#ifdef CONFIG_64BIT
 	andi		ra, t0, _PAGE_WRITE
+#else
+	PTR_LI		ra, _PAGE_WRITE
+	and 		ra, t0, ra
+#endif
+
 	beqz		ra, nopage_tlb_modify
 
+#ifdef CONFIG_64BIT
 	ori		t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+#else
+	PTR_LI		ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	or		t0, ra, t0
+#endif
+
 #ifdef CONFIG_SMP
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, smp_pgtable_change_modify
 #else
-	st.d		t0, t1, 0
+	PTR_S		t0, t1, 0
 #endif
 	tlbsrch
-	bstrins.d	t1, zero, 3, 3
-	ld.d		t0, t1, 0
-	ld.d		t1, t1, 8
+	PTR_BSTRINS	t1, zero, _PTE_T_LOG2, _PTE_T_LOG2
+	PTR_L		t0, t1, 0
+	PTR_L		t1, t1, _PTE_T_SIZE
 	csrwr		t0, LOONGARCH_CSR_TLBELO0
 	csrwr		t1, LOONGARCH_CSR_TLBELO1
 	tlbwr
@@ -430,30 +491,40 @@ smp_pgtable_change_modify:
 	csrrd		ra, EXCEPTION_KS2
 	ertn
 
-#ifdef CONFIG_64BIT
 vmalloc_modify:
 	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_modify
-#endif
 
 	/* This is the entry point of a huge page. */
 tlb_huge_update_modify:
 #ifdef CONFIG_SMP
-	ll.d		ra, t1, 0
+	PTE_LL		ra, t1, 0
 #else
-	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	PTR_ROTRI	ra, ra, BITS_PER_LONG - (_PAGE_HUGE_SHIFT + 1)
 #endif
+
+#ifdef CONFIG_64BIT
 	andi		t0, ra, _PAGE_WRITE
+#else
+	PTR_LI		t0, _PAGE_WRITE
+	and 		t0, ra, t0
+#endif
+
 	beqz		t0, nopage_tlb_modify
 
 #ifdef CONFIG_SMP
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
-	sc.d		t0, t1, 0
+	PTE_SC		t0, t1, 0
 	beqz		t0, tlb_huge_update_modify
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 #else
+#ifdef CONFIG_64BIT
 	ori		t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
-	st.d		t0, t1, 0
+#else
+	PTR_LI		t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	or		t0, ra, t0
+#endif
+	PTR_S		t0, t1, 0
 #endif
 	csrrd		ra, LOONGARCH_CSR_ASID
 	csrrd		t1, LOONGARCH_CSR_BADV
@@ -473,28 +544,28 @@ tlb_huge_update_modify:
 	xori		t0, t0, _PAGE_HUGE
 	lu12i.w		t1, _PAGE_HGLOBAL >> 12
 	and		t1, t0, t1
-	srli.d		t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
+	PTR_SRLI	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or		t0, t0, t1
 
 	move		ra, t0
 	csrwr		ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
-	addi.d		t1, zero, 1
-	slli.d		t1, t1, (HPAGE_SHIFT - 1)
-	add.d		t0, t0, t1
+	PTR_ADDI	t1, zero, 1
+	PTR_SLLI	t1, t1, (HPAGE_SHIFT - 1)
+	PTR_ADD		t0, t0, t1
 	csrwr		t0, LOONGARCH_CSR_TLBELO1
 
 	/* Set huge page tlb entry size */
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_HUGE_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	tlbfill
 
 	/* Reset default page size */
-	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
-	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
+	PTR_LI		t0, (CSR_TLBIDX_PS >> 16) << 16
+	PTR_LI		t1, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 	csrrd		t0, EXCEPTION_KS0
@@ -517,6 +588,44 @@ SYM_CODE_START(handle_tlb_modify_ptw)
 	jr		t0
 SYM_CODE_END(handle_tlb_modify_ptw)
 
+#ifdef CONFIG_32BIT
+SYM_CODE_START(handle_tlb_refill)
+	UNWIND_HINT_UNDEFINED
+	csrwr		t0, EXCEPTION_KS0
+	csrwr		t1, EXCEPTION_KS1
+	csrwr		ra, EXCEPTION_KS2
+	li.w		ra, 0x1fffffff
+
+	csrrd		t0, LOONGARCH_CSR_PGD
+	csrrd		t1, LOONGARCH_CSR_TLBRBADV
+	srli.w		t1, t1, PGDIR_SHIFT
+	slli.w		t1, t1, 0x2
+	add.w		t0, t0, t1
+	and		t0, t0, ra
+
+	ld.w		t0, t0, 0
+	csrrd		t1, LOONGARCH_CSR_TLBRBADV
+	slli.w		t1, t1, (32 - PGDIR_SHIFT)
+	srli.w		t1, t1, (32 - PGDIR_SHIFT + PAGE_SHIFT + 1)
+	slli.w		t1, t1, (0x2 + 1)
+	add.w		t0, t0, t1
+	and		t0, t0, ra
+
+	ld.w		t1, t0, 0x0
+	csrwr		t1, LOONGARCH_CSR_TLBRELO0
+
+	ld.w		t1, t0, 0x4
+	csrwr		t1, LOONGARCH_CSR_TLBRELO1
+
+	tlbfill
+	csrrd		t0, EXCEPTION_KS0
+	csrrd		t1, EXCEPTION_KS1
+	csrrd		ra, EXCEPTION_KS2
+	ertn
+SYM_CODE_END(handle_tlb_refill)
+#endif
+
+#ifdef CONFIG_64BIT
 SYM_CODE_START(handle_tlb_refill)
 	UNWIND_HINT_UNDEFINED
 	csrwr		t0, LOONGARCH_CSR_TLBRSAVE
@@ -534,3 +643,4 @@ SYM_CODE_START(handle_tlb_refill)
 	csrrd		t0, LOONGARCH_CSR_TLBRSAVE
 	ertn
 SYM_CODE_END(handle_tlb_refill)
+#endif
-- 
2.47.3


