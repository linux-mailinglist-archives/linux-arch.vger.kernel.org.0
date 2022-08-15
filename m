Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2095592F29
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiHOMqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiHOMqV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 08:46:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D86E0E2;
        Mon, 15 Aug 2022 05:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14309B80E34;
        Mon, 15 Aug 2022 12:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4425EC433D6;
        Mon, 15 Aug 2022 12:46:14 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Use TLB for ioremap()
Date:   Mon, 15 Aug 2022 20:46:12 +0800
Message-Id: <20220815124612.3328670-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We can support more cache attributes (CC, SUC and WUC) and page
protection when we use TLB for ioremap().

We move pagetable_init() earlier to make early ioremap() works, and we
modify the PCI ecam mapping because the new ioremap() actually takes the
size into account.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig              |  7 +++
 arch/loongarch/include/asm/fixmap.h | 17 ++++++
 arch/loongarch/include/asm/io.h     | 27 ++++-----
 arch/loongarch/kernel/setup.c       |  2 +-
 arch/loongarch/mm/init.c            | 64 ++++++++++++++++++++
 arch/loongarch/mm/ioremap.c         | 93 ++++++++++++++++++++++++++++-
 arch/loongarch/pci/acpi.c           | 76 +++++++++++++++++++++--
 7 files changed, 263 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index be04968fe403..24665808cf3d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -99,6 +99,7 @@ config LOONGARCH
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
+	select IOREMAP_WITH_TLB
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select MMU_GATHER_MERGE_VMAS if MMU
@@ -167,6 +168,9 @@ config MACH_LOONGSON32
 config MACH_LOONGSON64
 	def_bool 64BIT
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 config PAGE_SIZE_4KB
 	bool
 
@@ -411,6 +415,9 @@ config SECCOMP
 
 endmenu
 
+config IOREMAP_WITH_TLB
+	bool
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
diff --git a/arch/loongarch/include/asm/fixmap.h b/arch/loongarch/include/asm/fixmap.h
index b3541dfa2013..5adf0da48425 100644
--- a/arch/loongarch/include/asm/fixmap.h
+++ b/arch/loongarch/include/asm/fixmap.h
@@ -8,6 +8,23 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
+#include <asm/pgtable.h>
+
 #define NR_FIX_BTMAPS 64
 
+enum fixed_addresses {
+	FIX_HOLE,
+	FIX_EARLYCON_MEM_BASE,
+	__end_of_fixed_addresses
+};
+
+#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXMAP_PAGE_IO	PAGE_KERNEL_SUC
+
+extern void __set_fixmap(enum fixed_addresses idx,
+			 phys_addr_t phys, pgprot_t flags);
+
+#include <asm-generic/fixmap.h>
+
 #endif
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 884599739b36..a965721ba10b 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -46,14 +46,8 @@ extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 #define early_memremap early_ioremap
 #define early_memunmap early_iounmap
 
-static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-					 unsigned long prot_val)
-{
-	if (prot_val == _CACHE_CC)
-		return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
-	else
-		return (void __iomem *)(unsigned long)(UNCACHE_BASE + offset);
-}
+#define ioremap_prot ioremap_prot
+extern void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 
 /*
  * ioremap -   map bus memory into CPU space
@@ -66,8 +60,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * address is not guaranteed to be usable directly as a virtual
  * address.
  */
-#define ioremap(offset, size)					\
-	ioremap_prot((offset), (size), _CACHE_SUC)
+#define ioremap ioremap
+extern void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
 
 /*
  * ioremap_wc - map bus memory into CPU space
@@ -87,8 +81,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * CPU CCA doesn't support WUC, the method shall fall-back to the
  * _CACHE_SUC option (see cpu_probe() method).
  */
-#define ioremap_wc(offset, size)				\
-	ioremap_prot((offset), (size), _CACHE_WUC)
+#define ioremap_wc ioremap_wc
+extern void __iomem *ioremap_wc(phys_addr_t phys_addr, size_t size);
 
 /*
  * ioremap_cache -  map bus memory into CPU space
@@ -105,12 +99,11 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * the CPU.  Also enables full write-combining.	 Useful for some
  * memory-like regions on I/O busses.
  */
-#define ioremap_cache(offset, size)				\
-	ioremap_prot((offset), (size), _CACHE_CC)
+#define ioremap_cache ioremap_cache
+extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
-static inline void iounmap(const volatile void __iomem *addr)
-{
-}
+#define iounmap iounmap
+extern void iounmap(const volatile void __iomem *addr);
 
 #define mmiowb() asm volatile ("dbar 0" ::: "memory")
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 8f5c2f9a1a83..23ee293e1cd2 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -357,10 +357,10 @@ void __init setup_arch(char **cmdline_p)
 
 	init_environ();
 	memblock_init();
+	pagetable_init();
 	parse_early_param();
 
 	platform_init();
-	pagetable_init();
 	arch_mem_init(cmdline_p);
 
 	resource_init();
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 88c935344034..63e19b7a6644 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -201,6 +201,70 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #endif
 #endif
 
+static pte_t *fixmap_pte(unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset_k(addr);
+	p4d = p4d_offset(pgd, addr);
+
+	if (pgd_none(*pgd)) {
+		pud_t *new;
+
+		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+		pgd_populate(&init_mm, pgd, new);
+#ifndef __PAGETABLE_PUD_FOLDED
+		pud_init(new);
+#endif
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new;
+
+		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+		pud_populate(&init_mm, pud, new);
+#ifndef __PAGETABLE_PMD_FOLDED
+		pmd_init(new);
+#endif
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pte_t *new;
+
+		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+		pmd_populate_kernel(&init_mm, pmd, new);
+	}
+
+	return pte_offset_kernel(pmd, addr);
+}
+
+void __init __set_fixmap(enum fixed_addresses idx,
+			       phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *ptep;
+
+	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
+
+	ptep = fixmap_pte(addr);
+	if (!pte_none(*ptep)) {
+		pte_ERROR(*ptep);
+		return;
+	}
+
+	if (pgprot_val(flags))
+		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
+	else {
+		pte_clear(&init_mm, addr, ptep);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	}
+}
+
 /*
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
  * with a single LUI instruction in the TLB handlers.  If we used
diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
index 73b0980ab6f5..8d698d725dbb 100644
--- a/arch/loongarch/mm/ioremap.c
+++ b/arch/loongarch/mm/ioremap.c
@@ -3,7 +3,9 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
 
 void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size)
 {
@@ -25,3 +27,92 @@ void *early_memremap_prot(resource_size_t phys_addr, unsigned long size,
 {
 	return early_memremap(phys_addr, size);
 }
+
+#ifdef CONFIG_IOREMAP_WITH_TLB
+static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
+				      pgprot_t prot, void *caller)
+{
+	unsigned long last_addr;
+	unsigned long offset = phys_addr & ~PAGE_MASK;
+	int err;
+	unsigned long addr;
+	struct vm_struct *area;
+
+	/*
+	 * Page align the mapping address and size, taking account of any
+	 * offset.
+	 */
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(size + offset);
+
+	/*
+	 * Don't allow wraparound, zero size or outside PHYS_MASK.
+	 */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	area = get_vm_area_caller(size, VM_IOREMAP, caller);
+	if (!area)
+		return NULL;
+	addr = (unsigned long)area->addr;
+	area->phys_addr = phys_addr;
+
+	err = ioremap_page_range(addr, addr + size, phys_addr, prot);
+	if (err) {
+		vunmap((void *)addr);
+		return NULL;
+	}
+
+	return (void __iomem *)(offset + addr);
+}
+#else
+static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
+				      pgprot_t prot, void *caller)
+{
+	if (pgprot_val(prot) & _CACHE_CC)
+		return (void __iomem *)(unsigned long)(CACHE_BASE + phys_addr);
+	else
+		return (void __iomem *)(unsigned long)(UNCACHE_BASE + phys_addr);
+}
+#endif
+
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size)
+{
+	return __ioremap_caller(phys_addr, size, PAGE_KERNEL_SUC, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem *ioremap_wc(phys_addr_t phys_addr, size_t size)
+{
+	return __ioremap_caller(phys_addr, size, PAGE_KERNEL_WUC, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
+{
+	return __ioremap_caller(phys_addr, size, PAGE_KERNEL, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_cache);
+
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)
+{
+	return __ioremap_caller(phys_addr, size, __pgprot(prot), __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_prot);
+
+void iounmap(const volatile void __iomem *io_addr)
+{
+#ifdef CONFIG_IOREMAP_WITH_TLB
+	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
+
+	/*
+	 * We could get an address outside vmalloc range in case
+	 * of ioremap_cache() reusing a RAM mapping.
+	 */
+	if (is_vmalloc_addr((void *)addr))
+		vunmap((void *)addr);
+#endif
+}
+
+EXPORT_SYMBOL(iounmap);
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index bf921487333c..ac18ca7a900a 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -82,6 +82,69 @@ static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 	return 0;
 }
 
+/*
+ * Create a PCI config space window
+ *  - reserve mem region
+ *  - alloc struct pci_config_window with space for all mappings
+ *  - ioremap the config space
+ */
+struct pci_config_window *arch_pci_ecam_create(struct device *dev,
+		struct resource *cfgres, struct resource *busr, const struct pci_ecam_ops *ops)
+{
+	int bsz, bus_range, err;
+	struct resource *conflict;
+	struct pci_config_window *cfg;
+
+	if (busr->start > busr->end)
+		return ERR_PTR(-EINVAL);
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	cfg->parent = dev;
+	cfg->ops = ops;
+	cfg->busr.start = busr->start;
+	cfg->busr.end = busr->end;
+	cfg->busr.flags = IORESOURCE_BUS;
+	bus_range = resource_size(cfgres) >> ops->bus_shift;
+
+	bsz = 1 << ops->bus_shift;
+
+	cfg->res.start = cfgres->start;
+	cfg->res.end = cfgres->end;
+	cfg->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	cfg->res.name = "PCI ECAM";
+
+	conflict = request_resource_conflict(&iomem_resource, &cfg->res);
+	if (conflict) {
+		err = -EBUSY;
+		dev_err(dev, "can't claim ECAM area %pR: address conflict with %s %pR\n",
+			&cfg->res, conflict->name, conflict);
+		goto err_exit;
+	}
+
+	cfg->win = pci_remap_cfgspace(cfgres->start, bus_range * bsz);
+	if (!cfg->win)
+		goto err_exit_iomap;
+
+	if (ops->init) {
+		err = ops->init(cfg);
+		if (err)
+			goto err_exit;
+	}
+	dev_info(dev, "ECAM at %pR for %pR\n", &cfg->res, &cfg->busr);
+
+	return cfg;
+
+err_exit_iomap:
+	err = -ENOMEM;
+	dev_err(dev, "ECAM ioremap failed\n");
+err_exit:
+	pci_ecam_free(cfg);
+	return ERR_PTR(err);
+}
+
 /*
  * Lookup the bus range for the domain in MCFG, and set up config space
  * mapping.
@@ -106,11 +169,16 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 
 	bus_shift = ecam_ops->bus_shift ? : 20;
 
-	cfgres.start = root->mcfg_addr + (bus_res->start << bus_shift);
-	cfgres.end = cfgres.start + (resource_size(bus_res) << bus_shift) - 1;
-	cfgres.flags = IORESOURCE_MEM;
+	if (bus_shift == 20)
+		cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	else {
+		cfgres.start = root->mcfg_addr + (bus_res->start << bus_shift);
+		cfgres.end = cfgres.start + (resource_size(bus_res) << bus_shift) - 1;
+		cfgres.end |= BIT(28) + (((PCI_CFG_SPACE_EXP_SIZE - 1) & 0xf00) << 16);
+		cfgres.flags = IORESOURCE_MEM;
+		cfg = arch_pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	}
 
-	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
 	if (IS_ERR(cfg)) {
 		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res, PTR_ERR(cfg));
 		return NULL;
-- 
2.31.1

