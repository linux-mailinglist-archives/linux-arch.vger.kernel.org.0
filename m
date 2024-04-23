Return-Path: <linux-arch+bounces-3902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1D8ADB0A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 02:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B801F24E3B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 00:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730811EB21;
	Tue, 23 Apr 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1k9STT4"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483F1DDC5;
	Tue, 23 Apr 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831532; cv=fail; b=jo9RssshkOxCh6zk50m87zwSkdLNw+PuG3hsXFvVwXwR5ZJWazhPS8P7D6+21Yj5cbDKhCN1rV8ujkExu/99HlE9c+0rbQnB9w/o/1xmZ+rza7g+/Wh5h8G2uPyE6WiYH+S4foH2qr7LAc9QtK4ypHVxY2CT+q99rDW84oe7uFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831532; c=relaxed/simple;
	bh=8fXtGCb5VCixjKLMloWpJEuxZNtqHuih5H85WiwqDYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RaeV8oW//X0s2OOOv/UEINwbqS1hkgPv+p6GXqaYjs7pL/2UjYKR5X3zxB7w9rhYjBZhBAfS4i9wWcLM8+ORcHI4RN6eefwsHW43OvWSkbyglVLPum88gF4OnUsOlb/+ROMs+cB4wM8JvyrGEILN/jNINaKJdRvxTA+RPYLfAVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1k9STT4; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hayau5Wu0MDTetmzCj9km+jFYogjdVHNqlkJwDYsR//8+NeO4pRGxiTCrxfG48XY4wi1Xyp+bhe4b00WQvIIBgjFai8jhN0In5pEyvf/csQrTR1TKDf116mZESbpgu4LqVlMgeAXLgB2JQv+Y73zh6jFbQGg1R5IY8766VTAODcLTamFSeuN31OW7SQYOpDv+BcjwRzL/Ig3PGRghB504Ozt/035Fd1dCA+jiIjOumREypwG/Pc3FvQ2iwvPow+beXXzhGgxrkbN0hZn2l4rgY9iVfjtLjlf/3ipFE3zF1lZcw5R1zhLOWJ+Bj4cf1rF2EVQIEstirjo7qcLrPQplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSP0A4dnDfYE7yIsaRsJ4UOULqHEO5czRqdcMFOKmhE=;
 b=TGynlP9bgrV5orC+hdebU2wLC2J9p1Mv1WnEGAmx4C07/YCIIKZT/SxqxznTu1Rd/I4h152YRXAUCVoH6HDOoNXY9gtNr7w48epWkrY2MUPUdBY04YlCC9B6uTk0EjLcerYqT5JJgfxCyKCgsqlEycg9n8tX2i4pbgo76Zcfablr1xG3rI9kbE8HO6pk/SDYQEOHsVP7zVvfM5Lzjif0rKv1qhIT8rPd63UuIKz+BrM6P7dyUVIH/+5+v+hBkcJsLrB3FKgqDICoPpslbDq3OebX3dG212azxnO18EvDjWtGqVT7/4q+EDoqDqp7LIL/yGe/wGil5DilqdAAiTDYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSP0A4dnDfYE7yIsaRsJ4UOULqHEO5czRqdcMFOKmhE=;
 b=G1k9STT4gb/Sql7H72KgvFj64IPZHCq803y8cQ10+NDTkB8gBuyJhlp2CCLluYa10jxgY7TMsHrOHry69frPu0ocBkIjDvc4fCxZvygx4XdiFF4mMSBFA8AdBzD3hTE/yE0gcm6gWVCwYYeAiaPKO65gNgPXDoxPvadJkPE9NY+/Kr33EsrDiumU/aD6i2deEkXkiZrjxsNm6pOqW0T8smRh0gLv7l7Z6ue42hBNSoBXKHE1afm3IXeSkfFSb/L/bIs1xrUcn1Dhxj5jhvBNdJqXsYIhfwD/OZwbuWqUcj1AVxgfk759aV6qK/BRcH0QTU+UR0wDV0IQQAlZWocgRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 00:18:48 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 00:18:47 +0000
Date: Mon, 22 Apr 2024 21:18:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/6] Fix mlx5 write combining support on new ARM64
 cores
Message-ID: <20240423001846.GA434811@nvidia.com>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:208:234::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: ff240891-ee22-4ce0-6ad7-08dc632af1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIQyRpmxnMtiiXYgO2Y02qcU70ObJThv8quvUeaStimnxUwMKxSQ4kDobpg7?=
 =?us-ascii?Q?HQLN9m/tE1ZqNISfEEHQe14gdcMxRI9QHeD8rMWcA6PpH2pVmGJwQVTngdSu?=
 =?us-ascii?Q?/QQSX6Bx0qIvDokRyOYxfSaujcw7biT5kFcRHIl/8r+R3dWC47oafW7YLcce?=
 =?us-ascii?Q?lzHNjeNvttVOO/nQ/bFQdInJN49topRxfQx23pMnCOKh2ImgZgwVuJPL/TRv?=
 =?us-ascii?Q?zhRVIkhg9IFeVO/G4CNBSMd6ybiplp9GzbsLzyRKHSjf5f2pSE22cd5s1ec+?=
 =?us-ascii?Q?B4DNSOf6vCNMe6wbTm4Kd7wzptVwwR5pA69IJtbMrgd1kUH1yji8slKXxdUq?=
 =?us-ascii?Q?79oEXT7VwEohfFyKcPdCdqb0EKCGLlpi/9chVX7KlwKcxCGPGYEztdL6TRls?=
 =?us-ascii?Q?PDfRtSVN7VDkk4JXGTcnbgjE/kVTCWc16idc0skcW50dgmCc4F2qXmgm32II?=
 =?us-ascii?Q?5WOI4bDbVS7ro+HFMIWqcDwq3Eid7HLMftKwQqZZBrE+0uFA8DyqZaRI0/ch?=
 =?us-ascii?Q?E3qy41M2C2K27TvG/z9wE1DQnn4n+lytqCbiGSZ0w/Cm9cIsbpjMCbNyK7UN?=
 =?us-ascii?Q?A6RJhjTexgxXR6xLODI4/xgPCWJU7T4fQvfJiNYZqttDt4JDhSLleHIyGrIe?=
 =?us-ascii?Q?c6v/6LzYHiCZiWP6Mpy/6EcgeudV+l7djn9S+bYNBVatbbivh4vf/sHXXutK?=
 =?us-ascii?Q?Ks+ne7lyB5V6apUPWDqmdUmJBVE2E4BNGah5iZHFxYUxIc+R94Je25n2G5lt?=
 =?us-ascii?Q?cX9rZkr3+aM4uzsiU2lIpCdKMnagoO2+vOmS0M+2Fk+D1jQPbq7/tcXmejMC?=
 =?us-ascii?Q?lLf1NZchO9cz3ElfmTVsTSSOaOEof4HyM0MhpkNQ3AHwJnGILBo1KbGSHWmb?=
 =?us-ascii?Q?zsJV+i3uWYA+WVnGLcxGB/Gj2lLrToodFfiKGXl4tZEmheefftKyGqbws+Po?=
 =?us-ascii?Q?jCFsvF2qtFoVTyiXqi41sHtR95vMmhvaMSda4qK7KLzYTyOInwWQ1pwSN1cI?=
 =?us-ascii?Q?ZtCqvhEvRBxWok7sPUsI0jJuC5rJ5rf5m3wL6oD+uyaU2F6a4WHo6qne4Mlj?=
 =?us-ascii?Q?hL8ghqRRZXGpZ2kBWW+83TNFGZOlJCVEzy6ZxSJNoG6ra6kdSuRjzBc1U8JU?=
 =?us-ascii?Q?ApbUBEShrECKoin7xBABJeTU+HUrkRO3Fz3MStFPGjlNWbmzeJ3snthcLlEz?=
 =?us-ascii?Q?kOu9Qr6QYJ7XAbh/7cFme+C2kli01cO25UPiuls6IJKX9GW1OkL52pGzBEFK?=
 =?us-ascii?Q?Z4ZBzfCkvWVsmx3NJQpd27UsBSs1Ys7pn6ARgU5yHp8fBaSiwZLl9EapRvyF?=
 =?us-ascii?Q?01t6akX0YUA/j9TtI1fArMjc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfQuwXtUSmBbv5CJTKJnYG4e7HiIN/fSQzPZL92HLGU81ITEb+KYfAyeffDZ?=
 =?us-ascii?Q?lYUJDvYzXAgh66+0D0tM4MEBhkzFctiTKERbVWqcz7nvEbww9cZFJjbecSNV?=
 =?us-ascii?Q?aIrckiEXV6nOXst0NjWrmTf/sH/wajVg6h2k6W43I9FQrkg08wjuidsGNvJI?=
 =?us-ascii?Q?1MrPDvXwShGHT3OCaB6NPXYK+i/IDjdJQD8Jqn4FhGlb6FS3qUFXldiKBZHg?=
 =?us-ascii?Q?ywa+KQr4Kwwg/E3Xd9AJe6xC32b5vgWM3522XldyxwK7L2TrrjJ1/lTlz09N?=
 =?us-ascii?Q?kmN1XcUNAjHwvfkcNaN06lq4FKpRU7L3CWuiHY9gn1ypHNoCn83AkeIBKcYN?=
 =?us-ascii?Q?qtEEoUNqQ83t7zzydsXBGqUkn2IWkXTa6YeJivTvUDdC4+eA2TsidTczj5po?=
 =?us-ascii?Q?BfgWt5NchQfoO4ofB40fzRtSQakbJ/nDeXCTY/yiL6WZiCyRicDZqOc9RS01?=
 =?us-ascii?Q?MvBfb5aQipBL7wJVJqn8uBRUwGNVNEr/p6bROJpmnkMzX2mXZZX0fw1b3WZI?=
 =?us-ascii?Q?LEy3YHIIyT8oP+Z2oTVJKChUFeyTIQhhvFE8stx98llXfI7rNvvKm2JnaE0M?=
 =?us-ascii?Q?7ZS+nztMdGAj56E3FEMFWAA78KP+U5xG42WDVPgirfSSyfeaBwuXhS1GaM3c?=
 =?us-ascii?Q?2ySJJv6gGxxfWqiiCedBHTynR7c5kX8mS+uHy3mjXrzcNQqzFXHL4sMjzR7H?=
 =?us-ascii?Q?gATqDX6bm+JDo64sav1G63CrQ1044RPURQwhmccutN+IsUh8mbMlE2iY6QHa?=
 =?us-ascii?Q?1p2ZyIg/GDrgImQiVmIApWevxJtUmoxJgpLhUPceCWvPcv3Ltc1JroegSpAd?=
 =?us-ascii?Q?kj2uS8v8p30ewFwCXbLeim/qG0yodguMstI2G+Jmh7u/rCwNFzuEP5lZxLHc?=
 =?us-ascii?Q?Zwqj28MDO+5NtP8Qv4AoV15u1TzK+dKXXp9nnJsP60C92BtecjYB450DcADK?=
 =?us-ascii?Q?zwK9m6ROZSZdxbltuxMswu3aBNy7RlueO25qexvumHx8zjsYa3+zI8jMmBOo?=
 =?us-ascii?Q?wiFRViubvpoF2hHb80q6rrz0IA5VpXOG1C+e8I5bqSJa5oH0cf2dUYrVk+Es?=
 =?us-ascii?Q?xLq4nDU5cJBTdqDDC0kJVPWwu4sZpC7Jxjxa42GScIMAno0PcltXwbvnfnFF?=
 =?us-ascii?Q?3OSYJ2Ca/pZXc5eKKI2TkHaufqNoSUbwuT4vTODoVEwpPnHpkxMS4Ii2jsPb?=
 =?us-ascii?Q?dFBdUK7zTykJDRXtVioESpOMertou3EsA98ruWpEsZThfP/pgw8RhekFVL6B?=
 =?us-ascii?Q?opMsjuAMuPIWEiuou81Q3Xxryo4fzQmDteAVcMF2/KMmwFOawo/KkDWwXY3j?=
 =?us-ascii?Q?ovCufFsiEfZILF/BLlvcIcdx8FerofErVfdy1JGWhAsIb+MgvZ+pgFPb9JvF?=
 =?us-ascii?Q?TkxpZPTNcSEF+gwD6idHxdL9aaghZPZV6gt4NVypk5d8PDdkLNyDMwaEJ7m6?=
 =?us-ascii?Q?1w5qkL1ccc8d6x3o7CLaZO92MepEPzC97xXBN8Sxl8yTdlPVdSnWG5Ed4YX/?=
 =?us-ascii?Q?ztYRZftgBYDetWgeZei8lVSHJyOz/ofFWdIBqO1XV4v8vf8Foh52Vej/7Y4c?=
 =?us-ascii?Q?Sb/thZTTNnAd8p8li6g7Z6gaPHx9GgOXYlysDZVk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff240891-ee22-4ce0-6ad7-08dc632af1c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 00:18:47.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWckTwIs86dtruzzLMHOiG0ytkwl/H02OxJCn5iFUmwOaNmhxijnt2c+/aYuTpfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

On Thu, Apr 11, 2024 at 01:46:13PM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (6):
>   x86: Stop using weak symbols for __iowrite32_copy()
>   s390: Implement __iowrite32_copy()
>   s390: Stop using weak symbols for __iowrite64_copy()
>   arm64/io: Provide a WC friendly __iowriteXX_copy()
>   net: hns3: Remove io_stop_wc() calls after __iowrite64_copy()
>   IB/mlx5: Use __iowrite64_copy() for write combining stores

Applied to rdma's for-next thanks all

Jason

