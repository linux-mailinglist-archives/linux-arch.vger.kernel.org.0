Return-Path: <linux-arch+bounces-5421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4C932564
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26926B25619
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E51993A3;
	Tue, 16 Jul 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbP8A0lE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDF19922C;
	Tue, 16 Jul 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128609; cv=none; b=VPe+2s0+woeBuiquSWeeYpYDtDwktIFj3tLvws4FpAwQ+x+RO8d0xoBhsPmSsv3jRXcK1DuBDzs0sJiKVbVrPydasbIWi9I5cHclZLlgnkaGXAmWsqVXh5cdUk7NYYLeEcd7PUz3/iLB9gPenl0+IzdipvV32CwtW9WXwKFiZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128609; c=relaxed/simple;
	bh=cw/dvVFpXQw8UFABdX3d8CGu73vGiQNRy5vsiOPnGKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc6n4izkTBjUnQIQshdM57sfrnqUJEfSww2IiRo8a25Zqhl3v1PagUs+XIkHEk7lVbuByBGLsDACDndCYwCCwoKdxiV3VMVL8Qcw9IHyB9d04/TmIBM/hHeqaGS8NEDBSOQUEexn8oNuyeuM7GrrYM/9Fp6qW7ZKRxWa0ZrimaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbP8A0lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC11C4AF0D;
	Tue, 16 Jul 2024 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128608;
	bh=cw/dvVFpXQw8UFABdX3d8CGu73vGiQNRy5vsiOPnGKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbP8A0lEpqUTNDzt8jAuMvv6yCcB+FkqjrOQXQgUWcNzcZ3+xmIR/Aq1Yfp/okNoV
	 IxtfpfmtCpeARUNWee3xrWyJ+MV8+fqdOnXDXmDSbmggoHhS8hnAQRCM6WDuTW2B8o
	 R6ovcDEBbii5Ob4bL2Mrw5doidNTSFYtK8nUfLb31saiKBa99WjoYVfh0rLKHC3BZa
	 mysjvhMi7gKCDFNWYJfdmsaeFEBXPXyzNpLT8adWtIYuX5w/pzCWdyzxmtYtHzySlk
	 JM0zImcPHXvpx62YrgbS+n47aQzi3RmFdvy8Y0k7NX2M73TkKaURcJbMZJrXC8nNrw
	 ftINNXlBfq8ig==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 16/17] arch_numa: switch over to numa_memblks
Date: Tue, 16 Jul 2024 14:13:45 +0300
Message-ID: <20240716111346.3676969-17-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716111346.3676969-1-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Until now arch_numa was directly translating firmware NUMA information
to memblock.

Using numa_memblks as an intermediate step has a few advantages:
* alignment with more battle tested x86 implementation
* availability of NUMA emulation
* maintaining node information for not yet populated memory

Replace current functionality related to numa_add_memblk() and
__node_distance() with the implementation based on numa_memblks and add
functions required by numa_emulation.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/base/Kconfig       |   1 +
 drivers/base/arch_numa.c   | 200 +++++++++++--------------------------
 include/asm-generic/numa.h |   6 +-
 3 files changed, 64 insertions(+), 143 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..064eb52ff7e2 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -226,6 +226,7 @@ config GENERIC_ARCH_TOPOLOGY
 
 config GENERIC_ARCH_NUMA
 	bool
+	select NUMA_MEMBLKS
 	help
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 2ebf12eab99f..333cbbad7466 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -12,14 +12,12 @@
 #include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/numa_memblks.h>
 
 #include <asm/sections.h>
 
-nodemask_t numa_nodes_parsed __initdata;
 static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
 
-static int numa_distance_cnt;
-static u8 *numa_distance;
 bool numa_off;
 
 static __init int numa_parse_early_param(char *opt)
@@ -28,6 +26,8 @@ static __init int numa_parse_early_param(char *opt)
 		return -EINVAL;
 	if (str_has_prefix(opt, "off"))
 		numa_off = true;
+	if (!strncmp(opt, "fake=", 5))
+		return numa_emu_cmdline(opt + 5);
 
 	return 0;
 }
@@ -59,6 +59,7 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif
 
+#ifndef CONFIG_NUMA_EMU
 static void numa_update_cpu(unsigned int cpu, bool remove)
 {
 	int nid = cpu_to_node(cpu);
@@ -81,6 +82,7 @@ void numa_remove_cpu(unsigned int cpu)
 {
 	numa_update_cpu(cpu, true);
 }
+#endif
 
 void numa_clear_node(unsigned int cpu)
 {
@@ -142,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-int __init early_cpu_to_node(int cpu)
+int early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
@@ -187,30 +189,6 @@ void __init setup_per_cpu_areas(void)
 }
 #endif
 
-/**
- * numa_add_memblk() - Set node id to memblk
- * @nid: NUMA node ID of the new memblk
- * @start: Start address of the new memblk
- * @end:  End address of the new memblk
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int __init numa_add_memblk(int nid, u64 start, u64 end)
-{
-	int ret;
-
-	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
-	if (ret < 0) {
-		pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
-			start, (end - 1), nid);
-		return ret;
-	}
-
-	node_set(nid, numa_nodes_parsed);
-	return ret;
-}
-
 /*
  * Initialize NODE_DATA for a node on the local memory
  */
@@ -226,116 +204,9 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
 }
 
-/*
- * numa_free_distance
- *
- * The current table is freed.
- */
-void __init numa_free_distance(void)
-{
-	size_t size;
-
-	if (!numa_distance)
-		return;
-
-	size = numa_distance_cnt * numa_distance_cnt *
-		sizeof(numa_distance[0]);
-
-	memblock_free(numa_distance, size);
-	numa_distance_cnt = 0;
-	numa_distance = NULL;
-}
-
-/*
- * Create a new NUMA distance table.
- */
-static int __init numa_alloc_distance(void)
-{
-	size_t size;
-	int i, j;
-
-	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
-	numa_distance = memblock_alloc(size, PAGE_SIZE);
-	if (WARN_ON(!numa_distance))
-		return -ENOMEM;
-
-	numa_distance_cnt = nr_node_ids;
-
-	/* fill with the default distances */
-	for (i = 0; i < numa_distance_cnt; i++)
-		for (j = 0; j < numa_distance_cnt; j++)
-			numa_distance[i * numa_distance_cnt + j] = i == j ?
-				LOCAL_DISTANCE : REMOTE_DISTANCE;
-
-	pr_debug("Initialized distance table, cnt=%d\n", numa_distance_cnt);
-
-	return 0;
-}
-
-/**
- * numa_set_distance() - Set inter node NUMA distance from node to node.
- * @from: the 'from' node to set distance
- * @to: the 'to'  node to set distance
- * @distance: NUMA distance
- *
- * Set the distance from node @from to @to to @distance.
- * If distance table doesn't exist, a warning is printed.
- *
- * If @from or @to is higher than the highest known node or lower than zero
- * or @distance doesn't make sense, the call is ignored.
- */
-void __init numa_set_distance(int from, int to, int distance)
-{
-	if (!numa_distance) {
-		pr_warn_once("Warning: distance table not allocated yet\n");
-		return;
-	}
-
-	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
-			from < 0 || to < 0) {
-		pr_warn_once("Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
-			    from, to, distance);
-		return;
-	}
-
-	if ((u8)distance != distance ||
-	    (from == to && distance != LOCAL_DISTANCE)) {
-		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
-			     from, to, distance);
-		return;
-	}
-
-	numa_distance[from * numa_distance_cnt + to] = distance;
-}
-
-/*
- * Return NUMA distance @from to @to
- */
-int __node_distance(int from, int to)
-{
-	if (from >= numa_distance_cnt || to >= numa_distance_cnt)
-		return from == to ? LOCAL_DISTANCE : REMOTE_DISTANCE;
-	return numa_distance[from * numa_distance_cnt + to];
-}
-EXPORT_SYMBOL(__node_distance);
-
 static int __init numa_register_nodes(void)
 {
 	int nid;
-	struct memblock_region *mblk;
-
-	/* Check that valid nid is set to memblks */
-	for_each_mem_region(mblk) {
-		int mblk_nid = memblock_get_region_node(mblk);
-		phys_addr_t start = mblk->base;
-		phys_addr_t end = mblk->base + mblk->size - 1;
-
-		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
-			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
-				mblk_nid, &start, &end);
-			return -EINVAL;
-		}
-	}
 
 	/* Finally register nodes. */
 	for_each_node_mask(nid, numa_nodes_parsed) {
@@ -360,11 +231,7 @@ static int __init numa_init(int (*init_func)(void))
 	nodes_clear(node_possible_map);
 	nodes_clear(node_online_map);
 
-	ret = numa_alloc_distance();
-	if (ret < 0)
-		return ret;
-
-	ret = init_func();
+	ret = numa_memblks_init(init_func, /* memblock_force_top_down */ false);
 	if (ret < 0)
 		goto out_free_distance;
 
@@ -382,7 +249,7 @@ static int __init numa_init(int (*init_func)(void))
 
 	return 0;
 out_free_distance:
-	numa_free_distance();
+	numa_reset_distance();
 	return ret;
 }
 
@@ -454,3 +321,54 @@ void __init arch_numa_init(void)
 
 	numa_init(dummy_numa_init);
 }
+
+#ifdef CONFIG_NUMA_EMU
+void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
+					unsigned int nr_emu_nids)
+{
+	int i, j;
+
+	/*
+	 * Transform __apicid_to_node table to use emulated nids by
+	 * reverse-mapping phys_nid.  The maps should always exist but fall
+	 * back to zero just in case.
+	 */
+	for (i = 0; i < ARRAY_SIZE(cpu_to_node_map); i++) {
+		if (cpu_to_node_map[i] == NUMA_NO_NODE)
+			continue;
+		for (j = 0; j < nr_emu_nids; j++)
+			if (cpu_to_node_map[i] == emu_nid_to_phys[j])
+				break;
+		cpu_to_node_map[i] = j < nr_emu_nids ? j : 0;
+	}
+}
+
+u64 __init numa_emu_dma_end(void)
+{
+	return PFN_PHYS(memblock_start_of_DRAM() + SZ_4G);
+}
+
+void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable)
+{
+	struct cpumask *mask;
+
+	if (node == NUMA_NO_NODE)
+		return;
+
+	mask = node_to_cpumask_map[node];
+	if (!cpumask_available(mask)) {
+		pr_err("node_to_cpumask_map[%i] NULL\n", node);
+		dump_stack();
+		return;
+	}
+
+	if (enable)
+		cpumask_set_cpu(cpu, mask);
+	else
+		cpumask_clear_cpu(cpu, mask);
+
+	pr_debug("%s cpu %d node %d: mask now %*pbl\n",
+		 enable ? "numa_add_cpu" : "numa_remove_cpu",
+		 cpu, node, cpumask_pr_args(mask));
+}
+#endif /* CONFIG_NUMA_EMU */
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c32e0cf23c90..c2b046d1fd82 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -32,8 +32,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
 
 void __init arch_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
-void __init numa_set_distance(int from, int to, int distance);
-void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 int __init early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
@@ -51,4 +49,8 @@ static inline int early_cpu_to_node(int cpu) { return 0; }
 
 #endif	/* CONFIG_NUMA */
 
+#ifdef CONFIG_NUMA_EMU
+void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable);
+#endif
+
 #endif	/* __ASM_GENERIC_NUMA_H */
-- 
2.43.0


