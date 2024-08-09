Return-Path: <linux-arch+bounces-6132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5C94D63C
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 20:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC531C21270
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301914E2E6;
	Fri,  9 Aug 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XDfvu8i8"
X-Original-To: linux-arch@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2129.outbound.protection.outlook.com [40.107.122.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1874503C;
	Fri,  9 Aug 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227660; cv=fail; b=C4f7zHPPCtFwJ7foM/hbxcaS5fi8/F560qmr+6ftq6YH3wVT0vWs1LXx3vzkLztT8uesinSetJM4oNM67W1GSYMcdcqX1yFJEtgkpAVR53KVOJywmmEeCiUuIwaN5Mcfq7TpWX9xxmomTAfxkJc2klCzgEsxz845Ueph9Gi+R9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227660; c=relaxed/simple;
	bh=CEBM9M/lOB+bMzBHp+X6+rVV4tpr3VW+bUoRFajVdVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbCPX+FTOxcW+eXVxMS1hePxqvFRJ+X8zp0wdqgdPiKcfVyafJDCoDt3ioeZhD3L+qOV9EEGw5ftRprq435lwPpDTy8DItZsYg+HE9eZmi11mKfLplLYjlfeFZPlcWl6OemgjGBg6GLhTAxefAJaCmh/gXOmaFLjJLzv2XBymMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XDfvu8i8; arc=fail smtp.client-ip=40.107.122.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTm2gi2vc6FDDM3xSoCu8qhHR4LqR2oCUFp3F6dSXiucw8nNBf6lgJgsKiU6lk62nOdf+dkSTabACCMeW72e+vwXk2P34Y/Bg0M8YdNDYRcVtwVKoFc9Qr3s04J7gM2b4cVQAKHSX84rkQA00E/ssUT1pb7qVTozZuLTJ+IFulrR/1LLCxnTBWl6O9QWOfdckkZwp8pGOnXxpYVJZJHp59SrC6HPn1IN/0zOYrlWqnwxu3wfKiunNDqhKGZJi9G2H9tcEik1U1GoqWNf/Bk5LKF4PoToqwI2JILNJqFWDjDx8S+SPqbtjKM+Wl6X68gGFYh9klAdhFyDvdUz453mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=041wA+nZr29nC3qKS5XM5jsGNPFleq0ao67TggDmu70=;
 b=VE9jx4td0uPwbtQ+F4EYY+tp0az0munuDC6/3g+wxJRMn3v864I4ddEj3Tk5YeauZXor23u24aIK8nuoQyi0xKCldU9paESrA+8EDp72AwIRhaadRNNZyd9MFhWEvmiUN9eE3hfkJRKuciRkDOEz7dexrBL3CJPBoS7m60qzIKSd1YaCYMog3JFEOGFjELNrcxQFuoSZR3VScvkJre31zAZIDXkjLbBHEmxJIJnWdsZ/9QpjRJC05s6fI7JpNBGisbhb1Qm966ONbv3JW7sS2UlyKICbhb8ASvaQHNRbNbesVkmnAbzX5IzV0XsQwRbxmFhrqRqJpxvDn6Ga0XgwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=041wA+nZr29nC3qKS5XM5jsGNPFleq0ao67TggDmu70=;
 b=XDfvu8i8rOiC6tjd12RivGQ0wLTcqpa3MgtY5J/8qhwZX/LJ8or7z25wXPxnSlUrKLVPRmQR/rml6JxTbnsRycei1Jbdnww1RBQLHACEXCjxpnliXyy7Iqj9dLQq2sdaGFUP4nbGDK5JG6DDdZBHSGgUTW6HB76oKHocgVC512U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2861.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:172::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 18:20:46 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 18:20:46 +0000
Date: Fri, 9 Aug 2024 19:20:43 +0100
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
 Hindborg <a.hindborg@samsung.com>, linux-trace-kernel@vger.kernel.org,
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
 loongarch@lists.linux.dev, Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH v6 2/5] rust: add tracepoint support
Message-ID: <20240809192043.1311c228.gary@garyguo.net>
In-Reply-To: <20240808-tracepoint-v6-2-a23f800f1189@google.com>
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
	<20240808-tracepoint-v6-2-a23f800f1189@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2861:EE_
X-MS-Office365-Filtering-Correlation-Id: e77e95e0-dedb-42cf-9e12-08dcb89ffd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+SrlREq9JlEW/QIRcOpd4MNUQnAUjSLeWnLX/7qP0ZV6bEDlc+heJfXPBpN?=
 =?us-ascii?Q?kKJI2xLzs/MOQvftR8D1EcLiBqkpep9S5GZ56Z0pjkCVFNgP5W44+y9tFvLD?=
 =?us-ascii?Q?Q93xIuITIJ6D4WcV5ewBep9w7+dM69GqByY8w5xKFUwck6+4X80+U3/haxys?=
 =?us-ascii?Q?lGk5uMSQ4LQCSQ3jUVa58kLuRLFjhblZiMg+Bo0PvIDmqs4SKHHlHJHo5KBD?=
 =?us-ascii?Q?hplUedo8JSQM2GjMSbbovWCMIK9xo7z/5KwBkv18V4q876cxERZQ/PPqkIZP?=
 =?us-ascii?Q?w9dvlQaQ5MUyEy+a7XN4Ci68XUXugT5CYhRDAuEEeMvcBl3a1lNdYw8DZqKo?=
 =?us-ascii?Q?YpSejjF1KbMDBdI2am5EBi3bmxTBxMVPJdj4+BeQ3gwRSsqDvmF7OR/0QC29?=
 =?us-ascii?Q?hIQc+VvgvWnMhRCNf8IVJ37g2FuTJbxhhylIc3MSVoX7PWGYjJhDi9LPIGGQ?=
 =?us-ascii?Q?EsPIkcUKYC+pxcf0JpYK7XPuTzt28hF/+7tnCK6TEzVAQrrpaYPw4mSrhPYZ?=
 =?us-ascii?Q?t7Fh5TAxSv0moxkz1BBbzf5VNtIERp1NjmvcQcv7QCpy7hmG7Axd8xgtiqp2?=
 =?us-ascii?Q?QqANVNp8k1AIhMbtpcvnoz9kLumT6HUryYM+HiqE4J8hAmZWlNkA0DyeP6n7?=
 =?us-ascii?Q?N7vcjAH6shNkJ86Ow6Lc/WQWOWraSFfova/N1BDOjdIYIs6kTGOd0TDNxBAd?=
 =?us-ascii?Q?YTBXH+mdUIf5DdwiYCMdxjdbBOn04Rr15SwP8f0KRt57Bi4VyMRwb7WO76PZ?=
 =?us-ascii?Q?O5d0Yw3klawRSu3X97mZ3GvQUKXLBR7kdnf1qDl+zJD6yuLXINjT+RLRW6ft?=
 =?us-ascii?Q?GXL86dI5etOQvSgAsjv86sFUuOWv3kCm9siOAet0LEL184OdVM7Yj5lB4spk?=
 =?us-ascii?Q?1s+nPAnrfWHx5gPxdw7FNMw3lCcaXpDE4tRfD7yB9g8K+Ygljoqp/19Dp8Bg?=
 =?us-ascii?Q?LY/9S+5i4NBU525kke9yCDBmFsXfdK6FNe+fVU9mIm6iwlZt+3t1ZNkTS4BD?=
 =?us-ascii?Q?AXGhw0/jNQhNPUTsSwmApW8QcMx6Q4DlLfDvB6cRFj5ZLqlPY6WyHk+8yGVX?=
 =?us-ascii?Q?+utO3UI1pkyOBRMfGjz9vLNKmIm4S2n0uD7IkY1Pt9BmHMdI5F1j0DRAPksO?=
 =?us-ascii?Q?5rHM0F3UXwUdB/mMsvyZODuCxSpoQrrQvX6HHftnV5TfOJYFOPfaI5B0JZuW?=
 =?us-ascii?Q?eJmSzXFEqrS58/QTt6UIYKYRy6l+keQZYjM3tUTaaIJwu1gfMJblartv+uRt?=
 =?us-ascii?Q?7suL9aKHom8+cg/xCb0e0yrVL9o5t9U/EEC32phtpo4+IqDlDtvrcEHz9g/R?=
 =?us-ascii?Q?CWILvBv7V1+qC0irT5P5OBxJ2aLheB52ymIlpfM2ooZsUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkKHNPiv7PE8aJJIvmOLB/HLmo+w8pK4ZpsDU+LhXbMYOTaxNrVpDzVdP7XE?=
 =?us-ascii?Q?UQXOFW5za/FY8N89QKgs4genWClNr5B9JiEJQA6/+2jqZEdjd98/4YRfJ8tS?=
 =?us-ascii?Q?pdAnW7SFHbc6yMIpdCvXJ9HFecS9fXM491JzuoAXbZaNXaq9IcfCX3rFeka+?=
 =?us-ascii?Q?mTjfWdMQ8Q7tFbezLRU2adj6Ixu9s9NNxPX3XOYtOY1YvS7bPWYEL3T9fyeF?=
 =?us-ascii?Q?cpH8OGz8+lPf5JHSRqLvTaqvvSqhUk9Xu2CB+1qihyjvh/rbmfCi4e1LgcMY?=
 =?us-ascii?Q?7Na6pDHWNR9zq3rx/WY852L3+DfKg2SYlYuQKZ7aUUA6BxneqgDhKlQ/MBbO?=
 =?us-ascii?Q?y41zUSdB+Te9eGog/uS8OHpd+On+pUm9Jqaz9Fg3j1nVsgRWgYp+3zu4K+Gc?=
 =?us-ascii?Q?yZ3DHyzS8Ff5HYNFTIAJwH9wU1kARyk5AP58I6bgIqZfpYYUnRjiEjgj6esp?=
 =?us-ascii?Q?avszwXcgsk/8V8PG66cvRfFh2Ni20ON+nxyggVPjvSnNc70hLDB6+Io83LW6?=
 =?us-ascii?Q?T6eNkhf0Wx29xDfMkWon44PTz2OCH+catC5Bc+aREiFsnSx5UyE3pcsVn1SR?=
 =?us-ascii?Q?szx5Ad/FEc5fBhteAI+V7PtnrUleCvvW6gnDNIzVHEc252JO1vrIORwxh4o0?=
 =?us-ascii?Q?tId9tXFNUFDJQzrgrO9wJzSR1udXL5DtQ9Ilk2LPUaez0PBqzimQJJum0dkk?=
 =?us-ascii?Q?ddo3cxTW/55LxVk5eCiM5h5T+AmUBDFFoUBGZEyTmADtrpWXqvwXCfbCLbIp?=
 =?us-ascii?Q?+/Y9w0Xxf3vgy/JxBU7pW5qQjnnbX5A6flSqQmUxK69ouCSzNMvRN6z6uVoS?=
 =?us-ascii?Q?lxZO/nZe/31oHjvB7SOFDxxVKKZSVbCiCSkEz2jGpsat58vG9MUDXxF8SV7q?=
 =?us-ascii?Q?sBvEp6t1MlqRP6hv3IbSsImksJZjnVq5qm2zWVtzZx8Y2HCox+4nvItvy9Ih?=
 =?us-ascii?Q?QQN7Bc+xJtujJ/+Kf0tiXw4HKV+O61mzRLlN0ujN54A6RiR0n4J8ltf0aZI3?=
 =?us-ascii?Q?am5PTeN5/2KljNYnRilpl0oGCgH8M1/u6W8Vg9GQYoMKjkCVBGdFjvjaWoqc?=
 =?us-ascii?Q?OGWRvghr0ncefJpWZzXHHmUu8RB6SwrBTrB/3TFH8Rek39HjJH31RKisNlBP?=
 =?us-ascii?Q?h5tv3iWi8H7i3X1wkLTBFfieR5sl3ohQUfrEADrDiG0Lk6svdtgoORHtegVN?=
 =?us-ascii?Q?v5zN9P88YXMTHavKaaG9/AgwJJNt19UmhP7Fp5z61q01d6pUcCbX/XzSM6T3?=
 =?us-ascii?Q?vRZ5tTocmAuXB34nfoiMVyDtFJ7jCR3AO/qyhRb1gbqBrb1WBJbqqEjV3Fyy?=
 =?us-ascii?Q?dUhzQoheSW78H4IE9Pgu6AngOnqcCZAqj+Fmpkulu+teT+DXXLDLTzlEyUrU?=
 =?us-ascii?Q?dd85maLKDSY5vrSBUf3K43+TbrgKmq8YnY6h09Kmc7206wSmseADblI1QxDd?=
 =?us-ascii?Q?2j+YaoWubtqB6J6Bng/KGqwjVH1gnKPWT+Zghz5A88jqpemGu7heogIw9lWW?=
 =?us-ascii?Q?gLKF02hnsWbtjYIDFAduqjpdC8D/J48yNI3RYEniiRLTyZ02edhX3/lwGYrp?=
 =?us-ascii?Q?lX8numnlpAzMbEWw89VBwPZ7BsrGLRVYZ/WqgNbL+K9ulbIjrvibnKCbiPxs?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e77e95e0-dedb-42cf-9e12-08dcb89ffd2c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 18:20:46.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/h0dH1Q4I6xvIFpHC54ULDAFF0WpTs8DMOiRad/PdIdCnj5Vzv5c2Yyi20flBQhSeWen0x9UbhH/We8km9ThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2861

On Thu, 08 Aug 2024 17:23:38 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Instead of calling __DO_TRACE directly, the exported rust_do_trace_
> function calls an inline helper function. This is because the `cond`
> argument does not exist at the callsite of DEFINE_RUST_DO_TRACE.
> 
> __DECLARE_TRACE always emits an inline static and an extern declaration
> that is only used when CREATE_RUST_TRACE_POINTS is set. These should not
> end up in the final binary so it is not a problem that they sometimes
> are emitted without a user.
> 
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  include/linux/tracepoint.h      | 22 +++++++++++++++++-
>  include/trace/define_trace.h    | 12 ++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 84 insertions(+), 1 deletion(-)

