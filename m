Return-Path: <linux-arch+bounces-6131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B094D62D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F75D282C48
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4413E02A;
	Fri,  9 Aug 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JoQP8KLH"
X-Original-To: linux-arch@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2108.outbound.protection.outlook.com [40.107.122.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0162940D;
	Fri,  9 Aug 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227370; cv=fail; b=tkAQKIva5f7lkchAqpGc3AB9zcIYSaVsHsDsYjRRXpbzZnPUdqEH5XjW5a0+99UtLioUXwen0QhNMLsw0parcRlF1uet8kw5EtrBE9lg3TCawsVWZHXtFvm8lZF2V7B4D+PqSB0Py8Q/9RATSLukP30yBD9UdPATsAs8KuoLnX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227370; c=relaxed/simple;
	bh=LZ5OfRN1WlKMUzsA4VvY1u4W8ZZEK6PTq+sgdqm+wKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elltQ1K+NQDtJUNvA4GDsDeEdzuHqzoFNxL3RunMQBjHsiMFEwQnUfBZjPDDBiolN5Gg1WlZPSB3WOB/YbbIaoup+B6RD9AV2/Whys1O8+pHv8hbGc14AD+JAFKo3dF8gx/qGVtLD0E6kHJmHM8cBK/vBepbmQ1LBpS+ktWiXB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JoQP8KLH; arc=fail smtp.client-ip=40.107.122.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir9F7ZQPRDg0VsRAVVwfweC+X++yzReY/+MO2GWBebqVR9oDqNx6ZzZKBWphCqzU6gg5tYhodAhjrGfxlrhANX0wYCeEqsjdKnhbMr0Z3/rPd9WAC/BhTZIrYB1nl6j0iWJgJW/XimjnO7vXEIq2UxvRi2vwn/Om+0vSmm+Np+cmfZ2PT2h5iOcKHOpVC99f5GG960gCZbsX+oWNWle/fUq8bNMioTBss+6cWzWrEHOglaNRqqylcbdh+NyaLBWOeyaZzUZExgOFK3J/jzHMX70W261bn2WS86AySIcnQRa5XcsarXW+MGN7PA9Gwh6YoDEGj5Ra4qvDoh/7AZYfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro0cjt0RrMazyAxe2LDtC+scgfSEX2YIVx5FUNPVCGM=;
 b=KAOu+ZqHoZWnOlbvvAEpQMU1AmP4Z4xVex0+WnwUfNtt0fPwknIHlE6NDGg50d4R1p1XdcvZR1ETl2cmo5x7+Bv6JNhOa4l+Vs+8tZ96u+52zd7w9/plmASiNcfUP/xPigHHAc5EfyEf6KuUeZP/fC2JLjBU4WGa2aMVoo6eDhwTOmnsrEFiMlOcXxHWrfERTCDP5+AH7Z2uBgik/JAvif+CN6dMpaUW2yMoXosOypViF4qUGq4pmRPXbZWGUSc7hMHrY3lUroq88QhsLVR6tdVBNxnuwBP6x12zz0coFQpcVkwT9kJr6H/RN3OZD2pQfNgzqafDarrgg0+yZqQD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro0cjt0RrMazyAxe2LDtC+scgfSEX2YIVx5FUNPVCGM=;
 b=JoQP8KLHNlB33t2zNt7hv5t8XAiUDlBsEVVCDEFvin13UuTNkjp7bFcHUuvnSMS9HpsCzlCJSA14/rbOJFxkBoRs3xGX9Q9arUuie3bD+s59uWgDY//ShHqV3AA7Lv8Itdmvfp53t+0p3ny6sQjUKfEcoPY9NOEpEZq0fEMRh9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2861.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:172::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 18:16:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 18:16:05 +0000
Date: Fri, 9 Aug 2024 19:16:01 +0100
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
 loongarch@lists.linux.dev
Subject: Re: [PATCH v6 1/5] rust: add generic static_key_false
Message-ID: <20240809191601.3d15e3af.gary@garyguo.net>
In-Reply-To: <20240808-tracepoint-v6-1-a23f800f1189@google.com>
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
	<20240808-tracepoint-v6-1-a23f800f1189@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0646.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3d3127-93d1-4dff-1660-08dcb89f5525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tbbiP5XDsg21qXX7xmmRXrQGhUt4fT6khE48kx3uxDup1jgJdDHJ+1lE4KCn?=
 =?us-ascii?Q?euevsatY9X6GwymU+iO7tKx0Z9MhkEuwbcjlp8cZsJioomfN+/FH6cUlYct5?=
 =?us-ascii?Q?jH626Y+BclgeYwBQGPiVDCHK6KZkjm0xdb27OJ7WZN5v/xi8RjJ/UrLvHR3Z?=
 =?us-ascii?Q?HFJbKLcHQHU43RtDnLf76F13OCsDRdUm61VRKBDYO5tlMkiDZpe+1415OiAi?=
 =?us-ascii?Q?r1NjvDFXEqqrZyXIzaCjyHu8PTs9kGVmcwcWdO+KMEiu6A11tNJcBLbGQn9E?=
 =?us-ascii?Q?SypIbiUoWoQiFYIj+n615Fiqox3Q8hvILX7n6eO6Mf+djhIEkKYIHAM3Cs8b?=
 =?us-ascii?Q?gVdc86RkDHhJinWPYYFS/aKJY4uKP/7UywKu+x2LD7MmR79T99XNsqkkNarx?=
 =?us-ascii?Q?UW+aXMfr+nc2PXj9Z6WKINJJ0J9ibYfrj9k61HaIK5p0Ao8dcK6N4OJsscTm?=
 =?us-ascii?Q?88hdtOSAMKlfxeQQls2WM3eGZ3AQri3EeoE0FSw4gu2f0o48C9CVp2BK8Uv0?=
 =?us-ascii?Q?9AGdOM17FhkjqF1W7rpAcN1nDX1EFeUgPChlVMqfQgXnCNwIzkn7MPJPeFgs?=
 =?us-ascii?Q?E1Dim9aT2Avi5T7IhEgNGRaTjEFagXr0PoUNJNqVv/hwnMaZQuOVwUjwf46u?=
 =?us-ascii?Q?+wF/9NckRMF18xsSO6LsxZ7P53moGxVp0eahLxmEoediSC99ApeDLmQManoa?=
 =?us-ascii?Q?QjfNxddGhAsT+CyMLR7m9+ZAej6WefJouVBaaAt3CJW7eIC3VLUR27rslR7U?=
 =?us-ascii?Q?K6bMflWNjxR0iaKZjavgx1B691UUlh3XD+9UW3A0Rq/5EehH3pkKBrrU4zsZ?=
 =?us-ascii?Q?TEd/baV+j11hcs1Icwb4smpixM5WBXdmf5Z/YuDwinvXz7uZkySKvu5qg8nh?=
 =?us-ascii?Q?uEOfHXXF0v/hhoGigfsrbh/sGwftBRxhM/42qcdLo6sbD4LDzywkLLDfOUH4?=
 =?us-ascii?Q?Pzoe+fb7oK+G1cW0THGOxs43oFU2SgMVOr0RA5DZWMLtrqtXYmrV5bo7u0Fp?=
 =?us-ascii?Q?TOQpAstVb3tmtTUYo/dRr1fT/OxhBmbmpuW5nBNxxyqBeBZXFbdJLPvgtDXf?=
 =?us-ascii?Q?KP+6ky/wYiFYv1soyNZRaUsEAV2qBYc3X/fZfouXRn7Hir5aAWH93qbeTZh+?=
 =?us-ascii?Q?EIUiUTAaPnIXHLHxx5xHKzHiFf2tr1u4dWoUSCCy2M51DuTYnBRWMpif2k9M?=
 =?us-ascii?Q?CuJWtJlJjPV/FFYlLx6xK9cM+J8L4vIe4kDBFECorp04/WhQkrTagkDDv5JT?=
 =?us-ascii?Q?+hS6SJZkRcrL03Cw53DHO1l/5vrThS8H/PJf8hqO9IcQiRysu24DRfR0GsfE?=
 =?us-ascii?Q?cbk3NuVEtkMEUsbqY124vM+O+cVYcQkYUL16D/YmnMPp5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhTqguvXW6YZBUH4iCx6qs2WZEZbbx4JIMJ+2MfQUush5p+7tCC7ze90EabX?=
 =?us-ascii?Q?cmPOwZXmURcLiKuEUixpsmrtXydNuGWs5b41CDptZ/eEn26SLCgNnfA5yRCW?=
 =?us-ascii?Q?2C5VsAJfMaNw+Ey3eyZR2mEHf+JUMjTfY1yxkzMhg3IUxhv3ThoTkt6on3OO?=
 =?us-ascii?Q?Ic80JLlZSeUNx26e4X0dZ4dxEqAVpPxTNv/ju5WphC3121HbhiBYrs9Ou7k3?=
 =?us-ascii?Q?Hn+I4QFvVHr2oPjduCuiMfaS+J1IrfUF4Dmz7iCgx1iVGxLjhZ7xRYhE70lk?=
 =?us-ascii?Q?BZJICo0beum2dP4YGzpS/vDxdLJefW1+BBkZb46FfnGzoxd4eV7h556DBVPU?=
 =?us-ascii?Q?cEclmPbMkTGVcpsLapDqJ/95zBVPAR8S+2KFUczckoCqNg+IrGbJ5xw3MDhy?=
 =?us-ascii?Q?YvqOfA4CrK2DiCP3SBaNQL5+liLRh+oKJVt+ObbzIhdj/5zmJO5ACF2zioNj?=
 =?us-ascii?Q?iNRCLBAU/g5LDyOMFOjm1SbfhFFdlMUVt0tMj0fO3mV3FxhSB7vb42+Azwiz?=
 =?us-ascii?Q?tVYs2ArXaVYyr8zQfO59lHXHQ2zeQIFcu3ztjBpUeoTzJJyewFDaCSVItKwD?=
 =?us-ascii?Q?SGeiqorsaQQeuuokhDbtQdgDT06XaljscadIS3ZJ0JiSYm2yHnkkq+pRshds?=
 =?us-ascii?Q?KfWZC3lvrPpLPcrstVac+ATXcHhwIs0oGth9I5V+C6OpYCfUmuRUijTCPP4f?=
 =?us-ascii?Q?rKbCRHNGrk+Bin7XIKXuqXdfCErXUlVJ/HS3wiMGCoF6We+4WSM3iStJ9gK1?=
 =?us-ascii?Q?ryAR/zKHkNOyxwziGly3D/UemiuJbFjsk3WWoIugh/g+O0pmWAJBLFqKj1m/?=
 =?us-ascii?Q?KzTTun+AfB3pMcdUSJ2MBG0HkZgXn9cefCbAs6ALs0ZMu5CAwTXhJ2S5+86e?=
 =?us-ascii?Q?KHOrx7u1pm2+B7g03VTwThEZLpObrKf2EGsm/zpPABJFoIfjJKR9iYvxaL8b?=
 =?us-ascii?Q?G2VEiiVEx/Rl0jD0qz6Jvsi7FogLyhCzh1tNgQ5P9DcRiNkvLKFcBWmM4gGo?=
 =?us-ascii?Q?/NEbNgM/NNAA3DhgzrpizNPSeDhNH9xpOc/UgjV+zRfhb+oq0DSQ6FXeVwGa?=
 =?us-ascii?Q?z7yigeYjbVB3pK/voTuRnq8XfFWHFroHIfJ4YUyNZfHtPiLtO1GXbWb0ijcq?=
 =?us-ascii?Q?hrBxEwcQhIjOZuVDpxaKw0K95xO0D8SJVjUSMZWSmEw7ROR8MEFJ6orUxVDq?=
 =?us-ascii?Q?WepJno5sm29iQM4T4ikgpEagqkJA2WXavcia7VcG8gQUdb3a/cemVva9NA6j?=
 =?us-ascii?Q?BM3SYjBJXIF/fglp89QRPYf2eRxptT4H8pY294PDbCds3iZX1FEYZYhx2A6G?=
 =?us-ascii?Q?B1Bk/69ccJmdwxc35bDBs4AZ9lStuwbZ3mnUNGZqUD6W7+MMBFRNxjgzfdDd?=
 =?us-ascii?Q?ZT3S9Ab5klPlUhJGDWZoCUJaNJQikh0Pz+uI38oX3Xkve4PsM7nPGe+Elc6F?=
 =?us-ascii?Q?tg3b/39UzA9OcYkoUIsNp0pD6xuNw1wAXa0lPe2f7unjoEFv8TecrjAwCiZi?=
 =?us-ascii?Q?pgSlv3nDOU6UZeufBqO8OQiIOJ+TX6UIwPm4BgBftj4IuyP4xPigNINFA0jO?=
 =?us-ascii?Q?qxDMvLZ3y1f/4ATmYDgtwamM3DYQJOq2IhbWaXaCq7mImmFCsPbIKd9XSB1D?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3d3127-93d1-4dff-1660-08dcb89f5525
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 18:16:04.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO/YroiJM6No0tqBf3VLB3IdzsnXKWETF5jKhnws7b67D3ygMUwwCKDhtpavFS2YfYnLIoidwQimdaR+iH1Oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2861

On Thu, 08 Aug 2024 17:23:37 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
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
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h       |  1 +
>  rust/helpers.c                        |  9 +++++++++
>  rust/kernel/arch_static_branch_asm.rs |  1 +
>  rust/kernel/jump_label.rs             | 29 +++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                    |  1 +
>  5 files changed, 41 insertions(+)
> 
> diff --git a/rust/kernel/arch_static_branch_asm.rs b/rust/kernel/arch_static_branch_asm.rs
> new file mode 100644
> index 000000000000..958f1f130455
> --- /dev/null
> +++ b/rust/kernel/arch_static_branch_asm.rs
> @@ -0,0 +1 @@
> +::kernel::concat_literals!("1: jmp " "{l_yes}" " # objtool NOPs this \n\t" ".pushsection __jump_table,  \"aw\" \n\t" " " ".balign 8" " " "\n\t" ".long 1b - . \n\t" ".long " "{l_yes}" "- . \n\t" " " ".quad" " " " " "{symb} + {off} + {branch}" " - . \n\t" ".popsection \n\t")


I believe this file is included by mistake, given it's added to
gitignore in patch 5.

Best,
Gary

