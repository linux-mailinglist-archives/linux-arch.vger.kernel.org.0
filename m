Return-Path: <linux-arch+bounces-2700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C2A861216
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712522861F2
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8347CF21;
	Fri, 23 Feb 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PaTBue4K"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D37E795;
	Fri, 23 Feb 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693138; cv=fail; b=XW4FqSaCXWYRCyEctohrJX5oDxgueonxRiXOXa8d5Ll6Y8RQFPayWv8LmrGPUEPTNi3Yyo8kNaDd8Eahn47SyqyUvKipjVF0at/Mq6mA6Se6uW365Q2T6FbVDD0L8Ax0rcg66zA4vrj/XCxKrRcQqBUgru8LIx1U/2/92t0EOTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693138; c=relaxed/simple;
	bh=uF897Xi8OlgJXpClK2wXFCbPoix9oqTiLhu3C6sWNqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqxpBsap1x4WdlUDx8OG6LuL8u0InYx182XSCx1hAIKoY1ZARi9uxiPB/RPtaWYjHFMyXNYjB6EYo0tuaA4gxaRYOun0qnmAYnde0ah/vmWXFjaBREryqSAzQ9aRWs8+wmBqsTdIQMJ/cOupuWtDvrbBnK5zBQBmcBb3PJYbL0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PaTBue4K; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilcMmtM3va8/FbEScre1zWUV6wLAYBod8vGXdObre8Y4fn7asQllKDOnpGzcwu1La1vk61Cs8we5rfC5wZclOw+/4AvXYCOomVQWoTME61C6Q0F419bg0JAh3nyC5kj33KOCUZ8oG25ne6+kFtb8TQx9wcYEG6gtjj5gzkdERbrljdAcR58c4iykj4kFbJ41v6nhbsrJjm7zA4JqE+YaNxFhqdJ/fby1Gc6MBMHUZdjrXT4XsrMpkHOdbf+kVPefvLRM5S4L97Dbk10LwSYIGGDyRF6oGRUjwcHZ7lmsol5OdMwnBXl66I7IJzIELZOI/Lc/6NJZkwdEkoxXzw4/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n8Qj2kTygynxjX4nNLjhi0eBUP9z0rmJcieNSMy+vE=;
 b=D3742MziA9Dj6mpfeddYQAbeGk5BzF8MOJ/HiiPPVuw2bfuwd/iPP8eTc93RZYCCnt07VI4HlRvae3xZqGjMeKlrl619cB+vxIUTmR9Mw2VyQMy9aufKd3YXpXwANi9fJnb7XR2SdZwiow++Wvyld3c4Cgxyjbr9D7un+T14eW3UaMrvJlwYRCaXPTEzXuFTQghqbzUWLz+RfBQwKeqqjIC9dXXKheqGyjG5VyxXe3JXQRSUW0tKjr1QKe25oXL+5Cr3kjhCE+ZVm8ZZ4sAITQxvkobSCpd9KEGIEzkVVXKN3JMYLubYTrVluDwJ9HbcngbCh63YyN/sNcThP0FApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n8Qj2kTygynxjX4nNLjhi0eBUP9z0rmJcieNSMy+vE=;
 b=PaTBue4KOp/p+wz4NFEEKVzkFNtWixTXPGUOp6MTKnEpM6pfA+nipcDyRP6J5bPMS8eDcEcFRhiiXeoMStAXXh+rbEl6aDkyL693Bvv0XfzP0bIddt1PkwL5Z0tcXcaAyEAPCmfU/oEfQQfQuaB/DqaeBEnLCOKhmSWUQSvzctZXLW7vcJ0Ynh8W79hhivTJ/ZTyDZm6X9qP/O25ZC9gU70RmzJbsHcuUH28lrJAS7GSeYMAYw77d8NIT1nEuOvlOryp3xvd0uZyXac+5nVwtqUsjySFGfQpt+H2p4lPZwYZ5wddjQHtLYmqUVswlxuze+XTOBNAsxEdZaFJDqxRvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 12:58:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 12:58:53 +0000
Date: Fri, 23 Feb 2024 08:58:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: David Laight <David.Laight@aculab.com>,
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
Message-ID: <20240223125852.GE13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: c71641b2-3ab9-43cd-8c6d-08dc346f3004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cHX1NtuRH/CuiUxCtvRKxWVoQuYdvsnwrM6UrPZJ7LbZv+1Q8grUR2Vtj1WTrKUtPpRqEkZ5oSLdTWQROr6XewF1oMv/idSvZlK3ONrT+xnQro09DQN4EUQG9inKmRioBaqCr/sWx1Vbg+C4m3+66R4mCIyOEBTs9ogX89M9ej3v30rDjd+tqJI+jwgW8yPpxU2JWJIPWMgBRbkM3qfyzBWOFKudDkweY0AthbGKc7XgFw7pviaMbn/S6CgitxxCx2FotBKxzjHWOmVXtGRWShQf5Rz81hmbovGrmBECyHHNb0wiwICax9BTQHNmopig2u+mEe8X+dj3jL8N2F0OT9LwtwNf/fV4kZ5nzFdqFYI+XEoqt+jhLgqtvQrtLjnI578NOunR1PnPV2Qzpl2a43qpSU1Jfn4FAYmNln6bJfxLhYmcVW7Wpoq5dSCkX0xx3ppr7WQPlHfRRN3r0RCBsjiA06ZB6GH9pzKxbYQfxBbnem94ykZdzBbwLAOoRKZ+lE/H6PW4dDLfDy7SnYUqLltTOtJhPYfIsMAtXsbYpjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTk8NvNk+yOaM6Hiqm0K44IGZq9tlnw31oaQlBQ0YapAvBkw60Q9obRos0rx?=
 =?us-ascii?Q?5ckfJ4yiaVy9ZLeg6q89/Rk9CsGyR0C8d/r1W6v39YBPbYndJCDX2LMLqKLw?=
 =?us-ascii?Q?YNCsJxflwH5gHi9UZOu0P48lMsMjMQZqbmEnCi8a+1h7moFWModW4aCs5J7b?=
 =?us-ascii?Q?jvycHb3yFa8Sb3Hjw85p8gNGNKxamg55nZ24xxtg+/Az1foKsLgrYq0R4Ekl?=
 =?us-ascii?Q?ZFmCrlClDrrqEWkK3k1DGDQ0oTck8x8ZiOEqX+SrcKuw3uVoUO/2PI3M+Ue7?=
 =?us-ascii?Q?PACIbifi/unpKM1tdbq0bcqBTfKzNj6KBg779Wrb2V7GCErf+rNOQLOwqoHF?=
 =?us-ascii?Q?TwJ/70SNiMfIFcfPB9PLjyd7Nxh3Z9sCZFNI5ZXvM8jNRlMuMfGX8Wrxjocj?=
 =?us-ascii?Q?AYqABFDnJy4PfhoCJh5X7jU4vOaQ2QVVJZDzN1gxkGDVc8DPKmLLOzLXevRa?=
 =?us-ascii?Q?tdw6JGooqFG084mYNu7y63SMcjmFNLOdUpu9NKT2x2wA34uzZuTmZN7onHD7?=
 =?us-ascii?Q?4ymKKZDmKEntFlh/Cc5yi47LhrLb/7uLPnvqN2MJGrKjeT28zWrFzrH0sID6?=
 =?us-ascii?Q?K+mHXijKrWNvOtUgIbnEkDuiSf8wZLLf1Nqk6t9o08TJdl6A1uvdyXGMadLm?=
 =?us-ascii?Q?sxN4BCXm6gdHwEEJJtTuPQZdoXa3X0HF+P+WaJpA1lNw14Ehiu9AT1bRbW1k?=
 =?us-ascii?Q?Is8kDZcST3SvRxNIebH9hoilrzBHWGrKlu8oiulIoPBlO2xD3NL9omDuOSvB?=
 =?us-ascii?Q?CjBO5E7c/vrLUQGt6vkkcusIF+jAc30FX0CDb4NPbAOU+2a62cZJCthmA7yF?=
 =?us-ascii?Q?0G5pENteN7hVppNjHEKrTQp+rgRZPmNOvB6x8j1M7q7AjLOotiQ2Lvh3WQx8?=
 =?us-ascii?Q?8ygpxMGSxIDMzYUiQPqdm65W+XfdSfWTJ9uqB70sEUqv93tqpD3fWJ9mHK3G?=
 =?us-ascii?Q?ixsq9ILEEvKwa/eYOhBLV5rKQDDXLMqa5p+jie7tN/TUGibD10+soOahfldK?=
 =?us-ascii?Q?UevTV8Ihw9HdKcTZBSAmaxqIzZFBQ2OZrrBIM6RgyBmD2876jaH+qh+LYydc?=
 =?us-ascii?Q?EO5xec9IhfDU7KyeSXFVe307CMNPSKOXoRioaGAR/Iq5qMSbh3RcAA2mx1Mw?=
 =?us-ascii?Q?m2Rrt5hraGyMAjAQZ8AN98sZyBMNP+GHUFYiIQJcEmWZnsBIikcgjlVJGygm?=
 =?us-ascii?Q?Lk4rKyBsr7y9k/XSx4C5WxG4+2mWTLDDMClngb9VuaSXwtMH0XH2OX3n6IFe?=
 =?us-ascii?Q?EhDW23j8UgLsklRPJtDYwR6YhC5C1xbslP1ON+EK/dw7CIcni24i5nOQtOV8?=
 =?us-ascii?Q?2Qabu2evkcho8+dsh+/Q3SIR1Sq91+K0BeTkEQQL6YTTwLiYb1dJGU9RIHOo?=
 =?us-ascii?Q?2SsfbAnZwVs6XniK+ALC9eHMsFC+g1vaL3PhLcW8Nf7b6YpbtINiKkSRRfjT?=
 =?us-ascii?Q?bdFSH55iHscuo/CbefzwdNkMGcTA91M4Sdj6E+xgNUcWNfC4aOubCeaEIWUS?=
 =?us-ascii?Q?np8CTgwN7BLp4r/bTo4aV62KFZlWQx+qjHbsyVR1dLMWSxYWXZgO3F2tKr9O?=
 =?us-ascii?Q?cf7fYwa9jroKjV5komIqYM92mjrzUsVTEy5T7QAg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71641b2-3ab9-43cd-8c6d-08dc346f3004
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 12:58:53.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G0p+8T2DmIsNU/TJXe3X8Snd8wz/F2VLfm4pA+HuU9+jLnuaMklPqNwF8Xn3ahg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566

On Fri, Feb 23, 2024 at 12:38:18PM +0100, Niklas Schnelle wrote:
> > Although I doubt that generating long TLP from byte writes is
> > really necessary.
> 
> I might have gotten confused but I think these are not byte writes.
> Remember that the count is in terms of the number of bits sized
> quantities to copy so "count == 1" is 4/8 bytes here.

Right.

There seem to be two callers of this API in the kernel, one is calling
with a constant size and wants a large TLP

Another seems to want memcpy_to_io with a guarenteed 32/64 bit store.

> > IIRC you were merging at most 4 writes.
> > So better to do a single 32bit write instead.
> > (Unless you have misaligned source data - unlikely.)
> > 
> > While write-combining to generate long TLP is probably mostly
> > safe for PCIe targets, there are some that will only handle
> > TLP for single 32bit data items.
> > Which might be why the code is explicitly requesting 4 byte copies.
> > So it may be entirely wrong to write-combine anything except
> > the generic memcpy_toio().
> 
> On anything other than s390x this should only do write-combine if the
> memory mapping allows it, no? Meaning a driver that can't handle larger
> TLPs really shouldn't use ioremap_wc() then.

Right.

> On s390x one could argue that our version of __iowriteXX_copy() is
> strictly speaking not correct in that zpci_memcpy_toio() doesn't really
> use XX bit writes which is why for us memcpy_toio() was actually a
> better fit indeed. On the other hand doing 32 bit PCI stores (an s390x
> thing) can't combine multiple stores into a single TLP which these
> functions are used for and which has much more use cases than forcing a
> copy loop with 32/64 bit sized writes which would also be a lot slower
> on s390x than an aligned zpci_memcpy_toio().

mlx5 will definitely not work right if __iowrite64_copy() results in
anything smaller than 32/64 bit PCIe TLPs.

Jason

