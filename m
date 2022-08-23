Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B659CF1D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 05:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiHWDGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 23:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiHWDGT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 23:06:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F42CC93;
        Mon, 22 Aug 2022 20:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8558CE188A;
        Tue, 23 Aug 2022 03:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE77C433D6;
        Tue, 23 Aug 2022 03:03:32 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] LoongArch: Use TLB for ioremap()
Date:   Tue, 23 Aug 2022 11:03:19 +0800
Message-Id: <20220823030319.3872957-1-chenhuacai@loongson.cn>
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

We can support more cache attributes (e.g., CC, SUC and WUC) and page
protection when we use TLB for ioremap(). The implementation is based
on GENERIC_IOREMAP.

The existing simple ioremap() implementation has better performance so
we keep it and introduce ARCH_IOREMAP to control the selection.

We move pagetable_init() earlier to make early ioremap() works, and we
modify the PCI ecam mapping because the TLB-based version of ioremap()
will actually take the size into account.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Based on GENERIC_IOREMAP.

 arch/loongarch/Kconfig                    |  7 +++
 arch/loongarch/include/asm/fixmap.h       | 15 +++++
 arch/loongarch/include/asm/io.h           | 69 ++++++--------------
 arch/loongarch/include/asm/pgtable-bits.h |  3 +
 arch/loongarch/kernel/setup.c             |  2 +-
 arch/loongarch/mm/init.c                  | 64 +++++++++++++++++++
 arch/loongarch/pci/acpi.c                 | 76 +++++++++++++++++++++--
 7 files changed, 180 insertions(+), 56 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3594f0ba7581..5b89386d6972 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -61,6 +61,7 @@ config LOONGARCH
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IOREMAP if !ARCH_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -168,6 +169,9 @@ config MACH_LOONGSON32
 config MACH_LOONGSON64
 	def_bool 64BIT
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 config PAGE_SIZE_4KB
 	bool
 
@@ -421,6 +425,9 @@ config SECCOMP
 
 endmenu
 
+config ARCH_IOREMAP
+	bool
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
diff --git a/arch/loongarch/include/asm/fixmap.h b/arch/loongarch/include/asm/fixmap.h
index b3541dfa2013..d2e55ae55bb9 100644
--- a/arch/loongarch/include/asm/fixmap.h
+++ b/arch/loongarch/include/asm/fixmap.h
@@ -10,4 +10,19 @@
 
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
index 999944ea1cea..87a88eb792c1 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -27,71 +27,38 @@ extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 #define early_memremap early_ioremap
 #define early_memunmap early_iounmap
 
+#ifdef CONFIG_ARCH_IOREMAP
+
 static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 					 unsigned long prot_val)
 {
-	if (prot_val == _CACHE_CC)
+	if (prot_val & _CACHE_CC)
 		return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
 	else
 		return (void __iomem *)(unsigned long)(UNCACHE_BASE + offset);
 }
 
-/*
- * ioremap -   map bus memory into CPU space
- * @offset:    bus address of the memory
- * @size:      size of the resource to map
- *
- * ioremap performs a platform specific sequence of operations to
- * make bus memory CPU accessible via the readb/readw/readl/writeb/
- * writew/writel functions and the other mmio helpers. The returned
- * address is not guaranteed to be usable directly as a virtual
- * address.
- */
-#define ioremap(offset, size)					\
-	ioremap_prot((offset), (size), _CACHE_SUC)
+#define ioremap(offset, size)		\
+	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_SUC))
 
-/*
- * ioremap_wc - map bus memory into CPU space
- * @offset:     bus address of the memory
- * @size:       size of the resource to map
- *
- * ioremap_wc performs a platform specific sequence of operations to
- * make bus memory CPU accessible via the readb/readw/readl/writeb/
- * writew/writel functions and the other mmio helpers. The returned
- * address is not guaranteed to be usable directly as a virtual
- * address.
- *
- * This version of ioremap ensures that the memory is marked uncachable
- * but accelerated by means of write-combining feature. It is specifically
- * useful for PCIe prefetchable windows, which may vastly improve a
- * communications performance. If it was determined on boot stage, what
- * CPU CCA doesn't support WUC, the method shall fall-back to the
- * _CACHE_SUC option (see cpu_probe() method).
- */
-#define ioremap_wc(offset, size)				\
-	ioremap_prot((offset), (size), _CACHE_WUC)
+#define iounmap(addr) 			do { } while (0)
+
+#endif
 
 /*
- * ioremap_cache -  map bus memory into CPU space
- * @offset:	    bus address of the memory
- * @size:	    size of the resource to map
- *
- * ioremap_cache performs a platform specific sequence of operations to
- * make bus memory CPU accessible via the readb/readw/readl/writeb/
- * writew/writel functions and the other mmio helpers. The returned
- * address is not guaranteed to be usable directly as a virtual
- * address.
+ * On LoongArch, ioremap() has two variants, ioremap_wc() and ioremap_cache().
+ * They map bus memory into CPU space, the mapped memory is marked uncachable
+ * (_CACHE_SUC), uncachable but accelerated by write-combine (_CACHE_WUC) and
+ * cachable (_CACHE_CC) respectively for CPU access.
  *
- * This version of ioremap ensures that the memory is marked cachable by
- * the CPU.  Also enables full write-combining.	 Useful for some
- * memory-like regions on I/O busses.
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
  */
-#define ioremap_cache(offset, size)				\
-	ioremap_prot((offset), (size), _CACHE_CC)
+#define ioremap_wc(offset, size)	\
+	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_WUC))
 
-static inline void iounmap(const volatile void __iomem *addr)
-{
-}
+#define ioremap_cache(offset, size)	\
+	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
 
 #define mmiowb() asm volatile ("dbar 0" ::: "memory")
 
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 9ca147a29bab..3d1e0a69975a 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -83,8 +83,11 @@
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_SUC)
 #define PAGE_KERNEL_WUC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_WUC)
+
 #ifndef __ASSEMBLY__
 
+#define _PAGE_IOREMAP		pgprot_val(PAGE_KERNEL_SUC)
+
 #define pgprot_noncached pgprot_noncached
 
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 2b4e98170bc1..f938aae3e92c 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -349,10 +349,10 @@ void __init setup_arch(char **cmdline_p)
 
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

