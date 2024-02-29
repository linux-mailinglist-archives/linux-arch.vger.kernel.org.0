Return-Path: <linux-arch+bounces-2776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841AF86CA42
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 14:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2128B1F241C1
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058007E56F;
	Thu, 29 Feb 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZE38VEpx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB27C6CD;
	Thu, 29 Feb 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213405; cv=fail; b=cBtAOn/S7PzQMr1D97IBE2ueeh6Iuqoad9NZQuPxNyK2niH7KgTVQ3/Bl7OSb+AnPTsVSAWljlAWyAhNxEllej+vufmut2XsVqt5RPtxquqoqdHaBSqtxQ0HhpVV/uLFXYc9srsQQ6SmKKWa+bAOEa9SRZ44QdhFPaKK2G0enF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213405; c=relaxed/simple;
	bh=yKuVO+AAWRvlwrBBOR+ADY/R4/PDdxtHPtGz1EB+YTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjS6F+Lh7fqej7PLNfFr/Dbij7TGE+ElDhiCaWTImv5muVdGj0CZ8fZ7syveOqKpyxzg56nBbNTMw/mU35h07KObHFn9y4g3L2xpNVAb5n+3YvWrqun7kHDNp5MZiipBFZiZQE6cVvZN4FKS14DpAUISOrr+mboux7j3PHcqwms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZE38VEpx; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxsbOCIYfrYvfa6BeQVjyJWK7EeIDABAVukniCHxLOnRS07UscouJnYimWMuXJ1WwAj+UCxDgu8TuiuW6K0jGCMOlFWJsM2/GOERfwW275UnL8ZaGcfsMVmeh6L9yN1yTwVxZTCLWcRCE63OPpIDMFzdDbFgrT/gl1GA+pyrXoKwr2reqnFxotPPbYC/WZjg+Hyq+8vZfFZ6U4vXDMgX5C9/VrEn6Wt6FpwoRYVzeUnyRvEj4gyG9sFStJTd+tuPFiKlsU7TQGNGmr6AKQuyzBicUGs+7qm3EqQK2bbYn+JMpNMTNDKQttEdJL5wSsfYNSw2At3w6gE/XhSyc2i+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSFXHLthkHVPjZugNjonBzQ5RJhCtSrHipilrYMHz/I=;
 b=GdRDEwyH17cnIEFrbXR3GrsrEX7eDCHooQPNbIJJXnNSiyu5OmEypbeSVsnAfX8NH1n0Xvdk40xJL3lS6MmpQ2byqUC/l8QpjzEBdbbgfDOaYsTkucmrRrvLMNqaJWy/cRYpHiiRHEQupPkfvH9PcB+OljhX6lFypU6XDtTCiBbMddIR4xceruxdOV6BWhUABgNiZIiWPbFEnXNvbwsUHXVDaCBPbke/hRQ+9XJ8ZNT2ZQSILTEETLY8Vh1VwMk6bz4gwCynZinsLQ4YqHaRTGxVVyq9ftXOS5vwSphMWVTbxMTm5J9P1bREgoOBPKVZS15C88yp9tluQfA2pjpzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSFXHLthkHVPjZugNjonBzQ5RJhCtSrHipilrYMHz/I=;
 b=ZE38VEpxrTgATKo4GcG41v41iEYpY5TqZTUt5jFcr85lu9NRi2j9J5a1J3ERqalp8Q+SrNzj0VbKBP2K5TGUoUm0buNnOAtY70ubHL7usToESGiuwnMTph6vfEI/AIb29E+O+HMK2/P6U84tCkTCHrvLigf/aV+BvZEYO6PBBzFd2/BIdEPVKVhCH44FOn41VGjGwHH4KupLZfY/ApzDImQG6+MV0N6XW2GM/L/d+vn6rpbuIYEF/Z8Ky+qyfA/3OGC8EC/MtvIJTkxjKfStw5DTmh7G3j8X5tKWEbA3f9Pec48i8CqMDNIPgWpDXW0o1LTMEPHFStHd2dfUqxei/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 13:30:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 13:30:01 +0000
Date: Thu, 29 Feb 2024 09:29:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240229132959.GB9179@nvidia.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <ZeBdYCa5Kxqas4O8@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBdYCa5Kxqas4O8@arm.com>
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: c5522144-e293-4900-1487-08dc392a87d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mzxJ+uaRUOT7v7HWqwj83M60uADqMcJLSY56Bh7o59x9u6HgbNt/6ktkoXebKoOwBsjkpP7xBO//8wxz9FiFy1TYTS7kD05wgTOPBlTNL0+LSKv4nOXO4KRZz5aySqTiP+CRXTXZffzea6PDwMXBUoJDN5cm/Bgn8J4f7q0EFJ4rAheHB0oRis33qccG0bMo/DHINg2j58omlvOW0b4KQMQnS5Qr8fTDEQ5JN3WsJcwmkLIR2VzI0kxgY7xNVMlPXO7f9GKQLXdDEK+iLP4Gl5yS2tSlD0OVvwkjQDOvMtOr9l3TgFhHjKCEtRi4EOtliooLqpYOiKGYesBKc5DRKWptVVe5hDDkkO5S1HsLDJoRc4e79WI4tfPVQs7SwV7Ob1nsrZ1uAbgGRa1FdqOjFQXR918ktP74t4rXTjYpN0uFalo/hYPRnusPEsOAl/1WINlDuwSk3bs/wX0BVtHqbWEM7zKSlRnciXvzLYa6E/6UtG3GzaLh3cu4drxi7bkoNvCSRVBomzChatIe4TLj0wfqCH7S5mhVBDLx2+QSy3Rwg3m9+J+8R8ph3oABbu6MelxR1OQt5LUa0R4uyNj0mYYWPkgOiJiKivEtESEUXDopxYtrVNFmmbLQ5S29VtTz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kLN/fbQIieSnhr28VMfOBlzGLqRtFu44Wt2peR5Neo/c9X03NcGPI+yEQqCx?=
 =?us-ascii?Q?39jrIVO6uTYQLVkeNurIoeG92Y+EdiOk5DDpU8c9ZrD6hBj7vRYNQkx6SPLN?=
 =?us-ascii?Q?gKl0cb0aGU614YLoWQoFdd+u6CDjQI4ck6uxDIAasY9GmGEHDLf6kkcRIOt4?=
 =?us-ascii?Q?GPaa3YatG43NTwvAq9q667ixjJcQj7KZdYtAVq01m5tB0GLykuv2OPSxdz6d?=
 =?us-ascii?Q?kSaC1fgW4oEHUH5t8rggNfby0sQH0GKfCIh4mVDhZ56VaQL7Wap08Uwq9nUY?=
 =?us-ascii?Q?/JTdLu0p8SzpANniKlCt2X35KX541TOew1Jxlhwi8r4z9tGOvl6pDUVtfxb1?=
 =?us-ascii?Q?Vn68RRa3CPiOSxtq9431V207Nl5PmHycPL7w2TjRCGuAOCcqPSMxh1lTofGx?=
 =?us-ascii?Q?DiqGFEG/xZx/0ZfF4qSU9olc9g7NvG/WdaUVQWa/TWjvXGtW7FRzzsrWI9mV?=
 =?us-ascii?Q?OH+60Cz3jL5oP5V56uew9XC/tMjl8dcKXED1emBAZbD/QyOyGhYaei4J4c61?=
 =?us-ascii?Q?2FEq5t807oUhBOKsAwjKQLeSphAJ6epiLZoTE+g+XjYe7xQlWqmdxdlulLeJ?=
 =?us-ascii?Q?jb7G2hbz55RQ5i0Ze39tvr7F/M3aywgFEE+fopZ3d42GsEtB9zQwLvwwpLaq?=
 =?us-ascii?Q?1xltvPhFl6mX13p0roLQzq6coRJ5lTTzvH366ZadwYP6mJrOVdxWyRXl/rCw?=
 =?us-ascii?Q?fBrdxYom37L7pvAzqvFAIGsrK8o2HhDaVd7cJh6rDWu+4piPDBdty65Hx9BG?=
 =?us-ascii?Q?0mbXFvni8ecOK6QvTEnAEVdd4jNbCx3QIxy1ZFjaIt/E+aL7KQlXKR/bLTg6?=
 =?us-ascii?Q?PyJXa/h6jMr+RSOKPODX9K65i0fwItrUJ8tj2SAiNbopbtO+kuchbNrUC3kg?=
 =?us-ascii?Q?ZviftUKboxUH1JZn/lKQM6Q3BWNxsW+VSBy7BhzPx65lJ/z9omUFk+0nQcVQ?=
 =?us-ascii?Q?XcLXY7QB+OueVYAE7T9l3UUhdpNP2lIpbzsQJWO+i0IjbWqmCmHhRB+xGmtb?=
 =?us-ascii?Q?5wkKVWpoxkbZo8kdjHgK430NbRWgHxBDPNmKvj1tnAz8VqIAV5UhYm/HkQYB?=
 =?us-ascii?Q?ozR8hRbK8cWbhMYi+DtA+M3wjRBw11lbQH6Yc8ih2R7q4m5vijKmF2pVMTzy?=
 =?us-ascii?Q?XfzMNqj4qOjpGNvV5rGgNl671cm9I5G0WAUwUt/s9rIhXWnOI3cXGNj4/xTR?=
 =?us-ascii?Q?16sAxz35WnH33MnJ6hfDldSjP5hLlhy3qruXoB4cDCSDmw1cRgJhthgfnnS0?=
 =?us-ascii?Q?BHD8azzpEE/mUkyveqgdKhK4K2cFSVqzJoFfnqR0vWKGBCUHKel825VbtXzZ?=
 =?us-ascii?Q?9ehC25K7UPiVY3jXadYrUV5l4yiQvqwIoS16+ndZKZhO89Y3ojV5WVSUW6nG?=
 =?us-ascii?Q?AOCgylbiIeu+Yp9sPHNKgpJnlIzPucbZTZcFhUeq3jkvwcbI2/YBftAoqU0G?=
 =?us-ascii?Q?/IXT/uJM+aYvVGvotn+5sy31DEYEHUMGnRX3vY7wjr0i/fsfK+dsroUz8bJf?=
 =?us-ascii?Q?oyzJ9+x4pNziK13IgLkwzsPPoDoCfCL/bqKcMezuolfOImeYxBx7nirF9bwN?=
 =?us-ascii?Q?H9mcZTA1OlM8F6UK+nFuZmMrfHDyHjBVyI+35MeI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5522144-e293-4900-1487-08dc392a87d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:30:01.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1HKO++CJfeY8m4dGnWwncW78bfIqugqT9UWdCkWELHJQ5/pu3xfHyX9ieO5z0Al
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Thu, Feb 29, 2024 at 10:33:04AM +0000, Catalin Marinas wrote:
> On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> > +						 const u32 *from, size_t count)
> > +{
> > +	switch (count) {
> > +	case 8:
> > +		asm volatile("str %w0, [%8, #4 * 0]\n"
> > +			     "str %w1, [%8, #4 * 1]\n"
> > +			     "str %w2, [%8, #4 * 2]\n"
> > +			     "str %w3, [%8, #4 * 3]\n"
> > +			     "str %w4, [%8, #4 * 4]\n"
> > +			     "str %w5, [%8, #4 * 5]\n"
> > +			     "str %w6, [%8, #4 * 6]\n"
> > +			     "str %w7, [%8, #4 * 7]\n"
> > +			     :
> > +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> > +			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
> > +			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
> > +		break;
> 
> BTW, talking of maintenance, would a series of __raw_writel() with
> Mark's recent patch for offset addressing generate similar code? I.e.:

No

gcc intersperses reads/writes (which we were advised not to do) and
clang doesn't support the "o" directive so it produces poor
codegen.

Jason

