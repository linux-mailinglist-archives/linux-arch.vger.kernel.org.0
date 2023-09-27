Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46C7B00F8
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjI0JvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjI0Ju5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 05:50:57 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7F1A8;
        Wed, 27 Sep 2023 02:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOk40acwmQlBS4B3w+mZ3jshNTx3rIi4uKMR3oR2U0QR4BmkY5Ko4cyYld4i0D/f+RE+oLpc+E8lHc60e8OVz5VL7X94/pvr+Tt+TlD8t5pWZu5cVTc91dz/WrHcvcFBXEfObEo3DVbTZMVsANXWKmDCGwL6Y06/Ym5omSZ3xfO0Tzlw3jfKmwvgTdxmcxwNYX0qhlW86JcksWlVaqeIs17fjsMQ3gk3VN0q0K1TBeVWLMIK6Y5rHwnyA0M/fceNEcG69GEvI7yDiAqxvctwzRi5not5SKeILg6TA21AFNd91LsxErCWlI5v+6eJnUxYfxQ9l6ROjVDb9xiGo9YiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enrEaGioXb5xkoJ4V8LqcUMd/6pdaKT40/pyFjft6/M=;
 b=Mt8ImxQiJjSenpXT/430vSnUzaQz0Jj54v9DQe21Y2r1UU8e5HXx+QZxVhInanxRn8jgeF99hMFLab4U50sh/h3Y5ZeKuMX1rRsn7lI9F54dKMKUJtCnuz4HYzrhG35guKhiE0mZ/LOO8jyMq9Qv+m3yZmYDjkEY9ZeppMfS3ennDoeL1p3Wf+Lu1ai1gAr6YgYO17wk7S2G3c9oDviqWHSdiVXuWo63OlVMhmoUVj2eSes769elcXB2D50D0VkEhw5AAnz607Ljzc1uGBSF7zwDIvXKje1PknoLSf42OTUjYNPs9mfB+5SqNZ5VKr5yCjGtDHbnNAlkyohAZplNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enrEaGioXb5xkoJ4V8LqcUMd/6pdaKT40/pyFjft6/M=;
 b=NuOmzH2ATc0+707LEhg0VkRZ9uxzpr/3SSSdWUvTqzrcUqkB5vqAn+iCX62A+7IhJJHoLGssz1h9Oa9A1pE/ESF/C7K/qAO1ndnL11OHwxm6oEFGPb9r2fVcI9An8meQLXJ/EnuYtiRyZAmrMeMjVYATdRicvvMW3l6ia5qkPECtKrq89kLU2sSyrphQBRFgG1zT1eW6IbPXYS6nS6A97uunfBMbNB8jbL6j42s9CSJBpkp47fy5duzWlMMf3UyGM2RKbRIxR/LdOZc9WFsQ4cvU5+ktbqF32Uo1MDzWJWCVUyo3VvJtGgZUkuXIDGrlHm272bldzyy8b6P4sxV5kA==
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by CO1PR08MB6481.namprd08.prod.outlook.com (2603:10b6:303:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 27 Sep
 2023 09:50:40 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::a) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Wed, 27 Sep 2023 09:50:40 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by
 BOW17EX1902.micron.com (137.201.21.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Wed, 27 Sep 2023 03:50:38 -0600
Received: from VENKATARAVI-LAP.micron.com (10.70.32.235) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 id 15.2.1258.12 via Frontend Transport; Wed, 27 Sep 2023 03:50:31 -0600
From:   Ravi Jonnalagadda <ravis.opensrc@micron.com>
To:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <ying.huang@intel.com>, <jgroves@micron.com>,
        <ravis.opensrc@micron.com>, <sthanneeru@micron.com>,
        <emirakhur@micron.com>, <vtanna@micron.com>
Subject: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory nodes
Date:   Wed, 27 Sep 2023 15:20:02 +0530
Message-ID: <20230927095002.10245-3-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927095002.10245-1-ravis.opensrc@micron.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CO1PR08MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0a19cb-0c50-4dd0-84cd-08dbbf3f3563
X-EXT-ByPass: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3EAUmSuPCrI4h/VmlwkiZVh99adJIQFMQurdJL6HO3u/PXRQcGLOUDL8vH88EoTzjMYpRxS9OoB924iohf/GQdFX4n3gWTHrLRCRRZ0VpwseXBgicyyZmwap5RbhcxFFBvjwWqHUiSII7eOQHDVwAVtQS44asjca/4D2wIK6Hob2vfrP/ZPKx+Sn2uKp6/l9eARALdr4eIQhAFUUmjdJXa+fzcCXDxJJNL3DrvPS7olzhmhDV7pIvh+d48NIqxF7wtZU7ywYSlYAwj4r9hIc3OMuMIU0IoQHv3yEjSInvD9YgocR1HcDR6p3IA0XNXQZSyuz2BkJBb5kVggvPbyKPk0ftNu9v6r7kS5oGqTIQMbk/gCMgaRffQODDoxgApCMGb5uR/AkFnAF0IvJ+CBfz/Xvl+23nHweYhvztSy9h84MzNOt6AkjNmxf9xf9cxD/RyJvEjQFQQ/moEo9EybTqvHOGdLGMjlA+LbnexRKG+TCa8tdWesKI/4uwXhBxnx+o5T3pjVdDlqKqf8lmhsWCn9s4OMGuxrQDsv4awya/9ousF/qnPKezuPV6HjyVRJm2deBbmn388KKBSYx3/VWR3L0mavdoWIjVO5i3lYJ2rDx7j7fWk3rCCw4q6nHkG+hzH9O56vyVF2PvyvXW+ujo0n3zG8hI0OHEyMhq352lhs44/uwhh2BkkONe7bdRLyqH2xOTU9H4JRm5rCnJl9WKl5bNjjMzDtLNO5rAbOyFPYjgN2qCGL04gw2wn6Lf5z
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(356005)(6666004)(478600001)(83380400001)(7696005)(8676002)(70586007)(70206006)(54906003)(8936002)(110136005)(316002)(36756003)(4326008)(5660300002)(107886003)(40460700003)(1076003)(2616005)(26005)(36860700001)(40480700001)(82740400003)(426003)(41300700001)(86362001)(7416002)(336012)(2906002)(47076005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:50:40.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0a19cb-0c50-4dd0-84cd-08dbbf3f3563
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Srinivasulu Thanneeru <sthanneeru@micron.com>

Existing interleave policy spreads out pages evenly across a set of
specified nodes, i.e. 1:1 interleave. Upcoming tiered memory systems
have CPU-less memory nodes with different peak bandwidth and
latency-bandwidth characteristics. In such systems, we will want to
use the additional bandwidth provided by lowtier memory for
bandwidth-intensive applications. However, the default 1:1 interleave
can lead to suboptimal bandwidth distribution.

Introduce an interleave policy for multi-tiers that is based on
interleave weights, where pages are assigned from nodes of the tier
based on the tier weight.

For instance, 50:30:20 are the weights of tiers 0, 1, and 3, which
leads to a 50%/30%/20% traffic breakdown across the three tiers.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 include/linux/memory-tiers.h |  25 +++++++-
 include/linux/sched.h        |   2 +
 mm/memory-tiers.c            |  31 ++--------
 mm/mempolicy.c               | 107 +++++++++++++++++++++++++++++++++--
 4 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c62d286749d0..74be39cb56c4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MEMORY_TIERS_H
 #define _LINUX_MEMORY_TIERS_H
 
+#include <linux/device.h>
 #include <linux/types.h>
 #include <linux/nodemask.h>
 #include <linux/kref.h>
@@ -21,7 +22,27 @@
 
 #define MAX_TIER_INTERLEAVE_WEIGHT 100
 
-struct memory_tier;
+struct memory_tier {
+	/* hierarchy of memory tiers */
+	struct list_head list;
+	/* list of all memory types part of this tier */
+	struct list_head memory_types;
+	/*
+	 * By default all tiers will have weight as 1, which means they
+	 * follow default standard allocation.
+	 */
+	unsigned short interleave_weight;
+	/*
+	 * start value of abstract distance. memory tier maps
+	 * an abstract distance  range,
+	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
+	 */
+	int adistance_start;
+	struct device dev;
+	/* All the nodes that are part of all the lower memory tiers. */
+	nodemask_t lower_tier_mask;
+};
+
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
 	struct list_head tier_sibiling;
@@ -38,6 +59,8 @@ struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
+struct memory_tier *node_get_memory_tier(int node);
+nodemask_t get_memtier_nodemask(struct memory_tier *memtier);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..07ea837c3afb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1252,7 +1252,9 @@ struct task_struct {
 	/* Protected by alloc_lock: */
 	struct mempolicy		*mempolicy;
 	short				il_prev;
+	unsigned short			il_count;
 	short				pref_node_fork;
+	unsigned int			current_node;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	int				numa_scan_seq;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7e06c9e0fa41..5e2ddc9f994a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -8,27 +8,6 @@
 
 #include "internal.h"
 
-struct memory_tier {
-	/* hierarchy of memory tiers */
-	struct list_head list;
-	/* list of all memory types part of this tier */
-	struct list_head memory_types;
-	/*
-	 * By default all tiers will have weight as 1, which means they
-	 * follow default standard allocation.
-	 */
-	unsigned short interleave_weight;
-	/*
-	 * start value of abstract distance. memory tier maps
-	 * an abstract distance  range,
-	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
-	 */
-	int adistance_start;
-	struct device dev;
-	/* All the nodes that are part of all the lower memory tiers. */
-	nodemask_t lower_tier_mask;
-};
-
 struct demotion_nodes {
 	nodemask_t preferred;
 };
@@ -115,7 +94,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
 	return container_of(device, struct memory_tier, dev);
 }
 
-static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
+nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
 {
 	nodemask_t nodes = NODE_MASK_NONE;
 	struct memory_dev_type *memtype;
@@ -264,7 +243,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	return memtier;
 }
 
-static struct memory_tier *__node_get_memory_tier(int node)
+struct memory_tier *node_get_memory_tier(int node)
 {
 	pg_data_t *pgdat;
 
@@ -380,7 +359,7 @@ static void disable_all_demotion_targets(void)
 		 * We are holding memory_tier_lock, it is safe
 		 * to access pgda->memtier.
 		 */
-		memtier = __node_get_memory_tier(node);
+		memtier = node_get_memory_tier(node);
 		if (memtier)
 			memtier->lower_tier_mask = NODE_MASK_NONE;
 	}
@@ -417,7 +396,7 @@ static void establish_demotion_targets(void)
 		best_distance = -1;
 		nd = &node_demotion[node];
 
-		memtier = __node_get_memory_tier(node);
+		memtier = node_get_memory_tier(node);
 		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
 			continue;
 		/*
@@ -562,7 +541,7 @@ static bool clear_node_memory_tier(int node)
 	 * This also enables us to free the destroyed memory tier
 	 * with kfree instead of kfree_rcu
 	 */
-	memtier = __node_get_memory_tier(node);
+	memtier = node_get_memory_tier(node);
 	if (memtier) {
 		struct memory_dev_type *memtype;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..4f80c6ee1176 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -100,6 +100,8 @@
 #include <linux/ctype.h>
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
+#include <linux/memory-tiers.h>
+#include <linux/nodemask.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
 
@@ -882,8 +884,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && new->mode == MPOL_INTERLEAVE) {
 		current->il_prev = MAX_NUMNODES-1;
+		current->il_count = 0;
+		current->current_node = MAX_NUMNODES;
+	}
 	task_unlock(current);
 	mpol_put(old);
 	ret = 0;
@@ -1899,13 +1904,76 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	return nd;
 }
 
+/* Return interleave weight of node from tier's weight */
+static unsigned short node_interleave_weight(int nid, nodemask_t pol_nodemask)
+{
+	struct memory_tier *memtier;
+	nodemask_t tier_nodes, tier_and_pol;
+	unsigned short avrg_weight = 0;
+	int node, nnodes, reminder;
+
+	memtier = node_get_memory_tier(nid);
+
+	if (!memtier)
+		return 0;
+
+	tier_nodes = get_memtier_nodemask(memtier);
+	nodes_and(tier_and_pol, tier_nodes, pol_nodemask);
+	nnodes = nodes_weight(tier_and_pol);
+	if (!nnodes)
+		return 0;
+
+	avrg_weight = memtier->interleave_weight / nnodes;
+	/* Set minimum weight of node as 1 so that at least one page
+	 * is allocated.
+	 */
+	if (!avrg_weight)
+		return 1;
+
+	reminder = memtier->interleave_weight % nnodes;
+	if (reminder) {
+		for_each_node_mask(node, tier_and_pol) {
+			/* Increment target node's weight by 1, if it falls
+			 * within remaining weightage 'reminder'.
+			 */
+			if (node == nid) {
+				if (reminder > 0)
+					avrg_weight = avrg_weight + 1;
+				break;
+			}
+			reminder--;
+		}
+	}
+	return avrg_weight;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
 	unsigned next;
 	struct task_struct *me = current;
+	unsigned short node_weight = 0;
 
-	next = next_node_in(me->il_prev, policy->nodes);
+	/* select current node or next node from nodelist based on
+	 * available tier interleave weight.
+	 */
+	if (me->current_node == MAX_NUMNODES)
+		next = next_node_in(me->il_prev, policy->nodes);
+	else
+		next = me->current_node;
+	node_weight = node_interleave_weight(next, policy->nodes);
+	if (!node_weight)
+		goto set_il_prev;
+	if (me->il_count < node_weight) {
+		me->il_count++;
+		me->current_node = next;
+		if (me->il_count == node_weight) {
+			me->current_node = MAX_NUMNODES;
+			me->il_count = 0;
+		}
+	}
+
+set_il_prev:
 	if (next < MAX_NUMNODES)
 		me->il_prev = next;
 	return next;
@@ -1966,9 +2034,10 @@ unsigned int mempolicy_slab_node(void)
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
 	nodemask_t nodemask = pol->nodes;
-	unsigned int target, nnodes;
-	int i;
-	int nid;
+	unsigned int target, nnodes, vnnodes = 0;
+	unsigned short node_weight = 0;
+	int nid, vtarget, i;
+
 	/*
 	 * The barrier will stabilize the nodemask in a register or on
 	 * the stack so that it will stop changing under the code.
@@ -1981,7 +2050,33 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
-	target = (unsigned int)n % nnodes;
+
+	/*
+	 * Calculate the virtual target for @n in a nodelist that is scaled
+	 * with interleave weights....
+	 */
+	for_each_node_mask(nid, nodemask) {
+		node_weight = node_interleave_weight(nid, nodemask);
+		if (!node_weight)
+			continue;
+		vnnodes += node_weight;
+	}
+	if (!vnnodes)
+		return numa_node_id();
+	vtarget = (int)((unsigned int)n % vnnodes);
+
+	/* ...then map it back to the physical nodelist */
+	target = 0;
+	for_each_node_mask(nid, nodemask) {
+		node_weight = node_interleave_weight(nid, nodemask);
+		if (!node_weight)
+			continue;
+		vtarget -= node_weight;
+		if (vtarget < 0)
+			break;
+		target++;
+	}
+
 	nid = first_node(nodemask);
 	for (i = 0; i < target; i++)
 		nid = next_node(nid, nodemask);
-- 
2.39.3

