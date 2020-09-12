Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500C0267712
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 03:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgILBfG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 21:35:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13356 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgILBey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 21:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599874495; x=1631410495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JkSJpzvIaD6c9g/5xpC8MP5lV35I6QGKFzDpcrYYtoA=;
  b=UFucOdsPDfQpy1DAIzT7TWEyNDDCkAEyd9Du0IsRiqYC2x7uVI4ZPUZA
   95ZdUgXAbOUvcm0L2FqeHFKaco5Anv+v9Ry5D6tq/7m9Bh/QEXGNApCtn
   ZBYi5rkQfEgIetvGnER2A58p0/jmkleIyV/jTTSDIsaTdNGJJnYDzdxVC
   R2z4tCJnsoy6j5k0v1igymH+bPXD8MDlBOOKIsRPIsqGlx+sWaOmzA7hj
   jamRtIDoTuVqqjEiJ6D+bGKDcXMBlCEsMS/ZpiNKq2kdc0LWV4Sx/e9Wu
   wur/XqTsIosd4Q+/6cz/9YMM6Mo59IWzURXZNvGF19GB7GARNzyZrKuWA
   g==;
IronPort-SDR: K/G3xlfWBxWCT5mSPhgFjmWhqqFsB6QE5Jnayw18VH3vIL1w5v1zcmjqYmA8oY8rv4KYOurfTn
 47k32fCm2QILjeSOjcy6VGPU+1XaEwcLYOUyL04fKBCm7YBMjDXO7KgFST7SfoO5OyxX846aX7
 X0js4rszELejK0FgEPE6idWiA5lZQDlzywcfPLLG+jXh7FXrTwpds1zWrxIQXoUDPfthqENNeA
 YjV0VDOrh4A6wQKoJIPEmZTpmBeHvVqa6a9ZZE8UhFw/xhqjiMXSscD2JsmaSuuilAIIIE16wi
 L24=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147177963"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 09:34:50 +0800
IronPort-SDR: 3LOLVja06A0hmdmkFZUptBSaxQcbxzHAPfTsI2/XYeoUMp+8BnxFc6rnekAjAfyhL+ycGosAx0
 0FgFPzxixrFg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 18:22:04 -0700
IronPort-SDR: au43y8yvcMAKuIcwxIiE9zPcVwxZdxmh9+KeLC62rL5Nr/sxoxnIDjhf24+clJ06XxG8ooG1wl
 GH4g/3IHqz9Q==
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.hgst.com) ([10.86.59.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 18:34:48 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC/RFT PATCH v2 5/5] riscv: Add numa support for riscv64 platform
Date:   Fri, 11 Sep 2020 18:34:41 -0700
Message-Id: <20200912013441.9730-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200912013441.9730-1-atish.patra@wdc.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the generic numa implementation to add NUMA support for RISC-V.
This is based on Greentime's patch[1] but modified to use generic NUMA
implementation and few more fixes.

[1] https://lkml.org/lkml/2020/1/10/233

Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig              | 31 ++++++++++++++++++++++++++++++-
 arch/riscv/include/asm/mmzone.h | 13 +++++++++++++
 arch/riscv/include/asm/numa.h   |  8 ++++++++
 arch/riscv/include/asm/pci.h    | 14 ++++++++++++++
 arch/riscv/kernel/setup.c       | 10 ++++++++--
 arch/riscv/kernel/smpboot.c     | 12 +++++++++++-
 arch/riscv/mm/init.c            |  4 +++-
 7 files changed, 87 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/include/asm/mmzone.h
 create mode 100644 arch/riscv/include/asm/numa.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372861d8..7beb6ddb6eb1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -137,7 +137,7 @@ config PAGE_OFFSET
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	def_bool !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
@@ -295,6 +295,35 @@ config TUNE_GENERIC
 
 endchoice
 
+# Common NUMA Features
+config NUMA
+	bool "NUMA Memory Allocation and Scheduler Support"
+	select GENERIC_ARCH_NUMA
+	select OF_NUMA
+	select ARCH_SUPPORTS_NUMA_BALANCING
+	help
+	  Enable NUMA (Non-Uniform Memory Access) support.
+
+	  The kernel will try to allocate memory used by a CPU on the
+	  local memory of the CPU and add some more NUMA awareness to the kernel.
+
+config NODES_SHIFT
+	int "Maximum NUMA Nodes (as a power of 2)"
+	range 1 10
+	default "2"
+	depends on NEED_MULTIPLE_NODES
+	help
+	  Specify the maximum number of NUMA Nodes available on the target
+	  system.  Increases memory reserved to accommodate various tables.
+
+config USE_PERCPU_NUMA_NODE_ID
+	def_bool y
+	depends on NUMA
+
+config NEED_PER_CPU_EMBED_FIRST_CHUNK
+	def_bool y
+	depends on NUMA
+
 config RISCV_ISA_C
 	bool "Emit compressed instructions when building Linux"
 	default y
diff --git a/arch/riscv/include/asm/mmzone.h b/arch/riscv/include/asm/mmzone.h
new file mode 100644
index 000000000000..fa17e01d9ab2
--- /dev/null
+++ b/arch/riscv/include/asm/mmzone.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMZONE_H
+#define __ASM_MMZONE_H
+
+#ifdef CONFIG_NUMA
+
+#include <asm/numa.h>
+
+extern struct pglist_data *node_data[];
+#define NODE_DATA(nid)		(node_data[(nid)])
+
+#endif /* CONFIG_NUMA */
+#endif /* __ASM_MMZONE_H */
diff --git a/arch/riscv/include/asm/numa.h b/arch/riscv/include/asm/numa.h
new file mode 100644
index 000000000000..8c8cf4297cc3
--- /dev/null
+++ b/arch/riscv/include/asm/numa.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NUMA_H
+#define __ASM_NUMA_H
+
+#include <asm/topology.h>
+#include <asm-generic/numa.h>
+
+#endif	/* __ASM_NUMA_H */
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index 1c473a1bd986..658e112c3ce7 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -32,6 +32,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	/* always show the domain in /proc */
 	return 1;
 }
+
+#ifdef	CONFIG_NUMA
+
+static inline int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+#ifndef cpumask_of_pcibus
+#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
+				 cpu_all_mask :				\
+				 cpumask_of_node(pcibus_to_node(bus)))
+#endif
+#endif	/* CONFIG_NUMA */
+
 #endif  /* CONFIG_PCI */
 
 #endif  /* _ASM_RISCV_PCI_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 07fa6d13367e..53a806a9cbaf 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -101,13 +101,19 @@ void __init setup_arch(char **cmdline_p)
 
 static int __init topology_init(void)
 {
-	int i;
+	int i, ret;
+
+	for_each_online_node(i)
+		register_one_node(i);
 
 	for_each_possible_cpu(i) {
 		struct cpu *cpu = &per_cpu(cpu_devices, i);
 
 		cpu->hotpluggable = cpu_has_hotplug(i);
-		register_cpu(cpu, i);
+		ret = register_cpu(cpu, i);
+		if (unlikely(ret))
+			pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
+			       __func__, i, ret);
 	}
 
 	return 0;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 96167d55ed98..5e276c25646f 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -27,6 +27,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
+#include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
@@ -45,13 +46,18 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
 	int ret;
+	unsigned int curr_cpuid;
+
+	curr_cpuid = smp_processor_id();
+	numa_store_cpu_info(curr_cpuid);
+	numa_add_cpu(curr_cpuid);
 
 	/* This covers non-smp usecase mandated by "nosmp" option */
 	if (max_cpus == 0)
 		return;
 
 	for_each_possible_cpu(cpuid) {
-		if (cpuid == smp_processor_id())
+		if (cpuid == curr_cpuid)
 			continue;
 		if (cpu_ops[cpuid]->cpu_prepare) {
 			ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
@@ -59,6 +65,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 				continue;
 		}
 		set_cpu_present(cpuid, true);
+		numa_store_cpu_info(cpuid);
 	}
 }
 
@@ -79,6 +86,7 @@ void __init setup_smp(void)
 		if (hart == cpuid_to_hartid_map(0)) {
 			BUG_ON(found_boot_cpu);
 			found_boot_cpu = 1;
+			early_map_cpu_to_node(0, of_node_to_nid(dn));
 			continue;
 		}
 		if (cpuid >= NR_CPUS) {
@@ -88,6 +96,7 @@ void __init setup_smp(void)
 		}
 
 		cpuid_to_hartid_map(cpuid) = hart;
+		early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
 		cpuid++;
 	}
 
@@ -153,6 +162,7 @@ asmlinkage __visible void smp_callin(void)
 	current->active_mm = mm;
 
 	notify_cpu_starting(curr_cpuid);
+	numa_add_cpu(curr_cpuid);
 	update_siblings_masks(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8f31a5428ce4..bc484babb9ca 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -20,6 +20,7 @@
 #include <asm/soc.h>
 #include <asm/io.h>
 #include <asm/ptdump.h>
+#include <asm/numa.h>
 
 #include "../kernel/head.h"
 
@@ -188,7 +189,6 @@ void __init setup_bootmem(void)
 
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
-	memblock_dump_all();
 
 	for_each_memblock(memory, reg) {
 		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
@@ -573,9 +573,11 @@ void __init paging_init(void)
 
 void __init misc_mem_init(void)
 {
+	arch_numa_init();
 	sparse_init();
 	zone_sizes_init();
 	resource_init();
+	memblock_dump_all();
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-- 
2.24.0

