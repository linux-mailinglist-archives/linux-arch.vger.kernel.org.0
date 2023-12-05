Return-Path: <linux-arch+bounces-708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340A805ED4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A4C1F2163D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A466ABAA;
	Tue,  5 Dec 2023 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFCVgN/M"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B259A5;
	Tue,  5 Dec 2023 11:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaWc2lC3ZQNGWLI9G0yiD0XLhcsTDfK8MxoosPt6Q72bW6o5bWNqyIGXjcQGeXBsDiuN/b4jSa7W+0JjEJal2lFvAKnuHFTjjORNy0P9rRnglacOjDE+rfnMNClZgSmNXdXEm8dRilFZ1eNcLdqjaPDhTmnBlJhjB35RBcIqwMTVQ1JTCZFlVfvQFxz3wduubZmcvBxyEXfsaUx78nkUJO9LzmGWAS1PiWkdkFCsixerfva9DLaoPaRRYI+pCJJwhrUytvhEZJLbk28/oLSLk7xDgmMzNV1z0MFknUOgUkjDWJC/CEyVYJqZ5EpryxGLSJr5mC2WrhDGyOo/vvxqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrDHiPaMpKyvTRZYAXiP7Bbb94eHIrnc1Ph5eywapFI=;
 b=cMC5l4FSWdPkDsLRlrM9M8b9ZrEMODlkyDP3EJ+5DIcYasLiKkGEwDvPlHPD1Wy0+Ab8CupmVr2dXiSVY6Lit8AdfWjqVOORpMcDfFGYCGrELJ9Dow6d7TdQyNyc8l3Rvo8M4eRtG5wBnFTYsCyswpdJDiqKI4U/01vzUyPB/Hd8JwBfS8V5ZDAue/rmrMrl0tof0+Ooph0L6yoDWYMcMecgNkmNOVnmMmps0p4Si/6M1vl7Eae/CB2iQMSN9kvWGzCtCkspptYDBLa8hLJ14PH5yLnKcqaxI5wzGusGk/WRzd9EJ+yDyz7eeAXgsF9h9aVE5MBILMT+/fx2XrtQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrDHiPaMpKyvTRZYAXiP7Bbb94eHIrnc1Ph5eywapFI=;
 b=TFCVgN/MphqK2Tk3rcbeI4Aoe6cOvi2FlQTjf5+Sq9K/UW/h2QgdO4h68yYZt6YXtMJShF/vTLOvDu55oqqKRbphsDVO1Sn49IVSxNhMhIJ/1n0FKCP6htyHK+0H+KsMO2vJ66yMqjdizYCLJjc5L498LWbBAQsLQ02t7hVKDKSZ4UvUK84IjT/+HvjlAayrjl9kau+Kt2vHtwqjpETkexV8Jj72xNovBTaT0fUG89qHlAsL+NNryooljS2BPmAstLUq7Ypr9RD/7eTAx0aqwxQSgiWjQG1POhkhBJCpBETbuqErbBVrP0ha6J0zJG2P25HwnbeqRWURjmdEULA/+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 19:51:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 19:51:31 +0000
Date: Tue, 5 Dec 2023 15:51:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231205195130.GM2692119@nvidia.com>
References: <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW97VdHYH3HYVyd5@arm.com>
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb608d7-9a76-44e4-9f02-08dbf5cb941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y09lpmqe5pnVxSi0Gk3hjr78jkvuNXH57VUpIVy2h8JMwPNwbzcOpNdV4AQLMU7yFFe/5Z0nxSa31JOfQPoermRUDLOT7BMfSoK40dcJczlOmxrxJpGMtci6DSIIxfYn2KBtAdVz3CgTA2o1nAknqtLpPVo8owEfRyw4Uzi/POBOtPjb2Ohp1SbkZdO1MqBZynKfjYeY4UTIrfewDY9LYxLBfR8zmR4QeN83gNPHIWni2B1E/GxdYwID2AJfLdVi7agxjE0cdDejXOnT3lUb15JcrKf0gv0NjDjpH3dKe1XoC863NSUaV23TFFGz/j3zJa0L//0d8DGQVkHJQbiEwUJFVJWOkh//Bb2DcHM4KmH7MTjjAGimXfi5S2L5PBKWwX1UgB3JennljQ8t91gELC1BN3o77eqQVVndijOJeQPNoaA//+2H+tnZKaEIuq9T7E5pzhp4Dbi55Dx34FMnADdpdWq60EqIPoSmJT9Bw5myMRmqtyJMx3lyZZnurOH/X2bBBR83Oea6fdqwfcUjA6rk80wB7A5vx4RXQTFhkrl+LISAxoRgLas7yfYDG8ZY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(26005)(38100700002)(83380400001)(6506007)(2616005)(1076003)(478600001)(6486002)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(8676002)(8936002)(4326008)(33656002)(2906002)(36756003)(41300700001)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGJADZR3ZhnJ0ibZcF4y2Yd3QTIxZVuc3RI/HIhe4laeLFkKITLs+nqTXcKJ?=
 =?us-ascii?Q?5/4T587EBA4GiKSfGrofHRCTnMnhrG6oMc0zrCzrpvpNCzLdb7bBlKGMgP6x?=
 =?us-ascii?Q?fUaSLB7oEmh0L20b5vrViT3eLajYf642JTUde0UCHvyNAUc89jcAWjlT2Yym?=
 =?us-ascii?Q?tTHUDDai7LMBjNcSu3k4qrI/nIGF/da8GYqDFoLYtdxIe89V85OaVDD3I3MV?=
 =?us-ascii?Q?Dp3jSvvqxankrqnoi9GZR8E2Wdz6f8qkpDaAd050hTkb3sN33H6sfvGQ9zcc?=
 =?us-ascii?Q?SLR+Wsoyo2ofWyR4zO5kgzN5Ab6trxWznOVVT/uvUBKqeLdlW5GO04eHkewS?=
 =?us-ascii?Q?hFS6BpV4mDNz/+SaVJ6VUKyW18O5CqJJ1E17CiVKTE1BSZCCYAvPVvSdwIWg?=
 =?us-ascii?Q?x3l3hX/3bUCF5S+xqjYoKO8rqnIDOvPL+JwdxIt31RiGacVnU5HnWKDHvpEg?=
 =?us-ascii?Q?Gnr3Uz7fsNOgX25uevqzOwBFMqsc7YDFIZw2tZ6GqGN3uoZnxaY9R0Rm5rxt?=
 =?us-ascii?Q?RBqajB8UIY15Xepcy5JvI44lnvBoNcWo78Qx3qXuryuOym6c4PF5wTs6x7Kf?=
 =?us-ascii?Q?KP0z1w3XPUDoLKFaieS3lgVhqMxKuWA340JFg6Z/OjkNIt9PC++40WIhgCDs?=
 =?us-ascii?Q?XE75y6Kgh059jhlRzlk7TfncpURezcz9pZ+WG5JBvxSq5Dqo1HzzRxK6dd2K?=
 =?us-ascii?Q?FvIwgwpXJ80ntqOzZqDIum3iwAQll2jBBSCmrTjSIyVuaqAoXE9XfyAqK1fz?=
 =?us-ascii?Q?s81ZHp5jrHyq0QhtFLx/W5MMqKK/rc8f9xSB2CRVUBcopIVPjdA6nA95h7RC?=
 =?us-ascii?Q?cbjErWt//UYa6DuKetdKeJqdcTiMBPxpX0rensBuDc4ACYvpcnIAE2YKRWjS?=
 =?us-ascii?Q?EQAb3ShNJvEzGFpniXG2rXyHWBISpsvr55tIkAy7BKZoyX7HDgzH8JPJJZGQ?=
 =?us-ascii?Q?Bqzm2C77jiJjaetAJg87Dh1it2dXagqKQ13XlYkPPsogYOzefzZb3CS+egKM?=
 =?us-ascii?Q?ulp7quZ45zWrEmF7YxdNu0NtFHbbjNJ1nSBq74KTvDZAbJ/Uv0cu+WeBDfGU?=
 =?us-ascii?Q?UH2oYyC96pKaxhw+zDgEIAeJng9OK5s1VX8PFQdS9DxuYMHJBg0nVS46QMWN?=
 =?us-ascii?Q?Y0XfZI/XtbnQ9Nw+URhTV5aNxZhr+stQXqEABJpC5lKsh7Lhqh21zBLzG74b?=
 =?us-ascii?Q?VTIS+m2JhRwwqsv2gn5LbXTmf4u3ysgLhEouXMZMU/SWEuVHJ7vJ1LbHTYiT?=
 =?us-ascii?Q?WA9d/EWMnv3pmpS/Y+FHtE/zKFwTIRe3osWMbSPBDN8mIo1Tjnkcijeo6y/+?=
 =?us-ascii?Q?qOungpgGxDcbBVknQRR7nT/LDqu0MJOnkAHOTQriICb+yQyXKqMGcV8NbA6b?=
 =?us-ascii?Q?YxiS/pIFfGZPx3QwvSNl4Mw8gPndI7Gtqm98S5G2Z2wa0qyJb1ipEsvL5g1f?=
 =?us-ascii?Q?UQxlWTcORaMEzodS1HcNvVhCtwaejd5Mxqs+8S7yyYe+ZAiZ1oyx5CqdA7IL?=
 =?us-ascii?Q?gQ4xyZ8wXwW62z/aXCff1pou6PYjqJvd/w9KciVNqtoSWWqRm6oCaKtLgmjP?=
 =?us-ascii?Q?/Nm+V7MAeCeELeuuVMTdeABERG+/CNbLNsoew2g/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb608d7-9a76-44e4-9f02-08dbf5cb941d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 19:51:31.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdOc9T0nND+1hAji4oJe/66EVDVT2nS0k1tj0bdDaN2KCNPCAePq3n+A6UP2vGtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522

On Tue, Dec 05, 2023 at 07:34:45PM +0000, Catalin Marinas wrote:

> > 2) You want to #define __iowrite512_copy() to memcpy_toio() on ARM and
> >    implement some quad STP optimization for this case?
> 
> We can have the generic __iowrite512_copy() do memcpy_toio() and have
> the arm64 implement an optimised version.
> 
> What I'm not entirely sure of is the DGH (whatever the io_* barrier name
> is). I'd put it in the same __iowrite512_copy() function and remove it
> from the driver code. Otherwise when ST64B is added, we have an
> unnecessary DGH in the driver. If this does not match the other
> __iowrite*_copy() semantics, we can come up with another name. But start
> with this for now and document the function.

I think the iowrite is only used for WC and the DGH is functionally
harmless for non-WC, so it makes sense.

In this case we should just remove the DGH macro from the generic
architecture code and tell people to use iowrite - since we now
understand that callers basically have to in order to use DGH on new
ARM CPUs.

> > 3) A future ST64B and the x86 version would be put under
> >    __iowrite512_copy()?
> 
> Yes, arch-specific override.
> 
> > 4) A future ST64B would come with some kind of 'must do 64b copy or
> >    oops' to support the future HW that must have this instruction? eg
> >    we already see on Intel that HW must use ENQCMD and nothing else.
> 
> I don't agree with the oops part. We can't guarantee it on arm64, ST64B
> I think is optional in the architecture. If you do need such guarantees,
> we'd need the driver to probe for the feature (e.g. arch_has_...()) and
> invoke a new macro. 

Yes, exactly. The driver must check. The new macro should oops if it
is invoked wrong, the same way enqcmd will oops if invoked wrong on
Intel.

Jason

