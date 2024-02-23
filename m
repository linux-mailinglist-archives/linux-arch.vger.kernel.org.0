Return-Path: <linux-arch+bounces-2704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9E861465
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CE11F24B34
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403873F38;
	Fri, 23 Feb 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBe0lgRy"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EA7A73A;
	Fri, 23 Feb 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699453; cv=fail; b=i6jwPFm4mWaoSqqCcwXfd6KQqucZGO6L2zB8JkoSf6xs5s2vJ8zdtSIc6nx+WXLuUw8N+oQfdDdS8tNf/I6l0JjQQVRamiHeO9qNBHTGz21QDHcTVioasRcWR1k7YAwDTyK5qH6zI40Cw0c8czCLsQehtuP7vZQ1nHDGVcSX4Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699453; c=relaxed/simple;
	bh=GCX0W3Z93F7aIidfu8gRQHqaGi4LxwuzV6pUbHXrU7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3JOYB3qyFyZER0xSMrjrvzycEl9lmYmdTpMYEWT9VGBYrOQH2CPNwJgv2CF/sA8Lg1vOwsM6QZfB847IY0oUReZtdwp5GfmR4uVQYoPul+48kUo0fWRcyq831WtRAnLBaVjxp0sQEjtzqJ9iInehVsTHhSVh5GFpdK8PGhuYSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBe0lgRy; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTWMYIJT8pbuj6HLVUxmQ/9j4ObPGH2f5mIRQAAxomAxO4/6MXRHWPA5LBhGll8kiM+244Xk1G6854HQge9l1bXB9vfHhX35S9fjJ5jZb4w5Mtmvai4CLn7Yoh8Dz6vROV51v3QH79ukvMaSFt4qBkQRZmdd8NNNyMk3BIzW7q6cNwyH56ePcvi3mWGusj8vLcg/R1kzaw0NvvDO1fOKdlQGXtRWcFgqIze3BqHno9NUA5nzFXUh9+HJ+a+zKyMvSEvPVBrP459vCrL1bHs1RB7wqSmLeAmvUFCbSB65Ar0DlN4LsxaiPFmJzYRGyLeh0kXJZuQCGpmLiutYNbskZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vSLkYdFO0xFhCZVHbdFDHuXJqgYuaXGdfRLzDeZAuw=;
 b=g2oKZUzHeN6xSDx1omwpwXpxbKmuD55I523ouwCkbLeZxSdNvoQISFapLgkuP4Alvec2u2xFbXElwIotCtcbDyBqAm9dVLA4K/wXn7UQ61KaUNkYVKnOnlie4KvBn0cKGD/qP9n68T5m0Ghn81iXZY+yyq5+tkOAqySkmJFl/GQVYijTc6L5h/ttFz/omlCMaMladNp4oLGfvIcRPVDcoYPwORpxbRsCbMvZp8kV9ZlxxbTLgpm+gY2gqdV1mNY5j6LiUd/8HqqgGE1fefpkvoxWxh7vKRMRPuX468Mz4MED4rMJoozfXZQDsfnww95jTDt3aTF4ABNCViYWslIivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vSLkYdFO0xFhCZVHbdFDHuXJqgYuaXGdfRLzDeZAuw=;
 b=nBe0lgRyOoHVIHEPYDlsPNcXT5llr+rpIIBE0qedQwQDX4wQH2YU77yb3/coHNIbLT6kN+NqvaJR60KM+vLjnTMnC8bzfLrGdGrKpqmSygLfA4TC0JfeQzXZQNiFT5mL9dxmrdwCSvQM5AOi6cfSHoErqTVPw/tUu/m+tAvJ5zROGXJeDRYgMMsgVAeaOtNINfQqVcUK3t8A1Pgw//d/ws9my0MMxjqhK1jyYbihKu4weZRj4usLCUkEr2MnY32069qw7N58AuUMPrqf7x+L23IJPMOAryLk050bvZfrZDg7o//nbF2E51td1UbdCZvnNGDgDDAXC82unX1ym2ZQig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 14:44:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 14:44:08 +0000
Date: Fri, 23 Feb 2024 10:44:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Niklas Schnelle' <schnelle@linux.ibm.com>,
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
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240223144402.GG13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
 <d4150af74d7c45b79c770cd1c5d8eed7@AcuMS.aculab.com>
 <20240223130308.GF13330@nvidia.com>
 <18248cc6f411441c8a68a55f68416150@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18248cc6f411441c8a68a55f68416150@AcuMS.aculab.com>
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d1b00e-d054-48df-1fc9-08dc347de403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AyI74aWsDTpKUxr5KBQvYyeGAUSqz/X7EhMsYgX5LKa0YFFE78nyDl/KdSgSR/j/vVGWbAqMpKW2mXfnNBmDo9DrYh4C16JIUN3/nBoeM07KWeLKEt8ZyoC1dPfhbT0l39wafSQSkDo0r6fKhXVfchRg+fHUtzoJoqbgei3EXhGAhCZL6RVOqlVuEG+trFAEoPEnCcFbfUx7nNdyCmwXNddhg536KWAjPZ3qPiXLkfoiewpXz4CfwXW4CvhJZuyZwsoeUhxg9Sd7dI4m/SCwaWA/rRAmpxH112vIVm8UiHJ75yFi9SPR3zpG1RscxssM7FBX8VY5pD0zRprOBdr5jMNYN9kOc8ELqlBKSmmAj8rB1FlGzjJKh1Hx04PwxGukCLqkj9UezdCZUWK2LQdjKnGqzHrSAQuoqxZ7qikMcwhYWiUKXJ0HgsI7WB8SYoETv1IzJEiOBkusxmc67ILAcNtMRIXdNHhCx0td5CyStsXErYvX9x1zMUW8Z6hWmEeykqvWMXKr0bf4csVbzgUyGUl/kOOK1Rt/fj7ItuiZSbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWu4hSRuOxOvXhN4N+RfmjVP/6RlCWZ7TfW0bnDHsdlewMSFnj3KOvE6QsaU?=
 =?us-ascii?Q?a1JvjDnI7mEMs3wnX9XuOeKx97ZUHnXD1I9NzS9THi32quro8mWSZrnsX3Dl?=
 =?us-ascii?Q?nniYcWU2pdhl2q2MP2Q6WPZSo/2RWmr2yJ0BlcjDhrV582cCkPARha7mHc0+?=
 =?us-ascii?Q?ZVL3KUwCGf+4tOY3jITNQS23YaOelVIDswG2EJXXfe2701ORcLYdpJaWt/zh?=
 =?us-ascii?Q?ik/Gs48TFOpAI6TAunI1Lw+Mz5ciAYdbL4bBQrwPuyCEK8WJGJpJlaN5Q1wD?=
 =?us-ascii?Q?pJMhOpEERDEe4Uv5eLKksa8N1iKSwn9UlczqtVH2cAoK7ET2fTbhEznWbR5D?=
 =?us-ascii?Q?JlWSDWtZyPVO2WQD5LanmPuqqwEKj38ZkJpuA7nZqVta96TRe4qGm/IqNlig?=
 =?us-ascii?Q?PpJXdms7SpRgWyuM0Xu+0Lfl2gZBOfxjeAkbOYqbLntaiLUMCJyaV0esJp5X?=
 =?us-ascii?Q?6ge7R9Rm9m3abw6oVdqZvLqN/rHST6YsOwiGXT0vHcwnM+n0avpn5buW8EV6?=
 =?us-ascii?Q?Lfl3t7m0iKv4qLsoIz22Dp45Dso+SaHM4xtPOUSRoeY3PuyXBQsgX94Va9Ye?=
 =?us-ascii?Q?DR7MAVgrppHPWHcEk4LVc10Kcw6z0lAvRFY0HehJgnVuzZmziLH66mx+shWk?=
 =?us-ascii?Q?hFRM0gQQD8q7wt5EPXlsZTSymhji+9ojPuhEfS6M7HueHxkkLbRc9wvXdHoz?=
 =?us-ascii?Q?06qq4qmqtexRjYy7ilBbUCl8kJBMwekMhYmK0FjLgc8UJMEzf8Yv1IGN0UgE?=
 =?us-ascii?Q?xgQt0DSjHE7glS3KbA0bWrjuKsUC8XM8l5TdwX5RfSBXTdYS9G8a5GNkAPjz?=
 =?us-ascii?Q?aAwGHfVSzkG9+5NeoXbR8WyWpfVLWto5G6QJxc+oZ3fiMuS4anSD06blSmAF?=
 =?us-ascii?Q?Zy0EL6P2CJMkXDT/oKcHjra9r3Ff1cxTgsYRp6LRZs6yCa/89oHswezqb3Rz?=
 =?us-ascii?Q?ixmXSfMmE4/xMJ/YHgY/pf5GYvS4clo1DKNbR1SZMeoojPQGJufwNnFkh/Ce?=
 =?us-ascii?Q?9xm0goC/tiqEjoF2w0mkmRaZMvSgWILr9gkh6gbHnN1kZAvv+R3QL+oyLOj+?=
 =?us-ascii?Q?Tz/We2uNXhDx5yYr3YEBbD/d4vcdSkxekQKkH/Mx4X9l8giLZh9ENoy/Vv7/?=
 =?us-ascii?Q?nuIot19EIyY08U1GxaqcwrxQRBsvLHENcVpuZC7oIN/ZzmsjivWCefTuGnKQ?=
 =?us-ascii?Q?N8Rl7cwDGTlT/zdizECLESWeNSqOV/iUgJxLDC+H8I9hv9l9K5qP3GB2TpvJ?=
 =?us-ascii?Q?TPkK7LIWzv564KANXl7fAq51j0WW24BwC5i318GcnZurRR7OD0cmx6ESyLSs?=
 =?us-ascii?Q?XFJGtSAsI3eluT5+E+dXPGbbJAleCCw2EfH9+4fqg6t5fm+fhMjvMqSl8yLa?=
 =?us-ascii?Q?41N573DC6nlGdiRSntfk0pX6FiCqnIobmazhsqODdvQiHZDDAZBii6bFb/4O?=
 =?us-ascii?Q?KDrq7aZ8yTouqbUFPZx06JOnt5rp4wBd7Qsj0pHgEMZbU7VQ9XkaCsCTWyul?=
 =?us-ascii?Q?kFu09pW9W/dCwLWD3W8MzbiOIg1Ik6fcTtakN6O0tto6skueI2Vgf44eUxGT?=
 =?us-ascii?Q?3MnbLaGHTCDU/7s975rnlJwAGzTXz5jhgsN4cNjZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1b00e-d054-48df-1fc9-08dc347de403
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:44:08.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bq59aUj6BBI8kdoL7x7j0M3gkureQuJp8IVfU1v3QkLZ8nr+5Zy7R5R9lmJw14V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

On Fri, Feb 23, 2024 at 01:52:37PM +0000, David Laight wrote:
> > > Since writes get 'posted' all over the place.
> > > How many writes do you need to do before write-combining makes a
> > > difference?
> > 
> > The issue is that the HW can optimize if the entire transaction is
> > presented in one TLP, if it has to reassemble the transaction it takes
> > a big slow path hit.
> 
> Ah, so you aren't optimising to reduce the number of TLP for
> (effectively) a write to a memory buffer, but have a pcie slave
> that really want to see (for example) the writes for a ring buffer
> entry in a single TLP?
> 
> So you really want something that (should) generate a 16 (or 32)
> byte TLP? Rather than abusing the function that is expected to
> generate multiple 8 byte TLP to generate larger TLP.

__iowriteXX_copy() was originally created by Pathscale (an RDMA device
company) to support RDMA drivers doing exactly this workload. It is
not an abuse.

> It is rather a shame that there isn't an efficient way to get
> access to a couple of large SIMD registers.

Yes, userspace uses SIMD to make this work alot better and run faster.

Jason

