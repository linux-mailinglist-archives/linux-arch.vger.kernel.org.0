Return-Path: <linux-arch+bounces-10179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA7A39A29
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89303A1D97
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195D23C375;
	Tue, 18 Feb 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jGDkGd08"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4623AE66;
	Tue, 18 Feb 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877146; cv=fail; b=t+IuYYcrY1955oAdJT8U+9Li/wLRxfSPTZ1Px/1IqGApePjHvB0jlMlKp1AyU5SJLj6F7pIXXFATMZNnLB1cqfHJfRcP/8Rs1lqFuJsO0SSnMvwexRh4zDOgYs4iN9n4VLWkc7FVVmglVeE3AEjgaVX+2Y1zmrGrOHZBONP4SpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877146; c=relaxed/simple;
	bh=HpqxHwRu2ZZbs9lsavtmR++ODcwxzEgj7NfYwMIObLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2S6J6Rr4zNBdxm+Yrg1nYrIMZ/hdIK7pSkjWxY8ntsbWIMkrbd+PGtA1JrmPJe6928kF4c8A16m/KfBVUjF/qcXC+pSVjzx9nribborZ//wKmbtb5ZJcD/JQc49CEQfQKn1BjXRjaW2Q8HLJHX6UgVbHzW5SQXQHcxbwp/lMZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jGDkGd08; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVFNIe4lGByLqZel1ONxi6lS69/1u0KMsLiqAAMp74WN3WmUgBU96dTQqtDy7tlUMY3XCmiBus4l6tOrznPL7HRiH46ozKxv0oYL3Fv9qQLvqjrLTgqEVc1DdVBrvVMyMP6nSBdLRySD+VpGLy1tScKGqiVBCcRkG2iwM71KVcfoDnbesR3d6mu1k1jO0JxUsDPnpZCIKrTavyqZEWHpBVYmXphLNMzZUNMCjirPGtxmA0o1cU1yadBefkO7YGC9vC3W4zl5Ukjl/lDweQMH6zMhU+X4rdkyUXS6JvIvh18mN+lwyGVBzI55jklGLWOigNXZ4eRLWQe6+b7C+smtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufoxHWke6ItB3sBesXZRtrjbsDVty9Kphlni7y3dSdE=;
 b=HhCUP3UorEbBgO/KmC9+YY3mBguWemU0zRkhyJpyRppFUaLXKWfPqRK8L7utG4jbflz0xrx+Or1ZOsL7SY7fhVS7P89l7qwZn5nBNkOjEQIsyw+m7ZUxdTv/Gld0jfoVOVVZRbRJyWn39pycexantbkk9XB5HwIpeV2Yc0S1bk/pfot3Z1sX+3fG7057rAJRzdX9AUZsNQ1t1zfVYuY26DOD+NAK4R4/w4y4taZSf0Fq4CrCfGpasHzA5KYn8D9o4WOxgyZLNb8iwyiKr8VJQvzwi1llZxHwcdkbSNA/8O4xCsPkjHo/feHMWKlYdFnMT2eCN0ufTdmQjCts/sFfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufoxHWke6ItB3sBesXZRtrjbsDVty9Kphlni7y3dSdE=;
 b=jGDkGd08yF2VBrUMioIPlijxBzuNi8wEKZb4Epa7RPyGeWMtF2lAOG3/YXoECtOIyGySo+/iSTDV68Zw/nS2OpITiTIt+aDMZIsVON93Yx8wKKcCk6TWca18uu7uCJTO1bKi+XkE7/HNdL0NKxH4q2Q/rSkrVWmXqciHofGvass=
Received: from BN0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:e7::13)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 11:12:20 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::ce) by BN0PR03CA0038.outlook.office365.com
 (2603:10b6:408:e7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:12:19 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:12:11 -0600
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
Subject: [RFC PATCH v2 05/22] crypto: ccp: Enable SEV-TIO feature in the PSP when supported
Date: Tue, 18 Feb 2025 22:09:52 +1100
Message-ID: <20250218111017.491719-6-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7767ee-2a79-46d1-6a0b-08dd500d1c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+voZlhN+3NRamuW5dTq36QHCiTh83cH+cM0S0tMrVDMrubSB5rSJMXw9eMEs?=
 =?us-ascii?Q?DGEbdwZlc5ryLKVOQ4U1o/Cy1Qa5Z7OQmHm2QY5EfGYQp5MirjwzDD431r2D?=
 =?us-ascii?Q?uwLd4SmCRdwEZ2QrZRbsvbFA5N5FCC+2ifP94CmY2fbKVWPxKqjClXgRxRhd?=
 =?us-ascii?Q?mvEi+DQmEq5dLDl5UKhIBxgZmIaeaWP9pY7yF75kiWFBtm1Pd3/83uVp/PT2?=
 =?us-ascii?Q?9E+hlOUevYRf7CCsRpjqEKcJP4JFpMVzuUAlDg5YxkfqGWpITPiGNoF8RA7U?=
 =?us-ascii?Q?uLQzA9fP6YmUlOytR3nKIecPS8Jr+bHir/zHh5PLfDXZj4m292KV8i2euel8?=
 =?us-ascii?Q?7ZY+w1YqfQ9Dju+4M78VQPBUJLT5vFdjSXeeyDxk9sIhRUmgSIooEZfvCaDZ?=
 =?us-ascii?Q?QmOAWiLWlArVZxUFzTE9XPIwXoDyR8VnJECj1pMlol/LrOksH3fOTNVrEQjD?=
 =?us-ascii?Q?JOdV3exXdegJi2xmBI7k1mL3OXeh/gc+U0UQkDM7do6wcy31j2KLtzOCva7L?=
 =?us-ascii?Q?W2hQ3oiM/g5O14LZDS7WuMg923fOAx+dT/33CvbHzPQwbPTyUhWR/qachegb?=
 =?us-ascii?Q?rsK9X5w8Za8/WkFZKcd2uCqstDMrtiTH9lGTlP3n/3ymg0fnP8PgW47i11X/?=
 =?us-ascii?Q?gJVApkgbjKAVH6gyM0f3dhgSJY62/xGwKDEZuAm63NgRO3tpNmEWPFFsorVs?=
 =?us-ascii?Q?YGN30Y0dJwz/mvKO15o2lIPLlAftZncJxQZlnct6tMdA6QTZ+ec6awND4jcn?=
 =?us-ascii?Q?jDmat54Pxw7ULOwqLB8XO3l8dP+FfKrXBEu5NzBpNv6ussLFy8r4DE7ocPEw?=
 =?us-ascii?Q?uyQjF6RPesoi19rm0VTpO3hu+1XKroWj/DyubcPMkFCgPiTOxGVu3rxS7Ad6?=
 =?us-ascii?Q?NUxTZdaUV/bjXfDXLxCGdtuHNKf+XsrBB7yWi7uxuKFUs/yIGVwOxTPulpxa?=
 =?us-ascii?Q?MXLvcDw9Y1soobzgVIWCx1vO8/XjNJVPpCq4YTOfsf/Bd4pjpS8ugxsmc30k?=
 =?us-ascii?Q?+iU6oRWgVQB59L2zNjnlzZWrGq2abdYyHb5BClWTnrB/pohOjpELiDwseCya?=
 =?us-ascii?Q?Gb58B7I8+QBJzrAe0c1QxqYbeLVErq5ErtX/lyz9/s0VVyrGztLfQz2R0836?=
 =?us-ascii?Q?3hOZ30vqh7baIPRtMuBa3hGZgXiULnC9TgxEJpINdw5N5uYbM/ojEOsLQ1Mr?=
 =?us-ascii?Q?9iFwp89285Ty2uApovxnivpfwPELYGaDknWypUtkyGAtI8t82jkXtL8Lh6r0?=
 =?us-ascii?Q?KusayY2gZEBeRHvQMuM5jHoXErTMzrtp+Iy6OWgFUA2TWkoYI116QQ9qfEHZ?=
 =?us-ascii?Q?K6mTSecPDRH3w0PDCNulDh4aWZa3UDkimld707iEjPm40pJNVilwCpyy7bsb?=
 =?us-ascii?Q?G1da0NS5uC9UYdF90rTiehTBj+yyR7XFNiql1ZXboWaNYDqVugCt65fSLfwu?=
 =?us-ascii?Q?xU2V4dBip3eWrWZBbwR7ldqVZMVhFWQEKt4HVPdz7jGSnFysQzIM448s800C?=
 =?us-ascii?Q?RBJ1kGvrt6DIdCY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:12:19.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7767ee-2a79-46d1-6a0b-08dd500d1c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

The PSP advertises the SEV-TIO support via the FEATURE_INFO command
support of which is advertised via SNP_PLATFORM_STATUS.

Add FEATURE_INFO and use it to detect the TIO support in the PSP.
If present, enable TIO in the SNP_INIT_EX call.

While at this, add new bits to sev_data_snp_init_ex() from SEV-SNP 1.55.

Note that this tests the PSP firmware support but not if the feature
is enabled in the BIOS.

While at this, add new sev_data_snp_shutdown_ex::x86_snp_shutdown

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/crypto/ccp/sev-dev.h |  1 +
 include/linux/psp-sev.h      | 32 +++++++-
 include/uapi/linux/psp-sev.h |  4 +-
 drivers/crypto/ccp/sev-dev.c | 84 +++++++++++++++++++-
 4 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index d382a265350b..c87a312f7da6 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -71,6 +71,7 @@ struct sev_device {
 	struct fw_upload *fwl;
 	bool fw_cancel;
 #endif /* CONFIG_FW_UPLOAD */
+	bool tio_en;
 };
 
 bool sev_version_greater_or_equal(u8 maj, u8 min);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 788505d46d25..103d9c161f41 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -107,6 +107,7 @@ enum sev_cmd {
 	SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX = 0x0CA,
 	SEV_CMD_SNP_COMMIT		= 0x0CB,
 	SEV_CMD_SNP_VLEK_LOAD		= 0x0CD,
+	SEV_CMD_SNP_FEATURE_INFO	= 0x0CE,
 
 	SEV_CMD_MAX,
 };
@@ -146,6 +147,7 @@ struct sev_data_init_ex {
 } __packed;
 
 #define SEV_INIT_FLAGS_SEV_ES	0x01
+#define SEV_INIT_FLAGS_SEV_TIO_EN	BIT(2)
 
 /**
  * struct sev_data_pek_csr - PEK_CSR command parameters
@@ -601,6 +603,25 @@ struct sev_data_snp_addr {
 	u64 address;				/* In/Out */
 } __packed;
 
+/**
+ * struct sev_data_snp_feature_info - SEV_CMD_SNP_FEATURE_INFO command params
+ *
+ * @len: length of this struct
+ * @ecx_in: subfunction index of CPUID Fn8000_0024
+ * @feature_info_paddr: physical address of a page with sev_snp_feature_info
+ */
+#define SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO	1
+
+struct sev_snp_feature_info {
+	u32 eax, ebx, ecx, edx;			/* Out */
+} __packed;
+
+struct sev_data_snp_feature_info {
+	u32 length;				/* In */
+	u32 ecx_in;				/* In */
+	u64 feature_info_paddr;			/* In */
+} __packed;
+
 /**
  * struct sev_data_snp_launch_start - SNP_LAUNCH_START command params
  *
@@ -762,10 +783,14 @@ struct sev_data_snp_guest_request {
 struct sev_data_snp_init_ex {
 	u32 init_rmp:1;
 	u32 list_paddr_en:1;
-	u32 rsvd:30;
+	u32 rapl_dis:1;
+	u32 ciphertext_hiding_en:1;
+	u32 tio_en:1;
+	u32 rsvd:27;
 	u32 rsvd1;
 	u64 list_paddr;
-	u8  rsvd2[48];
+	u16 max_snp_asid;
+	u8  rsvd2[46];
 } __packed;
 
 /**
@@ -804,7 +829,8 @@ struct sev_data_range_list {
 struct sev_data_snp_shutdown_ex {
 	u32 len;
 	u32 iommu_snp_shutdown:1;
-	u32 rsvd1:31;
+	u32 x86_snp_shutdown:1;
+	u32 rsvd1:30;
 } __packed;
 
 /**
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index b508b355a72e..affa65dcebd4 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -189,6 +189,7 @@ struct sev_user_data_get_id2 {
  * @mask_chip_id: whether chip id is present in attestation reports or not
  * @mask_chip_key: whether attestation reports are signed or not
  * @vlek_en: VLEK (Version Loaded Endorsement Key) hashstick is loaded
+ * @feature_info: Indicates that the SNP_FEATURE_INFO command is available
  * @rsvd1: reserved
  * @guest_count: the number of guest currently managed by the firmware
  * @current_tcb_version: current TCB version
@@ -204,7 +205,8 @@ struct sev_user_data_snp_status {
 	__u32 mask_chip_id:1;		/* Out */
 	__u32 mask_chip_key:1;		/* Out */
 	__u32 vlek_en:1;		/* Out */
-	__u32 rsvd1:29;
+	__u32 feature_info:1;		/* Out */
+	__u32 rsvd1:28;
 	__u32 guest_count;		/* Out */
 	__u64 current_tcb_version;	/* Out */
 	__u64 reported_tcb_version;	/* Out */
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 7c9e6ca33bd2..b01e5f913727 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -74,6 +74,10 @@ static bool psp_init_on_probe = true;
 module_param(psp_init_on_probe, bool, 0444);
 MODULE_PARM_DESC(psp_init_on_probe, "  if true, the PSP will be initialized on module init. Else the PSP will be initialized on the first command requiring it");
 
+/* enable/disable SEV-TIO support */
+static bool sev_tio_enabled = true;
+module_param_named(sev_tio, sev_tio_enabled, bool, 0444);
+
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model0xh.sbin"); /* 1st gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model3xh.sbin"); /* 2nd gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam19h_model0xh.sbin"); /* 3rd gen EPYC */
@@ -228,6 +232,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
 	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
+	case SEV_CMD_SNP_FEATURE_INFO:		return sizeof(struct sev_data_snp_feature_info);
 	case SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX:	return sizeof(struct sev_data_download_firmware_ex);
 	default:				return 0;
 	}
@@ -1055,7 +1060,7 @@ static int __sev_init_ex_locked(int *error)
 		 */
 		data.tmr_address = __pa(sev_es_tmr);
 
-		data.flags |= SEV_INIT_FLAGS_SEV_ES;
+		data.flags |= SEV_INIT_FLAGS_SEV_ES | SEV_INIT_FLAGS_SEV_TIO_EN;
 		data.tmr_len = sev_es_tmr_size;
 	}
 
@@ -1226,6 +1231,77 @@ int sev_snp_guest_decommission(int asid, int *psp_ret)
 }
 EXPORT_SYMBOL_GPL(sev_snp_guest_decommission);
 
+static int snp_feature_info_locked(struct sev_device *sev, u32 ecx,
+				   struct sev_snp_feature_info *fi, int *psp_ret)
+{
+	struct sev_data_snp_feature_info buf = {
+		.length = sizeof(buf),
+		.ecx_in = ecx,
+	};
+	struct page *status_page;
+	void *data;
+	int ret;
+
+	status_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	if (!status_page)
+		return -ENOMEM;
+
+	data = page_address(status_page);
+
+	if (sev->snp_initialized && rmp_mark_pages_firmware(__pa(data), 1, true)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	buf.feature_info_paddr = __psp_pa(data);
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_FEATURE_INFO, &buf, psp_ret);
+
+	if (sev->snp_initialized && snp_reclaim_pages(__pa(data), 1, true))
+		ret = -EFAULT;
+
+	if (!ret)
+		memcpy(fi, data, sizeof(*fi));
+
+cleanup:
+	__free_pages(status_page, 0);
+	return ret;
+}
+
+static int snp_get_feature_info(struct sev_device *sev, u32 ecx, struct sev_snp_feature_info *fi)
+{
+	struct sev_user_data_snp_status status = { 0 };
+	int psp_ret = 0, ret;
+
+	ret = snp_platform_status_locked(sev, &status, &psp_ret);
+	if (ret)
+		return ret;
+	if (ret != SEV_RET_SUCCESS)
+		return -EFAULT;
+	if (!status.feature_info)
+		return -ENOENT;
+
+	ret = snp_feature_info_locked(sev, ecx, fi, &psp_ret);
+	if (ret)
+		return ret;
+	if (ret != SEV_RET_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static bool sev_tio_present(struct sev_device *sev)
+{
+	struct sev_snp_feature_info fi = { 0 };
+	bool present;
+
+	if (snp_get_feature_info(sev, 0, &fi))
+		return false;
+
+	present = (fi.ebx & SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO) != 0;
+	dev_info(sev->dev, "SEV-TIO support is %s\n", present ? "present" : "not present");
+	return present;
+}
+
 static int __sev_snp_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
@@ -1290,6 +1366,8 @@ static int __sev_snp_init_locked(int *error)
 		data.init_rmp = 1;
 		data.list_paddr_en = 1;
 		data.list_paddr = __psp_pa(snp_range_list);
+		data.tio_en = sev_tio_enabled && sev_tio_present(sev) &&
+			amd_iommu_sev_tio_supported();
 		cmd = SEV_CMD_SNP_INIT_EX;
 	} else {
 		cmd = SEV_CMD_SNP_INIT;
@@ -1319,7 +1397,9 @@ static int __sev_snp_init_locked(int *error)
 		return rc;
 
 	sev->snp_initialized = true;
-	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
+	sev->tio_en = data.tio_en;
+	dev_dbg(sev->dev, "SEV-SNP firmware initialized, SEV-TIO is %s\n",
+		sev->tio_en ? "enabled" : "disabled");
 
 	sev_es_tmr_size = SNP_TMR_SIZE;
 
-- 
2.47.1


