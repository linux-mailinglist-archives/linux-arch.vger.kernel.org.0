Return-Path: <linux-arch+bounces-2775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65C86CA3B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2691C20E9F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0967E11C;
	Thu, 29 Feb 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ko2hqmKR"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203174B5DA;
	Thu, 29 Feb 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213296; cv=fail; b=VYl8gvNIebsVjcS7LPTsYIPPmGe+5+glQB0BkmDIhXybEdnFd7lbly1Ak7m0vio10NvzZYG+ZqKBcs/N4cIwlTR3CXdfwhyrSid2JsyGkrY23ZwmDtc/m4wyBAWwS0J8ma4nOzVnIdWeMnZBxykIf++HDSSw15AglK3bBRuNgps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213296; c=relaxed/simple;
	bh=LIjxcL0Ktda+nAAXVjoJlZxVW6fymFx2o3AasCuTaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLLg6Y/4N9nPov0Jce8J7WQSIUl7ygQ7hvmMDXB/2/P4gOJuQ8B3TwvJ+fgMOuxz0ZocEBqnTR3wpI/8ggF5fYFSz9r/EtFeRq2vAVTSR4SXVJSk27eACj+i12RTCmmlqYPEURNgf1kGY0E72ieXMb/xUt3O8XhhC7TSjS9AnzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ko2hqmKR; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ6M96xiXREkoZQjU2+Nss8EIfk2xU3XG/4xKTSaIzlpX6rpvVJNbkTLza1R3cmv2QRpg3N/WWrBJBWNj1esMhQ05DOdwI26K14akQHrELUsARvwqyBJdBvJ0ZxGIdLSqpe2HNI3mOy4oX/7EpBWsEbRaBQAOReQtPxXjadJR3IRUEVz8/hBncvWAMSWbsv862VgdL5fIlJ1bN0f0cNccg518YJNWJEsZEtT4MmqjImrW5zpbu6FXCbMG5tbfuwOHNAN1m81TK4nwSmNg56ELy2rLBW+xFuvQ9hhZSiNNb5dk0rIXEL42CUx6iE2FFyscdKBAJDUC3FrSWHgbCRKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLy6nkxBwqP8k16mpZ9IugYBFqZqO/e7yI8e4so7VrE=;
 b=VmqZjS4Czvn/6At6xKaE0cYovf9R0Asr99+DHgSaacxVyePryoWg1hXQdyEkOt5BypcClhZocxNuz9iGebyNc6YKLiBJvYlDQ7czOnJ0PqSESlKKZXI6e4MWbqtN2YcV7xUh/GH24IW8UqM0IX/y8CtCUx/pjNkyEJlT5kJd9kAbklN6CKAuTDyk0UtzSQmr27o/sz6V4LCHN9VqLwiMdT9H8mjm9m4EBU0h4wbuWkKUGVYBFKgasGNGR11UPETKMaNwDcvpNO92a3cfka6um1mmnsMzQPnJZ9GKU4Vy9pCLNCcgsRJTA6IVW1l7UwSnMvVKhQojU9AtwKJLNe6osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLy6nkxBwqP8k16mpZ9IugYBFqZqO/e7yI8e4so7VrE=;
 b=Ko2hqmKR/m36fv0dMONOXflTQM9tXHtsxXl7YFq1cqLydXlwOUhvK7n2DhZuR4V5Bev76kGr8DbEhH7UbLPM6A09c6OcgZOPfU6vWIwzdiBENvttLzu+Rpj6LBEdtMuY7hSMUOm64pVa1vGBqFliE5yAjGn26m6Q0SWFYpfrwu33ufJ6Ef519Jev3UaDhEvhOChvX3c1EvBvV5y6/yb/z1ZYAknnJmhxTefGEyjBHDGFH29k9xGwlclOsM4dyYUNOSndWgxWb0SEoeC6exAMHt0P3b7eus7MC7qVTZ/Dyc1kZHP1pgBruzz36nPxaYcWHQL83l0bBQ0UoMyCtmuBYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 13:28:11 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 13:28:11 +0000
Date: Thu, 29 Feb 2024 09:28:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
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
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240229132810.GA9179@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <Zd27XtDg_NDzLXg-@arm.com>
 <20240228230616.GS13330@nvidia.com>
 <ZeBbamDoHIxzzfof@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBbamDoHIxzzfof@arm.com>
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: dd859ec2-4573-49d0-b712-08dc392a4633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y46tbwR+DFHy5dnb3nuA6aJ8Zpu7bnS57KPWu1OHediJMcVuhFt7pwDNqfY3LZ3RYNS9Pqog0AAPGFuXqApbyEi5nm8l20TE17HAA1jtJo8BGxbY+by7HuR/u8vYgF6b2DqZHLhIZdmE8oXmBcnpEYJs2WUpLjBw4YaDhdyYN8JN1ptTlHSQkG/cSANCPd1hqWlCtUofPQHge2XGpHp2etnm3pV7QS+SNIXvF8E4XX+CLwucRQ1Z9pPyOmePBDcWRY87PFlFalFM6qkK8kcgIrZIcQkboo8WN4vsLYIXG4vPs9tp07dOieQJs4Dq8xXL2Ay8Tl8l+kXQvP36E9EbTtBlt/dI4l+iV821X156MqmK/DzJiXEhxdSP/wcHdzNvfyy9LGEfhnwuiEQcSiD8bIpd0nBCjE3D43m/W6HTZBQfMBSEuwod+kNOApe8TIn++51HkmMPqw52s5JrQKPRw7Ya92uviCILhYq7wTSMN7ATvkO2/Dt7MCgbOLgRTrok4Zuy/hPW9u+vuyKYxAIulQBVql/UvTXz5mXe1ajhwInb7GLNgzLEI6e8vgXN8OPKnB+v6utfCGh0Zt7D9BUe+wtBFS24qE+C4aVIdzxBqEYc15haIU7M80KgrHGYgNxC3V6vvtbCl42MfehholoXpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nrqZSE3A+LGDqM4Xm2IRZwHhbzLUZlkZC9O756PeQZyFTvo7+gtcpf5Y24dV?=
 =?us-ascii?Q?WiMny6MlfQRoeGwmlJGtB1SRlXm/0J/j4YOSaIddaWALBUs5ziwcQRTauELK?=
 =?us-ascii?Q?S+EzhzG3zmTwXgRJODpmRvfA122SCRubx1PiveQ3UUfkJwelZ5LYeaSsFW3F?=
 =?us-ascii?Q?7xKVMO1rGCy/VgYCwFVGqxPEgv/agmDBazsiz0pw8fuzDxiCLlBanleFm3Di?=
 =?us-ascii?Q?OHUy08Aq6zAf5StGOapFHqR9dFJn9ke70fk+mfLlTfOQx8fyfs4NDWFyKwE0?=
 =?us-ascii?Q?NP4rGIftzhxMP5/98OmLQpO9LK2HfBK3tJGbD/3zb63kShgy0/j6lAXohcYc?=
 =?us-ascii?Q?x1mSQYaNlpn1Omo+Yn0ZzAvvbraWgNlOEG3br/eGEiWc9gQ16GtybUl08Bdb?=
 =?us-ascii?Q?We8Le6iPhH7yjJORedkwKg11SBEW9taeA0HLS15GzbJ6qDO2wDtC6x8Cggaz?=
 =?us-ascii?Q?74EplinhzNkWmhXo3n1qM/EtiCFJUiDo97zjDOx1ZNYDysQfjbC2ErLeTKwW?=
 =?us-ascii?Q?Ufp8qEgVDCXF9aXAb5qIGGgcM7QnE9x4is8sRIXxTPGx2OI6tWtpCi/eerFj?=
 =?us-ascii?Q?xrjtPsww2vr/VYipfaVSjUOFQPm36ZcI2LDH9HPupXRHBzwZ8JGwTgNEojmk?=
 =?us-ascii?Q?JX3UHfb/EgKb30L7IfcQDozLgFiSqt18Osskt/mQVhthI2vUbR1ldGl+GDLs?=
 =?us-ascii?Q?8BQOyc1ZI6r3KVpk847PVrv7ka1nm0CBWPgUNuSMNrF6SpA6kfjDEOJ204aY?=
 =?us-ascii?Q?SghgI3YYJ9KyCN4cwnJ/EOBwvXRw993hDb6lHpWp/WIv0+LCdxgOl74WyvfO?=
 =?us-ascii?Q?IY5jUyayRn391r9v8bkV+J+tnxAR/Sow6aMT7emRA5HVxN7EWOXM7cdhQpzk?=
 =?us-ascii?Q?I1hFOukW4FVcNEbNGBDpc2M0Za/GVV6eamOEWSvMIZiIGrRrP3zSQKdUjsfx?=
 =?us-ascii?Q?0T4X5EfUXw2qBSqs7uMHEt4qStd2VDA6FflQWLloK5TNsDsvzlTZTliRY57G?=
 =?us-ascii?Q?FMwlGgLxquewKBmDMBAPVmlc6Bc0UGgRMcb4FLn5+NzLRAwAJsEUFY6yRV9g?=
 =?us-ascii?Q?bw6PuVcoa5AQNNDMKPaU9jOnWWawn7CZlcibCYJ9HCayGBWcafV75nAReVvV?=
 =?us-ascii?Q?11DXs8LzeyZRl7GrhfnWI1nmKPHul6+L0PPbc7++vhGQi3+oN31rekXvS9DK?=
 =?us-ascii?Q?pLK4FG0KdZRAMNc59bxuZnFRFFOhuUBmmxEbBnwf1Ij+uu3x+obFibw0aFFM?=
 =?us-ascii?Q?IcNsxAsgFFJYJ1Rd1RuYiNQ2vQXzM5cLR0659vxAr/ro5VZI5ih7HJodeyr8?=
 =?us-ascii?Q?eQSTruyo1FaOskcM0LgO6pYZfLSelGNqoMT6LnEVKmQJ5ZwxiGJUiQgdAAZh?=
 =?us-ascii?Q?n4kzwXHI+Pi5VBk9aV9ydym50AwGZXPGx5w3EEeObO7BTBha/0Ge38UDwEgS?=
 =?us-ascii?Q?IDGWwQfKBb7Js13ux4WesVG2djIEVslJ/xqL66YnMigu3SWfQW3eSMYQvEei?=
 =?us-ascii?Q?XbsiZ3en9VKUrjsLl+JZCqIao1Q3I281tPjoBqK6Pu35y74u+ezBbDa8NsCK?=
 =?us-ascii?Q?pNBZeOp3HBOOMqnwgdldZHqYpTKdldSqQkJ6vKvA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd859ec2-4573-49d0-b712-08dc392a4633
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:28:11.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ9DDl66DWs2QSdW2jskBi05Hf8VLDYs6yn7PplXkA71DngLsyYtGmPAhQc3o3cd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Thu, Feb 29, 2024 at 10:24:42AM +0000, Catalin Marinas wrote:
> On Wed, Feb 28, 2024 at 07:06:16PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 27, 2024 at 10:37:18AM +0000, Catalin Marinas wrote:
> > > On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> > > > +/*
> > > > + * This generates a memcpy that works on a from/to address which is aligned to
> > > > + * bits. Count is in terms of the number of bits sized quantities to copy. It
> > > > + * optimizes to use the STR groupings when possible so that it is WC friendly.
> > > > + */
> > > > +#define memcpy_toio_aligned(to, from, count, bits)                        \
> > > > +	({                                                                \
> > > > +		volatile u##bits __iomem *_to = to;                       \
> > > > +		const u##bits *_from = from;                              \
> > > > +		size_t _count = count;                                    \
> > > > +		const u##bits *_end_from = _from + ALIGN_DOWN(_count, 8); \
> > > > +                                                                          \
> > > > +		for (; _from < _end_from; _from += 8, _to += 8)           \
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> > > > +		if ((_count % 8) >= 4) {                                  \
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 4); \
> > > > +			_from += 4;                                       \
> > > > +			_to += 4;                                         \
> > > > +		}                                                         \
> > > > +		if ((_count % 4) >= 2) {                                  \
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 2); \
> > > > +			_from += 2;                                       \
> > > > +			_to += 2;                                         \
> > > > +		}                                                         \
> > > > +		if (_count % 2)                                           \
> > > > +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > > > +	})
> > > 
> > > Do we actually need all this if count is not constant? If it's not
> > > performance critical anywhere, I'd rather copy the generic
> > > implementation, it's easier to read.
> > 
> > Which generic version?
> 
> The current __iowriteXX_copy() in lib/iomap_copy.c (copy them over or
> add some preprocessor reuse the generic functions).

That just loops over 64 bit quantities - we know that doesn't work?

> > The point is to maximize WC effects with non-constant values, so I
> > think we do need something like this. ie we can't just fall back to
> > looping over 64 bit stores one at a time.
> 
> If that's a case you are also targeting and have seen it in practice,
> that's fine. But I had the impression that you are mostly after the
> constant count case which is already addressed by the other part of this
> patch. For the non-constant case, we have a DGH only at the end of
> whatever buffer was copied rather than after every 64-byte increments
> you'd get for a count of 8.

mlx5 uses only the constant case. From my looking most places were
using the constant path.

However, from an API perspective, we know we need these runs of stores
for the CPU to work properly so it doesn't make any sense that the
same function called with a constant length would have good WC and the
very same function called with a variable length would have bad WC. I
would expect them to behave the same.

This is what the above does, if you pass in non-constant 64 or 32 you
get the same instruction sequence out of line as constant 64 or 32
length generates in-line. I think it is important to work like this
for basic sanity.

Jason

