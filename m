Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1D2706EC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIRUWu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:22:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4416 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRUWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:50 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:22:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460586; x=1631996586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WAdWz6nJXVK//UTGtZE/lOxWJrdXDKaNN7nBR7X7FM=;
  b=bdtXsocUWlN6Az1j2hZFQL7mrH1TOAnZg8myeI7XtEY4LKeW1zG2Ondf
   PnCvMbgnwVXIrXKjHbF3DlaoCag6eEXd1u97Sozd0YqtHDBCYSYdhBx6u
   UvAWPrbNAogCcw1R+MhkEeObabhjhX88Pwc9gMebSQL4S6QA629nktXk0
   hRDcj2ztU6qMNW3gjw0G2qWY+Udid26Pf3ujCxrMl//iy1J5dFftmt7JO
   EpvaRievWZQ86x73kVnNMlwTFHu5Geuk0lkXAZ39eni6gb3KJ943uA/23
   BcAKRBPC2j0NAfk+0/UUGcFNmOCTFM0kYZ1DGTk4q3bcqWCJB3eMjzxj4
   w==;
IronPort-SDR: vVV04U/uutdKR0bBvS5lbxHqBlmko3DOb4+bBphqxMZtQxf7400NKtdRWZibXG2sH6BMxCo2Tt
 cpjpa0vaJig3iwmzDpGBXVgeW13W022Qrup3PFVH0QoiW5Zr/YGEpWKjPI+ZqJVvjQE9b9sLvw
 8oSaWr4Upj/zcnnPxr240tgKFCADr7eNc10DZ+HAko942y5ErSmBMjgA3SPr2b2b0BqlL4QI7O
 XP7lfGE3SWynHm9w7eSJWpAJPpAlMKVgJXm/yZyzlJrFcSnAZirhzoBikUYPg+ZHwd+rbV0UKb
 Gbk=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108772"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:52 +0800
IronPort-SDR: QaBE9+eu5LlA+VTC791dHjuGdYV5E4uwKdhRfXTt6g0tfCqAAPZ/D4MV3QNSfsAks++vhoTyq6
 fVGyFVcoaHbA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:54 -0700
IronPort-SDR: DMb2uTD4wMKHEOgFNBFBayyBMMu5KqAF5Zo/x/fEnMTwHXZt5/QIdAAg2qe/pAJRoEVl21a86Q
 pR3Ox3ZZBsyA==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:48 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 1/5] numa: Move numa implementation to common code
Date:   Fri, 18 Sep 2020 13:11:36 -0700
Message-Id: <20200918201140.3172284-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 numa implementation is generic enough that RISC-V can reuse that
implementation with very minor cosmetic changes. This will help both
ARM64 and RISC-V in terms of maintanace and feature improvement

Move the numa implementation code to common directory so that both ISAs
can reuse this. This doesn't introduce any function changes for ARM64.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/numa.h                 | 45 +----------------
 arch/arm64/mm/Makefile                        |  1 -
 drivers/base/Kconfig                          |  6 +++
 drivers/base/Makefile                         |  1 +
 .../mm/numa.c => drivers/base/arch_numa.c     |  0
 include/asm-generic/numa.h                    | 49 +++++++++++++++++++
 7 files changed, 58 insertions(+), 45 deletions(-)
 rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (100%)
 create mode 100644 include/asm-generic/numa.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..955a0cf75b16 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -960,6 +960,7 @@ config HOTPLUG_CPU
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
+	select GENERIC_ARCH_NUMA
 	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	help
diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 626ad01e83bf..8c8cf4297cc3 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -3,49 +3,6 @@
 #define __ASM_NUMA_H
 
 #include <asm/topology.h>
-
-#ifdef CONFIG_NUMA
-
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
-
-int __node_distance(int from, int to);
-#define node_distance(a, b) __node_distance(a, b)
-
-extern nodemask_t numa_nodes_parsed __initdata;
-
-extern bool numa_off;
-
-/* Mappings between node number and cpus on that node. */
-extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
-void numa_clear_node(unsigned int cpu);
-
-#ifdef CONFIG_DEBUG_PER_CPU_MAPS
-const struct cpumask *cpumask_of_node(int node);
-#else
-/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
-static inline const struct cpumask *cpumask_of_node(int node)
-{
-	return node_to_cpumask_map[node];
-}
-#endif
-
-void __init arm64_numa_init(void);
-int __init numa_add_memblk(int nodeid, u64 start, u64 end);
-void __init numa_set_distance(int from, int to, int distance);
-void __init numa_free_distance(void);
-void __init early_map_cpu_to_node(unsigned int cpu, int nid);
-void numa_store_cpu_info(unsigned int cpu);
-void numa_add_cpu(unsigned int cpu);
-void numa_remove_cpu(unsigned int cpu);
-
-#else	/* CONFIG_NUMA */
-
-static inline void numa_store_cpu_info(unsigned int cpu) { }
-static inline void numa_add_cpu(unsigned int cpu) { }
-static inline void numa_remove_cpu(unsigned int cpu) { }
-static inline void arm64_numa_init(void) { }
-static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
-
-#endif	/* CONFIG_NUMA */
+#include <asm-generic/numa.h>
 
 #endif	/* __ASM_NUMA_H */
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index d91030f0ffee..928c308b044b 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -6,7 +6,6 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
-obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 KASAN_SANITIZE_physaddr.o	+= n
 
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 8d7001712062..c5956c8845cc 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
 	  appropriate scaling, sysfs interface for reading capacity values at
 	  runtime.
 
+config GENERIC_ARCH_NUMA
+	bool
+	help
+	  Enable support for generic NUMA implementation. Currently, RISC-V
+	  and ARM64 uses it.
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 157452080f3d..c3d02c644222 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
+obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 
 obj-y			+= test/
 
diff --git a/arch/arm64/mm/numa.c b/drivers/base/arch_numa.c
similarity index 100%
rename from arch/arm64/mm/numa.c
rename to drivers/base/arch_numa.c
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
new file mode 100644
index 000000000000..2718d5a6ff03
--- /dev/null
+++ b/include/asm-generic/numa.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_NUMA_H
+#define __ASM_GENERIC_NUMA_H
+
+#ifdef CONFIG_NUMA
+
+#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
+
+int __node_distance(int from, int to);
+#define node_distance(a, b) __node_distance(a, b)
+
+extern nodemask_t numa_nodes_parsed __initdata;
+
+extern bool numa_off;
+
+/* Mappings between node number and cpus on that node. */
+extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
+void numa_clear_node(unsigned int cpu);
+
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+const struct cpumask *cpumask_of_node(int node);
+#else
+/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
+static inline const struct cpumask *cpumask_of_node(int node)
+{
+	return node_to_cpumask_map[node];
+}
+#endif
+
+void __init arm64_numa_init(void);
+int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+void __init numa_set_distance(int from, int to, int distance);
+void __init numa_free_distance(void);
+void __init early_map_cpu_to_node(unsigned int cpu, int nid);
+void numa_store_cpu_info(unsigned int cpu);
+void numa_add_cpu(unsigned int cpu);
+void numa_remove_cpu(unsigned int cpu);
+
+#else	/* CONFIG_NUMA */
+
+static inline void numa_store_cpu_info(unsigned int cpu) { }
+static inline void numa_add_cpu(unsigned int cpu) { }
+static inline void numa_remove_cpu(unsigned int cpu) { }
+static inline void arm64_numa_init(void) { }
+static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+
+#endif	/* CONFIG_NUMA */
+
+#endif	/* __ASM_GENERIC_NUMA_H */
-- 
2.25.1

