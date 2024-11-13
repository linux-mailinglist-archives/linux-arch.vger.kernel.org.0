Return-Path: <linux-arch+bounces-9052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8E9C6EA1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9311F24381
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87913202F80;
	Wed, 13 Nov 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hIaeogIw"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4F2022FB;
	Wed, 13 Nov 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499442; cv=fail; b=AaCVby+KBxPtNH/nFFPEhp2x8RiuEamSZwAID76IWOtJ4Txv/xqrtEBUx+a1iSjRmrh62CeYK6e+JczgTpd2hyR7weq6jdx/2fVjSKn7B8l2vin+oH9yrq0Z2FwxXajxKDctKdFx9aySTPT/Tc7uKW8it9RBkbhuGqT3AICXhpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499442; c=relaxed/simple;
	bh=BsNnwUV2R/BfqocP4sWIcX7O5HMemYytLwFFbPlqykI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebD+Zzp/5BFEh8eUdeLWGY09i3LzXHcoQRDhLi6zbZgoDTa8F6j7nnfFvzFccWXCGb18gYS0z+vxlAWAohP2jRdijr6tp3kIYlw8uDzHF+H2tZGc1Vk4opEj+s95X2wgo9q4QvwTwlh+f31InCB1m+EXZ6daw7IzE4Vdx/1myw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hIaeogIw; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiIkzbKeVjBSB5FGNAwgnCowIw1kqmgU2HnbXZmfl+0PW8WiPjkkmBddGZjBSq0MioH6nhQPODkRv95dPdjriKDxGPPOORjuAOGKdhd0BB//NI9sLa+tmHulFe8CZHJ4AbAuchoa7sDrKe6EVIzSPXqPnzEHLUlUCGUR0SDsHaGi+F7o3jINijqcEDDK3vCUgDiriZ2WmRHeprrj8A5yVPlLp2TJY8jBrR0Dz+GTXNV9AoXcNAV/INgCEEAUYMKKD/fZns+SqK7/8uY6zxOv7qBTyEtMEO6Y2WCmmzSlX+7/Lyh8m2erUBH/6Aip9SiBww7SnatmBgRT1lOdf5YdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=ToIsJHacDrkRV1BnG+AhJHqx1lUylxEKKAPHOinMJNchTfpFfF2/SYmH8fAA9KMl/E40J6XKMsn2Q1GHdhAcmyEWL10bfiaSoyoud+nxezuHEwu3cNKYWLZaMxxdAMcp+vTMdnRvBFda5qA3sCRmTXiWTDU+o734hV4SU6vEtU8cZ49RaoJkgd21uQSHTVuIpm1EvUv6xnndloplBZJj0HIasFO1YHUw7Txyu280GT9mQjp0trZw1KQVrpt260E+qkyq9PwO7OdpzT583xDV9JneKYOYSpNE2IEYxXNIYBpI54e0RMhrqn9J543qG+6L9lcGbiP61S7z/xoZ/uI0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=hIaeogIwj2jhseucYkKlVPP4p5o2cwp6UdLIyZ6DEJ14UdF1wezwWP9ewMR7qF4D9d91IGGMGufeEtYUcTJW31S0F35qrjYt4JWSCCTKqCRzgglxEdRNoK1GvGUNmQIWC19209K2j6RX9Cqq0ARSa3tfwQ31e0Leidiuf6KH2w8=
Received: from BN0PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:143::34)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 12:03:58 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::12) by BN0PR10CA0028.outlook.office365.com
 (2603:10b6:408:143::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 12:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:03:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:03:52 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 02/10] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Wed, 13 Nov 2024 12:03:19 +0000
Message-ID: <20241113120327.5239-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 106eae4d-8592-488e-6fc3-08dd03db40ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEKK5OHf89x5PsYd7fj6oLnvoWFaXVP/xnIb4Gil5ZJscA8iuR4Fnd3RaVs3?=
 =?us-ascii?Q?knpImnWtdffcleCEI0pCi3R5/uS10sAzsiEHc5wlbB4Z6upQdQ3AX+NwB+by?=
 =?us-ascii?Q?o+K+nPo08T80c/Gr1KcY8ibglUc7LV+6mA11DQA+6Arzocm5Hfq0opp7UMXD?=
 =?us-ascii?Q?0HWJVp7fuuUDyqfQW7sYuyWsOz+zKeI9tX8qyHYwg4ZEbsurDT6L2XD9f2gE?=
 =?us-ascii?Q?Op/wXSyHcZm/FVngZlzpLguMmfX+obydY990Q9qEgPAQGy6IFHVTt9FO5mON?=
 =?us-ascii?Q?FVL2ZPvgnlsg3aTAPFjloIR171HR2uLBBv8tIo99rIdT3uLo8odq3ElbQNis?=
 =?us-ascii?Q?Yy6+D8rWmhOMg+pliWDP7NVWxqcAtF6NClKA7aVTx0mNdBh46NbomF6BgnK7?=
 =?us-ascii?Q?qJi2SKmGuhQvUwc63BGOgsndp3MqwEOzHhPRb504pQpXailf+U6T4FDdfnkO?=
 =?us-ascii?Q?nUM72jP4fV/09hC7nc/2qwJjjhaTwwgLtS62J8bm6CBu1iPAp2Qd28ocIU+b?=
 =?us-ascii?Q?fy6DmAVg2XYdtlrgpmZ2AGS5rvc4irX8gwBM367RvuwksKoCsw6rplABuK6O?=
 =?us-ascii?Q?lmxHKJKCVBM8izhfFq0LsrC72qW7R+8GzVrPfTdT++HJiIh+GAIMgkRBlCIT?=
 =?us-ascii?Q?4CMI9bqI9/eodl5GE7zBhT3jbSu6m5DZ2s8T61GA8C5v34SAeTnwZeudEKK0?=
 =?us-ascii?Q?tCpioHICOJBwMdQ/pONNLT2vUAwHKPrw+DsZlXVRDyd+cSQOb7C6xkD8b6mv?=
 =?us-ascii?Q?9tSIecsqHr5Zef935/E5AsamsFCbguaA2LfUbdPoraIQuS4nkH+cDDebQBbE?=
 =?us-ascii?Q?TO6ixbCyJlRFwO9qTp2xocLDf9U70qt8nVFMN0Ud5qchBhyhJAYdODx0OvBl?=
 =?us-ascii?Q?BbjO6Jut7DVIlZMAjr8O5cQfE4nypPA6bXVsZ8gGW9bbT+hvqq+hbzVc2Nii?=
 =?us-ascii?Q?8d/wiXh84lIwuomw035icrQPeXuP45MsHhmNbuzsbnz1jwDo2J1v26yRwhNz?=
 =?us-ascii?Q?cHSlnj5YqwJ5KAZa9Ng3UNT9tnzDEt83pxW/8iht5l1rCjc0vrHR5q4os4WE?=
 =?us-ascii?Q?d23QkOIPY9pMdv2O5tk44/3Qz1RvTlZ2ERN8eefaMOVA1oYW3tSqmVzVFCsm?=
 =?us-ascii?Q?ThKfjHOTJiwNs3kiyfZyWvPoXBc5LysxJttnW0b9T+ye7awBRrFGo3qQ4wDW?=
 =?us-ascii?Q?ttNdzX2hnySTxrMy8Bsm9edpjiyp698e1L7eK+EbDvF3cwdjOEtSlLaN1JyN?=
 =?us-ascii?Q?0sAmFGLH+aDXCndy33ky9eHTtQV40kFgkUme6auPE2IMYPGRsafOy9MwgATv?=
 =?us-ascii?Q?nTqFkq7w2p2WvvG5zg2v72pChoXYL7f3ZqM+NDaiy1tWWqhP6OqIVJSuFaWG?=
 =?us-ascii?Q?7mqpfzbIj+2OzDDlBLLW84/D4Pn37aM1zHkFL3QKJ68TfJjmWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:03:57.6874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106eae4d-8592-488e-6fc3-08dd03db40ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
in a single 256-bit transaction. It is recommended to update DTE using
128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
the IV=1b or V=1b before the change.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3a7b2b0472fa..c1607b29ebf4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1752,13 +1752,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling it.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+		/* GAM requires GA mode. */
+		if ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0)
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1768,13 +1763,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * XT, GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling them.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
+		/* XT and GAM require GA mode. */
+		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
 		}
@@ -3028,6 +3018,11 @@ static int __init early_amd_iommu_init(void)
 		return -EINVAL;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_CX16)) {
+		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Validate checksum here so we don't need to do it when
 	 * we actually parse the table
-- 
2.34.1


