Return-Path: <linux-arch+bounces-10192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5EBA39A8C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D317317410D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3E2417C6;
	Tue, 18 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wUVtIN1B"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A123C8A7;
	Tue, 18 Feb 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877414; cv=fail; b=XS7ejJ7gGj+k6gf/Fq7d3JvCqAqBoCQRacADijDH8vBMRAN1D3flvo8P9EVaiC5/SzswLiCnddr5tkLm4+WBceXYfEkT9jgApt5ovqQxI7d1y10OGy/fXWnJuF83p7gVL7DJBpbAWgJweKRvhu1ZIOAlIZXI6goW5NgkRPEr6vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877414; c=relaxed/simple;
	bh=3OdM7W7dLLVmIfboylcNee3zw1a/CvYgQe28T5VK0Lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujFCdXveNKV9OoJJKyyIY62bfiMErhu1cq6USnKTIAlwjdyXTxOkJRp4U1pwLzq5Nr1kYLQPtJ+yXbRDW2CelZu04RgJ9VRbhEvAgPhposTphJ8pLXKfq5+aKmI3ir8qcUYkxjOzk1s20W5BEq8h6Lb8KkQ0INRBjWEbzYQz5Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wUVtIN1B; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGsJNlVZYlinL0rWqMkBwbpC3MG3aEVF0eZx4B2ZOp9an3il4WonT3sO8M626wbuZ13gWfpPwaj6jrJsECCGMSg0AHXPQ2Z+8uwdh33HwTX4dVri8tAOfoEUKOvf70YNO4NjLeT+k+xO96JWvmyeMHnkdK4W5Dqy9GXlCLcNrb/E0pofFFt3B9q9AovQj1zdNMJHg8J4yl1KLdnreetisCgYt1Ri8wALGMx4sxnMHqHsg6tKog1v5k0YaDDaKgHDyaFvOqQfXu5kAaN7r48osiatJs019Nyk879iIUN6a90LAYi0UTS1Be1CHtTk8AXxs2ycqFKCDmG2T1peeWnhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D11gbLjX7dAGq0gW9N90U6bZpivPnmNEV4sU/JgWvKM=;
 b=A+49d72MQRHaKs3FnU/+9DTk/lJhBojB1Itl1WFSDmaCSZ0hWi97oUfMoMHniqanNB8I2ydF71FLFON7Ki54t41aW+znWU7Nui8uvEwIkz4EQ6sbpJfjS0n4Wpn76n6l4+TrXCpw6bgAvXnS1gDVGzSs4qnIssJqvWjcV0mxTCa/gUhhIT9T6kV8NRnmPVZFsDEoJu5VohwyjIAxHKoY0LAOb2wPWDX8NFaZn9uL1qCc0LvIBW5BAe7lkUVzkR9K2ehlcxmfMQxHeu6u2a4OwMgaEUY0/EB1mir7R0hbq8vP2LxEAc8JsBMhQAfUM2jUS7DvE8Hcm4bBtmklZBSrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D11gbLjX7dAGq0gW9N90U6bZpivPnmNEV4sU/JgWvKM=;
 b=wUVtIN1Bw3HoN+/O5nroW9F7deNbBM4yfi0s4iZdkhFVc/FSWhDY44nTq4oKPNrWf4tcVHaWZ1kQBRGQRmHusAI6IvtlXIA0fVivUJ+WPSafVeCdiRb12tW+ii4+4JvshcZFkbwzGDaNM/cwN6M41WpSAFsuTMJywh/Q6PoJFpM=
Received: from CH0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:610:b1::24)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 11:16:46 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::bb) by CH0PR13CA0019.outlook.office365.com
 (2603:10b6:610:b1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via Frontend Transport; Tue,
 18 Feb 2025 11:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:16:46 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:16:37 -0600
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
Subject: [RFC PATCH v2 18/22] coco/sev-guest: Implement the guest support for SEV TIO
Date: Tue, 18 Feb 2025 22:10:05 +1100
Message-ID: <20250218111017.491719-19-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bcfc81-8368-4562-46fc-08dd500dbb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmc2WmhPSENRaUpRSmFoRkYwM2t2OHhZcDB6ZzFEUHoxZHFMVGJvdTRKMWFp?=
 =?utf-8?B?eHVTUXN6UzQ2dHJDVm5YckxJNVZVcVdQSElabXhUeS9HOFVQYytrOFJEUjFD?=
 =?utf-8?B?TjMrbzJubjB6UDNCaFJKTUY2K1B6OHUzQTRTdE9SZ05KRWNMYjdUajhMeEpr?=
 =?utf-8?B?eHFYNUFOY3J0eVl6Um1nVFhtTXlmUlFnRS9qNHNyejJFNGg4QXQrcnFzZ1Zr?=
 =?utf-8?B?Mkd5QllqZGFiTTdiOFJzcEdHaXdyUWdnd3Q0Q1plZ3lSR0lrV0dsOGpkYlll?=
 =?utf-8?B?MityVFRVa3NDcUp0Z2xOVG1pMHF4dTB2MVR6STgyZ2RVR3JDU2xmREtqUnpx?=
 =?utf-8?B?aFAra1RmTm4wSnpIRk1EMHBQZXBXdHFEVjZoekNFbXVlL054ZlFKSGJQcW8v?=
 =?utf-8?B?bDhKN0U3UThpOXFzK1haT3d6RktHbDVIM3EyaUJsNW1RRk1XSDBORTBraDdl?=
 =?utf-8?B?VVJVZnpEN3NlY09URTVTL2pva3lmYlpYaEJBaEhyUFlhTDk0eEFRM1ViRUtI?=
 =?utf-8?B?KzR6MmRaMHVYanpGS3B0eGdjVzlGM2dSaGNQck1yM0xrcFhtVXZWM3RiZFQv?=
 =?utf-8?B?T2FCbzNySEpYZ3o4ZnhpK1JhNXdYYWM0ZXF5Y1pzdkU4Z2pMcXJWWXQ2TUpS?=
 =?utf-8?B?Q1Zvd28yT0N5anlGaTJIVVBaTElKbDFLVXI4anBKaWtycEhWbklQUzBWM2tO?=
 =?utf-8?B?WldoTHdsb3Q3bGMrYnBSRzlTQm1BLzBqelpIeGN0b1FSbEZ5U09oNkZRclhj?=
 =?utf-8?B?VE9IdldjRnJncnZwRnovWTdTcUpXcmpOb3preDZFSFhpZlJKSng4c201dEN1?=
 =?utf-8?B?SHRJaTc2cnh0UTNZcWxVc2NKUU1oZVRjZ3NTUmNua2xKVVBZWFRpMmdIdzNF?=
 =?utf-8?B?KzFKSmR1ODV1blBxOEF0bFBUbk9UU1JLRXFwMDl3WjROc2dWVkhjdk92WU5V?=
 =?utf-8?B?ei9EYXVmcU9hMkJmV0RNYXppR2s1YlBEMGwvdkpzWldyd3ZOSXdWdmUwMnZE?=
 =?utf-8?B?YThZeDl3UXE3UFMwcFNKR0F1b0JnK3dSZGhwTlNzL05uTFZHTHJxc1JkU1Rq?=
 =?utf-8?B?cy82d3NQeXFLdU1FQWVBLzloaUxaODV1VTVEOURkSnRCNCt3ZHJ6SG1CaDVk?=
 =?utf-8?B?cGpkK2pRY3NyNnNVdWpKbit3L2EyL25IcWc5RGxEOFNNN2pNYmNNYjJiL0hi?=
 =?utf-8?B?ZzJCUHozMzVDaDAzMVAzTCtuaWtETGJuc1RYZ2pNd1lYSGVoMzFEUHVHNFFQ?=
 =?utf-8?B?Y0FEdG1taE9oQk1hOEoxdy9TWC9TU09pcFZySU0vV1lIQnFrR3FzNkpTYkZ0?=
 =?utf-8?B?cVM1Rlh2NlhFWjdRNzRheEU5T3lWaWlKZTVqeW42YnNkVXl2Q05VaUExbVZ1?=
 =?utf-8?B?UThOenJZK2lyZm9QK2lZWmVZMG9NSURZaFkvM0I2Z0lvTExIVkNWZWdQVVNP?=
 =?utf-8?B?SjFzMUx5bTVyajBRT0FpeW9sV2dJeUFxelJxVTVQWGJqYlNiczQ2Qlo0cDF6?=
 =?utf-8?B?TzBja3dDUzl2MzNDc2FLZHRjdDQwd1NrMXNOR00vWElMRlZqTFZVbmE2cWVM?=
 =?utf-8?B?aGQzTC92SHFoRlpJYThWZkU5NFhUd1A3dUdWYWdwa1hYZ1lSTHNBQkRkRW9v?=
 =?utf-8?B?MEkwNVVIQUdJaVdzc245SEYrZEE2MThrWk9yaVl0bW9OL0lqRzJyZE45dUVH?=
 =?utf-8?B?Yll6aG9GWGRhczJLVjYwUGUycHdXbVdtbVNHTk1pMHdtL1RER3A1YmRaVG1h?=
 =?utf-8?B?OWwwUGlhV2dvaHREMmQ5QzJLSFhISDlYSmtVazV4RktvbEFCS2M5KzRhdzZq?=
 =?utf-8?B?L21XalR5M0FlQ1FKNFBvK1hFS1JGMXNMMmZlZTBRYWhLSjZZRkJkN053eGlT?=
 =?utf-8?B?VFJhRFN1aEdmQ2g5aHdUUTJ2dkVYU3c0QWNsZkF1WHQvV044RzN6eVRFdW81?=
 =?utf-8?B?VVJYeEpXK2pQQnBiQWUzdzh0NEVPQ0xnUmtya2Mya2pKZnlXTndiMVFWcE1o?=
 =?utf-8?Q?A/O0VVYXOI43a2mVg3QorrJF8u3Dqw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:16:46.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bcfc81-8368-4562-46fc-08dd500dbb1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

Define tsm_ops for the guest and forward the ops calls to the HV via
SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST.
Do the attestation report examination and enable MMIO.

In this RFC exercise, encrypted DMA supported for Coco VMs. Secure DMA
is allowed to all memory below "vTOM" (set now to the possible maximum
so all DMA is encrypted) after the VM performs "validation" via GHCB
TIO GUEST REQUEST "sDTE write" call to the secure fw.

Encrypted MMIO is possible to TEE regions in the VF (==TDI) interface
report and requires accepting MMIO ranges into the guest TCB which is
done in 2 steps:
- the HV RMPUPDATEs the ranges;
- the guest accepts them via GHCB TIO GUEST REQUEST "MMIO validate"
call to the secure fw (which is AMD's "pvalidate" for MMIO).

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/virt/coco/sev-guest/Makefile        |   2 +-
 arch/x86/include/asm/sev.h                  |   9 +
 include/uapi/linux/sev-guest.h              |  39 ++
 arch/x86/coco/sev/core.c                    |  19 +-
 drivers/virt/coco/sev-guest/sev_guest.c     |  10 +
 drivers/virt/coco/sev-guest/sev_guest_tio.c | 738 ++++++++++++++++++++
 6 files changed, 815 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/Makefile b/drivers/virt/coco/sev-guest/Makefile
index 2d7dffed7b2f..34ea9fab698b 100644
--- a/drivers/virt/coco/sev-guest/Makefile
+++ b/drivers/virt/coco/sev-guest/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SEV_GUEST) += sev-guest.o
-sev-guest-y += sev_guest.o
+sev-guest-y += sev_guest.o sev_guest_tio.o
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2cae72b618d0..a396dbcdee68 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -119,6 +119,8 @@ struct snp_req_data {
 	unsigned long resp_gpa;
 	unsigned long data_gpa;
 	unsigned int data_npages;
+	unsigned int guest_rid;
+	unsigned long param;
 };
 
 #define MAX_AUTHTAG_LEN		32
@@ -306,6 +308,11 @@ struct snp_guest_dev {
 		struct snp_derived_key_req derived_key;
 		struct snp_ext_report_req ext_report;
 	} req;
+
+#if defined(CONFIG_PCI_TSM) || defined(CONFIG_PCI_TSM_MODULE)
+	struct tsm_guest_subsys *tsm;
+	struct tsm_bus_subsys *tsm_bus;
+#endif
 };
 
 /*
@@ -516,6 +523,8 @@ void *snp_alloc_shared_pages(size_t sz);
 void snp_free_shared_pages(void *buf, size_t sz);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   u64 *exitinfo2);
+struct snp_guest_dev;
+void sev_guest_tsm_set_ops(bool set, struct snp_guest_dev *snp_dev);
 
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index fcdfea767fca..48b6df3d3298 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -13,6 +13,7 @@
 #define __UAPI_LINUX_SEV_GUEST_H_
 
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 #define SNP_REPORT_USER_DATA_SIZE 64
 
@@ -96,4 +97,42 @@ struct snp_ext_report_req {
 #define SNP_GUEST_VMM_ERR_INVALID_LEN	1
 #define SNP_GUEST_VMM_ERR_BUSY		2
 
+/*
+ * TIO_GUEST_REQUEST's TIO_MSG_MMIO_VALIDATE_REQ
+ * encoding for MMIO in RDX:
+ *
+ * ........ ....GGGG GGGGGGGG GGGGGGGG GGGGGGGG GGGGGGGG GGGGOOOO OOOOTrrr
+ * Where:
+ *	G - guest physical address
+ *	O - order of 4K pages
+ *	T - TEE (valid for TIO_MSG_MMIO_CONFIG_REQ)
+ *	r - range id == BAR
+ */
+#define MMIO_VALIDATE_GPA(r)      ((r) & 0x000FFFFFFFFFF000ULL)
+#define MMIO_VALIDATE_LEN(r)      (1ULL << (12 + (((r) >> 4) & 0xFF)))
+#define MMIO_VALIDATE_RANGEID(r)  ((r) & 0x7)
+#define MMIO_VALIDATE_RESERVED(r) ((r) & 0xFFF0000000000000ULL)
+#define MMIO_CONFIG_TEE		  BIT(3)
+
+#define MMIO_MK_VALIDATE(start, size, range_id, tee) \
+	(MMIO_VALIDATE_GPA(start) | (get_order(size >> 12) << 4) | \
+	((range_id) & 0xFF) | ((tee)?MMIO_CONFIG_TEE:0))
+
+/* Optional Certificates/measurements/report data from TIO_GUEST_REQUEST */
+struct tio_blob_table_entry {
+	guid_t guid;
+	__u32 offset;
+	__u32 length;
+} __packed;
+
+/* Measurement’s blob: 5caa80c6-12ef-401a-b364-ec59a93abe3f */
+#define TIO_GUID_MEASUREMENTS \
+	GUID_INIT(0x5caa80c6, 0x12ef, 0x401a, 0xb3, 0x64, 0xec, 0x59, 0xa9, 0x3a, 0xbe, 0x3f)
+/* Certificates blob: 078ccb75-2644-49e8-afe7-5686c5cf72f1 */
+#define TIO_GUID_CERTIFICATES \
+	GUID_INIT(0x078ccb75, 0x2644, 0x49e8, 0xaf, 0xe7, 0x56, 0x86, 0xc5, 0xcf, 0x72, 0xf1)
+/* Attestation report: 70dc5b0e-0cc0-4cd5-97bb-ff0ba25bf320 */
+#define TIO_GUID_REPORT \
+	GUID_INIT(0x70dc5b0e, 0x0cc0, 0x4cd5, 0x97, 0xbb, 0xff, 0x0b, 0xa2, 0x5b, 0xf3, 0x20)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c680057c13fa..c78a5db0feb5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2592,6 +2592,11 @@ static int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 		ghcb_set_rax(ghcb, input->data_gpa);
 		ghcb_set_rbx(ghcb, input->data_npages);
+	} else if (exit_code == SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST) {
+		ghcb_set_rax(ghcb, input->data_gpa);
+		ghcb_set_rbx(ghcb, input->data_npages);
+		ghcb_set_rcx(ghcb, input->guest_rid);
+		ghcb_set_rdx(ghcb, input->param);
 	}
 
 	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
@@ -2601,6 +2606,8 @@ static int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
 	*exitinfo2 = ghcb->save.sw_exit_info_2;
 	switch (*exitinfo2) {
 	case 0:
+		if (exit_code == SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST)
+			input->param = ghcb_get_rdx(ghcb);
 		break;
 
 	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
@@ -2613,6 +2620,10 @@ static int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
 			input->data_npages = ghcb_get_rbx(ghcb);
 			ret = -ENOSPC;
 			break;
+		} else if (exit_code == SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST) {
+			input->data_npages = ghcb_get_rbx(ghcb);
+			ret = -ENOSPC;
+			break;
 		}
 		fallthrough;
 	default:
@@ -2974,7 +2985,8 @@ static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_r
 		return -EBADMSG;
 
 	/* Verify response message type and version number. */
-	if (resp_msg_hdr->msg_type != (req_msg_hdr->msg_type + 1) ||
+	if ((resp_msg_hdr->msg_type != (req_msg_hdr->msg_type + 1) &&
+	     (resp_msg_hdr->msg_type != (req_msg_hdr->msg_type - 0x80))) ||
 	    resp_msg_hdr->msg_version != req_msg_hdr->msg_version)
 		return -EBADMSG;
 
@@ -3047,6 +3059,11 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, u64 exit_code,
 	rc = snp_issue_guest_request(exit_code, input, exitinfo2);
 	switch (rc) {
 	case -ENOSPC:
+		if (exit_code == SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST) {
+			pr_warn("SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST => -ENOSPC");
+			break;
+		}
+
 		/*
 		 * If the extended guest request fails due to having too
 		 * small of a certificate data buffer, retry the same
diff --git a/drivers/virt/coco/sev-guest/sev_guest.c b/drivers/virt/coco/sev-guest/sev_guest.c
index 4e79da7cb0d2..f8d5261595b9 100644
--- a/drivers/virt/coco/sev-guest/sev_guest.c
+++ b/drivers/virt/coco/sev-guest/sev_guest.c
@@ -43,6 +43,10 @@ static int vmpck_id = -1;
 module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
+static bool tsm_enable = true;
+module_param(tsm_enable, bool, 0644);
+MODULE_PARM_DESC(tsm_enable, "Enable SEV TIO");
+
 static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 {
 	struct miscdevice *dev = file->private_data;
@@ -635,6 +639,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->msg_desc = mdesc;
 	dev_info(dev, "Initialized SEV guest driver (using VMPCK%d communication key)\n",
 		 mdesc->vmpck_id);
+
+	if (tsm_enable)
+		sev_guest_tsm_set_ops(true, snp_dev);
+
 	return 0;
 
 e_msg_init:
@@ -648,6 +656,8 @@ static void __exit sev_guest_remove(struct platform_device *pdev)
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
 	snp_msg_free(snp_dev->msg_desc);
+	if (tsm_enable)
+		sev_guest_tsm_set_ops(false, snp_dev);
 	misc_deregister(&snp_dev->misc);
 }
 
diff --git a/drivers/virt/coco/sev-guest/sev_guest_tio.c b/drivers/virt/coco/sev-guest/sev_guest_tio.c
new file mode 100644
index 000000000000..7faa810a2823
--- /dev/null
+++ b/drivers/virt/coco/sev-guest/sev_guest_tio.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/psp-sev.h>
+#include <linux/tsm.h>
+#include <crypto/gcm.h>
+#include <uapi/linux/sev-guest.h>
+
+#include <asm/svm.h>
+#include <asm/sev.h>
+
+#define TIO_MESSAGE_VERSION	1
+
+ulong tsm_vtom = 0x7fffffff;
+module_param(tsm_vtom, ulong, 0644);
+MODULE_PARM_DESC(tsm_vtom, "SEV TIO vTOM value");
+
+#define tdi_to_pci_dev(tdi) (to_pci_dev(tdi->dev.parent))
+
+/*
+ * Status codes from TIO_MSG_SDTE_WRITE_RSP
+ */
+enum sdte_write_status {
+	SDTE_WRITE_SUCCESS = 0,
+	SDTE_WRITE_INVALID_TDI = 1,
+	SDTE_WRITE_TDI_NOT_BOUND = 2,
+	SDTE_WRITE_RESERVED = 3,
+};
+
+/*
+ * Status codes from TIO_MSG_MMIO_VALIDATE_REQ
+ */
+enum mmio_validate_status {
+	MMIO_VALIDATE_SUCCESS = 0,
+	MMIO_VALIDATE_INVALID_TDI = 1,
+	MMIO_VALIDATE_TDI_UNBOUND = 2,
+	/* At least one page is not assigned to the guest */
+	MMIO_VALIDATE_NOT_ASSIGNED = 3,
+	/* The Validated bit is not uniformly set for the MMIO subrange */
+	MMIO_VALIDATE_NOT_UNIFORM = 4,
+	/* At least one page does not have immutable bit set when validated bit is clear */
+	MMIO_VALIDATE_NOT_IMMUTABLE = 5,
+	/* At least one page is not mapped to the expected GPA */
+	MMIO_VALIDATE_NOT_MAPPED = 6,
+	/* The provided MMIO range ID is not reported in the interface report */
+	MMIO_VALIDATE_NOT_REPORTED = 7,
+	/* The subrange is out the MMIO range in the interface report */
+	MMIO_VALIDATE_OUT_OF_RANGE = 8,
+};
+
+/*
+ * Status codes from TIO_MSG_MMIO_CONFIG_REQ
+ */
+enum mmio_config_status {
+	MMIO_CONFIG_SUCCESS = 0,
+	MMIO_CONFIG_INVALID_TDI = 1,
+	MMIO_CONFIG_TDI_UNBOUND = 2,
+	 /* The provided MMIO range ID is not reported in the interface report */
+	MMIO_CONFIG_NOT_REPORTED = 3,
+	/* One or more attributes could not be changed */
+	MMIO_CONFIG_COULD_NOT_CHANGE = 4,
+};
+
+static int handle_tio_guest_request(struct snp_guest_dev *snp_dev, u8 type,
+				   void *req_buf, size_t req_sz, void *resp_buf, u32 resp_sz,
+				   void *pt, u64 *npages, u64 *bdfn, u64 *param, u64 *fw_err)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	struct snp_guest_req req = {
+		.msg_version = TIO_MESSAGE_VERSION,
+	};
+	u64 exitinfo2 = 0;
+	int ret;
+
+	req.msg_type = type;
+	req.vmpck_id = mdesc->vmpck_id;
+	req.req_buf = req_buf;
+	req.req_sz = req_sz;
+	req.resp_buf = resp_buf;
+	req.resp_sz = resp_sz;
+	req.exit_code = SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST;
+
+	req.input.guest_rid = 0;
+	req.input.param = 0;
+
+	if (pt && npages) {
+		req.data = pt;
+		req.input.data_npages = *npages;
+	}
+	if (bdfn)
+		req.input.guest_rid = *bdfn;
+	if (param)
+		req.input.param = *param;
+
+	ret = snp_send_guest_request(mdesc, &req, &exitinfo2);
+
+	if (param)
+		*param = req.input.param;
+
+	*fw_err = exitinfo2;
+
+	return ret;
+}
+
+static int guest_request_tio_data(struct snp_guest_dev *snp_dev, u8 type,
+				   void *req_buf, size_t req_sz, void *resp_buf, u32 resp_sz,
+				   u64 bdfn, enum tsm_tdisp_state *state,
+				   struct tsm_blob **certs, struct tsm_blob **meas,
+				   struct tsm_blob **report, u64 *fw_err)
+{
+	u64 npages = SZ_32K >> PAGE_SHIFT, c1, param = 0;
+	struct tio_blob_table_entry *pt;
+	int rc;
+
+	pt = snp_alloc_shared_pages(npages << PAGE_SHIFT);
+	if (!pt)
+		return -ENOMEM;
+
+	c1 = npages;
+	rc = handle_tio_guest_request(snp_dev, type, req_buf, req_sz, resp_buf, resp_sz,
+				      pt, &c1, &bdfn, state ? &param : NULL, fw_err);
+
+	if (c1 > SZ_32K) {
+		snp_free_shared_pages(pt, npages);
+		npages = c1;
+		pt = snp_alloc_shared_pages(npages << PAGE_SHIFT);
+		if (!pt)
+			return -ENOMEM;
+
+		rc = handle_tio_guest_request(snp_dev, type, req_buf, req_sz, resp_buf, resp_sz,
+					      pt, &c1, &bdfn, state ? &param : NULL, fw_err);
+	}
+	if (rc)
+		return rc;
+
+	tsm_blob_free(*meas);
+	tsm_blob_free(*certs);
+	tsm_blob_free(*report);
+	*meas = NULL;
+	*certs = NULL;
+	*report = NULL;
+
+	for (unsigned int i = 0; i < 3; ++i) {
+		u8 *ptr = ((u8 *) pt) + pt[i].offset;
+		size_t len = pt[i].length;
+		struct tsm_blob *b;
+
+		if (guid_is_null(&pt[i].guid))
+			break;
+
+		if (!len)
+			continue;
+
+		b = tsm_blob_new(ptr, len);
+		if (!b)
+			break;
+
+		if (guid_equal(&pt[i].guid, &TIO_GUID_MEASUREMENTS))
+			*meas = b;
+		else if (guid_equal(&pt[i].guid, &TIO_GUID_CERTIFICATES))
+			*certs = b;
+		else if (guid_equal(&pt[i].guid, &TIO_GUID_REPORT))
+			*report = b;
+	}
+	snp_free_shared_pages(pt, npages);
+
+	if (state)
+		*state = param;
+
+	return 0;
+}
+
+struct tio_msg_tdi_info_req {
+	__u16 guest_device_id;
+	__u8 reserved[14];
+} __packed;
+
+struct tio_msg_tdi_info_rsp {
+	__u16 guest_device_id;
+	__u16 status;
+	__u8 reserved1[12];
+	union {
+		u32 meas_flags;
+		struct {
+			u32 meas_digest_valid : 1;
+			u32 meas_digest_fresh : 1;
+		};
+	};
+	union {
+		u32 tdisp_lock_flags;
+		/* These are TDISP's LOCK_INTERFACE_REQUEST flags */
+		struct {
+			u32 no_fw_update : 1;
+			u32 cache_line_size : 1;
+			u32 lock_msix : 1;
+			u32 bind_p2p : 1;
+			u32 all_request_redirect : 1;
+		};
+	};
+	__u64 spdm_algos;
+	__u8 certs_digest[48];
+	__u8 meas_digest[48];
+	__u8 interface_report_digest[48];
+	__u64 tdi_report_count;
+	__u64 reserved2;
+} __packed;
+
+static int tio_tdi_status(struct tsm_tdi *tdi, struct snp_guest_dev *snp_dev,
+			  struct tsm_tdi_status *ts)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	size_t resp_len = sizeof(struct tio_msg_tdi_info_rsp) + mdesc->ctx->authsize;
+	struct tio_msg_tdi_info_rsp *rsp = kzalloc(resp_len, GFP_KERNEL);
+	struct tio_msg_tdi_info_req req = {
+		.guest_device_id = pci_dev_id(tdi_to_pci_dev(tdi)),
+	};
+	u64 fw_err = 0;
+	int rc;
+	enum tsm_tdisp_state state = 0;
+
+	dev_notice(&tdi->dev, "TDI info");
+	if (!rsp)
+		return -ENOMEM;
+
+	rc = guest_request_tio_data(snp_dev, TIO_MSG_TDI_INFO_REQ, &req,
+				     sizeof(req), rsp, resp_len,
+				     pci_dev_id(tdi_to_pci_dev(tdi)), &state,
+				     &tdi->tdev->certs, &tdi->tdev->meas,
+				     &tdi->report, &fw_err);
+	if (rc)
+		goto free_exit;
+
+	ts->meas_digest_valid = rsp->meas_digest_valid;
+	ts->meas_digest_fresh = rsp->meas_digest_fresh;
+	ts->no_fw_update = rsp->no_fw_update;
+	ts->cache_line_size = rsp->cache_line_size == 0 ? 64 : 128;
+	ts->lock_msix = rsp->lock_msix;
+	ts->bind_p2p = rsp->bind_p2p;
+	ts->all_request_redirect = rsp->all_request_redirect;
+#define __ALGO(x, n, y) \
+	((((x) & (0xFFUL << (n))) == TIO_SPDM_ALGOS_##y) ? \
+	 (1ULL << TSM_SPDM_ALGOS_##y) : 0)
+	ts->spdm_algos =
+		__ALGO(rsp->spdm_algos, 0, DHE_SECP256R1) |
+		__ALGO(rsp->spdm_algos, 0, DHE_SECP384R1) |
+		__ALGO(rsp->spdm_algos, 8, AEAD_AES_128_GCM) |
+		__ALGO(rsp->spdm_algos, 8, AEAD_AES_256_GCM) |
+		__ALGO(rsp->spdm_algos, 16, ASYM_TPM_ALG_RSASSA_3072) |
+		__ALGO(rsp->spdm_algos, 16, ASYM_TPM_ALG_ECDSA_ECC_NIST_P256) |
+		__ALGO(rsp->spdm_algos, 16, ASYM_TPM_ALG_ECDSA_ECC_NIST_P384) |
+		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_256) |
+		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_384) |
+		__ALGO(rsp->spdm_algos, 32, KEY_SCHED_SPDM_KEY_SCHEDULE);
+#undef __ALGO
+	memcpy(ts->certs_digest, rsp->certs_digest, sizeof(ts->certs_digest));
+	memcpy(ts->meas_digest, rsp->meas_digest, sizeof(ts->meas_digest));
+	memcpy(ts->interface_report_digest, rsp->interface_report_digest,
+	       sizeof(ts->interface_report_digest));
+	ts->intf_report_counter = rsp->tdi_report_count;
+
+	ts->valid = true;
+	ts->state = state;
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+free_exit:
+	memzero_explicit(&rsp, sizeof(resp_len));
+	kfree(rsp);
+	return rc;
+}
+
+struct tio_msg_mmio_validate_req {
+	__u16 guest_device_id;
+	__u16 reserved1;
+	__u8 reserved2[12];
+	__u64 subrange_base;
+	__u32 subrange_page_count;
+	__u32 range_offset;
+	union {
+		__u16 flags;
+		struct {
+			__u16 validated:1; /* Desired value to set RMP.Validated for the range */
+			/*
+			 * Force validated:
+			 * 0: If subrange does not have RMP.Validated set uniformly, fail.
+			 * 1: If subrange does not have RMP.Validated set uniformly, force
+			 *    to requested value
+			 */
+			__u16 force_validated:1;
+		};
+	};
+	__u16 range_id;
+	__u8 reserved3[12];
+} __packed;
+
+struct tio_msg_mmio_validate_rsp {
+	__u16 guest_interface_id;
+	__u16 status; /* MMIO_VALIDATE_xxx */
+	__u8 reserved1[12];
+	__u64 subrange_base;
+	__u32 subrange_page_count;
+	__u32 range_offset;
+	union {
+		__u16 flags;
+		struct {
+			/* Validated bit has changed due to this operation */
+			__u16 changed:1;
+		};
+	};
+	__u16 range_id;
+	__u8 reserved2[12];
+} __packed;
+
+static int mmio_validate_range(struct snp_guest_dev *snp_dev, struct pci_dev *pdev,
+			       unsigned int range_id, resource_size_t start, resource_size_t size,
+			       bool invalidate, u64 *fw_err, u16 *status)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	size_t resp_len = sizeof(struct tio_msg_mmio_validate_rsp) + mdesc->ctx->authsize;
+	struct tio_msg_mmio_validate_rsp *rsp = kzalloc(resp_len, GFP_KERNEL);
+	struct tio_msg_mmio_validate_req req = { 0 };
+	u64 bdfn = pci_dev_id(pdev);
+	u64 mmio_val = MMIO_MK_VALIDATE(start, size, range_id, !invalidate);
+	int rc;
+
+	if (!rsp)
+		return -ENOMEM;
+
+	if (!invalidate)
+		req = (struct tio_msg_mmio_validate_req) {
+			.guest_device_id = pci_dev_id(pdev),
+			.subrange_base = start,
+			.subrange_page_count = size >> PAGE_SHIFT,
+			.range_offset = 0,
+			.validated = 1, /* Desired value to set RMP.Validated for the range */
+			.force_validated = 0,
+			.range_id = range_id,
+		};
+
+	rc = handle_tio_guest_request(snp_dev, TIO_MSG_MMIO_VALIDATE_REQ,
+			       &req, sizeof(req), rsp, resp_len,
+			       NULL, NULL, &bdfn, &mmio_val, fw_err);
+	if (rc)
+		goto free_exit;
+
+	*status = rsp->status;
+
+free_exit:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(&rsp, sizeof(resp_len));
+	kfree(rsp);
+	return rc;
+}
+
+struct tio_msg_mmio_config_req {
+	__u16 guest_device_id;
+	__u16 reserved1;
+	struct {
+		__u32 reserved2:2;
+		__u32 is_non_tee_mem:1;
+		__u32 reserved3:13;
+		__u32 range_id:16;
+	};
+	struct {
+		__u32 write:1; /* 0: read; 1: Write configuration of range */
+		__u32 reserved4:31;
+	};
+	__u8 reserved5[4];
+} __packed;
+
+struct tio_msg_mmio_config_rsp {
+	__u16 guest_device_id;
+	__u16 status; /* mmio_config_status */
+	struct {
+		__u32 msix_table:1;
+		__u32 msix_pba:1;
+		__u32 is_non_tee_mem:1;
+		__u32 is_mem_attr_updateable:1;
+		__u32 reserved1:12;
+		__u32 range_id:16;
+	};
+	struct {
+		__u32 write:1; /* 0: read; 1: Write configuration of range */
+		__u32 reserved2:31;
+	};
+	__u8 reserved3[4];
+} __packed;
+
+static int mmio_config_get(struct snp_guest_dev *snp_dev, struct pci_dev *pdev,
+			   unsigned int range_id, bool *updateable, bool *is_non_tee,
+			   u64 *fw_err, u16 *status)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	size_t resp_len = sizeof(struct tio_msg_mmio_config_rsp) + mdesc->ctx->authsize;
+	struct tio_msg_mmio_config_rsp *rsp = kzalloc(resp_len, GFP_KERNEL);
+	struct tio_msg_mmio_config_req req = {
+		.guest_device_id = pci_dev_id(pdev),
+		.is_non_tee_mem = 0,
+		.range_id = range_id,
+		.write = 0,
+	};
+	u64 bdfn = pci_dev_id(pdev);
+	int rc;
+
+	if (!rsp)
+		return -ENOMEM;
+
+	rc = handle_tio_guest_request(snp_dev, TIO_MSG_MMIO_CONFIG_REQ,
+			       &req, sizeof(req), rsp, resp_len,
+			       NULL, NULL, &bdfn, NULL, fw_err);
+	if (rc)
+		goto free_exit;
+
+	*status = rsp->status;
+	*updateable = rsp->is_mem_attr_updateable;
+	*is_non_tee = rsp->is_non_tee_mem;
+
+free_exit:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(&rsp, sizeof(resp_len));
+	kfree(rsp);
+	return rc;
+}
+
+static int mmio_config_range(struct snp_guest_dev *snp_dev, struct pci_dev *pdev,
+			     unsigned int range_id, resource_size_t start, resource_size_t size,
+			     bool tee, u64 *fw_err, u16 *status)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	size_t resp_len = sizeof(struct tio_msg_mmio_config_rsp) + mdesc->ctx->authsize;
+	struct tio_msg_mmio_config_rsp *rsp = kzalloc(resp_len, GFP_KERNEL);
+	struct tio_msg_mmio_config_req req = {
+		.guest_device_id = pci_dev_id(pdev),
+//		We kinda want these but the spec does not define them (yet?)
+//		.subrange_base = start,
+//		.subrange_page_count = size >> PAGE_SHIFT,
+//		.range_offset = 0,
+		.is_non_tee_mem = !tee,
+		.range_id = range_id,
+		.write = 1,
+	};
+	u64 bdfn = pci_dev_id(pdev);
+	u64 mmio_val = MMIO_MK_VALIDATE(start, size, range_id, tee);
+	int rc;
+
+	if (!rsp)
+		return -ENOMEM;
+
+	if (tee)
+		mmio_val |= MMIO_CONFIG_TEE;
+
+	rc = handle_tio_guest_request(snp_dev, TIO_MSG_MMIO_CONFIG_REQ,
+			       &req, sizeof(req), rsp, resp_len,
+			       NULL, NULL, &bdfn, &mmio_val, fw_err);
+	if (rc)
+		goto free_exit;
+
+	*status = rsp->status;
+
+free_exit:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(&rsp, sizeof(resp_len));
+	kfree(rsp);
+	return rc;
+}
+
+static int tio_tdi_mmio_validate(struct tsm_tdi *tdi, struct snp_guest_dev *snp_dev,
+				 bool invalidate)
+{
+	struct pci_dev *pdev = tdi_to_pci_dev(tdi);
+	struct tdi_report_mmio_range mr;
+	unsigned int range_id;
+	struct resource *r;
+	u16 mmio_status;
+	u64 fw_err = 0;
+	int i = 0, rc;
+
+	pci_notice(pdev, "MMIO validate");
+
+	if (WARN_ON_ONCE(!tdi->report || !tdi->report->data))
+		return -EFAULT;
+
+	for (i = 0; i < TDI_REPORT_MR_NUM(tdi->report); ++i) {
+		mr = TDI_REPORT_MR(tdi->report, i);
+		range_id = FIELD_GET(TSM_TDI_REPORT_MMIO_RANGE_ID, mr.range_attributes);
+		r = pci_resource_n(pdev, range_id);
+
+		if (r->end == r->start || ((r->end - r->start + 1) & ~PAGE_MASK) || !mr.num) {
+			pci_warn(pdev, "Skipping broken range [%d] #%d %d pages, %llx..%llx\n",
+				i, range_id, mr.num, r->start, r->end);
+			continue;
+		}
+
+		if (FIELD_GET(TSM_TDI_REPORT_MMIO_IS_NON_TEE, mr.range_attributes)) {
+			pci_info(pdev, "Skipping non-TEE range [%d] #%d %d pages, %llx..%llx\n",
+				 i, range_id, mr.num, r->start, r->end);
+			continue;
+		}
+
+		/* Currently not supported */
+		if (FIELD_GET(TSM_TDI_REPORT_MMIO_MSIX_TABLE, mr.range_attributes) ||
+		    FIELD_GET(TSM_TDI_REPORT_MMIO_PBA, mr.range_attributes)) {
+			pci_info(pdev, "Skipping MSIX (%ld/%ld) range [%d] #%d %d pages, %llx..%llx\n",
+				 FIELD_GET(TSM_TDI_REPORT_MMIO_MSIX_TABLE, mr.range_attributes),
+				 FIELD_GET(TSM_TDI_REPORT_MMIO_PBA, mr.range_attributes),
+				 i, range_id, mr.num, r->start, r->end);
+			continue;
+		}
+
+		mmio_status = 0;
+		rc = mmio_validate_range(snp_dev, pdev, range_id,
+					 r->start, r->end - r->start + 1, invalidate, &fw_err,
+					 &mmio_status);
+		if (rc || fw_err != SEV_RET_SUCCESS || mmio_status != MMIO_VALIDATE_SUCCESS) {
+			pci_err(pdev, "MMIO #%d %llx..%llx validation failed 0x%llx %d\n",
+				range_id, r->start, r->end, fw_err, mmio_status);
+			continue;
+		}
+
+		rc = encrypt_resource(pci_resource_n(pdev, range_id),
+				      invalidate ? 0 : IORESOURCE_VALIDATED);
+		if (rc) {
+			pci_err(pdev, "MMIO #%d %llx..%llx failed to reserve\n",
+				range_id, r->start, r->end);
+			continue;
+		}
+
+		/* Try to make MMIO shared */
+		if (invalidate) {
+			bool updateable = false, is_non_tee = false;
+			u16 status = 0;
+
+			rc = mmio_config_get(snp_dev, pdev, range_id, &updateable,
+					     &is_non_tee, &fw_err, &status);
+			if (rc || fw_err) {
+				pci_err(pdev, "MMIO #%d %llx..%llx failed to get config\n",
+					range_id, r->start, r->end);
+				continue;
+			}
+
+			pci_notice(pdev, "[%d] #%d: updateable=%d is_non_tee=%d\n",
+				   i, range_id, updateable, is_non_tee);
+
+			if (!updateable || is_non_tee)
+				continue;
+
+			rc = mmio_config_range(snp_dev, pdev, range_id,
+					       r->start, r->end - r->start + 1,
+					       false, &fw_err, &status);
+			if (rc) {
+				pci_err(pdev, "MMIO #%d %llx..%llx failed to set config\n",
+					range_id, r->start, r->end);
+				continue;
+			}
+
+			pci_notice(pdev, "[%d] #%d: setting config rc=%d status=%d\n",
+				   i, range_id, rc, status);
+		}
+
+		pci_notice(pdev, "MMIO #%d %llx..%llx %s\n",  range_id, r->start, r->end,
+			   invalidate ? "invalidated" : "validated");
+	}
+
+	return rc;
+}
+
+struct sdte {
+	__u64 v                  : 1;
+	__u64 reserved           : 3;
+	__u64 cxlio              : 3;
+	__u64 reserved1          : 45;
+	__u64 ppr                : 1;
+	__u64 reserved2          : 1;
+	__u64 giov               : 1;
+	__u64 gv                 : 1;
+	__u64 glx                : 2;
+	__u64 gcr3_tbl_rp0       : 3;
+	__u64 ir                 : 1;
+	__u64 iw                 : 1;
+	__u64 reserved3          : 1;
+	__u16 domain_id;
+	__u16 gcr3_tbl_rp1;
+	__u32 interrupt          : 1;
+	__u32 reserved4          : 5;
+	__u32 ex                 : 1;
+	__u32 sd                 : 1;
+	__u32 reserved5          : 2;
+	__u32 sats               : 1;
+	__u32 gcr3_tbl_rp2       : 21;
+	__u64 giv                : 1;
+	__u64 gint_tbl_len       : 4;
+	__u64 reserved6          : 1;
+	__u64 gint_tbl           : 46;
+	__u64 reserved7          : 2;
+	__u64 gpm                : 2;
+	__u64 reserved8          : 3;
+	__u64 hpt_mode           : 1;
+	__u64 reserved9          : 4;
+	__u32 asid               : 12;
+	__u32 reserved10         : 3;
+	__u32 viommu_en          : 1;
+	__u32 guest_device_id    : 16;
+	__u32 guest_id           : 15;
+	__u32 guest_id_mbo       : 1;
+	__u32 reserved11         : 1;
+	__u32 vmpl               : 2;
+	__u32 reserved12         : 3;
+	__u32 attrv              : 1;
+	__u32 reserved13         : 1;
+	__u32 sa                 : 8;
+	__u8 ide_stream_id[8];
+	__u32 vtom_en            : 1;
+	__u32 vtom               : 31;
+	__u32 rp_id              : 5;
+	__u32 reserved14         : 27;
+	__u8  reserved15[0x40-0x30];
+} __packed;
+
+struct tio_msg_sdte_write_req {
+	__u16 guest_device_id;
+	__u8 reserved[14];
+	struct sdte sdte;
+} __packed;
+
+struct tio_msg_sdte_write_rsp {
+	__u16 guest_device_id;
+	__u16 status; /* SDTE_WRITE_xxx */
+	__u8 reserved[12];
+} __packed;
+
+static int tio_tdi_sdte_write(struct tsm_tdi *tdi, struct snp_guest_dev *snp_dev, bool invalidate)
+{
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
+	size_t resp_len = sizeof(struct tio_msg_sdte_write_rsp) + mdesc->ctx->authsize;
+	struct tio_msg_sdte_write_rsp *rsp = kzalloc(resp_len, GFP_KERNEL);
+	struct tio_msg_sdte_write_req req;
+	u64 fw_err = 0;
+	u64 bdfn = pci_dev_id(tdi_to_pci_dev(tdi));
+	int rc;
+
+	BUILD_BUG_ON(sizeof(struct sdte) * 8 != 512);
+
+	if (!invalidate)
+		req = (struct tio_msg_sdte_write_req) {
+			.guest_device_id = pci_dev_id(tdi_to_pci_dev(tdi)),
+			.sdte.vmpl = 0,
+			.sdte.vtom = tsm_vtom,
+			.sdte.vtom_en = 1,
+			.sdte.iw = 1,
+			.sdte.ir = 1,
+			.sdte.v = 1,
+		};
+	else
+		req = (struct tio_msg_sdte_write_req) {
+			.guest_device_id = pci_dev_id(tdi_to_pci_dev(tdi)),
+		};
+
+	dev_notice(&tdi->dev, "SDTE write vTOM=%lx", (unsigned long) req.sdte.vtom << 21);
+
+	if (!rsp)
+		return -ENOMEM;
+
+	rc = handle_tio_guest_request(snp_dev, TIO_MSG_SDTE_WRITE_REQ,
+			       &req, sizeof(req), rsp, resp_len,
+			       NULL, NULL, &bdfn, NULL, &fw_err);
+	if (rc) {
+		dev_err(&tdi->dev, "SDTE write failed with 0x%llx\n", fw_err);
+		goto free_exit;
+	}
+
+free_exit:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(&rsp, sizeof(resp_len));
+	kfree(rsp);
+	return rc;
+}
+
+static int sev_guest_tdi_status(struct tsm_tdi *tdi, void *private_data,
+				struct tsm_tdi_status *ts)
+{
+	struct snp_guest_dev *snp_dev = private_data;
+
+	return tio_tdi_status(tdi, snp_dev, ts);
+}
+
+static int sev_guest_tdi_validate(struct tsm_tdi *tdi, unsigned int featuremask,
+				  bool invalidate, void *private_data)
+{
+	struct snp_guest_dev *snp_dev = private_data;
+	struct tsm_tdi_status ts = { 0 };
+	int ret;
+
+	if (!tdi->report) {
+		ret = tio_tdi_status(tdi, snp_dev, &ts);
+
+		if (ret || !tdi->report) {
+			dev_err(&tdi->dev, "No report available, ret=%d", ret);
+			if (!ret && tdi->report)
+				ret = -EIO;
+			return ret;
+		}
+
+		if (ts.state != TDISP_STATE_RUN) {
+			dev_err(&tdi->dev, "Not in RUN state, state=%d instead", ts.state);
+			return -EIO;
+		}
+	}
+
+	ret = tio_tdi_sdte_write(tdi, snp_dev, invalidate);
+	if (ret)
+		return ret;
+
+	/* MMIO validation result is stored as IORESOURCE_VALIDATED */
+	tio_tdi_mmio_validate(tdi, snp_dev, invalidate);
+
+	return 0;
+}
+
+struct tsm_vm_ops sev_guest_tsm_ops = {
+	.tdi_validate = sev_guest_tdi_validate,
+	.tdi_status = sev_guest_tdi_status,
+};
+
+void sev_guest_tsm_set_ops(bool set, struct snp_guest_dev *snp_dev)
+{
+#if defined(CONFIG_PCI_TSM) || defined(CONFIG_PCI_TSM_MODULE)
+	if (set) {
+		snp_dev->tsm = tsm_guest_register(snp_dev->dev, &sev_guest_tsm_ops, snp_dev);
+		snp_dev->tsm_bus = pci_tsm_register((struct tsm_subsys *) snp_dev->tsm);
+	} else {
+		if (snp_dev->tsm_bus)
+			pci_tsm_unregister(snp_dev->tsm_bus);
+		if (snp_dev->tsm)
+			tsm_unregister((struct tsm_subsys *) snp_dev->tsm);
+		snp_dev->tsm_bus = NULL;
+		snp_dev->tsm = NULL;
+	}
+#endif
+}
-- 
2.47.1


