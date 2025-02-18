Return-Path: <linux-arch+bounces-10191-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D6A39A96
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25CB3A5046
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4172343C2;
	Tue, 18 Feb 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tSrJBhN5"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905622E40E;
	Tue, 18 Feb 2025 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877392; cv=fail; b=ISTQ2tGCn+GZt4VPVEkhsT9nyBdHoA4aVp0Tdtz1akXfJzJWTs3kDQN01A2F93r2xA9c+vH2hqcMBayMrK62+LZIXJ4jXjVH4z7VcyI/ASr0pH58gUUyYZego5np9yxNnb++HAtUeSXlGGsMSoVdYimx3R/JL7nrG0sMR8digw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877392; c=relaxed/simple;
	bh=IgVnsOuxgvQPc8Q3asUR9P/fBAJJImXCyMZ3ZUiH/gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZJ9fD6KdMkYti1TffayDfAKw9ibQWhr0Q79NgE0ezIZVIZZNRCM/tJozy5Ps6thq/ZMfHnD5s3iLMEM6FRQqy/qvH0coParHBUO0DusMsd7n2cL8dIO0ltj4oSJNm9h9Wi5vIxR2sZKUx3poC4zxS69jg0hblsi/Y8Bg764bNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tSrJBhN5; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNl88Hdm9e4fwb4izE+cz1QDDFWZPhKO95cHwX+trKiEgbbdux58+xo/6ocaN46U1vm+S19lI46eYptVbgxT/pnZpfe4kFCXx18eydE9wLQBT3tGy3LUIH/jf/n0y6l8ud3r4s5INdFrRbWKmjeHQjJ37OTTrcR/ad8dMdOUjkvKmkwh3gLsVwZJ/Zb3oGBiOknxPxANw+EJ3govvl89FVVRuUMO91Li4KiwyR4Wzq4X4mNw77iLmMOzAR0yABwmr9n3gK4aBTHgJNU6tuIRuWnbv25FrKREeV/7G7w5v7VAgbUEukQSfPcGx2BNXR7AgJYl5qo9qcoE4MiBfKm9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyg3wrzrCLLnB8AeqaRVb9FZTULW+HDG8F1txBPC/XQ=;
 b=Shw/+ZwhHxKWaMW/tl7fGQrTYAq9szC9+vK4q+bT98hATCECp02mcyBXwwuFtIQSHYeh+E9dkudqQb0LNNURJSH0YhwoX0A0QFvaF7CPZFU6foHWv/zFr4h8FgbYSmhsF8UbZ+xWhVP9wwLP31mfIscykA615SrBkVYwPqSZPh6niGu6p/8w4rqy7xs/nZsFZlCiPHf5Pj5uG1W4O2BLqVu6rnEJPnBXRtMW8dNqcuWBze0M4SeNAQqS40QngX0s6/WhrAksHzWsC/qb7qNrIpBWE3V4ArMdRUqoCqFXNgBkZkNCJskqslqds7yMTPjFdIZ4VG3qU2C325hj8I9wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyg3wrzrCLLnB8AeqaRVb9FZTULW+HDG8F1txBPC/XQ=;
 b=tSrJBhN5Y0xwQsXLv5btZ7oJ2AazQRO97s1zGg8xaOeX60vHs8/0Vyl+9A622/0JvG6e3wEuUEDAdM7a7FhqbVGJeBxPzg8yh5iiMeOScs0LOBDr3OKPIcyz1LPhdEOrXng14sAdumh17VW6A3onTVzNajwRlI5ZV6KW3MJV7CU=
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 11:16:26 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::42) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Tue,
 18 Feb 2025 11:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:16:25 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:16:17 -0600
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
Subject: [RFC PATCH v2 17/22] resource: Mark encrypted MMIO resource on validation
Date: Tue, 18 Feb 2025 22:10:04 +1100
Message-ID: <20250218111017.491719-18-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 29283913-f8c3-4ccc-f391-08dd500daee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yUo4rwM2786fc/Ab6z21UIU2rzaqMzY7dGNQlwfWZv0FzRE8VYLXAQCRvkV?=
 =?us-ascii?Q?V5tD7pqtJe0Js+BgULC7TFVDtBIGoropVcysALt+R3tSRyk2NYh6rHNmtUSF?=
 =?us-ascii?Q?/2z7sXDJK8Moca8c9dD4DCdvGBj2WA9chrUnTm0YlnkuOylbMSO1amJujYsV?=
 =?us-ascii?Q?ZymasfqDx4Jycfw7ZRFzcitaBQTXfvCmkvAhyZNfv4X5RoSDvNFyMLnJFUoi?=
 =?us-ascii?Q?UcAX9lyV61qU5oSI9EtKgIruqYcUFF1SOhSAf2aWpt4h4ooGnl7fKBHHx7jx?=
 =?us-ascii?Q?u9Nw/X+nZOD9pUflXs3QTx2yM5dI3cWJbZRBtFv496Oh+2oJ8yex1R4IIXlK?=
 =?us-ascii?Q?cQy7SJp0mK8WNx/jKFT/4QIyB6zFweV+sVWi4IhcCe7O+lSgoYvxD8nSRbyx?=
 =?us-ascii?Q?GzxW6ZIUd5aZ2QgsBqcOX11qhmu/sCqYunE6yKJZ+UYx463cUV9YnWsW5h/t?=
 =?us-ascii?Q?1fy6zRQyILjImgfXZ/Y6P0VlxMrDprBnVtOg5MsbIyjZhzLq1lMVfMvHmjGp?=
 =?us-ascii?Q?d4HvzECa/h/HUFAu/8xSdg+t0RjXKMNFgEX6owmciFsvdxgRsZaHnR4UJWCq?=
 =?us-ascii?Q?WUrVYkY/RubdiDwfzALYGdy88Bur3RZ9PASlBFVSoxTfMeicPBqFi4DoSqH0?=
 =?us-ascii?Q?7i/mIM00U53IquXKHY/6wfCZiT/zg1AmgXp1cN5drrrFhPoRt7CL3/Pf/upZ?=
 =?us-ascii?Q?cwGINRqQtqzR60ziQ66h4OxAHuDykAN24EhlTjMNmslwRXr6d4/sBTpO/ab+?=
 =?us-ascii?Q?Oqv+jTh7Cac25pDisM2YBrTUUo6r2NNTUyI049cZxLD554Zv8nN0BQniSebd?=
 =?us-ascii?Q?oJPUh6fGlBkk55DweKyCajBlYITtR2USoKx47VR+Lq6uPfGSIKzN2/VBAgdQ?=
 =?us-ascii?Q?m8UVZEChATnHtP7U5vaclRG0b9qo4ZA6wDaQDeZwP2wL6SAoPojvYCGjjkXf?=
 =?us-ascii?Q?kc0sHSjzXO+ZUzxEjavlb3srm/LAiFvqJUfPJrSOujN8Dpr9RRp/YuZ9r9Xo?=
 =?us-ascii?Q?Xu3qfOrzi9OMLD5It0yiyW+e8wmNASxHiPWDhgF+xqvvFJfddWY/9DPr+xiC?=
 =?us-ascii?Q?Q3o4ZHpr8htnM2GNY9hmBuzhXhEyyhPLgGVY4pVGWh9GYqoNI7/xaWDS0oTf?=
 =?us-ascii?Q?GLyZFBhOGkvwGuTHa7jx2Lr4bRHPeXb/HECyoxqAwcsmNnH9Ord06AE0i1K9?=
 =?us-ascii?Q?j5JmQwkg0lDf/gDjCWaqvw+tr+EKOvYaZeGpmcs1xSZS1FMgxaIDZf2+nWES?=
 =?us-ascii?Q?A+S7N/S4/OVFOe57fojWuuBfthOTqIPUIVoBoK5hjgzl6Baw66rTvu32H1DH?=
 =?us-ascii?Q?pTINTqhOQVp7AJL91OVbn9kX7VE2FKaV70oyDfp6tTJh+CqfkVcHzM76541+?=
 =?us-ascii?Q?R1vsZJu0MGFJ3mlrw8QjyX1yeIMHjh5FaHEIv8Lh5/em2CMAdVGwizwZ6ka/?=
 =?us-ascii?Q?3xuJzapi2jOhrkgN56t5lK1jSova+WI75q71jDSALbY2y+ZST36IJb/qCEC+?=
 =?us-ascii?Q?Q+yInZ3dnfNWCTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:16:25.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29283913-f8c3-4ccc-f391-08dd500daee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

In order to allow encrypted MMIO, a TDISP device needs to have it set up
as "TEE" (means "trusted") and the platform needs to allow accessing it
as encrypted (which is "pvalidate"'ed in AMD terms).

Once TDISP MMIO validation succeeded, a resource needs to be mapped as
encrypted or the device will reject it.

Add encrypt_resource() which marks the resource as "validated".
The TSM module is going to call this API.

Modify __ioremap_check_encrypted() to look for the new flag to allow
ioremap() correctly map encrypted resources.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

Should it also be IORESOURCE_BUSY?
---
 include/linux/ioport.h |  2 +
 arch/x86/mm/ioremap.c  |  2 +
 kernel/resource.c      | 48 ++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5385349f0b8a..f2e0b9f02373 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -55,6 +55,7 @@ struct resource {
 #define IORESOURCE_MEM_64	0x00100000
 #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
 #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
+#define IORESOURCE_VALIDATED	0x00800000	/* TDISP validated */
 
 #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
 #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
@@ -248,6 +249,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
+int encrypt_resource(struct resource *res, unsigned int flags);
 resource_size_t resource_alignment(struct resource *res);
 
 /**
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 38ff7791a9c7..748f39af127a 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -100,6 +100,8 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
 	switch (res->desc) {
 	case IORES_DESC_NONE:
 	case IORES_DESC_RESERVED:
+		if (res->flags & IORESOURCE_VALIDATED)
+			return IORES_MAP_ENCRYPTED;
 		break;
 	default:
 		return IORES_MAP_ENCRYPTED;
diff --git a/kernel/resource.c b/kernel/resource.c
index 12004452d999..c5a80da58033 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -503,6 +503,13 @@ int walk_mem_res(u64 start, u64 end, void *arg,
 {
 	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
+	int ret =  __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
+				     func);
+	if (ret < 0)
+		return ret;
+
+	flags = IORESOURCE_MEM | IORESOURCE_VALIDATED;
+
 	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
 				     func);
 }
@@ -1085,6 +1092,47 @@ int adjust_resource(struct resource *res, resource_size_t start,
 }
 EXPORT_SYMBOL(adjust_resource);
 
+int encrypt_resource(struct resource *res, unsigned int flags)
+{
+	struct resource *p;
+	int result = 0;
+
+	if (!res)
+		return -EINVAL;
+
+	write_lock(&resource_lock);
+
+	for_each_resource(&iomem_resource, p, false) {
+		/* If we passed the resource we are looking for, stop */
+		if (p->start > res->end) {
+			p = NULL;
+			break;
+		}
+
+		/* Skip until we find a range that matches what we look for */
+		if (p->end < res->start)
+			continue;
+
+		if (p->start == res->start && p->end == res->end) {
+			if ((p->flags & res->flags) != res->flags)
+				p = NULL;
+			break;
+		}
+	}
+
+	if (p) {
+		p->flags = (p->flags & ~(IORESOURCE_VALIDATED)) | flags;
+		res->flags = (res->flags & ~(IORESOURCE_VALIDATED)) | flags;
+	} else {
+		result = -EINVAL;
+	}
+
+	write_unlock(&resource_lock);
+
+	return result;
+}
+EXPORT_SYMBOL(encrypt_resource);
+
 static void __init
 __reserve_region_with_split(struct resource *root, resource_size_t start,
 			    resource_size_t end, const char *name)
-- 
2.47.1


