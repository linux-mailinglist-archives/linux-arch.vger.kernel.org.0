Return-Path: <linux-arch+bounces-10188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4402A39A59
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFD7A4FF9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8A23F297;
	Tue, 18 Feb 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQWaLSep"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27199235348;
	Tue, 18 Feb 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877332; cv=fail; b=LteujO/xhwwBC6aDuJqqoUHLQIQjbXwM6T5b1KqSSvJoKapaMUqKvGZ0kWCJ3isSrhcWFayxkdw9iMShMzbdZnP2cGstRvs6R/9gvU/50inG8BunTj9EeAErjY9DKI1bg/SUSAZq8ASHIRXRvz1wabFYOWcka6RwcwCyyqNTQ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877332; c=relaxed/simple;
	bh=yztE8/zFQC05Cz2ThE+puTN1PA7zeZ5aYdJSKQDU0vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlqNDkVs+vG3LibcBCWl41dGfhGnbAJ1WlUKKMSr3p1ilZ3nnQOFYTddUrao2z6JghR1KsRhdOiUswSNb65wZAlkwlScpOrlaOXdvlWTYdxnPN9w01owKn2LdVCV4GRfwxp2v8D5lhftpb1UyQySpvoebNVbOwQQfKqDzQW5eGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQWaLSep; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AniWGU9BCanyKFvnP1Q4a+/b4oS9LS7ql0mrTC3IWtxF1HMOnm6D8F9olNe53aUcAPG/Vua/EWd4sMj+K9XdZJRT4tw3OMYdS1fKVJBywFajhF/wih/HlZoXpyAnAsZHkdOR1x6gsMv92ukrCovpOaX8qKPHnmns1cbIKpH04iM2agk8WUGboeSi0BL4F1ATbVUma0a5ClLmYgFjjRg2qQ9ZXDak7UDDTC6kwYIC75hJYxM5tQ/jm02ane2dAOzJud38KPI5UDIa4UHIMBAJPo9mDjjY3JI4jOkKA0DsZ9k0YLBiK3xq2yHVyyKtyHdIsEfR5FN2URy1fkqNJVkrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7OXQ6Fj1LDrhpQ4xPBsdA+XVFL3ALtuzBlOVqsik6c=;
 b=DszuSi2TmOVHV4egl9GIsa5VhXQ+4kVZyGAuU7ISdTNZgHJKufX/7D3aTYGXRfKrUAjMfBk0oe174jSDC4Lkpvf6oSpvkrYRvuA82YGRYXgSEBToiq22WT6wnamtedxCDU6N5XqUJsi6zHTpUlQM/Fb2JfeBBrbTnwnJDKNfhzpDLzfOTaF3ObAZL9hPnEmhzcUT9QfEpGJl47EoIvD9hr1gcnY/byD3j/hMjlg+IBRxpHQsMDWH6jtPWHXPm/EacLAU7f/ncCBDoAfqtnoM5jc/OnzaNSZa3LlaaUN9tu1vFrhB4+4nMwP5UgUVh7weI9bXX+V6U35tFJGF+fVTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7OXQ6Fj1LDrhpQ4xPBsdA+XVFL3ALtuzBlOVqsik6c=;
 b=CQWaLSep4QpwGcK8tV9YBU2oAZ3rxjB9jQW7cenpXrIseoQrbR5zWGFGLmUiq+7tFt12erpUbJGzfIKL/oi05FdTRoPjwg3y80fnxUpqbbX1bCjr2c22T15h+6PWT9OKP1h6YpiLYeuDWxWQu0uLc3EVpu/tEp4603DRpjB1jfo=
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:15:24 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::37) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:15:23 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:15:15 -0600
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
Subject: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Date: Tue, 18 Feb 2025 22:10:01 +1100
Message-ID: <20250218111017.491719-15-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: d877f390-7475-4f9c-ca25-08dd500d8a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSaoQBq2zTxFU4J/HrDyQ+8sZHU1NI3BLqIPq7OYb5Kjs1KxdK498RJv/ZFC?=
 =?us-ascii?Q?VW/2h8Db5OwjOYtoKxpta+1xltJZrlTE5fv62lGKF9t9TWxra6t8qxxxPaAf?=
 =?us-ascii?Q?txvh4IWbUW6OykVPia35ZkwjkqR8qPJYGAkeNaz857Lk48OtMgEmMJzSemI9?=
 =?us-ascii?Q?xsYAQzCg1NIH9YurFLshKBFivyYYCLMwA89UmnrDjmU0sCnSiqQyusVaOLES?=
 =?us-ascii?Q?Ag3Rc1AYeuWLupCqi49CEREySXTsB6kPL9sRnP6ktvckmFOh34TnvmEfeCA9?=
 =?us-ascii?Q?qbnKmqW6HQ9F/5YQD+tqXFmSPY3ScXIXpawBW4Ekd28aFPYwAMnes7HtklBo?=
 =?us-ascii?Q?xew0ySElgYxAh9nHSQiax/GQMDkYlF7g+nXoxS1qMCAw1PDDoBVUkNwLvbwe?=
 =?us-ascii?Q?3d2+RcNgzBEGBf0zge22QygfiLQU8xbLVGN3R6X7ZL6eLcSmJUy7XATxi3lV?=
 =?us-ascii?Q?iartToBEigJ0HiEQNRC79Ga4uVX9y9NYm35oIlOs+JmxytnPIgPrK7HS8duj?=
 =?us-ascii?Q?+lrTp4D2OSNTdCGFPoLEffcwsLUxXv/wyGtV3sfuzx8vznhciVbxH4FM0bvW?=
 =?us-ascii?Q?LbgTSNozS2xIeLtVFBksybhxuKLM37DcR7kJr+AeOBuzkg3pXFtmN7vrSIwm?=
 =?us-ascii?Q?JvBde+kMaxJPiNg/GgjOv/RdHi3/a7XOBnhcykg2xMhlpuLY1Knuz9AZnlCl?=
 =?us-ascii?Q?J2guybfnCVYxUfGTXwRr8WtgNuV0Sp/NdEJPNODe7egOg9MAp2RpxA/bhoAS?=
 =?us-ascii?Q?KRGPgz0bYVlyLWrThaZM0R4iFl+/iqW52VJ3KwwtXeWu96zJBS/b5R+kHpgs?=
 =?us-ascii?Q?lUc3MeFWuB74TxrXQYywx5+/5T9gW7v+PNwbHDXPOEG+EQctTddK1YkqorQy?=
 =?us-ascii?Q?zh47P/yhDGnTVWKhOe6dwTAa86C3cDb+EfCNRvBhxUwLAXoYrxi9ZcY/S2wa?=
 =?us-ascii?Q?Ipeb42Y12eVgsM5qhU/wxe9fMkbmdF6+hqNbAiQzngFiN/9Kx8t4CeZMd/xz?=
 =?us-ascii?Q?Qq6hlcxv0wOAuX56LXSs02xhrpn4WDoI5hBV4DIf2qqD5pPXr7+tpa0FAbyJ?=
 =?us-ascii?Q?xrxCRKy2f2xVSpBr4IjQOzNkFT66hslBheClzUGK8ckvui3r1kkOfTYo/vc4?=
 =?us-ascii?Q?azCjNHshI1vO4z6IKmYYISV/7Q3ODBBHUxT1+tVYdtFV8hBqG2LSsACbsjdJ?=
 =?us-ascii?Q?kY/nS7OWyeojykQUgdDQxBkw2dlwrzLuYdM5NH4GR/405z86JdRoTJZ/AQtV?=
 =?us-ascii?Q?TOhYIwaSYY0dTVDncmUsH7Rlh8R676HCA0AzURswjY+TJR20+CLcw7M1sD/V?=
 =?us-ascii?Q?R5b+fvbj2rhXgMbooA7NlUlDFRg5LpC76s9D/3dVENaaOaLuqZ2ymF7mX3Xp?=
 =?us-ascii?Q?OG7PKR6IJovy9A7Ng/0qcz+LfzG/fh05sNRHYkEl+3kEdPVIyUtwQSkGcE9D?=
 =?us-ascii?Q?FiKgw46TvwXnUgMYfoAbAGCBDZtEORlqsHU8hPxv8Jxv1Hin1fIpN491ACNR?=
 =?us-ascii?Q?G6/A5kTvafpp9uc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:15:23.8997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d877f390-7475-4f9c-ca25-08dd500d8a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160

When a TDISP-capable device is passed through, it is configured as
a shared device to begin with. Later on when a VM probes the device,
detects its TDISP capability (reported via the PCIe ExtCap bit
called "TEE-IO"), performs the device attestation and transitions it
to a secure state when the device can run encrypted DMA and respond
to encrypted MMIO accesses.

Since KVM is out of the TCB, secure enablement is done in the secure
firmware. The API requires PCI host/guest BDFns, a KVM id hence such
calls are routed via IOMMUFD, primarily because allowing secure DMA
is the major performance bottleneck and it is a function of IOMMU.

Add TDI bind to do the initial binding of a passed through PCI
function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
call into the TSM which forwards the calls to the PSP.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

Both enabling secure DMA (== "SDTE Write") and secure MMIO (== "MMIO
validate") are TIO GUEST REQUEST messages. These are encrypted and
the HV (==IOMMUFD or KVM or VFIO) cannot see them unless the guest
shares some via kvm_run::kvm_user_vmgexit (and then QEMU passes those
via ioctls).

This RFC routes all TIO GUEST REQUESTs via IOMMUFD which arguably should
only do so only for "SDTE Write" and leave "MMIO validate" for VFIO.
---
 drivers/iommu/iommufd/iommufd_private.h |   3 +
 include/uapi/linux/iommufd.h            |  25 +++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          | 112 ++++++++++++++++++++
 4 files changed, 146 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0b1bafc7fd99..47a6fb5da253 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -546,6 +546,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd);
 
 struct iommufd_vdevice {
 	struct iommufd_object obj;
@@ -553,6 +555,7 @@ struct iommufd_vdevice {
 	struct iommufd_viommu *viommu;
 	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
+	bool tsm_bound;
 };
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b346fa11955c..0af15dcabd23 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,8 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VDEVICE_TSM_BIND = 0x93,
+	IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST = 0x94,
 };
 
 /**
@@ -1015,4 +1017,27 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+struct iommu_vdevice_tsm_bind {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 vdevice_id;
+	__s32 kvmfd;
+	__u32 pad;
+} __packed;
+#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
+
+struct iommu_vdevice_tsm_guest_request {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 vdevice_id;
+	__u8 *req;
+	__u8 *rsp;
+	__u32 rsp_len;
+	__u32 req_len;
+	__s32 fw_err;
+} __packed;
+#define IOMMU_VDEVICE_TSM_GUEST_REQUEST _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_GUEST_REQUEST)
+
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ccf616462a1c..c9152ef3dcab 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -310,6 +310,8 @@ union ucmd_buffer {
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_bind bind;
+	struct iommu_vdevice_tsm_guest_request gr;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -367,6 +369,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_BIND, iommufd_vdevice_tsm_bind_ioctl,
+		 struct iommu_vdevice_tsm_bind, pad),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_GUEST_REQUEST, iommufd_vdevice_tsm_guest_request_ioctl,
+		 struct iommu_vdevice_tsm_guest_request, fw_err),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..936d8a71a3ef 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
 #include "iommufd_private.h"
+#include "linux/tsm.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
@@ -88,6 +89,15 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->tsm_bound) {
+		struct tsm_tdi *tdi = tsm_tdi_get(vdev->dev);
+
+		if (tdi) {
+			tsm_tdi_unbind(tdi);
+			tsm_tdi_put(tdi);
+		}
+	}
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -155,3 +165,105 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	struct iommufd_vdevice *vdev;
+	struct iommufd_device *idev;
+	struct tsm_tdi *tdi;
+	int rc = 0;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_dev;
+	}
+
+	tdi = tsm_tdi_get(idev->dev);
+	if (!tdi) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	rc = tsm_tdi_bind(tdi, vdev->id, cmd->kvmfd);
+	if (rc)
+		goto out_put_tdi;
+
+	vdev->tsm_bound = true;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put_tdi:
+	tsm_tdi_put(tdi);
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+out_put_dev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
+
+int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_tsm_guest_request *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	struct iommufd_vdevice *vdev;
+	struct iommufd_device *idev;
+	struct tsm_tdi *tdi;
+	int rc = 0, fw_err = 0;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_dev;
+	}
+
+	tdi = tsm_tdi_get(idev->dev);
+	if (!tdi) {
+		rc = -ENODEV;
+		goto out_put_vdev;
+	}
+
+	rc = tsm_guest_request(tdi, cmd->req, cmd->req_len, cmd->rsp, cmd->rsp_len, &fw_err);
+	if (rc)
+		goto out_put_tdi;
+
+	cmd->fw_err = fw_err;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_tdi:
+	tsm_tdi_put(tdi);
+out_put_vdev:
+	iommufd_put_object(ucmd->ictx, &vdev->obj);
+out_put_dev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.47.1


