Return-Path: <linux-arch+bounces-2708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74778618D0
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945642861B9
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D812BF0E;
	Fri, 23 Feb 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rLNx5YIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67242A99;
	Fri, 23 Feb 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707941; cv=fail; b=TdDhJIAiSmCf6AIk4i31zzjb3X2wdE7G3ZMf8+o2zwRboD+wUMsBaEYZQFNGm5b4Hg5Qo7t/sxgykjjCyucwdvPqDbt64KQTDHu8387P5RaN34ed7ka4rkAZWA+lN8ZyGLOY2T8Gpr/CRaTecggtyPkD8ajXhxfGk8n2wQQHhuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707941; c=relaxed/simple;
	bh=AlOHL9cdOj24Y01UBT7oCTED7IaqYrmOMmXVAlMiZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P86X+cZV2qZqUDnav33j+SOFMPyE97LID6SU09iavHp4uiy7p1daYZFnnnGPyuNPpRW9l4M8kdySU/gV7abq1vIJPgWLiuHpzzhgxDud+YTThcobj70FFE5ATnMI7321MO9Y1vRUUTzXr19kZnnamCD0icVcSRoP9mKhvCQnqzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rLNx5YIH; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z93LBw28Khsh+QINXJDI6oeWHJlTW7bzOQr0r8Uhp3heng10CrkkbNf6Lio9fgcjGnKnWShrtY0UF2JgZemMgQOlIGhIkoH+yevaiiyi/p+BjwUMGz57Yjy/bD4pva6ENnB+2Q7PGQfLf1WwYYNQrNXhrN9iAnRIfRRguOGXLN4gJ41ACCnvFn1oJXEbD7TAOTYwJJZzF1SjvFHcWi9wYqho68vNqOiwF6vcjf1nZ4gKgR3i5WG6LHYpAz4PoIT+5Qza44MdZXKRKxJXI96m4woqkR4OUB1u5dgkOYX2gRXTCgLDAlQA9Hekpz/VkbY7oEJ1lpYA/ecFef69Qh6MDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa+y4GE7nCNexwBdjHtm88gM1SVFBc7A4bfDCX1jv0g=;
 b=nZLpcf0FBrv87iJyy8788TVMmiRfuGtbaguMdQ66mIe2cLDgI8YmSfbOwdTWQg0qacanWKNhqlaEoIYdYl7bo4jslzF7lQGXjmL1VcurP+TpBkijMhi5snYDt5/AEyuBOPbdWYUzik3ITJgm9aipxr1ktzrOgGE4f3UGFCcHEeHe/epBD/3O9GQM3qCtxFbLTNiZ4S5DIOfURq53pL1xNAWQjPVwAVcLpPmNBTCqUzhWlQxdFKCnAhj5L7fGOkRiweSry+9fxX5uAHVbP54QoOYWdeRCAkTB6VP5TwzHvdB3FiVWF5MwQkEpmJtVzOkXOAJ2Qo+YYiBtXnla5MPuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa+y4GE7nCNexwBdjHtm88gM1SVFBc7A4bfDCX1jv0g=;
 b=rLNx5YIHxbiyPcj5LH7gtBqiRR5kHCKD0hF0rgHmCSIeb4Dc8KNSitJiGJivlg0xCWB7A7wHIX280kZdtJUfGV9SW4FHuQgzU4DTY1uAlzbolQVz7zblSS8NHf3bv5gn9Zow2vHy/VL+W6ABfZ76Frvul0fKMyJgNUugH7jOjkxNWzqrGknlt5cKt1118R7Bb7+lWdtJY89P4unrtBeK38653Di1bxg/tKscjLjfEFR1c1MvGLtSi2NVH07wXJzgYzeSz3RU9HFOBuY5G5XWrguvBTKrDw0/BTMr5STV+0fKPZHzsGC2OJXAQybeQLves8VgxEqgHMSPD6eF/qYTWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 17:05:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 17:05:35 +0000
Date: Fri, 23 Feb 2024 13:05:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: David Laight <David.Laight@aculab.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
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
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240223170534.GI13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
 <20240223125852.GE13330@nvidia.com>
 <eea8b03c20fc49cd88b159959a589f78521ff53b.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea8b03c20fc49cd88b159959a589f78521ff53b.camel@linux.ibm.com>
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a33f2-6eb1-4e1f-7ac1-08dc3491a699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wTamJUy7Nnl/T60ivfU8YpouDL8b6CGvSEGpB+APoCV33C67fQRsf2bDiyDK9SLbcGdtDfG1+MWVT6rPzSEOrg8DomTlIPgQjkmx5hQZz9EyTtSRSm6S+W9s2u5KjVPVt5BfsrtXrVlVzKEmiu0FUzLScvKjMFmIbBNT341dJj4RyWJF6TBxEvG1f3uyXQQxO33Ld6tUQmawd1f51KzTMwjbUp6D1puBk7jXh7ri4lobvhnLsV75bnmdankDk+H5/H5yjItd8dSxYdrUWshqU7lwH1kpLjaQ3dCe7dxfISQ0M4oN6QOc4gJjqkSzqvexKdjM5QyUZcLQr6ZbbwTD/vW9YymT1jtFD5+H6PmsjR1FKEOeM3VpYGnMETe4smuyzu7KPCpc9XsQlT6e05wtmZ6Dzw3BOy1endEIKDNLU/2RbpBKrLeGWufviGnqSUXAga9k96VxiGjJrsbq9t4UY69USzRvjsJ65KW4ePRoKYCnbleFCbfTRsMSP/+AtigNL+4p6trqJr8G0iTyiJv4iPI6eFNtT05cfSBVvk24uCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wyUD2ldt12elJi4EiLooqNScdlyaE27re82/CoNDSJQkAs35tqpFjiXU9Oz?=
 =?us-ascii?Q?UpqkUvubD60LiGFBUdkJw8fMEsWhWj7wTTLyxr3waB2aTJ8PgWmvyOLd4f/w?=
 =?us-ascii?Q?fwiXsfLXMS5YjYJDnb6AIeWscOolbIGODywn7k9MvuiauZCWKSFNg0PM2AuX?=
 =?us-ascii?Q?+L5/HmxovK5CQ2mQrB2O6e9zknBEf9FbvOo4X3Yiuy3Y9HdTmTFfFf0D3VN0?=
 =?us-ascii?Q?XvoM3gSBIcJPppk+FIV4A08BGipYjF9ezBqL4dQ5y5JkEawEdx0YKcJdthuF?=
 =?us-ascii?Q?aRloZiyJ/nP75bCgg4il1NcarxmLNRXLkTeU6onRFPzxpG2Dcb3YUyYh9+AY?=
 =?us-ascii?Q?EWOrZ3dfI4ACOab1kuTwFS8t+EwUfzzflzYB7nfHrLQPwRJ0pRWXDsjvZc/R?=
 =?us-ascii?Q?g+UXjKivsYh/Kp8/XqQ+gSu5P107l9jSSzxRfAzRIJ9DTcbQmdG9PUSYbZis?=
 =?us-ascii?Q?/xir82pGCKFQsYvLfJAVUZu+TADdJKUWcadOzH6TyCKwaIJg/Qg7+8V2LFbD?=
 =?us-ascii?Q?vB8SNBdu5iG6OAFaTXbbfID3Dh0Ooqbt+/Oof6C7NWDd+AKvpCnmUcv96ydj?=
 =?us-ascii?Q?zzLDWnCn3DPf/VmNezxRsizxQdztCn0RH2if3HgzecbzSW4oYQT7ndEB6RdY?=
 =?us-ascii?Q?4brMkEcqnqfl2qikvZHD4YwH9ZY+/DHMjOwrX8eUiSRbb/SP0u0OlWx+t+3I?=
 =?us-ascii?Q?3A8G2YzRS49fENkSHo4sMSiAFD7gSHAchHBd03nL+2du7TyNbp5Zf8JTKLQZ?=
 =?us-ascii?Q?dzloi+c4kbiUWAWChluMH/2f9rjegp9vz+3ORN1KO6MdnvxlDa5T0VltvbMK?=
 =?us-ascii?Q?xEw6JlTW8xIy6xtycTAsGcBx14rfvdx437NbkYh8v51jDlCKF6OIhtP6Bi6+?=
 =?us-ascii?Q?OG3qKMHx6Iv0JAMo48FvSw0+c+KyDsDaQYsUml1EwiqGo9dpgNSdfVN3BqCD?=
 =?us-ascii?Q?8ridgBWquTQy525sYtmbyfbC5jzCwRAp8H7PWirgI+hbAsNW3ERwrlRTmym8?=
 =?us-ascii?Q?y2negh513LB8W9csq3zqFl5DYSKiWEHdezu0lHY4sA8vYgYiSKz5ViDBX19q?=
 =?us-ascii?Q?q/NbWC85UV2bumAuYMVnoyUsYJkbC5wwOzTeUCgbnCArGUG9Ja0u6Xr+HP0+?=
 =?us-ascii?Q?CPZ6WHo5AGd8qqafrCee3cKxfM/403oegGz1rt0pu5Z76AWBVAAgEAuAL0+T?=
 =?us-ascii?Q?eiAS4QulRBHtD20iWTEVI1ndEuc/HMBdH0u4BsyH77bCy7iR0s/f4V2I16ez?=
 =?us-ascii?Q?IEDmcPYDp+CURwf032ylbXvQlfhnFbk8ApUVPWKCvRy6LY5EDuM+BlgcvSgu?=
 =?us-ascii?Q?U4XZP5/949C225odOAo0uD82h6H/XLvMDQyli2f1T20iOodxMe2B8/XMvWNn?=
 =?us-ascii?Q?97ONJKJjzwfKxM8ruN4sbyphvulSNIYLv6fBPlzqBB6Ll1XjxSMa8D+gISz9?=
 =?us-ascii?Q?RqtVg/lXkjppgNNHBc3s6SotG3PsTdsvyPWfriyoZQ20kHB+Vy/axiZHcCj1?=
 =?us-ascii?Q?RQKfrzpN0pjVYmoYYzxAmKkMnJ3CgC9URAczqTqfACtSwlQfhOtQ+CnL3VNn?=
 =?us-ascii?Q?ASgrLE1tdn0BAroBSvQ5QRXvKFc+6T4rVXSu+/YG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a33f2-6eb1-4e1f-7ac1-08dc3491a699
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:05:35.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8pur2So67LET0MDrSuI5KGGq4b15i6plur92OMfdhGpN3P1SPOLZT7uuv2blepd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471

On Fri, Feb 23, 2024 at 05:35:42PM +0100, Niklas Schnelle wrote:
> On Fri, 2024-02-23 at 08:58 -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 23, 2024 at 12:38:18PM +0100, Niklas Schnelle wrote:
> > > > Although I doubt that generating long TLP from byte writes is
> > > > really necessary.
> > > 
> > > I might have gotten confused but I think these are not byte writes.
> > > Remember that the count is in terms of the number of bits sized
> > > quantities to copy so "count == 1" is 4/8 bytes here.
> > 
> > Right.
> > 
> > There seem to be two callers of this API in the kernel, one is calling
> > with a constant size and wants a large TLP
> > 
> > Another seems to want memcpy_to_io with a guarenteed 32/64 bit store.
> 
> I don't really understand how that works together with the order not
> being guaranteed. Do they use normal ioremap() and then require 32/64
> bit TLPs and don't care about the order?

Yes, I assume so. From my impression the cases looked like they were
copying to MMIO memory so order probably doesn't matter.

Jason

