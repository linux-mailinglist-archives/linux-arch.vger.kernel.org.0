Return-Path: <linux-arch+bounces-1524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DA83B243
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE161F238FF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91147132C0D;
	Wed, 24 Jan 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwi3OVoS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2F131755;
	Wed, 24 Jan 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124400; cv=fail; b=aVER2tH4F+19dGh6OnXupG5Fxk66tmkhCCD4N/tC9/FYGphi54ogQAAMemNUVT9D2F5YaMkTcHp4X/xDiG5EoR5IpxQgU07Hk1sVD0EoRDn78P+QyedzfUlquUg4Z41rBiRx3bjmU8zfcRpRou35PFEU4qWRfbu7FRUtZvw8qgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124400; c=relaxed/simple;
	bh=XuNvkOy5iTUuHIlP9vAPlw5o1XpaVkEZPxVnj3LURY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYQrDuf9AXwUYMrSebqIm149UK9o74+vb44jPrtSIIP4MixC+UhBIgKnOo1w8NOeuHRVwd3US3qeCbx4TvnF7zoPhbKl4ev9OSctAxB5qf3YUWgEApK8dKtlDGXZUahsaRXyTIxC1fYlcfo/mEaprPfy5/yRK7DE4/7XZew4OE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwi3OVoS; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aReAtsp7Rm8+FvB4q38jajFw6gbAPZMssr+ypIEbn1z+CfKcTys0LDOrVxKj9eaWjXpjc28h5irT+StT7DOcO2nJ/8r0D5m47I/O7GGZYI8+DSFYzP6+A8vzV9JDNwN1XyBKYK3E6Pm0S+wkUftEzxT3pOEShr4B4EM8ZxNjm/vC5ow1oaYyzX301AHXTlUd0rBqzN4TS7VBgAE3bqeI0DKFuQjvXSGOPJhGkw7Ppiu3A2TKg666Ucl+THwyrmkJTxyvHzrwVuisCPrKyKJ4SAe301ArfYTg32gDJSktqTmPYORHI6a4AY43iXYsbGogwVwwqEMN9k1BEEmcgND4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTWGVMtQ6LVFosCF9oDG9sRYV5ePMC2wfmztTsiIjTU=;
 b=IeLtnYinCIIqMU8p97TCDjObYJ+MPMjb8zs9v9vIz/ydYV3Y1X8CkEXuifkb65uQrbdD70LfKqxiZrvSl+7EJwsxIJgd0b0BKUs+18QyV2paYVFK4AyfHmKHawm7jnohDUQcUR3ykwsdfK9p2szL/6Zbwvc5vEX5uip3Ii1zivQE+xULrGekEXhn88Zq8K7v6Us9AyVo8Ou+B0Twnr2/hc/aTnrE4lPeUQMXEYIrl5kUIUaYUZJg81ymdS9ibqzJzUBEJDp4OLLP7cI+Oaxnsg65W+8GCe0YyIIFCeAguQBKvvLpuo0sqOKipPVBZ++gsN2UMXa0HEz9uW6V6jQyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTWGVMtQ6LVFosCF9oDG9sRYV5ePMC2wfmztTsiIjTU=;
 b=lwi3OVoSoM/0ak1C2PQ9W8JdS6gQpJkubGHJUj4MCEXHZ41MQ8uMcUIYEB3uCIneEbDaS6CyvLB/fgUnKCEoPU60gSj/NQqdbhbQFFqatgMca7Pjk1fcif68kzwfwFzD+peiVb7n1yDn5rT9IZbEj3BPF95CiAcTnxb2RGXDq0zmKUiSd708y2AiPK0SV/9DctM6lHdzkJRCNM5D60oBeysaKcBmzfevDoUik1tHIyV/YJz1xIbBVi/0rfuvLKztgIUxWxi08NE0EYTcNd+ZPknvJjTHd44Zbhlbjt6BpfdXrTBYmJ/0YXjlGVeho6I3kpXvXFwebjaoZSsjX9tlxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 19:26:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 19:26:35 +0000
Date: Wed, 24 Jan 2024 15:26:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240124192634.GJ1455070@nvidia.com>
References: <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
 <20240124132719.GF1455070@nvidia.com>
 <ZbFHPTUaBmbHYnwx@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFHPTUaBmbHYnwx@arm.com>
X-ClientProxiedBy: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 725abe3f-e0dd-49c0-7afc-08dc1d12610b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6928DowHpeC5V6twb7n1F5vUGyDM3RluQeQZH0uLblmIE7nhWofg5yR+ZxeMkwDkV5g7pGZ1t8ABPwTocUQRVo6nyVTG91A36DOEV5F6GDZjMbE8B3/2mflG/FioiVb32EgdhSw4Vy8jebFC1TcFMqiSyXY2aIDVrhOgms9AqJ/esSpHl+RQD4G8KqeB92oUY6kf3WW3hnO09f+CO3I6gOlwOP4AD5Oc+J7/9oA2qyY5tKlazQN8LZ/NluDmPDlBP86mxEgnlX7Akl8MUJzLg34BzLm1DzbN0uhaP382LIFj4jq14ZGk7ikDTxr0yJv/LQbPxoGSsrGI00/fgQdkiowAoOukQBUJmVyEs4F92LaLSzZJgxuVww2qkfl+/YCJe4I/Or8RcHD7GlsSa52FSrXHCRijKMKYgsLbcRmO+THB27hyV4h0WiAr8YyVvWLkCEntmbPhP0hGPZYwnJi8x7NEMRamkN/3d9y4nvmxKakFIpTLecXv4NOoke0RstB93LvYS8JEskEzoXDXzljOD00alrFc0zxbLYKGzi/5mYAVfub857caOxYTZfd+mTS0BxnPt9ARcETtqJ12p7Ic9+vEdXZASHAu9dakKtPzjrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(1076003)(2616005)(83380400001)(478600001)(6512007)(966005)(4326008)(6506007)(316002)(41300700001)(36756003)(5660300002)(8676002)(66476007)(66556008)(6916009)(54906003)(86362001)(2906002)(38100700002)(6486002)(33656002)(7416002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Al5D6HZPeT3jVJxYSS5NjIBX/obqmhvbkyOGYUr/VQihjMwASICC9tcMcjEN?=
 =?us-ascii?Q?8tlZdSu67esGFTjja9rnMWicfMA8e5ZDglZjqzBBXKh2k4Ug9Pqnng7Hq6Kt?=
 =?us-ascii?Q?VGz5+50h2CKk1cHKSIYfW1gJrqRFsNPBd8cpUPFvYUx3qP+E/XtItnShj2eL?=
 =?us-ascii?Q?bdQmqRMkasS9b6yGPoHgQXPWTNfRLjjySKolRmUyyUXFvLkiWJ5TmS1QSRup?=
 =?us-ascii?Q?ZPr0kahCSOuxNvYQSCWN7DH5iGomRn3ryPZOaIsySya8eQTLr6xkM8gUF7qI?=
 =?us-ascii?Q?cbf+5PaSgiTBa9z5ns8ZkGBvL7VIChhKRjyGHnRXL/UuvAc+t4MTINfu3tnq?=
 =?us-ascii?Q?4U6Bnf4WNkvxR26UjOV3EAvoOUF3+U1Rmz2O9SnVZcXLiBAcoW82MgSArCs6?=
 =?us-ascii?Q?uMbxvIjoIVHJ4IU1/AeI5mmPf2zGiB31GlS9AJYZmIbX6ZCtGR/C7ZLMScuM?=
 =?us-ascii?Q?G6Z5u5fjae5N+KW1pBy91XheqMeg4j7LjnqHi0pZBt7ofSL9MldmMmdPOb+r?=
 =?us-ascii?Q?puNXu8cZwkThtKFnLkooZwyumeJpkTNQ5y4FFwLS2fWBGNSROF6maXBxuTZL?=
 =?us-ascii?Q?EHEypkt4sx/lOp5TkMmcIB8vipM5z5dxAk1YGSHEM5CHLGM3XNS8gjY4VxGG?=
 =?us-ascii?Q?kJPvRcjqxJI3RarCl3B629VhfSyhzn5GM//zwZx7mNE2inzFD+sdgAkzvWc0?=
 =?us-ascii?Q?1e4XvST6vHIBNy9eWjiAyPs6Chw0wm/nXuzYwgVdOT2bFIVNiSCW++uosKH/?=
 =?us-ascii?Q?z2i00B0lSII0wI9G/dlKBI8Z/jOampicp4IP0miMVoC2IUtxnOU3VgHNUQZR?=
 =?us-ascii?Q?AVM1jO+NJ+64595fu0YloXGuAxHxYmg+X205PazZqUXw8/kpGM4/dyy/Dg8N?=
 =?us-ascii?Q?Ebs5HijoqrDib98ql9XEiGekauUEOzefTvjTEWcsKPqUaj+FM5FkMbrLQWB7?=
 =?us-ascii?Q?1e7uLpzVLRVDSZ/mLS9dF/F5sWTkPYtP/6fF4zb80oh+Xc4mHmcs0YdXXvIM?=
 =?us-ascii?Q?1SqBqlsjZ9Nu3wEiO2EmUo6EU5c4PhaqbxLMiMHCAeGCYbUUWsE0GbcUyzQC?=
 =?us-ascii?Q?KlZShQ0MLJlNso2veHdNyChF8I/pquyKhCWv2XniDjwMjDI+1mIwzNOHw3Mn?=
 =?us-ascii?Q?00Y3LXnSUrhAE3D3ogV51dDEiSyziaB0Vj2UNKNUABC9ZDtsWJ7SFLxAZx+i?=
 =?us-ascii?Q?hSjyBpiLsQf/hr3adXo2cxUdiFMu4KrNBkwLR01UdpY9762UgjXYbRbze3QC?=
 =?us-ascii?Q?TD5xXj1TCSHSctcPJPx7xmSMCBeg4xoF+XQWTbg89oxm6SjIr+tg29It7YPR?=
 =?us-ascii?Q?TKIyw002hTerchImnicnp+g6797k7TSqg3V+SfwmAgpr9oxC5zv6SHqpRww/?=
 =?us-ascii?Q?W0X+G+5GNiRgaPtlSV/sLQIgcfi7WeCnyV3HKgUpQK+DqH3vDiqo6qwcu9Je?=
 =?us-ascii?Q?S708JoX5HLbbpVz8DBiWZO3MLS7JGPLeEc9XzBm2llZYInaJIDEdoNQMOtYQ?=
 =?us-ascii?Q?MWz+LHhZc2woAJ63zpuR5fJ6K4oCUvWlwh5RNpPwhFs5/lH7MmpNljoGWwey?=
 =?us-ascii?Q?jx1XKR2rAVRRW6V6Hq0BbOBOHg2ouv/CG4aO7k26?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725abe3f-e0dd-49c0-7afc-08dc1d12610b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 19:26:35.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFOVd7aUYn+yf6r9ri2JO3qyA+kuaY5HvWMvpRWEXO/jtVsvO0hcqyM3iWuRNP5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

On Wed, Jan 24, 2024 at 05:22:05PM +0000, Catalin Marinas wrote:
> On Wed, Jan 24, 2024 at 09:27:19AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 24, 2024 at 12:40:29PM +0000, Catalin Marinas wrote:
> > 
> > > > Just to be clear, that means we should drop this patch ("arm64/io: add
> > > > memcpy_toio_64") for now, right?
> > > 
> > > In its current form yes, but that doesn't mean that memcpy_toio_64()
> > > cannot be reworked differently.
> > 
> > I gave up on touching memcpy_toio_64(), it doesn't work very well
> > because of the weak alignment
> > 
> > Instead I followed your suggestion to fix __iowrite64_copy()
> 
> I forgot the details. Was it to introduce an __iowrite512_copy()
> function or to simply use __iowrite64_copy() with a count of 8?

Count of 8

> Just invoking __iowrite64_copy() with a count of 8 wouldn't work well
> even if we have the writeq generating STR with an offset (well, it also
> increments the pointers, so I don't think Mark's optimisation would
> help). The copy implies loads and these would be interleaved with stores
> and potentially get in the way of write combining. An
> __iowrite512_copy() or maybe even an optimised __iowrite64_copy() for
> count 8 could do the loads first followed by the stores. You can use a
> special path in __iowrite64_copy() with __builtin_contant_p().

I did exactly the latter like this:

static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
						 const u64 *from, size_t count)
{
	switch (count) {
	case 8:
		asm volatile("stp %x0, %x1, [%8, #16 * 0]\n"
			     "stp %x2, %x3, [%8, #16 * 1]\n"
			     "stp %x4, %x5, [%8, #16 * 2]\n"
			     "stp %x6, %x7, [%8, #16 * 3]\n"
			     :
			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
		break;
	case 4:
		asm volatile("stp %x0, %x1, [%4, #16 * 0]\n"
			     "stp %x2, %x3, [%4, #16 * 1]\n"
			     :
			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
			       "rZ"(from[3]), "r"(to));
		break;
	case 2:
		asm volatile("stp %x0, %x1, [%2, #16 * 0]\n"
			     :
			     : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
		break;
	case 1:
		__raw_writeq(*from, to);
		break;
	default:
		BUILD_BUG();
	}
}

void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count);

static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
					  size_t count)
{
	if (count == 8 || count == 4 || count == 2 || count == 1) {
		__const_memcpy_toio_aligned64(to, from, count);
		dgh();
	} else {
		__iowrite64_copy_full(to, from, count);
	}
}

#define __iowrite64_copy(to, from, count)                  \
	(__builtin_constant_p(count) ?                     \
		 __const_iowrite64_copy(to, from, count) : \
		 __iowrite64_copy_full(to, from, count))

And the out of line __iowrite64_copy_full() generates good
assembly that loops 8/4/2/1 sized blocks.

I was going to send it out yesterday but am waiting for some
conclusion on the STP.

https://github.com/jgunthorpe/linux/commits/mlx5_wc/

> void __iowrite64_copy(void __iomem *to, const void *from,
> 		      size_t count)
> {
> 	u64 __iomem *dst = to;
> 	const u64 *src = from;
> 	const u64 *end = src + count;
> 
> 	/*
> 	 * Try a 64-byte write, the CPUs tend to write-combine them.
> 	 */
> 	if (__builtin_contant_p(count) && count == 8) {
> 		__raw_writeq(*src, dst);
> 		__raw_writeq(*(src + 1), dst + 1);
> 		__raw_writeq(*(src + 2), dst + 2);
> 		__raw_writeq(*(src + 3), dst + 3);
> 		__raw_writeq(*(src + 4), dst + 4);
> 		__raw_writeq(*(src + 5), dst + 5);
> 		__raw_writeq(*(src + 6), dst + 6);
> 		__raw_writeq(*(src + 7), dst + 7);
> 		return;
> 	}

I already looked at this, clang with the "Qo" constraint does:

ffffffc08086e6ec:       f9400029        ldr     x9, [x1]
ffffffc08086e6f0:       91002008        add     x8, x0, #0x8
ffffffc08086e6f4:       f9000009        str     x9, [x0]
ffffffc08086e6f8:       f9400429        ldr     x9, [x1, #8]
ffffffc08086e6fc:       f9000109        str     x9, [x8]
ffffffc08086e700:       91004008        add     x8, x0, #0x10
ffffffc08086e704:       f9400829        ldr     x9, [x1, #16]
ffffffc08086e708:       f9000109        str     x9, [x8]
ffffffc08086e70c:       91006008        add     x8, x0, #0x18
ffffffc08086e710:       f9400c29        ldr     x9, [x1, #24]
ffffffc08086e714:       f9000109        str     x9, [x8]
ffffffc08086e718:       91008008        add     x8, x0, #0x20
ffffffc08086e71c:       f9401029        ldr     x9, [x1, #32]
ffffffc08086e720:       f9000109        str     x9, [x8]
ffffffc08086e724:       9100a008        add     x8, x0, #0x28
ffffffc08086e728:       f9401429        ldr     x9, [x1, #40]
ffffffc08086e72c:       f9000109        str     x9, [x8]
ffffffc08086e730:       9100c008        add     x8, x0, #0x30
ffffffc08086e734:       f9401829        ldr     x9, [x1, #48]
ffffffc08086e738:       f9000109        str     x9, [x8]
ffffffc08086e73c:       f9401c28        ldr     x8, [x1, #56]
ffffffc08086e740:       9100e009        add     x9, x0, #0x38
ffffffc08086e744:       f9000128        str     x8, [x9]

Which is not good. Gcc is a better, but not perfect.

> What we don't have is inlining of __iowrite64_copy() but if we need that
> we can move away from a weak symbol to a static inline.

Yes I did this as well. It helps s390 and x86 nicely too.

> Give this a go and see if it you get write-combining in your hardware.
> If the loads interleaves with stores get in the way, maybe we can resort
> to inline asm.

For reference the actual assembly (see post_send_nop()) that fails is:

   13534:       d503201f        nop
   13538:       93407ea1        sxtw    x1, w21
   1353c:       f100403f        cmp     x1, #0x10
   13540:       54000488        b.hi    135d0 <post_send_nop.isra.0+0x260>  // b.pmore
   13544:       a9408a63        ldp     x3, x2, [x19, #8]
   13548:       f84086c4        ldr     x4, [x22], #8
   1354c:       f9400042        ldr     x2, [x2]
   13550:       8b030283        add     x3, x20, x3
   13554:       8b030042        add     x2, x2, x3
   13558:       f9000044        str     x4, [x2]
   1355c:       91002294        add     x20, x20, #0x8
   13560:       11000ab5        add     w21, w21, #0x2
   13564:       f101029f        cmp     x20, #0x40
   13568:       54fffe81        b.ne    13538 <post_send_nop.isra.0+0x1c8>  // b.any
   1356c:       d50320df        hint    #0x6

Not very good code the compiler wrote (the main issue is that it
reloads the dest pointer every iteration), but still, all those loads
are coming from memory that was recently touched so should be in-cache
most of the time. So it isn't like we are sitting around waiting for a
lengthy dcache fill and timing out the WC buffer.

However, it is 136 instructions, so it feels like the issue may be the
write combining buffer auto-flushes in less. Maybe it auto-flushes
after 128/64/32/16/8 cycles now. I know there has been a tension to
reduce WC latency vs maximum aggregation.

The suggestion that it should not have any interleaving instructions
and use STP came from our CPU architecture team.

The assembly I have been able to get tested from this series that did
works is this:

ffffffc08086ec84:       d5033e9f        dsb     st
ffffffc08086ec88:       f941de6b        ldr     x11, [x19, #952]
ffffffc08086ec8c:       f941da6c        ldr     x12, [x19, #944]
ffffffc08086ec90:       f940016b        ldr     x11, [x11]
ffffffc08086ec94:       8b0c016b        add     x11, x11, x12
ffffffc08086ec98:       a9002969        stp     x9, x10, [x11]
ffffffc08086ec9c:       a9012168        stp     x8, x8, [x11, #16]
ffffffc08086eca0:       a9022168        stp     x8, x8, [x11, #32]
ffffffc08086eca4:       a9032168        stp     x8, x8, [x11, #48]
ffffffc08086eca8:       d50320df        hint    #0x6

The revised __iowrite64_copy() version also creates this assembly.

The ST4 based thing in userspace also works.

Remember there are two related topics here.. mlx5 would like high
frequency of large TLP generation, but doesn't care about raw
performance. If the 24 instructions clang generates does that then
great.

hns/broadcom/others need the large TLP and care about performance. In
that case the stp block is the best we can do in the kernel as st4 is
off the table.

I would like the architecture code to do a good job for performance
since it is a generic API for all drivers.

Regarding the 8x STR option, I have to get that tested.

Jason

