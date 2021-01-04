Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3D02E9E93
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbhADUIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:08:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45697 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhADUID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:08:03 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 15:08:00 EST
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CEA5A40007;
        Mon,  4 Jan 2021 20:07:17 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 08/12] riscv: Implement sv48 support
Date:   Mon,  4 Jan 2021 14:58:36 -0500
Message-Id: <20210104195840.1593-9-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By adding a new 4th level of page table, give the possibility to 64bit
kernel to address 2^48 bytes of virtual address: in practice, that roughly
offers ~160TB of virtual address space to userspace and allows up to 64TB
of physical memory.

If the underlying hardware does not support sv48, we will automatically
fallback to a standard 3-level page table by folding the new PUD level into
PGDIR level. In order to detect HW capabilities at runtime, we
use SATP feature that ignores writes with an unsupported mode.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig                      |   6 +-
 arch/riscv/include/asm/csr.h            |   3 +-
 arch/riscv/include/asm/fixmap.h         |   3 +
 arch/riscv/include/asm/page.h           |  12 ++
 arch/riscv/include/asm/pgalloc.h        |  40 +++++
 arch/riscv/include/asm/pgtable-64.h     | 104 +++++++++++-
 arch/riscv/include/asm/pgtable.h        |  12 +-
 arch/riscv/kernel/head.S                |   3 +-
 arch/riscv/mm/context.c                 |   2 +-
 arch/riscv/mm/init.c                    | 212 +++++++++++++++++++++---
 drivers/firmware/efi/libstub/efi-stub.c |   2 +-
 11 files changed, 362 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 852ab2f7a50d..03205e11f952 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -127,7 +127,7 @@ config PAGE_OFFSET
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
 	default 0x80000000 if 64BIT && !MMU
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
+	default 0xffffc00000000000 if 64BIT && !MAXPHYSMEM_2GB
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
@@ -176,9 +176,11 @@ config GENERIC_HWEIGHT
 config FIX_EARLYCON_MEM
 	def_bool MMU
 
+# On a 64BIT relocatable kernel, the 4-level page table is at runtime folded
+# on a 3-level page table when sv48 is not supported.
 config PGTABLE_LEVELS
 	int
-	default 3 if 64BIT
+	default 4 if 64BIT
 	default 2
 
 config LOCKDEP_SUPPORT
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index cec462e198ce..d41536c3f8d4 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -40,11 +40,10 @@
 #ifndef CONFIG_64BIT
 #define SATP_PPN	_AC(0x003FFFFF, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
-#define SATP_MODE	SATP_MODE_32
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UL)
-#define SATP_MODE	SATP_MODE_39
+#define SATP_MODE_48	_AC(0x9000000000000000, UL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 54cbf07fb4e9..c4e51929773a 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -24,6 +24,9 @@ enum fixed_addresses {
 	FIX_HOLE,
 	FIX_PTE,
 	FIX_PMD,
+#ifdef CONFIG_64BIT
+	FIX_PUD,
+#endif
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index a93e35aaa717..37ca192a7b80 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -31,7 +31,16 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
+#ifdef CONFIG_64BIT
+#define PAGE_OFFSET		__page_offset
+/*
+ * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
+ * define the PAGE_OFFSET value for SV39.
+ */
+#define PAGE_OFFSET_L3		0xffffffe000000000
+#else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
+#endif /* CONFIG_64BIT */
 
 #define KERN_VIRT_SIZE (-PAGE_OFFSET)
 
@@ -102,6 +111,9 @@ extern unsigned long pfn_base;
 extern unsigned long max_low_pfn;
 extern unsigned long min_low_pfn;
 extern unsigned long kernel_virt_addr;
+#ifdef CONFIG_64BIT
+extern unsigned long __page_offset;
+#endif
 extern uintptr_t load_pa, load_sz;
 
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 23b1544e0ca5..2b7fb8156fc6 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -11,6 +11,8 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
+#define __HAVE_ARCH_PUD_ALLOC_ONE
+#define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -36,6 +38,44 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
+
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
+{
+	if (pgtable_l4_enabled) {
+		unsigned long pfn = virt_to_pfn(pud);
+
+		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	}
+}
+
+static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
+				     pud_t *pud)
+{
+	if (pgtable_l4_enabled) {
+		unsigned long pfn = virt_to_pfn(pud);
+
+		set_p4d_safe(p4d,
+			     __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	}
+}
+
+#define pud_alloc_one pud_alloc_one
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	if (pgtable_l4_enabled)
+		return __pud_alloc_one(mm, addr);
+
+	return NULL;
+}
+
+#define pud_free pud_free
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	if (pgtable_l4_enabled)
+		__pud_free(mm, pud);
+}
+
+#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 #define pmd_pgtable(pmd)	pmd_page(pmd)
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da64c6c8..338670897fbf 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,16 +8,36 @@
 
 #include <linux/const.h>
 
-#define PGDIR_SHIFT     30
+extern bool pgtable_l4_enabled;
+
+#define PGDIR_SHIFT_L3  30
+#define PGDIR_SHIFT_L4  39
+#define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
+
+#define PGDIR_SHIFT     (pgtable_l4_enabled ? PGDIR_SHIFT_L4: PGDIR_SHIFT_L3)
 /* Size of region mapped by a page global directory */
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
+/* pud is folded into pgd in case of 3-level page table */
+#define PUD_SHIFT	30
+#define PUD_SIZE	(_AC(1, UL) << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE - 1))
+
 #define PMD_SHIFT       21
 /* Size of region mapped by a page middle directory */
 #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE - 1))
 
+/* Page Upper Directory entry */
+typedef struct {
+	unsigned long pud;
+} pud_t;
+
+#define pud_val(x)      ((x).pud)
+#define __pud(x)        ((pud_t) { (x) })
+#define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
+
 /* Page Middle Directory entry */
 typedef struct {
 	unsigned long pmd;
@@ -60,6 +80,16 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
+static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+{
+	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+static inline unsigned long _pud_pfn(pud_t pud)
+{
+	return pud_val(pud) >> _PAGE_PFN_SHIFT;
+}
+
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
@@ -70,6 +100,17 @@ static inline struct page *pud_page(pud_t pud)
 	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
+#define mm_pud_folded	mm_pud_folded
+static inline bool mm_pud_folded(struct mm_struct *mm)
+{
+	if (pgtable_l4_enabled)
+		return false;
+
+	return true;
+}
+
+#define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
@@ -83,4 +124,65 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 
+#define pud_ERROR(e)	\
+	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
+
+static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		*p4dp = p4d;
+	else
+		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
+}
+
+static inline int p4d_none(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (p4d_val(p4d) == 0);
+
+	return 0;
+}
+
+static inline int p4d_present(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (p4d_val(p4d) & _PAGE_PRESENT);
+
+	return 1;
+}
+
+static inline int p4d_bad(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return !p4d_present(p4d);
+
+	return 0;
+}
+
+static inline void p4d_clear(p4d_t *p4d)
+{
+	if (pgtable_l4_enabled)
+		set_p4d(p4d, __p4d(0));
+}
+
+static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (unsigned long)pfn_to_virt(
+				p4d_val(p4d) >> _PAGE_PFN_SHIFT);
+
+	return pud_page_vaddr((pud_t) { p4d_val(p4d) });
+}
+
+#define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
+static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+{
+	if (pgtable_l4_enabled)
+		return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
+
+	return (pud_t *)p4d;
+}
+#define pud_offset pud_offset
+
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index c7973bfd65bc..dd27d28f1d9e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -44,7 +44,7 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
-#define VA_BITS		39
+#define VA_BITS		(pgtable_l4_enabled ? 48 : 39)
 #else
 #define VA_BITS		32
 #endif
@@ -76,8 +76,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Page Upper Directory not used in RISC-V */
-#include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable-nop4d.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 #include <linux/mm_types.h>
@@ -470,9 +469,11 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 #else
-#define TASK_SIZE FIXADDR_START
+#define TASK_SIZE	FIXADDR_START
+#define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
 #else /* CONFIG_MMU */
@@ -493,6 +494,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
 extern char _start[];
 extern void *dtb_early_va;
 extern uintptr_t dtb_early_pa;
+extern u64 satp_mode;
 void setup_bootmem(void);
 void paging_init(void);
 
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 66f40c49bf68..c98877307d4e 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -82,7 +82,8 @@ relocate:
 
 	/* Compute satp for kernel page tables, but don't load it yet */
 	srl a2, a0, PAGE_SHIFT
-	li a1, SATP_MODE
+	la a1, satp_mode
+	REG_L a1, 0(a1)
 	or a2, a2, a1
 
 	/*
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 613ec81a8979..0393ca1b4416 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -59,7 +59,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
 #ifdef CONFIG_MMU
-	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
+	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | satp_mode);
 	local_flush_tlb_all();
 #endif
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 694efcc3a131..cb23a30d9af3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -23,8 +23,23 @@
 
 #include "../kernel/head.h"
 
-unsigned long kernel_virt_addr = KERNEL_VIRT_ADDR;
+#ifdef CONFIG_64BIT
+u64 satp_mode = IS_ENABLED(CONFIG_MAXPHYSMEM_2GB) ?
+				SATP_MODE_39 : SATP_MODE_48;
+bool pgtable_l4_enabled = IS_ENABLED(CONFIG_MAXPHYSMEM_2GB) ? false : true;
+#else
+u64 satp_mode = SATP_MODE_32;
+bool pgtable_l4_enabled;
+#endif
+EXPORT_SYMBOL(pgtable_l4_enabled);
+EXPORT_SYMBOL(satp_mode);
+
+unsigned long kernel_virt_addr;
 EXPORT_SYMBOL(kernel_virt_addr);
+#ifdef CONFIG_64BIT
+unsigned long __page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
+EXPORT_SYMBOL(__page_offset);
+#endif
 
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
@@ -41,6 +56,8 @@ struct pt_alloc_ops {
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
 	phys_addr_t (*alloc_pmd)(uintptr_t va);
+	pud_t *(*get_pud_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pud)(uintptr_t va);
 #endif
 };
 
@@ -294,9 +311,13 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
+pud_t trampoline_pud[PTRS_PER_PUD] __page_aligned_bss;
 pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pud_t fixmap_pud[PTRS_PER_PUD] __page_aligned_bss;
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pud_t early_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
+pud_t early_dtb_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
@@ -318,7 +339,8 @@ static pmd_t *get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	BUG_ON((va - kernel_virt_addr) >> PGDIR_SHIFT);
+	/* Only one PMD is available for early mapping */
+	BUG_ON((va - kernel_virt_addr) >> PUD_SHIFT);
 
 	return (uintptr_t)early_pmd;
 }
@@ -364,20 +386,90 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 	create_pte_mapping(ptep, va, pa, sz, prot);
 }
 
-#define pgd_next_t		pmd_t
-#define alloc_pgd_next(__va)	pt_ops.alloc_pmd(__va)
-#define get_pgd_next_virt(__pa)	pt_ops.get_pmd_virt(__pa)
+static pud_t *__init get_pud_virt_early(phys_addr_t pa)
+{
+    return (pud_t *)((uintptr_t)pa);
+}
+
+static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PUD);
+	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
+}
+
+static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+{
+    return (pud_t *)__va(pa);
+}
+
+static phys_addr_t __init alloc_pud_early(uintptr_t va)
+{
+	/* Only one PUD is available for early mapping */
+	BUG_ON((va - kernel_virt_addr) >> PGDIR_SHIFT);
+
+	return (uintptr_t)early_pud;
+}
+
+static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
+{
+	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+static phys_addr_t alloc_pud_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	BUG_ON(!vaddr);
+	return __pa(vaddr);
+}
+
+static void __init create_pud_mapping(pud_t *pudp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot)
+{
+	pmd_t *nextp;
+	phys_addr_t next_phys;
+	uintptr_t pud_index = pud_index(va);
+
+	if (sz == PUD_SIZE) {
+		if (pud_val(pudp[pud_index]) == 0)
+			pudp[pud_index] = pfn_pud(PFN_DOWN(pa), prot);
+		return;
+	}
+
+	if (pud_val(pudp[pud_index]) == 0) {
+		next_phys = pt_ops.alloc_pmd(va);
+		pudp[pud_index] = pfn_pud(PFN_DOWN(next_phys), PAGE_TABLE);
+		nextp = pt_ops.get_pmd_virt(next_phys);
+		memset(nextp, 0, PAGE_SIZE);
+	} else {
+		next_phys = PFN_PHYS(_pud_pfn(pudp[pud_index]));
+		nextp = pt_ops.get_pmd_virt(next_phys);
+	}
+
+	create_pmd_mapping(nextp, va, pa, sz, prot);
+}
+
+#define pgd_next_t		pud_t
+#define alloc_pgd_next(__va)	pt_ops.alloc_pud(__va)
+#define get_pgd_next_virt(__pa)	pt_ops.get_pud_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
-	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
-#define fixmap_pgd_next		fixmap_pmd
+	create_pud_mapping(__nextp, __va, __pa, __sz, __prot)
+#define fixmap_pgd_next		(pgtable_l4_enabled ?			\
+			(uintptr_t)fixmap_pud : (uintptr_t)fixmap_pmd)
+#define trampoline_pgd_next	(pgtable_l4_enabled ?			\
+			(uintptr_t)trampoline_pud : (uintptr_t)trampoline_pmd)
+#define early_dtb_pgd_next	(pgtable_l4_enabled ?			\
+			(uintptr_t)early_dtb_pud : (uintptr_t)early_dtb_pmd)
 #else
 #define pgd_next_t		pte_t
 #define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
 #define get_pgd_next_virt(__pa)	pt_ops.get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
-#define fixmap_pgd_next		fixmap_pte
-#endif
+#define fixmap_pgd_next		((uintptr_t)fixmap_pte)
+#endif /* __PAGETABLE_PMD_FOLDED */
 
 void __init create_pgd_mapping(pgd_t *pgdp,
 				      uintptr_t va, phys_addr_t pa,
@@ -387,6 +479,13 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	phys_addr_t next_phys;
 	uintptr_t pgd_idx = pgd_index(va);
 
+#ifndef __PAGETABLE_PMD_FOLDED
+	if (!pgtable_l4_enabled) {
+		create_pud_mapping((pud_t *)pgdp, va, pa, sz, prot);
+		return;
+	}
+#endif
+
 	if (sz == PGDIR_SIZE) {
 		if (pgd_val(pgdp[pgd_idx]) == 0)
 			pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(pa), prot);
@@ -437,6 +536,48 @@ uintptr_t load_pa, load_sz;
 EXPORT_SYMBOL(load_pa);
 EXPORT_SYMBOL(load_sz);
 
+#if defined(CONFIG_64BIT) && !defined(CONFIG_MAXPHYSMEM_2GB)
+void disable_pgtable_l4(void)
+{
+	pgtable_l4_enabled = false;
+	__page_offset = PAGE_OFFSET_L3;
+	satp_mode = SATP_MODE_39;
+}
+
+/**
+ * There is a simple way to determine if 4-level is supported by the
+ * underlying hardware: establish 1:1 mapping in 4-level page table mode
+ * then read SATP to see if the configuration was taken into account
+ * meaning sv48 is supported.
+ */
+asmlinkage __init void set_satp_mode(uintptr_t load_pa)
+{
+	u64 identity_satp, hw_satp;
+
+	create_pgd_mapping(early_pg_dir, load_pa, (uintptr_t)early_pud,
+			   PGDIR_SIZE, PAGE_TABLE);
+	create_pud_mapping(early_pud, load_pa, (uintptr_t)early_pmd,
+			   PUD_SIZE, PAGE_TABLE);
+	create_pmd_mapping(early_pmd, load_pa, load_pa,
+			   PMD_SIZE, PAGE_KERNEL_EXEC);
+
+	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
+	local_flush_tlb_all();
+	csr_write(CSR_SATP, identity_satp);
+
+	hw_satp = csr_read(CSR_SATP);
+	csr_write(CSR_SATP, 0ULL);
+	local_flush_tlb_all();
+
+	if (hw_satp != identity_satp)
+		disable_pgtable_l4();
+
+	memset(early_pg_dir, 0, PAGE_SIZE);
+	memset(early_pud, 0, PAGE_SIZE);
+	memset(early_pmd, 0, PAGE_SIZE);
+}
+#endif
+
 static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
 {
 	uintptr_t va, end_va;
@@ -460,9 +601,23 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	load_sz = (uintptr_t)(&_end) - load_pa;
 	map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
 
+	pt_ops.alloc_pte = alloc_pte_early;
+	pt_ops.get_pte_virt = get_pte_virt_early;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_early;
+	pt_ops.get_pmd_virt = get_pmd_virt_early;
+    pt_ops.alloc_pud = alloc_pud_early;
+	pt_ops.get_pud_virt = get_pud_virt_early;
+#endif
+
+#if defined(CONFIG_64BIT) && !defined(CONFIG_MAXPHYSMEM_2GB)
+	set_satp_mode(load_pa);
+#endif
+
+	kernel_virt_addr = KERNEL_VIRT_ADDR;
+
 	va_pa_offset = PAGE_OFFSET - load_pa;
 	va_kernel_pa_offset = kernel_virt_addr - load_pa;
-
 	pfn_base = PFN_DOWN(load_pa);
 
 	/*
@@ -476,23 +631,24 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((load_pa % map_size) != 0);
 	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
 
-	pt_ops.alloc_pte = alloc_pte_early;
-	pt_ops.get_pte_virt = get_pte_virt_early;
-#ifndef __PAGETABLE_PMD_FOLDED
-	pt_ops.alloc_pmd = alloc_pmd_early;
-	pt_ops.get_pmd_virt = get_pmd_virt_early;
-#endif
 	/* Setup early PGD for fixmap */
 	create_pgd_mapping(early_pg_dir, FIXADDR_START,
-			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
+			   fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	/* Setup fixmap PMD */
+	/* Setup fixmap PUD and PMD */
+	if (pgtable_l4_enabled)
+		create_pud_mapping(fixmap_pud, FIXADDR_START,
+			   (uintptr_t)fixmap_pmd, PUD_SIZE, PAGE_TABLE);
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
 			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
+
 	/* Setup trampoline PGD and PMD */
 	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
-			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
+			   trampoline_pgd_next, PGDIR_SIZE, PAGE_TABLE);
+	if (pgtable_l4_enabled)
+		create_pud_mapping(trampoline_pud, kernel_virt_addr,
+			   (uintptr_t)trampoline_pmd, PUD_SIZE, PAGE_TABLE);
 	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
 			   load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
 #else
@@ -509,9 +665,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_kernel_page_table(early_pg_dir, map_size);
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	/* Setup early PMD for DTB */
+	/* Setup early PUD and PMD for DTB */
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
+			   (uintptr_t)early_dtb_pgd_next, PGDIR_SIZE, PAGE_TABLE);
+	if (pgtable_l4_enabled)
+		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
+			   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
 	/* Create two consecutive PMD mappings for FDT early scan */
 	pa = dtb_pa & ~(PMD_SIZE - 1);
 	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
@@ -534,7 +693,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
 	 * range can not span multiple pmds.
 	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+	BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -577,6 +736,8 @@ static void __init setup_vm_final(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_fixmap;
 	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
+	pt_ops.alloc_pud = alloc_pud_fixmap;
+	pt_ops.get_pud_virt = get_pud_virt_fixmap;
 #endif
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
@@ -619,12 +780,13 @@ static void __init setup_vm_final(void)
 
 	vm_area_add_early(&vm_kernel);
 
-	/* Clear fixmap PTE and PMD mappings */
+	/* Clear fixmap page table mappings */
 	clear_fixmap(FIX_PTE);
 	clear_fixmap(FIX_PMD);
+	clear_fixmap(FIX_PUD);
 
 	/* Move to swapper page table */
-	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
+	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 
 	/* generic page allocation functions must be used to setup page table */
@@ -633,6 +795,8 @@ static void __init setup_vm_final(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_late;
 	pt_ops.get_pmd_virt = get_pmd_virt_late;
+	pt_ops.alloc_pud = alloc_pud_late;
+	pt_ops.get_pud_virt = get_pud_virt_late;
 #endif
 }
 #else
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 914a343c7785..f7e3405bceb8 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -41,7 +41,7 @@
 #ifdef CONFIG_ARM64
 # define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
 #else
-# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
+# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_MIN
 #endif
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
-- 
2.20.1

