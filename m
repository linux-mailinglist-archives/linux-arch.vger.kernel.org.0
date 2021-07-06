Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E703BC543
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFEYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEYT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09EE460238;
        Tue,  6 Jul 2021 04:21:37 +0000 (UTC)
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
Subject: [PATCH 18/19] LoongArch: Add Non-Uniform Memory Access (NUMA) support
Date:   Tue,  6 Jul 2021 12:18:19 +0800
Message-Id: <20210706041820.1536502-19-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds Non-Uniform Memory Access (NUMA) support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                        |  43 ++
 arch/loongarch/include/asm/bootinfo.h         |  12 +
 .../include/asm/mach-loongson64/topology.h    |  26 +
 arch/loongarch/include/asm/mmzone.h           |  18 +
 arch/loongarch/include/asm/numa.h             |  69 +++
 arch/loongarch/include/asm/pgtable.h          |  12 +
 arch/loongarch/include/asm/topology.h         |   1 +
 arch/loongarch/kernel/acpi.c                  |  96 ++++
 arch/loongarch/kernel/module.c                |   1 +
 arch/loongarch/kernel/setup.c                 |   5 +-
 arch/loongarch/kernel/smp.c                   |  29 +-
 arch/loongarch/kernel/topology.c              |   5 +
 arch/loongarch/loongson64/Makefile            |   4 +-
 arch/loongarch/loongson64/dma.c               |  59 +++
 arch/loongarch/loongson64/init.c              |   4 +
 arch/loongarch/loongson64/irq.c               |   1 +
 arch/loongarch/loongson64/numa.c              | 488 ++++++++++++++++++
 arch/loongarch/loongson64/smp.c               |   6 +
 arch/loongarch/mm/init.c                      |  30 ++
 arch/loongarch/pci/acpi.c                     |   5 +-
 arch/loongarch/pci/pci-loongson.c             |  41 +-
 21 files changed, 945 insertions(+), 10 deletions(-)
 create mode 100644 arch/loongarch/include/asm/mach-loongson64/topology.h
 create mode 100644 arch/loongarch/include/asm/mmzone.h
 create mode 100644 arch/loongarch/include/asm/numa.h
 create mode 100644 arch/loongarch/loongson64/dma.c
 create mode 100644 arch/loongarch/loongson64/numa.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 74beb370d943..4ecc98b16fee 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -37,6 +37,7 @@ config LOONGARCH
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_QUEUED_RWLOCKS
@@ -120,6 +121,7 @@ config MACH_LOONGSON64
 	select SYS_HAS_CPU_LOONGSON64
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
+	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select ZONE_DMA32
 	help
@@ -165,6 +167,7 @@ choice
 config CPU_LOONGSON64
 	bool "Loongson 64-bit CPU"
 	depends on SYS_HAS_CPU_LOONGSON64
+	select ARCH_HAS_PHYS_TO_DMA
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select GPIOLIB
 	select SWIOTLB
@@ -292,6 +295,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
+	depends on !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
@@ -302,6 +306,41 @@ config ARCH_SPARSEMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa.rst> for more.
 
+config NUMA
+	bool "NUMA Support"
+	depends on SYS_SUPPORTS_NUMA
+	select ACPI_NUMA if ACPI
+	help
+	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
+	  Access).  This option improves performance on systems with more
+	  than two nodes; on two node systems it is generally better to
+	  leave it disabled; on single node systems disable this option
+	  disabled.
+
+config SYS_SUPPORTS_NUMA
+	bool
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
 config DMI
 	bool "Enable DMI scanning"
 	select DMI_SCAN_MACHINE_NON_EFI_FALLBACK
@@ -431,6 +470,10 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config HAVE_ARCH_NODEDATA_EXTENSION
+	def_bool y
+	depends on NUMA && ARCH_ENABLE_MEMORY_HOTPLUG
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index aa9915a56f66..a6a3dbc03b8c 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -35,4 +35,16 @@ extern unsigned long initrd_start, initrd_end;
  */
 extern void plat_mem_setup(void);
 
+#ifdef CONFIG_SWIOTLB
+/*
+ * Optional platform hook to call swiotlb_setup().
+ */
+extern void plat_swiotlb_setup(void);
+
+#else
+
+static inline void plat_swiotlb_setup(void) {}
+
+#endif /* CONFIG_SWIOTLB */
+
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/loongarch/include/asm/mach-loongson64/topology.h b/arch/loongarch/include/asm/mach-loongson64/topology.h
new file mode 100644
index 000000000000..2bfad6a6ce30
--- /dev/null
+++ b/arch/loongarch/include/asm/mach-loongson64/topology.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_MACH_TOPOLOGY_H
+#define _ASM_MACH_TOPOLOGY_H
+
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
+#endif /* _ASM_MACH_TOPOLOGY_H */
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
index 0458684c3d24..bc9d1f114a10 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -433,6 +433,18 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
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
index bc541a723f8a..1bb5aacf4801 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -5,6 +5,7 @@
 #ifndef __ASM_TOPOLOGY_H
 #define __ASM_TOPOLOGY_H
 
+#include <topology.h>
 #include <linux/smp.h>
 
 #ifdef CONFIG_SMP
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 3c300e53d724..ee334b60e652 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -13,6 +13,7 @@
 #include <linux/irqdomain.h>
 #include <linux/memblock.h>
 #include <asm/io.h>
+#include <asm/numa.h>
 #include <loongson.h>
 
 int acpi_disabled;
@@ -349,6 +350,80 @@ int __init acpi_boot_init(void)
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
@@ -363,6 +438,22 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 
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
@@ -373,6 +464,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu
 		return cpu;
 	}
 
+	acpi_map_cpu2node(handle, cpu, physid);
+
 	*pcpu = cpu;
 
 	return 0;
@@ -381,6 +474,9 @@ EXPORT_SYMBOL(acpi_map_cpu);
 
 int acpi_unmap_cpu(int cpu)
 {
+#ifdef CONFIG_ACPI_NUMA
+	set_cpuid_to_node(cpu_logical_map(cpu), NUMA_NO_NODE);
+#endif
 	set_cpu_present(cpu, false);
 	num_processors--;
 
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
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 0ae24254c304..ed5b3680e49e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -302,8 +302,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
+#ifndef CONFIG_NUMA
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
-
+#endif
 	bootmem_init();
 
 	/*
@@ -325,7 +326,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	sparse_init();
 	memblock_set_bottom_up(true);
 
-	swiotlb_init(1);
+	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 7532b0b6f2f8..bb55cc2a0d4a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <asm/processor.h>
 #include <asm/idle.h>
 #include <asm/mmu_context.h>
+#include <asm/numa.h>
 #include <asm/time.h>
 #include <asm/setup.h>
 
@@ -217,14 +218,36 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
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
 
diff --git a/arch/loongarch/loongson64/Makefile b/arch/loongarch/loongson64/Makefile
index b7697cfa2775..48f44abb88ff 100644
--- a/arch/loongarch/loongson64/Makefile
+++ b/arch/loongarch/loongson64/Makefile
@@ -3,8 +3,10 @@
 #
 
 obj-y += setup.o init.o env.o reset.o irq.o mem.o \
-	 rtc.o boardinfo.o
+	 dma.o rtc.o boardinfo.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
+obj-$(CONFIG_NUMA)	+= numa.o
+
 obj-$(CONFIG_PCI_MSI)	+= msi.o
diff --git a/arch/loongarch/loongson64/dma.c b/arch/loongarch/loongson64/dma.c
new file mode 100644
index 000000000000..f259f70c75fa
--- /dev/null
+++ b/arch/loongarch/loongson64/dma.c
@@ -0,0 +1,59 @@
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
+#include <loongson.h>
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
+struct loongson_addr_xlate_ops {
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+};
+struct loongson_addr_xlate_ops xlate_ops;
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
diff --git a/arch/loongarch/loongson64/init.c b/arch/loongarch/loongson64/init.c
index 40aa010c4976..e0f528e69d97 100644
--- a/arch/loongarch/loongson64/init.c
+++ b/arch/loongarch/loongson64/init.c
@@ -130,7 +130,11 @@ void __init platform_init(void)
 #endif
 	loongarch_pci_ops = &ls7a_pci_ops;
 
+#ifndef CONFIG_NUMA
 	fw_init_memory();
+#else
+	fw_init_numa_memory();
+#endif
 	dmi_setup();
 	smbios_parse();
 	pr_info("The BIOS Version: %s\n", b_info.bios_version);
diff --git a/arch/loongarch/loongson64/irq.c b/arch/loongarch/loongson64/irq.c
index a1e0bdebdf30..997c2dfed898 100644
--- a/arch/loongarch/loongson64/irq.c
+++ b/arch/loongarch/loongson64/irq.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <asm/irq.h>
+#include <asm/numa.h>
 #include <asm/setup.h>
 #include <asm/loongarchregs.h>
 #include <loongson.h>
diff --git a/arch/loongarch/loongson64/numa.c b/arch/loongarch/loongson64/numa.c
new file mode 100644
index 000000000000..6009a2946e24
--- /dev/null
+++ b/arch/loongarch/loongson64/numa.c
@@ -0,0 +1,488 @@
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
+#include <linux/pci.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/sections.h>
+#include <linux/irq.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <boot_param.h>
+#include <loongson.h>
+#include <asm/numa.h>
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
+	pagetable_init();
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
+	struct pci_controller *pc = bus->sysdata;
+
+	return pc->node;
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
diff --git a/arch/loongarch/loongson64/smp.c b/arch/loongarch/loongson64/smp.c
index 8b7d6dcf1315..2487769c7850 100644
--- a/arch/loongarch/loongson64/smp.c
+++ b/arch/loongarch/loongson64/smp.c
@@ -214,6 +214,9 @@ static void loongson3_init_secondary(void)
 	else
 		xconf_writel(0xffffffff, ipi_en_regs[cpu_logical_map(cpu)]);
 
+#ifdef CONFIG_NUMA
+	numa_add_cpu(cpu);
+#endif
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
 	cpu_set_core(&cpu_data[cpu],
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package);
@@ -314,6 +317,9 @@ static int loongson3_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
+#ifdef CONFIG_NUMA
+	numa_remove_cpu(cpu);
+#endif
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index e661017ca23e..774312ffc75e 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -93,6 +93,7 @@ void copy_from_user_page(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(copy_from_user_page);
 
+#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -118,6 +119,7 @@ void __init mem_init(void)
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 }
+#endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
@@ -162,6 +164,34 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
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
index 68e4c3f5e88f..f65f7e787bb9 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -11,6 +11,7 @@
 #include <linux/pci-acpi.h>
 
 #include <asm/pci.h>
+#include <asm/numa.h>
 #include <loongson.h>
 
 struct pci_root_info {
@@ -115,7 +116,7 @@ static void init_controller_resources(struct pci_controller *controller,
 	struct resource_entry *entry, *tmp;
 	struct resource *res;
 
-	controller->io_map_base = loongarch_io_port_base;
+	controller->io_map_base = loongarch_io_port_base | nid_to_addrbase(controller->node);
 
 	resource_list_for_each_entry_safe(entry, tmp, &bus->resources) {
 		res = entry->res;
@@ -155,7 +156,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!controller->mcfg_addr)
 		controller->mcfg_addr = mcfg_addr_init(controller->index);
 
-	controller->node = 0;
+	controller->node = pa_to_nid(controller->mcfg_addr);
 
 	bus = pci_find_bus(domain, busnum);
 	if (bus) {
diff --git a/arch/loongarch/pci/pci-loongson.c b/arch/loongarch/pci/pci-loongson.c
index e74f887a330e..bc1bc2b36293 100644
--- a/arch/loongarch/pci/pci-loongson.c
+++ b/arch/loongarch/pci/pci-loongson.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
 
+#include <asm/numa.h>
 #include <loongson.h>
 
 #define PCI_ACCESS_READ  0
@@ -17,6 +18,7 @@ static int ls7a_pci_config_access(unsigned char access_type,
 		struct pci_bus *bus, unsigned int devfn,
 		int where, u32 *data)
 {
+	int node = pcibus_to_node(bus);
 	unsigned char busnum = bus->number;
 	int device = PCI_SLOT(devfn);
 	int function = PCI_FUNC(devfn);
@@ -29,7 +31,7 @@ static int ls7a_pci_config_access(unsigned char access_type,
 	 * device 2: misc, device 21: confbus
 	 */
 	if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
-		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		addr = nid_to_addrbase(node) | (busnum << 16) | (device << 11) | (function << 8) | reg;
 		if (busnum == 0) {
 			if (device > 23 || (device >= 9 && device <= 20 && function == 1))
 				return PCIBIOS_DEVICE_NOT_FOUND;
@@ -39,7 +41,7 @@ static int ls7a_pci_config_access(unsigned char access_type,
 		}
 	} else if (where < PCI_CFG_SPACE_EXP_SIZE) {  /* extended config */
 		reg = (reg & 0xff) | ((reg & 0xf00) << 16);
-		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		addr = nid_to_addrbase(node) | (busnum << 16) | (device << 11) | (function << 8) | reg;
 		if (busnum == 0) {
 			if (device > 23 || (device >= 9 && device <= 20 && function == 1))
 				return PCIBIOS_DEVICE_NOT_FOUND;
@@ -114,6 +116,41 @@ struct pci_ops ls7a_pci_ops = {
 	.write = ls7a_pci_pcibios_write
 };
 
+static void pci_root_fix_resbase(struct pci_dev *dev)
+{
+	struct resource *res;
+	struct resource_entry *entry, *tmp;
+
+	resource_list_for_each_entry_safe(entry, tmp, &dev->bus->resources) {
+		res = entry->res;
+
+		if (res->flags & IORESOURCE_MEM) {
+			res->start &= GENMASK_ULL(40, 0);
+			res->end   &= GENMASK_ULL(40, 0);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HOST, pci_root_fix_resbase);
+
+static void pci_device_fix_resbase(struct pci_dev *dev)
+{
+	int i, node = pcibus_to_node(dev->bus);
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!node && (r->flags & IORESOURCE_IO))
+			continue;
+
+		if (r->flags & (IORESOURCE_MEM | IORESOURCE_IO)) {
+			r->start |= nid_to_addrbase(node) | HT1LO_OFFSET;
+			r->end   |= nid_to_addrbase(node) | HT1LO_OFFSET;
+		}
+
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, pci_device_fix_resbase);
+
 static void pci_fixup_vgadev(struct pci_dev *pdev)
 {
 	struct pci_dev *devp = NULL;
-- 
2.27.0

