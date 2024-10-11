Return-Path: <linux-arch+bounces-8034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB899A384
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E25B24A2E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99C216A3B;
	Fri, 11 Oct 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qnVAhyz1"
X-Original-To: linux-arch@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2127.outbound.protection.outlook.com [40.107.122.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081B1BDAA1;
	Fri, 11 Oct 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648809; cv=fail; b=JUPEcAAIqRnPFb0FavFDahCApJ5vnHk/H7sD/gFlbZvPSdTtnWTmfRsUlZtFC36+7HSaGRgoMQAlLfwG/K3/qQjzrLX3Z4QPrk0Wi+8EttGQZdW9nlL1cZNe+6jgvjaNpwt6DnRNlPZOHW8TP4PphqFsX2M3urgCxWXP9sf2g90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648809; c=relaxed/simple;
	bh=N6kBlFnhxHbzzRLvy2n0TO0HMSJSC/kk/oHPglWikRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MR78ImdvcpAkDDRPT2v5qMTx3deUfaiaj4A8rDj5VvYp0hJNU6KB1Ry6sRQdlfX02v9ePrmHJha9hxt7kAlJIYPFuzEhCLH9fpM/1Pj5IBHOIux5li8+ALIRD2ShZxq8DJBZeKpSJqBJcmGDlMlw4Q5fUVOgBlRmIbn3VKQaAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qnVAhyz1; arc=fail smtp.client-ip=40.107.122.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzYC0uPxcOlWNviNH7x9xIWyTraI2XgloWvh3c8Gloom7etjsN03lV9zIGh2EEkEUK+2RhbOpIuV6wp5dPEakLpsdwjYNUHei6uzP1XGrqGwnQH5O9ARdjDVrD06XrsXIRQkdz4GEV/J+0OYl/UeRrIp7HvyfYcgyRWdC0NFPzV/cb1glPxUMY85xjgsMJytXY1pQnXl84xHRRVBSNKoy3rPvJP53BkQvo1ssLxQOzKYnmJheHBIXffl4E+2eeNawCXKxOuHLeJ8pfqPXwJAObHWGTsc9myPjbvtd3qEGjdRVuac/Mx712Xu/XgbXdGvoR76ggyz7OdsgCGp46FdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DDq+WoksRSvViNEEuG0Aq4sek7ulKuTsXTctEeA4ds=;
 b=VutUZ6OC5TPcAq8vwuXBg5hrdHkShEU3+f9MiLLTy/6eyGuWZaepJleJYhUJs/kNTaIZ+q9pggxyPlzhhn88R7AjKLpPeSF1PAnWP98zRZyBexJkPnq3ENFIXXMS6x/VswKLyJn7P/HXLgmZ1HqLwdaRtcRXKuFUMuPMe1y3TAGuEfBujG9p40k+pB+7bQkRBszF4DdQjMzs6iIn3jBNt+l147/4FEBMnIyLsdTOmazM2hWHzOTsgiUHHvJYl+P5wGdT1eJXvU1sxIdvpx9Qz484kMVxx0L7sq0HXJBtIiXaQJ4gNdBDLZ05pl3VBsmSjZ5gCVjnDp9IQHV4SvDzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DDq+WoksRSvViNEEuG0Aq4sek7ulKuTsXTctEeA4ds=;
 b=qnVAhyz17o0GN+MJ/M1UCcjojgVCA4OuJOWs2C2BT4AfboW+qLLo+nYrjRF4UdsVJeJ2lC7UZs0vSgx9iq9aZGkGoO7H3Jbcnt/R8W0bPcVo6jw8CfnO+Dqb+arbp2xrBfWHjqLq8z6AVTy8KuR+wpUMTta/q6o7uKpgPnmVUyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB7220.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 12:13:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 12:13:20 +0000
Date: Fri, 11 Oct 2024 13:13:16 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>,
 Uros Bizjak <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v10 1/5] rust: add static_branch_unlikely for
 static_key_false
Message-ID: <20241011131316.5d6e5d10@eugeo>
In-Reply-To: <20241011-tracepoint-v10-1-7fbde4d6b525@google.com>
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
	<20241011-tracepoint-v10-1-7fbde4d6b525@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c607e1f-375d-4803-d0ab-08dce9ee1888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KmlhvFrBP+lj8H48hDcT2TITHOKv8hRseuNwNm2hRXEveDdPzHhzxsH2CdF?=
 =?us-ascii?Q?xH7zrifqryJ9IqKjf0UNUBzsF+ibsOd4j5Keo82JkRxlgNi3e2NvBquWSVTP?=
 =?us-ascii?Q?tQALpF1hKYLEZjavxJSzYA032BgL3zmD43CPLR4DSZkMS3IAgiTyodg/tn8m?=
 =?us-ascii?Q?fM+q0FOjm7A+lMVIN3VvoLwKs6Fc8sWEWWgJ0dM2A0eAsakxEzCeePzlKlgl?=
 =?us-ascii?Q?d3sVpUHlW4EDz55yI449jRmRhH5wX0falpS3DpBbd9bZs/HJnCa8x8emzP11?=
 =?us-ascii?Q?+cycVBccsxr+9FwXYSLaf4NKsedQWxuLyj+bAW0tsfK8dbgFzjirTmQSzWdW?=
 =?us-ascii?Q?ygLrzc+aa3+VsHxA0N13glIqqIN1LJA/Dlz/Je+hQGxJo1BJpE3H5mo1AfiM?=
 =?us-ascii?Q?dyIQpyQ6UNQDx7d6lZxZBUnMF0nAQ04oDXjC9a8cdKF+sI5OCLfk5NR/6XWh?=
 =?us-ascii?Q?VfWongQ5iCTE5NdPPFwgv1aPy0GhXkfn7q+vFMSmOSJcrH1dxh4e+KbBn7pl?=
 =?us-ascii?Q?REzGg76+0QfTph3oLvi8rl13sWaxU4FjNddkpRVQA04LIEIe4WSebw55frSq?=
 =?us-ascii?Q?mbsTQeeGUtksyW3wpVeywtPgZLMmbiGPJShwMHW397/hmY3cFLFFeEQ8XN5k?=
 =?us-ascii?Q?2kT5D9EEL81r+G+V4rmE9D1PjrN7Dp42bKzlUNgYqC08T7EwVRGiyer+upCc?=
 =?us-ascii?Q?Hk+/GXTNo3QUapo9NwUnfpzy8PaJV9lD6ojlZDr8pqqPM4vGl+dE370scUJ9?=
 =?us-ascii?Q?DdOMlhpYGxJUQ8IEjV51BiqRF3ARV/HeqLjLYdfBAeG4hcTeS73iKI+ZzLg/?=
 =?us-ascii?Q?UY7gi+MCEDOmBNbhgZcfVWBdJ3PysMaByyp/5LwjwaP+vV3HG5m2uo3ASejI?=
 =?us-ascii?Q?xbcX3FmP0DXQWLrqifgnBxkQJYfTTCTaYWffZjtsFBcKqG0K2jDEJzn7ngwM?=
 =?us-ascii?Q?/MOV34smDdl0EzB5qRwZLNsJa5NdvqkRW+k99kSG5YxB8ftTxtWYPos/x2ek?=
 =?us-ascii?Q?y96P4tMHlayNO0A66jjZdarsadl2x5b3NozAatiFIf8+UY0a7Hldc4/jEq2Y?=
 =?us-ascii?Q?qoxdD/MVNMkmkiYQ2X05LEjudjwSNr07HhCtVEMZ16QTQkI1rD5r7PM0QnzP?=
 =?us-ascii?Q?McWNeHVDLgJVn9uFLL0/SEuN7jMOwtpYRwXtKtQvNSe1Bo8QdpCekV+pE3Rs?=
 =?us-ascii?Q?uWux4h3sl5mv74lgc57XTFm9215zYI8hYyTJ8eV+hfTOcsX2eJtyvSucAGO2?=
 =?us-ascii?Q?H+En+ONv1J256CFLG9VYOcON2ussfTN8w4vYC4qREA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j91FfNDrTiFiRpiVXy2lWKofa/oTZHu3IkvBmMmuHU5lNac290UkOWCR9AOV?=
 =?us-ascii?Q?xrhmR/W+WdEk+qVYsn8wD9xVkFbIIqHMoA7KYUvmwTJyYoNCkbolMppekQzl?=
 =?us-ascii?Q?HqyirYc8oKHEDe1zngxKVxObEHtOpsZssXpkxJu/WJx/a3jNHYz+lYAlVgfH?=
 =?us-ascii?Q?HaCW14OA4XXZQqlRy75UoILqmlbRIUASOdLPOgKsigD1W3Rrd9Gtg6WUZjT7?=
 =?us-ascii?Q?ZO5dPNg4rh0GovoWlkFe6jR7ACcqqGo4/P0ipWopjoFgz7IxrKUC1gLOASM4?=
 =?us-ascii?Q?GVhiu3aM9ygQ31kb/yNyoi+cHskFYRMVQI8cCHRLyE40cFpn9B+wBBO4C3Ng?=
 =?us-ascii?Q?/ZphUT9IPL81W7TTFSOEA1LLdlYjqfsiTsaBl3PB0PTakC8IbE8NdVP7l9TY?=
 =?us-ascii?Q?YHH7EfvuWpSkv9PyH7QtfGH+6E1orcA5bOGmZ1PuVLBmTGSobpF0seI6rbQm?=
 =?us-ascii?Q?L5PKHejWEn9UxYGK/g9dLuf8j0E1ZdZjuGrXX2PMbiONub5rzreTZ+MJWC/F?=
 =?us-ascii?Q?kn7netWg2aF1DoXTNPiCksOim9N8bLJVUJZOd3jUHVGf7FNo+KPKgmI433D/?=
 =?us-ascii?Q?EAC/2Mo3X44KppThGpgU/gI3O7F7m8U9asvtKn8S83oMdQkJr5/dpSnmBO8a?=
 =?us-ascii?Q?2TkPOHfedtZtk13FGPpI/HcOEvxvKRTnb982Rye6q4Kxmtbm3jLlwO83UCXs?=
 =?us-ascii?Q?oT5neN7Vh+PhRCj1pcLvqXGZTkGBu2cp2lzNHHnzPZkPVDzxRR7AnnQbjKWf?=
 =?us-ascii?Q?J5V9PuG6bFkmN8v9FXGposERROnTzoxnIURp/DYjbz5JE0ijreiPnoJnuc5U?=
 =?us-ascii?Q?ZglaZLBkL1oqX2fVOLGDAFnlKTCk7hhK0LVraW+C78uXMnx5OyZjd63bsVMy?=
 =?us-ascii?Q?0RStUOyrhZAgo1ID95reyVpWU262XM0Qq7IKX7LpTOf4O7Zuc13ua0UI1PyJ?=
 =?us-ascii?Q?mgUMS/f+zFnSvqLQHFEqsMH5Wcq+k176WXL0K8aV48zRQQvxIrjkZF6UeOlt?=
 =?us-ascii?Q?kTpj5M7euc8ieV+tWtRAsEsMIt9nkNBRSBUGkvGe1N9hJ+/wVZuf09gcB3/7?=
 =?us-ascii?Q?jjI7TcYPhHjdc//p2LJ5AAb2jU6Wx6o4azx+ZtG83sXRIWpC3zjZ3u2+1cBZ?=
 =?us-ascii?Q?CuUSQJmV1/BcHHUyAMP9qUPxr5EI/jtlerWh3WrR5CUQiLu5xcn6R1n3bgti?=
 =?us-ascii?Q?JSZziZDBN7FZziex/fszn4QNNfDOy9faXhk/iQFrZ0Ku5OnJO+J1MKfhOAdw?=
 =?us-ascii?Q?F12GkWCYZ8kNUKLhV55dd9ptqFXIC0pwcmXBJpH68ns80pr7WqXPmKhmmH69?=
 =?us-ascii?Q?lPnJmGnkaSt/nEZD7moQW76HReAo8uc/X3tK9ymIjD3fw+NyQp17J/hYdMYi?=
 =?us-ascii?Q?WR+A75qwMD3KDYcoQR1Ia1d9RUsXFZoYIqFGuBKA8iDGfb/TI4gd0z4qF/VZ?=
 =?us-ascii?Q?aou2DNiO+UqPuK/9si5gRHml1yFgiq8M0fDMS/SV8Ztd/+AalRofXMgY/4qG?=
 =?us-ascii?Q?RvsCCDg6btT2UYH72hmCSBPgiHfufTkIZffTumoDM/42SVz1Xd1J6SSDtl5P?=
 =?us-ascii?Q?y+/9G6tmhLjbQOimPiD3InDQyaBphSFyZs9hbqZ7Wjs/byOwOfJyVupMoaO6?=
 =?us-ascii?Q?2YlOy3Lw3rY2UcnMjyt7172YPE89IUmx8Ofuy62lsMLj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c607e1f-375d-4803-d0ab-08dce9ee1888
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 12:13:20.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iCnu3LGOlsfDjHddHxOIqzT/oSYetllUbLhkmG76LI+BaTdHOuI+OePGmQ0GWJG6UQFt6hiPw7Wohb4SSLLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7220

On Fri, 11 Oct 2024 10:13:34 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_branch_unlikely` with a `struct
> static_key_false`, so we add the same functionality to Rust.
> 
> This patch only provides a generic implementation without code patching
> (matching the one used when CONFIG_JUMP_LABEL is disabled). Later
> patches add support for inline asm implementations that use runtime
> patching.
> 
> When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
> function, so a Rust helper is defined for `static_key_count` in this
> case. If Rust is compiled with LTO, this call should get inlined. The
> helper can be eliminated once we have the necessary inline asm to make
> atomic operations from Rust.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/jump_label.c       | 15 +++++++++++++++
>  rust/kernel/jump_label.rs       | 30 ++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 48 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..e0846e7e93e6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -14,6 +14,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/firmware.h>
>  #include <linux/jiffies.h>
> +#include <linux/jump_label.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..17e1b60d178f 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
>  #include "build_assert.c"
>  #include "build_bug.c"
>  #include "err.c"
> +#include "jump_label.c"
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/helpers/jump_label.c b/rust/helpers/jump_label.c
> new file mode 100644
> index 000000000000..6948cae5738f
> --- /dev/null
> +++ b/rust/helpers/jump_label.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2024 Google LLC.
> + */
> +
> +#include <linux/jump_label.h>
> +
> +#ifndef CONFIG_JUMP_LABEL
> +int rust_helper_static_key_count(struct static_key *key)
> +{
> +	return static_key_count(key);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_static_key_count);

^ Explicit export should be removed. This only works because we didn't
remove export.h from all helpers.c yet, but there's a patch to do
that and this will stop working.

You can add a Reviewed-by from me with this fixed.

> +#endif
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> new file mode 100644
> index 000000000000..4b7655b2a022
> --- /dev/null
> +++ b/rust/kernel/jump_label.rs
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for static keys.
> +//!
> +//! C header: [`include/linux/jump_label.h`](srctree/include/linux/jump_label.h).
> +
> +/// Branch based on a static key.
> +///
> +/// Takes three arguments:
> +///
> +/// * `key` - the path to the static variable containing the `static_key`.
> +/// * `keytyp` - the type of `key`.
> +/// * `field` - the name of the field of `key` that contains the `static_key`.
> +///
> +/// # Safety
> +///
> +/// The macro must be used with a real static key defined by C.
> +#[macro_export]
> +macro_rules! static_branch_unlikely {
> +    ($key:path, $keytyp:ty, $field:ident) => {{
> +        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
> +        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
> +        let _key: *const $crate::bindings::static_key = _key.cast();
> +
> +        $crate::bindings::static_key_count(_key.cast_mut()) > 0
> +    }};
> +}
> +pub use static_branch_unlikely;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b5f4b3ce6b48..708ff817ccc3 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> 


