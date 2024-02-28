Return-Path: <linux-arch+bounces-2772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0286BBE9
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 00:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD571F29C82
	for <lists+linux-arch@lfdr.de>; Wed, 28 Feb 2024 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416C13D2F0;
	Wed, 28 Feb 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9VLilN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007D13D2E5;
	Wed, 28 Feb 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161584; cv=fail; b=A3T45g0T5SqSTN64/jBH1yKo3pOO3o7/U9pLDtI3wIylFOdG/i46cWz8YF6BqlsbLYVEuydwnjPEkT/IJz2WJGz7xSZBGxl5Y9aVqXZBug4GLH9Z5v8ABgmgIsGzt79LQ+XC+F56utoH8SqP4dsV0jHCclJnHtLAD9igOApYl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161584; c=relaxed/simple;
	bh=b96DxaZ0vdRlBNXj7nYXn/QvI4oZ2HFXv61cr8FbQRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZqM8vHCJYfQobpVBdUSfoJzdlcanbxNH4xnmDWaha2vPdd6seFIv9MB+QY8tiD5MPv6etnTv2+1J8mT4NKL4uCMQm5KRS6A/uLUBpfKDpJl9i/lQBZVVhBu3WJqumezNFPrB+qUjcHnedGafojvcvlb0N5dGjzy4sWcJvTuHENE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9VLilN6; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHWLj3gXF/XysF+cMOU6s7th0vRdthaFJLCDS7mCwrUkOt5xhf1J9FlzRKuS0OQwBe0Mq/M3r9w2W3XOIIaWP+DyL3EXNJfDdAkd98CdRDdA6o6bxHTzmeHHQuyNvg8nEkv8rjm+ix5AW6+YgLUKLlxhZTLk2YJXtHGSBuLvM23lWw2i0qsFLNbZSK5xwljWosbMGwpZXbO7qXO3iKJGZlETkMD5utxObEXB06O4G4+iefKrUgPQtKi6WwswL9pPWmyPYKmU+SfRZXwLW1Kjz0Ik3nlEn4t2qMXahowhG2Tk2T7Jp/mWIoHxRJhAVzF79zpx+ioWe/GjBcPWRcLTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqa1gAzyjIl/S4o2PRoznHYpTG2g0iENkbXUyWNHni4=;
 b=CJBd27YqJL13w4kyNtjylLlgQ3U0gQDUFGiK8LpbTvnq5cnb6CNyj6LMh5JIEEnhqrR2/v6tKj0ausHjgX5k9pgHDs7d1PMm3M4JN+NdMFxgEWRBwv4NPLBpPpjLVRBRYj9rsj/+KApJiKsUGHrVt7I4aHKVn1Au6Vj/Q+zSykPiLTEYr49H6NOZfYaDk5t3MYC0bIYIQgeypO9TRtprRAvHqSMQhij3Kz15PBMCeF2wwOeWtZ1C2l6qltwv8jRQlUvNdgh72NBnrtuUy0Zuuxkckj6Ka7Ij/BCNH9yi78T/Q+i41laGh7PjK0fbWoiLq8lL8vi2eX/fmdzD6RLXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqa1gAzyjIl/S4o2PRoznHYpTG2g0iENkbXUyWNHni4=;
 b=K9VLilN6TcLbw6pZa2pvKDKNCsPxtMclo1/z45HSwMgjxrpvJurNe/A6YtCM7X/mcabxApZJiI2w1e05Q1tC99S0YZloz7XxqInIVSgW7nUFvQ+y2YReUjW2NZeV4etTWwgLepB827LQdHFLyl5ps56/ny5oJmGgNUmr9hPZq/s3oo8R79/FWeys+svjvkCb6/+PiMLjrdC4nysdq3M+3vyoMg3u4d7QM04Em4xQP9ciR7ebveHC25ceUuk6zCVePb98wOrrS4DrAWaIqLT/p69NcE2SLg5Ci/9MuEGcMFGY6doCFrKz/vU7MhetxU451o2fUHdINROE9DiDSpKcUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 23:06:17 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 23:06:17 +0000
Date: Wed, 28 Feb 2024 19:06:16 -0400
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
Message-ID: <20240228230616.GS13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <Zd27XtDg_NDzLXg-@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd27XtDg_NDzLXg-@arm.com>
X-ClientProxiedBy: DS7PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:5:3af::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c28f0b5-d1f8-470c-71e8-08dc38b1de44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1R/Z2DoK9MFIGp/bQ3/mJJ/ZbV31X9IjwBAWaBiYoq7kEo/SEXRLEFGLfuLDwy6HGgNmjXGLSm52qXYFzX4qnrnnyujGLjalIvS524U7ETvnbwYV/euEPVSCETWsigA3ZnJ5BUi9gYSJwHHY4vJSWhXD+aNZ4j2sC7YtZm9l1MovqRBBisM0XKou68Nuo0sNN2DbZbDDJgaTmiEaPbmlWJNUHmM8YB+nSgex8D5BEKFiKKKd3q5HC2oVaE6FRzMfVv4GopcBWdslR3yYtL/wGsHfT5Oif8DQOOCRDK5YEKgwdj1YsTvjGl6MTk3wsCJ0l0UDY8Fswh2VLlPNqlwJzW3h/aKjpj9Hb5zW6JtWEbQjMiUzmLAOpOb7QQwhiOWj4IikBSIfHxZplu5qrENFX6gZ2KQMAbDq6lfeuh2gV5Gbg7CIvDDDYwrwJokiyrDymtIl+gEKBc+XMYrEHUzVv+MrxfNrG0zy/eNZwSFr6FYoXQdMPKoMfcvNimQdyYK8bwuh4dyH7p0WRgAoG9mxR1yVu9x0qKM/pGKCbU2GFT/ddgtc/2hKAIxpWfsCnOxQd6y6YxV75+wDqQuF+31CV2V72SCCguwm4IqvtzJ4TdhvEyIG2+uhrDeoI2PEG+ym
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bl33Vq0DxnAgTVxNZhEcYh36gqJFY7Pug7yoOiv50bjWihtvuCvQhWBb2K3D?=
 =?us-ascii?Q?dOa4DUejnRvnjtItie9SrSocZX+erpipnPZ6zx6Ik/mZp6VaKK4aYeHkPomm?=
 =?us-ascii?Q?SlC/lhwvGJewnYvxiSSLtAzjeWuAdp3crCxUVI9s5BJH+5hYVb2Wcoo/zB86?=
 =?us-ascii?Q?O0qphUwEPZ79CDYSTXvXfnChTvQIXGmgP1fhhCIF5trKzwmgmLjprlMQ2nHd?=
 =?us-ascii?Q?elWdLB2oXwlM5xhfyr1k8bv8W0p6MaTLmI0z+4iHBt4fY51TEfLHDiR9Cxno?=
 =?us-ascii?Q?rv7Mz4w/AfHQBaoWOJg8yyEczE3+fx3lC1/sK2HW7EJYyuSMOYgwY21G99Kx?=
 =?us-ascii?Q?+JrSs/pnCo8zvRX4hlkqpt2Q1zMJS+aJAMsLcI0LEeJ8tnaEMhKaZf5JEDZA?=
 =?us-ascii?Q?KL713xFYTqdiW2cqvnvev0iKhrDMMn8TjN5R7C8Qz/K1LjLj+WNZGpX4NVvp?=
 =?us-ascii?Q?WV5+sDsam9VLZefmlQbDVKMCZG9MiR5mbtIlW3yURcellEIcStCJ+L4I8xWa?=
 =?us-ascii?Q?mb9z0gdGY26nxHDqOafc2stJx2RUEW00oafqKD1keb4UQPUHnwvxmdzXi5d3?=
 =?us-ascii?Q?UszQDRWd9DDN8ymT1Ri4wpMCWb9oiXxJIxEUXfmX1Xmc9VkvevYU50ciIzsm?=
 =?us-ascii?Q?ckPRGxwFEkXCAhmCjif235tDNm00RumXOGowaDtEiSn57lgfD3YpJQAuLkop?=
 =?us-ascii?Q?Jr50Bmh6UD29qib+xXIrO4/ZpHovoZ7UMmyeq0Z3BIJtydZxk4CppdQynuug?=
 =?us-ascii?Q?u2pOkBlEQqPfcx8H08X8D4fPHOwADHKlLpcUffdWwiR/gRJfF29t+DgKeyrj?=
 =?us-ascii?Q?aKwGSFdqmc3qXm3Fe0RjArA7UZTptJtc4SVYN3LCMq+riVwddxc6XJoE3Y+x?=
 =?us-ascii?Q?q42EFUMtf6yNrzPL2Q17r9cZVOYfaRhjkOGhWQ5qhQXt90zJUbIkL2QjKCCG?=
 =?us-ascii?Q?E0npfDQRVFLYLAy4QuEc5M3WTbVMdkFqP+Fs5tNen5T1Ilu3A4jsmjZPteAe?=
 =?us-ascii?Q?mU8HTXrL4Sn4uThS5oCcmqFnzwBQieNkhzShdlDiAksRzAe02zIX2VQZzIJn?=
 =?us-ascii?Q?i94edTg8PiKHICQJwWjd0e1oeVtkCsgKABHknxgxguZ8WhmCs1NxSaKpHDLD?=
 =?us-ascii?Q?9Y/YjC2yxeuPBYYm3eXxaRHsfGXcagq6cg5f5e4B9Lelk8QeSbmmekAlORuO?=
 =?us-ascii?Q?tB2Wy0XNyLrhV80Sbd8Kr/xi7mY6i1HVuu+2HBVyRRUMsgS1dApAtpsmJcUD?=
 =?us-ascii?Q?KB2RXIgu9PcCuGQ3Nc7j+752tmE/PfIZOUnhbXWVItfEVkUXYDHmu2CxaANS?=
 =?us-ascii?Q?eCCAvuzpixoK7AqBc9pbkbphEMwtQUJUVjWjqlEyd+QurdTfccV6BZ89Omtx?=
 =?us-ascii?Q?LtOrNbF8flwKvCeMz1oG6VYrK3UihBRTx5Z0Hn49z3O/7yCbai9NNpfvxWFU?=
 =?us-ascii?Q?7SmMrFgECI16Q8KrmP3WkXxTzA42D3jw0DaEPujBLbDz36IC9vGnFFFBM72A?=
 =?us-ascii?Q?eig7G5K9mIsA66xcQPUp1mrAdgvlImkzdadX0O8hMed3J7v4mrrrCYvDPf6p?=
 =?us-ascii?Q?HMgUf90absdk3k6yx2Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c28f0b5-d1f8-470c-71e8-08dc38b1de44
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 23:06:17.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LILSMS8ZEh7qGuIN+7D0algwk/mXUR8Yb1GOHfNMJ34rb0yVu07rDpxZyT20mY5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

On Tue, Feb 27, 2024 at 10:37:18AM +0000, Catalin Marinas wrote:
> On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
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
> > +		if ((_count % 8) >= 4) {                                  \
> > +			__const_memcpy_toio_aligned##bits(_to, _from, 4); \
> > +			_from += 4;                                       \
> > +			_to += 4;                                         \
> > +		}                                                         \
> > +		if ((_count % 4) >= 2) {                                  \
> > +			__const_memcpy_toio_aligned##bits(_to, _from, 2); \
> > +			_from += 2;                                       \
> > +			_to += 2;                                         \
> > +		}                                                         \
> > +		if (_count % 2)                                           \
> > +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > +	})
> 
> Do we actually need all this if count is not constant? If it's not
> performance critical anywhere, I'd rather copy the generic
> implementation, it's easier to read.

Which generic version?

The point is to maximize WC effects with non-constant values, so I
think we do need something like this. ie we can't just fall back to
looping over 64 bit stores one at a time.

If we don't use the large block stores we know we get very poor WC
behavior. So at least the 8 and 4 constant value sections are
needed. At that point you may as well just do 4 and 2 instead of
another loop.

Most places I know about using this are performance paths, the entire
iocopy infrastructure was introduced as an x86 performance
optimization..

Jason

