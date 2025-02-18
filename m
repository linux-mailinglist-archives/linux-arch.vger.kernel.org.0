Return-Path: <linux-arch+bounces-10176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04622A39A0C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301FD3B4A9E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2F23BF88;
	Tue, 18 Feb 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vChfCxfP"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2723AE96;
	Tue, 18 Feb 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877092; cv=fail; b=XncQfBVR05LbDhPrkcbt5Dx5OShEU8ERKpoejUSTa9/+vBb+ODLtSlSSKocWn62AmddlqgIoub5xBxu++5tr6JtjUuakcGzTJb4bbokEHwoooqlblPKQWve4SNllDd33Tsa7ymZjUvys6b4IeEWzYAbP+pDh128H9BUkkIby/kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877092; c=relaxed/simple;
	bh=X6rWdojPBRf5bzaPZ7/XEH//QoDvr0q9qqJwElpLpAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVnI7N868s3Rqs75hTGuNbpBqbjRoFqYJNc1UGMkig/9GC3Sg4DZ3Hpjyf5KLBV8PWftPzy6sHNFrPCwQ4MJQJknN+4UdhvMQB4Q222GKYX461kSnZYbTs+IMmstDsxdPBZT+bRG2zA/CTb1+qn1MvdakXTGuQz+vmHfW13CK6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vChfCxfP; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggMwBt4s9uSTc/LzgR5RqgIVxVgYiMjZ4CyVMqavDyGbTRnu4iDZ4gOgxdUFfhpcqyDxp/SboiIUv2YdHl6t49a3W/T3iItoriT4yY56Df5i+orswDYVS9xdsRMLaFoJgoetXNoq0X5JjXDKUr0Z3cVAaLrirlt/sLoxKJJJdGOspPaM3dBJ8W6KzwNVcgyEqj008oGJq6UUREZTe1myxTWJhSi6wm+IlccJZ8Xi7xJeSWFRBd4Znj9/Rq65vaFuRgrgTdutXKO+ycN3nk88d4TguClfWQ7TTdlTss/ung01iDe3OGoSUYvZPeRM59AmsHfH+JVyiaU1pD0ZvUbaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drMSr2NXcFgUCXNzn7sZBFn+PyFNxpFIonxBmsdVHqQ=;
 b=ioDOp5QhBjssU6P2VabKdhSTwwr0RHkkAxa5n54j/sMEJsn6oPNBZXl1RvLwzObeM+UWdZqa6qBPgYQBUrWefopRrIRqZWkKz8+CRjuSBu/SNhW9S4QYfQmUzE0LepPcFI2YPnYVC6dVNnoqvbDkTRjIlYgEhWBKETNGVXThXQMtf4bBAAc8xEUGBEWBSmxKICmjDRnkyc8vvd2xENfjUOqV4wbOTybDQmdybD2DhU/odRc2rtTFj8VNRR9B/M4IBehuimEJgrTBua9y81Pzb6eVnBhkFSIN/uvk/6A7XGFRmt9x5JfwdCLDVUzcBS/uXNK7xjADYBOfzaLm1p6RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drMSr2NXcFgUCXNzn7sZBFn+PyFNxpFIonxBmsdVHqQ=;
 b=vChfCxfPs9dbUsXPUQkcsCs+rhMUr3xrE8RMI4YKUN1+JvrzqyA15Q4kPLFIEu9ZKZbgX8Cw0u9P3fDM8G5KJ63m8+QNxZFxkf9Qh8ZyjMMjUT9Qx8TgCkkwyW8sDyPRU7Da4kmOFiFFXXza55/IS4MhKqslHuLCuwUn3qpxwQM=
Received: from BN9P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::16)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 11:11:20 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::b) by BN9P222CA0011.outlook.office365.com
 (2603:10b6:408:10c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:11:18 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:11:10 -0600
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
Subject: [RFC PATCH v2 02/22] PCI/IDE: Fixes to make it work on AMD SNP-SEV
Date: Tue, 18 Feb 2025 22:09:49 +1100
Message-ID: <20250218111017.491719-3-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: c77afa49-27fb-47d1-27a7-08dd500cf7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYz8Q7wpSnNrDA06/9J78ZVY8aO4FD99MnslBNCrpNLWuYCoi8kNaZDExjka?=
 =?us-ascii?Q?biaMQdz/0/P+3V2QdoCAj+Ttf/+m0Y0sBJbZzUp7z69x7U8GiY4UB6Qf1l2O?=
 =?us-ascii?Q?40E+nrxoCfixJRE6kDHvBLWgi0KRtOqs9BbhIQwr1VXxtY6x1uIS19o2FZ+7?=
 =?us-ascii?Q?Rjqndf8CASG9lsAS6ad0H4QImyN4a6SDkitkeNqemiFHIi006s/T3xVhNAnx?=
 =?us-ascii?Q?mD4bNc4jzmbq7QVrJOql247Z0qFc7u2GeFlNULp2Gnc2xExplct5306qlm95?=
 =?us-ascii?Q?IW7yn7pRPqHpYNo+7KsqrBEGmTY95YjtLixpnjtkxtCOmwyM2voI3Y0dVMeg?=
 =?us-ascii?Q?GSXOyWLWubTXBdOMWtD4GLGbM9T7Apvv64KQRYsfpKcQGSBoHACSlcvqI9J7?=
 =?us-ascii?Q?6xwzaAcAUxwhdFabR4Fq9SRkNLcmVCksou/F5Mr919Rup70Y1vn8awiYZnK/?=
 =?us-ascii?Q?duq4Eihbufyhua/hP0rZb5iHW89+lL0htj3KmsHgxwQ6RGzB4c2ZWBz8imk5?=
 =?us-ascii?Q?nVrwImdSEkCmreQn4WBDk+Gde9MEYhI7erPkjK5NyPrPqVVO48/H24BVD+Na?=
 =?us-ascii?Q?u1GthnYuipnl5AiBglKaHol8v0z6awonsxzyc7dMS+3gcqQ4sROuVFQLFJGm?=
 =?us-ascii?Q?PmxwijifBHGflf6FmADm0BxZ4RU+4cVoePKbyHf8lKovzgGNaROHGDVtoe90?=
 =?us-ascii?Q?2MS2sp9Iqd2bo9oghMlQrrL1wDh4qr14wbAACXCQLXU0Xv4bgp7EZvu2UuEc?=
 =?us-ascii?Q?1Ys/rwJ+JotWIlWSaxWVObc6y4Ixm5d9oJQGjCPdlGrmu41DhI8tOFt64k/e?=
 =?us-ascii?Q?tRYYOdFbTmBmIXkbBVtTlgwfn+fvIBBiYm2UFszPMEzntAfDaisZ/mZ12l3H?=
 =?us-ascii?Q?4FnA5NZ/o6PHq57KCYAwRr7LbgZSnmkU9ljicsZPQzSZqHpLg/Yy0wozMnTY?=
 =?us-ascii?Q?C4v1q118UaO9RRu97qm9OEdmVGuw6aVKj4BfmSlLTlXe/haQbSy6ggBe0EmJ?=
 =?us-ascii?Q?GU3gKpBdV+XQf1ME9b43ftttRhuh6qdpjwrEcowF8dtDXQjgdGgAWXz5mTNO?=
 =?us-ascii?Q?jZ4SZcb43FDoYMUZqyZr+JtFhvvZXXBZY6+JarEVvEHPnd+m+e+rQen2Yaga?=
 =?us-ascii?Q?+yiywIc/jMLN1N12gJ2duYx74008RFRWRbKTjTay9xN68hR/ZfXVkIF4mEav?=
 =?us-ascii?Q?MNBEFlFIqpwcaVd+NQ9/pv3wfkGocOLketW8Uro8tak6skfG9jm+lmhs1HCI?=
 =?us-ascii?Q?RmBExR1MIalEx+c1ab1i7FEcNdyD6+UQfWaeWL1JEnjMcSal1JQUNKXDe9aQ?=
 =?us-ascii?Q?I5X2QufUNa5F9g8YEr8n3prevlUdMoiVB4XYtJiCHVymGbWZP/DV2RTXrTsP?=
 =?us-ascii?Q?pyVAefR5br4iMKkjoRAK73T5dpN5AxuNINJAWO2bIpJpOhDFo+iy/kprQCax?=
 =?us-ascii?Q?jgU+WMU4CctUwa9UPwtqVJxtHtZewyKGkeZnR7wBEhfwulY7TyqtBShwYI9X?=
 =?us-ascii?Q?WBwpa0ic0lpIDCY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:sk;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:11:18.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77afa49-27fb-47d1-27a7-08dd500cf7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

The IDE proposed patches do setup of endpoints while they should focus
on root port.

These are workarounds better be discussed in
"[PATCH 00/11] PCI/TSM: Core infrastructure for PCI device security
(TDISP)"

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/pci-ide.h       | 19 +++--
 include/uapi/linux/pci_regs.h |  4 +-
 drivers/pci/ide.c             | 76 ++++++++++++++++----
 3 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 24e08a413645..f784fb16cc88 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -8,26 +8,33 @@
 
 #include <linux/range.h>
 
+enum pci_ide_flags {
+	PCI_IDE_SETUP_ROOT_PORT = BIT(0),
+	PCI_IDE_SETUP_ROOT_PORT_MEM = BIT(1),
+};
+
 struct pci_ide {
 	int domain;
 	u16 devid_start;
 	u16 devid_end;
+	u16 rpid_start;
+	u16 rpid_end;
 	int stream_id;
 	const char *name;
 	int nr_mem;
 	struct range mem[16];
+	unsigned int dev_sel_ctl;
+	unsigned int rootport_sel_ctl;
+	enum pci_ide_flags flags;
 };
 
 void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide);
 
-enum pci_ide_flags {
-	PCI_IDE_SETUP_ROOT_PORT = BIT(0),
-};
-
 int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
 			 enum pci_ide_flags flags);
-void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
-			     enum pci_ide_flags flags);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
 void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide);
 void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide);
+int pci_ide_stream_state(struct pci_dev *pdev, struct pci_ide *ide, u32 *status, u32 *rpstatus);
+
 #endif /* __PCI_IDE_H__ */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 498c6b298186..15bd8e2b3cf5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1293,9 +1293,9 @@
 /* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
 #define  PCI_IDE_SEL_ADDR_1(x)			(20 + (x) * 12)
 #define   PCI_IDE_SEL_ADDR_1_VALID		0x1
-#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK	0x000fff0
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK	0x000fff00
 #define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT	20
-#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK 	0xfff0000
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK	0xfff00000
 #define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT	20
 /* IDE Address Association Register 2 is "Memory Limit Upper" */
 /* IDE Address Association Register 3 is "Memory Base Upper" */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 500b63e149cf..3c53b27f8447 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -50,10 +50,10 @@ void pci_ide_init(struct pci_dev *pdev)
 	else
 		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
 
-	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
+	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1; i++) {
 		if (i == 0) {
 			pci_read_config_dword(pdev, sel_ide_cap, &val);
-			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
+			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val) + 1;
 		} else {
 			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
 
@@ -118,7 +118,7 @@ void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
 	hb->nr_ide_streams = nr;
 	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
 }
-EXPORT_SYMBOL_NS_GPL(pci_set_nr_ide_streams, PCI_IDE);
+EXPORT_SYMBOL_NS_GPL(pci_set_nr_ide_streams, "PCI_IDE");
 
 void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
 {
@@ -148,6 +148,10 @@ void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
 	else
 		ide->devid_end = ide->devid_start;
 
+	/* Enable everything into the rootport by default */
+	ide->rpid_start = 0;
+	ide->rpid_end = 0xffff;
+
 	/* TODO: address association probing... */
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_probe);
@@ -160,7 +164,7 @@ static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 			     pdev->nr_ide_mem);
 
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
-	for (int i = ide->nr_mem - 1; i >= 0; i--) {
+	for (int i = min(ide->nr_mem, pdev->nr_ide_mem) - 1; i >= 0; i--) {
 		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
 		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
 		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
@@ -169,7 +173,7 @@ static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
         pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
 }
 
-static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
+static int __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide, bool mem, bool rp)
 {
 	int pos;
 	u32 val;
@@ -177,14 +181,20 @@ static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
 			     pdev->nr_ide_mem);
 
-	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, rp ? ide->rpid_end : ide->devid_end);
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
 
 	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, rp ? ide->rpid_start : ide->devid_start) |
 	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
 
+	if (!mem)
+		return 0;
+
+	if (ide->nr_mem > pdev->nr_ide_mem)
+		return -EINVAL;
+
 	for (int i = 0; i < ide->nr_mem; i++) {
 		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
 		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
@@ -201,6 +211,8 @@ static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 		val = upper_32_bits(ide->mem[i].start);
 		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
 	}
+
+	return 0;
 }
 
 /*
@@ -248,10 +260,14 @@ int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
 			goto err;
 		}
 
-	__pci_ide_stream_setup(pdev, ide);
-	if (flags & PCI_IDE_SETUP_ROOT_PORT)
-		__pci_ide_stream_setup(rp, ide);
+	rc = __pci_ide_stream_setup(pdev, ide, true, false);
+	if (!rc && (flags & PCI_IDE_SETUP_ROOT_PORT))
+		rc = __pci_ide_stream_setup(rp, ide, !!(flags & PCI_IDE_SETUP_ROOT_PORT_MEM), true);
+
+	if (rc)
+		goto err;
 
+	ide->flags = flags;
 	return 0;
 err:
 	for (; mem >= 0; mem--)
@@ -268,6 +284,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
 
 void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
 {
+	struct pci_dev *rp = pcie_find_root_port(pdev);
 	int pos;
 	u32 val;
 
@@ -276,14 +293,27 @@ void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
 
 	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
 	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);
+	val |= FIELD_PREP(PCI_IDE_SEL_CTL_EN, 1);
+	/* there is rootport and pdev is not it */
+	if (rp && rp != pdev)
+		val |= ide->dev_sel_ctl;
+	else
+		val |= ide->rootport_sel_ctl;
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+
+	if (ide->flags & PCI_IDE_SETUP_ROOT_PORT && rp && rp != pdev)
+		pci_ide_enable_stream(rp, ide);
 }
 EXPORT_SYMBOL_GPL(pci_ide_enable_stream);
 
 void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
 {
+	struct pci_dev *rp = pcie_find_root_port(pdev);
 	int pos;
 
+	if (ide->flags & PCI_IDE_SETUP_ROOT_PORT && rp && rp != pdev)
+		pci_ide_disable_stream(rp, ide);
+
 	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
 			     pdev->nr_ide_mem);
 
@@ -291,14 +321,13 @@ void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(pci_ide_disable_stream);
 
-void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
-			     enum pci_ide_flags flags)
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
 	struct pci_dev *rp = pcie_find_root_port(pdev);
 
 	__pci_ide_stream_teardown(pdev, ide);
-	if (flags & PCI_IDE_SETUP_ROOT_PORT)
+	if (ide->flags & PCI_IDE_SETUP_ROOT_PORT)
 		__pci_ide_stream_teardown(rp, ide);
 
 	for (int i = ide->nr_mem - 1; i >= 0; i--)
@@ -309,3 +338,24 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
 	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
+
+static int __pci_ide_stream_state(struct pci_dev *pdev, struct pci_ide *ide, u32 *status)
+{
+	int pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
+				 pdev->nr_ide_mem);
+
+	return pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, status);
+}
+
+int pci_ide_stream_state(struct pci_dev *pdev, struct pci_ide *ide, u32 *status, u32 *rpstatus)
+{
+	int ret = __pci_ide_stream_state(pdev, ide, status);
+
+	if (!ret && ide->flags & PCI_IDE_SETUP_ROOT_PORT) {
+		struct pci_dev *rp = pcie_find_root_port(pdev);
+
+		ret = __pci_ide_stream_state(rp, ide, rpstatus);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_state);
-- 
2.47.1


