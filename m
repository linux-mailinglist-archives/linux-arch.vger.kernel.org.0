Return-Path: <linux-arch+bounces-1527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81183B68E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 02:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8E41C21A0C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C610E6;
	Thu, 25 Jan 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NW6Jb9KP"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5664ECC;
	Thu, 25 Jan 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146171; cv=fail; b=sVNHeCICxhzAX6KhKc7yokOiCzMWhowIenEkWg4538e54ct6oeNqOgVJGXq5xxdHZbfs52x1lyODVpA0UOOAMKsc6JOFUfrKCiGN2Am2jOibzBaGWl77PVN5uCiFjPJ1SuRh26XSoPurGtCDq0IKF0vx9B976uAUbn7DCOmHnpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146171; c=relaxed/simple;
	bh=YZfJr/cvKl+pZP9NQxSS4hOqBvKwkc7eobsl5vDdDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQmvgvFHdjKtOOgKrb0BiMa5h83pqQ23C+nQRuCjTq4z4z2RQttWIxcUbiqS/u5MjsBcgxv+YGTe3aA1dQJpRdSqGLY5Zwsz9Ga3nopUGDqZ66yNx25jQZvT9yB1E2Cc8ziE9JCa6Ckp+1atumdoPH4fpvOrW8u+b56gDU7E3Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NW6Jb9KP; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhbISzMZRLzDNLl/0qe365uejJxqk5EjGBnYTgj9sbz5YcPyHoom1wE51FmAyKP9RABjVlckre88U84v0PSbUG/Xt90JCniy69sLJnwve+uemo22oghgUqcwQ15obCh4qCMmmNuiXQt4cRYgh4UlvZGwg0eGdCXWnUkvkKMNEIDuToBMNV14tbutavhUztuVX8ycWh8qM9RHMrD5nKU6mDEvKg6QyGAncqJfhW/llV8SKM9A3NC5x583nUXTPkqSZu/SkDa3P+SOa1ywKx+P7ZbcGOhXuy59/txl55EVTTSRYMs5aS3b89XT0CvoXAgqruIdDYCpRr4vJy7nMwwEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE1YBXPN/7WwvP6tCmRAYtm0vUxqDOIjpQq/znFtt8Y=;
 b=Ip2Ewfb4MROJwNAsV9EnsSoM7+egyreHD17K41l6mIC8jYzmpSnM8D+Ov08SPzO+/vhsyDh2WecPIphqFkRKOx/nzfO6i+9vSBnPOPOOlwp+Up9K4f6BTUO9OwZ1nRfxmvQ+3TGdOWUBreRoDcMq7Qlt6k/pgMz6VpvECMdkFyx/tln19qiDtheHYMBnDBwmxY2TztJeVYqWnqGpsPtk1zOX49aM0M+UbBpQOxu9bJk5q3Gf2DRsnBee1mnlgdfAXEhwVhWS6uXcokVuR/l8p3FbjJyL4t2Fz1ZUDdeZG5Rd5SGdIYTjGFGT9OaNsc0Tn3JjEYkA5vwY4i4SeC6QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE1YBXPN/7WwvP6tCmRAYtm0vUxqDOIjpQq/znFtt8Y=;
 b=NW6Jb9KPN8hfGQr+9SFV3lVgmV7faYEzwoXuyqpmFs/RRvJxJVMKSnoZOgVwE4M/GFl3V1yGxm4qwuQJQ7gxKYNiI40VAwMPX4tirM3VLTdvhyfdDTFR8nV/EuMY9sqlZbWo+iPWWX8vIzZG1XhaO9bgzacOBHor9lwOUijdxR2EMozTpEsvv5nEW2BdQO+m/IWLcmGdNELm7iu9b3POVJigjJGf7EGEH22PQpRAzQEAyVFhnU81KoiAN7I2PXcp+UOlpnb3vh/gpq/KShAPrdm8z/U9hGppV/oEFD97TPjJCMN25DtIoxUy/VbD8JmML9IHEj912noTrp4Y67guxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 01:29:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 01:29:26 +0000
Date: Wed, 24 Jan 2024 21:29:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240125012924.GL1455070@nvidia.com>
References: <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
 <20240124130638.GE1455070@nvidia.com>
 <86bk9a97rt.wl-maz@kernel.org>
 <20240124155225.GG1455070@nvidia.com>
 <ZbFO6ZXq99AWerlQ@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFO6ZXq99AWerlQ@arm.com>
X-ClientProxiedBy: DM6PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:5:54::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 11724913-3f89-4f4f-e5c0-08dc1d451128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h/JSqE1qVj//x9kqJjFvlXXy+PvIRfuX+C1z3M3rEfNPRphG2PdsJKyxpoU0sES71gNllnpy+C9hxb9wR3Ftvbj70Y1yoDAkYFPCszezr5zzHDKH+0aTO/CvJRo8ztbjhUJI9gh5yrNaPFx80xzmF3v/G6KFtTulW/K64/jar01b4ZgEAG3wh6R3V376lKhvCjb+e6SMUwbN8jPfPtHkvQFsk5nxEEHPY6JFdTSR6iojmaei1eaoeAvRBd5YPMMoHuseq2SxBZfpCDndntu+iXaDstp414EMUcQ1aHDQdlRnvb4tUE6lcm7GQKAfVhFL49M9VUF8SgTgm32QJeHki+Vo9H+Jj7Zcfibcr5i2YVBtUJv3jg+htv4BpO51Z2oTkm6OETWjViU3TNo4qrBLfWIRo1gSKru9UuULoUubvf6pVVkANm8U/gZRjANTPSkeRkvGuNEGQAxijwmrits0ELg+DU+EevRduBtPvBWpoYkoXpI9/7qXLlgdqC1wZZGxYts2rxakdRLxBQO310XqcxUuSNSnKVhHFFBiW0ABGmkOkkkCRWAvMgty2G7rhNSV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(83380400001)(41300700001)(26005)(2616005)(478600001)(6512007)(1076003)(6486002)(6506007)(38100700002)(4326008)(5660300002)(7416002)(8936002)(6916009)(66946007)(66556008)(316002)(2906002)(54906003)(66476007)(33656002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?28ombjVa4mGa2c9QXo2kIQf/2/Nnw9jj7Cb2DMdPpEVkwYkWobFJvzVdc639?=
 =?us-ascii?Q?8cSSniU75fABxJU6eXMjR3306CiIO34iX6zmM3FrTNnjR4Leu3COK8dQpiWl?=
 =?us-ascii?Q?UWn3ZW5R9LzNNOI9gnGPubZnlOx5WyF+qDq/x8t3UwXc8XXYiJMhGyV6+prC?=
 =?us-ascii?Q?oxU+Tu46xmyxI6qDDDctIe83t6iRYnwRA2c/tL+Sz1IuYi/7rxH/3oTMxU8d?=
 =?us-ascii?Q?rkgZEWLMWjSoZrijBs4qGMKjC093eKFmJLtqfdyC4dFj74XloHhv3sOaaxqO?=
 =?us-ascii?Q?wHahTfYiolTDcXoLzXojANDNHzLUJAiUwYXJjfphrI8+LDLA2lkX63gVqDvD?=
 =?us-ascii?Q?l7guKZAmByAttgWhUuWWFbKdgTYDiWhWZgN8ZH166gGc4fcy6TkvhKMnLUwc?=
 =?us-ascii?Q?y3rxx/hhcVRi9DW987iARY7rPGvm+oh4uSUdOSCyqE0AjaBZ9ynGL9DVaXxV?=
 =?us-ascii?Q?RTJUp6boDcEP/U1MvCJ566Te+RsgEbeqDWyWuvBr3Vuv5p/1iW3SrKM2mBo4?=
 =?us-ascii?Q?SRmykyhAufE18Nu5+pzUCLor/7uvW77frY1g1AcZCogOq69XortK98e40aUD?=
 =?us-ascii?Q?ePRxEegnGwA3o5brR/0y4Cfrui2Jb22bgGjmnomoRTwtQHW4xj+bab4IN1W4?=
 =?us-ascii?Q?N2SWxVPbd3KxZUN1xfsSZ+pAcEjsx6bLmK2HDsN/9k1GY40la9TTaywY5jEM?=
 =?us-ascii?Q?vZMZvqNKzCMdjhXsKoSY7WgkF0jy8cEqJjGtHzSIlA73VH33aWucoO+QcVph?=
 =?us-ascii?Q?kXPeEXFDkisA+EWB5RCbPYOPITNQ20OjJPmZzK8qNBRpA4s8+wt6pYw7wX+D?=
 =?us-ascii?Q?dBlYnJm1Xqll/Vjq+0zcpZXBLFJWr61w/iMHiC/UEBs3gJEYKEcPsGHCEt61?=
 =?us-ascii?Q?a+NoqqIulOIeHEMW4qqifd2jp0/v8nbrhb8APgQd+ro0K7BxfT7U+8mGqZvc?=
 =?us-ascii?Q?NBhf0crl0ibU83nHV3EoOoaJhdoFjxsQC6O4FOHQuEF49C/WtPml22N1AyPx?=
 =?us-ascii?Q?x+6dd91a9iTUQ78ZdfXsBi0MqGp18/ROhcXZNz8uYHO/cMjlCnUYo2mqYeit?=
 =?us-ascii?Q?BwRCBgvAZWe9MZ0tr1nW42/Mddc8Rw0ojeblrgxIkzgDrcjEDJ5exOJUat0G?=
 =?us-ascii?Q?6Zet0V6OjgiU9a3gk2G4IZQkyXtj6IWfqrefhS7vA9VCHmUzAHakj5q7lQjt?=
 =?us-ascii?Q?lBFT+W0I0W4KFrSSdvRjqbOXUM5hBpABzsyEJKAgjKJL5SQGCQ7GtHRBUWnM?=
 =?us-ascii?Q?ccanI1anScQPf3ijnsM+lE96CJpUWQWUZia2edwyMDG+ISaufEMWeMZnZhAv?=
 =?us-ascii?Q?yp6Pbvvnfeq4Owo8GDAm8x71ROyw9MtIyAxcdfZY7mXEjUBdxVUmbjIXGyTl?=
 =?us-ascii?Q?6QxkAGteA/BTGiTlxcO6ERihevXz+3FDJvKGoioFW4igwgFyCvzhhKaihDJG?=
 =?us-ascii?Q?y4S7irT6YnfdGKlkpYAt5PyTrQUlm2kaXJCcozdUuA5v7r3qlMcQKoSgI5xQ?=
 =?us-ascii?Q?DHMcvpnzK2D4gua42o6DxBAH/sBcV84nsDZeAVXXDC4XRhd/Kx3sFl1fH5fW?=
 =?us-ascii?Q?Mfm0tx/fr9qha1J1s2KWf2btr1Q46CjkQ+VYIjEf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11724913-3f89-4f4f-e5c0-08dc1d451128
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 01:29:25.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPysawn3Mid+rqBK2jYrxisJQnNKJiKLcMn5IJASQ25mU2cjcAED7iWqFhE9GGGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

On Wed, Jan 24, 2024 at 05:54:49PM +0000, Catalin Marinas wrote:
> On Wed, Jan 24, 2024 at 11:52:25AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 24, 2024 at 01:32:22PM +0000, Marc Zyngier wrote:
> > > What I'm saying is that there are way to make it better without
> > > breaking your particular toy workload which, as important as it may be
> > > to *you*, doesn't cover everybody's use case.
> > 
> > Please, do we need the "toy" stuff? The industry is spending 10's of
> > billions of dollars right now to run "my workload". Currently not
> > widely on ARM servers, but we are all hoping ARM can succeed here,
> > right?
> > 
> > I still don't know what you mean by "better". There are several issues
> > now
> > 
> > 1) This series, where WC doesn't trigger on new cores. Maybe 8x STR
> >    will fix it, but it is not better performance wise than 4x STP.
> 
> It would be good to know. If the performance difference is significant,
> we can revisit. I'm not keen on using alternatives here without backing
> it up by numbers (do we even have a way to detect whether Linux is
> running natively or not? we may have to invent something).

I don't have a setup to measure performance, mlx5 is not using it in a
performance path. The other drivers in the tree are. I feel bad about
hobbling them.

> > 2) Userspace does ST4 to MMIO memory, and the VMM can't explode
> >    because of this. Replacing the ST4 with 8x STR is NOT better,
> >    that would be a big performance downside, especially for the
> >    quirky hi-silicon hardware.
> 
> I was hoping KVM injects an error into the guest rather than killing it
> but at a quick look I couldn't find it. The kvm_handle_guest_abort() ->
> io_mem_abort() ends up returning -ENOSYS while handle_trap_exceptions()
> only understands handled or not (like 1 or 0). Well, maybe I didn't look
> deep enough.

It looks to me like qemu turns on the KVM_CAP_ARM_NISV_TO_USER and
then when it gets a NISV it always converts it to a data abort to the
guest. See kvm_arm_handle_dabt_nisv() in qemu. So it is just a
correctness issue, not a 'VM userspace can crash the VMM' security
problem.

The reason we've never seen this fault in any of our testing is
because the whole system is designed to have qemu back vMMIO space
that is under hot path use by only a VFIO memslot. ie it never drops
the memslot and forces emulation. (KVM has no issue to handle a S2
abort if a memslot is present, obviously)

VFIO IO emulation is used to cover corner cases and establish a slow
technical correctness. It is not fast path. Avoid this if you want any
sort of performance.

Thus, IMHO, doing IO emulation for VFIO that doesn't support all the
instructions actual existing SW uses to do IO is hard to justify. We
are already on a slow path that only exists for technical correctness,
it should be perfect. It is perfect on x86 because x86 KVM does SW
instruction decode and emulation. ARM could too, but doesn't.

To put it in a practical example, I predict that if someone steps
outside our "engineered" box and runs a 64k page size hypervisor
kernel with a mlx5 device that is not engineered for 64K page size
they will get a MMIO BAR layout where the 64k page that covers the MSI
items will overlap with hot path addresses. The existing user space
stack could issue ST4's to hot path addresses within that emulated 64k
of vMMIO and explode. 4k page size hypervisors avoid this because the
typical mlx5 device has a BAR layout with a 4k granule in mind.

Jason

