Return-Path: <linux-arch+bounces-9131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F349D091A
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C88C1F21BE3
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB03613D8AC;
	Mon, 18 Nov 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c6XrhbCq"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F560DDC1;
	Mon, 18 Nov 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909160; cv=fail; b=bsbM6/7zNgkn80HUTeRz/C+c8EJ2gVZmFms9WUUwT+3xzLEUANJmef27VopJmjjNL/zDQKtA0iRQIMVYXjxB+RUVoWpj/hNBuzj3dHndjXu9LBbspG4EtQkxz2UXCTlCEOWY18WTSKawVl1lBC8cIc73+L0PBNnAqJSU+YQhdTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909160; c=relaxed/simple;
	bh=UQiduIaBdy0zfWJXfd4mmCFWRxiPJUoWULx6Y7SxVus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDz4tN7nTWkn+KqGaoRF3R4ds3lHL6cWxYe8MSfnGuU3AkcZNombWbhgl0rY3sCLTg7v3OeDCXvZkIu8z0jtZjVqoJ8A3i1bDr1SiWs7vyTZnmI1xtD7Db/jN2JWKGgkPLApdt43fi7Dnyt2+cerOtt1TfK/ZnNQhzT4mM0Vnyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c6XrhbCq; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdAR6LYE3V3N1BD1HUFrXRyqvAv3DiNt3X3EU3TJxRuR4zP6Sv/P+QuAdnxdywwC764VoHc9z6/fPjs1CNeVabGTKgIfR7anYMsV6yBpgaIc4LoAeM57YXb2f8g8bLvv7tIrseU7Lux+uqGotVzaSSO2cLO+Dx2Vs1agjO/TzX2iestLPgG19Ez3o2q0558ewL34JVobJLF0Mpo+1dsUrY9v/f3g1R7XuJGiMgQZIaT8xpJvui0upPUnWx3enOZ+Enhar6RQiXJ7Nr2zNRCjB4F9PD4tPjcjR0jTEfWW/N9SLAjnjpZ6+OyFXjUkwWGCo0T1W63K7RvaWqM/Ewhx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6ry/JgdNcRhBMex1qWlDAkfgMLi6VK/4TNymdzi0uw=;
 b=afeTqFdY3Kt2GCa8vJcpMdhxOMHtH2Is9Tezs3eyHncYIof3WJw3459WDyl1KrroxJ9moQQI0tRuN8ijd5Cqdj7oFhlzqvrteyVE2hrZwZO5JRcy6IV+DWOr6QNq3rMvZ4GJmUhHvBT5bBDwXMNqe/WkQVy5aZNrCh+MhaZ1b+06QaF5dddTBOxyL761r0qA7tSQY33tdWiUMcOSPInqs0TNEBXUKyPOqEHe8bcBOZTxALkR3Z0SbFhphDMO3fE7uFTkiAfH2uOQUWVzkwvUyEumaofGtrIrHf0J8TTM4aOrlDGx/h0/h6Qw07x4Fza0OHQDsVepbCGr+veOxfAKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6ry/JgdNcRhBMex1qWlDAkfgMLi6VK/4TNymdzi0uw=;
 b=c6XrhbCqE1t1TZnH5xWJSIeOrmkuUwbQEq0Tx0s1uu3MGGUMrSn0P0dsuf/Pl6vLHm7DkV2gyQIKZtc6Vl7u3Dd8+jTKEvKMkdNdsJI+0Ua5YCkcR2Ffhjd0KDOP7rbfZkoZgGtmPQFiwqbaD2jSmqh0ktDMkCY3kkAeAE1aoig=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 05:52:32 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::d1) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend Transport; Mon,
 18 Nov 2024 05:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Mon, 18 Nov 2024 05:52:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:18 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Mon, 18 Nov 2024 05:49:33 +0000
Message-ID: <20241118054937.5203-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
References: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 298fe477-4523-4b0c-f9d8-08dd079531d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+86q4svLkqX0sXJWpFyFzfmNGgDB32A5NJb5ARjC7QLKdb5ijS/2sneCG2Yo?=
 =?us-ascii?Q?Njgq3CljBxK9s1o8xLg5x94hd2OdriDzj79ZJoXUKkI2iBGu3zNeQSm92JB7?=
 =?us-ascii?Q?B9Vo2flNRtXxs72DWq30rpxpjTOoPVxYat7pCvk1dNfJRhJFfLzsOYt20Ovg?=
 =?us-ascii?Q?83it/tLUx/YKrNtvkDCAdGt/Rvq2LiPUyJ6voeIEGko1NDWzR59M7P+tk6y1?=
 =?us-ascii?Q?9oR6nCdy6Bz9fNmDnnIs/9HP3DKGjpcR5DE2WhwCI5PDFgKGKQvwk/CaVeH8?=
 =?us-ascii?Q?7D5HTmJaIKQI5CbH3WlCf6oJXopIkiaU9nJymJmY+MfqNeD0ctmKjLzFinyS?=
 =?us-ascii?Q?8Ls6OqKUG8lxytm6UES3iUUNMyTetfB7w/TauzGM1D2kv/nEJw/bD3L31FWV?=
 =?us-ascii?Q?0ujAR+CmpR9sH1Itx6+nqgTYkx5Qy3AsbsQ9O0k0JqrJNjLnS6WxwoOU7mo1?=
 =?us-ascii?Q?KOq4g8vjJrZsm19Y51BaHAjEuEv9A0SLsoFXdNIrrsCfKBqmYHFA2a3of+F4?=
 =?us-ascii?Q?FTLhOu5JXDWguxMArgRPAi6bGFwrlm9TSlg07HqwirDdPl1ETTJPrjMw3Cz0?=
 =?us-ascii?Q?hjm2/ASSAlq+I7ZfwdTfYff5IFQ3LUHfvrY7MaC7+N6suoQ037L4terhXvg4?=
 =?us-ascii?Q?8UbM8Cs7XVn3mqpLG/Cma5AurWBfhkbBys4/B5i8oiWLTmtV+0wrMBynEQkA?=
 =?us-ascii?Q?LrIqr7GyCiEbjRwobTDwIe9uU1r8XujXhq9OVQUIMg8pIWSwrWhjJudLEM4/?=
 =?us-ascii?Q?SQLrONxEEmIorP3yqTi0hjI8fltZU18k9JsxUbC1d3QB1r7oEhbboOHTuGmg?=
 =?us-ascii?Q?W19C1Qi6A7Mdctzrbr1xNd4KaOIf0M4lBUCodrM0wr/n0zPjoiRsNRL2koSB?=
 =?us-ascii?Q?F2WPfW1LRbBkX72+96yJCW4+SkUG6o0AAdQnQ6zszPzvCru1Qs5ZZEOCDq3s?=
 =?us-ascii?Q?bubM966v2GFlWOsew0LlVHsvEbYl6Rljfqc6LqG2NeAcslIlhycY2iTiibYF?=
 =?us-ascii?Q?qWOTOrn/nBCxxiXaSLZvIXzRBeGouBS/IC+RE5Vv7nSFep8PILFPdNziLea7?=
 =?us-ascii?Q?6eu+G6W0XPXJOvy2iUxwl6KqsOWNTzVdn1Sz8lx6b9tBXJdElkxREKKnxu8u?=
 =?us-ascii?Q?pKvPu+hYDGthObcePxcx8SbtsFRxEeWQl7PKOSi+7DqkqJ/Z4bkTomeTHFET?=
 =?us-ascii?Q?GS8xNVk3qPS6rEZBU1Bmsgb0vMJQf2iWQqY+U92G7qA3FCiSoDC9cUmG0Mfc?=
 =?us-ascii?Q?KNC9p8yOOjoqHt/v0NWFHuT34mtO2QeTNUvMmy10FM7TDtqsuE2IgYOupZXA?=
 =?us-ascii?Q?d6kX6BAKklFMY8TBA0v96w2UJW/ZjETxtlFSlw+DS3DxPxJGXp0S41oNB747?=
 =?us-ascii?Q?x2mm2n+CK16CuhwNnX0bb6a4x0IGyx+75DW3by/7MuUcymgqhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:52:32.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298fe477-4523-4b0c-f9d8-08dd079531d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 1145a9901430..fd69153e64e6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1944,90 +1944,109 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
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


