Return-Path: <linux-arch+bounces-10181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E4A39A2B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E40A16B18C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB223DE85;
	Tue, 18 Feb 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UbfNnBcz"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5A1A841C;
	Tue, 18 Feb 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877189; cv=fail; b=huXaw5Zny2k63Tk7d/3nIarFgd9LmZgJ4PHL6xTxA4Q4E39FYYOIlj5pihBLxkd4R8EbHVcqOfJZFLZfBb6Nw4Zhz8JEn+G9M9a/Sh8UngjITDBxf+It/n1BINelnui1xnZgXNtKKmUl+jVb3t5InJZaWtkJm5v13+FPWi2OM70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877189; c=relaxed/simple;
	bh=dYwuna3CkaI41eDgHHae4ltKWnjQQofcnsHfPAhTyDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duNDXF9ARBa5yveLDz3j2KZce+z2JPNFDDPX6362dH2pO00Rmn6YHTh7SuAHnt25Rs1X5an9aNE/5/f6cKkZRUjMkoJ6CSBpJMga0zVzkCAJNJLPMklU8+XmIaB17ZZ6OtbDG0y5Rdd1wmBDYOoF2QU/TCyLFGS6G9sd7/kssTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UbfNnBcz; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgpmf7YHMWF3UzWl1RtiADiIWPEunkUrWJ/o0nQowm1OYdP+v4OT347CfnKLUVMO5JyZim82D1drgii8vLg74BN3t+0CIuyLnkVjSRmmzT7wDtcuZ9vctEeYhKJ70nTzTfjUKvZGcjPwKUk5t9OGOh69S241ir2z6vSAuN+36IIVtRDKb8xMOOpBY7HT48wAF4W8yUFy9T6O2SxDJkW1rW4oYmCnLVMvacb4c8bxTVya0Ynk7B5g2h4xMRBpINCMPS7ocrblbmn3PhRy1+PwoknaTQH6XyFgXC3QxM3ZJBLWg9YLdqI3ChTSUeNccmcDboMIp62dcbLoS/D1Pw2f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YilQZM0RM9NQ00juV85NjA4o6LW+K9saVXHKI+fQc9Q=;
 b=E0glWxR8c2O2oJm3+ak9IXoZL7+OtrM2lPZFQPKS4PlcDSQUMa5CmxvLciS7g/vEydwCSkY0/x4m/8WUP2p/ViJAdg7e9xIivVUzAt+GlzjRDgd2tuJEWS2KleKfOVoe+EFDg0UA7oP3Cjt+0TFoffztdc8glASUoVgPKXX2jxmNNr0usvEpPluK6P5q+sWSPH/vNGd63/JKuw/enff4ALCotdtteGdECykss89P6rDfiOS/qskq+BaOr0vqCuel+LE4RBLmkXo3IRK1kFdrjbLKpQZMx1tJxDlw6LqRljIdhfeNyr1InE9Y2i8KaOX8eDWL5oPAPr5yvGwzz3PMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YilQZM0RM9NQ00juV85NjA4o6LW+K9saVXHKI+fQc9Q=;
 b=UbfNnBczdcZP6ol5mVT9fZijeSEGxJt9kwwM0ptcVumczwAiBQ4iYyfu9EcMUjw7ltBbjUapXH1G0DADF9E2rIQj+/YS1PiozWKVPEfM0atczYkf+Gh372ufJ0mTx396yXaal08c3oGXhdOC5UYfa9SKgLw1jTtS+0OVS8K/SBg=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 11:13:00 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::9b) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:13:00 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:12:52 -0600
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
Subject: [RFC PATCH v2 07/22] coco/tsm: Add tsm and tsm-host modules
Date: Tue, 18 Feb 2025 22:09:54 +1100
Message-ID: <20250218111017.491719-8-aik@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218111017.491719-1-aik@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: ae546d0a-706b-4108-3eb7-08dd500d34b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlE3VlNoY1h6NllDTjJaRFdNcjkrbTlqQ1plelpsWC9ERk80cVNseVNnVExW?=
 =?utf-8?B?WnRsWFprcnJqMDRkM1R2b1pzcXkvR1p4VEdKV1NpbTFGRTFFditVRWxmN21P?=
 =?utf-8?B?eXg5UVNFdWs5TDdpanZIL2NNdXh2WEpOM1ZnTkJ5eUFkcHFFVDQ5SE5yN1Uy?=
 =?utf-8?B?ZXFEL3l3c2dEUnpKcWxjRVNtRUg2NVNYU0kwek1iaWZHVEJ4eXNlQVRoQloy?=
 =?utf-8?B?dkU0R1dod3lTS0JZRmNMMHRpdUVQU3UycmpMd0hBclB0Z2tNVmdyVmF1cDhj?=
 =?utf-8?B?NGsyMGVjM21YeGcwZ0kvbzNiYWsxRVo3K2h0d3hzdXFPVFJid2xkQWNUNHZW?=
 =?utf-8?B?OXJBd0JQbVVncndVb3cyMWdCR2ZoT2p5VGlYbEc5L3Q1NjFZUFh0MVhIa1c0?=
 =?utf-8?B?cDZYV2dFUFlLekZXb3BTc1RhakU5eU1neFBaWmgvS0hhRmMwSkp6ZzZzUXFt?=
 =?utf-8?B?U29EUmlBN2RLUVhDMmprVXV1bFpsdXZYaDMrWW5xWXpCODc0Q0lCNUR4d2lC?=
 =?utf-8?B?Y1ZXR0ZuQ0VKN2Ewa2ZDWUFZSmxYR3Z0dTd6WlhyY21nSUh5S0M5T0poZzVQ?=
 =?utf-8?B?SnRJUEhZNEFoUGtsTC90UVgwN3pvOTdBUGJIUGdlMTI0bDBXdUlhUDlzWHBi?=
 =?utf-8?B?eGcwMnNtaTBnc0dUOTJaS3FHd1JKYXNOYlh1S3JVZUdIU1k1blpkbWRaRzFF?=
 =?utf-8?B?NkE4THlxT3VORkRKWDROS1hzQlR6MitMYWxEYWNoM3YxY2JZVnp2QUIvaVMw?=
 =?utf-8?B?dUVXQWQ4Q0Vpc0lPWGFrMjh3QVFYaFBCQkVJU1pyM2NodnZzV09ZZWZ4K3Jl?=
 =?utf-8?B?MlQ2R3hScS8vRGxzNHVWbDB3UVhwRm1VZmxjMWh5MGg4WmxDVldYckhyeTJK?=
 =?utf-8?B?bytGWnp6c2hOSUpmNHlHYkk2UHVhS3pMQ1Z6a05qVVdWNkd4R0wxaloxb1hk?=
 =?utf-8?B?N3BJaUNxMFkvYTZyaGhxWnBXVGFxVmhJTjE0N2pzeU1xWTZxb2ZJVVRTWDZS?=
 =?utf-8?B?OVB2dVJPcjY4YjdBc21LRE85ejlHSkdqYVh5eGF5V2FtT1BzV0c0OGVvM24x?=
 =?utf-8?B?eTR1QmZmcHFwQ09Vc0hxbVRpdkJLamIrdXNxV2tGdjllQlZkRHVqUWhTdlBp?=
 =?utf-8?B?WjR3a0dTUnNSSmoxQ0traWpreU5zN3BYYnZONTJLUUdDbUJmOVdwcUlaSTR1?=
 =?utf-8?B?TDRBUC9yeG9kZFBOb1hvazAvczhSUjV3eUZXSUFUMTBaSVdLWXpXdzhzcGY2?=
 =?utf-8?B?dHZaWmVEU3ROQkZJYnp3bEdMNzcxbUhPclVjN0orSWM1cXg2cnRUUkwxdXFB?=
 =?utf-8?B?eEkyRFJUcGpTM3lPRXVBamFCL05UcE1KWVFjazNGaTAzazFoVDhiWHNvWnA4?=
 =?utf-8?B?Y1M5T1dNL2x0L25zWFhleWt2NW8za3FEZG1uRzNkZ1BoK2YxV2NHZkxVbFlM?=
 =?utf-8?B?T2NERDFLYjB4TkU5YkdtNzNIdWcyWnU0VFUxekErNzFaU0xRTitubmJlUVAw?=
 =?utf-8?B?NmEwMnMyeDQycTlPZ3JkV1JPQ1dzMHFOY2haNzNjMlpyazkyei9ORTJzZlNo?=
 =?utf-8?B?VjR6Q1hXRnNXSWYzbUQ4WWVoOUkvSmUxendnNnNPL2h1RTNyVHdTMW1acE9C?=
 =?utf-8?B?aGQxSXNaRzdVN3JDUFVUcjBTbXhkaEY5YStPVDVvd011Z0xKNGlMUndFVWhK?=
 =?utf-8?B?d2hkQ204aG1xQkowVEIvWms4N1dHeWVXd01RMlJKV2dMdkhuWkc4L0g4MnBk?=
 =?utf-8?B?djBaZHhTSlhuSGx3ZkZlVWZ6bDZOYVJTajlRZFplc0NTNUlmd3M1ckxIWm1T?=
 =?utf-8?B?K1ZqSWJrR2NwQU0vOEpGYms0MFRXSWNERjYra2x5UXhROU52RCt3S2lSZGJ4?=
 =?utf-8?B?OE9wVklCbTBucmdDNTJHckU5M0tzeVRkajhHS3JmU2hDc01BaGc0Wlo1WGR5?=
 =?utf-8?B?cWV2WmI5VmtRQXVyWXUyeDhVOVExSDkxQ0RpRit1MGhnNzZVNVYxc3c4WU5P?=
 =?utf-8?Q?utyR7XoAVpVqs10MVzUC/dCkqJ0FG8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:13:00.5362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae546d0a-706b-4108-3eb7-08dd500d34b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

The TSM module is a library to create sysfs nodes common for hypervisors
and VMs. It also provides helpers to parse interface reports (required
by VMs, visible to HVs). It registers 3 device classes:
- tsm: one per platform,
- tsm-dev: for physical functions, ("TDEV");
- tdm-tdi: for PCI functions being assigned to VMs ("TDI").

The library adds a child device of "tsm-dev" or/and "tsm-tdi" class
for every capable PCI device. Note that the module is made bus-agnostic.

New device nodes provide sysfs interface for fetching device certificates
and measurements and TDI interface reports.
Nodes with the "_user" suffix provide human-readable information, without
that suffix it is raw binary data to be copied to a guest.

The TSM-HOST module adds hypervisor-only functionality on top. At the
moment it is:
- "connect" to enable/disable IDE (a PCI link encryption);
- "TDI bind" to manage a PCI function passed through to a secure VM.

A platform is expected to register itself in TSM-HOST and provide
necessary callbacks. No platform is added here, AMD SEV is coming in the
next patches.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/virt/coco/Makefile        |   2 +
 drivers/virt/coco/host/Makefile   |   6 +
 include/linux/tsm.h               | 295 +++++++++
 drivers/virt/coco/host/tsm-host.c | 552 +++++++++++++++++
 drivers/virt/coco/tsm.c           | 636 ++++++++++++++++++++
 Documentation/virt/coco/tsm.rst   |  99 +++
 drivers/virt/coco/Kconfig         |  14 +
 drivers/virt/coco/host/Kconfig    |   6 +
 8 files changed, 1610 insertions(+)

diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 885c9ef4e9fc..670f77c564e8 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,9 +2,11 @@
 #
 # Confidential computing related collateral
 #
+obj-$(CONFIG_TSM)		+= tsm.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM_REPORTS)	+= guest/
+obj-$(CONFIG_TSM_HOST)          += host/
diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
new file mode 100644
index 000000000000..c5e216b6cb1c
--- /dev/null
+++ b/drivers/virt/coco/host/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+
+obj-$(CONFIG_TSM_HOST) += tsm_host.o
+tsm_host-y += tsm-host.o
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..486e386d90fc 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,11 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/bitfield.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +114,294 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+
+/* SPDM control structure for DOE */
+struct tsm_spdm {
+	unsigned long req_len;
+	void *req;
+	unsigned long rsp_len;
+	void *rsp;
+};
+
+/* Data object for measurements/certificates/attestationreport */
+struct tsm_blob {
+	void *data;
+	size_t len;
+};
+
+struct tsm_blob *tsm_blob_new(void *data, size_t len);
+static inline void tsm_blob_free(struct tsm_blob *b)
+{
+	kfree(b);
+}
+
+/**
+ * struct tdisp_interface_id - TDISP INTERFACE_ID Definition
+ *
+ * @function_id: Identifies the function of the device hosting the TDI
+ *   15:0: @rid: Requester ID
+ *   23:16: @rseg: Requester Segment (Reserved if Requester Segment Valid is Clear)
+ *   24: @rseg_valid: Requester Segment Valid
+ *   31:25 – Reserved
+ * 8B - Reserved
+ */
+struct tdisp_interface_id {
+	u32 function_id; /* TSM_TDISP_IID_xxxx */
+	u8 reserved[8];
+} __packed;
+
+#define TSM_TDISP_IID_REQUESTER_ID	GENMASK(15, 0)
+#define TSM_TDISP_IID_RSEG		GENMASK(23, 16)
+#define TSM_TDISP_IID_RSEG_VALID	BIT(24)
+
+/*
+ * Measurement block as defined in SPDM DSP0274.
+ */
+struct spdm_measurement_block_header {
+	u8 index;
+	u8 spec; /* MeasurementSpecification */
+	u16 size;
+} __packed;
+
+struct dmtf_measurement_block_header {
+	u8 type;  /* DMTFSpecMeasurementValueType */
+	u16 size; /* DMTFSpecMeasurementValueSize */
+} __packed;
+
+struct dmtf_measurement_block_device_mode {
+	u32 opmode_cap;	 /* OperationalModeCapabilties */
+	u32 opmode_sta;  /* OperationalModeState */
+	u32 devmode_cap; /* DeviceModeCapabilties */
+	u32 devmode_sta; /* DeviceModeState */
+} __packed;
+
+struct spdm_certchain_block_header {
+	u16 length;
+	u16 reserved;
+} __packed;
+
+/*
+ * TDI Report Structure as defined in TDISP.
+ */
+struct tdi_report_header {
+	u16 interface_info; /* TSM_TDI_REPORT_xxx */
+	u16 reserved2;
+	u16 msi_x_message_control;
+	u16 lnr_control;
+	u32 tph_control;
+	u32 mmio_range_count;
+} __packed;
+
+#define _BITSH(x)	(1 << (x))
+#define TSM_TDI_REPORT_NO_FW_UPDATE	_BITSH(0)  /* not updates in CONFIG_LOCKED or RUN */
+#define TSM_TDI_REPORT_DMA_NO_PASID	_BITSH(1)  /* TDI generates DMA requests without PASID */
+#define TSM_TDI_REPORT_DMA_PASID	_BITSH(2)  /* TDI generates DMA requests with PASID */
+#define TSM_TDI_REPORT_ATS		_BITSH(3)  /* ATS supported and enabled for the TDI */
+#define TSM_TDI_REPORT_PRS		_BITSH(4)  /* PRS supported and enabled for the TDI */
+
+/*
+ * Each MMIO Range of the TDI is reported with the MMIO reporting offset added.
+ * Base and size in units of 4K pages
+ */
+struct tdi_report_mmio_range {
+	u64 first_page; /* First 4K page with offset added */
+	u32 num;	/* Number of 4K pages in this range */
+	u32 range_attributes; /* TSM_TDI_REPORT_MMIO_xxx */
+} __packed;
+
+#define TSM_TDI_REPORT_MMIO_MSIX_TABLE		BIT(0)
+#define TSM_TDI_REPORT_MMIO_PBA			BIT(1)
+#define TSM_TDI_REPORT_MMIO_IS_NON_TEE		BIT(2)
+#define TSM_TDI_REPORT_MMIO_IS_UPDATABLE	BIT(3)
+#define TSM_TDI_REPORT_MMIO_RESERVED		GENMASK(15, 4)
+#define TSM_TDI_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
+
+struct tdi_report_footer {
+	u32 device_specific_info_len;
+	u8 device_specific_info[];
+} __packed;
+
+#define TDI_REPORT_HDR(rep)		((struct tdi_report_header *) ((rep)->data))
+#define TDI_REPORT_MR_NUM(rep)		(TDI_REPORT_HDR(rep)->mmio_range_count)
+#define TDI_REPORT_MR_OFF(rep)		((struct tdi_report_mmio_range *) (TDI_REPORT_HDR(rep) + 1))
+#define TDI_REPORT_MR(rep, rangeid)	TDI_REPORT_MR_OFF(rep)[rangeid]
+#define TDI_REPORT_FTR(rep)		((struct tdi_report_footer *) &TDI_REPORT_MR((rep), \
+					TDI_REPORT_MR_NUM(rep)))
+
+struct tsm_bus_ops;
+
+/* Physical device descriptor responsible for IDE/TDISP setup */
+struct tsm_dev {
+	const struct attribute_group *ag;
+	struct device *physdev; /* Physical PCI function #0 */
+	struct device dev; /* A child device of PCI function #0 */
+	struct tsm_spdm spdm;
+	struct mutex spdm_mutex;
+
+	u8 cert_slot;
+	u8 connected;
+	unsigned int bound;
+
+	struct tsm_blob *meas;
+	struct tsm_blob *certs;
+#define TSM_MAX_NONCE_LEN	64
+	u8 nonce[TSM_MAX_NONCE_LEN];
+	size_t nonce_len;
+
+	void *data; /* Platform specific data */
+
+	struct tsm_subsys *tsm;
+	struct tsm_bus_subsys *tsm_bus;
+	/* Bus specific data follow this struct, see tsm_dev_to_bdata */
+};
+
+#define tsm_dev_to_bdata(tdev)	((tdev)?((void *)&(tdev)[1]):NULL)
+
+/* PCI function for passing through, can be the same as tsm_dev::pdev */
+struct tsm_tdi {
+	const struct attribute_group *ag;
+	struct device dev; /* A child device of PCI VF */
+	struct list_head node;
+	struct tsm_dev *tdev;
+
+	u8 rseg;
+	u8 rseg_valid;
+	bool validated;
+
+	struct tsm_blob *report;
+
+	void *data; /* Platform specific data */
+
+	struct kvm *kvm;
+	u16 guest_rid; /* BDFn of PCI Fn in the VM (when PCI TDISP) */
+};
+
+struct tsm_dev_status {
+	u8 ctx_state;
+	u8 tc_mask;
+	u8 certs_slot;
+	u16 device_id;
+	u16 segment_id;
+	u8 no_fw_update;
+	u16 ide_stream_id[8];
+};
+
+enum tsm_spdm_algos {
+	TSM_SPDM_ALGOS_DHE_SECP256R1,
+	TSM_SPDM_ALGOS_DHE_SECP384R1,
+	TSM_SPDM_ALGOS_AEAD_AES_128_GCM,
+	TSM_SPDM_ALGOS_AEAD_AES_256_GCM,
+	TSM_SPDM_ALGOS_ASYM_TPM_ALG_RSASSA_3072,
+	TSM_SPDM_ALGOS_ASYM_TPM_ALG_ECDSA_ECC_NIST_P256,
+	TSM_SPDM_ALGOS_ASYM_TPM_ALG_ECDSA_ECC_NIST_P384,
+	TSM_SPDM_ALGOS_HASH_TPM_ALG_SHA_256,
+	TSM_SPDM_ALGOS_HASH_TPM_ALG_SHA_384,
+	TSM_SPDM_ALGOS_KEY_SCHED_SPDM_KEY_SCHEDULE,
+};
+
+enum tsm_tdisp_state {
+	TDISP_STATE_CONFIG_UNLOCKED,
+	TDISP_STATE_CONFIG_LOCKED,
+	TDISP_STATE_RUN,
+	TDISP_STATE_ERROR,
+};
+
+struct tsm_tdi_status {
+	bool valid;
+	u8 meas_digest_fresh:1;
+	u8 meas_digest_valid:1;
+	u8 all_request_redirect:1;
+	u8 bind_p2p:1;
+	u8 lock_msix:1;
+	u8 no_fw_update:1;
+	u16 cache_line_size;
+	u64 spdm_algos; /* Bitmask of TSM_SPDM_ALGOS */
+	u8 certs_digest[48];
+	u8 meas_digest[48];
+	u8 interface_report_digest[48];
+	u64 intf_report_counter;
+	struct tdisp_interface_id id;
+	enum tsm_tdisp_state state;
+};
+
+struct tsm_bus_ops {
+	int (*spdm_forward)(struct tsm_spdm *spdm, u8 type);
+};
+
+struct tsm_bus_subsys {
+	struct tsm_bus_ops *ops;
+	struct notifier_block notifier;
+	struct tsm_subsys *tsm;
+};
+
+struct tsm_bus_subsys *pci_tsm_register(struct tsm_subsys *tsm_subsys);
+void pci_tsm_unregister(struct tsm_bus_subsys *subsys);
+
+/* tsm_hv_ops return codes for SPDM bouncing, when requested by the TSM */
+#define TSM_PROTO_CMA_SPDM		1
+#define TSM_PROTO_SECURED_CMA_SPDM	2
+
+struct tsm_hv_ops {
+	int (*dev_connect)(struct tsm_dev *tdev, void *private_data);
+	int (*dev_disconnect)(struct tsm_dev *tdev);
+	int (*dev_status)(struct tsm_dev *tdev, struct tsm_dev_status *s);
+	int (*dev_measurements)(struct tsm_dev *tdev);
+	int (*tdi_bind)(struct tsm_tdi *tdi, u32 bdfn, u64 vmid);
+	int (*tdi_unbind)(struct tsm_tdi *tdi);
+	int (*guest_request)(struct tsm_tdi *tdi, u8 __user *req, size_t reqlen,
+			     u8 __user *rsp, size_t rsplen, int *fw_err);
+	int (*tdi_status)(struct tsm_tdi *tdi, struct tsm_tdi_status *ts);
+};
+
+struct tsm_subsys {
+	struct device dev;
+	struct list_head tdi_head;
+	struct mutex lock;
+	const struct attribute_group *tdev_groups[3]; /* Common, host/guest, NULL */
+	const struct attribute_group *tdi_groups[3]; /* Common, host/guest, NULL */
+	int (*update_measurements)(struct tsm_dev *tdev);
+};
+
+struct tsm_subsys *tsm_register(struct device *parent, size_t extra,
+				const struct attribute_group *tdev_ag,
+				const struct attribute_group *tdi_ag,
+				int (*update_measurements)(struct tsm_dev *tdev));
+void tsm_unregister(struct tsm_subsys *subsys);
+
+struct tsm_host_subsys;
+struct tsm_host_subsys *tsm_host_register(struct device *parent,
+					  struct tsm_hv_ops *hvops,
+					  void *private_data);
+struct tsm_dev *tsm_dev_get(struct device *dev);
+void tsm_dev_put(struct tsm_dev *tdev);
+struct tsm_tdi *tsm_tdi_get(struct device *dev);
+void tsm_tdi_put(struct tsm_tdi *tdi);
+
+struct pci_dev;
+int pci_dev_tdi_validate(struct pci_dev *pdev, bool invalidate);
+int pci_dev_tdi_mmio_config(struct pci_dev *pdev, u32 range_id, bool tee);
+
+int tsm_dev_init(struct tsm_bus_subsys *tsm_bus, struct device *parent,
+		 size_t busdatalen, struct tsm_dev **ptdev);
+void tsm_dev_free(struct tsm_dev *tdev);
+int tsm_tdi_init(struct tsm_dev *tdev, struct device *dev);
+void tsm_tdi_free(struct tsm_tdi *tdi);
+
+/* IOMMUFD vIOMMU helpers */
+int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd);
+void tsm_tdi_unbind(struct tsm_tdi *tdi);
+int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t reqlen,
+		      u8 __user *res, size_t reslen, int *fw_err);
+
+/* Debug */
+ssize_t tsm_report_gen(struct tsm_blob *report, char *b, size_t len);
+
+/* IDE */
+int tsm_create_link(struct tsm_subsys *tsm, struct device *dev, const char *name);
+void tsm_remove_link(struct tsm_subsys *tsm, const char *name);
+#define tsm_register_ide_stream(tdev, ide) \
+	tsm_create_link((tdev)->tsm, &(tdev)->dev, (ide)->name)
+#define tsm_unregister_ide_stream(tdev, ide) \
+	tsm_remove_link((tdev)->tsm, (ide)->name)
+
 #endif /* __TSM_H */
diff --git a/drivers/virt/coco/host/tsm-host.c b/drivers/virt/coco/host/tsm-host.c
new file mode 100644
index 000000000000..80f3315fb195
--- /dev/null
+++ b/drivers/virt/coco/host/tsm-host.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+#include <linux/file.h>
+#include <linux/kvm_host.h>
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"aik@amd.com"
+#define DRIVER_DESC	"TSM host library"
+
+struct tsm_host_subsys {
+	struct tsm_subsys base;
+	struct tsm_hv_ops *ops;
+	void *private_data;
+};
+
+static int tsm_dev_connect(struct tsm_dev *tdev)
+{
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	if (WARN_ON(!hsubsys->ops->dev_connect))
+		return -EPERM;
+
+	if (WARN_ON(!tdev->tsm_bus))
+		return -EPERM;
+
+	mutex_lock(&tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->dev_connect(tdev, hsubsys->private_data);
+		if (ret <= 0)
+			break;
+
+		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	tdev->connected = (ret == 0);
+
+	return ret;
+}
+
+static int tsm_dev_reclaim(struct tsm_dev *tdev)
+{
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	if (WARN_ON(!hsubsys->ops->dev_disconnect))
+		return -EPERM;
+
+	/* Do not disconnect with active TDIs */
+	if (tdev->bound)
+		return -EBUSY;
+
+	mutex_lock(&tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->dev_disconnect(tdev);
+		if (ret <= 0)
+			break;
+
+		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	if (!ret)
+		tdev->connected = false;
+
+	return ret;
+}
+
+static int tsm_dev_status(struct tsm_dev *tdev, struct tsm_dev_status *s)
+{
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+
+	if (WARN_ON(!hsubsys->ops->dev_status))
+		return -EPERM;
+
+	return hsubsys->ops->dev_status(tdev, s);
+}
+
+static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
+{
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	while (1) {
+		ret = hsubsys->ops->dev_measurements(tdev);
+		if (ret <= 0)
+			break;
+
+		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static void tsm_tdi_reclaim(struct tsm_tdi *tdi)
+{
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	if (WARN_ON(!hsubsys->ops->tdi_unbind))
+		return;
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->tdi_unbind(tdi);
+		if (ret <= 0)
+			break;
+
+		ret = tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+}
+
+static int tsm_tdi_status(struct tsm_tdi *tdi, void *private_data, struct tsm_tdi_status *ts)
+{
+	struct tsm_tdi_status tstmp = { 0 };
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->tdi_status(tdi, &tstmp);
+		if (ret <= 0)
+			break;
+
+		ret = tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+
+	if (!ret)
+		*ts = tstmp;
+
+	return ret;
+}
+
+static ssize_t tsm_cert_slot_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t ret = count;
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		ret = -EINVAL;
+	else
+		tdev->cert_slot = val;
+
+	return ret;
+}
+
+static ssize_t tsm_cert_slot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t ret = sysfs_emit(buf, "%u\n", tdev->cert_slot);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(tsm_cert_slot);
+
+static ssize_t tsm_dev_connect_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	unsigned long val;
+	ssize_t ret = -EIO;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		ret = -EINVAL;
+	else if (val && !tdev->connected)
+		ret = tsm_dev_connect(tdev);
+	else if (!val && tdev->connected)
+		ret = tsm_dev_reclaim(tdev);
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+
+static ssize_t tsm_dev_connect_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t ret = sysfs_emit(buf, "%u\n", tdev->connected);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(tsm_dev_connect);
+
+static ssize_t tsm_dev_status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	struct tsm_dev_status s = { 0 };
+	int ret = tsm_dev_status(tdev, &s);
+	ssize_t ret1;
+
+	ret1 = sysfs_emit(buf, "ret=%d\n"
+			  "ctx_state=%x\n"
+			  "tc_mask=%x\n"
+			  "certs_slot=%x\n"
+			  "device_id=%x:%x.%d\n"
+			  "segment_id=%x\n"
+			  "no_fw_update=%x\n",
+			  ret,
+			  s.ctx_state,
+			  s.tc_mask,
+			  s.certs_slot,
+			  (s.device_id >> 8) & 0xff,
+			  (s.device_id >> 3) & 0x1f,
+			  s.device_id & 0x07,
+			  s.segment_id,
+			  s.no_fw_update);
+
+	tsm_dev_put(tdev);
+	return ret1;
+}
+
+static DEVICE_ATTR_RO(tsm_dev_status);
+
+static struct attribute *host_dev_attrs[] = {
+	&dev_attr_tsm_cert_slot.attr,
+	&dev_attr_tsm_dev_connect.attr,
+	&dev_attr_tsm_dev_status.attr,
+	NULL,
+};
+static const struct attribute_group host_dev_group = {
+	.attrs = host_dev_attrs,
+};
+
+static ssize_t tsm_tdi_bind_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+
+	if (!tdi->kvm)
+		return sysfs_emit(buf, "not bound\n");
+
+	return sysfs_emit(buf, "VM=%p BDFn=%x:%x.%d\n",
+			  tdi->kvm,
+			  (tdi->guest_rid >> 8) & 0xff,
+			  (tdi->guest_rid >> 3) & 0x1f,
+			  tdi->guest_rid & 0x07);
+}
+
+static DEVICE_ATTR_RO(tsm_tdi_bind);
+
+static char *spdm_algos_to_str(u64 algos, char *buf, size_t len)
+{
+	size_t n = 0;
+
+	buf[0] = 0;
+#define __ALGO(x) do {								\
+		if ((n < len) && (algos & (1ULL << (TSM_TDI_SPDM_ALGOS_##x))))	\
+			n += snprintf(buf + n, len - n, #x" ");			\
+	} while (0)
+
+	__ALGO(DHE_SECP256R1);
+	__ALGO(DHE_SECP384R1);
+	__ALGO(AEAD_AES_128_GCM);
+	__ALGO(AEAD_AES_256_GCM);
+	__ALGO(ASYM_TPM_ALG_RSASSA_3072);
+	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P256);
+	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P384);
+	__ALGO(HASH_TPM_ALG_SHA_256);
+	__ALGO(HASH_TPM_ALG_SHA_384);
+	__ALGO(KEY_SCHED_SPDM_KEY_SCHEDULE);
+#undef __ALGO
+	return buf;
+}
+
+static const char *tdisp_state_to_str(enum tsm_tdisp_state state)
+{
+	switch (state) {
+#define __ST(x) case TDISP_STATE_##x: return #x
+	case TDISP_STATE_UNAVAIL: return "TDISP state unavailable";
+	__ST(CONFIG_UNLOCKED);
+	__ST(CONFIG_LOCKED);
+	__ST(RUN);
+	__ST(ERROR);
+#undef __ST
+	default: return "unknown";
+	}
+}
+
+static ssize_t tsm_tdi_status_user_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	struct tsm_tdi_status ts = { 0 };
+	char algos[256] = "";
+	unsigned int n, m;
+	int ret;
+
+	ret = tsm_tdi_status(tdi, hsubsys->private_data, &ts);
+	if (ret < 0)
+		return sysfs_emit(buf, "ret=%d\n\n", ret);
+
+	if (!ts.valid)
+		return sysfs_emit(buf, "ret=%d\nstate=%d:%s\n",
+				  ret, ts.state, tdisp_state_to_str(ts.state));
+
+	n = snprintf(buf, PAGE_SIZE,
+		     "ret=%d\n"
+		     "state=%d:%s\n"
+		     "meas_digest_fresh=%x\n"
+		     "meas_digest_valid=%x\n"
+		     "all_request_redirect=%x\n"
+		     "bind_p2p=%x\n"
+		     "lock_msix=%x\n"
+		     "no_fw_update=%x\n"
+		     "cache_line_size=%d\n"
+		     "algos=%#llx:%s\n"
+		     "report_counter=%lld\n"
+		     ,
+		     ret,
+		     ts.state, tdisp_state_to_str(ts.state),
+		     ts.meas_digest_fresh,
+		     ts.meas_digest_valid,
+		     ts.all_request_redirect,
+		     ts.bind_p2p,
+		     ts.lock_msix,
+		     ts.no_fw_update,
+		     ts.cache_line_size,
+		     ts.spdm_algos, spdm_algos_to_str(ts.spdm_algos, algos, sizeof(algos) - 1),
+		     ts.intf_report_counter);
+
+	n += snprintf(buf + n, PAGE_SIZE - n, "Certs digest: ");
+	m = hex_dump_to_buffer(ts.certs_digest, sizeof(ts.certs_digest), 32, 1,
+			       buf + n, PAGE_SIZE - n, false);
+	n += min(PAGE_SIZE - n, m);
+	n += snprintf(buf + n, PAGE_SIZE - n, "...\nMeasurements digest: ");
+	m = hex_dump_to_buffer(ts.meas_digest, sizeof(ts.meas_digest), 32, 1,
+			       buf + n, PAGE_SIZE - n, false);
+	n += min(PAGE_SIZE - n, m);
+	n += snprintf(buf + n, PAGE_SIZE - n, "...\nInterface report digest: ");
+	m = hex_dump_to_buffer(ts.interface_report_digest, sizeof(ts.interface_report_digest),
+			       32, 1, buf + n, PAGE_SIZE - n, false);
+	n += min(PAGE_SIZE - n, m);
+	n += snprintf(buf + n, PAGE_SIZE - n, "...\n");
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_tdi_status_user);
+
+static ssize_t tsm_tdi_status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	struct tsm_tdi_status ts = { 0 };
+	u8 state;
+	int ret;
+
+	ret = tsm_tdi_status(tdi, hsubsys->private_data, &ts);
+	if (ret)
+		return ret;
+
+	state = ts.state;
+	memcpy(buf, &state, sizeof(state));
+
+	return sizeof(state);
+}
+
+static DEVICE_ATTR_RO(tsm_tdi_status);
+
+static struct attribute *host_tdi_attrs[] = {
+	&dev_attr_tsm_tdi_bind.attr,
+	&dev_attr_tsm_tdi_status_user.attr,
+	&dev_attr_tsm_tdi_status.attr,
+	NULL,
+};
+
+static const struct attribute_group host_tdi_group = {
+	.attrs = host_tdi_attrs,
+};
+
+int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd)
+{
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	struct fd f = fdget(kvmfd);
+	struct kvm *kvm;
+	u64 vmid;
+	int ret;
+
+	if (!fd_file(f))
+		return -EBADF;
+
+	if (!file_is_kvm(fd_file(f))) {
+		ret = -EBADF;
+		goto out_fput;
+	}
+
+	kvm = fd_file(f)->private_data;
+	if (!kvm || !kvm_get_kvm_safe(kvm)) {
+		ret = -EFAULT;
+		goto out_fput;
+	}
+
+	vmid = kvm_arch_tsm_get_vmid(kvm);
+	if (!vmid) {
+		ret = -EFAULT;
+		goto out_kvm_put;
+	}
+
+	if (WARN_ON(!hsubsys->ops->tdi_bind)) {
+		ret = -EPERM;
+		goto out_kvm_put;
+	}
+
+	if (!tdev->connected) {
+		ret = -EIO;
+		goto out_kvm_put;
+	}
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->tdi_bind(tdi, guest_rid, vmid);
+		if (ret < 0)
+			break;
+
+		if (!ret)
+			break;
+
+		ret = tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
+		if (ret < 0)
+			break;
+	}
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+
+	if (ret) {
+		tsm_tdi_unbind(tdi);
+		goto out_kvm_put;
+	}
+
+	tdi->guest_rid = guest_rid;
+	tdi->kvm = kvm;
+	++tdi->tdev->bound;
+	goto out_fput;
+
+out_kvm_put:
+	kvm_put_kvm(kvm);
+out_fput:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_bind);
+
+void tsm_tdi_unbind(struct tsm_tdi *tdi)
+{
+	if (tdi->kvm) {
+		tsm_tdi_reclaim(tdi);
+		--tdi->tdev->bound;
+		kvm_put_kvm(tdi->kvm);
+		tdi->kvm = NULL;
+	}
+
+	tdi->guest_rid = 0;
+	tdi->dev.parent->tdi_enabled = false;
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_unbind);
+
+int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t reqlen,
+		      u8 __user *res, size_t reslen, int *fw_err)
+{
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *) tdev->tsm;
+	int ret;
+
+	if (!hsubsys->ops->guest_request)
+		return -EPERM;
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	while (1) {
+		ret = hsubsys->ops->guest_request(tdi, req, reqlen,
+						  res, reslen, fw_err);
+		if (ret <= 0)
+			break;
+
+		ret = tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm,
+							    ret);
+		if (ret < 0)
+			break;
+	}
+
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tsm_guest_request);
+
+struct tsm_host_subsys *tsm_host_register(struct device *parent,
+					  struct tsm_hv_ops *hvops,
+					  void *private_data)
+{
+	struct tsm_subsys *subsys = tsm_register(parent, sizeof(struct tsm_host_subsys),
+						 &host_dev_group, &host_tdi_group,
+						 tsm_tdi_measurements_locked);
+	struct tsm_host_subsys *hsubsys;
+
+	hsubsys = (struct tsm_host_subsys *) subsys;
+
+	if (IS_ERR(hsubsys))
+		return hsubsys;
+
+	hsubsys->ops = hvops;
+	hsubsys->private_data = private_data;
+
+	return hsubsys;
+}
+EXPORT_SYMBOL_GPL(tsm_host_register);
+
+static int __init tsm_init(void)
+{
+	int ret = 0;
+
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	return ret;
+}
+
+static void __exit tsm_exit(void)
+{
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION " shutdown\n");
+}
+
+module_init(tsm_init);
+module_exit(tsm_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
new file mode 100644
index 000000000000..b6235d1210ca
--- /dev/null
+++ b/drivers/virt/coco/tsm.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"aik@amd.com"
+#define DRIVER_DESC	"TSM library"
+
+static struct class *tsm_class, *tdev_class, *tdi_class;
+
+/* snprintf does not check for the size, hence this wrapper */
+static int tsmprint(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	size_t i;
+
+	if (!size)
+		return 0;
+
+	va_start(args, fmt);
+	i = vsnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return min(i, size);
+}
+
+struct tsm_blob *tsm_blob_new(void *data, size_t len)
+{
+	struct tsm_blob *b;
+
+	if (!len || !data)
+		return NULL;
+
+	b = kzalloc(sizeof(*b) + len, GFP_KERNEL);
+	if (!b)
+		return NULL;
+
+	b->data = (void *)b + sizeof(*b);
+	b->len = len;
+	memcpy(b->data, data, len);
+
+	return b;
+}
+EXPORT_SYMBOL_GPL(tsm_blob_new);
+
+static int match_class(struct device *dev, const void *data)
+{
+	return dev->class == data;
+}
+
+struct tsm_dev *tsm_dev_get(struct device *parent)
+{
+	struct device *dev = device_find_child(parent, tdev_class, match_class);
+
+	if (!dev) {
+		dev = device_find_child(parent, tdi_class, match_class);
+		if (dev) {
+			struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+
+			dev = &tdi->tdev->dev;
+		}
+	}
+
+	if (!dev)
+		return NULL;
+
+	/* device_find_child() does get_device() */
+	return container_of(dev, struct tsm_dev, dev);
+}
+EXPORT_SYMBOL_GPL(tsm_dev_get);
+
+void tsm_dev_put(struct tsm_dev *tdev)
+{
+	put_device(&tdev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_dev_put);
+
+struct tsm_tdi *tsm_tdi_get(struct device *parent)
+{
+	struct device *dev = device_find_child(parent, tdi_class, match_class);
+
+	if (!dev)
+		return NULL;
+
+	/* device_find_child() does get_device() */
+	return container_of(dev, struct tsm_tdi, dev);
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_get);
+
+void tsm_tdi_put(struct tsm_tdi *tdi)
+{
+	put_device(&tdi->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_put);
+
+static ssize_t blob_show(struct tsm_blob *blob, char *buf)
+{
+	unsigned int n, m;
+	size_t sz = PAGE_SIZE - 1;
+
+	if (!blob)
+		return sysfs_emit(buf, "none\n");
+
+	n = tsmprint(buf, sz, "%lu %u\n", blob->len);
+	m = hex_dump_to_buffer(blob->data, blob->len, 32, 1,
+			       buf + n, sz - n, false);
+	n += min(sz - n, m);
+	n += tsmprint(buf + n, sz - n, "...\n");
+	return n;
+}
+
+static ssize_t tsm_certs_gen(struct tsm_blob *certs, char *buf, size_t len)
+{
+	struct spdm_certchain_block_header *h;
+	unsigned int n = 0, m, i, off, o2;
+	u8 *p;
+
+	for (i = 0, off = 0; off < certs->len; ++i) {
+		h = (struct spdm_certchain_block_header *) ((u8 *)certs->data + off);
+		if (WARN_ON_ONCE(h->length > certs->len - off))
+			return 0;
+
+		n += tsmprint(buf + n, len - n, "[%d] len=%d:\n", i, h->length);
+
+		for (o2 = 0, p = (u8 *)&h[1]; o2 < h->length; o2 += 32) {
+			m = hex_dump_to_buffer(p + o2, h->length - o2, 32, 1,
+					       buf + n, len - n, true);
+			n += min(len - n, m);
+			n += tsmprint(buf + n, len - n, "\n");
+		}
+
+		off += h->length; /* Includes the header */
+	}
+
+	return n;
+}
+
+static ssize_t tsm_certs_user_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t n;
+
+	mutex_lock(&tdev->spdm_mutex);
+	if (!tdev->certs) {
+		n = sysfs_emit(buf, "none\n");
+	} else {
+		n = tsm_certs_gen(tdev->certs, buf, PAGE_SIZE - 1);
+		if (!n)
+			n = blob_show(tdev->certs, buf);
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_certs_user);
+
+static ssize_t tsm_certs_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t n = 0;
+
+	mutex_lock(&tdev->spdm_mutex);
+	if (tdev->certs) {
+		n = min(PAGE_SIZE, tdev->certs->len);
+		memcpy(buf, tdev->certs->data, n);
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_certs);
+
+static ssize_t tsm_meas_gen(struct tsm_blob *meas, char *buf, size_t len)
+{
+	static const char * const whats[] = {
+		"ImmuROM", "MutFW", "HWCfg", "FWCfg",
+		"MeasMft", "DevDbg", "MutFWVer", "MutFWVerSec"
+	};
+	struct dmtf_measurement_block_device_mode *dm;
+	struct spdm_measurement_block_header *mb;
+	struct dmtf_measurement_block_header *h;
+	unsigned int n, m, off, what;
+	bool dmtf;
+
+	n = tsmprint(buf, len, "Len=%d\n", meas->len);
+	for (off = 0; off < meas->len; ) {
+		mb = (struct spdm_measurement_block_header *)(((u8 *) meas->data) + off);
+		dmtf = mb->spec & 1;
+
+		n += tsmprint(buf + n, len - n, "#%d (%d) ", mb->index, mb->size);
+		if (dmtf) {
+			h = (void *) &mb[1];
+
+			if (WARN_ON_ONCE(mb->size != (sizeof(*h) + h->size)))
+				return -EINVAL;
+
+			what = h->type & 0x7F;
+			n += tsmprint(buf + n, len - n, "%x=[%s %s]: ",
+				h->type,
+				h->type & 0x80 ? "digest" : "raw",
+				what < ARRAY_SIZE(whats) ? whats[what] : "reserved");
+
+			if (what == 5) {
+				dm = (struct dmtf_measurement_block_device_mode *) &h[1];
+				n += tsmprint(buf + n, len - n, " %x %x %x %x",
+					      dm->opmode_cap, dm->opmode_sta,
+					      dm->devmode_cap, dm->devmode_sta);
+			} else {
+				m = hex_dump_to_buffer(&h[1], h->size, 32, 1,
+						       buf + n, len - n, false);
+				n += min(len - n, m);
+			}
+		} else {
+			n += tsmprint(buf + n, len - n, "spec=%x: ", mb->spec);
+			m = hex_dump_to_buffer(&mb[1], min(len - off, mb->size),
+					       32, 1, buf + n, len - n, false);
+			n += min(len - n, m);
+		}
+
+		off += sizeof(*mb) + mb->size;
+		n += tsmprint(buf + n, len - n, "...\n");
+	}
+
+	return n;
+}
+
+static ssize_t tsm_meas_user_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t n;
+
+	mutex_lock(&tdev->spdm_mutex);
+	n = tdev->tsm->update_measurements(tdev);
+
+	if (!tdev->meas || n) {
+		n = sysfs_emit(buf, "none\n");
+	} else {
+		n = tsm_meas_gen(tdev->meas, buf, PAGE_SIZE);
+		if (!n)
+			n = blob_show(tdev->meas, buf);
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_meas_user);
+
+static ssize_t tsm_meas_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = container_of(dev, struct tsm_dev, dev);
+	ssize_t n = 0;
+
+	mutex_lock(&tdev->spdm_mutex);
+	n = tdev->tsm->update_measurements(tdev);
+	if (!n && tdev->meas) {
+		n = MIN(PAGE_SIZE, tdev->meas->len);
+		memcpy(buf, tdev->meas->data, n);
+	}
+	mutex_unlock(&tdev->spdm_mutex);
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_meas);
+
+static ssize_t tsm_nonce_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct tsm_dev *tdev = tsm_dev_get(dev);
+
+	if (!tdev)
+		return -EFAULT;
+
+	tdev->nonce_len = min(count, sizeof(tdev->nonce));
+	mutex_lock(&tdev->spdm_mutex);
+	memcpy(tdev->nonce, buf, tdev->nonce_len);
+	mutex_unlock(&tdev->spdm_mutex);
+	tsm_dev_put(tdev);
+
+	return tdev->nonce_len;
+}
+
+static ssize_t tsm_nonce_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_dev *tdev = tsm_dev_get(dev);
+
+	if (!tdev)
+		return -EFAULT;
+
+	mutex_lock(&tdev->spdm_mutex);
+	memcpy(buf, tdev->nonce, tdev->nonce_len);
+	mutex_unlock(&tdev->spdm_mutex);
+	tsm_dev_put(tdev);
+
+	return tdev->nonce_len;
+}
+
+static DEVICE_ATTR_RW(tsm_nonce);
+
+static struct attribute *dev_attrs[] = {
+	&dev_attr_tsm_certs_user.attr,
+	&dev_attr_tsm_meas_user.attr,
+	&dev_attr_tsm_certs.attr,
+	&dev_attr_tsm_meas.attr,
+	&dev_attr_tsm_nonce.attr,
+	NULL,
+};
+static const struct attribute_group dev_group = {
+	.attrs = dev_attrs,
+};
+
+
+ssize_t tsm_report_gen(struct tsm_blob *report, char *buf, size_t len)
+{
+	struct tdi_report_header *h = TDI_REPORT_HDR(report);
+	struct tdi_report_mmio_range *mr = TDI_REPORT_MR_OFF(report);
+	struct tdi_report_footer *f = TDI_REPORT_FTR(report);
+	unsigned int n, m, i;
+
+	n = tsmprint(buf, len,
+		     "no_fw_update=%u\ndma_no_pasid=%u\ndma_pasid=%u\nats=%u\nprs=%u\n",
+		     FIELD_GET(TSM_TDI_REPORT_NO_FW_UPDATE, h->interface_info),
+		     FIELD_GET(TSM_TDI_REPORT_DMA_NO_PASID, h->interface_info),
+		     FIELD_GET(TSM_TDI_REPORT_DMA_PASID, h->interface_info),
+		     FIELD_GET(TSM_TDI_REPORT_ATS,  h->interface_info),
+		     FIELD_GET(TSM_TDI_REPORT_PRS, h->interface_info));
+	n += tsmprint(buf + n, len - n,
+		      "msi_x_message_control=%#04x\nlnr_control=%#04x\n",
+		      h->msi_x_message_control, h->lnr_control);
+	n += tsmprint(buf + n, len - n, "tph_control=%#08x\n", h->tph_control);
+
+	for (i = 0; i < h->mmio_range_count; ++i) {
+#define FIELD_CH(m, r) (FIELD_GET((m), (r)) ? '+':'-')
+		n += tsmprint(buf + n, len - n,
+			      "[%i] #%lu %#016llx +%#lx MSIX%c PBA%c NonTEE%c Upd%c\n",
+			      i,
+			      FIELD_GET(TSM_TDI_REPORT_MMIO_RANGE_ID, mr[i].range_attributes),
+			      mr[i].first_page << PAGE_SHIFT,
+			      (unsigned long) mr[i].num << PAGE_SHIFT,
+			      FIELD_CH(TSM_TDI_REPORT_MMIO_MSIX_TABLE, mr[i].range_attributes),
+			      FIELD_CH(TSM_TDI_REPORT_MMIO_PBA, mr[i].range_attributes),
+			      FIELD_CH(TSM_TDI_REPORT_MMIO_IS_NON_TEE, mr[i].range_attributes),
+			      FIELD_CH(TSM_TDI_REPORT_MMIO_IS_UPDATABLE, mr[i].range_attributes));
+
+		if (FIELD_GET(TSM_TDI_REPORT_MMIO_RESERVED, mr[i].range_attributes))
+			n += tsmprint(buf + n, len - n,
+				      "[%i] WARN: reserved=%#x\n", i, mr[i].range_attributes);
+	}
+
+	if (f->device_specific_info_len) {
+		unsigned int num = report->len - ((u8 *)f->device_specific_info - (u8 *)h);
+
+		num = min(num, f->device_specific_info_len);
+		n += tsmprint(buf + n, len - n, "DevSp len=%d%s",
+			f->device_specific_info_len, num ? ": " : "");
+		m = hex_dump_to_buffer(f->device_specific_info, num, 32, 1,
+				       buf + n, len - n, false);
+		n += min(len - n, m);
+		n += tsmprint(buf + n, len - n, m ? "\n" : "...\n");
+	}
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(tsm_report_gen);
+
+static ssize_t tsm_report_user_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+	ssize_t n;
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	if (!tdi->report) {
+		n = sysfs_emit(buf, "none\n");
+	} else {
+		n = tsm_report_gen(tdi->report, buf, PAGE_SIZE - 1);
+		if (!n)
+			n = blob_show(tdi->report, buf);
+	}
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+
+	return n;
+}
+
+static DEVICE_ATTR_RO(tsm_report_user);
+
+static ssize_t tsm_report_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+	ssize_t n = 0;
+
+	mutex_lock(&tdi->tdev->spdm_mutex);
+	if (tdi->report) {
+		n = min(PAGE_SIZE, tdi->report->len);
+		memcpy(buf, tdi->report->data, n);
+	}
+	mutex_unlock(&tdi->tdev->spdm_mutex);
+
+	return n;
+}
+static DEVICE_ATTR_RO(tsm_report);
+
+static struct attribute *tdi_attrs[] = {
+	&dev_attr_tsm_report_user.attr,
+	&dev_attr_tsm_report.attr,
+	NULL,
+};
+
+static const struct attribute_group tdi_group = {
+	.attrs = tdi_attrs,
+};
+
+int tsm_tdi_init(struct tsm_dev *tdev, struct device *parent)
+{
+	struct tsm_tdi *tdi;
+	struct device *dev;
+	int ret = 0;
+
+	dev_info(parent, "Initializing tdi\n");
+	if (!tdev)
+		return -ENODEV;
+
+	tdi = kzalloc(sizeof(*tdi), GFP_KERNEL);
+	if (!tdi)
+		return -ENOMEM;
+
+	dev = &tdi->dev;
+	dev->groups = tdev->tsm->tdi_groups;
+	dev->parent = parent;
+	dev->class = tdi_class;
+	dev_set_name(dev, "tdi:%s", dev_name(parent));
+	device_initialize(dev);
+	ret = device_add(dev);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&parent->kobj, &tdev->dev.kobj, "tsm_dev");
+	if (ret)
+		goto free_exit;
+
+	tdi->tdev = tdev;
+
+	return 0;
+
+free_exit:
+	kfree(tdi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_init);
+
+void tsm_tdi_free(struct tsm_tdi *tdi)
+{
+	struct device *parent = tdi->dev.parent;
+
+	dev_notice(&tdi->dev, "Freeing tdi\n");
+	sysfs_remove_link(&parent->kobj, "tsm_dev");
+	device_unregister(&tdi->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_tdi_free);
+
+int tsm_dev_init(struct tsm_bus_subsys *tsm_bus, struct device *parent,
+		 size_t busdatalen, struct tsm_dev **ptdev)
+{
+	struct tsm_dev *tdev;
+	struct device *dev;
+	int ret = 0;
+
+	dev_info(parent, "Initializing tdev\n");
+	tdev = kzalloc(sizeof(*tdev) + busdatalen, GFP_KERNEL);
+	if (!tdev)
+		return -ENOMEM;
+
+	tdev->physdev = get_device(parent);
+	mutex_init(&tdev->spdm_mutex);
+
+	tdev->tsm = tsm_bus->tsm;
+	tdev->tsm_bus = tsm_bus;
+
+	dev = &tdev->dev;
+	dev->groups = tdev->tsm->tdev_groups;
+	dev->parent = parent;
+	dev->class = tdev_class;
+	dev_set_name(dev, "tdev:%s", dev_name(parent));
+	device_initialize(dev);
+	ret = device_add(dev);
+
+	get_device(dev);
+	*ptdev = tdev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_dev_init);
+
+void tsm_dev_free(struct tsm_dev *tdev)
+{
+	dev_notice(&tdev->dev, "Freeing tdevice\n");
+	device_unregister(&tdev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_dev_free);
+
+int tsm_create_link(struct tsm_subsys *tsm, struct device *dev, const char *name)
+{
+	return sysfs_create_link(&tsm->dev.kobj, &dev->kobj, name);
+}
+EXPORT_SYMBOL_GPL(tsm_create_link);
+
+void tsm_remove_link(struct tsm_subsys *tsm, const char *name)
+{
+	sysfs_remove_link(&tsm->dev.kobj, name);
+}
+EXPORT_SYMBOL_GPL(tsm_remove_link);
+
+static struct tsm_subsys *alloc_tsm_subsys(struct device *parent, size_t size)
+{
+	struct tsm_subsys *subsys;
+	struct device *dev;
+
+	if (WARN_ON_ONCE(size < sizeof(*subsys)))
+		return ERR_PTR(-EINVAL);
+
+	subsys = kzalloc(size, GFP_KERNEL);
+	if (!subsys)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &subsys->dev;
+	dev->parent = parent;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return subsys;
+}
+
+struct tsm_subsys *tsm_register(struct device *parent, size_t size,
+				const struct attribute_group *tdev_ag,
+				const struct attribute_group *tdi_ag,
+				int (*update_measurements)(struct tsm_dev *tdev))
+{
+	struct tsm_subsys *subsys = alloc_tsm_subsys(parent, size);
+	struct device *dev;
+	int rc;
+
+	if (IS_ERR(subsys))
+		return subsys;
+
+	dev = &subsys->dev;
+	rc = dev_set_name(dev, "tsm0");
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	subsys->tdev_groups[0] = &dev_group;
+	subsys->tdev_groups[1] = tdev_ag;
+	subsys->tdi_groups[0] = &tdi_group;
+	subsys->tdi_groups[1] = tdi_ag;
+	subsys->update_measurements = update_measurements;
+
+	return subsys;
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_subsys *subsys)
+{
+	device_unregister(&subsys->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_subsys *tsm = container_of(dev, typeof(*tsm), dev);
+
+	dev_info(&tsm->dev, "Releasing TSM\n");
+	kfree(tsm);
+}
+
+static void tdev_release(struct device *dev)
+{
+	struct tsm_dev *tdev = container_of(dev, typeof(*tdev), dev);
+
+	dev_info(&tdev->dev, "Releasing %s TDEV\n",
+		 tdev->connected ? "connected":"disconnected");
+	kfree(tdev);
+}
+
+static void tdi_release(struct device *dev)
+{
+	struct tsm_tdi *tdi = container_of(dev, typeof(*tdi), dev);
+
+	dev_info(&tdi->dev, "Releasing %s TDI\n", tdi->kvm ? "bound" : "unbound");
+	sysfs_remove_link(&tdi->dev.parent->kobj, "tsm_dev");
+	kfree(tdi);
+}
+
+static int __init tsm_init(void)
+{
+	int ret = 0;
+
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+	tsm_class->dev_release = tsm_release;
+
+	tdev_class = class_create("tsm-dev");
+	if (IS_ERR(tdev_class))
+		return PTR_ERR(tdev_class);
+	tdev_class->dev_release = tdev_release;
+
+	tdi_class = class_create("tsm-tdi");
+	if (IS_ERR(tdi_class))
+		return PTR_ERR(tdi_class);
+	tdi_class->dev_release = tdi_release;
+
+	return ret;
+}
+
+static void __exit tsm_exit(void)
+{
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION " shutdown\n");
+	class_destroy(tdi_class);
+	class_destroy(tdev_class);
+	class_destroy(tsm_class);
+}
+
+module_init(tsm_init);
+module_exit(tsm_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/Documentation/virt/coco/tsm.rst b/Documentation/virt/coco/tsm.rst
new file mode 100644
index 000000000000..7cb5f1862492
--- /dev/null
+++ b/Documentation/virt/coco/tsm.rst
@@ -0,0 +1,99 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+What it is
+==========
+
+This is for PCI passthrough in confidential computing (CoCo: SEV-SNP, TDX, CoVE).
+Currently passing through PCI devices to a CoCo VM uses SWIOTLB to pre-shared
+memory buffers.
+
+PCIe IDE (Integrity and Data Encryption) and TDISP (TEE Device Interface Security
+Protocol) are protocols to enable encryption over PCIe link and DMA to encrypted
+memory. This doc is focused to DMAing to encrypted VM, the encrypted host memory is
+out of scope.
+
+
+Protocols
+=========
+
+PCIe r6 DOE is a mailbox protocol to read/write object from/to device.
+Objects are of plain SPDM or secure SPDM type. SPDM is responsible for authenticating
+devices, creating a secure link between a device and TSM.
+IDE_KM manages PCIe link encryption keys, it works on top of secure SPDM.
+TDISP manages a passed through PCI function state, also works on top on secure SPDM.
+Additionally, PCIe defines IDE capability which provides the host OS a way
+to enable streams on the PCIe link.
+
+
+TSM modules
+===========
+
+TSM is a library, shared among hosts and guests.
+
+TSM-HOST contains host-specific bits, controls IDE and TDISP bindings.
+
+TSM-GUEST contains guest-specific bits, controls enablement of encrypted DMA and
+MMIO.
+
+TSM-PCI is PCI binding for TSM, calls the above libraries for setting up
+sysfs nodes and corresponding data structures.
+
+
+Flow
+====
+
+At the boot time the tsm.ko scans the PCI bus to find and setup TDISP-cabable
+devices; it also listens to hotplug events. If setup was successful, tsm-prefixed
+nodes will appear in sysfs.
+
+Then, the user enables IDE by writing to /sys/bus/pci/devices/0000:e1:00.0/tsm_dev_connect
+and this is how PCIe encryption is enabled.
+
+To pass the device through, a modifined VMM is required.
+
+In the VM, the same tsm.ko loads. In addition to the host's setup, the VM wants
+to receive the report and enable secure DMA or/and secure MMIO, via some VM<->HV
+protocol (such as AMD GHCB). Once this is done, a VM can access validated MMIO
+with the Cbit set and the device can DMA to encrypted memory.
+
+The sysfs example from a host with a TDISP capable device:
+
+~> find /sys -iname "*tsm*"
+/sys/class/tsm-tdi
+/sys/class/tsm
+/sys/class/tsm/tsm0
+/sys/class/tsm-dev
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm_dev
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_bind
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_status
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_status_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_report_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_report
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm_dev
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_bind
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_status
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_status_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_report_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_report
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_certs
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_nonce
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_meas_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_certs_user
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_status
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_cert_slot
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_connect
+/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_meas
+/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm
+/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm/tsm0
+
+
+References
+==========
+
+[1] TEE Device Interface Security Protocol - TDISP - v2022-07-27
+https://members.pcisig.com/wg/PCI-SIG/document/18268?downloadRevision=21500
+[2] Security Protocol and Data Model (SPDM)
+https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2.1.pdf
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..e4385247440b 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -3,6 +3,18 @@
 # Confidential computing related collateral
 #
 
+config TSM
+	tristate "Platform support for TEE Device Interface Security Protocol (TDISP)"
+	default m
+	depends on AMD_MEM_ENCRYPT
+	select PCI_DOE
+	select PCI_IDE
+	help
+	  Add a common place for user visible platform support for PCIe TDISP.
+	  TEE Device Interface Security Protocol (TDISP) from PCI-SIG,
+	  https://pcisig.com/tee-device-interface-security-protocol-tdisp
+	  This is prerequisite for host and guest support.
+
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/pkvm-guest/Kconfig"
@@ -14,3 +26,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+source "drivers/virt/coco/host/Kconfig"
diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
new file mode 100644
index 000000000000..3bde38b91fd4
--- /dev/null
+++ b/drivers/virt/coco/host/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure and host drivers
+#
+config TSM_HOST
+	tristate
-- 
2.47.1


