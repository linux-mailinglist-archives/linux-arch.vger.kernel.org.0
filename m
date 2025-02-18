Return-Path: <linux-arch+bounces-10180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F298BA39A2D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F4E3A23D6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EB23BF96;
	Tue, 18 Feb 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i7qRT6tM"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDC22DF92;
	Tue, 18 Feb 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877166; cv=fail; b=lwvNzkW2Pzjke801AEexyrPJRzRiKwrmGcXJM0FUPAl58hFTVN6rktQbRZjIHPffTyP4ixSkhBCUR0kxh9yrbH7wwXu0ArVeWES33nIrg7BS4FqFDebYlHrYGpcmnf5MkaXDPuKwth312tLfB6LQmGIxwfDBHycrsJx5z7fRYko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877166; c=relaxed/simple;
	bh=4Z+8ELD6wiz0D/oK//LbCtsaTUxSGnLejL8fjNsaxFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiprf3JCAK71Z+fwvfC+aWBEMI3tK9bBgySkM0+0LUC0mKCipLdSmeEBjtDb9R+ztR+zrdJ8T1JIZr0OwiXcXSY3BiGUmasWwaWeSEUgY0IJM3RHKmln3WsmdGiWWbBXozq31Y44tVpfr+jLahfJHhjdOsv0vGRoRprbmzaQZeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7qRT6tM; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF0Gs1Atv/Ly+mkZ3oktpNsgJv7GHnft+eieHv3rAUEhspbWO//Gm+bkQyRz7+LpJYpAvF9qDjM8HG1KyQoNedTxEwU7xuMS15tEEEZAH8d0ONAmcLD6uOn/04/20wyCxE/QGDtIG6JOTEhG2OsdEpZrN5X/i0Ah/AisBKX3fhgr7v6FDY9UNHJ9wChSzkQRPN+MMhkyd/DecPfWtKbeQahNQzGoeqibDyRYxpGHpbEMtlu6y1jpOsQlYGb64Z8W47Jvr07cCzgJB7jzfIUNk9cm8Qd97zmubaKqo9NEqdJ1BT6ejtSFGZxdq0urAY9IWJp3ixfO19I7ilSVMpeCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW/MbpWCcrsaKGzhsuId4FGH79DLa5vojUs/d1dho5U=;
 b=ZBu4sxCp4VbdYaZ0npc7U0I9MmBlCsrnqrIYnoT1+HJaHrBswgVyUQmoNsy22Qp8Ps8aC2nMhX+Uv7AHPFwf+JjwKZbDWNYzXmd1VMiC4hgA/zJMQx6QyO2hTH1tvad5Lg1OcYRaYEr8YDhHFhQD57t8lNTcRhpvZj4dGTjQBWZHFITKgMnJocgfKv24+hCJw6rc8wDPSZr0+DjDgmFzypgJoOS9HJ7JLXpCe7K6Yu711Nba/72k5bkbzDRjG/pCpPGFH2kbMorufyf56XI1QveyLI1aKyl8Xr4ZD0PbsNMfGFLcN3gQ3waPvWNRVnz5PbHcI92iJGIVPVeHDirLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW/MbpWCcrsaKGzhsuId4FGH79DLa5vojUs/d1dho5U=;
 b=i7qRT6tMrBz/4GAK5p57DCeiNET3u6YxyE49uFZ+qmCEIGYQoP06xnse0jroWsk1OGpgJVv9pBrR0szj2eVUcXrEknkwwQAUD4kkIa5yoOsSuFGgEeVK1QZTvJMrTEZXwt4DKzw+9GVb0oWbiq3swhux/mzNXaXJQ6HQOhiI6GA=
Received: from BLAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:36e::22)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:12:39 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::c7) by BLAPR05CA0016.outlook.office365.com
 (2603:10b6:208:36e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Tue,
 18 Feb 2025 11:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:12:39 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:12:31 -0600
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
Subject: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
Date: Tue, 18 Feb 2025 22:09:53 +1100
Message-ID: <20250218111017.491719-7-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa46d34-7c9f-4aee-7a86-08dd500d284d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uaOE8fgYJAImVX/DzgkqWYAQwLH8rINrhRsPtyhoil159YdK5nstEzhi+qq/?=
 =?us-ascii?Q?IDU6zO2BqQDYdiunag4Xwy5ih35i2J7Ac4l6esOC2jZVKlEcVJKPUUSQNFWy?=
 =?us-ascii?Q?C9bpaQ70HyuPPEfqjczlduKS2PCblLdGN3oLFP2UocFyfvjLziY5HsVwAZvC?=
 =?us-ascii?Q?K6Jwc46z8r5Nyq3iq4K7erg7SzRGD/yQt5qXrJmau6sudhVtLg8QALPqJ9i9?=
 =?us-ascii?Q?/XQ+lHuRoeHorJ6AJnuHZoCf6lG378DBKN4uyCrtfd201kmn3bqdf8K+q6Dz?=
 =?us-ascii?Q?DeWnfTxChEFdVdIy3CklJQEnsFcinMqm4oqOxBBgNG8NwkltX9dUsUwK3bQ+?=
 =?us-ascii?Q?DGqhn7zckz1IWn+h7P5bmrgVzcjnAgtIygLzVxxeEDol+UD/6aXOax2ra87y?=
 =?us-ascii?Q?SfEr9GICpGBW9fhyhEpdzRlhcfJrpVbDSJfSx0eEC/F78w4zMOkLKMvGBayU?=
 =?us-ascii?Q?pNrrP3YmIGyXi3e/DZASlUb5qNbj81HU39Ad2uJpNOeKUYAB+dGJq3SSEvnO?=
 =?us-ascii?Q?rArNZuz/S3rJwBc6tijO1of/XKywGInoq++bZkfHhTWwjGViCRQZbvG1gciN?=
 =?us-ascii?Q?Zf+GYtr2puVpNSSHvZKfloVfr+xZjNj0ppRvNqWnFG6NLnthKCt38D69eF3c?=
 =?us-ascii?Q?fZ8DqhW06W0sOIQimiWrpr98T1+fzwE8VwQhVHKL99mRUh1Sakd1x6S1nBvh?=
 =?us-ascii?Q?9/PL/jKSJGeAlRehNiifdih2YkEJu8jwWUzeUAlbM/OoqVAnV6t1FkQLWsqR?=
 =?us-ascii?Q?G7kzQhCxegeM1vuHBtz4dCsMcKa8Q5qgUwZ+SNsGPj/paxVevdXLfjjX2UEI?=
 =?us-ascii?Q?bwpyJvPAqIUH0RxxXIgmjhp64PJy/k5768etL3F9YRjge9RQEN+FDS5RQjvB?=
 =?us-ascii?Q?FDdWwgCBXtXo0o3m3EQzp262ccPM44Bz1+djJEDUgq5mSanZGO1c3VAEQUL4?=
 =?us-ascii?Q?7IJdSz61g0YP+kdiP7tqyPA0zZ+G29mMzr2NZckbmf6AC9e6F3NIXA1jTc7J?=
 =?us-ascii?Q?3a1L4nbOTZf03NtK8uRZTCtBSU5zIXQFUhA5OqPjplscdbU0BJ24ngewVHWY?=
 =?us-ascii?Q?zuQY11JyRbgQrsAVs8B//oPWuKuhz7gupIBACjBYnVvO798tmS51f0mrOIen?=
 =?us-ascii?Q?1FWOFfBCaEwh0O3yad8RmBcByF62XtyfF5maKiTjBOZDtzUy9P9MVdt0e4VH?=
 =?us-ascii?Q?2vCZmmG2K1UyzQJ+3BLxM8te5wNrOkLOSeKBX3HHank6cRxpvhXd9Lw8tDa3?=
 =?us-ascii?Q?dfVcUoxlTzURKbcM7tpPjOBS8pNV6f1ASnkIdVcVDA0XsoW+MDxVnAJNIqMc?=
 =?us-ascii?Q?siVfYEirxjFUAizQdmNuIAqTfvoWX4agSJc2wFMxDNIU/m493s9B69KWlojf?=
 =?us-ascii?Q?etlRIK0POS2uXe1y3QKmeec5nDlZ38ojWi8bo8wOhqsiLcEPfU6kbUPD8L2w?=
 =?us-ascii?Q?G0Gyl/VIAaN5ty2R8SO80PBVOKed0DVBQEJqcOn5Im83Nfz6C+9ysU5ufFmo?=
 =?us-ascii?Q?0hk1HtebquyilxY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:12:39.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa46d34-7c9f-4aee-7a86-08dd500d284d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

In order to add a PCI VF into a secure VM, the TSM module needs to
perform a "TDI bind" operation. The secure module ("PSP" for AMD)
reuqires a VM id to associate with a VM and KVM has it. Since
KVM cannot directly bind a TDI (as it does not have all necesessary
data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
but they do not have a VM id recognisable by the PSP.

Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
of GCTX (a private page describing secure VM context) and ASID
(required on unbind for IOMMU unfencing, when needed).

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 ++
 include/linux/kvm_host.h           |  2 ++
 arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
 virt/kvm/kvm_main.c                |  6 ++++++
 5 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index c35550581da0..63102a224cd7 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
+KVM_X86_OP_OPTIONAL(tsm_get_vmid)
 
 #undef KVM_X86_OP
 #undef KVM_X86_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b15cde0a9b5c..9330e8d4d29d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 	int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
+
+	u64 (*tsm_get_vmid)(struct kvm *kvm);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f34f4cfaa513..6cd351edb956 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
 
+u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
+
 #endif
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7640a84e554a..0276d60c61d6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
 	return page_address(page);
 }
 
+static u64 svm_tsm_get_vmid(struct kvm *kvm)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+
+	if (!sev->es_active)
+		return 0;
+
+	return ((u64) sev->snp_context) | sev->asid;
+}
+
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
@@ -5137,6 +5147,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.gmem_prepare = sev_gmem_prepare,
 	.gmem_invalidate = sev_gmem_invalidate,
 	.private_max_mapping_level = sev_private_max_mapping_level,
+
+	.tsm_get_vmid = svm_tsm_get_vmid,
 };
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba0327e2d0d3..90c3ff7c5c02 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6464,3 +6464,9 @@ void kvm_exit(void)
 	kvm_irqfd_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
+
+u64 kvm_arch_tsm_get_vmid(struct kvm *kvm)
+{
+	return static_call(kvm_x86_tsm_get_vmid)(kvm);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_tsm_get_vmid);
-- 
2.47.1


