Return-Path: <linux-arch+bounces-11931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF1AB747E
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DEF1BA484B
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B62874F6;
	Wed, 14 May 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlpW7a6W"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D9286D5C;
	Wed, 14 May 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248019; cv=fail; b=t1IdsJYRHcwqefMpJXOJfyPKZorrJ/dV8D2YPolpLrxCnEqG6l9m9yfFQzIAryT4/C1NAEA8aoe7nYhwTnLmZWt178PaBCd/JMuZIPE0BO0XrAWH/ekXBEPrQOAMYn8ICq1oQp/Sb2+zUXn5Hw7tLMu2lE3SBw93KE4kgeVE9iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248019; c=relaxed/simple;
	bh=tVgrK/u5U+gJnS4yeEYH8U8KvOmwKJCchfa/ZzspFY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS8GshTnReoIq0k4k6L2hMiEiIp+Y1QT7vcznZRn9rfkS6a43e7QUmKRDNgnZKBCb5RbxQ666LBJ69GEHyeyomy7TzWjVY8PiaNhrSRcSD0Z/O2ACP6v0aJx8zUpvQTV8yZmv45WnphaM9LtXhGDyN2HxICO+9Qd3MrdR6caxVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlpW7a6W; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBS2zs756/d8Evz6qVa96BHloca9/iepEsdccUgYCFb8AsEPAOHYj0GtyKsi0G09495YRfWe0IwuBUtGD+BcBt3EP3vAGH5VM5FRTMpSVUTPeGT5bn00C/gFZCOheydceANy60G2GaH4wGXjSbPtBTbSRvpKaTkAeN6McfdOJCULaAAOW0rtRMUWuYOIA1VasHT8PY1yzKDECTN+4Uh5sDdsPhNtZZKySJPhN7qtKDmaR/GrT+zTHcLLgnx9wqnnfNVpjl7AI265eZNMV6RzUxvEhq8ruwZcz7JiKpD0EXHBojNVaqllXs7bMMIIpLrLPgjkCdTmVqXtB1FEWDgyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnnY5TiOuu1pBKFeFMIoh5UPE5ukjzUfnAF0UPDtgVM=;
 b=sX8vTydxzCRAoREziaxlK56JQrPQ+OVdjJy0cyp+q0YCTf7nOJV+45y0tT75yNQKOcu8WE7zF3aIWN9jNxDuMNBdmexA8fKbl1oGo/clls3Iy2oX+l3UR7VtNB9t2duQ8a/VIq6kmA+iFapkK0dHn8TMhp50wppBD6I3QbCHA0xEqFyjmmM4UKWq6Pg/y+oeqjLA04D1pyGT10/x7My0wwAF5pjeXYegxG8KuL+YRvE2lPh59vsUWoWv5pDd1FAoQUB1o7T6tM7E317EeCRU0IP5LjLutagTzm9dDf4AM/Zj5blglR0zKzKiAWmNybRbokAgfqpEzfq9ZVHnxtRt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnnY5TiOuu1pBKFeFMIoh5UPE5ukjzUfnAF0UPDtgVM=;
 b=SlpW7a6W5ySqtfW5tC9yYDSexj1ajPaR4+1SoETPZ/6fQKxxZ+zA5mX4otP9b2q8Dx4lJIvvrEAnZbcMuxcPqM91JdKn1NLDqjxy/F5bfApz6VTIyOEn14+O0w12fEMSmLl0/VEDdxE/M+R4sP/2vzsq4DWgURSNko42iTJEk85Ls8EZwuDouFkBjRpFGoe3zVx4mkM2PXwzscFd9C8PQxuDaPQJOjY7Kkg2aCRe6FOhyQKc2TzpPLSkLmR14I56GxqvhJfJiLvYZ9dPt11NNRu7k/bgDm05siB9aks8cbMKRZkZOSYpijw+L41VsDYbu1lB8xCO8GmNWjDQusaPww==
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 18:40:06 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2a01:111:f403:c803::2) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 14 May 2025 18:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 18:40:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 11:39:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 11:39:51 -0700
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 14 May 2025 11:39:44 -0700
Date: Wed, 14 May 2025 21:39:43 +0300
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
Subject: Re: [RFC PATCH v2 07/22] coco/tsm: Add tsm and tsm-host modules
Message-ID: <20250514213943.49e1949c.zhiw@nvidia.com>
In-Reply-To: <20250218111017.491719-8-aik@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
	<20250218111017.491719-8-aik@amd.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 52415371-26a2-49b0-7b80-08dd9316bf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWl6RmpSd3hLVTFJYXpMRFM3Ni9lUzJ4eFFJdWdNZnRFaHJNREpValVwM2hT?=
 =?utf-8?B?OFJFN1ROTGpXWCt5MDlHRzZnKzE4a3BHWkZMK3RlK05udHhla1pWd3RUOXRG?=
 =?utf-8?B?NXJYVThMek51Z0hURTAzcmhXZzN5MzlQT0V5b3JSWmZJeTBJR3FqZ2p2MWRN?=
 =?utf-8?B?NGV1cnJiZkhPVENIUzRwZWVPc3ZwSlhBeHVVY1VJUCtmcVh5VEVFVGVhNlBx?=
 =?utf-8?B?M2twamlZTU82QktrdWdacDdqd2hGdnJUNEVsaEJPZU5POFc5VDUweU51ZjhK?=
 =?utf-8?B?Z09YQndjYnpzNmZ4SVFrUTk4QWpPYlNVMlBDcGZlZEx5SDVvSFpHTnpRdTFv?=
 =?utf-8?B?ZkI3QnpyRmEwM2ppWGJrSG50bkRIWmFHODhnS2I2dVZ3UEt0aWN6a0xseWVw?=
 =?utf-8?B?aGxaSS8xS2xMcW5TNFptck5HYzY2enhTSi8yQjdmKzAxK3VmZHVEV0wzeERI?=
 =?utf-8?B?SGw5VGg1TkJhOGsyaFF1NHZMbGMrTHdaTExaeUhtSXJoK1JMWmNqbHkwaVZr?=
 =?utf-8?B?TVJIQnFPY2oxdUora2IwNFU0bktnZ1dyZ0Z4UjQyWnl3Z2F2Y2pkcmZXWkV2?=
 =?utf-8?B?ZFhyWTRqNWhHaGNWbmNaVlVWTHRoWW41QXhUa280NGFFZFBhSTEzQjNlbXkz?=
 =?utf-8?B?OC9GUWVJdGs3SkJwMmZXNUV1bm5Gall4Mk5vaTlpdmVERWVXZm5OVjljdlNm?=
 =?utf-8?B?dlFmT0I4c3pMc0xFRFNzK3B2eTA0NGxRU1ZTNDJFcElDZFVFdmhjVXptYXdV?=
 =?utf-8?B?cXM5RnFxQzZqcGRESG92UUx3K3E4R3JmelRId1lOaW1HMytxUnk3YlU5MTRw?=
 =?utf-8?B?K0Y1M0NnM1VIOXo4cG5GZElWeVY0akwrVUxCZzZFRnhjUGk5bUorRncxanZR?=
 =?utf-8?B?U3hpaVkxM3gvTmhFYmVZczUxTE9JU2kwODd4QWx5S2dQdEtZdGlJdlZBY0tB?=
 =?utf-8?B?aDJxNmpmZElSQVRzWFI1ZS8vUXBrWkpQbE9UTmpuLzc5Vnc4bjF1WmhmVE1r?=
 =?utf-8?B?MkdwSWpCdW4vanBINERJUWY4STRuUCtxVm4zNkxocTJNTy9OaGR6bi9saktO?=
 =?utf-8?B?T3lrKzlkSUtEMHF0UWtMaVFxc2oxY0ZpL214QkNkOHBQL283SUpEN1VINDVH?=
 =?utf-8?B?Nzc0UTFxRnh0VjVPcElmWEI2b2RrTVJFRk9oMzBXczhXNmIyMmdOYm9MQnRX?=
 =?utf-8?B?Z3g4TEhMUzBjazBnc3RlVkJJVjQvSkN2RmNZR1Axa1ZZSGh5bVdIeXJFZUE2?=
 =?utf-8?B?WU9POHNPRXYra3VNeDU1LytwKysvQ0FNMkw5dEZGSEorbjJSY05IRThYL0Vn?=
 =?utf-8?B?eTNGT05MS3VJVUE3WFB2Z2VScDVaVXY4dHYvSFVwazVKSndJSGlPYWZMNVJX?=
 =?utf-8?B?dkwwMUw4VEx0Q0M1TjV1bXRqdEdsWkNvRCtZTEphREcrdjZkNkRrLzQ3cklT?=
 =?utf-8?B?dUlHQ3UvQ3d1bFU3YllYZ0N5KzVmczlyRVZnTXJWL2tHNVMyWkdFa0tBSUw4?=
 =?utf-8?B?SXUrU1RuSE52QXlmQW45bFA2UmtxWEhqbnZrUlRkaU9hRFVmejlQN2lEOFd3?=
 =?utf-8?B?bmxqclZGWVNaZkJycm54UUJ6aFdwcmE0a2xUMi9KVkVpbGx3RzhEMEsrRXVI?=
 =?utf-8?B?QkJaOGg0MytCN1JVK2taRTh3Y0kzM2hveVByR3hkem1HZ2kvd0FGdEY5S3Ja?=
 =?utf-8?B?eUgyWS9GN3psd0ZlN0NWd0dORDdsbkZoRElUUDhzckNiQXJhaGliUmF1Tlgw?=
 =?utf-8?B?Q0xwYlpZRVJ3QXQ4MExXT3IxYUtaWmVwZ2FIWG9KTDhYcHVBZEozQ3lVMkxJ?=
 =?utf-8?B?bEpxS0gzTnA1VXY5b1JtdkJOQUp5dFNYQzliSE1vWmp0STl1d0IrcmJhU1dD?=
 =?utf-8?B?dFIwQ3IwQzloRkhSb0RObmxMQStmNlYxUmNCcnJIZEcvZGpMOFZqMkpNMmZr?=
 =?utf-8?B?dU1IZDQzak14UnVpWHFnZmJCaE8ybXRkQUFxeTRNWlJsTjRQUTBwQWZjcGZI?=
 =?utf-8?B?YVFnLzhPUE9OV0UzSk1uZkJiUVprZEp0V1lTcC9LWmpyNDBDVENxWTJVZXBE?=
 =?utf-8?Q?OV/0mB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 18:40:06.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52415371-26a2-49b0-7b80-08dd9316bf7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

On Tue, 18 Feb 2025 22:09:54 +1100
Alexey Kardashevskiy <aik@amd.com> wrote:

> The TSM module is a library to create sysfs nodes common for
> hypervisors and VMs. It also provides helpers to parse interface
> reports (required by VMs, visible to HVs). It registers 3 device
> classes:
> - tsm: one per platform,
> - tsm-dev: for physical functions, ("TDEV");
> - tdm-tdi: for PCI functions being assigned to VMs ("TDI").
>=20
> The library adds a child device of "tsm-dev" or/and "tsm-tdi" class
> for every capable PCI device. Note that the module is made
> bus-agnostic.
>=20
> New device nodes provide sysfs interface for fetching device
> certificates and measurements and TDI interface reports.
> Nodes with the "_user" suffix provide human-readable information,
> without that suffix it is raw binary data to be copied to a guest.
>=20
> The TSM-HOST module adds hypervisor-only functionality on top. At the
> moment it is:
> - "connect" to enable/disable IDE (a PCI link encryption);
> - "TDI bind" to manage a PCI function passed through to a secure VM.
>=20
> A platform is expected to register itself in TSM-HOST and provide
> necessary callbacks. No platform is added here, AMD SEV is coming in
> the next patches.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  drivers/virt/coco/Makefile        |   2 +
>  drivers/virt/coco/host/Makefile   |   6 +
>  include/linux/tsm.h               | 295 +++++++++
>  drivers/virt/coco/host/tsm-host.c | 552 +++++++++++++++++
>  drivers/virt/coco/tsm.c           | 636 ++++++++++++++++++++
>  Documentation/virt/coco/tsm.rst   |  99 +++
>  drivers/virt/coco/Kconfig         |  14 +
>  drivers/virt/coco/host/Kconfig    |   6 +
>  8 files changed, 1610 insertions(+)
>=20
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index 885c9ef4e9fc..670f77c564e8 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,9 +2,11 @@
>  #
>  # Confidential computing related collateral
>  #
> +obj-$(CONFIG_TSM)		+=3D tsm.o
>  obj-$(CONFIG_EFI_SECRET)	+=3D efi_secret/
>  obj-$(CONFIG_ARM_PKVM_GUEST)	+=3D pkvm-guest/
>  obj-$(CONFIG_SEV_GUEST)		+=3D sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+=3D tdx-guest/
>  obj-$(CONFIG_ARM_CCA_GUEST)	+=3D arm-cca-guest/
>  obj-$(CONFIG_TSM_REPORTS)	+=3D guest/
> +obj-$(CONFIG_TSM_HOST)          +=3D host/
> diff --git a/drivers/virt/coco/host/Makefile
> b/drivers/virt/coco/host/Makefile new file mode 100644
> index 000000000000..c5e216b6cb1c
> --- /dev/null
> +++ b/drivers/virt/coco/host/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TSM (TEE Security Manager) Common infrastructure and host drivers
> +
> +obj-$(CONFIG_TSM_HOST) +=3D tsm_host.o
> +tsm_host-y +=3D tsm-host.o
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 431054810dca..486e386d90fc 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -5,6 +5,11 @@
>  #include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <linux/uuid.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/bitfield.h>
> =20
>  #define TSM_REPORT_INBLOB_MAX 64
>  #define TSM_REPORT_OUTBLOB_MAX SZ_32K
> @@ -109,4 +114,294 @@ struct tsm_report_ops {
> =20
>  int tsm_report_register(const struct tsm_report_ops *ops, void
> *priv); int tsm_report_unregister(const struct tsm_report_ops *ops);
> +
> +/* SPDM control structure for DOE */
> +struct tsm_spdm {
> +	unsigned long req_len;
> +	void *req;
> +	unsigned long rsp_len;
> +	void *rsp;
> +};
> +
> +/* Data object for measurements/certificates/attestationreport */
> +struct tsm_blob {
> +	void *data;
> +	size_t len;
> +};
> +
> +struct tsm_blob *tsm_blob_new(void *data, size_t len);
> +static inline void tsm_blob_free(struct tsm_blob *b)
> +{
> +	kfree(b);
> +}
> +
> +/**
> + * struct tdisp_interface_id - TDISP INTERFACE_ID Definition
> + *
> + * @function_id: Identifies the function of the device hosting the
> TDI
> + *   15:0: @rid: Requester ID
> + *   23:16: @rseg: Requester Segment (Reserved if Requester Segment
> Valid is Clear)
> + *   24: @rseg_valid: Requester Segment Valid
> + *   31:25 =E2=80=93 Reserved
> + * 8B - Reserved
> + */
> +struct tdisp_interface_id {
> +	u32 function_id; /* TSM_TDISP_IID_xxxx */
> +	u8 reserved[8];
> +} __packed;
> +
> +#define TSM_TDISP_IID_REQUESTER_ID	GENMASK(15, 0)
> +#define TSM_TDISP_IID_RSEG		GENMASK(23, 16)
> +#define TSM_TDISP_IID_RSEG_VALID	BIT(24)
> +

I would suggest that we have separate header files for spec
definitions. E.g. tdisp_defs and spdm_defs.h. from the maintainability
perspective.

> +/*
> + * Measurement block as defined in SPDM DSP0274.
> + */
> +struct spdm_measurement_block_header {
> +	u8 index;
> +	u8 spec; /* MeasurementSpecification */
> +	u16 size;
> +} __packed;
> +

....

> +struct tsm_hv_ops {
> +	int (*dev_connect)(struct tsm_dev *tdev, void *private_data);
> +	int (*dev_disconnect)(struct tsm_dev *tdev);
> +	int (*dev_status)(struct tsm_dev *tdev, struct
> tsm_dev_status *s);
> +	int (*dev_measurements)(struct tsm_dev *tdev);
> +	int (*tdi_bind)(struct tsm_tdi *tdi, u32 bdfn, u64 vmid);
> +	int (*tdi_unbind)(struct tsm_tdi *tdi);
> +	int (*guest_request)(struct tsm_tdi *tdi, u8 __user *req,
> size_t reqlen,
> +			     u8 __user *rsp, size_t rsplen, int
> *fw_err);
> +	int (*tdi_status)(struct tsm_tdi *tdi, struct tsm_tdi_status
> *ts); +};
> +

1) Looks we have two more callbacks besides TDI verbs, I think they are
fine to be in TSM driver ops.

For guest_request(), anyway, we need an entry point for QEMU to
reach the TSM services in the kernel. Looks like almost all the platform
(Intel/AMD/ARM) have TVM-HOST paths, which will exit to QEMU from KVM,
and QEMU reaches the TSM services and return to the TVM. I think they
can all leverage the entry point (IOMMUFD) via the guest request ioctl.
And IOMMUFD almost have all the stuff QEMU needs.

Or we would end up with QEMU reaches to different entry points in
per-vendor code path, which was not preferable, backing to the
period when enabling CC in QEMU.

2) Also, it is better that we have separate the tsm_guest and tsm_host
headers since the beginning.=20

3) How do you trigger the TDI_BIND from the guest in the late-bind
model? Was looking at tsm_vm_ops, but seems not found yet.

> +struct tsm_subsys {
> +	struct device dev;
> +	struct list_head tdi_head;
> +	struct mutex lock;
> +	const struct attribute_group *tdev_groups[3]; /* Common,
> host/guest, NULL */
> +	const struct attribute_group *tdi_groups[3]; /* Common,
> host/guest, NULL */
> +	int (*update_measurements)(struct tsm_dev *tdev);
> +};
> +
> +struct tsm_subsys *tsm_register(struct device *parent, size_t extra,
> +				const struct attribute_group
> *tdev_ag,
> +				const struct attribute_group *tdi_ag,
> +				int (*update_measurements)(struct
> tsm_dev *tdev)); +void tsm_unregister(struct tsm_subsys *subsys);
> +
> +struct tsm_host_subsys;
> +struct tsm_host_subsys *tsm_host_register(struct device *parent,
> +					  struct tsm_hv_ops *hvops,
> +					  void *private_data);
> +struct tsm_dev *tsm_dev_get(struct device *dev);
> +void tsm_dev_put(struct tsm_dev *tdev);
> +struct tsm_tdi *tsm_tdi_get(struct device *dev);
> +void tsm_tdi_put(struct tsm_tdi *tdi);
> +
> +struct pci_dev;
> +int pci_dev_tdi_validate(struct pci_dev *pdev, bool invalidate);
> +int pci_dev_tdi_mmio_config(struct pci_dev *pdev, u32 range_id, bool
> tee); +
> +int tsm_dev_init(struct tsm_bus_subsys *tsm_bus, struct device
> *parent,
> +		 size_t busdatalen, struct tsm_dev **ptdev);
> +void tsm_dev_free(struct tsm_dev *tdev);
> +int tsm_tdi_init(struct tsm_dev *tdev, struct device *dev);
> +void tsm_tdi_free(struct tsm_tdi *tdi);
> +
> +/* IOMMUFD vIOMMU helpers */
> +int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd);
> +void tsm_tdi_unbind(struct tsm_tdi *tdi);
> +int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t
> reqlen,
> +		      u8 __user *res, size_t reslen, int *fw_err);
> +
> +/* Debug */
> +ssize_t tsm_report_gen(struct tsm_blob *report, char *b, size_t len);
> +
> +/* IDE */
> +int tsm_create_link(struct tsm_subsys *tsm, struct device *dev,
> const char *name); +void tsm_remove_link(struct tsm_subsys *tsm,
> const char *name); +#define tsm_register_ide_stream(tdev, ide) \
> +	tsm_create_link((tdev)->tsm, &(tdev)->dev, (ide)->name)
> +#define tsm_unregister_ide_stream(tdev, ide) \
> +	tsm_remove_link((tdev)->tsm, (ide)->name)
> +
>  #endif /* __TSM_H */
> diff --git a/drivers/virt/coco/host/tsm-host.c
> b/drivers/virt/coco/host/tsm-host.c new file mode 100644
> index 000000000000..80f3315fb195
> --- /dev/null
> +++ b/drivers/virt/coco/host/tsm-host.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/tsm.h>
> +#include <linux/file.h>
> +#include <linux/kvm_host.h>
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"aik@amd.com"
> +#define DRIVER_DESC	"TSM host library"
> +
> +struct tsm_host_subsys {
> +	struct tsm_subsys base;
> +	struct tsm_hv_ops *ops;
> +	void *private_data;
> +};
> +
> +static int tsm_dev_connect(struct tsm_dev *tdev)
> +{
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	if (WARN_ON(!hsubsys->ops->dev_connect))
> +		return -EPERM;
> +
> +	if (WARN_ON(!tdev->tsm_bus))
> +		return -EPERM;
> +
> +	mutex_lock(&tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->dev_connect(tdev,
> hsubsys->private_data);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
> ret);
> +		if (ret < 0)
> +			break;
> +	}
> +	mutex_unlock(&tdev->spdm_mutex);
> +
> +	tdev->connected =3D (ret =3D=3D 0);
> +
> +	return ret;
> +}
> +
> +static int tsm_dev_reclaim(struct tsm_dev *tdev)
> +{
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	if (WARN_ON(!hsubsys->ops->dev_disconnect))
> +		return -EPERM;
> +
> +	/* Do not disconnect with active TDIs */
> +	if (tdev->bound)
> +		return -EBUSY;
> +

Can this replace a lock? refcount is to track the life cycle,
lock is to avoid racing. Think that we just pass here tdev->bound
=3D=3D 0, take the spdm_mutex and request the TSM to talk to the device
for disconnection, while someone is calling tdi_bind and pass the
tdev->connected check and waiting for the spdm_mutex to do the
tdi_bind. The device might see a TDI_BIND after a DEVICE_DISCONNECT.

Z.
> +	mutex_lock(&tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->dev_disconnect(tdev);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
> ret);
> +		if (ret < 0)
> +			break;
> +	}
> +	mutex_unlock(&tdev->spdm_mutex);
> +
> +	if (!ret)
> +		tdev->connected =3D false;
> +
> +	return ret;
> +}
> +
> +static int tsm_dev_status(struct tsm_dev *tdev, struct
> tsm_dev_status *s) +{
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm; +
> +	if (WARN_ON(!hsubsys->ops->dev_status))
> +		return -EPERM;
> +
> +	return hsubsys->ops->dev_status(tdev, s);
> +}
> +
> +static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
> +{
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	while (1) {
> +		ret =3D hsubsys->ops->dev_measurements(tdev);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
> ret);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void tsm_tdi_reclaim(struct tsm_tdi *tdi)
> +{
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	if (WARN_ON(!hsubsys->ops->tdi_unbind))
> +		return;
> +
> +	mutex_lock(&tdi->tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->tdi_unbind(tdi);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D
> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
> +		if (ret < 0)
> +			break;
> +	}
> +	mutex_unlock(&tdi->tdev->spdm_mutex);
> +}
> +
> +static int tsm_tdi_status(struct tsm_tdi *tdi, void *private_data,
> struct tsm_tdi_status *ts) +{
> +	struct tsm_tdi_status tstmp =3D { 0 };
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	mutex_lock(&tdi->tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->tdi_status(tdi, &tstmp);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D
> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
> +		if (ret < 0)
> +			break;
> +	}
> +	mutex_unlock(&tdi->tdev->spdm_mutex);
> +
> +	if (!ret)
> +		*ts =3D tstmp;
> +
> +	return ret;
> +}
> +
> +static ssize_t tsm_cert_slot_store(struct device *dev, struct
> device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct tsm_dev *tdev =3D container_of(dev, struct tsm_dev,
> dev);
> +	ssize_t ret =3D count;
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		ret =3D -EINVAL;
> +	else
> +		tdev->cert_slot =3D val;
> +
> +	return ret;
> +}
> +
> +static ssize_t tsm_cert_slot_show(struct device *dev, struct
> device_attribute *attr, char *buf) +{
> +	struct tsm_dev *tdev =3D container_of(dev, struct tsm_dev,
> dev);
> +	ssize_t ret =3D sysfs_emit(buf, "%u\n", tdev->cert_slot);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(tsm_cert_slot);
> +
> +static ssize_t tsm_dev_connect_store(struct device *dev, struct
> device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct tsm_dev *tdev =3D container_of(dev, struct tsm_dev,
> dev);
> +	unsigned long val;
> +	ssize_t ret =3D -EIO;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		ret =3D -EINVAL;
> +	else if (val && !tdev->connected)
> +		ret =3D tsm_dev_connect(tdev);
> +	else if (!val && tdev->connected)
> +		ret =3D tsm_dev_reclaim(tdev);
> +
> +	if (!ret)
> +		ret =3D count;
> +
> +	return ret;
> +}
> +
> +static ssize_t tsm_dev_connect_show(struct device *dev, struct
> device_attribute *attr, char *buf) +{
> +	struct tsm_dev *tdev =3D container_of(dev, struct tsm_dev,
> dev);
> +	ssize_t ret =3D sysfs_emit(buf, "%u\n", tdev->connected);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(tsm_dev_connect);
> +
> +static ssize_t tsm_dev_status_show(struct device *dev, struct
> device_attribute *attr, char *buf) +{
> +	struct tsm_dev *tdev =3D container_of(dev, struct tsm_dev,
> dev);
> +	struct tsm_dev_status s =3D { 0 };
> +	int ret =3D tsm_dev_status(tdev, &s);
> +	ssize_t ret1;
> +
> +	ret1 =3D sysfs_emit(buf, "ret=3D%d\n"
> +			  "ctx_state=3D%x\n"
> +			  "tc_mask=3D%x\n"
> +			  "certs_slot=3D%x\n"
> +			  "device_id=3D%x:%x.%d\n"
> +			  "segment_id=3D%x\n"
> +			  "no_fw_update=3D%x\n",
> +			  ret,
> +			  s.ctx_state,
> +			  s.tc_mask,
> +			  s.certs_slot,
> +			  (s.device_id >> 8) & 0xff,
> +			  (s.device_id >> 3) & 0x1f,
> +			  s.device_id & 0x07,
> +			  s.segment_id,
> +			  s.no_fw_update);
> +
> +	tsm_dev_put(tdev);
> +	return ret1;
> +}
> +
> +static DEVICE_ATTR_RO(tsm_dev_status);
> +
> +static struct attribute *host_dev_attrs[] =3D {
> +	&dev_attr_tsm_cert_slot.attr,
> +	&dev_attr_tsm_dev_connect.attr,
> +	&dev_attr_tsm_dev_status.attr,
> +	NULL,
> +};
> +static const struct attribute_group host_dev_group =3D {
> +	.attrs =3D host_dev_attrs,
> +};
> +
> +static ssize_t tsm_tdi_bind_show(struct device *dev, struct
> device_attribute *attr, char *buf) +{
> +	struct tsm_tdi *tdi =3D container_of(dev, struct tsm_tdi, dev);
> +
> +	if (!tdi->kvm)
> +		return sysfs_emit(buf, "not bound\n");
> +
> +	return sysfs_emit(buf, "VM=3D%p BDFn=3D%x:%x.%d\n",
> +			  tdi->kvm,
> +			  (tdi->guest_rid >> 8) & 0xff,
> +			  (tdi->guest_rid >> 3) & 0x1f,
> +			  tdi->guest_rid & 0x07);
> +}
> +
> +static DEVICE_ATTR_RO(tsm_tdi_bind);
> +
> +static char *spdm_algos_to_str(u64 algos, char *buf, size_t len)
> +{
> +	size_t n =3D 0;
> +
> +	buf[0] =3D 0;
> +#define __ALGO(x) do {
> 			\
> +		if ((n < len) && (algos & (1ULL <<
> (TSM_TDI_SPDM_ALGOS_##x))))	\
> +			n +=3D snprintf(buf + n, len - n, #x"
> ");			\
> +	} while (0)
> +
> +	__ALGO(DHE_SECP256R1);
> +	__ALGO(DHE_SECP384R1);
> +	__ALGO(AEAD_AES_128_GCM);
> +	__ALGO(AEAD_AES_256_GCM);
> +	__ALGO(ASYM_TPM_ALG_RSASSA_3072);
> +	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P256);
> +	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P384);
> +	__ALGO(HASH_TPM_ALG_SHA_256);
> +	__ALGO(HASH_TPM_ALG_SHA_384);
> +	__ALGO(KEY_SCHED_SPDM_KEY_SCHEDULE);
> +#undef __ALGO
> +	return buf;
> +}
> +
> +static const char *tdisp_state_to_str(enum tsm_tdisp_state state)
> +{
> +	switch (state) {
> +#define __ST(x) case TDISP_STATE_##x: return #x
> +	case TDISP_STATE_UNAVAIL: return "TDISP state unavailable";
> +	__ST(CONFIG_UNLOCKED);
> +	__ST(CONFIG_LOCKED);
> +	__ST(RUN);
> +	__ST(ERROR);
> +#undef __ST
> +	default: return "unknown";
> +	}
> +}
> +
> +static ssize_t tsm_tdi_status_user_show(struct device *dev,
> +					struct device_attribute
> *attr,
> +					char *buf)
> +{
> +	struct tsm_tdi *tdi =3D container_of(dev, struct tsm_tdi, dev);
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	struct tsm_tdi_status ts =3D { 0 };
> +	char algos[256] =3D "";
> +	unsigned int n, m;
> +	int ret;
> +
> +	ret =3D tsm_tdi_status(tdi, hsubsys->private_data, &ts);
> +	if (ret < 0)
> +		return sysfs_emit(buf, "ret=3D%d\n\n", ret);
> +
> +	if (!ts.valid)
> +		return sysfs_emit(buf, "ret=3D%d\nstate=3D%d:%s\n",
> +				  ret, ts.state,
> tdisp_state_to_str(ts.state)); +
> +	n =3D snprintf(buf, PAGE_SIZE,
> +		     "ret=3D%d\n"
> +		     "state=3D%d:%s\n"
> +		     "meas_digest_fresh=3D%x\n"
> +		     "meas_digest_valid=3D%x\n"
> +		     "all_request_redirect=3D%x\n"
> +		     "bind_p2p=3D%x\n"
> +		     "lock_msix=3D%x\n"
> +		     "no_fw_update=3D%x\n"
> +		     "cache_line_size=3D%d\n"
> +		     "algos=3D%#llx:%s\n"
> +		     "report_counter=3D%lld\n"
> +		     ,
> +		     ret,
> +		     ts.state, tdisp_state_to_str(ts.state),
> +		     ts.meas_digest_fresh,
> +		     ts.meas_digest_valid,
> +		     ts.all_request_redirect,
> +		     ts.bind_p2p,
> +		     ts.lock_msix,
> +		     ts.no_fw_update,
> +		     ts.cache_line_size,
> +		     ts.spdm_algos, spdm_algos_to_str(ts.spdm_algos,
> algos, sizeof(algos) - 1),
> +		     ts.intf_report_counter);
> +
> +	n +=3D snprintf(buf + n, PAGE_SIZE - n, "Certs digest: ");
> +	m =3D hex_dump_to_buffer(ts.certs_digest,
> sizeof(ts.certs_digest), 32, 1,
> +			       buf + n, PAGE_SIZE - n, false);
> +	n +=3D min(PAGE_SIZE - n, m);
> +	n +=3D snprintf(buf + n, PAGE_SIZE - n, "...\nMeasurements
> digest: ");
> +	m =3D hex_dump_to_buffer(ts.meas_digest,
> sizeof(ts.meas_digest), 32, 1,
> +			       buf + n, PAGE_SIZE - n, false);
> +	n +=3D min(PAGE_SIZE - n, m);
> +	n +=3D snprintf(buf + n, PAGE_SIZE - n, "...\nInterface report
> digest: ");
> +	m =3D hex_dump_to_buffer(ts.interface_report_digest,
> sizeof(ts.interface_report_digest),
> +			       32, 1, buf + n, PAGE_SIZE - n, false);
> +	n +=3D min(PAGE_SIZE - n, m);
> +	n +=3D snprintf(buf + n, PAGE_SIZE - n, "...\n");
> +
> +	return n;
> +}
> +
> +static DEVICE_ATTR_RO(tsm_tdi_status_user);
> +
> +static ssize_t tsm_tdi_status_show(struct device *dev, struct
> device_attribute *attr, char *buf) +{
> +	struct tsm_tdi *tdi =3D container_of(dev, struct tsm_tdi, dev);
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	struct tsm_tdi_status ts =3D { 0 };
> +	u8 state;
> +	int ret;
> +
> +	ret =3D tsm_tdi_status(tdi, hsubsys->private_data, &ts);
> +	if (ret)
> +		return ret;
> +
> +	state =3D ts.state;
> +	memcpy(buf, &state, sizeof(state));
> +
> +	return sizeof(state);
> +}
> +
> +static DEVICE_ATTR_RO(tsm_tdi_status);
> +
> +static struct attribute *host_tdi_attrs[] =3D {
> +	&dev_attr_tsm_tdi_bind.attr,
> +	&dev_attr_tsm_tdi_status_user.attr,
> +	&dev_attr_tsm_tdi_status.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group host_tdi_group =3D {
> +	.attrs =3D host_tdi_attrs,
> +};
> +
> +int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd)
> +{
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	struct fd f =3D fdget(kvmfd);
> +	struct kvm *kvm;
> +	u64 vmid;
> +	int ret;
> +
> +	if (!fd_file(f))
> +		return -EBADF;
> +
> +	if (!file_is_kvm(fd_file(f))) {
> +		ret =3D -EBADF;
> +		goto out_fput;
> +	}
> +
> +	kvm =3D fd_file(f)->private_data;
> +	if (!kvm || !kvm_get_kvm_safe(kvm)) {
> +		ret =3D -EFAULT;
> +		goto out_fput;
> +	}
> +
> +	vmid =3D kvm_arch_tsm_get_vmid(kvm);
> +	if (!vmid) {
> +		ret =3D -EFAULT;
> +		goto out_kvm_put;
> +	}
> +
> +	if (WARN_ON(!hsubsys->ops->tdi_bind)) {
> +		ret =3D -EPERM;
> +		goto out_kvm_put;
> +	}
> +
> +	if (!tdev->connected) {
> +		ret =3D -EIO;
> +		goto out_kvm_put;
> +	}
> +
> +	mutex_lock(&tdi->tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->tdi_bind(tdi, guest_rid, vmid);
> +		if (ret < 0)
> +			break;
> +
> +		if (!ret)
> +			break;
> +
> +		ret =3D
> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
> +		if (ret < 0)
> +			break;
> +	}
> +	mutex_unlock(&tdi->tdev->spdm_mutex);
> +
> +	if (ret) {
> +		tsm_tdi_unbind(tdi);
> +		goto out_kvm_put;
> +	}
> +
> +	tdi->guest_rid =3D guest_rid;
> +	tdi->kvm =3D kvm;
> +	++tdi->tdev->bound;
> +	goto out_fput;
> +
> +out_kvm_put:
> +	kvm_put_kvm(kvm);
> +out_fput:
> +	fdput(f);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tsm_tdi_bind);
> +
> +void tsm_tdi_unbind(struct tsm_tdi *tdi)
> +{
> +	if (tdi->kvm) {
> +		tsm_tdi_reclaim(tdi);
> +		--tdi->tdev->bound;
> +		kvm_put_kvm(tdi->kvm);
> +		tdi->kvm =3D NULL;
> +	}
> +
> +	tdi->guest_rid =3D 0;
> +	tdi->dev.parent->tdi_enabled =3D false;
> +}
> +EXPORT_SYMBOL_GPL(tsm_tdi_unbind);
> +
> +int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t
> reqlen,
> +		      u8 __user *res, size_t reslen, int *fw_err)
> +{
> +	struct tsm_dev *tdev =3D tdi->tdev;
> +	struct tsm_host_subsys *hsubsys =3D (struct tsm_host_subsys *)
> tdev->tsm;
> +	int ret;
> +
> +	if (!hsubsys->ops->guest_request)
> +		return -EPERM;
> +
> +	mutex_lock(&tdi->tdev->spdm_mutex);
> +	while (1) {
> +		ret =3D hsubsys->ops->guest_request(tdi, req, reqlen,
> +						  res, reslen,
> fw_err);
> +		if (ret <=3D 0)
> +			break;
> +
> +		ret =3D
> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm,
> +							    ret);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	mutex_unlock(&tdi->tdev->spdm_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tsm_guest_request);
> +
> +struct tsm_host_subsys *tsm_host_register(struct device *parent,
> +					  struct tsm_hv_ops *hvops,
> +					  void *private_data)
> +{
> +	struct tsm_subsys *subsys =3D tsm_register(parent,
> sizeof(struct tsm_host_subsys),
> +						 &host_dev_group,
> &host_tdi_group,
> +
> tsm_tdi_measurements_locked);
> +	struct tsm_host_subsys *hsubsys;
> +
> +	hsubsys =3D (struct tsm_host_subsys *) subsys;
> +
> +	if (IS_ERR(hsubsys))
> +		return hsubsys;
> +
> +	hsubsys->ops =3D hvops;
> +	hsubsys->private_data =3D private_data;
> +
> +	return hsubsys;
> +}
> +EXPORT_SYMBOL_GPL(tsm_host_register);
> +
> +static int __init tsm_init(void)
> +{
> +	int ret =3D 0;
> +
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	return ret;
> +}
> +
> +static void __exit tsm_exit(void)
> +{
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "
> shutdown\n"); +}
> +
> +module_init(tsm_init);
> +module_exit(tsm_exit);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> new file mode 100644
> index 000000000000..b6235d1210ca
> --- /dev/null
> +++ b/drivers/virt/coco/tsm.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/tsm.h>
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"aik@amd.com"
> +#define DRIVER_DESC	"TSM library"
> +
> +static struct class *tsm_class, *tdev_class, *tdi_class;
> +
> +/* snprintf does not check for the size, hence this wrapper */
> +static int tsmprint(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	size_t i;
> +
> +	if (!size)
> +		return 0;
> +
> +	va_start(args, fmt);
> +	i =3D vsnprintf(buf, size, fmt, args);
> +	va_end(args);
> +
> +	return min(i, size);
> +}
> +
> +struct tsm_blob *tsm_blob_new(void *data, size_t len)
> +{
> +	struct tsm_blob *b;
> +
> +	if (!len || !data)
> +		return NULL;
> +
> +	b =3D kzalloc(sizeof(*b) + len, GFP_KERNEL);
> +	if (!b)
> +		return NULL;
> +
> +	b->data =3D (void *)b + sizeof(*b);
> +	b->len =3D len;
> +	memcpy(b->data, data, len);
> +
> +	return b;
> +}
> +EXPORT_SYMBOL_GPL(tsm_blob_new);
> +
> +static int match_class(struct device *dev, const void *data)
> +{
> +	return dev->class =3D=3D data;
> +}
> +
> +struct tsm_dev *tsm_dev_get(struct device *parent)
> +{
> +	struct device *dev =3D device_find_child(parent, tdev_class,
> match_class); +
> +	if (!dev) {
> +		dev =3D device_find_child(parent, tdi_class,
> match_class);
> +		if (dev) {
> +			struct tsm_tdi *tdi =3D container_of(dev,
> struct tsm_tdi, dev); +
> +			dev =3D &tdi->tdev->dev;
> +		}
> +	}
> +
> +	if (!dev)
> +		return NULL;
> +
> +	/* device_find_child() does get_device() */
> +	return container_of(dev, struct tsm_dev, dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_dev_get);
> +
> +void tsm_dev_put(struct tsm_dev *tdev)
> +{
> +	put_device(&tdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_dev_put);
> +
> +struct tsm_tdi *tsm_tdi_get(struct device *parent)
> +{
> +	struct device *dev =3D device_find_child(parent, tdi_class,
> match_class); +
> +	if (!dev)
> +		return NULL;
> +
> +	/* device_find_child() does get_device() */
> +	return container_of(dev, struct tsm_tdi, dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_tdi_get);
> +
> +void tsm_tdi_put(struct tsm_tdi *tdi)
> +{
> +	put_device(&tdi->dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_tdi_put);
> +
> +static ssize_t blob_show(struct tsm_blob *blob, char *buf)
> +{
> +	unsigned int n, m;
> +	size_t sz =3D PAGE_SIZE - 1;
> +
> +	if (!blob)
> +		return sysfs_emit(buf, "none\n");
> +
> +	n =3D tsmprint(buf, sz, "%lu %u\n", blob->len);
> +	m =3D hex_dump_to_buffer(blob->data, blob->len, 32, 1,
> +			       buf + n, sz - n, false);
> +	n +=3D min(sz - n, m);
> +	n +=3D tsmprint(buf + n, sz - n, "...\n");
> +	return n;
> +}
> +
> +static ssize_t tsm_certs_gen(struct tsm_blob *certs, char *buf,
> size_t len) +{
> +	struct spdm_certchain_block_header *h;
> +	unsigned int n =3D 0, m, i, off, o2;
> +	u8 *p;
> +
> +	for (i =3D 0, off =3D 0; off < certs->len; ++i) {
> +		h =3D (struct spdm_certchain_block_header *) ((u8
> *)certs->data + off);
> +		if (WARN_ON_ONCE(h->length > certs->len - off))
> +			return 0;
> +
> +		n +=3D tsmprint(buf + n, len - n, "[%d] len=3D%d:\n", i,
> h->length); +
> +		for (o2 =3D 0, p =3D (u8 *)&h[1]; o2 < h->length; o2 +=3D
> 32) {
> +			m =3D hex_dump_to_buffer(p + o2, h->length -
> o2, 32, 1,
> +					       buf + n, len - n,
> true);
> +			n +=3D min(len - n, m);
> +			n +=3D tsmprint(buf + n, len - n, "\n");
> +		}
> +
> +		off +=3D h->length; /* Includes the header */
> +	}
> +
> +	return n;
> +}
> +

> +
> +void tsm_dev_free(struct tsm_dev *tdev)
> +{
> +	dev_notice(&tdev->dev, "Freeing tdevice\n");
> +	device_unregister(&tdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_dev_free);
> +
> +int tsm_create_link(struct tsm_subsys *tsm, struct device *dev,
> const char *name) +{
> +	return sysfs_create_link(&tsm->dev.kobj, &dev->kobj, name);
> +}
> +EXPORT_SYMBOL_GPL(tsm_create_link);
> +
> +void tsm_remove_link(struct tsm_subsys *tsm, const char *name)
> +{
> +	sysfs_remove_link(&tsm->dev.kobj, name);
> +}
> +EXPORT_SYMBOL_GPL(tsm_remove_link);
> +
> +static struct tsm_subsys *alloc_tsm_subsys(struct device *parent,
> size_t size) +{
> +	struct tsm_subsys *subsys;
> +	struct device *dev;
> +
> +	if (WARN_ON_ONCE(size < sizeof(*subsys)))
> +		return ERR_PTR(-EINVAL);
> +
> +	subsys =3D kzalloc(size, GFP_KERNEL);
> +	if (!subsys)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev =3D &subsys->dev;
> +	dev->parent =3D parent;
> +	dev->class =3D tsm_class;
> +	device_initialize(dev);
> +	return subsys;
> +}
> +
> +struct tsm_subsys *tsm_register(struct device *parent, size_t size,
> +				const struct attribute_group
> *tdev_ag,
> +				const struct attribute_group *tdi_ag,
> +				int (*update_measurements)(struct
> tsm_dev *tdev)) +{
> +	struct tsm_subsys *subsys =3D alloc_tsm_subsys(parent, size);
> +	struct device *dev;
> +	int rc;
> +
> +	if (IS_ERR(subsys))
> +		return subsys;
> +
> +	dev =3D &subsys->dev;
> +	rc =3D dev_set_name(dev, "tsm0");
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc =3D device_add(dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	subsys->tdev_groups[0] =3D &dev_group;
> +	subsys->tdev_groups[1] =3D tdev_ag;
> +	subsys->tdi_groups[0] =3D &tdi_group;
> +	subsys->tdi_groups[1] =3D tdi_ag;
> +	subsys->update_measurements =3D update_measurements;
> +
> +	return subsys;
> +}
> +EXPORT_SYMBOL_GPL(tsm_register);
> +
> +void tsm_unregister(struct tsm_subsys *subsys)
> +{
> +	device_unregister(&subsys->dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister);
> +
> +static void tsm_release(struct device *dev)
> +{
> +	struct tsm_subsys *tsm =3D container_of(dev, typeof(*tsm),
> dev); +
> +	dev_info(&tsm->dev, "Releasing TSM\n");
> +	kfree(tsm);
> +}
> +
> +static void tdev_release(struct device *dev)
> +{
> +	struct tsm_dev *tdev =3D container_of(dev, typeof(*tdev), dev);
> +
> +	dev_info(&tdev->dev, "Releasing %s TDEV\n",
> +		 tdev->connected ? "connected":"disconnected");
> +	kfree(tdev);
> +}
> +
> +static void tdi_release(struct device *dev)
> +{
> +	struct tsm_tdi *tdi =3D container_of(dev, typeof(*tdi), dev);
> +
> +	dev_info(&tdi->dev, "Releasing %s TDI\n", tdi->kvm ? "bound"
> : "unbound");
> +	sysfs_remove_link(&tdi->dev.parent->kobj, "tsm_dev");
> +	kfree(tdi);
> +}
> +
> +static int __init tsm_init(void)
> +{
> +	int ret =3D 0;
> +
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	tsm_class =3D class_create("tsm");
> +	if (IS_ERR(tsm_class))
> +		return PTR_ERR(tsm_class);
> +	tsm_class->dev_release =3D tsm_release;
> +
> +	tdev_class =3D class_create("tsm-dev");
> +	if (IS_ERR(tdev_class))
> +		return PTR_ERR(tdev_class);
> +	tdev_class->dev_release =3D tdev_release;
> +
> +	tdi_class =3D class_create("tsm-tdi");
> +	if (IS_ERR(tdi_class))
> +		return PTR_ERR(tdi_class);
> +	tdi_class->dev_release =3D tdi_release;
> +
> +	return ret;
> +}
> +
> +static void __exit tsm_exit(void)
> +{
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "
> shutdown\n");
> +	class_destroy(tdi_class);
> +	class_destroy(tdev_class);
> +	class_destroy(tsm_class);
> +}
> +
> +module_init(tsm_init);
> +module_exit(tsm_exit);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/Documentation/virt/coco/tsm.rst
> b/Documentation/virt/coco/tsm.rst new file mode 100644
> index 000000000000..7cb5f1862492
> --- /dev/null
> +++ b/Documentation/virt/coco/tsm.rst
> @@ -0,0 +1,99 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +What it is
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This is for PCI passthrough in confidential computing (CoCo:
> SEV-SNP, TDX, CoVE). +Currently passing through PCI devices to a CoCo
> VM uses SWIOTLB to pre-shared +memory buffers.
> +
> +PCIe IDE (Integrity and Data Encryption) and TDISP (TEE Device
> Interface Security +Protocol) are protocols to enable encryption over
> PCIe link and DMA to encrypted +memory. This doc is focused to DMAing
> to encrypted VM, the encrypted host memory is +out of scope.
> +
> +
> +Protocols
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +PCIe r6 DOE is a mailbox protocol to read/write object from/to
> device. +Objects are of plain SPDM or secure SPDM type. SPDM is
> responsible for authenticating +devices, creating a secure link
> between a device and TSM. +IDE_KM manages PCIe link encryption keys,
> it works on top of secure SPDM. +TDISP manages a passed through PCI
> function state, also works on top on secure SPDM. +Additionally, PCIe
> defines IDE capability which provides the host OS a way +to enable
> streams on the PCIe link. +
> +
> +TSM modules
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +TSM is a library, shared among hosts and guests.
> +
> +TSM-HOST contains host-specific bits, controls IDE and TDISP
> bindings. +
> +TSM-GUEST contains guest-specific bits, controls enablement of
> encrypted DMA and +MMIO.
> +
> +TSM-PCI is PCI binding for TSM, calls the above libraries for
> setting up +sysfs nodes and corresponding data structures.
> +
> +
> +Flow
> +=3D=3D=3D=3D
> +
> +At the boot time the tsm.ko scans the PCI bus to find and setup
> TDISP-cabable +devices; it also listens to hotplug events. If setup
> was successful, tsm-prefixed +nodes will appear in sysfs.
> +
> +Then, the user enables IDE by writing to
> /sys/bus/pci/devices/0000:e1:00.0/tsm_dev_connect +and this is how
> PCIe encryption is enabled. +
> +To pass the device through, a modifined VMM is required.
> +
> +In the VM, the same tsm.ko loads. In addition to the host's setup,
> the VM wants +to receive the report and enable secure DMA or/and
> secure MMIO, via some VM<->HV +protocol (such as AMD GHCB). Once this
> is done, a VM can access validated MMIO +with the Cbit set and the
> device can DMA to encrypted memory. +
> +The sysfs example from a host with a TDISP capable device:
> +
> +~> find /sys -iname "*tsm*" =20
> +/sys/class/tsm-tdi
> +/sys/class/tsm
> +/sys/class/tsm/tsm0
> +/sys/class/tsm-dev
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm_dev
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00=
.1/tsm_tdi_bind
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00=
.1/tsm_tdi_status
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00=
.1/tsm_tdi_status_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00=
.1/tsm_report_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00=
.1/tsm_report
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm_dev
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00=
.0/tsm_tdi_bind
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00=
.0/tsm_tdi_status
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00=
.0/tsm_tdi_status_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00=
.0/tsm_report_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00=
.0/tsm_report
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_certs
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_nonce
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_meas_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_certs_user
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_dev_status
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_cert_slot
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_dev_connect
> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:0=
0.0/tsm_meas
> +/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm
> +/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm/tsm0
> +
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[1] TEE Device Interface Security Protocol - TDISP - v2022-07-27
> +https://members.pcisig.com/wg/PCI-SIG/document/18268?downloadRevision=3D=
21500
> +[2] Security Protocol and Data Model (SPDM)
> +https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2=
.1.pdf
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index 819a97e8ba99..e4385247440b 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -3,6 +3,18 @@
>  # Confidential computing related collateral
>  #
> =20
> +config TSM
> +	tristate "Platform support for TEE Device Interface Security
> Protocol (TDISP)"
> +	default m
> +	depends on AMD_MEM_ENCRYPT
> +	select PCI_DOE
> +	select PCI_IDE
> +	help
> +	  Add a common place for user visible platform support for
> PCIe TDISP.
> +	  TEE Device Interface Security Protocol (TDISP) from
> PCI-SIG,
> +
> https://pcisig.com/tee-device-interface-security-protocol-tdisp
> +	  This is prerequisite for host and guest support.
> +
>  source "drivers/virt/coco/efi_secret/Kconfig"
> =20
>  source "drivers/virt/coco/pkvm-guest/Kconfig"
> @@ -14,3 +26,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>  source "drivers/virt/coco/arm-cca-guest/Kconfig"
> =20
>  source "drivers/virt/coco/guest/Kconfig"
> +
> +source "drivers/virt/coco/host/Kconfig"
> diff --git a/drivers/virt/coco/host/Kconfig
> b/drivers/virt/coco/host/Kconfig new file mode 100644
> index 000000000000..3bde38b91fd4
> --- /dev/null
> +++ b/drivers/virt/coco/host/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TSM (TEE Security Manager) Common infrastructure and host drivers
> +#
> +config TSM_HOST
> +	tristate


