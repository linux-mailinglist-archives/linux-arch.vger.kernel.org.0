Return-Path: <linux-arch+bounces-5723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6938941020
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD9EB247AA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB119AD81;
	Tue, 30 Jul 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Lo0HYcEB"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021134.outbound.protection.outlook.com [52.101.95.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200D1990AD;
	Tue, 30 Jul 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335735; cv=fail; b=fjOHUidLB6L4DA1RA6bZvIPhiUSQjS1O5jyqA8oSLzvRSSn/q9qDqyKpT94CWC/g9i2/3eP0BU1mzNyRNXtJE+FhXR1N7afPEOtL/5+egMaNR6TYxAhHvske2/DoNaacZO2+fiE5MxnXt6Waazf4UM2vfwSJfA6rkvNQobyRAgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335735; c=relaxed/simple;
	bh=cECuk2V2fAOl60BXMo+bifWkbuO76pR/Hkju5V9RRLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7QIZb0ykQpO3VqWcohniID3QDMXu0MJtdXCOv9E6sRANGqpT7Ub4ZCEnrWN35hAAgpP9Kp15aPkEQuHqOVRdXWH26nsxze+bzLSYxasa5/gWxWCeS/RqlGjA8HkB6dPWKKYE+BxhUkcE2NeY5elJ2KiR7FvAgCNLh8QOrofafo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Lo0HYcEB; arc=fail smtp.client-ip=52.101.95.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJRyzB+kLSqxIVkAojJwXCiVVL1r36DFQRqJa40YbjnmpFWVeFt8Dpo5CFlJQ71yIEqw3ZA219OdvjTuvFOW8CTRTbx/6PqwPY34+GrnEOVnBdRTIM1NIVwCHM/fxIRjh/XMUo3PoK+tagSy1ugBEb5hArZjbGmJIpXrxVA7EM448Kn1BPs34+O8LglIkPWeAO/ozyDHWF5g+OB9BfgahkauBt/gb5p0LeB0hFJdWQ7MH+8WQi2z+Q0a8xh3CR17CAQm3HeOojq8bL7WqOc6HnRkCjpkxhA7Xpo22znmdMtEk3Ho3GeU9rkZDgEjNyxvAsha3Pd1u8t0M+p1iJEoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifExQZBT2KRq/Wuc/SNvXo9/avN+B5ru3aUvVgkGPUs=;
 b=m9EUSdR1cYl6F0eDUS8sbvd7rUoQ9o9K6WOSr+EL1jasQsT3EDg5zW/doxDCddNwaVhEGFhclDTDU6Didn9NszMbtdVLdXRZcL/29LroemaczH6bsdynv88pMJKy9w+py7T/+qhETk5Nko/0kABOyfe76KEDcXtdKI2xIExXfFbTHsguFtIqL0uqjys1SX5IyyKVSnm0r8YJW4lZ4SUCtUVsmRXhh7zd3dAD09SPgAl6D/frRjiaS/qLpCTdb/kW0oS0YkjqTVSWlf46FE2961i/vV8LAYFpZitTUGYL9KNHEt7mOj9trxbsvs/pg46UE3oyqCFuVNzkmfgkyaAf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifExQZBT2KRq/Wuc/SNvXo9/avN+B5ru3aUvVgkGPUs=;
 b=Lo0HYcEBQYDdGMdyHmWcsH77z8a3siH01wQj5FpHmj6RWBGmUodkdkoFzW/487rfnPvYegQEBiL4n01j1LCabYVVaszNu5Karom0Yf9HXwhuqdUfrAKrBh4/l1cBJo87j90L3Ab7+qxhI3chQXyfx/hIvJLWtjupIFUd0AdcmD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB2748.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:35:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:35:31 +0000
Date: Tue, 30 Jul 2024 11:35:27 +0100
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
Subject: Re: [PATCH v4 2/2] rust: add tracepoint support
Message-ID: <20240730113527.5c9896db@eugeo>
In-Reply-To: <20240628-tracepoint-v4-2-353d523a9c15@google.com>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
	<20240628-tracepoint-v4-2-353d523a9c15@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB2748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8361ad91-41fd-4b3b-1133-08dcb08355d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?302UUQ8rxSXXztzDtjumQghT8qY7syjxSIcRzcWf3w/CbKQsR6whxCbcp47c?=
 =?us-ascii?Q?brwsrz9ueMJZgTUhPTldTEkMIdFD4XUuzzXaGAAG5UVCk/Ztk5+U99e56/54?=
 =?us-ascii?Q?CzfT2arCRjXykRIdpnxqaSj4xe8z1UgTf1FWED5uK64/xnZ9/zM3FrvT3Q/C?=
 =?us-ascii?Q?Y/ejfOuGlDiqmCdebcJDZuFlgICB08ZwrBsZTUUztJNVkbsk46HEMPpSkDt1?=
 =?us-ascii?Q?NDEAS9vjV6qjW955At5ywMp752nVIcEXu744miXYzmFgS9UwAxJ/lXZb72lX?=
 =?us-ascii?Q?nCEDP0PUgi6HE1njnO5ZID7P6jcTu2P7eKPMEhTeYNl0g5VbKnfMJbKPS8ui?=
 =?us-ascii?Q?5zRsYw1TP3chf391ZHdB4WjYxT6Goru5epRO9HwTvH1gZzX8LjOa95miQ2DR?=
 =?us-ascii?Q?kDJfj5sAqJ8YcUEW0BtCCEg0UY25mU+wELtJwn8YaaCYCPckp5tais7SKQ7x?=
 =?us-ascii?Q?cE1NhrGM+UsewE2nxToJAoFPjFvAQ3nqa1fSMI8Vc1sxk8wqsCYGLGcWOqHa?=
 =?us-ascii?Q?rlTRNr5xvF4/CHViuD1kHuiwj0qF0f+otgD8+eFnE1RRmRWTungNC3EoH4Fk?=
 =?us-ascii?Q?WGVjmZ5Hm92mA28extNU6+VhOIqfSendAs+RKqERPkny9NOUTSn8G26plchG?=
 =?us-ascii?Q?gA67m+K1K8dX7e9mNB/GCsBRpHFqvA3MLTQIbiHdmi2Vb89VacM9er55tNXC?=
 =?us-ascii?Q?kE4HJ/q675U1wKlrB+fcb8PlFKO6UNBpvs+h8dEFwXqRzAUZ1ciQn8BvjB5C?=
 =?us-ascii?Q?ITtXbu9Ova35BcDRE/u1cc89EwfUAVbN7vIashQpf4uMIZRTrTYQ8WSA/Elx?=
 =?us-ascii?Q?d32LMheXOJ3QN7bEXaw2LUAln2Rx8WkTEq1EX180ziEaUub02utPA0+Lo16K?=
 =?us-ascii?Q?4LV9XV3HhsZyEXTMXs+Bhh/6yDOtolJbrRqU/nKfnSBGysf+Uodl4lv+O6C4?=
 =?us-ascii?Q?Uut3EJWDjZvGGGgVJJDsiZfFZ7ztoiygJ60CTmUgFE9Blegdbt04Z5wuElAr?=
 =?us-ascii?Q?6VHhMA0Rs90sq+So+W3zWJoWNvz38vOFeUXYed6fP7zPe4UdSQsZ+neQ9BJt?=
 =?us-ascii?Q?d567ue7GLFq/NNwIpNCz0Tqo4Bz/dVj69em8isCeW3pBAd/7GdChblozdSJJ?=
 =?us-ascii?Q?5WCvzOWXggNpRas0PN0G7FrSiZt6TRzEoj/yOGai6iWAMcttCTNdO/hxKT08?=
 =?us-ascii?Q?9O4qlSwsjkWXCcr/LnS1/ucclmCq5YvkvhcUUNMEUwOIKr3C0eX4GGQKxlbD?=
 =?us-ascii?Q?pJ0Nmojijr98F9qfd4W/+jA2rXP6beP3zhQpizs39ho1W5xjM+Y+PFBaJ+aQ?=
 =?us-ascii?Q?vUi0xFvSttPD1cF6xFyJ0LF3fUg4hr6iICs6vYSLyaPZ7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNPd4zEcuC6LaJpiKh1VXzBz3Yeimyu4wFPkDJPj4vcJtM8/AViWIa9kXHGX?=
 =?us-ascii?Q?Bl75zBfrkIYU5caqLc4YfrRlAyrsOzRZamHsVx0FtYtjzioD76l0NQogfPDR?=
 =?us-ascii?Q?Qp2+2fLBQG6WlaKhoB4ZBGrpCAWlN43V/lexTTx8uxZ+FAVE6H2Z8eNe9G82?=
 =?us-ascii?Q?nvXAo1j5Dv3j7hg+PyO11sxXkXGiD+A9uMjhax3r8dwzmlvPx+lol3X+W67y?=
 =?us-ascii?Q?e4NhaRfnR8M/2cv1ZDfMi3nI8mqAvMU/Bz9a8UmcZTIS2qEI4OCKf5w5aE90?=
 =?us-ascii?Q?8JPm8FIfe2gWuqOcp/9C2jGjHm/k8OY6UNeAhG5giQUoP1FOWh+D6mHsWaM3?=
 =?us-ascii?Q?M2s4fd7mlBNK8/+nCjokfH9N63GwoZtVjB1s5QxIYgM4xr5DBNhMivYli+kw?=
 =?us-ascii?Q?OfhBF0sOw3PMLUYTpQKDQfAMhZDeA+Jh0yeW98dz+0C19IgNn3T5XDDTLmhL?=
 =?us-ascii?Q?kuD0O08rCubAH3FtQOHJwcvbnIr5wddGFSmeN15w+PDZY21xlO+49kCY2EMh?=
 =?us-ascii?Q?rvE5NfWTtt21ZM70ETd18P3TZEf7ElcP2xMlMKUfMjOea9fjn8VfA8VoEzB3?=
 =?us-ascii?Q?PH5saY5qeM/JeuDKluCUSDv1k0GODol6YC5trSWk+S1oQMbqWqkB+wlhR3It?=
 =?us-ascii?Q?bPc69/b2BLGqahclFU0+HiP2zzf0OoS7ynE6Ok2CZKifXudzTDmXPUie0z46?=
 =?us-ascii?Q?i7frrLOQ9ZLF7NznY+uOPIIC/B3LgJpkOnJLG806ypERJDkUobmHkQ4uPYjZ?=
 =?us-ascii?Q?UEAAG82F5w7NjkRQ2CFb/OEE6+ODzYY9/DKa0TDcwtz2UUJcNUS1CEuWyAeJ?=
 =?us-ascii?Q?DG/vDq4WyRQtI66eMGVbP5Ij/UHkvNU7FIK9GhYvvn0nj2+Uh54xi/GvCWpk?=
 =?us-ascii?Q?IwSGyexVHQVoaolIEl7qU4u17w+HnrfNaIOO5Qzy+6upRJfVdRvdawPey0Rq?=
 =?us-ascii?Q?imkWOGM5fbNkdtK6qLbAecOGn1d3UachOwk3pPu6oABhdDspHZPBoFn9f5qh?=
 =?us-ascii?Q?dGCEBeh68fk7DeXQZYCPURQ/m4wcMU0KX8wp5zGmW7gNtngDIKyq+aUjilyb?=
 =?us-ascii?Q?E8I+zWKQUsCj3mfddgxtdsEH1HquwwiuFKj5bvWDVPezD+JW6lbm8wAMZ0eu?=
 =?us-ascii?Q?irH7urlBSvAppTVG9KDfq/dsmCKMsnOPG+y08R69O5UnyaaZ4rlwCSy44TqB?=
 =?us-ascii?Q?4pMVvXcF4GfvdDy5dos1clrxOlAfEYRGkZxGKG8bYsvCP9CKZxSmJBbNu3Zw?=
 =?us-ascii?Q?GwieiRiqDzVu0lBAFglC2VPMN9p85cPIBvkLi0/c1XnMM0gGAXZz2j5BM380?=
 =?us-ascii?Q?UovLKd83FFyy1IA+EcIBRY7O76W1h4D5S2wyXaRxD1FnHsPjAp85f/ax05Pg?=
 =?us-ascii?Q?hBN0rPb5YgdcrCWPMz2h4GR3RTpKFoVvyfNCCLqLjaCkJ4KaCMi2u2599Lx9?=
 =?us-ascii?Q?oijKttmsHOatvL2z+cZoMz/3txHUVd2YNB2KpzJExmwKsyDw6YItjwg7ybvy?=
 =?us-ascii?Q?O6UmOP1YJ2B7o834JGAklJxwRsBRyCKqPGYrJO65IHqmWqSCY6zr16/M1iVK?=
 =?us-ascii?Q?NbWZqYP0R7yoH7VM+KKqiq6+j8Gl+trlY/dViAo3?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8361ad91-41fd-4b3b-1133-08dcb08355d9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:35:30.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uz3L3g3HUPw8B9wx2kZgf9iM0O4b9Hl+0Zk7PVRKYbEuZGcHGglchfgjq0pgiXmNOKX7mwQsO9GsrgCXfVb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2748

On Fri, 28 Jun 2024 13:23:32 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

The Rust part LGTM. Some comment about the C part.

> ---
>  include/linux/tracepoint.h      | 18 +++++++++++++++-
>  include/trace/define_trace.h    | 12 +++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 689b6d71590e..d82af4d77c9f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>  
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
> +	notrace void rust_do_trace_##name(proto)			\
> +	{								\
> +		__DO_TRACE(name,					\
> +			TP_ARGS(args),					\
> +			cpu_online(raw_smp_processor_id()), 0);		\

I guess this doesn't support conditions. Currently the conditions are
specified during declaration and not during definition.

Would it make sense to have

	static inline void do_trace_##name(proto)
	{
		__DO_TRACE(name, TP_ARGS(args), TP_CONDITION(cond), 0);
	}

in `__DECLARE_TRACE` and then simply call it in `rust_do_trace_##name`?

> +	}
> +
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section will
>   * not add unwanted padding between the beginning of the section and the
> @@ -253,6 +267,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	extern int __traceiter_##name(data_proto);			\
>  	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
>  	extern struct tracepoint __tracepoint_##name;			\
> +	extern void rust_do_trace_##name(proto);			\
>  	static inline void trace_##name(proto)				\
>  	{								\
>  		if (static_key_false(&__tracepoint_##name.key))		\
> @@ -337,7 +352,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	void __probestub_##_name(void *__data, proto)			\
>  	{								\
>  	}								\
> -	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> +	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
> +	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
>  
>  #define DEFINE_TRACE(name, proto, args)		\
>  	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 00723935dcc7..08ed5ce63a96 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -72,6 +72,13 @@
>  #define DECLARE_TRACE(name, proto, args)	\
>  	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>  
> +/* If requested, create helpers for calling these tracepoints from Rust. */
> +#ifdef CREATE_RUST_TRACE_POINTS
> +#undef DEFINE_RUST_DO_TRACE
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
> +	DEFINE_RUST_DO_TRACE_REAL(name, PARAMS(proto), PARAMS(args))
> +#endif
> +
>  #undef TRACE_INCLUDE
>  #undef __TRACE_INCLUDE
>  
> @@ -129,6 +136,11 @@
>  # undef UNDEF_TRACE_INCLUDE_PATH
>  #endif
>  
> +#ifdef CREATE_RUST_TRACE_POINTS
> +# undef DEFINE_RUST_DO_TRACE
> +# define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#endif
> +
>  /* We may be processing more files */
>  #define CREATE_TRACE_POINTS
>  

