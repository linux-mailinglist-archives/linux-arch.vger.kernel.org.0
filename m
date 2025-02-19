Return-Path: <linux-arch+bounces-10230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D41A3CB75
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A736A3A9FB8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25E23536C;
	Wed, 19 Feb 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gOHR1Yt0"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620E15746F;
	Wed, 19 Feb 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000658; cv=fail; b=I9GoE+QWhyFaZ5q4035vspOCX8dn7h27IZmpKJWZv4DGQO1Ct/X2bY4l/yJ3RfIjBeSIYku5HLrcS4NkJ1pUrfS4hOX2yxjuV9p8QJ1gZAWFM04LiLS8bJpW0F4qTB9shGScb7YSw27ssURpdPPqSV/9BC17CWBQ674ESQwy5U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000658; c=relaxed/simple;
	bh=9EHyKzgADGM/EJpJWEy5A5QZ+nAgDoIiF9cKBRLhRyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klmjJ8OEfKLVwsiz5LcN3EJPCamtTi6JUGJITNYbDBddn2hjLBc3ajW2xYsbiFZROxN5cmFlfjQIdLGsXieaymkEzVoyiymuSu324eaBPlLZf9DXVp9dP/NzytvDg+qCe1tldd5pozmGqaWN0gbvVgysEgrClNBMedo52WiLYSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gOHR1Yt0; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDgPJ1UbQ3Esq27sl8i8YEw0gkJZz4nlFm6M7aMsJ/jrVjdk6TzSfsf/kiL61vcI9BWkFMsxQ/U9U74FuiaqtZQHF48BsNlqS0ktwOL+iespVHtd0M7S63XgL7d0jMbTrQBYQF3QRPBBQaowQG3r1V9eZnb2gnLUSFeiy4HzNjz+VmO35xqrt0uKA3u/eMnFav7xurqpue6i7USXDvGK+DnTpMLfvW78STD7eAHYRXAomjhCM2uwZ4AXLJWr+v8d/Io9diiTPglfBTt2zFpyAMdR0VHkJcCYkX5HMK6o2iLBDjj/x+7aKeOvMSCUxLxj5sU91Eq9wTHLnR8IcYggdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcoYsuB9Y+TLT/NL6CnO+DW1g4W7y8ja7rTXsu8zos=;
 b=CeoKLYCIY3OYa+qWU3WMmi9qafxYVApi3+71ksps01B1K8rEUZ2BmDT6gG51UIm+ajaSDwYAWeMQC4pliSsoZqH4eta4XNlTiNF0JYAh4oQUwS7behTQXA0yE143n4mMm/hSKLdwwzdh1xEsbA/MS8C5YsEOSxOi3Vl4VvjO5xnDjvn8XAJBc6Ov5wAynZuOTJKjEpVVw6ujmqayCrAepWrQXH1PDn4YYGWSybpARKtlP+DrIQNomanHoaTibW1hbubwYFwoDbLIKB+sC1LUeUBERSPlym4Fj96caOL5dnNQ/U2M53UDINqAve2csgwTlgN43V9oKhMGlXmv05zkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IcoYsuB9Y+TLT/NL6CnO+DW1g4W7y8ja7rTXsu8zos=;
 b=gOHR1Yt0LeCZcn86mB3Q2RoKeyFP462Wkf5XsUHq8XrQcKyrpc08rzFysg+7eAQ+bJsbwaXw1MLeerRZxxgINOm8eqntZxT9nYnRx48i6lS3mD2fWc+uOJxUXLxOFP5oBbNh+LExLG1pP+V6mOlNZP7eJ0dspWhEB6mLtH83xBI=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:30:53 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::15) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 21:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Wed, 19 Feb 2025 21:30:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 15:30:52 -0600
Date: Wed, 19 Feb 2025 15:30:37 -0600
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
Message-ID: <20250219213037.ku2wi7oyd5kxtwiv@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
 <20250219202324.uq2kq27kmpmptbwx@amd.com>
 <20250219203708.GO3696814@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219203708.GO3696814@ziepe.ca>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb993ed-a4bb-4add-7fe8-08dd512cafe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wxyUKPalpo6xou9cy1uguTfvw/Xy6hdpVOeiSdTLYtvbz/8AfcUCbgzQPHS8?=
 =?us-ascii?Q?eEqf/Y68x6jUATKiFU9GdUDi9IPY2mVp8a83Cj3xpJnQbeEs+7iCpvaCZF0M?=
 =?us-ascii?Q?0dcZv/0lHlv4tIn3bAouDYuTPQAEMqf1iHkeoUFFBOISnHL1zVMNN/VCiYLj?=
 =?us-ascii?Q?pqqT7g/Rtz2l8G6R7sqKhTUCQVytQInodW697bslGLmL+zdxrszjR+f+4kGU?=
 =?us-ascii?Q?TuBSiF17sd/TpwB2ysAyvt7oeQNB8J+vigd4raPlKtWv5D5WCfd+ZVcgTBe5?=
 =?us-ascii?Q?i5ik0VSbta9irJeJ8u+SSlcz2WMNkpccczo1Q8Eg1HpRy4xZ9FqoavUhwJT1?=
 =?us-ascii?Q?kK+3NgVZ7kbqjItXIwYoAaGTIDtEmbhbg/VImunGlR6itRB5k5fwKjgmIuQy?=
 =?us-ascii?Q?NRSgf6Dq1wJ2SIeinUHmsLD71ZVym/6zPAuvIU7ExM/j05xllZPD19UNGOFF?=
 =?us-ascii?Q?+exQjfHo0lcyAWBLcxzhT0MY0+f3Mu0kI4L7RA54SccTe4YfcS26aI2C7cjm?=
 =?us-ascii?Q?EkXnBPqNryawAeMxDDi1ZbaND9O+iWrG+/QXKhH4vXMpYT0edQa6DFyIDN0k?=
 =?us-ascii?Q?uWM/FKyemg8A22YhdNHRfh3hM0uamSc0AypqVSchIT2pLBzwNN2NzSLef9hJ?=
 =?us-ascii?Q?gbu4YdrH1Iz5qnTRF6OKy1Wh+AP0nwMBSEBABLhibvuCxLqDcLj7J5WwDHTv?=
 =?us-ascii?Q?SHaX+80t0bIqHBoWv6LTAq78Penxnae/bgCp2nyP8Y/+qMZBWsEX9/AorgkU?=
 =?us-ascii?Q?to+p2OCFPks7HOZF5aPhwou74XFkGpmO+lXG2iNj+oW/ufQh4rtktDy0PoGi?=
 =?us-ascii?Q?OPbWNI3KHk3z1XS9nwToTjZdxCwQQoKuma+X8eYLa/CKeza7F/KMxG2PLExA?=
 =?us-ascii?Q?tcAfue7dBZ99NM9skJPV1LdGzKj3NQweJ+5Z0vCkby8BReJ5qyy8/ZDULwKn?=
 =?us-ascii?Q?gVnMbHnThUrun7Rc3unQsExQGJuLCjbzaaEEFoEy7obGu07aB4tF1WkPLz3P?=
 =?us-ascii?Q?h9ShFzoeGAMBcKpDXuCK6dWykRfu7ztqXdENwH8qLAvwscyNJMAzwKLEXKrW?=
 =?us-ascii?Q?1oZMal80iJsiqzEciqMdadpnDU3sJTB81mn9EIUlBvYqtHUv8sT0HQTuLLRt?=
 =?us-ascii?Q?t1BTOceNZIeBiyn+N3EJS3yuVTs5mMqblo6flTXkPYtTlwFqycrn/l3MqKJt?=
 =?us-ascii?Q?knfo5l2Gu5ZAv3vkSIS18YlojbAmws9qHMhKs8ulhXuDmfWfhTdKST7/UY1z?=
 =?us-ascii?Q?HUm998HrVH7i6PqmG8m6pMwyX1JNmaDBkEEFrdhQQv9pHWGPoD+QpDt9Xiaa?=
 =?us-ascii?Q?AxyjHm/X6NOPePQAvwLTfzLqZS/HwTjogg8D82LdtIA7p+dZFEKxnd1+UziP?=
 =?us-ascii?Q?X9sTAefe9E0CXaOpkelMJGMFynkIW2RHBXxCWernMCYcmgy5R8pilAsNq9ha?=
 =?us-ascii?Q?8cJGnf7L49b8f+7qKZAip7jFq7Yf6/yxtYqHSkbChRZ/eaooL3f4Hx/S4U8s?=
 =?us-ascii?Q?tZd0Q+WUWDiFAJw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:30:52.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb993ed-a4bb-4add-7fe8-08dd512cafe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

On Wed, Feb 19, 2025 at 04:37:08PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 02:23:24PM -0600, Michael Roth wrote:
> > Just for clarity: at least for normal/nested page table (but I'm
> > assuming the same applies to IOMMU mappings), 1G mappings are
> > handled similarly as 2MB mappings as far as RMP table checks are
> > concerned: each 2MB range is checked individually as if it were
> > a separate 2MB mapping:
> 
> Well, IIRC we are dealing with the AMDv1 IO page table here which
> supports more sizes than 1G and we likely start to see things like 4M
> mappings and the like. So maybe there is some issue if the above
> special case really only applies to 1G and only 1G.

I think the documentation only mentioned 1G specifically since that's
the next level up in host/nested page table mappings, and that more
generally anything mapping at a higher granularity than 2MB would be
broken down into individual checks on each 2MB range within. But it's
quite possible things are handled differently for IOMMU so definitely
worth confirming.

> 
> > But the point still stands for 4K RMP entries and 2MB mappings: a 2MB
> > mapping either requires private page RMP entries to be 2MB, or in the
> > case of 2MB mapping of shared pages, every page in the range must be
> > shared according to the corresponding RMP entries.
> 
>  Is 4k RMP what people are running?

Unfortunately yes, but that's mainly due to guest_memfd only handling
4K currently. Hopefully that will change soon, but in the meantime
there's only experimental support for larger private page sizes that
make use of 2MB RMP entries (via THP).

But regardless, we'll still end up dealing with 4K RMP entries since
we'll need to split 2MB RMP entries in response to private->conversions
that aren't 2MB aligned/sized.

> 
> > I think, for the non-SEV-TIO use-case, it had more to do with inability
> > to unmap a 4K range once a particular 4K page has been converted
> 
> Yes, we don't support unmap or resize. The entire theory of operation
> has the IOPTEs cover the guest memory and remain static at VM boot
> time. The RMP alone controls access and handles the static/private.
> 
> Assuming the host used 2M pages the IOPTEs in an AMDv1 table will be
> sized around 2M,4M,8M just based around random luck.
> 
> So it sounds like you can get to a situation with a >=2M mapping in
> the IOPTE but the guest has split it into private/shared at lower
> granularity and the HW cannot handle this?

Remembering more details: the situation is a bit more specific to
guest_memfd. In general, for non-SEV-TIO, everything in the IOMMU will
be always be for shared pages, and because of that the RMP checks don't
impose any additional restrictions on mapping size (a shared page can
be mapped 2MB even if the RMP entry is 4K (the RMP page-size bit only
really applies for private pages)).

The issue with guest_memfd is that it is only used for private pages
(at least until in-place conversion is supported), so when we "convert"
shared pages to private we are essentially discarding those pages and
re-allocating them via guest_memfd, so the mappings for those discarded
pages become stale and need to be removed. But since this can happen
at 4K granularities, we need to map as 4K because we don't have a way
to split them later on (at least, not currently...).

The other approach is to not discard these shared pages after conversion
and just not free them back, which ends up using more host memory, but
allows for larger IOMMU mappings.

> 
> > from shared to private if it was originally installed via a 2MB IOPTE,
> > since the guest could actively be DMA'ing to other shared pages in
> > the 2M range (but we can be assured it is not DMA'ing to a particular 4K
> > page it has converted to private), and the IOMMU doesn't (AFAIK) have
> > a way to atomically split an existing 2MB IOPTE to avoid this. 
> 
> The iommu can split it (with SW help), I'm working on that
> infrastructure right now..
> 
> So you will get a notification that the guest has made a
> private/public split and the iommu page table can be atomically
> restructured to put an IOPTE boundary at the split.
> 
> Then the HW will not see IOPTEs that exceed the shared/private
> granularity of the VM.

That sounds very interesting. It would allow us to use larger IOMMU
mappings even for guest_memfd as it exists today, while still supporting
shared memory discard and avoiding the additional host memory usage
mentioned above. Are there patches available publicly?

Thanks,

Mike

> 
> Jason

