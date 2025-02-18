Return-Path: <linux-arch+bounces-10187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B89A39A6C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E713B6BC0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA923644A;
	Tue, 18 Feb 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNNmp3TI"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCD24113A;
	Tue, 18 Feb 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877308; cv=fail; b=nY779Gmkaj9vBAflNgpc832oUQBEa3wbcfbkIFVlcp70Ya33YN9E0zCzeBkVc/gfVi7qczYnSYvYuCVavIL2BjB1HL4HykAOrZOxB9iMArgkyQaCXGtG/5DwRffAlo3e/O6LQwmCJ+tPWHS7CGjme5484Abs3l/O+oDoLoVcqxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877308; c=relaxed/simple;
	bh=BrMeEv7WnYjKShGr6ExNAUVOkBj62O3TNw2SUTUY+7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4TzGTUXnWBEsFSuJhaz7rPNQPguvhNrCCOk6Zo+UgdAZgbZoo8eKFwv6JskMBUrvoX3EmfwCjRwlDIf8U8m121iL9nO4K0Mtx+TzhROchQCasdhIrz1ACcirzrRG3KydnXa/8eJ/O9zJsa2Ma1ax3ao6Dd272QDTx9JJ3Fyz0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNNmp3TI; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aev1AwpedKaVyUUNGnxNUYZ/COhKfBs2Vau8tuIzYjKQFLqShiRx87uoR3bjlsedcgxyjTj0XzBD/kwLIN68YJjI/e/roGPYXMrteN0qj+RlT42fV92X2YMTIyZyBGiiPPeX9aXkLwDMabBWdpM0mIJFCoawxbS/NNSRfi4VVIUNAj54dXQ8Dj4tWj2+OUKAdteiSvOb7F50Eyll8mKLkPhpDjwj2yK4bBbK81gYy35qxib+JpASLCBaddfX44vZeowmPj4x4XhMlQA1Hpt/sEleEfrkAkOEg4VgWVTRZJsgzou4M4+Y9Gq1nuThOaYle/814Jr2pYxu075Z3IKfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFI94yMUp3uMqVwPx+bM42w01VlVkpu30TsVeazsAJI=;
 b=lHsi3caO1qd3gzjjjlRgxX6qirt/BrBycfVYIQtQOvZteivy9T3XZCE7omr7YNHNJZ5yFEgHIiSNsKmySiKFZ7WBXgJzO6gP/BwL1o3a/9jwAERO3U8DxrX3niEBWjtCQ0C1wfS4JyyjBdpN/IZh/V0fcRB2j6nCQHZIrRZomt1Ww9bJvxottne3ZYW0pqCJ1f/RZDOTQ+5n2PdXw7Docgh8jwMUCrhkjZD/K0WNcdZLzq9vydJlMnkBalqU1T/ZninkN6oIKi3RS4EWm8BQAIGogVytw3EbN01bluaDkw/owkxrHU5H7ox9wm2EzPQQAC+q3A1k01lWqKMNpgOApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFI94yMUp3uMqVwPx+bM42w01VlVkpu30TsVeazsAJI=;
 b=YNNmp3TIT6ncQYUKu7E7SpcPPvmZLq6/FGOy5Dru0yQOuUPSW4aeAe85hFYXoHvmn/d639m8DOc3h3awnajaS9rQI8+X2X0h3BLSGHPimNsK8adAxdpc3hLr78z6zF8LWwtmh382gx69GZhwADD8EvvygZoJNpgZjCjd34681IM=
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:15:03 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::e8) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:15:03 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:14:55 -0600
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
Subject: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Date: Tue, 18 Feb 2025 22:10:00 +1100
Message-ID: <20250218111017.491719-14-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: fc46e990-a82e-4474-b0c7-08dd500d7df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJAf+TYVulPUbI2EDcbwqgRY2rdNX2NWrJmWXovjwXj1fC+Ved92OMSsU7OB?=
 =?us-ascii?Q?9ASaBQcOCt9PfMGY2sjR+74s8AwQslJnjckPl3YZQ0vowE051JtoWIBQgwHx?=
 =?us-ascii?Q?TAAdTGvnzj5z2VdrrVve5h4YPKAiuCEbk6tUU6lR7S9OVHSsVt1wahf69P04?=
 =?us-ascii?Q?XdbefwUorpm9CQq7E1p0rIWOrx6rDQNCx+5bf4qPyJ+tjAXcg3KcQqAmWS99?=
 =?us-ascii?Q?yZifi65flFRq67C9n7X+Gu8AfeLmnVsiPSqIdCDv2lHwF85fR7R5tQJ8UpKA?=
 =?us-ascii?Q?Ct0qthDGsYiROVeiJQbOCiLmf8AxkNjNhLiWaXMnSjR41gEd0rs+DmJ5q5Wa?=
 =?us-ascii?Q?qPBut5FqLhZVLzm71Nu3c1OneIthKonMQ2CN4w0XYl0guqOIZNkHFKK1IBz6?=
 =?us-ascii?Q?aA3UA3rtVvjMJnak3j4ca8axUsyBTX7mtVbslQiqzM6fi6orRoJvhCz/NP6E?=
 =?us-ascii?Q?8jdWnjsr8zmbFTi61NAA/Ec6zQSaF1202XHvB/RFa3/sKWwZKaaCtNT4ai4U?=
 =?us-ascii?Q?HWvEKvJjWy97jcMkL7K83338CCwz/D8hG/ZBRBXOCwpJliqym0CFTOjP7mAL?=
 =?us-ascii?Q?qRkU/LrxfEPbsRgT/FKEX+35jDKitoFjvMhAiL18cVmGCteEk7y3N8Kktm8T?=
 =?us-ascii?Q?CTsdX0lyzvxOHpMHW5D0nlKYS0wAa2ZZpH3zk7xyoUR4ctxT2JfW7cksgK5o?=
 =?us-ascii?Q?iBW9BFK4tSOl5tUJDe4vFyjudQ8BAZ6R+fQd8lDmWIJhthC+5PAvZykD4Yuj?=
 =?us-ascii?Q?17w8L1DZI5/1orZxMbsXfJU1LDTfqbKbbsdgIaL67sO0VFcekNg/qWl3jT4M?=
 =?us-ascii?Q?8EmGTBeBJsNCSgFqR3lSmFOJXvl6pVyqNk6sVMxEYdiqdgGYMTeQiO5VJrxr?=
 =?us-ascii?Q?WEppPUn49bm2MdGJYXoTbE/ePQ2yLF6R8qnXniaVkCaWUuGB7F9qAf/1sbiJ?=
 =?us-ascii?Q?rR/6A7iX6O74MKu50Fg5uaf9Z1eTZTc/ZS0H886KwGcd4IU6drOyy6PvO8hz?=
 =?us-ascii?Q?b5HmlNBZuSRsLwHnkqXiweXdXe+u0SQ2jRVDC+XrXUkzd3U58vnnaxGeG7bH?=
 =?us-ascii?Q?V64qIrLYHwWn+b3X2Qnnh/brdhiRM8IJ5F7YWRVGl+TkPPLXQ+Yq8/ZvjYi0?=
 =?us-ascii?Q?cWKDtLR8ft0+pypZ1v3HWqvTqw7CjeZtJXtBSPFFb+A37ymbYyBfW04dE5/L?=
 =?us-ascii?Q?GYVN9OTNP6eJpiHuhZZCBH0lO8Eu3KxL7ukBWEalLaWRjO81SWAFiuxOOnyY?=
 =?us-ascii?Q?23ZMlGYw6d6iBCg9+3B6WQ73AlE0KWqpNgrC6XAj5XUMZBpwompiIDCRQsPF?=
 =?us-ascii?Q?/6Ql+D+kJBeYglrvFHbiXzFuhGYlDR33dJ2Y0OIPwBIzo0+7dR7/TvcFOxhm?=
 =?us-ascii?Q?WMi/UJfJlwwsOjvI95rxHseNO6KXS4DTZyv+NKCuDm7hIdkmupfUpXx9an1W?=
 =?us-ascii?Q?czEJZ3J9zmXF/fZ7JzSm9v2iawcg427QQWmUSlYQGEUzOIQ84bQ+/OIRPmVz?=
 =?us-ascii?Q?xf8R3SCnVcyKWRM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:15:03.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc46e990-a82e-4474-b0c7-08dd500d7df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

The new AMD SEV-TIO feature allows DMA to/from encrypted memory and
encrypted MMIO for use in CoCo VMs (SEV-SNP). The secure part of IOMMU
is called sDTE ("Secure DTE") which resides in private memory and
controlled by the PSP. sDTEs of passed through devices are in the TCB
of CoCo VMs and inaccessible by the host OS.

Implement vdevice in the AMD IOMMU host OS to represent the host instance
of a secure IOMMU which is visible to the guest. This will be used for
GHCB TIO GUEST REQUEST to manage secure sDTE and MMIO.

Most parts of insecure DTE move to sDTE so DTEs need to be adjusted.
At the moment this includes "domain_id" (moves to sDTE) and
"IOTLB enable" (should stay in sync with sDTE).

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 include/uapi/linux/iommufd.h        |  1 +
 drivers/iommu/amd/iommu.c           | 60 +++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b086fb632990..b5513bf05b27 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -593,6 +593,8 @@ struct protection_domain {
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
+
+	struct amd_viommu *aviommu;
 };
 
 /*
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..b346fa11955c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -939,6 +939,7 @@ struct iommu_fault_alloc {
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_TYPE_TSM = 2,
 };
 
 /**
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..076c58d61d5e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
+#include <linux/iommufd.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -2068,7 +2069,18 @@ static void set_dte_entry(struct amd_iommu *iommu,
 		new.data[1] |= DTE_FLAG_IOTLB;
 
 	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
-	new.data[1] |= domid;
+
+	if (domain->aviommu) {
+		/*
+		 * This runs when VFIO is bound to a device but TDI is not yet.
+		 * Ideally TSM should change DTE only when TDI is bound.
+		 */
+		dev_info(dev_data->dev, "Skip DomainID=%x and set bit96\n", domid);
+		new.data[1] |= 1ULL << (96 - 64);
+	} else {
+		dev_info(dev_data->dev, "Not skip DomainID=%x and not set bit96\n", domid);
+		new.data[1] |= domid;
+	}
 
 	/*
 	 * Restore cached persistent DTE bits, which can be set by information
@@ -2549,12 +2561,15 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
+	const u32 supported_flags2 = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
 						IOMMU_HWPT_ALLOC_PASID;
 
 	if ((flags & ~supported_flags) || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	switch (flags & supported_flags) {
+	switch (flags & supported_flags2) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
@@ -3015,6 +3030,46 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	return ret;
 }
 
+struct amd_viommu {
+	struct iommufd_viommu core;
+	struct protection_domain *domain;
+};
+
+static void amd_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct amd_viommu *aviommu = container_of(viommu, struct amd_viommu, core);
+
+	if (!aviommu->domain)
+		return;
+	aviommu->domain->aviommu = NULL;
+}
+
+
+static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.destroy = amd_viommu_destroy,
+};
+
+static struct iommufd_viommu *amd_viommu_alloc(struct device *dev,
+					       struct iommu_domain *parent,
+					       struct iommufd_ctx *ictx,
+					       unsigned int viommu_type)
+{
+	struct amd_viommu *aviommu;
+	struct protection_domain *domain = to_pdomain(parent);
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_TSM)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	aviommu = iommufd_viommu_alloc(ictx, struct amd_viommu, core, &amd_viommu_ops);
+	if (IS_ERR(aviommu))
+		return ERR_CAST(aviommu);
+
+	aviommu->domain = domain;
+	domain->aviommu = aviommu;
+
+	return &aviommu->core;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
@@ -3031,6 +3086,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.page_response = amd_iommu_page_response,
+	.viommu_alloc = amd_viommu_alloc,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.47.1


