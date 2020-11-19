Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E132B8917
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKSAik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49091 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgKSAii (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746317; x=1637282317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVYs1x4munyNqisP8RehwwbQA5Cb71FF96jIzbOi7/A=;
  b=bdd/sGJSNrpqoes2B9AustjK9B8RXPLyxKqgvcjotGveXlS/SMdNF7Z+
   uVqQFeWRra5R6bhxLf3dYGHjJvb3OByBI33/NDce3fTC7rYqHtiWqCOSC
   vUwJGOx0Su/gX7Fzg/UPp1jER0GZL/xQrPnedv5461kG3qzmwrwazIhHH
   LrTZetgkqszqOLdejZVSanbJWEhpJLr4RiHFxLhcftEKNlMid4cV10mD8
   MYCL3cakMze1IgLQ7A1hnWH3flHBN8jwsHVstqzIkfSc1FkYzJ33CJ9dl
   8lK2Xzdp+btvQHiZvyFtRGboAtLJH7n8KTrkMWSLGiBO4BI9ouIvNah12
   Q==;
IronPort-SDR: lMk7j3juOHLsyDEjrWNcvQ81ZiXbewxPa7MGG7iDNbaG4V5q4CfyV6nufT3eX51nqn+kev5BbD
 20ZWHkDWSzmhFiCKRTmuUbBePA12lxUTcvfgpYs+Qn3IfUZhyhe2AfaRCNNbnTVlE6aNe1BmjM
 JY2rHfjHVM2YPGaYB2nsXi5X/GEFNbSebMTPVKh2qjruGaEdvsbEmowMpIYwxAkJRQwkZ/gBZr
 Qyjerq0QX9sVFW5bkiE46+Ye/ZGMGhoaUtJ49uqvFPVb+EYo2VNmrNRQWKTNdZ/aMaeCHFZ6jE
 m+A=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974333"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:37 +0800
IronPort-SDR: WKHLE4FqGFbvpUR6TSm9ND+6sWQJPDT56nfl8KVlF1jADN+yt+JuYkk7WF26au7vZK2rq9FI1y
 DVCx6BmCF7BTrJZlJhvDzhnA67t0XmvaAAP2Tq5YtCK6ADr56CKgaNB7sd+DbO6156HX0tDDkz
 AuAWiMlo2+r/o6HWILCCyNVnYS9+hiOzs8QMXpC7X0D1Q3zwMHCeQ3hNHGVER9xznh/UYs/AJA
 M11oYeZ9InxOMyBZDfGeTdOOjQmMOe2AYDiMlnlLxuBqhCJAGnltqmSWtHdqvIjefeLgTt6i2L
 1J07c0Anl5BkcXTXoN6+NN+a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:08 -0800
IronPort-SDR: BDXAQ107e5nYkAadgPiLauOOmd79ned360nZAHxRg1wqiOC/zpBY8BhFU2FaauwYJHhYLIv+56
 5p73aQ+agfwfJGeI939XGTVy8JPxQ0R9cch3t00FYbfu7LPN3up5F91tzw0qyqAzGov27u3UrT
 KMxfCraJgnkQnbcH5DrdgSCNpYwEs4QsmsKFX8qn03H6338Z/QurNN1dB+5WsFiI0Z6WNxdsVj
 EGig8XMnfFNvXg+sCnPDiTfwzWRpUfDMza1GnqPhCSAvIRuAPuKuontM68ROv+b1jVb2aW7/p4
 4kM=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:36 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/5] numa: Move numa implementation to common code
Date:   Wed, 18 Nov 2020 16:38:26 -0800
Message-Id: <20201119003829.1282810-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
References: <20201119003829.1282810-1-atish.patra@wdc.com>
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
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/numa.h                 | 48 +----------------
 arch/arm64/mm/Makefile                        |  1 -
 drivers/base/Kconfig                          |  6 +++
 drivers/base/Makefile                         |  1 +
 .../mm/numa.c => drivers/base/arch_numa.c     |  0
 include/asm-generic/numa.h                    | 52 +++++++++++++++++++
 7 files changed, 61 insertions(+), 48 deletions(-)
 rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (100%)
 create mode 100644 include/asm-generic/numa.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..4ebef80274fd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -990,6 +990,7 @@ config HOTPLUG_CPU
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
+	select GENERIC_ARCH_NUMA
 	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	help
diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index ffc1dcdf1871..8c8cf4297cc3 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -3,52 +3,6 @@
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
-	if (node == NUMA_NO_NODE)
-		return cpu_all_mask;
-
-	return node_to_cpumask_map[node];
-}
-#endif
-
-void __init arch_numa_init(void);
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
-static inline void arch_numa_init(void) { }
-static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
-
-#endif	/* CONFIG_NUMA */
+#include <asm-generic/numa.h>
 
 #endif	/* __ASM_NUMA_H */
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 5ead3c3de3b6..cd60e4fed78f 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -6,7 +6,6 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
-obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
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
index 41369fc7004f..7d65ea07de65 100644
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
index 000000000000..1a3ad6d29833
--- /dev/null
+++ b/include/asm-generic/numa.h
@@ -0,0 +1,52 @@
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
+	if (node == NUMA_NO_NODE)
+		return cpu_all_mask;
+
+	return node_to_cpumask_map[node];
+}
+#endif
+
+void __init arch_numa_init(void);
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
+static inline void arch_numa_init(void) { }
+static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+
+#endif	/* CONFIG_NUMA */
+
+#endif	/* __ASM_GENERIC_NUMA_H */
-- 
2.25.1

