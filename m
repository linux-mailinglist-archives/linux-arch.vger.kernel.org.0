Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF82706EE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIRUXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:23:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4416 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRUWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:53 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:22:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460590; x=1631996590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEM2YpjTYs5tWM9BBH2qcr+4GjK6yIjG9J+n45VG2/0=;
  b=ef/kdj+CJuL1Pt207/PwY3XI2FG+lTuDgGBHcjUWZ7tyL2yUGiB8ylZt
   AmTiKyJ6NWx0XN8lbu12KdBlF0JeO3vJ6BKrKgnARMe3FYm9DFUQyAPio
   7LWSjwxhH2hbPfe8SVIPw9+Slqtye6v8NofC4BcjcwLy2baRv4jlDpdPp
   2zlbiViVv4cyFUGvCuDuaCdFRv6uhxZ3QDNn7213sPSmVd4xiRUMDzsMa
   8LneNPoKhJh/4GI20yoy55fSA8sWZIlmYr/OR71bXr9bCPPFmYyeJ8/2j
   74G9qfrWj7c2iMk5f0Ls1DvMjU6KBMoVpB6BbKPCkm+RGaPAdLleifnsK
   A==;
IronPort-SDR: Lb2xXrKxPXcG1O0YKN/jj6uQlGWv0DHdh8jQF24AhY7yiOEwbImMyz8409hVvIeN9vMgccT0wY
 YVSjAf//kzOZHhPjti2+FdUjz8k6uS+AIqjvVmnK+mJyVEFiqXWZ8puVwvkXp3/gIJFRhDFihh
 yU0LVCvEMIdhTywe2ci6zlzaaV4uT+D8S2iBqRk1nEfGbFLN6HM9piHg2J5WzKyDX/vwczN7bI
 dk8TdfPlfsuGBiunQRBd+kZPZ3vUFh1kdbcNSko7lujLMx75ACv0dGmFgBfWWTEARCUxy76cRg
 B6E=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108789"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:58 +0800
IronPort-SDR: /M0Uw/kGXQyZYoM5UQD3PqWp935b0/kxp+CQTPxsiwIcassGfqeXaH2tbn5W5CZkJMQgyOI3kY
 a63rCKNzlaoQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:58 -0700
IronPort-SDR: DOIe2arwMVrtn5beBgWsxJU+Nzpk3DynygzFVNIY0XAAz4v8c6Rf48cLWLkiOMeJAQxIRR0aoH
 NCfIgHickr0w==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:51 -0700
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 5/5] riscv: Add numa support for riscv64 platform
Date:   Fri, 18 Sep 2020 13:11:40 -0700
Message-Id: <20200918201140.3172284-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 114c3966aadb..c4046e11d264 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -20,6 +20,7 @@
 #include <asm/soc.h>
 #include <asm/io.h>
 #include <asm/ptdump.h>
+#include <asm/numa.h>
 
 #include "../kernel/head.h"
 
@@ -185,7 +186,6 @@ void __init setup_bootmem(void)
 
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
-	memblock_dump_all();
 
 	for_each_memblock(memory, reg) {
 		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
@@ -570,9 +570,11 @@ void __init paging_init(void)
 
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
2.25.1

