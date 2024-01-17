Return-Path: <linux-arch+bounces-1392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FB8309C4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A7C1C21C22
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75821373;
	Wed, 17 Jan 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/8xyKCE"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D603219F8;
	Wed, 17 Jan 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505309; cv=fail; b=JYOcfALb20+2YOSUIca+rClhBQ2xIu8plUWnmzYZTXmVz34cG2CMgBrJ2qHIfvRKwTwlqOMV7ubOAOuBMTQ/dTXKznVFLBDVN2IX79wLmXJA6oBlSMDc3R9RKpfkEur/UV9FaTZNZtEwwGyJd+PtIY37gljX4MpBfIQuUrO0/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505309; c=relaxed/simple;
	bh=AlUCP9of1Vmq30Vb4Z+NuucKjBDiULouHVvG2Widf0o=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tb84PcCchigVCQc3TNIO5wDcHAvFaovC4zuDnlhlmgRa7esF4Q9Aef9+AiSdbEsSxi7OP7UyJWpGsPZlPzdbPcG3BUtSIaVudQSmrp0U6gF3b9IhepPp30s56n/V3BnRNAOl/gROPNecxVxDEhe5qyR8cSheJ2PtX8WqbbOBevc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/8xyKCE; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7+Ypg6A0U2/62wpP8J964+UW+RsajAbcebNdhfrgt6GoQdDczn/b+BJ/tYNMRbteBqkU13RP49vZBE2GoPsq0UufZBP1uqgeLDsvZ7K8FivCJKxKlsVBqGkKlN6QVBZ6i3G0hbBQRUT7juIYJGDK9arcwOXROYxqYJUQpDuGcZDRcqqDYi/jfHodFy48LjPhp7Ysoq3UMSP6eKR/381nxQSOe26M3dEViO4dCDFn7hEyPoFjwJPeCuSS01QThwePX+bnPEjCUfwQdZtiQ3T1zu++h9++xtuCYrwH2iPMZJ+kM9bc89tS2N5c3yxKS8OGkH4Taioyz3TWKwicL8aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA8Xc0S4sFnRlJr2N13p4BMY7Fv1YVju8Tqq6ZXrC/I=;
 b=HUNhtxcO/CpGGsz3kadD9IVv+uwNCeuIDYNTVzCjsddD7+621kY/98MA0CxaRhURMts8yNlPXvGdfGoM/nPlKSyThXkqch9QA+HJheAedseUzhn9JFXfIz5bzv58dBRjZzHccHwOrn0W5vgKbWRr67K/gDoqYSmRqFEQ84DZCMjuvgcaxcSFUWJajZoycgzYQyEdxNGPGplTJR30TjTtMtaI+WhOF9KutyEHQdTMInhsU1bB5qnOZ0PEcurkIwwqzGibMpeLXnmZveeFQbjRaRqo28BYL5pLZIpFHGlNVxZeATt55qsWx3jp94bwHYvM6TifznhQzVa1bUzZ4xGgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA8Xc0S4sFnRlJr2N13p4BMY7Fv1YVju8Tqq6ZXrC/I=;
 b=s/8xyKCEGhAwsScxDvYxR3vfeWaMXNdykn9BekYPk2fntjapb8Wx5xCdOmm6oIWJU0i1hDqXfe8TnOHXtytBapqS79DAVj0xFNWPkqAkE5e75/tvisa6HybzuuSIYezgi8HKgyzmGGGzaR1zE268SvcGQZKNd0cns1VJL+DA8t4AAQUh0q84amTWQ65ySkv6nTSqeYUuJtXBrk3QivBO73UR0IlyHOlruY5dNSv0B3Jbsz92xpl1oFucUPTanvR55Tvah1cSSPjrTn9YwTsIdxUL3c20zv/fNxJco5U9A7tNz/5JIC2FMQWBIaUdDEWosGOyDzp7IoDlCr38Gc5Zzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Wed, 17 Jan
 2024 15:28:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 15:28:24 +0000
Date: Wed, 17 Jan 2024 11:28:22 -0400
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
Message-ID: <20240117152822.GI734935@nvidia.com>
References: <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <ZaffFMJy8cHOvtu8@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaffFMJy8cHOvtu8@FVFF77S0Q05N.cambridge.arm.com>
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7603eaec-3b98-4fae-750b-08dc1770f1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RriYxoa46KsZBVepM6Qzw5QdwyZ3S4p5VLnZIEaJzjpODqE+etMhiTqG+bK4BAevt9TXQXe66XDKFB5V2nrgsP2VOxzJnpcc7l1LrWLcBGrDEVOruAWQa8tEhR022GBoiRbMbzlIOBMFYVfKqP+R6YsOND2jt8nih0fiGECtJQctjSsUdCBbxdfbaE2WtUWZWYOc/DHwl0iNDw2+4mx5EUHTR5QWZkGMHxGhbrTxSMsUaqem2OFcGCnhVK7MvxFnioQAz+DtK8cw2TeT7H6q4W94cRfwsapSsJw4GC5Rw+yeJxTIJRKhrIfjsQaPY4QwnLK/dF0Cx1xzzeLBniWPIKmnYsxOV3IuEjR6HJBJJZtbAk7VW8MeqnomDL1REs2mnCqTlwI2tIMaROOhS9Gg8rV874ssgjixvjkgwEgrby8/syre3WR0ipWcHqo1moxa/uWflSFfuzzdNQ/3zf+nYaAQh7+4BiiW36ppq8tgjDVoSNyBEYiTenBvZ73Ivg16GxXxx3UfPnSzM95nR8aNeLOfRRN1Az4ddbmYKxv2ENCRW5Q1o5BxdqLgDBfSbwaJfB6biBIm1gV2NPXW13nxMG5LN0XHB6nN1vKM7RBhhsPF8LjBZXzc+y64jAJzANpn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(7416002)(41300700001)(26005)(1076003)(83380400001)(2616005)(38100700002)(8676002)(6916009)(8936002)(66556008)(66476007)(54906003)(4326008)(478600001)(2906002)(5660300002)(316002)(66946007)(6506007)(6512007)(6486002)(33656002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9N7uVqkbHeEv/PItgE3InM5a6EGZthIlZoK14BjKC8p1UCPWa9c08TtEFhmB?=
 =?us-ascii?Q?XfjDUX4jlqB2SdiaGybUe9nJUJXHGL0WgDuUEROCgbNq3e6L6DVikWpbqFV9?=
 =?us-ascii?Q?xUol2Hb2FU2luZ/1AcIae8LFKhT9ob7C3A90TMIx/3OA+J8Kggg7hC0prswa?=
 =?us-ascii?Q?mccpAh77zHeuWHG26jQNhSGq8UgCzIYOq25LrKLLTAlawo6fihWAT27vFY0J?=
 =?us-ascii?Q?P5z9l435lZ6+OBnRU+1oo7Cf9Zg1oCowf9aLrw1byRvLEvgnCmiwdJhLNTvQ?=
 =?us-ascii?Q?Ih8q+eLBjWWLAjOoIzLY0sIcxUH8zabYz5GMXlkEtJvr4llmXXscYdscexMF?=
 =?us-ascii?Q?2xthLkUPifO3cBdI+9Z+3qmGi0p24H8lByqRiwIByrqUsYqAGnuUTND3KJBf?=
 =?us-ascii?Q?afCfCgnKLaoidKqgehdZhtrhWLWWa6ukMoHB2LPaH/7BQx301Hwxp6pn2iZV?=
 =?us-ascii?Q?mnIhnJ9c0LS1f5Ky5Lo49K2b/Kb7PJ6NKQW4RsJAb/VR4jUQ+QhrL86haKXV?=
 =?us-ascii?Q?fqSSLNA7HewnHGXlkUb4yiXisttI9E6f4nZ/Z8jtdmA/hFaBdoaQRlTD90Of?=
 =?us-ascii?Q?JSHjJN+LKOUzF4PzLDs0BZ7DBbUa+mxKLZepEIkiG37sibE2sXRR2cIH4g5C?=
 =?us-ascii?Q?04mXbeSGHZYOU6QrIPKoGRoxZ81I6emeS62jr3+k7v0cToAbwmz86Dhfmt+1?=
 =?us-ascii?Q?EO/5OsmEsEApyK+45Movjv9pCmS3E8Ei9DTkz7XDYUzhhT1Uv4FdfVEGFgd0?=
 =?us-ascii?Q?Q75KeMj8QA51t56utu4j9GlbUj8V6aRlmBc8j5TwVwnbvxrJ6kQVcJypRlxO?=
 =?us-ascii?Q?iL5kEaRySpeYvoq4ewxV1il4Lbgj1ESu4PHGZE9kvkxQD9kdrE8a4tKm0COm?=
 =?us-ascii?Q?x1I6CxfpsftPc7R+cVwGjuL0AQ2+bFxymqhGgzZ9xukbmPkKrEzGHmD2z+FW?=
 =?us-ascii?Q?imRX4gcFDd+tZer3AKJm2NH8YB6EbtRg9tOTLVRXK6cDdFYP+2goveUlIH2d?=
 =?us-ascii?Q?DhUrLn4W6DB2O2qna0+Yh9Ye/XktWSGUv89/LVBlymb0YE2s0OubfED5pTY3?=
 =?us-ascii?Q?mS3u5LA0mQwq4vjMDqI5No0mZxpf66Eduw2jyy5I/ceGB5MTBanod8zNjMGI?=
 =?us-ascii?Q?fCNjb103IY6VAvlXSL6M5Am3cR77U7eReb+aKH3rX+lLGPgajIDn0OugqFnN?=
 =?us-ascii?Q?+MqivnmcOvSEuE6nLhcfVZbikA9BbR5foJtQvGH4QBZDzw1/nw3+TLN9trRe?=
 =?us-ascii?Q?0dxTqhGi6YLjBF19iRoMTHN+LzHN+ZIEy4f5mltCZT45d1dsilRBFaPdtOES?=
 =?us-ascii?Q?ZuFAjN/jmefZYSzO/jRh25fLsAy9rEettlxLY8DB1eCP/X5eicE849Nx8YUu?=
 =?us-ascii?Q?hyz/PB4ZwH6msxdoSytUSBHjsJhsajws+4IbBSYU870oKHKAixAbcCJIDHn6?=
 =?us-ascii?Q?HWzswxvU4jS8F43T51aDq/yKPyAVc3cl1FLDmh1st0FXHeRWS89MYH+JrJgz?=
 =?us-ascii?Q?jXEaP0+3TBBzWqT/S1htzgkIHJNTaLCVYc7tr/ctPWOKRxbq65bQb1RWzlnB?=
 =?us-ascii?Q?oHwH0ev+cWN3O7YWZD9JhKEDy46EqBrsfHoZs1F6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7603eaec-3b98-4fae-750b-08dc1770f1d4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:28:24.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HN2dTSDds6nstl/yE1AdrGfF7F2WunFPhcrcV19rmQWE7tjZ1a0HdIFyP2EptK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

On Wed, Jan 17, 2024 at 02:07:16PM +0000, Mark Rutland wrote:

> > I believe this is for the same reason as doing so in all of our other IO
> > accessors.
> > 
> > We've deliberately ensured that our IO accessors use a single base register
> > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > when reporting a stage-2 abort, which a hypervisor may use for emulating IO.
> 
> FWIW, IIUC the immediate-offset forms *without* writeback can still be reported
> usefully in ESR_ELx, so I believe that we could use the "o" constraint for the
> __raw_write*() functions, e.g.
> 
> static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> {
> 	asm volatile("str %x0, %1" : : "rZ" (val), "o" (*(volatile u64 *)addr));
> }

"o" works well in the same simple memcpy loop:

        add     x2, x1, w2, uxtw 3
        cmp     x1, x2
        bcs     .L1
.L3:
        ldp     x10, x9, [x1]
        ldp     x8, x7, [x1, 16]
        ldp     x6, x5, [x1, 32]
        ldp     x4, x3, [x1, 48]
        str x10, [x0]
        str x9, [x0, 8]
        str x8, [x0, 16]
        str x7, [x0, 24]
        str x6, [x0, 32]
        str x5, [x0, 40]
        str x4, [x0, 48]
        str x3, [x0, 56]
        add     x1, x1, 64
        add     x0, x0, 64
        cmp     x2, x1
        bhi     .L3
.L1:
        ret

Seems intersting to pursue?

Jason

