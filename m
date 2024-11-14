Return-Path: <linux-arch+bounces-9101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620799C9333
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 21:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F81F22DF1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F71ABEA5;
	Thu, 14 Nov 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QjoO2/I0"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614321A265B;
	Thu, 14 Nov 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616022; cv=fail; b=F2UD/106msjMQ0Ux8Ly/+m+SB8SHhoiNmjeNpqSyrGtYYeVGZILfUEKrJj0cIJzaQf4KqfMqcc35Fo/enYU/g7CAbeN7qYoaAysy5tqGjY/nyUZLcNYJENybokPTt4DOVApYbDbHFMOBEu5eqTKAXW7LTVr0AR3WZi1dJw3GyS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616022; c=relaxed/simple;
	bh=A2NCjXYnQsUuxF/c0BkdmihQkTZZxjsjC63Au5jjMSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a7XF2RHqFzKnKuvcU7K0fa4gqpkSjp3eAxxmqb+BGNdvWm6yDIrxxODrM4oDHkx3DAtbTBuY32lBft/wX/1IEaGBKAiCh5upTvDo/H+17EgRdtxq92yrV4m65iJHppR1wIZQVR2oyr3eKCemmmAqqEgnPYofeBa6Rx5M9vQjSxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QjoO2/I0; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGL0yhdOTdQhkYcLvA33Qme57ZbPt910fiV7D0kM8RFAxRhwmekAWrxtAm5bJpyRHahnw7bkh9dtHxbOyZL1iUDMCFWcu1fgcnpG8Kw+gMGbJ4OjL4Gmsk9mZFYN4xL9t5ituVOiYHEMTj6bmIZF0ShOmv8OJbclBJag7FHJg4VrHTz2QjQd7tRBT77c6WkXEvugU4RBrbke/Tzwe/XuhODZsRK6dUcLRDWJ+aEA11HAc5EA1R+mohui+KXORnieU6sh0OrDaOjfnrcNsMCVLeGES8oBbr/zgcaF+mtf61yuKDBGU0QvfjdnKDmENhju74IF/i+hl8HlidcRgl831g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P3IViAvkUbNLMivN5WtMKW77DzByYj57puLWMiUh6g=;
 b=Wi+NoDDkFHBhMv6o5G42Lein/ohU6eUY5x1ITTHnLSS0Weumkgyy5Qaj6E0ogNjn3uJX1So+3trMp7Hs3qjI2st1DxNbCPMUdrIRwei+8s9SBP2CAKohhmcgZtqxVDb3Ov6SMK1PQN6h7/fRnWnPIv9P85fpUNcIasZRRnQ7yjuFAG2PiC+XNmtS0Xl2Vhcl705onBLixuLZ6yYA7qjFVTFmYKoTHYrvKixb2jq+iG6BBerGCmqmkoKtzNTjUa2DJLSdHnlV5b3t7SsKxI00BJHWSrpwpQEBKM/3gL3f+/Hgtx3G8mvyTlTyvWDRgIvUZSgAaYUcpiKxQbiBlcPUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P3IViAvkUbNLMivN5WtMKW77DzByYj57puLWMiUh6g=;
 b=QjoO2/I063tbSXXP3ZZOG36TN26vPKEYtzc1C3SwGH4oJtUfUd6Gr1ygN+bwNb/DY2vKkgMS6Dum8VMh2AEHxlDVoe2MqU34EDNp3akIGFI1zf3SPAwfkgLmP+0r2c97eF3tuiZ4EEanTjcaq/v9Or6kPCa4esazuGiMzYHfr5FA6/8U4rClXscfbNWtGiknKZltN6+l6HcMwCJ7SWbr1HAG2Ca9Xb4ATi231N/2shY96h9YCySNq1KjSPcn5kvtVsOk0Y8Pi03ojKGBj4Hy93rXywkelFpNrs3pzB+FoXRHAgIDz8NmUmWdxeSKvTAfbDx3rNIiLfQKZKaVbApxpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Thu, 14 Nov
 2024 20:26:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 20:26:54 +0000
Date: Thu, 14 Nov 2024 16:26:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, arnd@arndb.de,
	ubizjak@gmail.com, linux-arch@vger.kernel.org, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v11 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241114202653.GV35230@nvidia.com>
References: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
 <20241114194436.389961-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114194436.389961-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c91e98e-ca2b-401c-085f-08dd04eaadf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6nn1VtwrUXa3W6kwkk5A3Ecw0BJbDSevjVFi4r9u7CBRLRr4BUqCqkyd05J?=
 =?us-ascii?Q?7CRsxQp/gES4GhrNdhWFHZbuZvhZagWPxZSy4irC5aKjKphrBJ2ELNVmXxOl?=
 =?us-ascii?Q?QyoghponasZxT/4dqIZEMXPLq3l8tN3b966CJ66ojfWb5tnJ9/y/1oyKY7sV?=
 =?us-ascii?Q?6shNeB26d308ZbykefYbXQE/X4TmyZaEDtTmGk6NCgQe/chjnbZ3yU2X+rTu?=
 =?us-ascii?Q?xBcdhIkoJo2JXIe5ZQA9wR5CnDkOC75ZPYd91cMv0WgdVOhCspFrDU8ovgvI?=
 =?us-ascii?Q?PF6iVtAV+BxV/hUADWjoJ9ChytABsNJ/xthuKbpGyfgDmj5i4QYcHJl+gq4X?=
 =?us-ascii?Q?vZ8tfx82G3Kt1ZcwJc6dVa/vd3e+u0AFDIza583mBiExP80NqCEIDhOkQEbc?=
 =?us-ascii?Q?LdwZQZy4VBQOSGLgMOfVesZzJ+8ssig55u9Qg2pXDCh6wTDQtV6C63FDdgxQ?=
 =?us-ascii?Q?SaRJG7qhfuaJ4HbryEywMEVxlKbhkqfl75BHdR7ZQjNgLYAXhAiyqKm13CeQ?=
 =?us-ascii?Q?uZye0DfO8lwLbvdG4fCC1BmGOP2jKxOo9On47wd1oIKX5sztcLH4YBtC1b6R?=
 =?us-ascii?Q?mMAI9iet9Nre95x1ybkajJpSYVaWrYudL7QikSbuq2DIb/w+ICJcnaiUhXmT?=
 =?us-ascii?Q?oIvdI9o4tXhCK/1qkqPL8xMMiTZ1YXXyI1eW2SsjEAylIo90K1qyuQlzZa5P?=
 =?us-ascii?Q?nFofp2cwyyB+9oQtkPpLaLdQMa7Eg+bA3ckFLaUOpdCSaaTN6DOtm6vHSlUL?=
 =?us-ascii?Q?qP5xw0wPiOB5Gq+wX27Qsqh/PfUX16Hot3t6wNM/NYdOXD4bLFiiXaf5fOwV?=
 =?us-ascii?Q?S91o6uGlzUqRoIpkDZDul59uXd964CTJ9KFvmJ0qynC+pK0M9mQ9n3GVBiq0?=
 =?us-ascii?Q?Rfu3zmqdY3PMixSNNXKrZ5mHh4mwG48gbR4qZ+BtbaCv2UbYt0t5I73uRreH?=
 =?us-ascii?Q?wWZke1t2bgwvOcgQAQE9yKHBITxtTfZA9AEKyiUIKztdq0rqgik0Ire8ZmkG?=
 =?us-ascii?Q?Fe1k+eUDUTC5BjqzvSQwe82J93J1harOk+GXtnj7wwcN53EwvUDGfRIMIMCH?=
 =?us-ascii?Q?OJoQlZHwgrGHSmdM2oTDkYWqs+n27aJ0AJhV6ytLzPNFxiqonjD6Kc9O9c2s?=
 =?us-ascii?Q?7I1Jka1ulqA3ZHgGL653NOVzKVS3rkcAtfuINuHfV9kCHzCbDeeieJNzbsOr?=
 =?us-ascii?Q?oZJuDJF/3CbyYE0Rcknv9FVfa7EDpUSb4y+0YmcZCl11CLqT5O8eo7u8rvOc?=
 =?us-ascii?Q?SUXiMsQnzFU6+3ITmeeYHtArX9Jsgxx+5TzFOHWZJaD6nISIe0+w+Ydwg2Qi?=
 =?us-ascii?Q?SHtj23IkG/V5fvQKRcmb/tFB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yA+lunKys3kMiBJF84nLO/EsaGRMpN61ic6ayizocppktHpfhLJPy4EAyQ2?=
 =?us-ascii?Q?XoENMYTWPH34VMdi/Vw4aYjOgXGVrKY0mFdqAvseHyTu1RQTtq1fQq8oB59K?=
 =?us-ascii?Q?ZNL5vp62S9Ax0KOybHj4BLaa1474a9gASFv6NMzwHg4mo276lgc1+fuqWTAk?=
 =?us-ascii?Q?Aqg7uEqq8uzhQdVpNEMXx0R7DWzIDTp8mEgARdaVkg+FKxtGUzb05A9Yk0Aw?=
 =?us-ascii?Q?SVGX/2eGTF0zyuZx7humg9D4QUyhNskgqOv0EtD+QsapEKmDK28TG4w9bLli?=
 =?us-ascii?Q?Vj/lGv1A6scv0hQpKXcN6F+WSdAmwtNNVsFtNb7PnoeHLCRqB589co879VGH?=
 =?us-ascii?Q?RdDrNDFoTqcofx5NAxhOLYhSCUa+QC9GxpWBHQBfPat0FSzFeonn2+K7O7zR?=
 =?us-ascii?Q?WTiXBDZ98gVw8Ceb0G2FXjPdi/M3yBW7uvVp2771El0lHFGRgCEUmNpl7pWT?=
 =?us-ascii?Q?1dQC5aXM8gMZJkVRC1g8rlCR628blv9oeyhx5k1Etke0sbLDftoTt5ibwZ4M?=
 =?us-ascii?Q?7pL8afj8ZoJese3+iMS/qem6z1phYa1K/pDqVy3VAlPuv8GHiA+RNtJdg6X4?=
 =?us-ascii?Q?vuX902xEl9BTS7tw1ola/E6mNq3wr09GKenIDzNmIsZNaPG4Q8ENWTkO3LRt?=
 =?us-ascii?Q?KcugLyy083SrFRgigkzSdYvbtqbujiKHI3K0d29PfG10GjZpuKR3LK52gllN?=
 =?us-ascii?Q?0wQe5gPfLwITFdXMRPb1W56vd3AIwa20tcbgtlEKg7NWOiRuMaE1QQR5Y8fD?=
 =?us-ascii?Q?y3iaeeQeAqvnk87Mafxqo5S8rXMJX7vPOGp8Xt0DJ7ghvYIbxYTIngcBMcHc?=
 =?us-ascii?Q?Fl3RV7mKWVjvG9mEH3vp/AqrWMZnlZucWWdwhs9b+6fiuEvZbwHE+s0PXTCx?=
 =?us-ascii?Q?oPkO6g2KpHnj+lUVbnghClE5+FIZXj1ueSnZu0AS+1be1/aoOlQTlsjhI4OF?=
 =?us-ascii?Q?74O66s0yo95tOxjEOQsJ/3iQLEpc/ZTI/EbW+omstm//1+0NWHtLid3XhTK4?=
 =?us-ascii?Q?d3WMu2UMsVbqjB2fFnQHYeZNOfwsM9MVg9CiE8WngVrbkd1awCg37buoT0to?=
 =?us-ascii?Q?76GbK33iOO8vpih2QenJCIepNv7FoS7VnC5FISH3tfHzAtV7o/h3r2YFuTcV?=
 =?us-ascii?Q?XiibUOzEXr10M2hBrjQGSHWPcGL5Pk16Cui1XCsU4bRvsHsb1jRGc6t9HO/D?=
 =?us-ascii?Q?uGJreHV3k4VXcNZYUU+xAhUTK++QV9Dcy7ryDUwghqoSdgUVP0GSxLDmhrZE?=
 =?us-ascii?Q?WISj89mT7QmQsvVjqXlfE3qanTVZgFq8QFcFu2AkHf4PlMAXz/wapwVDbQUt?=
 =?us-ascii?Q?zMNDgyNA2kFXpCDjm/Pxqit9vqJ4/Aui2HT4k7fXaEVnfLuifdlVumY63vMg?=
 =?us-ascii?Q?SJkBN8AU/jEV6bKPA2Opl84aH6sSFf6AUPnI9TMR2OpD6lK8hd4AG6D7hpY/?=
 =?us-ascii?Q?r05dnwTqI+SyaXWByyxmzDqVryJKIWwiduu4wM3Du+RJ1I29JXHhjzxvy5rC?=
 =?us-ascii?Q?hLpCUlBj1sCpAooJgRCrhEMuU03rqhLzVtUkUnxFYKcln2rt4/qGaUYI/DWN?=
 =?us-ascii?Q?8WE5jto69U0nkTbyMiI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c91e98e-ca2b-401c-085f-08dd04eaadf2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:26:54.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6cKxLEyuP7z8D8xPp0Dn7mLtIYcsOjpOMDdpjmfnN3m1dSiOuGH7ucJWv++Gw6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

On Thu, Nov 14, 2024 at 07:44:32PM +0000, Suravee Suthikulpanit wrote:
> Also, the set_dte_entry() is used to program several DTE fields (e.g.
> stage1 table, stage2 table, domain id, and etc.), which is difficult
> to keep track with current implementation.
> 
> Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
> another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
> GLX, and GuestPagingMode into another function set_dte_gcr3_table().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   2 +
>  drivers/iommu/amd/amd_iommu_types.h |  13 +--
>  drivers/iommu/amd/init.c            |  30 ++++++-
>  drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
>  4 files changed, 106 insertions(+), 68 deletions(-)

Got lost on v10:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

