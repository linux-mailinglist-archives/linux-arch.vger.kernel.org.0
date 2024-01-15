Return-Path: <linux-arch+bounces-1377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCD82E36D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 00:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1EE1C222B5
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 23:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14101B965;
	Mon, 15 Jan 2024 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwbQMIlN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C41CAB6;
	Mon, 15 Jan 2024 23:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516E9C433F1;
	Mon, 15 Jan 2024 23:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361111;
	bh=Of/M26tgjIFZ0crMR+t05m6NUaI2n91rEQ/liJl3EMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwbQMIlNh3xnKgFqz9PA+GQxz9aEpg3kuvJW1Kes3ehwrtQFJQGowTbr5S4WIYd8M
	 /xyei5s1FSGp41A1QHG2g2YloHr2F7kFErON4P+tVWNJvtVc6bmjmuygAx1X7YWU7j
	 scgB2Pk5QJKmeUUCpkCTmjCIA+Cippgp90mmOkvwV6bs1n3WhwbbzvI30QYwuCJa5N
	 4xL9gy+ywXRKPTxCy9oCBHlc1s91qZOwxRBYXhJOvNQUz0M6dcXfG/dsnbSHPAbCYO
	 Hn3kD4a9SzvfEp5oAfUMvuhlJNABqZI1Lo7lMGuJTjWprfeF5bE/6kcpzXA9JwjetV
	 /WO70yA+b1o7w==
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
Subject: [PATCH AUTOSEL 6.6 04/14] arm64: irq: set the correct node for VMAP stack
Date: Mon, 15 Jan 2024 18:24:27 -0500
Message-ID: <20240115232501.208889-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232501.208889-1-sashal@kernel.org>
References: <20240115232501.208889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 6ad5c6ef5329..9f253d8efe90 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/exception.h>
+#include <asm/numa.h>
 #include <asm/softirq_stack.h>
 #include <asm/stacktrace.h>
 #include <asm/vmap_stack.h>
@@ -51,13 +52,13 @@ static void init_irq_scs(void)
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
index eaa31e567d1e..5b59d133b6af 100644
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


