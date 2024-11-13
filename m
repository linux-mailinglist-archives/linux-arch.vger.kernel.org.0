Return-Path: <linux-arch+bounces-9056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB879C6F20
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A1B24190
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52B3205158;
	Wed, 13 Nov 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3k1eBGd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE8204F69;
	Wed, 13 Nov 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499460; cv=fail; b=gtt5slVcOYZEYl2j/F46PcGBiadJHj4zzoBUP54Z9ugCKdNH+l8FLmqBjEW+76FD2UQI96mncJ9gboIM0rTf5PFYEnr2zw3vz3GJLNcZBjbM9by2MDRalZurhGV+V+hFU0XlCLuKT65n5O1Y47grUCOxdIcs2WD1OKDFRXF8ENE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499460; c=relaxed/simple;
	bh=v/7+9ReQG563VkT5U5D7Lg1pqz6bq7o5ChfGVzJcySA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7r04WFzNrl4/9Xqubo97SYwP8U5Lv+chdPntOkH/NhmC1Ec0ldRHi5+bTU/N5df6TDDt98S4yBL3FSThZzqkN8gJp7Bc97Zg9dJewZIO3hE95tIq5bVkLzaE2wt9PiEWG2Xi2hUuugZiNSat/6mEL7wzepri7L4UO8XPEreBJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3k1eBGd; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9s9mgBOdUYeAU5z/7GVTjhaqOtVBP6AoLKu5wF5YydzudHRdwlnJkYw19QwCrKmzL4niHImGwED4zdBp/7gVV6O7IDTd0uFUlLwfRQm4sCPyprJzDAaAqAUGcECdowGwKOBPvp7oQC6Osecg3WSf9Ut71XZcC4cJyzIOc7GR3xIdAQIqXZ7boXi3ybONip43LiS0bskOvHAF1pk8mfv6dfLnEPSgTchj8B0df34QWN/0RlP5lFTIUAuIp3GxN0ibdE8wZ4Uu3W4yhQb4qBIosrmKqq+IjkSZv+kWO88AVqOmlF6tx1lLRYM45RIZp+lis5bbmvZOeH2NHHgPe0ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4ec+lvqzTQuyxe8SIBVwK9Q+3/WHJv8QXeMdd1kIBo=;
 b=rWTTsfBAkcz3cUl5X/j1HPITwJKWR1Gm4qDpJbKHjfPuKQZ/X4c/9dEC2za/rziRYUz/v7Z6pPjtzPjkAVXPAIQUkqU2374vbz3D8rgBcpU+vdTSSxDAn6PYZHbwayVr/SdhpvIc1oyxgU/PTDgnwecRUqnk7YfhHQoJ/obuxViQe836zwfXuEfRX+R40C312Wl0coKtWNT/C7OSJDOKfqt0OaQFY5IDxNgYu+Rw/RI5auc52g8nPIRHYUHXW+mVRij6EGKaZ8fyuVAQ45cdJBB3GtN1JTZhn5Hq2NfPVllEZMTy10lFDY14b/vwVUAbJ6dZx+YPe7uaVFphqruowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4ec+lvqzTQuyxe8SIBVwK9Q+3/WHJv8QXeMdd1kIBo=;
 b=H3k1eBGddOwtsMu028ys26gJ/7XXjNbMRp1OzOih/DiS06KiLHxOg3ZrHkEmj48ZqUe+chac9uPxppkao+1ngcL1GEtbwzPfbgCPyHwUfO3vgXBRj2+uEOtWPDZfAz8bi4gHQOwWjoWt0ZoTPUIsxLn28N8Txj+MJ4oacN7Aqn0=
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 12:04:14 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::f1) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:14 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:09 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 06/10] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Wed, 13 Nov 2024 12:03:23 +0000
Message-ID: <20241113120327.5239-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: a60f299a-1df6-4ab1-de68-08dd03db4ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bo6ac7kdip2r9UG1QgLPoytcD93g+nig/xVdKzNVute4F/9t3+uu4iDm+jHU?=
 =?us-ascii?Q?G4nIoUDc9zEAcye/2xbAztLxvShlrCYSoFzRKhThhLSNQAxj6AZoDCfsF6sv?=
 =?us-ascii?Q?aZ9QZl3wWTLVZFIU2KQNPjyf05lGwVe3Lzqjdo6od8f5eIzwlHZCaZk77Y2O?=
 =?us-ascii?Q?ZJXGtivaGbaHze3vuKPFz3eFyrt1K/OXP7EFD0/JKo1pmfS8+Aqr5TffjWuH?=
 =?us-ascii?Q?72DvYejjbaB7+hC8KlL+x/IkHAHCvenwOaUjAS3LFu1SkauZJqcslt+tI8Wi?=
 =?us-ascii?Q?hbAapE9VV5587xzilykf7mwjn7Z/mZEQp2iGM9EJUZIIHZADzOq2IQCinDKB?=
 =?us-ascii?Q?GGbiM+a/zwdJLpcmHfDYPSo2DbN0pGlqRbLvTNeJtwrLB45QEGiGexH9tae9?=
 =?us-ascii?Q?d5Aw0iKGbi6CNF+az3TEudnRrlACzwSQr35ZrcP0empE0sUDosxDweiNellN?=
 =?us-ascii?Q?jSvIMfR/MJEuBjJWPihgWkorLAvNxNotyPUttQd8XUP/Mh4VTc+WNwJ3kztn?=
 =?us-ascii?Q?nz0xtcq3qKP6x1Z1uk/+QFpAzZmh84Msr0zgJiGZSWoy23vv3JC4kjzfGoxO?=
 =?us-ascii?Q?AKyfXqC0NwrrNshj8eMkvOCW2lvLjQDDUk8KtqQ2iQH85Lh2K8zV+2YP9ebw?=
 =?us-ascii?Q?k7/+RUM7o1Zsa6+6MQ1Pq70fk1gsUHc4yeixLNfKQTIiKz/OhN7DEgMAWxUL?=
 =?us-ascii?Q?5e9FljNP9MdpWFTlLS1I8LnUznxinj7BcUXbZE/2AkCAXycxBEUe9tQ9cJFd?=
 =?us-ascii?Q?aR+OoKbI9hIZZq6SMS4UnQ6gTgmmNA/QvGSubyib8tLC6rLyVf8qkidGgBF0?=
 =?us-ascii?Q?m1c28DPOCPhm3SPC1r35VmSE+JbsqGGIbZ3ApIr8SRfGRqXztTaSpBgMLMGy?=
 =?us-ascii?Q?+BzcCG9LoMAEIDOslQrPATe9JoN3xFfiEGkVljLaC54x4ly8nHYecfv6u3M7?=
 =?us-ascii?Q?3raFzERM3cUMoqo/+95P2EO2nt61RRB/HRS2MhU3epsOsWCiBa2b6x7lWvqQ?=
 =?us-ascii?Q?Wdyb0F9rsPRC7LUhtshaGfrTn7MIn79OxMajeYwNrXc4LRpRi1eWZRPrIv61?=
 =?us-ascii?Q?I3bjKDsBvHbhlwq0UUmv3Lb6AqnWhUXsWi2tRjTGx3mWt2KA2TENyEbIgrJ+?=
 =?us-ascii?Q?Nn3h1TaGV6NVwc4clMi9tE0vYOlVRVCevRsvtqAnvMB+TWTcgzUFFNjOhire?=
 =?us-ascii?Q?svWYyrISRtYOCPx0HDhe97fbLparzG6ffF/jnB1cw7G1S2Lsj+DScsw/66F6?=
 =?us-ascii?Q?mt851E9+E3tkMqio3tFuyBYlSMS6eNgCc+7bRUe+um7pnq+6GK6ga9IvC529?=
 =?us-ascii?Q?gZUl9CGvPMpsqHb6O/Efj8myrmCU1PzqcPmuvMzdS6TkuC94SExXKigG6Ufn?=
 =?us-ascii?Q?C7H2RQ19GaDPJEEI8vyM/iE3j8qTumHPtUnNuSRecpI1sSdH7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:14.3132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60f299a-1df6-4ab1-de68-08dd03db4ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  13 +--
 drivers/iommu/amd/init.c            |  30 ++++++-
 drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
 4 files changed, 106 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 38509e1019e9..f9260bb8fc85 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -183,3 +183,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 #endif
+
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ea7922b06325..0bbda60d3cdc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -409,8 +409,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
-#define DTE_GLX_SHIFT	(56)
-#define DTE_GLX_MASK	(3)
+#define DTE_GLX		GENMASK_ULL(57, 56)
 #define DTE_FLAG_IR	BIT_ULL(61)
 #define DTE_FLAG_IW	BIT_ULL(62)
 
@@ -418,13 +417,9 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DEV_DOMID_MASK	0xffffULL
 
-#define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
-#define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
-
-#define DTE_GCR3_SHIFT_A	58
-#define DTE_GCR3_SHIFT_B	16
-#define DTE_GCR3_SHIFT_C	43
+#define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
+#define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
+#define DTE_GCR3_51_31	GENMASK_ULL(63, 43)
 
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 015c9b045685..1e4b8040c374 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1089,11 +1089,9 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 			}
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
-				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-				tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+				tmp = (DTE_GCR3_30_15 | DTE_GCR3_51_31);
 				pci_seg->old_dev_tbl_cpy[devid].data[1] &= ~tmp;
-				tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
-				tmp |= DTE_FLAG_GV;
+				tmp = (DTE_GCR3_14_12 | DTE_FLAG_GV);
 				pci_seg->old_dev_tbl_cpy[devid].data[0] &= ~tmp;
 			}
 		}
@@ -1144,6 +1142,30 @@ static bool copy_device_table(void)
 	return true;
 }
 
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
+{
+	struct ivhd_dte_flags *e;
+	unsigned int best_len = UINT_MAX;
+	struct dev_table_entry *dte = NULL;
+
+	for_each_ivhd_dte_flags(e) {
+		/*
+		 * Need to go through the whole list to find the smallest range,
+		 * which contains the devid.
+		 */
+		if ((e->segid == segid) &&
+		    (e->devid_first <= devid) && (devid <= e->devid_last)) {
+			unsigned int len = e->devid_last - e->devid_first;
+
+			if (len < best_len) {
+				dte = &(e->dte);
+				best_len = len;
+			}
+		}
+	}
+	return dte;
+}
+
 static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 {
 	struct ivhd_dte_flags *e;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d6c814bd1443..f7e36cbb6c4d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1937,90 +1937,109 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
+			   struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
+
+/*
+ * Note:
+ * The old value for GCR3 table and GPT have been cleared from caller.
+ */
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	target->data[0] |= DTE_FLAG_GV |
+			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+
+	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
+
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+	else
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u32 old_domid;
+	struct dev_table_entry *initial_dte;
+	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	make_clear_dte(dev_data, dte, &new);
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
-	 * When SNP is enabled, Only set TV bit when IOMMU
-	 * page translation is in use.
+	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
+	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
+	 * do_iommu_domain_alloc().
 	 */
-	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
-
-	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+	WARN_ON(amd_iommu_snp_en && (domid == 0));
+	new.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+		new.data[0] |= DTE_FLAG_HAD;
 
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
-
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new.data128[0] |= initial_dte->data128[0];
+		new.data128[1] |= initial_dte->data128[1];
 	}
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1


