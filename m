Return-Path: <linux-arch+bounces-15646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF842CF04BD
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C39D1300985B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F511247295;
	Sat,  3 Jan 2026 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TvLE4XPM"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F13202997;
	Sat,  3 Jan 2026 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767467118; cv=fail; b=Qf1ogbnb0pxcZBU/VGABLFepWVOKH4O/5aOspYhb1FIwZF0DL/miYwbgJ2tAaoN4GtwDAGIIYoeVnmP28LuhIjcxZf3ReGr5OxP28+aVEMwLVQbTno3ixZqjtpjOEoLq53XkNwUI3b4SLyNXfFMJWS/0uUP9wkqA/xMItXu6Nws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767467118; c=relaxed/simple;
	bh=7lZt4r7gjRiOeZAIlpt85R2ybdgcJ86+AowO7YwdIjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrSyw77uVEuNpfUsXXispXKZC6gCaq1EmjiiXFAfiJEKbVTqq0rI/eKz5WNcbqMhfapGTNe5OZBQEfWhGj1gkfAVmi36enWxIm9WB8sX30r0jtjDvdFexfWpdYKF/FQZoC0QXZevjyvYKAOOPck+JAWjTFXpP/1ywxt8iMIwsR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TvLE4XPM; arc=fail smtp.client-ip=52.101.196.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbJnKFzD7iHr7xJ2N6KpxUX3zsOEp4H36d+0e97i4vOrN924KcPvbzgsV9ZZIFIJ0ebayemTAr9bZdjCSGR9Q0pDhCAF9XNyUtjW47W6IhtIl9zgKhmA9c1sLY/mzkdugG65MUrfVX+GXDr7bWZj6X/+aGtTtFZSbTt38f0fcvrt52n282yj685XL3bdfmpIEEcj3F12ALJJ2Obu9wi7teysLXsnNMqkumzxe8lecFTCz2A1g3yhmKvQAYqjpoG8MziN3IRUcBS5+tKg75qbAnZ+ohpEwgRPI3hlOY21tMkJe2yOKncG8DTWmtQ1UPMYIJY5KuHfJEySk2PL7vzf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/cb5afzuIJOpDxPLq0PN6KIetGWGEXWL3PomiHgvng=;
 b=eyVxwdd5xuU9yUoxsVJiVtmNUz7IL/8D5yARSEL2gxdyIwa3Re7pxPs0SejKsQZMcYaJvpSupyIUOPl+0WIzs2eTEW4OSv4SQCmxy7nQGJFXXDXgVbDCFhxBBjDDhF3pfc1RPyjiu5/4Xqx/6Celdqyxismia0gAomlqC7qt31S8RqUwPFnWVSfy09u5vIoSrFCGXZHlVFmLpWVnyF9h8f7ceTcbvT237p1aP645CGJbgQuyXVvSDlpAYiLPMa54E9TJ8Bon07sjI6VsOdHwbn/n/319eg/JM3cv9pNoDws7rXmV+TB+mutSUt9fTg2mjUO9q/5pJX4UdqxWJZUpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/cb5afzuIJOpDxPLq0PN6KIetGWGEXWL3PomiHgvng=;
 b=TvLE4XPM/5clgrQbsMGtv3ciJfWIOX9dFtY/V4Kt3x1c//Rt8zy5Q7s0xeKC+m+3XzQ9fPwkzuebncubyvc42z5C2TUXw/BtjPbRxhi9nW/S30/u4m9M4P3KhMnuSualG7rnm4MokdYG8jJ2q9NZzWuhhwVItnk7fSmz4Gscoro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6705.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 19:05:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 19:05:12 +0000
Date: Sat, 3 Jan 2026 19:05:10 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
Message-ID: <20260103190511.2d267164.gary@garyguo.net>
In-Reply-To: <20260103.194448.560764475765900721.fujita.tomonori@gmail.com>
References: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
	<20260101210430.6b210dc6.gary@garyguo.net>
	<20260103.194448.560764475765900721.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f686dd-2a50-4619-f9b2-08de4afb05ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BvILa/XwwuZ6FsrQHq8XTZI6iFzocGe3nzXJqHl2aW3lAQTM47oRuAzYngM?=
 =?us-ascii?Q?KeeG2LLAe56WH+41hB+A+ZPr53KAwxK7RmN/PyXEEa/q5JgsdkwSqqmvPfRP?=
 =?us-ascii?Q?OlrNHJYWQPv6vxVbMj7YL2xe77g+xWOcIE7YelNhITT3IdG/LrUHVsRc8kKG?=
 =?us-ascii?Q?j0RV3TNbzqtnYqk/XjHv7tHfiCM+zHpLGGAohslyKS8HpXbtvebKtrd9OBIf?=
 =?us-ascii?Q?aH0r50jql39TcldAmv+XNtel34Iqe9Ra6Oa4dU6UcD56wCcDyxohpCaxx8Gt?=
 =?us-ascii?Q?xoUPWzgvcpuWRiyMWzJAdFp6sIqg+2Jb164T3VRgIfYApoUBcvrG+6oGNBzI?=
 =?us-ascii?Q?MO8/cu1zlPj4MgO2hky9QM2BvtElT1j4H5hp/E1Lj8pQjHFr/OXkop/iYBZU?=
 =?us-ascii?Q?QiJ86k6AOBPSc/qrmNJDb+9cPeaHVVyukIBkAJ3oUhwyfBPaVF0PFRm0seGK?=
 =?us-ascii?Q?imtkp6g5F3yJYIWzBK3BczS5/S0yEfLks+O/safXNndDlJ97TIrqyJO5NUEo?=
 =?us-ascii?Q?RGLdyxpLRC47k6uhFGxeGeVQXEyQ/jyctk/S/cD9Ug1Hsk0aojy14ESyj6dr?=
 =?us-ascii?Q?3B0Qck5V2AwtxGd0aQeWW9xD1iHrEik85I3mtGhHYt/3t2T0fXs8O5Hyg3sV?=
 =?us-ascii?Q?BMIDbV28BKTsOARZn6j1DZwVx5tn6GY/OoVeivpQYLr10hNyAVLOY8aS4MGr?=
 =?us-ascii?Q?MVTQfKImfwkhMWj6sENsI3cZP2AzvMZAQlT06OgStvYxlyRaDS53cGiJQMyA?=
 =?us-ascii?Q?TAddu5GtWf2OM7kJgOjnCh1RxyLfLKBbgL5PaaUVVRyygG9q9GBf1pN3toAO?=
 =?us-ascii?Q?N5u0nsX+gqE81gZfo4yrPLP83nD/qDIpX+maNymRIVR0t6mt+bGfXvqDDWfj?=
 =?us-ascii?Q?S6g+KqtNvnR13rhVsJN6sx/4hL/TQ6ZG8WGPCUNyrh0t30F1PNbc6tRVVY7o?=
 =?us-ascii?Q?I+LRHo1K3Q/fa+iB4m8Hi4vODaVsGN/+/IyanCCSyi/3kjvoCmwZ/f2ZXylJ?=
 =?us-ascii?Q?fh8fVpPP/PR+Y1/Mh9pcKzTRujQ/555OMsyyR3jzP3Cpv0vC+35EA7ewtqLs?=
 =?us-ascii?Q?2DLD7cFfVddDjte1acL3N5RDI5Nzy94xxxxwItllOJm+YCIhCwFsjGbsJDmO?=
 =?us-ascii?Q?hR+cFKoBSFdc9zJCkYmKONl76z1RC5SDFySAhURAsMh1GLWrbkPuZdVA8POQ?=
 =?us-ascii?Q?LGuJiCjlZJ4HVXNoZ4Ye3eFl5gQ8BqDoLPHnuj+jsrMU/HBNpfQHRDlKaUbx?=
 =?us-ascii?Q?ZBPvplglNd92CBO543jO2pJPuHLofrI7IDRGeEl4VRMEvVkoE0UYWl+Z5av3?=
 =?us-ascii?Q?SbROo2pV2jN2l4XW86NtOzAQBHy8BXukeicNwKQjCUAQu3vtllQ9vh4cpZz2?=
 =?us-ascii?Q?Gn98/f/hZEE36vIUzq4y9d//OvdtQaPQQpskYAeHaMoIUuje+p+h28GufLIg?=
 =?us-ascii?Q?UKHjeRjjhL5rlTgA8kd/6LjKc4SkfSXF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ojPXxwnIE+6csbKNDqwnoyE/zRshUJiQ6aS4AYGWdWrEhyglmqsbls6Hhwm?=
 =?us-ascii?Q?1MCPnqf29SZBkZjr3zvi73lQ14zBi4ARKEk3gIA9VUxm1oqKWj5KmFTbUpNf?=
 =?us-ascii?Q?e5OjZkkrxiN+Bi0jXun0HrimFbq+MCPHQyPdf98+P1IY2HS0ATZ9fQvEZPqF?=
 =?us-ascii?Q?KNdjsML8pvUtvZjowjo56C9UCWezkl+y+LxofagpfNEOtAoARITN7uW1YJWB?=
 =?us-ascii?Q?C6FlflbHutri2jx5LCuKWaCHrw54RpGz8kHQ3nuQQQPlFecspzXuRPBogTbN?=
 =?us-ascii?Q?WOmKhs8qvoUfQPnXd2WyJRTkScPLcqxwid1sRtq/b9S56KGbV2g2x7Lbnik5?=
 =?us-ascii?Q?graeGhPmY+HJ+fnNa2ENe6Wzi/6mJ6uUnO8k2wRD73nxE1yDZAi+c7dZLDb7?=
 =?us-ascii?Q?9bG4jLyPO34Ww3rXt/JG/FL4T8ls5xiU7nvoETrjJl28ebX7DrkBk1UPj0GK?=
 =?us-ascii?Q?F6Y8DL1oAvqTpakSJzA7rBoxdfWop7+Pff9DFk1d8O01SwSBUsyTkHv7V7qW?=
 =?us-ascii?Q?az186dLompaeWq99cE5J3gTRBBgwB0fJpJvCrusbZg79zm8rfv4y7qHm9Ah4?=
 =?us-ascii?Q?u9JZOiMqxbuNvoq6CX7YN8Z2MMe7IaTJBM7Ok0mbS8g5s7bkT8wZQTDwodMK?=
 =?us-ascii?Q?C4VbZEI3fd1vlCBPu52mxrs2Fe4n9chilqLLBb8UhO4Eue5h4zo1F2HcuPpz?=
 =?us-ascii?Q?tW2G4QmTSNKF+gqSm6tthWmHDcF8GR1lzthEEbHIuxpYEV/UN4dIoKkOrtYn?=
 =?us-ascii?Q?m5BQCdWKt7/EgP+HOornO6VRY3vyVyt++LHJQKJa2s3TDlxfW40vU4igifqB?=
 =?us-ascii?Q?b4L3u+1KNPMAfCXW8RrqwsGg6v+Nw1YIf+zQ4Lb3DttxdAIdosVTDT5kmMLE?=
 =?us-ascii?Q?+ZRtTMPnuuDwtbpdMOPKYZme/vR/Q+9im3Ry8xUwpXU2XLRqacsedreJmt/W?=
 =?us-ascii?Q?7lXs1NZZAv1v7f0jXZunMo1uKtN9BdDe9LES57CuKp8k124wpglQJwDjZcZu?=
 =?us-ascii?Q?Iyc8WR/gCh8zClAoeFiUIHcjBvKay1LnDoVFfLRPWgXq2YrS4C5BqUHuPJjH?=
 =?us-ascii?Q?RS0irbCEZ+zHD+XpBz+gZ2Q48J9zJI1VsvpLq63PCrKsjXYEfnVmlUEZb4O4?=
 =?us-ascii?Q?uzuN4gbUVAgraq/nujAyGWFGMIKNKIC4gxVi1SVLk0EnSBG2qTT0z4XwKT/f?=
 =?us-ascii?Q?WbDC/TRRbqEQHh9/earkZacy0dRLycnMax8G1/GIkPmdzc0yJGUOcK3h9gPl?=
 =?us-ascii?Q?C6MQsYoj+lqoozmW6rGbwNjDfxHt6FN0RISLnXWr+V3S151dBGurHAgUIWJ7?=
 =?us-ascii?Q?SYrMMocHnqHXfeOuNzCHgXhTSTpUeoqOj9T1yIevQz0mgYvwKiZhJPfvoxxI?=
 =?us-ascii?Q?784IIUYkroh8c0H+fljVRtO3QD5ApblxdREx/EDceapAtbKVL/PeZRxDJxyQ?=
 =?us-ascii?Q?he4HyICCBZ2YDW1wEKyAB+VVAJ5bsWdEj6qb+Vk2vLORwAmmezvGHrdJ+02I?=
 =?us-ascii?Q?UoBhVqaY6j5fwZBS8bPmoR8nXUmIPhgrNOzR+flno7YSH/DQyKQOKTLrWOx8?=
 =?us-ascii?Q?1oZ8HwMSTZjPu6CgiS5lw6YxP+HncAOZf065mtUMEx4eFTryMO8eIoqQCrvB?=
 =?us-ascii?Q?16DLn6O4fYGT6d0H9mDU6AAE6cms+8wY5RXgeaKjfoWlvmXcA+JOhCUFMAqM?=
 =?us-ascii?Q?uTafrhomL8P2vGqT5y07ks3aXWiQCE8VwVmoFBz7M6DqirCDNhbqlgVUVUsD?=
 =?us-ascii?Q?fiu4gUGIxQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f686dd-2a50-4619-f9b2-08de4afb05ab
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 19:05:12.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2lciF5yIi1jvARuvm3rR2uNGqnjAgK4p/F/jlU0PD/mM3i8aqiAdJdK1+VchZ96AO3QDgvOUhEQmAu8NnDnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6705

On Sat, 03 Jan 2026 19:44:48 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Thu, 1 Jan 2026 21:04:30 +0000
> Gary Guo <gary@garyguo.net> wrote:
> 
> > On Thu,  1 Jan 2026 19:27:18 +0900
> > FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> >   
> >> Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
> >> AtomicType for it, so users can use Atomic<Flag> for boolean flags.
> >> 
> >> Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
> >> particular, when RMW operations such as xchg()/cmpxchg() may be used
> >> and minimizing memory usage is not the top priority. On some
> >> architectures without byte-sized RMW instructions, Atomic<bool> can be
> >> slower for RMW operations.
> >> 
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> ---
> >>  rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >> 
> >> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> >> index 4aebeacb961a..d98ab51ae4fc 100644
> >> --- a/rust/kernel/sync/atomic.rs
> >> +++ b/rust/kernel/sync/atomic.rs
> >> @@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
> >>          unsafe { from_repr(ret) }
> >>      }
> >>  }
> >> +
> >> +/// An atomic flag type backed by `i32`.  
> > 
> > I would recommend that we document that the backing type is the
> > (perf-)optimal type on the target architecure, so arch can decide to use
> > i8 as backing type if they prefer.  
> 
> I'm not sure I fully understand the intent yet.
> 
> Do you mean we should document Flag as being backed by the
> (perf-)optimal integer type for the target architecture, so that the
> backing type can remain an implementation detail and potentially be
> selected per-arch (e.g. i8 on x86) via cfg?

Yes, I don't want anyone to rely on it being i32 (at least for now, before
a concrete use case of doing so appears).

> 
> Yeah, that sounds like a good addition.
> 
> +
> +impl From<Flag> for bool {
> +    fn from(f: Flag) -> Self {
> +        f == Flag::Set
> +    }
> +}

A `#[inline]` is warranted here. Also, it'll be good to have the
conversion for the other direction too.

Best,
Gary




