Return-Path: <linux-arch+bounces-10193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE19A39A87
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB0B7A4B6E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F723F295;
	Tue, 18 Feb 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pML3E6iy"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34901AF0B7;
	Tue, 18 Feb 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877432; cv=fail; b=iUzU3arUDAtrZo5UGvwgjndnDyZaWpWq8CasVIF+zeRx8+/js7Qmvf4KZPXCL7j9ZgmtJ4bEGBic+G5eUdbB+rykOlKxxrDi51Y2MyH3jUMM9jeGAq7Fh8wVDlb7Ia8K4lCLbg64gHdoh2mI4jdkhjzBy6xOOcafUAhQjIZBrVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877432; c=relaxed/simple;
	bh=z7iOm8bh9TghyXizwBavMmSXStHE7K2cEojmGvKOh4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWYfTXPQyjWV7ld6BAhqBLRKkO6acX8g7EOj+pfGEahLg9j9Te/CpzmuOQL44XAaMP7xNRPyJqmaoVA3BZcj3tmNygX2Bc8uOBc1vvkzOEtzHPFQ1g1xrh3+4FV40Bh34lQPjkZIRREohPXseFbPRPPqUi/xS6n9N0fFZsW+oEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pML3E6iy; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obH4btDPNSTJZbsvW1Q0TCpyDwzcfMEmdNnTNRU/O9FUWgWpo50tDRfZK00UEvs0jMJuVBLEV2O0VHCV7Zc3Vom6Xr0oR1pwtOH3IcTcrNuTqQLrO2UVbtry0n61ECKDiGsO/5b/JJvQXA33jbJQc03w5s20L4SwyfGBIhm+jYKL0DN8bl5QZf58CQ4Kona2qzGBwiNrrDhCXUK6Mu8UKXvZQuswJEq+H3OII0+BMGzGIT0esD97xCU+gopS5YN+97OWNmJsw11+QZIrplc6cI88dmLNZmhCI13X+wWnYLgu7H6iL6MGJMjLo5olYBRDmZZnp/BV8ZL6GjVSyofITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3aM0ECW3j5gVBQRHwomwEGcCZJCz4L4ntXDbIc9/Z4=;
 b=bp4YqQUyMMcFjAUAh7tmpQsA7QkSfEGFfO1fNGbu6xETQz0lvjuD5+dhu3GpVYPb+sCr/UAmGS778iim34/Z+a+O3x7FbXUzNpRE7N7/bPkzkermcSkwZCkbWsl6LzS6s/ba+OJ86BjKOmSOz4wdiWGEiEya/pzlqa0KgJgp7Y/cPh2MnHb4S+fImrLpRoTc97npHHhRJJjxmqAb5WCafUmxFVhMeJspwc+dkvIAWH247a9TwXnMOsZSq37fl3gDsBlsoOIq5L1D55N10vlPUx8DlaxG5+eRRTmu/DaqM6pBKzepgzDkBUUqyQr+2VFF+TNwLWBogHk/ZG2EbhWjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3aM0ECW3j5gVBQRHwomwEGcCZJCz4L4ntXDbIc9/Z4=;
 b=pML3E6iyW1TRkp/a6y5sV66szoW1A3vz38FzO0UeEZBpWEu3eQhWce13iFrgAt5w/wcWGsY3M2FClETjcd/q/hN0/2q3H1dufSZ3xgtriPx2VD3mzRdAJjd3Qk0CSVaBlMdb6vMJ+jHBJbTL5V3lRV7BPzy+LOzfGDEmlvJuw+I=
Received: from CH0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:610:b1::34)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:17:06 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::d4) by CH0PR13CA0029.outlook.office365.com
 (2603:10b6:610:b1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 18 Feb 2025 11:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:17:06 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:16:58 -0600
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
Subject: [RFC PATCH v2 19/22] RFC: pci: Add BUS_NOTIFY_PCI_BUS_MASTER event
Date: Tue, 18 Feb 2025 22:10:06 +1100
Message-ID: <20250218111017.491719-20-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e41e905-9905-4089-0920-08dd500dc749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJg9jMOek6eNg6STLeTALf/X0vGEUcTVHJDW/N7hEEalcmH1l59E+1g5GSBv?=
 =?us-ascii?Q?paZfOuoKrdASLolUMJ5Gtsw/guRJnBzbKfArvPBB2akmsuQpNBsXR5kUOnTu?=
 =?us-ascii?Q?fhNd5eHeLi6R/p+IL/3B/WwbwhD3ubOHVb3K1+z8EBKRz9dFowe6C3kVqHr1?=
 =?us-ascii?Q?lWjOKNCAw3KfTz1GVCcf7Vt3yqyZFTHzkVPVCI8lZd2MnCJVuBQDUGlbokFs?=
 =?us-ascii?Q?ygkbBMOlrzm2DxtBJyGnr3OkDOWxECOnyq1DINYJehNsV3GZlqvwFMrsYO4i?=
 =?us-ascii?Q?Cy780Jwu7r2yMXJrWuoOB6sPBnjZpwvpQK7zq7S7G6toTQqVSf6NxsEJwKSk?=
 =?us-ascii?Q?c0CE6iZO/8aP4ba8wkYJe1YF+yAxtkQ/FRreGMT4pUNrmGJlyT9CILVsv9Hf?=
 =?us-ascii?Q?4o2RfA+RNLLTSmszcPifYMJORp/4gUXaUP51xuwaBQlOut50OQT0+zsAjYl/?=
 =?us-ascii?Q?LQ1OczAF3on7BWpA7vRTqkelD4oq/vbqy9BFkP4inzJxZ+S0lUuDqil8ZJbP?=
 =?us-ascii?Q?R+qNtW5SKBZyTHjhYZaXq0sowT5eyFEFoN1Vd/0zUXIF3qyjOVJI9gbIZeT6?=
 =?us-ascii?Q?xhF762loYqOieBkrG8c32+vEjCOdr8FesxvLwouAcg4JjFMnBMFSSHRaGP21?=
 =?us-ascii?Q?iD8oMBdnzTO+HRRIADacglvPU6gCc/b/m0qbhtswPBUgmuLw1S3hO0VE5Td3?=
 =?us-ascii?Q?cZGk6HzR5o0Rfw0HJguTRwnQB5yqpBvig2CuMorBzy3N7K060jPZr7e5f+Ky?=
 =?us-ascii?Q?qlcaI6LY2cUpQGIFjAuX/060NIYFl+X23KSp9RN/lF0Ccj+uZvJtri1a+Mn7?=
 =?us-ascii?Q?aPbhOSwP1ty1l74xj39OIUeFSS583RCQEndhaBcSUDvbS+v+Et3/+dJULTO/?=
 =?us-ascii?Q?2abfAwTRRECD/3lZ+/pAlS3V4Ak504mjz/H8gai96WxINeOfQ+ZRVs6Fa+VX?=
 =?us-ascii?Q?+qllN85afHqUebVm7JblJ/JRjwxLQ8X6bJc9yGMBdk8ZL1A5WEaj/gtB4nA0?=
 =?us-ascii?Q?qO6LzMT2TzkaEgaiegRqbLAvqPhYCMNq6rV5Yuq9gbUT+fLl3J6urrQFEmqH?=
 =?us-ascii?Q?NoxkZQxNilUvCsA131pkbTmlloSmYQbZbDD+5TOMuaa0d+CGc6YrsaEr0zu+?=
 =?us-ascii?Q?iL7255KUk+/y8Q1Y6LEplO20saK/+gIA2zPYfrgxEb9kU8jhjQPHiHVxXtp0?=
 =?us-ascii?Q?swcUgsY94bkI3No+JuiHfJ795o3VywYB0ijVIgyrNym7g1+rv8x9I3EFYzXc?=
 =?us-ascii?Q?1MJNOmBIh8/LRyfhUrfMGsKVSNBf07rNM83wOIYGUlxZRNl6ypQMDG7N/QIh?=
 =?us-ascii?Q?XrJwE5bhINFORPPrZdNW/ZVAFtG2K5HY0pjHB/ICELARdAmo1FlD+EyD43dR?=
 =?us-ascii?Q?crz2d/VWjuW7RZpMZTVXdNAHHzgzUTgw0/iB73mP6fydVE3TtBXUJCRUvwR8?=
 =?us-ascii?Q?OHJM3r8XkBQzAHIUyMXu+IbtB4h+LZG8Tj7AqtecFyC5PnHfhA6YCYfIJAWq?=
 =?us-ascii?Q?J5gWw9YZXQ0wZh0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:17:06.3946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e41e905-9905-4089-0920-08dd500dc749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

TDISP allows secure MMIO access to a validated MMIO range.
The validation is done in the TSM and after that point changing
the device's Memory Space enable (MSE) or Bus Master enable (BME)
transitions the device into the error state.

For PCI device drivers which enable MSE, then BME, and then
start using the device, enabling BME is a logical point to perform
the MMIO range validation in the TSM.

Define new event for a bus. TSM is going to listen to it in the TVM
and do the validation for TEE ranges.

This does not switch MMIO to private by default though as this is
for the driver to decide (at least, for now).

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/device/bus.h          |  3 ++
 drivers/pci/pci.c                   |  3 ++
 drivers/virt/coco/guest/tsm-guest.c | 35 ++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f5a56efd2bd6..12f46ca69239 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -278,8 +278,11 @@ enum bus_notifier_event {
 	BUS_NOTIFY_UNBIND_DRIVER,
 	BUS_NOTIFY_UNBOUND_DRIVER,
 	BUS_NOTIFY_DRIVER_NOT_BOUND,
+	BUS_NOTIFY_PCI_BUS_MASTER,
 };
 
+void bus_notify(struct device *dev, enum bus_notifier_event value);
+
 struct kset *bus_get_kset(const struct bus_type *bus);
 struct device *bus_get_dev_root(const struct bus_type *bus);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b462bab597f7..3aeaa583cd92 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4294,6 +4294,9 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	dev->is_busmaster = enable;
+
+	if (enable)
+		bus_notify(&dev->dev, BUS_NOTIFY_PCI_BUS_MASTER);
 }
 
 /**
diff --git a/drivers/virt/coco/guest/tsm-guest.c b/drivers/virt/coco/guest/tsm-guest.c
index d3be089308e0..d30e49c154e0 100644
--- a/drivers/virt/coco/guest/tsm-guest.c
+++ b/drivers/virt/coco/guest/tsm-guest.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/tsm.h>
+#include <linux/pci.h>
 
 #define DRIVER_VERSION	"0.1"
 #define DRIVER_AUTHOR	"aik@amd.com"
@@ -241,6 +242,36 @@ static const struct attribute_group tdi_group = {
 	.attrs = tdi_attrs,
 };
 
+/* In case BUS_NOTIFY_PCI_BUS_MASTER is no good, a driver can call pci_dev_tdi_validate() */
+int pci_dev_tdi_validate(struct pci_dev *pdev, bool invalidate)
+{
+	struct tsm_tdi *tdi = tsm_tdi_get(&pdev->dev);
+	int ret;
+
+	if (!tdi)
+		return -EFAULT;
+
+	ret = tsm_tdi_validate(tdi, TDI_VALIDATE_DMA | TDI_VALIDATE_MMIO, invalidate);
+
+	tsm_tdi_put(tdi);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_dev_tdi_validate);
+
+static int tsm_guest_pci_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
+{
+	switch (action) {
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		pci_dev_tdi_validate(to_pci_dev(data), true);
+		break;
+	case BUS_NOTIFY_PCI_BUS_MASTER:
+		pci_dev_tdi_validate(to_pci_dev(data), false);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 struct tsm_guest_subsys *tsm_guest_register(struct device *parent,
 					    struct tsm_vm_ops *vmops,
 					    void *private_data)
@@ -258,12 +289,16 @@ struct tsm_guest_subsys *tsm_guest_register(struct device *parent,
 	gsubsys->ops = vmops;
 	gsubsys->private_data = private_data;
 
+	gsubsys->notifier.notifier_call = tsm_guest_pci_bus_notifier;
+	bus_register_notifier(&pci_bus_type, &gsubsys->notifier);
+
 	return gsubsys;
 }
 EXPORT_SYMBOL_GPL(tsm_guest_register);
 
 void tsm_guest_unregister(struct tsm_guest_subsys *gsubsys)
 {
+	bus_unregister_notifier(&pci_bus_type, &gsubsys->notifier);
 	tsm_unregister(&gsubsys->base);
 }
 EXPORT_SYMBOL_GPL(tsm_guest_unregister);
-- 
2.47.1


