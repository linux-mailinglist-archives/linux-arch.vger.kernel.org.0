Return-Path: <linux-arch+bounces-10184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B209A39A4C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CC216E5EB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048B23FC4B;
	Tue, 18 Feb 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0duHuMW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A11A841C;
	Tue, 18 Feb 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877249; cv=fail; b=niejSK4B42Aeb0ecJcfmx2ohynnFNvA1LTQKDj6os3UQf/2S0Vef+II1i8HyekYfiWTG57X5oHdj5qiGlYyrUEliLyUZA0+Bof07qJE0FvHR3hELEUFT43aIeFmANSDQ9WyBZGV5F6IR3Okbez9OP9xVDUYOLflbhwBotbd3VXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877249; c=relaxed/simple;
	bh=l+6D+woqjvJCe6D2MbmC24jdWmRPsyPmVl3YopaSu/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIlkxgzQJ1xuOCD3SqiNxbb+osns63/h8IzVkD97a+pQVy82yJk90Lsh7zPr12NWujaWfpxVrmWqcFUlxx9wQDODECe1BCEHF1fcEkZAhvVzn4bvLAK9q7PdlB8f4PRxvoHernD1a/3yoo0Gi5jMOD4j6KTNZD+A1YYchEj7HsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x0duHuMW; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlQDavh63hq0Rm/lBueYMbP3cfeJJOLnI02wKx/mzlbYxhpGqcc+2qAW1oQxuSy7nMw3rUkzC9SKgDkdx6XGFQnIvuzOQnGKUug9SBiOE/0+Ci9daUZI5ceXSt8J45EAMY/mrvIXmuB49NAbVxiUexLLljg02adsFoTwChN0RYQaUMYy1NqW+0gUTOH/y+O7VMQY1aBxLcBKPC4ppXyVvnEwDZ22vvXk/vggkNlw2LXKLDEs5jQBctdlQqIxtDYSaGRmAMmFw40UheJ6r6c+v/DoVBe/pQsIbA/6wxLEPa7F3wVcb04xjjJ7YL5B7IqXMKUHfYWG1nHoXK3sk/Szqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw2qRPOMUgEtpoCevBdf/XxGs8dG9vF+BEMn0dV3mRU=;
 b=i4TV6R0xjiAS/8llbfovjeat8No9X8jVm7ATQeO3aHdutAQBicYM2aFqCD7fo16ENTcL4oO5YnRSWtIulVmMFW7hLGQHfjsSYoa0UC4E/plJIh7Hr2mjkXVD+IpCG+B7f2Ux7itD0j7IvJeNVbzIr+70Hr9Gw8SCmCfEMuNQ23ymCgCNc6/kWxe6IRXpgnJxYPDWwHtc45n/4A1O4qVEbCNn/BsoV8dn2jXM1iFxMI8nKfvA6NCPLXhWjRaGkAcPwtJQ+TXVNGM4m4kuHvCCA5MmjNgnJ08DQjvlGXt3HyJik+PID+XB/g8asOEZ7If9B8kEvcNzPllHqMqVIbDOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw2qRPOMUgEtpoCevBdf/XxGs8dG9vF+BEMn0dV3mRU=;
 b=x0duHuMWlcnH+F7US5wrjomTZRBpGxd3Wy6cT05uCSmi/z9YiJWti63MO9c7SvNtizH7Lx5Sdi4YXRJJ9aGFhBgNRqcLznVU1qKu7XOAGLNvBMDiKeqcDY4kGn5fZCFyUKPjpUWBKHyPTPwVy/S1aOPbymWWXMOAMtWQyp/vHds=
Received: from MN2PR01CA0014.prod.exchangelabs.com (2603:10b6:208:10c::27) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 11:14:04 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::49) by MN2PR01CA0014.outlook.office365.com
 (2603:10b6:208:10c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Tue,
 18 Feb 2025 11:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:14:04 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:13:54 -0600
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
Subject: [RFC PATCH v2 10/22] KVM: SVM: Add uAPI to change RMP for MMIO
Date: Tue, 18 Feb 2025 22:09:57 +1100
Message-ID: <20250218111017.491719-11-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 17448abf-16aa-45be-494e-08dd500d5a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?szas4ezMcVuG4jPr7Qm4QD5NqLCxwqgb406Z2JO09vvheQ8Z/pbKhCxTmnqJ?=
 =?us-ascii?Q?xwPB0PA4ryjhWeG4v7VxV9Dpz+eJdlnNRbfbT0Zk2nU8cTkkW9p8jRLLhqcw?=
 =?us-ascii?Q?HhPLds46TmwtnmryYDwUFq3M2MqPs4QAFgMXBPbKM00D1nvCcFQZID9blrHZ?=
 =?us-ascii?Q?+wta1AJLMpH8rx4H0oqBHSXKYyJc4MfaftA7aHgoDLc3vTYkA3+yrXwVb2QP?=
 =?us-ascii?Q?bN2z77J/jBYaifI3/Kqjpitrv0dsUndv7MziMcSnw/gsVGj+B+SqaPuRut/3?=
 =?us-ascii?Q?rl3URfNx2Ptp6pjq7snVyOCRbI5QDVk4W88XyuO7hfNy3tSuipf8VXrjxA0q?=
 =?us-ascii?Q?vu/Kl4A1ysiYAR/3obA/Xh5+MS167oLJOAdFLsteBIQ4vI6M/hsg4Do+MZsn?=
 =?us-ascii?Q?I9wXsn+7eo3K4yexTKYdnAEhu40LcNhzo/zmoxqAq5yxTB2qGG4sKSo4k8Ke?=
 =?us-ascii?Q?DKSQGKiMNBgRug/Lb/u6IR80J2cMuu6Zkmvporj762ZH059ALXyoR9LjsnXd?=
 =?us-ascii?Q?1LGkmmpbOFdDRQ3b43V7CaQGOf+xuERDtlVCWX01AEf/IiwBtmkRyybqUBBX?=
 =?us-ascii?Q?2teS8DSTv2m89yXeZdBBo5wecq+4gLa9U6OWnpJV73WVjCRanKeWVBoyESXH?=
 =?us-ascii?Q?T3RuU1dmNa7HqiLLaPEv37S3efM7hU6/RzOiRMOKvjaKePgHZNZKAioU7kpK?=
 =?us-ascii?Q?Dr9No/nknU+5S0eXopLVazJtteVli8C6EdckzGKfP2YnPuaHRJtHdOOT+eJ0?=
 =?us-ascii?Q?HYFsf3YCc0QBipxGEeEfNljDUpqSKf1K6vgvZ9emeWMYiIoSHZxaDz6CHicz?=
 =?us-ascii?Q?TGeJKoS7VJ2AUIrYlafMUFUU0QBVSm6/nlmZHAv2qe0VcjrjdUpaoB9k7RDH?=
 =?us-ascii?Q?mkiUREFj4ZHd3+3Rf710ecY/yIPJBGzTZry1NfpyPqoYTTQ7C3ty09dQNztW?=
 =?us-ascii?Q?Ji52kTrmDWPO3WBfh4EA4ZwRrEB5QcDE+xfDVquv2qTdke6J6sM4n6SnBn7m?=
 =?us-ascii?Q?wkIPnSx33rk0346SAzs83C03QNE5fYLQiTQcJfR2z8u5yDbC3vqLIOAK5MBD?=
 =?us-ascii?Q?otrSyHFVaXEHInscIYutfA+y33A+bk52WNLyFo7qPLQVV/BMMa6O7m7q5/23?=
 =?us-ascii?Q?GR8rYP+tAvegCkf4Tjjj91DfGe6pF7DvZPPGBB8bayeP2PF0gdRION/vibEC?=
 =?us-ascii?Q?iOn7B32tgLHsZg5xV98X8tdfNgB0edcteOlidp0Uoe35N+ROoMcKdny5Tyty?=
 =?us-ascii?Q?HPIUmiYfTB0HVqBPKL9dbDQVw4dbtNsHjVAkjhSAc8Ecn+gBkPNFIZX29Sjn?=
 =?us-ascii?Q?XrALqjO3QceY/p22lkTmhcY5DEa/XY1hYIFJuwccWMTuPZszlEEE0XyqCSI0?=
 =?us-ascii?Q?uvk6BdFisyHJSuEQ8iDu0E76448Dm1oYGZ6oeMtbkEZ3daVZZjPAP01VSxMX?=
 =?us-ascii?Q?SWcGhlWXJp1TwWsX+o6s8DPWIAElqQi5ZdQQ3J2lednB7Ch0Guh1jYSa/4xx?=
 =?us-ascii?Q?+zvGAPo31FiYWa8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:14:04.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17448abf-16aa-45be-494e-08dd500d5a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

The TDI bind operation moves the TDI into "RUN" state which means that
TEE resources are now to be used as encrypted, or the device will
refuse to operate. This requires RMP setup for MMIO BARs which is done
in 2 steps:
- RMPUPDATE on the host to assign host's MMIO ranges to GPA (like RAM);
- validate the RMP entry which is done via TIO GUEST REQUEST GHCB message
(unlike RAM for which the VM could just call PVALIDATE) but TDI bind must
complete first to ensure the TDI is in the LOCKED state so the location
of MMIO is fixed.

The bind happens on the first TIO GUEST REQUEST from the guest.
At this point KVM does not have host TDI BDFn so it exits to QEMU which
calls VFIO-IOMMUFD to bind the TDI.

Now, RMPUPDATE need to be done, in some place on the way back to the guest.
Possible places are:
a) the VFIO-IOMMUFD bind handler (does not know GPAs);
b) QEMU (can mmapp MMIO and knows GPA);
c) the KVM handler which received the first TIO GUEST REQUEST (does not
know host MMIO ranges or host BDFn).

The b) approach is taken. Add an KVM ioctl() to update RMP table for
a given MMIO range. Lots of cut-n-paste.

The validation happens later on explicit guest requests.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/include/asm/sev.h      |   2 +
 arch/x86/include/uapi/asm/kvm.h |  11 ++
 arch/x86/kvm/svm/sev.c          | 135 ++++++++++++++++++++
 arch/x86/virt/svm/sev.c         |  34 ++++-
 4 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c5e9455df0dc..2cae72b618d0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -573,7 +573,9 @@ int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level);
 void snp_dump_hva_rmpentry(unsigned long address);
 int psmash(u64 pfn);
 int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable);
+int rmp_make_private_mmio(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable);
 int rmp_make_shared(u64 pfn, enum pg_level level);
+int rmp_make_shared_mmio(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9e75da97bce0..1681bd8c5d33 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -704,6 +704,7 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_LAUNCH_START = 100,
 	KVM_SEV_SNP_LAUNCH_UPDATE,
 	KVM_SEV_SNP_LAUNCH_FINISH,
+	KVM_SEV_SNP_MMIO_RMP_UPDATE,
 
 	KVM_SEV_NR_MAX,
 };
@@ -874,6 +875,16 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
 
+#define KVM_SEV_SNP_RMP_FLAG_PRIVATE		BIT(0)
+
+struct kvm_sev_snp_rmp_update {
+	__u32 flags; /* KVM_SEV_SNP_RMP_FLAG_xxxx */
+	__u32 pad0;
+	__u64 useraddr;
+	__u64 gpa;
+	__u64 size;
+};
+
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23705ea03381..4916b916c20a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2541,6 +2541,8 @@ static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_mmio_rmp_update(struct kvm *kvm, struct kvm_sev_cmd *argp);
+
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -2646,6 +2648,9 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_FINISH:
 		r = snp_launch_finish(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_MMIO_RMP_UPDATE:
+		r = snp_mmio_rmp_update(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -4115,6 +4120,136 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return 1; /* resume guest */
 }
 
+static int hva_to_pfn_remapped(struct vm_area_struct *vma,
+			       unsigned long addr, bool write_fault,
+			       bool *writable, kvm_pfn_t *p_pfn)
+{
+	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
+	kvm_pfn_t pfn;
+	int r;
+
+	r = follow_pfnmap_start(&args);
+	if (r) {
+		/*
+		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
+		 * not call the fault handler, so do it here.
+		 */
+		bool unlocked = false;
+
+		r = fixup_user_fault(current->mm, addr,
+				     (write_fault ? FAULT_FLAG_WRITE : 0),
+				     &unlocked);
+		if (unlocked)
+			return -EAGAIN;
+		if (r)
+			return r;
+
+		r = follow_pfnmap_start(&args);
+		if (r)
+			return r;
+	}
+
+	if (write_fault && !args.writable) {
+		pfn = KVM_PFN_ERR_RO_FAULT;
+		goto out;
+	}
+
+	if (writable)
+		*writable = args.writable;
+	pfn = args.pfn;
+out:
+	follow_pfnmap_end(&args);
+	*p_pfn = pfn;
+
+	return r;
+}
+
+static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
+{
+	if (unlikely(!(vma->vm_flags & VM_READ)))
+		return false;
+
+	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
+		return false;
+
+	return true;
+}
+
+static inline int check_user_page_hwpoison(unsigned long addr)
+{
+	int rc, flags = FOLL_HWPOISON | FOLL_WRITE;
+
+	rc = get_user_pages(addr, 1, flags, NULL);
+	return rc == -EHWPOISON;
+}
+
+static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
+		     bool *async, bool write_fault, bool *writable)
+{
+	struct vm_area_struct *vma;
+	kvm_pfn_t pfn;
+	int r;
+
+	mmap_read_lock(current->mm);
+retry:
+	vma = vma_lookup(current->mm, addr);
+
+	if (vma == NULL)
+		pfn = KVM_PFN_ERR_FAULT;
+	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+		// Here we only expect MMIO for validation
+		r = hva_to_pfn_remapped(vma, addr, write_fault, writable, &pfn);
+		if (r == -EAGAIN)
+			goto retry;
+		if (r < 0)
+			pfn = KVM_PFN_ERR_FAULT;
+	} else {
+		if (async && vma_is_valid(vma, write_fault))
+			*async = true;
+		pfn = KVM_PFN_ERR_FAULT;
+	}
+
+	mmap_read_unlock(current->mm);
+	return pfn;
+}
+
+
+static int snp_mmio_rmp_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_sev_snp_rmp_update params;
+	bool async = false, writable = false;
+	int ret;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
+		return -EFAULT;
+
+	for (phys_addr_t off = 0; off < params.size; off += PAGE_SIZE) {
+		kvm_pfn_t pfn = hva_to_pfn(params.useraddr + off, false,
+					   false /*interruptible*/,
+					   &async, false, &writable);
+
+		if (is_error_pfn(pfn))
+			return -EINVAL;
+
+		if (params.flags & KVM_SEV_SNP_RMP_FLAG_PRIVATE)
+			ret = rmp_make_private_mmio(pfn, params.gpa + off, PG_LEVEL_4K,
+						    sev->asid, false/*Immutable*/);
+		else
+			ret = rmp_make_shared_mmio(pfn, PG_LEVEL_4K);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 1dcc027ec77e..6e6bd3c2f7ec 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -978,7 +978,7 @@ static int adjust_direct_map(u64 pfn, int rmp_level)
  * The optimal solution would be range locking to avoid locking disjoint
  * regions unnecessarily but there's no support for that yet.
  */
-static int rmpupdate(u64 pfn, struct rmp_state *state)
+static int rmpupdate(u64 pfn, struct rmp_state *state, bool mmio)
 {
 	unsigned long paddr = pfn << PAGE_SHIFT;
 	int ret, level;
@@ -988,7 +988,7 @@ static int rmpupdate(u64 pfn, struct rmp_state *state)
 
 	level = RMP_TO_PG_LEVEL(state->pagesize);
 
-	if (adjust_direct_map(pfn, level))
+	if (!mmio && adjust_direct_map(pfn, level))
 		return -EFAULT;
 
 	do {
@@ -1022,10 +1022,25 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
 	state.gpa = gpa;
 	state.pagesize = PG_LEVEL_TO_RMP(level);
 
-	return rmpupdate(pfn, &state);
+	return rmpupdate(pfn, &state, false);
 }
 EXPORT_SYMBOL_GPL(rmp_make_private);
 
+int rmp_make_private_mmio(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable)
+{
+	struct rmp_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.assigned = 1;
+	state.asid = asid;
+	state.immutable = immutable;
+	state.gpa = gpa;
+	state.pagesize = PG_LEVEL_TO_RMP(level);
+
+	return rmpupdate(pfn, &state, true);
+}
+EXPORT_SYMBOL_GPL(rmp_make_private_mmio);
+
 /* Transition a page to hypervisor-owned/shared state in the RMP table. */
 int rmp_make_shared(u64 pfn, enum pg_level level)
 {
@@ -1034,10 +1049,21 @@ int rmp_make_shared(u64 pfn, enum pg_level level)
 	memset(&state, 0, sizeof(state));
 	state.pagesize = PG_LEVEL_TO_RMP(level);
 
-	return rmpupdate(pfn, &state);
+	return rmpupdate(pfn, &state, false);
 }
 EXPORT_SYMBOL_GPL(rmp_make_shared);
 
+int rmp_make_shared_mmio(u64 pfn, enum pg_level level)
+{
+	struct rmp_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.pagesize = PG_LEVEL_TO_RMP(level);
+
+	return rmpupdate(pfn, &state, true);
+}
+EXPORT_SYMBOL_GPL(rmp_make_shared_mmio);
+
 void snp_leak_pages(u64 pfn, unsigned int npages)
 {
 	struct page *page = pfn_to_page(pfn);
-- 
2.47.1


