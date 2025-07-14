Return-Path: <linux-arch+bounces-12754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33BB049C5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 23:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8326917CB1E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1DA26A08D;
	Mon, 14 Jul 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Twx2WOUC"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7725DAFF;
	Mon, 14 Jul 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530110; cv=fail; b=M4KnGRoEV/N9FhORTtwpK5pd1vEuzCLCRD0sBlO8pqFwy3EqNCgPcVEhYCMwEGjJOHSvfmqMzc9Af3qWCIalW3ow/aiIty7a8lZqWrYSnZ6cUXPDiMGKBl7v9Hx0YFgb0BCRc/tWfWKlhg0u+1Ti3T8mTDSYNizpDZCupUiEHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530110; c=relaxed/simple;
	bh=DyKgyqwlnuYNpOIRbp4MdZJk/JmhDsVz+QMdb6MAmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xt6yM4kFGcUMPiz/FLowG1YxLIdnGV+tImLir3/sjk5e1Epwqjws26JnVLPysncgCJXLhv7Q7gdeeanK2pOaGWPxkuF7SMdokvmPyQo2zz8bOuBNheAHfmxhWwR9fuzrKQgX7m4f6J0onF1Cr2gIny4iBgKZBHxRWCEYIdXOBfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Twx2WOUC; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPxWe2QuIhqrZ9uYnBmDoa6hfwK4o/Y5YMoPUzYRBlc+9OTNDgt8K3uOpmLyzMNNg4Z6/bbjxYdMQ/vBD+3OnbIxBwhb/715KfV7ezTlDFMbV2vfkxdF3vLRAZ0IbmKQzSJqManwD9Y5OjWuIUFEjGCAGH5rWwk7osS05RrnGt3EmtuCNDtjpmNEf/KISHSUfcSgFqJh0a1bceGIA3XUqWFytenjlLAW6K1tOi3ktodE1ziuqK+X9gAfISubw/ZpgtWARZtglBgdUOy8aa8DhGtgpi7y4wB1UUf9OAdvnkSSv7PysuNHT0hLvgNY5zbCeZIwG4OOyW1Qq/FkV8NBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHmXGO4AkzZpC9hJ9+n0pSuChs/w2fSqZxudNrG26pA=;
 b=h3cQhKTsvETzN2gQcOqL8kdQfryeHDTMsFDnV1N95Sxdb/zEp53s8fZdWta28KiRB6TNuc/EGlKvXIm62LINz6R+v7X9GjyQC9wnlEMKbKvzVKW4Vud8hQj2E+BX63RbEdA1EiQ0tzx+kiLuU3XsC0DDlUMVyQi5iYgoyp6WT5blTZv/G8ICWTR5zsEbZ6UplJtnCGK5BptUCV784jxMSfMlnAIOwyRKr8GCKkbiwkNW6XGZLNOyUfMfyg7El7iMoMJ9EC/APpEJwk2jAbxyOGYPGOyTcPBbd0ALq95BRMbBCRz8/0kpZEbmAFYefbSInl8ns6Wve3dAKPJyuX2gHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHmXGO4AkzZpC9hJ9+n0pSuChs/w2fSqZxudNrG26pA=;
 b=Twx2WOUCdSmu+seubQSv50Z/qLepAHrY1xnkhs9tcLbhyTsrAeFjY9L6ddIrV+NpYwGR62HcE6ME9fQkusCcxiNdPbBFXQUOGKn0ddWF50UUFCgkQtQwM9FXC8XLfFl+E1GNoEmkEfqVqZ6bTh/tSpIQLpGsDn7u+UnrqDQXw5pUq0P81Zbw79ZiNHgaIgOfdMZPRM2yDGQyvczoCNiLrJgBNinN9559h1msWeg4bqpEy3RYIOibkyHcw0gDmgCyEmqN+TTOF45fF/c3bEQdJBVN8A4PIRC9a0aL1TIHSRzk0bWPCbpek/TH8bFbXerSfhkaQQsi9yOQTAGMCLxOvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 14 Jul
 2025 21:55:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 21:55:05 +0000
Date: Mon, 14 Jul 2025 18:55:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
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
Cc: Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@mellanox.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <20250714215504.GA2083014@nvidia.com>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:208:15e::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c33d465-7a45-47bb-6e8d-08ddc32117bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7LsO+zD5MNy6KwoqCBEpMZ1rptmlISB3Tj5R4L4TaYs5W6tal9nCzLYo7LR1?=
 =?us-ascii?Q?uadIBS6yz0/UDv3DLoV//JURe8uzYq1qPqycfjNaO4eJOJ+W0JL/lo9s3NMl?=
 =?us-ascii?Q?awkrIbUPpumcjKrrN4Dwr1xYWIJEpWzwM/mK6KyxJwWivZg78xIWS9k2LTjw?=
 =?us-ascii?Q?Vq1IpKIr4H4iQxonz+R8tXu2wRL1BBtEo8fx3paUAr1X8G2JDJlX/d98EFo7?=
 =?us-ascii?Q?W1mbCxbplZOV+FXpp3oid9qotDhGPFuaEPqP9yLQ8un4nWNEMrJVIikHdNOL?=
 =?us-ascii?Q?6z2A2mz7mBydDIKmslKwdnoKxWQAG/LW3eX0oOlLaPJreZNCREvUXtmWRxgv?=
 =?us-ascii?Q?5QyD8TYsDhuzcT7jPcSml5Oxs9b3HQhI/sDcdo7jAU4BxAJo/hyMdzGcOnqG?=
 =?us-ascii?Q?4LEMsvxppmSqo3zNXolXD9nP1PS9lOKiw3m9xlFKjnXHakEoKiOrMOIw0t+t?=
 =?us-ascii?Q?UW/B2Mct6VJYv5nBmTf0I9rqgW2Fe5ucK2hQJYCCvYVUWxgcmKLYdD7Ld4H0?=
 =?us-ascii?Q?m0V9cf4Kd3M6oIP2ap9NKB8JUAhlWqenOB83lF9kX5Ux+Fxg3K0N5RQGGEZa?=
 =?us-ascii?Q?DcM52gd2nm7h+TVivAevOAZou11NKDqSf9vJIvmTmsmft83DWNnJytd/NaD3?=
 =?us-ascii?Q?fHxLN8mCDnKojUCPB5oXaC/nqDconyBQFpF8T+NmIT6eeFM7f4Vm7kM7IEUa?=
 =?us-ascii?Q?PzKZagN2m1N1tm/8xNnux++loonNUod84EtRdeYhfiihRetV5FPX7pQhdOAi?=
 =?us-ascii?Q?LgbPmAoYM6MoKbhyX1VOWSPs7L3ELKgR+pco13bCrN0jUFcwOtcyAE33M1Cw?=
 =?us-ascii?Q?0of2MkqCScqzoKDatEByxXZZY7yZCY8b1WxOnInLJqjnYJy3PQXY3crJ0FJb?=
 =?us-ascii?Q?z6AH8d27duwa93u3r2AcmEOy0RV0OJhr4luZ3f418Q3njVxlWP1SbVUS2XBJ?=
 =?us-ascii?Q?p75D9tRaEgPpw7es2OiKR4TxDci191rzj13VLsEXopwjqUc7fwvZNkYA377D?=
 =?us-ascii?Q?IkyRxJr2aocmEQ6ltU7W8gCWHztjDZED21xTsF+AfXGanVnKEqtGdBZTWs19?=
 =?us-ascii?Q?LAl176K8w4aOCpKkE7puzdjA3ALs/nNgIyXpc+Whi24T1VVvK19xymKSjqXI?=
 =?us-ascii?Q?X1byE2w35an1rFAPEdWNAxYuPiFY3RV6X/owuyEhgi/eWmUjHO1EdGX/qMpS?=
 =?us-ascii?Q?MK7NDPnGLdHw6acIcB6JQXc7NnRw99a8tPYJuQd25ZuTedvVRNjGvVSJVEU/?=
 =?us-ascii?Q?0uSTNY+Cw36+K6QV2oFmMnLtmbaFGVxde+6N9Czju1A7CYjsd57M2ayKXjWS?=
 =?us-ascii?Q?IljgepHVOCElf0K2AaK8QyRXNEKN9Pu0vb2nUDAvW77hYaDPFVsHEt7Zl0Gd?=
 =?us-ascii?Q?dqqFS7KJPBEa0qYRrpqtMcRWnH/cHqQx1igYQduMr68kGrSUWhQg5Y/i0BFc?=
 =?us-ascii?Q?ijkOivx7Q/8E7GCSpLzfvS9jZ1ujX7ORVxA2fRJ2m6unEz83l6BmfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XQYzwcpioWKwStu8AD6pl58tXEvLICCPzFqVfv2D4H8V3R80aiEbLuv2e6m?=
 =?us-ascii?Q?IJpc8yfmM/Bhi9oXC6/BDnSLIAhCYiM/WDqlAIouCtBLhwteUQKh5dcyznhK?=
 =?us-ascii?Q?JGDI2T17vTCByMDcdSWACHaIgidv31Y7vtfjKUFyy5vqGvFRW56aeqZigzNP?=
 =?us-ascii?Q?4noOvDMVlz2tX3uypHsjIub++hDQxtvtf5TGd9qtaGH75ZAIctR4oF33bxPq?=
 =?us-ascii?Q?tWfVy7o3k//MZ7NLqFVoMCb1RIwVdR352QdenMJ0rQZ52JDINJOKF2meiufB?=
 =?us-ascii?Q?a/kPQvGmQa/wQob+jUbey0JbfgvUSZDpioGDi5BB+8sx7jSrueOs4xaiTsZ3?=
 =?us-ascii?Q?9yDZGPx25Oriwm/yp+y1M6jUmYjaqpqUtg6vqs24QuVz8GdueBokvYlCto6a?=
 =?us-ascii?Q?66DYua4vDew8z4pzsH9LbxEuoud1H/AjiNwl645KPaVS/GZaoaZbamYl1GXW?=
 =?us-ascii?Q?t67VqZugz2cAZ/eX+PPXTsUW+FKDQpZhtVV2D5ivFoNks6ivfDQQh0qJKzuG?=
 =?us-ascii?Q?qfutnkI2RsrkBMWTPBUrVR/2Sdq1RWjjFyfy6RTd8rCmTZwDxmVqGnKakH1y?=
 =?us-ascii?Q?697Zu9oRRK1blZKgJSax2K00C2v3Mp+KWdMI0S5PS1O6FxUKSyIzwjtJpFuf?=
 =?us-ascii?Q?zVa7FecWHVApqY8g4aY63RZOsr2klzPqw3wg9gOkdAyWyhHzXoSH6gnxdhGw?=
 =?us-ascii?Q?ejk3CroiTVmIl+/1N++1QsDT6j84sXQ09e0PYeNf40R1WYym1K7dqZ+Vepdb?=
 =?us-ascii?Q?FQ48dYnQxJ2sEA53ADXNBwJoI0zjWYi64v54P8ttf2W/rTCKrPEj8s2B1AFq?=
 =?us-ascii?Q?XfKuLGmxQ3SVRLjqj328yAE62P3UTRSSZXGHtCF7n561e9UL3FMWwejKXPVh?=
 =?us-ascii?Q?PdAmu8DzXHTTfp+9DjBGyJiMCrRW7VWXfHUAj9a7M4ZQWqg5oL3oDx3aa4G8?=
 =?us-ascii?Q?66Ap8Pbi8nGhkghjL6CuwF8aAmHzMXThsqPXpe5HtInM58WwJWog4Vkxgbli?=
 =?us-ascii?Q?wpVrZNzRekwzPvxYc5bU5GSsvKwd/PuJZEJ6CBlzHePVY4d5izs3XHpqVCgS?=
 =?us-ascii?Q?HvqXUrGnn0UQxkWTSZcTTzHJxc5BHI2wRVkYJs4TbtwgqUUK3Bk3h6+m+4Lt?=
 =?us-ascii?Q?nSatZPuXL6sOv1LMHeIX5x7qTPYhlrxLVDmHxnbXgFgQTdyYKKyrHKPPx//p?=
 =?us-ascii?Q?DCoto6NDklUQiwe1nGN8BJbuFZBWeVgvYu9EsMdvVbXFJ+bKgx2svCoyI1Wy?=
 =?us-ascii?Q?7NobSI7fjbWoQDDeDiaNWoSD+sGS4hqFeadyqIcagdT6QLG1/NKx+ok0Ki6v?=
 =?us-ascii?Q?DDKIQgpvCbIhr1bIOBo5Y+mVCOJ7qcmNUvKeJrb/CwRY2mZq9iLB2mFCKz+f?=
 =?us-ascii?Q?uIkXye29UYOq2CKqXoUK2x62bqNLVgKOenUKTZqZdRQFyAQeP104GZxBm4YW?=
 =?us-ascii?Q?Ib4H975Fb0CzjN2BJ2RxceEOPANg66y+aFq/4telu4R4ERFt/6XUQNyIvLIi?=
 =?us-ascii?Q?uB8Bpn9/fTaXQILwaN3MRZJP+h95+H45ZUI4cB2/ob5JjYSxVkOaDd3j+JND?=
 =?us-ascii?Q?K2qEE9aCo3TLBxVNK9x56HOlLsjmckn7yDD7KNlZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33d465-7a45-47bb-6e8d-08ddc32117bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 21:55:05.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7ZFZEtFzogdBiyDJEajePGcPt6csMMJadpbiMuvzZF0o4tetIkvr1xBR1kUmof9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

On Thu, Apr 11, 2024 at 01:46:19PM -0300, Jason Gunthorpe wrote:
> mlx5 has a built in self-test at driver startup to evaluate if the
> platform supports write combining to generate a 64 byte PCIe TLP or
> not. This has proven necessary because a lot of common scenarios end up
> with broken write combining (especially inside virtual machines) and there
> is other way to learn this information.
> 
> This self test has been consistently failing on new ARM64 CPU
> designs (specifically with NVIDIA Grace's implementation of Neoverse
> V2). The C loop around writeq() generates some pretty terrible ARM64
> assembly, but historically this has worked on a lot of existing ARM64 CPUs
> till now.
> 
> We see it succeed about 1 time in 10,000 on the worst effected
> systems. The CPU architects speculate that the load instructions
> interspersed with the stores makes the WC buffers statistically flush too
> often and thus the generation of large TLPs becomes infrequent. This makes
> the boot up test unreliable in that it indicates no write-combining,
> however userspace would be fine since it uses a ST4 instruction.

Hi Catalin,

After a year of testing this in real systems it turns out that still
some systems are not good enough with the unrolled 8 byte store loop.
In my view the CPUs are quite bad here and this WC performance
optimization is not working very well.

There are only two more options to work around this issue, use the
unrolled 16 byte STP or the single Neon instruction 64 byte store.

Since STP was rejected alread we've only tested the Neon version. It
does make a huge improvement, but it still somehow fails to combine
rarely sometimes. The CPU is really bad at this :(

So we want to make mlx5 use the single 64 byte neon store instruction
like userspace has been using for a long time for this testing
algorithm.

It is simple enough, but the question has come up where to put the
code.  Do you want to somehow see the neon option to be in the
arch/arm64 code or should we stick it in the driver under a #ifdef?

The entry/exit from neon is slow enough I don't think any driver doing
performance work would want to use neon instead of __iowrite64_copy(),
so I do not think it should be hidden inside __iowrite64_copy(). Nor
have I thought of a name for an arch generic function..

Thanks,
Jason

