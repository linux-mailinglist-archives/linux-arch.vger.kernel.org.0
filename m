Return-Path: <linux-arch+bounces-3613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274828A2630
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 08:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BAB283816
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9301DDDB;
	Fri, 12 Apr 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="YrwtIkIx"
X-Original-To: linux-arch@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022019.outbound.protection.outlook.com [52.101.167.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD83F9CC;
	Fri, 12 Apr 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902044; cv=fail; b=HeXeoldBnw9rcmp8q8S+qeVadKvqBqLBifWZS8UmG4+1OTwR3luaNDUp6NgyYPWed12FU64toeKF2RwA6KDQl4VNhkyCgEBsIrxdL/8Mq7JQljmQuUa/EJq9MY6LTdfRqIyMtHaXx6VMFUvPRluZCrXUCuo+WJbllbf49IBMj7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902044; c=relaxed/simple;
	bh=VCtLZZmUM4apZPEn/X9Sc5KLnL2dyWx2scMhnNFp8jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qt/jz4lnIGDW1naJeTi6UQzvE1F8nnj6/O5qid8wvVb8LX4tU2wA1IMvwHPFD+RwdLxUnchbkVIj4MytjjgZfqQf9rD0EkJyjKmoMz+HkNwCt2C0kfhv2eU3VW7mDaqe183K6E09GfNcgKgPv8QQBGc8OnJRAInJZbcJxC6+siI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=YrwtIkIx; arc=fail smtp.client-ip=52.101.167.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7k412+CwiWXy21ulu6VQy0QzlRA1+LEnVfC9bb8GDF+ia/icwsRnbgv0SW/ZQMAImDQql9t0/z4NNS7y0XDGonNnTi/FgRqgRRJDZOay+weyjQ2KIKMljcXaBPPUABrhcDAOQBIB1eCBGnnoA3PTBRFdXRU5/3t+yZHfaI+XyY00tfqZd01J1fQzQiDZrXEDl30oeyTjuOyfDXft/+1+auTITVGG+bnDyrIrbHYHhIzMrg27atGuWhSBrd6NbczvKCUhV3IxveepU8yXziln3Z2QddjtAX2vsaZe8TSyVrRR9Dj0WsPtygx9jOE+Sk3kYeHr1CRLQKSEdZdo7f6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCtLZZmUM4apZPEn/X9Sc5KLnL2dyWx2scMhnNFp8jg=;
 b=EoPKE/LrZ9p9XqpHM4SVmJ0V+RrBIgB7Tdn0lUcMXmHCIvCmgtI+JhU0RZA6GNcsCX/QskabcpoxlLzbBZYP4E5tmZkGx6pxWRew2gDXg1r1it9X/OL8fjNdZJ9/GHY3xJ0DEYnenJkZOoj0w9LJ91WC3It/T6s9Kbdzcx0K2e9kMdZxf53sgp1QBAuHCJ9n+ae9RsVlYrM+JEgk4dfQFartWffNmJJEtEQIpaQKmT9+C6POLrPTr4XDLuor9wifgj/hfvu6+AiKrJjJCnb8H8jgecFYYnFTlI/tETcjLCQ/zP+QjkjWx+z832/Fb7IkPgwqrL+SVtWHTDuZBOmpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCtLZZmUM4apZPEn/X9Sc5KLnL2dyWx2scMhnNFp8jg=;
 b=YrwtIkIxnLGFjUQ5u70frnHSntwEUiGb6FTsQSd5aJWz85TL/j3Lh3H5yrVLOoWeDfSwAyk8IImbjMI5gtL+yF50cooVScLO2KkrDP7Yy1DlXJWNT73n28SfOos2ejieZXuxBNj82shj1XewMejY82H4uuDqP9/E3h5W7o5j1Np2wyfMTptMFHSKtUf9HHCn/axyySzCFjCRuYsabt5E1MIyFHTfpKElOIDIl953CNXGTS8uABfk4XoSXjB6tm54Ku4Ln4F2awVyrAvpxun8DeCzUnZgHzt7jBu7Hm6hHycKoKFQZGTVYnTptkbsxpNBDrWb+Oh3CiwGKDZ/oytrYw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3626.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 06:07:19 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:07:19 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mike Rapoport <rppt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
	<luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, Helge
 Deller <deller@gmx.de>, Lorenzo Stoakes <lstoakes@gmail.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 2/7] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Thread-Topic: [RFC PATCH 2/7] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Thread-Index: AQHajCouSrFGoyjUSEe9FLrHXKhqTrFkJwQA
Date: Fri, 12 Apr 2024 06:07:19 +0000
Message-ID: <9217c95a-39f6-49ce-9857-ee2eebdb7a16@csgroup.eu>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-3-rppt@kernel.org>
In-Reply-To: <20240411160526.2093408-3-rppt@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3626:EE_
x-ms-office365-filtering-correlation-id: 0074e096-56fa-4d8f-0d49-08dc5ab6cfbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 izsbZpA25isfwXRGocYvvL7cti9peX23dC+0ucoZNh2zg1Dq/PL0LhmMipH8XUZVUyneyJ5uNQqceMG6ROswFFJqfO3u+VFIpxOXE9CWU7S2tL8eKEOVbFUn34EPyPond8xkV6kcYg+e/+3hVo0rNtuhqEqblxspKvwSQ1qNccn/nAnjaCcyqnD0P4yIRk+bIZDe+LKtdowhukpSncm6G0W9zX5pPpL9/Eyd3OktYxngGK9W18g+jcYKEAmj6yf6srPfLuVssSyTGcbTt1akWFhAmJbUVNAgm7JH7BXbw2Mm0kNOff+ulmhFzk4UQYl1QZDqP8YCh7CAbEqcIurEQlnd5mwkxNzf7h94r7gsPGi7VPRWHj4gW5Nundxg0or6w9dcYBEsYitHQntDEV2Z3EbbYyi9GU9iK8vhE4cdGKtYxdW5Vms2zbTX5xOj12Bh7mQpc+R2Y693FeqrGl9v7LbRQOYoTAzLUbo/XGyP8F8YAwoxBOAjhC9ibFwwuHLt+IK4eE8LDPjg4msA4YlvTYOAObhHi08zfv0b683LHUIW4W+pdP4SBC6wpTAhS7AXe5t1POFTcRaHsiMynCsuRXPjX/K6hRcPPIVqvEYuSELLvRgS/zrOfiNnDte1CxrXVqynrpT2YplrHUEz8doDExj0c+Mm9hPSgQhv45DhT3Mv5QMWYMreaZOSz3uX/HWMqK1t08iuQz4flUcIFK/j6pf3wTxL2Zd20R/NQ5D05HI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTYrUE4yTC9taTVLWEtWUGd0MHpqY2pYL3FST09Yb2t4K3QwNHVDZzFzYTNS?=
 =?utf-8?B?WncxK0lnY0x3cWRtS0ZzU2p1eFBXQmFTZDA3YXFvMUpQZE9LRStJZXlxZG51?=
 =?utf-8?B?UFZjR1VFK1RWNlRwUzdZTU5ORFI4ZTcvTGVmVFhLN1hsN2ZMZGExQURhWHph?=
 =?utf-8?B?QklGRUJuVmJUUW51amN0M0RXdnNGdHVsWFlSN2psRnFKSkRnUnZPeWdyRHJp?=
 =?utf-8?B?M1VKdVpKTDEwRmp2Smx0eDlVL3ljNWh5VTdUY2dSUW1BSVE0ejQ0SmVWWndE?=
 =?utf-8?B?RTRDQWxESUFhVWV4R0xWbU8rM1gxc3FCcFlGMkFEQ0pYNjdmN1Y1ZmFJQlJy?=
 =?utf-8?B?UlovY1p5eUZqUTBxdHNuRUQ1emxzQ3Q4UlRQa0JvOTlMTHJZVUI1WlZkKzRK?=
 =?utf-8?B?cXQ4akhrY1YwbEpPQ1VCNHBSMFFpUnFYVGJwL1U3QkFsc0JUc0VsNGhnQ2kz?=
 =?utf-8?B?YTROV1hSUnRGUmQ4NllNVXlyVElpQ3BNSGdtNy8zbk8zWERoSzdEV1ZWdFZw?=
 =?utf-8?B?MWd6WUFzYlZPM1NlNmxGSUxZdWtuVjVOWUNDZzVkc0RxNUg0U1czL2dtL3Zq?=
 =?utf-8?B?TU44ZVJnWlF6d3VtTmtMcXBPSVgzMDJWMEwxMnFEbGhjdndoMmdVWktjeTZu?=
 =?utf-8?B?YmVZNWo2VElqZjRBS0tkbWowLzlqZEFnbjlxamVkckg5K1RUSWlvcURUNVdo?=
 =?utf-8?B?WG5yZVBtWmhpVkpHd20zaXhpTUo0dHJDcU9hZ3Q5S1JXMktFZ2FJMkR1OU9M?=
 =?utf-8?B?Y25LUm5tWHN0OHdsSGlFSEwrOUZNQXNRRDZmNFNvTVBxV0k2L3ZxNmhncEpz?=
 =?utf-8?B?dVRIMWtkb0I3WUczYmRmN01QeGVQOTJGSzRTN0VtM1EyWDV3MEZhNnhicHRW?=
 =?utf-8?B?UFpueHFuOVFrOUhZSENuMlV4M2lIcHBwNzYxT3VsK1FlSU05blhjVmoxc2M3?=
 =?utf-8?B?eW5yaUVZNjdNd1RpSnBpUlVYdkJzaG44Z3pxZERUcEJ3d2ZIbkYrTVlkbUtL?=
 =?utf-8?B?VlhRblMrcC9GeHNxZUluQkJCWjhLVDB0ckE4WmswbllUbFVpMkFRVkZaYTdM?=
 =?utf-8?B?QXJMbzRkTUFFVWVvMWlGS081eVIra2drRFltRDZaeE5LZUNzVGZaa21MN2R6?=
 =?utf-8?B?dGtoSWN5UXJ4S29NMk1pL1V3UmQrU2JZSEFicC9xRDhsTnMwTG9qY3RmWGUv?=
 =?utf-8?B?Tmp6WDFFR3Npbk0wNXByZ2tQMjlsL0RabFkyL3cyenlBNFVrVUIrNk4yTDZD?=
 =?utf-8?B?dU5NTjNHbWNGMkVsNWgwKzh0Ym1PNGpzcjZzeDNGdCtQcWFwb0d2RE5rRjVX?=
 =?utf-8?B?MDc1a052ZGNpQWF3WS9KVHo5Y2xGSkJpVDJZZFhxU0w5UWJVZkJ2Z2gyNHNa?=
 =?utf-8?B?SHBTd2tmS1BjSjlZcU5jN2dEQTJncGpwMllOVS9Gd1ovL05nWGswYW5EMkVp?=
 =?utf-8?B?UllTRi9wanFRMTd6bjZrRDF6Q2VIQUtCZjVGREVvMjRZUTBiaE9WcWlGMUFB?=
 =?utf-8?B?U1NqYmFVZHdCL1ZKcTgycVVwN3FCYjh2MzYwVmF5TFAyY3E5VlNOUmhGSmV4?=
 =?utf-8?B?bXpSbVBTMVZ2bWtDLzJzdkM1eld2TjNzUmUzMDJtbkkxMzZjWWgrQnZQVXJl?=
 =?utf-8?B?TmtMRmhqZTZIbjhoYlhEVncxb0w3emhuZGZneFVZQk13MUJUZkd2LzkwbnZD?=
 =?utf-8?B?aUptdFJ3Uk51bFRTQ3o1UjZadVVpTlRoeEZ3UENPU3VWSGVTNzd2bElWZlRl?=
 =?utf-8?B?WE5RR0NHb2o4N0h2Q2NYTXZBRHQ2YnkxV2IwaTU1T1VhR2RqSW1SRmU1Q01M?=
 =?utf-8?B?T1c5MHU3Ym9xMTQ1TnFwNjdnN0dmQ283SnVIUitva3UzaXBZLy9KUGY5WXdE?=
 =?utf-8?B?Um5YZG5EcGo0aUdJMnZiOVNEaCswTnE1YnZLQ2NkUVFoWHFxUWQwRGN1WTNo?=
 =?utf-8?B?TVdmVVg1c1k1YWJOSC9rOVlaQmRCOUx2RFhZSmVpWkphOGpHb0N6Mnl5c0pJ?=
 =?utf-8?B?dkRxRzhiTzBrQW9PUUFNdVVabkVxOWs5SG84ZE5mcmVwMDNTeU5WTXFqZmNI?=
 =?utf-8?B?SGJlRXFxNHB1S3NCN1d5WmZBTG9UMzcyeHBSMW8zaVlBQU1DNU1Wd3V5bmhX?=
 =?utf-8?B?WDFTSlkvaTFWSUIvSkdydlBuNzBEU3FaMDdFZ25IM1c2ZWpCaG96cDBpMkJv?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89340A390489FE418D98F718ABAD4B26@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0074e096-56fa-4d8f-0d49-08dc5ab6cfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:07:19.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yq5Ymt19cJDsoLY25zKtmPvXU0rgWBmXhHy/D5kncbqWx7FlrTMN9Z1HWfzvLyp+U8CRCTN7eOfrUGLCaBMlx5mbRNwuH7MAlURd9neCIOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3626

DQoNCkxlIDExLzA0LzIwMjQgw6AgMTg6MDUsIE1pa2UgUmFwb3BvcnQgYSDDqWNyaXTCoDoNCj4g
RnJvbTogIk1pa2UgUmFwb3BvcnQgKElCTSkiIDxycHB0QGtlcm5lbC5vcmc+DQo+IA0KPiB2bWFs
bG9jIGFsbG9jYXRpb25zIHdpdGggVk1fQUxMT1dfSFVHRV9WTUFQIHRoYXQgZG8gbm90IGV4cGxp
Y3RseQ0KPiBzcGVjaWZ5IG5vZGUgSUQgd2lsbCB1c2UgaHVnZSBwYWdlcyBvbmx5IGlmIHNpemVf
cGVyX25vZGUgaXMgbGFyZ2VyIHRoYW4NCj4gUE1EX1NJWkUuDQo+IFN0aWxsIHRoZSBhY3R1YWwg
YWxsb2NhdGVkIG1lbW9yeSBpcyBub3QgZGlzdHJpYnV0ZWQgYmV0d2VlbiBub2RlcyBhbmQNCj4g
dGhlcmUgaXMgbm8gYWR2YW50YWdlIGluIHN1Y2ggYXBwcm9hY2guDQo+IE9uIHRoZSBjb250cmFy
eSwgQlBGIGFsbG9jYXRlcyBQTURfU0laRSAqIG51bV9wb3NzaWJsZV9ub2RlcygpIGZvciBlYWNo
DQo+IG5ldyBicGZfcHJvZ19wYWNrLCB3aGlsZSBpdCBjb3VsZCBkbyB3aXRoIFBNRF9TSVpFJ2Vk
IHBhY2tzLg0KPiANCj4gRG9uJ3QgYWNjb3VudCBmb3IgbnVtYmVyIG9mIG5vZGVzIGZvciBWTV9B
TExPV19IVUdFX1ZNQVAgd2l0aA0KPiBOVU1BX05PX05PREUgYW5kIHVzZSBodWdlIHBhZ2VzIHdo
ZW5ldmVyIHRoZSByZXF1ZXN0ZWQgYWxsb2NhdGlvbiBzaXplDQo+IGlzIGxhcmdlciB0aGFuIFBN
RF9TSVpFLg0KDQpQYXRjaCBsb29rcyBvayBidXQgbWVzc2FnZSBpcyBjb25mdXNpbmcuIFdlIGFs
c28gdXNlIGh1Z2UgcGFnZXMgYXQgUFRFIA0Kc2l6ZSwgZm9yIGluc3RhbmNlIDUxMmsgcGFnZXMg
b3IgMTZrIHBhZ2VzIG9uIHBvd2VycGMgOHh4LCB3aGlsZSANClBNRF9TSVpFIGlzIDRNLg0KDQpD
aHJpc3RvcGhlDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJw
cHRAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAgbW0vdm1hbGxvYy5jIHwgOSArKy0tLS0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL3ZtYWxsb2MuYyBiL21tL3ZtYWxsb2MuYw0KPiBpbmRleCAyMmFhNjNm
NGVmNjMuLjVmYzhiNTE0ZTQ1NyAxMDA2NDQNCj4gLS0tIGEvbW0vdm1hbGxvYy5jDQo+ICsrKyBi
L21tL3ZtYWxsb2MuYw0KPiBAQCAtMzczNyw4ICszNzM3LDYgQEAgdm9pZCAqX192bWFsbG9jX25v
ZGVfcmFuZ2UodW5zaWduZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIGFsaWduLA0KPiAgIAl9
DQo+ICAgDQo+ICAgCWlmICh2bWFwX2FsbG93X2h1Z2UgJiYgKHZtX2ZsYWdzICYgVk1fQUxMT1df
SFVHRV9WTUFQKSkgew0KPiAtCQl1bnNpZ25lZCBsb25nIHNpemVfcGVyX25vZGU7DQo+IC0NCj4g
ICAJCS8qDQo+ICAgCQkgKiBUcnkgaHVnZSBwYWdlcy4gT25seSB0cnkgZm9yIFBBR0VfS0VSTkVM
IGFsbG9jYXRpb25zLA0KPiAgIAkJICogb3RoZXJzIGxpa2UgbW9kdWxlcyBkb24ndCB5ZXQgZXhw
ZWN0IGh1Z2UgcGFnZXMgaW4NCj4gQEAgLTM3NDYsMTMgKzM3NDQsMTAgQEAgdm9pZCAqX192bWFs
bG9jX25vZGVfcmFuZ2UodW5zaWduZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIGFsaWduLA0K
PiAgIAkJICogc3VwcG9ydGluZyB0aGVtLg0KPiAgIAkJICovDQo+ICAgDQo+IC0JCXNpemVfcGVy
X25vZGUgPSBzaXplOw0KPiAtCQlpZiAobm9kZSA9PSBOVU1BX05PX05PREUpDQo+IC0JCQlzaXpl
X3Blcl9ub2RlIC89IG51bV9vbmxpbmVfbm9kZXMoKTsNCj4gLQkJaWYgKGFyY2hfdm1hcF9wbWRf
c3VwcG9ydGVkKHByb3QpICYmIHNpemVfcGVyX25vZGUgPj0gUE1EX1NJWkUpDQo+ICsJCWlmIChh
cmNoX3ZtYXBfcG1kX3N1cHBvcnRlZChwcm90KSAmJiBzaXplID49IFBNRF9TSVpFKQ0KPiAgIAkJ
CXNoaWZ0ID0gUE1EX1NISUZUOw0KPiAgIAkJZWxzZQ0KPiAtCQkJc2hpZnQgPSBhcmNoX3ZtYXBf
cHRlX3N1cHBvcnRlZF9zaGlmdChzaXplX3Blcl9ub2RlKTsNCj4gKwkJCXNoaWZ0ID0gYXJjaF92
bWFwX3B0ZV9zdXBwb3J0ZWRfc2hpZnQoc2l6ZSk7DQo+ICAgDQo+ICAgCQlhbGlnbiA9IG1heChy
ZWFsX2FsaWduLCAxVUwgPDwgc2hpZnQpOw0KPiAgIAkJc2l6ZSA9IEFMSUdOKHJlYWxfc2l6ZSwg
MVVMIDw8IHNoaWZ0KTsNCg==

