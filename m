Return-Path: <linux-arch+bounces-5410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C846E9324E9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D92858F1
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3591993A4;
	Tue, 16 Jul 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfr0ZPQi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04D19AA48;
	Tue, 16 Jul 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128497; cv=none; b=kaHSSZCzweAHGPrem7DSz0iMbaPprG/ojG8DJZCbpsaCoPw+Fv7g+ho0lCE8y5Pql2Pd7+qkwsgvmb/Y0SdYjYT/Cp97kYMvgonk9wDXP6UH86eg3o0aPqBIRUHaMvGAKDnDn7E6n1gxrf9i59Jgk+Z65Hwb+hVWh2YqVJr3V3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128497; c=relaxed/simple;
	bh=UA0klgv2viiKR0+T1J1Sg8IipQ5Blqy8qGKV0TMcN0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j68JVu06n41LbYa+8I7FainY4ByZt54qAJF5DxPhgnjlGFUL6S8cfdVmnj238DOCpFuZaO3myfkQuzqSQROMMCNQX0tuh/oJhS2RPj4hacJq/fmtxSOt7F88b5Ygf7eEcjGO5ZCTycenuc+NyoqBflTY+1WcduNw1nlba6RiOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfr0ZPQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71119C116B1;
	Tue, 16 Jul 2024 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128497;
	bh=UA0klgv2viiKR0+T1J1Sg8IipQ5Blqy8qGKV0TMcN0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hfr0ZPQiq4ddVCM5js4xl2uQMjfDUsXd2/NBxRA3R7TYpvOejdnsJaRRxlMmMZHC5
	 EBSfwFm2L/V9FBPnbJJHEGqQhtUKP1hyHk76dlU5UNSO6fIpyhVct3YW7jgyF4EmoX
	 okRXDl+cLkjO5sDflUKVlzOoXBQda/X7GxpeZyPafkjdXph4yb79zqSmAIZnBs8hsq
	 EVM+DAxSS/m5UEWw0y5l8dcuiwTThvLZJ3EMDAsEVXJO0Y1fMMjgsnuWGozjPEda7j
	 0VQkO020JimUYLWXJ2r4f8LRfKjgjT5v6aPm3eX0VE5rNdoPwK/72mobKyyJgpGg/x
	 uEz5GFQHUKXFA==
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
Subject: [PATCH 05/17] arch, mm: pull out allocation of NODE_DATA to generic code
Date: Tue, 16 Jul 2024 14:13:34 +0300
Message-ID: <20240716111346.3676969-6-rppt@kernel.org>
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

Architectures that support NUMA duplicate the code that allocates
NODE_DATA on the node-local memory with slight variations in reporting
of the addresses where the memory was allocated.

Use x86 version as the basis for the generic alloc_node_data() function
and call this function in architecture specific numa initialization.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/loongarch/kernel/numa.c | 18 ------------------
 arch/mips/loongson64/numa.c  | 16 ++--------------
 arch/powerpc/mm/numa.c       | 24 +++---------------------
 arch/sh/mm/init.c            |  7 +------
 arch/sparc/mm/init_64.c      |  9 ++-------
 arch/x86/mm/numa.c           | 34 +---------------------------------
 drivers/base/arch_numa.c     | 21 +--------------------
 include/linux/numa.h         |  2 ++
 mm/numa.c                    | 27 +++++++++++++++++++++++++++
 9 files changed, 39 insertions(+), 119 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index acada671e020..84fe7f854820 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -187,24 +187,6 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
 }
 
-static void __init alloc_node_data(int nid)
-{
-	void *nd;
-	unsigned long nd_pa;
-	size_t nd_sz = roundup(sizeof(pg_data_t), PAGE_SIZE);
-
-	nd_pa = memblock_phys_alloc_try_nid(nd_sz, SMP_CACHE_BYTES, nid);
-	if (!nd_pa) {
-		pr_err("Cannot find %zu Byte for node_data (initial node: %d)\n", nd_sz, nid);
-		return;
-	}
-
-	nd = __va(nd_pa);
-
-	node_data[nid] = nd;
-	memset(nd, 0, sizeof(pg_data_t));
-}
-
 static void __init node_mem_init(unsigned int node)
 {
 	unsigned long start_pfn, end_pfn;
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 9208eaadf690..909f6cec3a26 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -81,12 +81,8 @@ static void __init init_topology_matrix(void)
 
 static void __init node_mem_init(unsigned int node)
 {
-	struct pglist_data *nd;
 	unsigned long node_addrspace_offset;
 	unsigned long start_pfn, end_pfn;
-	unsigned long nd_pa;
-	int tnid;
-	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
 
 	node_addrspace_offset = nid_to_addrbase(node);
 	pr_info("Node%d's addrspace_offset is 0x%lx\n",
@@ -96,16 +92,8 @@ static void __init node_mem_init(unsigned int node)
 	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
 		node, start_pfn, end_pfn);
 
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, node);
-	if (!nd_pa)
-		panic("Cannot allocate %zu bytes for node %d data\n",
-		      nd_size, node);
-	nd = __va(nd_pa);
-	memset(nd, 0, sizeof(struct pglist_data));
-	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
-	if (tnid != node)
-		pr_info("NODE_DATA(%d) on node %d\n", node, tnid);
-	node_data[node] = nd;
+	alloc_node_data(node);
+
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8c18973cd71e..4c54764af160 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1081,27 +1081,9 @@ void __init dump_numa_cpu_topology(void)
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
 	u64 spanned_pages = end_pfn - start_pfn;
-	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
-	u64 nd_pa;
-	void *nd;
-	int tnid;
-
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
-	if (!nd_pa)
-		panic("Cannot allocate %zu bytes for node %d data\n",
-		      nd_size, nid);
-
-	nd = __va(nd_pa);
-
-	/* report and initialize */
-	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
-		nd_pa, nd_pa + nd_size - 1);
-	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
-	if (tnid != nid)
-		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
-
-	node_data[nid] = nd;
-	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+
+	alloc_node_data(nid);
+
 	NODE_DATA(nid)->node_id = nid;
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index bf1b54055316..5cc89a0932c3 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -212,12 +212,7 @@ void __init allocate_pgdat(unsigned int nid)
 	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
 #ifdef CONFIG_NUMA
-	NODE_DATA(nid) = memblock_alloc_try_nid(
-				sizeof(struct pglist_data),
-				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
-				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-	if (!NODE_DATA(nid))
-		panic("Can't allocate pgdat for node %d\n", nid);
+	alloc_node_data(nid);
 #endif
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3cb698204609..83279c43572d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1075,14 +1075,9 @@ static void __init allocate_node_data(int nid)
 {
 	struct pglist_data *p;
 	unsigned long start_pfn, end_pfn;
-#ifdef CONFIG_NUMA
 
-	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, nid);
-	if (!NODE_DATA(nid)) {
-		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
-		prom_halt();
-	}
+#ifdef CONFIG_NUMA
+	alloc_node_data(nid);
 
 	NODE_DATA(nid)->node_id = nid;
 #endif
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7de725d6bb05..5e1dde26674b 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -191,39 +191,6 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
 }
 
-/* Allocate NODE_DATA for a node on the local memory */
-static void __init alloc_node_data(int nid)
-{
-	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
-	u64 nd_pa;
-	void *nd;
-	int tnid;
-
-	/*
-	 * Allocate node data.  Try node-local memory and then any node.
-	 * Never allocate in DMA zone.
-	 */
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
-	if (!nd_pa) {
-		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
-		       nd_size, nid);
-		return;
-	}
-	nd = __va(nd_pa);
-
-	/* report and initialize */
-	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
-	       nd_pa, nd_pa + nd_size - 1);
-	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
-	if (tnid != nid)
-		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
-
-	node_data[nid] = nd;
-	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-
-	node_set_online(nid);
-}
-
 /**
  * numa_cleanup_meminfo - Cleanup a numa_meminfo
  * @mi: numa_meminfo to clean up
@@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		node_set_online(nid);
 	}
 
 	/* Dump memblock with node info and return. */
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 9b71ad2869f1..2ebf12eab99f 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -216,30 +216,11 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
  */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
-	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
-	u64 nd_pa;
-	void *nd;
-	int tnid;
-
 	if (start_pfn >= end_pfn)
 		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
 
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
-	if (!nd_pa)
-		panic("Cannot allocate %zu bytes for node %d data\n",
-		      nd_size, nid);
-
-	nd = __va(nd_pa);
-
-	/* report and initialize */
-	pr_info("NODE_DATA [mem %#010Lx-%#010Lx]\n",
-		nd_pa, nd_pa + nd_size - 1);
-	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
-	if (tnid != nid)
-		pr_info("NODE_DATA(%d) on node %d\n", nid, tnid);
+	alloc_node_data(nid);
 
-	node_data[nid] = nd;
-	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	NODE_DATA(nid)->node_id = nid;
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index e5841d4057ab..3b12d8ca0afd 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -33,6 +33,8 @@ static inline bool numa_valid_node(int nid)
 extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 
+void __init alloc_node_data(int nid);
+
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
 
diff --git a/mm/numa.c b/mm/numa.c
index 8c157d41c026..0483cabc4c4b 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -1,11 +1,38 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/memblock.h>
 #include <linux/printk.h>
 #include <linux/numa.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
 
+/* Allocate NODE_DATA for a node on the local memory */
+void __init alloc_node_data(int nid)
+{
+	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
+	u64 nd_pa;
+	void *nd;
+	int tnid;
+
+	/* Allocate node data.  Try node-local memory and then any node. */
+	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	if (!nd_pa)
+		panic("Cannot allocate %zu bytes for node %d data\n",
+		      nd_size, nid);
+	nd = __va(nd_pa);
+
+	/* report and initialize */
+	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
+		nd_pa, nd_pa + nd_size - 1);
+	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
+	if (tnid != nid)
+		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
+
+	node_data[nid] = nd;
+	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+}
+
 /* Stub functions: */
 
 #ifndef memory_add_physaddr_to_nid
-- 
2.43.0


