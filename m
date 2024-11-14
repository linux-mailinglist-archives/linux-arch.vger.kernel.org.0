Return-Path: <linux-arch+bounces-9095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17179C9294
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E4B25FCC
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B81AA78E;
	Thu, 14 Nov 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKUn1hiu"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECCBE4E;
	Thu, 14 Nov 2024 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613533; cv=fail; b=JPpvwBO25nn9eo6Ajxxf3cwldTCL8cztC1piHONAkCNGZ3LoJmEYUQ/6WVcr+887FXWlqTjW5e2pjOe3EsDU6r/KXyBYqOkBUc7GBRKGy4sFQgpjH/zpGPBZWBDGkFiZqeA8gK2VWgcIspcyjwFgaOcuOXRDtwlwF8aOcCe0yr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613533; c=relaxed/simple;
	bh=4TMaHMTAqqp1srFkIKkt3p3hmI8c6rB+VN71d1v3dA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goUAZURSKO5ZuR5cOt/F+RJe71ArfARpMQcK9Vbk8I9q7kuEOWEatkNhSGquQZpN8XG4rDORI8g8dQRiEGeNvr6BH3R4za7Ad+2yWd8rgPHPkkP7t/FykRdYTfG51ahabes6EVu8OgYlw4UWvThtkDDCBrjg0r/gx+roQHYisq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKUn1hiu; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1ZIyjPhp5yrAF28RvRkta1C9njK+bW1qJKussTUPLYIy7PTO1RrqzWLwEccFSPnp/sOCR54ErKCaixp6HRVjwaycOD23NRnZ/s9FhWW9ytlXTLQWMP+gJfnbX8MPt9Fra3Kg6hF9lnzFQGwTKmlIu85024E4wisAN/10US04U8wIDj4am0rhAIvf/rnE9G3R556zD27rFJWOavcGvPXablESCXezdxHsJVhvKEASZC3TV1/XjmlJBAvaW5cm651oRSORhbI8Ga9egINUgX1qhxB951Q5goiwPhqsH8ssxzhcf5cG5CEXSUAXfvAQel61aibfDWeoJZV2ExL1C8PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnlw9nFRMBEw7x+UvQGIppYrBwoJ/xMg/xv3jU5lR7w=;
 b=Cdemlud28ceJLE0G7Kos0Dmvh1a7ZwRmkwZWq6SFLMB1licoIgxAUUP3LY7bQzMnCTARHN88BwODV2QraIA9jphBTgJy6uM/IcsLdbBM/RYd0ZRCQCb1dmCbzgeY8+9h7YXAxc8Vos578VziK7LjKoNxRvVo2EwEz9N+n6qmhPpMtwlgPm0wMi4VjSopQBQSMebQJAtWS1XG70v73d1DVrOerg67pkD/qbWIgFVTGf035U5bzNX6biGZf17V8d2NAsjXceBZCBZjR9w8MvsA+0oiccOJJM9h6taLPf77DkjUt1WQdxBuzFK4+Qjmv9gayldVHdiy6iYDctR4RzGJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnlw9nFRMBEw7x+UvQGIppYrBwoJ/xMg/xv3jU5lR7w=;
 b=VKUn1hiuMgvERJim+LeyZisfE731OCy8Uey5eFdrtkgVEfY07E17+HJT0ofuGTWhoROB7DyTsZPPQA1TIE0NAr17lJqqnjcWfxQKys2CS//55bt99cBglS5+2DfJlXH+ADjDM1razzjH+kcmG4P5ap4s8MOSHyJSGpoG8nUmX5g=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 19:45:25 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::8d) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:24 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:19 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 6/9] iommu/amd: Introduce helper function get_dte256()
Date: Thu, 14 Nov 2024 19:44:33 +0000
Message-ID: <20241114194436.389961-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: e306c839-cc00-4c98-6ec9-08dd04e4e1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akbxtio5oke81sZxU33Q1Qab7T+vd2XRRmEvaSGkslYxpYp9s3laDfujcjWW?=
 =?us-ascii?Q?MQEkPfJj0HErQ5gx9Yn5P7xRmN5xK40OKQ1ejfh/naBQiHSfqNADCOECcy84?=
 =?us-ascii?Q?kq9RWy4BIKbsrTWZl+yhxPPfrLufz+a4pLgP4foG9tUGXgjvTejgV+HjMeRc?=
 =?us-ascii?Q?kBkATtjjfq1mTpI4V/ebkoFp6rNZ0f4eweW9p5kHsTqPM50Cx29BDgfSD2BR?=
 =?us-ascii?Q?ScdN7JyBSPt+6IpGYi0PGcXAYqaJkG4vlylz+b4A9WqjsrpdTiqQCAtKXcut?=
 =?us-ascii?Q?RnGkSgvIOzZ6kxf2uIHLpj7EHQNmWBRl7qXQ4Gpln+SLukOgsf180pS4valx?=
 =?us-ascii?Q?JGF+PVWeVsS2yOtKa/dH5mt44reJgJkv3ASu3QlErKKlLGm5F4upirRoMGyP?=
 =?us-ascii?Q?ahcBIf8ROROHUwEeWzfBUQ/N6NOwy2Cufjsj5gshcFI/zD6uMqEZ2h/+p1hN?=
 =?us-ascii?Q?6q8VG95oYTMVQVkczjdOBVXZYqTt9efgUwLN/yQrUBxSGxkrEpkRP8RhPeGs?=
 =?us-ascii?Q?7QxNCWa2l9OBsUqhvXfBMVcdOunOJ/A5/vf93d/C47Bjm32EGQgRJFMaXHgJ?=
 =?us-ascii?Q?u6FtRQjUVRlcbyDxKn1uWErSQD8Axhc4vquB7u7EU3raapy7VmsqDCmze1TZ?=
 =?us-ascii?Q?FyhsfXe3f1Ghj6fYITUT4jjZEiN/rgpkimQT/i1TOcBsGgoOLi1UtP3MYWmt?=
 =?us-ascii?Q?09DQqtaBkjLHxtsLhdWnA8ocbNBUdc9B31lGUKmo7KMu24k1F9TvIPPG6JvS?=
 =?us-ascii?Q?J4zkriB3ZkVvk1d2oowTaLe02WJHU0snU/+ocl8pXwj1kEJfXNFxZTc90etG?=
 =?us-ascii?Q?SF4/bA17bIc6PDbq5q62sl0tXGdDBEPAARMZMcOp5jVvSNIWBHZg1gLetsW/?=
 =?us-ascii?Q?rUWTOPHwsGSRukPGdplJbokbrkTd9ll9Q94MxVdqdA8vrmi0HjbbAi+6ku+V?=
 =?us-ascii?Q?sZQIwL+CH3q91CjpM4WEtE8I6WhRe9qgHYA7OGsl5I+jqP9+YsJwOBPL2UBT?=
 =?us-ascii?Q?4mEakKKWt49LOMcDXELtUiEDMlhEMW6RYADsKZcXjQs6TGvo1q0DpE3D5Ql5?=
 =?us-ascii?Q?Ph1uWs4dvhrZKmdzxTuiu2+sY79wrJFMk/eo4raf2DSlmE0/nFhH1F2W+Neg?=
 =?us-ascii?Q?K7wcDxthtTWPXBlMLaDvKViuVgm3M2mm1mbGQHT/lMuFh0WD9AgyDTSyat1m?=
 =?us-ascii?Q?1gXJSBUazED7OFsMoSXu8fsejgd9sitl3uqIp0bkwAl6av61dL2/3R57+Ltl?=
 =?us-ascii?Q?+m6hnTwbfs7dgaR9T6ayeb6pRwwudgRR+wtDlxEF3ua+cda83tWtbCm/DQaK?=
 =?us-ascii?Q?skHn3ifUa/tdIW4k4D7WyXPQAGwXBq3rOwjFt6NwD65V+r3+eKEScq8WYMM7?=
 =?us-ascii?Q?SzAaWVkJTz6XoTrleabnSluK7vwXjX1cWGU3w7yadrAp5rJWGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:24.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e306c839-cc00-4c98-6ec9-08dd04e4e1f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 62 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cc778056bcd5..8f1de15c07a2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -202,6 +204,21 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
 }
 
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	unsigned long flags;
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	dte->data128[0] = ptr->data128[0];
+	dte->data128[1] = ptr->data128[1];
+	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -350,9 +367,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
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
@@ -361,13 +380,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
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
@@ -640,6 +673,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
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
@@ -653,8 +692,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -685,10 +722,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
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


