Return-Path: <linux-arch+bounces-650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A9803CBB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884251F21273
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F32F84C;
	Mon,  4 Dec 2023 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqSuQiiE"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F51D2;
	Mon,  4 Dec 2023 10:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8EnppaaCDzp+6bsgGhEvnbahuF7onF/5Sfdz7EHvvp7YnhdWk4kjs7s1zwsFMWlsrmt3ZpYk4wyqHMqiMGOiBjcPSkdfAOKyhVYrhgW9qI2wgbnLvRUDWwcLDxsX7DOvTjQUyMrW/f/0sTXb0tEFY4+2ddnvOP6gRoc3nn9WpH2Oz87JQNgL3/qtUD2oDwpDNcoZqCAHBI1fa+CC2mGXncMqQja+2Mrl4AWJuHAXUcSMVOJN5tV3joJvzMKjPyOaxr5Y2yiVR3zBL8wY1GFxOPeP8Sbz0u/RrSZEpYmaeJQmO/XTF+eCHt9Q8HNV+JWm1ICaTcQhiCx/Rv6POd8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwHKL8gPgwUexhx3IdpKyoewR0Gf7jNHmT+LPsPRKjA=;
 b=gIo0emulyouLAw5wrTZiPB5L7NBkL2BbqKUdLS5XnXikDhxMKviBfNqfCHhhuLQw2PApXXYBoIzYLQ0c1xmuuDsmAt+J0EhMkIu0RorR9kwgIqHcVNvAZfeX5LacTQiqfXgd3fjEqsUF75S5MKhYI/zc1wnPVbOuLzZp+mpx+/+ft2yddSBnQLl9y2OSpFnHx/K3KDHhnRpP0A5joW4of373KfdaswPutogK0h3wZbH01s2+F7Naj+S3PHH3d2bXBPQxSNswVGClRPDk/BuCII8fK8um5MY8B6i8RuVYymZfgwACmV5DB3XKaS99r5TamK1Z4rriG0xVb1+nR+qC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwHKL8gPgwUexhx3IdpKyoewR0Gf7jNHmT+LPsPRKjA=;
 b=rqSuQiiExaRA+31r5IQRPEhG9TzOkhXYMhL6HWBYv1cjjUB6l/coEp8k8OdOYshhIDwPZyivdZtIFb6Xl2ogau7M7XJf8QWP2HUSvrWk6Wt3vSfCIFnX4x1ISbyCHmN0rELsO3FSXIhF/WSHSDY0E5PmXFO01FBSTA6werQR5CKw7HIP8LUOa4Ev89jquEiSmicrlybQ8RJikc8fsNYARvEQXiPbCVEwKD8OEBgrN0z2kpbtKADtJoU0FCwgDJirJqcRpOi+6LeR4gSpuq3SQ0eogsFiLXlSGJOqtH3U8xHfy5tY6IlDTbtOkiMM6iu8IGkALZWEt2aEl91Qt/cZ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 18:23:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 18:23:31 +0000
Date: Mon, 4 Dec 2023 14:23:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231204182330.GK1493156@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4NAzI_jvwoq8dL@arm.com>
X-ClientProxiedBy: BL1PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:256::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d715ec-8854-4736-0405-08dbf4f61e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1DCVlp4weC6qk9BenTtcHKkif1qYAWtujGTYj5wlmEpAHxBw25kDTRsBE4bsKsJQYXtLGeetm/q6lD/bDk5u1xRxsy/E4570oOwcODxuAt7NzkOn7ueCM5qkSAh5sfNbSGtRz0a7KPPY+qAJf86iMGmaBYVP+hAMvjiH3qBb2CNElzoiVfIksl3VA6kZFWSAzNPJ8NdR++0uL4MX/9Li+go845vvbJ27qjvl7yOgVCEEGOShk21OpeV0IAZ8H0TNC/LWEf0f8GKvLddYhRbDsk/7WLRyaxWZPFs6x8b2CJZrDvzrSiBWatECBRiFz3XIB/hLCd7oD27Lkq2c2jgE04u3/yGh4JGJcpHJAbTV++Q1irQwVQTrzfn2L61zymlw2IdcVXZ3vryVaEAv0cSNHx5QECa6/IgAbdNlvudrzQVuzNkmcw6D+TIHCR/wJXsV7u2lKDrU9fugNkomA//Z5qmSCdcy/6wNkPWcqqlb7nrOwsxnhOWLTF7jbbzkzI3RaU/0wow0phya6nAT7Zm1sjW9Ck13WKOEHbLu20w2V3tdnp5OlU25yTs3rqXrJUxO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(316002)(66476007)(6916009)(54906003)(66946007)(6486002)(478600001)(7416002)(5660300002)(36756003)(41300700001)(2906002)(33656002)(8676002)(8936002)(4326008)(86362001)(1076003)(83380400001)(2616005)(26005)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q95FVFVtwIZQKRT0GIHn7ZN8z0anmA18I734GPJsMQ9psSixmnf2Kk7MX4Be?=
 =?us-ascii?Q?BxmkP/U3I511dyhLPDXBoTzsEMK7WKEtSt30vm8zHjDZsENG05m3cNtrPB6G?=
 =?us-ascii?Q?XW6n+vODOwSG4Te98Ijf0nE/l/7WIPWHOlLjX6CHOCVO+CT1tSOkNbCjga6b?=
 =?us-ascii?Q?ERITPORyj4VdKGn4gdBBDBL5CZG6pZAUZqBYI2sf5P+Gjw1mS5TMAaUgkmOT?=
 =?us-ascii?Q?PYBDuUWAgWj7tVDu4Q5YYArXUuvQYpXlEZDs2hg9GQDhYCW9t7A8+ZqlW7KM?=
 =?us-ascii?Q?Sahj15kT55gZbxiFFFJBBabxm2FHnlxeoLfnMXh1hyFi22lb77w7hqG8whrs?=
 =?us-ascii?Q?0NQcZui90I0BqCcDZppkOQODcMf2etB7iIpierRgRQtSZ45U2Ejbwgt+f87M?=
 =?us-ascii?Q?BpPvmgKmDxyQxELTxLAqf1dk3xj4jSfWQd+dDnVOaQNYSwtaBtqJZYvNxB/v?=
 =?us-ascii?Q?+pWIlx/rzLGnxhIAmdg7zZd2r0G6xin544N4znd0jpn6+uaPoLb7hGlIlm21?=
 =?us-ascii?Q?mbFbyzpP2OfkLqcEpeTAy2yWFE6lKyFfBTMFq/DLrPhFeNpeSErCXGpyyyDJ?=
 =?us-ascii?Q?1iKi7nvfLr43eVla/q3ShTfzuvrVYjI3m9/h+LCX1zYq2Duqe2w21RH3Vzej?=
 =?us-ascii?Q?++FZijDaIsAJqgpv6Q5yX2Bp7FJg8IWo+cEkvuyznI0FrWB2Shcub9wd7wSV?=
 =?us-ascii?Q?r57azmBeIDwJnrgtRr7r57PvbUtvl11fZmT+rCstPIZ8AhKuoK53b9Pi5mjN?=
 =?us-ascii?Q?SSg4v7M1f5NxIGmbcZdqwT7O+lUcXvUL8l+NZv+ugNDKUGIS2zHVvoG7mXe5?=
 =?us-ascii?Q?mjwURZOdAyQwW2IrA/P7yy35LlnP3YgeoK3/673L6hjZ4LwW055CkhMbCOt8?=
 =?us-ascii?Q?NKrR5QRGUK7w59lZ6K9Dvz1E11glUJW9kW9lVfzVmMcIG+7YhiOY23wcTnmv?=
 =?us-ascii?Q?0dyf8hsIlYlBbA3j2nReOxEmIOiPFenucPO8ysRqqnvUze2QzHVHXwTndu53?=
 =?us-ascii?Q?4xkKazNGab68imF3J89iYFzEurOK1Jjsj4nCa1C0i9IyGvOHGRpzgrbZ15aY?=
 =?us-ascii?Q?Pg8+7ofaAxHQDzebifL6/LZLLoWkrdOE/RXPXZK5BlKxSCj+/gghyj1MpA9/?=
 =?us-ascii?Q?7s9mMU0wvJ3yEXHgRxMAroSs/pNHy/SMGpfJS6kdScyVKvrw6Q62H/w3djWN?=
 =?us-ascii?Q?Ke9DcHGHKdTJiiqnE5MSb2YblOONvijFqMA6lK/23gW/7nPHwCB2N3GGkNx2?=
 =?us-ascii?Q?nnBUhjz2g3oaINo6/SQLyhjZKHBveWts2b23eV3ZGVL2QCIM1wT331EWa7V3?=
 =?us-ascii?Q?InuBfnp/LTYZjvLqzrAz0VrXYkIbN3dxtTzwsxD6Vx6zVvFzwrkw4BCjC5zu?=
 =?us-ascii?Q?B/0u8q2fPlYCKwzsZZCAzjT4sCld35LrmY0TS4zy8V4zfN3fPuVOVbYiPg1Y?=
 =?us-ascii?Q?PcESP2ohFllYB3EnKZN5AN9sj/78ie1HWGAOD+/qHyqlK1Dg5oYHA8+pT1xA?=
 =?us-ascii?Q?SsI1Bv/Ac52IjvSo+ZJRiScyzSO8rJxTnVQ5wskMfzAXvp5xBJ295qu5mdxd?=
 =?us-ascii?Q?QRvMDLaukGMNOJVO2CHtDQnf9U7LQ3uPEuD7vXRn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d715ec-8854-4736-0405-08dbf4f61e6a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:23:31.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzAxsFBjRGy4E2ONC43rMPdN24UU2tEtT/CTIgGFsiHR423uQCcBmPs+465utFiM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On Mon, Dec 04, 2023 at 05:31:47PM +0000, Catalin Marinas wrote:
> On Mon, Nov 27, 2023 at 09:45:05AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 27, 2023 at 12:42:41PM +0000, Catalin Marinas wrote:
> > > > > What's the actual requirement here? Is this just for performance?
> > > > 
> > > > Yes, just performance.
> > > 
> > > Do you have any rough numbers (percentage)? It's highly
> > > microarchitecture-dependent until we get the ST64B instruction.
> > 
> > The current C code is an open coded store loop. The kernel does 250
> > tries and measures if any one of them succeeds to combine.
> > 
> > On x86, and older ARM cores we see that 100% of the time at least 1 in
> > 250 tries succeeds.
> > 
> > With the new CPU cores we see more like 9 out of 10 time there are 0
> > in 250 tries that succeed. Ie we can go thousands of times without
> > seeing any successful WC combine.
> > 
> > The STP block brings it back to 100% of the time 1 in 250 succeed.
> 
> That's a bit confusing to me: 1 in 250 succeeding is still pretty rare.
> But I guess what your benchmark says is that at least 1 succeeded to
> write-combine and it might as well be all 250 tries. It's more
> interesting to see if there's actual performance gain in real-world
> traffic, not just some artificial benchmark (I may have misunderstood
> your numbers above).

Yes, I just don't have better data available to say that 250/250
succeeded, but we expect that is the case.

We have now something like 20 years experiance with write combining
performance on x86 systems. It brings real world gains in real word
HPC applications.

Indeed, the reason this even came up was because one of our existing
applications was performing unexpectedly badly on these ARM64 servers.

We even have data showing that having the CPU do all the write
combining steps and then fail to get writecombining is notably slower
than just assuming no write combining. It is why we go through the
trouble to test the physical HW.

> > However, in userspace we have long been using ST4 to create a
> > single-instruction 64 byte store on ARM64. As far as I know this is
> > highly reliable. I don't have direct data on the STP configuration.
> 
> Personally I'd optimise the mempcy_toio() arm64 implementation to do
> STPs if the alignment is right (like we do for classic memcpy()).
> There's a slight overhead for alignment checking but I suspect it would
> be lost as long as you can get the write-combining. Not sure whether the
> interspersed reads in memcpy_toio() would somehow prevent the
> write-combining.

I understand on these new CPUs anything other than a block of
contiguous STPs is risky to break the WC. I was told we should not
have any loads between them.

So we can't just update memcpy_toio to optimize a 128 bit store
variant like memcpy might. We actually need a special case just for 64
byte.

IMHO it does not look good as the chance any existing callers can use
this optmized 64B path is probably small, but everyone has to pay the
costs to check for it.

I also would not do this on x86 - Pathscale apparently decided the
needed special __iowrite*_copy() things to actually make this work on
xome x86 systems - I'm very leary to change x86 stuff away from the 64
bit copy loopw we know works already on x86.

IMHO encoding the alignment expectation in the API is best, especially
since this is typically a performance path.

> A memcpy_toio_64() can use the new ST64B instruction if available or
> fall back to memcpy_toio() on arm64. It should also have the DGH
> instruction (io_stop_wc()) but only if falling back to classic
> memcpy_toio(). We don't need DGH with ST64B.

I'm told it is problematic, something about ST64B not working with
NORMAL_NC.

We could fold the DGH into the helper though. IHMO I'd like to see how
ST64B actually gets implemented before doing that. If the note about
the NORMAL_NC is true then we need a lot more infrastructure to
actually use it.

Also in a future ST64B world we are going to see HW start relying on
large TLPs, not just being an optional performance win. To my mind it
makes more sense that there is an API that guarantees a large TLP or
oops. We really don't want an automatic fallback to memcpy.

Jason

