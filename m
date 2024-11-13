Return-Path: <linux-arch+bounces-9059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8DD9C6EB2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5D1F269B9
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3D206E76;
	Wed, 13 Nov 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BosxLMRx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA104206965;
	Wed, 13 Nov 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499473; cv=fail; b=bZ+hk+cOOAuu9k8f/R/YN3xF04kI6GGD4kbfDuGcsqMxDdWbSl4rtWASIyI+TSDRCFxBpAgHiM1hUUpBRoqgCRx12j2xvhnC/cTjdnzBAfZGEy4asS0wMJeTnKv2Pja6lFXTFsLsbahQqD95t34Oo78A55GGH/9cmCT9SqdyP1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499473; c=relaxed/simple;
	bh=QGhAAbRBrrgQYJwBI5cSJDSY53BsU4f4It0EpKwek2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJpr1ifOkWZZP36rSw9NPjYGp9Q0bS0tESJQ5ENmBsqDl9Yzo6cmMfJpJVUNvyg1joDLEOJCnoasYVwiTPPlXc66kuz+pXVRQVGheKhROJ0+1aLUuuAIWFd2C4qxXvoMvX1XewkPL7lkEbdfSJo0NNUHknXYzKwFeaE+my8N/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BosxLMRx; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcgxtrYyyUNZIBf4/rKhF8gZU4UE8Ec2aS3zRkY+YjcykKj/uIS7Ym+xoJSm6LG+viStYGNdpOCD0REElavLeBmHOGWtAn1tW/LkA/hLhw0o2PFiX2kHReBdgeFHh5FpJQ6M/75j4YoKgCveTQtUjxicsZFfCo0cyMP3Qb7Vxw8OI8t0OkXTPsAn7BZw0bc/7V21+Hsg5a1LFE27jBVvUWLHLoPOluD1nToY83Ltb4dd7BrXABSSiEXolihdgNDNtZfekBJj5xyDUznzChL8SPulC5WtUHgXDBXYOYYTNP7LQHsmh117O92x2FipxA+3gt2F0i5RqzL0p6hYOQeWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2paVVJDfI3hker/6JTwafhAh5VtEpo6HP7fNFPL/NQU=;
 b=qNrq8T8HFmhD0/mMO+vr/RLOf8t+6mSYh/ufaw8rlORAQ7V+ak4CSiba92rWFVx5mvsr6j6IcEFw/wcwVpAGtNS6IQThLiZ7BQudOtngYPMP4Tc3TeHHhjDJyUMqiFNsknMKK8dYb7gGBt55PSR/CQGHQsTslS4/UJMugjCwxNMMyQe1B4p3AefETb/svjlEnzSu/ZicxxidLWOF6xUEQ7/RFUZ8iBtloz8j/WxqhX31YPefBYeicEUmtEjn0CcuegEWkeCxk42BNI9UJzBsjRse0XO6JEUvhc62z0IDAKwW04Aj3Ujh/UXB7MDURoexLGSAiZ1P+CfZEEDoPa04uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2paVVJDfI3hker/6JTwafhAh5VtEpo6HP7fNFPL/NQU=;
 b=BosxLMRxPf7Zd8pyhyJrJoPC8M3SuPRcDx15Mc9t3j56PsuiKdnU/x82l/sT69qR7/qVjbetoiP8DWE8fnnUMaq4CLmtJhHi2BNJDGy48Hbcxw/5gixNaJtH9qRIkYPI6Vmg8Of7rTKOSj9VDYCyA1dH4y06mSMgrwdSI48v76M=
Received: from BN0PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:143::10)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:04:27 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::df) by BN0PR10CA0012.outlook.office365.com
 (2603:10b6:408:143::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:22 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 09/10] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Wed, 13 Nov 2024 12:03:26 +0000
Message-ID: <20241113120327.5239-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb544fb-6487-4ca4-0407-08dd03db52bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QAD6hMxVpLm/Y2MgGQJW9pM9lW3ba4Ucv4dO1aqeNmGJ5gj43gKI4kqDaJT?=
 =?us-ascii?Q?uuyA3BFVuuCN6Y4fHCvT9Wd1qwAjfTU/1Qz6nz4NIDoLzdfTmJv2kfRLs096?=
 =?us-ascii?Q?rDGKzAHmvnzKp6MglNTx7qEl+IpK3KK4OE7pEpLHFpdhj0NBKup0sDReOlov?=
 =?us-ascii?Q?YP7UEbfh3XFID1zdvn1JzF9SIVgW4N4VAwLgBBQQ6D06IMwzMuLnQU1vXVIY?=
 =?us-ascii?Q?gORGK9fPWeObOS8Na4SPwZwzt16qSCN1DWM6BosvnrmlM1aMzrElypWvnEIm?=
 =?us-ascii?Q?Ng6kNSF8zv7iY0cwA5y6qMEqq5EnIee7eXJWyCBw8gyq1QWLWYzqud4Vc/7J?=
 =?us-ascii?Q?5aJgOeNICvgxJ4zwS1wEGF4bRGwDnBW8O/85XEmLv1I/qIr0DietCB9iApCd?=
 =?us-ascii?Q?tPQ+nXg2LIO34ymAATYOaLz7Hmw/9FCqru9UBBYq0C1iUZPKjLcZq99QdWTD?=
 =?us-ascii?Q?KN+9MCNcQbCw7DEEKa1Uil4rSNURG8iPHLxmZUuDHkweISLILyoCCawhe1U/?=
 =?us-ascii?Q?v9rcHANdR0NKgbtO/wc8r5roqJ/EJXM96cfWU82SZo2UtAWSg5oymxEXUyF6?=
 =?us-ascii?Q?d8iV1EhZrZovqAJhe+9ByuSZFzVQSxn91tcbqNZxu12jazmcTLQKlBa7dXSW?=
 =?us-ascii?Q?XIAiY+PUPQ1a1eiaNKUKX4EibgtWLmHnyCBIwAmot2t1vtrvKsvqxXrBbGl3?=
 =?us-ascii?Q?JnOeHo27EPNjVGyYKEaObdoa0GmrsoBeh22BLFvJ1tueqcXnLd2/T+/65211?=
 =?us-ascii?Q?JftHcsn7/FmdQ7Mp3rOqFNwjE9lSzesMAU5Bryb22HnvAnySKJJapxnqsfZK?=
 =?us-ascii?Q?8Grdst9XnCGurWEY2n9d+eRjYVf4ez/ececkoUPaziQPL8qIX7Mu4GGzbGai?=
 =?us-ascii?Q?YgUf1BWTcQGmjapc3pEK2/6P99DtcYWCxtmcXYQwRk7n2dhRzK2zp3Z7EcwL?=
 =?us-ascii?Q?Pr0hETLlDSa4qT/PorcNZUhnbbBtFtsfhusXJVxLUWpsDm49v3P9D5SLKQ4J?=
 =?us-ascii?Q?c5RZeuQjzUZCg6kIZ3Xf0Uk/iBT5qMFADdSAzPP0SpcMwEAFhCzGPGSQvWQL?=
 =?us-ascii?Q?yDUFMk6X1JCRbbKukaMHS2uuQyjXJA7GxuWsiiESe1mQNcsbC/IpXY04G/kN?=
 =?us-ascii?Q?bPl5YuALyyWrXOrmctv1bHByxDidi+oTuBTPVPAg/+cMYKFUIcuHKenWpbPT?=
 =?us-ascii?Q?hmrg9M8kLZZ0rMFyBmCxCen4bIZG+eXE6EWLQHD5M9hbbTT8g/kKjEljDoZ3?=
 =?us-ascii?Q?amEZRsVhFPIsANQqYpk8niKDqmA/aYootd8vj/1Le1/Qj4LoIDRiXmhRkvtn?=
 =?us-ascii?Q?5bVfUy4922ssQsxDsJEWvJhzuMWbb8dvs8T/PZ0GL2jcKj+jVM5OeVML7KRG?=
 =?us-ascii?Q?XJGB+akg1F36rApHEkG9ZIaUnygOtvoh8vwMYbI+Hrt7aG/cpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:27.5156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb544fb-6487-4ca4-0407-08dd03db52bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 43 +++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f9260bb8fc85..7b43894f6b90 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -185,3 +185,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d54579206a04..ebcdcaa6b5f0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -339,7 +339,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2830,12 +2830,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable)
 {
 	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dev_table_entry *dev_table;
+	struct dev_table_entry *dte;
 	struct iommu_dev_data *dev_data;
 	bool domain_flush = false;
 	struct amd_iommu *iommu;
 	unsigned long flags;
-	u64 pte_root;
+	u64 new;
 
 	spin_lock_irqsave(&pdomain->lock, flags);
 	if (!(pdomain->dirty_tracking ^ enable)) {
@@ -2844,16 +2844,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
+		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
-
-		dev_table = get_dev_table(iommu);
-		pte_root = dev_table[dev_data->devid].data[0];
-
-		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
-				     pte_root & ~DTE_FLAG_HAD);
+		dte = &get_dev_table(iommu)[dev_data->devid];
+		new = READ_ONCE(dte->data[0]);
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		WRITE_ONCE(dte->data[0], new);
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3120,17 +3119,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-	u64 dte;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u64 new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
+
+	if (dev_data)
+		spin_lock(&dev_data->dte_lock);
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	new = READ_ONCE(dte->data[2]);
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1


