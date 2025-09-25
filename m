Return-Path: <linux-arch+bounces-13768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25715B9F071
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D527B56FB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAF2FFDEE;
	Thu, 25 Sep 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4AQXLXt"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8F2FC86F;
	Thu, 25 Sep 2025 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801279; cv=fail; b=ZJjwYe82enTPJr/Phoz7eRHBtizOfz/Ns2eWrcMfmfgPwMt8HxatH1q1idnepeevncZ+GrErczhjEaPUgua7V6wDwjc6exTRNp2sUAnqTrTNLPN7XXOLwd831wCaAXDAZu2T4tP+zsod2/fPeaVpNT22LYa3aES/RMyN4lXx/Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801279; c=relaxed/simple;
	bh=dlph6o31dFLDvPXyrvgxT+7rjsfgEUpM1z+QbnEqxDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=npMpMha8wTom3jDu/1rrxmfqOvh8LlyLZnE4ms6myhpFLqsvGjZg1kiRsEejhV83LW9b6ShRXeJMdV7tJXolgLPs2taJGTJueJwsFS/XxTAfGJNxTDYFzIuMVO4tr1AGz8p0wSe4ihyJ9LqlqYrDDmvp+yHJoxmf7/J+OJaOdQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4AQXLXt; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbs0hnzel0q9YXikV1/28HxI9z4iakLwUfQRh41ERGi3PeKriFObcUKnYANk6FzD1WZIgupVS64O8zWfs9mLic6K5lIBmj8tfGUQiInWsF4Aojp5f0p9SQXSKyI7m9J/+axsv0gaR8HkAMeJfmnhodgwUrPffjEga6mh87l2fwuSuNRMvhU96w4j4kjfaT0laM/LBUdyuQ2qgr+hUpWr4ab59FLCl6mUB3+KwoJYbFBiEBa8sw/oR4625us6humRK2pVKFwavZlsnJgy6xnmZ1cJ6Ga10IwyYevx4mu2SUvNLcHoJlGvpmFtLg6r6bEW1+8rkvx2X2BHvzJiy7fa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CKBTlbBHaVU7zmfD+ehydjL7VNeIZ+gKA7/F9VJBEI=;
 b=LRKfkkhdVDK/BGQLEPrQd1L4/y/V/zAGGL1T9C0wXwRTtC/uFfCG+GRZmwfgMDeAUI17WRdANXEyuq5mlT0vNpq6+Q/SSSLvVwjHRWtDTL47dXWRa8WoFkG+e19xFp/jamiW+jItLT9E3FLT3lRuH9Xw9zr52f+AX3p8iTjpKKC2w2Uso1hA1RW8cwSWtfJBlCcUqq+j7dsf25RDRaebTspSvv0SNDDL/xuxwDMYv9qSW/zOw0SRTZ+0p4vQwGd9by+yYNdiSuMJ1S5rinSEX6VwnUYlicste5pDlWuthskoW/hSq0xx4C5iZimCouIj+7Tdqtj9b67c4MOd5zAx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CKBTlbBHaVU7zmfD+ehydjL7VNeIZ+gKA7/F9VJBEI=;
 b=t4AQXLXtFIOp/AZUi5+0KmrCpWm5Sohb2ewRRdEwgJ+B5miNCw26sSgw44BSrKsiOXXrFxiZWSBK5iWVabasj8mRccWToGDzERAl2E8wMDLql+X7uHF6jnBbugPjMjtoToQVyUZTFqu0cqL+Nt/imxlfTYYK4Fq8R6Z34g0BeQ8icTMVRecIVNKZHGL1VOvQMxwTkQA/1iG5jtwHzDN0UtgKXDNNyUSq8MUj5KdN4iml+m3QtAUqBfc5HYnobRLK6HmoCB2jeNoRORvMNXaH7GGv8nhQFiKrqGCV8AYYo3ZcHSPDqAfluPWZkTZjlrPtunuC9zDMAyCKjG0akfYGqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:54:34 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 11:54:34 +0000
Date: Thu, 25 Sep 2025 08:54:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V5] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250925115433.GU2617119@nvidia.com>
References: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:806:22::15) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d40625-a664-4f6e-e9a9-08ddfc2a4bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9i0Jm/v9KFVLaQiIk5TjFX8KzrZSY2wGxb1b+SdZ53SPbQDI3Iu7/WnsyxO?=
 =?us-ascii?Q?ZpYHr/fOWWgQsYKnEakEhpRCpI/BMTY1MFGdzn+/YqE7DdBoapuw+zUIfH9y?=
 =?us-ascii?Q?eKGN/7sGH91ATHGIb7eckQWnVg9vBnh47Xf4I2loHIe2UKmeWUXXAxDbZf+o?=
 =?us-ascii?Q?ww/Z1yfSJDvKfTW3ATIlasXel7Z6417OMEpnwlXv76FI+sUN84fVoHgJyDgy?=
 =?us-ascii?Q?95u4pGM4oJ+qw4EbZyCjmJHMo9Akvj9ReMOpKlqkS8pbiaKBNraw+7PAv4Xa?=
 =?us-ascii?Q?3LRtnR+S2Yzwih4eQGhzrE4cBj9t7mEUvb9IAtPI4FUj8RI3NlTwVtLOTKrI?=
 =?us-ascii?Q?j5RnYIf8HK16UYPBpUfLCq7R5ZR75t0wfxB6Kn008MFXCyPLmO7udLy09hto?=
 =?us-ascii?Q?Uyexj+GjPUok69nIzuOxyaKY0upfDud+aI0pCjoyhDes5Nwos/675aM0I0BP?=
 =?us-ascii?Q?Fh8uzX1ck1W5wGMXNV7FEEWUnhrfdCJLZW/WcOJOUsV+7TFZqQDxmPgo1eSL?=
 =?us-ascii?Q?84qZtHMFxLwfkh4HX6OI69IpIJQJNAZ/bja4FfaU0ZBo3vS177fPq2yzJhxb?=
 =?us-ascii?Q?jpq4gUMidFOb/ltdDb0kQH4o4v3Xun/amFNPMD7oHCGXIk8ZAfEO6N2KeiG/?=
 =?us-ascii?Q?1qlkiZ+3foUwF3VZTlO3sgCsLaVFoOcro7XUIWIZbMUnmMnHm+ypUmD3n6GW?=
 =?us-ascii?Q?1LXx98KVmNMQdXC+3ixnLsuFUASFh8S9yIEi90BBp0ZmoAT6AHUpdYJrMVdl?=
 =?us-ascii?Q?x2cnLX1gkOUmuw4HkVmTh4CbP2PR+km6lHCrdoOCM3HPduDpwyN1eOgAzpVn?=
 =?us-ascii?Q?QuY2oPQ4jzUThguoZXYxDlQHyKAy3fv4UvGA1+fx9Z2ylFniinrbgsvUvfgg?=
 =?us-ascii?Q?a4/Z3TnwRRwoPHBNVxN53NU9uXuCiAIHJylKN1r2MkVT6VR/HGedKX6BQ1/1?=
 =?us-ascii?Q?3np2HEJuT0OEGwY+YAA3VIT+KDnEikrihfcwWGfejmd/PS4JPUQKSS+zPOom?=
 =?us-ascii?Q?LwnV+goqZoRSRqynDCtEpqr2HIy6S7RUrtRQc27P77GwBYVtINtmrEQOB1uk?=
 =?us-ascii?Q?mNZX8ArBz8NAhGxIXSmm7kdyI6ybHNARi4YRtcK4bDXUQBo+YnI6HVfgdeN6?=
 =?us-ascii?Q?eK2WzeE9l/4Sbkih4z0fUL+G1W/Xcq7mAubsDmFWNITnDjPexpnXVnn9wrGp?=
 =?us-ascii?Q?QvDW3aALDoJdo99DbSGI/IDyfvjYTzm7TqA9kOjuApycGwtASq36/pyWAlxO?=
 =?us-ascii?Q?rh+XTcrQuPxQBzncAKpvQNUk8QHpJM9ngJAZM3IO6vYURojWzwLuHVQbeqfv?=
 =?us-ascii?Q?gWIGxoELrnVGrqSxVgacIc+r3ko2xYhXhjKkqRw64eci1lu00WvGIUC0r6Ak?=
 =?us-ascii?Q?sx3uYjh0F6FJ7ecmJKx3+0KQ1QSIfwNvHjgvCspi4OdK4bvNM4mniewgGJPY?=
 =?us-ascii?Q?aRyXoqzjVvc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Impwt5fsRUe+CVxBsLK8CRs9eV/OhlXT4vkmUjB7xGgiijJUHsjnrDb8KhUQ?=
 =?us-ascii?Q?Yh6H5Y1nkf1FcXwKDQL3U+qUYt+hbzF6ZUgpqZhS/vEmANSC0bNfE0xfXcN+?=
 =?us-ascii?Q?Wt4BzSs4RqKCBOo7sa8p8/c6hOLsqV8wbnWLY5KDLOf20n+CrBkqGjsB5ASB?=
 =?us-ascii?Q?l6ty57rzptRFfSBQBdBu+WWAHlf/c3LqPunIJx0pCvlFjrpO3vhj3Ea/2082?=
 =?us-ascii?Q?UjF6yEgandiP9bAR2HPN+kGPkFbgYLW9Q0bRnW3pyoaXjAwg6eJAI7UC9dVm?=
 =?us-ascii?Q?P6p6oJ/dtdb5E+RF7Y+o1jetuaGZ+X4Q30rAOfCxcp6pZ2i//40z/AVlZc/o?=
 =?us-ascii?Q?8+vAbtnjzS6EYyo/n/qWGxm7qGZxnDCv350S8H9VhSxKgLsRVFDC4PopiotV?=
 =?us-ascii?Q?tw7riVCz7QeZjEpzk1tgAGvzyMTZuTNbL9KNEVL+Mp61BJS53uqa+cXxPK5v?=
 =?us-ascii?Q?iUwTPzmt8G72OqP6rGBkbfZyzUbWDbXv+S8EnTtOHUorAzIFPX5rNbwIUNLF?=
 =?us-ascii?Q?zqWzoceEG2cWK8LwqZU1CXuqZpfOVpfggnyj44KGPUunFk6qgf/qyMHyXhVH?=
 =?us-ascii?Q?sOAvlyucu57jtef8Eoiu2woDGqK2dA/OvVH2wDUCME5LlYl2qXbYrhRFBQ0G?=
 =?us-ascii?Q?vH5yo3FM6QBK6Fvf0QjZ2J0Oqr6NAWPAAJ6pcchGiDXZEeg6w+qLtKybezTe?=
 =?us-ascii?Q?6EGGp8JHhrv9S97aRnlSzgas+v4bvHBkcI8Fek7ie+sA5MXc1jtmeAj094aB?=
 =?us-ascii?Q?fSXqgrc/W3VR8ab0WYf/WbcHXguCLCCmKdiKR08FYEjAFlQbNKVK5j0ylNZe?=
 =?us-ascii?Q?ldO01GqHKr9wGASe/7hyY4FlvjQzs5zBEHaHjExRroaCDB1KAXMsnFosvTxq?=
 =?us-ascii?Q?1+NKaDH1tPTi//fp+HUFhhYZU10VuzxUBXRETdgVCrhwmcQqUr35p6EBr3UO?=
 =?us-ascii?Q?ffSnHNGYHZulNWFdMfcuD2r+jwX41Dm5oh3zb8du7O1ChLq0kYbnSdHCIsNC?=
 =?us-ascii?Q?PhoQ6qATeCZa1dwECoHnmpvdAQatPtspjnKjU+hXpuFV7USvaq7378Nkdpsq?=
 =?us-ascii?Q?WvPewX8XXrrPFepT7m5SgG0yXo2YBE+oD+bXXNwOh94HgvEvKagrB5pXEBM8?=
 =?us-ascii?Q?Z6QxgQoy9/v1RuXY+eVUTToDAVuLr7vW4orLCqlJAx/r+XDtsYu6CkZ+M127?=
 =?us-ascii?Q?398Hm1Nr0NBu/1na/dEUfF8uiYUVdT1mBYNKS3ZiiIai3BohiR7FuNlcXEA7?=
 =?us-ascii?Q?fwtxpBc7vZxvNYCmWxSefPvqCJa7nWz7fjVkJUyD0zCNfvRKKTfu3rgdE5pj?=
 =?us-ascii?Q?wOZjUzj6yxh2+u/qKDtvNLCg0Z71qPay9Qo7x4OqnZ7ohwum8//VYEOOoR6C?=
 =?us-ascii?Q?iXfQG+HABAHIk3A/9YNlaK/J1FcTVDkhTQiQuItoELlciZs9jYiSeX9TlsJM?=
 =?us-ascii?Q?EPShi1ByZeZ932G6w/TaFQQij+bZlaIK0wjwz19ZY5GuLRuYobw6g7VzHwI4?=
 =?us-ascii?Q?WbnAj8J4+0q/ckgmJim8wfKFM0yOl7qE59+niajW4GfWQl4Anl/V64RBh3pz?=
 =?us-ascii?Q?/fSDldSfddux1Y3F94cJIB9XFTRJmK1S+uGmiIpT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d40625-a664-4f6e-e9a9-08ddfc2a4bb5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:54:34.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/BJvwey8bcxoxH/SbADoxvQf323yqkSLTJrV7zhr9oSWmj5TC9YQ66vJTxSm/vA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Thu, Sep 25, 2025 at 02:48:33PM +0300, Tariq Toukan wrote:
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)

IS_ENABLED() not defined()

Jason

