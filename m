Return-Path: <linux-arch+bounces-9058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200F9C6EEB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5B9B2FA03
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F92064EF;
	Wed, 13 Nov 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hahoiOK3"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBF206516;
	Wed, 13 Nov 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499468; cv=fail; b=X12jBLiN+gU0DzvwmO3dhEc3teCzMAyLA+HwSu2MTn5M6hdFI0iH04CeXhdAWsgdiNwHjbBNaHvJUvxer9Fa20kzmq6AuxTsldX4h5Oh5LwwkyGzQLk1/mJThVoADoEq1TWHeeQYlhz9OJW3A5Y9Sb05lAT4sBoQu7C/NLhhJ9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499468; c=relaxed/simple;
	bh=a7Q94x2niv637ixoQwvi/YsuFAzXXxQsRojzxMXMWs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GowbEjkzQHiwEMJweUzjz8ejRBEwE958Sd+zTHmeH+ZkwKo7B6sLMDRUTOrwrjF/upM4JRlEfMYemnnKQ0N6MpovP4ZTE0ekvd3Nn69KwaBEc8yw/zY8HVQTD6BnS4fTKWJedIptSzzy1dU73AReIN3AgoqwgR5DD4iP4HEZPzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hahoiOK3; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhWtAlVy3nIzBaYg25bDnBGZ1Oe05orupOpdYXNXaxfWeBeDAuYuzKjcSC+cX+NBEv5nJWZO5Sxx+qLBqMfJ862ubzplMuOPDWfTjlCD0viW3y8uT8NHMwTELtp+l+ueDXV3hMrVqxm/zdmH4wRq5p6mwQI4M3WxukmNKgQjRKYRMoIRq3RFodUReQg6P2KzlLTOT+2W3AHxMCaDNVCvozrSsj4GOnCgtpQtdOwtIrPmhfLXLFgOWU03yU0Mvy2Zh1mWUNEq9kUF6ufG3R9qQV94cUv7/CZI+S+JcEWPv146KicZGNRDBV9ISpWdhrG0QOnGXd7NYPtKgwW1R52/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lABNp1ZxkN1ogGx3trDV6vTPk1zgjxTOVwvmKCsGXqM=;
 b=UdKj6ws8d7QkBMW/fTPPMi5bbphkeA8bwi6R9MDaMFRiLI826PUL4NxJZmBXNgI9hBFcmiBBAFA/0lB6VHqUZsUq7yiAJYJvVFZnaJ0yLh/JnqsCwHWtov1qMD3ona5OjTT+6z8VMKe5tjqNTC2iUdZhcgIldJeUzzcI0kHHmx49uHhsaKqz62Et3KSLWBDWEPS0FvwARea3qT9/OkOPvkRxqlTUGU7AKa2I6T2P9xkd/8gR1qYHHSA1pRFVhom3BpflHwBHxFJi3ErFw4sw346v9IhKG2aMPzsAdOmyEeSYcGM1xkFnfYlVFf93SHywwBPZttgPUF+wbXLNOfA5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lABNp1ZxkN1ogGx3trDV6vTPk1zgjxTOVwvmKCsGXqM=;
 b=hahoiOK3UIa3kHMGBE2qXWnMA3vNJ53imhdsWZqr3Op9Gbtk911/ctNgjP5gQXHHi+G0t9wMpDHSjOKZvSD1VkzACOWAxicjsuLxx5rNNsoaRTojA79Q96XHhIDcCrpqOCEbbfb9tVnOqirabsOZPhNJxPPeST6OnaBnB0X+0p0=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:04:24 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::bd) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:04:18 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 08/10] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Wed, 13 Nov 2024 12:03:25 +0000
Message-ID: <20241113120327.5239-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 01793722-9987-49d5-56e5-08dd03db50a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLjvDQ3k5a9zQtRHycGuY2AkXviw5agC+AW7vC7doukEt9/jexSeMcVlIHif?=
 =?us-ascii?Q?W0oGnBX0WeDpcUOUqh3IeFT+lKgoM/pvLFeFZWo1Ag7jKWZfrP/nvs3UmFjE?=
 =?us-ascii?Q?wHO0CJAb0qW8U0p3VqGqcrSuxhx2MMa9dUH5moKYlCiFt0ZcULnwHv4EJUAO?=
 =?us-ascii?Q?94zKZah+0nBUA5AZVAJCSTOmN3T6vHeu64EYu12AcQndeL2gbTH+wRvr5E7k?=
 =?us-ascii?Q?hxWjCV4LfW4c6T/Lk8Ev1rnyAA74LtAJRe5pcWjR3/18zkGn+u1ubWXbCHtu?=
 =?us-ascii?Q?Xv2j6LFXYMH5B3RKCbhQKJhWrWvVpxo7S2Jszvvie9stIzIRy1NRLQrI8nqX?=
 =?us-ascii?Q?XvSxyxNOST1xO6AVTUeYiMcRHtxyOJdx8kZcmnOpYvSsaqINZQ9tcnNXesXV?=
 =?us-ascii?Q?9NAEfom+r0arKCD3DO/5b+nsNY+HYZUT4iV4o4fSPkBI8eV1Nf9b4WloiE8l?=
 =?us-ascii?Q?kJzyM53wbBJzs15d/Ji5GKmklFqMch6xySQYjIC0586F2ufsiBCkzyBf6jqv?=
 =?us-ascii?Q?Ji5yHRLwuT4Ohkc0kEK9Gp33AXNm78WJnpJK+i+AZhY+7A8vMw6HiUpEg4zb?=
 =?us-ascii?Q?vsIYwwb6X/OdrfhKBGr5mH9lGcjaywI23CON6WNj9sjvzWvG6iwQODYjI1y4?=
 =?us-ascii?Q?F6/6elmHU5V9fd7PGdXY+5lTK613Xkz3s5sR7nTBlrBT7ND7jvvy9zJOj7KM?=
 =?us-ascii?Q?CUxSSHLdW9AJO1KJ+gLV35WQasHbOeS0YS9Db+PDGcJ8eHvaXLSc4/PFE8Qc?=
 =?us-ascii?Q?kw1ruN0dH7zBhT/5RFQNSLg3IyrbThWIe4z70QLBS6wtoChnW/UqbT99D9QS?=
 =?us-ascii?Q?kdPein0XP9xs5VyBRvAWlUZ0g07/CxskPOAdQqM5mDDDqT4+umxgsOZamNA0?=
 =?us-ascii?Q?jusphS/MZCnQ45sMBFwdfB2v3RKY8zPMheCJo4Q3hApMzVz+4Pi8xk4XrjjU?=
 =?us-ascii?Q?mq8YRFCxDrh6MVxJIJ8SzOCEJnoRWObMyolTd+Qpo5ExkJJMtJFpw21ZV6+c?=
 =?us-ascii?Q?55EoV2v07x5+fKwOSBJ039clWiFKt1r4mojpqlZNhBzobjbepV0iQ6Rm4m3X?=
 =?us-ascii?Q?hKCuawf5d6RxKfWiGzu26mTbk/3LF9BslC9swX/E6tG1ZOp5BQeHDrqM9LDh?=
 =?us-ascii?Q?C/SY4vopvISqBEQk1asOsztMm2tAusmTccLF+j1aFd+daD+zw3bHCpSxF3J7?=
 =?us-ascii?Q?aO6Bc85ZDu3JKJXSOd9ilJiHsw1mI86zaxjYcqdxFARkKWQKCvf8IZnlrcdN?=
 =?us-ascii?Q?jHsffPwTTD79W8Fl0kFi7fMvrIXxJlN1O1Xxbcs1481qUOMac7KKtT7WAe6K?=
 =?us-ascii?Q?6o8KrLMbRaf2xLuWOSzeg3b49tHlVGupbQPthEkG4PFsJqI2rWmc6EcllCOe?=
 =?us-ascii?Q?S1RP23Td8wwf566ahD0dpGllFbhFjInULQ7e3xb2P8Ns9VtA7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:23.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01793722-9987-49d5-56e5-08dd03db50a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

By reusing the make_clear_dte() and update_dte256().

Also, there is no need to set TV bit for non-SNP system when clearing DTE
for blocked domain, and no longer need to apply erratum 63 in clear_dte()
since it is already stored in struct ivhd_dte_flags and apply in
set_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2a0411e8ec20..d54579206a04 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2090,19 +2090,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+/*
+ * Clear DMA-remap related flags to block all DMA (blockeded domain)
+ */
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
-
-	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
-
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	struct dev_table_entry new = {};
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	make_clear_dte(dev_data, dte, &new);
+	update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2113,7 +2110,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1


