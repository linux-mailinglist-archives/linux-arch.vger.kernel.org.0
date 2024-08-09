Return-Path: <linux-arch+bounces-6141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1594D746
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CD4B23B2D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52E16D31C;
	Fri,  9 Aug 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="V2NrbCtI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ec01uNAe"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAC16B39F;
	Fri,  9 Aug 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231516; cv=none; b=ANaiT4Pcx/i8ybtTS+klmzMTYR2522huw770yzn78c55B21PzUv1AfDNnN8eI5RrW8/KsSV+GNd60RmoEdWhX121L8zLI/I5KHQsTfNa0NrDlyvmEnW99zCJBqDZawhInmJPbgtlHYNs/lf9X2zaPrfy8zb8sEgoXE0VlvQybiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231516; c=relaxed/simple;
	bh=+0h3Rgyd67gfl84X0A0L2yZJ6tl+tasYgp9SNGwj598=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sz3fzLyrowNCi6XuNX2yYEbf5Jm1CQEMEOXxY2WZ3pw3520G+ADMwropLqHtuyYsa5FFmAxN5jUETQS4xaI0YG9VrJQ0A79qr4K9d+PQUvnBw0BMaNsgdNO4z6Xxl/uySf7OoFu3CwYw5MMPXk9V6PWJaGDZ/9Qss01/xvOgMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=V2NrbCtI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ec01uNAe; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4FC00138FC4A;
	Fri,  9 Aug 2024 15:25:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 09 Aug 2024 15:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231514;
	 x=1723317914; bh=g3CvfVEBDaUPTY5RbshqMg36ReqhANIf4Ba8J3xVInE=; b=
	V2NrbCtIRjIJvPfWvtWnD0dyfszX7QbypqYT7Ze5nHE/o/UGHGQaw8P8DJoCsHA/
	qGGaQDq5GlR52DAziYhuRcHEt4gWiFKTXFkpA04qHPlYCf6EDTVgsttsaeAQ954i
	lhkltcFCuXmHXBmbqU/kQvXSTM66OlVNB7m6bVcwIvrNonvhkycfrlJPoUvwV0n0
	u7jl8EUVe6QhPbiSqJXRGVCUjwqrPE3reaNXcaPVp8mQMJghuHTjLDK0przEyolk
	rZPj7LQznWO8Vnc3vOlBg2F4tG6MifRVwhXzPhB8noJfww28vc77Vk6QEvWAcyWY
	50Ax31mDiBJplsHLZVjXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231514; x=
	1723317914; bh=g3CvfVEBDaUPTY5RbshqMg36ReqhANIf4Ba8J3xVInE=; b=e
	c01uNAeBxJ7lOv3LAfJMyrYUJHI/gjPXvHlfMBYrUPDgkBTbMTgdvEnb7kwc7zSq
	BiEon7kzkYMtP5PaAb9xmO+DD1tLNO2QjP7ZOSYxDzsQ42Iop+qZlJCl2BDMemk8
	h/ysvEKaSFJSy7gq9sSot7Dpm0sjbudxsy1V6or7pWdgXZ9LzIVuTCgvo4qpJI36
	V3sMNkvwbMlVdla2zKXd+cIe4or5lDksfO/mZiHtt+JgjWi758WSlufTVcTMmm0P
	HWDjFxfvD93ywaO4mx6NiRpNI86u0ZInRQFAYv6Yx0xUf63yFZBtbmDAk2v5TB0k
	Sps9eM5R6tNFvmnIOJfew==
X-ME-Sender: <xms:Gm22ZiE_1BF_ggnjP-oC68q1ZhPsWjRg5bnhepx6B_vcEKEMgxOZng>
    <xme:Gm22ZjWjeGBll9y81eF03UIcJJvw8E407X6PYTgPJf9XexNXrA-io7NMbDVKmwiD7
    gzQdfh9_TWcbVchTYI>
X-ME-Received: <xmr:Gm22ZsJzO9hkkJp01BsHYLZpEkZpwPifzHBnu_gBCAgdnToi67VZTsNGj3cIP-hhuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhf
    rhgrnhhkvghnrdguvgdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Gm22ZsEBDLO_pwS39OYfmiSafB9liLYeJxBmDSUAbV2iNGFXgIOqrQ>
    <xmx:Gm22ZoXp3z0ooMIzzOnTLTFPaYL6ooqEY_QXozm7-xqs4lVCN75gug>
    <xmx:Gm22ZvOHpqFuxd_02hEC3itxHquA0bHzVBNXdpaZwtiAnTnffgwolA>
    <xmx:Gm22Zv3FrfJ9owoZ0tqIOs6ZLRPf-G3xs0MrkperX8WNprehh6epug>
    <xmx:Gm22ZsrQlskfeiAe3FKQg5_pLxjYmp4zulVeKhxL5Q8hl-QMxPh7mjHE>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:07 +0100
Subject: [PATCH 7/7] MIPS: Loongson64: Migrate to arch_numa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-7-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11959;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+0h3Rgyd67gfl84X0A0L2yZJ6tl+tasYgp9SNGwj598=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufwaJu2vjoUvPhp381TUn+oEhvKt35cIyHP/ubrFN
 aHse/S7jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIlscM/1MEplV8uPeW97zu
 i885G93Ptf56sulaQOMyxoUvTUu6LE0ZGZ4JfXymc9PDvKzmdpP7/bgvvLNsymftLGRduTL0wr4
 9vawA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Migrate to generic arch_numa infra to reduce maintenance burden.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                                |   2 +-
 arch/mips/include/asm/mach-loongson64/mmzone.h   |   2 -
 arch/mips/include/asm/mach-loongson64/numa.h     |  22 ----
 arch/mips/include/asm/mach-loongson64/topology.h |  18 ---
 arch/mips/kernel/setup.c                         |   2 +-
 arch/mips/loongson64/init.c                      |  27 ++--
 arch/mips/loongson64/numa.c                      | 153 ++---------------------
 arch/mips/loongson64/smp.c                       |   2 +
 8 files changed, 24 insertions(+), 204 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9284a06db2b4..1edf36f89171 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2601,7 +2601,7 @@ config NUMA
 	bool "NUMA Support"
 	depends on SYS_SUPPORTS_NUMA
 	select SMP
-	select GENERIC_ARCH_NUMA if !SGI_IP27 && !MACH_LOONGSON64
+	select GENERIC_ARCH_NUMA if !SGI_IP27
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select USE_PERCPU_NUMA_NODE_ID if GENERIC_ARCH_NUMA
diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index 8fb70fd3c9c4..f5946e69ad55 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -14,6 +14,4 @@
 #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
 #define nid_to_addrbase(nid) ((unsigned long)(nid) << NODE_ADDRSPACE_SHIFT)
 
-extern void __init prom_init_numa_memory(void);
-
 #endif /* _ASM_MACH_MMZONE_H */
diff --git a/arch/mips/include/asm/mach-loongson64/numa.h b/arch/mips/include/asm/mach-loongson64/numa.h
deleted file mode 100644
index 2fac370d981f..000000000000
--- a/arch/mips/include/asm/mach-loongson64/numa.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
- */
-
-#ifndef __ASM_MACH_LOONGSON64_NUMA_H
-#define __ASM_MACH_LOONGSON64_NUMA_H
-
-#ifdef CONFIG_NUMA
-extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
-
-#define node_distance(from, to)	(__node_distances[(from)][(to)])
-#endif
-
-/* Hanlded in platform code */
-static inline void numa_store_cpu_info(unsigned int cpu) { }
-static inline void numa_add_cpu(unsigned int cpu) { }
-static inline void numa_remove_cpu(unsigned int cpu) { }
-static inline void arch_numa_init(void) { }
-static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
-
-#endif	/* __ASM_NUMA_H */
diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
deleted file mode 100644
index ebb086821401..000000000000
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_MACH_TOPOLOGY_H
-#define _ASM_MACH_TOPOLOGY_H
-
-#include <asm/numa.h>
-
-#ifdef CONFIG_NUMA
-#define early_cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
-#define cpu_to_node(cpu)  early_cpu_to_node(cpu)
-
-extern cpumask_t __node_cpumask[];
-#define cpumask_of_node(node)	(&__node_cpumask[node])
-
-#endif
-
-#include <asm-generic/topology.h>
-
-#endif /* _ASM_MACH_TOPOLOGY_H */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 655391c04477..242945d240c5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -252,7 +252,7 @@ static unsigned long __init init_initrd(void)
  * Initialize the bootmem allocator. It also setup initrd related data
  * if needed.
  */
-#if defined(CONFIG_SGI_IP27) || (defined(CONFIG_CPU_LOONGSON64) && defined(CONFIG_NUMA))
+#if defined(CONFIG_SGI_IP27)
 
 static void __init bootmem_init(void)
 {
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index a35dd7311795..dad78bcce93f 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -46,9 +46,9 @@ void virtual_early_config(void)
 	node_id_offset = 44;
 }
 
-void __init szmem(unsigned int node)
+static void __init prom_init_memory(void)
 {
-	u32 i, mem_type;
+	u32 i, mem_type, max_node_id = 0;
 	phys_addr_t node_id, mem_start, mem_size;
 
 	/* Otherwise come from DTB */
@@ -58,8 +58,8 @@ void __init szmem(unsigned int node)
 	/* Parse memory information and activate */
 	for (i = 0; i < loongson_memmap->nr_map; i++) {
 		node_id = loongson_memmap->map[i].node_id;
-		if (node_id != node)
-			continue;
+		if (node_id > max_node_id)
+			max_node_id = node_id;
 
 		mem_type = loongson_memmap->map[i].mem_type;
 		mem_size = loongson_memmap->map[i].mem_size;
@@ -78,7 +78,7 @@ void __init szmem(unsigned int node)
 		case UMA_VIDEO_RAM:
 			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes usable\n",
 				(u32)node_id, mem_type, &mem_start, &mem_size);
-			memblock_add_node(mem_start, mem_size, node,
+			memblock_add_node(mem_start, mem_size, node_id,
 					  MEMBLOCK_NONE);
 			break;
 		case SYSTEM_RAM_RESERVED:
@@ -104,16 +104,11 @@ void __init szmem(unsigned int node)
 		memblock_reserve(virt_to_phys((void *)loongson_sysconf.vgabios_addr),
 				SZ_256K);
 	/* set nid for reserved memory */
-	memblock_set_node((u64)node << 44, (u64)(node + 1) << 44,
-			&memblock.reserved, node);
-}
-
-#ifndef CONFIG_NUMA
-static void __init prom_init_memory(void)
-{
-	szmem(0);
+	for (i = 0; i <= max_node_id; i++) {
+		memblock_set_node(nid_to_addrbase(i), nid_to_addrbase(i + 1),
+				  &memblock.reserved, i);
+	}
 }
-#endif
 
 void __init prom_init(void)
 {
@@ -133,11 +128,7 @@ void __init prom_init(void)
 	if (loongson_sysconf.early_config)
 		loongson_sysconf.early_config();
 
-#ifdef CONFIG_NUMA
-	prom_init_numa_memory();
-#else
 	prom_init_memory();
-#endif
 
 	/* Hardcode to CPU UART 0 */
 	if ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64R)
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index d49180562c9f..9431e6e0a082 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -9,45 +9,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/export.h>
-#include <linux/nodemask.h>
-#include <linux/swap.h>
-#include <linux/memblock.h>
-#include <linux/pfn.h>
-#include <linux/highmem.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/sections.h>
-#include <linux/irq.h>
-#include <asm/bootinfo.h>
-#include <asm/mc146818-time.h>
-#include <asm/time.h>
-#include <asm/wbflush.h>
+#include <linux/numa_memblks.h>
 #include <boot_param.h>
 #include <loongson.h>
 
-unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
-EXPORT_SYMBOL(__node_distances);
-
-cpumask_t __node_cpumask[MAX_NUMNODES];
-EXPORT_SYMBOL(__node_cpumask);
-
-static void cpu_node_probe(void)
-{
-	int i;
-
-	nodes_clear(node_possible_map);
-	nodes_clear(node_online_map);
-	for (i = 0; i < loongson_sysconf.nr_nodes; i++) {
-		node_set_state(num_online_nodes(), N_POSSIBLE);
-		node_set_online(num_online_nodes());
-	}
-
-	pr_info("NUMA: Discovered %d cpus on %d nodes\n",
-		loongson_sysconf.nr_cpus, num_online_nodes());
-}
-
 static int __init compute_node_distance(int row, int col)
 {
 	int package_row = row * loongson_sysconf.cores_per_node /
@@ -63,117 +28,21 @@ static int __init compute_node_distance(int row, int col)
 		return 100;
 }
 
-static void __init init_topology_matrix(void)
-{
-	int row, col;
-
-	for (row = 0; row < MAX_NUMNODES; row++)
-		for (col = 0; col < MAX_NUMNODES; col++)
-			__node_distances[row][col] = -1;
-
-	for_each_online_node(row) {
-		for_each_online_node(col) {
-			__node_distances[row][col] =
-				compute_node_distance(row, col);
-		}
-	}
-}
-
-static void __init node_mem_init(unsigned int node)
-{
-	unsigned long node_addrspace_offset;
-	unsigned long start_pfn, end_pfn;
-
-	node_addrspace_offset = nid_to_addrbase(node);
-	pr_info("Node%d's addrspace_offset is 0x%lx\n",
-			node, node_addrspace_offset);
-
-	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
-		node, start_pfn, end_pfn);
-
-	alloc_node_data(node);
-
-	NODE_DATA(node)->node_start_pfn = start_pfn;
-	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
-
-	if (node == 0) {
-		/* kernel start address */
-		unsigned long kernel_start_pfn = PFN_DOWN(__pa_symbol(&_text));
-
-		/* kernel end address */
-		unsigned long kernel_end_pfn = PFN_UP(__pa_symbol(&_end));
-
-		/* used by finalize_initrd() */
-		max_low_pfn = end_pfn;
-
-		/* Reserve the kernel text/data/bss */
-		memblock_reserve(kernel_start_pfn << PAGE_SHIFT,
-				 ((kernel_end_pfn - kernel_start_pfn) << PAGE_SHIFT));
-
-		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
-		if (node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT))
-			memblock_reserve((node_addrspace_offset | 0xfe000000),
-					 32 << 20);
-
-		/* Reserve pfn range 0~node[0]->node_start_pfn */
-		memblock_reserve(0, PAGE_SIZE * start_pfn);
-		/* set nid for reserved memory on node 0 */
-		memblock_set_node(0, 1ULL << 44, &memblock.reserved, 0);
-	}
-}
-
-static __init void prom_meminit(void)
+int __init arch_platform_numa_init(void)
 {
-	unsigned int node, cpu, active_cpu = 0;
+	int nr_nodes, nid, row, col;
 
-	cpu_node_probe();
-	init_topology_matrix();
+	nr_nodes = loongson_sysconf.nr_nodes;
 
-	for (node = 0; node < loongson_sysconf.nr_nodes; node++) {
-		if (node_online(node)) {
-			szmem(node);
-			node_mem_init(node);
-			cpumask_clear(&__node_cpumask[node]);
-		}
+	for (nid = 0; nid < nr_nodes; nid++) {
+		node_set(nid, numa_nodes_parsed);
+		numa_add_memblk(nid, nid_to_addrbase(nid), nid_to_addrbase(nid + 1));
 	}
-	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
-
-	for (cpu = 0; cpu < loongson_sysconf.nr_cpus; cpu++) {
-		node = cpu / loongson_sysconf.cores_per_node;
-		if (node >= num_online_nodes())
-			node = 0;
-
-		if (loongson_sysconf.reserved_cpus_mask & (1<<cpu))
-			continue;
 
-		cpumask_set_cpu(active_cpu, &__node_cpumask[node]);
-		pr_info("NUMA: set cpumask cpu %d on node %d\n", active_cpu, node);
-
-		active_cpu++;
+	for (row = 0; row < nr_nodes; row++) {
+		for (col = 0; col < nr_nodes; col++)
+			numa_set_distance(row, col, compute_node_distance(row, col));
 	}
-}
-
-void __init paging_init(void)
-{
-	unsigned long zones_size[MAX_NR_ZONES] = {0, };
-
-	pagetable_init();
-	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
-	zones_size[ZONE_NORMAL] = max_low_pfn;
-	free_area_init(zones_size);
-}
 
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
-	setup_zero_pages();	/* This comes from node 0 */
-}
-
-void __init prom_init_numa_memory(void)
-{
-	pr_info("CP0_Config3: CP0 16.3 (0x%x)\n", read_c0_config3());
-	pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
-	prom_meminit();
+	return 0;
 }
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 147acd972a07..417063b8145b 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -464,6 +464,7 @@ static void __init loongson3_smp_setup(void)
 			set_cpu_possible(num, true);
 			/* Loongson processors are always grouped by 4 */
 			cpu_set_cluster(&cpu_data[num], i / 4);
+			early_map_cpu_to_node(num, i / loongson_sysconf.cores_per_node);
 			num++;
 		}
 		i++;
@@ -517,6 +518,7 @@ static int loongson3_cpu_disable(void)
 	unsigned int cpu = smp_processor_id();
 
 	set_cpu_online(cpu, false);
+	numa_remove_cpu(cpu);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
 	clear_c0_status(ST0_IM);

-- 
2.46.0


