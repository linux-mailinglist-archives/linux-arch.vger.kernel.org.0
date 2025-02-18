Return-Path: <linux-arch+bounces-10190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE39A39A68
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1AD189421F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B62343BE;
	Tue, 18 Feb 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEokrjPF"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CB233136;
	Tue, 18 Feb 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877373; cv=fail; b=mWw+Bsp7ujC8vPFDX+iCXF5bjoJcU6y7Qiw+c42YIyQqICy4wLkRsa0ASr2+mHr2y9RjevmCFMQOhPH/y6XB5Qz0p1NRVrDmCcQ3GwF6NnqpEKF8hGjxOKiq5K8X96hq6/cXwUyFYV+TZPWulgdj9KFUF3oqt17QLK09x8Lsc4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877373; c=relaxed/simple;
	bh=pqDejP7YRgOmcPROmcHNsa9PKTlMK8FeF7gaSs3J/ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDvMAP0IOMc6wDr+ad2NCgKrKrSCrhN5v3KNpgG15ce6++W6i93gGa49rj0mF2r2a4ffH4O7qg5e2dAX6DIn9qvVCEabuusYihOB1ORKr2/R/vBvgJd+AvZLK0Vp+p/H0Fy+qkqAkLKMDuXjj4j79or2KuZac6jfJbxYOdezdV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEokrjPF; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFW8puZUpWp7ynYC9owLb6I2lYAwbGbFf5asey3lOKjEhG60J1R9zX8gSlXC/Tm91SVHbOMcbNCCUDyLBVqhm4sE2NhXxDjU65WbMmp7FiFQrrMa7UayKCU8HXoIJK9wDxkl/hbbveJLPENaq+EiOko+EN9unEcdEqN6UVURb7V9vHAadP7IBCUBClhumBPj0hyiA25svXOa7zcLC8gdfSSGgleqUFExBridL2LAs4a9TFmr3KoX9VfPdu/AQOHbY90mJj3CMLDqZx8w30OlE9TvG49t0NIJyLMMkTiMnJeoGJawnGQ4qCuBNOJktpVGJG4edRdwR3Y5kXl4NsCCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc0vfPNVAAshVkeSLWks1ktlCugLt4bEWwWROZWprIQ=;
 b=HUvVuIsZeX7qrmWBH4z8R/BSxHz2cmX6DKgnOs624R+tu8xe6oHGQn8A2xMMP55w2VGd5mf2D9u8zPpBsCFBczsT+OsCrYhkvvB9s7g8EzuLQ/dza/b6HjiNmaI1R2YqeEAlIcAmPfwWzZxYQV+LOTIqp26b2sc7Pu7Ehe4/CSrdNyEKCJTGPBO8NICKE3hMJcMyjs7L6MG3KIIR9BuidLloGUSX31rIYM32KlyonlOBPYsiUpWoeRdeCDEdArcTtW43zRZWCZByaudd9Yfj8c6eoQ3Ts5Q2B4iXeqxzVlP5B6XlNJgn/IZWC0ld0D8b71MzeQlxy8ULI5rM5/1HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc0vfPNVAAshVkeSLWks1ktlCugLt4bEWwWROZWprIQ=;
 b=JEokrjPFUOepooYRTyQsiq5Cb2w5g+BcG/9PG7kd+jEEKc9DUTtx7kXq9CQZKrYgEIJ5/8Gr6cHGr0bdylbHmr2vE2BIM0IxxcFptcBUgpPYZL6pLjS+nI2a4E8ij0FyQkvopK1SXbBQX+Qa44MmLPNKGTB0BwO426epwPQvyac=
Received: from CH2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:610:54::22)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 11:16:05 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::1) by CH2PR11CA0012.outlook.office365.com
 (2603:10b6:610:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:16:05 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:15:56 -0600
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
Subject: [RFC PATCH v2 16/22] coco/tsm: Add tsm-guest module
Date: Tue, 18 Feb 2025 22:10:03 +1100
Message-ID: <20250218111017.491719-17-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b65a5d5-d3a4-4a6d-0294-08dd500da2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ty+FtjfcMrCI7Hm7P8XkXadxqA1GJqT0xORnR+Z33b2EaMlztik2JlZKmqxd?=
 =?us-ascii?Q?4Yc9QfMiSqOVu14rTuCHCpIrLQRM+pnM2bpWmqN7XqGegpvW5tHSjfNNOSIv?=
 =?us-ascii?Q?R2JNhmXDBK33BLOvAG43aBECEE2bJkyiE7MjKJZqRxDOzjQ3RNXI1/a61EFl?=
 =?us-ascii?Q?6WS8YfyjNvZxQB299Z7C1gwaVFtMwP5z7tUkxdCUmGsudDATmiKKYF/32qrp?=
 =?us-ascii?Q?CipE0NyVeCNkti6VJ275aC09lYtD3ReglO4R3AAw6ZsEgwiM7TAH7NK48wP5?=
 =?us-ascii?Q?cGyiRhI5KJUeiS40MW0SXtPw0BHwwIhBkMSv4h+MSye+3ntPd1Gc2ZVcrsKM?=
 =?us-ascii?Q?Wkpe0jh0LvPRWzfeArnAl7YnoA83WR7dq4yO8QKIPJ8VDg959mrHG+5UPDx5?=
 =?us-ascii?Q?Cf0oxccqpfTMuGbYdTLrLCGI28HostyaRgtE7MRSR3zohann7rbmKBkbs0zb?=
 =?us-ascii?Q?LObGHhgv9/B828KLW4CAPD4cEWD95WVLIQ30DFOD8G5119CU+e2crK9iZHdt?=
 =?us-ascii?Q?Ekme2IAVIK8wf2gGjtM90ZgI+l60s8sikTzyyQvLfD9AoVbJseqKdmoFzMdB?=
 =?us-ascii?Q?fJ0Groic0yeaGxkVsAo0bIHkpIGm4uEAYBjpvMCcnma1V0/XuY8MrWOgWysM?=
 =?us-ascii?Q?Hp88XQFNnbffHOmal/KqP8/obmdtncaaZFILH0pGZrGkPZ8IXOc4fDndBVD9?=
 =?us-ascii?Q?Gtp7cDj+ncS71d+jFBvlk3eaLF2JrCfkk7AZCt6LZm8JR3hrA/+UmSwd/Ml+?=
 =?us-ascii?Q?l/7tIf5fGVomQhkWSXI+nijREupZ6KI4SdQQ1LhBwEC15S/3IhaFx68Jhg/t?=
 =?us-ascii?Q?gQzp/AoN/PbpDkMioH2R2E7N6VVjo67YHavcXCNHwvxXRUjUDcIu8fbBBVnW?=
 =?us-ascii?Q?gzN0/BNt4FhwhU7M2gWhxXe/MW1V+KV7wqPLmT6FSr9GQaEMRbjEShjghumZ?=
 =?us-ascii?Q?JCqqUfkpHgtrV/CTJ8lKLlRohgXarKWOVl1+M7O6aBXR7cunc1fra2FPjGa1?=
 =?us-ascii?Q?ARJEnUsYM6H9X2AJ/wDb5J48bDaABgZJcvZ5PbHyVGkfpfJl+AP5Qk6rpipk?=
 =?us-ascii?Q?g/EU5G/iQiG3y/1hd6NDwpgGpeXagy+3RpmGOgQIogN/dozkhwHI8xBg4vLI?=
 =?us-ascii?Q?6lDfcqsx40Zd4lPqwFooLSmj/PeXA2v6rKnQ5MK8ziQT7Jc2krRdtuMTMiry?=
 =?us-ascii?Q?85YItCLJDMULJIOewW3UqMRAMAuoQWNSReZIkaFhvR911RrHA2HIij4NnhUF?=
 =?us-ascii?Q?m4oR2KSIMWGllopD9vOCpX/Xt/mAj0v1t+bxo2sQDIicRxJFev7RlToTFqcN?=
 =?us-ascii?Q?mjlta+o8tWvzHxbBx4EFwaDslXGkrPCKDnqtorU8K5WqNEps338ZtjM3ctLj?=
 =?us-ascii?Q?C4b50RjWar+wQwGfA+Ubp/MeFBIp3XZBB6s8f1dZfrgUKPSjk9lL5Sh0q1K+?=
 =?us-ascii?Q?tU8IcqmyeP9zuOEqK7ouyhlUWpzUA/3mShHqdUp6f9aAmGoS1QGuQUCPMtPo?=
 =?us-ascii?Q?axn/aui5nTKdbn0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:16:05.0200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b65a5d5-d3a4-4a6d-0294-08dd500da2b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275

The "coco/tsm: Add tsm and tsm-host modules" added a common TSM library
and the host module which initialises contexts for secure devices on
the host.

Guests use some of the host sysfs interface and define their own, hence
a new module - TSM GUEST.

Note that the module is made bus-agnostic, like TSM-HOST.

New device nodes provide sysfs interface for fetching device certificates
and measurements and TDI interface reports.

A platform is expected to register itself in TSM-GUEST and provide
necessary callbacks. No platform is added here, AMD SEV is coming in the
next patches.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/virt/coco/guest/Makefile    |   3 +
 include/linux/device.h              |   4 +
 include/linux/tsm.h                 |  20 ++
 drivers/virt/coco/guest/tsm-guest.c | 291 ++++++++++++++++++++
 drivers/virt/coco/host/tsm-host.c   |   1 +
 drivers/virt/coco/tsm.c             |   2 +
 Documentation/virt/coco/tsm.rst     |  33 +++
 drivers/virt/coco/guest/Kconfig     |   3 +
 drivers/virt/coco/sev-guest/Kconfig |   1 +
 9 files changed, 358 insertions(+)

diff --git a/drivers/virt/coco/guest/Makefile b/drivers/virt/coco/guest/Makefile
index b3b217af77cf..60b688ab816a 100644
--- a/drivers/virt/coco/guest/Makefile
+++ b/drivers/virt/coco/guest/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TSM_REPORTS)	+= tsm_report.o
 tsm_report-y := report.o
+
+obj-$(CONFIG_TSM_GUEST) += tsm_guest.o
+tsm_guest-y := tsm-guest.o
diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..e813575b848b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -843,6 +843,10 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
 #endif
+#if defined(CONFIG_TSM_GUEST) || defined(CONFIG_TSM_GUEST_MODULE)
+	bool			tdi_enabled:1;
+	bool			tdi_validated:1;
+#endif
 };
 
 /**
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 486e386d90fc..9e25b1a99c19 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -353,6 +353,20 @@ struct tsm_hv_ops {
 	int (*tdi_status)(struct tsm_tdi *tdi, struct tsm_tdi_status *ts);
 };
 
+/* featuremask for tdi_validate */
+/* TODO: use it */
+#define TDI_VALIDATE_DMA	BIT(0)
+#define TDI_VALIDATE_MMIO	BIT(1)
+
+struct tsm_vm_ops {
+	int (*tdi_validate)(struct tsm_tdi *tdi, unsigned int featuremask,
+			    bool invalidate, void *private_data);
+	int (*tdi_mmio_config)(struct tsm_tdi *tdi, u64 start, u64 size,
+			       bool tee, void *private_data);
+	int (*tdi_status)(struct tsm_tdi *tdi, void *private_data,
+			  struct tsm_tdi_status *ts);
+};
+
 struct tsm_subsys {
 	struct device dev;
 	struct list_head tdi_head;
@@ -372,6 +386,12 @@ struct tsm_host_subsys;
 struct tsm_host_subsys *tsm_host_register(struct device *parent,
 					  struct tsm_hv_ops *hvops,
 					  void *private_data);
+struct tsm_guest_subsys;
+struct tsm_guest_subsys *tsm_guest_register(struct device *parent,
+					    struct tsm_vm_ops *vmops,
+					    void *private_data);
+void tsm_guest_unregister(struct tsm_guest_subsys *gsubsys);
+
 struct tsm_dev *tsm_dev_get(struct device *dev);
 void tsm_dev_put(struct tsm_dev *tdev);
 struct tsm_tdi *tsm_tdi_get(struct device *dev);
diff --git a/drivers/virt/coco/guest/tsm-guest.c b/drivers/virt/coco/guest/tsm-guest.c
new file mode 100644
index 000000000000..d3be089308e0
--- /dev/null
+++ b/drivers/virt/coco/guest/tsm-guest.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"aik@amd.com"
+#define DRIVER_DESC	"TSM guest library"
+
+struct tsm_guest_subsys {
+	struct tsm_subsys base;
+	struct tsm_vm_ops *ops;
+	void *private_data;
+	struct notifier_block notifier;
+};
+
+static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
+{
+	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+	struct tsm_tdi_status tstmp = { 0 };
+	struct tsm_tdi *tdi = tsm_tdi_get(tdev->physdev);
+
+	if (!tdi)
+		return -EFAULT;
+
+	return gsubsys->ops->tdi_status(tdi, gsubsys->private_data, &tstmp);
+}
+
+static int tsm_tdi_validate(struct tsm_tdi *tdi, unsigned int featuremask, bool invalidate)
+{
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+	int ret;
+
+	if (!tdi || !gsubsys->ops->tdi_validate)
+		return -EPERM;
+
+	ret = gsubsys->ops->tdi_validate(tdi, featuremask, invalidate, gsubsys->private_data);
+	if (ret) {
+		tdi->dev.parent->tdi_validated = false;
+		dev_err(tdi->dev.parent, "TDI is not validated, ret=%d\n", ret);
+	} else {
+		tdi->dev.parent->tdi_validated = true;
+		dev_info(tdi->dev.parent, "TDI validated\n");
+	}
+
+	return ret;
+}
+
+//int tsm_tdi_mmio_config(struct tsm_tdi *tdi, u64 start, u64 end, bool tee)
+//{
+//	struct tsm_dev *tdev = tdi->tdev;
+//	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+//	int ret;
+//
+//	if (!tdi || !gsubsys->ops->tdi_mmio_config)
+//		return -EPERM;
+//
+//	ret = gsubsys->ops->tdi_mmio_config(tdi, start, end, tee, gsubsys->private_data);
+//
+//	return ret;
+//}
+//EXPORT_SYMBOL_GPL(tsm_tdi_mmio_config);
+
+static int tsm_tdi_status(struct tsm_tdi *tdi, void *private_data, struct tsm_tdi_status *ts)
+{
+	struct tsm_tdi_status tstmp = { 0 };
+	struct tsm_dev *tdev = tdi->tdev;
+	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+	int ret;
+
+	ret = gsubsys->ops->tdi_status(tdi, private_data, &tstmp);
+	if (!ret)
+		*ts = tstmp;
+
+	return ret;
+}
+
+static ssize_t tsm_tdi_validate_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		ret = tsm_tdi_validate(tdi, TDI_VALIDATE_DMA | TDI_VALIDATE_MMIO, false);
+		if (ret)
+			return ret;
+	} else {
+		tsm_tdi_validate(tdi, TDI_VALIDATE_DMA | TDI_VALIDATE_MMIO, true);
+	}
+
+	tdi->validated = val;
+
+	return count;
+}
+
+static ssize_t tsm_tdi_validate_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
+
+	return sysfs_emit(buf, "%u\n", tdi->validated);
+}
+
+static DEVICE_ATTR_RW(tsm_tdi_validate);
+
+static char *spdm_algos_to_str(u64 algos, char *buf, size_t len)
+{
+	size_t n = 0;
+
+	buf[0] = 0;
+#define __ALGO(x) do {								\
+		if ((n < len) && (algos & (1ULL << (TSM_SPDM_ALGOS_##x))))	\
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
+	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+	struct tsm_tdi_status ts = { 0 };
+	char algos[256] = "";
+	unsigned int n, m;
+	int ret;
+
+	ret = tsm_tdi_status(tdi, gsubsys->private_data, &ts);
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
+	struct tsm_guest_subsys *gsubsys = (struct tsm_guest_subsys *) tdev->tsm;
+	struct tsm_tdi_status ts = { 0 };
+	u8 state;
+	int ret;
+
+	ret = tsm_tdi_status(tdi, gsubsys->private_data, &ts);
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
+static struct attribute *tdi_attrs[] = {
+	&dev_attr_tsm_tdi_validate.attr,
+	&dev_attr_tsm_tdi_status_user.attr,
+	&dev_attr_tsm_tdi_status.attr,
+	NULL,
+};
+
+static const struct attribute_group tdi_group = {
+	.attrs = tdi_attrs,
+};
+
+struct tsm_guest_subsys *tsm_guest_register(struct device *parent,
+					    struct tsm_vm_ops *vmops,
+					    void *private_data)
+{
+	struct tsm_subsys *subsys = tsm_register(parent, sizeof(struct tsm_guest_subsys),
+						 NULL, &tdi_group,
+						 tsm_tdi_measurements_locked);
+	struct tsm_guest_subsys *gsubsys;
+
+	gsubsys = (struct tsm_guest_subsys *) subsys;
+
+	if (IS_ERR(gsubsys))
+		return gsubsys;
+
+	gsubsys->ops = vmops;
+	gsubsys->private_data = private_data;
+
+	return gsubsys;
+}
+EXPORT_SYMBOL_GPL(tsm_guest_register);
+
+void tsm_guest_unregister(struct tsm_guest_subsys *gsubsys)
+{
+	tsm_unregister(&gsubsys->base);
+}
+EXPORT_SYMBOL_GPL(tsm_guest_unregister);
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
diff --git a/drivers/virt/coco/host/tsm-host.c b/drivers/virt/coco/host/tsm-host.c
index 5d23a3871009..7a37327fded8 100644
--- a/drivers/virt/coco/host/tsm-host.c
+++ b/drivers/virt/coco/host/tsm-host.c
@@ -474,6 +474,7 @@ void tsm_tdi_unbind(struct tsm_tdi *tdi)
 	}
 
 	tdi->guest_rid = 0;
+	tdi->dev.parent->tdi_enabled = false;
 }
 EXPORT_SYMBOL_GPL(tsm_tdi_unbind);
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index b6235d1210ca..a6979d51f029 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -442,6 +442,8 @@ int tsm_tdi_init(struct tsm_dev *tdev, struct device *parent)
 		goto free_exit;
 
 	tdi->tdev = tdev;
+	tdi->dev.parent->tdi_enabled = true;
+	tdi->dev.parent->tdi_validated = false;
 
 	return 0;
 
diff --git a/Documentation/virt/coco/tsm.rst b/Documentation/virt/coco/tsm.rst
index 7cb5f1862492..203cc9c8411d 100644
--- a/Documentation/virt/coco/tsm.rst
+++ b/Documentation/virt/coco/tsm.rst
@@ -90,6 +90,39 @@ The sysfs example from a host with a TDISP capable device:
 /sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm/tsm0
 
 
+The sysfs example from a guest with a TDISP capable device:
+
+~> find /sys -iname "*tsm*"
+/sys/kernel/config/tsm
+/sys/class/tsm-tdi
+/sys/class/tsm
+/sys/class/tsm/tsm0
+/sys/class/tsm-dev
+/sys/devices/platform/sev-guest/tsm
+/sys/devices/platform/sev-guest/tsm/tsm0
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm_dev
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi/tdi:0000:01:00.0/tsm_tdi_status
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi/tdi:0000:01:00.0/tsm_tdi_validate
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi/tdi:0000:01:00.0/tsm_tdi_status_user
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi/tdi:0000:01:00.0/tsm_report_user
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-tdi/tdi:0000:01:00.0/tsm_report
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev/tdev:0000:01:00.0/tsm_certs
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev/tdev:0000:01:00.0/tsm_nonce
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev/tdev:0000:01:00.0/tsm_meas_user
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev/tdev:0000:01:00.0/tsm_certs_user
+/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/tsm-dev/tdev:0000:01:00.0/tsm_meas
+/sys/module/tsm_pci
+/sys/module/sev_guest/parameters/tsm_vtom
+/sys/module/sev_guest/parameters/tsm_enable
+/sys/module/tsm_report
+/sys/module/tsm
+/sys/module/tsm/holders/tsm_pci
+/sys/module/tsm/holders/tsm_guest
+/sys/module/tsm_guest
+
+
 References
 ==========
 
diff --git a/drivers/virt/coco/guest/Kconfig b/drivers/virt/coco/guest/Kconfig
index ed9bafbdd854..30f0235f0113 100644
--- a/drivers/virt/coco/guest/Kconfig
+++ b/drivers/virt/coco/guest/Kconfig
@@ -5,3 +5,6 @@
 config TSM_REPORTS
 	select CONFIGFS_FS
 	tristate
+
+config TSM_GUEST
+	tristate
diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index a6405ab6c2c3..148af36772ff 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -3,6 +3,7 @@ config SEV_GUEST
 	default m
 	depends on AMD_MEM_ENCRYPT
 	select TSM_REPORTS
+	select TSM_GUEST
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
 	  the PSP without risk from a malicious hypervisor who wishes to read,
-- 
2.47.1


