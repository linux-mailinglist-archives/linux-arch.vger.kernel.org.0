Return-Path: <linux-arch+bounces-1502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59370839E3A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 02:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A928E22E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9655910E6;
	Wed, 24 Jan 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFF7t9oF"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFF1381;
	Wed, 24 Jan 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059650; cv=fail; b=eigoPI+rKQ1SCmcxzb75DhTrZBIkBicNJMNHoC49CpQzvYVrfWPlGzMuXVd1Nii8NkpoZpHufxQAAg6Wupar7bhwbPjDEDcGHqq7fJBFtknjJkDZ0WmnLcVYTshv0yU/2HfnKgi8xx6FC4oRgjUj1MxDVlrgKVWJURi0faziENQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059650; c=relaxed/simple;
	bh=U6EIOG4FD/W81/MXzjGl9l0jmxh4tGk3WCAUw6wlaAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iOBh8YS3j8expokmaKpb/MIYVYeg2GvLn28BCMOZA58ghAgGZRyN14ZKg1XZfIxoi0WGlMJ/HyKA7fG41E5UV51oQpfNnDHIxJKMyO4DfUB28OERAtk8UfguBwv4JLg7GtYyxYVfnclbjLQ99zCYv/4wk8OxOYOlbOQKjt8JiVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dFF7t9oF; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAXeR88obZTPxZRKFjYEV+cC5+jSg+Nb0U83QeZphyoSMtfiQtqgRtNXufrtZ+yWEgr1YlDsujfWUV1oMfkd3h5WX1YTeKSwBFpUD1K5OmBmlhLKu6IWM+cBxk882KPTWhbLP+te/5q4pre5of52uZ/zklsPWNOmRY5mPkBGn8hfltT/ylDh22dRDCv0JdZ2+dvdnYLVPD7FrQxDtlskRZnZ05K5Rx/T1flLRDtlY0+aK9xy9Bp6WocHIAnrRVkVb7pdTEqACe4k1O3ZqEiN+1PStg/co9/v4qcfK8oVaZOO52oPW1QtI5XRe+9AhOzZBgXMYOO1vCXEXX7T/cNCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sXMMCeuJiQGDaybYd2OdY+MviGKahXOrnPdaadR6MU=;
 b=BSmA7XwY+ZmFcUiVHyC2F4h+2eueJkQk1oOZ8wu91W82MAvSgqHeGWXmOtj/5AvpAG6kipfTEr3lq7YAfigM4YqE/wKSX5IEA8iJ9lfEDdMRGTSReLDhL+Exvw8yPR0sAkiLbOxvptBkyS43lz2gdyjbQnC9OBJRVcV9tVYyCGI5GWFQB4WBxelovlD33hgSFISGvaQNYaj7T3CZosypMnX5gkZYpLyYAXbRZq7rM9YeBU/buLZxDDiPPagM9jEvNG2eN/nN1hhoF9sPVdYegj6QtISZs0NOWXVPMIny6q03Aagm2j1war0Vp0wELaYAOulZGKMsIobJq4X7TcpHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sXMMCeuJiQGDaybYd2OdY+MviGKahXOrnPdaadR6MU=;
 b=dFF7t9oFKmJ9wRwszMpDSZIJhhuPm4zBX7V2eoNyrW0wRbKYXhnp7wT62RQ3VijROipuOK63uom8dz9RCVsUEYgRAsMeZqMI4aYPjKLj5WiWedOMVIumMAlRrA06Hz/qSwpwStUNR+pVJdOUDDIe0nalEAywaIHAxKxc6xGiIFBhmXV4ftfZxPlpGLeopKW+lOomPrpqPk/B9siN7TWvgm6yyaKZLSoL9H7f640zlJeJB2ayYD/5RLBqzo1KOu9EDRkPD1kSCJljTIFLkwCOIjaE0SaSmCKnK0THuTLxf0a7xPYroz41mRjwW/+Nzb9e4r/Aufi56OJ1D7aGxvN3bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 24 Jan
 2024 01:27:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 01:27:25 +0000
Date: Tue, 23 Jan 2024 21:27:23 -0400
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
Message-ID: <20240124012723.GD1455070@nvidia.com>
References: <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbAj34vdVuMrmdFD@arm.com>
X-ClientProxiedBy: DS7PR03CA0348.namprd03.prod.outlook.com (2603:10b6:8:55::8)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 285c1324-1f7f-4bef-5bbc-08dc1c7b9ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+G8enOTCd2KNDF8IYPNqaJHNNp69PoLeoTgodsE5ptE3s5CI/QCZ4V+8MZyw9caFARS30WQQT7HHvDkm3z48kgtdLQD3HFcQVfxcpeOCyT3DEPYWUp8dpg3d/YjQy2a8mJ+JxuE4M/JrLsHd6nPswuT61JMibGrM6AEI1r++Zckq2ilpaOr1TxL+LBY8BZaEHmerKBQMsmgv1InvWitfvy4sNjidgiktxPA92V7dkNCvEgxmQKJXQkFnovCaEDZTpBh+TqHrwg+GtkJP6tSga2jPgt6j2wkMQogb1yRSDstHI3gvlJj5gSTxSV0YJ0WrAc77mnH3IkZ5C0mvMf5/FIzmFGcgWorX6HbcUQMMG/3kqKAPVbiqNKuDR9x8KdS0zLH+aiTuMD5bFDSyY1sofzjhqtCvexTSVmyj6KQUBaCi5+ZcV24Vdt2yCdddzb/SXGyvUg0fcf/UEX+J99PlRR8betlW8EPJnvcKhs1ORDWPXWjw3u+qhGAy839MIBNsm0tCEwv1nAUwWH6GVgcbGfrCpZVPfeP1B3Ipx8F1NiR8K1eiOj1HqzodLXxrL5g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66476007)(66946007)(83380400001)(8676002)(6916009)(6486002)(5660300002)(86362001)(54906003)(66556008)(2906002)(8936002)(4326008)(41300700001)(7416002)(36756003)(33656002)(26005)(6512007)(6506007)(38100700002)(2616005)(478600001)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?McTlJU1O4uVoXX4AVAfhFk2iYmrdBRp2uZ741Hn4J53yn5guHJjfvj79i9Hv?=
 =?us-ascii?Q?lMn1YjX94B/foJdR68+MjRk7rPaxS6/irwbT7BU00vi9LT0/Kwp3JQRvhpVH?=
 =?us-ascii?Q?FI/SLBEE431Qm0o2i/HWmnSvN+gWCwsZys7Zi7hFw8ECUSJzDkpYtYpE1ltN?=
 =?us-ascii?Q?TYUZPrBBrTuXhQMChiEd4yvp1DZ8Q1kuRWCvnGY1kSzeexi+OzTz2I912n1L?=
 =?us-ascii?Q?0VeZSfiSXXY1VTZtU7EYoXr6gXdS4FUyynDfXLRlVuUZJgbKUHOtOeKf6LBk?=
 =?us-ascii?Q?2IZDy9bBOnibhmmCCkpx9XIOH/Tfp37nxYrI7Z/QsvWimhVjyjdmteU3Jmuo?=
 =?us-ascii?Q?XfcKjFmvhqGZqLkyGr9OxaQhq8HOnyWZP8M+vuVPmUCI+sNPFyacNxZmFcLr?=
 =?us-ascii?Q?gJnYzq1xl5clrvrSwe2IsbVPUVMxypt5KBZaO6V7O3Su4Ybo3JVJ8fvMAYo3?=
 =?us-ascii?Q?rMf9BT8yRzMF5W6xcy3BXM/LrJhOldViWaIVt71fwrZ2+rH7ZUUWzJTmtwG0?=
 =?us-ascii?Q?wbRVrhGA8xenwZVd8ioSWsvxiyXFXn1Zs9jnvIaIY7DQCXEipTCnT+cj72yi?=
 =?us-ascii?Q?WVoyknjO71yQRHilv+SGDuu7FL3ovYm73I2pFlvIMl5dWkla4O1FPJb+4TCK?=
 =?us-ascii?Q?fiJ8pWaKpic3jNXSJf9t/irodgCGtre0KhHp4+MejPqXsT6uwGespGR1E9aq?=
 =?us-ascii?Q?SONYwlBvFSF0uFBcDse0kvZHFk89evyKBGUgeFQe/+jmb/Fb9C77dzsGksiG?=
 =?us-ascii?Q?PO2NBmJrC2My7qtVqk6TnmeSQTnkwebUGEjWxa16tLRXxI/QPks5eGFPRQGM?=
 =?us-ascii?Q?9tDANiQITuX5m5ro3Q8VKNe/ZvffvO6eXCMUJisdt6buvGgJ99tVUagymHn/?=
 =?us-ascii?Q?DEYaq+CwUgOJ/FtBx/Fu8qSUppZUKVcoG9qONOKxwSGCwqgK6Pt6fs6+DMvc?=
 =?us-ascii?Q?FI2PNORtPn5a0qJXcS4zzpg1wHCo9HIBihoIC3u09127x8S2H9u5t9WZnIE6?=
 =?us-ascii?Q?yzEqegvuoYlGlWOSYjuI6cfd+2N9xMCK8hKQQBfGwrJRwBKaY653Uqseuc8w?=
 =?us-ascii?Q?0+0FSWJoMQnx82d6CgKepDfLd6PkP9e3EN5jlGYiCD83ve+x4zkUdyVMRVw7?=
 =?us-ascii?Q?dGduxluTndIjkHXscSLbnQ7jXFuEeCxPKTS9yNgO/pXkhAapMSn88j+KDDXi?=
 =?us-ascii?Q?nMU/nqYo9w57RD5C2NSQDDeiTS+EuMZRO5WeHVrB8Hf6HDfzjdUtF2W82a3/?=
 =?us-ascii?Q?gRvRvlTaij3MJk5NnOiyy4zOcR2+k6ifWI1Feeb00de6XzciB4pgpjfvC+zj?=
 =?us-ascii?Q?lwXdgDt6PZKXWiaazj57ToP2PZkJqzKjPqesRB9V0ijtQyaWN11Lq0Eq3SW3?=
 =?us-ascii?Q?2aFA+oXzrwVgYnGXQuZA0qb2WvaKCkyYoaUxC2y8xZIRez0Xem/j+c9T3oYN?=
 =?us-ascii?Q?BQ3NonWYX0nEikmQOWolec6VwaVvnWskc+zShRYvZvqOOD6wzyWzsi6Z4I+Y?=
 =?us-ascii?Q?N/eTHEO1m5pyQydKm5KPdgc+rXOcFlTL7W/trRURFFwEEfn0gkLRNVMeqJt3?=
 =?us-ascii?Q?x7aDkgUANKS44wREcaqaAy66vvcW0KhMgyHsRMqj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285c1324-1f7f-4bef-5bbc-08dc1c7b9ed2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 01:27:25.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP+rUQy6K7kc91wCVCwcxBV0TVcu+75lDbPmQ6PyjSHeeAt+J3LG7V+9TqDUiAu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

On Tue, Jan 23, 2024 at 08:38:55PM +0000, Catalin Marinas wrote:
> (fixed Marc's email address)
> 
> On Wed, Jan 17, 2024 at 01:29:06PM +0000, Mark Rutland wrote:
> > On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > > > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > > > 
> > > > > #define __raw_writeq __raw_writeq
> > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > {
> > > > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > > > }
> > > > > 
> > > > > Instead of
> > > > > 
> > > > > #define __raw_writeq __raw_writeq
> > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > {
> > > > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > > > }
> > > > > 
> > > > > ?? Like x86 has.
> > > > 
> > > > I believe this is for the same reason as doing so in all of our other IO
> > > > accessors.
> > > > 
> > > > We've deliberately ensured that our IO accessors use a single base register
> > > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > > when reporting a stage-2 abort, which a hypervisor may use for
> > > > emulating IO.
> > > 
> > > Wow, harming bare metal performace to accommodate imperfect emulation
> > > sounds like a horrible reason :(
> > 
> > Having working functionality everywhere is a very good reason. :)
> > 
> > > So what happens with this patch where IO is done with STP? Are you
> > > going to tell me I can't do it because of this?
> > 
> > I'm not personally going to make that judgement, but it's certainly something
> > for Catalin and Will to consider (and I've added Marc in case he has any
> > opinion).
> 
> Good point, I missed this part. We definitely can't use STP in the I/O
> accessors, we'd have a big surprise when running the same code in a
> guest with emulated I/O.

Unfortunately there is no hard distinction in KVM/qemu for "emulated
IO" and "VFIO MMIO". Even devices using VFIO can get funneled down the
emulated path for legitimate reasons.

Again, userspace is already widely deployed using complex IO
accessors. ST4 has been out there for years and at this moment this
patch with STP is already being deployed in production environments.

Even if you refuse to take STP to mainline it *will* be running in VMs
under ARM hypervisors.

What exactly do you think should be done about that?

I thought the guiding mantra here was that any time KVM does not
perfectly emulate bare metal it is a bug. "We can't assume all VMs are
Linux!". Indeed we recently had some long and *very* theoretical
discussions about possible incompatibilties due to kvm changes in the
memory attributes thread.

But here it seems to be just shrugging off something so catastrophic
as performance IO accessors *that are widely deployed already* don't
work reliably in VMs!?!?

"Oh well, don't use them"!?

Damn I hope it crashes the VM and doesn't corrupt the MMIO. I just
debugged a x86 KVM issue with it corrupting VFIO MMIO and that was a
total nightmare to find.

> If eight STRs without other operations interleaved give us the
> write-combining on most CPUs (with Normal NC), we should go with this
> instead of STP.

__iowrite64_copy() is a performance IO accessor, we should not degrade
it because buggy hypervisors might exist that have a problem with STP
or other instructions. :( :(

Anyhow, I know nothing about whatever this issue is - Mark said:

 > FWIW, IIUC the immediate-offset forms *without* writeback can still
 > be reported usefully in ESR_ELx,

Which excludes the post/pre increment forms - but does STP and ST4
also have some kind of problem because the emulation path can't know
about wider than a 64 bit access?

What is the plan for ST64B? Don't get to use that either?

Jason 

