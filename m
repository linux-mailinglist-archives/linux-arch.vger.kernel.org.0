Return-Path: <linux-arch+bounces-245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429A7F00CF
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5BB280F48
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3209171B9;
	Sat, 18 Nov 2023 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IUezXz9I"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2109.outbound.protection.outlook.com [40.107.92.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77D182;
	Sat, 18 Nov 2023 08:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVYE/WkwsmMmJVugsf6lCgeB62pMNDivyRnrFTl8+aT34O41rFiCTPOMVQc+elHTOt23OqIg87GPRV7QTI0ket5S4+XbuN2bctlaM2jeWULyfxgXK0ridkzNbrU2x48Xe2kCaLAiI2ixpD1XnQOcVvBa3nrYGOA6tpXaBdnRz16VV3Uo4Wl0vChaIMdecZ0C/kZ6vzZd8hqi8RLhCPWUtC90rRabH7CYZhUCYftpT5mM7SHX+t67hVPyncKJLhKxJPUiFWdsMZWo0zyIFRTuEixIO8Vw9tgirRS58RgK2km5U6dMxSqGdd1mIKUUcsSfGiiktKHzUC8l+212LFBntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv2MhPhz8vX5EVXTcetWaN6ncrvpW3Me+2LRl1lemRQ=;
 b=h1PBNTMcB9nn5Kor+BZk4/4VL1BkF48jpi/oJvVoCXoAi6xKNnasaMuKQPfifii62+o8zMhrCmC/U/43KAr6xK0DyRzxSkWCrjRAImNVCM5AZDREsUoY7kt6vrI5NtveUiGlyhQIWu8g5ganMifVNdq8TbagpJT6YAH1v40dfVMh+2FZDgBunNiFphD2a7Qrp12ETEsI2uE9BSJ3g6Nm2NhbMIgsVuoizbaayb4+Sm1BKqdismj2GkgKVT3hlMmiJgthko5hXcpmEJGX3MYpk7dfhRjRZM4djAv3S1wQBNlzMuihoozuoYwAXJsK7jvL5YXHveo/Fr+EsppgGJ+eIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv2MhPhz8vX5EVXTcetWaN6ncrvpW3Me+2LRl1lemRQ=;
 b=IUezXz9IBNiQFOeyUY2OP0YRRmdUWbm/Ml6gB+MFFQduRZAiePtreHAewtgmkMqXxYXtbz91Fnv7S/PuWcks5RmrJIuyffc+q7aLUy4BNSm7ItTY6nk8Qb8ggbt41pyP91U3ENfQsdytJgQFcM9dkjmkvz0fFFjMbZAZ+4h1Eh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 IA0PR01MB8306.prod.exchangelabs.com (2603:10b6:208:480::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.25; Sat, 18 Nov 2023 16:02:32 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.6977.028; Sat, 18 Nov 2023
 16:02:32 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	arnd@arndb.de,
	mark.rutland@arm.com,
	broonie@kernel.org,
	keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	patches@amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3] arm64: irq: set the correct node for VMAP stack
Date: Sun, 19 Nov 2023 00:02:05 +0800
Message-Id: <20231118160205.3923-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZVZO55IjQSbzWnfG@arm.com>
References: <ZVZO55IjQSbzWnfG@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::14) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|IA0PR01MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d36c0ee-4d1a-44ad-704d-08dbe84fc578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nC8TVmGGqpY7I48bdngWs164A5sdGUTuITlZWfudmdiobWnuxrTMKGZiGDWxfxv1+HO5rX1b0qiVZkf9Qw7kq58ZElIxDbmsHxehdJ1ORnui+KWJwQvyPt6Y1xZ4bbwDiNTPQcNakHeQspp3+K4QIVeBhrqedqgTKhJCLTsoHV0HoAnq+hQ/i8BayE5TYUa2zaD53rnQxAe8F4JOYKLWvwvNn7uEpOpEQ5l8xNl66J0HmRcHDoJOI8g+3KZKA+FqjAqbILaO3UMC6nSn/h+UfqkZKSO/tWbv2IOGAU6F+MWX7W0SXL922szIOgCZw1QbGHNl6kYgGxcg37+Guua7ZbZpe5NxA89hZ25H7F6+g2UC9daQfJJ5rfoONQV9YVKwNINk/HPBhZDuwpDbPfCbz4ilpEzlmtVaXqhyY1GGWtMjwOU2CABuONYROilpyABnJJSpz5KDezcVMIff4rTiOMEje/LUGoXOTSCdSdqMfgTJtZYHxJxnNNPGi8uZLjU6v0Lybj4US438k3H/VIYIjJCain9RNb7CDyCrJcxmGy7/MEgl9+vOpRZpz50wfJPzl7SPWSYhsx6Vh8vwV6faw3F5E4Z5RLRCEkb/rCGbBRlnkLF2PudUnr5F9Fsuvava
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(66476007)(66946007)(6916009)(316002)(52116002)(6512007)(6666004)(6506007)(2616005)(26005)(1076003)(107886003)(478600001)(6486002)(38350700005)(38100700002)(83380400001)(86362001)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8NJEKdv7MXmP7KocyeknDxYAavKS/wWC3OR0PZoCYY5tbm6va9dDGkwBrx6?=
 =?us-ascii?Q?bguIp1gzMm5gyMTb/icATkP48/zi9qrq1BZjR6X11rqi5cuQ8vM3O057aXvE?=
 =?us-ascii?Q?DJMTlUeeAoLoIeh3/CcGy/32zsFB/7JHVQUXuwbeU0jElXJKDfT31bWZmemO?=
 =?us-ascii?Q?/fxKoz5n+CG0zmFTaSBhZsmIH/XLgEAgfiGQm5u2dVaVbXiQlNnN7DPUNMW3?=
 =?us-ascii?Q?aJsYeAzq0rwGkHIygyCsHe5lvvasar0Wd8YWHc3C24tKG9TXLzJlr2AKnFql?=
 =?us-ascii?Q?/4tS1KF8QfP2HuHM7DFb00wdTY8SZ9Bzx/wwR9Q/zncjR2Yo5+jUM1EYGMKH?=
 =?us-ascii?Q?WK45fGQD6HnvMEgztnLItcwIFxgJ11tnnifUTHnYU+Z/bssnZeBi67/Lv2oY?=
 =?us-ascii?Q?GbCWD2L5KbaTnOCYUTvwqZ6FYo5SmByLuneRsyioULLwqHjAfg86jGWsOlkh?=
 =?us-ascii?Q?u2HSuHtqH9AhJvT0v122H98qVx8i4Td0qzwjVaGKXrAOscvw8t8oQ4NIFT0O?=
 =?us-ascii?Q?FscxhJ2NrMWIr4npo9KxrMoR6nK/bDCi9BRBM4Gd62Qb8FV/KG9q7WPaIRgq?=
 =?us-ascii?Q?0/xdrMs6svS7xcXQ5ikxxVXeCUEP6kLjGbKJAB8jUKbqROL/6+EEHQ0UzZ9Z?=
 =?us-ascii?Q?CA0Orbwpuze2O9glDMRRm/WJy3cdBu4O9CC00+osHW0lcpD+fOdXajZMV6uH?=
 =?us-ascii?Q?QN+L+6zCbeq4O39QXjEDzPqpoEfDB2IEX5WvZkzc5ItspWHdmuNdfQYoS+Kt?=
 =?us-ascii?Q?1SjWgBF6TqCxxJ2Jos6Rzr3W+jIw94vn6yWrUaqRPeOK9zPKmunshm70FYmW?=
 =?us-ascii?Q?ejUsTEhH6JviA7xaVS1WBCyqdjsQ+FzRyqIq3JK6LHcEALOY3sloIIu5d1zd?=
 =?us-ascii?Q?IL02y8xvU/oDE5O82PX/yc3B7hjdBtPQBlI79r5OZ4sH2fMbNTOBDFVyrh9B?=
 =?us-ascii?Q?DGE5xualowQP+i6UcGJIuLD5uDivSeFc/S77fsPfgtLhJkn8onxd3S7E+Nc9?=
 =?us-ascii?Q?DN4sYFYDBjivFeT92TtMvXpWNLFIblxvUGdh3Eq8+2JEH10HEkLXTN8olDok?=
 =?us-ascii?Q?sphuxRShQRy89D/5FtTataEFdVHlX3h1P1uBHMG2pFNI6b+8bz/4DaGhUjBu?=
 =?us-ascii?Q?aGBYQTgkHHfOzY7znYIQ2kGRcGNxEK0md+tVPuKVrzn+Y82gI6vLZDeZczbP?=
 =?us-ascii?Q?wDchh/sgnIK/mZUk/RbeVIMKcsdRuXfWPSosz/HTGmMSSYHz9J4QNcZ8HH8J?=
 =?us-ascii?Q?AkZCaDbs0OGW5oVLv0CKZna0ElcsEEBy3StFX9EV8FLC/8L9/yMk4CToVlOP?=
 =?us-ascii?Q?dhDACZ8sOGf9hiK1Kf7yswIGZy1x309RkkJYPZxNU0DBem6HKr4BNRO2x8uX?=
 =?us-ascii?Q?x9F9NFS2Va55dtb2VJfF7xwLwOAiqUVfzXejEOkcAY1U3I+dYiLNZRd347MA?=
 =?us-ascii?Q?SWTlyn57sfKSLK7JeDTDbcpW9nyJ7/XsH+QKlXxGkZMijuwePi8Z+Qy07czK?=
 =?us-ascii?Q?JlBy/2T8A/WVwZlO3L+8eX6WyjEhaRITiZKN+skKW0BQPQwWIUZGmLnWJJ6j?=
 =?us-ascii?Q?Fyl/XnSunz2gfGdjU5MJ2mAQM25aGhxYjsu8jkLmVb7ZaFVNFozWsN1ItKZQ?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d36c0ee-4d1a-44ad-704d-08dbe84fc578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 16:02:31.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlRs/yK7rDRQIWa8tsCRGI5iApSbE90Hdo9ajnOm8+l8i/i3Bo3iIMM1MK6sCjnn3SePn5PDMdOX80TeFHZIy8FGg9vHvyof77bKx8I5XNXucHFnaTV23XnJyWQSYQtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8306

In current code, init_irq_stacks() will call cpu_to_node().
The cpu_to_node() depends on percpu "numa_node" which is initialized in:
     arch_call_rest_init() --> rest_init() -- kernel_init()
	--> kernel_init_freeable() --> smp_prepare_cpus()

But init_irq_stacks() is called in init_IRQ() which is before
arch_call_rest_init().

So in init_irq_stacks(), the cpu_to_node() does not work, it
always return 0. In NUMA, it makes the node 1 cpu accesses the IRQ stack which
is in the node 0.

This patch fixes it by exporting the early_cpu_to_node(), and use it
in the init_irq_stacks().

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v2 --> v3:
	move the "numa.h" to the right position.
---
 arch/arm64/kernel/irq.c    | 3 ++-
 drivers/base/arch_numa.c   | 2 +-
 include/asm-generic/numa.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 6ad5c6ef5329..d9ee14723478 100644
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
@@ -57,7 +58,7 @@ static void init_irq_stacks(void)
 	unsigned long *p;
 
 	for_each_possible_cpu(cpu) {
-		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
+		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
 		per_cpu(irq_stack_ptr, cpu) = p;
 	}
 }
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index eaa31e567d1e..90519d981471 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static int __init early_cpu_to_node(int cpu)
+int early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 1a3ad6d29833..16073111bffc 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
+int early_cpu_to_node(int cpu);
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
2.40.1


