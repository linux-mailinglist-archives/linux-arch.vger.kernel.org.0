Return-Path: <linux-arch+bounces-9096-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BE9C9296
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1126B25F24
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9C1AD3F6;
	Thu, 14 Nov 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MA8FCktg"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEF1AC884;
	Thu, 14 Nov 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613534; cv=fail; b=okB7E1GJCeo2GNFj2FSXpjZQqcRE+df5mzhC4PG3kwRjOh9vocK/8wUjsmrdJt80KbF/StBplJkKkqXq7fux7x7OMmQsGb170EQxAlCZLFYH39L7vrlb35s3+TYjJ+ojGzIUOATWLfnJVoweiyMaTq9k1AzZAcz5m3yL/G893dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613534; c=relaxed/simple;
	bh=3LutQPCRym9Ipba6rDwB+D90hnu57+hwxY48vzsEV6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQNC/tbHsvk7GaBaxm4EMpRnckF+JVM986/zOQcF4VnXtQQ79E8R8QgyoZwek/pLUXBq9sqYAdkhKphiwqOeCeG8MoH8PW5cqn7xuSTs6J6XSuAuEfM5xr+sAcaW9FqxZCAzcZz3jiFLc25+QRVghBH7L4ZIq7prvKJZyMMTHQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MA8FCktg; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9ByVHpCWoSVv4l9dB5dcYo9SjcykAJqg+/R5DCX8krb3r1AUu2x5/FlrjL9pAwW7KcTH2dBThrpW35W1Hdy3F+ZtKPnvTC63Hi3Wa+udpcKVkMtMrVLYP/lHczR3yfcKpzsxegOBOlAdh+h5zdV9L13Nf6Pnwlu6sZSWTbp/LnQqCKnvH/LlyTBsdoDQNm3cjjcTTXfBP9FudgmeXkGDu0GUwydVCLE8hCZHQsp7jOfWVhEfIU0fIzZyWblA427UdyETejaSiZrjEn8XHsx5Xs6LWTxuhPXljJveKnX3IBMb0vhd3EKdM8zrmWBGmKOzWk1z59IlZ0DGrW4JroTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRTvE9NMOR1EgcwPA4vYuGwGy/DlsU01+HLuB1/WbXo=;
 b=kN7aDkqn7unWGWJDZ+EX1y6pPPCr6bHDkTtpJTSAeHstfxcIOCsduQ0v1DfIFNI+JAv7IgfiBuKQf8Qztr4GuiJH66ObhOCEtBhiHCoV/fhEdpBOb7YRWuPBrhf/PPK2vMzuNJ2dKIVMa43mD50JvkFT1J3S2WFpQTkamIS88Hmv2k6CNQvMz9LhhNHF7P3CxKHWYpRAGnzIgpkT0gtU01wTwyMDgrSjpqVhwf2yFJzLJqgO69hU82mP/cN8g3fJOAFwuOgLkASWuDihu7n2sDUtDurK9d1yUZ4NYgPIdcnBAlrZJUizzx/kxVOVsIqyP0j0i8q9LHkvjZT9vN2wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRTvE9NMOR1EgcwPA4vYuGwGy/DlsU01+HLuB1/WbXo=;
 b=MA8FCktgopmgVfafmXuEqCbkqobp9Lghvf7Z2MKBx8svUA5h3a589QC/e/lu5MOeTd9lct9BKqn+NsSIBqCjMpC/1VZgkiZxAdG2V5S3nI6RdKmRVNRx84PDb0pQQRJh0myz6DJ0vgejUNyFjet0eVcvDT9gi2umhnmt8W7pvUA=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 19:45:29 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e5) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:23 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 7/9] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Thu, 14 Nov 2024 19:44:34 +0000
Message-ID: <20241114194436.389961-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
References: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc42927-af0c-400a-7729-08dd04e4e4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLOzS9LMefEoERFXiDFWxRrX7iju2OdpHQpLxpQglkcFPSafgkObT/0fUrp3?=
 =?us-ascii?Q?iapJUypx//vf7NrSkT6yq2FlOwvu0VarZcAAkuCjC2FpkT40lEKPaGN+9B+S?=
 =?us-ascii?Q?8MKUM31z2tMRnaVaeKnnP3HxYI45UXykjhHd+Z81w5RuuK+WrUDnsjGsYWJZ?=
 =?us-ascii?Q?0g9Fu2nitYVg0Gogpja9tte9G22Yo0N6Sag23gDNSCpPl+yhLwPYIqwBt+PK?=
 =?us-ascii?Q?p5bg7ZMh8mAe0sPqpvwYljhTB5KsZ5Mvm1tWzUw/2sDC6RaXBapnow+yZBhe?=
 =?us-ascii?Q?g4jThM3aAsnREr91/iCKR9lA4VWyLOZl0hXo7HhfvTUvQuKvfJJP/9GCw7QB?=
 =?us-ascii?Q?L69KH5jWCY2o2PJZq16qV2/HPyD/UVCAomeiPgA0RbKaYw+4SQ4x07pHhRAu?=
 =?us-ascii?Q?v7AQi+CIhVeyCTcS/KbjF35cHPBC5CPzsJOb/h5ZATUUhLpM7NszCfPhlm8X?=
 =?us-ascii?Q?VVTVsM4wYXsh2bjKlh0iXvOhnfL6abzA2KROeZOHwkInCeKu3OJLG3eyQiTH?=
 =?us-ascii?Q?5e8zPoiwtB7SDiiQnw9+arWomsXTWgGAbAcL1Mtkkhrqb1axue5aWkgZKk+F?=
 =?us-ascii?Q?gGy0AY9e29UZb3vzWOtxtEuSPZHtnKvTqCCKTGtLpH8MepzePBWO6OFY0mJM?=
 =?us-ascii?Q?wZU3cx806AHd+4gPnrCWC60zlYOzoUCLfS6wELhEnLUIO0djsVRs6pfXTYPk?=
 =?us-ascii?Q?MmolDPg9TDGwhkzNPr1l5I7y2KGY0PySw7z8ovuX5qGHwm79qwO95M+RCo+P?=
 =?us-ascii?Q?omti+uvERBixPUh2bxCn9roxL6LH+ukg32J+srHeTVK50ehruWWa4cOpZcfG?=
 =?us-ascii?Q?WlrLBCTMeCW5b2aGoQfUN7taGra276/7MOe0El4PiPA2JpNGfnnJ2trDHSWI?=
 =?us-ascii?Q?hJblOyNgaL5weF2tt8DaEQar8eCDeA9S4kXhPbSz2iOX3TSP+K7roVctAai1?=
 =?us-ascii?Q?BCEc69vXZa52ACJ0/6JDQuwQyu1fv72O+lmSwDzIkbP1gVOswsM+v8aEyERz?=
 =?us-ascii?Q?pxtNOzLfAPVVmQV0T7o4zsJAg1b+tcYxIDfbG0TvayBtrRSMhrXdBHLuPA+L?=
 =?us-ascii?Q?Lu+AKNHQkAo2Yb4hyJHQeGzn0FL01He5ACEMjEuG5HmpBFL1awisa97WKkch?=
 =?us-ascii?Q?fstN5BIi2J9qZRrvsnL2doJ4+FFXzwcB5onzHvKRBiqxtkEASblBivHJUIVM?=
 =?us-ascii?Q?GmUHWz27td4DSgUrUyEXYLjmCT/u8qqpjbjSumX5f+DdrMIqxtUO+oXe8/E1?=
 =?us-ascii?Q?mFFRC6Y6WEySFipnkln0edIZ64kKd3xZArcrbOyWl1V+2J5sed1Gg0jsWdnd?=
 =?us-ascii?Q?1MXblBtOeAzSgkFPKZigf/HNilcaLVw5Iyglo7N1gTMnhVS2p3k8d1rWbZlX?=
 =?us-ascii?Q?XsYfxdE/2/GIZs3CYoSCmQFaOtB11wwVxiH7RR7ysjd2NjrwSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:29.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc42927-af0c-400a-7729-08dd04e4e4a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

By reusing the make_clear_dte() and update_dte256().

Also, there is no need to set TV bit for non-SNP system when clearing DTE
for blocked domain, and no longer need to apply erratum 63 in clear_dte()
since it is already stored in struct ivhd_dte_flags and apply in
set_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8f1de15c07a2..70002fe3994f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2098,19 +2098,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+/*
+ * Clear DMA-remap related flags to block all DMA (blockeded domain)
+ */
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
-
-	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
-
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	make_clear_dte(dev_data, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2121,7 +2118,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1


