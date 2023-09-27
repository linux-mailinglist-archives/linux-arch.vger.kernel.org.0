Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E667B00F4
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjI0Jun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjI0Jul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 05:50:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74F19A;
        Wed, 27 Sep 2023 02:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQafWxuh6IS6unVrqrQSxaxOEI33DccjcRY6ScL4uZl/AG3UL3fDzpDXAEmvoioSfB/qQi3RFzXap7TznG8zKydTyQfPMxEjYsZ89ypHSYUIibwGZniyN1Mj1C0l6gZENemLCQeAPn/8x98BRoTCM2OHOxUFWTT/idiBSdi6p5mu+SULz2l+n6ysibdpa+z9qMde/LXH4u1MPUn7nVMHTsnV5jjOYB9SKG7VCbXb27uxcCjE2M9NdBzwV4E1Qhs2Tz9S/n8NJUZgvUeo39VBHS/HH8ggs4uwwuVUs6hG2ieIjHqaJsBJfZ8yna8UN5nREVfu+FdEVGMRsfIkqJbbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thYVmvpinxBahG2GwRtw2flYX45FvPsdbyuUHWCf1NY=;
 b=japeuDGkGXbsTpGpbrPg2mXY6IhfzEeya6+rOq1mv28MTNxjWHiKMQG7ZbxaTdyCOOkLzZlGRPpR53pJlVgRozlZQxuxM30EPfzFHloqD6OYLZ/J/5lj9SLw9Qrs76Y6JjaKswqvX+2M3D03wdUwa7AZhdTqrNAGP3bXlxZlOiqQ8oUQDFeQLJbIMILYW63n2ZLnY30s8yEnts9iyfyaDNwJzDrGPAlj0oeQHeAFOX2upEoyat03xsrWTTGEJ0YaRRrUnN8INU0X519UT6/j++cGfiQpgrq6ZH8d34EXRH0AK113CfvLApy2t8HUVHKTKcpCHo3ksxlmHCyZoM9QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYVmvpinxBahG2GwRtw2flYX45FvPsdbyuUHWCf1NY=;
 b=cqgzrtFJPzrJHOALIR3oJXOkTzG93JNq3TcO0mo2CKx7hxuZ+X5JhiaEKQ4sl88HAwlipALqei5dO4FNMrGQ7uMtI19BnQ5dI/oyR1/BbHCoP+eiPwYrYPEmtU2g4HtSIsaIaU+Gu4l28Yj5uYHJROZok9SAGEdSHOnAk7bH+NthF9mv0JKc6d0AhVtAgkkaN/IJYXfL+aOybAP+lidXFtS+i6LiZ+zKxZPn08vmrHlh+b3sHsZmEDu5ssoLJusY1lwT0ehtBFftjBzFafvvG+8hwhjXL8MNpvWlpmGfwkTt04E34/I/BML0JqYokP7m4u4tlo+lCWsdda/gkOCPaQ==
Received: from BYAPR07CA0079.namprd07.prod.outlook.com (2603:10b6:a03:12b::20)
 by PH7PR08MB8474.namprd08.prod.outlook.com (2603:10b6:510:2b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 09:50:35 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b6) by BYAPR07CA0079.outlook.office365.com
 (2603:10b6:a03:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 09:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:50:35 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by
 BOW36EX1902.micron.com (137.201.85.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Wed, 27 Sep 2023 03:50:31 -0600
Received: from VENKATARAVI-LAP.micron.com (10.70.32.235) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 id 15.2.1258.12 via Frontend Transport; Wed, 27 Sep 2023 03:50:24 -0600
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
Subject: [PATCH 1/2] memory tier: Introduce sysfs for tier interleave weights.
Date:   Wed, 27 Sep 2023 15:20:01 +0530
Message-ID: <20230927095002.10245-2-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927095002.10245-1-ravis.opensrc@micron.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR08MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e408db-996d-43fa-5dcb-08dbbf3f3275
X-EXT-ByPass: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t64jye0mnkNqqvcNPbxvc+8kFdAlwRkj/+JLrexztc2cY5AikoAU+Jd7PN8O6eUGJ5lIK9097F0auXJre4BnTshvxPJPCctPkZsp8ULZsq5vhIh0IvvkzYpipV3B5WfGc4ZpCgFcjDuTqxERldAYta+yAJPy+EX7oQ3gxekBBIh1i0Q0EgysWZgxn9ZwAv51OYfR5pnQmwLeeS15iWU2Z9Ljs+tj4zzo/oBODAXNe6Jh8Xy9P2uwzzl7vPyVE7vG2PhxfO3PN6xhGn/xteC7vpUoHamOL7301AT+kplXWluS/2b7dd1gdJavrjQ4Fs3641VnB3X/SxrrHIt3Xy4VxU2AnZYBqqe2qoiNyJpmhK784NCQemfPXntitjXd5uxvoO8VkAEP+m7NJ352XDTdmYhN/NreUOVinOdhQJAoAFQGe4WqA3zUS7bgzFnmDxOmp1uSPLwwWt0I/WL0so9TXoWG/oEP5WoBRpBzWfcyERZReRKSht6NM6j7loCqD7cnLm+cUyXKHwGZPedSib4tj38K2JNqbWMxDCwhzEKGOwieBL5hWo4e59N4Y89/LSzsNn+YRLGH4qobJqvekLQ5r42tnr544zOtTj3oKrFlF23AgofT+q/k9AudZ0U4rDDYrLZmk56AaAB0vgQqPtNDtlCenhYjR2Ibuykq7A2VxmLx33p6ipBRT1UDPfu3yFjzACKYpynP/wLazX7Sy6tEuxu9ETaE8TtT2BamPKJ/qo9NNIpprU6VbBU5HSyNg/rhIlFR4YQxjz9bNnJn/xP+Lw==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(86362001)(8676002)(70206006)(4326008)(5660300002)(70586007)(36860700001)(54906003)(41300700001)(316002)(110136005)(7416002)(2906002)(47076005)(36756003)(83380400001)(478600001)(336012)(426003)(40480700001)(26005)(356005)(1076003)(7696005)(40460700003)(2616005)(7636003)(107886003)(82740400003)(6666004)(16393002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:50:35.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e408db-996d-43fa-5dcb-08dbbf3f3275
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8474
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

Allocating pages across tiers is accomplished by provisioning
interleave weights for each tier, with the distribution based on
these weight values.
By default, all tiers will have a weight of 1, which means
default standard page allocation. By default all nodes within
tier will have weight of 1.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            | 46 +++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 437441cdf78f..c62d286749d0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -19,6 +19,8 @@
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
+#define MAX_TIER_INTERLEAVE_WEIGHT 100
+
 struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 37a4f59d9585..7e06c9e0fa41 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -13,6 +13,11 @@ struct memory_tier {
 	struct list_head list;
 	/* list of all memory types part of this tier */
 	struct list_head memory_types;
+	/*
+	 * By default all tiers will have weight as 1, which means they
+	 * follow default standard allocation.
+	 */
+	unsigned short interleave_weight;
 	/*
 	 * start value of abstract distance. memory tier maps
 	 * an abstract distance  range,
@@ -145,8 +150,45 @@ static ssize_t nodelist_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(nodelist);
 
+static ssize_t interleave_weight_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct memory_tier *tier = to_memory_tier(dev);
+
+	mutex_lock(&memory_tier_lock);
+	ret = sysfs_emit(buf, "%u\n", tier->interleave_weight);
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
+static ssize_t interleave_weight_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t size)
+{
+	unsigned short value;
+	int ret;
+	struct memory_tier *tier = to_memory_tier(dev);
+
+	ret = kstrtou16(buf, 0, &value);
+
+	if (ret)
+		return ret;
+	if (value > MAX_TIER_INTERLEAVE_WEIGHT)
+		return -EINVAL;
+
+	mutex_lock(&memory_tier_lock);
+	tier->interleave_weight = value;
+	mutex_unlock(&memory_tier_lock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(interleave_weight);
+
 static struct attribute *memtier_dev_attrs[] = {
 	&dev_attr_nodelist.attr,
+	&dev_attr_interleave_weight.attr,
 	NULL
 };
 
@@ -489,8 +531,10 @@ static struct memory_tier *set_node_memory_tier(int node)
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
 	memtier = find_create_memory_tier(memtype);
-	if (!IS_ERR(memtier))
+	if (!IS_ERR(memtier)) {
 		rcu_assign_pointer(pgdat->memtier, memtier);
+		memtier->interleave_weight = 1;
+	}
 	return memtier;
 }
 
-- 
2.39.3

