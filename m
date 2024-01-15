Return-Path: <linux-arch+bounces-1380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FF82E3B9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 00:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2245728710B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DB219EF;
	Mon, 15 Jan 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI16xNMh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7841C2BC;
	Mon, 15 Jan 2024 23:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6A0C433C7;
	Mon, 15 Jan 2024 23:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361246;
	bh=SLjTFVzCCuFtlCTLtbQ8mH7lK3/LrsRsGGDoB43LPJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LI16xNMh5cNPH5hn5aIIF+HNsWkDmq35wqPe8QDIq+YYf9FojELEQjfJqjU+3MPC6
	 HG23tpCPi8ZYC4WQQTS+9x3UAV2rWGDIQUxSj5WKAheDwA8Gy7S9T31b1NCVft3Ayo
	 2mEoDzYcNt4BLqv8F1xmPfiRr5MH9U9ziThNc5uWqTbA44XmhonWd7VT58xCx39u9L
	 MyiK0QoPsI0c5NYQUwdI/HLnFOw/Wc73I+vXDIdLKAECN1nis9W/m++a8/PFd92V0Y
	 3qxBKsg7OItxRYOoagDDRNf3mXg7M4byViDYcX0N1gbD2CetYQOBKK3cPBk7xms/dG
	 PDWJzz1Wae/fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/12] arm64: irq: set the correct node for VMAP stack
Date: Mon, 15 Jan 2024 18:26:48 -0500
Message-ID: <20240115232718.209642-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Huang Shijie <shijie@os.amperecomputing.com>

[ Upstream commit 75b5e0bf90bffaca4b1f19114065dc59f5cc161f ]

In current code, init_irq_stacks() will call cpu_to_node().
The cpu_to_node() depends on percpu "numa_node" which is initialized in:
     arch_call_rest_init() --> rest_init() -- kernel_init()
	--> kernel_init_freeable() --> smp_prepare_cpus()

But init_irq_stacks() is called in init_IRQ() which is before
arch_call_rest_init().

So in init_irq_stacks(), the cpu_to_node() does not work, it
always return 0. In NUMA, it makes the node 1 cpu accesses the IRQ stack which
is in the node 0.

This patch fixes it by:
  1.) export the early_cpu_to_node(), and use it in the init_irq_stacks().
  2.) change init_irq_stacks() to __init function.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20231124031513.81548-1-shijie@os.amperecomputing.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/irq.c    | 5 +++--
 drivers/base/arch_numa.c   | 2 +-
 include/asm-generic/numa.h | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..dab45f19df49 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -19,6 +19,7 @@
 #include <linux/kprobes.h>
 #include <linux/scs.h>
 #include <linux/seq_file.h>
+#include <asm/numa.h>
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
@@ -48,13 +49,13 @@ static void init_irq_scs(void)
 }
 
 #ifdef CONFIG_VMAP_STACK
-static void init_irq_stacks(void)
+static void __init init_irq_stacks(void)
 {
 	int cpu;
 	unsigned long *p;
 
 	for_each_possible_cpu(cpu) {
-		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
+		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
 		per_cpu(irq_stack_ptr, cpu) = p;
 	}
 }
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 00fb4120a5b3..bce0902dccb4 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static int __init early_cpu_to_node(int cpu)
+int __init early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 1a3ad6d29833..c32e0cf23c90 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
+int __init early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
@@ -46,6 +47,7 @@ static inline void numa_add_cpu(unsigned int cpu) { }
 static inline void numa_remove_cpu(unsigned int cpu) { }
 static inline void arch_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+static inline int early_cpu_to_node(int cpu) { return 0; }
 
 #endif	/* CONFIG_NUMA */
 
-- 
2.43.0


