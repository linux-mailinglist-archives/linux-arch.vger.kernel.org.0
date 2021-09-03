Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCC3FFDDF
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348982AbhICKGk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 06:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349059AbhICKGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 06:06:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1045D60FDA;
        Fri,  3 Sep 2021 10:05:32 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 21/22] LoongArch: Add Non-Uniform Memory Access (NUMA) support
Date:   Fri,  3 Sep 2021 17:52:12 +0800
Message-Id: <20210903095213.797973-22-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds Non-Uniform Memory Access (NUMA) support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                  |  38 ++
 arch/loongarch/include/asm/bootinfo.h   |   1 +
 arch/loongarch/include/asm/dma-direct.h |  11 +
 arch/loongarch/include/asm/mmzone.h     |  18 +
 arch/loongarch/include/asm/numa.h       |  69 ++++
 arch/loongarch/include/asm/pgtable.h    |  12 +
 arch/loongarch/include/asm/topology.h   |  21 ++
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/acpi.c            |  96 +++++
 arch/loongarch/kernel/dma.c             |  58 +++
 arch/loongarch/kernel/module.c          |   1 +
 arch/loongarch/kernel/numa.c            | 483 ++++++++++++++++++++++++
 arch/loongarch/kernel/setup.c           |   8 +-
 arch/loongarch/kernel/smp.c             |  35 +-
 arch/loongarch/kernel/topology.c        |   5 +
 arch/loongarch/mm/init.c                |  30 ++
 arch/loongarch/pci/acpi.c               |   2 +
 arch/loongarch/pci/pci.c                |  26 ++
 18 files changed, 912 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/dma-direct.h
 create mode 100644 arch/loongarch/include/asm/mmzone.h
 create mode 100644 arch/loongarch/include/asm/numa.h
 create mode 100644 arch/loongarch/kernel/dma.c
 create mode 100644 arch/loongarch/kernel/numa.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 8627d2520924..547d68992bf6 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,6 +7,7 @@ config LOONGARCH
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
@@ -41,6 +42,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
@@ -303,6 +305,37 @@ config NR_CPUS
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.
 
+config NUMA
+	bool "NUMA Support"
+	select ACPI_NUMA if ACPI
+	help
+	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
+	  Access).  This option improves performance on systems with more
+	  than two nodes; on two node systems it is generally better to
+	  leave it disabled; on single node systems disable this option
+	  disabled.
+
+config NODES_SHIFT
+	int
+	default "6"
+	depends on NUMA
+
+config USE_PERCPU_NUMA_NODE_ID
+	def_bool y
+	depends on NUMA
+
+config HAVE_SETUP_PER_CPU_AREA
+	def_bool y
+	depends on NUMA
+
+config NEED_PER_CPU_EMBED_FIRST_CHUNK
+	def_bool y
+	depends on NUMA
+
+config NEED_PER_CPU_PAGE_FIRST_CHUNK
+	def_bool y
+	depends on NUMA
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 14 64 if PAGE_SIZE_64KB
@@ -349,6 +382,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
+	depends on !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
@@ -369,6 +403,10 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config HAVE_ARCH_NODEDATA_EXTENSION
+	def_bool y
+	depends on NUMA && ARCH_ENABLE_MEMORY_HOTPLUG
+
 config MMU
 	bool
 	default y
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index 41838633d1aa..e358ea0e823c 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -15,6 +15,7 @@ extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_ad
 
 extern void early_init(void);
 extern void platform_init(void);
+extern void plat_swiotlb_setup(void);
 
 extern void free_init_pages(const char *what, unsigned long begin, unsigned long end);
 
diff --git a/arch/loongarch/include/asm/dma-direct.h b/arch/loongarch/include/asm/dma-direct.h
new file mode 100644
index 000000000000..5fdc1988c34b
--- /dev/null
+++ b/arch/loongarch/include/asm/dma-direct.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _LOONGARCH_DMA_DIRECT_H
+#define _LOONGARCH_DMA_DIRECT_H
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
+
+#endif /* _LOONGARCH_DMA_DIRECT_H */
diff --git a/arch/loongarch/include/asm/mmzone.h b/arch/loongarch/include/asm/mmzone.h
new file mode 100644
index 000000000000..772c3baa5bb9
--- /dev/null
+++ b/arch/loongarch/include/asm/mmzone.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen (chenhuacai@loongson.cn)
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_MMZONE_H_
+#define _ASM_MMZONE_H_
+
+#include <asm/page.h>
+#include <asm/numa.h>
+
+extern struct pglist_data *node_data[];
+
+#define NODE_DATA(nid)	(node_data[(nid)])
+
+extern void setup_zero_pages(void);
+
+#endif /* _ASM_MMZONE_H_ */
diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
new file mode 100644
index 000000000000..79a7ed4bdaba
--- /dev/null
+++ b/arch/loongarch/include/asm/numa.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch specific ACPICA environments and implementation
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_NUMA_H
+#define _ASM_LOONGARCH_NUMA_H
+
+#include <linux/nodemask.h>
+
+#define NODE_ADDRSPACE_SHIFT 44
+
+#define pa_to_nid(addr)		(((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
+#define nid_to_addrbase(nid)	(_ULCAST_(nid) << NODE_ADDRSPACE_SHIFT)
+
+#ifdef CONFIG_NUMA
+
+extern int numa_off;
+extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
+extern nodemask_t numa_nodes_parsed __initdata;
+
+struct numa_memblk {
+	u64			start;
+	u64			end;
+	int			nid;
+};
+
+#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
+struct numa_meminfo {
+	int			nr_blks;
+	struct numa_memblk	blk[NR_NODE_MEMBLKS];
+};
+
+extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+
+extern void __init early_numa_add_cpu(int cpuid, s16 node);
+extern void numa_add_cpu(unsigned int cpu);
+extern void numa_remove_cpu(unsigned int cpu);
+
+static inline void numa_clear_node(int cpu)
+{
+}
+
+static inline void set_cpuid_to_node(int cpuid, s16 node)
+{
+	__cpuid_to_node[cpuid] = node;
+}
+
+extern int early_cpu_to_node(int cpu);
+
+#else
+
+static inline void early_numa_add_cpu(int cpuid, s16 node)	{ }
+static inline void numa_add_cpu(unsigned int cpu)		{ }
+static inline void numa_remove_cpu(unsigned int cpu)		{ }
+
+static inline int early_cpu_to_node(int cpu)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_NUMA */
+
+#endif	/* _ASM_LOONGARCH_NUMA_H */
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 9c1c431f788b..28657d36a733 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -594,6 +594,18 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifdef CONFIG_NUMA_BALANCING
+static inline long pte_protnone(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PROTNONE);
+}
+
+static inline long pmd_protnone(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PAGE_PROTNONE);
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index bc541a723f8a..f855de0f30b2 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -7,6 +7,27 @@
 
 #include <linux/smp.h>
 
+#ifdef CONFIG_NUMA
+
+extern cpumask_t cpus_on_node[];
+
+#define cpumask_of_node(node)  (&cpus_on_node[node])
+
+struct pci_bus;
+extern int pcibus_to_node(struct pci_bus *);
+
+#define cpumask_of_pcibus(bus)	(cpu_online_mask)
+
+extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+
+void numa_set_distance(int from, int to, int distance);
+
+#define node_distance(from, to)	(__node_distances[(from)][(to)])
+
+#else
+#define pcibus_to_node(bus)	0
+#endif
+
 #ifdef CONFIG_SMP
 #define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
 #define topology_core_id(cpu)			(cpu_core(&cpu_data[cpu]))
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 9d5cb652bfc0..66f5cd49fb03 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -21,4 +21,6 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 
+obj-$(CONFIG_NUMA)		+= numa.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 51cca3369183..f3829589ebbd 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/serial_core.h>
 #include <asm/io.h>
+#include <asm/numa.h>
 #include <asm/loongson.h>
 
 int acpi_disabled;
@@ -353,6 +354,80 @@ int __init acpi_boot_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+
+static __init int setup_node(int pxm)
+{
+	return acpi_map_pxm_to_node(pxm);
+}
+
+/*
+ * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
+ * I/O localities since SRAT does not list them.  I/O localities are
+ * not supported at this point.
+ */
+extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+unsigned int numa_distance_cnt;
+
+static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
+{
+	return slit->locality_count;
+}
+
+void __init numa_set_distance(int from, int to, int distance)
+{
+	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
+		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
+				from, to, distance);
+		return;
+	}
+
+	__node_distances[from][to] = distance;
+}
+
+/* Callback for Proximity Domain -> CPUID mapping */
+void __init
+acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
+{
+	int pxm, node;
+
+	if (srat_disabled())
+		return;
+	if (pa->header.length != sizeof(struct acpi_srat_cpu_affinity)) {
+		bad_srat();
+		return;
+	}
+	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
+		return;
+	pxm = pa->proximity_domain_lo;
+	if (acpi_srat_revision >= 2) {
+		pxm |= (pa->proximity_domain_hi[0] << 8);
+		pxm |= (pa->proximity_domain_hi[1] << 16);
+		pxm |= (pa->proximity_domain_hi[2] << 24);
+	}
+	node = setup_node(pxm);
+	if (node < 0) {
+		pr_err("SRAT: Too many proximity domains %x\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	if (pa->apic_id >= CONFIG_NR_CPUS) {
+		pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u skipped apicid that is too big\n",
+				pxm, pa->apic_id, node);
+		return;
+	}
+
+	early_numa_add_cpu(pa->apic_id, node);
+
+	set_cpuid_to_node(pa->apic_id, node);
+	node_set(node, numa_nodes_parsed);
+	pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u\n", pxm, pa->apic_id, node);
+}
+
+void __init acpi_numa_arch_fixup(void) {}
+#endif
+
 void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	u8 map_count = loongson_mem_map->map_count;
@@ -367,6 +442,22 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 
 #include <acpi/processor.h>
 
+static int __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+{
+#ifdef CONFIG_ACPI_NUMA
+	int nid;
+
+	nid = acpi_get_node(handle);
+	if (nid != NUMA_NO_NODE) {
+		set_cpuid_to_node(physid, nid);
+		node_set(nid, numa_nodes_parsed);
+		set_cpu_numa_node(cpu, nid);
+		cpumask_set_cpu(cpu, cpumask_of_node(nid));
+	}
+#endif
+	return 0;
+}
+
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
 {
 	int cpu;
@@ -377,6 +468,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu
 		return cpu;
 	}
 
+	acpi_map_cpu2node(handle, cpu, physid);
+
 	*pcpu = cpu;
 
 	return 0;
@@ -385,6 +478,9 @@ EXPORT_SYMBOL(acpi_map_cpu);
 
 int acpi_unmap_cpu(int cpu)
 {
+#ifdef CONFIG_ACPI_NUMA
+	set_cpuid_to_node(cpu_logical_map(cpu), NUMA_NO_NODE);
+#endif
 	set_cpu_present(cpu, false);
 	num_processors--;
 
diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
new file mode 100644
index 000000000000..6e526ab5eba2
--- /dev/null
+++ b/arch/loongarch/kernel/dma.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <linux/swiotlb.h>
+
+#include <asm/bootinfo.h>
+#include <asm/dma.h>
+#include <asm/loongson.h>
+
+/*
+ * We extract 4bit node id (bit 44~47) from Loongson-3's
+ * 48bit physical address space and embed it into 40bit.
+ */
+
+static int node_id_offset;
+
+static dma_addr_t loongson_phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	long nid = (paddr >> 44) & 0xf;
+
+	return ((nid << 44) ^ paddr) | (nid << node_id_offset);
+}
+
+static phys_addr_t loongson_dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	long nid = (daddr >> node_id_offset) & 0xf;
+
+	return ((nid << node_id_offset) ^ daddr) | (nid << 44);
+}
+
+static struct loongson_addr_xlate_ops {
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+} xlate_ops;
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return xlate_ops.phys_to_dma(dev, paddr);
+}
+
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return xlate_ops.dma_to_phys(dev, daddr);
+}
+
+void __init plat_swiotlb_setup(void)
+{
+	swiotlb_init(1);
+	node_id_offset = ((readl(LS7A_DMA_CFG) & LS7A_DMA_NODE_MASK) >> LS7A_DMA_NODE_SHF) + 36;
+
+	xlate_ops.phys_to_dma = loongson_phys_to_dma;
+	xlate_ops.dma_to_phys = loongson_dma_to_phys;
+}
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index af7c403b032b..cb87486cacb6 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -11,6 +11,7 @@
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
+#include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
new file mode 100644
index 000000000000..9a083309974e
--- /dev/null
+++ b/arch/loongarch/kernel/numa.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technology Co., Ltd.
+ *
+ * Author:  Xiang Gao, gaoxiang@loongson.cn
+ *          Huacai Chen, chenhuacai@loongson.cn
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/export.h>
+#include <linux/nodemask.h>
+#include <linux/swap.h>
+#include <linux/memblock.h>
+#include <linux/pfn.h>
+#include <linux/acpi.h>
+#include <linux/highmem.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+#include <asm/numa.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/sections.h>
+#include <asm/time.h>
+
+int numa_off;
+struct pglist_data *node_data[MAX_NUMNODES];
+unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+
+EXPORT_SYMBOL(node_data);
+EXPORT_SYMBOL(__node_distances);
+
+static struct numa_meminfo numa_meminfo;
+cpumask_t cpus_on_node[MAX_NUMNODES];
+cpumask_t phys_cpus_on_node[MAX_NUMNODES];
+EXPORT_SYMBOL(cpus_on_node);
+
+/*
+ * apicid, cpu, node mappings
+ */
+s16 __cpuid_to_node[CONFIG_NR_CPUS] = {
+	[0 ... CONFIG_NR_CPUS - 1] = NUMA_NO_NODE
+};
+EXPORT_SYMBOL(__cpuid_to_node);
+
+nodemask_t numa_nodes_parsed __initdata;
+
+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
+unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(__per_cpu_offset);
+
+static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
+{
+	if (early_cpu_to_node(from) == early_cpu_to_node(to))
+		return LOCAL_DISTANCE;
+	else
+		return REMOTE_DISTANCE;
+}
+
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
+				       size_t align)
+{
+	return memblock_alloc_try_nid(size, align, __pa(MAX_DMA_ADDRESS),
+				      MEMBLOCK_ALLOC_ACCESSIBLE, early_cpu_to_node(cpu));
+}
+
+static void __init pcpu_fc_free(void *ptr, size_t size)
+{
+	memblock_free_early(__pa(ptr), size);
+}
+
+static void __init pcpu_populate_pte(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (pgd_none(*pgd)) {
+		pud_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		pgd_populate(&init_mm, pgd, new);
+#ifndef __PAGETABLE_PUD_FOLDED
+		pud_init((unsigned long)new, (unsigned long)invalid_pmd_table);
+#endif
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		pud_populate(&init_mm, pud, new);
+#ifndef __PAGETABLE_PMD_FOLDED
+		pmd_init((unsigned long)new, (unsigned long)invalid_pte_table);
+#endif
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd)) {
+		pte_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		pmd_populate_kernel(&init_mm, pmd, new);
+	}
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long delta;
+	unsigned int cpu;
+	int rc = -EINVAL;
+
+	if (pcpu_chosen_fc == PCPU_FC_AUTO) {
+		if (nr_node_ids >= 8)
+			pcpu_chosen_fc = PCPU_FC_PAGE;
+		else
+			pcpu_chosen_fc = PCPU_FC_EMBED;
+	}
+
+	/*
+	 * Always reserve area for module percpu variables.  That's
+	 * what the legacy allocator did.
+	 */
+	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
+		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+					    PERCPU_DYNAMIC_RESERVE, PMD_SIZE,
+					    pcpu_cpu_distance,
+					    pcpu_fc_alloc, pcpu_fc_free);
+		if (rc < 0)
+			pr_warn("%s allocator failed (%d), falling back to page size\n",
+				pcpu_fc_names[pcpu_chosen_fc], rc);
+	}
+	if (rc < 0)
+		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
+					   pcpu_fc_alloc, pcpu_fc_free,
+					   pcpu_populate_pte);
+	if (rc < 0)
+		panic("cannot initialize percpu area (err=%d)", rc);
+
+	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
+	for_each_possible_cpu(cpu)
+		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
+}
+#endif
+
+/*
+ * Get nodeid by logical cpu number.
+ * __cpuid_to_node maps phyical cpu id to node, so we
+ * should use cpu_logical_map(cpu) to index it.
+ *
+ * This routine is only used in early phase during
+ * booting, after setup_per_cpu_areas calling and numa_node
+ * initialization, cpu_to_node will be used instead.
+ */
+int early_cpu_to_node(int cpu)
+{
+	int physid = cpu_logical_map(cpu);
+
+	if (physid < 0)
+		return NUMA_NO_NODE;
+
+	return __cpuid_to_node[physid];
+}
+
+void __init early_numa_add_cpu(int cpuid, s16 node)
+{
+	int cpu = __cpu_number_map[cpuid];
+
+	if (cpu < 0)
+		return;
+
+	cpumask_set_cpu(cpu, &cpus_on_node[node]);
+	cpumask_set_cpu(cpuid, &phys_cpus_on_node[node]);
+}
+
+void numa_add_cpu(unsigned int cpu)
+{
+	int nid = cpu_to_node(cpu);
+	cpumask_set_cpu(cpu, &cpus_on_node[nid]);
+}
+
+void numa_remove_cpu(unsigned int cpu)
+{
+	int nid = cpu_to_node(cpu);
+	cpumask_clear_cpu(cpu, &cpus_on_node[nid]);
+}
+
+static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
+				     struct numa_meminfo *mi)
+{
+	/* ignore zero length blks */
+	if (start == end)
+		return 0;
+
+	/* whine about and ignore invalid blks */
+	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
+		pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
+			   nid, start, end - 1);
+		return 0;
+	}
+
+	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
+		pr_err("NUMA: too many memblk ranges\n");
+		return -EINVAL;
+	}
+
+	mi->blk[mi->nr_blks].start = PFN_ALIGN(start);
+	mi->blk[mi->nr_blks].end = PFN_ALIGN(end - PAGE_SIZE + 1);
+	mi->blk[mi->nr_blks].nid = nid;
+	mi->nr_blks++;
+	return 0;
+}
+
+/**
+ * numa_add_memblk - Add one numa_memblk to numa_meminfo
+ * @nid: NUMA node ID of the new memblk
+ * @start: Start address of the new memblk
+ * @end: End address of the new memblk
+ *
+ * Add a new memblk to the default numa_meminfo.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int __init numa_add_memblk(int nid, u64 start, u64 end)
+{
+	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
+}
+
+static void __init alloc_node_data(int nid)
+{
+	void *nd;
+	unsigned long nd_pa;
+	size_t nd_sz = roundup(sizeof(pg_data_t), PAGE_SIZE);
+
+	nd_pa = memblock_phys_alloc_try_nid(nd_sz, SMP_CACHE_BYTES, nid);
+	if (!nd_pa) {
+		pr_err("Cannot find %zu Byte for node_data (initial node: %d)\n", nd_sz, nid);
+		return;
+	}
+
+	nd = __va(nd_pa);
+
+	node_data[nid] = nd;
+	memset(nd, 0, sizeof(pg_data_t));
+}
+
+static void __init node_mem_init(unsigned int node)
+{
+	unsigned long start_pfn, end_pfn;
+	unsigned long node_addrspace_offset;
+
+	node_addrspace_offset = nid_to_addrbase(node);
+	pr_info("Node%d's addrspace_offset is 0x%lx\n",
+			node, node_addrspace_offset);
+
+	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
+		node, start_pfn, end_pfn);
+
+	alloc_node_data(node);
+
+	NODE_DATA(node)->node_start_pfn = start_pfn;
+	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
+
+	if (node == 0) {
+		/* used by finalize_initrd() */
+		max_low_pfn = end_pfn;
+
+		/* Reserve the first 2MB */
+		memblock_reserve(PHYS_OFFSET, 0x200000);
+
+		/* Reserve the kernel text/data/bss */
+		memblock_reserve(__pa_symbol(&_text),
+				 __pa_symbol(&_end) - __pa_symbol(&_text));
+	}
+}
+
+#ifdef CONFIG_ACPI_NUMA
+
+/*
+ * Sanity check to catch more bad NUMA configurations (they are amazingly
+ * common).  Make sure the nodes cover all memory.
+ */
+static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
+{
+	int i;
+	u64 numaram, biosram;
+
+	numaram = 0;
+	for (i = 0; i < mi->nr_blks; i++) {
+		u64 s = mi->blk[i].start >> PAGE_SHIFT;
+		u64 e = mi->blk[i].end >> PAGE_SHIFT;
+
+		numaram += e - s;
+		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
+		if ((s64)numaram < 0)
+			numaram = 0;
+	}
+	max_pfn = max_low_pfn;
+	biosram = max_pfn - absent_pages_in_range(0, max_pfn);
+
+	BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
+	return true;
+}
+
+static void __init add_node_intersection(u32 node, u64 start, u64 size)
+{
+	static unsigned long num_physpages;
+
+	num_physpages += (size >> PAGE_SHIFT);
+	pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
+		node, ADDRESS_TYPE_SYSRAM, start, size);
+	pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
+		start >> PAGE_SHIFT, (start + size) >> PAGE_SHIFT, num_physpages);
+	memblock_add_node(start, size, node);
+	memblock_set_node(start, size, &memblock.memory, node);
+}
+
+/*
+ * add_mem_region
+ *
+ * Add a uasable memory region described by BIOS. The
+ * routine gets each intersection between BIOS's region
+ * and node's region, and adds them into node's memblock
+ * pool.
+ *
+ */
+static void __init add_numamem_region(u64 start, u64 end)
+{
+	u32 i;
+	u64 tmp = start;
+
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = &numa_meminfo.blk[i];
+
+		if (tmp > mb->end)
+			continue;
+
+		if (end > mb->end) {
+			add_node_intersection(mb->nid, tmp, mb->end - tmp);
+			tmp = mb->end;
+		} else {
+			add_node_intersection(mb->nid, tmp, end - tmp);
+			break;
+		}
+	}
+}
+
+static void __init init_node_memblock(void)
+{
+	u32 i, mem_type;
+	u64 mem_end, mem_start, mem_size;
+
+	/* Parse memory information and activate */
+	for (i = 0; i < loongson_mem_map->map_count; i++) {
+		mem_type = loongson_mem_map->map[i].mem_type;
+		mem_start = loongson_mem_map->map[i].mem_start;
+		mem_size = loongson_mem_map->map[i].mem_size;
+		mem_end = loongson_mem_map->map[i].mem_start + mem_size;
+		switch (mem_type) {
+		case ADDRESS_TYPE_SYSRAM:
+			mem_start = PFN_ALIGN(mem_start);
+			mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
+			add_numamem_region(mem_start, mem_end);
+			break;
+		case ADDRESS_TYPE_ACPI:
+		case ADDRESS_TYPE_RESERVED:
+			pr_info("Resvd: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
+					mem_type, mem_start, mem_size);
+			memblock_reserve(mem_start, mem_size);
+			break;
+		}
+	}
+}
+
+static void __init numa_default_distance(void)
+{
+	int row, col;
+
+	for (row = 0; row < MAX_NUMNODES; row++)
+		for (col = 0; col < MAX_NUMNODES; col++) {
+
+			if (col == row)
+				__node_distances[row][col] = 0;
+			else
+				/* We assume that one node per package here!
+				 *
+				 * A SLIT should be used for multiple nodes per
+				 * package to override default setting.
+				 */
+				__node_distances[row][col] = 200;
+	}
+}
+
+static int __init numa_mem_init(int (*init_func)(void))
+{
+	int i;
+	int ret;
+	int node;
+
+	for (i = 0; i < NR_CPUS; i++)
+		set_cpuid_to_node(i, NUMA_NO_NODE);
+
+	nodes_clear(numa_nodes_parsed);
+	nodes_clear(node_possible_map);
+	nodes_clear(node_online_map);
+	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
+	numa_default_distance();
+
+	/* Parse SRAT and SLIT if provided by firmware. */
+	ret = init_func();
+	if (ret < 0)
+		return ret;
+
+	node_possible_map = numa_nodes_parsed;
+	if (WARN_ON(nodes_empty(node_possible_map)))
+		return -EINVAL;
+
+	init_node_memblock();
+	if (numa_meminfo_cover_memory(&numa_meminfo) == false)
+		return -EINVAL;
+
+	for_each_node_mask(node, node_possible_map) {
+		node_mem_init(node);
+		node_set_online(node);
+	}
+	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+
+	return 0;
+}
+#endif
+void __init paging_init(void)
+{
+	unsigned int node;
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+	for_each_online_node(node) {
+		unsigned long start_pfn, end_pfn;
+
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+
+		if (end_pfn > max_low_pfn)
+			max_low_pfn = end_pfn;
+	}
+#ifdef CONFIG_ZONE_DMA32
+	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
+#endif
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+	free_area_init(zones_size);
+}
+
+void __init mem_init(void)
+{
+	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+	memblock_free_all();
+	setup_zero_pages();	/* This comes from node 0 */
+}
+
+int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+EXPORT_SYMBOL(pcibus_to_node);
+
+void __init fw_init_numa_memory(void)
+{
+	numa_mem_init(acpi_numa_init);
+	setup_nr_node_ids();
+	loongson_sysconf.nr_nodes = nr_node_ids;
+	loongson_sysconf.cores_per_node = cpumask_weight(&phys_cpus_on_node[0]);
+}
+EXPORT_SYMBOL(fw_init_numa_memory);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 3ad6dc1dc565..4c484b927644 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -343,7 +343,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
+#ifndef CONFIG_NUMA
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
+#endif
 	pagetable_init();
 
 	/*
@@ -365,7 +367,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	sparse_init();
 	memblock_set_bottom_up(true);
 
-	swiotlb_init(1);
+	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
@@ -429,7 +431,11 @@ void __init platform_init(void)
 	acpi_boot_init();
 #endif
 
+#ifndef CONFIG_NUMA
 	fw_init_memory();
+#else
+	fw_init_numa_memory();
+#endif
 	dmi_setup();
 	smbios_parse();
 	pr_info("The BIOS Version: %s\n", b_info.bios_version);
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 75b86053dc7c..56b1d7e16f9d 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <asm/idle.h>
 #include <asm/loongson.h>
 #include <asm/mmu_context.h>
+#include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
 #include <asm/time.h>
@@ -258,6 +259,9 @@ static void loongson3_init_secondary(void)
 	else
 		xconf_writel(0xffffffff, ipi_en_regs[cpu_logical_map(cpu)]);
 
+#ifdef CONFIG_NUMA
+	numa_add_cpu(cpu);
+#endif
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
 	cpu_set_core(&cpu_data[cpu],
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package);
@@ -377,6 +381,9 @@ static int loongson3_cpu_disable(void)
 	if (io_master(cpu))
 		return -EBUSY;
 
+#ifdef CONFIG_NUMA
+	numa_remove_cpu(cpu);
+#endif
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
@@ -713,14 +720,36 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 /* Preload SMP state for boot cpu */
 void smp_prepare_boot_cpu(void)
 {
-	unsigned int cpu;
+	unsigned int cpu, node, rr_node;
 
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
 	set_my_cpu_offset(per_cpu_offset(0));
 
-	for_each_possible_cpu(cpu)
-		set_cpu_numa_node(cpu, 0);
+	rr_node = first_node(node_online_map);
+	for_each_possible_cpu(cpu) {
+		node = early_cpu_to_node(cpu);
+
+		/*
+		 * The mapping between present cpus and nodes has been
+		 * built during MADT and SRAT parsing.
+		 *
+		 * If possible cpus = present cpus here, early_cpu_to_node
+		 * will return valid node.
+		 *
+		 * If possible cpus > present cpus here (e.g. some possible
+		 * cpus will be added by cpu-hotplug later), for possible but
+		 * not present cpus, early_cpu_to_node will return NUMA_NO_NODE,
+		 * and we just map them to online nodes in round-robin way.
+		 * Once hotplugged, new correct mapping will be built for them.
+		 */
+		if (node != NUMA_NO_NODE)
+			set_cpu_numa_node(cpu, node);
+		else {
+			set_cpu_numa_node(cpu, rr_node);
+			rr_node = next_node_in(rr_node, node_online_map);
+		}
+	}
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index ab1a75c0b5a6..ae5f0e5414a3 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -37,6 +37,11 @@ static int __init topology_init(void)
 {
 	int i, ret;
 
+#ifdef CONFIG_NUMA
+	for_each_online_node(i)
+		register_one_node(i);
+#endif /* CONFIG_NUMA */
+
 	for_each_present_cpu(i) {
 		struct cpu *c = &per_cpu(cpu_devices, i);
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index d5015ed0d192..2f8a4651edb1 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -93,6 +93,7 @@ void copy_from_user_page(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(copy_from_user_page);
 
+#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -116,6 +117,7 @@ void __init mem_init(void)
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 }
+#endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
@@ -160,6 +162,34 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
 	return ret;
 }
 
+#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
+pg_data_t *arch_alloc_nodedata(int nid)
+{
+	return kzalloc(sizeof(pg_data_t), GFP_KERNEL);
+}
+
+void arch_free_nodedata(pg_data_t *pgdat)
+{
+	kfree(pgdat);
+}
+
+void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+	BUG();
+}
+#endif
+
+#ifdef CONFIG_NUMA
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int nid;
+
+	nid = pa_to_nid(start);
+	return nid;
+}
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+#endif
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start,
 		u64 size, struct vmem_altmap *altmap)
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index d6e2f69b9503..2d2a615552b7 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -28,8 +28,10 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	struct pci_config_window *cfg = bridge->bus->sysdata;
 	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct device *bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, pa_to_nid(cfg->res.start));
 
 	return 0;
 }
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 68f36368b0df..25669c3c239a 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -153,6 +153,32 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
+static void pci_root_fix_resbase(struct pci_dev *dev)
+{
+	int node = pcibus_to_node(dev->bus);
+	struct resource *res;
+	struct resource_entry *entry, *window, *tmp;
+	struct pci_host_bridge *bridge = to_pci_host_bridge(dev->bus->bridge);
+
+	resource_list_for_each_entry_safe(entry, tmp, &dev->bus->resources) {
+		res = entry->res;
+
+		if (res->flags & IORESOURCE_MEM) {
+			res->start &= GENMASK_ULL(40, 0);
+			res->end   &= GENMASK_ULL(40, 0);
+		}
+	}
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		if (window->res->flags & IORESOURCE_MEM) {
+			window->offset = nid_to_addrbase(node) | HT1LO_OFFSET;
+			window->res->start |= nid_to_addrbase(node) | HT1LO_OFFSET;
+			window->res->end   |= nid_to_addrbase(node) | HT1LO_OFFSET;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HOST, pci_root_fix_resbase);
+
 static void pci_fixup_vgadev(struct pci_dev *pdev)
 {
 	struct pci_dev *devp = NULL;
-- 
2.27.0

