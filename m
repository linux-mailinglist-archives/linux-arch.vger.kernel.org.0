Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A663BC533
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGFEVL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEVL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44AD861973;
        Tue,  6 Jul 2021 04:18:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 05/19] LoongArch: Add boot and setup routines
Date:   Tue,  6 Jul 2021 12:18:06 +0800
Message-Id: <20210706041820.1536502-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds basic boot, setup and reset routines for LoongArch.
LoongArch uses UEFI-based firmware and uses ACPI as the boot protocol.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/acpi.c      | 325 +++++++++++++++++++++++
 arch/loongarch/kernel/cacheinfo.c | 126 +++++++++
 arch/loongarch/kernel/cmdline.c   |  28 ++
 arch/loongarch/kernel/cpu-probe.c | 302 +++++++++++++++++++++
 arch/loongarch/kernel/efi.c       |  68 +++++
 arch/loongarch/kernel/head.S      |  67 +++++
 arch/loongarch/kernel/reset.c     |  51 ++++
 arch/loongarch/kernel/setup.c     | 428 ++++++++++++++++++++++++++++++
 arch/loongarch/kernel/time.c      | 227 ++++++++++++++++
 arch/loongarch/kernel/topology.c  |  13 +
 10 files changed, 1635 insertions(+)
 create mode 100644 arch/loongarch/kernel/acpi.c
 create mode 100644 arch/loongarch/kernel/cacheinfo.c
 create mode 100644 arch/loongarch/kernel/cmdline.c
 create mode 100644 arch/loongarch/kernel/cpu-probe.c
 create mode 100644 arch/loongarch/kernel/efi.c
 create mode 100644 arch/loongarch/kernel/head.S
 create mode 100644 arch/loongarch/kernel/reset.c
 create mode 100644 arch/loongarch/kernel/setup.c
 create mode 100644 arch/loongarch/kernel/time.c
 create mode 100644 arch/loongarch/kernel/topology.c

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
new file mode 100644
index 000000000000..632a2da2130c
--- /dev/null
+++ b/arch/loongarch/kernel/acpi.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * acpi.c - Architecture-Specific Low-Level ACPI Boot Support
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/memblock.h>
+#include <asm/io.h>
+#include <loongson.h>
+
+int acpi_disabled;
+EXPORT_SYMBOL(acpi_disabled);
+int acpi_noirq;
+int acpi_pci_disabled;
+EXPORT_SYMBOL(acpi_pci_disabled);
+int acpi_strict = 1; /* We have no workarounds on LoongArch */
+int num_processors;
+int disabled_cpus;
+enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+
+u64 acpi_saved_sp;
+
+#define MAX_CORE_PIC 256
+
+#define PREFIX			"ACPI: "
+
+/*
+ * Following __acpi_xx functions should be implemented for sepecific cpu.
+ */
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
+{
+	if (irqp != NULL)
+		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
+
+int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
+{
+	if (gsi)
+		*gsi = isa_irq;
+	return 0;
+}
+
+/*
+ * success: return IRQ number (>=0)
+ * failure: return < 0
+ */
+int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
+{
+	int id;
+	struct irq_fwspec fwspec;
+	struct fwnode_handle *handle;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		fwspec.fwnode = acpi_liointc_handle;
+		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
+		fwspec.param_count = 1;
+
+		return irq_create_fwspec_mapping(&fwspec);
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id < 0)
+			return -1;
+
+		handle = acpi_picdomain_handle[id];
+		if (handle) {
+			fwspec.fwnode = handle;
+			fwspec.param[0] = gsi - GSI_MIN_PCH_IRQ;
+			fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+			fwspec.param_count = 2;
+
+			return irq_create_fwspec_mapping(&fwspec);
+		}
+
+		return gsi;
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+void __iomem *__init __acpi_map_table(unsigned long phys, unsigned long size)
+{
+
+	if (!phys || !size)
+		return NULL;
+
+	return early_memremap(phys, size);
+}
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
+
+	early_memunmap(map, size);
+}
+
+void __init acpi_boot_table_init(void)
+{
+	/*
+	 * If acpi_disabled, bail out
+	 */
+	if (acpi_disabled)
+		return;
+
+	/*
+	 * Initialize the ACPI boot-time table parser.
+	 */
+	if (acpi_table_init()) {
+		disable_acpi();
+		return;
+	}
+}
+
+static int __init
+acpi_parse_cpuintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_core_pic *processor = NULL;
+
+	processor = (struct acpi_madt_core_pic *)header;
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	return 0;
+}
+
+static int __init
+acpi_parse_liointc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_lio_pic *liointc = NULL;
+
+	liointc = (struct acpi_madt_lio_pic *)header;
+
+	if (BAD_MADT_ENTRY(liointc, end))
+		return -EINVAL;
+
+	acpi_liointc = liointc;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_eiointc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_eio_pic *eiointc = NULL;
+
+	eiointc = (struct acpi_madt_eio_pic *)header;
+
+	if (BAD_MADT_ENTRY(eiointc, end))
+		return -EINVAL;
+
+	acpi_eiointc = eiointc;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_htintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc = NULL;
+
+	htintc = (struct acpi_madt_ht_pic *)header;
+
+	if (BAD_MADT_ENTRY(htintc, end))
+		return -EINVAL;
+
+	acpi_htintc = htintc;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_lpc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_lpc_pic *pchlpc = NULL;
+
+	pchlpc = (struct acpi_madt_lpc_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchlpc, end))
+		return -EINVAL;
+
+	acpi_pchlpc = pchlpc;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_msi(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi = NULL;
+
+	pchmsi = (struct acpi_madt_msi_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchmsi, end))
+		return -EINVAL;
+
+	acpi_pchmsi = pchmsi;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_pic(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic = NULL;
+
+	pchpic = (struct acpi_madt_bio_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchpic, end))
+		return -EINVAL;
+
+	acpi_pchpic[loongson_sysconf.nr_pch_pics] = pchpic;
+	loongson_sysconf.nr_pch_pics++;
+
+	return 0;
+}
+
+static void __init acpi_process_madt(void)
+{
+	int error;
+
+	/* Parse MADT CPUINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC, acpi_parse_cpuintc, MAX_CORE_PIC);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (CPUINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	loongson_sysconf.nr_cpus = num_processors;
+
+	/* Parse MADT LIOINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, acpi_parse_liointc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (LIOINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT EIOINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, acpi_parse_eiointc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (EIOINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT HTVEC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC, acpi_parse_htintc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (HTVEC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHLPC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, acpi_parse_pch_lpc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHLPC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHMSI entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, acpi_parse_pch_msi, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHMSI entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHPIC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, acpi_parse_pch_pic, MAX_PCH_PICS);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHPIC entries), ACPI disabled\n");
+		return;
+	}
+}
+
+int __init acpi_boot_init(void)
+{
+	/*
+	 * If acpi_disabled, bail out
+	 */
+	if (acpi_disabled)
+		return -1;
+
+	loongson_sysconf.boot_cpu_id = read_csr_cpuid();
+
+	/*
+	 * Process the Multiple APIC Description Table (MADT), if present
+	 */
+	acpi_process_madt();
+
+	return 0;
+}
+
+void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
+{
+	u8 map_count = loongson_mem_map->map_count;
+
+	loongson_mem_map->map[map_count].mem_start = addr;
+	loongson_mem_map->map[map_count].mem_size = size;
+	loongson_mem_map->map[map_count].mem_type = ADDRESS_TYPE_ACPI;
+	loongson_mem_map->map_count++;
+}
diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
new file mode 100644
index 000000000000..399e2f5fa6fc
--- /dev/null
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch cacheinfo support
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/cacheinfo.h>
+#include <linux/of.h>
+
+/* Populates leaf and increments to next leaf */
+#define populate_cache(cache, leaf, c_level, c_type)		\
+do {								\
+	leaf->type = c_type;					\
+	leaf->level = c_level;					\
+	leaf->coherency_line_size = c->cache.linesz;		\
+	leaf->number_of_sets = c->cache.sets;			\
+	leaf->ways_of_associativity = c->cache.ways;		\
+	leaf->size = c->cache.linesz * c->cache.sets *		\
+		c->cache.ways;					\
+	leaf++;							\
+} while (0)
+
+static int __init_cache_level(unsigned int cpu)
+{
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	int levels = 0, leaves = 0;
+
+	/*
+	 * If Dcache is not set, we assume the cache structures
+	 * are not properly initialized.
+	 */
+	if (c->dcache.waysize)
+		levels += 1;
+	else
+		return -ENOENT;
+
+
+	leaves += (c->icache.waysize) ? 2 : 1;
+
+	if (c->vcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->scache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->tcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+	return 0;
+}
+
+static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
+					   struct cacheinfo *sib_leaf)
+{
+	return !((this_leaf->level == 1) || (this_leaf->level == 2));
+}
+
+static void __cache_cpumap_setup(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf, *sib_leaf;
+	unsigned int index;
+
+	for (index = 0; index < this_cpu_ci->num_leaves; index++) {
+		unsigned int i;
+
+		this_leaf = this_cpu_ci->info_list + index;
+		/* skip if shared_cpu_map is already populated */
+		if (!cpumask_empty(&this_leaf->shared_cpu_map))
+			continue;
+
+		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
+		for_each_online_cpu(i) {
+			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
+
+			if (i == cpu || !sib_cpu_ci->info_list)
+				continue;/* skip if itself or no cacheinfo */
+			sib_leaf = sib_cpu_ci->info_list + index;
+			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
+				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
+			}
+		}
+	}
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	int level = 1;
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	if (c->icache.waysize) {
+		populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA);
+		populate_cache(icache, this_leaf, level++, CACHE_TYPE_INST);
+	} else {
+		populate_cache(dcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+	}
+
+	if (c->vcache.waysize)
+		populate_cache(vcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	if (c->scache.waysize)
+		populate_cache(scache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	if (c->tcache.waysize)
+		populate_cache(tcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	__cache_cpumap_setup(cpu);
+	this_cpu_ci->cpu_map_populated = true;
+
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/loongarch/kernel/cmdline.c b/arch/loongarch/kernel/cmdline.c
new file mode 100644
index 000000000000..46bf4486b54c
--- /dev/null
+++ b/arch/loongarch/kernel/cmdline.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/fw.h>
+
+int fw_argc;
+long *_fw_argv, *_fw_envp;
+
+void __init fw_init_cmdline(void)
+{
+	int i;
+
+	fw_argc = fw_arg0;
+	_fw_argv = (long *)fw_arg1;
+	_fw_envp = (long *)fw_arg2;
+
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < fw_argc; i++) {
+		strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
+		if (i < (fw_argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+	}
+}
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
new file mode 100644
index 000000000000..400c7d1ba67e
--- /dev/null
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Processor capabilities determination functions.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+#include <linux/export.h>
+#include <linux/printk.h>
+#include <linux/uaccess.h>
+
+#include <asm/cpu.h>
+#include <asm/cpu-features.h>
+#include <asm/fpu.h>
+#include <asm/loongarchregs.h>
+#include <asm/elf.h>
+#include <asm/pgtable-bits.h>
+
+/* Hardware capabilities */
+unsigned int elf_hwcap __read_mostly;
+EXPORT_SYMBOL_GPL(elf_hwcap);
+
+/*
+ * Determine the FCSR mask for FPU hardware.
+ */
+static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_loongarch *c)
+{
+	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
+
+	fcsr = c->fpu_csr0;
+	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
+
+	sr = read_csr_euen();
+	enable_fpu();
+
+	fcsr0 = fcsr & mask;
+	write_fcsr(LOONGARCH_FCSR0, fcsr0);
+	fcsr0 = read_fcsr(LOONGARCH_FCSR0);
+
+	fcsr1 = fcsr | ~mask;
+	write_fcsr(LOONGARCH_FCSR0, fcsr1);
+	fcsr1 = read_fcsr(LOONGARCH_FCSR0);
+
+	write_fcsr(LOONGARCH_FCSR0, fcsr);
+
+	write_csr_euen(sr);
+
+	c->fpu_mask = ~(fcsr0 ^ fcsr1) & ~mask;
+}
+
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu == 0)
+		__elf_platform = plat;
+}
+
+/* MAP BASE */
+unsigned long vm_map_base;
+EXPORT_SYMBOL_GPL(vm_map_base);
+
+void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
+{
+#ifdef __NEED_ADDRBITS_PROBE
+	c->pabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_PABITS) >> 4;
+	c->vabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_VABITS) >> 12;
+	vm_map_base = 0UL - (1UL << c->vabits);
+#endif
+}
+
+static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
+{
+	switch (isa) {
+	case LOONGARCH_CPU_ISA_LA64:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA64;
+		fallthrough;
+	case LOONGARCH_CPU_ISA_LA32S:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA32S;
+		fallthrough;
+	case LOONGARCH_CPU_ISA_LA32R:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA32R;
+		break;
+	}
+}
+
+static void decode_configs(struct cpuinfo_loongarch *c)
+{
+	unsigned int config;
+	unsigned long asid_mask;
+
+	config = read_cpucfg(LOONGARCH_CPUCFG1);
+	if (config & CPUCFG1_UAL) {
+		c->options |= LOONGARCH_CPU_UAL;
+		elf_hwcap |= HWCAP_LOONGARCH_UAL;
+	}
+
+	config = read_cpucfg(LOONGARCH_CPUCFG2);
+	if (config & CPUCFG2_LAM) {
+		c->options |= LOONGARCH_CPU_LAM;
+		elf_hwcap |= HWCAP_LOONGARCH_LAM;
+	}
+	if (config & CPUCFG2_FP) {
+		c->options |= LOONGARCH_CPU_FPU;
+		elf_hwcap |= HWCAP_LOONGARCH_FPU;
+	}
+	if (config & CPUCFG2_COMPLEX) {
+		c->options |= LOONGARCH_CPU_COMPLEX;
+		elf_hwcap |= HWCAP_LOONGARCH_COMPLEX;
+	}
+	if (config & CPUCFG2_CRYPTO) {
+		c->options |= LOONGARCH_CPU_CRYPTO;
+		elf_hwcap |= HWCAP_LOONGARCH_CRYPTO;
+	}
+	if (config & CPUCFG2_LVZP) {
+		c->options |= LOONGARCH_CPU_LVZ;
+		elf_hwcap |= HWCAP_LOONGARCH_LVZ;
+	}
+
+	config = read_cpucfg(LOONGARCH_CPUCFG6);
+	if (config & CPUCFG6_PMP)
+		c->options |= LOONGARCH_CPU_PMP;
+
+	config = iocsr_readl(LOONGARCH_IOCSR_FEATURES);
+	if (config & IOCSRF_CSRIPI)
+		c->options |= LOONGARCH_CPU_CSRIPI;
+	if (config & IOCSRF_EXTIOI)
+		c->options |= LOONGARCH_CPU_EXTIOI;
+	if (config & IOCSRF_FREQSCALE)
+		c->options |= LOONGARCH_CPU_SCALEFREQ;
+	if (config & IOCSRF_VM)
+		c->options |= LOONGARCH_CPU_HYPERVISOR;
+
+	config = csr_readl(LOONGARCH_CSR_ASID);
+	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
+	asid_mask = GENMASK(config - 1, 0);
+	set_cpu_asid_mask(c, asid_mask);
+
+	config = read_csr_prcfg1();
+	c->kscratch_mask = GENMASK((config & CSR_CONF1_KSNUM) - 1, 0);
+	c->kscratch_mask &= ~(EXC_KSCRATCH_MASK | PERCPU_KSCRATCH_MASK | KVM_KSCRATCH_MASK);
+
+	config = read_csr_prcfg3();
+	switch (config & CSR_CONF3_TLBTYPE) {
+	case 0:
+		c->tlbsizemtlb = 0;
+		c->tlbsizestlbsets = 0;
+		c->tlbsizestlbways = 0;
+		c->tlbsize = 0;
+		break;
+	case 1:
+		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		c->tlbsizestlbsets = 0;
+		c->tlbsizestlbways = 0;
+		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		break;
+	case 2:
+		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		c->tlbsizestlbsets = 1 << ((config & CSR_CONF3_STLBIDX) >> CSR_CONF3_STLBIDX_SHIFT);
+		c->tlbsizestlbways = ((config & CSR_CONF3_STLBWAYS) >> CSR_CONF3_STLBWAYS_SHIFT) + 1;
+		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		break;
+	default:
+		pr_warn("Warning: unimplemented tlb type\n");
+	}
+}
+
+#define MAX_NAME_LEN	32
+#define VENDOR_OFFSET	0
+#define CPUNAME_OFFSET	9
+
+static char cpu_full_name[MAX_NAME_LEN] = "        -        ";
+
+static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int cpu)
+{
+	uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
+	uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
+
+	c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR |
+		     LOONGARCH_CPU_TLB | LOONGARCH_CPU_VINT | LOONGARCH_CPU_WATCH;
+
+	decode_configs(c);
+	elf_hwcap |= HWCAP_LOONGARCH_CRC32;
+
+	__cpu_full_name[cpu] = cpu_full_name;
+	*vendor = iocsr_readq(LOONGARCH_IOCSR_VENDOR);
+	*cpuname = iocsr_readq(LOONGARCH_IOCSR_CPUNAME);
+
+	switch (c->processor_id & PRID_IMP_MASK) {
+	case PRID_IMP_LOONGSON_32:
+		c->cputype = CPU_LOONGSON32;
+		set_isa(c, LOONGARCH_CPU_ISA_LA32S);
+		c->writecombine = _CACHE_WUC;
+		__cpu_family[cpu] = "Loongson-32bit";
+		pr_info("Standard 32-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64R:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		c->writecombine = _CACHE_WUC;
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Reduced 64-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64C:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		c->writecombine = _CACHE_WUC;
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Classic 64-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64G:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		c->writecombine = _CACHE_WUC;
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Generic 64-bit Loongson Processor probed\n");
+		break;
+	default: /* Default to 64 bit */
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		c->writecombine = _CACHE_SUC;
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Unknown 64-bit Loongson Processor probed\n");
+	}
+}
+
+#ifdef CONFIG_64BIT
+/* For use by uaccess.h */
+u64 __ua_limit;
+EXPORT_SYMBOL(__ua_limit);
+#endif
+
+const char *__cpu_family[NR_CPUS];
+const char *__cpu_full_name[NR_CPUS];
+const char *__elf_platform;
+
+void cpu_probe(void)
+{
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+	unsigned int cpu = smp_processor_id();
+
+	/*
+	 * Set a default elf platform, cpu probe may later
+	 * overwrite it with a more precise value
+	 */
+	set_elf_platform(cpu, "loongarch");
+
+	c->cputype	= CPU_UNKNOWN;
+	c->processor_id = read_cpucfg(LOONGARCH_CPUCFG0);
+	c->fpu_vers	= (read_cpucfg(LOONGARCH_CPUCFG2) >> 3) & 0x3;
+	c->writecombine = _CACHE_SUC;
+
+	c->fpu_csr0	= FPU_CSR_RN;
+	c->fpu_mask	= FPU_CSR_RSVD;
+
+	switch (c->processor_id & PRID_COMP_MASK) {
+	case PRID_COMP_LOONGSON:
+		cpu_probe_loongson(c, cpu);
+		break;
+	}
+
+	BUG_ON(!__cpu_family[cpu]);
+	BUG_ON(c->cputype == CPU_UNKNOWN);
+
+	cpu_probe_addrbits(c);
+
+#ifdef CONFIG_64BIT
+	if (cpu == 0)
+		__ua_limit = ~((1ull << cpu_vabits) - 1);
+#endif
+}
+
+void cpu_report(void)
+{
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+
+	pr_info("CPU%d revision is: %08x (%s)\n",
+		smp_processor_id(), c->processor_id, cpu_family_string());
+	if (c->options & LOONGARCH_CPU_FPU)
+		pr_info("FPU%d revision is: %08x\n", smp_processor_id(), c->fpu_vers);
+}
+
+void cpu_set_cluster(struct cpuinfo_loongarch *cpuinfo, unsigned int cluster)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(cluster > (LOONGARCH_GLOBALNUMBER_CLUSTER >>
+			   LOONGARCH_GLOBALNUMBER_CLUSTER_SHF));
+
+	cpuinfo->globalnumber &= ~LOONGARCH_GLOBALNUMBER_CLUSTER;
+	cpuinfo->globalnumber |= cluster << LOONGARCH_GLOBALNUMBER_CLUSTER_SHF;
+}
+
+void cpu_set_core(struct cpuinfo_loongarch *cpuinfo, unsigned int core)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(core > (LOONGARCH_GLOBALNUMBER_CORE >> LOONGARCH_GLOBALNUMBER_CORE_SHF));
+
+	cpuinfo->globalnumber &= ~LOONGARCH_GLOBALNUMBER_CORE;
+	cpuinfo->globalnumber |= core << LOONGARCH_GLOBALNUMBER_CORE_SHF;
+}
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
new file mode 100644
index 000000000000..ed359c1d6976
--- /dev/null
+++ b/arch/loongarch/kernel/efi.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * EFI initialization
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
+#include <linux/efi-bgrt.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/memblock.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/time.h>
+#include <linux/io.h>
+#include <linux/reboot.h>
+#include <linux/bcd.h>
+
+#include <asm/efi.h>
+#include <boot_param.h>
+
+static efi_config_table_type_t arch_tables[] __initdata = {{},};
+
+void __init efi_runtime_init(void)
+{
+	if (!efi_enabled(EFI_BOOT))
+		return;
+
+	if (!efi.runtime)
+		return;
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return;
+	}
+
+	efi_native_runtime_setup();
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+}
+
+void __init efi_init(void)
+{
+	unsigned long efi_config_table;
+	efi_system_table_t *efi_systab;
+
+	if (!efi_bp)
+		return;
+
+	efi_systab = (efi_system_table_t *)efi_bp->systemtable;
+	if (!efi_systab) {
+		pr_err("Can't find EFI system table.\n");
+		return;
+	}
+
+	set_bit(EFI_64BIT, &efi.flags);
+	efi_config_table = (unsigned long)efi_systab->tables;
+	efi.runtime	 = (efi_runtime_services_t *)efi_systab->runtime;
+	efi.runtime_version = (unsigned int)efi_systab->runtime->hdr.revision;
+
+	efi_config_parse_tables((void *)efi_systab->tables, efi_systab->nr_tables, arch_tables);
+}
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
new file mode 100644
index 000000000000..0658db1ecb56
--- /dev/null
+++ b/arch/loongarch/kernel/head.S
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/threads.h>
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/irqflags.h>
+#include <asm/regdef.h>
+#include <asm/loongarchregs.h>
+#include <asm/stackframe.h>
+
+SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
+
+	__REF
+
+SYM_CODE_START(kernel_entry)			# kernel entry point
+
+	/* We might not get launched at the address the kernel is linked to,
+	   so we jump there.  */
+	la.abs		t0, 0f
+	jirl		zero, t0, 0
+0:
+	la		t0, __bss_start		# clear .bss
+	st.d		zero, t0, 0
+	la		t1, __bss_stop - LONGSIZE
+1:
+	addi.d		t0, t0, LONGSIZE
+	st.d		zero, t0, 0
+	bne		t0, t1, 1b
+
+	la		t0, fw_arg0
+	st.d		a0, t0, 0		# firmware arguments
+	la		t0, fw_arg1
+	st.d		a1, t0, 0
+	la		t0, fw_arg2
+	st.d		a2, t0, 0
+	la		t0, fw_arg3
+	st.d		a3, t0, 0
+
+	/* Config direct window and set PG */
+	li.d		t0, CSR_DMW0_INIT	# UC, PLV0, 0x8000 xxxx xxxx xxxx
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	li.d		t0, CSR_DMW1_INIT	# CA, PLV0, 0x9000 xxxx xxxx xxxx
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+	/* Enable PG */
+	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
+	csrwr		t0, LOONGARCH_CSR_CRMD
+
+	/* KScratch3 used for percpu base, initialized as 0 */
+	csrwr		zero, PERCPU_BASE_KS
+	/* GPR21 used for percpu base (runtime), initialized as 0 */
+	or		x0, zero, zero
+
+	la		tp, init_thread_union
+	/* Set the SP after an empty pt_regs.  */
+	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_ADDU	sp, sp, tp
+	set_saved_sp	sp, t0, t1
+	PTR_ADDIU	sp, sp, -4 * SZREG	# init stack pointer
+
+	b		start_kernel
+
+SYM_CODE_END(kernel_entry)
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
new file mode 100644
index 000000000000..cdbeeaa052b3
--- /dev/null
+++ b/arch/loongarch/kernel/reset.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/reboot.h>
+#include <linux/delay.h>
+#include <linux/console.h>
+
+#include <asm/compiler.h>
+#include <asm/idle.h>
+#include <asm/loongarchregs.h>
+#include <asm/reboot.h>
+
+static void machine_hang(void)
+{
+	local_irq_disable();
+	clear_csr_ecfg(ECFG0_IM);
+
+	pr_notice("\n\n** You can safely turn off the power now **\n\n");
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
+	while (true) {
+		__arch_cpu_idle();
+		local_irq_disable();
+	}
+}
+
+void (*pm_restart)(void) = machine_hang;
+void (*pm_power_off)(void) = machine_hang;
+
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_halt(void)
+{
+	machine_hang();
+}
+
+void machine_power_off(void)
+{
+	pm_power_off();
+}
+
+void machine_restart(char *command)
+{
+	do_kernel_restart(command);
+	pm_restart();
+}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
new file mode 100644
index 000000000000..ba63b45ed82f
--- /dev/null
+++ b/arch/loongarch/kernel/setup.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/export.h>
+#include <linux/screen_info.h>
+#include <linux/memblock.h>
+#include <linux/initrd.h>
+#include <linux/root_dev.h>
+#include <linux/highmem.h>
+#include <linux/console.h>
+#include <linux/pfn.h>
+#include <linux/debugfs.h>
+#include <linux/sizes.h>
+#include <linux/device.h>
+#include <linux/dma-map-ops.h>
+#include <linux/swiotlb.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/cache.h>
+#include <asm/cpu.h>
+#include <asm/debug.h>
+#include <asm/dma.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+
+struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
+
+EXPORT_SYMBOL(cpu_data);
+
+#ifdef CONFIG_VT
+struct screen_info screen_info;
+#endif
+
+/*
+ * Setup information
+ *
+ * These are initialized so they are in the .data section
+ */
+
+char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
+
+/*
+ * loongarch_io_port_base is the begin of the address space to which x86 style
+ * I/O ports are mapped.
+ */
+unsigned long loongarch_io_port_base = -1;
+EXPORT_SYMBOL(loongarch_io_port_base);
+
+static struct resource code_resource = { .name = "Kernel code", };
+static struct resource data_resource = { .name = "Kernel data", };
+static struct resource bss_resource = { .name = "Kernel bss", };
+
+unsigned long __kaslr_offset __ro_after_init;
+EXPORT_SYMBOL(__kaslr_offset);
+
+static void *detect_magic __initdata = detect_memory_region;
+
+void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_addr_t sz_max)
+{
+	void *dm = &detect_magic;
+	phys_addr_t size;
+
+	for (size = sz_min; size < sz_max; size <<= 1) {
+		if (!memcmp(dm, dm + size, sizeof(detect_magic)))
+			break;
+	}
+
+	pr_debug("Memory: %lluMB of RAM detected at 0x%llx (min: %lluMB, max: %lluMB)\n",
+		((unsigned long long) size) / SZ_1M,
+		(unsigned long long) start,
+		((unsigned long long) sz_min) / SZ_1M,
+		((unsigned long long) sz_max) / SZ_1M);
+
+	memblock_add(start, size);
+}
+
+/*
+ * Manage initrd
+ */
+#ifdef CONFIG_BLK_DEV_INITRD
+
+static int __init rd_start_early(char *p)
+{
+	unsigned long start = memparse(p, &p);
+
+#ifdef CONFIG_64BIT
+	/* Guess if the sign extension was forgotten by bootloader */
+	if (start < CAC_BASE)
+		start = (int)start;
+#endif
+	initrd_start = start;
+	initrd_end += start;
+	return 0;
+}
+early_param("rd_start", rd_start_early);
+
+static int __init rd_size_early(char *p)
+{
+	initrd_end += memparse(p, &p);
+	return 0;
+}
+early_param("rd_size", rd_size_early);
+
+static unsigned long __init init_initrd(void)
+{
+	/*
+	 * Board specific code or command line parser should have
+	 * already set up initrd_start and initrd_end. In these cases
+	 * perfom sanity checks and use them if all looks good.
+	 */
+	if (!initrd_start || initrd_end <= initrd_start)
+		goto disable;
+
+	if (initrd_start & ~PAGE_MASK) {
+		pr_err("initrd start must be page aligned\n");
+		goto disable;
+	}
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
+	ROOT_DEV = Root_RAM0;
+
+	return 0;
+disable:
+	initrd_start = 0;
+	initrd_end = 0;
+	return 0;
+}
+
+static void __init finalize_initrd(void)
+{
+	unsigned long size = initrd_end - initrd_start;
+
+	if (size == 0) {
+		pr_info("Initrd not found or empty");
+		goto disable;
+	}
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("Initrd extends beyond end of memory");
+		goto disable;
+	}
+
+
+	memblock_reserve(__pa(initrd_start), size);
+	initrd_below_start_ok = 1;
+
+	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
+		initrd_start, size);
+	return;
+disable:
+	pr_cont(" - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
+#else  /* !CONFIG_BLK_DEV_INITRD */
+
+static unsigned long __init init_initrd(void)
+{
+	return 0;
+}
+
+#define finalize_initrd()	do {} while (0)
+
+#endif
+
+/*
+ * Initialize the bootmem allocator. It also setup initrd related data
+ * if needed.
+ */
+static void __init bootmem_init(void)
+{
+	init_initrd();
+	finalize_initrd();
+}
+
+static int usermem __initdata;
+
+static int __init early_parse_mem(char *p)
+{
+	phys_addr_t start, size;
+
+	/*
+	 * If a user specifies memory size, we
+	 * blow away any automatically generated
+	 * size.
+	 */
+	if (usermem == 0) {
+		usermem = 1;
+		memblock_remove(memblock_start_of_DRAM(),
+			memblock_end_of_DRAM() - memblock_start_of_DRAM());
+	}
+	start = 0;
+	size = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
+	memblock_add(start, size);
+
+	return 0;
+}
+early_param("mem", early_parse_mem);
+
+static int __init early_parse_memmap(char *p)
+{
+	char *oldp;
+	u64 start_at, mem_size;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!strncmp(p, "exactmap", 8)) {
+		pr_err("\"memmap=exactmap\" invalid on LoongArch\n");
+		return 0;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	if (*p == '@') {
+		start_at = memparse(p+1, &p);
+		memblock_add(start_at, mem_size);
+	} else if (*p == '#') {
+		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on LoongArch\n");
+		return -EINVAL;
+	} else if (*p == '$') {
+		start_at = memparse(p+1, &p);
+		memblock_add(start_at, mem_size);
+		memblock_reserve(start_at, mem_size);
+	} else {
+		pr_err("\"memmap\" invalid format!\n");
+		return -EINVAL;
+	}
+
+	if (*p == '\0') {
+		usermem = 1;
+		return 0;
+	} else
+		return -EINVAL;
+}
+early_param("memmap", early_parse_memmap);
+
+static void __init check_kernel_sections_mem(void)
+{
+	phys_addr_t start = __pa_symbol(&_text);
+	phys_addr_t size = __pa_symbol(&_end) - start;
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_info("Kernel sections are not in the memory maps\n");
+		memblock_add(start, size);
+	}
+}
+
+static void __init bootcmdline_append(const char *s, size_t max)
+{
+	if (!s[0] || !max)
+		return;
+
+	if (boot_command_line[0])
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+
+	strlcat(boot_command_line, s, max);
+}
+
+static void __init bootcmdline_init(char **cmdline_p)
+{
+	boot_command_line[0] = 0;
+
+	/*
+	 * Take arguments from the bootloader at first. Early code should have
+	 * filled arcs_cmdline with arguments from the bootloader.
+	 */
+	bootcmdline_append(arcs_cmdline, COMMAND_LINE_SIZE);
+
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
+	parse_early_param();
+}
+
+/*
+ * arch_mem_init - initialize memory management subsystem
+ */
+static void __init arch_mem_init(char **cmdline_p)
+{
+	/* call board setup routine */
+	plat_mem_setup();
+	memblock_set_bottom_up(true);
+
+	if (usermem)
+		pr_info("User-defined physical RAM map overwrite\n");
+
+	check_kernel_sections_mem();
+
+	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
+
+	bootmem_init();
+
+	/*
+	 * Prevent memblock from allocating high memory.
+	 * This cannot be done before max_low_pfn is detected, so up
+	 * to this point is possible to only reserve physical memory
+	 * with memblock_reserve; memblock_alloc* can be used
+	 * only after this point
+	 */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+
+	/*
+	 * In order to reduce the possibility of kernel panic when failed to
+	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
+	 * low memory as small as possible before plat_swiotlb_setup(), so
+	 * make sparse_init() using top-down allocation.
+	 */
+	memblock_set_bottom_up(false);
+	sparse_init();
+	memblock_set_bottom_up(true);
+
+	swiotlb_init(1);
+
+	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+
+	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
+}
+
+static void __init resource_init(void)
+{
+	u64 i;
+	phys_addr_t start, end;
+
+	if (UNCAC_BASE != IO_BASE)
+		return;
+
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
+	bss_resource.start = __pa_symbol(&__bss_start);
+	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
+
+	for_each_mem_range(i, &start, &end) {
+		struct resource *res;
+
+		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
+		if (!res)
+			panic("%s: Failed to allocate %zu bytes\n", __func__,
+			      sizeof(struct resource));
+
+		res->start = start;
+		/*
+		 * In memblock, end points to the first byte after the
+		 * range while in resourses, end points to the last byte in
+		 * the range.
+		 */
+		res->end = end - 1;
+		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+		res->name = "System RAM";
+
+		request_resource(&iomem_resource, res);
+
+		/*
+		 *  We don't know which RAM region contains kernel data,
+		 *  so we try it repeatedly and let the resource manager
+		 *  test it.
+		 */
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+		request_resource(res, &bss_resource);
+	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	cpu_probe();
+
+	early_init();
+	bootcmdline_init(cmdline_p);
+
+#ifdef CONFIG_ACPI
+	init_initrd();
+#endif
+	platform_init();
+
+	cpu_report();
+
+#if defined(CONFIG_VT)
+#if defined(CONFIG_VGA_CONSOLE)
+	conswitchp = &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+#endif
+	arch_mem_init(cmdline_p);
+
+	resource_init();
+
+	cpu_cache_init();
+	paging_init();
+	boot_cpu_trap_init();
+}
+
+DEFINE_PER_CPU(unsigned long, kernelsp);
+unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *loongarch_debugfs_dir;
+static int __init debugfs_loongarch(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("loongarch", NULL);
+	if (!d)
+		return -ENOMEM;
+	loongarch_debugfs_dir = d;
+	return 0;
+}
+arch_initcall(debugfs_loongarch);
+#endif
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
new file mode 100644
index 000000000000..2509a2e9fac3
--- /dev/null
+++ b/arch/loongarch/kernel/time.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common time service routines for LoongArch machines.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/clockchips.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/sched_clock.h>
+#include <linux/spinlock.h>
+
+#include <asm/cpu-features.h>
+#include <asm/loongarchregs.h>
+#include <asm/time.h>
+
+u64 cpu_clock_freq;
+EXPORT_SYMBOL(cpu_clock_freq);
+u64 const_clock_freq;
+EXPORT_SYMBOL(const_clock_freq);
+
+static DEFINE_SPINLOCK(state_lock);
+DEFINE_PER_CPU(struct clock_event_device, constant_clockevent_device);
+
+void constant_event_handler(struct clock_event_device *dev)
+{
+}
+
+irqreturn_t constant_timer_interrupt(int irq, void *data)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+
+	/* Clear Timer Interrupt */
+	write_csr_tintclear(CSR_TINTCLR_TI);
+	cd = &per_cpu(constant_clockevent_device, cpu);
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static int constant_set_state_oneshot(struct clock_event_device *evt)
+{
+	unsigned long timer_config;
+
+	spin_lock(&state_lock);
+
+	timer_config = csr_readq(LOONGARCH_CSR_TCFG);
+	timer_config |=  CSR_TCFG_EN;
+	timer_config &= ~CSR_TCFG_PERIOD;
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	spin_unlock(&state_lock);
+
+	return 0;
+}
+
+static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int constant_set_state_periodic(struct clock_event_device *evt)
+{
+	unsigned long period;
+	unsigned long timer_config;
+
+	spin_lock(&state_lock);
+
+	period = const_clock_freq / HZ;
+	timer_config = period & CSR_TCFG_VAL;
+	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	spin_unlock(&state_lock);
+
+	return 0;
+}
+
+static int constant_set_state_shutdown(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int constant_timer_next_event(unsigned long delta, struct clock_event_device *evt)
+{
+	unsigned long timer_config;
+
+	delta &= CSR_TCFG_VAL;
+	timer_config = delta | CSR_TCFG_EN;
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	return 0;
+}
+
+static unsigned long __init get_loops_per_jiffy(void)
+{
+	unsigned long lpj = (unsigned long)const_clock_freq;
+
+	do_div(lpj, HZ);
+
+	return lpj;
+}
+
+static long init_timeval;
+
+void sync_counter(void)
+{
+	/* Ensure counter begin at 0 */
+	csr_writeq(-init_timeval, LOONGARCH_CSR_CNTC);
+}
+
+int constant_clockevent_init(void)
+{
+	unsigned int irq;
+	unsigned int cpu = smp_processor_id();
+	unsigned long min_delta = 0x600;
+	unsigned long max_delta = (1UL << 48) - 1;
+	struct clock_event_device *cd;
+	static int timer_irq_installed = 0;
+
+	irq = LOONGSON_TIMER_IRQ;
+
+	cd = &per_cpu(constant_clockevent_device, cpu);
+
+	cd->name = "Constant";
+	cd->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_PERCPU;
+
+	cd->irq = irq;
+	cd->rating = 320;
+	cd->cpumask = cpumask_of(cpu);
+	cd->set_state_oneshot = constant_set_state_oneshot;
+	cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
+	cd->set_state_periodic = constant_set_state_periodic;
+	cd->set_state_shutdown = constant_set_state_shutdown;
+	cd->set_next_event = constant_timer_next_event;
+	cd->event_handler = constant_event_handler;
+
+	clockevents_config_and_register(cd, const_clock_freq, min_delta, max_delta);
+
+	if (timer_irq_installed)
+		return 0;
+
+	timer_irq_installed = 1;
+
+	sync_counter();
+
+	if (request_irq(irq, constant_timer_interrupt, IRQF_PERCPU | IRQF_TIMER, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", irq);
+
+	lpj_fine = get_loops_per_jiffy();
+	pr_info("Constant clock event device register\n");
+
+	return 0;
+}
+
+static u64 read_const_counter(struct clocksource *clk)
+{
+	return drdtime();
+}
+
+static struct clocksource clocksource_const = {
+	.name = "Constant",
+	.rating = 400,
+	.read = read_const_counter,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.mult = 0,
+	.shift = 10,
+};
+
+unsigned long long notrace sched_clock(void)
+{
+	/* 64-bit arithmetic can overflow, so use 128-bit. */
+	u64 t1, t2, t3;
+	unsigned long long rv;
+	u64 mult = clocksource_const.mult;
+	u64 shift = clocksource_const.shift;
+	u64 cnt = read_const_counter(NULL);
+
+	__asm__ (
+		"nor		%[t1], $r0, %[shift]	\n\t"
+		"mulh.du	%[t2], %[cnt], %[mult]	\n\t"
+		"mul.d		%[t3], %[cnt], %[mult]	\n\t"
+		"slli.d		%[t2], %[t2], 1		\n\t"
+		"srl.d		%[rv], %[t3], %[shift]	\n\t"
+		"sll.d		%[t1], %[t2], %[t1]	\n\t"
+		"or		%[rv], %[t1], %[rv]	\n\t"
+		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
+		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
+		: );
+
+	return rv;
+}
+
+int __init constant_clocksource_init(void)
+{
+	int res;
+	unsigned long freq;
+
+	freq = const_clock_freq;
+
+	clocksource_const.mult =
+		clocksource_hz2mult(freq, clocksource_const.shift);
+
+	res = clocksource_register_hz(&clocksource_const, freq);
+
+	pr_info("Constant clock source device register\n");
+
+	return res;
+}
+
+void __init time_init(void)
+{
+	if (!cpu_has_cpucfg)
+		const_clock_freq = cpu_clock_freq;
+	else
+		const_clock_freq = calc_const_freq();
+
+	init_timeval = drdtime() - csr_readq(LOONGARCH_CSR_CNTC);
+
+	constant_clockevent_init();
+	constant_clocksource_init();
+}
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
new file mode 100644
index 000000000000..3b2cbb95875b
--- /dev/null
+++ b/arch/loongarch/kernel/topology.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+
+static struct cpu cpu_device;
+
+static int __init topology_init(void)
+{
+	return register_cpu(&cpu_device, 0);
+}
+
+subsys_initcall(topology_init);
-- 
2.27.0

