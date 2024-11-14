Return-Path: <linux-arch+bounces-9091-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751839C928C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3456C28333B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AE1A76B5;
	Thu, 14 Nov 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FWaVeKFS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF08BE4E;
	Thu, 14 Nov 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613514; cv=fail; b=OMwDr6jxAbZBnGbvFUP70UDerin+DWNl7OPBJyfWtuZ2UcqgIhn8oMS8IH9/vuRm7esWnIXxMz0FXaKerAEg3GiZD/0i7wsmU8GuTDbcpIP1PhuefNbpqj1AffOehHIjK9qptZwQoZ3g9m4NupKjnmcWl+sc20doB5wISMSq5gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613514; c=relaxed/simple;
	bh=BsNnwUV2R/BfqocP4sWIcX7O5HMemYytLwFFbPlqykI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IorXJDScDQFzMKNcd3Z09HNI4jPj7sh8p88xziQ2qX54u5yzszGjuW+GP7jlnzz6cQa9ExAIEwFSP0wtdxa/2s8t+uWcFYNOxTDcZ9u26rXflxOrd0i581FqJGwD3SjkCZEpD1uXqm5TYL2R3K2sm0UWXacvsTlybEFZiEshTLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FWaVeKFS; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvxeqZhRWwVXUfd2JjbZk1Eibn9BqtgZVbdWTqcwQu8/6wjcDTKlHLtV5AlMH3HqeaFyEgHVTKplZ5LmYKxr7sZzrG6OxnAdBpvRrwOmkyeWThF5K0oHSsn3n167JU99w/+dGyS8uKU9/W7Dv3zUaCS/kyXiX7qDfbRUDoDtBMMsX/cl+O9XOGN+CZ0CI/wSq5MnYE0xkbNXhl143b9FioERPLqGhP3dEXhQIIzMT9EtKaa6lgBA8b7qlgkcpDzMK2mxzHIBDsDMRItjxsELoCD6yKNjIQ7yh5D/xQVLKwoYNWdCKVlt5oTnaAN+Bb95UAlOZsvmBgG4zqNxu2WjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=ny4X85Z7X3tGssxKWcvK/lyfDn1dCUIDX3bdaE/jK8Ntm/VD9KPuWtLdWcVFJSfczH+HcPpHcsBG6s1oIBFfkQIymjT54OvOjvjsuKkSe7OzxQg7++JpAt7M3UG77o+qw953UkBOA6erGuOJ4EdyO+GhibvCAyylLvT1uqP09NzwS+bKXsrTin5ODB1FECUffMJ+Yqs+gdSV0pPjMyRedgBQb/Yqbxw9j3vw8JEtcxnyx+JmDuoKGfGQkdF2ri9GFB9uUFxpUejWwDoPPVdkJ5Ije9ydmyHKfmkBrpvciuH7rcdT3bi8QZC4FasbtOpdADFuC/L6B/7M3j0H1WckYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=FWaVeKFS1i5U9JNdPdvrwYZC1rcA7a7dVpECPOB78qNV72nwamfPhchGDBbr8cOAHhVBoLBbqW9wwKJhDfi+k5jV2o5JtCVPMaDZXCMNhrWSbdHgO8GI6SEv21+onqcjNkppaNg5eZqLmKQnKbKEdw5mKhdgHsEuIFRixJ/vhFo=
Received: from BYAPR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:e0::34)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 19:45:08 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::28) by BYAPR05CA0093.outlook.office365.com
 (2603:10b6:a03:e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:07 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:02 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 2/9] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Thu, 14 Nov 2024 19:44:29 +0000
Message-ID: <20241114194436.389961-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 30251883-96af-40b7-967b-08dd04e4d7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Qaz4t+tKiT/hoEHa6Ck/0OInAh4tAMX+hEfuFT6pyXpJIW0kuSq4dbPqD4i?=
 =?us-ascii?Q?MlfEv0DELoTuxDtmTbdj2GCHHE2hiCmwM0t+H6aAx4UUQpcg/vyn8ER1P1hk?=
 =?us-ascii?Q?VdUyN/g8PhlXvx9eqrVgJoZfvFYKWMrjfiVHCYsWEYIdHxqW4hs0P3E/ne7I?=
 =?us-ascii?Q?WPXtAX8YOUI2tog+G8Jgyr6EqGY5UeU+w6eEZQXhQk0kuIDcbXqDj8vtKz4E?=
 =?us-ascii?Q?cstsqaY29zYZwSeVS9Yi7XVe2OZN1oqJJQK8dFZJYcSruQzmAOg4ImZV68kD?=
 =?us-ascii?Q?Vaislxvpis/G7Wjry0mozSC6uil7GBG3PeDRqNIEtRvLZ+kr1b0fhMtoyaNY?=
 =?us-ascii?Q?VDnHiqJ8GeX0tre1ZkgDUpUWumiVrB6XM8hC3kwV9PzQ6gz3DkA0BSUlEXdu?=
 =?us-ascii?Q?3oAHZ2HjwI4cHa+i09nLl6UOKaXmsbQOiiEaiGdB1ll4Wz834C49PGrzq438?=
 =?us-ascii?Q?w4am642KRtARA92r/g1jHAnBI7Kl6Hkv4piyt2XW3anbTwRtIy1poBN8njHq?=
 =?us-ascii?Q?FK7hN3fPtAOKYKetzIxQYcWrpfmqLfid2uLjUsCUFtyJJujT/kP2L/di1C2p?=
 =?us-ascii?Q?g6ubwhpl4SUw3+41SwAF79UG650QUcoeT3Iklm09aIHCU/ow+7ERj7mCit2w?=
 =?us-ascii?Q?X5jxE9gb9Eob4FIFValDH9Ntrz4j0lGvA166qCXdWVD85Qas80/8jFwtXPJS?=
 =?us-ascii?Q?tTZFWEan2wcjOcZZvqOlnbdzkh1/EXbbEqqnuq/oxMoSoHoh/IyC2ljKp7UE?=
 =?us-ascii?Q?y3qc23VeIJiQw7X8F04iL7tvaQ9+2Fmpyy5xjWPYHop8cfiX3F+7rPAfYklC?=
 =?us-ascii?Q?jF0qu2VhhvSk3PrjUTUibUF21SQvKoHwDoMd+usjhffy0MGVewGF/nO4lYCG?=
 =?us-ascii?Q?tpnFCxpLVL99Dt9Pek0JHOuzp51NKQmbF1tFk4il8siWsS158+Hy8mWQFq+T?=
 =?us-ascii?Q?cJHHxZev7t22+WrruY35xNiwZBO741+CyLbHo8roClWwwMyxMBhxPweDs4+I?=
 =?us-ascii?Q?NildPYt+AKwFJ6RXwvq+RN8vbDErH1RCXPaTXV2u6IOkoB/REuDSsaNyVDrl?=
 =?us-ascii?Q?jYfzGCMrrmwyQMa8bjArWTGyT83mgy5Zyjs2RxitYWS+AxILDfNVSRAlAu97?=
 =?us-ascii?Q?JSH6It+Dm5VvfjEMAqGaQg6ZM2xn4915RMZbWor5MXgmv57FJmdnpFSfnkKS?=
 =?us-ascii?Q?iZby+qY9HLMAlbW+7i/6h33YMBJUovLS7kiS7W/93+tkuxrwWKIKNWw+7Zxe?=
 =?us-ascii?Q?oWqoBMX1iQqQzrD1o0IFWorvE1s4+4b496nZ5GnSACgLY0uhllJ6FZlXwRnH?=
 =?us-ascii?Q?VsufDQoAnygZm3EK/ReWqi6RAb4pxVcGVMLeRuMtFdPZ8rdPCAQPxzKSi35h?=
 =?us-ascii?Q?370awrtsVKNLhuDSKnld1HM0CVE9SLtgBCoRrA/9RbnvoGDSFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:07.1596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30251883-96af-40b7-967b-08dd04e4d7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

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


