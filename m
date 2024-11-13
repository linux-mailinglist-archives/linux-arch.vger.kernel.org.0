Return-Path: <linux-arch+bounces-9054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF29C6EAA
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353C3281FC2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BD2038DC;
	Wed, 13 Nov 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z8EHEV11"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B720408E;
	Wed, 13 Nov 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499452; cv=fail; b=QLezPGCP+vUst2PJyTyAcs0c+KsXC3Ba4tlTTDHIOslhD0YGfGTLkuFzqkJl7r3KpC0ZVO3iy1EUTAKHxclyGEBSQs8RcAutLxtFwBVqU5HRNtX9hl8pTrMwl7HTKJoJ1Ly7ydqB9mGQQiwOpoi+9aS92f8VtVTDP9MR0uOF8EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499452; c=relaxed/simple;
	bh=jpHJ2al8FOn0Z+Q1yy1S00HSe4XZce36Tt1fSG4E2bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTwduKBLnMbQstkSnv5UMRsq/EFXAbYdxr/03NICH6cIXyQvTRWKG9jdpRKL7VHD+CYYe3RZ+5ffL4MK3Pto//F5ClSxGVrlhKX+5USvCtTViQiX1IsL9vRjPCUrpBceq5i0+FUy2KVxNsF4+lH6XEJrTo+GH2dcsbiqC+jYL1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z8EHEV11; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMcGT+9E/3j+XZC8vRUhGOP+2z7Xva7QZYxUP04DYbe42mVl8UHv7hH9KOgQDULgUo4cfeMIpi1x+A3/uCV5NGwHMuRgS1TMkR/jucJRajQji9D3UD28eTUXVLAaS5t2F0MGmAHb5btSVV7+mFZRro8WWO22ifiavBYPdY5XJPBjlMP0L6JFw9UrpzSabtsQpGedHPflfrt46iy6ebSEdFujf21h4pLdSeoUX9L60cw46IzJ88kyRTQID3nUlSAY3kWx2hWJxvGvsqft6k3ooW9pywcx27SIDC3UwhOA6/xqPyFA1JikLzb1NAn9c+G6yi7P3+QirzhbpbdOwSZTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=HkROfazoETsZYj019zLRZ0rkkkVb7BZIQPQwisrw9sF22vLuhLFZ0SS2DQC3IpFOclrHoznm4sdUKZOcNtqr+bOuR0gQVElBVsjxqVqlEx8iLiIioG1VL2keA7LgBS4uTBqYu4UF03oEVUZ+qfO4JI1PI650xIwH7jAviM9HanFfyzQlw++0xMiIDcH1MRUrNbgEEJ9iM2k4jSdo2R45PIhhiehELhjGzfHi6G1GT9vI6cPEgJgoCztm58sP3gD6KrzjmmjCo9XyaH4AWvFbmL9kOv+aVP2OUx8kbwKBFbGnmEcB2vuclCgRxRqHK2zZqlG4pk3QEeRja7UO383CxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=z8EHEV11CUJK21ZGKo0fWj37Bx8CVRsv+8+HRJ7gZcjA3G5lPoZb0xU12HSPodg2QW1Sp7mWn290cg2ZVLrJ4eMcqjRXJoeSbikA6YH6ASrw3KeX9l7XPIr15avBHxly8+huoYiUM+nlyeQnBH2YwnDZwehPfavShf1LcRMIiFo=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 12:04:05 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::90) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:00 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 04/10] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Wed, 13 Nov 2024 12:03:21 +0000
Message-ID: <20241113120327.5239-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 784a4d22-6267-43be-feff-08dd03db458a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZap2V79sJXTMHLWuq2/W6LwGrVd0oaz9bLSArSBhtrEtsUL5KDgiRokyBnF?=
 =?us-ascii?Q?CljJCa+Xr7Er7KoZY/QlgD75dp7NcHvUwpiaW9obr8Uy3d8awHmccLqlpiNN?=
 =?us-ascii?Q?6nZgWsnemEMwBM5rsTFpUx1pbDLVJ3+M6IBrVQNZmJAA1ohZOhYsGf1FUkDF?=
 =?us-ascii?Q?Ax7XwehkJK9mFixi0wdlvlt867Z+i9/R6F5v8FhO53uDW1CgUd2kA5TTphfV?=
 =?us-ascii?Q?OlIh2msahmsdkj1s8nqqKgbEsKM9FPqD7yeQ1C40BnZZWBS31wwVB2ZhI36n?=
 =?us-ascii?Q?ScjHQaeAhLzdM3ip7TRv/k+btLcbOhMzaFqSUO57+rT1aWf9aXnDsxFBy8nY?=
 =?us-ascii?Q?Tx5DXXiz/T0RTD4psWesX3KWfjrQRq8qj2A/F3WxgqBrsd+ry5i5oGlt5FBX?=
 =?us-ascii?Q?/MMkPr4thqyZiXHbwLFp5iAwr5BKtrwjolXnz4aD1zSdUX0lw9AbIEw0o1Kr?=
 =?us-ascii?Q?nooTjB0ynzQdc1aYB7sGeUe28KHCTeY7amUQPSYor4aJhgWvfVxJPI/3HoHZ?=
 =?us-ascii?Q?49cJiDbdcEllMhH6XBna7SnLOGt9CRkc6Mzyq5IAfDkWqCVmffZoN+MmD7v5?=
 =?us-ascii?Q?iCYjKD8ZL7xz1MbKypHCLKhHi0ftyeoJYeXZ3lJ+72JM2FmlCOTWN2easbBN?=
 =?us-ascii?Q?ktg0UUHqdQD3WJNJTUaywWEhSKxrp1GnQefh5MRmioDyRT2rx0PqPDWJ2Nc+?=
 =?us-ascii?Q?o+7mF3lixn6g7mhrSau+Ezf89TwdN6B6l/jWQ828bXqqiSKAUXbZWmfe3dFz?=
 =?us-ascii?Q?tCi0VVILmpCLlVyfkuvKuwMHEvIOG2Is8hanzR0XAniVQedFrPMBFb9bqZxe?=
 =?us-ascii?Q?eNKF4kw3U9qnim+RMFAKzeyLnNBik+YnuwQLt7+LlpARMoLfBe6BYniNl4qM?=
 =?us-ascii?Q?FFCgIaXRKEHAuklmNos3EIexeMO64wGJI7vVn+HimsVmj5L+oP1xgtCb/Q3e?=
 =?us-ascii?Q?BwS7tfrZE3cqQgXjSOynkusV4xSN7GaLtWHgfNGTiOUbQdGV+/qxtuEvb/xP?=
 =?us-ascii?Q?u9TD9CSiZhIbj6B0+nXi4zjIJ3xBYIvTsuWfxLAuxPzOS/ya70j6MMznChX2?=
 =?us-ascii?Q?fFthCtclPEcjUicd7PEGutLrnk/5rDbcI9obW3F26HGExFNks2P8dVDmlHxQ?=
 =?us-ascii?Q?G6kk5i744i8WuD+MkCcevjJcS/QBMkTvbTWoUHw1kkEmMus9WdptJl53U56g?=
 =?us-ascii?Q?TFwLgB1sFiGo30xy8a23rQehwIlYwek/i/BZBqUqPBgMHXGPtdDZ3CGqzJ7f?=
 =?us-ascii?Q?E0TMUDy/NWfVh7QMhc7ezQdsTgDxJcergGdta/eI5dxN8udCzTjqAlDLOR85?=
 =?us-ascii?Q?rB24xRFY3ozJr6DV9vmQuqaOIbT6grjV4vnJ2Q2uOckRrowgc7fsUIzsAGit?=
 =?us-ascii?Q?onlb1qOf5Qe1yqOizN5LKxwzelZaQTaOUndr8h9F9x6lJTCf9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:05.4218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784a4d22-6267-43be-feff-08dd03db458a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186

During early initialization, the driver parses IVRS IVHD block to get list
of downstream devices along with their DTE flags (i.e INITPass, EIntPass,
NMIPass, SysMgt, Lint0Pass, Lint1Pass). This information is currently
store in the device DTE, and needs to be preserved when clearing
and configuring each DTE, which makes it difficult to manage.

Introduce struct ivhd_dte_flags to store IVHD DTE settings for a device or
range of devices, which are stored in the amd_ivhd_dev_flags_list during
initial IVHD parsing.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  16 ++++
 drivers/iommu/amd/init.c            | 113 +++++++++++++++++++++-------
 2 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index af87b1d094c1..ae5f1e031722 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -220,6 +220,8 @@
 #define DEV_ENTRY_EX            0x67
 #define DEV_ENTRY_SYSMGT1       0x68
 #define DEV_ENTRY_SYSMGT2       0x69
+#define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
+
 #define DEV_ENTRY_IRQ_TBL_EN	0x80
 #define DEV_ENTRY_INIT_PASS     0xb8
 #define DEV_ENTRY_EINT_PASS     0xb9
@@ -516,6 +518,9 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
 	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
+#define for_each_ivhd_dte_flags(entry) \
+	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
+
 struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
@@ -884,6 +889,17 @@ struct dev_table_entry {
 	u64 data[4];
 };
 
+/*
+ * Structure to sture persistent DTE flags from IVHD
+ */
+struct ivhd_dte_flags {
+	struct list_head list;
+	u16 segid;
+	u16 devid_first;
+	u16 devid_last;
+	struct dev_table_entry dte;
+};
+
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c1607b29ebf4..015c9b045685 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -174,8 +174,8 @@ bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
-LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
-					   system */
+LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the system */
+LIST_HEAD(amd_ivhd_dev_flags_list);	/* list of all IVHD device entry settings */
 
 /* Number of IOMMUs present in the system */
 static int amd_iommus_present;
@@ -984,6 +984,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
+static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
+{
+	int i = (bit >> 6) & 0x03;
+	int _bit = bit & 0x3f;
+
+	dte->data[i] |= (1UL << _bit);
+}
+
 static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 				u16 devid, u8 bit)
 {
@@ -1136,6 +1144,19 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
+{
+	struct ivhd_dte_flags *e;
+
+	for_each_ivhd_dte_flags(e) {
+		if ((e->segid == segid) &&
+		    (e->devid_first == first) &&
+		    (e->devid_last == last))
+			return true;
+	}
+	return false;
+}
+
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
@@ -1151,27 +1172,66 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
  */
-static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
-					   u16 devid, u32 flags, u32 ext_flags)
+static void __init
+set_dev_entry_from_acpi_range(struct amd_iommu *iommu, u16 first, u16 last,
+			      u32 flags, u32 ext_flags)
 {
-	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
-	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
-	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
-	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
-	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
-	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
-	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
+	int i;
+	struct dev_table_entry dte = {};
+
+	/* Parse IVHD DTE setting flags and store information */
+	if (flags) {
+		struct ivhd_dte_flags *d;
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+		if (search_ivhd_dte_flags(iommu->pci_seg->id, first, last))
+			return;
 
-	amd_iommu_set_rlookup_table(iommu, devid);
+		d = kzalloc(sizeof(struct ivhd_dte_flags), GFP_KERNEL);
+		if (!d)
+			return;
+
+		pr_debug("%s: devid range %#x:%#x\n", __func__, first, last);
+
+		if (flags & ACPI_DEVFLAG_INITPASS)
+			set_dte_bit(&dte, DEV_ENTRY_INIT_PASS);
+		if (flags & ACPI_DEVFLAG_EXTINT)
+			set_dte_bit(&dte, DEV_ENTRY_EINT_PASS);
+		if (flags & ACPI_DEVFLAG_NMI)
+			set_dte_bit(&dte, DEV_ENTRY_NMI_PASS);
+		if (flags & ACPI_DEVFLAG_SYSMGT1)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT1);
+		if (flags & ACPI_DEVFLAG_SYSMGT2)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT2);
+		if (flags & ACPI_DEVFLAG_LINT0)
+			set_dte_bit(&dte, DEV_ENTRY_LINT0_PASS);
+		if (flags & ACPI_DEVFLAG_LINT1)
+			set_dte_bit(&dte, DEV_ENTRY_LINT1_PASS);
+
+		/* Apply erratum 63, which needs info in initial_dte */
+		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, dte.data[1]) == 0x1)
+			dte.data[0] |= DTE_FLAG_IW;
+
+		memcpy(&d->dte, &dte, sizeof(dte));
+		d->segid = iommu->pci_seg->id;
+		d->devid_first = first;
+		d->devid_last = last;
+		list_add_tail(&d->list, &amd_ivhd_dev_flags_list);
+	}
+
+	for (i = first; i <= last; i++)  {
+		if (flags) {
+			struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+			memcpy(&dev_table[i], &dte, sizeof(dte));
+		}
+		amd_iommu_set_rlookup_table(iommu, i);
+	}
+}
+
+static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
+					   u16 devid, u32 flags, u32 ext_flags)
+{
+	set_dev_entry_from_acpi_range(iommu, devid, devid, flags, ext_flags);
 }
 
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
@@ -1332,9 +1392,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALL:
 
 			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
-
-			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
-				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
+			set_dev_entry_from_acpi_range(iommu, 0, pci_seg->last_bdf, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
@@ -1428,14 +1486,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			devid = e->devid;
 			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
-				if (alias) {
+				if (alias)
 					pci_seg->alias_table[dev_i] = devid_to;
-					set_dev_entry_from_acpi(iommu,
-						devid_to, flags, ext_flags);
-				}
-				set_dev_entry_from_acpi(iommu, dev_i,
-							flags, ext_flags);
 			}
+			set_dev_entry_from_acpi_range(iommu, devid_start, devid, flags, ext_flags);
+			set_dev_entry_from_acpi(iommu, devid_to, flags, ext_flags);
 			break;
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
-- 
2.34.1


