Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF672B891E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKSAip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49094 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKSAil (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746320; x=1637282320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qp8TCYaXaopaPTPsiJ0rVCynZ7BwUesX2w2H35SSgiU=;
  b=b47I2Xz+1vfWPTiW28UqrSkpW8S25/QM9VyL4+OQvh7PkPE9OpGdLbre
   BREUfuel3Cjv7GPEzZiVfdp3UKoRVkMT+uGIWeWXGzbTFC4pakjvAkYME
   LtKFp8Rlw+OKu0WLMzrIru0GtDoI0euwBk6rmxNeKywGP8RJuV6sC4CtW
   X/hEPnwpU1CoA1WHUWUDYKiKdQTXYCdL1RhHALlHGvNkwpW70MRisa6pt
   cbE9Fg5abV/8mVs9z0bF5bi8avsBDg+S9/4agE5TvjVnXwln0vVRL2AZ5
   PDS8pWdFTJURJPRMahplWmEgIEm+glpPTK089Z4l9cazCd7A6E1390PPL
   w==;
IronPort-SDR: 8gtwWmbELWyigf04Pn8mHd4JRvaIOEbTRzsjc4cwLu7NOSaDWdvPBj81YI3XTgALP668YXUEUB
 xX0QcYHQ+CHOQOoH2YgCuIPYz+7RyNW2mi53MNH0m7L5ENG39tmKzT3bvM519mUdjEg1GA/0q/
 uFwIL2upWc0klPz/T7faYvbQQq0y1REBqyVwo53dZsCOUIZTmjTuyRMS/qeS5PbG1WCUBKq4Ec
 nlsHkh9IRYSAGtz10fe95IUMmW4podhkJSKNJ+oKD92R0eSX5tdqNYKZSKNBVY0jwwd5wz+d0/
 W3Q=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974345"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:40 +0800
IronPort-SDR: AC7iUOs4nHSrk+t5r7Pj3rISE+gjIxTn3z2zYFbLYyS6tNSKAn/TsrBq+HG8AI0anDk3huqeh1
 7dkLJ6fojlDXRupgve/+gIk+SfwyNlyOZkx7oDa9eK26BE0tdKPsFiwEP22H9Qqjl59a7CGz6s
 tqpzEE5Hjd9daGQYegCJgZRSQx/VIer5ZqHURw34hsk8X9PLKrAfn/ccfjRW84g6EWciG5kf34
 mF/q9/AyIux3csYni6jYORG94Fc3MpiTmffcscGDFJ/hkEJXJZbAqCBXgN8VNS/OYboXL5wdXG
 lVTRJwfdbfc3tnszDvfwXrrp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:11 -0800
IronPort-SDR: C+KfU0ZzZTBZrm2AmqLQM5wYz0+PjH6Uyaoyh3h1sRHUnq5S+CrHLYeP+KZOv0FTAYZlFbS6Gx
 XUPxV2+47BTMh/xIE32rhmMAT6tNBjdOtULktkr8UZiq2X6ySqp4N0eJrFTOHe6j7WDx8qxJ2T
 lgeBbnGhxi4WUqaTZUHQJrFbPkzWvc3N+hcJYk9o09uzisYvpeMUK79RiCXKSikb+z7E87EaaR
 jq3b36br6G8nQx02W1jb5qN0xBMtJ9dZZ10v83qdsHUbiidSDkqKEv5V2F4LaHK1SRhJAYqNdG
 +PA=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:38 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/5] riscv: Add numa support for riscv64 platform
Date:   Wed, 18 Nov 2020 16:38:29 -0800
Message-Id: <20201119003829.1282810-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
References: <20201119003829.1282810-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
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
index 44377fd7860e..5414fe747f64 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -140,7 +140,7 @@ config PAGE_OFFSET
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	def_bool !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
@@ -298,6 +298,35 @@ config TUNE_GENERIC
 
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
index eb1cbdc29ea7..26712745c5df 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -111,13 +111,19 @@ void __init setup_arch(char **cmdline_p)
 
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
index 826e7de73f45..e1f1b149dfba 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -20,6 +20,7 @@
 #include <asm/soc.h>
 #include <asm/io.h>
 #include <asm/ptdump.h>
+#include <asm/numa.h>
 
 #include "../kernel/head.h"
 
@@ -195,7 +196,6 @@ void __init setup_bootmem(void)
 
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
-	memblock_dump_all();
 }
 
 #ifdef CONFIG_MMU
@@ -669,9 +669,11 @@ void __init paging_init(void)
 
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

