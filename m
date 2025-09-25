Return-Path: <linux-arch+bounces-13771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD54B9F398
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559DA3BDBA0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D22FD1C6;
	Thu, 25 Sep 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CscnSF8U"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737F2EAB6D;
	Thu, 25 Sep 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802907; cv=fail; b=MdGOlZDGsLRMa32y7EH/UbLfO3ySw2JwywgsKP4m5ncFPKIWSoS8FncKuhRDodOSQtImngzVS8hrQ9eRSUDzCi+ZnspTaELeWVXHfmxlvDzHIAULbATqocMV6XIIcoTwKz0W6uvY37CrzB6jHPNUTrE2ekmfoGz9/gU9Y5Djawk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802907; c=relaxed/simple;
	bh=cm3TG5HPYCvcWiLhRr1hGCUE6g0Zz/qsXwldlf3eZF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eWJAeqjvTVznFZPQrEcVsoN/dv/lhGuP8l3WdtCjYyisFy899bnlYuYv9Gqpf9Q4L2z5AXi3wp6OvGZjyAXNqwy4Ufpp+ftwpfOJ8zrlBcaPu24qMggGRfTOn4tEHZkdJdpJ85eBCrcXjXfSgXW/lx64cQ+NLDCvLyKsBBeVm2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CscnSF8U; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbb0j1YsRx4GcpSxtR/OTlnV1e8G/vQJ1B7Tv/5UTVPhnQiXvHuGzDFGyMU015b+dB6EIvIZJrAVxkbryO3MiQKaVqntDDtl5bgd951DPTMAXQuoAWmGcOSOTyal+48y+mWri5I0dYkG4FWULnvdyMq1fZHhNNdC+hch+VdCiUDmnK9Wg5AJrHgzvxNnQhs7LTZ+2dkEaSAmQ2T2zodWeTor621CVDOZtyANNUsDFrilRAA68OyHawqsO3gi/VBD6G6rm1D/7hktaVReMXDlPM221IIBk5Foca9AnnCq98aND+Y9zPKhNDqxuIih9jjFJsKQu4Goyf8sK+qOw+Onwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX8YkeusmhfTNoEkcfVemAzMql2PPy18BCHSOfBEKjw=;
 b=qEwCvVjeuw61Ljb5EnNv5ryErJGlGxuFVu4QZUEipr/WQE1Xyr1u3ASVqAdMfSfSl5XyRJdYWcYnC5a6CIIHK4DkbAQMiKNgj4NYxYlKactBoMW/XOjyZLlHSOZ2j+4BgaLavpDJP2cVfqxWX/vPXSqKUqoBMD9MD+2qVzB5pSLFQpLk9UCsxQe/iqZtDQa0wMHioWzeavLegiNxwittZreyGPHspkH5/akwWvoG9nODnSY3Cfzk6x6UBT2nO+Uww67agxIHTQvPVbLKVN2ekt8QhqaJYN0NZNBe5QVOTOqBi2lsuSWLNtZwEkQ10qLLZtX15fUK5fEjX3GOKp2NyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX8YkeusmhfTNoEkcfVemAzMql2PPy18BCHSOfBEKjw=;
 b=CscnSF8U6tuSYVkd87XsitfuJtcBAwpB1G0ZqdayQSHvRFFVUZDYY4hKctKpKY96QmII5EJiRrYDH/Hq6SaUNOlU57RFbXzS2sLA5YUUnDApH0R8ZrbyeKdFnuvTrz26h715+4Zshv84rxrPzXo/hZNUHeM/7N9qTK44aR2k+uMv27j/X1C1o3Ig1Qb4awqDasd4cFUq1A33K+aT9DLQHDlsSxp7mIt8yiNui/R9Iie5FLJjbYBKVNLf9i7OF0NAHGH6GeNVVevo24gVtl0jD5IX12n5d/voTXabqcKujbCiMdqXnvGSS36rZ2+/i20MjXsAzHTQOOsHl2/8VWQnsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 12:21:42 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 12:21:41 +0000
Date: Thu, 25 Sep 2025 09:21:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
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
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V5] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250925122139.GW2617119@nvidia.com>
References: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
 <20250925115433.GU2617119@nvidia.com>
 <d548b14e-ae28-4807-9b29-9961543ea549@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d548b14e-ae28-4807-9b29-9961543ea549@nvidia.com>
X-ClientProxiedBy: DS0PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:8:191::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac25156-c1a6-4d4f-84c5-08ddfc2e151e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5JBA2NWdC0qCiOzXh4YtWKm6HOVY2Khju5GHc+7eImtMzR1gIkj8sTPo76Q?=
 =?us-ascii?Q?o/nOktghBmu5uJ7ww2Tqx3nY9iEsnFPAbM7/9YlTeWNWYK7EyWPi3vwc2wpv?=
 =?us-ascii?Q?0mSV5CHPUieeoL4BUndatsTiv0gzKTTSZQ3eq8sGmyqG9EpAK89gvK3UNhaG?=
 =?us-ascii?Q?1Qq6tlD9Pb0Z3dQC5qC7ap799TcSs7xxFyhXVJ1uHQTsrdUWR9xZneuTvWFv?=
 =?us-ascii?Q?9IDIxBcbn+HQULkcEN3zxn17OqMIfVBcp0jH+warLFRNoptfECqcj7qe3cPi?=
 =?us-ascii?Q?ypLwbTDh5i7Rt82pWY9LfmoB5rK2LlUo62NISYSxbuyT+ojy8d/id2S/jlXi?=
 =?us-ascii?Q?AlvpdmxoGn64t7yxeVpN6OezODysl+3Gw+bm2u/nprikx4DAT0qZX0AX14uq?=
 =?us-ascii?Q?VUlebsR30KkY5heWR2O4WhOCvhxofqExrYh5lvvG2vglOgGsSqfArwdAqDPf?=
 =?us-ascii?Q?x6eFHa4zYOVT8RWMRDRvrb5ST89Natt7VWipvu097SC0Pl99bV/KUBUS8Ist?=
 =?us-ascii?Q?ojubMl+/UfwrzNxSPsJ9t+l3qc2nc1MBNveMfzqvMFx6FXxRhQkOusObmu6f?=
 =?us-ascii?Q?vT55Xb5NfQ1DYHHTh1qmYLGdGFs/Jo/18HEHfcpHwLdpTtGZ7c0gg72v8eXv?=
 =?us-ascii?Q?vtJHanRN71BZljWzZasNG2dRIIupsDit2XpX1cdwE7I8ZHk7Jkx4kw0ssmst?=
 =?us-ascii?Q?sjSM6NbfWgMsCfY/pGmVys3TSBO5D0P90753A75+OBYg4yGLHb9K2zKqSj4N?=
 =?us-ascii?Q?HBNRL7BlG6i76OYp1w2wn/DyKX9uJxuquaQi/deHybPr/dApdD93YfEhlePo?=
 =?us-ascii?Q?1ARMpbLvN7vpM9nZj0OzhzqGjKSp6CXg2Xwykuakn31vDjICeBeR689/uK0T?=
 =?us-ascii?Q?TcsMKaZn6beD8eNMe7X/WTPRuLB/tq8/WRX49j7F4796ISx2G7M2Th13gwwu?=
 =?us-ascii?Q?uw7CdrEchwuggmkElYWjmecVtJPV/AXpjgwK6pYaMvxr7Bz6ozjrEerlOaKO?=
 =?us-ascii?Q?079cEakPUsG4AS7ch+c5lAOIngqqCcEFbIBP6AIuxPgMhAzpwD3/tv3Gn5jA?=
 =?us-ascii?Q?e1REEvDUu4VvQ/Ko/620Yym+vr9QkIO1liplXAspiK7Fe+GfXZeo5hPFGZsG?=
 =?us-ascii?Q?Iz24acxP09vSGnQkWFEQq9e3V+9QIB2Peu7gLR1avkARkJrvwm13Lm18i6Zg?=
 =?us-ascii?Q?zkk1l+orEe9CO8T1w8oFaB1KgSsf1dxoXuaYusnzQ1dSAB7Y+vIq2ZjKWrIZ?=
 =?us-ascii?Q?Ca39RFpxhJSX7Jb6I4ne27YaiEjlbr7RDo68ZYTlruugku95quSi5b/bs0By?=
 =?us-ascii?Q?dV7SzMtcbozl0zy5GKDonViV/IMoaWEYAzKk7+osUtMouk/ZeExT5eS/4R7T?=
 =?us-ascii?Q?3LzJYAWPvJNWeAcGgL6CN/Ax1JfuULtVQyReX3GtzeU7fvDTkOItk4v80BSf?=
 =?us-ascii?Q?05zeOqaEg9Ojv85zDrLArVJ1L+doRFcK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DPQUp8U1r+X/uLD/pybdwnt/uDfUASmI41LsIU9ylrGYrOb0KtaL1gRr/5BS?=
 =?us-ascii?Q?xJxc9soBSBa+M/Hn+tlLQPKVF4KdJohu5fbqpMygJlWZVPZBp8cBYR3ou+dL?=
 =?us-ascii?Q?rISSEk0rS0TpKa4C0GTIHa8jCM/z8UVPtTYv8so/Qr37ucRof/0zEIg1VC1H?=
 =?us-ascii?Q?gcVrr0yg2BL0FCEttPWaENyVdZzKjFPI/8Sc4uU8ZxDU+V0iYAb7mVoJyP4z?=
 =?us-ascii?Q?fPVOp7tUknFwofL+pDWoCy7bvcWAb2o5d7JfyyjvIFVh55TKUK0DCvOfrKqq?=
 =?us-ascii?Q?l2+CqML3fBGLSefKZlMCeE7HJnjgQE+qoCeRfHTHnvLUFJPuew36AKrX7rOt?=
 =?us-ascii?Q?qseBLFAsIiffB/sPbcHqHOdLd61QXleLkQWE4lI+cSGpYzKfnPBmKbbiP2NV?=
 =?us-ascii?Q?XfVZJe08UqeDEtolVOnl9HbqZpDXRYDGqWDE2LzFkpHhX9H+2Kg0aWQI+PGT?=
 =?us-ascii?Q?CKvxodo69AwSnN0I+M3MHZ0n5HLNwWvmoA0qCJrVtIwcDdrsLBrFEC+BKjVX?=
 =?us-ascii?Q?JhFdQrKXxk6VyOWVSM+iq0ojqrFUcyhvxOm/RfJo5uz53XBHY1u+YAkrrXTt?=
 =?us-ascii?Q?10LOjFaLClBFCqHte4l3Cu8X3IYnjHUrzZ2TZ5jIxaAbWnTgLUgc2iWZXtq8?=
 =?us-ascii?Q?pdsqJKk+TuDd5JnboMj4sUPrfePa874otcfBFczF6FhEFiNpBZwSCW9NyY+C?=
 =?us-ascii?Q?ymsn0KgsgxyCasz0RKIHm8C88jgF3oPlhNU0zr7Twk06l7/cwAXbGYiZfq/D?=
 =?us-ascii?Q?Q4w8+p9yGiKf35sjWO+r7/hAkmPEibYOm0QTXL8j1nqP8In6sxhTzn3YuHAC?=
 =?us-ascii?Q?Mj7GDixL40WpSn+A8HJ3gbe96Hf5R2ciqu8sCOD+8GDIgX38mD0+jciJo3NI?=
 =?us-ascii?Q?TSXXpUC5OBFeJGd0HoqQfWm55pWarDioRvu6mKrzGPokFmcEa9F2tukI+o/K?=
 =?us-ascii?Q?wipUL57ExZQMZW68BFYFcslUges9g1BCUsnwmqfHqOffHk2k7TJ+Um2eERSG?=
 =?us-ascii?Q?6jdvgMH8jWL8SZN6Gtr4Z1ZVyzFqS8dm+1ZF15HzkhuLtIM3d3RjAGhwPoDI?=
 =?us-ascii?Q?i3T9rEY9kOabDQuAnFL8s2JzmwQUPiwHLfwX0GY37LJk1S0sa+1IOpZ5beI9?=
 =?us-ascii?Q?pL75U2fW6xKpmgppZUFze5UdAW3R4jNadGU0InnopqLKLR+uUnkDjlRamWeF?=
 =?us-ascii?Q?kaQcD6BSJZnKf/ph9lzNulJD0/7xSk4cpAcxKIdW3wG6eyl2vij+xVW4Fvap?=
 =?us-ascii?Q?7ekClstuEa7Jh5hA57Z3e7siwYPZTZK/XPm4PzUyjutC89A0GedMUQcOqxJ6?=
 =?us-ascii?Q?wAhfmukc4IT+dAKsYCdAEV4nmILxjlzgYco3i3W2h3DU7rYybDU4XDTmsoYd?=
 =?us-ascii?Q?I/xBGXjY8iuqgrblFYA6GFNVBBcDdKtX9xu4lObCpuh4ouk4jq8eOHBRlJAJ?=
 =?us-ascii?Q?NBxkqcyaIvYvHC4+uFY7X2W2No4V3EWm/+Il8rsZ6ifBzJCbHfhwjIplXRgE?=
 =?us-ascii?Q?bN7ZA4s/SXapifgnxQusKflEnT/y3zZQ7d+w9xZt/qZWcbdvUfDk73zgMNU6?=
 =?us-ascii?Q?cin9km/8CiTzb7LYCVQucjybjl+giVRHfFPFN7k9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac25156-c1a6-4d4f-84c5-08ddfc2e151e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:21:41.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlCAQyTsqqG6ss+jy7zlUp3puVoYlJobrLIwgaK9l1ZOgo/wwh5oUQpIx9avNvH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

On Thu, Sep 25, 2025 at 03:15:46PM +0300, Patrisious Haddad wrote:
> 
> On 9/25/2025 2:54 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 25, 2025 at 02:48:33PM +0300, Tariq Toukan wrote:
> > > +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> > > +				size_t mmio_wqe_size, unsigned int offset)
> > > +{
> > > +#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)
> > IS_ENABLED() not defined()
> I just wonder why, Is there a preference in the driver from like
> aesthetic/convention point of view?
> Since here it technically doesnt matter - IS_ENABLED have no functional
> difference from defined since these are boolean configs not *tristate*ones
> (cant be loaded as module).

I think it is an aesthetic convention to avoid defined(CONFIG_*) as
the reasoning it is not tristate is a bit tricky.

Jason

