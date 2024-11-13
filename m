Return-Path: <linux-arch+bounces-9060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195F9C6EB7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D653E283380
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A78207205;
	Wed, 13 Nov 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jGn4svnz"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5696206E79;
	Wed, 13 Nov 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499477; cv=fail; b=A3CE7RgrdIjIHFmOmM+cyDOxAlIVyFTqxJ2Bm967NwqoBAli4SdisvlF16pILC8WqtMlj/rvdCrAuAhPTvVGp3e6FvnOFN6w31Nz8wc0s8F+PxmcZXDVu0JUOd1eb0Q+WZS/9MIIiYJdqJYujiKTjs3biuh20wJJ9hBBcvV/rHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499477; c=relaxed/simple;
	bh=pD3CmY8Vf1E5rTziOoui/AnVhcJWQmAJJ32cDLUAJww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOAe9gbXAwSZwIn3jGAHPse1A4UjgxpNGiibDs/vYvsL5/Cguba/4rqVYcwMJ9ke1IRoGb2sP6Y39V/NfXmCj3IlzI8bIdue0fJF0CQ9RJJBTATpWdgv25pM2eiT53S5bPVvEYL8XeW6qOJug2vd7A3b77jNtXoL+tq8RQySSFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jGn4svnz; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guFf/KsuaJcb7GZFXrA82zq7tAoWmPexIOfWN2rgI9OrYrNRp5MXhmE5rsOkhV09VKif8+NAyAPZAhMLshzX6tXzveoP9Dk2fUd07CuCWQ+Sby3pLyb3X9dTxmjbPg1KlNGPTAcz2Op50LDezPx/nx1/gw0q+gZ+BmqixI/vXEvamCtT2AuIMzCjcZyqOwNa9p8TSj/QxwPS8t0vQ26k37qRu1zmrvF25jllXoXcVS1uzQhf7+uuHD+uEZE46T9JWdQskAwdugxVXkyJAO6bsemLX8OZtUbD3L+yVOOdWWrmR3gQ8vyUwJyWY1ZVYJsKRv1+rKJvwxH0tEq6KQGbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=Jgrc6z0KzPHTCIi7ewfQy0e9oEIqPthnum0Dxq/llP0/9wHpFXTY3cVd2h5QrFbUFpCVYhj/EKgdJN9STjWeqrauU4yaZOz7nA6KkK9RpI6KSvsoofi3czSA3DM/FufuzrNBPHhrfnG1MLq9oVBlMM1EuvE/oGD1ch21SgGuUuulGNuqnxzsweg4KekGZe5bfztNbUQSZx8F9aotdyPrLqVA6aSSSB5+26vaQS7/3XiAJ75TtMWuR97KwWK8JY+0UnuJjj9JMmEKa/lO4XCD+SNmrY0OhVZF/N6AIqpZCjZLVg0+eDLUFwtav0wt8wgGogGQHF0gySEbfqenLVEIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=jGn4svnz/gunhEaEq8BnJQfl+BTCleWyZA87qg6Gs6tCsuDWqavO4PtWOztLMZIjayNPsGdZPOC3w7cjeqGRKEWXnqmnw9day6E6FHoJPJ8br/za4INWrD8eT1eN2vCUqu8D573koAaWPeiR3CZJ6v4Iw8Lg+McjUkY2CA0jr8w=
Received: from BN8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:ac::24)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:04:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::fb) by BN8PR07CA0011.outlook.office365.com
 (2603:10b6:408:ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:26 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 10/10] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Wed, 13 Nov 2024 12:03:27 +0000
Message-ID: <20241113120327.5239-11-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9594e9c2-73bc-477a-76e4-08dd03db5572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81V4Dy6RYANUt1vq3eXAXHTDUtFONv2HY4Znf8r73vi4hIy5VX8FHMjD5b1E?=
 =?us-ascii?Q?LKiu8i9VHHosCuDa3U+I0reDuJwlWAkpq24iHzDgROhrIK7nXVewKeBLDt9n?=
 =?us-ascii?Q?jf/SeL/SMBDoKQ0h8B/7yym/BC+mpNCPh2xJEaB+79ML7I/0+XsdNed0hntF?=
 =?us-ascii?Q?4UFBJB+vIGEuG34FyzXaA7rh5pzblA6tj6xUWHghIcog0KEeGTqUSAIE785k?=
 =?us-ascii?Q?A+zyYvAiuYJjnmSu7wFSR3GcMVko+/JezLwSAo3A98CEPg8PFQmw5zE/p0fh?=
 =?us-ascii?Q?giognSrvJr+7wPxN/r/lRO2lqBCT+xMqSO8GFQ8s6DJwo25IjCu0IB51aiEt?=
 =?us-ascii?Q?tHDXtFlmIqcqj+QxVG378uoVfsMRm2pd2oD/ztOEHuzkXUF68IigCMERRBWY?=
 =?us-ascii?Q?ZPMONDRJ3pTVQdHT6xxjGVGYoLw7Fsnu+ON7Fka1SiOUv9xizY+NBhHZPDMB?=
 =?us-ascii?Q?H3wecET29+Paf9t/ngV76dPV3Sx9lb/B+Fn2O7XyXHBr1yP61ziizn6QVFZj?=
 =?us-ascii?Q?PC225KdNnwXi0YiuzSZubjD8LOpRd9hysDZ5ZRnli337lZGHWXq19IxkFd79?=
 =?us-ascii?Q?4roXeJsG0LPkXTrJOp493XW1ZrtDwohe8uQHvefSrKlaBFKl6o43abWnK+7Z?=
 =?us-ascii?Q?0H4y8BCFtvPrI2RWWD+8ecNm8wBF/cbM6Ryv+9h9PiEu3ANpINTmo4/G1tIt?=
 =?us-ascii?Q?eFtF9UVlavn1AXyZoXjEH8lzb5h13pkCM9FRb3gg72L+Gg1C8Flxk8dvKzZO?=
 =?us-ascii?Q?bQpKXWnNXzjATNiooHKtRU0x0R7bE7ikVI2hWsnqb51C78pLvwN633Xqz9Lp?=
 =?us-ascii?Q?855g5IC08JuPm0GXQHnQz6e91nxxieeXYYKdqxN1ClS/PtDGmO8KDFTEClns?=
 =?us-ascii?Q?6xIHu2SEZUF7e9t/gluBZ0pHLNO6pBQKJxaDfvgEOauq+e63Xf+6NEhL2VH0?=
 =?us-ascii?Q?foU24WUL2Gl4RtkSXIlkwxBWZKuFIWXkfIdNXcoi5WyvC2Ot1rrLaBmb3tkZ?=
 =?us-ascii?Q?eapjuJbGCHXkKoFtIdn2THM+MLuG9T0WPNWzZt4zFhkSDlAcGyrpxRxPE8uU?=
 =?us-ascii?Q?s0XUcnvGZZUfS63F8geFmUD6YgehG9NAeBZWxxsNPDlSiSQrEs1Ukn6VkVdX?=
 =?us-ascii?Q?2hxnV8j29UKdZjCHsm9fSSvoa+djT2fK6IuS8rYKagBmqKoE9Ozdoyw5ZIQD?=
 =?us-ascii?Q?OZdmYmmjb2/37/oHJ+XkplxeoceWS1Yl6IIHxdwTDdhcSQ3yRNBSRaQPERU4?=
 =?us-ascii?Q?bIJLp0cn2hHvGCOM18MoW+2hHxaJk6qd3B4+wILotuvEu/4CJy1fdTuL9uQb?=
 =?us-ascii?Q?SJBnDyd1rgE61Sc+DBUFy7UPOO+ABR5j5LvMoKpX5/oye6YHFLiKTY4+DH50?=
 =?us-ascii?Q?BdpdMVG3/VQnjCk4yhC1KphiSKJulnse2AI1HuHGUu1TSyeUZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:32.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9594e9c2-73bc-477a-76e4-08dd03db5572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

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


