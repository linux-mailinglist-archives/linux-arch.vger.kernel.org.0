Return-Path: <linux-arch+bounces-10185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E6A39A5A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A4E3B751F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33623C385;
	Tue, 18 Feb 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="faa1OBJs"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A223BF9E;
	Tue, 18 Feb 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877268; cv=fail; b=aeaRNzVQtvAoQS4Rnz1NckKLYtO6jnMyxx07/nsTPhhJ4fA1EwsEj64PBi6O2bNsarC7E6Qank9eg+UrdnpEDV9acJdD54P3SxT7FWRByZjH5zd1vEh2REPf9qF4i9X3LzAAFzVh3nfyrYxI/jRFbHPr1pxF6y+W0x2W3wvnMI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877268; c=relaxed/simple;
	bh=WCPL9rVr4j2Pb2uKP2Xa/RLtbkNnn3GWjdl/4E9pb00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXy2cb7gf3KSDP7b4bsspWldi1sJ8LI8eO4ZKjM3oIOP9e9rPvgYwFJqoj7ZFUC1H0e6ZFb8jdg3kuSs7D2O1DZHi2myRjdwasWgpK1mZRgmJYO9A7FmCLoDpvTds2MCf/x2xmnNJ2uzdeR6fHz0F+mTkHDHUgdBxwVB2ad0LKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=faa1OBJs; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWh6+hI5lYne5wdgh0KDcKhgmgvCK4D+ygfnKFhyhsrpLgRpwznON7cXzxWffKk/JaxWsej2kCBpMjkUn3FEyUpMase3YsPUuOKpukYlJWk7eC0zGfXJsebSzaNtC6m2Y656fV4z6Dvj5xlpFXbdToh6+3D6cot0yELQE445/mFWQp7gurSg0VdFUBwOyYlv8B3ImfgeSjyCMa6U/QZvqLOqsW5cPAD+8eOIjWsnR8wFBwZVGqfyfGafgNcWPeigAeYgwkdXmartVMASFtpzfEOR1xX7lvuvVpk3JKyCQ2kYDYpbZRdAHCaRNwrGJqbtM9F3t+2COVP/+U8ZOTH7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgaHBRP+oQfuGsFY+h4i5BGvzxvLvSYi1+FCYp43Xck=;
 b=Xj+l3E7vSNh+96iDm9SNoOZb1HPjh8RfJwWv+4kSZDS7hCWP4wRtgaA7FJiwIlDNda6spovpkTbKjMkz13yIGdkgEwcmCANdyS2I9uZTawh6Ak0pQKXa8iuR00r6fi1K/e8Pe6XtcHFkuEgmMcq4pLPqwkUt+Wu6V7n2g7W6BhSNqc1hfhkvj7XqEegMjygw2NMLwhifqoTdQYLWfhX3AvuTpz8N7k9Plo6zdJIvnFPhw2nvtfPvyJRD3VylRieKwaeM6bN00SEq18fh3qvJUQNJy48E07mepUqq1ehF4J8eUHUckiFv0fABr9uoOuJBHyuURaALy6xHe/X+ab+wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgaHBRP+oQfuGsFY+h4i5BGvzxvLvSYi1+FCYp43Xck=;
 b=faa1OBJsVctqfwG+siIYnpRI8/NHzxyah6BEKM5/LNHcw4Uka7TTVMQ/i7Wxf9hyVlLBPbWl/0JWwMxiB/kG1bEaApskmmcknmHWepPls7Zrriu5XLq1LJGKF/nRrwcL59Cnufw1nUImikKiy0bQkwdBtu7+/bw8kMuM4QIOH94=
Received: from MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) by
 PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 11:14:23 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::be) by MN2PR01CA0023.outlook.office365.com
 (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:14:22 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:14:14 -0600
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
Subject: [RFC PATCH v2 11/22] KVM: SEV: Add TIO VMGEXIT
Date: Tue, 18 Feb 2025 22:09:58 +1100
Message-ID: <20250218111017.491719-12-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c256334-0578-4c51-a172-08dd500d65bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/3ht+RFmZcYiZfoSPDltyFOeZiksGX2a97W5qqYQFRdLi2pXWID6HZu8loI?=
 =?us-ascii?Q?VIwZ5GbegQIB7zaTijVI+HVVHeyDUpFPKtmpVbKgRG6t7EKXlw3vVZx3GmCF?=
 =?us-ascii?Q?w8rdtVq0XEYTd889Qym7W0fZ5In8+QDR/IQ70N8c75xRygK2v1BrcITUBwxb?=
 =?us-ascii?Q?46JIMbqmQiu0X+11g0Jllf2J4Cw7RF/uO5yTr2E/i1bLI0p4sfhC0mS8cBFh?=
 =?us-ascii?Q?4hgvofSpAJ5gWreQelnDpxxUI3uv7xM5YxVr9LDe/KwDPrL3ZQjvzQTcn/ti?=
 =?us-ascii?Q?UDiVCQzo6TKOzbKVAbd1kp2DeX86I2lplbFJjLwyECyB6og6texu2hViC/lN?=
 =?us-ascii?Q?vitSqq4ULmUKyRiTTahre5cSjl4m2tyXJhcn9nWK9CCKR9HubUCZUcn56m2D?=
 =?us-ascii?Q?eIy9LP6cj1b0JwBZoPez37b9Yn2Dv6aMhbcaZ42sTFVGIeaiRM1To7/wWQBP?=
 =?us-ascii?Q?3Iz0DNUDpX2N6rxH/Vg/lGMRjC8DaNPxaxIH3OKKsuqiAs2Tjmlm1FT04V+V?=
 =?us-ascii?Q?Pe9VMkHuqHHWBskrwARiEZcoSK/zmG64is2SAezOigjB4pHlntFeDXlyjZcw?=
 =?us-ascii?Q?SB6mvJZg7OTeeyjzo4xw5JueCvsvSNv/n86j5zwgdyYMcejAeWifAtQUbnQ6?=
 =?us-ascii?Q?xFMHon6HbXdrFg9VggbjvIxBxxKw0MmdTUy0lj5aIV1F4taen6McNNOIOiI0?=
 =?us-ascii?Q?LzQmybOTEyLe30gWylGbxca0DCG5p/f2YrtkPtWJyjR51uE47lsfJwyghX4w?=
 =?us-ascii?Q?rL3oAOUalmQ4v+qOgFqyPvLmhwlGqkAHQNAJpGPW0W6GOEDg01UHD8ZU22Ui?=
 =?us-ascii?Q?H4M0wiTPMCVjopaukiBUK8++nlk3gjh209gIMehh0Hi/DdWz7hFxaDW2XGc+?=
 =?us-ascii?Q?mr0AYOnQxMD9sFi71Y987ZHH3mvTklgjFFq60LA+aAE8QCnfDdxjfm6M20Oq?=
 =?us-ascii?Q?WEkpEK3gA9eQ2yk8YgEb9wrFm3nwJBCFdUmvrDVTvCsXUycuQMgoihh2+iB/?=
 =?us-ascii?Q?lw4VV6R7y/gbWwxXTICI68c6KPvziP9G5sqTdK+6XeRN+OBbYOae+Q9x7d1A?=
 =?us-ascii?Q?a8SGPI8/6wn5IICFMFp1LDBF+gb9uEuPHs9gQQpNmcdijVsjJKK7k5F9EInw?=
 =?us-ascii?Q?Cmu39mqvzgR7n9bwAUTQyDSK5Q0uT/Oan295Z7cujehpVgdO8f0MkvWHlGpC?=
 =?us-ascii?Q?2ZcvMlbH/gZ8/kOW7ywWnxdxxPZ5Nb0aUmihuRaryQl0Q7xs9MsSlKocyDJ1?=
 =?us-ascii?Q?t/i11UrvGmzCSb9rvyLyXuqALWIwXEnCD2VzgjfXuGqH6XIGM54oF8HYL7YL?=
 =?us-ascii?Q?vISgjhV20t8Q343tIWzu5+ECDaiuqxtf4o/2dDwbfjR9QQFIO4NgPdsvTN4k?=
 =?us-ascii?Q?nm5IC4GFaLaMHlBxBFY2txEHlNJOdw8zUH0Gtf4YyXcZlTL1pxUZTRLDiG4w?=
 =?us-ascii?Q?ED4tpFJto/7CfmZe0JwmWcrmS/hdCM9x7ha23olSyDUjkEFc8GCzNWaY73q1?=
 =?us-ascii?Q?PSF5eiEWtyB45v8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:14:22.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c256334-0578-4c51-a172-08dd500d65bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

The SEV TIO spec defines a new TIO_GUEST_MESSAGE message to provide
a secure communication channel between a SNP VM and the PSP, very
similar to the GHCB GUEST MESSAGE. However the new call requires
additional information about the host and guest PCI BDFn and
the VM id (which is GCTX==guest context page). Since KVM does not
know PCI, it exits to QEMU which has all the pieces to make the call
to the PSP. This relies on necessary additional ioctl() are
implemented separately, such as:
- IOMMUFD "TDI bind" to bind a secure VF to a CoCo VM;
- IOMMUFD "Guest Request" to manage secure DMA and MMIO;
- SEV KVM ioctl() to call RMPUPDATE on MMIO ranges.

Define new VMGEXIT code - SEV_TIO_GUEST_REQUEST. Define its
parameters in kvm_run::kvm_user_vmgexit. These include:
- guest BDFn,
- GHCB request/response buffers (encrypted guest pages),
- space for certificate/measurements/interface repors
(non encrypted guest pages).

Some numeric values are out of order because numbers in between
have been used at different stages of KVM SEV-SNP upstreaming process.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  2 +
 include/uapi/linux/kvm.h        | 24 +++++++
 arch/x86/kvm/svm/sev.c          | 70 ++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 1814b413fd57..ac90a69e6327 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -116,6 +116,7 @@
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
+#define SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST	0x80000020
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
@@ -237,6 +238,7 @@
 	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
+	{ SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST, "vmgexit_sev_tio_guest_request" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 45e6d8fca9b9..cb3bc5b9c1e0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -135,6 +135,28 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_user_vmgexit {
+#define KVM_USER_VMGEXIT_TIO_REQ	4
+	__u32 type; /* KVM_USER_VMGEXIT_* type */
+	union {
+		struct {
+			__u32 guest_rid;	/* in */
+			__u16 ret;		/* out */
+#define KVM_USER_VMGEXIT_TIO_REQ_FLAG_STATUS		BIT(0)
+#define KVM_USER_VMGEXIT_TIO_REQ_FLAG_MMIO_VALIDATE	BIT(1)
+#define KVM_USER_VMGEXIT_TIO_REQ_FLAG_MMIO_CONFIG	BIT(2)
+			__u8  flags;		/* in */
+			__u8  tdi_status;	/* out */
+			__u64 data_gpa;		/* in */
+			__u64 data_npages;	/* in/out */
+			__u64 req_spa;		/* in */
+			__u64 rsp_spa;		/* in */
+			__u64 mmio_gpa;		/* in */
+			__s32 fw_err;		/* out */
+		} tio_req;
+	};
+} __packed;
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -178,6 +200,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_VMGEXIT          40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -446,6 +469,7 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		struct kvm_user_vmgexit vmgexit;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4916b916c20a..ea1cf33191b5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3390,6 +3390,8 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		    control->exit_info_1 == control->exit_info_2)
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST:
+		break;
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
 		goto vmgexit_err;
@@ -4250,6 +4252,71 @@ static int snp_mmio_rmp_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_complete_sev_tio_guest_request(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+	gpa_t req_gpa = control->exit_info_1;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sev_info *sev;
+	u8 msg_type = 0;
+
+	if (!sev_snp_guest(kvm))
+		return -EINVAL;
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
+			   &msg_type, 1))
+		return -EIO;
+
+	if (msg_type == TIO_MSG_TDI_INFO_REQ)
+		vcpu->arch.regs[VCPU_REGS_RDX] = vcpu->run->vmgexit.tio_req.tdi_status;
+
+	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb,
+				SNP_GUEST_ERR(0, vcpu->run->vmgexit.tio_req.fw_err));
+
+	return 1; /* Resume guest */
+}
+
+static int snp_sev_tio_guest_request(struct kvm_vcpu *vcpu, gpa_t req_gpa, gpa_t resp_gpa)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sev_info *sev;
+	u8 msg_type;
+
+	if (!sev_snp_guest(kvm))
+		return SEV_RET_INVALID_GUEST;
+
+	sev = &to_kvm_svm(kvm)->sev_info;
+
+	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
+			   &msg_type, 1))
+		return -EIO;
+
+	vcpu->run->exit_reason = KVM_EXIT_VMGEXIT;
+	vcpu->run->vmgexit.type = KVM_USER_VMGEXIT_TIO_REQ;
+	vcpu->run->vmgexit.tio_req.guest_rid = vcpu->arch.regs[VCPU_REGS_RCX];
+	vcpu->run->vmgexit.tio_req.flags = 0;
+	if (msg_type == TIO_MSG_TDI_INFO_REQ)
+		vcpu->run->vmgexit.tio_req.flags |= KVM_USER_VMGEXIT_TIO_REQ_FLAG_STATUS;
+	if (msg_type == TIO_MSG_MMIO_VALIDATE_REQ) {
+		vcpu->run->vmgexit.tio_req.flags |= KVM_USER_VMGEXIT_TIO_REQ_FLAG_MMIO_VALIDATE;
+		vcpu->run->vmgexit.tio_req.mmio_gpa = vcpu->arch.regs[VCPU_REGS_RDX];
+	}
+	if (msg_type == TIO_MSG_MMIO_CONFIG_REQ) {
+		vcpu->run->vmgexit.tio_req.flags |= KVM_USER_VMGEXIT_TIO_REQ_FLAG_MMIO_CONFIG;
+		vcpu->run->vmgexit.tio_req.mmio_gpa = vcpu->arch.regs[VCPU_REGS_RDX];
+	}
+	vcpu->run->vmgexit.tio_req.data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
+	vcpu->run->vmgexit.tio_req.data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
+	vcpu->run->vmgexit.tio_req.req_spa = req_gpa;
+	vcpu->run->vmgexit.tio_req.rsp_spa = resp_gpa;
+	vcpu->arch.complete_userspace_io = snp_complete_sev_tio_guest_request;
+
+	return 0; /* Exit KVM */
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4530,6 +4597,9 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		ret = snp_handle_ext_guest_req(svm, control->exit_info_1, control->exit_info_2);
 		break;
+	case SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST:
+		ret = snp_sev_tio_guest_request(vcpu, control->exit_info_1, control->exit_info_2);
+		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
-- 
2.47.1


