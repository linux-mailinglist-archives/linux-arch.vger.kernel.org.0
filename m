Return-Path: <linux-arch+bounces-9130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1039D091B
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923D6B21B5F
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7013D61B;
	Mon, 18 Nov 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XauLj0mn"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4FE1758B;
	Mon, 18 Nov 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909160; cv=fail; b=hNtVqz9s6mpCJS3Gau+c2R+/4QoK4wuCBNoKud9LSA+PdTZ2Cfs5VsygredEiQYBpq35O/7gAJfiio99ZlU5dAWeMO6PRDpHvh4DJJsNpUaZsLRjHUaIFUq+K/U+vucIjchPpluGKnFl9uiYqoPQYvMStSbfUD3kikjOdgS4b/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909160; c=relaxed/simple;
	bh=4ebb7iVJI70mR0HnYrcH3AroE6xLOnH/w4P7l6fxaZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx2N8OAWgNTIVfhhN/PlBNG0kHbLRKJeuCPglwqFjBhqUfjm1SjjpTfo2PTf3AQlBg//9MdXr4z/zNsjaA7InL0gcagtWs5qdRHah2KtpmIjlqGlXAfafurA1sCbnorG4owejwKqNlDBUFPeWTWhzyRJEgG/VowsJYscntllBfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XauLj0mn; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBf1rti4nzlWfwgz2V417i1z2zGkAJvY1WyILj9Rh2Xv+zXdo1GMZyH2ThfzP1VHgWzCDgadVwxfvL+NIPlFlpNMDwigAiSgU4yTN79zNDXU2XfRcAt1pBBB90fnYa7Po7xG8fGiGhCZ456Q2s/yIJOyMsBwFuqJ+CufShy1Wd3B6TLYXI7ktHCbr4DP/4o9c3zCI9FfV2n3n5FskQy9tRXcLQnOUF++7J32pTo4a8a3CsLhvETeD29oKuTR5MtYfjbvussPLWslAUqeuJswtfpYbD9X43rizZ5E6SEeRiQRUuRnbPTxZrBkrCZpW41C6cRF9d7RVL2MUROurZ267g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UGfiAJgc0pAnLf1ricbhysBTUjnmwroF2iTiY4F88I=;
 b=neQAWRBJtggXwLDqqOKGra4SZdzwfPlGThCNymv4XiZQzUcD4++6WqH20rrQL2TwTjHkMZV50lYs0y+c01BDKeQedki+A64shPk1/n1LnGQNauTfOf+qnu4TYuWCJv9tZK0eKTNFyMm26mgawPaG1Uo9Soux0gC28B97hdd52Kwahf1RMj79g0SwqaIh5nBA+YaS07ra2P+H37wKBr0psCXg8Ace9htuDS0Yp5lpmpupZHA9XRpscyUEEUJI7oAMlyz+UUxqRvO4Ikb+l/AW/WNM4zRmv1rN9AXhONDUejczDam9/LbL2NufpKsB+HReHHmkwtjbmux8EXs5oeu71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UGfiAJgc0pAnLf1ricbhysBTUjnmwroF2iTiY4F88I=;
 b=XauLj0mnbiDMAJ5U2ORSRcJpAgYNW1kio4yFWtbg8JIWdsxjTopxL/VWSh3/SQTXLKTHpOdOeq4Kn4VkxPXBpaqMJ/wQRZLeSgHMu3Twm40DFmuUNVW80VoyrO6y8TpZuyZTlqhuMRo6drhOVkIESnqy8AF4XBsi5FhdhJj5MXs=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 05:52:34 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::d1) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend Transport; Mon,
 18 Nov 2024 05:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Mon, 18 Nov 2024 05:52:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:28 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 7/9] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Mon, 18 Nov 2024 05:49:35 +0000
Message-ID: <20241118054937.5203-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bacf62f-97c6-44a4-2d8e-08dd07953255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wE6bys6s40gdBoNOrGJaw395vJdkoGpKvqCq1FZxp3KBFzy8tIdOMDcN/6m5?=
 =?us-ascii?Q?64ayXWOXaxKpOE2B3r3PqoVUIs3fAh7wTWezV8/gnXTH8uoklsLgcDhlkyOM?=
 =?us-ascii?Q?npaMt/sLlMK+bHY8aFTA6WYiVlrn+3sGN7tcz9lCSSfEivpagVuJfbvrXWrg?=
 =?us-ascii?Q?IpQ2BkXN0HNv1N+pb6U5ueqmyYiY7ADzyfrdgPvAX/1nFMo1pPVZVX4pf4ip?=
 =?us-ascii?Q?R1md0/erRSyZK1Rv3wTmcmIR5007657WvasYy4XDPbSYYqu7+dk+8D4wj2Nv?=
 =?us-ascii?Q?ZUWyAnVZ6RNWD1q4o1TW/8qAzlyhy2JtnhikIO3oLb/eudpFOiq7+sGAXHMS?=
 =?us-ascii?Q?I/p6QDnkLHYvR5aeyM89D9DtESWPGuWNiY093wOnevKDTQlg2rNliGc4uFPY?=
 =?us-ascii?Q?e7Y8sxbdQvadiKGL9EMNYYksPl/dsyk4mPIDyy5hhMsOooyq9e+ugDupfTUM?=
 =?us-ascii?Q?12TgcfvrVVkXBOpJyiK69GFjkZHdZWHZ3m+hOnDAlpc6xX84f77HgEqTMZLL?=
 =?us-ascii?Q?v5FVXN5IKA4aI2G+oKfMa0jX11NAu2bcUo86lFKiZ0KD/ieuHXd4L5QOfIKL?=
 =?us-ascii?Q?IoPY9OV7njsVUyySkOpLFpQMG1qyylPjvJ16SOjSjBIg05sdF3dYzPXqmkAq?=
 =?us-ascii?Q?fRtN6JlnbXwS4H6zNBTDO6vy99u1NCetO3ygPPvZi85tsL881CSvAgkrX6L4?=
 =?us-ascii?Q?LuwNr3kVa2/EBJE64lhJ1Xu4J6TjvZlCXO72TIzYpeE6AqqpvrvaLsTVZhqt?=
 =?us-ascii?Q?w1cJ2BsvxNDMW57GmGB2uSPs+64kFN7D1Sch97mhk3Nalbl4re9BXlBvRwxZ?=
 =?us-ascii?Q?8pzB7EP5Q7x6ixXwRPN5QYRjfTw8dZvQpgss3THpvlHAh2UZnn8/kVYoRkE1?=
 =?us-ascii?Q?hnnXbHVYVbeROOxV2eIK1YkrShJFtfJVoTnzGgDHrtjnYFu9iWsxaUCMCC6y?=
 =?us-ascii?Q?n9P/oZmeVO8+sTqdEHcxIGDNzaDNAR8e2oa8+eZYwTgSqnX4jzF0b0PBe7i2?=
 =?us-ascii?Q?5c2RijG1aSsrVX10Tv2Vgb2Cbd3o9XDU4iw//dLEF7Symee0yMLGwou3EWCc?=
 =?us-ascii?Q?EJsyslp1oYoG6gYLFxhuc9i2xLbdGSE0javX4Qp6cDbSYBMBrh6CJCN+n+E0?=
 =?us-ascii?Q?KWVlFkISPQW8aZy8ewlyZ2dJ+5Sez60NdjHsFK2N9+2jqABhCMNpdBxmULI8?=
 =?us-ascii?Q?5TwHnyotpSg22AYli15nVYrx3UVS8EdX0Jp6zjWTt4mRP8W8iArt329Y72IO?=
 =?us-ascii?Q?N9bMRr4DtET0lJReK4I0Tk2hyneCKQeRieUnjNLQnrNlfdgbqJEuivTsUyQs?=
 =?us-ascii?Q?aS1rBbjZJtpPumhCSXf+GjJwcz/czGbgufAVxKXrj8oIHU8ow41CRAxvaqXj?=
 =?us-ascii?Q?npwEAs6+TrhGqNqHuDT/TxVcwfGugyi3OD3hjURY6rKUWNXaeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:52:33.1765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bacf62f-97c6-44a4-2d8e-08dd07953255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

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
index a1ed8d3b3887..6adab38cb84b 100644
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


