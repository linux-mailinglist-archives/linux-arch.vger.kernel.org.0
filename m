Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D328331C9A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 02:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCIBzo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 20:55:44 -0500
Received: from mail.loongson.cn ([114.242.206.163]:37644 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229611AbhCIBza (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 20:55:30 -0500
Received: from localhost.localdomain (unknown [196.245.9.44])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax2dVS1UZg+DIXAA--.8336S4;
        Tue, 09 Mar 2021 09:55:22 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH 2/2] MIPS: loongson64: alloc pglist_data at run time
Date:   Tue,  9 Mar 2021 09:54:21 +0800
Message-Id: <20210309015421.32595-3-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309015421.32595-1-huangpei@loongson.cn>
References: <20210309015421.32595-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9Ax2dVS1UZg+DIXAA--.8336S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyfXFykZr18JFy3Zw4rGrg_yoW8ur43pr
        y3A3Wrtay5tr1S9FySqFW8ZrySyw18Ca1xtFW29FyxZa9rWryIgFy7KFy0g3y5tFWkZF15
        JrZ0qF17WFs7JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVCF1wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x0JUHbyAUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Loongson64 allocates arrays of pglist_data statically and is located
at Node 0, and cpu from Nodes other than 0 need remote access to
pglist_data and zone info.

Delay pglist_data allocation till run time, and make it NUMA-aware

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/loongson64/numa.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index cf9459f79f9b..afafd367cb38 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -26,7 +26,6 @@
 #include <asm/wbflush.h>
 #include <boot_param.h>
 
-static struct pglist_data prealloc__node_data[MAX_NUMNODES];
 unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
 EXPORT_SYMBOL(__node_distances);
 struct pglist_data *__node_data[MAX_NUMNODES];
@@ -151,8 +150,12 @@ static void __init szmem(unsigned int node)
 
 static void __init node_mem_init(unsigned int node)
 {
+	struct pglist_data *nd;
 	unsigned long node_addrspace_offset;
 	unsigned long start_pfn, end_pfn;
+	unsigned long nd_pa;
+	int tnid;
+	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
 
 	node_addrspace_offset = nid_to_addrbase(node);
 	pr_info("Node%d's addrspace_offset is 0x%lx\n",
@@ -162,8 +165,16 @@ static void __init node_mem_init(unsigned int node)
 	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
 		node, start_pfn, end_pfn);
 
-	__node_data[node] = prealloc__node_data + node;
-
+	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, node);
+	if (!nd_pa)
+		panic("Cannot allocate %zu bytes for node %d data\n",
+		      nd_size, node);
+	nd = __va(nd_pa);
+	memset(nd, 0, sizeof(struct pglist_data));
+	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
+	if (tnid != node)
+		pr_info("NODE_DATA(%d) on node %d\n", node, tnid);
+	__node_data[node] = nd;
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
-- 
2.17.1

