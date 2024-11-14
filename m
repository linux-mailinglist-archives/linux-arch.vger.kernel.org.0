Return-Path: <linux-arch+bounces-9092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2909C928E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9651F2251D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0221AB526;
	Thu, 14 Nov 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jdhT+MI+"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8661AB500;
	Thu, 14 Nov 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613517; cv=fail; b=ZfJDB6tqAilJ0PFvECwmTNEQRaJSN1zszklO858p8vhTmyCTB/rz0r8YqqIabeJ69asN6e0Wh31CM1pw4sHGJB87b329ON4UsATSBEkhPj5EH5eWlZeC27NR9FphNTe1jryFAWdZmbWgIxc7G2z+axB6YUv18RfMzeUNH1N7HdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613517; c=relaxed/simple;
	bh=jpHJ2al8FOn0Z+Q1yy1S00HSe4XZce36Tt1fSG4E2bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9DgGEbIACyBVZ51JxxeEDUFcAh03qc4MrM16OohEt7e8S53zch9JvmXsNE1qvrmKygdPPKq+exDRJ/gt0OtWQrNjQj6P2JJzAF1nwhnk2CPwtHSzrIeW914PBhgFAv3EpQLbsvuZhM8iQ8sSica7zSwcbpLTta65JgvPRFsvZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jdhT+MI+; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsdcpuqbPQTRiWyRrT14n7rtYTgeR9sUcWP3MPK/aBbr3dPvPifFbI3hstxZ1f8/V/2ABUF6sBnSu99HdVQUlAERx6L6jTxBTdshS7A/38mr9JvPf8CG+G4ck7fky6bLhNwH0bG6ECsrkLIRWGYYQQ0dcZ2cyDN082JFwqAFzWeGlxOV44P0K9qhylGjuJDMxFGcGSzvVeTw9LD6IRtAY/Kl9mE+GOBiHmejL9ZW6R+fEjutqK5mLNKdE7eT5aK81Gp0mqZD8BKpcglW563TfCxRTByyNFlOm05FCkgSAx/YXf/e2AFBdN/HtiR+PO3nRC23UBAOQUafQCfE4YnHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=AKtzdaMR9oXgXTNde8pVpFN086f2n6nFKrjMaJEWFe7aJ0V3i82hDFiFbvqZuY7YvZAfNgsMYY653aF/Q3fadspVEEvslqH3HAx57r5scCeyonCAyLosN7fQJfzWGi3osHIi8Rvcs3+7R50YduN2EEeFeAJECOmpQ7klF0S4LirGLvkaRgQmfJ7B+E+w8FkOC5COOMgLIF/iCwUiYzpyOoVakYtfAYOxzeSnDoPkfMKBPoGtZg5SNQ/l04HQSmrw54YqSPMwtDNFjBtW1rjYHlCaevH/dm8Jm0rr38CPD4FmYZeW8G4NDxI8nyV5zsGVS6kRQ4ZApPwk+jA2ntXjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=jdhT+MI+pz8BkOSWb8g80U0nb0+mlsSQQooL4nzEK8etfKFjHifpM7tUU2L4mcc/YWqYW4mXBRLez1xm00qZExY7zJ9nx13rdrhL9V3nTJ9ojBewgrLz0HvrdYktSyK6S3bnvaE9214G432KXp6WjUeRuu6Yu0Wrl+pacftFnRw=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 19:45:11 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::f0) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:11 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:06 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 3/9] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Thu, 14 Nov 2024 19:44:30 +0000
Message-ID: <20241114194436.389961-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a870175-7f90-4926-0c56-08dd04e4d9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EThVgURXrk77osCc6m6WYzoJiJCwq23VzmAwXb4mLfGJfw/mUEyVdn1UWUDR?=
 =?us-ascii?Q?2BgaCNUkalNpMvtW+g454FXMw3jexs5F/jmfms4SsNLccGsjf/pPMuI5uvn4?=
 =?us-ascii?Q?kE6r6li+O7eqwkGTx/8qkGSWiFKhOybH5xJ07S+3pqBxH2yRHMS7BQaWcgdn?=
 =?us-ascii?Q?O7By48njuaCFXaNrsXoIvPZ51WaAw1G24JoK8B78qgkEd1L+Z0jPZxLo9n4S?=
 =?us-ascii?Q?Ctj/s2RS5V/W8+pCZsV7/ZbXfZc+ixYdVKskRiNo2P9ewifPU6qVxGbtOYzK?=
 =?us-ascii?Q?gcTiDIAeHfrjtCph3zxV6SSuXFSeNLhRwROHccs8ECrzvW/qwFYjGat1pkh7?=
 =?us-ascii?Q?8QKjxHoaXX0lEyOWC64aJxAo3uMmqX2R6FEbTQwc2HidTa+uqAM3eLnb1bCm?=
 =?us-ascii?Q?xFcSuYRSB8MFYpQDaDSARO8XZUWmraktzZGiJRC90EDwhE9FST5j1xJ8B0Gw?=
 =?us-ascii?Q?fmbINYlexGxJXhPDsSw8Yd0rYDievqR6UpkqCDBRxYlI6bFfwHFm1KAtCWDV?=
 =?us-ascii?Q?6qr3pWu8tYiem2Q1U2YBCIBNqzTGXiDXr0u6RrKJ54ViympG4SlKi+TnZd8f?=
 =?us-ascii?Q?TEIGq1bULKwGBUDFvYFgi3o/itgvnHbhFlZMegzbidvI/rA9ErwzYdnrb1R/?=
 =?us-ascii?Q?DNGZ9j4K6E9txzF6ZgB0yKFtDF0uQ1aZah9ldhXZGP4bbBc7mg6KeAihwZpU?=
 =?us-ascii?Q?9e2UIqfb/qbj/kpbsWhugMSUq9io/s05gXFvB0m9xxbJYDVc0XUk1GoRMW8N?=
 =?us-ascii?Q?TirQ3sx2XEqS4OFKHZWkFyUARwgLwtmnv6UpZyyJVvtpPwB3Yp5+f9QPWdIT?=
 =?us-ascii?Q?jenxC3qhjkGnbuNZbdh3CBqbf3CmYBvejCHBAAbv8eKcJbkm0zGERemP5et/?=
 =?us-ascii?Q?MzjJy6vPMrYmmZXnkjs4RfclVpfZ77L7yCTUqLGt13YMWVRO3okO1tFvGihp?=
 =?us-ascii?Q?rkGopSijZIJJqnCzeUyWpZPC6CD+1EdpwjnheMwu0ELe4GsPo9jiyhgcBFMQ?=
 =?us-ascii?Q?BMp7XQVsfas6Cd//nrZZ37uNfSMetA9+/kRGaBtIVrj4Yy7J9g5kDgcFpyDh?=
 =?us-ascii?Q?+Ck3b5yjYDVTLn2vjv/rf/ajSO0pz9JjURjpolaDho5AWc1juEkWc25ysMyQ?=
 =?us-ascii?Q?mgwqtO2oGQlh+k75p/laZAPebGCdiNPZOaQCjTmYbKc6ZffKwPmuZmwxT4Tm?=
 =?us-ascii?Q?kwYPSnrQ+5Mwy880Cv3mVafnuRVJi2WkY8QCRyoyD7paANAqn0Ukb19XhjWW?=
 =?us-ascii?Q?Z64LrArEDO9wC+g6+TJFQ1COPD4mBxxiMGanJ9UJmhPVcBn6Lp0SOgmRxRqq?=
 =?us-ascii?Q?Bqoht4GfMbWDHXr/tkfkPswtHi9EtjffBcaLOsfNpRLTGOxSluYPOLvpU2tt?=
 =?us-ascii?Q?dF3g5hiA6WQSWj6Zp19ujCrSN8LPX8z6y0FBJ2GYKRVgarp6RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:11.1467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a870175-7f90-4926-0c56-08dd04e4d9f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237

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


