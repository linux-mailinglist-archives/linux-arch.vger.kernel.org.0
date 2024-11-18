Return-Path: <linux-arch+bounces-9134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13DE9D0922
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6127F1F21E34
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35D1494A6;
	Mon, 18 Nov 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AIMBRyUa"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26E146A97;
	Mon, 18 Nov 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909165; cv=fail; b=qX5iKsZ3UPI7IYo9cXazid06W3C1KsEbPWwCSNwHRtFYi2D7dtbpjJrs/mdJyEPA1bBAaIOkF/VOPsZqPCmobZT56TDUfuKxtaj7vE/1MdUKQ0o5/iBRZ9YmhnzLfuILpHYnP63/RC3haw84fWsz9mQOHEXC26lPzyGGZyeiHOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909165; c=relaxed/simple;
	bh=zueGsBGOHqH2gzKBXNI/4E6Blh6vTNp7xyEp2m45294=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDPBNlXFujKr+d5xvv50G5DS3i8VDVLF/w3QXvqUgFgNgqXHKzDhh1v4B2iW8Rgc+GwxvvzYMKCnuvt2QrbrI0jT2dxw21JR9KjVtV/wMnuZdkKUjh9ZAhwnYl6yECzpVsvg7ZUTql9y4yqsiV/TXNXmVFyvPn97xWY64kynawg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AIMBRyUa; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8suCdEwJZgMYu7FPVX3EjxCVNbTggaFfzTj8zlfU2sY+VONoKUcbvm4LkHYGum0Nk8DZYkiMRNhqSb9WsqaG0fkzPuq/Mu0Iz7pvqP08pM60gu32fYycfCgdmhnRFTAV1vQ0ouiELKDjkhI5L57uo5yo8QJ3xv2/siYurkCvIAULUCZaJFr9JbIZ0gd8Py7Aiwf4CdoQYRxUdXgJmCfT+sO7n9cIp8tEetHuCkoM2tRK+palpy70jTyaZCcdimxrMSZlvi8CZU1toCASN1tMnkaXbbVLJIKiqH7q1Vyh62CAOlq57KhUkdGSXMM8pwffvUi0jYgWi3+7WpY0gLKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGKZ4JJ3gS+C78RTXX5ZzQ/0w47X/WABKZZDEeBUVAY=;
 b=C1NsEwVQamklZ71xwOQR8psk3YuNXpcG57JdXVx9NUrXcrJdweAFLOWqmWfggr+NtAR8F0tIJ8r8FU/xBmuguFoHvCCAr1K1fkP8lnRDNePMjjn9gL/MczSlGHLWXwfH8LTe3uQNLEljZxbAGTTw6+E7dXHMNricimRo80xpCeSwYejxgfulhHfBsxrXkyWn6+VHQhcxoEwU9qRy8vI6fANMZTDreCbgDWRcRfB2Qu1P9DYs3Al4vKiW4Fx+PQUMcpTjZTcBxu9c3cZUeD1Ie1wuMAZeU/jrAbR547qDisbFj851yz7bsIdVErYw+x2BuLCP0X60973FD4jCVvYZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGKZ4JJ3gS+C78RTXX5ZzQ/0w47X/WABKZZDEeBUVAY=;
 b=AIMBRyUazKklq1cUL1I/IDLUwIv9ii60z+I6O+hAqS0aoU3iL9zWPQ88zS3TKsmA+3pM1FOE4SEn3ZjkBEKBN/31CfDAeZ+tSMGeRe8HRnTd7070Ghpw50/zj0rdLVZHSltMJVQ6JlsazkB8Zf/H5t4GZeaRdgfolyqe3V0ig6E=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:52:40 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::cd) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19 via Frontend
 Transport; Mon, 18 Nov 2024 05:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:52:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:32 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 8/9] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Mon, 18 Nov 2024 05:49:36 +0000
Message-ID: <20241118054937.5203-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a623a5-eba2-45c7-af0d-08dd079535df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsxRfRUYz4yIYOtUgE0EIzP9DD7OiYnBHdnLQ2b9OdkyfYVS+76Kzq+s7W1A?=
 =?us-ascii?Q?+4f2THOvDFS1yizfvYb48Vcuf6Nbo+fd6jC+4PWNRkoi2VZoDqHLAkH8Ti6g?=
 =?us-ascii?Q?vPnIvKGzyA5rxBucmBN9h9knUkcZwsQPhB5Eu29nE3/5jO7KYnAjRXqrko6m?=
 =?us-ascii?Q?PPUe3lT3u8t6AnhK/IXIySRfjMTS2Xluyn8kuimQ0ATMD2+stOUewyj9y2K5?=
 =?us-ascii?Q?02GKQWFdjSooj6VpD3guuIarIlO/x0byfcpZjHejXOMagSYKtgra5xenwEp7?=
 =?us-ascii?Q?QdE+6coItwVx8IMecE0d1tOdfMxQ0GpjrMIRRWMBPUNGRoqxE2fXUEOaOsCb?=
 =?us-ascii?Q?AH/geMa3CRXw8gm5HYY1/aAtzoorXSbqYLRL/NyQMXQa60197yANQzgc+0g1?=
 =?us-ascii?Q?ERHix23hMJ+CxrrXQ2MLK5inYHSOH2u2HNgsGI6yM4+X4I6XKEhoO+cwIEMP?=
 =?us-ascii?Q?wDiOhvo6Hu+jclYDZPUuUZwNcPrKdKfsib2pQWOafwiPzfN2D8I0XQQzSQkl?=
 =?us-ascii?Q?Ifl/eaGAjeUWpcm76SPJ7+GbJG/zMMWfdcZ/GA6FpQFiegaatQssGbBfbB0n?=
 =?us-ascii?Q?IS9rqdJnWUec8vQd5nLZ+Btonl6MU13kGw6iIuX/hy3diI25b5PqTPMSS8iW?=
 =?us-ascii?Q?iYIS0RkkL+aOOT+LLGdZHewRL2ybzIoHFiqOGqaHjoZ1/5nosUA4iAhnRPBO?=
 =?us-ascii?Q?08tIApf5LsjIOkvZSeW4kGCm41Duo+VFUtbZzO/qe/ItUPt2a98qV1/h9aZf?=
 =?us-ascii?Q?aGJJH/3rdg76DE28yUf+u67Z80dBR7PWWItAXKdzDj6e8rdJf21wYwErnCJz?=
 =?us-ascii?Q?vvmaptJaYmS85f/QFHqaUjXoxnsSZW8lP6vM4qGnbCuXRGvnyDiZi0++lmRn?=
 =?us-ascii?Q?z4UHxAXpGTk9/wH8j3MhcrBJN8wXGJS2rh1RapDGupXRL7Ey+dEKOKYdLK8Z?=
 =?us-ascii?Q?R9xZGLZKXVVPdEyoFqjmjnivF1DOwzZ2iGQQBkrCzqwwBQ8TQ99XiGmSEo1C?=
 =?us-ascii?Q?J8WhpjDmbVUEnzPk7Nauov9LtXXC0wl+TFRDKz57DeBAenNQIIJoyWcfboCk?=
 =?us-ascii?Q?OBIzUeTkixtBeBmnK49Bo+0iQHx1tDgNM5gWjc9X9k1LQ2iuSbSFurYwaCPh?=
 =?us-ascii?Q?SnT5rdpTOglExYFSAO402U0roikP/lia930oizdU4+k67Ea9+VHBamy3pjRX?=
 =?us-ascii?Q?+K6b7pLVNTEM01SO66mUaGrVlRx55NGBILCqZgDGgT96joJXCJg58Fv4RJE8?=
 =?us-ascii?Q?D3nIba9yCJvuo5ZSfLDmw2ebcSlEO7wN2XXh7BVI2vIzbLq4u0ZGAC6q4bSc?=
 =?us-ascii?Q?mzXO+R2ZBLerPLZXCyv1qhQDqPP2m3uPop2XPXtWODuKpHgaQUP2/RTCY5+g?=
 =?us-ascii?Q?7MiZX/rU2vNw3ZQFKGCRdvokPuI+lzkQnhlDRAcl3OJPOAu68g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:52:39.0133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a623a5-eba2-45c7-af0d-08dd079535df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 43 +++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f9260bb8fc85..7b43894f6b90 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -185,3 +185,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6adab38cb84b..b9d681d12810 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -347,7 +347,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2838,12 +2838,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable)
 {
 	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dev_table_entry *dev_table;
+	struct dev_table_entry *dte;
 	struct iommu_dev_data *dev_data;
 	bool domain_flush = false;
 	struct amd_iommu *iommu;
 	unsigned long flags;
-	u64 pte_root;
+	u64 new;
 
 	spin_lock_irqsave(&pdomain->lock, flags);
 	if (!(pdomain->dirty_tracking ^ enable)) {
@@ -2852,16 +2852,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
+		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
-
-		dev_table = get_dev_table(iommu);
-		pte_root = dev_table[dev_data->devid].data[0];
-
-		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
-				     pte_root & ~DTE_FLAG_HAD);
+		dte = &get_dev_table(iommu)[dev_data->devid];
+		new = dte->data[0];
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		dte->data[0] = new;
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3128,17 +3127,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-	u64 dte;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u64 new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
+
+	if (dev_data)
+		spin_lock(&dev_data->dte_lock);
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	new = READ_ONCE(dte->data[2]);
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1


