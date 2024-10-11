Return-Path: <linux-arch+bounces-8046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E496699A8AB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 18:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9128492D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997C198A10;
	Fri, 11 Oct 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jJRVLG5L"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022095.outbound.protection.outlook.com [52.101.96.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265016F27E;
	Fri, 11 Oct 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663180; cv=fail; b=axrS8eU7Z9gItGMuxLdcsKEaOz93wtAAGQfiWyUlPCPRcdQ9Cfz9CxeFbxrO4bFw2+cep3IYbnTxchu81fxG1LBqm+JpFkspAa+nf3RnJMCbZmeEllhYpa6CMKCpfVXtaXWNXhlK737PRU6aim34vmKjuX+3aVugkoGPeEtHo+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663180; c=relaxed/simple;
	bh=MIcIlK5fz7WBkiXjL8gC8Dk/Qf51Xq3fjwgYAwJaC8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hg+m6mYTf/Awt6gOrrITs58mvFz1jWjZAc/g3srEyYwSal/PkleTcnYb55N75KsEthzn0FKBHtE+FJQBsDQEO/v7lIK1tSthf3N2WGap/UxL35SKk3/+/of/fR+H+jPXJ35+8GW20MlESwwAueTwOLtNZC4s7OUVpRMlwHZ+zMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jJRVLG5L; arc=fail smtp.client-ip=52.101.96.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpSd3PoljVBvYuwyJfnSsdeQzpCC5Y6aDU2SfjTlRDb20dO5c5KnMgtoIjfdslNzBGwwIyCGmgNHcJWZgm9xH+lW7WCj5FptRSIT6+ZUUyLVBrYU3V4Cgr3hi13Fb15jRapLnOGa2C7d+/sMVIBh/k1NF6UO6AuaOINCkIkq3khHwSVgylEN+pbQbtbh+Axud/b6xfASKE+9uSn4klTNoxMRfjMQsWhyQLh4tBUiYETTkmDZVAsXO28BVWGjUhjQVGaGkLaZ38uBCTyBhtkWQM8SmNncD+HhvjKyaJYdwmUCW9405BTyExXWS/L7Jghqu/CkHZseTbmNijN2UMZ5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t03ajzDGx0sYewOhnV4hN1bg+F5FhWBD/B4a3Q2tE3E=;
 b=jIRzAxZ3qUeXcGtS8o1Pu0Lo295MJucP4elHp2uMR9INyrvJcZ3vjl2LHzy8DiVxT7Kud7EaxsYU+g5IENgsqxBDyLxgmh+t3Ss2A3R92bBJW991u4WiQmwTsnB9CdOz2s8WDgUVbzK80xq2CnXwOY9icAHo/6RjdGpQY8ai7JbBnBQX1v31RzIe93WU7ELPSJpHTjQ5p+JPZM05/97HU9qWBvcvdMK9jSF2ofVsd7HF9947f8iBKt5A4f9XPZhSx/GyGc0l3pYo5k5iH8csUM9ECTpEO7EzGRnr6G1cINBg1SAWBnsWgAejmdWIqDVcpwgG8ui+JHS+1VZ/hbK5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t03ajzDGx0sYewOhnV4hN1bg+F5FhWBD/B4a3Q2tE3E=;
 b=jJRVLG5LSwocyUFlxtsVN9r4bEiVpruYyqmZt6pBs/wH9VuKIrVv6cFi9dmeZ8nXU4kPkPWANzstSpR1y4//QkxmrwYIbNpXV7E6wlf2TsWkS6A83OVtKcxAZ+LIDv5bJSY+Wh3r60vYSq5/PDnngVoWqXi+k7Xhe4eKob4ANjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2782.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 16:12:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 16:12:55 +0000
Date: Fri, 11 Oct 2024 17:12:51 +0100
From: Gary Guo <gary@garyguo.net>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
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
Message-ID: <20241011171251.0bd53f01@eugeo>
In-Reply-To: <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com>
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
	<20241011-tracepoint-v10-1-7fbde4d6b525@google.com>
	<20241011131316.5d6e5d10@eugeo>
	<CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3343d5cb-6873-4fee-252e-08dcea0f90d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjdrVHJ5QmlmcFUvQkF3WU8wM3U4UzJKVFJJYkhreXkxLzFxdzEwUDJIVjlN?=
 =?utf-8?B?b1VaWVVSQjdyVE8wN2RuS0gyTjFrVFYzY0wwSWdoenMwMlUvdVc2TTlzVTQ4?=
 =?utf-8?B?TXBHRGJ5RVdzVXR1MS9rbmthcmpQOXY4SUR3ZlJveDN5TEU4NkphdXBpRnd1?=
 =?utf-8?B?UmYxUGs3Z0NNQ1Y2UllzWVFDb2d6eGk1dkZoZ3VuL1NRTS9nNHZGRjJiQ1cr?=
 =?utf-8?B?bWJoeGhtc0lLWjFkQWVBZ1FmY1V1VmdKRDFBSkkxOWNCNkl0OVJnZldGd09Z?=
 =?utf-8?B?czJiNldob2RPR0d0UDF0ZE9ZV1R0cFVDYnlFV1RUOVFpc2V0dHhRMGk3YnNn?=
 =?utf-8?B?T0w5cE10andSbFpxWEtTM2pLQTFlQzAwNEVqaG9UZnFhNkhLbXgrbi95MUky?=
 =?utf-8?B?RmxlTEdKWnVLbTVXNzZZZXNpKzJmck9pWVJuUVd4TThSTkphRWpMbzJpNE1n?=
 =?utf-8?B?bDZ3ZjYrRUZIWG5UV244TVNvNjRsODlRK2NKOVF2QzQ2b2c0UFhzYTlNTGE4?=
 =?utf-8?B?VHJkQ2VGaTQ4Zzc2cjFzM2o1RXZlbzJ5RDhjaWtRZkg4bVhrQ2VKRm90ckc0?=
 =?utf-8?B?c1RGSU1JUjhmZTQ5cmNxVTA5a0pacFU5WmoxcExUS3JkY2tBcHBKZWRwZWRq?=
 =?utf-8?B?VjEwaGV4NjRzcWFLZUswN3FYck94ZHpZejVDOW9BYzZWcHF2c3h1L1BTSG9F?=
 =?utf-8?B?QXVpOHlnWkNqSTdoV2s3YTNEYnd4MUgwNW92VG5TUFdVNVRXQnRrZXJmV1oz?=
 =?utf-8?B?Y0FPdEU5cExxak5QbUNZZ3dJSGRQOFBBSGZGYzRhVFpOL281T3dHNkdSRlp5?=
 =?utf-8?B?ZEFBbmtaSGE3NENPeWZkT0piaTE5Z1pqb2VYVXRKZlU0NXFBZUxNMTFyS1h4?=
 =?utf-8?B?WHVHQWRZbGM4bmRNaU80ZmMrN3lmbFBRWlZlQitmOWxoYWtUdjJRUlF6SjhG?=
 =?utf-8?B?cDYyOWErc2QzRWlFcldrWGhRM0ZoMUdSTTc2d205OVd6RWJ2MlVLcERxNWdL?=
 =?utf-8?B?M0M5OUtXSHRRdndCbUI2RDNEdUgwUXppeTQ4MGM4cWdOd2dFRDU0ZjBzdXJ0?=
 =?utf-8?B?U3V0Mkhad3dFWW9HWnh2NnVWWVJ4NWFIS0F4TUxMWDhlaTZZWkFKenZ0SGRE?=
 =?utf-8?B?VFZmYm5UVEtQcUh3QWRVc05MaUxCZ0dadzV0NmJSbCtkMCtqRzFrb3QzRXNI?=
 =?utf-8?B?Ukxsem9xc3o4Y01OTk5maXhVcytqNDZDS1I4bjJKOVBZMlR3M0UzaTJueWhF?=
 =?utf-8?B?RUxqWDhtTEJZbEhrVjZYR0pESlI5Q3J4WGoyUUFNK0lLeUc2ek1WemQ3Wk5m?=
 =?utf-8?B?MG01dkpRWFMweTEzNHVXZ3dzaXdReHNFZVg5aWN4YmxvNGM0QkdmaUtic1RS?=
 =?utf-8?B?ZktrT2ZHVWlVQUc1d1diZGRBUVpYdkIvcGtTcjFReDN5dU1LTVREUFNmRmZ1?=
 =?utf-8?B?NHE0WXg3cTBmN0NOQUNmWDZnVHZMK1k2MjBDRUdmTjZjR2w4cnhxUC83dzMr?=
 =?utf-8?B?WkhSc1ZpTnpRNGI4cXZKRGpGUm5KZHo4SkZVM3F3aUN0UUM4TThXTExENkhp?=
 =?utf-8?B?aisvZis4L21tL2VBd21NUEVFaGlFZDN5aDlmdG1LamNFYzhKZ3ovWDRWSlZx?=
 =?utf-8?B?RWlNRWtuZ21WaDJxdmF5MDVVYXQwc25qSVVZZVFzTEdrQ0NQaCs0bGdiK004?=
 =?utf-8?B?S3dZSlNVSEF0aWMzUW1Ga2E2eEU3aDcwQWM1K09Md1ZvRVRrUC9IdjFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RtS0VpeUtCbGZ1VmRtUE9KTjZ0eUdDZnkwa1lwU2F0RTMwSktJcWxnUVRy?=
 =?utf-8?B?MU44VW1lZEMzWkNlZWdYOEtyZjRuV2xuV015Y0E1VFp0OVdqSGV5Y0xEdVlM?=
 =?utf-8?B?SmFOY2VzeTVsYk92UCtGYmJZamxZRFpIMnFaTzQ0d05zRVhtd09PSkNmeDd3?=
 =?utf-8?B?dm96Wmtzd1MzSUk5Q1RyVHdhSGNUM0lyZUZQRGlxU0oydzBKSmRac3d1WTU5?=
 =?utf-8?B?ZDRWbzBBSHdwdnBHL0lCSXVEMHZvVFVqQTQ3d0dhdEV3TDFQOFNDTEtjaXZD?=
 =?utf-8?B?VUwrbWhiczVQa2hZZVZXYUtVcDJYTVFTaE1MY2EvKzhpTUlBalp5QmZIZFJn?=
 =?utf-8?B?WjNoQVNPQ3diNnM2UkdON29JUW43K2xYQWV2aDRDL1ZsQ0ZTa1k2aTdaTFE2?=
 =?utf-8?B?YmwvMWxhejQ4Q1IxODV4ZkFkRmNTWHdKM2h5S2JKNURVeFJrY3R4TmF4SWlW?=
 =?utf-8?B?WkJsK1BEblJvajJQemt3OVlmaGd2VUVLZDlvOCtKOFRkTUNyQ1dhOEE5b3RB?=
 =?utf-8?B?dXg1OGFtQ1Zka0dhcDhWN0J5Q3dsY2poWEsrZEFTOXd5SUNVVSt0ODQ1L2lE?=
 =?utf-8?B?dzhYNUx2R0YxTGFzaEtqMDBGYXpDWEZ6Qnh0L2pwc2FaeXloWXlpUUtPeWY1?=
 =?utf-8?B?dnorMXRTdi91elFkYjNaZFRpY1pNbXo2S3VWRjl6WWF3eHRQNkE1Tm95K0kr?=
 =?utf-8?B?ZDNvcnFsM3pxWlpDZkpXREptMTBJYjlma2JGNldHSGJDeHU0VE5LZzRHcURL?=
 =?utf-8?B?d3A4MnZxcS9Nc1JHRWlhVlR5M0FyWk42WGNJR1lvZWR4dC9sS0w0eHRyeFNZ?=
 =?utf-8?B?UHV6REFpQ1QwMGpnVGt5K0ZDQTdIUTFCb1dacm1wdFpFTVNTQVdYcHVaZEw3?=
 =?utf-8?B?WE1Gc3FaeE8yWmhta1YyQTZHOXpwZWxiK1M0R3NMaDJPdnBiQXpZVWNrL2VU?=
 =?utf-8?B?aCt6ZkFGMkNaTDVvVjJaVXNJckdHZTNRUW1CYXpIUWxLS2dPVFBtNisyTmpB?=
 =?utf-8?B?MjZkNmgrTkhYSWFFWVhVOGhyejc4d1VyMzJMTEVySHRlQUpuZGR4QnBjS0pv?=
 =?utf-8?B?S3VlcW5oR2RjdytBZ2UvclBEdXFQTm9CWU4yNEswdkhKWWZkSzY5TmZjNVFy?=
 =?utf-8?B?WkE1bVA3ejJLa0JqbHYrdWF0ZHh4S0psNlBqQVk0NlNoZGoxNnYwOThXYUpw?=
 =?utf-8?B?WUJyeUNDS2R1emt1Tjg5azZKNXNxaWJNdlZzTms0RjVhWDh6QWIrQ080MDF1?=
 =?utf-8?B?aytaVGdaTmNiZnZFZHY1VitjN3FvL2Z5eHpTS0xKZEFOcmhTYjh0Q0VURVRi?=
 =?utf-8?B?cWk1Ry9naUdJRlVpVDIxblhzSUFNM2gzUU9sRGIzZUd1VitkaGJYVFpWTzAz?=
 =?utf-8?B?aFZNbmpxRnAwekYzOHZiMFNiR1FFUTJEM2ZmQWV3Y3RybHBsZldybTdxTTZH?=
 =?utf-8?B?RDFsclZ2Rmp0QXZBUHFpNm1LMjhoa012ZmtTNmU5M1pMc3pyK3RNM2hiQm5p?=
 =?utf-8?B?cU1EU0dhek9oS3UzbXh5Yjl0b3lKdmhTS1BZekdsVS95NDJKRHhJVWRrVmNX?=
 =?utf-8?B?ZHZqUGxrOGN1M1BkQnB2aElXdGdTVjRVS2xvNWFTblNEN2h6ZVJhYW9neVFF?=
 =?utf-8?B?S3N5WlJ0TE5NOXVwSEhlWWFKZVBXWFcvcjU5S1pBSmpzc1VpcWVkWERCaUlj?=
 =?utf-8?B?MEVBRXdCYXBJRVQrN2drL1FXQm50ZzRIRk4zblpyUStTWitmeEo0cEx2SmZm?=
 =?utf-8?B?bUtsWGRlbFlMaEpLcFlxVll5Y0lpamcxblpUdzkzd1I4WklCZlg1c3lGUm5V?=
 =?utf-8?B?clQ5Sy83bHEyVzRYbjlvQ2ZQdUZ1V1dUVHB3bmVOcXdtV1VwS1N6dlNITW5Y?=
 =?utf-8?B?U3RJUStrUTRMR1J0TitZaTVnR2M3cXB2MHo5bXVmL0RGNzhxeWJONWJyMng4?=
 =?utf-8?B?aEVVY3k0eGVZejZVN3QwYXhwUTYvRGxEYXlzbnp2Z0NXM1hTdHZGTmZpTWVw?=
 =?utf-8?B?Vm5yYTlZbVFqWXRZY2tnTndVR3l3empvbjVUeG93d2ZuYUdLZUx3YlhieTg1?=
 =?utf-8?B?anNRdmFjMHM4UTJzdU12SnBpT2UzUXhLVWNQMUdxYkw3RWR4bE5mNlNmU1dF?=
 =?utf-8?B?L20yOGlZTm5RWkg3R3l5N28xMVpBSzJ3Y3UwL1VNS04yOExOK3Y0N1hSTUxx?=
 =?utf-8?Q?CSMR/S+ocjAOmc2/NuD6sL3ssyXERKpR3W4uKCsfB5Qj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3343d5cb-6873-4fee-252e-08dcea0f90d1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:12:55.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVfNfDQXFm523fs8OEaOSGxDG4Qf5sOWyb+sJA1YZ1nQGEWBM/gknB9MYmJ7pggztIGpd23X04zlOmajQcMRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2782

On Fri, 11 Oct 2024 08:23:18 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Fri, Oct 11, 2024 at 5:13=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > On Fri, 11 Oct 2024 10:13:34 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > =20
> > > +#ifndef CONFIG_JUMP_LABEL
> > > +int rust_helper_static_key_count(struct static_key *key)
> > > +{
> > > +     return static_key_count(key);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_static_key_count); =20
> >
> > ^ Explicit export should be removed. This only works because we didn't
> > remove export.h from all helpers.c yet, but there's a patch to do
> > that and this will stop working. =20
>=20
> What's the benefit of removing explicit exports from the Rust helper C
> code? It requires special casing things like modversions for these
> files, so I assume there's a reason for this. I asked about it here,
> but never got a response:
>=20
> https://lore.kernel.org/rust-for-linux/CABCJKudqAEvLcdqTqyfE2+iW+jeqBpnTG=
gYJvrZ0by6hGdfevQ@mail.gmail.com/
>=20
> Sami

Ah, I didn't saw that email, probably because I archived the mails after
the patch is applied.

We're working towards having an option that enables inlining these
helpers into Rust; when that option is enabled, the helpers must not be
exported. See
https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garygu=
o.net/
and https://lwn.net/Articles/993163/.

It's also quite tedious for every helper to carry this export.

Best,
Gary

