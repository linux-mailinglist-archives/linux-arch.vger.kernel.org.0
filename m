Return-Path: <linux-arch+bounces-10182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E619A39A48
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C553B6E71
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524EB23CF07;
	Tue, 18 Feb 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5R/ehpKj"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392D23C8AF;
	Tue, 18 Feb 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877208; cv=fail; b=YSTFT2XmKQqD4EmhbkITuzGuZ7EDkfFoYKhd3HB5PxWwYVj7BqN6HedeJxmbr5UVCm0lW6JtxX4koxFVvPA153BOBnhoSWyAyFQQxRvdf9Q8QWIJx5XlDZjdq/jGW+h8W1lRhR8yXDw5bhvYd9tWaeSuZUhFA2wwDNNYteARRjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877208; c=relaxed/simple;
	bh=Xxz/hUYdryDM9qJWSNdGJq2xWXL6xoB68QiNy13ofpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn8qu6nNFGonRwVFDJmHXesf4Ha0UezpI4RGGhsLYsYi4TG9fqqnbnyLQXij7N2U8YhofwNwaD7oWsPAGnGuH5yJblkXlQq9ft4JCmcCZf3hvzVZb2QmwVmbBmCCZ6MsymnTnxl/6oRNBmu0ucJJzG4ukfJ37RGqQFhP4S7Mv60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5R/ehpKj; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmRV66/cHJmlZTVNR2gMk2ReuSMfwhVdvaJJP1w/MWZ8GxpN843OE8+8Qv+M7lSovWdrhc7YfakTu3ZsrkGyOAuLlPWUXhkuALffpMWXuG4GJVLvsGHLJYERzyqA8Z+fkP+VbUBZQadmzHWLbTthO23Fs48kgICKH18rrA3G4JMQM9YrH+9tmK/xe9VWOFz9tqAUXL7KELBqghY7An8+noUMuKU3gorS9LJg6Oorz56tXdLU5OzWiaiaFgV3wqNDTFy7beZb1OzgMCTkgvN97lhBycUBkCQU6hoLIxPSRfapCF3x7jK4by92WazzpNZcTvci02iB1Wztpa8BYh1VMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1OW6d8q1ynsEWf1ZMkyACA6oxmLJn0zo1MzBD6oT6E=;
 b=QAiz6OXXuqo0gYb0ZpZ7evQqniclN/zrs67ML/x0hXKiAUadIxP5n0M3LKShMT4a9G8mQ78GMasgQo8efNYiXTHyLYuujfNXChTrzjsvgJsMrr5EHPQQXxgQdn+c/mAkdx870k5eamfZX55PZ2FVPzTVnCc8wyIpAMvt192+nsAZXbpjsZDgV88GUGu5FY+fyCUIs6op3c5EVFz5yexhtjQSNHJBCHnriGFxsB8YXElA/cS43zuIYguY32NsK49le9PAO4BToteROS4YiqyEnwythZ+pVdrqc4kaSlUp8o6+YKXqnpW3+TlWRUNPFC3kNk/9WvZyFrfeCAq9rUEjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1OW6d8q1ynsEWf1ZMkyACA6oxmLJn0zo1MzBD6oT6E=;
 b=5R/ehpKjnM7CUeG488JcCpXBj203zynNY6V+5xo7xYjXZImbEPBd+FSpAu1aU4EYttV6WhK43Go0wCdYnB6P/fvkXgNgpQXzxnDplEqmYfX4Rk3u60Ces1mMtCo7Xn2wW22NdLhoEmncIRv15RtAgeTHykgEiGC0w3L0nGfLN4A=
Received: from BN0PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:143::9)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 11:13:22 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::ff) by BN0PR10CA0030.outlook.office365.com
 (2603:10b6:408:143::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 11:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:13:22 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:13:12 -0600
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
Subject: [RFC PATCH v2 08/22] pci/tsm: Add PCI driver for TSM
Date: Tue, 18 Feb 2025 22:09:55 +1100
Message-ID: <20250218111017.491719-9-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6e89fc-3659-4e94-38ae-08dd500d41d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZ8dnE+aax0DZRyAcaYL+NntBRz8iSR9XRLmV5N7HpazgY1zS6Im3gx3VRLl?=
 =?us-ascii?Q?OKVn9xNSpxbAY0JY1A2d3SGlPNFD5YWmaM8b5zZ15ryUeQocKNzryHBtn4zo?=
 =?us-ascii?Q?8Yf/qFaZgkPHzn2ruhtcfmDla1XY5rDvcQLlXVde5LYty5hkzd84XFTnNAHO?=
 =?us-ascii?Q?m3AwJMazjl8EclRbP5H+4muPOUlUHqHmESgDD9yugWEkiLW9ZRk3gXyDRICm?=
 =?us-ascii?Q?KBrkZ+RQHKBvprQcRz8WVfUgA4dMMaUNJlMVHl6b1Bk/48Z3zK+hxkhFNy4o?=
 =?us-ascii?Q?7twZlN9JUBs3dx9zRmeFaNxWZlGk7Vyas96bWUXa7ZaDLTnIHNpSbRMFig6v?=
 =?us-ascii?Q?4DJgd1kr16Ub+XjmYnLDXMDnE+xfG0PZYrESoHdo0hw/PPT9hCpXlfZQkWPG?=
 =?us-ascii?Q?FF7tk3CMrYxwtKL9wRzL0Cqaj+7r9dXyFSZFUq0kpgpsMCzqmMVdwTvMmZ9/?=
 =?us-ascii?Q?IZx1O0Mzf7gH5ql6ICBQl1tbY1H99RR66I0dsuZXsquzQujpmQ7TjW9E4QOZ?=
 =?us-ascii?Q?sMT1IrLG8q73pDyc4jTI87nylNbZD6UIHQrbOJpCfBGT4I8Yg/MnvTbd91l4?=
 =?us-ascii?Q?C84DCHUKO1cypOeKEjDbOMMACYqpapAp02TsHHt1MSapWMxq5abi94CSVBZn?=
 =?us-ascii?Q?Pml8GA9/yMiH6U1UydQTze7T9CzUqjA4UaRLnmXlltUYghPfjym2Hwwv927U?=
 =?us-ascii?Q?l/1rkTQWbXKUVd/CXU/iWrFNQU7Xg6roa1p7zn8pr5LB/raKvGOpJr4rQ/vg?=
 =?us-ascii?Q?MMbwxjqXsTngOayidxXM3S6WwXeyq4/VgIyAnKfA7/75+QBj2RzI7MHVEN5k?=
 =?us-ascii?Q?/bFjsnJVGJxH8LrC8mdreOyeJSM/FawfefeeOhilGmi9/M1zldh0EB5alfeE?=
 =?us-ascii?Q?Va0UfDwSCFyWoEXHEemy3uHyK5UuRE0/LQQ7eGHzID77OoCgdAAHsBTC5zZc?=
 =?us-ascii?Q?LqOe2WahEJ0gONE7lXaIb88DskNWgC3k5oLwzfF0h44XuFosBhDLx6JLDYQO?=
 =?us-ascii?Q?MZDeeIYU4jjm2U6tIVE01mYl/16UX0FKfBr9/onXNphUbyT/hnbfKh7TC9sH?=
 =?us-ascii?Q?TZnhqyry1eC0wc7wxf8dcxZ+HlEVCPkrq7+1sA0NgEqDbDuT474ct24RYER3?=
 =?us-ascii?Q?j1UcEHnBFBlp0TO895UEHsOFpqpqeMpGLBNQzTaiRFtKtCy/qo4ExO2bDeNR?=
 =?us-ascii?Q?+CvKtHFRs3C1RimH/c9EAIsNvvZ13x5ZF5tJNM957oEm+WAtjFewAyUhbPlG?=
 =?us-ascii?Q?mOItw6+GtKd4YxLJO1ywcMG1vuJQFAcIu3b7lOn/gjrZNzK0ufHyoVXRJjjs?=
 =?us-ascii?Q?mMimG8c0v8v0ivnP/Ld8J49OZBdonYbUc0yogiil/FjYPxtyZQeEccxwS+6c?=
 =?us-ascii?Q?7ty9Ygom7BFb0C843Ri6WngHDfd5mqFIjrIHbc4GGzSRnNJbrB5+wjY30rQl?=
 =?us-ascii?Q?EF6/pAUtWz4uK7igMgnbV7caNwKFDtnRVLIGUKRq33665+O/CJCPzDHjn4gT?=
 =?us-ascii?Q?Jw+YXN9eX1xHRE0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:13:22.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6e89fc-3659-4e94-38ae-08dd500d41d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

The PCI TSM module scans the PCI bus to initialize a TSM context for
physical ("TDEV") and virtual ("TDI") functions. It also implements
bus operations which at the moment is just an SPDM bouncer which talks
to the PF's DOE mailboxes.

The purpose of this module is to keep drivers/virt/coco/(guest|host)
unaware of PCI as much as possible (which is not always the case).

This module does not add new sysfs interfaces.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/pci/Makefile          |   3 +
 include/uapi/linux/pci_regs.h |   1 +
 drivers/pci/tsm.c             | 233 ++++++++++++++++++++
 drivers/pci/Kconfig           |  15 ++
 4 files changed, 252 insertions(+)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8050b04cc350..59d774bf9c32 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_PCI_CMA)		+= cma.o cma.asn1.o
 $(obj)/cma.o:			$(obj)/cma.asn1.h
 $(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
 
+tsm_pci-y			:= tsm.o
+obj-$(CONFIG_PCI_TSM)		+= tsm_pci.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 15bd8e2b3cf5..9c4a1995da8c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -499,6 +499,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..1539db584887
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TEE Security Manager for the TEE Device Interface Security Protocol
+ * (TDISP, PCIe r6.1 sec 11)
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "TSM: " fmt
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/sysfs.h>
+#include <linux/xarray.h>
+#include <linux/module.h>
+#include <linux/pci-ide.h>
+#include <linux/tsm.h>
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"aik@amd.com"
+#define DRIVER_DESC	"TSM TDISP library"
+
+static bool is_physical_endpoint(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return true;
+}
+
+static bool is_endpoint(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return true;
+}
+
+struct tsm_pci_dev_data {
+	struct pci_doe_mb *doe_mb;
+	struct pci_doe_mb *doe_mb_sec;
+};
+
+#define tsm_dev_to_pcidata(tdev) ((struct tsm_pci_dev_data *)tsm_dev_to_bdata(tdev))
+
+static int tsm_pci_dev_spdm_forward(struct tsm_spdm *spdm, u8 type)
+{
+	struct tsm_dev *tdev = container_of(spdm, struct tsm_dev, spdm);
+	struct tsm_pci_dev_data *tdata = tsm_dev_to_pcidata(tdev);
+	struct pci_doe_mb *doe_mb;
+	int rc;
+
+	if (type == TSM_PROTO_SECURED_CMA_SPDM)
+		doe_mb = tdata->doe_mb_sec;
+	else if (type == TSM_PROTO_CMA_SPDM)
+		doe_mb = tdata->doe_mb;
+	else
+		return -EINVAL;
+
+	if (!doe_mb)
+		return -EFAULT;
+
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, type,
+		     spdm->req, spdm->req_len, spdm->rsp, spdm->rsp_len);
+	if (rc >= 0)
+		spdm->rsp_len = rc;
+
+	return rc;
+}
+
+static struct tsm_bus_ops tsm_pci_ops = {
+	.spdm_forward = tsm_pci_dev_spdm_forward,
+};
+
+static int tsm_pci_dev_init(struct tsm_bus_subsys *tsm_bus,
+			    struct pci_dev *pdev,
+			    struct tsm_dev **ptdev)
+{
+	struct tsm_pci_dev_data *tdata;
+	int ret = tsm_dev_init(tsm_bus, &pdev->dev, sizeof(*tdata), ptdev);
+
+	if (ret)
+		return ret;
+
+	tdata = tsm_dev_to_bdata(*ptdev);
+
+	tdata->doe_mb = pci_find_doe_mailbox(pdev,
+					     PCI_VENDOR_ID_PCI_SIG,
+					     PCI_DOE_PROTOCOL_CMA_SPDM);
+	tdata->doe_mb_sec = pci_find_doe_mailbox(pdev,
+						 PCI_VENDOR_ID_PCI_SIG,
+						 PCI_DOE_PROTOCOL_SECURED_CMA_SPDM);
+
+	if (tdata->doe_mb || tdata->doe_mb_sec)
+		pci_notice(pdev, "DOE SPDM=%s SecuredSPDM=%s\n",
+			   tdata->doe_mb ? "yes":"no", tdata->doe_mb_sec ? "yes":"no");
+
+	return ret;
+}
+
+static int tsm_pci_alloc_device(struct tsm_bus_subsys *tsm_bus,
+				struct pci_dev *pdev)
+{
+	int ret = 0;
+
+	/* Set up TDIs for HV (physical functions) and VM (all functions) */
+	if ((pdev->devcap & PCI_EXP_DEVCAP_TEE) &&
+	    (((pdev->is_physfn && (PCI_FUNC(pdev->devfn) == 0)) ||
+	      (!pdev->is_physfn && !pdev->is_virtfn)))) {
+
+		struct tsm_dev *tdev = NULL;
+
+		if (!is_physical_endpoint(pdev))
+			return 0;
+
+		ret = tsm_pci_dev_init(tsm_bus, pdev, &tdev);
+		if (ret)
+			return ret;
+
+		ret = tsm_tdi_init(tdev, &pdev->dev);
+		tsm_dev_put(tdev);
+		return ret;
+	}
+
+	/* Set up TDIs for HV (virtual functions), should do nothing in VMs */
+	if (pdev->is_virtfn) {
+		struct pci_dev *pf0 = pci_get_slot(pdev->physfn->bus,
+						   pdev->physfn->devfn & ~7);
+
+		if (pf0 && (pf0->devcap & PCI_EXP_DEVCAP_TEE)) {
+			struct tsm_dev *tdev = tsm_dev_get(&pf0->dev);
+
+			if (!is_endpoint(pdev))
+				return 0;
+
+			ret = tsm_tdi_init(tdev, &pdev->dev);
+			tsm_dev_put(tdev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void tsm_pci_dev_free(struct pci_dev *pdev)
+{
+	struct tsm_tdi *tdi = tsm_tdi_get(&pdev->dev);
+
+	if (tdi) {
+		tsm_tdi_put(tdi);
+		tsm_tdi_free(tdi);
+	}
+
+	struct tsm_dev *tdev = tsm_dev_get(&pdev->dev);
+
+	if (tdev) {
+		tsm_dev_put(tdev);
+		tsm_dev_free(tdev);
+	}
+
+	WARN_ON(!tdi && tdev);
+}
+
+static int tsm_pci_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct tsm_bus_subsys *tsm_bus = container_of(nb, struct tsm_bus_subsys, notifier);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		tsm_pci_alloc_device(tsm_bus, to_pci_dev(data));
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		tsm_pci_dev_free(to_pci_dev(data));
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+struct tsm_bus_subsys *pci_tsm_register(struct tsm_subsys *tsm)
+{
+	struct tsm_bus_subsys *tsm_bus = kzalloc(sizeof(*tsm_bus), GFP_KERNEL);
+	struct pci_dev *pdev = NULL;
+
+	pr_info("Scan TSM PCI\n");
+	tsm_bus->ops = &tsm_pci_ops;
+	tsm_bus->tsm = tsm;
+	tsm_bus->notifier.notifier_call = tsm_pci_bus_notifier;
+	for_each_pci_dev(pdev)
+		tsm_pci_alloc_device(tsm_bus, pdev);
+	bus_register_notifier(&pci_bus_type, &tsm_bus->notifier);
+	return tsm_bus;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_register);
+
+void pci_tsm_unregister(struct tsm_bus_subsys *subsys)
+{
+	struct pci_dev *pdev = NULL;
+
+	pr_info("Shut down TSM PCI\n");
+	bus_unregister_notifier(&pci_bus_type, &subsys->notifier);
+	for_each_pci_dev(pdev)
+		tsm_pci_dev_free(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unregister);
+
+static int __init tsm_pci_init(void)
+{
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+	return 0;
+}
+
+static void __exit tsm_pci_cleanup(void)
+{
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION " unload\n");
+}
+
+module_init(tsm_pci_init);
+module_exit(tsm_pci_cleanup);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9212c0decdc5..9285e7511860 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -137,6 +137,21 @@ config PCI_CMA
 config PCI_IDE
 	bool
 
+config PCI_TSM
+	tristate "TEE Security Manager for PCI Device Security"
+	select PCI_IDE
+	depends on TSM
+	default m
+	help
+	  The TEE (Trusted Execution Environment) Device Interface
+	  Security Protocol (TDISP) defines a "TSM" as a platform agent
+	  that manages device authentication, link encryption, link
+	  integrity protection, and assignment of PCI device functions
+	  (virtual or physical) to confidential computing VMs that can
+	  access (DMA) guest private memory.
+
+	  Enable a platform TSM driver to use this capability.
+
 config PCI_DOE
 	bool
 
-- 
2.47.1


