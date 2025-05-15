Return-Path: <linux-arch+bounces-11937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34860AB8029
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498F516764E
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD62868B5;
	Thu, 15 May 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeLWK9rU"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B521D3CD;
	Thu, 15 May 2025 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297141; cv=fail; b=C6z0sxNRWputzyBdmA9Pf2SjlVlx0qSpN1LYGePVqZBfhZKHvsW1wPCMGq5waQaCOAr5YJY2ZPwQkUrS36QvRncuggLy83r6W0ozKByzUIcmKrOxmnpHKfvkUkPqJBgA2jqJLCEHyRSwtbVp+2C/PVYra9D+CVzXhnEJkaTEnJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297141; c=relaxed/simple;
	bh=zmARsJvcK21WV1su/5yIu90rHV6rlPsVufquDm41vpA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGioWUnOl1ergTQA75xPZhZEcPZBzeJfTsa9bwLCJmH5hWE1Q0J+sQtq8bdBDWPb4hbp/VbXzMkrKP//ny+aaZUKtcF4D2Ho1rscbpZRIPfA5ih9egFcaq9diRJkm1cCu5nOkZrQJzi27ejLk0ivD9/MKBmVW/Dkc+25+OXXoGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeLWK9rU; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK3LTUnPnzfdmr8FFH35IXYvkMjqrP0peEpXWnFqvxFq7sUObOSxJEz1BgNeIepGjLBICejfVAYVgS6su6VZBfbZapxEyR1PsCHAtleLH2xS2ZVXr4vQF7adkU3gJ4jCZaCi+xB7YubVFCZ3EKGrMIusA/+wu1boApbID7qC4LgSwzFC0kCpIrM3Ir0GHEXrTKV+9zamlIgRagLNPIHjEBR0sQrahyj2Z0aHA6O19rx0KTvfCEy6C35IF8seoVLStj99F+CXcQtUsTzvotv/ulsfDyWQbdms9t8mOTVQ+2BOawRr4DQsuLvUiRM4rtV3eUDglONObM9eoztZs8zM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtwxJ7G0fmUIxZcDo3g/dfAU04OgUlD+ayGq0Od5dAM=;
 b=EszwQmzeO+Dqzeq1AmxY27f7aCrMZdz3UBYIkRA2/sZz6ZTFP3Gb3XBB4AqBxgIMVUf2NsZboBeOdepStQ6/IrfY7eBuYfhrq2AksEdZmfMnLxhNqy1L3/TLC9wuG3Tdf/gbvqEDmWxppQehQ5ksEpl3rwWdVJmKLH1WWmpsyixSPexCo/lGND32oqrzifPQTiXqEop9L0BNi8uh9lWXSIsdJQUs3A/icDQlzoOM94i1/gBVu/Gv4QPf7JcK0hmb1sjsFaar8KAz5zaTK02vQx3uQRFvj5p3vVen6CECZCErRY2IFvioN22rpUzWb4ALnzGn+9nwC9EMToF47xVcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtwxJ7G0fmUIxZcDo3g/dfAU04OgUlD+ayGq0Od5dAM=;
 b=aeLWK9rUdRiAsE5lfSVfQJh+tBZ7SLFMTyt/RCwIFh6iADr1KmobRvXw/ZFOKgqX1Zs+qlaO2PLNyip6k7BFZpZ0dqpoNRNnol9IYQ+DL1DFs8fZ32ogs+Qhlm27ERAgXlpzX06/zthv3HiHAWIr2ppAk9Bbq8e2yAiQipLZU5X09kG0uBvfHg8+0uUaO+CygU3H5KvnmVOd8MMR4/v70f2QBfQmQYFiMItDfunV5oUHhNQGmKr3McGrtwEqzzFYdaoKM1ZKPT0BXyPxIZeNpiMkuXlZ9ey8Q1VaAaUzsya6C+hiEG7dgYMsLlDOyhZwVweMyxuNkTk0glmX7pNiHw==
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 08:18:52 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 15 May 2025 08:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 08:18:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 01:18:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 01:18:37 -0700
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 01:18:30 -0700
Date: Thu, 15 May 2025 11:18:29 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
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
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, AXu Yilun
	<yilun.xu@linux.intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 15/22] KVM: X86: Handle private MMIO as shared
Message-ID: <20250515111829.45e31bf2.zhiw@nvidia.com>
In-Reply-To: <20250218111017.491719-16-aik@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
	<20250218111017.491719-16-aik@amd.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1300a0cf-8119-4617-4942-08dd9389209e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WREsl63SadQVgxl8ZDZ0qegIE6IqeZiqh1Hp2LJXTD/OOCBX+dS5XkYBOkj0?=
 =?us-ascii?Q?NdFHeFtkweFk1Ef74RoznrVTr7bySRoNO5uddCd/UzJoAUyBUX8FMnQpuFyD?=
 =?us-ascii?Q?5gVfER38J2S8IdUL3ky6mrGRYTyNmHUdMmuIY7piPeGKS4Ox+uW3xF6jeaX5?=
 =?us-ascii?Q?1qr1sD+YuPorgmLEBDdrfYef4VNNdHF7C6SwTqL/H+7/n3jZt9UY7VMTU3gp?=
 =?us-ascii?Q?Z976Ej56ewsTY/lJB8pF1J6tE0vw0bA3nG7HHld7diL6kakycLm+Y+YGUNnE?=
 =?us-ascii?Q?Eu39WMzUN4MH7mQ5sGkE8msvvkLe/gHkZfniKx0uR3Zb8mwDELbKNuN3oIU/?=
 =?us-ascii?Q?C7068s3YwqGqR88XVEImL81WaaYRD0c5WNDdYMyufJ1OuTrI2SKWUabzoWZH?=
 =?us-ascii?Q?O8/fC1cIe0NykBnWYQMWm+eGkPt5U70quscDYhAOolTTLr39anquhbqKI8gE?=
 =?us-ascii?Q?4bjgvUJsPkKwxJzLGP1gQxbW5PJAvoJ/McZwmugJ0hjQuntw/xwOGVavYlJ7?=
 =?us-ascii?Q?QsCCJ93WegL2ppkqG3IdxJvinI37Vq/WhBgl2BUqXCxMvJjsDVEtDAgd2PhX?=
 =?us-ascii?Q?z987CazwjYX4rCIpK6XG0uFlGQiLgYzDHxBILNfTjRf8jSImMoezjsin6Wev?=
 =?us-ascii?Q?TeuQyJmky1sG2gzhp7Uc3Ms5m3J71xHKsD6cQSBKd7xekf0AH5wiiNlWUcQo?=
 =?us-ascii?Q?kOvbh+tBL6EjSzabz1faR91y69kOFy5bry+z34/2+6gCNw6BlBWpnBLQc6jL?=
 =?us-ascii?Q?K99SUaBOD5ZbxUVoZOmag5DX5epMY8UZ6QcCPW8K59tA/dO9YhhnmaTXUdEC?=
 =?us-ascii?Q?/dRqHo28vr8Pio5g3hkNKhDpMqiFUQzFhOC089P1r/E4mma8HxkFPNNZqMA6?=
 =?us-ascii?Q?NveQTmDm6VMDnNBALC2Jy2mG+95gMs0hdpP9N8E+9YjJek+j5OAdTorZcPmj?=
 =?us-ascii?Q?1QXOMwYpz7P670ain/M6SM7jIkjkNV8ah4rpH7z1tlSAvwIkPhmPDnG+/09a?=
 =?us-ascii?Q?pWpxPLq6vl85w0eRRBHFWk2JFEmj0c7exBvyOz4J8GEwHeGCjdgugw0LYlX4?=
 =?us-ascii?Q?RXUutWOyfwQ5uOt1Xej3rEjPC8k4AD0woWteCnjSRFNgEa8QHAfwo5xVhzCN?=
 =?us-ascii?Q?xyGylBN/AWvblduq8he/BOVRwdDdoKKJMidgaHPIwK7NFXKxoZB0KAHMPqeT?=
 =?us-ascii?Q?DL5AKW8UnnOvl8+D5jBRE0KIlDTCokySOLb64LhvJs6ehxMmssZHhCjCndIl?=
 =?us-ascii?Q?VbZTJvV07vF9F6PsuPSYHlA+y8dVotcGK63VDCcJYfyOmGHRxbPZ1XDXWkWK?=
 =?us-ascii?Q?3G+AgwFAZtcsiB6PPBr4/nDE06C4uKUSwPnpV9EmIEwdETxlpzob/TcQdcV/?=
 =?us-ascii?Q?oqxHiMLdF3u7LGitKIzxryJ+3dgwBLGqrzOsUNjFMsy2DshWBs6lh8PUd6y4?=
 =?us-ascii?Q?ZaphjB+R9TrOgvhvo64G1PT4lPuOS6x6qFeHMf/V78UyIS68OdjnnfkcQzm8?=
 =?us-ascii?Q?k5gjNOH0vVebsUFxkfTbUaVWku8jswmRAHo+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:18:52.2407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1300a0cf-8119-4617-4942-08dd9389209e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

On Tue, 18 Feb 2025 22:10:02 +1100
Alexey Kardashevskiy <aik@amd.com> wrote:

> Currently private MMIO nested page faults are not expected so when
> such fault occurs, KVM tries moving the faulted page from private to
> shared which is not going to work as private MMIO is not backed by
> memfd.
> 
> Handle private MMIO as shared: skip page state change and memfd
> page state tracking.
> 
> The MMIO KVM memory slot is still marked as shared as the guest can
> access it as private or shared so marking the MMIO slot as private
> is not going to help.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 74c20dbb92da..32e27080b1c7 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4347,7 +4347,11 @@ static int __kvm_mmu_faultin_pfn(struct
> kvm_vcpu *vcpu, {
>  	unsigned int foll = fault->write ? FOLL_WRITE : 0;
>  
> -	if (fault->is_private)
> +	if (fault->slot && fault->is_private &&
> !kvm_slot_can_be_private(fault->slot) &&
> +	    (vcpu->kvm->arch.vm_type == KVM_X86_SNP_VM))
> +		pr_warn("%s: private SEV TIO MMIO fault for
> fault->gfn=%llx\n",
> +			__func__, fault->gfn);
> +	else if (fault->is_private)
>  		return kvm_mmu_faultin_pfn_private(vcpu, fault);
>  

Let's fold this in a macro and make this more informative with comments.

>  	foll |= FOLL_NOWAIT;


