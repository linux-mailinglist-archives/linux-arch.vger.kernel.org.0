Return-Path: <linux-arch+bounces-1521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD983ADCB
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6878B1C249B3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1A7C0B3;
	Wed, 24 Jan 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PG/k5MNo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638877A704;
	Wed, 24 Jan 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111560; cv=fail; b=J/IFpkPjIkXxNSVj6o17Wx8hyejSlgTOg7wfjWx2Kyfq8Kps0qgEOg0m2LUUmj3oWW1Y4spEdvb3CcaCz3ieO5VjjMNZIPZshtiMIc9bBAj4FRSiyLxCMqD62WszfwzmpKYmIvSpxKYn/6zK3HmhP7aS8i6Qmj7HHK3K2lFF2DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111560; c=relaxed/simple;
	bh=6Y23doozzdyuRAUbFIiZOWGerp8ILwz7UClRZe0Oqhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfCMuDXQ3kCYwzPQevjlraaLXFntThMcv2F54vKZQ1meG1zatQFIgneD+T1sScgN6bn3Vpoo5GDNqFmnky9a2Cf5fxGfaw58w3iSUozjTGukA/G7ClJO1/GJPUjWF9mDnpifvVZjdvK5b5PIY5GtzkRPNMt7lat1RHrdy05EMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PG/k5MNo; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmAoHpBlSz64iiNUwiE+J7YylNJsUiNPqg7VYMHOjuH97tfTF+rAi70Z1Z4weuwUxjlRvny5etxamod6eBCzUHFQAYXZ9p3Xeg4unVTAwYXds+xGpYIJ2RoCdVDo/kjEHE12xab6wsjvA4wtOVj0ZccCMt2xwj21KY5tcMPO/aIEc0Ip9wRUELfX2QGtm9i0zl0YaLDnsxfeA1NJR1Ungiu9NbCBSRXU5YHLBUN6JjpMvFOi3IrisU6GioMcMAZsHGt+pwj99N8tMn0H6VDyiovDe6iik/TFcZRRvnZRlLL9tIpZ2gIsU8DjtTdp4FA8zPI6VjYoWte/MKFDr+NS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk9/yBEYbEVYXpf/saEDBaYqmcA/4ORBO42nLiS/FaY=;
 b=LK2hayvWMP4clSvQqlqj6B9ziEiUYWD/vY7EuEfI6w/RjtLjq+WrpxM1v1mkJXoZBrfV1wWUGeVM+GJfCNQiGtWVA6gXjEMncuSP2L/wmQKG+PmX0YOPn6k5OKpgG7qX6kZHs9WARpqcofwKcsHPyuacdJn/iiWqj5ueBcpeB2XiZrG81qMZex34iEvvlhL6sjqJ0EKHKSP+yt77ra1OeglSKilPgL1DgoXWCrYulLGkBBER2r4c0MrarjLR+f8YzGOml8nfZyz6doJr0Fc3WT0h6lvJwC6hSERXCXMRBXeR8dMdH23thMn2+NDPfzEb20x/Y2++UfcHKS0abOwGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk9/yBEYbEVYXpf/saEDBaYqmcA/4ORBO42nLiS/FaY=;
 b=PG/k5MNoHKeALLHLsUOlxBLxlLewM9A1geqKFUGHl/Q16HRd6lQnUDM0isCfU9VB9J+v9elBKUQHtCDsMI1MfdcG5UUxOTrI86rj5S84VSsR3OAoIsk7hbjQLvzfdeg142FSUbc6MR9lADjHbHmlLScGBK3BZf639EZXQc86I1BucvOPiK6IWU90h6mAQIPNWcm1NaabGK7J+EA78dAN6nWLegaAYFaeXgOfN9ykUHOyL63MODv1vFP1B7MUPjwkANdrDjeRsHj6WD2nJqbX2iTW9J9W3QWDvNXdh3cophT2ozxXpnalqAB9vahjsSTiRwKse8R88eweFwUpW4sQCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 15:52:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:52:26 +0000
Date: Wed, 24 Jan 2024 11:52:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240124155225.GG1455070@nvidia.com>
References: <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
 <20240124130638.GE1455070@nvidia.com>
 <86bk9a97rt.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bk9a97rt.wl-maz@kernel.org>
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3b3cc5-c4cf-4a9f-ceb9-08dc1cf47684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wpfAd3yS4348opJ09wzxUYp6LqjV3U7u7+VT4orM/f5Wsts96DPJAJuvMzq4qfqbQ5PRnKHBvhmkaqn3zaZkO2B0wkel4J1nlv0tpjcyoem+7FOZY+ChTMh2d4vht+FJcP/3E2YYCya08B0wIJwbnSQeYPMrnrWELMNeWC2qyGtFUl2XFGTHN/nCHlMs7XatqnOHKriNBF7X35Tygw6MfhGNLokIMljfTyNhg4ZBSKCAgm7NBqUv2sZWCpyUOouwYK3c54bFGPHoDaDt3ZK7pEp5Ijb0Jfv56dCUKX5dmA6EqjEuGwy7kwrkUIjxoYewuK6kd3e5rfyyFv/1qq0NRhlWiNAc7M1tPIqtS/5fxW/Zpss2KEKZHy+5/xzLCSLt3H4Ry7YkzEPcUz3hPbU/fM/bn+BU64KsfH4QzWovrVnd/hiRR+9jNacVKhCSDU416FJ20oYotjaLPE5dqFDUPqX1bU7j+IYLCjfGQYXDT/90MgoXVVWnGWj/3wHuyomHhN0xzifyNF7kDXXMB95W93KdRktCGzkat5gchsNJc9Q+BYLPtSdoEdPRqmgYEX4+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(36756003)(86362001)(33656002)(38100700002)(66946007)(41300700001)(1076003)(6512007)(26005)(6506007)(478600001)(316002)(54906003)(6916009)(66556008)(66476007)(2906002)(7416002)(5660300002)(4326008)(6486002)(8676002)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWXGXv2vCPqGmO2iSd7NLpXDUeAl9rL2hBDHlDtHL1PTgl8uH/vs/9xvhHZZ?=
 =?us-ascii?Q?XwoweYD6rFyxYtr+ZmgM1UYmtsPb9hVxDfecZHZUh/etMJMO+MEKCZiPVrmt?=
 =?us-ascii?Q?X8WcA889xOWAYPrpk6y/J3uiPiqyhD/WtjeFwSwgxNV3rHSXHFmJaQQ6MWh0?=
 =?us-ascii?Q?+vGQ4J+L8iCGTckqBfuPVPY697GOrkEWUCc93mupigE68fwHavDTzhwQFtRG?=
 =?us-ascii?Q?Ckx2mVZAxZb8EWzUR2yEsKCWOIcM1d6k8nO8/BXZMtogJ5NNriKbWjadgPe5?=
 =?us-ascii?Q?187a3ghhxEy+fzN3+awJuCStF5gs1ut7Bwvq/m9dfiicdm8EB/MBr6IL8twW?=
 =?us-ascii?Q?QZ83jX21AHGyRbrKWr7RheeFrp/C+lza8FF+0CoD4HV9OQstQgyHMIjX9Wtw?=
 =?us-ascii?Q?NzX464zdHRMi72l6EDPMu3oJv7bqVd3+ka3pzfLZh7RxaF/SPWNBwidIY7eD?=
 =?us-ascii?Q?OtHZpTNvqPNNrGCwXWBdI58Di21bTCR4KUHOfYYdkm+F9itRJ/Fq1imXDKu9?=
 =?us-ascii?Q?JPOuPPRMjdd/8KYL7boxukqgRnVv0l4jLkIZBaymsnXHjCoTVJesx8niQfhK?=
 =?us-ascii?Q?v+4LgkdQrxmJP7Iv0oBgShFfxiUvDXCv1nbYhqueUV+LiA3wxjxXjZ0xaGGS?=
 =?us-ascii?Q?IkBrXfY0itT1/bQEw0JI3XQs2dLjq++Q+xIRpGysaidlItM9C/iTKZ13yFeF?=
 =?us-ascii?Q?hZzkrdOGmH/5ELfdARzfuBnUtelhFfXjlAdWjIw6jGXCTfytAixLL97eAeEc?=
 =?us-ascii?Q?DfG9WYpqZOm4C+qHPj/xJCo2zdSWvj87gjYZsm08c4oTWIj6uETYhqmI9gA8?=
 =?us-ascii?Q?NaEt1rBkPO9Enn69gJlEfJsKPwDG+DX/JLLN3M7hPVj5wh3k0douZ7U8kHyv?=
 =?us-ascii?Q?LXvYwDmTHM16DtrTcTr/Cd1RorunvzR/l1OaMxA0A392sGO4vSwwL1WPrYmj?=
 =?us-ascii?Q?cXhHHHzwbXDpd/MBFw+JSxrTI2sKWYFPFcsoAefznF9154U/LSFU5F1eUBJJ?=
 =?us-ascii?Q?hyjHPzfWRYPMpXEN84qs5wdWM5r9+BFCy9xyzuuMnz7DXHsPNAqLyzlxrPgG?=
 =?us-ascii?Q?Jv8JxRsXPNkOr8e+ZP1wa3TTgHQzjbEze2nB8EKYHqL4MM0vMdU9/n7EAZHu?=
 =?us-ascii?Q?AQ80esPeLc29lYDhtvtj/g/9dDGlz/NreA/fMLQgX9kg00cIJEw86ySGron2?=
 =?us-ascii?Q?1xB640nfCqGFPsloQAMpMbYE8sGEDfB5XRDAk9ZyVQNyDBfC4zUaRYgdzygT?=
 =?us-ascii?Q?J/h/7v9KgqU89kofJTZyEDKbOusvYIXJiu829AhAjoZlUkn6KtbOjjM5911I?=
 =?us-ascii?Q?ErfHTet9vvWIe3bE+ACzQw5VqL1njRPTBcVfn7fmrFn9i631p36gXV6iT5KI?=
 =?us-ascii?Q?5YpSEVuFG4pO1ShOywuk9j5kwvYfse6vnZxXVNqJElyDicEBN/pHvzcliQOB?=
 =?us-ascii?Q?E9RhrjLNbMc2it4bIsXyY61B4MrV5OZlDgKewIcsJ20VkMqrBnI+SFIUAhKz?=
 =?us-ascii?Q?dGM/gFLfpLm4kMtRSIqLIywTvScnN/i78sN+6MtMHyGhB0C5Bte9aRJK/yeq?=
 =?us-ascii?Q?+MxoFJezA9DQgASZLtWbA01HGU57X0ne9rc2CFuf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3b3cc5-c4cf-4a9f-ceb9-08dc1cf47684
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:52:26.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpyY0+Ak/cObKs6W7DrQfTKmEW+yUM/zzSyVWae2L0UzDV5llGU6hZafuZrINAsv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

On Wed, Jan 24, 2024 at 01:32:22PM +0000, Marc Zyngier wrote:
> > So, I'm fine if the answer is that VMM's using VFIO need to use
> > KVM_CAP_ARM_NISV_TO_USER and do instruction parsing for emulated IO in
> > userspace if they have a design where VFIO MMIO can infrequently
> > generate faults. That is all VMM design stuff and has nothing to do
> > with the kernel.
> 
> Which will work a treat with things like CCA, I'm sure.

CCA shouldn't have emulation or trapping on the MMIO mappings.

> > > Or you can stop whining and try to get better performance out of what
> > > we have today.
> > 
> > "better performance"!?!? You are telling me I have to destroy one of
> > our important fast paths for HPC workloads to accommodate some
> > theoretical ARM KVM problem?
> 
> What I'm saying is that there are way to make it better without
> breaking your particular toy workload which, as important as it may be
> to *you*, doesn't cover everybody's use case.

Please, do we need the "toy" stuff? The industry is spending 10's of
billions of dollars right now to run "my workload". Currently not
widely on ARM servers, but we are all hoping ARM can succeed here,
right?

I still don't know what you mean by "better". There are several issues
now

1) This series, where WC doesn't trigger on new cores. Maybe 8x STR
   will fix it, but it is not better performance wise than 4x STP.

2) Userspace does ST4 to MMIO memory, and the VMM can't explode
   because of this. Replacing the ST4 with 8x STR is NOT better,
   that would be a big performance downside, especially for the
   quirky hi-silicon hardware.

3) The other series changing the S2 so that WC can work in the VM

> Mark did post such an example that has the potential of having that
> improvement. I'd suggest that you give it a go.

Mark's patch doesn't help this, I've already written and evaluated his
patch last week. Unfortunately it needs to be done with explicit
inline assembly either STP or STR blocks.

I don't know if the 8x STR is workable or not. I need to get someone
to test it, but even if it is the userspace IO for this HW will
continue to use ST4.

So, regardless of the kernel decision, if someone is going to put this
HW into a VM then their VMM needs to do *something* to ensure that the
VMM does not malfunction when the VM issues STP/ST4 to the VFIO MMIO.

There are good choices for the VMM here - ensuring it never has to
process a S2 VFIO MMIO fault, always resuming and never emulating VFIO
MMIO, or correctly handling an emulated S2 fault from a STP/ST4
instruction via instruction parsing.

Therefore we can assume that working VMM's will exist. Indeed I would
go farther and say that mlx5 HW in a VM must have a working VMM.

So the question is only how pessimistic should the arch code for
__iowrite64_copy() be. My view is that it is only used in a small
number of drivers and if a VMM creates vPCI devices for those drivers
then the VMM should be expected to bring proper vMMIO support too.

I do not like this notion that all drivers using __iowrite64_copy()
should have sub-optimal bare metal performance because a VMM *might*
exist that has a problem.

> But your attitude of "who cares if it breaks as long as it works for
> me" is not something I can adhere to.

In my world failing to reach performance is a "break" as well.

So you have a server that is "broken" because its performance is
degraded vs an unknown VMM that is "broken" because it wants to
emulate IO (without implementing instruction parsing) for a device
with a __iowrite64_copy() using driver.

My server really does exist. I'm not so sure about the other case.

Jason

