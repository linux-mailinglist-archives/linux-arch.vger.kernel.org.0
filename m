Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E909A244FA3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgHNVsb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25018 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHNVsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441710; x=1628977710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJ0t1sPROiBG0ybrpqvJwUR8k08JOqtJS9YP0pE5HbI=;
  b=V/81DogkkHth2qGkYWWRDe/4HCQMWnkMT3MBVCUuY4bV3Egx4kSOxnDO
   MBXKHInKyw1bEOG4k/Y/sfcwkBjNeP3FMBd/OD42L7aSxpGbhNSEfe0W7
   R3JGOSzdW3VLzvtFqmGtwB39DfcU/5v+o5rIeO7fn2cb7sjRmAjVLlQhp
   h9ky4LjGsaOE+foQP47N1UMOmQkPHHC3ABXTuY1gRpodhwc/+oqcUrGbi
   Sa4B2nXY/CcQ1acnsgGUOLutTxK52MRF+RwzColNsgTVrSdwSrNcOzORy
   Gk7308wZOewSm0h6w1AlfMsFUOWOormaoV0x4byBAraIXgG1yy0TQApmt
   w==;
IronPort-SDR: F9oERQ4+ZoVe8td8EYGwnYjFA1kFXeZhqm0ISZFkvoZdYFYco+qISZojLnBEG7fRalg+WrlWnR
 Q0La31+mDzKDDPJzQQIZLGj5kbzVWWX+RZLMdBIfFGnjat7Tdyu6Ap5Fm5c5cX1W0ZFw7gu8jf
 uUPKG6tjnY7Yg6x4lRyd+7PwQ8LZY2a4/FB9bQeOCMZV01smCQnM5Dlg8L1/CVX9f7Nzciwq17
 ePalmAoJc+m8k1ynpAfDTpwFNtIQnRuIZ51coTtkt/nxdK72+O0cSym1oJdGgADMrUeiIcG72J
 7hM=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217643"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:29 +0800
IronPort-SDR: prg0Il37RT0hE/Hont5b/EH7QFqM+n1C/Q4UyTIMgwo7G5Drxp/tpK2ZgyDdzuiiaH1ZWx0F8t
 qIu7eYMy1Myw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:34 -0700
IronPort-SDR: xffce0VAhCB97N3lScrDgWYFuEDqStOodwz6NuYrdbRda0C1irpZ5qtGu/MYexgJM39mnWmD8l
 W9+3tcwmpHpA==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:27 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common code
Date:   Fri, 14 Aug 2020 14:47:20 -0700
Message-Id: <20200814214725.28818-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200814214725.28818-1-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 numa implementation is generic enough that RISC-V can reuse that
implementation with very minor cosmetic changes. This will help both
ARM64 and RISC-V in terms of maintanace and feature improvement

Move the numa implementation code to common directory so that both ISAs
can reuse this. This doesn't introduce any function changes for ARM64.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/numa.h                 | 45 +---------------
 arch/arm64/mm/Makefile                        |  1 -
 drivers/base/Kconfig                          |  6 +++
 drivers/base/Makefile                         |  1 +
 .../mm/numa.c => drivers/base/arch_numa.c     |  0
 include/asm-generic/numa.h                    | 51 +++++++++++++++++++
 7 files changed, 60 insertions(+), 45 deletions(-)
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
index 8d7001712062..73c2151de194 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
 	  appropriate scaling, sysfs interface for reading capacity values at
 	  runtime.
 
+config GENERIC_ARCH_NUMA
+	bool
+	help
+	  Enable support for generic numa implementation. Currently, RISC-V
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
index 000000000000..0635c0724b7c
--- /dev/null
+++ b/include/asm-generic/numa.h
@@ -0,0 +1,51 @@
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
+#include <asm/topology.h>
+
+#endif	/* __ASM_GENERIC_NUMA_H */
-- 
2.24.0

