Return-Path: <linux-arch+bounces-12778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE05B05946
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 13:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F17B18995B2
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C32D9EEA;
	Tue, 15 Jul 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TGK+bdKH"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86125BF0E;
	Tue, 15 Jul 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580326; cv=fail; b=TfUqXVEVsbLimoD+a9X9Rn1yJsDPFZ5R3T7fBG3amQ8y3Q/sXYg+TnWoXm4uXAt428s2gPDYWtQsRAKJszHWA+bPEBfv13VMvH9/ynaxTpSD+je8G//WTHeKFr5AWYRbNjpxJbXimVRPzwzhZqUaCuz9tDTp0Y5IpMPqniInGfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580326; c=relaxed/simple;
	bh=edgAY/mO+l4emHqHRnAPLCi1doOzV01eF7Gf7Iw981Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGjq8b73Jtq0RoYQJRkrWgVeSlRXqU/2IzkmuZv/YPW5liQnlFo4UjwOOfFIUCQLblK1mZB1nYa9S9HLFh5/uQxDfqCzHyfRP8tey2wvyLA9g74O8EkS+56ObtW3SgnpcvNFc/XsqMlCTE/PHqAytYoTm2Qfo9TGnmLVDxY7HUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TGK+bdKH; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf4bfu94ct3+1QItPDnYLAkjDuOlBz8J5xma5sRCGdnnlI6/yGmMlPcvYvLtcm1EFz+sL4Bv2bBG7Jp1coyPXiT34uoVYyEmFwke3Qh9vVusH1KnmykbUSgIQosuuSlZodSBolrGwtSy4PjwRcYd9aSCmSHk5C362o+iIl2u9eHlMydvbMo80G39ddukH/aGez3ZFIcXmmmtuWlQ07n5d/hISoeOyABAK8GVRwR3m74MS+rLdKrz7zuw14JMvZUOpA/quiI67+OUZaAbqCXsixC7MH2giOdExhuj6JdR7fc3GajrMBqndxkLEbJfNSfMxQvuktuVMkaO68bnWdUtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfkUolST63xQOcpWWuBwE9NEWrbBVDZZR6miTU67RDU=;
 b=MYCuCgzbb0MBFIgMINmfVhmkErn/IgQT5ln4hWJJTJo78xLY0HVjGZx19xaO2kxmj5x6G+vltH+9NaqAar03fwsLQEeSCSfvWHhcY8jbob+k1J8jAj7oqSSWrhAxPXwyvJsexQhaavWJAUEhQVCSYlAh6t1oZ7dIYqYQXcpkX/2oe0NPKtLHZtwZFNSNyc2+q6JXPjjuReSHsDNZPo8LTzogySzqCotqaLAnBTTO+pFrAYtCtPsHbZxkfGcR0R2kBD7YKJwzVf5Om3Odw9Gp7omESVTtNYPv3rvNEtd8FwSyR+n/V2RbphEcCm9oeVbl9hJrFFpO88iBWxVQ2Nd/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfkUolST63xQOcpWWuBwE9NEWrbBVDZZR6miTU67RDU=;
 b=TGK+bdKHm+OwNoZgULIKPOOpSwjKwIW98yi+89AOx2l5DT8Gj0wySZHt2u6h0xxL2jwdr8emZ9DG4gUL/yPJxerKlDb7t3f/xOiLd1WlJVO9KAXeGDV0kTN21DvoV/G4uevdZS7vJzGOOoKPpg91WmEQI3b5ESyGNrNg52OngyUrhkecfh6PssySra5/tykjKzthq8OA26Zq+8MXAIL99CuXcJUItWdbcwVfyIb2DjbEJ7Cdbn4RLWrCjPZxAnjGj0BXOFGsG4tVgHQ316DlfnJNVpEo+clgIvSejsKgKmftYubPAm1ua9Ckh+Gp4k3/KF7zVhnCcHpwJspEoIcPhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 11:52:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 11:52:02 +0000
Date: Tue, 15 Jul 2025 08:52:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <20250715115200.GJ2067380@nvidia.com>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <20250714215504.GA2083014@nvidia.com>
 <aHYqPRqgcl5DQOpq@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYqPRqgcl5DQOpq@willie-the-truck>
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: e82663d4-339a-418e-3414-08ddc39602fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6rgt3Nem9c3JrwSbbOTUebS/Y5yyPzNtb/MNzBKPpq7VcyM/euVBk/jmAlz?=
 =?us-ascii?Q?QgLYTVudTmfPYZAV5X9Ro/Xg8dIhrcEZWq98IeN3XOtnhcfOzOJHKQBLvKWA?=
 =?us-ascii?Q?fLZwedloJiTzXjoLYogdKcmKcA+7jWlmpqcrnMnuHVkbcfZDgCW1rgrnZvR+?=
 =?us-ascii?Q?jfkA7GSnMMd1XPFP5dGYoBz4RmJ18kUrB7rxRi2pfnOpxHDnof2gJmLBaF6y?=
 =?us-ascii?Q?3u7S+Y/PqJN92SU4qcel1CWqCHCjsVvqiltkyNhkpz3Xd/UE3oudtcLy/g1w?=
 =?us-ascii?Q?Kh9BhveTsRrG/5W/gagsAGZ8tY2yF3EwyPmXJYPYR9ghG27W0z7CeetVCqf2?=
 =?us-ascii?Q?hgshMoTOnKS4538gqOK7jCJoJmtrgNqVL+sEWPSsnUPhEzP6r/DsF5cA9gJV?=
 =?us-ascii?Q?ZG6Xz06vNbvcVONlofkyQR/as+GDEznY9Sdx0DJ30NMFbgfcUJXGNKkeKBJQ?=
 =?us-ascii?Q?wJHjAIPg21N19/QN6KyC3buxA8p8ElkfU3uPPANZK/QyLIEhZRRt6pYfs6gT?=
 =?us-ascii?Q?wt2h//As4Ra5TSgnAoZmQaAjQl307HrUNyka1uFCiK0kGuEEk5MI5nZPG46m?=
 =?us-ascii?Q?9QBpCeTklZnt5Daeaz3N3c54Dnjh4VlUglHAi2PEsngisj4echtaTOyo9++A?=
 =?us-ascii?Q?FXMZy99rMd8AAwj0QRtS+aizAKpF7AqdBxrMNp97njOYYbHYgFEhvOmbqfn2?=
 =?us-ascii?Q?IpvpqVAUJPjXr8JYI/Nb0bkCa01WPnIZIaZ7gUM2eW+GeC9uAcdeRNAaKZze?=
 =?us-ascii?Q?JhDhgADEgwSNQ7MscsMzJHZYDCBDUwQeLtHxbwiSVZf1tTAbU62RxfmHpioD?=
 =?us-ascii?Q?w3eATam1dHS1Y7/pvYd3koAXysQpk9r1wn+8ilfk/ROVUYlXsKzVxe7cx1mn?=
 =?us-ascii?Q?7XedWS+KOaCp6DnMkW+Isq5Cj+Oxh7U96B/qIx/Et8jIuQr0sqiCHVpKC5o+?=
 =?us-ascii?Q?NnbE9BfYf3tAuFH2rw03PdcXRt0YdDsw5/1Cd/cU6k0Gqo1OokNt010dFrAa?=
 =?us-ascii?Q?jVci+lDdJFbZZuBithWghQxihOHoDRnkt3ztdxMRS5bw2EDnhUT5KQlbuV0s?=
 =?us-ascii?Q?OZkynv1tymb2Z+mknX7L+LzVjhFS4Ms/JRWE1WxRmN4kNbYLYLrHAwuzMYk1?=
 =?us-ascii?Q?+EGOuwpY5GmURS0q/SWi7QhJ7ndVp8/8eqEDJjggwtD5ysgsbU5fROddw86V?=
 =?us-ascii?Q?XB+niM3UGEmrtU9TBbr+q/1GZVzMXskbNUYK1LN8ycwsqBsi/bbGTeB9GtsS?=
 =?us-ascii?Q?iP/tqusH7jve+qI4m8oTeCUS9NLla7WAu1v5y6cVwbyC3iOHivd5g6Q6FtIm?=
 =?us-ascii?Q?ol0c06htni7m+jC4ngG3NszhvfVKLToVQJwuW+70snhsxjWz4UufMPgvsUv3?=
 =?us-ascii?Q?CDYhuLMH2PuqAlEgqPyoGLdFrRL/G+HWWCNQRkz9/PygOOdoUQ1WAgV90Q/b?=
 =?us-ascii?Q?cOQXIUVOdlo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+Vi2p25kpu1TffEcCGLoYK0H/mR5iZ6ZUGyn+s53c0XPK0apFs1CGeGgXHO?=
 =?us-ascii?Q?i7jJec5aeOA7/9IB6mZMe9CywsL5offIYisRJv99GV9EYryRhoTL5sRsnC2O?=
 =?us-ascii?Q?XWocvDYF/q5PDV3334/aiEf+sI0dV0hxpjHvnVemGvewDUYL0H17wprFOWSA?=
 =?us-ascii?Q?13IqX1J/OimepTm5myD+wq4cbxU7s/Zm29b8PqWZNWEPKN4nPzcH/BsZH/5j?=
 =?us-ascii?Q?uehoW/NK6rs/q+yJctWM7NtgpCCEZ8h50anueYf9A5FvSd7MtwDvHoUcvYTM?=
 =?us-ascii?Q?udOrBbxR8lx32C2OvNC9QLh6/bc3e2wZIjU4IlqmPK3fn3g3znm3pAHSfvAX?=
 =?us-ascii?Q?JV6SeLmPv6GIxqAxFA0BCWZoqp1h/9c/szZ5SYqRATSusdMe68ASuo6NV872?=
 =?us-ascii?Q?LvrprfLzhffATzwK3pzn67DfJHZxOO9OEyboXW4uYoYh2hwXJleHNx31OHyn?=
 =?us-ascii?Q?8Z7s6n8Abg4azECNZq3+Cb3vUMGJPn4q9x5ix03oEOivpR/fheZPtHgtJHLH?=
 =?us-ascii?Q?UJmFVG2gvAnKs5bBBoAUOBEWIimvSgpKOe8+R4m2C5NUgwDgYgio6R84zH7w?=
 =?us-ascii?Q?tfBgJKx/An/3Tqg+xYHhNKY90X3FprzNtP3e0VJubXlD0aa+6IULhOmXf56m?=
 =?us-ascii?Q?mIMPZeqgfH/CV/OVT9akgVDbEO1Q6LPzTrkyXEOMIrHTE3Pw46PoWxSzT4Q3?=
 =?us-ascii?Q?odOMaTOeKD4IxHwX50ER+NIQb6v3nWgkazbFlylzRSOmq+zZ6IphIEm4D1kJ?=
 =?us-ascii?Q?mHdPGVPVYAHLBu5XSmnFoTCzRStqq22jqwj0phnr4dSmKrXJo4lm5xCaJd0e?=
 =?us-ascii?Q?YSxmEcbRderthYVux8iI9+kPwaF2cCmUH3pXu4ASdRclw4sqV6PMWK8B7b6C?=
 =?us-ascii?Q?2LM7DT0EuAoP54sc4fJcBr3SsC3SUx6wJEa97cvXTawXCurCAV/QlMLcZzeP?=
 =?us-ascii?Q?5Q8UAawBTbWfc4lk8ffaz+9iza0gyJLd7mAjNm2Pl3cOANbYYhAXlI2NwKGB?=
 =?us-ascii?Q?vvwQyLvgL8RJQYC1p/4ud/XIk1ATFsic8+si+M04hZtBLELMJNZaYU6Mpmp8?=
 =?us-ascii?Q?Rt6/6Fe3N1toYoN+3L5jifZYzSpqiQN1X1mKak8yL1DDVN8jodwbPZjA/Pzh?=
 =?us-ascii?Q?eKoYyCJ/aaNIdxGd6xcSaWVyLeMBIYLyercpa0g1//2IOCqpV7EPAQXVHhrz?=
 =?us-ascii?Q?wz9VFpDWmnaPln9hzaJwLyMKd9OvYmD6tSe5I62sQlFiJ3ZLC26gyWrXfgCY?=
 =?us-ascii?Q?5ZGl2QW7Gs4naBxYhZz3MrG35fl/END2j6si2tMGoFku+/BgIiIGcVvd3wd4?=
 =?us-ascii?Q?YinfrhHsJDp849wmYIXAKgIm3e7r05lox9CeV3usCV3U71pi2nksqNlvm4PU?=
 =?us-ascii?Q?a95iaNYVH/bWVmVwZQhmtvyIsblk2cfqc4ZtDzSlwZu/xOvz70qYcVSC1KOe?=
 =?us-ascii?Q?DMNBwLUfMmavWbWiTJi9nDfWNJwoeWPa4Z1fctgz0dwQ0n9iMLfs/a8V0D1p?=
 =?us-ascii?Q?iogsAmu87E60tE4R+TZJAbVv0P9FenSv4tantzWCevt5EX5mpMRpcOF5enRL?=
 =?us-ascii?Q?JN+GrAFvMRCasUi2YYD7BSrcZ8QqN3tfdW6Bteja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82663d4-339a-418e-3414-08ddc39602fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:52:02.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAGfT/IK6zVTgYYp26C2k98Wf850rdkX3hkh5gku+2ulOb5xQbOkUFkXnFXQlQC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

On Tue, Jul 15, 2025 at 11:15:25AM +0100, Will Deacon wrote:
> > Since STP was rejected alread we've only tested the Neon version. It
> > does make a huge improvement, but it still somehow fails to combine
> > rarely sometimes. The CPU is really bad at this :(
> 
> I think the thread was from last year so I've forgotten most of the
> details, but wasn't STP rejected because it wasn't virtualisable? 

Yes, that was the claim.

> In which case, doesn't NEON suffer from exactly the same (or possibly
> worse) problem?

In general yes, in specific no.

mlx5 (and other RDMA devices) have long used Neon for MMIO in
userspace, so any VMM assigning mlx5 devices simply must make this
work - it is already not optional. So we know that all VMs out there
with mlx5 support neon for mlx5, and it is safe for mlx5 to use.

Typically this is trivally done in a VMM by never emulating mlx5's
MMIO space. If the VMM takes a fault on a MMIO page it fixes the fault
and restarts the neon instruction.

The generality was the notion that there could be other devices in a
VM that are fully emulated and using these challenging instructions
would break the simple emulation. This is why the general purpose
__iowrite64_copy() didn't use STP.

> Also, have you managed to investigate why the CPU tends not to get this
> right? 

I have asked but our CPU architects have said it is too complex to
analyze, but they admit it doesn't work entirely well :(

The belief is some micro-architectural condition is breaking it as we
see even neon instructions failing during every test.

They say it is fully fixed with ST64B in the future.

> Do we e.g. end up taking interrupts/exceptions while the self
> test is running or something like that?

I doubt it, the test is running in kernel mode during boot for
hundreds of iterations. An interrupt on every interation is not
likely. Any single successful combine is a pass for the test.

Even an interrupt shouldn't disrupt a single instruction Neon store,
yet we can still mesure a low rate of neon failures.

> Sorry for the wall of questions!

No worries! It's weird and definately complicated.

Jason

