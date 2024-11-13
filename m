Return-Path: <linux-arch+bounces-9051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8CD9C6EA0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20A42809E4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769EE202F6B;
	Wed, 13 Nov 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o1o/Y2iP"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41872202651;
	Wed, 13 Nov 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499441; cv=fail; b=jvZAbwy61bcr2uwdAvnpEveKPrb1OS44v83INgOSglSQwa1AEQa3r+9B0L63Brzxf1+q+woJXANGmYhSWZOdfjTzvRCXvq3HwH1oqGTVJk9q+9seEx4UiLlnGWHkrp77VC6ZWtRkCnvoEXzD07e0EiCiJ2TLc7b+easTWyQhPeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499441; c=relaxed/simple;
	bh=I6EQiYw8K0f5jXKss9BxucItbForiWMKXniF8tpRkio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARFVKA/S7qBGMnD0qkZnMypRSGlPAQ40NUqefwioamC/IVEmh5osa4iDLnILCYS0DEaCe7cOLHrxbzyX6DuaH1naHYk5cG20YvyC85h61oXg8TgHfBo5pBMVHRA6mGlkuIYD9nlz0ez4CYs2Mq6lOWdO11yQtFHyNslllZh7HDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o1o/Y2iP; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHo4M3NAe7FQYOrWkL+3BkdvXXabiy4+yuTemAYlpD38YFr0omrk4XntrpivGv+eJMcsBgtcxTF6TO6i82lnD2RHwaZTAh/qKsa3z0Svw2ct5htxkrwJ2ZEPP+dr80A/i5jasp12Z4FwiutosEgzmHYXvnbul3i1K5m+OVgy11jAXmqiWe8/a8uTLMz7Y6WqeXNKDvxgZ05er26/Ya6CbuBzZ+W//AA9L9I505Gp87lFrwPoYlDgqXwoT5EhMMqyq961BNegh4PNkQ7WxgytMdBLxyVckzCXttOciM/EjFBEI6QASwceLBmxgdCZYcP+gWsmZl08Na/Zg0YgDF0sLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=TwBztir395bj7eQYlc94TvMtDR1IWDV/GuvrhB7Mr0nnIztfEhma27q0Mmd8KfzdOS+DLulm3Y0jk8NhKrJvUYbkbfumdvsTCs1Z5y0GfoXh8oWTKdnHUQKVaWqcg0JFpl6pugng+Vos7KASDmyFMZcoGAhaJ50kl7BLMntmK9vH6BufQZ3ZpMrFBJlGqxezKUn5xlWHtk59uWcSN0KOtVlrlJnvgadXrkr1a/PTAQA1XGqqOqi2cfDgG1TJGklJ+uh7NcrlOS/bMBxGc3tTsKwjlIYWvdKW/p2v978aQbMT6oqHcOcUccXr75o2ty9wrTZg+a090wqodA5isKeRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=o1o/Y2iPWOhtjkNwFsG8nY++YiJ80+0hwWaclg+AK5dURTAGxTRXwhFAmK6pBqCHkqAvgv9NZe41i6jIYJ0d40VlF1aUrpZwcBclPYhL9XRdt9kLARY3V++U0mN612pu+NxXMKpJnENWTDLNZ3os0lekh7ksA5XAKphMsh+TBD4=
Received: from MN2PR13CA0035.namprd13.prod.outlook.com (2603:10b6:208:160::48)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:03:53 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::d0) by MN2PR13CA0035.outlook.office365.com
 (2603:10b6:208:160::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Wed, 13 Nov 2024 12:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:03:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:03:47 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 01/10] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Wed, 13 Nov 2024 12:03:18 +0000
Message-ID: <20241113120327.5239-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c929a0f-3c96-44f4-7f05-08dd03db3dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0RgAJQNFrB0hd6kpbwdmWjn8wPJCUllFTOkbWDvd0XWTTut2NJwHQKMYFpg?=
 =?us-ascii?Q?oNrF51hyN0ZdSZkc1KXUYTG5bfxcXNmcBMyQhkMdlhRhWSuMTPQgMcfVjBrO?=
 =?us-ascii?Q?WDiT45B1cppN1Vw9plwRQuROxU6dNgZe2yW64YicPrRB+EvhD2Z6DzPvgtgh?=
 =?us-ascii?Q?pxcQAKU8lhSw9x5kYddyuIYiaC3gu+9P/QIVVPbnX3kuynOjJAZxK5DQgwuW?=
 =?us-ascii?Q?aK7tFsUA4dNp6KVWjMtZ5naqCFJuoKgyfnVj0RP2hdxvJPxB6ylPHzRXNyB6?=
 =?us-ascii?Q?Gz10o0XEyMCeA1Ksdr/VfhW9fHuLzhaFRoTCzYI94hcKtccR63G97rCZnRBI?=
 =?us-ascii?Q?jddoOiXxsK1wDE0F1PhzWOCPoAY3aou52K/qbBUKSTbMGQ2KpP71V5S7FLKp?=
 =?us-ascii?Q?ZNryDwnss63QokL9bBpD+pUuQVySe41b7n708c8YuNdxb/HgHQkjv9A+g/mU?=
 =?us-ascii?Q?8ZJbW/AJPXwO1/0gXiMUIyZa3nx2dY582vikLu8eE4YVR8J9ie3lM6n+kNyy?=
 =?us-ascii?Q?8c/aJur+jZCnE5+KYb+LDkOBKSHkOeYGZjHt/U3DbC+qVJt6d74CqoRR0xrk?=
 =?us-ascii?Q?eIXBnyYqWhqPSDN1bKhCoQbDEJGla9uKy2P5VqCJwmOL99mDXPuAXNQHkVrU?=
 =?us-ascii?Q?CLdLmCYzrIy3i/CLrbB+kyhaDwwiivIQsQDACIFNXJ3TVCLRUD6+orX6Ux0F?=
 =?us-ascii?Q?0HRY/RbtchU5nLH+3L3heZXMMc31/agWyo+MqtmGyY4KjjL2ZSajyf+QaXZw?=
 =?us-ascii?Q?OxwVc8kEbMPrlEZ+Ysi0Q77T/23fPdTFgJXuxdRs/Re/7CKvrVIdKJ05FWRo?=
 =?us-ascii?Q?coSn6N5LSyJQbhF9IFtA214jjloVLxZ9x6JWDxvIOat8vT03puFRxueQ7iUU?=
 =?us-ascii?Q?QJ9w1mYecERv5azXoEpVOvh2CDaho1Ph7frTbxPnYjTok7xUrwbzGOJ7gCBB?=
 =?us-ascii?Q?l38jUx1gtQeTtzfivJuVbUDTwL9bwWr5L1jITDBItA2cK6YfcOr/VXEef/B1?=
 =?us-ascii?Q?zWyckzabg2qmdOKXsSPPBbSWtc610+5hXw1UEdlypnMr6I2vviz/Ue2g+5oC?=
 =?us-ascii?Q?pxoVNHTM4F94+P3EFTm86QSuRw1i96XlzL9qAVo72F8s0Im7uy0n7CUlWsFh?=
 =?us-ascii?Q?ainEOsi/bh6LQlAj89p8IwA5GMzEcXi43mpRf35t2OzNMbbZe84MCHAWlUoo?=
 =?us-ascii?Q?Rb3RxhuWX+DXQLoQtJ5Cnv5LBU/H4ltrHEnyGdrg7IQPwEe44dKljlz0o+6w?=
 =?us-ascii?Q?Q0hCylIHtm2boXMXVeGDB5h+XAx2BM43SccAub5dEm0yul4ZySi97+5AyI0r?=
 =?us-ascii?Q?/gM0Nn6R7Re40ofqkdV/yMs8Zn/SiAbi3O4nOI6V9gHkX+B5uS/f+KSblHyQ?=
 =?us-ascii?Q?YiirzWgY9Pn4lSxWTaL0O3cwGiNg/meJBfQ2jEJOusaKUaBeOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:03:52.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c929a0f-3c96-44f4-7f05-08dd03db3dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

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


