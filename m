Return-Path: <linux-arch+bounces-9093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3B9C9290
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BE1F2245A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3241AB52F;
	Thu, 14 Nov 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3JnRGJKQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DFBE4E;
	Thu, 14 Nov 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613520; cv=fail; b=JlQparyyjfQm6Gmgxz7WTJPzbXHgSHnZIzxi9Zw+Ep3fjgoDRarLKU+vWKRydj/ceDgYzrZs8X5J3fmJaOpB81p2tMtIuSaYJRkxcCEzLWzGNUHpi+O8O5Pj79AZJyB2BtXjCWRGDj4la7WAy2xkV61mtSWfzVOeWI6ORteJcm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613520; c=relaxed/simple;
	bh=aqOOkxtxrHq9FyXo0yTVnpObYgB2GADdbwg821CPCgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGSG1FaaqfxS4Lc25gks0d7vfOZBEPC325PYjJ85gPFMbW3anngHuMUOqp1PdeghR4mNRpjODIjQVYgKcBA7Gmz4PPdMCsPGzsVpZrWH8CECAayq4SiFFPgq0yXxqWlJKRA2Ukkx+WYNm1LYrLG1LwGlVypZsRsoa9ZQvpCbBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3JnRGJKQ; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTdIs4uGB9ZsnoDXnHJ1iXjgc5N9ZeA3lZe3k2bbDZVF2bSn6lkL3E+9PopSaBpqPk6lDTafKUCxnits5T4kD+RtqMPaKQC0IjSkarDE2WtZAipxSMH/04+hHIwh0MNqeeaBaydlP6hO0LkbQm+qj6kyHFGXRyjqqkyfplCvgDGUYHRU+xC5nB2q9erQm607QFY6Z9keYwwW86LGXgKnHYKkKYNnvXWv7P80kSS8+i+/6bhOWGwSGge/P0Pn5ZGbHVAdjndDcGYKbE6IUkFbkPZPO7URE0RoO6JSPRklgEZqUAspfRpaIVq98kruoK1mU4HxunjrKf8fHp4jRQiWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDYxgIDGppc7nsmlPgsXp5/B7SogmpnnGXWxJ6ePU7k=;
 b=SXPv1ehQnuzNoxfi55INdbOK7hnCU54cothvouNk5SXQJRdCSPq9Y8ITuN1cvr0yuZMbYSRaxmAeS/OpnoSXTjFNEE68+uPXN7WPBy1OCGT3miPgVQrhOYhRnOOBVJ81zYuWOBOmdzOwt/trowYqVb+1lUxNGx6g1sqX/D/AfIvCI/vwGEhRkd/rdNmlvp+kuqRF+rCe4WXJgBgTZspU3cABR1u+mh4AaK4k0aOH3Jobz2IJ+nTn06MRTYEs10lv8gW0xFBR5D2Hd3gJMVt3RuTqTys+1w5pKqSehz76AS/4kAb1IM+ykl86zvmWaAb338rDmNkIYhTc08Vh4w0h9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDYxgIDGppc7nsmlPgsXp5/B7SogmpnnGXWxJ6ePU7k=;
 b=3JnRGJKQKp03Cdr9itaRAjZI1zJD2oHbZNbElsfeVaninT4+NGeSyxWCWokDCEs2tdEE73+zkNuSlLJxdIpUI3rztpIwBiNrJg0eDm3Dai1b8G42WovWi+4X9P8KVxh2g7yFCAvBdeKMGCumXsOXLBBzJDybOSbVEwZ6I8ouSaM=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 19:45:16 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b7) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:15 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:10 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 4/9] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Thu, 14 Nov 2024 19:44:31 +0000
Message-ID: <20241114194436.389961-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: d637c0c4-769c-4d4e-58b4-08dd04e4dcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhvqHUUpBSzCDqtxtRq5yp6gFZM9CYDMd5XqUqUIJq1Axux1yoFlQIXLoiE6?=
 =?us-ascii?Q?pxSYNeuSeb82pszz0gSPUVSs8a+DsUJQ3TSH2k7Mqm1bTnjPxEFNEkz2eSfM?=
 =?us-ascii?Q?0gydY5HhPc9hgy4L2DKyN0nHZY8MWCUpfNVgQihUBQtz9eThxQlAvWjt9bs6?=
 =?us-ascii?Q?+DP/HKZsMGDKMLEDvOMnQ1UgYmgy9kdyjKHk8J1ewKwDk8irYE1hk67E2lll?=
 =?us-ascii?Q?l4Av/ikUyu1Bor8i65VhwrAFO4qrYJRCcr+z2/VEXp8salcSKDMYDfpfsJj+?=
 =?us-ascii?Q?2HV71OD3d5BLZQxM4fyvxJAnx1JgU5+Oxu/RLfH3+rkHnnefbr6Cj6tcgPJW?=
 =?us-ascii?Q?ohr2oBXjwlszezdxzx9CNrNL01vBN6GPUA4eJWYaUwrKB20xhktix16ZLzHl?=
 =?us-ascii?Q?qGHlysZ7UhVvxytg3eFJET/uVSdTLi0yK7JJh4toIUpQXZ+BEmbev7K4k8Pj?=
 =?us-ascii?Q?saeGXWZl0QoW8yUwEu89kjAzJkSIEMNN0EpvWpTgASc1ITwC6d0ibkuw5MFV?=
 =?us-ascii?Q?Las8PYOkBIKU2nXIiNuRMD6KZWjs8asC0Tqivqq0Pxs8INkQU8UxuG8Wpb7k?=
 =?us-ascii?Q?kPfuPxZktFekBi+xDWWlqnLK5rUfYgbWPJtCjEAot/iJrTaBUjKJqcRQ9Uop?=
 =?us-ascii?Q?t75I7crb3ip13a9cpawcm9Lmj6+vIhRnnqSOU3CVXbg218IbrWN2xR6mvkCa?=
 =?us-ascii?Q?tDXps7PfuhqXWQH6hVLPzN4Q2yREH0u10RBMkdaNdJLPJs4nXHCoQhUT+xZ+?=
 =?us-ascii?Q?ehWjkXqfuEZI6Mn60OvyVSbN3wxFZ5sc1zKXM2oOTPXkL8GRslTh8YFJIO7x?=
 =?us-ascii?Q?h5BWsO7UCrlSfQgE2B9BBEvy480ujsSxsam5/10/BPMpgV2xsNbNkjyy8hRp?=
 =?us-ascii?Q?nYoirSkvPFExBj1wnseEObbqdECD6rXc5CXRy4YMBVG6zvbSkwx0aAtQKiCb?=
 =?us-ascii?Q?qvIxCkgPfx370knYpEiPFrsen13d61L/C2ORUXBjThhF3+xW8CW8W/L05ZcH?=
 =?us-ascii?Q?GilExRfjHPmXq353iIsXViwkTTzfSKs3fEPQn30shZC72rncHwU9OYCenA5M?=
 =?us-ascii?Q?Y+C5it91DnILrc0NjGJ2TbLDbj8afQMFWyW7jzvnyhidJ4s9cn2KpwOK6lVI?=
 =?us-ascii?Q?biPgGCKWJgMLJ4SQnU91qd5UCtMFz0syTiJmVG/OVxzcOaHtCzS/9Vm8XfjZ?=
 =?us-ascii?Q?FnrpaHA8W104+IxUHERRnBfEzAPCwpMvNYLw84QO/pShtrlqWk2s49Dnig1z?=
 =?us-ascii?Q?XS6Pz8+K8ELLTIXCUAmIlvZ3EnpvS3MbQ1H5zWMKtthKCzdNiEG6XYKhlEOQ?=
 =?us-ascii?Q?3Nhrxk2aCgjOsG1CQe8mjtIUXcd1PeXdypArR74HHZRNiHQROEIS2iRXPETa?=
 =?us-ascii?Q?hKaUK566ZkJkR0sJrVougg24ihPcDLcGckHdHOlzyKFtfHbmbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:15.6842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d637c0c4-769c-4d4e-58b4-08dd04e4dcb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820

The current implementation does not follow 128-bit write requirement
to update DTE as specified in the AMD I/O Virtualization Techonology
(IOMMU) Specification.

Therefore, modify the struct dev_table_entry to contain union of u128 data
array, and introduce a helper functions update_dte256() to update DTE using
two 128-bit cmpxchg operations to update 256-bit DTE with the modified
structure, and take into account the DTE[V, GV] bits when programming
the DTE to ensure proper order of DTE programming and flushing.

In addition, introduce a per-DTE spin_lock struct dev_data.dte_lock to
provide synchronization when updating the DTE to prevent cmpxchg128
failure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  10 ++-
 drivers/iommu/amd/iommu.c           | 123 ++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ae5f1e031722..ea7922b06325 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -427,9 +427,13 @@
 #define DTE_GCR3_SHIFT_C	43
 
 #define DTE_GPT_LEVEL_SHIFT	54
+#define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
 #define GCR3_VALID		0x01ULL
 
+/* DTE[128:179] | DTE[184:191] */
+#define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
+
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
 #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
@@ -842,6 +846,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	struct mutex mutex;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -886,7 +891,10 @@ extern struct list_head amd_iommu_list;
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-	u64 data[4];
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5ce8e6504ba7..7e0b62f2268a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -83,12 +83,125 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
  *
  ****************************************************************************/
 
+static __always_inline void amd_iommu_atomic128_set(__int128 *ptr, __int128 val)
+{
+	/*
+	 * Note:
+	 * We use arch_try_cmpxchg128_local() because:
+	 * - Need cmpxchg16b instruction mainly for 128-bit store to DTE
+	 *   (not necessary for cmpxchg since this function is already
+	 *   protected by a spin_lock for this DTE).
+	 * - Neither need LOCK_PREFIX nor try loop because of the spin_lock.
+	 */
+	arch_try_cmpxchg128_local(ptr, ptr, val);
+}
+
+static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old;
+
+	old.data128[1] = ptr->data128[1];
+	/*
+	 * Preserve DTE_DATA2_INTR_MASK. This needs to be
+	 * done here since it requires to be inside
+	 * spin_lock(&dev_data->dte_lock) context.
+	 */
+	new->data[2] &= ~DTE_DATA2_INTR_MASK;
+	new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
+
+	amd_iommu_atomic128_set(&ptr->data128[1], new->data128[1]);
+}
+
+static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	amd_iommu_atomic128_set(&ptr->data128[0], new->data128[0]);
+}
+
+/*
+ * Note:
+ * IOMMU reads the entire Device Table entry in a single 256-bit transaction
+ * but the driver is programming DTE using 2 128-bit cmpxchg. So, the driver
+ * need to ensure the following:
+ *   - DTE[V|GV] bit is being written last when setting.
+ *   - DTE[V|GV] bit is being written first when clearing.
+ *
+ * This function is used only by code, which updates DMA translation part of the DTE.
+ * So, only consider control bits related to DMA when updating the entry.
+ */
+static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new)
+{
+	unsigned long flags;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+
+	spin_lock_irqsave(&dev_data->dte_lock, flags);
+
+	if (!(ptr->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is not valid. */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!(new->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is valid. New DTE is not valid.  */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has no guest page table.
+		 */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has guest page table,
+		 * new DTE has no guest page table,
+		 */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
+		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * but have different number of levels. So, we need
+		 * to upadte both upper and lower 128-bit value, which
+		 * require disabling and flushing.
+		 */
+		struct dev_table_entry clear = {};
+
+		/* First disable DTE */
+		write_dte_lower128(ptr, &clear);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+
+		/* Then update DTE */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * and same number of levels. We just need to only
+		 * update the lower 128-bit. So no need to disable DTE.
+		 */
+		write_dte_lower128(ptr, new);
+	}
+
+	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -209,6 +322,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1261,6 +1375,15 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 	return iommu_queue_command(iommu, &cmd);
 }
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
+{
+	int ret;
+
+	ret = iommu_flush_dte(iommu, devid);
+	if (!ret)
+		iommu_completion_wait(iommu);
+}
+
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
-- 
2.34.1


