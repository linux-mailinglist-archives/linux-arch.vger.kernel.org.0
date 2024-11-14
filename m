Return-Path: <linux-arch+bounces-9097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4579C9298
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF37281209
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C221AE861;
	Thu, 14 Nov 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CuZwM80t"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EC1ADFFD;
	Thu, 14 Nov 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613537; cv=fail; b=kJOcGSfLB93g+7Vj7MteDuo4JZRDoW+f4EbSvc7kOmhdQkMO7uvbutpC5cELpg/AqFMGP0acIYZsCNMYTlLI8DnEIQzfSZaIhae8d2UPl/wijCMkdTqOrHlM6+ACoFZftA/PM3wKkq+ICNKohg0gv5ZY5TNyzkNSTWPAbTAqI6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613537; c=relaxed/simple;
	bh=oSb3N/XXPFRcHfdk1XRU9RwQmplICbmCl3SuxQtfNd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpAPGsJn/J10Ttd27LOZ7qomA915XPOBYdUntx3s7u9T83Q6fvoPxJtTpzyVzfeRh3h/BQZVHPFpYi3ZHt48eeoPgL/vPAq+zp84OO8k1Ru+nzTUW9/1S8xbMJpqf+zJXXPD72yXxXU+eDOQUIIArXlADfoBKW0xmZLsCh+LHvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CuZwM80t; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4D706AQy8r3gacJwWdipSDtAk/yLqRPdWVd7AhDF7gkGxPQWSjh94ex1knM2lioST4d4KsaVg1gcNVmULAW2KzRQtiN7/k12OVAwKD2kFut2zDe2OYSOCdBF2FdXPPDlow4DPShIpmcgv40v3oo7zoP/MCyk8SzvzxiD71aMqPOmHVWBr6gq5xF33GSqZiJoFWrQD3byeBJNAEXIIZZWRqtdfO9NWkVPUFpsBgKdX6G1qK5xyLXgELnEWeX0nLNI4JYEwVLiq582hniIHYYUS9TqjELItfVqdRZ4iWWiZL5F+LuTjKoh+K+/oJQT2Gwn31Shz8QP7kcTA3iNb1LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaEp/0eo+Lf8t0wRv4JgBilkavW0ldXTrbiU8osfi0E=;
 b=Rc2frXSTd9amPhvlZ6gjuaxwFjaqgr6fnSSaP6NG4WGcBv+n99BP+BTYhtodzQPgHM1WuYw6TQ1/rSh/cnyAwX8XPf26jqvP23Vv/rlg+3pM7ugeu683Vpo8s8022rt4ZBcLoUw46r/jE/rLd8od4UtD3uqELThbkJtf9DZ8mAguNyhTdMVeBx2ZYvrQBCYj64jxnnoZsGSRIRozg3V0rATY+hosuE2Go8JFPt6zGVsBhyibR6DXWNp9A0/NP4D6xDvJ2+4Eko4aC0MCEgL/+pIwSLTCvWG5N8K9x1lGAefNq5eCDKO9qrPqzwEmk0YaMBiSkvfx87JlHAHSWZ12VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaEp/0eo+Lf8t0wRv4JgBilkavW0ldXTrbiU8osfi0E=;
 b=CuZwM80tnJCu9Ks6PajEMR8IjDYuSEBR+Ng50b+yyG9B7tA0mWnr68X1tBRfakBTaslbPDjoHBX8p1r8KP0kxM7wtn8O6hjTEfoBcb0Z0z4qQ+ycDPOq2sMIJzhOiUYYXrxIRweKre4ELMsotU+/9HIGPt+xxLHxBhI/O8qZdE8=
Received: from BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27) by
 DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.19; Thu, 14 Nov 2024 19:45:33 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::1f) by BYAPR01CA0050.outlook.office365.com
 (2603:10b6:a03:94::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:28 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 8/9] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Thu, 14 Nov 2024 19:44:35 +0000
Message-ID: <20241114194436.389961-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: c2db6deb-cdc9-445d-58fd-08dd04e4e716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z0YBW6DPsyxMM3JFvKZd4GgMGxy1+KChGzwJO2qwVHmAbx+bUGOXTGLl7AP0?=
 =?us-ascii?Q?cBimyOr/6iKnULA8qJG14YzOTQM0pCTzJYdG04xo/6rANgD8vxcy5hlgzJBa?=
 =?us-ascii?Q?M1oA3ZRylkLmomQM6LkJYy4rWbav5GgIMmn/yimQwBODJAVLG7Evs6qHd5Dn?=
 =?us-ascii?Q?pZosF7K/Ye2HyhvBt/A4JC5F1e1kf72aaIjrrzJRlkq5El82xxMkGI4+0yx9?=
 =?us-ascii?Q?LDLIuPlDBEEYHJjD18P+yNyt9OpvDgrg0bmWUQNllzN396Xds2K1qD+2dnoV?=
 =?us-ascii?Q?8/Hn/HMMDd8DEM8ugnz+wqSGEzAmUavAVMnyD7jbtqpetqefln2KnIlHp0PP?=
 =?us-ascii?Q?Bk4TANffaE2Z6Wh6JPmncgtf0B08cm1Re8tFzl0+IWpWN8lr4HwAG4+a9c6U?=
 =?us-ascii?Q?huN1binnk9P+5+WKoTO3QmewfSlCy052RM21pDaycxl4n3iGc1Vo91SbaxiC?=
 =?us-ascii?Q?B/Bek7up6RXnsWbTg4ts4Swm4HGqny8aqgdsHVcSLM9qSR2kwNvRtxRpmBsG?=
 =?us-ascii?Q?o1lX89JknKxboeEE4xa6dIZjqtimCVmydbLCfobCZXZVadbmac0yYb1/svds?=
 =?us-ascii?Q?bgG1WhboTWJzJXXIX1kgh/qMWYpa3Cj62JlSeUUPHRF5gaESTjHkpwBEtbEL?=
 =?us-ascii?Q?6ZMhobmPYvwmroVhtSVE+y5BFi4570ihM16x04r4oUhSBbQQUw0USqlFiOug?=
 =?us-ascii?Q?4W+rBz59IRbFkXxmkrRDtjRFFCMvuIdKV4P9pG8XnUR5PDSTnqq6cx0X+XHO?=
 =?us-ascii?Q?k3MiCRoqufIuEGhlchDqipwRgp86KvvgMm+30dQeRnEO8ccQYOkJiiRHD61m?=
 =?us-ascii?Q?b7bBY3LJtT2gIM2InT77+g6MUjt1SSgdbeM16wRg62IcJCtxgIaF+/aE/t55?=
 =?us-ascii?Q?2BRI3EGfizIDIrZteFNY0+f8Y+Gs1VfVtzZCSiasR/ij1cjEO3T8SMWPAGDs?=
 =?us-ascii?Q?bNv7tNhf54hJaqWqyHBfg9vbn5CYSxL3Zb07/IxukgGPb6CgsA0j9s8k2Rbz?=
 =?us-ascii?Q?yAZc75lCZqzzxUI8EZDa3dK+Ho/2bZDyVzuMVKtNzV/bH6WdaQEkNx2MmZbm?=
 =?us-ascii?Q?0DuzMIMFeHayGIBKx6ZBdZ8q0vuNBFV+3Fxu13a/6OF5o6EyQ/f0nJljITOF?=
 =?us-ascii?Q?cZLgJLAB5MsWZJihyGsQAKDaYuIsG4CNAIU9ZVHF8q38mkYhBCmMQF9dM8Mh?=
 =?us-ascii?Q?T1hIWwzmqLgzwMhr4AeGwDE2JKeOq6SAQK2Sn+8DNva5grhLcoWxA159I4pi?=
 =?us-ascii?Q?hCLJeU3jnD3n/c5xA4RvFdb0cFFFvI5rmkRF+ui8HtqgDgAgWkNonSeSQjBH?=
 =?us-ascii?Q?/bGxQNX+wF8AjRBZSnDZXPpPNGHOjyGOXviATqe1BKufxXYea9miE+mUVse/?=
 =?us-ascii?Q?ee2Kgu03Efk1QVl03sf3e1OH6GedLxsQoHTDQKuyqvw6E+vTUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:33.0815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db6deb-cdc9-445d-58fd-08dd04e4e716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

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
index 70002fe3994f..65225100cb23 100644
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


