Return-Path: <linux-arch+bounces-213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249A7EACDE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F761C2074B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185D16421;
	Tue, 14 Nov 2023 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j4I9ExqK"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667516403
	for <linux-arch@vger.kernel.org>; Tue, 14 Nov 2023 09:17:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2126.outbound.protection.outlook.com [40.107.100.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D019F;
	Tue, 14 Nov 2023 01:17:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8XJKTiJHC8SqtnUAwwbYPZvmzdI1PQ1t3wCjo49KCGehZahiTViysGIzcD6mXYnhRkYGYMkqEAvIaNlERIDExD7s+R6VGn+DBRCJFk9fm1IutjEWe9mA3q6z4WyDeeNLIJvm2LIQxAHbvMSdcVIHCYLQgKtoD2Db8RgVfz4bKilACoHyId4U6g0kl6y0Bu9ZGQUOioHkWe9s9D7r04sl4ydpjMotwQbR8YIJoTDvpVSZbnVwZwhhWXPzqdEzv3WVDHRiE/nNIBnq40Icnmko3yYFNCPk8+LsbZrGH0WjNgSJscXbcCvjdP0FFieX1ybqcRZLyBEW/9OEzUFW/m52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCTfLweAjmMubihY6xBAwiJ+HbPDBA38ZcHvNO04dMc=;
 b=csPT7I6l0c1UhOKvzttTS716DMNpNc4vqPVfAfmG4cIRwYglfqSR2okXPfpIX0JS1JTjLGRER56xByDUGQ7IU6+ks7Dp6hD1h2WGA5Z2BsNtF6jgwe67CeSPn//PAwAuqHJLaTnzQjrI717YKUMsWbUf2Fa6CcbtS5ctgMApgGaCI/e2u3nDEGOVE8gRlVHNjPKRtF9uQ67BdAueTWxStaznvIuaQMuPP5aTHFAWE0jWCqkNRbw606HTiOFvd/IV9Nvq0bD9pyk2uwa2q82vRDyx7g9F5Kuq8k+BIx5XJ/n7PnsCGRi1WVaosJPAjYMPzDrN8B4swkq4+A1jm1cdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCTfLweAjmMubihY6xBAwiJ+HbPDBA38ZcHvNO04dMc=;
 b=j4I9ExqK8onfDsmEVZwfw4DV+FIWEBdWwuOuEk4SY5Uft0SLSNfHEwsCpD4KC0l43UiTodYkagn7/3CdxCybdyZeswoRbBobRuKxuOlLhi9X0wd5/UkO2f8CGWykttr8SKWaK8tILajwv/71ahn1MbQdjirlcvgJtPTRAd2A3s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB7196.prod.exchangelabs.com (2603:10b6:208:347::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 09:17:50 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.6977.028; Tue, 14 Nov 2023
 09:17:49 +0000
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
Subject: [PATCH] arm64: irq: set the correct node for VMAP stack
Date: Tue, 14 Nov 2023 17:16:43 +0800
Message-Id: <20231114091643.59530-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:610:e5::29) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: fb359013-e710-4a3d-205f-08dbe4f2923a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ifcpzH0LgExv3zxsy24q+LnIwsGZbxY1snmOSABxosOZuMJBbW6WVOGt34nKd8wag8UXDXLPyZf06LJW1ll75Lb9mjMzZZ/9hOW1hFdo7KJ4rtew1D3JeuHXlUL1AZwm1eWdj/IntG90u53vCnoylggLWhbCo1RJFWkGFDeAU1ExfBWPjn8OAvcThNGKEcJOqPvYXiey97p+r/W3RP5d/qbay1xeteec3rZLHtf/nOK8BriPe3VM9HVSOT1NHUrBztQLUs/CwIvV7+utYEzffidql6ybOnoxSbwIsVonu+Zn8noeSPioZWTkODldXzpG98jKM4RtwQIisdYLE2O5Wfh+hNJIq98YNl96W7MClB4X2RRb322EYfQZiHeJXRD4grwMb/57tMEZwnd2dbIP8RYBQnj0HEUoNw/m//s8FZhtPygXMqRJ4qyDodJNddugc+ZJE7s4mnHbm3MBHEhxrPIz0HOIAHalBWqt216EkL5te6dtHrNVBktrfPqMY7OzXG/WeeWdSHa6UQeAeEYxS2HMeSU394YokmOyqQBxw26mVAs8infuzNX7liRO4zehCSdEuNOrnE6djVJ2Rjr0IiLwQwAfmS46bIHtgZJxBl4/qVlor1fV0aCLctEw2qsF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39850400004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(86362001)(83380400001)(26005)(6666004)(6486002)(478600001)(1076003)(6512007)(2616005)(107886003)(38100700002)(52116002)(6506007)(41300700001)(2906002)(6916009)(5660300002)(7416002)(66556008)(8936002)(4326008)(66476007)(8676002)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzpe3EHoDwXf8k8btOens2RUmCiX7k5iH+w+JG0Lsh3KxqgWysuOls13vkQ2?=
 =?us-ascii?Q?6kMjCUK0olLQ0VYdixsN1kG10P/q83q5WKKpokkTYFQ+hrgIZ5mljRYMydpT?=
 =?us-ascii?Q?8eU98M6CYXWNhSScmEALVBtdP+YnaIzOnZPjz6WDUHvgWayj4PDlB9PG+n+7?=
 =?us-ascii?Q?psoEq+6pIsork7TTjqSuUNRNkV53EuMAYeerJmTHeAQVbewOQx/xGjVwRCgm?=
 =?us-ascii?Q?SJR0tCr6xHUHzN8UExgOAizLKFtc8uaHgrc51LV0pXW9L4v1dbxXJOJEDUnE?=
 =?us-ascii?Q?wnwbMRRxQUdeIxo+eON9q2SnlcK2MQZe0kMQyjbMNG5n0W6isEOsz8Vylx43?=
 =?us-ascii?Q?ylxcYxuo+yckwl1EDZ+XpYUsq1pnD8ZSOSD0NJhYySOQvZhq19KRJ8pBM1YQ?=
 =?us-ascii?Q?/rtN4mIf2PeO2YCPxlwQaHTcues77U0HyHNxBWSRKQCu9e7ua8aUsr1H1qqp?=
 =?us-ascii?Q?Fqq6H3CE7vhK8hVYqArhhpwB9z/xmOKa6ufix0nQhLfioawKBHsSTebosZ9F?=
 =?us-ascii?Q?FDzsLTBIJGKV+SDX4HqNvabUpZpuK1IKXZOffaV5tS5942kL8C5LhHTufibW?=
 =?us-ascii?Q?0eEMp1F7idYnUOAigorxBgXUvZ8DfYhZXJxrJjkroC3eKuv9Yfx0qMClDpaj?=
 =?us-ascii?Q?mLLAi4l7Lt/tRJBwY6GziQgsVzE1Ekzv45SED/Y0gt9/zKdEa49uVDPSumCM?=
 =?us-ascii?Q?BHPK/NIK7yXVlYq4Fxgley3UpShpAY275WuyFIM4Ekps38+JNUBcIseG9CDc?=
 =?us-ascii?Q?2DyGRkxnlHDSdy+DmNeNqVx/B9rx1NEIORIOk0v5LuaqBsrfYe7Iijc2mBRM?=
 =?us-ascii?Q?y9S1BXYxads5ExCY8ceSGmHmd4PLTpA0wbi7hsa7IbJtq2IMrKf116Q29dGb?=
 =?us-ascii?Q?R4b5FeTzwiEtwcJ6Sl13dGnOIzHOvMBW6VQrjj/WE9o64Hb4awBBSvDZxAD3?=
 =?us-ascii?Q?uN8f3jShxVXttOwI3cDS8VCA7ZUVEmCxJPzvmIVEqAprnln+fj4TXa2jJTzh?=
 =?us-ascii?Q?uagrvpXptqPWNsim+Ggq7XcY0JBxeQYD09hU1Z2qeftPM0gC6QNit5eQVma0?=
 =?us-ascii?Q?i8TD9LrQOZzmf+UjXk8WD2avnxQBWCC44FUfHolE5RBdIf4gQqAvAwFrBjYP?=
 =?us-ascii?Q?U23d3aymWhi0twl9/SZyFiqrgPznOdvfoPlCuaIutomer2X2tlnJe7Gi0Ehu?=
 =?us-ascii?Q?1vErF6fmpR/pWz6ypp65znT5lKA2lRMTNVw8Ck+YaRlfyvgcyZlUJxnd8kJY?=
 =?us-ascii?Q?wEViE09OHSJgTpem7VBHFYDTzRtQr8K1Ys0JmT0NTaJpdbtfl/EBHbBFuPF1?=
 =?us-ascii?Q?10XTm0n8KKePuG6FpXZXnS7cOWEOnZIhvbjsFalF5YAxF9wJPco39myk7MAH?=
 =?us-ascii?Q?gPalu+UEFxn/wU4k6+vDRKChtFCW9y5eQ1M24Vt9s9I6lJXUtyUpUoxh25t2?=
 =?us-ascii?Q?DXMSkZxKwWz1KzTuuzme1mQh/jrehU6JbAkFoqx04B3SLej4flsPN1p4a3L3?=
 =?us-ascii?Q?nCDvt+4wT7RvH/H+E1aebHjxyImwD1ihN4kd9mtyQyYkKGsICrsJj8rfb0UY?=
 =?us-ascii?Q?D7uDta31qGNYhgXhpq7Z3jG00h2Df8P+YmsoCnI6QbzXTWv5CjMi3zqIWrcO?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb359013-e710-4a3d-205f-08dbe4f2923a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 09:17:49.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmiaUWSXIDcmMrhKJNuPWahtSFT/vHVKhrJ9y471Y2oj0hQL88sUcLJn1dgy0KAvsNMnH08gEqciA+qI3MUnpdeYfLFbwK+QmrOmKMqQPBK3fiZmMgI+e6AobPE2upIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7196

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
 arch/arm64/kernel/irq.c    | 2 +-
 drivers/base/arch_numa.c   | 2 +-
 include/asm-generic/numa.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 6ad5c6ef5329..e62d3cb3f74c 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -57,7 +57,7 @@ static void init_irq_stacks(void)
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
index 1a3ad6d29833..fc8a9bd6a444 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -38,6 +38,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
+int early_cpu_to_node(int cpu);
 
 #else	/* CONFIG_NUMA */
 
-- 
2.40.1


