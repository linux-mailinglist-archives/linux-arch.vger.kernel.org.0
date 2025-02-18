Return-Path: <linux-arch+bounces-10189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB2A39A65
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D341895A8A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7AA2405EC;
	Tue, 18 Feb 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0ZcI/z+"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95223FC48;
	Tue, 18 Feb 2025 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877351; cv=fail; b=D/TilqY92iEWHGoKo74uw/+ghAzAMywGKtJ1Ho5bVCzMBt4fronB8vB1Rf93T8cJbtYlqbXsYFFtgFGIab4XB3ryFrzN9qPkqEO6mkGhbbvQTmxlgPGQN4Jj/Xli57u5PBzN7C3nydX+zX8EokeTMfj7cIb0ATLPDwu00OLaYAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877351; c=relaxed/simple;
	bh=cMPPYYLs/xnnHWBhMUCDZDzcuSfSSxsrL68JUgj2uT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKgAVjCfBehux8KaK2KVkvXazpCSc7AwWlpBPYTvrlnjP9DAXfedy1ksSYf0444y1qP2JSOy8Iad2zOuS2wgQ63eU9Cfe5WS7s1y7Am2iy/z5wtOFJkRuHZyXGYHhFvnYOt0+5/O0n9SGZF18yV4wLEBxZmzNKV+Tj8bzO4dq60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0ZcI/z+; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVcErwU0vum8Ay3TUGuSjHrz6bFyoplTGmueM5ph1e8IlgbpS+IyjMp8J/zd6/+0TlRndVXfJ+pFeHF9toigTDWJZttRSsEwKa1P7zufmZ7wv73FDXKCyeFT4S8CfYjwu4l6fc6ltt+1vWHygPEGX1OnX/YGAZ1TUnpka8hUQFY4cFeX1cKYkVb9CPEnVl7wTaoAU0O2oVT1C5IUnFZEMrUz2ztRDXtEIbMUXhocsCi35PRnWgt4Ka3vQoLgSwu5xH+EZxKgPCMd4yrBGPMOeAZHITExQlbyjPx/yvDu9NmOWNlpwV6oiOHR2KPfDYPkjqtKqgS82RKYrlGOTPMLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7EGaCV/rM5+p1jaHlz8zossWnACeHWDNUzx7M9H0+0=;
 b=elbIe62WmuM0pqHag+8/4nYTEyupa2kwGio8Kh1iOBLmivctXWtZgPr6VRXsAHTdkKgz48jtErQ5i9lkOVavjK74kV4NDk/TrdDyFGa0BA9sCwoYJD3nVOtxGTN1jU+2G67JV4NuP/qN1z0TDHh7TOfdv3nXIEPr7xJNc76bRN2mrjsz8RJGZP24aB2UqZvkc0L6AHlO3duM02H4BQEXQsHdprUeNbRhoBBs+zFQaaW7ktPQY5Ilp9uGIC9mSnEEq5rF3Zmm97sW6FrfpAZw+wD3qQz8werccHFBQtfc6qGP9gzuo9RF4bNmD5d87mTR2A8yhGm4HaILMzjF5MWZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7EGaCV/rM5+p1jaHlz8zossWnACeHWDNUzx7M9H0+0=;
 b=r0ZcI/z+japhaJW6bM9EJ2nFYIW7eK4hdiZlWZMod7UJVs1M1DBbz8DABwW38KramIl+lP+cbZ0nVcp2hQxcn1faes3NwzroHh/Z61Olbd6+x4h5GndtwDZe41EFLTP3XyJYlX0NbvnVnsfnJBySVigqPctB2lpdsdHjI9g6LOw=
Received: from BL0PR0102CA0041.prod.exchangelabs.com (2603:10b6:208:25::18) by
 SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 11:15:45 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::26) by BL0PR0102CA0041.outlook.office365.com
 (2603:10b6:208:25::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:15:44 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:15:36 -0600
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
Subject: [RFC PATCH v2 15/22] KVM: X86: Handle private MMIO as shared
Date: Tue, 18 Feb 2025 22:10:02 +1100
Message-ID: <20250218111017.491719-16-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 856045c2-4b30-4bb4-2c80-08dd500d9654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4XgJJ6VHHFaS9tiutjaFInGxIXXLjsfvTL6dSfliULuWPN9a+iHuKPgKu7C?=
 =?us-ascii?Q?yiFG0XPmxC/bj5T6T12uCnJAvCpQvOTSgPFlehY9bgPr8c79y1kM16l3SNHg?=
 =?us-ascii?Q?bkjaqZwRoP+T09rv5K4vaKQe1Tqnik2vOU5I/EluwL7mvIdjH8ktud02XKZa?=
 =?us-ascii?Q?mADBHvdvEsoOnuZN1ttVYs/IKcAtANPPjdo0ULrehY6/06m6U4iLIUGbq7Yg?=
 =?us-ascii?Q?5kP5+MXHYwIF7ZpnP+j53Boc7PTqIoOxynAbsoHDhHKhHugjVTxvzA6DtY+4?=
 =?us-ascii?Q?zQeFbGyroDTznbXo/WDNb5w4eV2RiUJ+3NHPRvKKeC++Swjg2jdliyMh/PRg?=
 =?us-ascii?Q?iS4pNy7uPCh2MplVgaixnxmGGzAV0705k+UGWMpF1vaEgCinDirqLgiYw9bj?=
 =?us-ascii?Q?8DyEsPWyNnoO2cCRQdWjErTPQ0joqzLKjrc3NbfE/y+8FdLlvKoF+SDduTWh?=
 =?us-ascii?Q?CYxKNRMR5WVCXovwgIXk6VgAlODvnZWcQzrtXiCZBdOO+k/7UjhiNwHgZL9k?=
 =?us-ascii?Q?QYlCvXL6TfVYlAwUCes1/kONWELu/N1doYsCGPXXgRWBUw3Je56dK9JOtHev?=
 =?us-ascii?Q?uVRA74MA2VnMn9ZB0tabqXQ8Zsc7W2K9IH5MfK3Z0VpiHoLMv6n3w6xax85h?=
 =?us-ascii?Q?me/DUrPoHGsw2cgHV5H0Xt31biexLiLu6smnk/zXRJQvfwVmg/m7HfiJUZQY?=
 =?us-ascii?Q?7l2qu8omYyuQ+KitBe8MbZS4oAjFDVhQbE52uS7kfi0hF6uQz7YPIRbNioBd?=
 =?us-ascii?Q?MpRj0B9t6WcFSZWr8Rrr09WZ5aJMX9fkmLy8nrSzZL2vM5vl3NAjqB+7SX7d?=
 =?us-ascii?Q?UXjaiRmz0FLTTupwwtgSDkFORnxAAQ6ynlcG0Hf+xVwJj0hTuV4OrSrO1cEj?=
 =?us-ascii?Q?LHkDkS9Ko9ROWw136pJEb7zoaVmeZ+vQzbFZ/6j3kvHpcSYxht2xduZaeAcF?=
 =?us-ascii?Q?EeX/ykH5D/6GJ9gl/JX5gD6zUTMZHDiz8U9/N5XJh26d80sP0IOAe/xI9Bne?=
 =?us-ascii?Q?uP7jHWmUgCqndb3wR8zSvoHDZa8hRuKOdR/FSfLqlU3Ncj1gku+JU6Rpopeq?=
 =?us-ascii?Q?ey0EzZqqUzRbFbztEDG79ka6IrfiTbB2cA5237QS6oYCKDSgPVWDspjnVfYQ?=
 =?us-ascii?Q?W8vQdkGyqLR4Eq4IDIDV8jHFKY+ZN3jDJLM3i85M/pLkhQPaJWxZz5jls9gU?=
 =?us-ascii?Q?teaJlaa593Ep1gTYH2JzQagxdgOodh13VdkryEl9M5wGWVSMUy/wdgVK7n5h?=
 =?us-ascii?Q?yGOGH64HTL/r+O+uzl/sQzWmwxX/2DGf11XsQKc+BJwlHA1g0GX1RcB8oHnC?=
 =?us-ascii?Q?GO1fjBCFSbjoMLZDcEWEyPhq0DGklA4c6gwxVMmTbwUPj9Osm5ogjHi690un?=
 =?us-ascii?Q?QdyPAS4+lTrg9mNZqmMivFBkwPdnJF7EjY7YnGMJW0QCtGPgARYz9c4II0fb?=
 =?us-ascii?Q?QinEyKV/Wc5CPm9MijN+zSnJxSFsCvn/gL/t/64m0UiNyBe5aaDtpmBKCU0u?=
 =?us-ascii?Q?uOJgu0rpPC3s1Xw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:15:44.2749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856045c2-4b30-4bb4-2c80-08dd500d9654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

Currently private MMIO nested page faults are not expected so when such
fault occurs, KVM tries moving the faulted page from private to shared
which is not going to work as private MMIO is not backed by memfd.

Handle private MMIO as shared: skip page state change and memfd
page state tracking.

The MMIO KVM memory slot is still marked as shared as the guest can
access it as private or shared so marking the MMIO slot as private
is not going to help.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 74c20dbb92da..32e27080b1c7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4347,7 +4347,11 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 {
 	unsigned int foll = fault->write ? FOLL_WRITE : 0;
 
-	if (fault->is_private)
+	if (fault->slot && fault->is_private && !kvm_slot_can_be_private(fault->slot) &&
+	    (vcpu->kvm->arch.vm_type == KVM_X86_SNP_VM))
+		pr_warn("%s: private SEV TIO MMIO fault for fault->gfn=%llx\n",
+			__func__, fault->gfn);
+	else if (fault->is_private)
 		return kvm_mmu_faultin_pfn_private(vcpu, fault);
 
 	foll |= FOLL_NOWAIT;
-- 
2.47.1


