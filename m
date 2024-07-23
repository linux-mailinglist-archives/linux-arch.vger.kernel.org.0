Return-Path: <linux-arch+bounces-5575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC899939AB9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30B0281C27
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01614D290;
	Tue, 23 Jul 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3HMCfkI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0014A4E1;
	Tue, 23 Jul 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717136; cv=none; b=KtapL4dmcbFdBrUAgs1oHoJl5WYIfEhKy1XpnuFT5kB4v3ymzBh3wG4LtoRFReSts1rnzmfy782ndfZuFdotxT/L/vREWDpRibO9aXc55v+IG89VgUQyGGSmfmvJdLLpChXkpdyOxkjUYI+dL8FQEqMJPxf0CjZFR8+fM0kb084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717136; c=relaxed/simple;
	bh=+SS+kBMesJ55WKe6egUFmgElS27y1BsvfZiWIBsrKDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIUEM/m5rqRKGz/vv38/Q+kn7km237ssVPxEpLS9OQXDjZ6qVsq/CrTQ1FEanQLJwWQEzhieMNUhgpCZwIXTDkmsgXuf072gV1FRpaNXUr3hJyUUkuUG6Z0e13ygZ9g2BiO3R1r5Sa0uHIXHl7KT8sbolm47zLF1jfiT2KFHAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3HMCfkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971FBC4AF11;
	Tue, 23 Jul 2024 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717135;
	bh=+SS+kBMesJ55WKe6egUFmgElS27y1BsvfZiWIBsrKDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3HMCfkIDYgCAdmaqzZirn25m5YCUeyx2+Yt3KdJ6dTe+hC6ma8FVwdGgTevrbpTL
	 V//8S9aE/BnndgxKBfH8v2teL/zytgKLeZ2En2ll04NA+2vnSnRelqp8J/Fc7zmU3u
	 N2YmBf/L2IxONH8YSjWtlPNG2JSUVmrkq/CcYSl2x/7B7gxvE3wGy2UBHd60A2YUFK
	 teggemL4n51lCoSdDB/KK9I/AbKJbXmmMIJ7lg2NBd5Le4xuGf9of21zn3SflH013v
	 pdSEe26Djqlgk2Q3FaJEqaax7RJgiB4I5DBw/NKtOXnzTM+Lp3LjUZbxQa1YIgGrif
	 lMfTVrQ9TgE3g==
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 17/25] mm: introduce numa_memblks
Date: Tue, 23 Jul 2024 09:41:48 +0300
Message-ID: <20240723064156.4009477-18-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Move code dealing with numa_memblks from arch/x86 to mm/ and add Kconfig
options to let x86 select it in its Kconfig.

This code will be later reused by arch_numa.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig             |   1 +
 arch/x86/include/asm/numa.h  |   3 -
 arch/x86/mm/amdtopology.c    |   1 +
 arch/x86/mm/numa.c           | 372 +--------------------------------
 arch/x86/mm/numa_emulation.c |   1 +
 arch/x86/mm/numa_internal.h  |  15 +-
 drivers/acpi/numa/srat.c     |   1 +
 drivers/of/of_numa.c         |   1 +
 include/linux/numa_memblks.h |  35 ++++
 mm/Kconfig                   |   3 +
 mm/Makefile                  |   1 +
 mm/numa_memblks.c            | 385 +++++++++++++++++++++++++++++++++++
 12 files changed, 436 insertions(+), 383 deletions(-)
 create mode 100644 include/linux/numa_memblks.h
 create mode 100644 mm/numa_memblks.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e..d8084f37157c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -295,6 +295,7 @@ config X86
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select NEED_SG_DMA_LENGTH
+	select NUMA_MEMBLKS			if NUMA
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
 	select PERF_EVENTS
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 6fa5ea925aac..6e9a50bf03d4 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -10,8 +10,6 @@
 
 #ifdef CONFIG_NUMA
 
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
-
 extern int numa_off;
 
 /*
@@ -25,7 +23,6 @@ extern int numa_off;
 extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
 
-extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 9332b36a1091..628833afee37 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
+#include <linux/numa_memblks.h>
 
 #include <asm/io.h>
 #include <linux/pci_ids.h>
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index cf7b95125d2a..6874d5650b4d 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/topology.h>
 #include <linux/sort.h>
+#include <linux/numa_memblks.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -22,10 +23,6 @@
 #include "numa_internal.h"
 
 int numa_off;
-nodemask_t numa_nodes_parsed __initdata;
-
-static struct numa_meminfo numa_meminfo __initdata_or_meminfo;
-static struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
@@ -121,194 +118,6 @@ void __init setup_node_to_cpumask_map(void)
 	pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
 }
 
-static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
-				     struct numa_meminfo *mi)
-{
-	/* ignore zero length blks */
-	if (start == end)
-		return 0;
-
-	/* whine about and ignore invalid blks */
-	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
-		pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-			nid, start, end - 1);
-		return 0;
-	}
-
-	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
-		pr_err("too many memblk ranges\n");
-		return -EINVAL;
-	}
-
-	mi->blk[mi->nr_blks].start = start;
-	mi->blk[mi->nr_blks].end = end;
-	mi->blk[mi->nr_blks].nid = nid;
-	mi->nr_blks++;
-	return 0;
-}
-
-/**
- * numa_remove_memblk_from - Remove one numa_memblk from a numa_meminfo
- * @idx: Index of memblk to remove
- * @mi: numa_meminfo to remove memblk from
- *
- * Remove @idx'th numa_memblk from @mi by shifting @mi->blk[] and
- * decrementing @mi->nr_blks.
- */
-void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
-{
-	mi->nr_blks--;
-	memmove(&mi->blk[idx], &mi->blk[idx + 1],
-		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
-}
-
-/**
- * numa_move_tail_memblk - Move a numa_memblk from one numa_meminfo to another
- * @dst: numa_meminfo to append block to
- * @idx: Index of memblk to remove
- * @src: numa_meminfo to remove memblk from
- */
-static void __init numa_move_tail_memblk(struct numa_meminfo *dst, int idx,
-					 struct numa_meminfo *src)
-{
-	dst->blk[dst->nr_blks++] = src->blk[idx];
-	numa_remove_memblk_from(idx, src);
-}
-
-/**
- * numa_add_memblk - Add one numa_memblk to numa_meminfo
- * @nid: NUMA node ID of the new memblk
- * @start: Start address of the new memblk
- * @end: End address of the new memblk
- *
- * Add a new memblk to the default numa_meminfo.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int __init numa_add_memblk(int nid, u64 start, u64 end)
-{
-	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
-}
-
-/**
- * numa_cleanup_meminfo - Cleanup a numa_meminfo
- * @mi: numa_meminfo to clean up
- *
- * Sanitize @mi by merging and removing unnecessary memblks.  Also check for
- * conflicts and clear unused memblks.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
-{
-	const u64 low = 0;
-	const u64 high = PFN_PHYS(max_pfn);
-	int i, j, k;
-
-	/* first, trim all entries */
-	for (i = 0; i < mi->nr_blks; i++) {
-		struct numa_memblk *bi = &mi->blk[i];
-
-		/* move / save reserved memory ranges */
-		if (!memblock_overlaps_region(&memblock.memory,
-					bi->start, bi->end - bi->start)) {
-			numa_move_tail_memblk(&numa_reserved_meminfo, i--, mi);
-			continue;
-		}
-
-		/* make sure all non-reserved blocks are inside the limits */
-		bi->start = max(bi->start, low);
-
-		/* preserve info for non-RAM areas above 'max_pfn': */
-		if (bi->end > high) {
-			numa_add_memblk_to(bi->nid, high, bi->end,
-					   &numa_reserved_meminfo);
-			bi->end = high;
-		}
-
-		/* and there's no empty block */
-		if (bi->start >= bi->end)
-			numa_remove_memblk_from(i--, mi);
-	}
-
-	/* merge neighboring / overlapping entries */
-	for (i = 0; i < mi->nr_blks; i++) {
-		struct numa_memblk *bi = &mi->blk[i];
-
-		for (j = i + 1; j < mi->nr_blks; j++) {
-			struct numa_memblk *bj = &mi->blk[j];
-			u64 start, end;
-
-			/*
-			 * See whether there are overlapping blocks.  Whine
-			 * about but allow overlaps of the same nid.  They
-			 * will be merged below.
-			 */
-			if (bi->end > bj->start && bi->start < bj->end) {
-				if (bi->nid != bj->nid) {
-					pr_err("node %d [mem %#010Lx-%#010Lx] overlaps with node %d [mem %#010Lx-%#010Lx]\n",
-					       bi->nid, bi->start, bi->end - 1,
-					       bj->nid, bj->start, bj->end - 1);
-					return -EINVAL;
-				}
-				pr_warn("Warning: node %d [mem %#010Lx-%#010Lx] overlaps with itself [mem %#010Lx-%#010Lx]\n",
-					bi->nid, bi->start, bi->end - 1,
-					bj->start, bj->end - 1);
-			}
-
-			/*
-			 * Join together blocks on the same node, holes
-			 * between which don't overlap with memory on other
-			 * nodes.
-			 */
-			if (bi->nid != bj->nid)
-				continue;
-			start = min(bi->start, bj->start);
-			end = max(bi->end, bj->end);
-			for (k = 0; k < mi->nr_blks; k++) {
-				struct numa_memblk *bk = &mi->blk[k];
-
-				if (bi->nid == bk->nid)
-					continue;
-				if (start < bk->end && end > bk->start)
-					break;
-			}
-			if (k < mi->nr_blks)
-				continue;
-			printk(KERN_INFO "NUMA: Node %d [mem %#010Lx-%#010Lx] + [mem %#010Lx-%#010Lx] -> [mem %#010Lx-%#010Lx]\n",
-			       bi->nid, bi->start, bi->end - 1, bj->start,
-			       bj->end - 1, start, end - 1);
-			bi->start = start;
-			bi->end = end;
-			numa_remove_memblk_from(j--, mi);
-		}
-	}
-
-	/* clear unused ones */
-	for (i = mi->nr_blks; i < ARRAY_SIZE(mi->blk); i++) {
-		mi->blk[i].start = mi->blk[i].end = 0;
-		mi->blk[i].nid = NUMA_NO_NODE;
-	}
-
-	return 0;
-}
-
-/*
- * Set nodes, which have memory in @mi, in *@nodemask.
- */
-static void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
-					      const struct numa_meminfo *mi)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
-		if (mi->blk[i].start != mi->blk[i].end &&
-		    mi->blk[i].nid != NUMA_NO_NODE)
-			node_set(mi->blk[i].nid, *nodemask);
-}
-
 /**
  * numa_reset_distance - Reset NUMA distance table
  *
@@ -410,111 +219,13 @@ int __node_distance(int from, int to)
 }
 EXPORT_SYMBOL(__node_distance);
 
-/*
- * Mark all currently memblock-reserved physical memory (which covers the
- * kernel's own memory ranges) as hot-unswappable.
- */
-static void __init numa_clear_kernel_node_hotplug(void)
-{
-	nodemask_t reserved_nodemask = NODE_MASK_NONE;
-	struct memblock_region *mb_region;
-	int i;
-
-	/*
-	 * We have to do some preprocessing of memblock regions, to
-	 * make them suitable for reservation.
-	 *
-	 * At this time, all memory regions reserved by memblock are
-	 * used by the kernel, but those regions are not split up
-	 * along node boundaries yet, and don't necessarily have their
-	 * node ID set yet either.
-	 *
-	 * So iterate over all memory known to the x86 architecture,
-	 * and use those ranges to set the nid in memblock.reserved.
-	 * This will split up the memblock regions along node
-	 * boundaries and will set the node IDs as well.
-	 */
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = numa_meminfo.blk + i;
-		int ret;
-
-		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
-		WARN_ON_ONCE(ret);
-	}
-
-	/*
-	 * Now go over all reserved memblock regions, to construct a
-	 * node mask of all kernel reserved memory areas.
-	 *
-	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
-	 *   numa_meminfo might not include all memblock.reserved
-	 *   memory ranges, because quirks such as trim_snb_memory()
-	 *   reserve specific pages for Sandy Bridge graphics. ]
-	 */
-	for_each_reserved_mem_region(mb_region) {
-		int nid = memblock_get_region_node(mb_region);
-
-		if (nid != NUMA_NO_NODE)
-			node_set(nid, reserved_nodemask);
-	}
-
-	/*
-	 * Finally, clear the MEMBLOCK_HOTPLUG flag for all memory
-	 * belonging to the reserved node mask.
-	 *
-	 * Note that this will include memory regions that reside
-	 * on nodes that contain kernel memory - entire nodes
-	 * become hot-unpluggable:
-	 */
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = numa_meminfo.blk + i;
-
-		if (!node_isset(mb->nid, reserved_nodemask))
-			continue;
-
-		memblock_clear_hotplug(mb->start, mb->end - mb->start);
-	}
-}
-
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
-	int i, nid;
+	int nid, err;
 
-	/* Account for nodes with cpus and no memory */
-	node_possible_map = numa_nodes_parsed;
-	numa_nodemask_from_meminfo(&node_possible_map, mi);
-	if (WARN_ON(nodes_empty(node_possible_map)))
-		return -EINVAL;
-
-	for (i = 0; i < mi->nr_blks; i++) {
-		struct numa_memblk *mb = &mi->blk[i];
-		memblock_set_node(mb->start, mb->end - mb->start,
-				  &memblock.memory, mb->nid);
-	}
-
-	/*
-	 * At very early time, the kernel have to use some memory such as
-	 * loading the kernel image. We cannot prevent this anyway. So any
-	 * node the kernel resides in should be un-hotpluggable.
-	 *
-	 * And when we come here, alloc node data won't fail.
-	 */
-	numa_clear_kernel_node_hotplug();
-
-	/*
-	 * If sections array is gonna be used for pfn -> nid mapping, check
-	 * whether its granularity is fine enough.
-	 */
-	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
-		unsigned long pfn_align = node_map_pfn_alignment();
-
-		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
-			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
-				PFN_PHYS(pfn_align) >> 20,
-				PFN_PHYS(PAGES_PER_SECTION) >> 20);
-			return -EINVAL;
-		}
-	}
+	err = numa_register_meminfo(mi);
+	if (err)
+		return err;
 
 	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
@@ -912,76 +623,3 @@ int memory_add_physaddr_to_nid(u64 start)
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
 #endif
-
-static int __init cmp_memblk(const void *a, const void *b)
-{
-	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
-	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
-
-	return (ma->start > mb->start) - (ma->start < mb->start);
-}
-
-static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
-
-/**
- * numa_fill_memblks - Fill gaps in numa_meminfo memblks
- * @start: address to begin fill
- * @end: address to end fill
- *
- * Find and extend numa_meminfo memblks to cover the physical
- * address range @start-@end
- *
- * RETURNS:
- * 0		  : Success
- * NUMA_NO_MEMBLK : No memblks exist in address range @start-@end
- */
-
-int __init numa_fill_memblks(u64 start, u64 end)
-{
-	struct numa_memblk **blk = &numa_memblk_list[0];
-	struct numa_meminfo *mi = &numa_meminfo;
-	int count = 0;
-	u64 prev_end;
-
-	/*
-	 * Create a list of pointers to numa_meminfo memblks that
-	 * overlap start, end. The list is used to make in-place
-	 * changes that fill out the numa_meminfo memblks.
-	 */
-	for (int i = 0; i < mi->nr_blks; i++) {
-		struct numa_memblk *bi = &mi->blk[i];
-
-		if (memblock_addrs_overlap(start, end - start, bi->start,
-					   bi->end - bi->start)) {
-			blk[count] = &mi->blk[i];
-			count++;
-		}
-	}
-	if (!count)
-		return NUMA_NO_MEMBLK;
-
-	/* Sort the list of pointers in memblk->start order */
-	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
-
-	/* Make sure the first/last memblks include start/end */
-	blk[0]->start = min(blk[0]->start, start);
-	blk[count - 1]->end = max(blk[count - 1]->end, end);
-
-	/*
-	 * Fill any gaps by tracking the previous memblks
-	 * end address and backfilling to it if needed.
-	 */
-	prev_end = blk[0]->end;
-	for (int i = 1; i < count; i++) {
-		struct numa_memblk *curr = blk[i];
-
-		if (prev_end >= curr->start) {
-			if (prev_end < curr->end)
-				prev_end = curr->end;
-		} else {
-			curr->start = prev_end;
-			prev_end = curr->end;
-		}
-	}
-	return 0;
-}
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 235f8a4eb2fa..33610026b7a3 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/memblock.h>
+#include <linux/numa_memblks.h>
 #include <asm/dma.h>
 
 #include "numa_internal.h"
diff --git a/arch/x86/mm/numa_internal.h b/arch/x86/mm/numa_internal.h
index 86860f279662..a51229a2f5af 100644
--- a/arch/x86/mm/numa_internal.h
+++ b/arch/x86/mm/numa_internal.h
@@ -5,23 +5,12 @@
 #include <linux/types.h>
 #include <asm/numa.h>
 
-struct numa_memblk {
-	u64			start;
-	u64			end;
-	int			nid;
-};
-
-struct numa_meminfo {
-	int			nr_blks;
-	struct numa_memblk	blk[NR_NODE_MEMBLKS];
-};
-
-void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
-int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
 void __init numa_reset_distance(void);
 
 void __init x86_numa_init(void);
 
+struct numa_meminfo;
+
 #ifdef CONFIG_NUMA_EMU
 void __init numa_emulation(struct numa_meminfo *numa_meminfo,
 			   int numa_dist_cnt);
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e3f26e71637a..6f2983cbe553 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <linux/numa_memblks.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 5949829a1b00..838747e319a2 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/nodemask.h>
+#include <linux/numa_memblks.h>
 
 #include <asm/numa.h>
 
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
new file mode 100644
index 000000000000..6981cf97d2c9
--- /dev/null
+++ b/include/linux/numa_memblks.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NUMA_MEMBLKS_H
+#define __NUMA_MEMBLKS_H
+
+#ifdef CONFIG_NUMA_MEMBLKS
+#include <linux/types.h>
+
+#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
+
+struct numa_memblk {
+	u64			start;
+	u64			end;
+	int			nid;
+};
+
+struct numa_meminfo {
+	int			nr_blks;
+	struct numa_memblk	blk[NR_NODE_MEMBLKS];
+};
+
+extern struct numa_meminfo numa_meminfo __initdata_or_meminfo;
+extern struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
+
+int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
+
+int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
+int __init numa_register_meminfo(struct numa_meminfo *mi);
+
+void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
+				       const struct numa_meminfo *mi);
+
+#endif /* CONFIG_NUMA_MEMBLKS */
+
+#endif	/* __NUMA_MEMBLKS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..15c6efbaa1df 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1249,6 +1249,9 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config NUMA_MEMBLKS
+	bool
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 773b3b267438..17bc4013a2c5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -140,3 +140,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_NUMA) += numa.o
+obj-$(CONFIG_NUMA_MEMBLKS) += numa_memblks.o
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
new file mode 100644
index 000000000000..72f191a94c66
--- /dev/null
+++ b/mm/numa_memblks.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/sort.h>
+#include <linux/printk.h>
+#include <linux/memblock.h>
+#include <linux/numa.h>
+#include <linux/numa_memblks.h>
+
+nodemask_t numa_nodes_parsed __initdata;
+
+struct numa_meminfo numa_meminfo __initdata_or_meminfo;
+struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
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
+		pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
+			nid, start, end - 1);
+		return 0;
+	}
+
+	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
+		pr_err("too many memblk ranges\n");
+		return -EINVAL;
+	}
+
+	mi->blk[mi->nr_blks].start = start;
+	mi->blk[mi->nr_blks].end = end;
+	mi->blk[mi->nr_blks].nid = nid;
+	mi->nr_blks++;
+	return 0;
+}
+
+/**
+ * numa_remove_memblk_from - Remove one numa_memblk from a numa_meminfo
+ * @idx: Index of memblk to remove
+ * @mi: numa_meminfo to remove memblk from
+ *
+ * Remove @idx'th numa_memblk from @mi by shifting @mi->blk[] and
+ * decrementing @mi->nr_blks.
+ */
+void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
+{
+	mi->nr_blks--;
+	memmove(&mi->blk[idx], &mi->blk[idx + 1],
+		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
+}
+
+/**
+ * numa_move_tail_memblk - Move a numa_memblk from one numa_meminfo to another
+ * @dst: numa_meminfo to append block to
+ * @idx: Index of memblk to remove
+ * @src: numa_meminfo to remove memblk from
+ */
+static void __init numa_move_tail_memblk(struct numa_meminfo *dst, int idx,
+					 struct numa_meminfo *src)
+{
+	dst->blk[dst->nr_blks++] = src->blk[idx];
+	numa_remove_memblk_from(idx, src);
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
+/**
+ * numa_cleanup_meminfo - Cleanup a numa_meminfo
+ * @mi: numa_meminfo to clean up
+ *
+ * Sanitize @mi by merging and removing unnecessary memblks.  Also check for
+ * conflicts and clear unused memblks.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
+{
+	const u64 low = 0;
+	const u64 high = PFN_PHYS(max_pfn);
+	int i, j, k;
+
+	/* first, trim all entries */
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		/* move / save reserved memory ranges */
+		if (!memblock_overlaps_region(&memblock.memory,
+					bi->start, bi->end - bi->start)) {
+			numa_move_tail_memblk(&numa_reserved_meminfo, i--, mi);
+			continue;
+		}
+
+		/* make sure all non-reserved blocks are inside the limits */
+		bi->start = max(bi->start, low);
+
+		/* preserve info for non-RAM areas above 'max_pfn': */
+		if (bi->end > high) {
+			numa_add_memblk_to(bi->nid, high, bi->end,
+					   &numa_reserved_meminfo);
+			bi->end = high;
+		}
+
+		/* and there's no empty block */
+		if (bi->start >= bi->end)
+			numa_remove_memblk_from(i--, mi);
+	}
+
+	/* merge neighboring / overlapping entries */
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		for (j = i + 1; j < mi->nr_blks; j++) {
+			struct numa_memblk *bj = &mi->blk[j];
+			u64 start, end;
+
+			/*
+			 * See whether there are overlapping blocks.  Whine
+			 * about but allow overlaps of the same nid.  They
+			 * will be merged below.
+			 */
+			if (bi->end > bj->start && bi->start < bj->end) {
+				if (bi->nid != bj->nid) {
+					pr_err("node %d [mem %#010Lx-%#010Lx] overlaps with node %d [mem %#010Lx-%#010Lx]\n",
+					       bi->nid, bi->start, bi->end - 1,
+					       bj->nid, bj->start, bj->end - 1);
+					return -EINVAL;
+				}
+				pr_warn("Warning: node %d [mem %#010Lx-%#010Lx] overlaps with itself [mem %#010Lx-%#010Lx]\n",
+					bi->nid, bi->start, bi->end - 1,
+					bj->start, bj->end - 1);
+			}
+
+			/*
+			 * Join together blocks on the same node, holes
+			 * between which don't overlap with memory on other
+			 * nodes.
+			 */
+			if (bi->nid != bj->nid)
+				continue;
+			start = min(bi->start, bj->start);
+			end = max(bi->end, bj->end);
+			for (k = 0; k < mi->nr_blks; k++) {
+				struct numa_memblk *bk = &mi->blk[k];
+
+				if (bi->nid == bk->nid)
+					continue;
+				if (start < bk->end && end > bk->start)
+					break;
+			}
+			if (k < mi->nr_blks)
+				continue;
+			pr_info("NUMA: Node %d [mem %#010Lx-%#010Lx] + [mem %#010Lx-%#010Lx] -> [mem %#010Lx-%#010Lx]\n",
+			       bi->nid, bi->start, bi->end - 1, bj->start,
+			       bj->end - 1, start, end - 1);
+			bi->start = start;
+			bi->end = end;
+			numa_remove_memblk_from(j--, mi);
+		}
+	}
+
+	/* clear unused ones */
+	for (i = mi->nr_blks; i < ARRAY_SIZE(mi->blk); i++) {
+		mi->blk[i].start = mi->blk[i].end = 0;
+		mi->blk[i].nid = NUMA_NO_NODE;
+	}
+
+	return 0;
+}
+
+/*
+ * Set nodes, which have memory in @mi, in *@nodemask.
+ */
+void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
+				       const struct numa_meminfo *mi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
+		if (mi->blk[i].start != mi->blk[i].end &&
+		    mi->blk[i].nid != NUMA_NO_NODE)
+			node_set(mi->blk[i].nid, *nodemask);
+}
+
+/*
+ * Mark all currently memblock-reserved physical memory (which covers the
+ * kernel's own memory ranges) as hot-unswappable.
+ */
+static void __init numa_clear_kernel_node_hotplug(void)
+{
+	nodemask_t reserved_nodemask = NODE_MASK_NONE;
+	struct memblock_region *mb_region;
+	int i;
+
+	/*
+	 * We have to do some preprocessing of memblock regions, to
+	 * make them suitable for reservation.
+	 *
+	 * At this time, all memory regions reserved by memblock are
+	 * used by the kernel, but those regions are not split up
+	 * along node boundaries yet, and don't necessarily have their
+	 * node ID set yet either.
+	 *
+	 * So iterate over all parsed memory blocks and use those ranges to
+	 * set the nid in memblock.reserved.  This will split up the
+	 * memblock regions along node boundaries and will set the node IDs
+	 * as well.
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+		int ret;
+
+		ret = memblock_set_node(mb->start, mb->end - mb->start,
+					&memblock.reserved, mb->nid);
+		WARN_ON_ONCE(ret);
+	}
+
+	/*
+	 * Now go over all reserved memblock regions, to construct a
+	 * node mask of all kernel reserved memory areas.
+	 *
+	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
+	 *   numa_meminfo might not include all memblock.reserved
+	 *   memory ranges, because quirks such as trim_snb_memory()
+	 *   reserve specific pages for Sandy Bridge graphics. ]
+	 */
+	for_each_reserved_mem_region(mb_region) {
+		int nid = memblock_get_region_node(mb_region);
+
+		if (nid != MAX_NUMNODES)
+			node_set(nid, reserved_nodemask);
+	}
+
+	/*
+	 * Finally, clear the MEMBLOCK_HOTPLUG flag for all memory
+	 * belonging to the reserved node mask.
+	 *
+	 * Note that this will include memory regions that reside
+	 * on nodes that contain kernel memory - entire nodes
+	 * become hot-unpluggable:
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+
+		if (!node_isset(mb->nid, reserved_nodemask))
+			continue;
+
+		memblock_clear_hotplug(mb->start, mb->end - mb->start);
+	}
+}
+
+int __init numa_register_meminfo(struct numa_meminfo *mi)
+{
+	int i;
+
+	/* Account for nodes with cpus and no memory */
+	node_possible_map = numa_nodes_parsed;
+	numa_nodemask_from_meminfo(&node_possible_map, mi);
+	if (WARN_ON(nodes_empty(node_possible_map)))
+		return -EINVAL;
+
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *mb = &mi->blk[i];
+
+		memblock_set_node(mb->start, mb->end - mb->start,
+				  &memblock.memory, mb->nid);
+	}
+
+	/*
+	 * At very early time, the kernel have to use some memory such as
+	 * loading the kernel image. We cannot prevent this anyway. So any
+	 * node the kernel resides in should be un-hotpluggable.
+	 *
+	 * And when we come here, alloc node data won't fail.
+	 */
+	numa_clear_kernel_node_hotplug();
+
+	/*
+	 * If sections array is gonna be used for pfn -> nid mapping, check
+	 * whether its granularity is fine enough.
+	 */
+	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
+		unsigned long pfn_align = node_map_pfn_alignment();
+
+		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
+			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
+				PFN_PHYS(pfn_align) >> 20,
+				PFN_PHYS(PAGES_PER_SECTION) >> 20);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int __init cmp_memblk(const void *a, const void *b)
+{
+	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
+	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
+
+	return (ma->start > mb->start) - (ma->start < mb->start);
+}
+
+static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
+
+/**
+ * numa_fill_memblks - Fill gaps in numa_meminfo memblks
+ * @start: address to begin fill
+ * @end: address to end fill
+ *
+ * Find and extend numa_meminfo memblks to cover the physical
+ * address range @start-@end
+ *
+ * RETURNS:
+ * 0		  : Success
+ * NUMA_NO_MEMBLK : No memblks exist in address range @start-@end
+ */
+
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct numa_memblk **blk = &numa_memblk_list[0];
+	struct numa_meminfo *mi = &numa_meminfo;
+	int count = 0;
+	u64 prev_end;
+
+	/*
+	 * Create a list of pointers to numa_meminfo memblks that
+	 * overlap start, end. The list is used to make in-place
+	 * changes that fill out the numa_meminfo memblks.
+	 */
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (memblock_addrs_overlap(start, end - start, bi->start,
+					   bi->end - bi->start)) {
+			blk[count] = &mi->blk[i];
+			count++;
+		}
+	}
+	if (!count)
+		return NUMA_NO_MEMBLK;
+
+	/* Sort the list of pointers in memblk->start order */
+	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
+
+	/* Make sure the first/last memblks include start/end */
+	blk[0]->start = min(blk[0]->start, start);
+	blk[count - 1]->end = max(blk[count - 1]->end, end);
+
+	/*
+	 * Fill any gaps by tracking the previous memblks
+	 * end address and backfilling to it if needed.
+	 */
+	prev_end = blk[0]->end;
+	for (int i = 1; i < count; i++) {
+		struct numa_memblk *curr = blk[i];
+
+		if (prev_end >= curr->start) {
+			if (prev_end < curr->end)
+				prev_end = curr->end;
+		} else {
+			curr->start = prev_end;
+			prev_end = curr->end;
+		}
+	}
+	return 0;
+}
-- 
2.43.0


