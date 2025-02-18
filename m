Return-Path: <linux-arch+bounces-10175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E75A399FC
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4118716DEDB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706723AE95;
	Tue, 18 Feb 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQbaNl24"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE672397AA;
	Tue, 18 Feb 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877062; cv=fail; b=arTMWsEdW6jPsrDzWRiAsLmppAaXxx/j+gwajEQH1+50y3li37/IyVOwqfoinigUIe6ikyrUCTyZMBkff7+QhIf+dxnfFejG0FZ77xve+v4hGVBXywMA+dam8DnsFkaDqT789FBVM9kkWPyOezM6HWcpAWf4rk7QIlOFr4W0DYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877062; c=relaxed/simple;
	bh=yZDw9GrHj+wqH8ZY1ceCx4TX2m9lzWnKAUnHNfCXXPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkrgjbBWelHXm+nrL/shLv16xTwpwN7gvwp/FNImEXfs9bEovpbBR1Jn86JrL0PYHvv03QFYG7plSPAMtlgOyv84MicHy+0/WVjR+HdqADbvII8oFa8QPq9DTiLcWLEI2ow0vq/rvt6eorPpWeLKdsg4WJQ7T9F69dqieBKeVnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQbaNl24; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+j8tWiSoWlW8Xr4RkZUnMo7+A659Pgxpr1NJmPg5oJuK9A6pwlSQune5iuyPtYQHT34aGgcvnDTIdmJ9TAEyspChVX6Yp68DZi2ksotRotfdPS6NwdWKsUmieudVGQIL1QymoGXRjSe7jVgyLaZkS76K/A7LozHFRcNEEObGHdznBdNz4CLm6vXytPfiG4iUoUGaA0qS4D1QylqhoHtvoCATN/I70gTnQU/+tdnEOq3nb7Mn6qgGStHrN+nvQI3mHaB2gm+54B0AkSsuFG7X0ejf19f7jRSCvFSgHqD1DhpT7e4LF+4IM95+2ohVdu9yIGe2a1LJ9KGbbWI1Ukkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCAwqqUdJ+HI/4UA+HiyjrghrqXWy4ML5tMIao2i0oY=;
 b=u0vPnSA+wozMOyO7ehpHXTNTinT3jwEXXkX5h4u4UWFLMZKHdsq7DXubwmSa/18/Y/qKbPVQ1fEyIu9yIMy0nLQJV/9Y82jbMjUKykw1fPiyuf/5OczVtKJbj97sXIdRBcSw2nOSn8TKJozggdGU7Qe/eiL+3JxXlnt1GKWaivs36y6UmTU+tKLn/gCvM84SU8Q5IJFd9QhF/4JzwLqugh16vS6bMtua2p/DXup626uh7dgQu3OqLKF2efQD41QS1rJZfF7rPiYNJMLTvDoogFGcA+wHMGrKeWv5uJ+6MPZ2hPnuEDr6iW3eI3lFC4fAYRgkn6/vziiwGZvhqgZNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCAwqqUdJ+HI/4UA+HiyjrghrqXWy4ML5tMIao2i0oY=;
 b=oQbaNl248Z+Y5mbhxVDkWyW5CQ+493EP4KBgX9gKYn+e55jnvjGDxK0k6ty6qjcePa3X5LJOvXKUI/6IoqulGnJqBNHIaF7nRS9Tqqi7fjiJLelIIJPl8bxxBPVIyEiYZHRQAdyhLwwest6AsCHSTj/t3NmV1zPpRbwe+hFcdW0=
Received: from BN7PR06CA0062.namprd06.prod.outlook.com (2603:10b6:408:34::39)
 by IA0PPFAF883AE17.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 11:10:58 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::7c) by BN7PR06CA0062.outlook.office365.com
 (2603:10b6:408:34::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:10:57 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:10:49 -0600
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
Subject: [RFC PATCH v2 01/22] pci/doe: Define protocol types and make those public
Date: Tue, 18 Feb 2025 22:09:48 +1100
Message-ID: <20250218111017.491719-2-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d95f68a-e84a-412b-8ac7-08dd500ceb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xSDgf5X64mDvQhLM2LNrUf443uSbJMgRnvkg7g24Vqjrd8Hov5OryqpqzlOm?=
 =?us-ascii?Q?kEPM1vmy+84rxIxXqu58h5bsW13TDFzIn/McXYCtEcwtyRgMaKI7LVUn9d/G?=
 =?us-ascii?Q?YPHRAESe1hgnS5HYFpaBkCeuKWhAokZIEv3K//39gAQliGfM9aPjRXyMPoUD?=
 =?us-ascii?Q?w63M2YEHg0opfc/JEwrNmgWVGPuFWg4GOmK5p/6dyvyQw4TR8duIKDFyS2s+?=
 =?us-ascii?Q?VUa8lPlUqQBu0+KoK/qhBg/c/rmNpDUxPH9QSUVeO/0ksTF2yClfLTYln65p?=
 =?us-ascii?Q?PhpH+WJoY+lLYWhD4NoruY6tOpTR6YoaQ9ZnhIgg3qhxQ520JZ+jAdhvLH22?=
 =?us-ascii?Q?Sbh7+4m9M8CtKaLuZxYkkx/EJ41fOvoPCLqjvpsgrVBWQmnOsdtEuWAIfi2j?=
 =?us-ascii?Q?mYpmUoY+JBe6F8V8RrSueOe1vtwF7pvtX8Qr4V4mx/jgr0Kis6FWFHG6+yDF?=
 =?us-ascii?Q?PNta09Xjq32ZBjN4I8kMhTUcCelby7CFrO9+EtJ2L9nQFKXbC/wF2ZAjbEby?=
 =?us-ascii?Q?EqKQrgKA32BgYIdNTddFbvAQqVYemH6HZs6eGbWkBvF906SWHwLcroBpOafk?=
 =?us-ascii?Q?pQlX7FcrTlMmo3OUFA//ceMSM/3ixpP25ajyuqEZDt6JCpi+X5YgpLhvq6Hv?=
 =?us-ascii?Q?Q/Ez7o0ChOu+/Kn2JvEcoo3FNsGha8QzWOt0Zsjgt14qMLPA0ojDarZSNXRj?=
 =?us-ascii?Q?38C/vc5/qY3VgNqvHRMDJZHy0OY7BUmeAUojISvDd/Dvs1Qyeuog46ntWNli?=
 =?us-ascii?Q?vtxG/YiGa0STxPD5HP7sEGDqyzc9lGkwdG1H1NMIoI/xpz075icC/3MgsVUO?=
 =?us-ascii?Q?C8I6qFDpzwVbPhWSBTJSZAtvWw1YlO1F6uJBsOAcFZRppe166zvBLyXm5HeK?=
 =?us-ascii?Q?W3ZQKjIFp92UmLu609z7cwIocVYt37u9PoHW4M9cT9QB1YgeY3Z9ZY+iCKbn?=
 =?us-ascii?Q?FVYfMuXLBE91VgseLvP+ZNQS6kwWL6eVbFXSl81FGoBJER7tAGU/0UIe86G1?=
 =?us-ascii?Q?EjTqgIr4XgsT0rdsVnxP1qoOvna3tNpdDSpCwflpRPeKFw2dANcSahs0sJJz?=
 =?us-ascii?Q?85M+qYUn+VFxaic4fx1/NGK65XFYMgy0yZMK9L8DLQtmfuSzYc5IKHMtVNxk?=
 =?us-ascii?Q?oDX+AwFfcekMkxnt+M40yNdW3xtzIwS/t6ug7MvfuVHQjlkLt1tM9snrb4D4?=
 =?us-ascii?Q?TxVVitJA7F76wynu/tskJogP1Ws+tdDZLZJcCZXc1EV200zx5EZH6dA7ZYb9?=
 =?us-ascii?Q?FOvARlaHd6zmMGNOwdSdoFGq6VMyG0emKwKud0bklUDV181Ck8Ny3SBB9i9E?=
 =?us-ascii?Q?huj600qa5yMVWvAWgGnD2JHNpmt0Y1RiDgFabJVg6gx7RZWpOqFT5Q5hcMYb?=
 =?us-ascii?Q?sBnZ824KW2FFpTU2aFi80OQQ+EyzUfCHLLITNLVncHd8gmZGXm85fsHt8oGN?=
 =?us-ascii?Q?yCTozBJb8Wzr4Cnl8LmFe0CXY/AoUbJ0oKfJLJlKWi3VqE2wI/mZ6Se1JwSW?=
 =?us-ascii?Q?QjwtIlVJBMuq+Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:10:57.7736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d95f68a-e84a-412b-8ac7-08dd500ceb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17

Already public pci_doe() takes a protocol type argument.
PCIe 6.0 defines three, define them in a header for use with pci_doe().

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/pci-doe.h | 4 ++++
 drivers/pci/doe.c       | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 0d3d7656c456..82e393ba5465 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -13,6 +13,10 @@
 #ifndef LINUX_PCI_DOE_H
 #define LINUX_PCI_DOE_H
 
+#define PCI_DOE_PROTOCOL_DISCOVERY		0
+#define PCI_DOE_PROTOCOL_CMA_SPDM		1
+#define PCI_DOE_PROTOCOL_SECURED_CMA_SPDM	2
+
 struct pci_doe_mb;
 
 /* Max data object length is 2^18 dwords (including 2 dwords for header) */
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e4b609f613da..98fd86fae8d8 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -22,8 +22,6 @@
 
 #include "pci.h"
 
-#define PCI_DOE_PROTOCOL_DISCOVERY 0
-
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
-- 
2.47.1


