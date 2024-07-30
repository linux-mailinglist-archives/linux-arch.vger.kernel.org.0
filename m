Return-Path: <linux-arch+bounces-5722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67C940ED7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558692824C3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9E194A6B;
	Tue, 30 Jul 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RJlGkIxR"
X-Original-To: linux-arch@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2128.outbound.protection.outlook.com [40.107.121.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F73208DA;
	Tue, 30 Jul 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334822; cv=fail; b=XLFPoGdn7iYGqikLXR0Rbk3qT2q1MLeWiARsgO1GrH41i9sbmkjCzygy6PfQQdAPlxOoTToli+Aiqxb1dBT11/0rADtC0pL/fpQwt+DUENC7HPO3ug6i6iRf4Fc1C4jMcmZDb4eqHrYjwZpcB/qxuU68riU8mfVrS86rzSAtktI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334822; c=relaxed/simple;
	bh=DRBX85TKORC6ogGB9Xdfymm5GWtJCaf6cp+bzF5BvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZE5w1vLZron4/ekd2EgulCISMznFI3DP8FsJtDUEXgrDiWv1QRljhZQCYut/9jM5KFP8r7V05LBNmN72QEQe5hT+ihBe+DrsNYWeJhVAEjmYdNbkM7ZpBtJJLCL6RmEu7Y4nBoeL3qY/XSZBb91joYid6YJLEeTsq5Q3vTnRSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RJlGkIxR; arc=fail smtp.client-ip=40.107.121.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H15IKT4X4gpjBH0ZtjQEraW+3QLG1g5joOzVUjQq9Sm64V+ypIwqyqIdrp3wmnoJh1gaK0U11KkxTGLeT8SlEMA7axaUHl8wm4AHyJVraHVSQYCSSHrRWCcilAVK0dGI3a+ET7FqBREvFtVlLevxsdtUsqNkBA7yE4j2oiU7eEGalicy4EfwniCJpbIaoMBzlo3E5N+MpRMnlkUuBi/z/cHo/onGHi3BLmNShZ+O52pHSwrg9koN0VVacHG3iXa6/LvXzSugwDGeDHUS0ps+/DUVVaYle964ArDq9KBNHtd8PjF5Gc3OWeq/05Jtk1SC2jbgyKpuugYn5tTvxoxCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFZ82QBk/r0tIiq+WrT1tcKo2VV8NOsNSkcij4YS1pg=;
 b=Ggft1D4oulvbyEWNZMDfApoFwK+ToPgN389N+OcMbSTX2xGJ6qchY97kyAJ2pY4jCsOgSkLa7fEoe00sS2lPquryAICgA8CyDUEj7Pb/UuZPjnVYnHzdouHM+4ZkL1H69/uaFGtUkklB1LpSjNNKZhuNKpDbE5pCnG4Wpso+H71shnMToAit24LwTs9a3J2VbBfv+YkhZ5CblIuy7rkgOpTN4nB8Rjg0L6Rav/V69nO0RtWzWMuOYVfBeITxXI59caAgtsHR05Jp70Nrq7ooqk/EWD2B22Eh4EbMWb3685KX2cLtE70X0fRjlkE9HsEU5SYuKJUCqLq0X2UnIp56EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFZ82QBk/r0tIiq+WrT1tcKo2VV8NOsNSkcij4YS1pg=;
 b=RJlGkIxR8mQmOnjSLUu9nwNd32BFSnZxcDREeSrA+bZuqDBWqiKrVbt9fe9JI/vo8OhyGmpTaQeO3DoLmmXWXSUwnmwIVXqN0KfWfVq6zVAGmL6y7ZMuBuEhUg2kjj5FrjhlxtKBxW9p8PW1/SmxNkRxJvSy/iY98gnG9gqHpTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3481.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:20:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:20:17 +0000
Date: Tue, 30 Jul 2024 11:20:13 +0100
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
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradaed.org>, Sean Christopherson <seanjc@google.com>, Uros
 Bizjak <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
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
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
Message-ID: <20240730112013.4d0cd624@eugeo>
In-Reply-To: <20240628-tracepoint-v4-1-353d523a9c15@google.com>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
	<20240628-tracepoint-v4-1-353d523a9c15@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3481:EE_
X-MS-Office365-Filtering-Correlation-Id: 08349b05-4d70-48aa-6913-08dcb081352b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6InyZ1pyPdlryjPSoDsqa3qc5xecLwKH2pZ2dSBXOiS7gY1uEP6ohU1xMUYh?=
 =?us-ascii?Q?j/9TTKBsuucGStJUqNwSzzaJAjQCDGAlbgIKz+7E0BxCwkOBHX45Wxv5aGSM?=
 =?us-ascii?Q?GwvkxhZVToGtOgEENkx8rJvLNP3DTBSzYKYYcQYpXLLO6JrKXbFVzIJK4MES?=
 =?us-ascii?Q?RixYG5RvXPKNUZKYd0WxkbYLSQBFs43CAGpMNfSmRFDdN+N6Do0jmnLjAwhI?=
 =?us-ascii?Q?StU019DdXLpsw3YVcTpKr0I+FERrCXZ1TxQc6hIB8h7mOB/SmQ1rCzyiK3r3?=
 =?us-ascii?Q?gMnlUF+ps8d7/twrbOJB4KGxrW/CkOJRKuC0ixHi5WqF0Pm4yJDavsBaDiMe?=
 =?us-ascii?Q?wghIJRhQuUhqDyaLx/wF38Ff7kyCEXzOGwz69R6iYQEL0Y2opRmJnzhpl3Yi?=
 =?us-ascii?Q?h5n+GGsk9h3gtBWdOw34/ZbOGYCaz2bFetVSPCgnPYsFdsWoZZJ7pvI/Om5g?=
 =?us-ascii?Q?Of18hllFtQCoQDfeBe4PVtmZ9tqQ2tNu5TY/m04/c1ulvyLliiHRM5jmW7Ro?=
 =?us-ascii?Q?GRnKq7sBmdluFdPd8ISFbFYC47KYM6WhEqXS4om2lqRNWo4ZSK5Ejcx/e7lE?=
 =?us-ascii?Q?sJFSNtYDwIyxKT8fFvqVYWTDTIozymMx9G+Axv6PegMLstw911ZfiKh13Uyn?=
 =?us-ascii?Q?B7Rt/cY3elLC0dunxvucu06d3MtMLFO5m91UNuu+e4UnfCq6413CoyFPjptc?=
 =?us-ascii?Q?vAr1zanRmmzMxy4hxezOl8JLZVhZxuz0tSuSYprV6EE43rfGVzd+lUfhEy30?=
 =?us-ascii?Q?Pc/8epaUHzn7KPRj3xXs/aStFmrEv45/pPCDuGUFJ1Jft1U4ZSxzCbXvDt2Z?=
 =?us-ascii?Q?G8nRDd4RcPDebMGpYZv6r7qTvJhq9nEhIB8hnAXc+7bAiXBUx/74xlddiul/?=
 =?us-ascii?Q?SYSPN/vpMEkYz9u3HV+Q6uxGts/1+Mcmbhx8AW0gjY906jJefzi2z0pNnbhi?=
 =?us-ascii?Q?BNPaL3IsWumqmLSrhtJoODAIOvYrZmKRneQVpWcjjDZOd3UZxTY6zykqN/LO?=
 =?us-ascii?Q?WDmH9bAPaa29mjnJwK36uTyjswh+sMyqJl/rOhx/hEsVayjF539WR3MwUvUA?=
 =?us-ascii?Q?/Iyf9cKlPwOsr/6iaiDzekENyVSIKRVBokmrWLJrAfpLz4PF21w/n3C4lTAb?=
 =?us-ascii?Q?L+XJ8jWv/hnRBZIvs4wZW237hTuuagJ31NtN9WNorZy09Kao++w1QB+UMZxw?=
 =?us-ascii?Q?OqMR+HZ1Mq8A1O3P5oYxTeORLx6BmjjVfpaDveWdUZ3tzTNLExq6foCSYn9T?=
 =?us-ascii?Q?akguO5NylAQ3P0DEUAMEd0GtM7VPu6Cy1jqCNM+CEooyH7kpZwnvUm+sarJU?=
 =?us-ascii?Q?/Gc48ri2j0kr0a4pkb91sBnqjMMdapkskMFwN+VP7bdIww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7gP54bxgXn652BZq7K1Jc4ll7qzkjUERp2b+Q0uQfl2xJo+tiXAl5iOAGNa?=
 =?us-ascii?Q?zoKD8cGxRWhzX0uHtc3AcVTtDZU/9hsJPWRUowT5BRirCpilGE/Gc+itwT82?=
 =?us-ascii?Q?3wExkpg8qGE+yClKj5sK+V4rNTaKlDxIPFRkw+YSGuBM7cHSWgW+2/cSwxKj?=
 =?us-ascii?Q?dW6NuU7HFTfVETg2+5jSAX96vUjMAYNH9p32vnxs22YZY/fYpkRry+py5Np5?=
 =?us-ascii?Q?DZzUJ6JHDQ7LSVFsdrXFDJIcu4IIdaCiSlLjlU08eDr12qcnsXq/MWkGv9UQ?=
 =?us-ascii?Q?+u0iEFe2oEySGJACspIDMSZeudqkp54X2czbpEOSudoIzE4DM1hakv57wgCw?=
 =?us-ascii?Q?RRzZPEvBALdESNfqDPLiZ/ATq0HUInTzp+mYqXCFkNzsDolJRNcEhps6JUQx?=
 =?us-ascii?Q?EdFic9U5nePg6eV1FraDWRUfVuy8WypNRn0Y3qV9SlP8mPv4P/K7XTYpAMfO?=
 =?us-ascii?Q?r0qge7PAOcvi/JHfmaUlUxg4RKliRVXlED209vX+G2RlRA7QCZwSnxm0EyUg?=
 =?us-ascii?Q?KS+aE12UzHocwhCrl4V7wI434Sn9CYG2zEF4QaVztgY3gsG7HA1iTUlcZOAV?=
 =?us-ascii?Q?6OiFG1XGmGW2R1zhjjxc+Zhnwh/LTjIqW0E66KMCpNyDGxyw8O+0sm6FEzT7?=
 =?us-ascii?Q?fAKyta0Rds7XbIttVMEXhCmj7LqyE7O+R6Zk9Fu7siZ73SyvERt1QwYcy+G1?=
 =?us-ascii?Q?LiCI8Y5aIfzsaW02lFwiiZsujH4PX4JaMXbO/F8D2fYHVlXhnbwONvAsXbQ/?=
 =?us-ascii?Q?AeshYtEFeD0Y4fvupGlt8mbm1N8n+hEowHMZsgqokxm7U5IFJhCWggy+YilY?=
 =?us-ascii?Q?laNi8MnL3omjlnqde30movfFH+GA1ArJXBjEOSsBsomYC1w8mPKi6od8uAxO?=
 =?us-ascii?Q?rOJGEdUnwBO2kmK1WKRL/I0xwycwGW6S9bfqzuH/zQaBfD6RYSh53Zh20Hj7?=
 =?us-ascii?Q?L9t5Avd0Qb8B+ZlRHf9X5wZHad4af05ZtLQxddZp2w1QA8GDn979c8tePATr?=
 =?us-ascii?Q?zJdKYMFEWcwdXIUI73IUuwzAaG9Nq5f+EaBTY2Ofm6CcoplXZ0zeRSFUeJ1H?=
 =?us-ascii?Q?jSMhoaHmnNmtJRu2xxOkDmdTxj1ovTHJL/fdoaFzAUWTIDEL8qcuygQk0Ygr?=
 =?us-ascii?Q?0Sh7XKpWrok7fzMB5StLEA/uKe8hN9YFvliG8ligyUhkduu5i0dMAZwr+kRA?=
 =?us-ascii?Q?foJN7vO8h2ZvapQJUNSwjALglrIfrtc35oDzzlwx4k0C6m/X89rAc434Xc4+?=
 =?us-ascii?Q?khh7W5OsAw0Bg/+mNla+qeannP9XQsP/WYk2lvviUGK+xElo+KYa+AMVo0H3?=
 =?us-ascii?Q?Ac2IvOUxXOktIbuT68KYxLrMInLIccVpetC7N36gjqlyim40kCZGpEclTr+i?=
 =?us-ascii?Q?gJb7umNn7q3eg+cnSqKhciuSzhLxglovY5IWFjSzeZSOZ/YSpsvfconxugvq?=
 =?us-ascii?Q?Zldr1UdfeLiMI8WJY6zRqEA1OIChbamcvcQOKKhMBcQMzL7vs2YGVk2gNF28?=
 =?us-ascii?Q?/FSMVPI/dxUzZ8n1ZEGXHKcRGMtdS6i0vCtKEsfa3nElluK1j7lGfVNcpZfq?=
 =?us-ascii?Q?f8BIX/+ZPk6I4/gYAl1R7EQkKXA2aZ30Yy4AP7By?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08349b05-4d70-48aa-6913-08dcb081352b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:20:17.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnqH9N/yzHb61y5doCAdlqbsaLVkwmp33gdB7v1mqY05HviLF/DyVb/0pEGRnsjzIl8bwhE133VXVGzle7l0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3481

On Fri, 28 Jun 2024 13:23:31 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
> 
> It is not possible to use the existing C implementation of
> arch_static_branch because it passes the argument `key` to inline
> assembly as an 'i' parameter, so any attempt to add a C helper for this
> function will fail to compile because the value of `key` must be known
> at compile-time.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++++++++
>  rust/kernel/arch/loongarch/jump_label.rs | 35 +++++++++++++++++++++++++++++
>  rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++++++
>  rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++++++++++
>  rust/kernel/arch/x86/jump_label.rs       | 35 +++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                       |  2 ++
>  rust/kernel/static_key.rs                | 32 +++++++++++++++++++++++++++
>  scripts/Makefile.build                   |  2 +-
>  8 files changed, 201 insertions(+), 1 deletion(-)

