Return-Path: <linux-arch+bounces-10196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63CA39AA9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE853B6D10
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937724110F;
	Tue, 18 Feb 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6inxWo4"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD508241102;
	Tue, 18 Feb 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877493; cv=fail; b=o7NXx2Mk/Ejg5Et8YMHlDanpVpqK7IG6j3Z0uQjTti3ZuGCLMh+PSj63dPF/bTbbPkwwZFJTxV3Mh/ntFG3b/hmUVhIOF4Fuv6mJUf9N9Vd7I1JRBspWZDfFkxSG2P+4/5MRurbuHSGbu/tTp6OHIpm7c5byRg48t+05Wvyv7OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877493; c=relaxed/simple;
	bh=DnayqJBxOYrvgTFazHs1b3353D56A8Cc+Nj5T6CqWCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2VWK/nWxMpvalslOaTNv6i8h2mATyXz/+efw43fvRoJzjfsVmOIs9dxuR/eRCfB0AO2pODXOvasJr6+PxLlAQ/XoTloevXeDm2P5nJQHnwZ+rvWB5xgzBtdBKMfh2eTkuIB5Z8KAd0zOmdmQdWHCydVg8VLhQPfEEBvv/U5zcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6inxWo4; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUnpevEc0TLwLSBR4iZxojvOFoLvwSAL57GZckZg4geFQriZTE5nxAU8jQXS98CKX8Vsl25a43ZyuYoBP1XXtk+iYnIIMytZS+cXdb/1tjAoDfitH3J7HlxyYSOB59ZdtnQFhTrTk4HDaRPkY/CcRamT60H/++byG+MeNYPHwg1cCDekL7/Bs4NzF9yBQQ8wM0iEnaJxeUyuIZulasEMVE9glkvtwkADfcZGt6OTL/awoEAV1x8TQ2JFh1w/vYM0GfFEWqv9DrEC7/EO9tTnXM25winIv5n8OnMEXEmapF47QWNrQuU0iYjRr+q5BBAMxjqIjPGYZ5q0SCGkRY0GUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvxxSAP18WOUT26gcgIEkRQ6QsFxwX3a9MuNkpR8o0s=;
 b=Lm8QNgUrw9PMc9dkLuXOrZiTJNuLQx63Saw8hVheQa6SjvTiBzOyKOjNjwaJ7ey9SMxX66+fIDHSW95/hNrvHVQaKbw9lehMTxu22aV/2eE86CD9qJq7qz+FOr4BzkobHJ+eJwJ4UrxSJ36PogzGp8qL2h7RzBt6r3kBLTSlmWW1LqLd/Up3Vqn5Bs6zvqAnIFI6fBgcFKaq6j0rytifvnTZewfeueHsZyNgb8k+3n/oagEIQJbIrPQAwuWOz6+f6QTE5B6RldpWIyjvqtlNlcFY+EzKNxBJoijxALxIUiejY8ScHVdrFQPAzldQOguvkyLf4SHHyyeX3jKbpPoxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvxxSAP18WOUT26gcgIEkRQ6QsFxwX3a9MuNkpR8o0s=;
 b=q6inxWo4UALLuBl6+h8vT+FwzUwigZXPswsuIDdRW1OsgeHJGdWxzK41xsF9RSScd4a34AYAcXH6tWppUQN/r6Lyn4lfoUUEgXWnoSNPspY0iIcm1TSVNMdRRmA0OQGQvf1dB19khWIa6BsnGCgt11gAr08+rLSdq7alM1D0RIg=
Received: from CH2PR07CA0038.namprd07.prod.outlook.com (2603:10b6:610:5b::12)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:18:07 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::dd) by CH2PR07CA0038.outlook.office365.com
 (2603:10b6:610:5b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:18:07 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:17:59 -0600
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
Subject: [RFC PATCH v2 22/22] pci: Define pci_iomap_range_encrypted
Date: Tue, 18 Feb 2025 22:10:09 +1100
Message-ID: <20250218111017.491719-23-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f4253d17-2324-4b4c-e9bd-08dd500debcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zZUwG/y1EtX/mUIyIDArN4CKOPLjA8jNjDf8Tm34T5egLdW/4bWbTRD4Lxxf?=
 =?us-ascii?Q?X2dekdphnyqFC+ljMGjmnpCL8AliF5yrWjRVSoEXG5KPvufaLDC+y82WKkdr?=
 =?us-ascii?Q?J7Lb8WeJd7G+PvqSTAng3PS0rW9OroCB70rB35JPSwEqL9joxhfpiEPgL6Lz?=
 =?us-ascii?Q?gUxT4FVfwEVOF/3D6J754z5QvuhoD4u0R+XuAZ9Qq7+MmLTtTB2z7LFz6tAk?=
 =?us-ascii?Q?uVV2Xg2NukZ7WmOSJM9CBcU2lENIVT9NysG+k+1NZ2E2sISO+KwMyTOq3TOK?=
 =?us-ascii?Q?JdgzkKijF5Y2usJGOBEyFqhk+L7cdlruk2ctawGgXwbAOyuzJ9rKKZkuhPAl?=
 =?us-ascii?Q?2CjTB1Vn3SaqNRNH7Z8Cjdvd+4rUGWfsWZowXyuae12CGhRUNBGa9gZQMeei?=
 =?us-ascii?Q?dGjK+WBX6Jfx+zRo4sxUPa12g0ydz8dLczlqXNsP7+vVVQi0g8fel9yHl3cu?=
 =?us-ascii?Q?4nKaz2grYsaD2wDmWHWF90ePpObNbxsfxM/1JBS6fCSdFbci11MmY+NUpOen?=
 =?us-ascii?Q?bGfxW7l5TE/0HnE5fnvxL6euMtiGUYmJ5EIPudkHnEw8zuQWa9bpb3FW3O+4?=
 =?us-ascii?Q?OhrDKgqFKYyLXm/gnfQoI/hcjs/1R3BEeMWQodq5Yu3pmDXoFOa9NZHXGWkQ?=
 =?us-ascii?Q?fFRXXRXS1li5we+ZmSG+IjtsiVGNZYyk7C2bsN1MTqivItLg8AL8b1/5Z5Qu?=
 =?us-ascii?Q?1mcBpHXDZp4F1pCxhGybnIbw+WaicdJQg7fdFAjOHr49Ae+LLQKMCjrWRK5+?=
 =?us-ascii?Q?YAa4MAjR9om+7kqVosdp+0EP3KR/eQbWbnQTn9qwSYHvAHRvyUdp37u50uJ5?=
 =?us-ascii?Q?AhUU39UZUqSZCabLiwjxyz+Va8wBDyjMrFID5GuDnlJE0ZdDQla0+h68RyD5?=
 =?us-ascii?Q?N12NDDPJCT/GfNQXQkEmmRXjuMetNJGZuTYmmfw3v38ujFSQ6N1rlKZhJ+3C?=
 =?us-ascii?Q?w8Q4vwi0VQlvYKzGAy1KTCKnXt/G4b+UZxG1uczCIYbIYmAj+q94921dkTiG?=
 =?us-ascii?Q?Rnp4nDfjOevMYyVvio6YLIwDA/ZzduQ+LQk9pgfv1PBjhy8y7/2fnw1Kx/Ni?=
 =?us-ascii?Q?Zjd1eXvbaulVTfPn9S+izC3vfp3pvyEwU2854EF/UWx2Mufh5mGCcOmX2OMR?=
 =?us-ascii?Q?Zwx3a77zk8c+VdEh5mtuvmQ/Rx1b+jd9YTLU859uFSvySB0XU5HYT02GxGSl?=
 =?us-ascii?Q?pXabgAtD0+ZVtE8BRmwiO9SAabcQhVfSe9oU6kGmoaj3uMLh5AsXIeV/Aja+?=
 =?us-ascii?Q?t9w7DpG2oY3n66AmFLGWcAWN88kx0E9CYKhGtPARDdg64koNmbekoubPBL+i?=
 =?us-ascii?Q?rV9KXmQwYtYq2+UObSsWofbHqNBy3OgRZax4Gpcu6Enkuu8Lc5NZjB8JnhGG?=
 =?us-ascii?Q?8FNk/zQYH9qjh/Qe0Fxx1Ikz0qXerdgZNhBI46iEwU1cybBfQ+qjf/EFJLT9?=
 =?us-ascii?Q?XTFcQSelcy8iH4jB4IXd5x2DpeHKy529HxTEvXENfBXmx/w/GgA10TRkZXIo?=
 =?us-ascii?Q?EMjRCei8LNeGKK8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:18:07.6503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4253d17-2324-4b4c-e9bd-08dd500debcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

So far PCI BARs could not be mapped as encrypted so there was no
need in API supporting encrypted mappings. TDISP is adding such
support so add pci_iomap_range_encrypted() to allow PCI drivers
do the encrypted mapping when needed.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/asm-generic/pci_iomap.h |  4 ++++
 drivers/pci/iomap.c             | 24 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 8fbb0a55545d..d7b922c5ab86 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -15,6 +15,10 @@ extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long ma
 extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 				     unsigned long offset,
 				     unsigned long maxlen);
+extern void __iomem *pci_iomap_range_encrypted(struct pci_dev *dev,
+					       int bar,
+					       unsigned long offset,
+					       unsigned long maxlen);
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 9fb7cacc15cd..97bada477336 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -52,6 +52,30 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 }
 EXPORT_SYMBOL(pci_iomap_range);
 
+void __iomem *pci_iomap_range_encrypted(struct pci_dev *dev,
+					int bar,
+					unsigned long offset,
+					unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (len <= offset || !start)
+		return NULL;
+	len -= offset;
+	start += offset;
+	if (maxlen && len > maxlen)
+		len = maxlen;
+	if (flags & IORESOURCE_IO)
+		return NULL;
+	if ((flags & IORESOURCE_MEM) && (flags & IORESOURCE_VALIDATED))
+		return ioremap_encrypted(start, len);
+	/* What? */
+	return NULL;
+}
+EXPORT_SYMBOL(pci_iomap_range_encrypted);
+
 /**
  * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
-- 
2.47.1


