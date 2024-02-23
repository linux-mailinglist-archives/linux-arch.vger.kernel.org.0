Return-Path: <linux-arch+bounces-2701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECCE861232
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6648F1F22F43
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3E7E571;
	Fri, 23 Feb 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lF8UW752"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E71E4B3;
	Fri, 23 Feb 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693393; cv=fail; b=gwcjD+qamloUmIaUTMhqpHNrV1/HW9Eb3j46VS3YIkPr3xE4CuhoJrM5AN13qLiCWY66SyNhU9cBDD23rxmunuJO7GN7UBErSwXbkgNtG16BRv+CFm+MnApJuDQWY6yq7VMrhVUvlu3N6ePC8CHIvIvYPtaXlxPk8NVYWIuLBZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693393; c=relaxed/simple;
	bh=EGaTAgnyah6o+/M2lVP+MXDHn21HPqF9QCP13AtlISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aS05f70pUMw0ZFPgP6OKeWmZmKLJ2kSclBFraNS7D/guhYa93Sb1uN1TAA+ekEoVSG5fwUB6xfjB6IQVwf3Ei3sc2wUH18JgHUCGqF9Yg5m0mI3u93JTeYgwU4VpETi7pLjiG6+YI1aeksZJnMIeijJBwBEMjXA/zJTmBUsjArY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lF8UW752; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLqArQMpQz6uGkvbIMcEAHFzjNRuVm9rph2ZsWHG5qmmhdpghx9qcw5z8fWmsk6blDjMJsB10E0ionF5/QCmgPkzW1o5gdgQSsX0PGypZiHYBS5I/VxfSr75dxIWZP6/QXLL8GqAukBU64ZOYWOk1Ao978vhk8DQDlfexkCn+OO+PfMcnzfp1nhoG1/8yaZ25vODcykKT/sT/+jIqSCjL4e7VRCdLus4Vh/l0VzYF+cK/UdTRmZFK3VGSk1qVfRs8eoqHq/hdmLBH0bK2wQD5BJm97ZGDS/8SMDUns2HNBaMHztHmub/ACCO7g2re6Bus/fhSIyHZ9btgLhSKvOKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGaTAgnyah6o+/M2lVP+MXDHn21HPqF9QCP13AtlISs=;
 b=icvNYOXbHvtUXGTE93ZczXVRm8UmgbBCbxIlx8I0Bd52OyflHUbghM9cftrCh1RteM1OIa2qBpoQ/LaQupWpcb0vkNN/HuUD43ld4cAivI7RYbQ2uVy3mvvmbZqNT8kDBPPQVpvdaalQr40nsB6JzJ2qtJ7injZeZ+vTkev6441K75zE0AWGYsOqebQwqXMj7mH6L6/ekHJzbodLLWpvam/OH06at3X3e+zOzDO8Gyj/A2x78yMuFJ2YhVjedZgLEXZowqGZ21mnGWzp7AJqpZbf3rQKuV77QTZ/vfQbnxcKcAR1p5PyKMsSzPgQrl6oq3SJrJb03UnWcpjrWCySLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGaTAgnyah6o+/M2lVP+MXDHn21HPqF9QCP13AtlISs=;
 b=lF8UW752bhnuIxuFPPKHiODGRY2jg+pLm10mGQ+rYaPuV1/T96nW3NYqLUKYwJpDbWdcqSyYP42GEnQBMsK8HAaCPvJPyCrIegvwc9D5acOBEkH3oSBJtG5tRQ3TTNck1gaJdNHEqOXEXKpwGkykKbPX60kboCx8LTp16RZryMYrZKxl59BZBS2KEyhjgtJIMD2SjLHLUA9MWHsi3ZWI4+HJ+N7I98de+9UXWAORl1FGgDVcAxBONzdq0TykL9dGiaxLfwvIJmSKZNrXZ9eHuHR/mfTQz1W0m0MyWvjf1xgHbOuM07Do+K30uP/fCN4CSwJrQqoypLdrSCyy3KBeVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:03:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 13:03:09 +0000
Date: Fri, 23 Feb 2024 09:03:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Niklas Schnelle' <schnelle@linux.ibm.com>,
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
Message-ID: <20240223130308.GF13330@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
 <d4150af74d7c45b79c770cd1c5d8eed7@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4150af74d7c45b79c770cd1c5d8eed7@AcuMS.aculab.com>
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a85300-5cd8-4010-158d-08dc346fc8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hH6AE7yl9MAqM4Vsr8ID/3zHQ8BTlIs7QHHbizXfjpi0jVvJAsgHm+mGjS+X1de4oXjh+LtZ5jKjHI7V0849Nq5JIt9IZfKnUIFB1r+8GfQ6sFcsIY0Ad9Y3eDAp4UNlzxSwJ4hYICUvEUkaQhYf/dp86rbN94LQArdF4sFXmLWxZdwnDjkeka/auh0dN6di+yYDYGu6ifmyCInn4+Zflxl3W2od/1JQYXzWG8KdboAXI17+ssl/Go3uThUAEHaF1KWQFRC3euCgh8MK3Ef6X0hkwVghIETpGTORflpDJWHMt62XmAotZdtQhDoDG+r0d8EH7K53/9dAmBFSMUrZ5SaBkNlyKHLqTGRF3/WrnYJMjX0O2VSAgCGB6chLqbrbq0fknBloC33/+gcDjWhZKVsesuO3IcL+6zBPhe5xVbJtQDvVsbiLkfEyte79DzuoRHpKcbg0ukUeHFfgHq/LVWir2uh4+Yzbb/mBr7ZsyODbVovAWFWfPlRcsD3DrI8MQw16POSPdkvV+sx5cvHZ7WHQcjRydZ1pxlb29q5kMyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xzq+jV1/AdyYEzgCH6IbIoIxgpvyc37+o4wjUCBkQG/xsqPn/JCDeflSrYwV?=
 =?us-ascii?Q?aLuSyVf27Cuy0Bgb/gfwtCJjO8uk26hDlB3tfMs0mEhjwwahASQrOiKDhaK0?=
 =?us-ascii?Q?i3ScDgIhGKK8WSxO2LVrnScQYB+67HPL0Jf9CYvJ9EP4yS1T/+5RH4n+h06T?=
 =?us-ascii?Q?MviuGuEaDPiSOSSG3xg7GocYX0J794qYLfQeRom6pafwpknRYfGYppaGQplF?=
 =?us-ascii?Q?0MfxYJqPUULQcyirjIMa15apTj6K880qkCGjpFMlbCpEnASQ4ROjv3tSvEjU?=
 =?us-ascii?Q?GUm4RMdxtkQU+dEDB8JcbmzYoq4vd3y2TS8Ou2GDynTVJcX+GWOIRM2G+oLE?=
 =?us-ascii?Q?s/10WZaYP63+l4YFepQ8xmt0wRB1Xo0xETd5p/Jo+WhLo8nwnJ6L08P+aS8u?=
 =?us-ascii?Q?PrZ82XNwr0bU+tnmCg4xmXvu6o1G97+FoC5ILzY4okIhaUzR9ZfVhUTkFvp3?=
 =?us-ascii?Q?akY5s/2HZB2TxfhgDRgvr5aM8UuQQ1hC42kGUAdkD/UXxwYcgAuQmErstUm9?=
 =?us-ascii?Q?0EDaRidqbmLMu5o43fZN59cwqT2C/P7OoJKrcbb+YvpqNhga0rFeMuvS4PYR?=
 =?us-ascii?Q?st0MvG0VhZkinFb4Xe+fsjXpMIPsxojPh3qyZcLSoJm00v9PsSX1dGkIojmR?=
 =?us-ascii?Q?gwxGekYs66zLMRPcYAHEfTA0MJEosfJLadaWzYi86iGNT1iLEeG9KX4cq4sT?=
 =?us-ascii?Q?eXfKxSiMef4fQgrQAD17VAEW2O4MgvIYk+PAmK3sHyzbqtNdf/R5+1GpBPR7?=
 =?us-ascii?Q?m+clN0pLQnnlKVfjbIVfc9Ez5DezEqxSu8+crzrzds7g08C8SIt6fHI6z/4K?=
 =?us-ascii?Q?i3Y7uQO1PIKmnPoGJ4dSNepaLNskMpdpPlX7ymC4CuhcGqAS56Z7HxrVPqTp?=
 =?us-ascii?Q?lG85mubEGEXvxondfkQFnCDpDzDE6fGGT4oojqmCMFHpxVryUjB5yhugP7Mg?=
 =?us-ascii?Q?Wx6nPqKDBRpWHdzJ4l+ou95ezSd890Y+G8BfIgd6FjmSSTXJq+8E+UTyBXeq?=
 =?us-ascii?Q?7yg1HFy/CE+701KmWlqX1Eu5WwLRoFClJYTq8E8uWB9VTB7bkdaxnWB9Vu6T?=
 =?us-ascii?Q?FY8ZrYt9i8uUKKpZj4zVo4MjZ6hs8wH+dMyWTjIrnlkV8cOS539wtlcgA2Rr?=
 =?us-ascii?Q?w7PNBaZBRSx2YXlzHIjZJk0xWEqy0DKn+hC+b1dTMJiRl/JPiH8hJu7RFn8K?=
 =?us-ascii?Q?THBgcqX+6jzD8Rn9vVizvJN2aKChucdwUHbhUwVU9TXdKg1caiDFULBKstjC?=
 =?us-ascii?Q?LgoV7JxG6AcDwnN7Pucx76S+k8W0sLRZ7F/0HKizntJxtTDd92G3yB2eEnlR?=
 =?us-ascii?Q?46TDzU9/Tc9msWLlF/VoB7SHQ6aYoAOl3zG0baWPPEBNJ+7qlNl0/A1gBItL?=
 =?us-ascii?Q?+aGQ20IKiNCvknetVY9Txko66DOGjuNpq0gk4J9AA0ZPDlBtNgUcF/Cwe5kO?=
 =?us-ascii?Q?O1ikZrqwwNQe4DZAUTnobhNdf+CLz560WaRQlOgnz4X8iyJluVgPWCamawBb?=
 =?us-ascii?Q?Ze/zUG+bfVIy1hbYS+avnrMm6uxPR8Biv6VqmgPvh/EkSS4cmyE2U1Y9eM/6?=
 =?us-ascii?Q?j9SleqzF4RLKe4yLnBDRQZQGXilJmsOdcCFqUjmU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a85300-5cd8-4010-158d-08dc346fc8de
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:03:09.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqmjENjDxJCvKcPyXIOn6rJ3/dyDZx9PF+7yLSJOAkYfIV4rhNH6YG/CMLMjEdnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566

On Fri, Feb 23, 2024 at 12:19:24PM +0000, David Laight wrote:

> Since writes get 'posted' all over the place.
> How many writes do you need to do before write-combining makes a
> difference?

The issue is that the HW can optimize if the entire transaction is
presented in one TLP, if it has to reassemble the transaction it takes
a big slow path hit.

Jason

