Return-Path: <linux-arch+bounces-1386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FC83056A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24C81F2509C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62C6FBD;
	Wed, 17 Jan 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MHQpDBNs"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6B1D6A8;
	Wed, 17 Jan 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494986; cv=fail; b=klOOEyMrZaTEGHavSwjyc+taqM7kQNij8GErTRcoPiXAl0C7Oo77oYrSQsLbllg9qydGYLfb6wCkQi/k9chLNMEfbLxjyEQo9IrHcbtfYs+z/a9dSyKi5GD5n3r4jUOQlaLujdoYqU7tecY2g3dM+Z62IQHRNauWYC4OTjn1ud0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494986; c=relaxed/simple;
	bh=ZXhUXQtlQUoXfNGzGP7Faz6wuWzvZunUGAz/76w5rlk=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=d2jnrJyTtf6wNawfK55fp2D3z2GnYATc3WzUb6gNykCXh2BRoHzcFMkEzNXHuKZwXLq1r1NjcerpYSWyNeph1PIEal95T7VuxvZnl7n6hopH8pYvATo6D3pGODJaNvNg1LVxiXiOrOjkgTQkKiRsjsy+V7RisAzT07aOipprxNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MHQpDBNs; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyvw84ebjMzW+Mwvi24YAYoN5gON9AItqmZbYjqq7TDSWrb6ARYSypibk2jqOLVoU9DJY0We7q6Mspvx7SXkRMgPqzNSB1r/Ooi7cxMVMDBZ1YQn0zu03AGBiQhFJ7dJXhgGH09H/yikbg5hbeg+jx7f4Zb+SdVXg87R6SCUKJiNok83/9UPRRj+sIS4KKjjDgFYHb4P5v5C7vcmzq2HM2eJBLk1eVtjXU+kWJiMVoNGvesqkUsmWoK48d+9VZCROJg1vaBJWrB7EmUyyh63ayBqxH6vIJmy6Z5rPXLFXW4W86LH1ytslH2AHI0mqG1FkgNjX8DmY89tqvjlw9WlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fkogIErvaZ5tKoHbKzIsByzGgJDB4F0coSdGJRqbts=;
 b=FVUxdWjsC3551O8JoYwiZESjRNupwE6CzWvn7kYnWqtT2opGgmzcSRcHmDO8jyKSpWzfg8b70Y5+y6lAtt66Y9mXlvzsoxHZj2jw7fZmGfqHsZGc65pdovLYdhAPI2lkpaXYZkGhnzlyFBK+elo80XRc09xiFtRZG1dyzy5QvRWILxPkuhfbe+hxwUSKLU5lL1pDiLsj4f41cMf/RSY+G25pmUb9nsuWhwPb0JONaoZpA2z0JW0rRsYh71FxlCV2QZraCIuYWyan02JqOg9+NrpaCph0QJe6nOmTyS7gf+8Cmx60TOnWfLVnHLY2UCr2bPLQXOvrpe5qIHFLMQECxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fkogIErvaZ5tKoHbKzIsByzGgJDB4F0coSdGJRqbts=;
 b=MHQpDBNsV/uULl5HDg67GaPjEJuUYYmNsv7Z0M5jqxGI/mHoJf3W6lJuQn9Ohiw/dgQjEatTi3VMDB3ztlbi2WxmDk7xL5jEWLQsYA+ZbFtGu0wqA+QQIC8qRWWxrAE91cBKMyJsZ4dDHFZXHAqI4Zo6vOyGsJIohNyV4bvYtlOR4KqXqF2A5krcEBSzQVCbLQdtwhpAGEcx8q5aBbkB6WsJTL3XlO4N2MtX1mdRCkfFLjbfLWCu6aA1pBUFXesw6dlasBVe3PIQVVO/nv2QZ38EU68RnDKwIIt8Sn/CtGxPGWwOQztKNH9RMAwX77cvEkCc6G8nGlwiqAK0/XBQ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 12:36:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 12:36:18 +0000
Date: Wed, 17 Jan 2024 08:36:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240117123618.GD734935@nvidia.com>
References: <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f63b2b-22b8-41ee-a4ee-08dc1758e770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ub3251XMuennYC6SiOAZfI2EjczAfFVFY5KrEW/xM08fJuq0SSe8slHvtYQiuYSyNHAVesRUNXmJGTQaFDSZWzo16NFRxnwuksBoEXNaT3vaZzFeRJzaDru7RF1LzsteFGRO71Wti4QKqYZt3T3Izs1Ohj9tmtBF/PAxAAW/8tHjgHYusjIS32zk35Xsf7kNxNQ3iGLeKIOkNKDJAWyNzCC1HBSfwpm2z90BrCwXBWvvdMSm5Z0CjdpOXeLYRK+8SAiq2yIfqJJ6T9S4J2CCbeGk5xMRGLF4AOwH4QWljz6Qv0EKwsj8HK1scMdN1MRLoiM8mpUihXXlQ1LQl1w0mfPaQ2Xpvh/Zv4TFz75vraX7ew1OZFI+G3JmoNI6PTQjcp5HA5ma+Kiv8iOOTNu+bCDU+Os5/NfzKh36eWt879iiZ8wyUGpeCTeW/g4UplheETzrLgdvZkAs9wFd95VPmvVB61/Jbo6bdbxTCYFAQyhpZowK+XAkAyWfhPrQ0D4/hqxxioljW9KoKI0KX8x9ACLonQZSMGy8R2+NSbVajtujeOSzfNFQ2gLuW/UxdS9FV4kPEr3YIONVVfoE02ixpl+MbwAwfvRneKmQiC6h/NrFCAkv7c7qQ+bislU3yzjS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(6506007)(26005)(2616005)(1076003)(38100700002)(33656002)(36756003)(86362001)(41300700001)(4326008)(6486002)(2906002)(5660300002)(83380400001)(7416002)(316002)(478600001)(66946007)(6916009)(66476007)(66556008)(8936002)(8676002)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Yk8NRryrP1KRDHvkuB3rD4HUpRk8GNWeV12v2XSGE0QcqkX865CRaIhpfOo?=
 =?us-ascii?Q?kxrhkcVbIvMvfzQQv3ZKAn3s8MB566C0cgvyU1RxrryyNtieJAxQ0LqfQlgX?=
 =?us-ascii?Q?lQXARSW7a0V9q+8bfBG2vOD7Hk7AYwMsqe0/ph0Dc04v3DigQDzHcYGYylgV?=
 =?us-ascii?Q?LmXzUt0r/5ZAG5y4IVwccdlzFSOLEzlyZgOwoIIAGNZ4sEyVy52k1Ye7IXoF?=
 =?us-ascii?Q?2Rb4jMOtpqZt5Mnbk13TxhRV8abvaJqQ/OtQwqhs4gZJCTxAh35D26XrMfzR?=
 =?us-ascii?Q?U2NNJQ5QWXJ4aOYNfagPfZiW7J7V9l4tCTPxXIt25teAn5SVmbWXdJSIQtA5?=
 =?us-ascii?Q?f62FAG1MGcS53qlgMToVXvn53rm+Exi3veo9F2xYmOlYf/DSrUALy3Jr89BO?=
 =?us-ascii?Q?q2u+rAkdH6ZWpu3q1fQnoEooBO1OngP0orBbYEnKYvybjcQYN5idCLbgvMTS?=
 =?us-ascii?Q?dEM23lk9c7eRXgWKJ4lZmplENsNy5HuTvBDx3WUnwEvbPPTVkNfcubUwmIvC?=
 =?us-ascii?Q?uCGOPmcplpFljcCoJ4M2dz6Y24CVDnXaNmQheNkAuRRHBZu9yc0mS8leK2vS?=
 =?us-ascii?Q?GJezjp2a0jbREAInAVfL3FwIHfCWxMZwVuAsudnzsPXWB1P1R41qr4dThHCc?=
 =?us-ascii?Q?CLpvBsPx0uccUMHw3oeERl0c39DYJlZ3EYLrzbnz07DA8r3QZS+hbioBmYjE?=
 =?us-ascii?Q?xPMX5TQcZpMRd8nnS0KVR21XYlotsW9gfYlHbWlBS+F5ZEmPcDbIt+sp3n9J?=
 =?us-ascii?Q?OukdlE0fuNq+fHIbXCLwkz27e67N6kTRJpHkxkvaro9jEFvxnUf2jvMwi3bq?=
 =?us-ascii?Q?OCi+e4Pq3GZ6Z0+eG9QkZAg3up74Lrh5/rbSDPcevtVONukd8S1A8P3hGlS2?=
 =?us-ascii?Q?29pLbl3ikVVpQB3md9Ff6qQtBCYh3CdUpDCR2yHlOSM6KV0sZDH291KmL7t8?=
 =?us-ascii?Q?Tludc6jbWcr+EgVwxr3rrn9VvdTDM7s/OjxqKe278DZeuKLpToXCb4XXCCxm?=
 =?us-ascii?Q?rZ//YPyt4OUYMSr6XMFfxdWExDo2Jduhf2cxWvEo5KHd4rAOa7R4ddjAuRwl?=
 =?us-ascii?Q?CoIc6tPT5KdYNoIB6wCXVSqvotQ73Ewp35h+PaoAh9CsoEyiR8i73YJJobt0?=
 =?us-ascii?Q?n4YCaK2D9bK50rMsIt9pdrZKCwh/p2CgV4W5m9biojMSoscatlzeh1gVLpLr?=
 =?us-ascii?Q?eKaqeTFCv42sT8/ZL9XMn+49mxtBW4CdgFiKKZL8VFRbmHxBtU+KV6daFUuQ?=
 =?us-ascii?Q?KV9vYhhP1NRSz5QAjlovT/WlESgTqcrSiI/5BKEwPcLGt5smoibhuwmGuLJV?=
 =?us-ascii?Q?z0uWAK7yG7l7OAFJK7aPpZmW0SW6lSvvjft2116jcPA24t0ElwNprrAGUfez?=
 =?us-ascii?Q?VwQf0mcCGlp2YtjPZMODR69no88RwcM5KgrToa9yZ2l57Qk9kwp5eWKbEUXn?=
 =?us-ascii?Q?y9ZN6OqqoC7LBM5GNtNA61TvxDVaFChqnpDLo44sICLbWC+5WwvhjKr1au08?=
 =?us-ascii?Q?BboxdXNVfoeA3M4fD4kYvTNnVOsIN3nuZvRwXrpTRaVWo/hE/uV3fXh6S1uA?=
 =?us-ascii?Q?JYlDzMXhFeTbpUrBzDh7RX+ME2FDc/IuXT/lYez4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f63b2b-22b8-41ee-a4ee-08dc1758e770
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:36:18.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocgZ2QK+ooycL737O24IoNeGMcDLUeBx/ByvC+xttyrXGOtMmZYEbvrS9dzDjlyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137

On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > Hey Catalin,
> > 
> > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > 
> > #define __raw_writeq __raw_writeq
> > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > {
> > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > }
> > 
> > Instead of
> > 
> > #define __raw_writeq __raw_writeq
> > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > {
> > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > }
> > 
> > ?? Like x86 has.
> 
> I believe this is for the same reason as doing so in all of our other IO
> accessors.
> 
> We've deliberately ensured that our IO accessors use a single base register
> with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> when reporting a stage-2 abort, which a hypervisor may use for
> emulating IO.

Wow, harming bare metal performace to accommodate imperfect emulation
sounds like a horrible reason :(

So what happens with this patch where IO is done with STP? Are you
going to tell me I can't do it because of this?

Jason

