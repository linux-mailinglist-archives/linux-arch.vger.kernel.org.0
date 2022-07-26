Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA50A5813C1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jul 2022 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiGZNEQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGZNEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 09:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95A15FF7
        for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2022 06:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFF96154C
        for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2022 13:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F09FC341C8;
        Tue, 26 Jul 2022 13:04:11 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix shared cache size calculation
Date:   Tue, 26 Jul 2022 21:04:40 +0800
Message-Id: <20220726130440.3997832-1-chenhuacai@loongson.cn>
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

Current calculation of shared cache size is from the node (die) scope,
but we hope 'lscpu' to show the shared cache size of the whole package
for multi-die chips (e.g., Loongson-3C5000L, which contains 4 dies in
one package). So fix it by multiplying nodes_per_package.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/cacheinfo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
index b38f5489d094..4662b06269f4 100644
--- a/arch/loongarch/kernel/cacheinfo.c
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -4,8 +4,9 @@
  *
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
-#include <asm/cpu-info.h>
 #include <linux/cacheinfo.h>
+#include <asm/bootinfo.h>
+#include <asm/cpu-info.h>
 
 /* Populates leaf and increments to next leaf */
 #define populate_cache(cache, leaf, c_level, c_type)		\
@@ -17,6 +18,8 @@ do {								\
 	leaf->ways_of_associativity = c->cache.ways;		\
 	leaf->size = c->cache.linesz * c->cache.sets *		\
 		c->cache.ways;					\
+	if (leaf->level > 2)					\
+		leaf->size *= nodes_per_package;		\
 	leaf++;							\
 } while (0)
 
@@ -95,11 +98,15 @@ static void cache_cpumap_setup(unsigned int cpu)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	int level = 1;
+	int level = 1, nodes_per_package = 1;
 	struct cpuinfo_loongarch *c = &current_cpu_data;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 
+	if (loongson_sysconf.nr_nodes > 1)
+		nodes_per_package = loongson_sysconf.cores_per_package
+					/ loongson_sysconf.cores_per_node;
+
 	if (c->icache.waysize) {
 		populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA);
 		populate_cache(icache, this_leaf, level++, CACHE_TYPE_INST);
-- 
2.31.1

