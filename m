Return-Path: <linux-arch+bounces-9098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE49C929A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1521F22EC4
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9331AF0CE;
	Thu, 14 Nov 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PGDTKCju"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B31AF0B2;
	Thu, 14 Nov 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613542; cv=fail; b=DDDf6/D7WODmlrpuAu4DvdFs7c5wheUOycFxcz5gSn1ZGfG1QOWHZTNwE+LqWO5+yscPYHKjtsOFBQMiaasroC5w4riMDWQG/+n6Ao9Y2TDOzZOMJh63SncahPf042P4ExZ+EPwdPAHflxnH5Gz4DP8AhcEbbBLPZG4JKkY70es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613542; c=relaxed/simple;
	bh=pD3CmY8Vf1E5rTziOoui/AnVhcJWQmAJJ32cDLUAJww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNrdLnhw/2ay5vTYZOP0G1U1F+FlXSXjIL7+TllVc61II51nal5nPlpgpwVwexJIw3/3nMysMBo2fmyrC/DrGHeSbSL3pRasq5L548o/VzhL4arFBLzesRPo8rS7zB0ED2mLbUx/CbiEQeejj6CvgemdrM+AhI1R/7undrXrFsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PGDTKCju; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM52Jfdv+aalJf4NDCgJ2vsQADj380ReqSOGtufut4MJDOctlM/0IdXapjd2m6E3pgBgjAxmT/N938eV1IQ6/mXDFNpG3Dbozop8Y075t5L+BtjIsgKHD9JAd3rK7lcP29iAoQiw0HgespC4a5n3l674SE7qhOBYJAD/VCSo/vpMGQGscMwNUh0PyEf3+Qq+moSVSrhu6wfhWit7IS84qgNI3r3GqDKFP5LRDYfoqqdqHPtzGIsiG5Tv2AWgzbUnFb07TeFK9zztvkWqoi4JcHVbwKzD/IYtu6uDd0eXFbGuoMQ8kt1aggMtxL524wVqUXlENkh9rVNjp1DcNz63rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=N+BVpBntSjGQRWuFsZFk8PSjeg47CaEwXsMeZOtrS43rbEV3+dVLC2G7TuqbAe80ej3tGit8pDOL8JYPLYYgMWqcy1VnuKDUUf4UPE01pp7KPLhOAVyqVH16HZ6JKo/6TrKDWWN4uZ3nrzzE/MECNz7KnwDyKbG7+Ns4zqMfqwc+HseZbiz4FZcwDaNYTyBzaDGwz7RI7jrlzGUYhs20TqKjZTFan5h6aPUXMxQRJN2SihEPuw3SibydPLsqxeEaaygvvl+f+9cRGjbjVCPRNaJRwXsqmn/wH/8zXABltWzgxsUwzeUkfcGnF2Xlcq4kOJjxotTFTGwt8FSQx7zjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=PGDTKCju1gVsnKOefNe4eVGOC6+lgeKZbHELw4EDAMBuNwnuXBfy9SNEvOlR841IXPnpwgM4RAq+GnyYGpy+opkOFSs/1Ifyd4taTTvH2vu7yYcuQq7RilRbhpOr5edENr5o+iVNEMO6DLRY8GJ/NeDZ00IBM8JnJgwN7kI6OQ0=
Received: from SJ0PR13CA0216.namprd13.prod.outlook.com (2603:10b6:a03:2c1::11)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 19:45:38 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::d7) by SJ0PR13CA0216.outlook.office365.com
 (2603:10b6:a03:2c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:37 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:32 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 9/9] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Thu, 14 Nov 2024 19:44:36 +0000
Message-ID: <20241114194436.389961-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: c405112a-d4e6-44e5-7bbb-08dd04e4e99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/n/GOhCJtyovQXpG09Wnnq+j4va3Jek909nBGOyvAdpoPlROcxm0W+IRBA6?=
 =?us-ascii?Q?zmhmUMF7s3fV6E+JP3uZtL7hj2oO0mqcVAym8wN3Cjwnrm0RkgwfyNoz4XaL?=
 =?us-ascii?Q?/tdVkXVm1/Gy8Am2BORttoaYPgBN3/Yi0bKKNpcoovhZ7fNfx5ZrolKLj6GB?=
 =?us-ascii?Q?sM10su7cxmJDJub4Vpi0z5szTKWSAItcLkK1mpSyqhYqtS9pfAkkPg2uYvd9?=
 =?us-ascii?Q?HIZTftLV2GfwFXVn1Nj5HnIa7GW9ka0cKaKaUpxQJrnEVmWzW9XRPRUDNihw?=
 =?us-ascii?Q?bCPs2ESnC4bO5z+FvyKNA1yzXarE4Zhn3/sFcdxenJ/vD5/F3r24euk+aZuN?=
 =?us-ascii?Q?+ABXNL64sVZ2d0LmZoJplwEUNzYTT2mfyLGXoHUDzcCap2J08qANi2An54JG?=
 =?us-ascii?Q?xdJq+VP5bcG4DcgWOiI2nS0RZ0MEoOzu5fd2SHoBV5l4U+yFwpTiARLoNIgX?=
 =?us-ascii?Q?2NA5qQAhsuR/yhcHf/BMnav8qK7BjLqxPWp2VopXByx0UuKhBwh5zEzq3dqj?=
 =?us-ascii?Q?swqIuK/ilpDU6Gh19THn0TO36Nx25FLR+p0YVS+XB6s+dbiwu76D3S6uC+Hj?=
 =?us-ascii?Q?/+acu9HbAMTguq2CdTQ7KI+nlBCY4K56Zn48OwivXhA7pnT5NkkC0g5cXC+3?=
 =?us-ascii?Q?lSwmrjMbx7yMECgD5/Nhb/CGxHFIc54QdakA2ZwewAcBpGVCw/arMDTXncdk?=
 =?us-ascii?Q?FqKKcBpfqOjI3R4kmUAvBcEb6uR2UoTAS3MPorWn+UcDyvfK1ZBCC0pEVLU1?=
 =?us-ascii?Q?glzf+19WF6YtyyZwGykt7fnL82O5QKi+IZ9h4GgGJKQoS2YUFQXuGeuDBKSi?=
 =?us-ascii?Q?PlmwvycTEInP6l8JZMBBjgNVu0bwiQjpKDclZ56HYZjbd+Yp/I0U84zGRgUs?=
 =?us-ascii?Q?o1OviNFj9R489d0MsrupurABBDZs/53YFOFaBZHFuBlLC2uORuWYrXkHg0Sg?=
 =?us-ascii?Q?pPuANQhAvWfAo0g5ol/WYSGItSW7edbhm7YwVXdsPZEyup0CQGCF8dTyNB07?=
 =?us-ascii?Q?J9ygwUnc3Sw8DTAxjR1fdtBg8qFBhEt8Rlp7S0gfiEdR3LMfdKmY4P9q/Seq?=
 =?us-ascii?Q?hw58dFQDwP9GTSkb2ki4AKJnDHzXAnmiItIE3AzIygxxuIXX+S0ZCGQQP5UC?=
 =?us-ascii?Q?Imf+Gbkz/epF1QCtYX7MWvGqM1VeikI6umPLC7j6ROVM77Wcg/rxpkM6OWHv?=
 =?us-ascii?Q?CteBhH0apl89pVXJzN1pS7SM3RfK67iwJ6L9hkLeTPafyVrP2bUWG952IqF4?=
 =?us-ascii?Q?eiIk7aOVsLXV1ZUzLuQd9i2lC3xzzvWGAgDrrWZQkiD2qraDmjU5+mGPK4Yy?=
 =?us-ascii?Q?m7XxIRqlrHQsRGCvuFnyW5+tYkGt9cTSjFS5F4YvDUVVqndN0Svim78b+U45?=
 =?us-ascii?Q?VUYHxulTnviIVJLNPiPgrfmnPSgpXuob4MQiSotaQWRw8tx34w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:37.3251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c405112a-d4e6-44e5-7bbb-08dd04e4e99b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
helper functions.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 50 +++--------------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7b43894f6b90..621ffb5d8669 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1e4b8040c374..41294807452d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -992,38 +992,6 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
-				u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	dev_table[devid].data[i] |= (1UL << _bit);
-}
-
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1179,17 +1147,6 @@ static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 	return false;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -2637,9 +2594,9 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		set_dte_bit(&dev_table[devid], DEV_ENTRY_VALID);
 		if (!amd_iommu_snp_en)
-			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+			set_dte_bit(&dev_table[devid], DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2667,8 +2624,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
-					    devid, DEV_ENTRY_IRQ_TBL_EN);
+			set_dte_bit(&pci_seg->dev_table[devid], DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
 
-- 
2.34.1


