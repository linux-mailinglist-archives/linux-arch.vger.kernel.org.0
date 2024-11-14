Return-Path: <linux-arch+bounces-9090-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF89C928A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9594CB244E5
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729E1A724C;
	Thu, 14 Nov 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I/UEHqIm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34811A3A95;
	Thu, 14 Nov 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613509; cv=fail; b=O+46ith88m7FCtMuR58LRp6BBFLbVG2IjQ08ulRQW99pzyyYppunjyILk8P5vp3QKAa86DUKGC6AKLN+TyJKWXhMhYnBi6/tvgG8xr1X4DwSfgnzMxeAps2MU0WSV2DSZNb+dReRp6sANSWt3wyLFLEQxu9vLtxA73iLrTh9fcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613509; c=relaxed/simple;
	bh=I6EQiYw8K0f5jXKss9BxucItbForiWMKXniF8tpRkio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEBcLwQ1fLaBMiKJiXuG+Rdohrim9ktd/051M96NkpdGnJof7qkxzOTt/KDLMg6wIKY9nUfYc92bwxypLmNT+5JC/7p/8NDlf3kANHaHqLNlEr58YZL+lMOn47pqtIuGxhRh4NcluM4ggTAhR2m93Y2fBuogs2cB6dG6sZi7Ta0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I/UEHqIm; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbxIoC2331fSzUwxydj7przBc8pzwblo9NNz58HpwrnL6kSY//9aN4B0w1wQdLracZlCYCuclK+nVu3/fO9oBaaudQJZ3+n/hCUw+eDfwBEVaApf2MJnkCyNacrXFx/SsbiL1otDr8mF3WPForR9isXzObxqxGJ8jXaVVwGeSkrDQZzqTlcN78wnSlMdP3vBdhA44iCkAcP7EzAAcq9Bmq9Q3W39mgnUelbi32WZrXF77BGZltP2qnKu9RbudD5e2/8FkrWMZ8WfkfBZxbQygfiGWpnQubPgbKt0c2nsOpWxeoftgM7LNExLvbZLiFqkVkNT/pygyQJan144tCqfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=YlEPLqfss9R7qiVVfogI5uYChvrgfROJrkS+vk5jF+IWBdncW17jCe3JA0i/rxtgL95nAPvHDXJ+WVkTZoFZ7fbZQJgoG+tvo+z1RIW7rLrZ/nLU0V7sNW0GyOG4LEeWv1CqQxcakNDJVRaV3YFYo7snLrZRpdfqhLfEEAluYKo7mGmESiK09bQIFL50QgncZGjnubwEY4EyEqW/5FGqMjmzFPMMNPmkqIWZVaJ3XVxCk2rq70aeT+oKibY9oAQrOpYkvubgDTJhGwUxO5u/7YtVPNvr8UL9vfEdrVdVWITydkAObzxQYvTXP7CMj7S3p1wZr5yVCNaqkUqrQvzMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=I/UEHqIm7TEU+jZmriqZIAmMYhECdVmCxNqCLQbu7thGN+2XvJaYJs5Kwm/V26Rw9LiBPLGrq9q0X6F/wYYDXFbXhfCQbYlVrYkvgvrPMZXALdlHRbdwQlIcgVqNUpnD0p+MqsN3Il42uQA4O/0kBPKOdqet6eFwTOhHap8SnYs=
Received: from BY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:a03:1a0::18)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 19:45:05 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::99) by BY5PR16CA0005.outlook.office365.com
 (2603:10b6:a03:1a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:04 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:44:58 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 1/9] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Thu, 14 Nov 2024 19:44:28 +0000
Message-ID: <20241114194436.389961-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ff892a-4e1a-48c4-9aae-08dd04e4d62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PWw3NnC8ASMbYt2lFAsJd8ohQ8AbQMDAjRL7HNcuJ/rBZ5UdCTOnnl5/MPyt?=
 =?us-ascii?Q?Q+XfYEMv07GNR4RCvdT7/N5Tav5NdCv/1ksCa/COdGfC8+84js7O+1pKGsAf?=
 =?us-ascii?Q?pp40pWgtEHLCIZlvZ09XIwEJ5GB8n7rQPp86p/6JrqxHIxfynswUH+zm03jQ?=
 =?us-ascii?Q?mPUJYvNjqzYhOwHOTy1fD1kFGlpPnZhJFayqkjnpiI8gIlS9m8ZE1+fvTmGc?=
 =?us-ascii?Q?pt5gCWzVBYDi60hj/yh8QGHGnzj9SGKx9upHjVRoe8YD5Lirq5Mmds6u8cMd?=
 =?us-ascii?Q?l/sqn/nh5fViUcOFbwKlv4PNJwV7dIw5jat4wuLHlPn3kFhTmNycMAcHHSU/?=
 =?us-ascii?Q?BPiQQMkk7owaY/p45/f9l4nS6y7JOFuW7+K3tTrYn1S63X/lxTJnpS3IAWIF?=
 =?us-ascii?Q?tEt9D3eBsLZZgpLkM7QZT3xm/GehNYjTz9uBhK2KenUl/QdYHLZQL073M63e?=
 =?us-ascii?Q?iSXyS0DeE+uFWgIxjsQmWGmCnVkUdIyl9qOuk3jieslmAR2yLgXl4CGDW11a?=
 =?us-ascii?Q?EZcufcFdoCyyQPLPUKeYcbhRs7ltAGg0DWYMsi8kUxxWAlMRSFx8M3cCC62L?=
 =?us-ascii?Q?3aU8l7Xj4p2jiR24FFpxtZvw5QbAbU7pAYkmddwVpNV/16pDv8o9yjEUslEA?=
 =?us-ascii?Q?HevLqwuVtNJJM/DnnfdETAuzUKWUR4uNlue0bWaH81qfGxA+Ck1mlUBT9dwo?=
 =?us-ascii?Q?lROj2C0fRv4aIoc843UMiqUDk8ySkHd0vhfy8l2U24osPLGHT0Pkt/2HyIDu?=
 =?us-ascii?Q?U9+g0FBhQBR1uHlqrXD4jBDq0ax4Ydlx/252JSq9zK0HcMUfa1G0XuFLbSOS?=
 =?us-ascii?Q?NJqlAGFgInZCJopXaUDzf5bErt7bcMaqxRxnA/9G4pPmSkWyaoHcZvDi145E?=
 =?us-ascii?Q?o7yEOz2ADo47nVHeW2j6CY0pgCM8/hL0BjXIWHRGD69sd88aUJf5y7uuEQrH?=
 =?us-ascii?Q?R3yw2t2cf9qIhBSsxxqXchT/1RMkNijbueRPkDWPyTSMm76HjDTlHPI1rUh4?=
 =?us-ascii?Q?uLahHgoTN2gRrCLPEO8Ohx3wSwZtBJcVY5uhNogDRp7gnK3ltB8FU06XYTxo?=
 =?us-ascii?Q?U5rVcYswaMZW6zDPqoLsnXdlUkw20N2JakxEKNvbHIFgkBIGK4TdreU/vb3x?=
 =?us-ascii?Q?P/KH+NCpsXQoY6Ar2kFszy9tNX1DkzJr3sQ+H2BDdpQHOx7ccvgBL+jDbvPy?=
 =?us-ascii?Q?QaUo4oFBw4g8HewybBI/XopJuFxqkECFGJx65WTZiURaAMAQoqzrV2uzUZNR?=
 =?us-ascii?Q?U7yaR8ds8X910IU3X6bH0UrVeSGj2yWdALP8khmUYZfBqMMe0C7N/jBj6k9P?=
 =?us-ascii?Q?qt8HDiHTRU0NQ7Jk+TJ5Lna7bvIm1dYaXcKhWVq4CWMOGDbiLl65Rvc8hABu?=
 =?us-ascii?Q?PWukxqPfHKmTFFSqALT2Rq9x3s2CU4/nNyuAf3i/Q6dgniEGAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:04.7349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ff892a-4e1a-48c4-9aae-08dd04e4d62e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

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


