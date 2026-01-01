Return-Path: <linux-arch+bounces-15633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0935CED599
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 22:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B3D30062CB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8B224244;
	Thu,  1 Jan 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PAGV49TE"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477B1F875A;
	Thu,  1 Jan 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767301477; cv=fail; b=YpSFrOp/ZZL81mxCWR0/kqApDy7j5v00Qy8PSVC8Z6e1Qa6RwV9fs/cbw6+FfhVQCcA42qp6InJ2++JERqVK+XVHnxbYMEn1zNhdmkG1cPipSPEdX6CjqZDU+CGeL2LcmA/MJlHOsd/s2lCer+wOQEHSl3/UkLctEjd3eiVKqWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767301477; c=relaxed/simple;
	bh=beUxAry8gStRU+gCLJ3RLL8jTMotxgbMdCYucVGfvo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELtaMZ91LySCOP5ixxEBh04jggQ/LSsxgDB/zzJLzGyO6XfBrLx2RO2zcJnTKn21qVK55hjlKRs5D4lpc4Ray6o1yAEMjaZMjCtbAXSiOTj76lF8sgyC2p7Uw6LD6FDC0zTN8jPtY+NLw+mQJI1gCwU9n1l/vWISjSFwoqcnzu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PAGV49TE; arc=fail smtp.client-ip=52.101.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfod5uubNWtI3k5MoCVzrIx6Qf25WcGJUSIzT2sprDoKNpx9HZ64e4v3o90dS/KGNg4dExtvzUL24Owp8fZd23XA6CXcoKFrP3LkmysBdANFLX4hBbmPKo91LcpboZkBTiLgzgBR6SnLakJ8k75GlTiEsq40rxJtXoUSRSi08X3XrlBQa80AnvbLRnAlD46HWrcwmvO9W3F5GhxsvpetwiOOw4GaUjgLB4mOVAhnhVquATf0/0oZmtuyNioUqnSQV2CIVHL6f9l0W+T/Oj22KTSP2U4PhgytK55YVtEeKuXZvtizU9g4iGNo5ctH3w3Rxc0mKRSpOqZoVcks0bSWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaXpJaKLRldSeYnU61Yq6naxHsWVTSDemYWU2156tSU=;
 b=pEAJI3RLagQDBKyD3yIhz/WHquJ3WJtus+Dn1ZEOYjrxnX7Q8D5kxEkh2vrxR2wHsnJbsZOGj9Tj3DqbViCxPkBQhUxsd+1f3Mu8zgG8LU3vL2i0EhDub5nLekt1s1r9pWlto2l0RmnSW/9n3f5wGyo60n6nQnBsWugK1XONg0u7W44WpLVuAZpOgxv1cr0WlsEqZpP1qF7RaNCITtdKABYmaTrJ+hqaqVXMnbJMDW9dzSRxfOZgOLO/oBt/fvzgkt4uJfL4E7C/kjqzPSpHtbdrL7FHFpQHUihMacVyXbdeYuZaeg0FAyo+jmsPFenFGVbnbQNmD1aD+7vwJVjHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaXpJaKLRldSeYnU61Yq6naxHsWVTSDemYWU2156tSU=;
 b=PAGV49TEEGAakVrJjZNOWM0SP2MFP+YVnKINPJQFVflKWW0GGEx50ktQ15k49gYNl+kc7CD2AQbCto0VoNDhMRm09gQ7HcuOU/LXWztYkaVAgMzXyTGeBs/L/+Z/Hp26j79mgR1WlCbO9sk0GL65Kl5acd+kHqPAJFvgEDO+brc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3353.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 21:04:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 21:04:32 +0000
Date: Thu, 1 Jan 2026 21:04:30 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
Message-ID: <20260101210430.6b210dc6.gary@garyguo.net>
In-Reply-To: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
References: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3353:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9cef2a-3f0b-4efd-fc02-08de49795c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QBNkocLYStdt7Xi9z+jCGh6DTj0NWTUyGdk85nYJMhNSjr3xj7qHBlvAcZA?=
 =?us-ascii?Q?wOrPmZJ/HOOkrMfR7eTD4lDUTQF6KN1lvE0+TaXw5ecmyU13XSosxDmtgIdi?=
 =?us-ascii?Q?5jRfO0I/6R+h1kfjY8StRpgEIFHliiSjCK35V0qZJRR0du0H+AWe0331aNHd?=
 =?us-ascii?Q?Dj9NkrZ+N9a9FveGKsqLomADtLwJ4WM8QDPNjsHy7PLKzjR8WIjZg3gQWrxs?=
 =?us-ascii?Q?JgzAqmYEmw2lz7Njo1bYiygJG1+G4Qvtqe+zN8ApWZg9jWZbKhQC3BX53tPX?=
 =?us-ascii?Q?tNH1WedE+v8BAOpCSafuusY1XfxkZ/4Jf6nlPXdBGIM0uDNEI1RvQxjhLlCO?=
 =?us-ascii?Q?IGGSef8LNpoiE22rQ/vXbUlkOCD7HAmmpwj7gDIgLfWGagu5YIEsXyQa+75K?=
 =?us-ascii?Q?mcmGnOHtktZQFMrqm16+SZS3rkOPup+TZo7bneL1+sS0bs8PJydg3veXCN+M?=
 =?us-ascii?Q?BFrKMGLxHiDVNUFIcLrLkYRIoZtexL7DTgJ6YEcKjBsB0/JlHnwH/afVhmHR?=
 =?us-ascii?Q?UxEfp2HCXUvF3kva09ieTItnpRnLa3vYMr0XtJRJZRsA3+oo4gBF+c/CykP0?=
 =?us-ascii?Q?mDLIxcxbLzgUqJcHuFgI4T3xZvGPCnplZEGMSU1XWo4Mk0l2vpTU7B/FgYWj?=
 =?us-ascii?Q?ppzRcEnfz6sJiczcHzmOaBaDHiq6zYWBLIgiFJsh2dqBYD3zl9+4SJ3HMZZy?=
 =?us-ascii?Q?8rG/Y73PEHYZOUDCRaa33cVki80/w8vr573uclA+Ex730tB1Z7NBEYD9GZXu?=
 =?us-ascii?Q?hlIUGYQRYow8SzFtTYMJFDv8joOQC0RiTqmvS2q7ecBWzKq7Y5aUJkPwyzQi?=
 =?us-ascii?Q?l2As+L+UbHkjc1k+5WJUTMOiwf2+MaaIgiYrM7uDQtK5IG5HNiOVVTK9ZaMn?=
 =?us-ascii?Q?O7dD1zMJ1VZLEqpvrk7lbcWGs5yyAkimAvAoXoWIn9O9GPRXrgSlPbolt/pJ?=
 =?us-ascii?Q?aJIb6xhlJMVPyL/C1XuJLpfiP6MYUjBR8Bth5Se8hK4gvOa4WyN0UJoXIJFR?=
 =?us-ascii?Q?ii1r0ewZ8m+3iLc2ncm9JpUxrgxgoBfTW9KVJ6VEYGo/T68/s6ukY0Xk042s?=
 =?us-ascii?Q?L4qPkUKoAzL2x0ShtnfAulPBFoj2yJHCrEwZoR3blwvyM1x6dfTl8qnUtdE1?=
 =?us-ascii?Q?FajgzI/ayKvNDansH15ho5NbBgs0z41NoldZM1l+J9Yw55XiIDgY2sSc6U7Q?=
 =?us-ascii?Q?UMsWs38hHFbaWzP2cL+nncW+vu6j4zbebvCGIeNqigoeGum3u7FHG2pgxL30?=
 =?us-ascii?Q?VWs6Jx5v4qFNoK0/F8rx6TrwABFChozKOUDDh8xkQCUmTSTpx+uqOtYmSaxo?=
 =?us-ascii?Q?q4XMpVVagD8xd+vvwaQF90TmriuYWzQyZm12h56GBUyNCmzREdlUmqHbnKIO?=
 =?us-ascii?Q?tmNQ5oGTr4blEt95E941dMOxjCnXb8MtKSkOBBaULiEjmI+R+IUjrhRZMPAl?=
 =?us-ascii?Q?Hnj1fxhx6VrWwgiJSZ1/fvlq+dKbG0NW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZcy9nKGb7zTuIjIkr8Q6WnHpbvYIk8gCxPF+AVK52P80VKFTWyS0XhZMCpZ?=
 =?us-ascii?Q?GCX1RdzvpyM6rbIcg1ACZzYvfU08SyYOiWYycH+5Qi6eMFDA1JtWtmTwdbfD?=
 =?us-ascii?Q?dhESdiqRiXXaUlnMOCtXxoTLLg0VGsnquZ9AGgmqqLq04WYlZEi5xDhIT8pY?=
 =?us-ascii?Q?b9KdKAfBGD13ZNTfGgzobdodjLzr5tB6xpgktK9astTPyyQpFMj12uE108DT?=
 =?us-ascii?Q?2jb6EZRo55X1b9LH6TL4gImM5rrV+yX6bS7b/daQhZA2IDxbL+twXLW6EM8P?=
 =?us-ascii?Q?I06NqB4G+uZ4F6XOOgtk+uosyqGRSAq5PsvR9g2S6IV09ubByLCHohiIOAi1?=
 =?us-ascii?Q?+VqR8MJszq8Z6ucy/PGSTWaYnHYtvAAVoVUB+nsEVdusq4bq9fxzhNUudH+4?=
 =?us-ascii?Q?CsigvOZaLfpd2r3Vbr66hX/2HOOFNUeRYCV8f1hV9uyUQ9gVU3zTklqWtHJO?=
 =?us-ascii?Q?/tNa28fF0uhx4ueM1zKPqZUqRrIaQDJ1RCZ5U6qYbxQABZeZ1a7NC9/dfUWS?=
 =?us-ascii?Q?qO83swshSTQEFNT/Dded4za4PZywcPK1P49xOFrSq5ePtOFQdlIEb2ugUEQA?=
 =?us-ascii?Q?HBxXugb1iCMGVK4oDwjpsTM+INUMSKMPhPUT9K5QT7aIREtyQWkeXsJbQtzx?=
 =?us-ascii?Q?2JXqqvBKEoVAIFi22p8aAqHGlhHuHTMyqPCWABnqqOtH1weL/aSCrxOAgr/B?=
 =?us-ascii?Q?rq6CT9gn28sdJF1fvDmjS+N2FLvCWcWfm7iaHmwkNlprrTGeqQMMHZ8CD2vD?=
 =?us-ascii?Q?88dNsqCh5FLLoxyLYvipTVgDeugvK6uUNXQG41fW4IvncRITabmXBblbeTEN?=
 =?us-ascii?Q?UL6KhiO47S1ibRlVWRbjKn0SNSy8d+fdPxsVONeguLdIOKitJ39hSDT3y3G6?=
 =?us-ascii?Q?uIaycs2JvjpI5UhSIBdMIuZfmyG/bLhXRcSihFLEg498/mm2Tvu0ee0mH9EL?=
 =?us-ascii?Q?90Zp3QQ1icIda8fjzENEwlJiLPT1h6nGYJvLHvvgCI0wOZQFsVfQNel2iZUd?=
 =?us-ascii?Q?4Ecfdo8fAED+AA8b+r1R8Eahrd9LvY6aB7vbAEj+PBxsnxNakdcUOSPcNkJ7?=
 =?us-ascii?Q?JUEryw7Ea1Cx1e6FNSNjrdLse5ueliwFH9jvaXzx9jzn8jCIAjz0FtG4WEzF?=
 =?us-ascii?Q?dWJJ+5MRjfinjyJocsZjmCvljafYNi6KTJ/w5Yxi/LG4CXfRWWlqJZj+OHMp?=
 =?us-ascii?Q?HR+quJlrCVOmxKL0UoTb/0iYlcg15qy5FkTnOoyDEj7o6dbF5d0QtyTcrtJf?=
 =?us-ascii?Q?F8RyNr7H3/Sv7+alilSqXm87U1iMIY23ZpgZ2ryr89R6Y7xvE7dr4psNyZVY?=
 =?us-ascii?Q?5onvOzw4QOVe2jD53mDLv27yizlzwccXziUXqyLqykMPLryaowS9eMaqP+nk?=
 =?us-ascii?Q?1UyTYQcwe/puHHmldenaWHEIMnAL2yJLMSOeVovxd+TzlxzvktS1z4zIK1UI?=
 =?us-ascii?Q?rXZ8EXul4CO06QDt3K2YvT3j0EB/TaQAlit5yKW+Ce0hJZyz3gEetr99Mo3l?=
 =?us-ascii?Q?DmKbFWqH+PK4+FcBhmIvs1L4sZqfiVCkC42v1Z4Wb1M0A4zY9O6jynatuevL?=
 =?us-ascii?Q?43OyXJydXPUi4vZcfwD2XKoXGdR/9dodxdfy9fGa3rWrcgE+p33ap4iDJ7gZ?=
 =?us-ascii?Q?wdALmpbOCn9JyEUg5/1eY+oXuL2a1RNAknED7MxMTSUgiSBn1sOFB1sW5DY/?=
 =?us-ascii?Q?xg3RvQpCiJBTewEhruGyLj0RJCIlOGAmv3dKonb/gXxUbH0xLlOoTXoanr4v?=
 =?us-ascii?Q?O95zz9d6sQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9cef2a-3f0b-4efd-fc02-08de49795c1a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 21:04:31.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d47mQWAopXqb3+04z6Rl+4G5FnNM1TRWVZWjcxaCvZFQTyiAmBPwkM8XMi5lYA+v2Wz4VkALcDdVI64dni134g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3353

On Thu,  1 Jan 2026 19:27:18 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
> AtomicType for it, so users can use Atomic<Flag> for boolean flags.
> 
> Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
> particular, when RMW operations such as xchg()/cmpxchg() may be used
> and minimizing memory usage is not the top priority. On some
> architectures without byte-sized RMW instructions, Atomic<bool> can be
> slower for RMW operations.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 4aebeacb961a..d98ab51ae4fc 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
>          unsafe { from_repr(ret) }
>      }
>  }
> +
> +/// An atomic flag type backed by `i32`.

I would recommend that we document that the backing type is the
(perf-)optimal type on the target architecure, so arch can decide to use
i8 as backing type if they prefer.

> +///
> +/// `Atomic<Flag>` is generally preferable when you need an atomic boolean and you may use
> +/// read-modify-write operations (e.g. `xchg()`/`cmpxchg()`), and when minimizing memory usage is
> +/// not the top priority.
> +///
> +/// `Atomic<bool>` is backed by `u8`. On some architectures that do not support byte-sized RMW
> +/// instructions, this can make RMW operations slower.
> +///
> +/// If you only use `load()`/`store()`, either `Atomic<bool>` or `Atomic<Flag>` is fine.
> +///
> +/// ## Examples
> +///
> +/// ```
> +/// use kernel::sync::atomic::{Atomic, Flag, Relaxed};
> +/// let flag = Atomic::new(Flag::Clear);
> +/// assert_eq!(Flag::Clear, flag.load(Relaxed));
> +/// flag.store(Flag::Set, Relaxed);
> +/// assert_eq!(Flag::Set, flag.load(Relaxed));
> +/// ```
> +#[derive(Clone, Copy, PartialEq, Eq)]
> +#[repr(i32)]
> +pub enum Flag {
> +    /// The flag is clear.
> +    Clear = 0,
> +    /// The flag is set.
> +    Set = 1,
> +}

Maybe add `From` impls that convert this type to boolean?

Best,
Gary

> +
> +// SAFETY: `Flag` and `i32` has the same size and alignment, and it's round-trip
> +// transmutable to `i32`.
> +unsafe impl AtomicType for Flag {
> +    type Repr = i32;
> +}
> 
> base-commit: dafb6d4cabd044ccd7e49cea29363e8526edc071


