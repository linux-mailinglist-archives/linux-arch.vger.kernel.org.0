Return-Path: <linux-arch+bounces-9129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BA9D0918
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FDBB23709
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359C148827;
	Mon, 18 Nov 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MSquESSm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8D1487FE;
	Mon, 18 Nov 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909028; cv=fail; b=SFpDLcdwPk+aaBrRzqjy81PTozAKRFCyqxRuhb+RN2ZMtP+0iqx8zW41CFd39dLuL1vPSBkC3P9HItoZD6ffSd58xcn6mmx0fcwzcaDOtBgGXO3hwIWsgmS9CKDsVilHDCrMqyImlVfOYbc5mMgoLBeFUxMerC0i+s4YcOZau8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909028; c=relaxed/simple;
	bh=Xgt4V20QqgVI29bvyeRr64W4J10AWVdMDWcMs/vf7qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=octDk8FfgzxnSqe7UixgKAUEXXZ4H4DvT0+7OwTRYxqbvYa6+Et/mZtLGyNl+sNRmde9Pbw/R9fPY9qwMQnIU/21wFr2HrsmAbIsnj9hPkTzZJDhXgQ5iBdGOButu86vmTE74lyKXxDog2SOC5X+rmF5oM/YCjQB3PrvspDK0mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MSquESSm; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O02qEE43p+eRLLJeaVoDWcQ41PKKeGhVfpIs+mH3usA/+AI5l0+py+4uGpNfcA/5eiij1rq3M24SYRTE2tBCHoRaFdc7IPax2IBBnol1+uZyXqZaqotlZztc/Nf2BGLFDy8TQo4LDaO1MEz1Msa+PInoLFyYBFZg8d+Sx6nSN8Cow/tHTaue5nNy38K42S5G+d63lA37dPPgkFD/lxce27aGpkllFZsiL3oqf18iSyME6lXvcsndQ1U1mGwyjHB/bnoOQGc9EVb/ZtSevO3sIAOcXDUWMCuZoXiimx4nazxQMbFPsbooKprzwaVTXg/7hm6XNwVxbEZF7SaXWp0wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE8wBtZx6k8kjcKboRJ/stWlZtYUpTxe9Zurkp0Ard8=;
 b=dJOkrtMnJBRCdRJ+C4OEZHltRCkpDN0i6uW3SfdxkH9vqGZQWWwvFg0c/w97woqk5E6noan7jzEgEvXFVPD/Fc+RAisYxxvIlq7rp7UNBdG3Oqe1M7v3t88mdwlAd8axydn9veGvx48kY6NBEF0BiPx+LbpiCiUHVkOeSh98FextRzin5Dr2+TRNPkD+2WACEHR5rpbUfl9iLOOgJANW4WsjYQnNnIfMTzWe7QTKXvN5IISZk7+ke4i/2OY2T1QG/m7sQIZMhQqIgLuV6kDFN9nJCAtUe3aRHntZ60ZjsTrkNkkftEs/xoCIBPxgWibH2Av/7QvePEwh4I7VW+hj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE8wBtZx6k8kjcKboRJ/stWlZtYUpTxe9Zurkp0Ard8=;
 b=MSquESSmKLsbytcm5D8/6S1Sefqj4Op1F7BYTccWq+oFEuVR+PLduvBTrPX/6oYjjIZFmuGrbPIQ4BqAiVwyWBfP8RVr5YdrqrRi74r+I6JoneXd00BoB1otR2rZkXcM+K5+Ieo/AhUul01sLBe1Iy4Z8MnnX9R3hsKiydzXC0Q=
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Mon, 18 Nov
 2024 05:50:21 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::bd) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Mon, 18 Nov 2024 05:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:50:20 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:14 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 4/9] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Mon, 18 Nov 2024 05:49:32 +0000
Message-ID: <20241118054937.5203-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4f8b79-e8bd-4e3d-61d2-08dd0794e343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?660g7wHnfShfUr/Zqwi5j2J/aoGc9yT4ryngIOPTth8s8YWQPmxNNojyJcjS?=
 =?us-ascii?Q?W1M3aGtUO5JG071TMfQUeQDy2WhN1oqF6wrzUbCuoUCAW43ldH9EMN+vD0uo?=
 =?us-ascii?Q?BGnKOCpiSZqPBT8qSXd7QYkemo6r93e8mDdMohKp1dEdqC+wXehLL3JIHAbR?=
 =?us-ascii?Q?tb8gIYzFAhRLUmSTJPwveQitmpVhba4gLtk2+vquBxX4TARn/ZlRNHm4XAPe?=
 =?us-ascii?Q?MWJWNRowmi+iCwqVMiN/ybUF+zSXf21+xtfQbEvF0YrRWPhoA16MoNuiVZF5?=
 =?us-ascii?Q?rDGBOZWRk/NysThg4UOtq7uo4959mZa34ru1EeK3OaRoObt0Xe0ovz9CfC7N?=
 =?us-ascii?Q?PsCPrMq6lXXwvOZq89mJ2HMsMWrFU518TCLP7e2pXcJdZbpoyi4SkOuY/DAY?=
 =?us-ascii?Q?S3VeGXljOK1IUxew0GRhapmO+9zXUdUFY7G8cnajuyltH5gb06KPkWA4GHLY?=
 =?us-ascii?Q?wZ7I1RUGVs8IR2dJ63wFnDoFf5ykFzAMZz3CC+bUTmAD4ulk9iKMGuSjuFDd?=
 =?us-ascii?Q?xq6sLjdfVK7bCHE+X/w/mPPLbnoBe67hw3w5fGOPE/9rfjH1erp6zefN2LXM?=
 =?us-ascii?Q?X4Ie5Sp7VXTEk8c6GMpHYsyvGtpM8B6FwrkmGpI8AU4GHAuco80pFsSgN5y6?=
 =?us-ascii?Q?PliGZ1PL75TQgpJnu32wRoLHG5mANt+DxUfsOwtR0F8Iv3ftP+uW540feQY1?=
 =?us-ascii?Q?GHazkJFI9t9DGsmbMDCI8zaw0SDnH7bpEmU7GZ5/o/wn4k6ZwjV+gY9U2yWO?=
 =?us-ascii?Q?KwsCTAE4Ro4jr8CMNTeTVGKQNZrZ895BOhA2WKGV39Hw0Oap9Ym3VpZWjw7L?=
 =?us-ascii?Q?zq2HyVz11lJx+dpNNl1eQcr4HAO3NTDL0lCyinniqOTdQxMw4zEDVcFIapVQ?=
 =?us-ascii?Q?CYGvmCm3PAGGnc1Ls/vu73TRmrP4irypJNgJ2HsR68EU/9PnWvmGkz11e/qP?=
 =?us-ascii?Q?ziI1a/5vYEJHlUiTd41WirR+YSbf5hZBtKfFA2pmNzb37YMMF4tMcAheZ5xB?=
 =?us-ascii?Q?wUR93NXCejXDkrxtNL1EbwNNlS0EZSNB4Ntj8OsJ463ZxuES1wlE7+CENEou?=
 =?us-ascii?Q?NlT5GMlGaFMfyRJeKVykYsK1URoGFkpBy7S13pwvoGGdq0fH+vqwU8dpoPDp?=
 =?us-ascii?Q?TwdAsKXH+HHhUBSC97yZnhg1TxNfQsC/FPQT0D82E7BeUz0UsfJFvQSDAj1I?=
 =?us-ascii?Q?QStBPBVKiy0As8PQETVEjkiVUv6i9Y6BoCYVK2hUUUz9f4gMDqFTYIWzoxP0?=
 =?us-ascii?Q?pTyr18tMjwHvMoeP8cUYk2cuRYTbqEZoRDpmJFIvziBK5fcGv2mFxDIexnhH?=
 =?us-ascii?Q?uWTyhdLbtu+XZ0c7GgW4JVdeNeG1qo2cYEu13yUCT/jR1Y/ggFtrwnPfCelK?=
 =?us-ascii?Q?IE08mP31Xea+QSeQnjeUBPhB70nQNQjR63iuEU4S8VcD7b/GvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:50:20.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f8b79-e8bd-4e3d-61d2-08dd0794e343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

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
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
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
index 5ce8e6504ba7..1145a9901430 100644
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
+	 * We use arch_cmpxchg128_local() because:
+	 * - Need cmpxchg16b instruction mainly for 128-bit store to DTE
+	 *   (not necessary for cmpxchg since this function is already
+	 *   protected by a spin_lock for this DTE).
+	 * - Neither need LOCK_PREFIX nor try loop because of the spin_lock.
+	 */
+	arch_cmpxchg128_local(ptr, *ptr, val);
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


