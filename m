Return-Path: <linux-arch+bounces-10183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E89A39A46
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E19168911
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318F23C39F;
	Tue, 18 Feb 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iMtexMVZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299D1AAA10;
	Tue, 18 Feb 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877232; cv=fail; b=YhsvpKkphzwEOyiZ80l8NGfGvStBVfZcJbLP0ZswtaZ2xh1CDotc6/Mc7LCqlY1EG+tHfrNsRa/bm79/R/5ufwmuaemgPYfR50XYL8wYp+aw8UHII8kdZ7CRtbH5ZMnng5zAE3wb5QLoweJp8z1VrmwG63OjWMNdR/p9UbG6COk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877232; c=relaxed/simple;
	bh=1wMMQpvWZNz70ZAnTP1kuXEMbTM+Ji3WYy/ykgu7m/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FElnyXBtvxMPPhWGLvImyg7B/ce5MsqzNmIpJ6WnR2BF05Z9PtExlQwOhrtocZLdJZ9aEfA6BMqnObPrUff8GTJ9UXegeZIENXDaDRP4UXkgYubRxeQ/stwRgTnim/nHTTo+MMjRDVlC47Ck/9WWGtM9DeduuK9MwtT5dHwrkG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iMtexMVZ; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwOr517ItULweB2X8naPpFZxWuHRH5pKSi9NquMKvL4IgE/4EyPmeDkvxH9vJVNtaa0DVnVWXfzmSNn7e/Zoyznt9M249J5DFee8f5nrFo3KG5i/7gUP8X5Fe+CMqzdrWRgroJp3sPXthV/eChohkqVQ+9ZYrMmkwk1YoQY0amyQ8Zc5EGrVIetnQT6i14oIrhYOt8Cj4rncRn0uEL0Igoo36LVrStg9Y+T7enQtW8V2WbAIe9/DAiQnlwF2OVlFKbi9ZhrUyS3On89cbMQGHBcgnJTIvdBOife88Z7lAHbCHDmrnAVb+upj9jV2R5VjcleI4/aPmC5Q8hLOPfGVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0bpBlCSa+fU72ncwwNisNntvm0wOihFAYgqCxT5Yi4=;
 b=ldTbRMl8mQKYQ54kVMkDdMslmwy180i8BTNIXgjBb4bjZOycwisiPVJhe+ZGRmRnm7wqLvuZ8fx5HH65v2H2rkGYbuQRD07t+UDwBPBN8VhVhCa7EdEG3u4T4y4V6qeEGK/YN2o+wtRn2CEkKUM2Q4nbOl00y1KzDTeTU6l8hPQr5gbexwFe8y+cfXJcfMLFSnyzbdUcecv0peKL40TbAmjVc0lYWYStkfQxgbN01bxHnGVd2r7Nemp4y/1r6V5+wgwWJP4gUxi/VH96Mx8jBplfv6lY3Ahqdwqg63WBPOOTNJ3LblobD7N20zeQpLpfcSvyjaTCnWpMy2eHR98b9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0bpBlCSa+fU72ncwwNisNntvm0wOihFAYgqCxT5Yi4=;
 b=iMtexMVZMG5qk+4N/h0RRoqf6COKvdQ2ubYYgx/RZFqhf0a3t5u3GCXZJ9+Fn/BeX0WRNxAxhArpdR2ZrqMhizqd+I/T183djiMg2x42GqfxrfGCWNFm0ZEyhuE8qj8XomMmvoWCjlbU/EQwk3KgsAEVBqccRX0bgNDXvrC7bs0=
Received: from BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30) by
 DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 11:13:42 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::fa) by BL0PR01CA0017.outlook.office365.com
 (2603:10b6:208:71::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 11:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:13:42 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:13:33 -0600
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
Subject: [RFC PATCH v2 09/22] crypto/ccp: Implement SEV TIO firmware interface
Date: Tue, 18 Feb 2025 22:09:56 +1100
Message-ID: <20250218111017.491719-10-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b55741a-4ccb-482a-1d3f-08dd500d4d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEFaZzUwbW1CVmhSbVBJWkxTd0oweFYwR25QUXJhSDBDeUJ5aHFzTGd5ZlU0?=
 =?utf-8?B?WTE4a0hGeGh2Z1gwUWg4UE1PUE9YQlBtYUs4cVVPS0FiNS9QVHFkUFF6bnl2?=
 =?utf-8?B?RjRkYWlpREh3L1YydU9sMzJtN2xXV01GVUFNU1NmQmgvN0pXRDFSWVQrQnhu?=
 =?utf-8?B?TUk1bWVHRVlWN0FwYnc3MzMrOTR2QmtVdTdmS2RKaEFpbE9wR0NOa3lsMWhZ?=
 =?utf-8?B?bi9uNTVRenU5Qm1NOFpnYldhNVpLeWFiUGZ3T2VRdldGZUJ3Y1Q1SEJ6bVB2?=
 =?utf-8?B?MDFJMEswdTNzWGU1Y3NnbkNvdW4vcUs1SjR0UllKc3MvV0lidTdVRE96eFBy?=
 =?utf-8?B?TnY2eHh0YTNNZGt4NjZzZGtha0ZMOWI1WXdpS1VWWXY1cnFGa3hYVGo5dTFK?=
 =?utf-8?B?WlBjNXoweWtsdTlPNVVKbGJsbmUrOHo4ZmxUUm1OdHY4bTNhemdpeUFsdkJG?=
 =?utf-8?B?TFFGMzZHb05JVWx4TTBrdXA4cFFiL2VDVVp0d2dqTEhISzZ4RTJnblBvWGli?=
 =?utf-8?B?eDZpd0RTN0hEaXY0QjU3VHBQL0tteHFQNEJ5MWhEYnlvSktublo5SlNNVTlj?=
 =?utf-8?B?WjFFcTJuZVRDK0hsSlkvb3NLU3UxRDc4SWcrVlc5YjhJUWhKZGh4N3B5Rmh1?=
 =?utf-8?B?M0M5cWlRL0tkWHE4bXRLQVRaTWdkSTFZRFRiaGJ6NGc0QUdEblo0NjdSOXVH?=
 =?utf-8?B?SDhhTDdoaDlCZHF6bXNmb1hpamoraC9PVUk5djhUYllBQTY5N2k4ajl4RWNT?=
 =?utf-8?B?K2tQdWluVm8yNEpROGFPb0h4OUVLZGxnUC94dkVSL3pRVnVVYmQyaHNwYmNT?=
 =?utf-8?B?cE9YUDFKeFFtclhSZityWU1nQUhsaVdUaG9ya0pRQ2ptamNvMU90RDlPeUhY?=
 =?utf-8?B?M3RhQ0VFN3BIUmRQTDdJUXl3ditoakpHQjc2R08vK2phVFVPMzdSOFhLY2NJ?=
 =?utf-8?B?c2o5SjFSTWxFQkZETHVEa2dCSVZvWDZoeWxFUTNGNUNQdDhnODlaRVZQbmV1?=
 =?utf-8?B?Zlp5VDdmZmZLb2RLVXlhRDRxMWxVWkpFWkRDKzBuY3Q2cHdZNi92T3N1Zjlr?=
 =?utf-8?B?V3BnVWhaVWRxRVRIdld0SFVhNjNNYlhYSGpORDI5UFVIY1l0UW1oZGRhdFVz?=
 =?utf-8?B?bFdpYlVVSTBYb3M0WU55cGpXbHAzSkJLUG1RbWV0VzNWbEtMOUFEQzlKYm1i?=
 =?utf-8?B?S2xpeWhOS2l3WTlNOVhHb3FnYnpwRFcvK0VKRk5iSlRRWXUxaUlUQUpEcUh3?=
 =?utf-8?B?T0VWcVBSV3dOb0VpZjF6KzlKZXNWUWtqVGRGbmwrRVk5NTlsZDZvTElSRll4?=
 =?utf-8?B?cU5KWFJRTmk4RjBKZzhiVElNdzFqeVlJVDE0U1RIRjBWT0FsOCtPYXJycDUv?=
 =?utf-8?B?aVIrOWVXb3ZHbWo0Nko2S09PWjFqVEp3M01mYTBUV3llQ3pYTkZ0b29iMGxV?=
 =?utf-8?B?Qkw1TGMwV01VbHVOWERiWXc1TXRzYzFzUmpYTHhJVHFRbCtsbHpYNHhpT25I?=
 =?utf-8?B?QVVTUTk5V09RZHdmSGlxV2tDRENKWWs3T2J0dFRIZW13dlcyN0pmWlhWeHhH?=
 =?utf-8?B?bXVUZ1hGVjF3N3Nqem1XR0ExaVFSU3VZMzg2dit3b3lrTVJOSWIvNmhNTzRC?=
 =?utf-8?B?ekppLzUrcnZSVVhNVmdMUUoydW1FbTl1MFhwWWRsVm1HUklteEpvU1U4VDJx?=
 =?utf-8?B?YVNhVWJBSlVRY3ByRElLWFg2Q1VNMlpoWC94VTN0M2tMU3pTU2o1anJ5ZVF2?=
 =?utf-8?B?Y3U3K0VyUFA2MFVJUnNzZDV6WGJscjhKOVpwd2YvelR5QUpFclpoeUJaeTFW?=
 =?utf-8?B?dlQyL0wrUWt6dE9kOFpPVGgrdDFXMkJsa2U0aThqR0hSaG1Gd1U5emtlOWxV?=
 =?utf-8?B?NlNjcG9JVEFaSEdPcVg0Y3d2Z3dXdFRjODZrOTQ1N1pPZVhvY3RheTJFOStw?=
 =?utf-8?B?MXJQblU2eG1sQW1oVUExYTFZSlBtL2FUWlA1WmNPTStseERuTVArbEg4L0hY?=
 =?utf-8?Q?UvdLqn8G4RbKJM3IQrHhHtY8Y6+4Bw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:13:42.0564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b55741a-4ccb-482a-1d3f-08dd500d4d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

On AND SEV, the AMD PSP firmware acts as TSM (manages the
security/trust). The CCP driver provides the interface to it
and registers itself in the TSM-HOST subsystem.

Implement SEV TIO PSP command wrappers in sev-dev-tio.c, these make
SPDM calls and store the data in the SEV-TIO-specific structs.

Implement TSM-HOST hooks in sev-dev-tsm.c.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/crypto/ccp/Makefile       |   13 +
 arch/x86/include/asm/sev.h        |   20 +
 drivers/crypto/ccp/sev-dev-tio.h  |  111 ++
 drivers/crypto/ccp/sev-dev.h      |   18 +
 include/linux/psp-sev.h           |   27 +
 include/uapi/linux/psp-sev.h      |    2 +
 drivers/crypto/ccp/sev-dev-tio.c  | 1664 ++++++++++++++++++++
 drivers/crypto/ccp/sev-dev-tsm.c  |  709 +++++++++
 drivers/crypto/ccp/sev-dev.c      |   10 +-
 drivers/virt/coco/host/tsm-host.c |    4 +-
 drivers/crypto/ccp/Kconfig        |    2 +
 11 files changed, 2576 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index 5ce69134ec48..8868896f3fd5 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -14,6 +14,19 @@ ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) += psp-dev.o \
                                    platform-access.o \
                                    dbc.o \
                                    hsti.o
+
+ifeq ($(CONFIG_CRYPTO_DEV_SP_PSP)$(CONFIG_PCI_TSM),yy)
+ccp-y += sev-dev-tsm.o sev-dev-tio.o
+endif
+
+ifeq ($(CONFIG_CRYPTO_DEV_SP_PSP)$(CONFIG_PCI_TSM),ym)
+ccp-m += sev-dev-tsm.o sev-dev-tio.o
+endif
+
+ifeq ($(CONFIG_CRYPTO_DEV_SP_PSP)$(CONFIG_PCI_TSM),mm)
+ccp-m += sev-dev-tsm.o sev-dev-tio.o
+endif
+
 ccp-$(CONFIG_CRYPTO_DEV_SP_PSP_FW_UPLOAD) += sev-fw.o
 
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) += ccp-crypto.o
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 46a7e5d45275..c5e9455df0dc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -146,6 +146,14 @@ enum msg_type {
 	SNP_MSG_ABSORB_RSP,
 	SNP_MSG_VMRK_REQ,
 	SNP_MSG_VMRK_RSP,
+	TIO_MSG_TDI_INFO_REQ        = 0x81,
+	TIO_MSG_TDI_INFO_RSP        = 0x01,
+	TIO_MSG_MMIO_VALIDATE_REQ   = 0x82,
+	TIO_MSG_MMIO_VALIDATE_RSP   = 0x02,
+	TIO_MSG_MMIO_CONFIG_REQ     = 0x83,
+	TIO_MSG_MMIO_CONFIG_RSP     = 0x03,
+	TIO_MSG_SDTE_WRITE_REQ      = 0x84,
+	TIO_MSG_SDTE_WRITE_RSP      = 0x04,
 
 	SNP_MSG_TSC_INFO_REQ = 17,
 	SNP_MSG_TSC_INFO_RSP,
@@ -209,6 +217,18 @@ struct snp_guest_req {
 	void *data;
 };
 
+/* SPDM algorithms used for TDISP, used in TIO_MSG_TDI_INFO_REQ */
+#define TIO_SPDM_ALGOS_DHE_SECP256R1			0
+#define TIO_SPDM_ALGOS_DHE_SECP384R1			1
+#define TIO_SPDM_ALGOS_AEAD_AES_128_GCM			(0<<8)
+#define TIO_SPDM_ALGOS_AEAD_AES_256_GCM			(1<<8)
+#define TIO_SPDM_ALGOS_ASYM_TPM_ALG_RSASSA_3072		(0<<16)
+#define TIO_SPDM_ALGOS_ASYM_TPM_ALG_ECDSA_ECC_NIST_P256	(1<<16)
+#define TIO_SPDM_ALGOS_ASYM_TPM_ALG_ECDSA_ECC_NIST_P384	(2<<16)
+#define TIO_SPDM_ALGOS_HASH_TPM_ALG_SHA_256		(0<<24)
+#define TIO_SPDM_ALGOS_HASH_TPM_ALG_SHA_384		(1<<24)
+#define TIO_SPDM_ALGOS_KEY_SCHED_SPDM_KEY_SCHEDULE	(0ULL<<32)
+
 /*
  * The secrets page contains 96-bytes of reserved field that can be used by
  * the guest OS. The guest OS uses the area to save the message sequence
diff --git a/drivers/crypto/ccp/sev-dev-tio.h b/drivers/crypto/ccp/sev-dev-tio.h
new file mode 100644
index 000000000000..98d6797fea5e
--- /dev/null
+++ b/drivers/crypto/ccp/sev-dev-tio.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __PSP_SEV_TIO_H__
+#define __PSP_SEV_TIO_H__
+
+#include <linux/tsm.h>
+#include <linux/pci-ide.h>
+#include <uapi/linux/psp-sev.h>
+
+#if defined(CONFIG_CRYPTO_DEV_SP_PSP) || defined(CONFIG_CRYPTO_DEV_SP_PSP_MODULE)
+
+struct sla_addr_t {
+	union {
+		u64 sla;
+		struct {
+			u64 page_type:1;
+			u64 page_size:1;
+			u64 reserved1:10;
+			u64 pfn:40;
+			u64 reserved2:12;
+		};
+	};
+} __packed;
+
+#define SEV_TIO_MAX_COMMAND_LENGTH	128
+#define SEV_TIO_MAX_DATA_LENGTH		256
+
+/* struct tsm_dev::data */
+struct tsm_dev_tio {
+	struct sla_addr_t dev_ctx;
+	struct sla_addr_t req;
+	struct sla_addr_t resp;
+	struct sla_addr_t scratch;
+	struct sla_addr_t output;
+	size_t output_len;
+	size_t scratch_len;
+	struct sla_buffer_hdr *reqbuf; /* vmap'ed @req for DOE */
+	struct sla_buffer_hdr *respbuf; /* vmap'ed @resp for DOE */
+
+	int cmd;
+	int psp_ret;
+	u8 cmd_data[SEV_TIO_MAX_COMMAND_LENGTH];
+	u8 *data_pg; /* Data page for SPDM-aware commands returning some data */
+
+	struct sev_tio_status *tio_status;
+	void *guest_req_buf;    /* Bounce buffer for TIO Guest Request input */
+	void *guest_resp_buf;   /* Bounce buffer for TIO Guest Request output */
+
+	struct pci_ide ide;
+};
+
+/* struct tsm_tdi::data */
+struct tsm_tdi_tio {
+	struct sla_addr_t tdi_ctx;
+	u64 gctx_paddr;
+	u32 asid;
+};
+
+#define SPDM_DOBJ_ID_NONE		0
+#define SPDM_DOBJ_ID_REQ		1
+#define SPDM_DOBJ_ID_RESP		2
+#define SPDM_DOBJ_ID_CERTIFICATE	4
+#define SPDM_DOBJ_ID_MEASUREMENT	5
+#define SPDM_DOBJ_ID_REPORT		6
+
+void sev_tio_cleanup(struct sev_device *sev);
+
+void tio_save_output(struct tsm_blob **blob, struct sla_addr_t sla, u32 dobjid);
+
+int sev_tio_status(struct sev_device *sev);
+int sev_tio_continue(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm);
+
+int sev_tio_dev_measurements(struct tsm_dev_tio *dev_data, void *nonce, size_t nonce_len,
+			     struct tsm_spdm *spdm);
+int sev_tio_dev_certificates(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm);
+int sev_tio_dev_create(struct tsm_dev_tio *dev_data, u16 device_id, u16 root_port_id,
+		       u8 segment_id);
+int sev_tio_dev_connect(struct tsm_dev_tio *dev_data, u8 tc_mask, u8 ids[8], u8 cert_slot,
+			struct tsm_spdm *spdm);
+int sev_tio_dev_disconnect(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm);
+int sev_tio_dev_reclaim(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm);
+int sev_tio_dev_status(struct tsm_dev_tio *dev_data, struct tsm_dev_status *status);
+int sev_tio_ide_refresh(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm);
+
+int sev_tio_tdi_create(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data, u16 dev_id,
+		       u8 rseg, u8 rseg_valid);
+void sev_tio_tdi_reclaim(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data);
+int sev_tio_guest_request(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+			  void *req, void *res, struct tsm_spdm *spdm);
+
+int sev_tio_tdi_bind(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		     u32 guest_rid, u64 gctx_paddr, u32 asid, bool force_run,
+		     struct tsm_spdm *spdm);
+int sev_tio_tdi_unbind(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm);
+int sev_tio_tdi_report(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm);
+
+int sev_tio_asid_fence_clear(u16 device_id, u8 segment_id, u64 gctx_paddr, int *psp_ret);
+int sev_tio_asid_fence_status(struct tsm_dev_tio *dev_data, u16 device_id, u8 segment_id,
+			      u32 asid, bool *fenced);
+
+int sev_tio_tdi_info(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		     struct tsm_tdi_status *ts);
+int sev_tio_tdi_status(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm);
+int sev_tio_tdi_status_fin(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+			   enum tsm_tdisp_state *state);
+
+#endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
+
+#endif	/* __PSP_SEV_TIO_H__ */
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index c87a312f7da6..342fcd42fa7c 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -43,6 +43,8 @@ struct sev_misc_dev {
 	struct miscdevice misc;
 };
 
+struct sev_tio_status;
+
 struct sev_device {
 	struct device *dev;
 	struct psp_device *psp;
@@ -71,7 +73,13 @@ struct sev_device {
 	struct fw_upload *fwl;
 	bool fw_cancel;
 #endif /* CONFIG_FW_UPLOAD */
+
 	bool tio_en;
+#if defined(CONFIG_PCI_TSM) || defined(CONFIG_PCI_TSM_MODULE)
+	struct tsm_host_subsys *tsm;
+	struct tsm_bus_subsys *tsm_bus;
+	struct sev_tio_status *tio_status;
+#endif
 };
 
 bool sev_version_greater_or_equal(u8 maj, u8 min);
@@ -102,4 +110,14 @@ static inline void sev_snp_destroy_firmware_upload(struct sev_device *sev) { }
 static inline int sev_snp_synthetic_error(struct sev_device *sev, int *psp_ret) { return 0; }
 #endif /* CONFIG_CRYPTO_DEV_SP_PSP_FW_UPLOAD */
 
+#if defined(CONFIG_PCI_TSM) || defined(CONFIG_PCI_TSM_MODULE)
+void sev_tsm_init(struct sev_device *sev);
+void sev_tsm_uninit(struct sev_device *sev);
+int sev_tio_cmd_buffer_len(int cmd);
+#else
+static inline void sev_tsm_init(struct sev_device *sev) {}
+static inline void sev_tsm_uninit(struct sev_device *sev) {}
+static inline int sev_tio_cmd_buffer_len(int cmd) { return 0; }
+#endif
+
 #endif /* __SEV_DEV_H */
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 103d9c161f41..5d276e2c2112 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -12,6 +12,7 @@
 #ifndef __PSP_SEV_H__
 #define __PSP_SEV_H__
 
+#include <linux/tsm.h>
 #include <uapi/linux/psp-sev.h>
 
 #define SEV_FW_BLOB_MAX_SIZE	0x4000	/* 16KB */
@@ -109,6 +110,27 @@ enum sev_cmd {
 	SEV_CMD_SNP_VLEK_LOAD		= 0x0CD,
 	SEV_CMD_SNP_FEATURE_INFO	= 0x0CE,
 
+	/* SEV-TIO commands */
+	SEV_CMD_TIO_STATUS		= 0x0D0,
+	SEV_CMD_TIO_INIT		= 0x0D1,
+	SEV_CMD_TIO_DEV_CREATE		= 0x0D2,
+	SEV_CMD_TIO_DEV_RECLAIM		= 0x0D3,
+	SEV_CMD_TIO_DEV_CONNECT		= 0x0D4,
+	SEV_CMD_TIO_DEV_DISCONNECT	= 0x0D5,
+	SEV_CMD_TIO_DEV_STATUS		= 0x0D6,
+	SEV_CMD_TIO_DEV_MEASUREMENTS	= 0x0D7,
+	SEV_CMD_TIO_DEV_CERTIFICATES	= 0x0D8,
+	SEV_CMD_TIO_TDI_CREATE		= 0x0DA,
+	SEV_CMD_TIO_TDI_RECLAIM		= 0x0DB,
+	SEV_CMD_TIO_TDI_BIND		= 0x0DC,
+	SEV_CMD_TIO_TDI_UNBIND		= 0x0DD,
+	SEV_CMD_TIO_TDI_REPORT		= 0x0DE,
+	SEV_CMD_TIO_TDI_STATUS		= 0x0DF,
+	SEV_CMD_TIO_GUEST_REQUEST	= 0x0E0,
+	SEV_CMD_TIO_ASID_FENCE_CLEAR	= 0x0E1,
+	SEV_CMD_TIO_ASID_FENCE_STATUS	= 0x0E2,
+	SEV_CMD_TIO_TDI_INFO		= 0x0E3,
+	SEV_CMD_TIO_ROLL_KEY		= 0x0E4,
 	SEV_CMD_MAX,
 };
 
@@ -770,6 +792,11 @@ struct sev_data_snp_guest_request {
 	u64 res_paddr;				/* In */
 } __packed;
 
+struct tio_guest_request {
+	struct sev_data_snp_guest_request data;
+	int fw_err;
+};
+
 /**
  * struct sev_data_snp_init_ex - SNP_INIT_EX structure
  *
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index affa65dcebd4..a2fbc20c5db6 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -88,6 +88,8 @@ typedef enum {
 	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
 	SEV_RET_INVALID_KEY                = 0x0027,
 	SEV_RET_SHUTDOWN_INCOMPLETE        = 0x0028,
+	SEV_RET_INCORRECT_BUFFER_LENGTH	   = 0x0030,
+	SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST = 0x0031,
 	SEV_RET_SPDM_REQUEST               = 0x0032,
 	SEV_RET_SPDM_ERROR                 = 0x0033,
 	SEV_RET_IN_USE                     = 0x003A,
diff --git a/drivers/crypto/ccp/sev-dev-tio.c b/drivers/crypto/ccp/sev-dev-tio.c
new file mode 100644
index 000000000000..bd55ad6c5fb3
--- /dev/null
+++ b/drivers/crypto/ccp/sev-dev-tio.c
@@ -0,0 +1,1664 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+// Interface to PSP for CCP/SEV-TIO/SNP-VM
+
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include <linux/psp.h>
+#include <linux/file.h>
+#include <linux/vmalloc.h>
+
+#include <asm/sev-common.h>
+#include <asm/sev.h>
+#include <asm/page.h>
+
+#include "psp-dev.h"
+#include "sev-dev.h"
+#include "sev-dev-tio.h"
+
+static void *__prep_data_pg(struct tsm_dev_tio *dev_data, size_t len)
+{
+	void *r = dev_data->data_pg;
+
+	if (snp_reclaim_pages(virt_to_phys(r), 1, false))
+		return NULL;
+
+	memset(r, 0, len);
+
+	if (rmp_make_private(page_to_pfn(virt_to_page(r)), 0, PG_LEVEL_4K, 0, true))
+		return NULL;
+
+	return r;
+}
+
+#define prep_data_pg(type, tdev) ((type *) __prep_data_pg((tdev), sizeof(type)))
+
+#define SLA_PAGE_TYPE_DATA	0
+#define SLA_PAGE_TYPE_SCATTER	1
+#define SLA_PAGE_SIZE_4K	0
+#define SLA_PAGE_SIZE_2M	1
+#define SLA_SZ(s)		((s).page_size == SLA_PAGE_SIZE_2M ? SZ_2M : SZ_4K)
+#define SLA_SCATTER_LEN(s)	(SLA_SZ(s) / sizeof(struct sla_addr_t))
+#define SLA_EOL			((struct sla_addr_t) { .pfn = 0xFFFFFFFFFFUL })
+#define SLA_NULL		((struct sla_addr_t) { 0 })
+#define IS_SLA_NULL(s)		((s).sla == SLA_NULL.sla)
+#define IS_SLA_EOL(s)		((s).sla == SLA_EOL.sla)
+
+/* the BUFFER Structure */
+struct sla_buffer_hdr {
+	u32 capacity_sz;
+	u32 payload_sz; /* The size of BUFFER_PAYLOAD in bytes. Must be multiple of 32B */
+	union {
+		u32 flags;
+		struct {
+			u32 encryption:1;
+		};
+	};
+	u32 reserved1;
+	u8 iv[16];	/* IV used for the encryption of this buffer */
+	u8 authtag[16]; /* Authentication tag for this buffer */
+	u8 reserved2[16];
+} __packed;
+
+struct spdm_dobj_hdr {
+	u32 id;     /* Data object type identifier */
+	u32 length; /* Length of the data object, INCLUDING THIS HEADER */
+	union {
+		u16 ver; /* Version of the data object structure */
+		struct {
+			u8 minor;
+			u8 major;
+		} version;
+	};
+} __packed;
+
+enum spdm_data_type_t {
+	DOBJ_DATA_TYPE_SPDM = 0x1,
+	DOBJ_DATA_TYPE_SECURE_SPDM = 0x2,
+};
+
+struct spdm_dobj_hdr_req {
+	struct spdm_dobj_hdr hdr; /* hdr.id == SPDM_DOBJ_ID_REQ */
+	u8 data_type; /* spdm_data_type_t */
+	u8 reserved2[5];
+} __packed;
+
+struct spdm_dobj_hdr_resp {
+	struct spdm_dobj_hdr hdr; /* hdr.id == SPDM_DOBJ_ID_RESP */
+	u8 data_type; /* spdm_data_type_t */
+	u8 reserved2[5];
+} __packed;
+
+struct spdm_dobj_hdr_cert {
+	struct spdm_dobj_hdr hdr; /* hdr.id == SPDM_DOBJ_ID_CERTIFICATE */
+	u8 reserved1[6];
+	u16 device_id;
+	u8 segment_id;
+	u8 type; /* 1h: SPDM certificate. 0h, 2h–FFh: Reserved. */
+	u8 reserved2[12];
+} __packed;
+
+struct spdm_dobj_hdr_meas {
+	struct spdm_dobj_hdr hdr; /* hdr.id == SPDM_DOBJ_ID_MEASUREMENT */
+	u8 reserved1[6];
+	u16 device_id;
+	u8 segment_id;
+	u8 type; /* 1h: SPDM measurement. 0h, 2h–FFh: Reserved. */
+	u8 reserved2[12];
+} __packed;
+
+struct spdm_dobj_hdr_report {
+	struct spdm_dobj_hdr hdr; /* hdr.id == SPDM_DOBJ_ID_REPORT */
+	u8 reserved1[6];
+	u16 device_id;
+	u8 segment_id;
+	u8 type; /* 1h: TDISP interface report. 0h, 2h–FFh: Reserved */
+	u8 reserved2[12];
+} __packed;
+
+/* Used in all SPDM-aware TIO commands */
+struct spdm_ctrl {
+	struct sla_addr_t req;
+	struct sla_addr_t resp;
+	struct sla_addr_t scratch;
+	struct sla_addr_t output;
+} __packed;
+
+static size_t sla_dobj_id_to_size(u8 id)
+{
+	size_t n;
+
+	BUILD_BUG_ON(sizeof(struct spdm_dobj_hdr_resp) != 0x10);
+	switch (id) {
+	case SPDM_DOBJ_ID_REQ:
+		n = sizeof(struct spdm_dobj_hdr_req);
+		break;
+	case SPDM_DOBJ_ID_RESP:
+		n = sizeof(struct spdm_dobj_hdr_resp);
+		break;
+	case SPDM_DOBJ_ID_CERTIFICATE:
+		n = sizeof(struct spdm_dobj_hdr_cert);
+		break;
+	case SPDM_DOBJ_ID_MEASUREMENT:
+		n = sizeof(struct spdm_dobj_hdr_meas);
+		break;
+	case SPDM_DOBJ_ID_REPORT:
+		n = sizeof(struct spdm_dobj_hdr_report);
+		break;
+	default:
+		WARN_ON(1);
+		n = 0;
+		break;
+	}
+
+	return n;
+}
+
+#define SPDM_DOBJ_HDR_SIZE(hdr)		sla_dobj_id_to_size((hdr)->id)
+#define SPDM_DOBJ_DATA(hdr)		((u8 *)(hdr) + SPDM_DOBJ_HDR_SIZE(hdr))
+#define SPDM_DOBJ_LEN(hdr)		((hdr)->length - SPDM_DOBJ_HDR_SIZE(hdr))
+
+#define sla_to_dobj_resp_hdr(buf)	((struct spdm_dobj_hdr_resp *) \
+					sla_to_dobj_hdr_check((buf), SPDM_DOBJ_ID_RESP))
+#define sla_to_dobj_req_hdr(buf)	((struct spdm_dobj_hdr_req *) \
+					sla_to_dobj_hdr_check((buf), SPDM_DOBJ_ID_REQ))
+
+static struct spdm_dobj_hdr *sla_to_dobj_hdr(struct sla_buffer_hdr *buf)
+{
+	if (!buf)
+		return NULL;
+
+	return (struct spdm_dobj_hdr *) &buf[1];
+}
+
+static struct spdm_dobj_hdr *sla_to_dobj_hdr_check(struct sla_buffer_hdr *buf, u32 check_dobjid)
+{
+	struct spdm_dobj_hdr *hdr = sla_to_dobj_hdr(buf);
+
+	if (hdr && hdr->id == check_dobjid)
+		return hdr;
+
+	pr_err("! ERROR: expected %d, found %d\n", check_dobjid, hdr->id);
+	return NULL;
+}
+
+static void *sla_to_data(struct sla_buffer_hdr *buf, u32 dobjid)
+{
+	struct spdm_dobj_hdr *hdr = sla_to_dobj_hdr(buf);
+
+	if (WARN_ON_ONCE(dobjid != SPDM_DOBJ_ID_REQ && dobjid != SPDM_DOBJ_ID_RESP))
+		return NULL;
+
+	if (!hdr)
+		return NULL;
+
+	return (u8 *) hdr + sla_dobj_id_to_size(dobjid);
+}
+
+/**
+ * struct sev_tio_status - TIO_STATUS command's info_paddr buffer
+ *
+ * @length: Length of this structure in bytes.
+ * @tio_init_done: Indicates TIO_INIT has been invoked
+ * @tio_en: Indicates that SNP_INIT_EX initialized the RMP for SEV-TIO.
+ * @spdm_req_size_min: Minimum SPDM request buffer size in bytes.
+ * @spdm_req_size_max: Maximum SPDM request buffer size in bytes.
+ * @spdm_scratch_size_min: Minimum  SPDM scratch buffer size in bytes.
+ * @spdm_scratch_size_max: Maximum SPDM scratch buffer size in bytes.
+ * @spdm_out_size_min: Minimum SPDM output buffer size in bytes
+ * @spdm_out_size_max: Maximum for the SPDM output buffer size in bytes.
+ * @spdm_rsp_size_min: Minimum SPDM response buffer size in bytes.
+ * @spdm_rsp_size_max: Maximum SPDM response buffer size in bytes.
+ * @devctx_size: Size of a device context buffer in bytes.
+ * @tdictx_size: Size of a TDI context buffer in bytes.
+ */
+struct sev_tio_status {
+	u32 length;
+	union {
+		u32 flags;
+		struct {
+			u32 tio_en:1;
+			u32 tio_init_done:1;
+		};
+	};
+	u32 spdm_req_size_min;
+	u32 spdm_req_size_max;
+	u32 spdm_scratch_size_min;
+	u32 spdm_scratch_size_max;
+	u32 spdm_out_size_min;
+	u32 spdm_out_size_max;
+	u32 spdm_rsp_size_min;
+	u32 spdm_rsp_size_max;
+	u32 devctx_size;
+	u32 tdictx_size;
+};
+
+/**
+ * struct sev_data_tio_status - SEV_CMD_TIO_STATUS command
+ *
+ * @length: Length of this command buffer in bytes
+ * @status_paddr: SPA of the TIO_STATUS structure
+ */
+struct sev_data_tio_status {
+	u32 length;
+	u32 reserved;
+	u64 status_paddr;
+} __packed;
+
+/* TIO_INIT */
+struct sev_data_tio_init {
+	u32 length;
+	u32 reserved[3];
+} __packed;
+
+void sev_tio_cleanup(struct sev_device *sev)
+{
+	kfree(sev->tio_status);
+	sev->tio_status = NULL;
+}
+
+/**
+ * struct sev_data_tio_dev_create - TIO_DEV_CREATE command
+ *
+ * @length: Length in bytes of this command buffer.
+ * @dev_ctx_sla: A scatter list address pointing to a buffer to be used as a device context buffer.
+ * @device_id: The PCIe Routing Identifier of the device to connect to.
+ * @root_port_id: FiXME: The PCIe Routing Identifier of the root port of the device.
+ * @segment_id: The PCIe Segment Identifier of the device to connect to.
+ */
+struct sev_data_tio_dev_create {
+	u32 length;
+	u32 reserved1;
+	struct sla_addr_t dev_ctx_sla;
+	u16 device_id;
+	u16 root_port_id;
+	u8 segment_id;
+	u8 reserved2[11];
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_connect - TIO_DEV_CONNECT
+ *
+ * @length: Length in bytes of this command buffer.
+ * @spdm_ctrl: SPDM control structure defined in Section 5.1.
+ * @device_id: The PCIe Routing Identifier of the device to connect to.
+ * @root_port_id: The PCIe Routing Identifier of the root port of the device.
+ * @segment_id: The PCIe Segment Identifier of the device to connect to.
+ * @dev_ctx_sla: Scatter list address of the device context buffer.
+ * @tc_mask: Bitmask of the traffic classes to initialize for SEV-TIO usage.
+ *           Setting the kth bit of the TC_MASK to 1 indicates that the traffic
+ *           class k will be initialized.
+ * @cert_slot: Slot number of the certificate requested for constructing the SPDM session.
+ * @ide_stream_id: IDE stream IDs to be associated with this device.
+ *                 Valid only if corresponding bit in TC_MASK is set.
+ */
+struct sev_data_tio_dev_connect {
+	u32 length;
+	u32 reserved1;
+	struct spdm_ctrl spdm_ctrl;
+	u8 reserved2[8];
+	struct sla_addr_t dev_ctx_sla;
+	u8 tc_mask;
+	u8 cert_slot;
+	u8 reserved3[6];
+	u8 ide_stream_id[8];
+	u8 reserved4[8];
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_disconnect - TIO_DEV_DISCONNECT
+ *
+ * @length: Length in bytes of this command buffer.
+ * @force: Force device disconnect without SPDM traffic.
+ * @spdm_ctrl: SPDM control structure defined in Section 5.1.
+ * @dev_ctx_sla: Scatter list address of the device context buffer.
+ */
+struct sev_data_tio_dev_disconnect {
+	u32 length;
+	union {
+		u32 flags;
+		struct {
+			u32 force:1;
+		};
+	};
+	struct spdm_ctrl spdm_ctrl;
+	struct sla_addr_t dev_ctx_sla;
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_meas - TIO_DEV_MEASUREMENTS
+ *
+ * @length: Length in bytes of this command buffer
+ * @raw_bitstream: 0: Requests the digest form of the attestation report
+ *                 1: Requests the raw bitstream form of the attestation report
+ * @spdm_ctrl: SPDM control structure defined in Section 5.1.
+ * @dev_ctx_sla: Scatter list address of the device context buffer.
+ */
+struct sev_data_tio_dev_meas {
+	u32 length;
+	union {
+		u32 flags;
+		struct {
+			u32 raw_bitstream:1;
+		};
+	};
+	struct spdm_ctrl spdm_ctrl;
+	struct sla_addr_t dev_ctx_sla;
+	u8 meas_nonce[32];
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_certs - TIO_DEV_CERTIFICATES
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure defined in Section 5.1.
+ * @dev_ctx_sla: Scatter list address of the device context buffer.
+ */
+struct sev_data_tio_dev_certs {
+	u32 length;
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;
+	struct sla_addr_t dev_ctx_sla;
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_reclaim - TIO_DEV_RECLAIM command
+ *
+ * @length: Length in bytes of this command buffer
+ * @dev_ctx_paddr: SPA of page donated by hypervisor
+ */
+struct sev_data_tio_dev_reclaim {
+	u32 length;
+	u32 reserved;
+	struct sla_addr_t dev_ctx_sla;
+} __packed;
+
+/**
+ * struct sev_tio_dev_status - sev_data_tio_dev_status::status_paddr of
+ * TIO_DEV_STATUS command
+ *
+ */
+struct sev_tio_dev_status {
+	u32 length;
+	u8 ctx_state;
+	u8 reserved1;
+	union {
+		u8 p1;
+		struct {
+			u8 request_pending:1;
+			u8 request_pending_tdi:1;
+		};
+	};
+	u8 certs_slot;
+	u16 device_id;
+	u8 segment_id;
+	u8 tc_mask;
+	u16 request_pending_command;
+	u16 reserved2;
+	struct tdisp_interface_id request_pending_interface_id;
+	union {
+		u8 p2;
+		struct {
+			u8 meas_digest_valid:1;
+			u8 no_fw_update:1;
+		};
+	};
+	u8 reserved3[3];
+	u8 ide_stream_id[8];
+	u8 reserved4[8];
+	u8 certs_digest[48];
+	u8 meas_digest[48];
+	u32 tdi_count;
+	u32 bound_tdi_count;
+	u8 reserved5[8];
+} __packed;
+
+/**
+ * struct sev_data_tio_dev_status - TIO_DEV_STATUS command
+ *
+ * @length: Length in bytes of this command buffer
+ * @dev_ctx_paddr: SPA of a device context page
+ * @status_length: Length in bytes of the sev_tio_dev_status buffer
+ * @status_paddr: SPA of the status buffer. See Table 16
+ */
+struct sev_data_tio_dev_status {
+	u32 length;				/* In */
+	u32 reserved;
+	struct sla_addr_t dev_ctx_paddr;		/* In */
+	u32 status_length;			/* In */
+	u64 status_paddr;			/* In */
+} __packed;
+
+/**
+ * struct sev_data_tio_tdi_create - TIO_TDI_CREATE command
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure
+ * @dev_ctx_paddr: SPA of a device context page
+ * @tdi_ctx_paddr: SPA of page donated by hypervisor
+ * @interface_id: Interface ID of the TDI as defined by TDISP (host PCIID)
+ */
+struct sev_data_tio_tdi_create {
+	u32 length;				/* In */
+	u32 reserved;
+	struct sla_addr_t dev_ctx_sla;			/* In */
+	struct sla_addr_t tdi_ctx_sla;			/* In */
+	struct tdisp_interface_id interface_id;	/* In */
+	u8 reserved2[12];
+} __packed;
+
+struct sev_data_tio_tdi_reclaim {
+	u32 length;				/* In */
+	u32 reserved;
+	struct sla_addr_t dev_ctx_sla;			/* In */
+	struct sla_addr_t tdi_ctx_sla;			/* In */
+	u64 reserved2;
+} __packed;
+
+/*
+ * struct sev_data_tio_tdi_bind - TIO_TDI_BIND command
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure defined in Chapter 2.
+ * @tdi_ctx_paddr: SPA of page donated by hypervisor
+ * @guest_ctx_paddr: SPA of guest context page
+ * @flags:
+ *  4 ALL_REQUEST_REDIRECT Requires ATS translated requests to route through
+ *                         the root complex. Must be 1.
+ *  3 BIND_P2P Enables direct P2P. Must be 0
+ *  2 LOCK_MSIX Lock the MSI-X table and PBA.
+ *  1 CACHE_LINE_SIZE Indicates the cache line size. 0 indicates 64B. 1 indicates 128B.
+ *                    Must be 0.
+ *  0 NO_FW_UPDATE Indicates that no firmware updates are allowed while the interface
+ *                 is locked.
+ * @mmio_reporting_offset: Offset added to the MMIO range addresses in the interface
+ *                         report.
+ * @guest_interface_id: Hypervisor provided identifier used by the guest to identify
+ *                      the TDI in guest messages
+ */
+struct sev_data_tio_tdi_bind {
+	u32 length;				/* In */
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;		/* In */
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 gctx_paddr;
+	u16 guest_device_id;
+	union {
+		u16 flags;
+		/* These are TDISP's LOCK_INTERFACE_REQUEST flags */
+		struct {
+			u16 no_fw_update:1;
+			u16 reservedf1:1;
+			u16 lock_msix:1;
+			u16 bind_p2p:1;
+			u16 all_request_redirect:1;
+		};
+	} tdisp_lock_if;
+	u16 run:1;
+	u16 reserved2:15;
+	u8 reserved3[2];
+} __packed;
+
+/*
+ * struct sev_data_tio_tdi_unbind - TIO_TDI_UNBIND command
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure defined in Chapter 2.
+ * @tdi_ctx_paddr: SPA of page donated by hypervisor
+ */
+struct sev_data_tio_tdi_unbind {
+	u32 length;				/* In */
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;		/* In */
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 gctx_paddr;			/* In */
+} __packed;
+
+/*
+ * struct sev_data_tio_tdi_report - TIO_TDI_REPORT command
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure defined in Chapter 2.
+ * @dev_ctx_sla: Scatter list address of the device context buffer
+ * @tdi_ctx_paddr: Scatter list address of a TDI context buffer
+ * @guest_ctx_paddr: System physical address of a guest context page
+ */
+struct sev_data_tio_tdi_report {
+	u32 length;
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 gctx_paddr;
+} __packed;
+
+struct sev_data_tio_asid_fence_clear {
+	u32 length;				/* In */
+	u32 reserved1;
+	u64 gctx_paddr;			/* In */
+	u16 device_id;
+	u8 segment_id;
+	u8 reserved[13];
+} __packed;
+
+struct sev_data_tio_asid_fence_status {
+	u32 length;				/* In */
+	u32 asid;				/* In */
+	u64 status_pa;
+	u16 device_id;
+	u8 segment_id;
+	u8 reserved[13];
+} __packed;
+
+/**
+ * struct sev_data_tio_guest_request - TIO_GUEST_REQUEST command
+ *
+ * @length: Length in bytes of this command buffer
+ * @spdm_ctrl: SPDM control structure defined in Chapter 2.
+ * @gctx_paddr: system physical address of guest context page
+ * @tdi_ctx_paddr: SPA of page donated by hypervisor
+ * @req_paddr: system physical address of request page
+ * @res_paddr: system physical address of response page
+ */
+struct sev_data_tio_guest_request {
+	u32 length;				/* In */
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;		/* In */
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 gctx_paddr;
+	u64 req_paddr;				/* In */
+	u64 res_paddr;				/* In */
+} __packed;
+
+struct sev_data_tio_roll_key {
+	u32 length;				/* In */
+	u32 reserved;
+	struct spdm_ctrl spdm_ctrl;		/* In */
+	struct sla_addr_t dev_ctx_sla;			/* In */
+} __packed;
+
+static struct sla_buffer_hdr *sla_buffer_map(struct sla_addr_t sla)
+{
+	struct sla_buffer_hdr *buf;
+
+	BUILD_BUG_ON(sizeof(struct sla_buffer_hdr) != 0x40);
+	if (IS_SLA_NULL(sla))
+		return NULL;
+
+	if (sla.page_type == SLA_PAGE_TYPE_SCATTER) {
+		struct sla_addr_t *scatter = __va((u64)sla.pfn << PAGE_SHIFT);
+		unsigned int i, npages = 0;
+		struct page **pp;
+
+		for (i = 0; i < SLA_SCATTER_LEN(sla); ++i) {
+			if (WARN_ON_ONCE(SLA_SZ(scatter[i]) > SZ_4K))
+				return NULL;
+
+			if (WARN_ON_ONCE(scatter[i].page_type == SLA_PAGE_TYPE_SCATTER))
+				return NULL;
+
+			if (IS_SLA_EOL(scatter[i])) {
+				npages = i;
+				break;
+			}
+		}
+		if (WARN_ON_ONCE(!npages))
+			return NULL;
+
+		pp = kmalloc_array(npages, sizeof(pp[0]), GFP_KERNEL);
+		if (!pp)
+			return NULL;
+
+		for (i = 0; i < npages; ++i)
+			pp[i] = pfn_to_page(scatter[i].pfn);
+
+		buf = vm_map_ram(pp, npages, 0);
+		kfree(pp);
+	} else {
+		struct page *pg = pfn_to_page(sla.pfn);
+
+		buf = vm_map_ram(&pg, 1, 0);
+	}
+
+	return buf;
+}
+
+static void sla_buffer_unmap(struct sla_addr_t sla, struct sla_buffer_hdr *buf)
+{
+	if (!buf)
+		return;
+
+	if (sla.page_type == SLA_PAGE_TYPE_SCATTER) {
+		struct sla_addr_t *scatter = __va((u64)sla.pfn << PAGE_SHIFT);
+		unsigned int i, npages = 0;
+
+		for (i = 0; i < SLA_SCATTER_LEN(sla); ++i) {
+			if (IS_SLA_EOL(scatter[i])) {
+				npages = i;
+				break;
+			}
+		}
+		if (!npages)
+			return;
+
+		vm_unmap_ram(buf, npages);
+	} else {
+		vm_unmap_ram(buf, 1);
+	}
+}
+
+static void dobj_response_init(struct sla_buffer_hdr *buf)
+{
+	struct spdm_dobj_hdr *dobj = sla_to_dobj_hdr(buf);
+
+	dobj->id = SPDM_DOBJ_ID_RESP;
+	dobj->version.major = 0x1;
+	dobj->version.minor = 0;
+	dobj->length = 0;
+	buf->payload_sz = sla_dobj_id_to_size(dobj->id) + dobj->length;
+}
+
+static void sla_free(struct sla_addr_t sla, size_t len, bool firmware_state)
+{
+	unsigned int npages = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	struct sla_addr_t *scatter = NULL;
+	int ret = 0, i;
+
+	if (IS_SLA_NULL(sla))
+		return;
+
+	if (firmware_state) {
+		if (sla.page_type == SLA_PAGE_TYPE_SCATTER) {
+			scatter = __va((u64)sla.pfn << PAGE_SHIFT);
+
+			for (i = 0; i < npages; ++i) {
+				if (IS_SLA_EOL(scatter[i]))
+					break;
+
+				ret = snp_reclaim_pages(
+					(u64)scatter[i].pfn << PAGE_SHIFT,
+					1, false);
+				if (ret)
+					break;
+			}
+		} else {
+			pr_err("Reclaiming %llx\n", (u64)sla.pfn << PAGE_SHIFT);
+			ret = snp_reclaim_pages((u64)sla.pfn << PAGE_SHIFT, 1, false);
+		}
+	}
+
+	if (WARN_ON(ret))
+		return;
+
+	if (scatter) {
+		for (i = 0; i < npages; ++i) {
+			if (IS_SLA_EOL(scatter[i]))
+				break;
+			free_page((unsigned long)__va((u64)scatter[i].pfn << PAGE_SHIFT));
+		}
+	}
+
+	free_page((unsigned long)__va((u64)sla.pfn << PAGE_SHIFT));
+}
+
+static struct sla_addr_t sla_alloc(size_t len, bool firmware_state)
+{
+	unsigned long i, npages = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	struct sla_addr_t *scatter = NULL;
+	struct sla_addr_t ret = SLA_NULL;
+	struct sla_buffer_hdr *buf;
+	struct page *pg;
+
+	if (npages == 0)
+		return ret;
+
+	if (WARN_ON_ONCE(npages > ((PAGE_SIZE / sizeof(struct sla_addr_t)) + 1)))
+		return ret;
+
+	BUILD_BUG_ON(PAGE_SIZE < SZ_4K);
+
+	if (npages > 1) {
+		pg = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!pg)
+			return SLA_NULL;
+
+		ret.pfn = page_to_pfn(pg);
+		ret.page_size = SLA_PAGE_SIZE_4K;
+		ret.page_type = SLA_PAGE_TYPE_SCATTER;
+
+		scatter = page_to_virt(pg);
+		for (i = 0; i < npages; ++i) {
+			pg = alloc_page(GFP_KERNEL | __GFP_ZERO);
+			if (!pg)
+				goto no_reclaim_exit;
+
+			scatter[i].pfn = page_to_pfn(pg);
+			scatter[i].page_type = SLA_PAGE_TYPE_DATA;
+			scatter[i].page_size = SLA_PAGE_SIZE_4K;
+		}
+		scatter[i] = SLA_EOL;
+	} else {
+		pg = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!pg)
+			return SLA_NULL;
+
+		ret.pfn = page_to_pfn(pg);
+		ret.page_size = SLA_PAGE_SIZE_4K;
+		ret.page_type = SLA_PAGE_TYPE_DATA;
+	}
+
+	buf = sla_buffer_map(ret);
+	if (!buf)
+		goto no_reclaim_exit;
+
+	buf->capacity_sz = (npages << PAGE_SHIFT);
+	sla_buffer_unmap(ret, buf);
+
+	if (firmware_state) {
+		if (scatter) {
+			for (i = 0; i < npages; ++i) {
+				if (rmp_make_private(scatter[i].pfn, 0, PG_LEVEL_4K, 0, true))
+					goto free_exit;
+			}
+		} else {
+			if (rmp_make_private(ret.pfn, 0, PG_LEVEL_4K, 0, true))
+				goto no_reclaim_exit;
+		}
+	}
+
+	return ret;
+
+no_reclaim_exit:
+	firmware_state = false;
+free_exit:
+	sla_free(ret, len, firmware_state);
+	return SLA_NULL;
+}
+
+/* Expands a buffer, only firmware owned buffers allowed for now */
+static int sla_expand(struct sla_addr_t *sla, size_t *len)
+{
+	struct sla_buffer_hdr *oldbuf = sla_buffer_map(*sla), *newbuf;
+	struct sla_addr_t oldsla = *sla, newsla;
+	size_t oldlen = *len, newlen;
+
+	if (!oldbuf)
+		return -EFAULT;
+
+	newlen = oldbuf->capacity_sz;
+	if (oldbuf->capacity_sz == oldlen) {
+		/* This buffer does not require expansion, must be another buffer */
+		sla_buffer_unmap(oldsla, oldbuf);
+		return 1;
+	}
+
+	pr_notice("Expanding BUFFER from %ld to %ld bytes\n", oldlen, newlen);
+
+	newsla = sla_alloc(newlen, true);
+	if (IS_SLA_NULL(newsla))
+		return -ENOMEM;
+
+	newbuf = sla_buffer_map(newsla);
+	if (!newbuf) {
+		sla_free(newsla, newlen, true);
+		return -EFAULT;
+	}
+
+	memcpy(newbuf, oldbuf, oldlen);
+
+	sla_buffer_unmap(newsla, newbuf);
+	sla_free(oldsla, oldlen, true);
+	*sla = newsla;
+	*len = newlen;
+
+	return 0;
+}
+
+void tio_save_output(struct tsm_blob **blob, struct sla_addr_t sla, u32 check_dobjid)
+{
+	struct sla_buffer_hdr *buf;
+	struct spdm_dobj_hdr *hdr;
+
+	tsm_blob_free(*blob);
+	*blob = NULL;
+
+	buf = sla_buffer_map(sla);
+	if (!buf)
+		return;
+
+	hdr = sla_to_dobj_hdr_check(buf, check_dobjid);
+	if (hdr)
+		*blob = tsm_blob_new(SPDM_DOBJ_DATA(hdr), hdr->length);
+
+	sla_buffer_unmap(sla, buf);
+}
+
+static int sev_tio_do_cmd(int cmd, void *data, size_t data_len, int *psp_ret,
+			  struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	int rc;
+
+	*psp_ret = 0;
+	rc = sev_do_cmd(cmd, data, psp_ret);
+
+	if (WARN_ON(!spdm && !rc && *psp_ret == SEV_RET_SPDM_REQUEST))
+		return -EIO;
+
+	if (rc == 0 && *psp_ret == SEV_RET_EXPAND_BUFFER_LENGTH_REQUEST) {
+		int rc1, rc2;
+
+		rc1 = sla_expand(&dev_data->output, &dev_data->output_len);
+		if (rc1 < 0)
+			return rc1;
+
+		rc2 = sla_expand(&dev_data->scratch, &dev_data->scratch_len);
+		if (rc2 < 0)
+			return rc2;
+
+		if (!rc1 && !rc2)
+			/* Neither buffer requires expansion, this is wrong */
+			return -EFAULT;
+
+		*psp_ret = 0;
+		rc = sev_do_cmd(cmd, data, psp_ret);
+	}
+
+	if (spdm && (rc == 0 || rc == -EIO) && *psp_ret == SEV_RET_SPDM_REQUEST) {
+		struct spdm_dobj_hdr_resp *resp_hdr;
+		struct spdm_dobj_hdr_req *req_hdr;
+		size_t resp_len = dev_data->tio_status->spdm_req_size_max -
+			(sla_dobj_id_to_size(SPDM_DOBJ_ID_RESP) + sizeof(struct sla_buffer_hdr));
+
+		if (!dev_data->cmd) {
+			if (WARN_ON_ONCE(!data_len || (data_len != *(u32 *) data)))
+				return -EINVAL;
+			if (WARN_ON(data_len > sizeof(dev_data->cmd_data)))
+				return -EFAULT;
+			memcpy(dev_data->cmd_data, data, data_len);
+			memset(&dev_data->cmd_data[data_len], 0xFF,
+			       sizeof(dev_data->cmd_data) - data_len);
+			dev_data->cmd = cmd;
+		}
+
+		req_hdr = sla_to_dobj_req_hdr(dev_data->reqbuf);
+		resp_hdr = sla_to_dobj_resp_hdr(dev_data->respbuf);
+		switch (req_hdr->data_type) {
+		case DOBJ_DATA_TYPE_SPDM:
+			rc = TSM_PROTO_CMA_SPDM;
+			break;
+		case DOBJ_DATA_TYPE_SECURE_SPDM:
+			rc = TSM_PROTO_SECURED_CMA_SPDM;
+			break;
+		default:
+			rc = -EINVAL;
+			return rc;
+		}
+		resp_hdr->data_type = req_hdr->data_type;
+		spdm->req_len = req_hdr->hdr.length;
+		spdm->rsp_len = resp_len;
+	} else if (dev_data && dev_data->cmd) {
+		/* For either error or success just stop the bouncing */
+		memset(dev_data->cmd_data, 0, sizeof(dev_data->cmd_data));
+		dev_data->cmd = 0;
+	}
+
+	return rc;
+}
+
+int sev_tio_continue(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct spdm_dobj_hdr_resp *resp_hdr;
+	int ret;
+
+	if (!dev_data || !dev_data->cmd)
+		return -EINVAL;
+
+	resp_hdr = sla_to_dobj_resp_hdr(dev_data->respbuf);
+	resp_hdr->hdr.length = ALIGN(sla_dobj_id_to_size(SPDM_DOBJ_ID_RESP) + spdm->rsp_len, 32);
+	dev_data->respbuf->payload_sz = resp_hdr->hdr.length;
+
+	ret = sev_tio_do_cmd(dev_data->cmd, dev_data->cmd_data, 0,
+			     &dev_data->psp_ret, dev_data, spdm);
+
+	return ret;
+}
+
+static int spdm_ctrl_init(struct tsm_spdm *spdm, struct spdm_ctrl *ctrl,
+			  struct tsm_dev_tio *dev_data)
+{
+	ctrl->req = dev_data->req;
+	ctrl->resp = dev_data->resp;
+	ctrl->scratch = dev_data->scratch;
+	ctrl->output = dev_data->output;
+
+	spdm->req = sla_to_data(dev_data->reqbuf, SPDM_DOBJ_ID_REQ);
+	spdm->rsp = sla_to_data(dev_data->respbuf, SPDM_DOBJ_ID_RESP);
+	if (!spdm->req || !spdm->rsp)
+		return -EFAULT;
+
+	return 0;
+}
+
+static void spdm_ctrl_free(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	size_t len = dev_data->tio_status->spdm_req_size_max -
+		(sla_dobj_id_to_size(SPDM_DOBJ_ID_RESP) +
+		 sizeof(struct sla_buffer_hdr));
+
+	sla_buffer_unmap(dev_data->resp, dev_data->respbuf);
+	sla_buffer_unmap(dev_data->req, dev_data->reqbuf);
+	spdm->rsp = NULL;
+	spdm->req = NULL;
+	sla_free(dev_data->req, len, true);
+	sla_free(dev_data->resp, len, false);
+	sla_free(dev_data->scratch, dev_data->tio_status->spdm_scratch_size_max, true);
+
+	dev_data->req.sla = 0;
+	dev_data->resp.sla = 0;
+	dev_data->scratch.sla = 0;
+	dev_data->respbuf = NULL;
+	dev_data->reqbuf = NULL;
+	sla_free(dev_data->output, dev_data->tio_status->spdm_out_size_max, true);
+}
+
+static int spdm_ctrl_alloc(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct sev_tio_status *tio_status = dev_data->tio_status;
+	int ret;
+
+	dev_data->req = sla_alloc(tio_status->spdm_req_size_max, true);
+	dev_data->resp = sla_alloc(tio_status->spdm_req_size_max, false);
+	dev_data->scratch_len = tio_status->spdm_scratch_size_max;
+	dev_data->scratch = sla_alloc(dev_data->scratch_len, true);
+	dev_data->output_len = tio_status->spdm_out_size_max;
+	dev_data->output = sla_alloc(dev_data->output_len, true);
+
+	if (IS_SLA_NULL(dev_data->req) || IS_SLA_NULL(dev_data->resp) ||
+	    IS_SLA_NULL(dev_data->scratch) || IS_SLA_NULL(dev_data->dev_ctx)) {
+		ret = -ENOMEM;
+		goto free_spdm_exit;
+	}
+
+	dev_data->reqbuf = sla_buffer_map(dev_data->req);
+	dev_data->respbuf = sla_buffer_map(dev_data->resp);
+	if (!dev_data->reqbuf || !dev_data->respbuf) {
+		ret = -EFAULT;
+		goto free_spdm_exit;
+	}
+
+	dobj_response_init(dev_data->respbuf);
+
+	return 0;
+
+free_spdm_exit:
+	spdm_ctrl_free(dev_data, spdm);
+	return ret;
+}
+
+int sev_tio_status(struct sev_device *sev)
+{
+	struct sev_data_tio_status data_status = {
+		.length = sizeof(data_status),
+	};
+	struct sev_tio_status *tio_status;
+	int ret = 0, psp_ret = 0;
+
+	if (!sev_version_greater_or_equal(1, 55))
+		return -EPERM;
+
+	WARN_ON(tio_status);
+
+	tio_status = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!tio_status)
+		return -ENOMEM;
+
+	data_status.status_paddr = __psp_pa(tio_status);
+	ret = sev_do_cmd(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
+	if (ret)
+		goto err_msg_exit;
+
+	if (tio_status->flags & 0xFFFFFF00) {
+		ret = -EFAULT;
+		goto err_msg_exit;
+	}
+
+	if (!tio_status->tio_en && !tio_status->tio_init_done) {
+		ret = -ENOENT;
+		goto err_msg_exit;
+	}
+
+	if (tio_status->tio_en && !tio_status->tio_init_done) {
+		struct sev_data_tio_init ti = { .length = sizeof(ti) };
+
+		ret = sev_do_cmd(SEV_CMD_TIO_INIT, &ti, &psp_ret);
+		if (ret)
+			goto err_msg_exit;
+
+		ret = sev_do_cmd(SEV_CMD_TIO_STATUS, &data_status, &psp_ret);
+		if (ret)
+			goto err_msg_exit;
+
+		print_hex_dump(KERN_INFO, "TIO_ST ", DUMP_PREFIX_OFFSET, 16, 1, tio_status,
+			       sizeof(*tio_status), false);
+	}
+
+	sev->tio_status = kmemdup(tio_status, sizeof(*tio_status), GFP_KERNEL);
+	if (!sev->tio_status) {
+		ret = -ENOMEM;
+		goto err_msg_exit;
+	}
+
+	pr_notice("SEV-TIO status: EN=%d INIT_DONE=%d rq=%d..%d rs=%d..%d scr=%d..%d out=%d..%d dev=%d tdi=%d\n",
+		  tio_status->tio_en, tio_status->tio_init_done,
+		  tio_status->spdm_req_size_min, tio_status->spdm_req_size_max,
+		  tio_status->spdm_rsp_size_min, tio_status->spdm_rsp_size_max,
+		  tio_status->spdm_scratch_size_min, tio_status->spdm_scratch_size_max,
+		  tio_status->spdm_out_size_min, tio_status->spdm_out_size_max,
+		  tio_status->devctx_size, tio_status->tdictx_size);
+
+	goto free_exit;
+
+err_msg_exit:
+	pr_err("Failed to enable SEV-TIO: ret=%d en=%d initdone=%d SEV=%d\n",
+	       ret, tio_status->tio_en, tio_status->tio_init_done,
+	       boot_cpu_has(X86_FEATURE_SEV));
+	pr_err("Check BIOS for: SMEE, SEV Control, SEV-ES ASID Space Limit=99,\n"
+	       "SNP Memory (RMP Table) Coverage, RMP Coverage for 64Bit MMIO Ranges\n"
+	       "SEV-SNP Support, SEV-TIO Support, PCIE IDE Capability\n");
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		pr_err("mem_encrypt=on is currently broken\n");
+
+free_exit:
+	snp_free_firmware_page(tio_status);
+	return ret;
+}
+
+int sev_tio_dev_create(struct tsm_dev_tio *dev_data, u16 device_id,
+		       u16 root_port_id, u8 segment_id)
+{
+	struct sev_tio_status *tio_status = dev_data->tio_status;
+	struct sev_data_tio_dev_create create = {
+		.length = sizeof(create),
+		.device_id = device_id,
+		.root_port_id = root_port_id,
+		.segment_id = segment_id,
+	};
+	void *data_pg;
+	int ret;
+
+	dev_data->dev_ctx = sla_alloc(tio_status->devctx_size, true);
+	if (IS_SLA_NULL(dev_data->dev_ctx))
+		return -ENOMEM;
+
+	/* Alloc data page for TDI_STATUS, TDI_INFO, the PSP or prep_data_pg() will zero it */
+	data_pg = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
+	if (!data_pg) {
+		ret = -ENOMEM;
+		goto free_ctx_exit;
+	}
+
+	create.dev_ctx_sla = dev_data->dev_ctx;
+	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CREATE, &create, sizeof(create),
+			     &dev_data->psp_ret, dev_data, NULL);
+	if (ret)
+		goto free_data_pg_exit;
+
+	dev_data->data_pg = data_pg;
+
+	return ret;
+
+free_data_pg_exit:
+	snp_free_firmware_page(data_pg);
+free_ctx_exit:
+	sla_free(create.dev_ctx_sla, tio_status->devctx_size, true);
+	return ret;
+}
+
+int sev_tio_dev_reclaim(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct sev_tio_status *tio_status = dev_data->tio_status;
+	struct sev_data_tio_dev_reclaim r = {
+		.length = sizeof(r),
+		.dev_ctx_sla = dev_data->dev_ctx,
+	};
+	int ret;
+
+	if (dev_data->data_pg) {
+		snp_free_firmware_page(dev_data->data_pg);
+		dev_data->data_pg = NULL;
+	}
+
+	if (IS_SLA_NULL(dev_data->dev_ctx))
+		return 0;
+
+	ret = sev_do_cmd(SEV_CMD_TIO_DEV_RECLAIM, &r, &dev_data->psp_ret);
+
+	sla_free(dev_data->dev_ctx, tio_status->devctx_size, true);
+	dev_data->dev_ctx = SLA_NULL;
+
+	spdm_ctrl_free(dev_data, spdm);
+
+	return ret;
+}
+
+int sev_tio_dev_connect(struct tsm_dev_tio *dev_data, u8 tc_mask, u8 ids[8], u8 cert_slot,
+			struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_dev_connect connect = {
+		.length = sizeof(connect),
+		.tc_mask = tc_mask,
+		.cert_slot = cert_slot,
+		.dev_ctx_sla = dev_data->dev_ctx,
+		.ide_stream_id = {
+			ids[0], ids[1], ids[2], ids[3],
+			ids[4], ids[5], ids[6], ids[7]
+		},
+	};
+	int ret;
+
+	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
+		return -EFAULT;
+	if (!(tc_mask & 1))
+		return -EINVAL;
+
+	ret = spdm_ctrl_alloc(dev_data, spdm);
+	if (ret)
+		return ret;
+	ret = spdm_ctrl_init(spdm, &connect.spdm_ctrl, dev_data);
+	if (ret)
+		return ret;
+
+	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_CONNECT, &connect, sizeof(connect),
+			     &dev_data->psp_ret, dev_data, spdm);
+
+	return ret;
+}
+
+int sev_tio_dev_disconnect(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_dev_disconnect dc = {
+		.length = sizeof(dc),
+		.dev_ctx_sla = dev_data->dev_ctx,
+	};
+	int ret;
+
+	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx)))
+		return -EFAULT;
+
+	ret = spdm_ctrl_init(spdm, &dc.spdm_ctrl, dev_data);
+	if (ret)
+		return ret;
+
+	ret = sev_tio_do_cmd(SEV_CMD_TIO_DEV_DISCONNECT, &dc, sizeof(dc),
+			     &dev_data->psp_ret, dev_data, spdm);
+
+	return ret;
+}
+
+int sev_tio_dev_measurements(struct tsm_dev_tio *dev_data, void *nonce, size_t nonce_len,
+			     struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_dev_meas meas = {
+		.length = sizeof(meas),
+		.raw_bitstream = 1,
+	};
+
+	if (nonce_len > sizeof(meas.meas_nonce))
+		return -EINVAL;
+
+	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
+		return -EFAULT;
+
+	spdm_ctrl_init(spdm, &meas.spdm_ctrl, dev_data);
+	meas.dev_ctx_sla = dev_data->dev_ctx;
+	memcpy(meas.meas_nonce, nonce, nonce_len);
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_DEV_MEASUREMENTS, &meas, sizeof(meas),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+int sev_tio_dev_certificates(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_dev_certs c = {
+		.length = sizeof(c),
+	};
+
+	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
+		return -EFAULT;
+
+	spdm_ctrl_init(spdm, &c.spdm_ctrl, dev_data);
+	c.dev_ctx_sla = dev_data->dev_ctx;
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_DEV_CERTIFICATES, &c, sizeof(c),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+int sev_tio_dev_status(struct tsm_dev_tio *dev_data, struct tsm_dev_status *s)
+{
+	struct sev_tio_dev_status *status =
+		prep_data_pg(struct sev_tio_dev_status, dev_data);
+	struct sev_data_tio_dev_status data_status = {
+		.length = sizeof(data_status),
+		.dev_ctx_paddr = dev_data->dev_ctx,
+		.status_length = sizeof(*status),
+		.status_paddr = __psp_pa(status),
+	};
+	int ret;
+
+	if (!dev_data)
+		return -ENODEV;
+
+	if (IS_SLA_NULL(dev_data->dev_ctx))
+		return -ENXIO;
+
+	ret = sev_do_cmd(SEV_CMD_TIO_DEV_STATUS, &data_status, &dev_data->psp_ret);
+	if (ret)
+		return ret;
+
+	s->ctx_state = status->ctx_state;
+	s->device_id = status->device_id;
+	s->tc_mask = status->tc_mask;
+	memcpy(s->ide_stream_id, status->ide_stream_id, sizeof(status->ide_stream_id));
+	s->certs_slot = status->certs_slot;
+	s->no_fw_update = status->no_fw_update;
+
+	return 0;
+}
+
+int sev_tio_ide_refresh(struct tsm_dev_tio *dev_data, struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_roll_key rk = {
+		.length = sizeof(rk),
+		.dev_ctx_sla = dev_data->dev_ctx,
+	};
+	int ret;
+
+	if (WARN_ON(IS_SLA_NULL(dev_data->dev_ctx)))
+		return -EFAULT;
+
+	ret = spdm_ctrl_init(spdm, &rk.spdm_ctrl, dev_data);
+	if (ret)
+		return ret;
+
+	ret = sev_tio_do_cmd(SEV_CMD_TIO_ROLL_KEY, &rk, sizeof(rk),
+			     &dev_data->psp_ret, dev_data, spdm);
+
+	return ret;
+}
+
+int sev_tio_tdi_create(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data, u16 dev_id,
+		       u8 rseg, u8 rseg_valid)
+{
+	struct sev_tio_status *tio_status = dev_data->tio_status;
+	struct sev_data_tio_tdi_create c = {
+		.length = sizeof(c),
+	};
+	int ret;
+
+	if (!dev_data || !tdi_data) /* Device is not "connected" */
+		return -EPERM;
+
+	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx) || !IS_SLA_NULL(tdi_data->tdi_ctx)))
+		return -EFAULT;
+
+	tdi_data->tdi_ctx = sla_alloc(tio_status->tdictx_size, true);
+	if (IS_SLA_NULL(tdi_data->tdi_ctx))
+		return -ENOMEM;
+
+	c.dev_ctx_sla = dev_data->dev_ctx;
+	c.tdi_ctx_sla = tdi_data->tdi_ctx;
+	c.interface_id.function_id =
+		FIELD_PREP(TSM_TDISP_IID_REQUESTER_ID, dev_id) |
+		FIELD_PREP(TSM_TDISP_IID_RSEG, rseg) |
+		FIELD_PREP(TSM_TDISP_IID_RSEG_VALID, rseg_valid);
+
+	ret = sev_do_cmd(SEV_CMD_TIO_TDI_CREATE, &c, &dev_data->psp_ret);
+	if (ret)
+		goto free_exit;
+
+	return 0;
+
+free_exit:
+	sla_free(tdi_data->tdi_ctx, tio_status->tdictx_size, true);
+	tdi_data->tdi_ctx = SLA_NULL;
+	return ret;
+}
+
+void sev_tio_tdi_reclaim(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data)
+{
+	struct sev_tio_status *tio_status = dev_data->tio_status;
+	struct sev_data_tio_tdi_reclaim r = {
+		.length = sizeof(r),
+	};
+
+	if (WARN_ON(!dev_data || !tdi_data))
+		return;
+	if (IS_SLA_NULL(dev_data->dev_ctx) || IS_SLA_NULL(tdi_data->tdi_ctx))
+		return;
+
+	r.dev_ctx_sla = dev_data->dev_ctx;
+	r.tdi_ctx_sla = tdi_data->tdi_ctx;
+
+	sev_do_cmd(SEV_CMD_TIO_TDI_RECLAIM, &r, &dev_data->psp_ret);
+
+	sla_free(tdi_data->tdi_ctx, tio_status->tdictx_size, true);
+	tdi_data->tdi_ctx = SLA_NULL;
+}
+
+int sev_tio_tdi_bind(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		     u32 guest_rid, u64 gctx_paddr, u32 asid, bool force_run,
+		     struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_tdi_bind b = {
+		.length = sizeof(b),
+	};
+
+	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx) || IS_SLA_NULL(tdi_data->tdi_ctx)))
+		return -EFAULT;
+
+	spdm_ctrl_init(spdm, &b.spdm_ctrl, dev_data);
+	b.dev_ctx_sla = dev_data->dev_ctx;
+	b.tdi_ctx_sla = tdi_data->tdi_ctx;
+	b.guest_device_id = guest_rid;
+	b.gctx_paddr = gctx_paddr;
+	b.run = force_run;
+
+	tdi_data->gctx_paddr = gctx_paddr;
+	tdi_data->asid = asid;
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_TDI_BIND, &b, sizeof(b),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+int sev_tio_tdi_unbind(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_tdi_unbind ub = {
+		.length = sizeof(ub),
+	};
+
+	if (WARN_ON(!tdi_data || !dev_data))
+		return 0;
+
+	if (WARN_ON(!tdi_data->gctx_paddr))
+		return -EFAULT;
+
+	spdm_ctrl_init(spdm, &ub.spdm_ctrl, dev_data);
+	ub.dev_ctx_sla = dev_data->dev_ctx;
+	ub.tdi_ctx_sla = tdi_data->tdi_ctx;
+	ub.gctx_paddr = tdi_data->gctx_paddr;
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_TDI_UNBIND, &ub, sizeof(ub),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+int sev_tio_tdi_report(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_tdi_report r = {
+		.length = sizeof(r),
+		.dev_ctx_sla = dev_data->dev_ctx,
+		.tdi_ctx_sla = tdi_data->tdi_ctx,
+		.gctx_paddr = tdi_data->gctx_paddr,
+	};
+
+	if (WARN_ON_ONCE(IS_SLA_NULL(dev_data->dev_ctx) || IS_SLA_NULL(tdi_data->tdi_ctx)))
+		return -EFAULT;
+
+	spdm_ctrl_init(spdm, &r.spdm_ctrl, dev_data);
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_TDI_REPORT, &r, sizeof(r),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+int sev_tio_asid_fence_clear(u16 device_id, u8 segment_id, u64 gctx_paddr, int *psp_ret)
+{
+	struct sev_data_tio_asid_fence_clear c = {
+		.length = sizeof(c),
+		.gctx_paddr = gctx_paddr,
+		.device_id = device_id,
+		.segment_id = segment_id,
+	};
+
+	return sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_CLEAR, &c, psp_ret);
+}
+
+int sev_tio_asid_fence_status(struct tsm_dev_tio *dev_data, u16 device_id, u8 segment_id,
+			      u32 asid, bool *fenced)
+{
+	u64 *status = prep_data_pg(u64, dev_data);
+	struct sev_data_tio_asid_fence_status s = {
+		.length = sizeof(s),
+		.asid = asid,
+		.status_pa = __psp_pa(status),
+		.device_id = device_id,
+		.segment_id = segment_id,
+	};
+	int ret;
+
+	ret = sev_do_cmd(SEV_CMD_TIO_ASID_FENCE_STATUS, &s, &dev_data->psp_ret);
+
+	if (ret == SEV_RET_SUCCESS) {
+		switch (*status) {
+		case 0:
+			*fenced = false;
+			break;
+		case 1:
+			*fenced = true;
+			break;
+		default:
+			pr_err("%04x:%x:%x.%d: undefined fence state %#llx\n",
+			       segment_id, PCI_BUS_NUM(device_id),
+			       PCI_SLOT(device_id), PCI_FUNC(device_id), *status);
+			*fenced = true;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int sev_tio_guest_request(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+			  void *req, void *res, struct tsm_spdm *spdm)
+{
+	struct sev_data_tio_guest_request gr = {
+		.length = sizeof(gr),
+		.dev_ctx_sla = dev_data->dev_ctx,
+		.tdi_ctx_sla = tdi_data->tdi_ctx,
+		.gctx_paddr = tdi_data->gctx_paddr,
+		.req_paddr = __psp_pa(req),
+		.res_paddr = __psp_pa(res),
+	};
+	int ret;
+
+	if (WARN_ON(!tdi_data || !dev_data))
+		return -EINVAL;
+
+	spdm_ctrl_init(spdm, &gr.spdm_ctrl, dev_data);
+
+	ret = sev_tio_do_cmd(SEV_CMD_TIO_GUEST_REQUEST, &gr, sizeof(gr),
+			     &dev_data->psp_ret, dev_data, spdm);
+
+	return ret;
+}
+
+struct sev_tio_tdi_info_data {
+	u32 length;
+	struct tdisp_interface_id interface_id;
+	union {
+		u32 p1;
+		struct {
+			u32 meas_digest_valid:1;
+			u32 meas_digest_fresh:1;
+			u32 tdi_status:2; /* 0: TDI_UNBOUND 1: TDI_BIND_LOCKED 2: TDI_BIND_RUN */
+		};
+	};
+	union {
+		u32 p2;
+		struct {
+			u32 no_fw_update:1;
+			u32 cache_line_size:1;
+			u32 lock_msix:1;
+			u32 bind_p2p:1;
+			u32 all_request_redirect:1;
+		};
+	};
+	u64 spdm_algos;
+	u8 certs_digest[48];
+	u8 meas_digest[48];
+	u8 interface_report_digest[48];
+	u64 intf_report_counter;
+	u32 asid; /* ASID of the guest that this device is assigned to. Valid if CTX_STATE=1 */
+	u8 reserved2[4];
+} __packed;
+
+struct sev_data_tio_tdi_info {
+	u32 length;
+	u32 reserved1;
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 status_paddr;
+	u8 reserved2[16];
+} __packed;
+
+int sev_tio_tdi_info(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		     struct tsm_tdi_status *ts)
+{
+	struct sev_tio_tdi_info_data *data =
+		prep_data_pg(struct sev_tio_tdi_info_data, dev_data);
+	struct sev_data_tio_tdi_info info = {
+		.length = sizeof(info),
+		.dev_ctx_sla = dev_data->dev_ctx,
+		.tdi_ctx_sla = tdi_data->tdi_ctx,
+		.status_paddr = __psp_pa(data),
+	};
+	int ret;
+
+	if (IS_SLA_NULL(dev_data->dev_ctx) || IS_SLA_NULL(tdi_data->tdi_ctx))
+		return -ENXIO;
+
+	ret = sev_do_cmd(SEV_CMD_TIO_TDI_INFO, &info, &dev_data->psp_ret);
+	if (ret)
+		return ret;
+
+	ts->id = data->interface_id;
+	ts->meas_digest_valid = data->meas_digest_valid;
+	ts->meas_digest_fresh = data->meas_digest_fresh;
+	ts->no_fw_update = data->no_fw_update;
+	ts->cache_line_size = data->cache_line_size == 0 ? 64 : 128;
+	ts->lock_msix = data->lock_msix;
+	ts->bind_p2p = data->bind_p2p;
+	ts->all_request_redirect = data->all_request_redirect;
+
+#define __ALGO(x, n, y) \
+	((((x) & (0xFFULL << (n))) == TIO_SPDM_ALGOS_##y) ? \
+	 (1ULL << TSM_SPDM_ALGOS_##y) : 0)
+	ts->spdm_algos =
+		__ALGO(data->spdm_algos, 0, DHE_SECP256R1) |
+		__ALGO(data->spdm_algos, 0, DHE_SECP384R1) |
+		__ALGO(data->spdm_algos, 8, AEAD_AES_128_GCM) |
+		__ALGO(data->spdm_algos, 8, AEAD_AES_256_GCM) |
+		__ALGO(data->spdm_algos, 16, ASYM_TPM_ALG_RSASSA_3072) |
+		__ALGO(data->spdm_algos, 16, ASYM_TPM_ALG_ECDSA_ECC_NIST_P256) |
+		__ALGO(data->spdm_algos, 16, ASYM_TPM_ALG_ECDSA_ECC_NIST_P384) |
+		__ALGO(data->spdm_algos, 24, HASH_TPM_ALG_SHA_256) |
+		__ALGO(data->spdm_algos, 24, HASH_TPM_ALG_SHA_384) |
+		__ALGO(data->spdm_algos, 32, KEY_SCHED_SPDM_KEY_SCHEDULE);
+#undef __ALGO
+	memcpy(ts->certs_digest, data->certs_digest, sizeof(ts->certs_digest));
+	memcpy(ts->meas_digest, data->meas_digest, sizeof(ts->meas_digest));
+	memcpy(ts->interface_report_digest, data->interface_report_digest,
+	       sizeof(ts->interface_report_digest));
+	ts->intf_report_counter = data->intf_report_counter;
+	ts->valid = true;
+
+	return 0;
+}
+
+struct sev_tio_tdi_status_data {
+	u32 length;
+	u8 tdisp_state;
+	u8 reserved1[3];
+} __packed;
+
+struct sev_data_tio_tdi_status {
+	u32 length;
+	u32 reserved1;
+	struct spdm_ctrl spdm_ctrl;
+	struct sla_addr_t dev_ctx_sla;
+	struct sla_addr_t tdi_ctx_sla;
+	u64 status_paddr;
+} __packed;
+
+int sev_tio_tdi_status(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+		       struct tsm_spdm *spdm)
+{
+	struct sev_tio_tdi_status_data *data =
+		prep_data_pg(struct sev_tio_tdi_status_data, dev_data);
+	struct sev_data_tio_tdi_status status = {
+		.length = sizeof(status),
+		.dev_ctx_sla = dev_data->dev_ctx,
+		.tdi_ctx_sla = tdi_data->tdi_ctx,
+		.status_paddr = __psp_pa(data),
+	};
+
+	if (IS_SLA_NULL(dev_data->dev_ctx) || IS_SLA_NULL(tdi_data->tdi_ctx))
+		return -ENXIO;
+
+	spdm_ctrl_init(spdm, &status.spdm_ctrl, dev_data);
+
+	return sev_tio_do_cmd(SEV_CMD_TIO_TDI_STATUS, &status, sizeof(status),
+			      &dev_data->psp_ret, dev_data, spdm);
+}
+
+#define TIO_TDISP_STATE_CONFIG_UNLOCKED	0
+#define TIO_TDISP_STATE_CONFIG_LOCKED	1
+#define TIO_TDISP_STATE_RUN		2
+#define TIO_TDISP_STATE_ERROR		3
+
+int sev_tio_tdi_status_fin(struct tsm_dev_tio *dev_data, struct tsm_tdi_tio *tdi_data,
+			   enum tsm_tdisp_state *state)
+{
+	struct sev_tio_tdi_status_data *data = (struct sev_tio_tdi_status_data *) dev_data->data_pg;
+
+	switch (data->tdisp_state) {
+#define __TDISP_STATE(y) case TIO_TDISP_STATE_##y: *state = TDISP_STATE_##y; break
+	__TDISP_STATE(CONFIG_UNLOCKED);
+	__TDISP_STATE(CONFIG_LOCKED);
+	__TDISP_STATE(RUN);
+	__TDISP_STATE(ERROR);
+#undef __TDISP_STATE
+	}
+
+	return 0;
+}
+
+int sev_tio_cmd_buffer_len(int cmd)
+{
+	switch (cmd) {
+	case SEV_CMD_TIO_STATUS:		return sizeof(struct sev_data_tio_status);
+	case SEV_CMD_TIO_INIT:			return sizeof(struct sev_data_tio_init);
+	case SEV_CMD_TIO_DEV_CREATE:		return sizeof(struct sev_data_tio_dev_create);
+	case SEV_CMD_TIO_DEV_RECLAIM:		return sizeof(struct sev_data_tio_dev_reclaim);
+	case SEV_CMD_TIO_DEV_CONNECT:		return sizeof(struct sev_data_tio_dev_connect);
+	case SEV_CMD_TIO_DEV_DISCONNECT:	return sizeof(struct sev_data_tio_dev_disconnect);
+	case SEV_CMD_TIO_DEV_STATUS:		return sizeof(struct sev_data_tio_dev_status);
+	case SEV_CMD_TIO_DEV_MEASUREMENTS:	return sizeof(struct sev_data_tio_dev_meas);
+	case SEV_CMD_TIO_DEV_CERTIFICATES:	return sizeof(struct sev_data_tio_dev_certs);
+	case SEV_CMD_TIO_TDI_CREATE:		return sizeof(struct sev_data_tio_tdi_create);
+	case SEV_CMD_TIO_TDI_RECLAIM:		return sizeof(struct sev_data_tio_tdi_reclaim);
+	case SEV_CMD_TIO_TDI_BIND:		return sizeof(struct sev_data_tio_tdi_bind);
+	case SEV_CMD_TIO_TDI_UNBIND:		return sizeof(struct sev_data_tio_tdi_unbind);
+	case SEV_CMD_TIO_TDI_REPORT:		return sizeof(struct sev_data_tio_tdi_report);
+	case SEV_CMD_TIO_TDI_STATUS:		return sizeof(struct sev_data_tio_tdi_status);
+	case SEV_CMD_TIO_GUEST_REQUEST:		return sizeof(struct sev_data_tio_guest_request);
+	case SEV_CMD_TIO_ASID_FENCE_CLEAR:	return sizeof(struct sev_data_tio_asid_fence_clear);
+	case SEV_CMD_TIO_ASID_FENCE_STATUS: return sizeof(struct sev_data_tio_asid_fence_status);
+	case SEV_CMD_TIO_TDI_INFO:		return sizeof(struct sev_data_tio_tdi_info);
+	case SEV_CMD_TIO_ROLL_KEY:		return sizeof(struct sev_data_tio_roll_key);
+	default:				return 0;
+	}
+}
diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
new file mode 100644
index 000000000000..db34fce3126b
--- /dev/null
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -0,0 +1,709 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+// Interface to CCP/SEV-TIO for generic PCIe TDISP module
+
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/tsm.h>
+
+#include <asm/sev-common.h>
+#include <asm/sev.h>
+
+#include "psp-dev.h"
+#include "sev-dev.h"
+#include "sev-dev-tio.h"
+
+#define tdi_to_pci_dev(tdi) (to_pci_dev(tdi->dev.parent))
+
+static void pr_ide_state(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	u32 devst = 0xffffffff, rcst = 0xffffffff;
+	int ret = pci_ide_stream_state(pdev, ide, &devst, &rcst);
+
+	pci_notice(pdev, "%x%s <-> %s: %x%s ret=%d",
+		   devst,
+		   PCI_IDE_SEL_STS_STATUS(devst) == 2 ? "=SECURE" : "",
+		   pci_name(rp),
+		   rcst,
+		   PCI_IDE_SEL_STS_STATUS(rcst) == 2 ? "=SECURE" : "",
+		   ret);
+}
+
+static int mkret(int ret, struct tsm_dev_tio *dev_data)
+{
+	if (ret)
+		return ret;
+
+	if (dev_data->psp_ret == SEV_RET_SUCCESS)
+		return 0;
+
+	pr_err("PSP returned an error %d\n", dev_data->psp_ret);
+	return -EINVAL;
+}
+
+static int ide_refresh(struct tsm_dev *tdev)
+{
+	struct tsm_dev_tio *dev_data = tdev->data;
+	int ret;
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_ide_refresh(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_ROLL_KEY) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+	}
+
+	return ret;
+}
+
+static int dev_create(struct tsm_dev *tdev, void *private_data)
+{
+	struct pci_dev *pdev = to_pci_dev(tdev->physdev);
+	u8 segment_id = pdev->bus ? pci_domain_nr(pdev->bus) : 0;
+	struct pci_dev *rootport = pdev->bus->self;
+	struct sev_device *sev = private_data;
+	u16 device_id = pci_dev_id(pdev);
+	struct tsm_dev_tio *dev_data;
+	struct page *req_page;
+	u16 root_port_id;
+	u32 lnkcap = 0;
+	int ret;
+
+	if (pci_read_config_dword(rootport, pci_pcie_cap(rootport) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return -ENODEV;
+
+	root_port_id = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev_data->tio_status = sev->tio_status;
+
+	req_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!req_page) {
+		ret = -ENOMEM;
+		goto free_dev_data_exit;
+	}
+	dev_data->guest_req_buf = page_address(req_page);
+
+	dev_data->guest_resp_buf = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!dev_data->guest_resp_buf) {
+		ret = -EIO;
+		goto free_req_exit;
+	}
+
+	ret = sev_tio_dev_create(dev_data, device_id, root_port_id, segment_id);
+	if (ret)
+		goto free_resp_exit;
+
+	tdev->data = dev_data;
+
+	return 0;
+
+free_resp_exit:
+	snp_free_firmware_page(dev_data->guest_resp_buf);
+free_req_exit:
+	__free_page(req_page);
+free_dev_data_exit:
+	kfree(dev_data);
+	return ret;
+}
+
+static int dev_connect(struct tsm_dev *tdev, void *private_data)
+{
+	struct pci_dev *pdev = to_pci_dev(tdev->physdev);
+	struct tsm_dev_tio *dev_data = tdev->data;
+	u8 tc_mask = 1, ids[8] = { 0 };
+	int ret;
+
+	if (tdev->connected)
+		return ide_refresh(tdev);
+
+	if (!dev_data) {
+		struct pci_ide ide1 = { 0 };
+		struct pci_ide *ide = &ide1;
+
+		pci_ide_stream_probe(pdev, ide);
+		ide->stream_id = ids[0];
+		ide->nr_mem = 1;
+		ide->mem[0] = (struct range) { 0, 0xFFFFFFFFFFF00000ULL };
+		ide->dev_sel_ctl = FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, 1);
+		ide->rootport_sel_ctl = FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, 1);
+		ide->devid_start = 0;
+		ide->devid_end = 0xffff;
+		ide->rpid_start = 0;
+		ide->rpid_end = 0xffff;
+
+		ret = pci_ide_stream_setup(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
+		if (ret)
+			return ret;
+
+		pci_ide_enable_stream(pdev, ide);
+		pr_ide_state(pdev, ide);
+
+		ret = dev_create(tdev, private_data);
+		if (ret)
+			return ret;
+
+		dev_data = tdev->data;
+		dev_data->ide = *ide;
+	}
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_dev_connect(dev_data, tc_mask, ids, tdev->cert_slot, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			goto free_exit;
+
+		tio_save_output(&tdev->certs, dev_data->output, SPDM_DOBJ_ID_CERTIFICATE);
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_DEV_CONNECT) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			goto free_exit;
+
+		tio_save_output(&tdev->certs, dev_data->output, SPDM_DOBJ_ID_CERTIFICATE);
+	}
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_dev_measurements(dev_data, tdev->nonce, tdev->nonce_len, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0) {
+			pci_warn(pdev, "Reading measurements failed ret=%d\n", ret);
+			ret = 0;
+		} else {
+			tio_save_output(&tdev->meas, dev_data->output, SPDM_DOBJ_ID_MEASUREMENT);
+		}
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_DEV_MEASUREMENTS) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0) {
+			pci_warn(pdev, "Reading measurements failed ret=%d\n", ret);
+			ret = 0;
+		} else {
+			tio_save_output(&tdev->meas, dev_data->output, SPDM_DOBJ_ID_MEASUREMENT);
+		}
+	}
+#if 0
+	/* Uncomment to verify SEV_CMD_TIO_DEV_CERTIFICATES work */
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_dev_certificates(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			goto free_exit;
+
+		tio_save_output(&tdev->certs, dev_data->output, SPDM_DOBJ_ID_CERTIFICATE);
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_DEV_CERTIFICATES) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			goto free_exit;
+
+		tio_save_output(&tdev->certs, dev_data->output, SPDM_DOBJ_ID_CERTIFICATE);
+	}
+#endif
+	ret = tsm_register_ide_stream(tdev, &dev_data->ide);
+	if (ret)
+		goto free_exit;
+
+	try_module_get(THIS_MODULE);
+	pr_ide_state(pdev, &dev_data->ide);
+	return 0;
+
+free_exit:
+	sev_tio_dev_reclaim(dev_data, &tdev->spdm);
+	kfree(dev_data);
+	tdev->data = NULL;
+	if (ret > 0)
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static int dev_disconnect(struct tsm_dev *tdev)
+{
+	struct tsm_dev_tio *dev_data = tdev->data;
+	int ret;
+
+	if (!dev_data)
+		return -ENODEV;
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_dev_disconnect(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+	} else if (dev_data->cmd == SEV_CMD_TIO_DEV_DISCONNECT) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(&tdev->dev, "Wrong state, cmd 0x%x in flight\n",
+			dev_data->cmd);
+	}
+
+	ret = sev_tio_dev_reclaim(dev_data, &tdev->spdm);
+	ret = mkret(ret, dev_data);
+
+	tsm_blob_free(tdev->meas);
+	tdev->meas = NULL;
+	tsm_blob_free(tdev->certs);
+	tdev->certs = NULL;
+	kfree(tdev->data);
+	tdev->data = NULL;
+
+	if (dev_data->guest_resp_buf)
+		snp_free_firmware_page(dev_data->guest_resp_buf);
+
+	if (dev_data->guest_req_buf)
+		__free_page(virt_to_page(dev_data->guest_req_buf));
+
+	dev_data->guest_req_buf = NULL;
+	dev_data->guest_resp_buf = NULL;
+
+	struct pci_dev *pdev = to_pci_dev(tdev->physdev);
+	struct pci_ide *ide = &dev_data->ide;
+
+	pr_ide_state(pdev, &dev_data->ide);
+	pci_ide_disable_stream(pdev, ide);
+	tsm_unregister_ide_stream(tdev, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pr_ide_state(pdev, &dev_data->ide);
+
+	module_put(THIS_MODULE);
+
+	return ret;
+}
+
+static int dev_status(struct tsm_dev *tdev, struct tsm_dev_status *s)
+{
+	struct tsm_dev_tio *dev_data = tdev->data;
+	int ret;
+
+	if (!dev_data)
+		return -ENODEV;
+
+	ret = sev_tio_dev_status(dev_data, s);
+	ret = mkret(ret, dev_data);
+	if (!ret)
+		WARN_ON(s->device_id != pci_dev_id(to_pci_dev(tdev->physdev)));
+
+	return ret;
+}
+
+static int dev_measurements(struct tsm_dev *tdev)
+{
+	struct tsm_dev_tio *dev_data = tdev->data;
+	int ret;
+
+	if (!dev_data)
+		return -ENODEV;
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_dev_measurements(dev_data, tdev->nonce, tdev->nonce_len, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			return ret;
+
+		tio_save_output(&tdev->meas, dev_data->output, SPDM_DOBJ_ID_MEASUREMENT);
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_DEV_MEASUREMENTS) {
+		ret = sev_tio_continue(dev_data, &tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		if (ret < 0)
+			return ret;
+
+		tio_save_output(&tdev->meas, dev_data->output, SPDM_DOBJ_ID_MEASUREMENT);
+	}
+
+	return 0;
+}
+
+static void tdi_share_mmio(struct pci_dev *pdev);
+
+static int tdi_unbind(struct tsm_tdi *tdi)
+{
+	struct tsm_dev_tio *dev_data;
+	int ret;
+
+	if (!tdi->data)
+		return -ENODEV;
+
+	dev_data = tdi->tdev->data;
+	if (tdi->kvm) {
+		if (dev_data->cmd == 0) {
+			ret = sev_tio_tdi_unbind(tdi->tdev->data, tdi->data, &tdi->tdev->spdm);
+			ret = mkret(ret, dev_data);
+			if (ret)
+				return ret;
+		} else if (dev_data->cmd == SEV_CMD_TIO_TDI_UNBIND) {
+			ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+			ret = mkret(ret, dev_data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* The hunk to verify transitioning to CONFIG_UNLOCKED */
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_tdi_status(tdi->tdev->data, tdi->data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+
+	} else if (dev_data->cmd == SEV_CMD_TIO_TDI_STATUS) {
+		enum tsm_tdisp_state state = TDISP_STATE_CONFIG_UNLOCKED;
+		static const char * const sstate[] = {
+			"CONFIG_UNLOCKED", "CONFIG_LOCKED", "RUN", "ERROR"};
+
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+
+		if (ret) {
+			dev_err(&tdi->dev, "TDI status failed to read, ret=%d\n", ret);
+		} else {
+			ret = sev_tio_tdi_status_fin(tdi->tdev->data, tdi->data, &state);
+			dev_notice(&tdi->dev, "TDI status %d=\"%s\"\n",
+				   state, state < ARRAY_SIZE(sstate) ? sstate[state] : sstate[0]);
+		}
+	}
+
+	/* Reclaim TDI if DEV is connected */
+	if (tdi->tdev->data) {
+		struct tsm_tdi_tio *tdi_data = tdi->data;
+		struct tsm_dev *tdev = tdi->tdev;
+		struct pci_dev *pdev = to_pci_dev(tdev->physdev);
+		struct pci_dev *rootport = pdev->bus->self;
+		u8 segment_id = pci_domain_nr(rootport->bus);
+		u16 device_id = pci_dev_id(rootport);
+		bool fenced = false;
+
+		sev_tio_tdi_reclaim(tdi->tdev->data, tdi->data);
+
+		if (!sev_tio_asid_fence_status(dev_data, device_id, segment_id,
+					       tdi_data->asid, &fenced)) {
+			if (fenced) {
+				ret = sev_tio_asid_fence_clear(device_id, segment_id,
+						tdi_data->gctx_paddr, &dev_data->psp_ret);
+				pci_notice(rootport, "Unfenced VM=%llx ASID=%d ret=%d %d",
+					   tdi_data->gctx_paddr, tdi_data->asid, ret,
+					   dev_data->psp_ret);
+			}
+		}
+
+		tsm_blob_free(tdi->report);
+		tdi->report = NULL;
+	}
+
+	pr_ide_state(to_pci_dev(tdi->tdev->physdev), &dev_data->ide);
+	kfree(tdi->data);
+	tdi->data = NULL;
+
+	tdi_share_mmio(tdi_to_pci_dev(tdi));
+
+	return 0;
+}
+
+static int tdi_create(struct tsm_tdi *tdi)
+{
+	struct tsm_tdi_tio *tdi_data = tdi->data;
+	int ret;
+
+	if (tdi_data)
+		return -EBUSY;
+
+	tdi_data = kzalloc(sizeof(*tdi_data), GFP_KERNEL);
+	if (!tdi_data)
+		return -ENOMEM;
+
+	ret = sev_tio_tdi_create(tdi->tdev->data, tdi_data, pci_dev_id(tdi_to_pci_dev(tdi)),
+				 tdi->rseg, tdi->rseg_valid);
+	if (ret)
+		kfree(tdi_data);
+	else
+		tdi->data = tdi_data;
+
+	return ret;
+}
+
+static int tdi_bind(struct tsm_tdi *tdi, u32 bdfn, u64 vmid)
+{
+	enum tsm_tdisp_state state = TDISP_STATE_CONFIG_UNLOCKED;
+	struct tsm_dev_tio *dev_data = tdi->tdev->data;
+	u64 gctx = __psp_pa(vmid & PAGE_MASK); /* see SVM's sev_tio_vmid() */
+	u32 asid = vmid & ~PAGE_MASK;
+	int ret = 0;
+
+	if (dev_data->cmd == SEV_CMD_TIO_TDI_UNBIND) {
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		return mkret(ret, dev_data);
+	}
+
+	if (!tdi->data) {
+		ret = tdi_create(tdi);
+		if (ret)
+			return ret;
+	}
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_tdi_bind(dev_data, tdi->data, bdfn, gctx, asid,
+				       false, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret < 0) {
+			ret = sev_tio_tdi_bind(dev_data, tdi->data, bdfn, gctx, asid,
+					       true, &tdi->tdev->spdm);
+			ret = mkret(ret, dev_data);
+		}
+		if (ret < 0)
+			goto error_exit;
+		if (ret)
+			return ret;
+
+		tio_save_output(&tdi->report, dev_data->output, SPDM_DOBJ_ID_REPORT);
+	}
+
+	if (dev_data->cmd == SEV_CMD_TIO_TDI_BIND) {
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret < 0)
+			goto error_exit;
+		if (ret)
+			return ret;
+
+		tio_save_output(&tdi->report, dev_data->output, SPDM_DOBJ_ID_REPORT);
+	}
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_tdi_status(tdi->tdev->data, tdi->data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+
+		ret = sev_tio_tdi_status_fin(tdi->tdev->data, tdi->data, &state);
+	} else if (dev_data->cmd == SEV_CMD_TIO_TDI_STATUS) {
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+
+		ret = sev_tio_tdi_status_fin(tdi->tdev->data, tdi->data, &state);
+	}
+
+	if (ret < 0)
+		goto error_exit;
+	if (ret)
+		return ret;
+
+	if (dev_data->cmd == 0 && state == TDISP_STATE_CONFIG_LOCKED) {
+		ret = sev_tio_tdi_bind(dev_data, tdi->data, bdfn, gctx, asid,
+				       true, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret < 0)
+			goto error_exit;
+		if (ret)
+			return ret;
+
+		tio_save_output(&tdi->report, dev_data->output, SPDM_DOBJ_ID_REPORT);
+	}
+
+	pr_ide_state(to_pci_dev(tdi->tdev->physdev), &dev_data->ide);
+
+	return ret;
+
+error_exit:
+	return sev_tio_tdi_unbind(tdi->tdev->data, tdi->data, &tdi->tdev->spdm);
+}
+
+static int guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t reqlen,
+			 u8 __user *rsp, size_t rsplen, int *fw_err)
+{
+	struct tsm_dev_tio *dev_data = tdi->tdev->data;
+	int ret;
+
+	if (!tdi->data)
+		return -EFAULT;
+
+	if (dev_data->cmd == 0) {
+		ret = copy_from_user(dev_data->guest_req_buf, req, reqlen);
+		if (ret)
+			return ret;
+
+		ret = sev_tio_guest_request(dev_data, tdi->data, dev_data->guest_req_buf,
+					    dev_data->guest_resp_buf, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		*fw_err = dev_data->psp_ret;
+		ret = copy_to_user(rsp, dev_data->guest_resp_buf, rsplen);
+
+	} else if (dev_data->cmd == SEV_CMD_TIO_GUEST_REQUEST) {
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret > 0)
+			return ret;
+		*fw_err = dev_data->psp_ret;
+		ret = copy_to_user(rsp, dev_data->guest_resp_buf, rsplen);
+	}
+
+	return ret;
+}
+
+static int tdi_status(struct tsm_tdi *tdi, struct tsm_tdi_status *ts)
+{
+	struct tsm_dev_tio *dev_data = tdi->tdev->data;
+	int ret;
+
+	if (!tdi->data)
+		return -ENODEV;
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_tdi_info(tdi->tdev->data, tdi->data, ts);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+	}
+
+	if (dev_data->cmd == 0) {
+		ret = sev_tio_tdi_status(tdi->tdev->data, tdi->data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+
+		ret = sev_tio_tdi_status_fin(tdi->tdev->data, tdi->data, &ts->state);
+	} else if (dev_data->cmd == SEV_CMD_TIO_TDI_STATUS) {
+		ret = sev_tio_continue(dev_data, &tdi->tdev->spdm);
+		ret = mkret(ret, dev_data);
+		if (ret)
+			return ret;
+
+		ret = sev_tio_tdi_status_fin(tdi->tdev->data, tdi->data, &ts->state);
+	} else {
+		dev_err(tdi->dev.parent, "Wrong state, cmd 0x%x in flight\n",
+			dev_data->cmd);
+	}
+
+	return ret;
+}
+
+struct tsm_hv_ops sev_tsm_ops = {
+	.dev_connect = dev_connect,
+	.dev_disconnect = dev_disconnect,
+	.dev_status = dev_status,
+	.dev_measurements = dev_measurements,
+	.tdi_bind = tdi_bind,
+	.tdi_unbind = tdi_unbind,
+	.guest_request = guest_request,
+	.tdi_status = tdi_status,
+};
+
+void sev_tsm_init(struct sev_device *sev)
+{
+	int ret;
+
+	if (!sev->tio_en)
+		return;
+
+	ret = sev_tio_status(sev);
+	if (ret) {
+		pr_warn("SEV-TIO STATUS failed with %d\n", ret);
+		return;
+	}
+
+	sev->tsm = tsm_host_register(sev->dev, &sev_tsm_ops, sev);
+	sev->tsm_bus = pci_tsm_register((struct tsm_subsys *) sev->tsm);
+}
+
+void sev_tsm_uninit(struct sev_device *sev)
+{
+	if (!sev->tio_en)
+		return;
+	if (sev->tsm_bus)
+		pci_tsm_unregister(sev->tsm_bus);
+	if (sev->tsm)
+		tsm_unregister((struct tsm_subsys *) sev->tsm);
+	sev->tsm_bus = NULL;
+	sev->tsm = NULL;
+	sev_tio_cleanup(sev);
+	sev->tio_en = false;
+}
+
+
+static int rmpupdate(u64 pfn, struct rmp_state *state)
+{
+	unsigned long paddr = pfn << PAGE_SHIFT;
+	int ret, level;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return -ENODEV;
+
+	level = RMP_TO_PG_LEVEL(state->pagesize);
+
+	do {
+		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
+		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
+			     : "=a" (ret)
+			     : "a" (paddr), "c" ((unsigned long)state)
+			     : "memory", "cc");
+	} while (ret == RMPUPDATE_FAIL_OVERLAP);
+
+	if (ret) {
+		pr_err("MMIO RMPUPDATE failed for PFN %llx, pg_level: %d, ret: %d\n",
+		       pfn, level, ret);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void tdi_share_mmio(struct pci_dev *pdev)
+{
+	struct resource *res;
+
+	pci_dev_for_each_resource(pdev, res) {
+		if (!res)
+			continue;
+
+		pr_err("___K___ %s %u: Sharing %s %llx..%llx\n", __func__, __LINE__,
+			res->name ? res->name : "(null)", res->start, res->end);
+		for (resource_size_t off = res->start; off < res->end; off += PAGE_SIZE) {
+			struct rmp_state state = {};
+
+			state.pagesize = PG_LEVEL_TO_RMP(PG_LEVEL_4K);
+			rmpupdate(off >> PAGE_SHIFT, &state);
+		}
+	}
+}
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index b01e5f913727..d59d74d3aaca 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -37,6 +37,7 @@
 
 #include "psp-dev.h"
 #include "sev-dev.h"
+#include "sev-dev-tio.h"
 
 #define DEVICE_NAME		"sev"
 #define SEV_FW_FILE		"amd/sev.fw"
@@ -234,7 +235,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
 	case SEV_CMD_SNP_FEATURE_INFO:		return sizeof(struct sev_data_snp_feature_info);
 	case SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX:	return sizeof(struct sev_data_download_firmware_ex);
-	default:				return 0;
+	default:				return sev_tio_cmd_buffer_len(cmd);
 	}
 
 	return 0;
@@ -2631,6 +2632,8 @@ void sev_pci_init(void)
 
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &snp_panic_notifier);
+	sev_tsm_init(sev);
+
 	return;
 
 err:
@@ -2647,6 +2650,11 @@ void sev_pci_exit(void)
 		return;
 
 	sev_firmware_shutdown(sev);
+	/*
+	 * sev_tsm_uninit needs to clear tio_en after sev_firmware_shutdown to let it
+	 * do proper cleanup.
+	 */
+	sev_tsm_uninit(sev);
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &snp_panic_notifier);
diff --git a/drivers/virt/coco/host/tsm-host.c b/drivers/virt/coco/host/tsm-host.c
index 80f3315fb195..5d23a3871009 100644
--- a/drivers/virt/coco/host/tsm-host.c
+++ b/drivers/virt/coco/host/tsm-host.c
@@ -265,7 +265,7 @@ static char *spdm_algos_to_str(u64 algos, char *buf, size_t len)
 
 	buf[0] = 0;
 #define __ALGO(x) do {								\
-		if ((n < len) && (algos & (1ULL << (TSM_TDI_SPDM_ALGOS_##x))))	\
+		if ((n < len) && (algos & (1ULL << (TSM_SPDM_ALGOS_##x))))	\
 			n += snprintf(buf + n, len - n, #x" ");			\
 	} while (0)
 
@@ -287,7 +287,6 @@ static const char *tdisp_state_to_str(enum tsm_tdisp_state state)
 {
 	switch (state) {
 #define __ST(x) case TDISP_STATE_##x: return #x
-	case TDISP_STATE_UNAVAIL: return "TDISP state unavailable";
 	__ST(CONFIG_UNLOCKED);
 	__ST(CONFIG_LOCKED);
 	__ST(RUN);
@@ -475,7 +474,6 @@ void tsm_tdi_unbind(struct tsm_tdi *tdi)
 	}
 
 	tdi->guest_rid = 0;
-	tdi->dev.parent->tdi_enabled = false;
 }
 EXPORT_SYMBOL_GPL(tsm_tdi_unbind);
 
diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index 40be991f15d2..459bc339e651 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -25,6 +25,7 @@ config CRYPTO_DEV_CCP_CRYPTO
 	default m
 	depends on CRYPTO_DEV_CCP_DD
 	depends on CRYPTO_DEV_SP_CCP
+	depends on PCI_TSM
 	select CRYPTO_HASH
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AUTHENC
@@ -39,6 +40,7 @@ config CRYPTO_DEV_SP_PSP
 	bool "Platform Security Processor (PSP) device"
 	default y
 	depends on CRYPTO_DEV_CCP_DD && X86_64 && AMD_IOMMU
+	select TSM_HOST
 	help
 	 Provide support for the AMD Platform Security Processor (PSP).
 	 The PSP is a dedicated processor that provides support for key
-- 
2.47.1


