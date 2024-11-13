Return-Path: <linux-arch+bounces-9057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670129C6EAD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27284281D73
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E99205ACC;
	Wed, 13 Nov 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYXUd10J"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED35205AA7;
	Wed, 13 Nov 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499465; cv=fail; b=eejx1K17qrjcapME5iCWGBDMVKOL7NsvBodR6yAHaAGuQfru9eO/wWy8SdEzwtS6pZtgLsCdBoA+D4dd9u1JHPRk0D0/3QGDfDr+tMEJOutAdVp6q0quF156h4vTvL6SjXpgAfkordC3j2QRW/5ZTVYI1Tl6VsjPmPK2XFwu8aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499465; c=relaxed/simple;
	bh=prsCiuIX8pUYBg0WYu8DEAqczd1GZTFvj1BDJ8cCswI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX22SuZve3sKB/tAjNYK9IDgmAf309LDoxBKVrHQZf2DBctrMS73eWQm+gNUU5FXowMDZdfieNvNkpe6WeDraFE0WrtZ2dJGKwZT8GJTDeqAjLwmwNZSIjRF1KNRHWiZZieXwgroZd+NwGjycl7Zvxt3ShkXGxFYuVN2WrmmiJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYXUd10J; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu+shKU2WSbY8nHQE3Q6UTVZWj3sziR3bLD+4An+Qj4HVIyaTZomn08WAiUAeVvVHhX9W9J77R9JvaSbJEnyllxYCeVTSpzRbga2qrpAuaOKo9GM47xOZAg1tyBF52sr4qkQO95XVsbYARRWbCjRGuXTjBiak9uVxF564bRRLcsbgUHZyR32FvsZlbOpwgIfNSVLmlz9QF/gCeFEKWYa/opbad6IxGBipJGPSprpbxm1yNnRPVa3EC6XOl0LwbbRrrWn35kNmsgeP8ucHTDddMXgPZ9o7LCrG4Z6RitQELbQ8W0B83hSWC6ycZp1HA9Gq1l1WY+3YBMKgzHF43834Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNEI2ek/GjinlxJpUFHzdDZ8Z3BSXvjB1Kxg1r+t6uM=;
 b=og0TOoIh06pISrB1fzfOTzwywX9tiNd9T8tu11Kxhvm5fRc5QCigVvKq9V4wdtB5Ue3KZqJDbR68v9e27ObuJUiDEpOBnZwW0XNxsX9iFn28YMsN1WYwDXsqIoi6e7CxxsLxGLICSG+uU6lPZYRe3RCO3/KYsRItPqmRxz1nep+RSFSF2hAhckyryUwxAqRp8yi56RVmyvcRYuGohnvhlIhIssRnx1nhV0vEwVDrZQer6R6r+kZFZloOhQUDDKRJbFR+U+k7vlLueCvrMjPS6TTRhY8UNGQ38M5+CN0fY83cNlyepRCFwLKlmaZSvcpktq+vbU8PbKC1Sgtm21A9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNEI2ek/GjinlxJpUFHzdDZ8Z3BSXvjB1Kxg1r+t6uM=;
 b=TYXUd10JTCMwpZazSf3++3y981io7sfqpW2lMG7QHsXq1msoySW+2EyoRpxEIP/MMm3+bkJyyym5gRX9777oHzLZq4DrpIT0RmaJQlua4oYxgEIxh1S6xbhzrlp3F+yPUjYN3AksV4JKx36ATlUq2HQhsrlwj8f0M3AiKpF6aDg=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 12:04:19 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::76) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:13 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 07/10] iommu/amd: Introduce helper function get_dte256()
Date: Wed, 13 Nov 2024 12:03:24 +0000
Message-ID: <20241113120327.5239-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: df6f3402-4b80-4a5c-80f6-08dd03db4dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFhKuD8qaKpwHE2beaeJpJjjZtc3/q0IFAqAx+snwrVMhGIZODyRRsVtDdxn?=
 =?us-ascii?Q?VhpCj5hBe+7eqvSzENMooe8xRry/t7S+z/gc0dj5al9kZkpeK1gzegH5ZP1a?=
 =?us-ascii?Q?LVqsHo3YazTAG0Q04AdVSP0/2PcDxbQMJuujaCl67D1Jbb9dIXlwplVTkjTb?=
 =?us-ascii?Q?fs7nh4hnCChZioTdkHHV9x1Uip8C08YF/etVtDuaUKFW25znnWZotczT1o9K?=
 =?us-ascii?Q?UJG1NTnov4y9hWUN8Ag+fdqpnXOsqY0F/E1QeFJxVUrO7wmfm5M3MuARq2dJ?=
 =?us-ascii?Q?M29uMKLXbcnKbZHk94NhruBlfKAJxd7wWp9+mu5CNgagtb6ydpZxVhMZqukm?=
 =?us-ascii?Q?ueJQ37jPYCnaL+xIMjsEG28lahZf9WxVKijH/2LWC6xGKdXG+2qwvPzXKJON?=
 =?us-ascii?Q?Lw3OtThBWEFP6BeO10TGetUD1CJh5g5DIggsRvQdX6KJOrkI0pIBQSLbF5hC?=
 =?us-ascii?Q?TGRCBuDbhrY6jDrq+g3AyBwHKNy2Cy9Wr4CcF8bLF+9ziDwJtPnr3gN01QVZ?=
 =?us-ascii?Q?1Gwe8egPIZ7iONTfXX5VJbOi+GJVkPKdqT39JXYW779u9IYRWnw0dTsk81mz?=
 =?us-ascii?Q?N52isLwAV8RtWd958KW6EwSHt4OY7YicBAH82rTuf1+wCEcINuf9xX9LJRjG?=
 =?us-ascii?Q?RXVf9qTfgxs5MRSJ4NI3TNJDGcOfRSKgFxMZocB79WbQR5SWlq0PIIMOFwtY?=
 =?us-ascii?Q?EsYoYLouj8ANuTDyET6j8q9fwwgUuJrwng8E4rWnAxEMZrc+8Jh+SzDOjT8B?=
 =?us-ascii?Q?Qd8xn15IE/0zFrjic2d44xu9DLcXx5L0giRm5KJdG0n9ZLdk9emn8XdQwSI2?=
 =?us-ascii?Q?E5DyXn9gABNNAxzwOK+Cnfm9VNoK+qpT3Wz/ZpiEH2yNcLN/ruYdyP9OZRxE?=
 =?us-ascii?Q?7sghjj7c3rXQo71DlPN4+XAPvx2MmZ+SLsxtYSyFtDRRk7x+UyTzmZ9NV5xm?=
 =?us-ascii?Q?1dezRC8Y9En5bFTo6OmO5jsH28kaMnRadwpRrESS1dR1vA16n6YrDgGgFALh?=
 =?us-ascii?Q?T+/ApHKld6WdluRDzLlCKdmsBAebBXPAqTATKOlew9WuTK2zjbXSpRm2npkw?=
 =?us-ascii?Q?ZPGww7tzpfWiD5BKjbrfbMT4vPb8WQ6IyPyzUxvPXyljph83/UpnhGFXZaZx?=
 =?us-ascii?Q?Wnu2eVv2aEgllrT5Qx3djZQApEdo7GWX8HIFBYqq9xVtBZrTcX6yQOyPz7Dw?=
 =?us-ascii?Q?rh+Cmh9677EGoVvZQPQOBTjgFEtnlOQENSfRCaai1UfN29FTmmPdVqMIwuVt?=
 =?us-ascii?Q?EmzjtFX+HEa89k4AznkNGwe+WN85GEFeZI5G5Hl5i9vsgzXWo/iJYPEOWCNz?=
 =?us-ascii?Q?1lbLEVc7mXL4JmXQY653UOgEQQ4c6KBOBq+cJVM2FQnrtOULURMU9vMts19Q?=
 =?us-ascii?Q?DPRI1ZVqXiARfIlhI0xuHAl2hX32OaGKTwTpBiyQ+Yzoa5n0cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:19.2038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6f3402-4b80-4a5c-80f6-08dd03db4dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f7e36cbb6c4d..2a0411e8ec20 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -195,6 +197,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock(&dev_data->dte_lock);
 }
 
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
+	dte->data128[0] = __READ_ONCE(ptr->data128[0]);
+	dte->data128[1] = __READ_ONCE(ptr->data128[1]);
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -343,9 +359,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data, *alias_data;
 	u16 devid = pci_dev_id(pdev);
+	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -354,13 +372,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
+	/* Copy the data from pdev */
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
+		ret = -EINVAL;
+		goto out;
+	}
+	get_dte256(iommu, dev_data, &new);
 
-	return 0;
+	/* Setup alias */
+	alias_data = find_dev_data(iommu, alias);
+	if (!alias_data) {
+		pr_err("%s : Failed to get alias dev_data for 0x%x\n", __func__, alias);
+		ret = -EINVAL;
+		goto out;
+	}
+	update_dte256(iommu, alias_data, &new);
+
+	amd_iommu_set_rlookup_table(iommu, alias);
+out:
+	return ret;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
@@ -633,6 +665,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
+
+	/*
+	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
+	 */
+	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
 	/*
@@ -646,8 +684,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -678,10 +714,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry dte;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	get_dte256(iommu, dev_data, &dte);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
-- 
2.34.1


