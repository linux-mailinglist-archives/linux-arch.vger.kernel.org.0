Return-Path: <linux-arch+bounces-10226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E7A3C995
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 21:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D5F3A8461
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E82144A6;
	Wed, 19 Feb 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePGbzrFz"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617591BE251;
	Wed, 19 Feb 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996627; cv=fail; b=jpOahKg/+KOBy+4XH5j1LzhgTuttdQGu90+v4Kq7jcs6bi7HZ8t835YPCa1suqGHy8fKOXCPcMaJi50YHDBl6aGCCr5kBb0qMADj99x7LJa4tAASG9HVEIry8y1l5KkO4hk3fNZQ5JhuqW4EOVOg6yVlxma224pJdZM4sE6fZJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996627; c=relaxed/simple;
	bh=551a7v/832k71jac5kJCslJuqmC7FRAA8vE+k9NbHNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwJxseM/amiOQRnv/MelJJGlBbLgByO4CE+EYSuLauSz+ifflaDqD21R85oIBvNlwQleaFZxdA0+636Ewz58x8hSd3+VjEmbuvXJAH2pHOfLgfBOKBkeynDIfDqVRjwffzi0G6OjL98QoGTkM72GIWaMBDtlzoObqpFRfRbQkxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePGbzrFz; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0KySXx7aPVMPdzBobKZ5EE7HbGmc+jg892wjN5HICu4xFwPJgi/C3VjZPAq76pYCde4w+bm3z9SbNcz4p5CunTQ2+9OtrgM+O6fPILrV8Cddd8cK2ElOPDzqbS1v+uruABzvdLwhqfrDcg0onJOa5W61p24W8TrVfuI7OezVu+GGE6yR5KaQn9NlpoESgzrAFjS4fQY2GhbVZ6U2pO+oQLfKg8MLkePx1wHdPGJDNPQPF6IOkoxp8gRq5GdCUwgNLxt7ROwn5St9O8CrMwIH5XaePk5ek9BMVEgwlBS7qE+oLuMH8lsDt7hEvEjVb3wJrBj1qbn1QDIK/rhLQHbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y76QK7xhwkKUzF1crl2ZpASSEli0wGC223YxIr+GuY=;
 b=PqvYqPODkzJli8JbiuYKY9uQgUi9qvegfDj19s1RqHCQzDinK9HEFaEnRYZlXE+gCCz9yckYnHl0u0Q6JOTSYWQaNzhaAUF7iP2PDv+WQrbQLvU9XExXAKl5bCuNDQccw9k14ZRc33LkPxLrfpsr4UJONtVxaXGG5jScHdL3iqQBLuJBTz9V6yiD3NZA/zZDkuHveviRWwA0kjURuK5HWwP77GWSFnnvrz3EE4Mht9xBMykv0JjiBg9rINsr237HfFFWdD3xUGdj/wp5v7ZL0abnYQMDxM+LkZyPaKg318D/I2g5XsoN67cMMyiioeHDccP3a+XyCkLIKYs7OuP9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y76QK7xhwkKUzF1crl2ZpASSEli0wGC223YxIr+GuY=;
 b=ePGbzrFzp60kWUnj3I3sWVz3575X7rcgIZyXlXAXkY0rNZ3MAL85Zvr8M8G4fM3CZUBhAM6GhH0ji5pE5oJIyLJhSiKDvkWO3JuTgVxrCCGtgeBEMH9xYQFAJH6dY8uEwKt7+FTehQkCmKhKlDa4UqIp43NldfKeFjrdRiKaZ1g=
Received: from CH0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:610:cd::15)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 20:23:41 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::c3) by CH0PR03CA0100.outlook.office365.com
 (2603:10b6:610:cd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 20:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 20:23:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 14:23:39 -0600
Date: Wed, 19 Feb 2025 14:23:24 -0600
From: Michael Roth <michael.roth@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alexey Kardashevskiy <aik@amd.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arch@vger.kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Joao
 Martins <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Steve Sistare <steven.sistare@oracle.com>,
	"Lukas Wunner" <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Zhi Wang
	<zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250219202324.uq2kq27kmpmptbwx@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219133516.GL3696814@ziepe.ca>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c76ec8-2ab7-4c41-9bda-08dd51234ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YmzbjPvqE1x2b0UJQSVs+Ke2SMABJ8KwSOPjiJQGT1lEnZoAsT3pxx9ihLG/?=
 =?us-ascii?Q?W4oEx36K/ZjfmmMklfVhUG9bRD44lulphD7gOznl6T69SKWcaerGpcAtPjkU?=
 =?us-ascii?Q?WeyOpdTHJ56PCQWqeXFn2t+0OULjvcGSnvNyY7G9OI2hUyIXTT6iR4Tm+bKo?=
 =?us-ascii?Q?+se+xdI8aUXrg1vT2u/0qSdHaOs7NRIZRrt0jdzxTsqfwZ/Ll8+ZG+A5oluW?=
 =?us-ascii?Q?LUFc9RQLOTXkAFf/GM37ACnaPRRjd0ziKZg9urAksWQyan7kno6xOgfVSFGL?=
 =?us-ascii?Q?FP8eOAO1RtULZD6E7C7TGOASOAjq/Q+RWKQhic3NU1RkYEDjd3slyb/Age6X?=
 =?us-ascii?Q?js49HlAxzTfH2O5Boq7abl0vhHhAYiXc3e047wJml/EgNBDY7AgRcw8rb/CP?=
 =?us-ascii?Q?mIYxDFx2gTMKv622a3PjM5ik50lrTWagamsHL5J+/pc2VlcvmVxEon3fLZku?=
 =?us-ascii?Q?JbUm6rbD2mPYbiJ814A9Ozyg/+M1vdoRUj3uX3rnlzOeZlWkZ5yj7F1e3ZzQ?=
 =?us-ascii?Q?/Vwi/VUTOZrwC5/ScJWCyoiRf1cHR7mdUpon/Uu6aBMpnEqISy6PUIJDNhNg?=
 =?us-ascii?Q?iTNBZogDcAEx6Tsahr45Rlnhhu9QhNtu8oAlEPUBe5Ha3hD3cm2iBDpL9pAJ?=
 =?us-ascii?Q?PN3hI+7tpXChLQEZKRBOU1iPmacXJ+LWnjvtQLxCTM+CRK5n19zq030IFXXU?=
 =?us-ascii?Q?3escQgtk32n9ylTGQ8JWr+6MIc4jhr47bAhWnjEZOLyRk3V6EgO+1AYbCwfR?=
 =?us-ascii?Q?ZpQSmVaEHbtEwHLfq7kub141i9SflKzHnMBrIPrVDWmDzhr1FU2Ty6YmtgfA?=
 =?us-ascii?Q?tEpgUE71gJtDY6NkLAdroG05Xe9RFCm0gqCAw1mq4ge0excRmNejIwwY0Cyl?=
 =?us-ascii?Q?EhBN6lWOteAUUZ5i4LS5IlQbNe9wohL5DI7rYC1J5osQiPe9XnLAL3FZvFWV?=
 =?us-ascii?Q?DqPKZ4J77T3w7DwNDKdJ/biEKwVSLK9AdjPDxbKhnkQdQie30E/lGRrJJ8B3?=
 =?us-ascii?Q?LvxW9RNYeRt69rOvGw6esYYu0+3gJ08Wm6f9ZCghgGHntTd7FbZhKzJ9Him0?=
 =?us-ascii?Q?tMQ9ycL/iJY1832R9cipDaCd1Qb0aPdENrylAfeSGwqIIsDZcBZAf0Db87Sj?=
 =?us-ascii?Q?WTtVpfgqUL5wnY+cw95AM98kzcEh1vz/in1tLUwGnV6Bmk4We9+H6fzneuGe?=
 =?us-ascii?Q?gIrY5+Q4dKkhIauvVUNckmAual4uEtpdvw4GxnI++GVwlQxHe1LAXvenTQIX?=
 =?us-ascii?Q?ZVvCPl83eiFMKTjRaNLoW66Bq9y8cqN1H7B1v3y2x8sEUVQKdrhIXMYINaWn?=
 =?us-ascii?Q?t96J+46W+iDlWryvcwiOPyWsXuQpxEtsifuq65XQlRlaSqEk65vHnIQpNvL6?=
 =?us-ascii?Q?sIMq2RWAhZMIjmeyMd6xMG7XhqVl2uFBBFjh4wwmNliuGXml+Xbd9ECvgg5w?=
 =?us-ascii?Q?Ysxwk6kRVauK44b5zS6iG9mKeS40FLbFVYSA3QzUuGuha2RRawt6/ad9Px6F?=
 =?us-ascii?Q?zp/YX5dMpx0jMkw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:23:40.7677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c76ec8-2ab7-4c41-9bda-08dd51234ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

On Wed, Feb 19, 2025 at 09:35:16AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 11:43:46AM +1100, Alexey Kardashevskiy wrote:
> > On 19/2/25 10:51, Jason Gunthorpe wrote:
> > > On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:
> > > 
> > > > With in-place conversion, we could map the entire guest once in the HV IOMMU
> > > > and control the Cbit via the guest's IOMMU table (when available). Thanks,
> > > 
> > > Isn't it more complicated than that? I understood you need to have a
> > > IOPTE boundary in the hypervisor at any point where the guest Cbit
> > > changes - so you can't just dump 1G hypervisor pages to cover the
> > > whole VM, you have to actively resize ioptes?
> > 
> > When the guest Cbit changes, only AMD RMP table requires update but not
> > necessaryly NPT or IOPTEs.
> > (I may have misunderstood the question, what meaning does "dump 1G pages"
> > have?).
> 
> AFAIK that is not true, if there are mismatches in page size, ie the
> RMP is 2M and the IOPTE is 1G then things do not work properly.

Just for clarity: at least for normal/nested page table (but I'm
assuming the same applies to IOMMU mappings), 1G mappings are
handled similarly as 2MB mappings as far as RMP table checks are
concerned: each 2MB range is checked individually as if it were
a separate 2MB mapping:

AMD Architecture Programmer's Manual Volume 2, 15.36.10,
"RMP and VMPL Access Checks":

  "Accesses to 1GB pages only install 2MB TLB entries when SEV-SNP is
  enabled, therefore this check treats 1GB accesses as 2MB accesses for
  purposes of this check."

So a 1GB mapping doesn't really impose more restrictions than a 2MB
mapping (unless there's something different about how RMP checks are
done for IOMMU).

But the point still stands for 4K RMP entries and 2MB mappings: a 2MB
mapping either requires private page RMP entries to be 2MB, or in the
case of 2MB mapping of shared pages, every page in the range must be
shared according to the corresponding RMP entries.

> 
> It is why we had to do this:

I think, for the non-SEV-TIO use-case, it had more to do with inability
to unmap a 4K range once a particular 4K page has been converted
from shared to private if it was originally installed via a 2MB IOPTE,
since the guest could actively be DMA'ing to other shared pages in the
2M range (but we can be assured it is not DMA'ing to a particular 4K
page it has converted to private), and the IOMMU doesn't (AFAIK) have
a way to atomically split an existing 2MB IOPTE to avoid this. So
forcing everything to 4K ends up being necessary since we don't know
in advance what ranges might contain 4K pages that will get converted
to private in the future by the guest.

SEV-TIO might relax this restriction by making use of TMPM and the
PSMASH_IO command to split/"smash" RMP entries and IOMMU mappings to 4K
after-the-fact, but I'm not too familiar with the architecture/plans so
Alexey can correct me on that.

-Mike

> 
> > > This was the whole motivation to adding the page size override kernel
> > > command line.
> 
> commit f0295913c4b4f377c454e06f50c1a04f2f80d9df
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Thu Sep 5 09:22:40 2024 +0200
> 
>     iommu/amd: Add kernel parameters to limit V1 page-sizes
>     
>     Add two new kernel command line parameters to limit the page-sizes
>     used for v1 page-tables:
>     
>             nohugepages     - Limits page-sizes to 4KiB
>     
>             v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
>                               same as the sizes used with v2 page-tables
>     
>     This is needed for multiple scenarios. When assigning devices to
>     SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
>     table, otherwise the device will not be able to access all shared
>     memory.
>     
>     Also, some ATS devices do not work properly with arbitrary IO
>     page-sizes as supported by AMD-Vi, so limiting the sizes used by the
>     driver is a suitable workaround.
>     
>     All-in-all, these parameters are only workarounds until the IOMMU core
>     and related APIs gather the ability to negotiate the page-sizes in a
>     better way.
>     
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>     Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>     Link: https://lore.kernel.org/r/20240905072240.253313-1-joro@8bytes.org
> 
> Jason

