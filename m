Return-Path: <linux-arch+bounces-10194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B103A39A90
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE2A1741E8
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAA236A61;
	Tue, 18 Feb 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pvV3g+Sm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C02343BE;
	Tue, 18 Feb 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877452; cv=fail; b=DYP4F0T/Ese8CkhqNLxOfTypbayJdfSy0UlmAAk85d8WTl1fG10DFUwkkqp0npmJOclkZ9JdokxNokW0Juo0hLJmpaAHQ3sDFgf9WlTx12G1dG56/AO62UmvMpPTtjr/mzDYa8YQmqN2HerjMEfRGnkBDGs4xJSR9fGYD9YJCwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877452; c=relaxed/simple;
	bh=ACeK8EnncRisX03Iaca97lykerRAmIbenfpQjDoeJmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbOIxZ09omhAqSpAzwITByjOKxZmaL2iISCDwJgzE5EwOFeppDvfd4NnNoZPRllJORlwYBmO6bdSx6cM/ssAqTS7exbSewcvZ2vNzKHpcHyvmspbQgG+fqB+0xXm9+kbU1pNxXutI5AWxBLBN2HDwuuKzy4yXotrLmZ8TQvhrg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pvV3g+Sm; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBlG1+ZtLu2rk5k2h7YTSJWqOA1c4xVOdVyI4NX7Kz9CSHmESaUKa1E4mmwUjkTk/hPX/DPelBW3yiAQEiSkB3Tft0qMPjumE1FGjhEcMJLr34TDccSgCBmfXSQ85padQ/Onx4rmVMeFS7pDM0l1mwN0oE62aT2Oknq9FySoUNpEpU8OHHRns1xWt8428Skzm0cT5tozDSzeZYMrqGO1sLbKG4gW4Mb6uVcXe8I9g3ba0/+zO8Kcr2SKFAuI+5lpZmXghYmVJNSpSn9EQ4+lslhWvljzUR+TMwctgjKhlVaJWDLQOooHwmNtVedcQfncVuLxBlQMTt1+eJ4hgUy3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vr+YSZpMClJCTixEamJAWElz44Tj4SAZi0SW9n+2EQ=;
 b=PN3EAx0Hv3lzvn3Ji7UZsHBwcVt0r7G9hNc5/JxZ9SVNx4UAMWKYQ9SfCjxh1Zpw4Q4DhtYpaPu66/A7ZcRBaIwpZx2e903Gj261iKOaWm5h4QrlAHDIsUBIfYBzLZb6D2ep7jJ9qxki6zOfDzDGMf6hKaIH6KAgbYB17UfKwjpOCzuXSc0EFHYRSGk9Dw0EKmrNPKNZtu7PAaIh3BLyhuSyeKy4LwJT35wrt2KxCqysmCBGHli4oBTE6BMfW9SKDRlwKO0Km8hDBLOp5KA2UXVjCMeu1RkoPnE4vJ53svDDdhKbsHPIoJInv0TYmBgxurdVYtHfbHOrahxm3lEjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vr+YSZpMClJCTixEamJAWElz44Tj4SAZi0SW9n+2EQ=;
 b=pvV3g+Sm+XeU7bl6p2OMoiwf1bj+eZobIXPRRgWdW+I17UuEp7Q0dk5PA5sOSo7VCOMPRp1WUwhV+7vMt4tg9rygNKq6jSOcTa9PPYcI3VbYIrXnywXrIyeJ8/zSaDhZFmyn4R4D5ZUTdsK9fgfX41VEdcfgiB9/XfaA4d2gDJQ=
Received: from CH2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:610:4f::40)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Tue, 18 Feb
 2025 11:17:27 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::b) by CH2PR18CA0030.outlook.office365.com
 (2603:10b6:610:4f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:17:27 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:17:18 -0600
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
Subject: [RFC PATCH v2 20/22] sev-guest: Stop changing encrypted page state for TDISP devices
Date: Tue, 18 Feb 2025 22:10:07 +1100
Message-ID: <20250218111017.491719-21-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: fe324db8-ed02-4cd1-0e75-08dd500dd3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MiDPLiwivmrMTPXETqh8IPmgD/i+i7cuWK922BuvrhbMtg1sy59ci7CCEv+Y?=
 =?us-ascii?Q?RE6p/trTSTQwcDjFT1CxYWiviDOBuhYFtWbHEdOb+oIztHCMbwYeUecsmcJd?=
 =?us-ascii?Q?6ZP+yftrDbsYBg/o5ixLmRTh3l0g8B7wgsZUZAgr46WcHwjlhkgWD9vL+5TY?=
 =?us-ascii?Q?HtuIt/b7SviYAOwOM0EPrnGIypy1YKkA5oGs/cYHvOzhQckTipWTBdEK4q+Q?=
 =?us-ascii?Q?z/8V5cGIZCWac1OYUxipZkjPLD3tKWhA9nLZmmNIwgGzAH60ApWDmWx92u/K?=
 =?us-ascii?Q?3ppybBkALbM2qRRstYywgM6idKc4B82QMJm/GTDzfYFFpvwwmL0C5HhTc4qc?=
 =?us-ascii?Q?AOU/q7EUKsgbWxbEYdTNViYeEtB4GOTcLBtdADDjncAsCA2paZ/MX/ezFUHJ?=
 =?us-ascii?Q?xQwwKPI4YGJWSEQLuvYjvyJqgzuAMIME9VVJlcF5Z/pLrL1oRcN5OYMmGYVD?=
 =?us-ascii?Q?D2U5zk1iOSmlA3/Kh9cqZ2CIQ3mCp/cQ03dycvXYP+YRHK+PvRTDmhsU+fWO?=
 =?us-ascii?Q?dqar2xUoLKMx3IL/eE1rKP9ic4uzZo7+HDhUpBjPlBMPsYVNtcoYpDuuwX5V?=
 =?us-ascii?Q?tFC479anvo/oiRnUQMreWPjzTXcXb2P6p56zpfppRS7P5l65LqThe5NQKBcC?=
 =?us-ascii?Q?RgUaeJbYUfDjWyuy1BulQ/56fGhn2o/QH98RpNtb+dX/QEJPA8UQvdpcTXwF?=
 =?us-ascii?Q?3otPSY8TsSngz0XIr41Xstlw4EriE5kqnRbXUrkgl0vKCydYuPyhCOZH4rH7?=
 =?us-ascii?Q?SJt8tP5k7tCcuZHsj7/FBELoa+LdWSDUmOYiEVEo0GVRSDPKrM067RZN4Jdm?=
 =?us-ascii?Q?HxmCdVOtPdXjNUmOf1X0Q7lau17ycSHYPgFjyB6NBqDSefrO6hNnXDpbloc+?=
 =?us-ascii?Q?Dj3cQT5VXH/of4VDB1Mn5Bbf4YmvNtpraH+gTyvj8EelcIRY2pP39xoJvfed?=
 =?us-ascii?Q?cQ5JwOfC662gWOXAAov1U/AOsNuDIC1TsA9VE+2pPa+ZyUE2CrxuAyFp+xSO?=
 =?us-ascii?Q?0m+CRs67kg7KFfZTnPHlXlzyX/KOkMPYJKZ7VDB3xwhBMPkBKSSoSPejwBx3?=
 =?us-ascii?Q?5Tf22llOJSN8a3CWOvbWiqM3F/P1ZaO8yLLRyRIZqZ86I6SNm1y76tc+a22p?=
 =?us-ascii?Q?yGSceVcrufgprxGWv0eoGTjEWrVIsXMKvZLf2gQVWv/ARlh+e4QRzBmFDlLp?=
 =?us-ascii?Q?YdzsiGu/CXBSbIh2n9Him7TW9n6eAKdSq82TkYwzPfQEA027e1FyJGcxLk7N?=
 =?us-ascii?Q?I30hnya2aRboJcoDIn44+MzhhHttjqJldTOxiQts30LROrNrgK0webs4sw22?=
 =?us-ascii?Q?VD5OQyQsPYOzlKF/uRkEUOQ6nnOHpFGeOc+lQ0Lu8xKSTbXpWQJuVsJWcciw?=
 =?us-ascii?Q?PmehjckP3yzGyqijyJlrXGlTqNwTBKPLUEnYS41OCTDr5ABn12mQvW+6HL28?=
 =?us-ascii?Q?faTHlNLUyjKqNqEkq5MTcDwo+gtBgXZLoONfDsbN5DOZIwW1QPAC7M+twDQg?=
 =?us-ascii?Q?btCuQx02V743p0M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:17:27.4343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe324db8-ed02-4cd1-0e75-08dd500dd3d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086

At the moment DMA is assumes insecure and either private memory is
converted into shared for the duration of DMA, or SWIOTLB is used.
With secure DMA enabled, neither is required.

Stop enforcing unencrypted DMA and SWIOTLB if the device is marked as
TDI enabled.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/dma-direct.h | 8 ++++++++
 include/linux/swiotlb.h    | 8 ++++++++
 arch/x86/mm/mem_encrypt.c  | 6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d7e30d4f7503..3bd533d2e65d 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -94,6 +94,14 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
+#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
+	if (dev->tdi_enabled) {
+		dev_warn_once(dev, "(TIO) Disable SME");
+		if (!dev->tdi_validated)
+			dev_warn(dev, "TDI is not validated, DMA @%llx will fail", paddr);
+		return phys_to_dma_unencrypted(dev, paddr);
+	}
+#endif
 	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
 }
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..67bea31fa42a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -173,6 +173,14 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
+#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
+	if (dev->tdi_enabled) {
+		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
+		if (!dev->tdi_validated)
+			dev_warn(dev, "TDI is not validated");
+		return false;
+	}
+#endif
 	return mem && mem->force_bounce;
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 95bae74fdab2..c9c99154bec9 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -19,6 +19,12 @@
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
+#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
+	if (dev->tdi_enabled) {
+		dev_warn_once(dev, "(TIO) Disable decryption");
+		return false;
+	}
+#endif
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
-- 
2.47.1


