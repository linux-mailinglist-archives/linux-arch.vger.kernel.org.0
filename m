Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A865BC145
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 04:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiISCOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISCOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 22:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76E13D3F;
        Sun, 18 Sep 2022 19:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18A061172;
        Mon, 19 Sep 2022 02:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B13EC433B5;
        Mon, 19 Sep 2022 02:14:01 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] LoongArch: Refactor cache probe and flush methods
Date:   Mon, 19 Sep 2022 10:13:05 +0800
Message-Id: <20220919021305.2869400-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Current cache probe and flush methods have some drawbacks:
1, Assume there are 3 cache levels and only 3 levels;
2, Assume L1 = I + D, L2 = V, L3 = S, V is exclusive, S is inclusive.

However, the fact is I + D, I + D + V, I + D + S and I + D + V + S are
all valid. So, refactor the cache probe and flush methods to adapt more
types of cache hierarchy.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build errors and warnings reported by kernel test robot.

 arch/loongarch/include/asm/cacheflush.h   |  87 +++++----
 arch/loongarch/include/asm/cacheops.h     |  36 ++--
 arch/loongarch/include/asm/cpu-features.h |   5 -
 arch/loongarch/include/asm/cpu-info.h     |  21 ++-
 arch/loongarch/include/asm/loongarch.h    |  33 +---
 arch/loongarch/include/asm/setup.h        |   2 +
 arch/loongarch/kernel/cacheinfo.c         |  98 +++-------
 arch/loongarch/kernel/traps.c             |   3 -
 arch/loongarch/mm/cache.c                 | 211 ++++++++++++----------
 arch/loongarch/pci/pci.c                  |   7 +-
 10 files changed, 236 insertions(+), 267 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 670900141b7c..0681788eb474 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -6,10 +6,33 @@
 #define _ASM_CACHEFLUSH_H
 
 #include <linux/mm.h>
-#include <asm/cpu-features.h>
+#include <asm/cpu-info.h>
 #include <asm/cacheops.h>
 
-extern void local_flush_icache_range(unsigned long start, unsigned long end);
+static inline bool cache_present(struct cache_desc *cdesc)
+{
+	return cdesc->flags & CACHE_PRESENT;
+}
+
+static inline bool cache_private(struct cache_desc *cdesc)
+{
+	return cdesc->flags & CACHE_PRIVATE;
+}
+
+static inline bool cache_inclusive(struct cache_desc *cdesc)
+{
+	return cdesc->flags & CACHE_INCLUSIVE;
+}
+
+static inline unsigned int cpu_last_level_cache_line_size(void)
+{
+	int cache_present = boot_cpu_data.cache_leaves_present;
+
+	return boot_cpu_data.cache_leaves[cache_present - 1].linesz;
+}
+
+asmlinkage void __flush_cache_all(void);
+void local_flush_icache_range(unsigned long start, unsigned long end);
 
 #define flush_icache_range	local_flush_icache_range
 #define flush_icache_user_range	local_flush_icache_range
@@ -35,44 +58,30 @@ extern void local_flush_icache_range(unsigned long start, unsigned long end);
 	:								\
 	: "i" (op), "ZC" (*(unsigned char *)(addr)))
 
-static inline void flush_icache_line_indexed(unsigned long addr)
-{
-	cache_op(Index_Invalidate_I, addr);
-}
-
-static inline void flush_dcache_line_indexed(unsigned long addr)
-{
-	cache_op(Index_Writeback_Inv_D, addr);
-}
-
-static inline void flush_vcache_line_indexed(unsigned long addr)
-{
-	cache_op(Index_Writeback_Inv_V, addr);
-}
-
-static inline void flush_scache_line_indexed(unsigned long addr)
-{
-	cache_op(Index_Writeback_Inv_S, addr);
-}
-
-static inline void flush_icache_line(unsigned long addr)
-{
-	cache_op(Hit_Invalidate_I, addr);
-}
-
-static inline void flush_dcache_line(unsigned long addr)
-{
-	cache_op(Hit_Writeback_Inv_D, addr);
-}
-
-static inline void flush_vcache_line(unsigned long addr)
-{
-	cache_op(Hit_Writeback_Inv_V, addr);
-}
-
-static inline void flush_scache_line(unsigned long addr)
+static inline void flush_cache_line(int leaf, unsigned long addr)
 {
-	cache_op(Hit_Writeback_Inv_S, addr);
+	switch (leaf) {
+	case Cache_LEAF0:
+		cache_op(Index_Writeback_Inv_LEAF0, addr);
+		break;
+	case Cache_LEAF1:
+		cache_op(Index_Writeback_Inv_LEAF1, addr);
+		break;
+	case Cache_LEAF2:
+		cache_op(Index_Writeback_Inv_LEAF2, addr);
+		break;
+	case Cache_LEAF3:
+		cache_op(Index_Writeback_Inv_LEAF3, addr);
+		break;
+	case Cache_LEAF4:
+		cache_op(Index_Writeback_Inv_LEAF4, addr);
+		break;
+	case Cache_LEAF5:
+		cache_op(Index_Writeback_Inv_LEAF5, addr);
+		break;
+	default:
+		break;
+	}
 }
 
 #include <asm-generic/cacheflush.h>
diff --git a/arch/loongarch/include/asm/cacheops.h b/arch/loongarch/include/asm/cacheops.h
index dc280efecebd..0f4a86f8e2be 100644
--- a/arch/loongarch/include/asm/cacheops.h
+++ b/arch/loongarch/include/asm/cacheops.h
@@ -8,16 +8,18 @@
 #define __ASM_CACHEOPS_H
 
 /*
- * Most cache ops are split into a 2 bit field identifying the cache, and a 3
+ * Most cache ops are split into a 3 bit field identifying the cache, and a 2
  * bit field identifying the cache operation.
  */
-#define CacheOp_Cache			0x03
-#define CacheOp_Op			0x1c
+#define CacheOp_Cache			0x07
+#define CacheOp_Op			0x18
 
-#define Cache_I				0x00
-#define Cache_D				0x01
-#define Cache_V				0x02
-#define Cache_S				0x03
+#define Cache_LEAF0			0x00
+#define Cache_LEAF1			0x01
+#define Cache_LEAF2			0x02
+#define Cache_LEAF3			0x03
+#define Cache_LEAF4			0x04
+#define Cache_LEAF5			0x05
 
 #define Index_Invalidate		0x08
 #define Index_Writeback_Inv		0x08
@@ -25,13 +27,17 @@
 #define Hit_Writeback_Inv		0x10
 #define CacheOp_User_Defined		0x18
 
-#define Index_Invalidate_I		(Cache_I | Index_Invalidate)
-#define Index_Writeback_Inv_D		(Cache_D | Index_Writeback_Inv)
-#define Index_Writeback_Inv_V		(Cache_V | Index_Writeback_Inv)
-#define Index_Writeback_Inv_S		(Cache_S | Index_Writeback_Inv)
-#define Hit_Invalidate_I		(Cache_I | Hit_Invalidate)
-#define Hit_Writeback_Inv_D		(Cache_D | Hit_Writeback_Inv)
-#define Hit_Writeback_Inv_V		(Cache_V | Hit_Writeback_Inv)
-#define Hit_Writeback_Inv_S		(Cache_S | Hit_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF0	(Cache_LEAF0 | Index_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF1	(Cache_LEAF1 | Index_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF2	(Cache_LEAF2 | Index_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF3	(Cache_LEAF3 | Index_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF4	(Cache_LEAF4 | Index_Writeback_Inv)
+#define Index_Writeback_Inv_LEAF5	(Cache_LEAF5 | Index_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF0		(Cache_LEAF0 | Hit_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF1		(Cache_LEAF1 | Hit_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF2		(Cache_LEAF2 | Hit_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF3		(Cache_LEAF3 | Hit_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF4		(Cache_LEAF4 | Hit_Writeback_Inv)
+#define Hit_Writeback_Inv_LEAF5		(Cache_LEAF5 | Hit_Writeback_Inv)
 
 #endif	/* __ASM_CACHEOPS_H */
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index a8d87c40a0eb..b07974218393 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -19,11 +19,6 @@
 #define cpu_has_loongarch32		(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_32BIT)
 #define cpu_has_loongarch64		(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
 
-#define cpu_icache_line_size()		cpu_data[0].icache.linesz
-#define cpu_dcache_line_size()		cpu_data[0].dcache.linesz
-#define cpu_vcache_line_size()		cpu_data[0].vcache.linesz
-#define cpu_scache_line_size()		cpu_data[0].scache.linesz
-
 #ifdef CONFIG_32BIT
 # define cpu_has_64bits			(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
 # define cpu_vabits			31
diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
index b6c4f96079df..cd73a6f57fe3 100644
--- a/arch/loongarch/include/asm/cpu-info.h
+++ b/arch/loongarch/include/asm/cpu-info.h
@@ -10,18 +10,28 @@
 
 #include <asm/loongarch.h>
 
+/* cache_desc->flags */
+enum {
+	CACHE_PRESENT	= (1 << 0),
+	CACHE_PRIVATE	= (1 << 1),	/* core private cache */
+	CACHE_INCLUSIVE	= (1 << 2),	/* include the inner level caches */
+};
+
 /*
  * Descriptor for a cache
  */
 struct cache_desc {
-	unsigned int waysize;	/* Bytes per way */
+	unsigned char type;
+	unsigned char level;
 	unsigned short sets;	/* Number of lines per set */
 	unsigned char ways;	/* Number of ways */
 	unsigned char linesz;	/* Size of line in bytes */
-	unsigned char waybit;	/* Bits to select in a cache set */
 	unsigned char flags;	/* Flags describing cache properties */
 };
 
+#define CACHE_LEVEL_MAX		3
+#define CACHE_LEAVES_MAX	6
+
 struct cpuinfo_loongarch {
 	u64			asid_cache;
 	unsigned long		asid_mask;
@@ -40,11 +50,8 @@ struct cpuinfo_loongarch {
 	int			tlbsizemtlb;
 	int			tlbsizestlbsets;
 	int			tlbsizestlbways;
-	struct cache_desc	icache; /* Primary I-cache */
-	struct cache_desc	dcache; /* Primary D or combined I/D cache */
-	struct cache_desc	vcache; /* Victim cache, between pcache and scache */
-	struct cache_desc	scache; /* Secondary cache */
-	struct cache_desc	tcache; /* Tertiary/split secondary cache */
+	int			cache_leaves_present; /* number of cache_leaves[] elements */
+	struct cache_desc	cache_leaves[CACHE_LEAVES_MAX];
 	int			core;   /* physical core number in package */
 	int			package;/* physical package number */
 	int			vabits; /* Virtual Address size in bits */
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3ba4f7e87cd2..7f8d57a61c8b 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -187,36 +187,15 @@ static inline u32 read_cpucfg(u32 reg)
 #define  CPUCFG16_L3_DINCL		BIT(16)
 
 #define LOONGARCH_CPUCFG17		0x11
-#define  CPUCFG17_L1I_WAYS_M		GENMASK(15, 0)
-#define  CPUCFG17_L1I_SETS_M		GENMASK(23, 16)
-#define  CPUCFG17_L1I_SIZE_M		GENMASK(30, 24)
-#define  CPUCFG17_L1I_WAYS		0
-#define  CPUCFG17_L1I_SETS		16
-#define  CPUCFG17_L1I_SIZE		24
-
 #define LOONGARCH_CPUCFG18		0x12
-#define  CPUCFG18_L1D_WAYS_M		GENMASK(15, 0)
-#define  CPUCFG18_L1D_SETS_M		GENMASK(23, 16)
-#define  CPUCFG18_L1D_SIZE_M		GENMASK(30, 24)
-#define  CPUCFG18_L1D_WAYS		0
-#define  CPUCFG18_L1D_SETS		16
-#define  CPUCFG18_L1D_SIZE		24
-
 #define LOONGARCH_CPUCFG19		0x13
-#define  CPUCFG19_L2_WAYS_M		GENMASK(15, 0)
-#define  CPUCFG19_L2_SETS_M		GENMASK(23, 16)
-#define  CPUCFG19_L2_SIZE_M		GENMASK(30, 24)
-#define  CPUCFG19_L2_WAYS		0
-#define  CPUCFG19_L2_SETS		16
-#define  CPUCFG19_L2_SIZE		24
-
 #define LOONGARCH_CPUCFG20		0x14
-#define  CPUCFG20_L3_WAYS_M		GENMASK(15, 0)
-#define  CPUCFG20_L3_SETS_M		GENMASK(23, 16)
-#define  CPUCFG20_L3_SIZE_M		GENMASK(30, 24)
-#define  CPUCFG20_L3_WAYS		0
-#define  CPUCFG20_L3_SETS		16
-#define  CPUCFG20_L3_SIZE		24
+#define  CPUCFG_CACHE_WAYS_M		GENMASK(15, 0)
+#define  CPUCFG_CACHE_SETS_M		GENMASK(23, 16)
+#define  CPUCFG_CACHE_LSIZE_M		GENMASK(30, 24)
+#define  CPUCFG_CACHE_WAYS	 	0
+#define  CPUCFG_CACHE_SETS		16
+#define  CPUCFG_CACHE_LSIZE		24
 
 #define LOONGARCH_CPUCFG48		0x30
 #define  CPUCFG48_MCSR_LCK		BIT(0)
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 6d7d2a3e23dd..ca373f8e3c4d 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -13,7 +13,9 @@
 
 extern unsigned long eentry;
 extern unsigned long tlbrentry;
+extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
+extern void cache_error_setup(void);
 extern void per_cpu_trap_init(int cpu);
 extern void set_handler(unsigned long offset, void *addr, unsigned long len);
 extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
index 4662b06269f4..c7988f757281 100644
--- a/arch/loongarch/kernel/cacheinfo.c
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -5,73 +5,34 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/cacheinfo.h>
+#include <linux/topology.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu-info.h>
 
-/* Populates leaf and increments to next leaf */
-#define populate_cache(cache, leaf, c_level, c_type)		\
-do {								\
-	leaf->type = c_type;					\
-	leaf->level = c_level;					\
-	leaf->coherency_line_size = c->cache.linesz;		\
-	leaf->number_of_sets = c->cache.sets;			\
-	leaf->ways_of_associativity = c->cache.ways;		\
-	leaf->size = c->cache.linesz * c->cache.sets *		\
-		c->cache.ways;					\
-	if (leaf->level > 2)					\
-		leaf->size *= nodes_per_package;		\
-	leaf++;							\
-} while (0)
-
 int init_cache_level(unsigned int cpu)
 {
-	struct cpuinfo_loongarch *c = &current_cpu_data;
+	int cache_present = current_cpu_data.cache_leaves_present;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	int levels = 0, leaves = 0;
-
-	/*
-	 * If Dcache is not set, we assume the cache structures
-	 * are not properly initialized.
-	 */
-	if (c->dcache.waysize)
-		levels += 1;
-	else
-		return -ENOENT;
-
-
-	leaves += (c->icache.waysize) ? 2 : 1;
-
-	if (c->vcache.waysize) {
-		levels++;
-		leaves++;
-	}
 
-	if (c->scache.waysize) {
-		levels++;
-		leaves++;
-	}
+	this_cpu_ci->num_levels =
+		current_cpu_data.cache_leaves[cache_present - 1].level;
+	this_cpu_ci->num_leaves = cache_present;
 
-	if (c->tcache.waysize) {
-		levels++;
-		leaves++;
-	}
-
-	this_cpu_ci->num_levels = levels;
-	this_cpu_ci->num_leaves = leaves;
 	return 0;
 }
 
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
-	return !((this_leaf->level == 1) || (this_leaf->level == 2));
+	return (!(*(unsigned char *)(this_leaf->priv) & CACHE_PRIVATE)
+		&& !(*(unsigned char *)(sib_leaf->priv) & CACHE_PRIVATE));
 }
 
 static void cache_cpumap_setup(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int index;
+	struct cacheinfo *this_leaf, *sib_leaf;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (index = 0; index < this_cpu_ci->num_leaves; index++) {
 		unsigned int i;
@@ -85,8 +46,10 @@ static void cache_cpumap_setup(unsigned int cpu)
 		for_each_online_cpu(i) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
 
-			if (i == cpu || !sib_cpu_ci->info_list)
-				continue;/* skip if itself or no cacheinfo */
+			if (i == cpu || !sib_cpu_ci->info_list ||
+				(cpu_to_node(i) != cpu_to_node(cpu)))
+				continue;
+
 			sib_leaf = sib_cpu_ci->info_list + index;
 			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
@@ -98,31 +61,24 @@ static void cache_cpumap_setup(unsigned int cpu)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	int level = 1, nodes_per_package = 1;
-	struct cpuinfo_loongarch *c = &current_cpu_data;
+	int i, cache_present = current_cpu_data.cache_leaves_present;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
-
-	if (loongson_sysconf.nr_nodes > 1)
-		nodes_per_package = loongson_sysconf.cores_per_package
-					/ loongson_sysconf.cores_per_node;
-
-	if (c->icache.waysize) {
-		populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA);
-		populate_cache(icache, this_leaf, level++, CACHE_TYPE_INST);
-	} else {
-		populate_cache(dcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+	struct cache_desc *cd, *cdesc = current_cpu_data.cache_leaves;
+
+	for (i = 0; i < cache_present; i++) {
+		cd = cdesc + i;
+
+		this_leaf->type = cd->type;
+		this_leaf->level = cd->level;
+		this_leaf->coherency_line_size = cd->linesz;
+		this_leaf->number_of_sets = cd->sets;
+		this_leaf->ways_of_associativity = cd->ways;
+		this_leaf->size = cd->linesz * cd->sets * cd->ways;
+		this_leaf->priv = &cd->flags;
+		this_leaf++;
 	}
 
-	if (c->vcache.waysize)
-		populate_cache(vcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
-
-	if (c->scache.waysize)
-		populate_cache(scache, this_leaf, level++, CACHE_TYPE_UNIFIED);
-
-	if (c->tcache.waysize)
-		populate_cache(tcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
-
 	cache_cpumap_setup(cpu);
 	this_cpu_ci->cpu_map_populated = true;
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aa1c95aaf595..950af620e7d0 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -631,9 +631,6 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 	irqentry_exit(regs, state);
 }
 
-extern void tlb_init(int cpu);
-extern void cache_error_setup(void);
-
 unsigned long eentry;
 unsigned long tlbrentry;
 
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index e8c68dcf6ab2..72685a48eaf0 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -6,8 +6,8 @@
  * Copyright (C) 1994 - 2003, 06, 07 by Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007 MIPS Technologies, Inc.
  */
+#include <linux/cacheinfo.h>
 #include <linux/export.h>
-#include <linux/fcntl.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
@@ -16,14 +16,21 @@
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 
+#include <asm/bootinfo.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
-#include <asm/dma.h>
 #include <asm/loongarch.h>
+#include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
 
+void cache_error_setup(void)
+{
+	extern char __weak except_vec_cex;
+	set_merr_handler(0x0, &except_vec_cex, 0x80);
+}
+
 /*
  * LoongArch maintains ICache/DCache coherency by hardware,
  * we just need "ibar" to avoid instruction hazard here.
@@ -34,109 +41,121 @@ void local_flush_icache_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(local_flush_icache_range);
 
-void cache_error_setup(void)
-{
-	extern char __weak except_vec_cex;
-	set_merr_handler(0x0, &except_vec_cex, 0x80);
-}
-
-static unsigned long icache_size __read_mostly;
-static unsigned long dcache_size __read_mostly;
-static unsigned long vcache_size __read_mostly;
-static unsigned long scache_size __read_mostly;
-
-static char *way_string[] = { NULL, "direct mapped", "2-way",
-	"3-way", "4-way", "5-way", "6-way", "7-way", "8-way",
-	"9-way", "10-way", "11-way", "12-way",
-	"13-way", "14-way", "15-way", "16-way",
-};
-
-static void probe_pcache(void)
+static void flush_cache_leaf(unsigned int leaf)
 {
-	struct cpuinfo_loongarch *c = &current_cpu_data;
-	unsigned int lsize, sets, ways;
-	unsigned int config;
-
-	config = read_cpucfg(LOONGARCH_CPUCFG17);
-	lsize = 1 << ((config & CPUCFG17_L1I_SIZE_M) >> CPUCFG17_L1I_SIZE);
-	sets  = 1 << ((config & CPUCFG17_L1I_SETS_M) >> CPUCFG17_L1I_SETS);
-	ways  = ((config & CPUCFG17_L1I_WAYS_M) >> CPUCFG17_L1I_WAYS) + 1;
-
-	c->icache.linesz = lsize;
-	c->icache.sets = sets;
-	c->icache.ways = ways;
-	icache_size = sets * ways * lsize;
-	c->icache.waysize = icache_size / c->icache.ways;
-
-	config = read_cpucfg(LOONGARCH_CPUCFG18);
-	lsize = 1 << ((config & CPUCFG18_L1D_SIZE_M) >> CPUCFG18_L1D_SIZE);
-	sets  = 1 << ((config & CPUCFG18_L1D_SETS_M) >> CPUCFG18_L1D_SETS);
-	ways  = ((config & CPUCFG18_L1D_WAYS_M) >> CPUCFG18_L1D_WAYS) + 1;
-
-	c->dcache.linesz = lsize;
-	c->dcache.sets = sets;
-	c->dcache.ways = ways;
-	dcache_size = sets * ways * lsize;
-	c->dcache.waysize = dcache_size / c->dcache.ways;
-
-	c->options |= LOONGARCH_CPU_PREFETCH;
-
-	pr_info("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
-		icache_size >> 10, way_string[c->icache.ways], "VIPT", c->icache.linesz);
-
-	pr_info("Primary data cache %ldkB, %s, %s, %s, linesize %d bytes\n",
-		dcache_size >> 10, way_string[c->dcache.ways], "VIPT", "no aliases", c->dcache.linesz);
+	int i, j, nr_nodes;
+	uint64_t addr = CSR_DMW0_BASE;
+	struct cache_desc *cdesc = current_cpu_data.cache_leaves + leaf;
+
+	nr_nodes = cache_private(cdesc) ? 1 : loongson_sysconf.nr_nodes;
+
+	do {
+		for (i = 0; i < cdesc->sets; i++) {
+			for (j = 0; j < cdesc->ways; j++) {
+				flush_cache_line(leaf, addr);
+				addr++;
+			}
+
+			addr -= cdesc->ways;
+			addr += cdesc->linesz;
+		}
+		addr += (1ULL << NODE_ADDRSPACE_SHIFT);
+	} while (--nr_nodes > 0);
 }
 
-static void probe_vcache(void)
+asmlinkage __visible void __flush_cache_all(void)
 {
-	struct cpuinfo_loongarch *c = &current_cpu_data;
-	unsigned int lsize, sets, ways;
-	unsigned int config;
-
-	config = read_cpucfg(LOONGARCH_CPUCFG19);
-	lsize = 1 << ((config & CPUCFG19_L2_SIZE_M) >> CPUCFG19_L2_SIZE);
-	sets  = 1 << ((config & CPUCFG19_L2_SETS_M) >> CPUCFG19_L2_SETS);
-	ways  = ((config & CPUCFG19_L2_WAYS_M) >> CPUCFG19_L2_WAYS) + 1;
-
-	c->vcache.linesz = lsize;
-	c->vcache.sets = sets;
-	c->vcache.ways = ways;
-	vcache_size = lsize * sets * ways;
-	c->vcache.waysize = vcache_size / c->vcache.ways;
-
-	pr_info("Unified victim cache %ldkB %s, linesize %d bytes.\n",
-		vcache_size >> 10, way_string[c->vcache.ways], c->vcache.linesz);
+	int leaf;
+	struct cache_desc *cdesc = current_cpu_data.cache_leaves;
+	unsigned int cache_present = current_cpu_data.cache_leaves_present;
+
+	leaf = cache_present - 1;
+	if (cache_inclusive(cdesc + leaf)) {
+		flush_cache_leaf(leaf);
+		return;
+	}
+
+	for (leaf = 0; leaf < cache_present; leaf++)
+		flush_cache_leaf(leaf);
 }
 
-static void probe_scache(void)
-{
-	struct cpuinfo_loongarch *c = &current_cpu_data;
-	unsigned int lsize, sets, ways;
-	unsigned int config;
-
-	config = read_cpucfg(LOONGARCH_CPUCFG20);
-	lsize = 1 << ((config & CPUCFG20_L3_SIZE_M) >> CPUCFG20_L3_SIZE);
-	sets  = 1 << ((config & CPUCFG20_L3_SETS_M) >> CPUCFG20_L3_SETS);
-	ways  = ((config & CPUCFG20_L3_WAYS_M) >> CPUCFG20_L3_WAYS) + 1;
-
-	c->scache.linesz = lsize;
-	c->scache.sets = sets;
-	c->scache.ways = ways;
-	/* 4 cores. scaches are shared */
-	scache_size = lsize * sets * ways;
-	c->scache.waysize = scache_size / c->scache.ways;
-
-	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
-		scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
-}
+#define L1IUPRE		(1 << 0)
+#define L1IUUNIFY	(1 << 1)
+#define L1DPRE		(1 << 2)
+
+#define LXIUPRE		(1 << 0)
+#define LXIUUNIFY	(1 << 1)
+#define LXIUPRIV	(1 << 2)
+#define LXIUINCL	(1 << 3)
+#define LXDPRE		(1 << 4)
+#define LXDPRIV		(1 << 5)
+#define LXDINCL		(1 << 6)
+
+#define populate_cache_properties(cfg0, cdesc, level, leaf)				\
+do {											\
+	unsigned int cfg1;								\
+											\
+	cfg1 = read_cpucfg(LOONGARCH_CPUCFG17 + leaf);					\
+	if (level == 1)	{								\
+		cdesc->flags |= CACHE_PRIVATE;						\
+	} else {									\
+		if (cfg0 & LXIUPRIV)							\
+			cdesc->flags |= CACHE_PRIVATE;					\
+		if (cfg0 & LXIUINCL)							\
+			cdesc->flags |= CACHE_INCLUSIVE;				\
+	}										\
+	cdesc->level = level;								\
+	cdesc->flags |= CACHE_PRESENT;							\
+	cdesc->ways = ((cfg1 & CPUCFG_CACHE_WAYS_M) >> CPUCFG_CACHE_WAYS) + 1;		\
+	cdesc->sets = 1 << ((cfg1 & CPUCFG_CACHE_SETS_M) >> CPUCFG_CACHE_SETS);		\
+	cdesc->linesz = 1 << ((cfg1 & CPUCFG_CACHE_LSIZE_M) >> CPUCFG_CACHE_LSIZE);	\
+	cdesc++; leaf++;								\
+} while (0)
 
 void cpu_cache_init(void)
 {
-	probe_pcache();
-	probe_vcache();
-	probe_scache();
-
+	unsigned int leaf = 0, level = 1;
+	unsigned int config = read_cpucfg(LOONGARCH_CPUCFG16);
+	struct cache_desc *cdesc = current_cpu_data.cache_leaves;
+
+	if (config & L1IUPRE) {
+		if (config & L1IUUNIFY)
+			cdesc->type = CACHE_TYPE_UNIFIED;
+		else
+			cdesc->type = CACHE_TYPE_INST;
+		populate_cache_properties(config, cdesc, level, leaf);
+	}
+
+	if (config & L1DPRE) {
+		cdesc->type = CACHE_TYPE_DATA;
+		populate_cache_properties(config, cdesc, level, leaf);
+	}
+
+	config = config >> 3;
+	for (level = 2; level <= CACHE_LEVEL_MAX; level++) {
+		if (!config)
+			break;
+
+		if (config & LXIUPRE) {
+			if (config & LXIUUNIFY)
+				cdesc->type = CACHE_TYPE_UNIFIED;
+			else
+				cdesc->type = CACHE_TYPE_INST;
+			populate_cache_properties(config, cdesc, level, leaf);
+		}
+
+		if (config & LXDPRE) {
+			cdesc->type = CACHE_TYPE_DATA;
+			populate_cache_properties(config, cdesc, level, leaf);
+		}
+
+		config = config >> 7;
+	}
+
+	BUG_ON(leaf > CACHE_LEAVES_MAX);
+
+	current_cpu_data.cache_leaves_present = leaf;
+	current_cpu_data.options |= LOONGARCH_CPU_PREFETCH;
 	shm_align_mask = PAGE_SIZE - 1;
 }
 
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index e9b7c34d9b6d..2726639150bc 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
+#include <asm/cacheflush.h>
 #include <asm/loongson.h>
 
 #define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
@@ -45,12 +46,10 @@ static int __init pcibios_init(void)
 	unsigned int lsize;
 
 	/*
-	 * Set PCI cacheline size to that of the highest level in the
+	 * Set PCI cacheline size to that of the last level in the
 	 * cache hierarchy.
 	 */
-	lsize = cpu_dcache_line_size();
-	lsize = cpu_vcache_line_size() ? : lsize;
-	lsize = cpu_scache_line_size() ? : lsize;
+	lsize = cpu_last_level_cache_line_size();
 
 	BUG_ON(!lsize);
 
-- 
2.31.1

