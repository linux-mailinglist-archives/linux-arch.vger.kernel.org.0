Return-Path: <linux-arch+bounces-433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 103547F6AD6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 04:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8512B20DF0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808E7F5;
	Fri, 24 Nov 2023 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jae3BwU8"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24910F5;
	Thu, 23 Nov 2023 19:16:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVRq42zz8rr70Cj8gFygwyhLDvI04I7COfMNXFvkd8ydCk3t6i9uoGe4HpLYFC2RyfaLxrnHzaOECnZGmJtZraGTIACXoMbxEx+gG/hY45WqwP+7IR5L6+5uCKyJlkalcYZfN5Ysgi5eCnutOf4vx7S580hfXzyzPW/cLIS5ruM/fqVYzgTzAAQ9pes/mWAiJs9KLmbLgyAxwkgoylCzoK40KIQclogkyY4DCKtPFOVfFlup2Q7pcYhkahMWWji6TqRowBIqVmwpp+yxLHQJAKKRjvTd00rdHyEmbd3qvUmGqxp1NG+B8iuAv8YzIwjytQsSr/mbRTbw5/7knzurvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ULVDnZW07tHeZLi9IvabMzFmsTEFLea4bY33CL7RzY=;
 b=XLh6UPez4HmZS8qZhrHevcNZKbZBwtVx4P7TB9ywrlpujeGFA/R/nlC63jyE2sOzRFWQpo7gAEcr/qLtdOCTslQqrpk+wy5t7R/Iq6GR0FYb3UPcRsAWao9JycgEWZYXA+DYz/8mkMzWuEhNA8C9WzsmaemY+c/5ZxMyYHBA8CpA/dx3xGkRTHR2AOYT8o7dNUEfS/lEfvirCZXcCXEFVDpzLa0sp3l0Iz8bNONoGeqig2JEveUh4erFtXvTifg4Sn7hy/EqYex5iD+dGfw0LVZCRB+WWQMnoo1/VMI8Jc3fQGHU+TsOgaTQ4gDhltQ6wfdAAVNRkInflyZan20vuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULVDnZW07tHeZLi9IvabMzFmsTEFLea4bY33CL7RzY=;
 b=jae3BwU8oncvo+TxnQeGkIfZ5caL1yCwRSp3gzbOY6aGzrk0E4TIJpYNLrSbjkMkeUFscsZYVqNCuqWmHiy8ar4hclVyVVO4cK0YQnH19rWU5wjk9Dt7yVRZWdKte3FgP4p8E/GfJxnKcCaZ2Q4COcLSsOv6BJrptPlOu/MOI/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB6102.prod.exchangelabs.com (2603:10b6:510:13::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.21; Fri, 24 Nov 2023 03:16:02 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 03:16:01 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v4] arm64: irq: set the correct node for VMAP stack
Date: Fri, 24 Nov 2023 11:15:13 +0800
Message-Id: <20231124031513.81548-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZV-EA46rBJ9WK4UH@arm.com>
References: <ZV-EA46rBJ9WK4UH@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 89449542-e180-4de6-dd50-08dbec9ba416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	so55jnm1HnBjNs2MBoteuvelyJHgH1k1QWDSRGW8sLt/n/qLz8Q2wkaBJgtEx/1VpD7Ql4i9WpoZ2aoaR/Lvb93JTnl4VE4LrpiY7JzzsUdDcMdc+0drza3r9jNj/MKiWDhN0y+yAB56twxCkN50tOC67JxvJVsmCWJxdWNIwZX5hzxP3yOcH9qeYKW2gTXuIwzqbkI4FVThy/UXIEFUWVLAJqfyeBCXobQ9bPwfd0AdiUNMdksWjX7YtNB0qTsamnFAJ3u37HEVy4N3xvJTMVEnuLBlmU0R0cX9QL30O9pQ0oP89+eDAm70rVTfXh4i30vdyYCIilsjY3f+Ys4/5ka6bmugYQJ9aRXnBakPIkCHLbgY/PGufw76ysP3U84CNdUfRC6DE7oGBHfuicU+tauy4uEfg+OUVHEU6vLYZAgRJbU0Poi4PCJJ7ayGBzj6/CbqhFJKr1Yeo9nOzVUAvV0ML4bF9Z0FnxSgFPqsUQxazLIEHX9jpNAMfP4SC4a7CRzQG2WD8jTVelfJyZgazIa+EnKf8eak5q7VynUbxwlHFsrBqiWu41Kwkx8QJqJYKD+VXQntuEidfCtdMlavAFwgmw+B1HLApfywTXPyUY1CrEG8/bDgZdPhharr9Euk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(478600001)(6506007)(52116002)(6666004)(38350700005)(5660300002)(86362001)(8936002)(2906002)(41300700001)(66946007)(38100700002)(66476007)(66556008)(6916009)(4326008)(8676002)(316002)(107886003)(1076003)(2616005)(83380400001)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oo16UmguACxF1IBAwcY3BB+j1ptMBo32AmusLeEMHJLDeJzdnbhVBctWNwdt?=
 =?us-ascii?Q?ULcYW8aXHH6YkpSc1AKTv4GjwUxub3i28/TJEkCe+4LpPAL2Y8NyB3DkkStP?=
 =?us-ascii?Q?AUb6U3Uo388v0Rk9olt+aucJxb1S9O7FYbNJfKfy0gxZrPtTPQbGNWzDxhUT?=
 =?us-ascii?Q?EkatqTv8aZGwketz8S6bPpfmUmiNFEBiwhWSu9dNmvK8fWxGjyv79K5ca+fJ?=
 =?us-ascii?Q?jGYdMOBZZRGhqi8r6rRNzetE3G8/P9UWiF5vZ98trtjv4gZMarXFnzbseJur?=
 =?us-ascii?Q?0dcoB+RyqsqxE04GJEX2qiEOSfrNnp9jyuevINCHuJ1R7SJCFKDki1aRViAf?=
 =?us-ascii?Q?MrrvqKH+gOx3XtFW0kG2I8H/RP0QovDm7gna2iikiRHuv48gZr1iSElmf0I0?=
 =?us-ascii?Q?HPDFwgpwOhDRXzeH3rrwh/ZjgqW2gHXTt8fvN+9gOaHZQTPw9FCFLl+KL3oE?=
 =?us-ascii?Q?uum9kSMFXJ7TddWJsLkZZNh4H4U5r1awRzCTy1iZTv2Zw5SjB7gTtFTjAxFC?=
 =?us-ascii?Q?AIaeM6S6fYHEIifYnOexmOdHWyevd/BoV7RWfceMRdS7to8tHmJWFnaNmoiH?=
 =?us-ascii?Q?67CZnq/l3g68VloWlRv9XfETxXaWtznz1vBUWbFBblBh+aJhG0FAQ2bGSjvD?=
 =?us-ascii?Q?q5wicIJwRmg9375xLH2k5/z4evzF/PGCmpGANCVPdgSDjdYXzvQOYaEeipul?=
 =?us-ascii?Q?9H9faLFXjOna2644N/khVztBfuLgXef3ASlA9dc4AJFLIiwy8T422yNvvH/O?=
 =?us-ascii?Q?sTbY2bHG54oKDFOMX2WJnVRfdXUvUWBtAePQ2hPh9vFSFP0+5ExIu5YDTqXz?=
 =?us-ascii?Q?k/tME9+y+b4k/hGJUZ6Fwqo8m/m3mXifEzWDx/DqsEQROyJPo2CxEfow+cqI?=
 =?us-ascii?Q?oBYQKSjAs3MUbeJ8qY2hXEKhLWl7EEXolBfpknk7XDpFkyM4K12m6zmRuaEM?=
 =?us-ascii?Q?aSZqmvOulfpn0ezEHJxpHIwM8MEnTwb1XisawtCZtJ22dzXeAjVWiSVQ/stM?=
 =?us-ascii?Q?gz00Tu4jiOyi5vE53/hIHwWtvhTYfBGAVaN5JM7xAxiVj4QwLEWve7N2U4wI?=
 =?us-ascii?Q?E1VQE/+2j++aZnUdaHckQrhUCcMwWN5oCqCL6voxP3RVcUOmkoFncFthNohH?=
 =?us-ascii?Q?EJE7Ynqg/5EfwQsPVHCsgtaxHjbCqP2K5kGUnRtW0xknsIaGxtOy2mysIVNb?=
 =?us-ascii?Q?VDTt0jDsP4O0d/u/Eb9ESp2J1Uif0jTfhPshUoM1NWOjYa0HDmmnYk6M1SWk?=
 =?us-ascii?Q?9ktlXxIOt2d+Cp0hjKNYUBLXTP1QAetzsuLFFFxu1l84v6I5IjF6AEkq2tWN?=
 =?us-ascii?Q?Wfd5Jmu4CeCbDAHb6p46Ue8QJoCI7oUr7KCabcV47UPF+ccs/vTYjMAbCWQZ?=
 =?us-ascii?Q?Qn7yJ62zK9F2RcUHWnoz/hm0q0Bv/swMtH0d2cg5ZO+DgFUvOa2KK0/a9dom?=
 =?us-ascii?Q?tFY36Dga0ZqmJtCDUf5cg+ZTY7wvw5CQwcbs8cVvMJMLRFNSjJi4ZcboRsW/?=
 =?us-ascii?Q?8gvLe/2XgDa8JyUDTD5Wey+Tp0CB6kd79VoOSge0o/643zKqqxy3j54VIL+k?=
 =?us-ascii?Q?CguJDpEGxH6J4zqlWjKwb6FCAkNu6FIZAQEOLi86R+3y6jqaZR5MuSQofyGT?=
 =?us-ascii?Q?2QcaSxzrK770QKgY0njJXd0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89449542-e180-4de6-dd50-08dbec9ba416
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 03:15:42.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy5GGw4rt24749QG8bw1sO3/f4mCKegzKvKZ3C+IqV/h9+eb0E10bpOLGRfqxsq4AwC2gvx05T0Ey3xbyES02uH3lKoDYbikqCgKGzDZt5CHa5KM/pUMUHCDvYvUPHOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6102

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
---
v3 --> v4:
	1.) keep early_cpu_to_node() as __init function.
	2.) change init_irq_stacks() to __init function.

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
2.40.1


