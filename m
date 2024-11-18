Return-Path: <linux-arch+bounces-9126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55A9D0912
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AB4B221CD
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6A13D279;
	Mon, 18 Nov 2024 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2nXPTA89"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209138B;
	Mon, 18 Nov 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909016; cv=fail; b=gakZeeELrclhEGcP5zUa3iIe4au0iu2HP0OMfktEdwJdKV/j3h876eiVU6ysEF5Eu8677bJ+YT8qmCZsuZICq0fPd6g+DOzd7csB+890KF67Z25XO2VD5q4qkUVAkbaj6AMuv2TM+M9LECdCV+ErkX03eaWNM2ikAwxSTcJXD6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909016; c=relaxed/simple;
	bh=I6EQiYw8K0f5jXKss9BxucItbForiWMKXniF8tpRkio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOwiTDKe3wxqwN3paKAMcX0BvwL/z6+pswK8U32c7nOVqERzF8voqw8OL6qMUH0KWwzGOpDqBYVoRWaUo5Ww0HB5TXy+XLa60ViTcnJF63Ibl0PM0+yYAYuqXx2M1Q2vVIzMJioHFhf5QmiMuhXff31sOErCklszU9mpSu6tuTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2nXPTA89; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXf/egnq/xhh2mY4U0idZ4REPUkLw3bdl9WumuT0ShzZLCMO8VUzJ+Atyse0eKACG4V0ayeyCGR29qdvW0PXc5S++1gqYCC3UADFdZEvkxc13I3fyyi0PS18xhZolnHiI4kd0Rf/azm/undQySZWvROWWUtduDfC4ETE1teUH9O7EC/CHCyGTBZ9cEXTdul7bY3Z6jZkWQDhsQa+vl5LpcDJzn1IEASgrvs/eyZcO8nCJPeouKHVterSLdXaLdDwU3atcm7Lt5TF9oXO2DG1rxjs3X0qX/fAns6BjWxWB36sOphSDINfWthgy9mgK+CBeFCN0peePI2mHD2Lvle8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=uFI06uapuSuklZDCILpUCSKX4HuuF33RjzGTN4qIxxDl7BZYBgqkDErXXws4MmNAQJrFnr51WUhVY5QWZP2IWsRaUj3OZKoDIreeoP8auUlYeAhFutWRGOqCjpGPpnl6MmK/A4u9Y6ihXS5Di7u+2ZuwGL6IJq+9lUMSDYOSwOkXYqeDZ4smN/6Zs1Tpr5BX633OS0nuNW2KyORW+iyi5qsGl+j/qjqXMIEpMr0QQHLHhIR8tEo7/66/5vCWpil5nsEZHwwRU1BJQ30V4WQkhOQvwqOqRsfIuwcaGVv8onTJMjijW95bsJR+M3iTgCqfpaG/xB16hqrA2JQS0bU20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=2nXPTA89JMkRJLcgR/lgi2si0roVW+iCfgfXS60+TAY8uvOnke/Xz5aoMYQueLQPMVQYIbpmHuLZUEAncVHz5qQ+OCE81lXr/THg3OJDeL8RO9IaEM3GTZ+F1lioCB/+61bdnZfO3h2QW0HDCCTRUc9rBp752KQVsm0xEtkW8tk=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:50:11 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::94) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 05:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:50:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:01 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 1/9] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Mon, 18 Nov 2024 05:49:29 +0000
Message-ID: <20241118054937.5203-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f2e861-9ced-4ab6-9309-08dd0794dd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rrggiR+usEk1arjOWfLTv1rwROdTvi8laIF0dldCYzN6ovo8yezv8ivbe6yI?=
 =?us-ascii?Q?03WazP3dFn8vTIp2yePHUHXhaa+b0sCEfIzoIJy5gG1zMi1mNKvd8p/yaKNC?=
 =?us-ascii?Q?RG19Z3At/18H2GlxTX7VnICsYi5bBvWXybv4bE2Gw5oF2hcZ9iksGQNxggL8?=
 =?us-ascii?Q?VTBXmoCoPuLZ0KQkySUhRXRpzTUEgWU5WS2cIjAWz2BoTj+ihGc9oSDG4Y0U?=
 =?us-ascii?Q?UApsltBc0Hmz0iwA/69gWtyxQ89BGa0bPtJsk7/ZIUxRX2JHx1iV0JopeetN?=
 =?us-ascii?Q?bRXghFwpF2YkgDMSnPp+XiIlNHg3Q9fzfJ92PorzRXShozVy4if6+wpZ5GLV?=
 =?us-ascii?Q?blIRh4GJlFCTFPjn5Ncu1DKV2SmrGkB6NUoDEnSkSIy0hdjXIJM7Oz5k8Adg?=
 =?us-ascii?Q?siDOZ7umdd0j2J7csfm6fYWV5NBXG+TscIC6NjFhmzQuXqmZTERxM6lKB3+U?=
 =?us-ascii?Q?MxH6aCrpLryROmtYnUtMVUpYAM32H2rrzesnF1gtnY8ZwohQpdki5IZt41aq?=
 =?us-ascii?Q?UYiYStGvQJzGF/1MQ8bwU2hR3MplefrglHjAPdfUQoZr0q8gSdPCyZLIGSO4?=
 =?us-ascii?Q?WVWctdKW8bIlpBllSbkeGcusZazVE5gdrZ43AIxqK28T47mTVjKS3qL+ofSO?=
 =?us-ascii?Q?K4Fy6ri/HZEqrjP7Ymhn/fcIxW7F1gkbPsemy+KgNAlcYIU/1ctes4fxZzPr?=
 =?us-ascii?Q?1q+rvqt0gIpMzsEBqZgsfdhLmeDZVIWunta+B7fVnMdZ6HR3mup4H9Swq9ns?=
 =?us-ascii?Q?DHql744l8DXdSVb9DKS9dwCkQARFiXVdGQXrztEfEw3M9CJwGSjxZO3kxXH/?=
 =?us-ascii?Q?GwPQsxOdBPaYGvRiYLsZE1LZe4a9DMRjoU2nskORL/+pl1nX6FDtyWFfc3ww?=
 =?us-ascii?Q?tAvJAzBz9ZIiPay19rpDvc2vDG6VgjUDfl3lrp1UskWMLw2hPLv72IAkoDHl?=
 =?us-ascii?Q?G937SVQVp/xH8F0fFr6Hj4DMb+WtyjPa0ZMfAmVJEDiosUndCSkxYoImYZJ2?=
 =?us-ascii?Q?WOiyYeRTABBDzM0v1/B74AJ8NY7WdVrLcrmP8dLTs2hC0ujl7Ib9zOl3NHI+?=
 =?us-ascii?Q?1ib2JA0I8/ClFTVVDrcvv/U+cfYWS6Ww4H1nqMYF/F8zfD3pFpe9TXTPkbs+?=
 =?us-ascii?Q?8lsBoad0+PBREmPIDoy6O80MTp87rdT8EGx70F+0XGMcwuGwL7q1b2CLwWqE?=
 =?us-ascii?Q?duZOTH11j4CEEbCdtdtY3FFRVRIiE/xbQuPHoOtcrvfIF/9hPrwiXGtUjanq?=
 =?us-ascii?Q?PHr0yWV/MO0gAuO6wouRKRhYd/4mhBsSSXMm68GdpZCiwzmDLrpyjfBoT3VY?=
 =?us-ascii?Q?0ZJqhrXxLibfLiyTsGr4TWi9i763ZY+VCtTUyKq+qsXTJIqMjt8TuWuzoSxv?=
 =?us-ascii?Q?I1dw2/QSz0qcb/v16Tu+yCD1Bhx7ld5rB+WHMkvn1zsWl1j7AA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:50:10.0689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f2e861-9ced-4ab6-9309-08dd0794dd18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

* Remove redundant AMD-Vi prefix.
* Print IVHD device entry settings field using hex value.
* Print root device of IVHD ACPI device entry using hex value.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 35 +++++++++++++----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fdb0357e0bb9..af87b1d094c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -468,7 +468,7 @@ extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
 	do {							\
 		if (amd_iommu_dump)				\
-			pr_info("AMD-Vi: " format, ## arg);	\
+			pr_info(format, ## arg);	\
 	} while(0);
 
 /* global flag if IOMMUs cache non-present entries */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0e0a531042ac..3a7b2b0472fa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1239,7 +1239,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 	entry->cmd_line	= cmd_line;
 	entry->root_devid = (entry->devid & (~0x7));
 
-	pr_info("%s, add hid:%s, uid:%s, rdevid:%d\n",
+	pr_info("%s, add hid:%s, uid:%s, rdevid:%#x\n",
 		entry->cmd_line ? "cmd" : "ivrs",
 		entry->hid, entry->uid, entry->root_devid);
 
@@ -1331,15 +1331,14 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
-			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
+			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
 
 			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
-			DUMP_printk("  DEV_SELECT\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x\n",
+			DUMP_printk("  DEV_SELECT\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1350,8 +1349,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT_RANGE_START:
 
-			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+			DUMP_printk("  DEV_SELECT_RANGE_START\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1364,8 +1362,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x devid_to: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1382,9 +1379,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
-			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x "
-				    "devid_to: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS_RANGE\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1401,8 +1396,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT\t\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1414,8 +1408,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
-			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT_RANGE\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1428,7 +1421,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_RANGE_END\t\tdevid: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
@@ -1461,11 +1454,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    var, (int)handle,
 				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			ret = add_special_device(type, handle, &devid, false);
 			if (ret)
@@ -1525,11 +1519,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			}
 
 			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, e->devid);
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    hid, uid, seg_id,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			flags = e->flags;
 
-- 
2.34.1


