Return-Path: <linux-arch+bounces-1398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A3831D79
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128D1C22D30
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jan 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E57328DDA;
	Thu, 18 Jan 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uo93Vhwn"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245914270;
	Thu, 18 Jan 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594730; cv=fail; b=reP3JDKSQ1vOrz8MBHRwqv9PIzS90OhdQ/zMTN9vKrr+MyFGHkIhzi+qOE+lavZRoMlHp+ATUquGECNbj/BrmBv0+njSkgbERhNjW4J6+Ycs73E8fpqr3Gt3xybcRgP9QQtrdTrfshERfkZ4LizDFNyyc/maH4SYWqvrlyfs4o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594730; c=relaxed/simple;
	bh=EmDS7a4RZMoKT1xhxM6/mGzkdypTTBc29Dvv+vTLZ30=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Oi7iPEQ7G8VcI91MSTAdz1KgNl+vwwUiMrOLsQzr44ec1QTBeYOlk02QNOyvWQ95MR5TU5W5vtE0EG5wK+dNkUq46MT/ioy6XlkdzIT0sbP+Wa1HzFdC7GOmenBrEWSJaY4AhsgNTtUDHBdJbMMe8ojaGDj9FbVYaXvdBnJqZeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uo93Vhwn; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9fWdZ9VDvLkS1UtscvvTaOId/6wwDWrpD4bRmt5XemOjxXMqzO9x9+hl/JgKq/C5B2dsvNCOUGd/++faf/nzoqXN4gjKw60RTRe6xHWCYlsj4roaV3xXGcJs5FqX/rorN1AJBRXykaZd3KpbOfz7TcI+ZAk7N9z3k5hlUnY8xiQefCHQ9xO56V1vQ0YaxWMg0Ns7rCse567Bcg4OJBC56IpQOoNApLBr8QCezI95xdiMNxCsujUOxePoHE5jbgYTc0kRxuluu7twRBsMQa8WhngMWrqQCLvFXFUM4rz9u/gTvXciS5Tnl6vQiE1SV73va4IWnxL0UO7AgtZpTS4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA8L0zBhpYRpH41FDtdcJUpxLYps5W6S2wNwSlbpUME=;
 b=bFkODXExjLx52VZRS1wNMGjPtP+wLgnNJaj70h2/Pk0bvDBZFwFDpFmIkMmlSQDnDq8CQXaioa0d7oU160eAHg1h/3LJA/7KsTTZoYw7bL9DzZrAbbxic7fkyVAP4wvumjf5jI6WSXPGdekNVs+ANGh05xtpeYmcY+frwvTeEVlodEK06n63/Hi2mGXnGRsGctRo7puwmhRCO7p/+8OPJPhotGXpw9VYUybmd9IVqEeZdUvFCilMEcRd8OGslo6ySV+ks7HdwM8swqNkwr+H9SkPlMHNk+CLwqdfwTXPjysd1jTh5J1t50s1V+XlknQWFZmcSFb/IAS1kMd3K8dL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA8L0zBhpYRpH41FDtdcJUpxLYps5W6S2wNwSlbpUME=;
 b=Uo93VhwnansKu0I6SLa+gHZUHZTZLUszeTYO8MT2f64OXONGvSv1rhj+dF2NF8Z6Qo20ZrZu+JSTfnpfh8tsst47hhizonptbpUziImKsUDtFViYKSaJS0fJxkuvFSuVnWsfb3Kq/drpwr8lMF2BywijO5O78+doAmNWop2DNlnp/G5BXuS81FdjQbjVS4YHvLUcO347UvqgeEEGEVAe7fFm6MKdBlEIfuyRrS7W5yv+X97c0RfbyuXbR1ETxY6Bi1LDZlEpmQdaxE1fgQ6Q+b3pU549z2QuBFl3T3l3Wz7AgxpMcj/vcOOo+H0Q6gcPSJOEenzi4CyJN7fjP7me5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Thu, 18 Jan
 2024 16:18:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 16:18:45 +0000
Date: Thu, 18 Jan 2024 12:18:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240118161843.GN734935@nvidia.com>
References: <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <ZaffFMJy8cHOvtu8@FVFF77S0Q05N.cambridge.arm.com>
 <20240117152822.GI734935@nvidia.com>
 <20240117160528.GA3398@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117160528.GA3398@willie-the-truck>
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9552d3d4-e3b6-4d67-c396-08dc184124cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zus91BwzZri9R7tYubucfxVM72MUsC+zIAzAuDnw62wGw8ZbEua4jimlZzs8sYSeLkLfTZ99+ho/z/spjnnaH9sKPEToshDlF27u3kzV803HEBsVnQLhdrlTq2/CBZgHPFrgfw8PfwhOqAihEHI76w/MXN+uYddfIrLpVhyyZWlqQZul56eharw8jSFtNSyzre8+QtPoRGHrDUq1gtKxUBVkPZjmv7VwdyW22x6B3SD0Yrl6k5IS0Go4VCUZiiiPRRj6Vma+6PGlSuQXHKuAmaz0CzHconbpP/3cPhDXV0ZPiFNNXBdCTB0gIcOOlI1Vs6lQWV0wdENS0UjWFZT76jU21gZSTxEPbBqlDUJJ8c82dlgHP1xRs9XHfolyVnOngBNZcJxADW5zyZH76NvUwYjx0PXkL9veeRFlGpnvxbXACjo/OVWunfb3P6lJOXamvWMld4Jnv1pFdfCgDHmPH1nAN/ON48LTg8JuAuo4rQa10PZuKcR4lfHl7brsJiG2f9BEktYL8H/iWIvYlRApgZlIld3nePoTUEKBYgiGHR8jeqexp75ks5WrCbp4YMHKgFopiXNGuaEGrzlbJZ0969/VYPrQCDtc36IUFltVsTt435GG1KQ1g9GZi+KE1ELL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(66556008)(6916009)(7416002)(8936002)(316002)(2906002)(5660300002)(54906003)(66476007)(2616005)(1076003)(33656002)(36756003)(86362001)(26005)(66946007)(8676002)(6506007)(6486002)(6512007)(478600001)(41300700001)(38100700002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqOdBO7+sUJvdRDwPbmjb+3H3dBu4/m18rRKIeb+Fg6FXAJuGh+TPWePcv4J?=
 =?us-ascii?Q?mBOxNMhok/DbjRgc+xfC87tylnchf6tB8qzrpfYs/Ogm3XMfjlwrEdnCQ8Nh?=
 =?us-ascii?Q?lUCrOIszLkr+bDw9xoA44pMWmKySl6YX+cLDfNfoNEfp74HTpRohD0wwlATG?=
 =?us-ascii?Q?cnbh1ZRBkuPhXGh7njHqZk8BZ2U0H5B1QVSFK/wRqYj3lnJ2kLTYlk6pCR5d?=
 =?us-ascii?Q?aoiIEXXMbU+Ov4o+KoNznhAe5AgncwEf0aRVHDqj9lnEzXV11417xDLX4/Rj?=
 =?us-ascii?Q?16m85i9jMONnfQo5ClDsEl/f1yUM4SwdYR9d618JB9cuu2Axe9cYLZRUV64y?=
 =?us-ascii?Q?ofL8fYqQtARueWakMtpDoCBDlW1wwgAuLGATGMYy4uLk7d+oAftXFKCRC83y?=
 =?us-ascii?Q?t/VMVdpjoSGZY1R2rvD2ql5f7Iy9wzffVzrKaqmpBbpH9zqvBs5NBK8ruTgM?=
 =?us-ascii?Q?yWEUj7p/JE8tuu1IC0Rbae2tJke2a/qPu7NaOkxOMvc65kAHIMYVOi6AiAg0?=
 =?us-ascii?Q?1E4EoZTOfXtjX3oJIQGHiOYU79jgybVMB7b8lSiqElwFCQ9B5+3F2xd6iZ//?=
 =?us-ascii?Q?NcqXgdF/ql32VKVtsNxm9aGkENGK+cRrdPFixyuiTSXGkKPPUDQPafJgJH1A?=
 =?us-ascii?Q?AF4uby5du+xxcKuwzgcTOo4Kur2WFS2F3TFRe4J+AAroYoDjKqe5utFrN7Qr?=
 =?us-ascii?Q?/tAy8e0riyCDL7sanP3Cy3bnPsszm/j+EInoAkidGl4CYPOw6eNdve/kK8Ee?=
 =?us-ascii?Q?+mo3g1b+EjBbwls0AqGnfH7Xgz8iHF+9iO0l3Iu2Cnjevo0SRC2M0Rb+1R0n?=
 =?us-ascii?Q?kBOKStdIM6rWAtmPim2XAAEEK3XMNCxx3qiM2Gsn2UhWASzxvA0KFhSnTOcZ?=
 =?us-ascii?Q?bdU7ObJ4YNjln6I+4zlB411qp7wkSqk6X/VZ0r0kEsEkyCxjUIz9AOXB5CtZ?=
 =?us-ascii?Q?wcaHI9yofHBRvDXPGoIdoJJM6Lm7qkf28rXA/zWX4fQONW6Vy5UWmWtxb2b3?=
 =?us-ascii?Q?6jSgwaD9t2rNk4i2/ziuQpsH4zf4PTjg8dds5FUz73DMyn2H9jWrRVxo+JpJ?=
 =?us-ascii?Q?0e0Nq5ElwLLVT1hGgNy1cpcplBDQEB50G2nOW09O9tlBo3hXxGHvq+u9eLjV?=
 =?us-ascii?Q?u70MNQcg+1jrnNhnj5e0ZsgBXlRb831VD0RHZdNiFr84GxPGGNRZJZKqZ0Md?=
 =?us-ascii?Q?GMwrq7OSkR0leoxAukXcyjO8ipY4rccOvbw4U+7daQKvqazygkHIefxGdiBC?=
 =?us-ascii?Q?MkrGHezGx7Bl9zM5yXjOeCEqMXVFO6TB17ULEqREp51/T940CXLxeW+vreqJ?=
 =?us-ascii?Q?nh2tGFoDojKhItEGJQRiBO1ls7wwCvjuYbfGOwLfNlcG11si69AXd8Dqq/mw?=
 =?us-ascii?Q?9XyQZOpDI70VhRpuMp1oNRuy78dZaI1RK8VGzmbLeDYXi6SVz1tZnKi2zamH?=
 =?us-ascii?Q?ET/YCojDuI3AwrsFV8wp8RT7ZfNklZInPheALjZomPVOVdGRrCHy54IE4umL?=
 =?us-ascii?Q?0tgpD3ratAn+xpdnI5MuZ2iCJMPOlJwZ0lbG8Ya3eYXT7rdAPOFZxWv8nnR9?=
 =?us-ascii?Q?KZXBnbN6cmUzH35zghIg4C+sU2mWZ2PiDR0py5Qk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9552d3d4-e3b6-4d67-c396-08dc184124cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 16:18:45.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1t23J2HMUFcbolKeWZdBhhW06tlcrrx1lNMKc1ORmuP0QxsVP/7LFwz+xXxbqHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

On Wed, Jan 17, 2024 at 04:05:29PM +0000, Will Deacon wrote:
> On Wed, Jan 17, 2024 at 11:28:22AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 17, 2024 at 02:07:16PM +0000, Mark Rutland wrote:
> > 
> > > > I believe this is for the same reason as doing so in all of our other IO
> > > > accessors.
> > > > 
> > > > We've deliberately ensured that our IO accessors use a single base register
> > > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > > when reporting a stage-2 abort, which a hypervisor may use for emulating IO.
> > > 
> > > FWIW, IIUC the immediate-offset forms *without* writeback can still be reported
> > > usefully in ESR_ELx, so I believe that we could use the "o" constraint for the
> > > __raw_write*() functions, e.g.
> > > 
> > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > {
> > > 	asm volatile("str %x0, %1" : : "rZ" (val), "o" (*(volatile u64 *)addr));
> > > }
> > 
> > "o" works well in the same simple memcpy loop:
> > 
> >         add     x2, x1, w2, uxtw 3
> >         cmp     x1, x2
> >         bcs     .L1
> > .L3:
> >         ldp     x10, x9, [x1]
> >         ldp     x8, x7, [x1, 16]
> >         ldp     x6, x5, [x1, 32]
> >         ldp     x4, x3, [x1, 48]
> >         str x10, [x0]
> >         str x9, [x0, 8]
> >         str x8, [x0, 16]
> >         str x7, [x0, 24]
> >         str x6, [x0, 32]
> >         str x5, [x0, 40]
> >         str x4, [x0, 48]
> >         str x3, [x0, 56]
> >         add     x1, x1, 64
> >         add     x0, x0, 64
> >         cmp     x2, x1
> >         bhi     .L3
> > .L1:
> >         ret
> > 
> > Seems intersting to pursue?
> 
> I've seen the compiler struggle with plain "o" in the past ("Impossible
> constraint in asm") so we might want "Qo" if we go down this route.

I'll stick a patch in 0-day and lets see if there are explosions. "Qo"
generates the same assembly.

So to summarize:
 - We don't like "m" because something about virtualization
   traps breaks with post/pre indexed forms like:
     str x1, [x0, 8]!
   And "m" will allow the compiler to emit that. 
 - o selects only base register plus offset so it is OK
 - Q allows base register only (no offset) on some compilers that
   won't allow o for 0 offset
 - read side stays at 'r' due to an alternates errata workaround
   requiring ldar which doesn't accept the same effective address
   as ldr.

Jason

