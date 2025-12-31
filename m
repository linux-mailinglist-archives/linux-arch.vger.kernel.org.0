Return-Path: <linux-arch+bounces-15625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A9CEC2D9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 16:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1C4300B295
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE681DFD8B;
	Wed, 31 Dec 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="V4fNyCmW"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021092.outbound.protection.outlook.com [52.101.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53141925BC;
	Wed, 31 Dec 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767195277; cv=fail; b=e1B8cL1Q5tx8MCs/eqfNDZHzY13UyUAZQ2wqXLbOqFE4QRHMGAosFwf+1pCgnM0oLGsJkB6ly1sOrCLGvREhjH8+EFrzI2+MeD9wWd3tCpIPS/uxGYBKi4Q4Zz0A8Ksw4qYFz+TdYytKdrskqznOxd/JatzQmoFGMpgFlFt79mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767195277; c=relaxed/simple;
	bh=KMsURh0YWZquVv+u0FgDY5jYmZvQGFs8vSKvaKgMMzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fH2ewnLr4GZqZvc7cROKbVMI1P5bbhsJ0/H5QNj5dABDi8/WdZcK2nZhfWwQIZ2vn+UMOmFhv0m4jQJUuRbVG7PDffqNlZzz0VMKJqwGsrik3whczd2sIwotWJXKOOeQ7BSnV0RzD/R7fd6DHM5rhj6tXdwalOjuVqkExw+CEjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=V4fNyCmW; arc=fail smtp.client-ip=52.101.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPcspIVvHqK4ngOUYDFkrz2UvRg9q068ocoDV4yRnC/loIz9CBPGwEU1KJTnCJ49+V3vdxUWYEGPzW7WH15DfAr8Q4WoG4ViUFbYzdLnoGCM5eztwpHnnFaa+s2hZGJUfJtk+N37GA4YiCj1gEDmNMcYugA2/KSxx5isOcaj8VZfPqz08Vuy07Wt2F3eH2w2YA7omGIE0gmGFHhUBl4XorKEpnGRSEtHZTKfWrymDla0evwKvG/Lbm69aN9sf9Ju8v9VCuUKdHrlCYg3mcp+3PpGCFu4rB1YfQP9Xs+vUFkf5LJThoY/i4ol36rzJSCOBZl7T01Z7IqngYhzOZZrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB4DPyLu3lPUOI25F3TzNbBXhGbA7ETY110qAe87ZqM=;
 b=QwoA8eQXQd569p9/2fGKwyO+NKtz3EebdgKmIwV+pEYADol53nPdYEOEayyPWv5a+g90e/1K9PYqiMXu3wszy5HWurL3397bjL4HsQo8fUD15hMv3g3ASyS31MAJe/PHdiUOyAfkFeYkupyMz1cEa3tm2s5VztE4SpNIDyvUO/ibiZNNnRD4thSI9Fp88g84dcDhc9YpxYAGYuBtAuAEiiPCJN8yA136HwLgEa/X9AtW8WPofTSjlZYsgOz0oTPRiYuVvQ/2trgstrAPQfrp0aab/Paz4AYuPppugRY84jccj0GKIqX6gMhN0Ujt9zvRCBUMS6KoEbrMd+2K7njV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB4DPyLu3lPUOI25F3TzNbBXhGbA7ETY110qAe87ZqM=;
 b=V4fNyCmWE7vq49Z8OvZaxkJT3ZmX784daLZHfC4wH5ruZpkkNtE4ifb8Hqjnpe8nPno4ENKY+IqhmFKiBLPMKH5uA6CV4FQVI4IuUTz1TC087XiYZG5Eed00IY2n7x+KPRLAVIAqPTinrzJQzsv3D3owrWjNQMk5Sw88xh9M1AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2784.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 15:34:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 15:34:33 +0000
Date: Wed, 31 Dec 2025 15:34:31 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add atomic bool support
Message-ID: <20251231153431.4a48816c.gary@garyguo.net>
In-Reply-To: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2784:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4a50a1-ed74-4846-bf3a-08de488218fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WGHD2dq3xomaBjsgrshm+f1dA1TlWPSaAfliM87DyJhpByoODwaCzBtrTc0?=
 =?us-ascii?Q?IFfWm9Wc2sFXiVE8gOrwDH3Gc6hMRfXkM0Qhfy8h+9EvusQO3lIa0+p24Sr+?=
 =?us-ascii?Q?cjPGiwtaUkm9f0ABiIqEvsWBn21KiXxGSul+xO41kMwCi9PoT8032oBxoTGP?=
 =?us-ascii?Q?bOobeAwukhWeo4TjSJb3vDXRwMFRyoF5YvVZF15tQkbNWmVE7AQji4noiWP1?=
 =?us-ascii?Q?MfvgwKRYBCeXLTgDqYw7Zi5RaT5bGFmsVWMvXfNy0L63Dl9AvO3klbsbyR/L?=
 =?us-ascii?Q?XrLWpoTTW+zQejDixcsiPLGU5f8TNwn3uJJBVtKg+fHnSsywvh51yTzxnp7d?=
 =?us-ascii?Q?T8+N5kW3ISNfUERL6UEnsqkUonwVJJgGSNmIvPIDBw8amtuyItnKgUR3IVVJ?=
 =?us-ascii?Q?SJ2IeZnvw3cMleZMrWqbEpikk/9TA6ZRBrZgI+IU007utQrzinYIyZXRJKzR?=
 =?us-ascii?Q?mpjL3a7nntsOTCN1HO2cTijpdNkz3bUjThhL9Oz1cY4ErxQxVyZanfTGPus6?=
 =?us-ascii?Q?NadZUiJRTg+db6JeESeJePlkxwYRm6ft54GOWQQrEw9xayEIqSvPrBSof06J?=
 =?us-ascii?Q?d4WjTAYD5otDNXqDAW63+Utd18P9qB9oh1u84eXzAf5M4ENzrbuDuYenwfIy?=
 =?us-ascii?Q?w1+++PBsC51XyF5OZA42msAeFGr+Yju+snmJjY1w4aT2dvCTeJTtuzjtb/I/?=
 =?us-ascii?Q?9Cb+hXpN7eFsqD5R+YOgxkxm/6xX7cla7zvcL1FQUCqMv8uivaoNSPDmealV?=
 =?us-ascii?Q?2TeAjuS8/Hqw4n1EzxffBinoynlOqOidfO9e410zIIGSR6ieDwbjMw4asmNN?=
 =?us-ascii?Q?2Bho/jSbqpNFxnihKXuqAb1RR5s2AStm94bk8skUoHrOsimFEZJmRVlqGutE?=
 =?us-ascii?Q?fV9yQ65igMQHhOVlzCh3+T0ddvLTdgfIORFh67OPov3US4g+A7a7lI6bOVy+?=
 =?us-ascii?Q?a7CC904yVKCJLRH5TOMFVXQjpUS0nYZQcUrsOesBGWXCoXcnhwLE+O/9/TFW?=
 =?us-ascii?Q?pstPtAI9pbBmPmflKXWcetUCDXVibgtZjls4U7joX/0OAAhdanjhic3eEpNR?=
 =?us-ascii?Q?ifNIqE96/TvkOE95lK4961l8FsKj3UaDw2SJZIS6AXufeHV8+5CZx+a5+SbN?=
 =?us-ascii?Q?jgU8OwcaSA+xI1b+xOxJ5hs7laWM/zCzEo2JYp59N4xdl2KGLNoeUx6dwq3R?=
 =?us-ascii?Q?ZeBd6TAoj00gAMsxCVUImyMtdzYGFDh9eXicl8O6ja+i6dN3INU1drc7Az6+?=
 =?us-ascii?Q?eVYONndsUd2jF16CdlS5698yRtYUeGi+zUFd1gdhy4JE5pUSB2IL9kUv43CF?=
 =?us-ascii?Q?SCfps8q9QX4fQSTRzTwMutZjPUJ90Ft59CFtNwHsQFNZsaO4JV9CUsDPetrx?=
 =?us-ascii?Q?I1frHZ3Q9Bj2NzAHI6JTm6lAn0AMrr++5gwzaY8hQLL0JqbBi0SbsKns2SEX?=
 =?us-ascii?Q?M9Ko3RRIkUhpSUXFN11y681t7LJbkOAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngsba5uDKcSJhYHfsSt2KGB3V6vyXwrM7pNEpSPmxP4nKsMlq4+G+vIk1VRT?=
 =?us-ascii?Q?SJwC1oaMcbzSsAcD+cbg8yf6MzI3NU6Hl09DbFoWypkJJFj0pRLFv+psl+sM?=
 =?us-ascii?Q?QDekt9Spd9NGaL0BWAqSMl5p1v5Hp/5cYJFLXG1hhUS76yYxmUWlBwoPytZY?=
 =?us-ascii?Q?cZrDr5Jf8ydIHo62m9e4x0BZDg0c4WlJXNVg4/+h8/6gGa0Z0nDl2ClIIYVT?=
 =?us-ascii?Q?HOGdAa/nuDuWhMmLmpvWE5dlAuJt8RE79UNzlLycWbAHKzgLuV8W9okRFGAB?=
 =?us-ascii?Q?DswgsnHKOrBw0dZp5YcqpqoA4tzjZoYmmwZ+6ysi2IYavvUZYQUcrcCTWF4Y?=
 =?us-ascii?Q?RKUOEoxybgVmWc4zU49Nqo3Br+gBHbMKbQTvD1w1hd1u8Id5D2B5ozwsmZZo?=
 =?us-ascii?Q?Y0PrxeHE02DfC/j1YtWivznDspRbfRqrQFhMIClJRZJAXzx7UfYCpHjJyLEB?=
 =?us-ascii?Q?8cf5O4PV1bCJBCDZOBrSAquALNvoIJFU8tQFXOSSa8PLN4QUSrcg7nOGoFqT?=
 =?us-ascii?Q?bVRJtSwJFLqW/UvWWucqjTD94FXBOV/DY/ZAh3Uqu8T3YfVTFD3OCJxV0Ct7?=
 =?us-ascii?Q?KXAY0g3XpKSy00D9P2RiPivy6IhCl4Adzxq5auyAra8Y2qec2kmln23iXFwx?=
 =?us-ascii?Q?+qKoMfGiA7Vf+dfwT7ITTZUsGpyo/UqM22ZAbvlGtTLSvFcOctQVciATEYO+?=
 =?us-ascii?Q?urB1OWmJED7vcP8UJZqWzwOgAkkL7Xp8C7OhZjXuZCgf4zaprvk96LG0+bkU?=
 =?us-ascii?Q?L5owoOmkMRqXsdcYGrwgA4cSgo19sZZThg8//7NSinCTdWIYSvEE1YNv7u7L?=
 =?us-ascii?Q?ORiK9Zo3UugiN6qemYmAqPowhgMzSbmP0B0xtxEk8mNjWQQoovNSMt1qgPEU?=
 =?us-ascii?Q?gCUjs7Adujdq3HFJU1WVYK5bR0A7r6Rb4SutS+8zTBT51QmAv4FNqMgzuBuK?=
 =?us-ascii?Q?onAOdiJs2RntolFCeLGAv6nvUeEm9Nj7Crxl1FxA7PtuQ0Sn2e2Q6syTsAyR?=
 =?us-ascii?Q?tdEnuWo95cx00og+TyQkuqJZAz+Jz0PTfNZrEsSQQenHzFvLm5QOvZgpPfoB?=
 =?us-ascii?Q?1JIVbMYle5EF6LfevufAyL78uCSv2NOG2pQtExWPoExFVFVwPNQ9GWfowrLR?=
 =?us-ascii?Q?RLZ1arNwlww385D0p+uAej1aeGnGjv/hyClZXhsZPREpjzpMu0Ee4FAEaeqY?=
 =?us-ascii?Q?QzfS0xgjOnxMNEhEl/cUQekwvIIwYs812ReEIgzUaxIt+4o4cV3q0VgEaNDa?=
 =?us-ascii?Q?BqhJRTKfyAos8b5jWf02n6sWqZF8/1HRM35g1qwJqQntB+NowdNoDyLZ4g4X?=
 =?us-ascii?Q?ir7XxwavlpnN3QIQZssa4g3WHff1wnVpkJQ4esGFMSnmPWGj8nomT8Krw/hO?=
 =?us-ascii?Q?Lr+tSwAd5PMP96sIRemmMmiV25kngC5YXrJZqkKQsF4OdI4GO21ZJ6xUXr/m?=
 =?us-ascii?Q?CZQJZzSNps6CuY53vD0+HKEd+83iL267Br3n1mSXW4RBceOd/8I7Hd8mFNAt?=
 =?us-ascii?Q?HNJOFmrfZT97bj+b6f6gf2t02b1uiXdxiz4jSwKO++mJr6TibHnakYMFRv0k?=
 =?us-ascii?Q?MjCAOjS65OfZJluCG15Y2tjNDx9tJi2eUqDrGSC3C6rQ6Ib5nfBNu6ZbHe7k?=
 =?us-ascii?Q?XoaEqrUe38R6gCZ84CkOm0cQNt1mea4PEZ/CvEbj4Bwrvx0Ps2D3UtXBg4jZ?=
 =?us-ascii?Q?IPJm/948vvta83MY2y91LCXFYr9oVL48y3GZ0Hp6GcsfOu7vzil8kTfcFYSw?=
 =?us-ascii?Q?JhwlRgPC0g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4a50a1-ed74-4846-bf3a-08de488218fb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 15:34:33.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBOMWwecjeo2zKsw3L9CP7UpeXqX9Mn1UgN6jIZsT5QFKFkxx+35b34Nn+8XFCfY72EELCgYkCDDAZCkgm8kOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2784

On Tue, 30 Dec 2025 13:50:26 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> This adds `bool` support to the Rust LKMM atomics.
> 
> Rust specifies that `bool` has size 1 and alignment 1 [1], so it can
> be represented using an `i8` backing type.
> 
> Since `bool` only permits the bit patterns 0x00 and 0x01, the first
> patch also documents an additional safety preconditions for unsafe
> `Atomic::<T>::from_ptr`.
> 
> `from_ptr()` exists to operate on C-side storage so I don't think it
> makes sense for bool. We could restrict from_ptr() via a marker trait.

The C-side does have `bool` type, too (`_Bool` has been there since C99 and
we have typedef'd it to `bool`). User might still want to perform relaxed
load/store on these C-side bool storage.

I think it's fine to leave out this line too (given Boqun also points out
that the additional safety precondition is not needed for `from_ptr).

Best,
Gary

> 
> [1] https://doc.rust-lang.org/reference/types/boolean.html
> 
> 
> FUJITA Tomonori (2):
>   rust: sync: atomic: Add atomic bool support via i8 representation
>   rust: sync: atomic: Add atomic bool tests
> 
>  rust/kernel/sync/atomic.rs           |  1 +
>  rust/kernel/sync/atomic/internal.rs  |  8 ++++++++
>  rust/kernel/sync/atomic/predefine.rs | 27 +++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> base-commit: 13ade169e801a423bc1a5a5c3c6ac680a144a608


