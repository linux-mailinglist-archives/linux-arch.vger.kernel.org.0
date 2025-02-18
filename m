Return-Path: <linux-arch+bounces-10186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D9A39A62
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470323B6063
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39723F291;
	Tue, 18 Feb 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wz/STjJP"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18B1AF0B7;
	Tue, 18 Feb 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877287; cv=fail; b=EuNXqh7rjnGqy1OOPKer3r/HTJBq9BaEX5+BQ/ZK1hxJV/QoSdfon5LdB1TFQ9354tFrlhXTGj2MIRBkxZixwjr9Kpt/qPTIq79eV58GC5frOGkHbIUuuCunRPu1qRId4DRAKmXSZ9gT18hQvHM8TkLAA1vedn41Kvbu7CIeY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877287; c=relaxed/simple;
	bh=+f+rSWC9UtbHJ4l8a0NmLEt4Eyqs+jgkvTffKW7w67E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAxSsSXKWA525ZeUnvHMRlLbboC5lhStgroAIXuhIl75gxroPirEKzNU4gFWRZA+qmZXxWDrO+zKDNPZqA/q4lCruSNbGtFOdif2je4iwcKn79R+BLXISe+OPo+4jf+idNkQJ/t4j3oep/18SrGWF58mxjFXa6MQ1alL5U3ztO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wz/STjJP; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLigjDcv/eipMARl70iKHE5bXl6ctDD2a20wYiJ8WdLaYL8arMmV+SO1dzpihPtZjafi9tzcB3FXyHp/gwwfSZaSzOPuCjf7vTvIRdPRbyiZg7R5ah2d4VIPRS386g9nyRCGyzSFfEu4C3azQe9lHrRW3Q6xmVs49ae5dyXZVaTN7dVW4l6LztuIfSwhP5l52ropBgfEGsGsux5eE0fhcw9F/n5sGN9TuUU0hLIRk5Yoafit7lLipKT4dwW86dySju07G39Ez+D4X7I/bn1SDELgDcWwujRctdkxbxh3123noE3McCfhCvnG3317ker6xJth7RF9OstMwCe5SC8/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppgZ84PrrhxUfU+/rclO4iDOQx/xzWduKUM9nPWvVV0=;
 b=sQ1bSAAgux4vQo2k0pQZjGe8AGHiGzRZ+F5zw9EmpeIEZJBD5mwU65IaNgAJUMSWIw6h2dekm7DnIx/7HEeXBVD9TEvkPC8kN2y3cdfx8NB3fuvNUndAhb5IG2d/l2ARgm2NGCBjR3QB95UPb5TsWYPhjPF84jhvN3NHpJK05HcOyCFGgRncdMEuCeCyjzKzZQ8O+H3loQb/K1j0qqw0VTbSbpNC4ztKyoRP8xHwnRPuJ/Sz+sZhUeuTFue4q5R0fwQhmiHD6FW4xAqPT+Od1PQKEEX9j56jHgF3kNgT/QQvscWLC8AjFGHWufT1PhY3VonuGxQXWr58KSzgGV/SmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppgZ84PrrhxUfU+/rclO4iDOQx/xzWduKUM9nPWvVV0=;
 b=Wz/STjJP3sDY6TnzGhzDGGu7SvNrOZKhLagMomp9j2SsozSQiHwZO+/C/wyzcke/1vgupIgoWsOCI9+wEI7Yk4Fhnbi2IkzRu4SKnHpDV0DDcOTAPSM7oXbHThNVFoqG0AF092LUTyxBcV4vMPsmNGZytDgGk8xMTAL1SKnwHIQ=
Received: from BL0PR01CA0015.prod.exchangelabs.com (2603:10b6:208:71::28) by
 CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 11:14:43 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::c2) by BL0PR01CA0015.outlook.office365.com
 (2603:10b6:208:71::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 11:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:14:43 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:14:35 -0600
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
Subject: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Date: Tue, 18 Feb 2025 22:09:59 +1100
Message-ID: <20250218111017.491719-13-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c3facf-837b-4da8-0a74-08dd500d71d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w5IfIYMgEX0v30MHeMY2AqH+G/14aXFpt9bKPJqUb5RBeqq75YQ21e7HDew9?=
 =?us-ascii?Q?7aQQnqXs8NRs+hDSzNboNgW+i0r4/31kZN4MMP+neU0gvhZYsNolijoVdVnB?=
 =?us-ascii?Q?as9X39i6/FrT4dNs8sweVlk9I3g1nuOq7z80BCEqpk6CKyuff9ebCjtEZ0V0?=
 =?us-ascii?Q?M7v2OEnsVOZJQF3/L2Imz8uc8KtjPFlDUVvh9tcdknmNNwO7rhf5dCE8TMd3?=
 =?us-ascii?Q?n7OX1ivBUYL/FyezntThbR3CI6CbTk+IjaeqiMm0pGiPkEdLNiStyS59T9+e?=
 =?us-ascii?Q?Nxb7oh1qhtFhJS4NRNwnYmiZ3GlDh3ElRJvw5k/VhCaOIpB8jaSfj348J/aM?=
 =?us-ascii?Q?s2L0y/WrjCuiK97D0kdyQp6IM2vSG57BjtKNyeb1Hn4APb1fcuU7V7RyJTjV?=
 =?us-ascii?Q?ZzFE0JMocTfF7wlubpFK1pFCOKVtEqhKex0CNbyxNU/qoHh7G6avHrmTnIu5?=
 =?us-ascii?Q?RzeembwX5uxCmufyTTdvZVZg+ukxeTVGSood3ICVfRmQ9pFwacFiIxMSPM8r?=
 =?us-ascii?Q?lxCOGvS8KqMwaEuzdnblMH/IOiHhQTeubUlRmehlalopyKsjmZqYH6hSwOYY?=
 =?us-ascii?Q?VKJs78cE7E7PuPhubFYuCqhAOh3wMPwuKVvqCFuvZd9/UYpj/LoOjRZiLSSz?=
 =?us-ascii?Q?b8afNuPg7Hq14b8HoPkd1ERxReUYVWPq1YbtZKWIqokqZ/TRd4fRgitoqkIo?=
 =?us-ascii?Q?9EWi0e1XgF97cEGddJDAb61REkI8FdDSkkLcyq9Z+WC4xtWcRl3TW+u39wuk?=
 =?us-ascii?Q?RjmmuXu6FpApTof8KmeC1ylDXFkO+hmLdfmo0wHWF2bMbpItJ1Ya4ZRpawsm?=
 =?us-ascii?Q?zBu1meT++RT3WVD/E5mcHA9KCKqA4l8R+Zf5U1/JxUdk3kAWOS0O4TsKUL0U?=
 =?us-ascii?Q?Zh8XGxaxPKr6Sk3ep4aEYfIybsaCh20Fv3MA+J6sCM1VXQbVlBekDHIZ0hYD?=
 =?us-ascii?Q?5Nf0gklO65SmW3hr+sKIWZFbJ3ghfMiFtvCb+w59cmKreyGUi2k/0xaQoBT0?=
 =?us-ascii?Q?T5yhmwHi7RPVJzfOgAesg+7fCbhZmcoz+CjO7W0CY69xxtyIEBDtJiokwamx?=
 =?us-ascii?Q?3E9RKZ16RDBI0sZuo/Ar/65QxN7lvW16lLESd4+Bc1k3mog0vIvp22ZvNCrS?=
 =?us-ascii?Q?55IZqwvagucGUJtba9N5xLGM8RyIYb1fO3G/anzJ9vExC/KcLdKasz4fyu9C?=
 =?us-ascii?Q?gBhWWDH0xwDegHo9U0OLup1xzsjxn6Ow19fQTbyOkW/EWD1vI19pwNCtCikb?=
 =?us-ascii?Q?Puelt9O9w6k+/UkM828fJvBI6kFArF8NZe+EgfLxNB1t2/7ksec3FXOCTLqJ?=
 =?us-ascii?Q?SwufmUxtJwsCoYdzgCX00CvXUFPKkh8Cmq1alKm9tP7QzHg2yPeobhdgsq7F?=
 =?us-ascii?Q?f3yYSmzWjMiZHFzSV1WUTiic/1KaDUqdrNapVD2DE2aOn/tKq22hrhPEBdjQ?=
 =?us-ascii?Q?gQoOqpr1cRQ5w1uJSCGSNIRZMlTPhmvmJikeMr4o/zxqXeDqQ8VfMgQoga9C?=
 =?us-ascii?Q?Wd2qAevRO4Wb7vU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:14:43.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c3facf-837b-4da8-0a74-08dd500d71d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

CoCo VMs get their private memory allocated from guest_memfd
("gmemfd") which is a KVM facility similar to memfd.
At the moment gmemfds cannot mmap() so the usual GUP API does
not work on these as expected.

Use the existing IOMMU_IOAS_MAP_FILE API to allow mapping from
fd + offset. Detect the gmemfd case in pfn_reader_user_pin() and
simplified mapping.

The long term plan is to ditch this workaround and follow
the usual memfd path.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/iommu/iommufd/pages.c | 88 +++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 3427749bc5ce..457d8eaacd2c 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -53,6 +53,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/pagemap.h>
 
 #include "double_span.h"
 #include "io_pagetable.h"
@@ -850,6 +851,88 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 	return npages_out;
 }
 
+static bool is_guest_memfd(struct file *file)
+{
+	struct address_space *mapping = file_inode(file)->i_mapping;
+
+	return mapping_inaccessible(mapping) && mapping_unevictable(mapping);
+}
+
+static struct folio *guest_memfd_get_pfn(struct file *file, unsigned long index,
+					 unsigned long *pfn, int *max_order)
+{
+	struct folio *folio;
+	int ret = 0;
+
+	folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
+
+	if (IS_ERR(folio))
+		return folio;
+
+	if (folio_test_hwpoison(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return ERR_PTR(-EHWPOISON);
+	}
+
+	*pfn = folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
+	if (!max_order)
+		goto unlock_exit;
+
+	/* Refs for unpin_user_page_range_dirty_lock->gup_put_folio(FOLL_PIN) */
+	ret = folio_add_pins(folio, 1);
+	folio_put(folio); /* Drop ref from filemap_grab_folio */
+
+unlock_exit:
+	folio_unlock(folio);
+	if (ret)
+		folio = ERR_PTR(ret);
+
+	return folio;
+}
+
+static long pin_guest_memfd_pages(struct pfn_reader_user *user, loff_t start, unsigned long npages,
+			       struct iopt_pages *pages)
+{
+	unsigned long offset = 0;
+	loff_t uptr = start;
+	long rc = 0;
+
+	for (unsigned long i = 0; i < npages; ++i, uptr += PAGE_SIZE) {
+		unsigned long gfn = 0, pfn = 0;
+		int max_order = 0;
+		struct folio *folio;
+
+		folio = guest_memfd_get_pfn(user->file, uptr >> PAGE_SHIFT, &pfn, &max_order);
+		if (IS_ERR(folio))
+			rc = PTR_ERR(folio);
+
+		if (rc == -EINVAL && i == 0) {
+			pr_err_once("Must be vfio mmio at gfn=%lx pfn=%lx, skipping\n", gfn, pfn);
+			return rc;
+		}
+
+		if (rc) {
+			pr_err("%s: %ld %ld %lx -> %lx\n", __func__,
+			       rc, i, (unsigned long) uptr, (unsigned long) pfn);
+			break;
+		}
+
+		if (i == 0)
+			offset = offset_in_folio(folio, start);
+
+		user->ufolios[i] = folio;
+	}
+
+	if (!rc) {
+		rc = npages;
+		user->ufolios_next = user->ufolios;
+		user->ufolios_offset = offset;
+	}
+
+	return rc;
+}
+
 static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			       struct iopt_pages *pages,
 			       unsigned long start_index,
@@ -903,7 +986,10 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 
 	if (user->file) {
 		start = pages->start + (start_index * PAGE_SIZE);
-		rc = pin_memfd_pages(user, start, npages);
+		if (is_guest_memfd(user->file))
+			rc = pin_guest_memfd_pages(user, start, npages, pages);
+		else
+			rc = pin_memfd_pages(user, start, npages);
 	} else if (!remote_mm) {
 		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
 		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
-- 
2.47.1


