Return-Path: <linux-arch+bounces-15634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15CCEE50E
	for <lists+linux-arch@lfdr.de>; Fri, 02 Jan 2026 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500BD300F9CA
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jan 2026 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3A1EBA19;
	Fri,  2 Jan 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PecjHXA1"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93841E834E;
	Fri,  2 Jan 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352807; cv=fail; b=RFg/9zmJLITXwA93AEVqT+KYCzn7FdDjbIGx12FZdMTTkALRyhdJjFE2iEVQcx8bppbBBOnTHSFJg/WwgHV2LcAUXL9XBmPQw2yYEZT7m5FvemlnJNKnAvBguFMeKwgeHLAS48K4r9PYwvnKkcrwmya9Iy842ha5vNEJfzrqIwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352807; c=relaxed/simple;
	bh=a3EYwsv+lT4M1D8S0LR1kw/ScHSfuEhybJvYnnu1e9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHExPHWchtrqJ8u0kkTN4jHMzrRI+vB66+2QZE0+VrRqnZIiDKzGDpOht9vLImszQ++7TiP20DJl1dK8V2QDMOwasbr29xnhOvUKeuJpoO9zrqLZ4zKOFMXYXqklQeEeSdi+E/pFBF+4T9Xx+DuJr1tpZK8DJyVxEIEICLrBjHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PecjHXA1; arc=fail smtp.client-ip=52.101.195.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXjMZ9SRvT5shdICuGPX9nZ72Tpo183XK2tvjdC8x+XuSN7a4eulheW2soDFkNyQbyitHW+kBUCbuU/4bd0OjlE/NE4iyp0oMwQqwObACg0XmypIoyJ/kkQF2WKgtEDaHGJ61PYXLvuOiRRtsKQzq6uysMGAZse4R9caDjfBTQdGCI3o3COSwS6Z7N4QwSkh4dXWDngoAzhTpO6QVSnG1PsCGkuJPXpP/YjW0S8qMdGg8v7vyK8u/oIuYSp67qYetbgSVutDB+nVUhSd9YPB1gKNsl8RGsSng5XCouSjxvCHY242UKs97EiOEiUMImx+5TPlJmHQ1pwFdLBckkIRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSpnvuBc0wui1Bol6+ze5dWZtnUoE6OqtapXfIt9hbE=;
 b=teaVkTtX8NJx/svFbK39SlzfJxKm4akDQZS9IzINGTxFgbmptamt/r4dDvKeOiiHElDxvKb31GTlq0AWQFyIDZTFe3RqSe2FoIXHXFprMOcLpKWE2u1kErH2UG86wuWYnFYNE3Y77bVmo1h4fxpBEZ9z/gG6uIPI3s7xUXF1z5lb2DkaJZv8P0LahOCiVf4ikbtx4ie8sr281ZjjJDUuR1HnFgG47abN65AzJKWq1d0FYqrVyZPaKVgDOkSRmJE3FLbCAww3GAvJaxAcPK2nnthXcPBBQXvAC22hP9dsTAapJaTTXuDgHcFOILXpg4KEw2RlxJUEAUEPwRv+RCsEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSpnvuBc0wui1Bol6+ze5dWZtnUoE6OqtapXfIt9hbE=;
 b=PecjHXA1eYXFU84LfCKTRUG5P8cc9GylOg+4lOPMNeB1zG/3oscZZEzDrcWehpb/OCbVpQJ3Gp4olJsAYS0I4KNkQDG4keSm7OfmKKdzffhfCi05LkKTmwMOX2rYldIweNf3IXoovJlVwJRJeyJPgzvMNGiIfrBZu71E9SJes4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB3599.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Fri, 2 Jan
 2026 11:20:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 11:20:02 +0000
Date: Fri, 2 Jan 2026 11:20:00 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add atomic bool support
Message-ID: <20260102112000.714ac16d.gary@garyguo.net>
In-Reply-To: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
References: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB3599:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea41776-c673-4b15-7d69-08de49f0df92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpPeFQGL4atceGGZJL8/z4t++jzDswsLpXKdSmEBM3D/GrdQ64imS8qMv9b+?=
 =?us-ascii?Q?cggfg6LWR6/XOpdlFeC8+ub1R8RuWG17cqrTs2+fix1Aj/XksBxV8Bhg0ydO?=
 =?us-ascii?Q?mRgxfV3ph/LYP28Ud0GYgFVz0bNc7CZrXpNaCyDHYSVINTqko8ZOUK6PO5nX?=
 =?us-ascii?Q?lMUnrWMpnrmQ8MlYxQPVo0FJ1IGlWLEt5celR19xWFWoJgEgzvzXsz06u2Ja?=
 =?us-ascii?Q?Pz0u2j7Dq26pVidk1IIPxqysLfIeF5BGKsBy1UkVDNbvSYLpEzJMn63/tKB7?=
 =?us-ascii?Q?JPAvPYZT4qX/4cmZjyQfk+1jOZXAVYavKYmTgGDA9aXVlP6axYklFrj3vT99?=
 =?us-ascii?Q?fakeRcR0MXfn8eUWyahzYcRTERohunZEP2cyFLNUelm226QgfNHqcdzBAA5C?=
 =?us-ascii?Q?AmrJ6W50dRtqbHLsVzDAwaKFQlGbOgXQo+vg+vg0VsfQKtqfJ4uYGN5o2awH?=
 =?us-ascii?Q?PIO44y2FbuO97GrFsnF4ddDVJ2XXDfX0pbWb73I2pGZ8qkhHNa4Y0dm7CSgU?=
 =?us-ascii?Q?u8cGftORjBk1so2xkKclUrg5Y8M8HTxPVE+x1IecOcRJNCBAjXTr9nz1uzFK?=
 =?us-ascii?Q?tGzgIvIM4KSjkz9jK9QSCTyrGinzZyaCgNTbbNCXApjUoZ014Ffj0q+lXE8u?=
 =?us-ascii?Q?qbCgBBkJweKx6g4LfQDOwFOB4Npa/CmeQTELrI28sJ9BgG5/R2y0CxhFVanm?=
 =?us-ascii?Q?9UJslRjbHs+Ndqd08nPvbCUazwlsMVQSg6G+aOwksCQ7AGhakBLqOadk1i16?=
 =?us-ascii?Q?Bk7P8XAIy+ph0uEKghuR6C2drmuEgfjqZG4xotUQMws4M/5zKUOq2nSH5dmT?=
 =?us-ascii?Q?kVdqzxdfrG9f04T6sFQO1hr8XnQw5eo0Y73EOB1yBTXXdmUFBL5o16DUmwsE?=
 =?us-ascii?Q?zPoLLWCJKXlot/tZzXZueWYFEx5/+WCo3lEKeKXXYekLna4maiboG1eJab+8?=
 =?us-ascii?Q?Ee8RIN4of+tyt6uREtP6sGSe4KtJfmnfLZ5WZjAE1urEsgnBXic2S3b6KwC+?=
 =?us-ascii?Q?MEwzcLA54CDRYF0RE3BxyMEqT0P7wT7vkJfeqmy588xNxIVr5dMupe+ZXLGz?=
 =?us-ascii?Q?Gr/LF273YEAabMjAEmo0DzYIFGIzH3qWjqYY2y++7oJJ/JIy1eDfL+k4A2tJ?=
 =?us-ascii?Q?fCSQryoChZDGWFunwxY8ZnfOnAlu0uoK1zTVcfLfYl6X6Ii47o1xj+QcaC05?=
 =?us-ascii?Q?PJC5d9hvNqA5aApY6H+8sCC0gYvIve8keg7Ql5LgbubctDj//IRlNYktCdSU?=
 =?us-ascii?Q?X5PU3WwnwgY7e7kTSmkIonquvqg1b1lxcE7T2DPQj5RpXrovAN+Z9qkciJpE?=
 =?us-ascii?Q?dnJyJHYpgpLVkQ9HIsLGZOJWcM+9y3VejIeDeElnE4H6r15+eyOG5/ubrOcZ?=
 =?us-ascii?Q?pO+BJCEMJsc8g6ZHcc36rD1RYSFCMMUNM0mbGNwCsqQXCIouRntKhw6xNEfv?=
 =?us-ascii?Q?eIB5u2IGflNSfTKHaOsthO7I5cT3Jl4U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yH13dxUZX9JI6hLXHxWtFmyC9gqGqu+Mq60FgqsO6/Nceo1bJW7+Tz7uu5Zk?=
 =?us-ascii?Q?YrLuXR5lX/HvpSsLiVywskSOtGD3DwmKxqWgO6jYQlG2x2Fom4Jkh5rFSGHw?=
 =?us-ascii?Q?29vfinV1lReXPbttcmj/Wfs2Or3A2cB7YHbwZLxv+ZDEi399S3BUWSNUGx/u?=
 =?us-ascii?Q?DRiV01c3CYVlH/oH0bLsv485I49WU/JvuFKWXTtS04SilZfWKzTBCMCBVn8o?=
 =?us-ascii?Q?obEonF3JV0Px4n7v0VP1SXsvUtPy3KZqQWWv3/wGBy21lCEXPJzvpAwar6Em?=
 =?us-ascii?Q?EcW5a3tzJDc7UY1dQhEsLoMFTzuFEKWWKG0qlJ9fN2Z/a0QHjpjWvGDu4DHZ?=
 =?us-ascii?Q?RPfZo8yPcGD91IJW0XlkErnbA3YJStApQsivY7XyAbieLKHmYozurju47qtl?=
 =?us-ascii?Q?y/mDhE2AqNTZdAtBb0NL6KrWizC8idzqh/XhrTGg+rRkHxafsZtyyo5lpOa3?=
 =?us-ascii?Q?rz8ecXTH4PSDEzPZKIR6zbKIentINtlDz8k4hQa+uPYgkpQ1A1uRlymB6S65?=
 =?us-ascii?Q?y60Bx9+4f/1bznjFMiXAmOjgZP/VAFhu6dgQhWreYYKwPGECTReeYO7/gMpf?=
 =?us-ascii?Q?qs5HgV0yGFPewZBP274rvvab9YoRZ/mhrhyRQ4ZuqIl1XL8/pRLMzfI21QlM?=
 =?us-ascii?Q?EiXwnRvmXGQeNYG57JmI+LU9UlBQyZv5KiFf93KYnU5LVnp1Dy+TTjDIbiB3?=
 =?us-ascii?Q?hXWHmQr8xOsKKwpAwbrTqrdFWykfgM6WFvyKC1AGqT/epD/u7DHkq3Ad/isX?=
 =?us-ascii?Q?ScFYjZsZc+t6bcey9M1I99WEpkfU8H8zY3TdMGjyVgkfKtYS6w2TP1fzNKXR?=
 =?us-ascii?Q?YCjjLSEe7myXDYNMbfQtOCL45SsvD6QF8tljLN5jA0j4YXauDjSXHVU09USB?=
 =?us-ascii?Q?YQEUKB5FlBikueTBKwFW+rnWbHZ8ddUhtfsSXqaVISoyoT8V028zbxx5QWk9?=
 =?us-ascii?Q?Ph2NH8rGG3fKnh1KnHzt8wAJmrHdYjN59g65AL64N+alLJ9GzyxnhjHTqpHw?=
 =?us-ascii?Q?LGWJImRX+c2vGL0Rx4wZ1YvwF/9qUZgk9jQgLnsN+hSk+efNXCPX94q7iT9w?=
 =?us-ascii?Q?Q8N7ruyl/uCw1MQJU32UqgnEqPDIRx0/QhZF6e25QlkJpaGXgEX7UQsm9p/X?=
 =?us-ascii?Q?sF9jK3tvoF3LoHtog/ZmpYOOYzlPpl4Qc8obagi43HZw8XpirAMmswv3xMRT?=
 =?us-ascii?Q?2AY7duBziTRCLULH+rY2kCaqAh9DdVLdH0+I7a668O4/KwppENOjHQRgchR4?=
 =?us-ascii?Q?LpIlhXE/LScAzWc7TzHoBQ/2TFAD1iyzyd2HCSL2Kt+rw+ftlkpuzeFF3ULx?=
 =?us-ascii?Q?W/PJcz6ThR6X0Q3a+BZrQc9R39zNJS3whDJa7CZ3qoeczqWvgx3Ux9hwQCdc?=
 =?us-ascii?Q?tUfO5o/+uhar/RrRaTCZd1RGoPUrmeIoO8+teqyQ9JWejbdy8YwC3rk6N8iG?=
 =?us-ascii?Q?IyfiuD2ai+6lT/y5cTzjaxtWBXhT1IBIImthAmEPCYMWKIfkDyH819vEd7Lm?=
 =?us-ascii?Q?X8xEPEiVL+sHALR3KhxG15XPuTjZy29qXbThVAfF3DvEVlhVxL/C57ogH3Rs?=
 =?us-ascii?Q?DjgLi+G0UAT8kQQ9+kKenfWvjxLVfj6O6N+1SnH7wtYQy7p6+wXqJpZuGLUR?=
 =?us-ascii?Q?5IMiFhpxs+1ExdYWEB+jUpj+k+31KpQcWjFtNcoA6+Sx/HPdrMaQImd23IqZ?=
 =?us-ascii?Q?9LFffb5E8ZGFQ9CReWLQtV8ZPEvRYV2+gxEP1ywsMSUJbJknH+e7W7m4nQWz?=
 =?us-ascii?Q?4rYYFaM26A=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea41776-c673-4b15-7d69-08de49f0df92
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 11:20:02.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOOHTqv5TJK0p7+ldLZZlicsWue3C/ozyhbPPXBx3a/NJg9cQD0eRs1B4FCbosQ1By9jJEuw7Q+e2oZ4lw+pmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3599

On Thu,  1 Jan 2026 12:49:20 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> This adds `bool` support to the Rust LKMM atomics.
> 
> Rust specifies that `bool` has size 1 and alignment 1 [1], so it can
> be represented using an `i8` backing type.
> 
> [1] https://doc.rust-lang.org/reference/types/boolean.html
> 
> v2:
> - remove AtomicImpl
> - remove Safety comment about the bit patterns
> - remove from_ptr() comment in cover letter
> v1: https://lore.kernel.org/rust-for-linux/20251230045028.1773445-1-fujita.tomonori@gmail.com/
> 

Reviewed-by: Gary Guo <gary@garyguo.net>

Thanks!

- Gary

> 
> FUJITA Tomonori (2):
>   rust: sync: atomic: Add atomic bool support via i8 representation
>   rust: sync: atomic: Add atomic bool tests
> 
>  rust/kernel/sync/atomic/internal.rs  |  1 +
>  rust/kernel/sync/atomic/predefine.rs | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> 
> base-commit: dafb6d4cabd044ccd7e49cea29363e8526edc071


