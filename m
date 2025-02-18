Return-Path: <linux-arch+bounces-10177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB9A39A05
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7656718902C2
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7F23BF91;
	Tue, 18 Feb 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1mxrknL8"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895522DF92;
	Tue, 18 Feb 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877104; cv=fail; b=mlc0HncPvEPLl5Ngp+cm8EEDZ1lF1WQC76nOsV2DIkTms3BIyzNhtvJXkw1LGqrVm3TeghClaty52KyaT+0hlXQb/mR0KtRxm5zHaCfZY7XQQYrss7dxem3jXI7bM6WMEXsPudisXoaVezLYdKxVE6r6bazZzQsgWfG4zj7nY88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877104; c=relaxed/simple;
	bh=1KVx7VYiVA/8sBupT6NnqbQAau2zF5M+T4XuMdB4EQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3/Vdz9gI9L5GImgQDYxLTf36QR5KWDgT+c7wqfMZ+BJhWRWVSX/Pyl4wnpYy6nqG4V+cuRZsKY/nOFfPfVXfSgvhpt6gWGRSFWBueq65A58EIgBDQxUBLv9DAcSWzOmeey79VOJQ2R1PUfyB2gZ4QihXqIXUrdyIjoK3n8O3f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1mxrknL8; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoyIkPlIIqIlALP0KlRDwj6chMX8vtWfqSzh/R6GSXjPzk2hOl+qtE3hal0MLB4oKHBLnCP9UP54YdRH4oDeohdmJOKF3Z3jTXnfqBz1hHJAIDnUQL2z89NyYh2rQcojDQNm90Y6efH31m/aclP3ykSyxyciBCilq/QKucVknCfU7w+7zVYAnyBCV5hFDQ/QV4lEUwvE0/2XJrkW+jqZf3fFluXhWg5Hzxj6OB5lt4B7H6gUmyD9yJiiJK56hQZAsK8XZ1bCh5ht9egoNFfhHNzKQZdz5Z7iihxLmTqhqVDkuAlS1NrSGbw3MVmOurs8DQQwkx6sS9tNXHVBpH7a2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3eqTs5hcL57MwXtdZf9Bn5hgb4AIxLs8NtJy7oIKfE=;
 b=y8ffkDWIFXXhUI1sR6QivZ9E7bxwcOciOSV9BL01JIfX3qFsnNi9CZ+VKSJI1tlIDha7i2JW8jpgr/H0I4YItgWmrWfhIrEDw/zc8GtIfXr0bNSM+T0GSK8Gg3Dsup4EpFf+U7gVL4/P5JDSvhezFNM6zogpLGmBtTg1KOjD3dgK7zj+agHqItu6L1tQmstB5lM7codf7uDDen9bBSRu1Hy6IyqM28YIYJl2+f76/E3SZbk/YnqqXsP5RdzSQ6pXX/Lzymf0k44D7WwS6XFQR9Kw2F4f7NsnXz0vNDToW2T+1uzuv6kK/zTJ1B6UwZAoGnQ6Z+Vq9Of7FtdS6ZDMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3eqTs5hcL57MwXtdZf9Bn5hgb4AIxLs8NtJy7oIKfE=;
 b=1mxrknL8Z9p/ERv/YzncgesTKb95yylnTpVn9Gd/BUyWLYU3VzXL6rw7Mly/92jB97GY7fZqFIa3me1EiPgx9FHEN/sY7RXwt/K8/f2X1AgSUl3bG9h1C82qjvf2goUyhvRrFDuJhjBYua8l4XTDLh2l+4isXLqglagTJ+dHu0A=
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:11:39 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::13) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Tue,
 18 Feb 2025 11:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:11:38 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:11:30 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <x86@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, "Christoph
 Hellwig" <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>, Michael Roth
	<michael.roth@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
	<joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Steve Sistare <steven.sistare@oracle.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Dionna Glaze
	<dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Zhi Wang
	<zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>, Alexey Kardashevskiy <aik@amd.com>
Subject: [RFC PATCH v2 03/22] PCI/IDE: Init IDs on all IDE streams beforehand
Date: Tue, 18 Feb 2025 22:09:50 +1100
Message-ID: <20250218111017.491719-4-aik@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218111017.491719-1-aik@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 318a83ba-b4d2-4c9d-81b3-08dd500d03de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DECNRsKf+vt9Z6fG7iY/R4mBhR9Krl/kqZukcwJYNTUSxvqQQvXImcanCObO?=
 =?us-ascii?Q?+YZtTfzEW43AUMn5Ohesy17U3qaTgsRuE4UO/7Xkk/WySxXvjICG2E+RUMsE?=
 =?us-ascii?Q?WQ9aVOh3N2doAON3rmOmM6j8ZCbhe/VLh/tCzRD9CU0RODlr8/JtsbbeV9L7?=
 =?us-ascii?Q?bBp1Vx5tGX/iTdR3PUAv5dd4O19E0k+xaGBh5LMd9wAydrXDWfxm1BHwiifA?=
 =?us-ascii?Q?73ajW60qICnF4fJWgY0fpRuFI+FI4A4HZ7qeWTtLtm4vJE0Td6Oi6LSqu1pq?=
 =?us-ascii?Q?h/2lTf74j3tScIZ1NW1di7TwDuo/NW9TDlzCX2kzgBN2i/OpT8yQPuadCOjP?=
 =?us-ascii?Q?bPZaqfuvxmLY9dlrYh5qB/85w+dr8USevYqpjIDp6NYmRiGt8g4YP/q3YGZ5?=
 =?us-ascii?Q?CRNAKM+99vvlWOqoKdafsNWJJWayuSBnTJfaBn/KqNwNhEr5jTSY46uuxusD?=
 =?us-ascii?Q?38QQoG0bhRluI3gs573+sEQKs9xoSik83Z1drg5cueLvYgLK4raP12sOCyub?=
 =?us-ascii?Q?FC1FRTCmsZ6c7Zc2VUcWl4EFiXJ7W2gAEO5hcWD8l02YnuW2Ffqzzy6e3E8e?=
 =?us-ascii?Q?9+ztxLo95rKK8ybeCoVzFN5DkQuoexkDBgVyEQ32u+F1nWcU5v7Ci4r0Pfp9?=
 =?us-ascii?Q?wrgw1A9cHRaZQ2syfCXsUKj3dSjju0yg593M/zY6v78IJWaBDQwKc2xtstsX?=
 =?us-ascii?Q?THl8LKLRWzgR5iIriPyrjl2V8gaDuw3zWUYszSgnnUdvalhNdbjZVo8/+zBr?=
 =?us-ascii?Q?nSE6cD+T3B+sxlns58KuAO1Pp6TpKMfNoPoYj1jqxneQmVx6BfZPAiCL1P7u?=
 =?us-ascii?Q?VKyV5xjq6ewL0XMdP3t/AiWF5em1qFrCj3dQiyKOcBrkgFJxvRewb9+8Ma4g?=
 =?us-ascii?Q?cW7r6SBbIDf5GwiOw2B0+46idXSpC+ftbTzmFBCEXSPaQboKun2+UMJtbN99?=
 =?us-ascii?Q?pM8AeaC1pEOGstIfYCwtF61JRJOp2IP7YNAPpisajxm32T+5WtWp9UZkGGgt?=
 =?us-ascii?Q?sjU6Q4PDRthKocnjcXxl/s+yGgDcqQTImFkyMOAY66ZCf3lPGr8kMrr1K78w?=
 =?us-ascii?Q?ulc0U6IxOqUvKOz78Ep2frlInsuD9zSLZLZANFMmlbhdm3CwtW/qav4oBj2I?=
 =?us-ascii?Q?oDoBZpdgxYfHQfXEc4DlgYf+cf/yd57MPGuWBeCaTdjIHsjYz9zaYDT9noXW?=
 =?us-ascii?Q?0RiMTxWO7EULBldrtU+PvX0VYGidwt2eMHpFLJmoArS6+4JWxPWmw8+5vXX9?=
 =?us-ascii?Q?fJRyz1tx+3WUPXy9d1OJ/+3kGUP9LW6caFgnohclJbo3hZnkPFZkmi9tpjHI?=
 =?us-ascii?Q?nTD6XsqVmB4esasO6DacRzSh/JexRqN3rrCGZR5p3cBXZ+U1ly0Zv5r2dXT/?=
 =?us-ascii?Q?MkjVtho/Kef8fujK2zPSE0sgtSxbMH7zupabwQWrToNJg6ObnM69oULzF/Xf?=
 =?us-ascii?Q?3KkOHlvKZYi+1PdlcKhY5GaK99Wlt3IbZBzIuPEGTGmW9XrGOX4dASFxzW5W?=
 =?us-ascii?Q?8o21QVs5Bf/hJRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:11:38.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318a83ba-b4d2-4c9d-81b3-08dd500d03de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

The PCIe spec defines two types of streams - selective and link.
Each stream has an ID from the same bucket so a stream ID does not
tell the type.
The spec defines an "enable" bit for every stream and required
stream IDs to be unique among all enabled stream but there is no such
requirement for disabled streams.

However, when IDE_KM is programming keys, an IDE-capable device needs
to know the type of stream being programmed to write it directly to
the hardware as keys are relatively large, possibly many of them and
devices often struggle with keeping around rather big data not being
used.

Walk through all streams on a device and initialize the IDs to some
unique number, both link and selective.

Probably should be a quirk if it turns out not to be a common issue.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/pci/ide.c | 29 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 3c53b27f8447..5f1d5385d3a8 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -18,7 +18,7 @@ static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
 void pci_ide_init(struct pci_dev *pdev)
 {
 	u16 ide_cap, sel_ide_cap;
-	int nr_ide_mem = 0;
+	int nr_ide_mem = 0, i, link_num, sel_num, offset;
 	u32 val = 0;
 
 	if (!pci_is_pcie(pdev))
@@ -33,6 +33,7 @@ void pci_ide_init(struct pci_dev *pdev)
 	 * require consistent number of address association blocks
 	 */
 	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
+
 	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
 		return;
 
@@ -43,6 +44,9 @@ void pci_ide_init(struct pci_dev *pdev)
 			return;
 	}
 
+	link_num = PCI_IDE_CAP_LINK_TC_NUM(val) + 1;
+	sel_num = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1;
+
 	if (val & PCI_IDE_CAP_LINK)
 		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
 			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
@@ -50,12 +54,13 @@ void pci_ide_init(struct pci_dev *pdev)
 	else
 		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
 
-	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1; i++) {
+	for (i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1; i++) {
 		if (i == 0) {
+			offset = 0;
 			pci_read_config_dword(pdev, sel_ide_cap, &val);
 			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val) + 1;
 		} else {
-			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
+			offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
 
 			pci_read_config_dword(pdev, offset, &val);
 
@@ -68,6 +73,24 @@ void pci_ide_init(struct pci_dev *pdev)
 				return;
 			}
 		}
+
+		/* Some devices insist on streamid to be unique even for not enabled streams */
+		val &= ~PCI_IDE_SEL_CTL_ID_MASK;
+		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, i);
+		pci_write_config_dword(pdev, offset + PCI_IDE_SEL_CTL, val);
+	}
+
+	if (val & PCI_IDE_CAP_LINK) {
+		/* Some devices insist on streamid to be unique even for not enabled streams */
+		for (i = 0; i < link_num; ++i) {
+			offset = ide_cap + PCI_IDE_LINK_STREAM + i * PCI_IDE_LINK_BLOCK_SIZE;
+
+			pci_read_config_dword(pdev, offset, &val);
+			val &= ~PCI_IDE_LINK_CTL_ID_MASK;
+			val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID_MASK, i + sel_num);
+
+			pci_write_config_dword(pdev, offset, val);
+		}
 	}
 
 	pdev->ide_cap = ide_cap;
-- 
2.47.1


