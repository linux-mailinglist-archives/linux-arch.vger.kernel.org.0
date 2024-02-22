Return-Path: <linux-arch+bounces-2688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E248605C1
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 23:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FF11C212C0
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D317C62;
	Thu, 22 Feb 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyswoUbm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F412E40;
	Thu, 22 Feb 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641383; cv=fail; b=mOEtbYVDeT/gwOM6NP+C2Zkw3oofRM3N+gdYlmhkuTTu3aEdPo5U9NWmJ6ANQI1SdXUCnW/+pdqY56ujDiAhAZvn1LRaidt8644Jg4fezR4bAI4oM3peLtNPiyn2VtRtRwO3liDsqEj8mrmllvedvbTpvtNg2V/dgBoqthpGD0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641383; c=relaxed/simple;
	bh=m7ew78+X0oEwPWO7F05kjN3ykI9oPfgiw8q+tm1rQVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KhLYKqBuIznRGkV096QR9anp5V3Mi/fpFi+j2OEfCffMUWwsyEMpANTfetIef6XksBS7mFAACyOusZkWM4ZzgTKMkhxmWcs5xW+YL6HUuf/PCMWvq7BgZP/oGucDfk1OOF3Yq7jiBfKeR6DedPO3N2d448Gf2CtZkUHGQjP9/Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyswoUbm; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkx2/cQ5mlx6x0qTlzwIiCTPCo+w4bLke24zHv60dcfQX9eUtT3xM0BBGpOQJCnKpwttuNe/IZ7ciWKKmZXhob6ZBVTRYIWA5D0VnWSZ7JuVNkFESgHoiVF+GEvyjRj++F4Jnyla4iYrJe6x3CYoXJuxWUHL34EOG/w+uD/5HquGnMzad9P3ULSkftaEjXFIKl7U0fdHXtiqvhGDFMspFN1yRHcdqloWhEs/KEL7QWwhk0bVw6LnqxybuJDfYToLayai3ibdMUo/3ZcbUlFg5OKEFtZplOVxH+bRllSSnAlYzyH39vJ751O3r3xe4jEx6Enfw48TuVqdpHuo3rEM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=556nOXOlFNVOoVAIXOAp7n8Uzz6ZG5JnfbbRK+Fw5UI=;
 b=i9v1iw8NrrM+cubHvnoolodE6YQGgYtGTHdPHe3EByqkmdBAE/yi7qTnERE++f4fdKvvCQ96DLZZ7XwkAwzn8UvVD/d3+mbpZ9xjj4HwdSvxgZJL5G/EXiY4tlCgewbV5ZH0vzHIVWK42iXUUS7h3cZeBU2K358nEfNVEaBw6hGVcRu/CaQ/V92xTv6j1TpU1S1HiMXglwoo/J0abKHljTcomApmuOt6+u8miikptK3yq3BjmnbJIAL5GermS0XOPYC3ROB9KbEcIOnZzHDvwIhCbtBWeiKnfYubHud79aTV0Fs82VfBkfRrHFw7lEUcbfNj00G7HWxUEEwiejHMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=556nOXOlFNVOoVAIXOAp7n8Uzz6ZG5JnfbbRK+Fw5UI=;
 b=qyswoUbmNSnd6Qc2Yue3Y1YVzzEwqW+63BdEPsJr59xnaVtx9TgsGuhvbpbgk2rua1u1SDtbcYvSlJH23Lx7g8+9M4iWYM9OKZg7EoAlGOpahsBbbFnW4q05N22t33oXdoIktXasYmlaHQ99t6AJCpu5YDuetgJU7OvhpXfuTHqy7h+slk9HsYFMfQzMegOJjLFmtqlaaLiPnjnlCmrZdKf8sfN1J2aLGkrRj3uDPH9fziqwCZU5Bgd1KEsDZl0xVmlvlglFWeqT94M4MH3zoyQRb9PrlE1WOAqBOjiy8tQKObY6hvVCHd6Y5/SCMYkMsyuFtU0VqeRwrh10hMtUMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 22:36:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 22:36:18 +0000
Date: Thu, 22 Feb 2024 18:36:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Laight <David.Laight@aculab.com>
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
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240222223617.GC13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 902bc137-243b-4ef4-10a5-08dc33f6afd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MS4Y1HOvY27XSlfqfO37dCkdSVGZd+oZ4n3dGceQ+Ef2ux926E2KQnK1lFd3DdeKnv4Ro+bUFu86R3D1OzrXN0BQqv3QZOSJxKij33ffKl7gl853GjVYBs6Yrse9oEtT0zPNsHLADJa7J9CaQ+r9Zhi2WeY79pukxukq9Oi9zu7+mMxyoxV88bWomsAQC1mXmfBSZg9a/0tJBd5kSD+3HGMtJuhkC1b+r6yZtzMDcIiqPErSW4rXDx9AHSv5yjEui3vISE91Jzv6lda3no/nOYF5SN5+hKxBPW3UrNtoMsy6jZ8k2KT4lZ7iesQKTx5E/eYRqkEZ/o1wL17V7/CQLKAjKG9bjhJ3l9L3HP86hM3Hm9KSTMxNBeSdBmoQsr6J0yi9kHUc59wpL7exMoth14B2c/RqsjZbYP77yvZWubRrmRM6YKQhKaQQ4Pmh/x3vo+pwvPfhFkiwA/EpeEon9D4R7EUyGYihWBcSDzfW2S8aKJ5iRnt3IbsDl6d4+GBUMh+GA8Pd3uneDFZtje+HuDyZ+lVsLBiJOoiYLO6IUg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhS6U//mrXukSZsfeM4pUMuLcjK3Re1MxpSOKcWjs/hsAypONE7YGpzxB5FR?=
 =?us-ascii?Q?4yO7f5nVftLb/bS3vgzzEh7t+UGyqG5Q9sWxMvWxoLaQG9piyj8QMohlnk6V?=
 =?us-ascii?Q?h+QlMFRu/3KKmqvUSSXKl89X9Df0vj/encGmIMprZKiS7qJDZsrA7KXR7ix6?=
 =?us-ascii?Q?1hQXtx1umNxyJ2/B9VoCzgP7oS1yHl1nAeJuZOJaf+0jBLTi9yEYbhw5dSSd?=
 =?us-ascii?Q?6crdQoqxOVGwTyeMs6fTj8SdiM2fFI+uryqHtYelCJma6moAiNtXKJ/2pZ+T?=
 =?us-ascii?Q?7C/Yk8ErK8wc52Mmk59UGjDIYFq9DrGU6mhsPU7yi7HSK/xMnhzUyBBkveR5?=
 =?us-ascii?Q?jcWYqm7gcT8Cud30UpbGWdgSRqKjgodZabKcdJEasKd6mnR5wdSOWMhSO35m?=
 =?us-ascii?Q?s4qsKkmAm3mHwHBzkNjSms0CF0hOYzjJR/5tuWnpFKuK33zINRkgMPwlbRHz?=
 =?us-ascii?Q?J2ZbjTcdVErGWaKAwZ4d6PEYq5RstP8Nz9KDEtWacc+NlxKqcpejh7MeFMS5?=
 =?us-ascii?Q?teYw9CReiDv/kF60n41C3ew0QxYMzCJ4kbfJU68z+g0i7wSOOpwtTC1h1xVK?=
 =?us-ascii?Q?HuTG48vGYjEbAodpvfE0G42rW29du/s1rJbMQe0l7G35edLABrgau4Ash6B6?=
 =?us-ascii?Q?svxd0PEyujilP1QqSvIMBj0xva9oCOSeN6QR7em+sdEOyHyDVt9orfkNn3c4?=
 =?us-ascii?Q?6Bsm04+tfhISEhaVapFRUa4xqXafR7+jeVd+LgJHZd2R5PbpAEg5NTSgO58Q?=
 =?us-ascii?Q?GnPBSXOpQxgxi1bi2BBSZk1B9tE7uM3YeTP4AuNdr2PqAmI2ZbbI9RxUo9ui?=
 =?us-ascii?Q?FDA6SZtTAKBiDITbbk1SlgV+KtVrfB3efYuLsLrn6gmCsuQgoW0QLGz0Qc4R?=
 =?us-ascii?Q?16NcQC43rRM0lYyM8tYTN762M4v6Wqi+ExG3pVZuIGnAuWW909K0IJgOtQuE?=
 =?us-ascii?Q?7k87OJ1de6Hg4fB2YH6QggCer2l1qGuR0Y9d6JNjcdftSaq0hhTeUO3sEwiu?=
 =?us-ascii?Q?AwMnNAODBf6rAw78pJYk0ZNpUANLE1c2uWrKW9GK2BRLaraD90qQQ/YGyq4Q?=
 =?us-ascii?Q?ucZPJ3o0BscWjved+HEDxKrQXTpqefnaYg2kl3bum86Pl2+AcQVZ7Top0fqz?=
 =?us-ascii?Q?P9IEeXGrGRzfrjgd2yh7LJh7gCgFO0ohP//sME1deISGnB5qL7KiWDhuf/iX?=
 =?us-ascii?Q?Z92oRrloRhrOsK25W2h1lxjZ0EUL5zqqxOsem0jy2ieuU/YK6mz2XWg87baw?=
 =?us-ascii?Q?FMgNd5XOX+huIXiuEVfeOTrDWYOTVkHGEc1cEty5P8Suq6EPm6KwRbTC5az/?=
 =?us-ascii?Q?Nur2ePkRVEbkDR05V4kaUH+FdThq5gkrzBIWD+EB8H+gqIai2DZ2mpCiSLAl?=
 =?us-ascii?Q?GwUxn0yGH0BTt97PxxD1z0JGyEOlqprjMVaxGD35lxtqG9z4vo0gZg+HSjbA?=
 =?us-ascii?Q?Rzrar9V3QFFHecpo/BUYAXMMkIaQ025PlVdNRgfbqWYXdBrT5U414TdOze2y?=
 =?us-ascii?Q?xZGL+aH3jucUByi29eL6mj38muPv0MtjSLu6HmlqofBk5Mfm2EPLYd4cgkip?=
 =?us-ascii?Q?yDtmeY/JpIxvVpzB3rtSsMyEiEkInRp63/ro0quH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902bc137-243b-4ef4-10a5-08dc33f6afd1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:36:18.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XXcBuZTvvvFV8v2i9IEP7kw+07zZtjvcXTkBYme+9zs28eLGhdmL1AJgJJpI0YN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

On Thu, Feb 22, 2024 at 10:05:04PM +0000, David Laight wrote:
> From: Jason Gunthorpe
> > Sent: 21 February 2024 01:17
> > 
> > The kernel provides driver support for using write combining IO memory
> > through the __iowriteXX_copy() API which is commonly used as an optional
> > optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environment.
> > 
> ...
> > Implement __iowrite32/64_copy() specifically for ARM64 and use inline
> > assembly to build consecutive blocks of STR instructions. Provide direct
> > support for 64/32/16 large TLP generation in this manner. Optimize for
> > common constant lengths so that the compiler can directly inline the store
> > blocks.
> ...
> > +/*
> > + * This generates a memcpy that works on a from/to address which is aligned to
> > + * bits. Count is in terms of the number of bits sized quantities to copy. It
> > + * optimizes to use the STR groupings when possible so that it is WC friendly.
> > + */
> > +#define memcpy_toio_aligned(to, from, count, bits)                        \
> > +	({                                                                \
> > +		volatile u##bits __iomem *_to = to;                       \
> > +		const u##bits *_from = from;                              \
> > +		size_t _count = count;                                    \
> > +		const u##bits *_end_from = _from + ALIGN_DOWN(_count, 8); \
> > +                                                                          \
> > +		for (; _from < _end_from; _from += 8, _to += 8)           \
> > +			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> > +		if ((_count % 8) >= 4) {    
> 
> If (_count & 4) {

That would be obfuscating, IMHO. The compiler doesn't need such things
to generate optimal code.

> > +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > +	})
> 
> But that looks bit a bit large to be inlined.

You trimmed alot, this #define is in a C file and it is a template to
generate the 32 and 64 bit out of line functions. Things are done like
this because the 32/64 version are exactly the same logic except just
with different types and sizes.

Jason

