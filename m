Return-Path: <linux-arch+bounces-9128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9059D0916
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BED0281F85
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC901474CF;
	Mon, 18 Nov 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lmc3NMdh"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4951465A5;
	Mon, 18 Nov 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909021; cv=fail; b=lF27y7VP8wB8w1PYKp50HWJCStgTlkCfXGFfT4sRl5HAeJfiRTTTfc1COnL4IZqeSlolEYmUsU9qRz3EDjUDxTFQSg/cPn/YSmkxnhozQ0y1fXRqHOEga2Cw4Z/sbTPrXuBVYFuE8WlbDx/xfGCM+SeymH9P7oQMyINy9QedGdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909021; c=relaxed/simple;
	bh=jpHJ2al8FOn0Z+Q1yy1S00HSe4XZce36Tt1fSG4E2bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDZg6CcJbXqWh5K/3OxzegJ6YzvU9NpM1lQOjVt6dVqCaX9Ig7hu+6ExFOqdfFmfzR9QcpKQLJ5sjOzdyyJnz0s0oHPkhl9wDB7BauX3z0XGiymZ4Pi/2dMnVfEoV6E1OfNCtLcZNkHDZQN4PPKJWpHpLXRALK2brOANh6qFELk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lmc3NMdh; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpxaf5Ul2mxIXuVJFL7OTPkrJ4sNbnim9xAZilctL5jJgB7ThUH+7Mi5yJBi8LTRK4/juraepQzOahupiQp9078hb/D5/6ou7bA+ZmR6AqiDpsuxxcPQ+fHuAkUvP2d0W0+Bj3beDYR6pUy6Qzg3IKQRVvRRoCAoG0bE2hp1rBxcGxG+MadDsBvazFq8tGA/AJEe04cqfs+TyfClmIr01BgkejBFzwGOyxPJMhHPuKQlcJpIqCflVszs3XF57D1PKO9sMrwI0xoTun2zBLqPZpxgrImzxrgP2XY9rUCVA0X8i9eMrtGq9FYI+3VqOfekSgE3aTargRUUTA21KatFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=Y+oFGK/fDdyLwWQQo3xTvATSx3uoxmuCk4magh5y5btczdanJ3t2OoccFyJEC5fCeEhN+vQSLbIJF8ZZ4UYvQNC0/Kzi3X5Lpp2rywrdtZTjExPjqQj9+HoGaNcGz7d2oUeVpefsvg8eumhBr3m4Se7KiMwPeyqanLuvdxQjci5VHU42GfFxh9UKqQyvLFGAFHc1atJEPwvN8tuc7syXxcGv3pXinp9O7DECtXM/L3UdP4rA//m/xLE8B6zTgTDhbtwq3L9zCIcsb74AEuKx/TPCO979OjiNceGyT51GptwWON38+WUaueDZSwNMT1RO2jAbECvXvqDc5PMSqSaJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=Lmc3NMdhMKPM4dXmxQU04WSAAmyVUFWjFJMB782S3vi406qQDocBAW9h8za9mKbI2OYs9R4xuRR5Bwp/U9NDV5qN4m/NKh8PetOHWe6WIOXbuc+DnuHzSDGFXEK64+HRi7DeJd0be5/yCP9UG2qWAkz+A1Uy0KlRHoIwO3WHHZw=
Received: from DM6PR10CA0032.namprd10.prod.outlook.com (2603:10b6:5:60::45) by
 DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Mon, 18 Nov 2024 05:50:15 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::a5) by DM6PR10CA0032.outlook.office365.com
 (2603:10b6:5:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 05:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:50:15 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:10 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 3/9] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Mon, 18 Nov 2024 05:49:31 +0000
Message-ID: <20241118054937.5203-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 352a4a76-ea7d-44d9-3c52-08dd0794e046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOUCc61aM8XqDBUJdvt1i2NRB/bEyEVBkUWwXkTfkSsi2FewHKKKSzpxY3rP?=
 =?us-ascii?Q?71KAR33sE+TPk6cBhuwapniWDlI1TTW1zjE5Je7yvFLxm3Z8IvhqoN/HPuJD?=
 =?us-ascii?Q?wy8z1FSpasSnLDWsnVb/B7W42wyvj0NTmFFEjuR95qrYX5RcfRYSkaCgtKCF?=
 =?us-ascii?Q?5tEPg94yzFnnCcaTdxftq8J58vx87CDpWIXJzfuAdenNbAi/3TGcH1mydfWu?=
 =?us-ascii?Q?2bHLr4g9nymwYlp2LSCSCgHbTpWWAb26KXj99aX3Q1eBH1bcvk9SCJY44SK2?=
 =?us-ascii?Q?BP3SGw19zAFYajR83D4XmkVpXizA2DPVoHrhSYR4+QZY7mJ4YzamunCM7Kjw?=
 =?us-ascii?Q?C8QZ8vpQqk10HnCvzrb92ncByUb8AVU0UhBf0aP2w0LAG11pO257YadDk6SV?=
 =?us-ascii?Q?MTPUXczQK566FExM/ScFZLa9w76i4CRDD1Zzu7cTUs97QJXq5PfSDA8x8X/m?=
 =?us-ascii?Q?nXl9cTUnxGdqkTUTBCCFyPOu27hPPCJ0ICYKEjLPwVYA6ov5FsVPSeROr+NS?=
 =?us-ascii?Q?IaOxIrbmh0QO7Jhik6t/9A5jmZP4Y2uTuLTrlRjqU65YdVkwkkNmSu728Cha?=
 =?us-ascii?Q?j+JHPJbWZIdYxZxqe5n+7g92s2tVOP9BoEs/JNwZoE6mjftmPAA/x0E3E9C5?=
 =?us-ascii?Q?8neQCHGhd+VnQqxOqc1HIMeXCYGOUWUj5XqbIMPAcupK6Oagw0Jqtol5HRd2?=
 =?us-ascii?Q?NSpSXTSzVo3edRB4SBl8AHpI6wJWfol0YtYcR5M2+vozf3i+xxMQoFoeG/0+?=
 =?us-ascii?Q?FGlVbisDwAp8/KVfhieiv5UgxmExeuH0UAKqW9t95FfibE107juN/z4VqZGH?=
 =?us-ascii?Q?VpZ0Drtq31Fys8in2L4qgj2YGgIwvydrtljsJk8Hg0RyV1b1qES4RzWRd42G?=
 =?us-ascii?Q?4zO+fcVBO6cEhWmItomglU7HVTXY096xH9feOKqhSMFAW8L2BX4Hh5aq/iQW?=
 =?us-ascii?Q?ECFKqgFgiuOb7sGUMlpligN8rWCfI8uJtGtrma5yvHU5wfp5Zx0/XhbjOgT6?=
 =?us-ascii?Q?jgNFbL3gXJ5sfMsUtcK6TJ29FK9ZBpBSHGN8WbbTkxsCWuux4aPdXU6TzOEZ?=
 =?us-ascii?Q?z3h9FVqoXa2m+tF2Z1smMbzXOu5CoUHFS50u2uzEjxhZAQOCea1NXGtuTwWV?=
 =?us-ascii?Q?DCLryrvQhebKjqCTe34LO/bs5Be/+5bYE/QkN/x4QxB1OaSHrQXy+0Js60YK?=
 =?us-ascii?Q?98jOzQdzAGbfcCiZoVXnhVJmqtopDCjMOOnGt5lwVPh2pfDD4o1A2KAy7P9e?=
 =?us-ascii?Q?6TsXvxQGyKlScASq93VY6/HmYAQi5QMxz0DvPSZ2ukW/kTvG0PiYOE9Jg7aw?=
 =?us-ascii?Q?drEmyVwsnSWOplDiIr/PfQf9SoIYdqifPrDYQE0qhL/F/PWciWOdb4sz3AbG?=
 =?us-ascii?Q?l3pDZpX7k/k7bjzuXDWtGTO9deTdYEtEP22WPGUtUPmHV10a2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:50:15.4482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352a4a76-ea7d-44d9-3c52-08dd0794e046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

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


