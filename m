Return-Path: <linux-arch+bounces-9055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88D9C6EAB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38746281C4E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5E204F64;
	Wed, 13 Nov 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMw34aOd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534B2040B8;
	Wed, 13 Nov 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499455; cv=fail; b=gAXIDtj91Px5Nntoll2Li02/GGirG6Q+4n0qCghZ+5/NkA10s9V1xB/BXJhTlK9s51cI7AB4fgneKDS1StErKzZXhS7uvEi83Yw/s/j096ajSN3rV6veq6gI7dmhqxPMyEHcdq5tzex1ywjIk0J2itRIgodfm+b42mJM5y4iMro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499455; c=relaxed/simple;
	bh=msxCgxP1ORqWQZQD2nLcCf2D5abPd29sgQHAI1FJlX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx+tKopIRRoxk2fOdnDno7BYpYActpSBRDBm8RFbbNKMkxDr+WdwyM7Ij/yDKBv1PfdPMzR9N7+dnpJ9fPzdPJAeSaOuzMI69AidiM1ErJjXMqDyBZjfcYMHs69c/oViMbfz2p9xAxcL8NVW61EUySfnAf60kdNl5TiEky1yTys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMw34aOd; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWTGLAgc4Z6LLSHoZmG+9zRmst0xTavts1HRp/AJy+sMJYifTTJJxf+g09awyCC7lQwe3FMfOUrGrq2FeaKgAnVxfLzjXpoKpOxov7WxO3Xl0JrJMjR5Oi6X6psv/GpvOffHYruIZ6QvObwn+zdxxVCyQnRMRr9LWdO+VMv+dN9TQJbfJ56Fk0UBO0b1UZqysDeDs2ZKti/zUbrgadv1ZEECjWuMXf8ktHBeX2wUs1gCgdYX0O5fxIyJrzJlOkulrHySBFRJ4GpiTx/FaFrfHHYMiMZE7Yv1efFsVi0t/5rC5UnAhv98coZQQSFJx6MZ5M6PMUmEMNftV6usGsWM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgEYcQUviXuP6wBbmWIp7qYsoLr7mgolz2TGwhkXakw=;
 b=Rf8RaU1ozIeFRzYCLz186yglG/xd3JxzwWRLFBaG9kDWWmKZN8XqLkEDtvOQFeV7LCkCOlEw4g8WErMvsEZb3nYkv+/vYUeiFZFbb8UnSM7q8J8JPCBJXyCBU/Z06nh7GeNgwd7G+VWE8CgPGhWkltiqkprU4nw9E5rdpNrbpcSC3K0YeGMP6CLmk5Y10fpQdKpf/74FDk1+l/8NRSrV4a9Cmb7CA26kt6G0becD6wKPqs67+r77DmzhfTUPt9lOfOQazsrRIf6bkGz9zg87yVSPm+LjOtV8+kSD8ehyeJhRVZP5U3Txp19G0mxj+LS88usNhtNXL+L6T9RIA8dA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgEYcQUviXuP6wBbmWIp7qYsoLr7mgolz2TGwhkXakw=;
 b=BMw34aOdcaQ+2P/NSm5R8p4SqcVZCDbtTAH0Y4JgLHovmsBpuGlvJk8MzUQ5AKnEM8AasGnqfDLrpFrrQ5uwp2bGC/PooL5R8iUpwbV0eAXBc6QDe/qOCNFeCCCMp/5htTdaWj7QigfyLX0tA/f2+rpojz1D1cyTLs1oKQxibRM=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 12:04:11 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::e5) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:05 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 05/10] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Wed, 13 Nov 2024 12:03:22 +0000
Message-ID: <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b19b84-0e77-4136-7fc7-08dd03db48d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hA0LmhPvpdTPdFHzFj82JnFMy5EMMSzW3aNIrdpAb9YkuQxo1RZbCAYtFDFp?=
 =?us-ascii?Q?rm7VjDTq7ByLvqOxiD2+Xnq5o7qE6thwhUbuEF1mayExpDRyH1n5DToZUwYr?=
 =?us-ascii?Q?AcKxYSPcKI+RAUhK1mjjTH5hzob4B/Gw0vpyWDwmvmz0a+Kt23RJrTyiljgv?=
 =?us-ascii?Q?2WoQYK+9QcZpKyxADqZuwVJK+qiUTtOgbCbgfT/QAKWVFolGQUzfSW2q4+pG?=
 =?us-ascii?Q?2zYKZr9OQVMgDdrWvAkPJ8zvgZcs538jq704PKmIyTuauvfqwcstGviYXjLR?=
 =?us-ascii?Q?bI/9VO/ig+em+71COWzvKZQAJisQzT+W9qy4xySfO7bLA0sWpgci3/LYWxWE?=
 =?us-ascii?Q?L5PxWvRzHpCJ1kH26bkcvHsCkqjQ5zHhln8MpRDTGX2Vds8uX2dBYI/CTOhS?=
 =?us-ascii?Q?VZDPa+X6K0w2xjD/zBu+y2grpEfD0sUbvMVwZwj+HLaXDo16JOoVlEhV+VQ2?=
 =?us-ascii?Q?7nbMQQBjFmo6MGlKQ3Q/fzZ5mxFWYXrwJ8T1rXNuQsRc1f9szfmrlY+vpNCx?=
 =?us-ascii?Q?PC4HzXptsDX5YP0h0kHcvLlz4Fg7pf7wmAr6tX8RJzKVOkC29T6JG53uMS7Z?=
 =?us-ascii?Q?QtloQ7LWptHniVIi9ciuKqyxb+gUt9YjB1E4hbhxEgzYs/MMbXaxKZ9+PYKh?=
 =?us-ascii?Q?It7c5ZfJxNdxnOFK3n8pmaboIXNO9JXavhJsAxDlkMEsjYDFkGuh2R9hG5lB?=
 =?us-ascii?Q?k5DkFlMSy8T3AmLueopeJ1zS5N6r+tYJiX75lTCru41pY2FQeLhCroVrf0xA?=
 =?us-ascii?Q?kBxfakJtI7ow7DP3SaCRuGYyyTNqNj2HGfRmUriEiy6YIJlgYBKVjNo1Gil5?=
 =?us-ascii?Q?TxK3HaQxBFLJO8CYQgRSX38lCDwDDXrQg8HNnf1zJ0PPUHGaWWLCJT8NmHOs?=
 =?us-ascii?Q?V3xhOGju+IQqXLWgoiOkqRJf/4KvSMRVKRHI0pggfgDiqG+Mwpx3HvymFDWd?=
 =?us-ascii?Q?4tUZLXKUuK3z/3RzxzOR8zTa/BBAOGkji8V6AOnZ0+/nnZfk1YqI218Zwsr1?=
 =?us-ascii?Q?A30BfnIqonur4wpA47CDDHJb0pm9ovHhHc0QmNAIJ+BRhvA3WixrrUFqpRlc?=
 =?us-ascii?Q?wAKZ1CUbpG7JlDjxsy+Gimjn+LjdprOcrSDkP/MbnaOHP0OoRnAp0KqYZgsQ?=
 =?us-ascii?Q?5ThqyaEYJjEVC8ND0QO8M5ZX7OY2SqP9usyUPKdpbPO5FKgkJcuyY2aBhAHp?=
 =?us-ascii?Q?OeBx2Yr+rsAYMW5rBAMp6awfv0msTJG73POVfnyZslhHHdcN+luQKN0hQ0lf?=
 =?us-ascii?Q?ITcqdGM3YSzBGF5MHAgMkgvfZQB7XEBPjUZ7p0Wat/ikNzvOOM1iZqFmA77+?=
 =?us-ascii?Q?tvpdrIaplppCuNZ68CUWv2W4o4vuJgzVHk05q6WSLBYt3fKVmM9Zk7FDkg8X?=
 =?us-ascii?Q?vr1AjqXbphpOu1QlPRw+MZuCK9kg6l98hogxzRC9ZRoKi2IiSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:10.9381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b19b84-0e77-4136-7fc7-08dd03db48d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  10 ++-
 drivers/iommu/amd/iommu.c           | 116 ++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)

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
index 5ce8e6504ba7..d6c814bd1443 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -83,12 +83,118 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
  *
  ****************************************************************************/
 
+static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[1] = __READ_ONCE(ptr->data128[1]);
+	do {
+		/*
+		 * Preserve DTE_DATA2_INTR_MASK. This needs to be
+		 * done here since it requires to be inside
+		 * spin_lock(&dev_data->dte_lock) context.
+		 */
+		new->data[2] &= ~DTE_DATA2_INTR_MASK;
+		new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
+
+	/* Note: try_cmpxchg inherently update &old.data128[1] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));
+}
+
+static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[0] = __READ_ONCE(ptr->data128[0]);
+	do {
+	/* Note: try_cmpxchg inherently update &old.data128[0] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));
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
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
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
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -209,6 +315,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1261,6 +1368,15 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
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


