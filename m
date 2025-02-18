Return-Path: <linux-arch+bounces-10178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E6A39A16
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C1716F053
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8423C8BC;
	Tue, 18 Feb 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Px7ymLFN"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216323C8AA;
	Tue, 18 Feb 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877124; cv=fail; b=EDuEMYMs2Fs9PmFZfUEvOOxsd1enqIci9y8dLlaAIWLB38FpYg4XsHVcBgm+6YRj659vM6V5XY7uNvFSdUzaAcHIH7X1oScyHioGpyaCQo0/gsmPUMlHjcuYXUwu8S17t6+EEJV+KxGg7l/d2gOPNZflV6JfDYd5edditL5tp5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877124; c=relaxed/simple;
	bh=Y7Wsa+Xb2X+VFPkBLwCQWUPIKUKUS3ILUHSf6QnJnyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex/DdRyHXwrkj1axDddU8YoE7oToZ9v9J9ARUG9mY4Qk1iAMV/Vsb5840WevB3kNOqRVfe0vkKBcDOe+TntqnldcdewDmw0NearaT9XWLVVpty1WEO2X2sFj32jyh2amJafOEBtwpguOF+jjLuhM/NsLKJrmDeSsYVY1cigy2BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Px7ymLFN; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMWklWh+flurOA4HXCxeBbfpQtnsEtz/+579W3nG6ypQZPMPEZfZGZuiX4k0dQqQm8rZ/64GRLA7C6ShUH1xX3UlFBPAXX0JH+L3KIflITaP2e1sIGLz2Ywg725EYRialcX2rYfLriQ/kJ6XQsupiFvKfbv41rphB3H1CoCoNO7qXiKShOnS5tU/cKq4Cqj5bCfOSDX/mxZCAZIrsrgs6UE/oalAfgYXTKzToNhvwvCBXIrNaDT+ozKk8tbw6azI0e5WZAXL8vbXeN243vr/Z+JJ53hz4hYFRIT7wvzeAqXJN/i7DQ5KZ8l6UPtzjOirP0ZlInqWAYM+quE79zM/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3DZg1KUVh9AqHcIXcBCgnGEraSW5KDwb5irN2Agvek=;
 b=K0YEsO/AE8wM0m7/PWr/47DpmHt8h15l/6DpmBEdx8TWV2IRjV/qFG5oUJNPq3K1df03zc1RYECPlIG/OnFPm+lTXFfn8xr3TJCDob8JP1vHZygzApjkDU0J6iUTosWvTr794L6E7GvWngzGgJ5DSVwbz36kOMZ1bXbUhryYbTHtcAndUud44wP4xZAY2qa56rqh5LMvaGZYmxavKMq6MlwEVJOk5N2JTsXVkMKTsrbHJsqaLlAe6tsznRnQE6yDAfLiG2KovhdZtF7SyRl9KmgkBWYy+OOaGdTH4SsZQ4PW03vJwJQzpPNGoFp6WP8BqWB9kc2L6CFk8jjZnRO+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3DZg1KUVh9AqHcIXcBCgnGEraSW5KDwb5irN2Agvek=;
 b=Px7ymLFNNmjsH7BZI7JGvDKQY0YtPiLMm2oZf07tjYa9j6G5PmzbswuWhU1O3reNtNiq/rDi7rpXRfX5nsyFcfCcfgph3hsxOGHTc4GwLfq6WKNox8AwaehtSXrdX2cFLcpqGl87uHDrFlnUB9/Sv2Oj1GI10FqW3AybX7dJ1W0=
Received: from BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:11:59 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::6b) by BL0PR01CA0026.outlook.office365.com
 (2603:10b6:208:71::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:11:58 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:11:50 -0600
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
Subject: [RFC PATCH v2 04/22] iommu/amd: Report SEV-TIO support
Date: Tue, 18 Feb 2025 22:09:51 +1100
Message-ID: <20250218111017.491719-5-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: bd982f6b-2642-4d1e-3955-08dd500d0ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dx+oyvsVfXvnL8SmenmpbtHZTBuHzc7sf7cJyygCNRX0GHBML63vUf6ouGfQ?=
 =?us-ascii?Q?QaTNBq8TYzvL7Pa5i4IsO/qQpV16yM7EOhOP7EGXua9QH7bZsmiFyKAvmxXY?=
 =?us-ascii?Q?rto9bntQ2VGdlTcuowxOAkSOQeLO1jXvezSPFgD1VX8OV0NXvhx1mTYvVBmk?=
 =?us-ascii?Q?m8SfznZNxczYawQ2/m4UlO832P0r/qxTU0X4CdDWxPzsXzwVK8qQtJgPHLMR?=
 =?us-ascii?Q?G3MDH6v35z6CYC2o/BQ/f0QwI/mBKAXnA+rzf6X8DQnxL4oDK1pjkxp5RbER?=
 =?us-ascii?Q?SzkCIL7f30EQVDCvsrWVLcvIvuIKIPcQBGVykjcQPpagZbHBZL8SfH+nhcV0?=
 =?us-ascii?Q?9te1IDhbvrekK8+dRGG6CEGGU+73eSCOARWtU79KLdfG7oMgsGyW3VbxWD0b?=
 =?us-ascii?Q?8hz/+TFwFOJWgMEPcOmd4fhCZG8d0/snWesWa5K5KdPwYic08zvGhf8PN+aT?=
 =?us-ascii?Q?exdQbZjuoD4G3CVVLXBP1/odO1ay+HlyKhkVkdYEnfmFC4wYjXZrzqKoiBaT?=
 =?us-ascii?Q?2J06RBoQrZAO5ARWssfjcfeFZi47vE3x0+WxBFVqr8JO8ztmzfK78sbHjiSb?=
 =?us-ascii?Q?cAWVUfCIjJKb8t/JLPfSLaMXfAB1yPfke7K3MfwBI7QWKluM9Le9dINvN8jR?=
 =?us-ascii?Q?BmSRAAmggXwIgBMrHNXb61+/i7s78D/PoT+OnhY5tzEZBunRK/c9KbxvuYeX?=
 =?us-ascii?Q?9Va22TkNsNDpA4TdPO/V5CKZBuTdP1AVGEt8kVMH77ziKNE4gQG411IEkrmp?=
 =?us-ascii?Q?AjPaNz/4+tzdV8QpfMMryB+BbUDlIa8w+8TjSc8xeV0VvU7Xm13In0sa1wl5?=
 =?us-ascii?Q?trg65YEB3EBHOyErPmaQX7yXSBJBHK07xsADAELJvOoVs0ck3lwH9jtN23au?=
 =?us-ascii?Q?E+Lutg203SWBR8pdBILGE4PvjLUdWXqxmdtmAK9xcoP9VcToPZl99YxrHuY8?=
 =?us-ascii?Q?yvjJN7jd0N6mgNmhmceD9hnuibhHTmKuio4PRQnt4isqFkj8XgowUdEBBZTQ?=
 =?us-ascii?Q?I5pxqKqeG3bvyibAg04T6glzlGPtdx+JTkvIEEIb1ofg6kEssAPYylEe8dp8?=
 =?us-ascii?Q?XCUE2h5Xr/l9Qi1RRdCQJlvbXTxhXKaJEWhcxPFtr0L+bA+hc/ppeJUxSe17?=
 =?us-ascii?Q?8mTrUl1Da8eAEgFQ8hWUzK2yKFSDjRJKOiaqjOe67B1a5ElTTbABlGNwDCa3?=
 =?us-ascii?Q?HJR0fSNrj13pgBLfT8uDMxjXLNuOl/yqbI4YQ8nzrx5q0v7ZePSGjW5wQ7Sb?=
 =?us-ascii?Q?cO7anUSJqt8aoyxJY+M0ojF47MGVuzxwmBME6ujKZ2s3Mc484c2ZnGtQ7FY+?=
 =?us-ascii?Q?Ih52YJ2Xc6Bzv2kaWUMTTQ/DkZvVQ/QRGKYr4TiMJ+sqzxxvMuxPD0LPNPSK?=
 =?us-ascii?Q?OIrRvu2ZN8kFGu8q98xVytB0ab2NXzBu1+tlnvhu83fkboi3FoGh3yCY/iU2?=
 =?us-ascii?Q?f+HPRPWGQhDHcU5rQW43c8r6lqXzlh1/aWzRzW+nuZF8K7wd9l1S9ODt1tgJ?=
 =?us-ascii?Q?nLk3y5EFUNlW/yM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:11:58.8994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd982f6b-2642-4d1e-3955-08dd500d0ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

The AMD BIOS'es "SEV-TIO" switch is reported to the OS via IOMMU
Extended Feature 2 register (EFR2), bit 1.

Add helper to parse the bit and report the feature presense.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 include/linux/amd-iommu.h           | 2 ++
 drivers/iommu/amd/init.c            | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0bbda60d3cdc..b086fb632990 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -108,6 +108,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 062fbd4c9b77..cb1b94fdb63c 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,10 +32,12 @@ struct task_struct;
 struct pci_dev;
 
 extern void amd_iommu_detect(void);
+extern bool amd_iommu_sev_tio_supported(void);
 
 #else /* CONFIG_AMD_IOMMU */
 
 static inline void amd_iommu_detect(void) { }
+static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 
 #endif /* CONFIG_AMD_IOMMU */
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c5cd92edada0..9f2756d3bd73 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2156,6 +2156,9 @@ static void print_iommu_info(void)
 		if (check_feature(FEATURE_SNP))
 			pr_cont(" SNP");
 
+		if (check_feature2(FEATURE_SEVSNPIO_SUP))
+			pr_cont(" SEV-TIO");
+
 		pr_cont("\n");
 	}
 
@@ -3856,4 +3859,10 @@ int amd_iommu_snp_disable(void)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(amd_iommu_snp_disable);
+
+bool amd_iommu_sev_tio_supported(void)
+{
+	return check_feature2(FEATURE_SEVSNPIO_SUP);
+}
+EXPORT_SYMBOL_GPL(amd_iommu_sev_tio_supported);
 #endif
-- 
2.47.1


