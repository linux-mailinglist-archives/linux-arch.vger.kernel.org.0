Return-Path: <linux-arch+bounces-2657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C785ECE3
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3E1C21F64
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 23:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F6128824;
	Wed, 21 Feb 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwODr0cY"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9D8663D;
	Wed, 21 Feb 2024 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558126; cv=fail; b=inr4XwzC4RiDnIH12rBWulmeEEtR6B78Jn8TVyhepfHkwxwAKH+f/+QpCrnLoNSQT2563p9g/tCs5tbEccYElIJXtBGLR76wvCq0fx9TGUXwUFoq+GQgzYUU2Mpvzcow1ZHLJbHkIZkfSgUw8qs8lZZ1EyZXRfrmQLuiJv2IYY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558126; c=relaxed/simple;
	bh=L/41UywScgeVwsZyNgwCmuPR1FSzKOeRcaMJDmEv57k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euRG+0q9z9mxbVOLnsH9RBOlLGzZsR0i5o0YZbdIHBB70v1wfXaIMeelSUun/ZOTD+o+F80XgY/wn6sbLvVd6YkjZyKh70fN9jNAndtSs2bUq0NznsziiwgkaEZbQVIRcjOgmsWzoGXorcCp9TFblcbuB0k+DOr3u0pU5laaWXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwODr0cY; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl2j/ULX1AApdU5xxffV6UVT22T92fuJcgbdsAFx/KkJpO9JarcGBwlDDI40ASVeRYJdZSP43ODnYdF6/wpDbhKgjJ/pfn81tDUXAA2gM+O5LXu8d8lb2lGduTSp5+9XRwmp72TjNFWW4qm4peuC0SplkV/gPEsHo3Loynd1Nd61NDi+xCXP1PD4WUTR9QehPpDyp3dxvyi/EPYNqvARGaFuqTBmbRPDwMnv2AFGgQZ5oNMcldtuRMvLNlSqC8vHMKgAFkJJSXIgO+6uLNKOARxonXMb00e1U2KwYOnV0qF3AS0idmtTPk9lKpyrcTwHrOcKw+hCrjkcq8Oa5HjfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOk/BPIbQExmXo8fdoKhbqz3nGoN72hO2FdzeQd2oow=;
 b=j4PFtHH5Qi79NH0yEWAwuQfyNHritfrd+2YaW8ZPG9D21NKQCFSZiuBVtyXovWt7iXhqmS5TV19CIw+7FbjMzviRe1+Oy5y5SSDgLapqqkCtUnpwjJvUEX8GN+ewZZyICPAIqztTBirxvv8/awAGpQsSz+gXDyN3wy0YjdFE3afxGow/4mF0DWnvpp5GDXLEEKJ8/BMuDzTZtYYMMnWssINHKysL2M4d+3iu16ixRmtnvIgvEvnmCGp2ANWpnNfSy0Ag9sBnH2whSW6TbDfAxHuAtumNbAbrfGs6tQl+QgoJAbQ4ImsQB0bzxlRDjTlTenlAX9m4LhPe51pVYHr7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOk/BPIbQExmXo8fdoKhbqz3nGoN72hO2FdzeQd2oow=;
 b=cwODr0cYLNihUYxD1wwVe51aXni8v7QVNe8Bhdp6OPnvVSDmL9FBsKbWhGmXCc7+SQlgpx0Len5N1GkcJdZDr5QRFBpQZip6+E40RJsgDGqTSVrvR17M74eTyvqE0170hRoePIV4Z3Xq/0LNWeoQp5XMBfsDCsxdVhF8M7RxTdzpAF1wL/vCHUWSTGpKC03/FKZQnWGCku35NN4n1h1COHhwGGxzRr1E54mdQlEkpunn9flwumojkT+tzA5udTmD6BT7HTClX6jE10vtJJ4Q6lL+RIkmuEDZ2Vyf/Zs7DItRir5iZfyR898BkRY7TiUQM5RkZzs3iH2VZGTPFWXfuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 23:28:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Wed, 21 Feb 2024
 23:28:42 +0000
Date: Wed, 21 Feb 2024 19:28:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240221232839.GY13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <20240221192205.GA7619@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221192205.GA7619@willie-the-truck>
X-ClientProxiedBy: MN2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:d4::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f7445e-5496-4b89-3ac6-08dc3334d637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C908/LDoKWSJl6rmPVefXFTBy+l6RyZebt1taQ5Eqaar5wDxgvm1WIJJ5N4IThVulZ3L48xM5dQPT7OZCt6Bko8DN48jDuUnRNV9ngKujv+3P+EgrNLRr+7CQ6aN1RWL7XSW7rBCOI9BrmyjlS9GorLcuS/rGz8qCW2DfhSrf0uCmS2ZnpnIX9RZfLVDnYkMVWMXSTkxng+SRjjJxInE1D/IVQskQVWlvi+6cu5+PT3HKtvz75KDLPoM8N1LvO2egboWjjlbmLq0gsSaqJoB8/v9ctjLSgbvVsJrQZpbzmghctbz+NUY1oTnYyNUfEY0JissQuW4PLWl/TMDZ1K8vgp8oWmlPQ0r1B4c4MdjAtiDQE2rqa0DGDwIyP8vyZeOpMVeLdubkPBFvkhUrrmlMMswlmBaZ8pQs/79/K4I1962g/0zs64dTkoynU91J0zLuZaQ3sM5ugFE6U6qcOv+MPS3iP2hzDGPHtakID/TRhFQHnhSYv7qVe5ZCFa8Ps9YkHQjG7NVMDPe1rcBliRFU41PPGYWnkTEP835EcE9Ak8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKoL8mHbTWIpYLvS1ovwaYafn6E8oemV+/qTCZnnKRT+XgJJpQq1innzzWIS?=
 =?us-ascii?Q?1FJbheyCSoHdUmb0tScEKVdVii4iqHkR/EY94X3CWUOyN9nvuUZsTfoqmx2W?=
 =?us-ascii?Q?6iP6WlosLL+opUnpsdKKIakvKm0y86AImYrXf/m8WygvmxJIFGyEvsgBh8Sm?=
 =?us-ascii?Q?9eg5NYYFSGgulKnCFbfkp+cC/JcsXpqp0hFFd95+5bX9FPrNbKvags/ASs/w?=
 =?us-ascii?Q?Rd9vTMYCK5k4I5gfeNQc4ibliXgoN27JoPtOEjbZHMUAGQT89f4Abo4HA9Lx?=
 =?us-ascii?Q?lGONCazrgDue3z8IQ+GvmevZt1ZjEJ24iltnsNw14T7I0TqlCKxmmwRK93gd?=
 =?us-ascii?Q?mR2d/GFGOOX92P6/rW/s+rBstyguK/5qcfoEN49A5AZAoaXToL+l96NdiEuI?=
 =?us-ascii?Q?2y9wX72/2n3wobgWAZ+Js1JeB39kgYYUhbz2W1jrr+ieHa/gxlU53s6alBGi?=
 =?us-ascii?Q?G+KzAdAz7ONgMkgaCLRDqdgarohbqr0EMWR6babQbjzCCKK3YEC5kgyWRBNM?=
 =?us-ascii?Q?FG9Ge2/Sgo1hV/HRQkK0iYrmurypm01Mw1iz5+kLjd0Crl5EakRj/yzwnzK/?=
 =?us-ascii?Q?BFEsRRcAaJMgk7hk3IYHZKTxcDWHIGdoGvWJ6TpV2cKHBnJo/gWCZn6v3AhS?=
 =?us-ascii?Q?o3/6gFQcApVyLhIyPu0wrK8DKP3B+f6DT3lyVJR4EO1YWTQMhoDbRoBUe7IZ?=
 =?us-ascii?Q?4vMUfJxpWpvOf0c7I8gOxhPkVMkb7dCUvjyjxLyiL7BNEdntvnn0yY9hTUe8?=
 =?us-ascii?Q?Q/lZdj/hsCTMoQDNrrcfEnO+Q1z9aEyS9F2tRm+DuJeUoj8OGXnOe+7ShvfG?=
 =?us-ascii?Q?1nWMuNmTBrb1LFi5FKyr8J4x/Q1Kq1XRVV+c0pJiqcF3Woz82feTcvTVbA05?=
 =?us-ascii?Q?A/giYfhaB7HZnL9aQCn1mU1KGmSDEzWh1KDHJV4sIlNSu1/xWhmWLvED2zzR?=
 =?us-ascii?Q?/wkv4mxn0qLTRVa5ECNXC7e8jT4by3ztdwV/o7JP63uc7p+Ipee1hREzeLhw?=
 =?us-ascii?Q?Ti+VNQvXWhYab5VwPeulT8cNfPI0pm6JMMx6diXtaOx86wUFpwStF61pPf/i?=
 =?us-ascii?Q?wK+rS5fuiGMiUqiBERTKARrJsMfbi6vlHjL9EVo/bkTON2vxACfMVhnzd2FC?=
 =?us-ascii?Q?IXOugN1Yvx/5Hg2rmyQpGeCJis68wY/vcZmIylySTq1N9Aj42w/Uicxx/gzM?=
 =?us-ascii?Q?FjuD0r5i2uBgWlHYeaVRW6zCWjzXOQXOzP5B3Daqe0yTEu6aAQZ4I2P/b/+n?=
 =?us-ascii?Q?t02HcizhrGknNJ9wWJMOe5WGvpjDuwTO4v/OmiSaRZT0/2gdwR3O11CWZXe6?=
 =?us-ascii?Q?WPu5LviUuu0OO2plgoPX4bVKyoHaFKD9pF2wlS2KN5VaR5EgvbWMlb0GyBvZ?=
 =?us-ascii?Q?qetEctJTEpVtn5YVOLYKiEzVAzm1iQvIANcaVPxCzf54AIu+huLqPNXyC8p5?=
 =?us-ascii?Q?77fSZYJr6Au2nqUgnjdwCUM/YDcML7VWXsix9eq7IBAIZNLrHOuaUP05vson?=
 =?us-ascii?Q?Yp6vMjC8X44l25wTEkNsds6fxcyrYo7eWzvXtqc+U/KySMSIWtel8cWEIMpX?=
 =?us-ascii?Q?GKMLZDoMfhhCC8JWjz1ZzlgyRAxK2ND5HjigYCba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f7445e-5496-4b89-3ac6-08dc3334d637
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 23:28:41.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFqMFAOeBX82eKLciPWR3kPlsXS1sbwMBxx8iseV0kUa1YFw6oSzDe35bSTgQJE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

On Wed, Feb 21, 2024 at 07:22:06PM +0000, Will Deacon wrote:
> On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> > +static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
> > +						 const u64 *from, size_t count)
> > +{
> > +	switch (count) {
> > +	case 8:
> > +		asm volatile("str %x0, [%8, #8 * 0]\n"
> > +			     "str %x1, [%8, #8 * 1]\n"
> > +			     "str %x2, [%8, #8 * 2]\n"
> > +			     "str %x3, [%8, #8 * 3]\n"
> > +			     "str %x4, [%8, #8 * 4]\n"
> > +			     "str %x5, [%8, #8 * 5]\n"
> > +			     "str %x6, [%8, #8 * 6]\n"
> > +			     "str %x7, [%8, #8 * 7]\n"
> > +			     :
> > +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> > +			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
> > +			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
> > +		break;
> > +	case 4:
> > +		asm volatile("str %x0, [%4, #8 * 0]\n"
> > +			     "str %x1, [%4, #8 * 1]\n"
> > +			     "str %x2, [%4, #8 * 2]\n"
> > +			     "str %x3, [%4, #8 * 3]\n"
> > +			     :
> > +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> > +			       "rZ"(from[3]), "r"(to));
> > +		break;
> > +	case 2:
> > +		asm volatile("str %x0, [%2, #8 * 0]\n"
> > +			     "str %x1, [%2, #8 * 1]\n"
> > +			     :
> > +			     : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
> > +		break;
> > +	case 1:
> > +		__raw_writel(*from, to);
> 
> Shouldn't this be __raw_writeq?

Yes! Thanks

Jason

