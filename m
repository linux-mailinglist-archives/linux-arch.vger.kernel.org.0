Return-Path: <linux-arch+bounces-10195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA652A39AA8
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F33B468B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812623F286;
	Tue, 18 Feb 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJFGJtBX"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4B1AF0B7;
	Tue, 18 Feb 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877473; cv=fail; b=ZKJsQw2+xUzd56NcfmtMu7ZlecXDLnsHc2AAMHDTdO2kMA3AycUHZ7ljW8/fyMwnuzYx9f+T2ZhrIPhQ7Cx6ylf48PvsxrStDc2vEqfryKqMBiPPBnQAHE/+mI09G7/3xVhbCeFbgrw++IJLCMGQu7q+fXmR1wPg0uOw2+MZpcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877473; c=relaxed/simple;
	bh=/2WT13l/W8Okz2thfVxg2Py+STQleJ3jD6xzMtfLyvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avieuAfqaouyqfZTNa/RsiVIwEjj3CtUb6i2SdQvt8jRQaYa9w4FRnuxKTsX4hQBoYHwAjI64Xs+H460u/mtL7x64QFn5qFbatnATmKULYqD2RNNTHhuDQGo79MjvTcHm7ZGQj14xFF4cdRtXYNXbuuplXAiEDCXYO/kTmZGF/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJFGJtBX; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at3ZuW2Nni4MkoI8X3AMQs1cH2zO1kMl+G26Kr9qKBoMJ4M7Pt5oh7g/pZN+clAkI84/aYplf9vXJKpCushrsZfJkq6E62/0zGm4c7H5Nc3+DnNMycSBP7vqILZGd4ujTnUfpNkVO0dx9XuYcHXH6jV9DCFghy7MK2TjpzqGOD0WEQ29JVsD7Tu90QngeCvAlaljMIhv/sFFJte8uqiDZgUImLH7C5sOTM4jVFMXvLyIpbZ4c1e022Yb3GrUr8TjwmFI9rOnL1AXfeeK1T0g+K65hoi+oiWXrMhQfwYHu0Cy1mFfhgX6L8nTzqoBnNIk/PABw/UDRC5Y6Ly/MdMqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6NGfW1CFdAgc4lpaqDg5VE0bJlzyxSJUAO8qXkrRhc=;
 b=ZirAltjk0hObA5CauSIPeypyqV4zzMv1FS6gJyzcSnSQ5o0PGB4+NqH418e/WxPEo3B6tEONYQ7CpsWipIT76HZpYt7insqIr5Gu0QNvrpysvNZr1W3q8/Zp+u0bqeXYkXk4SY2Qm2JvjhcluwJgmi8khXTDzsgeEyhlqXHDlgjoGLofi3+FBnsLHPsQJ55JDAzEZtzSdiVu8hd0s1Nkgu2lFeOBK/zUaDUA1ewU8Ha3RFWoIWOqx0cXuS9iqAUz0HP4GFSP9jWP7lXsN6gayudlkaTPgWVUH6VNbHgj46D7fvK7B10bmKlU3loGTeMci1FEzN6rCQexB9rEnUV8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6NGfW1CFdAgc4lpaqDg5VE0bJlzyxSJUAO8qXkrRhc=;
 b=ZJFGJtBXilfU8GZHYgcpGBgv5aVWHD2TMzsgRimDjVtkxXgFoC4wAnVgXJCBkgO/PEKzOs01LHSaHePGYkdh+xFkt+n8VzkzTYEwuElaBsO0wDPrNJM2yTcQCihqYwHv3HhhUAUPtSy5sDnrJq89LzeZPI+5jkFXrSaGFT0O1nk=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:17:47 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::61) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Tue,
 18 Feb 2025 11:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 11:17:47 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 05:17:39 -0600
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
Subject: [RFC PATCH v2 21/22] pci: Allow encrypted MMIO mapping via sysfs
Date: Tue, 18 Feb 2025 22:10:08 +1100
Message-ID: <20250218111017.491719-22-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: a94abe54-1f3b-4f63-02ac-08dd500ddf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXRwlDm+nLMA2QUbQfBITFM/RW/7MuwMWilBsU9VCf2xBBOT6iqmDELsn50M?=
 =?us-ascii?Q?PdzbrL0ZIK/F3dOccL1XeUhEp5m30phgYIOg6AJcnl+HcsqRWZWitPCq24rs?=
 =?us-ascii?Q?bkKHzfcKsP/0JVSEJb/E2wEZC9aSSh9+jo59kybBIMHayu3z5xdWDsMGUMrT?=
 =?us-ascii?Q?VZGPhXXDZq3SiESPsdy4o1ukMON5EhHWuVcgQYp4VOEUhq5ArHHMyIBOt9/M?=
 =?us-ascii?Q?WA9goMMgBk1X8Dtls506lECEPUF3/xsAUFvI2eHbmqnblQctDNu87WEZbQMA?=
 =?us-ascii?Q?CXqitsaYOOL/Tp/k+ojsAJ2OLAoxyfcOzq/3cIF1NobBM/xir4s4LR92mx0f?=
 =?us-ascii?Q?IjT4Bmls5e1Y/BhSW2y6N9MHLWehgb8jaDG4r8BDwZ/lP5bgkYADalb/hHIM?=
 =?us-ascii?Q?dOuHiF8RnSPdlTt6ZMi8SIsqjhU6EOSdnyq1m0s8sd99vqSsqMTn9M7sixKy?=
 =?us-ascii?Q?YnovZUgSjqiiA/hEHbHFGEM/8pbPEhzEfy82ldWuMwgSi6I1pqF838Yd1Izy?=
 =?us-ascii?Q?64kw0qs8loLCPPzCfrz8uoxJ4zwCe9LbQeAzHYHZoJsKMsoIG9rD4fI+kXgW?=
 =?us-ascii?Q?QS2/WzJIjQKo137yDf5T1ap51OtTUBapFlKrSdQ/jZ6JzG37U8tiSpeDE6iX?=
 =?us-ascii?Q?iraZvuNNw5OeBO8AbQf2V7LTR4myT+EOIaTo4YwfNF59eWw2CPoJd7afnyyt?=
 =?us-ascii?Q?EiYrk5WMyFJjEaXFH8Pc2ZkYGe2HLEBf/tqpZ8E/8nb5qvkvDZAr7Mbi7uUJ?=
 =?us-ascii?Q?fHbt2ljhsYFy7bPMWWZHCjmBSmIkwprXhjk+/fb0oWqpHbz2eqeGJlseESSo?=
 =?us-ascii?Q?F5WV+KVfV4KJPwowgrdhXHFZPTt7T00VEucCbWr+FfXhoZs7HunJBb9lNimC?=
 =?us-ascii?Q?FsKOCe+WbpoX8w2UAxAbCEukAHF+pNWZPktn3pyTK92EJ+YLb7PonjJ3ISA6?=
 =?us-ascii?Q?ik/A4Hs7XxhsHkSoYkJkgo8DyVpfNIFwlEXBMVA5aK4Fr7lyguWiKmMm4wW1?=
 =?us-ascii?Q?Q/boOWnWUzU3onep4pj2duVSOoZHiYKgrx1SR6Y95keGigimbPn8NxFlI1tt?=
 =?us-ascii?Q?RQrRh/8gGXlFWeVqTIKP0LhUoGihwecBNXM+WJQUcuWB1BgOqZIVXo+sQpz5?=
 =?us-ascii?Q?oZ8INU8XQtwn/LDoam3cg8iYtHXLyegsvE+4cgNxbUzGgmmOXuTDkfjLkOJB?=
 =?us-ascii?Q?i+pYoq6VwHFXLBwjWuQw80W16Sr5QHGICeb84y96wb9i6/GNnBcXzzuBorr7?=
 =?us-ascii?Q?ikrQQTi4EtxEP0lu/3W0PtdQd0cpUsTfbTh7BNUV3x9rJx10+77HfjLaUoKA?=
 =?us-ascii?Q?ZQxTyai4Q1LNI2S/aEJY/JEbw4bhPAYisrBqt+frkqr/FmIr9CEBAPUPzowL?=
 =?us-ascii?Q?lPYsmUA4W4B5p9qNJZ/9yMrQ8AbDh8v27MU0DKVkEnYjohv7e7A8oO9bfAER?=
 =?us-ascii?Q?x7vM689ujUShhv8h865zbKW5BolYQ3zphZiSFZ33T4c4p0Z8r7nfkDZnn20H?=
 =?us-ascii?Q?7oXW257xWM7Bkz8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:17:47.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94abe54-1f3b-4f63-02ac-08dd500ddf8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

Add another resource#d_enc to allow mapping MMIO as
an encrypted/private region.

Unlike resourceN_wc, the node is added always as ability to
map MMIO as private depends on negotiation with the TSM which
happens quite late.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/pci.h     |  2 +-
 drivers/pci/mmap.c      | 11 +++++++-
 drivers/pci/pci-sysfs.c | 27 +++++++++++++++-----
 drivers/pci/proc.c      |  2 +-
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 073f8f3aece8..862f63ef9bf9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2129,7 +2129,7 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
  */
 int pci_mmap_resource_range(struct pci_dev *dev, int bar,
 			    struct vm_area_struct *vma,
-			    enum pci_mmap_state mmap_state, int write_combine);
+			    enum pci_mmap_state mmap_state, int write_combine, int enc);
 
 #ifndef arch_can_pci_mmap_wc
 #define arch_can_pci_mmap_wc()		0
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 8da3347a95c4..4fd522aeb767 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -23,7 +23,7 @@ static const struct vm_operations_struct pci_phys_vm_ops = {
 
 int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 			    struct vm_area_struct *vma,
-			    enum pci_mmap_state mmap_state, int write_combine)
+			    enum pci_mmap_state mmap_state, int write_combine, int enc)
 {
 	unsigned long size;
 	int ret;
@@ -46,6 +46,15 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 
 	vma->vm_ops = &pci_phys_vm_ops;
 
+	/*
+	 * Calling remap_pfn_range() directly as io_remap_pfn_range()
+	 * enforces shared mapping.
+	 */
+	if (enc)
+		return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				       vma->vm_end - vma->vm_start,
+				       vma->vm_page_prot);
+
 	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				  vma->vm_end - vma->vm_start,
 				  vma->vm_page_prot);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 4136889011c9..7b03daa13879 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1062,7 +1062,7 @@ void pci_remove_legacy_files(struct pci_bus *b)
  * Use the regular PCI mapping routines to map a PCI resource into userspace.
  */
 static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *attr,
-			     struct vm_area_struct *vma, int write_combine)
+			     struct vm_area_struct *vma, int write_combine, int enc)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
@@ -1082,21 +1082,28 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
-	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
+	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine, enc);
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
 				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
-	return pci_mmap_resource(kobj, attr, vma, 0);
+	return pci_mmap_resource(kobj, attr, vma, 0, 0);
 }
 
 static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
 				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
-	return pci_mmap_resource(kobj, attr, vma, 1);
+	return pci_mmap_resource(kobj, attr, vma, 1, 0);
+}
+
+static int pci_mmap_resource_enc(struct file *filp, struct kobject *kobj,
+				 const struct bin_attribute *attr,
+				 struct vm_area_struct *vma)
+{
+	return pci_mmap_resource(kobj, attr, vma, 0, 1);
 }
 
 static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
@@ -1190,7 +1197,7 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 	}
 }
 
-static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
+static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine, int enc)
 {
 	/* allocate attribute structure, piggyback attribute name */
 	int name_len = write_combine ? 13 : 10;
@@ -1208,6 +1215,9 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	if (write_combine) {
 		sprintf(res_attr_name, "resource%d_wc", num);
 		res_attr->mmap = pci_mmap_resource_wc;
+	} else if (enc) {
+		sprintf(res_attr_name, "resource%d_enc", num);
+		res_attr->mmap = pci_mmap_resource_enc;
 	} else {
 		sprintf(res_attr_name, "resource%d", num);
 		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
@@ -1264,11 +1274,14 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		if (!pci_resource_len(pdev, i))
 			continue;
 
-		retval = pci_create_attr(pdev, i, 0);
+		retval = pci_create_attr(pdev, i, 0, 0);
 		/* for prefetchable resources, create a WC mappable file */
 		if (!retval && arch_can_pci_mmap_wc() &&
 		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
-			retval = pci_create_attr(pdev, i, 1);
+			retval = pci_create_attr(pdev, i, 1, 0);
+		/* Add node for private MMIO mapping */
+		if (!retval)
+			retval = pci_create_attr(pdev, i, 0, 1);
 		if (retval) {
 			pci_remove_resource_files(pdev);
 			return retval;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f967709082d6..62992c8234f1 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -284,7 +284,7 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	/* Adjust vm_pgoff to be the offset within the resource */
 	vma->vm_pgoff -= start >> PAGE_SHIFT;
 	ret = pci_mmap_resource_range(dev, i, vma,
-				  fpriv->mmap_state, write_combine);
+				  fpriv->mmap_state, write_combine, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.47.1


