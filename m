Return-Path: <linux-arch+bounces-5997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB694829E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED74C283616
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E75B166F3B;
	Mon,  5 Aug 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jBLpaITa"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2075.outbound.protection.outlook.com [40.92.42.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C1149009;
	Mon,  5 Aug 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887502; cv=fail; b=R9b1S4MNqlc9ktHOvFnIl60hiPD7D+GHJKsr+Kp8cDgESpm4NIKH6Ibc+YS/ORObJMjP1ZiXDnbAOiydEGrNzchKqhVCc3f6So72GDsb24Hc/pfI2s2MEVebG0COHJ7of9Lq8GB4iP0F9Cl2dsnCUdMTNxMNH+GliDxD2lNfanQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887502; c=relaxed/simple;
	bh=s2AgqCGNUz7CRqyy1AQuCnDSoRslDkcaJTwhncGW3C8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8+GEHnJ369dQ7Eg6xfGX8f5A34Qo7CHKlKy03YObiAMcMyz1MdE1RT91pGeE6w4tPiHwyIHExYoh4aEoHypwn/Fy/qT3ij7LZupoPhpi4US2eBWXGl0y3npG3ax1IOhgM6RRZWuGVYP4RP5+aI2m3xHVPEP898IKvSmvanStkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jBLpaITa; arc=fail smtp.client-ip=40.92.42.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNC5Ae+tgCYPFtT7D1sXYk6q9Xin6AKPR3cjul4i2NWgcWxUaSATiXCsuYZ2qL9gkvLrZJVhIGb9RDbZB3mW9/zexZqHi6D0390l3SQlgqd/hzJbIEKHW7QRwEiCUMMrhLPEGj6Cb2LTC84kwxkGQjc0oxkAfcek8hhi/0pmCEYpjxKVbSSyF7T48GIGXdxJWq2n+gIh+vyQSmsNDvrCVPNLvVEQS3LHrouDTpovFKlxOLu5EBlfohlxmW3uguVGSdrZNFBReCLf8e85K2hSVcB9fnQODU0I9YNNBOQvByazvUWFhVsYG2i7b0JgiHn3iM0oLkGiM2gLGs5FeHCG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2AgqCGNUz7CRqyy1AQuCnDSoRslDkcaJTwhncGW3C8=;
 b=YDdT8c8BseQpRVAx/NsfVmXbPENiMmBGhYnf9DZ2S6H819SwCp70NVnyuAS3PrJvubI/hZUMdzSzWrPcln2PS7Zx/9dZMHv1PqbQOeoc1yMfUw/wBJIbtG5hJa+sWYQQlmbv61bPbjvFndZ1U1LXAVW8DBOCgdaV4Swrxfolt3UgQWuIC3XhQg+jTCk4g8FLPdRKgRJvIUJn49Ueeo4VdkkDmm8uedQsIDXndUyxvaTPWSQ3ZsKku9EF4gDh+F8pluwLQAJMJLGpfnijbRBNqVPPoP2mRrgboESEJpySTpXRxouUYKhLYGP0SFgQOTmbDvtV3IOFlTn9xpe70nMBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2AgqCGNUz7CRqyy1AQuCnDSoRslDkcaJTwhncGW3C8=;
 b=jBLpaITadyUUMPNaXk+KBhggJryAWVHpLCgeTbrE52sFojETOHsUP3prADOHHDdXQO0ra/RUwK3KFTnRNpCznOEWQq0J0ai3OJPbdDpmznn6eVyPM8gg32LfrtdsId+TizvUs4pXOk56trSoo0igFq8SahVO5H5G73oeb4ca7rsF4MI3Kwk0Cv2NJ/RPrgHueQIjyFLycbsFqI7PIU51I29y1znx2mh29hlkBDuL9kceEKLr/dnFzQhNigSNGcdQkDQhc0OOYZeOWa8dySj+p0caF8QmefGGE7pNpQEO5g/IzyBCHJbFayO03XjY7okuQLhTNSU/ToJEw3zH6DTJpg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7342.namprd02.prod.outlook.com (2603:10b6:a03:299::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 19:51:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 19:51:36 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Thread-Topic: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Thread-Index: AQHa36+bZ2NhttEXkUO+7UvkTiCvrrIXTMEQgADNK4CAAL28AIAARRWA
Date: Mon, 5 Aug 2024 19:51:36 +0000
Message-ID:
 <SN6PR02MB4157B22BD56677EFBD215D87D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-3-romank@linux.microsoft.com>
 <SN6PR02MB4157824AC8ECA000559F5160D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240805040503.GA14919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ebac7069-0396-4b33-88b8-60d5e2594c88@linux.microsoft.com>
In-Reply-To: <ebac7069-0396-4b33-88b8-60d5e2594c88@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [6S/n89hKJ4uuI404IFqFj57N4CccAk4b]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7342:EE_
x-ms-office365-filtering-correlation-id: 194d57b1-2c70-4fe7-d9eb-08dcb58803f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 3C1bGlfu6BEnOezBAOJi/d3174tB4O6WKWDLkpovHcuXV7CZKzGx5k/We+DFSZhicT8X4sRRwEgVpWOjqmPqlECaMw9V6oivBTN+22B035wm7KvWB9uCc7z/naKcAe4xNsmMn78blIoXVnPOMD1ETKeIdTfPw376jaCOeR7bLe1Rev8YYN2cj85xJXjMNWxW8fElY5kFtqJEEQ2Wj+ed7gyE6g00W939SSeGmYWS30UcOOQzWR1yOn0JurrtyrYajFnHEHeOGv9N64jW8PuFzuZR7R9jRocl2eR5jsLtPp1p5hS0gzYY2jQ1CZ1Kd09QpJGZNAxpCL0uOVdw/4yFZtvoHVmbGuHMCCK7hDvDBxUk01UP6aO/MO1jLVHKL0ra/GFGnDEUl/SqB06XuavmYAPF0wTkFVATtQCyOF4YHKntSTPrkuyDGYnOZunBUSwofysXWBO7RCsCnh+ReVF8klVDRn0M8uyt58a4IOciLpFG+oXvqDz013yUv/1uKuxz8m2GcpA0lC5TC5caaOgaemhYOWOoZrUoUAHz+ad6hflvUBuHbE3bnKq8Q+s6hZW4visuRhotSYZana9x9Uh7AUHLac8eYUMMfXAvXdKckcFFQy3SzmaTPtdYQuwvw2eqVjGktb5bgPwGp7/3XwUVCw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R09EcWpiU3pkdEh4MWhQY0xHQkNGOW1RS3JuMUVjM28vRGRyRUtldUU5WGZq?=
 =?utf-8?B?WnJLZktETm9zbHJoaXNGMjJ0WGd5YTRzYjVSNSsyZUhGZm5FYjlSNEkvWVNo?=
 =?utf-8?B?MmJkcUZCMldHY0tjeXFpS0FvYzRySnp4VVBoWVNaRktFcmxtOTFTNk5uWi8w?=
 =?utf-8?B?eGNFQWg0bE40RHB0Q0RzcmIvR0s1T3pHdW9zcWdwdTd6THViQWd2aHpXOFhP?=
 =?utf-8?B?T2JtZmZIMTN4T1ExQi9EMEFKTVVML3Vud3ZVejZmM0hOWHd1WENYSVdqdUxO?=
 =?utf-8?B?U0dnTk5hT1pBSlVKSUxRaUx4dHNONHhUWHBEMFdIa3BiQkxCTUw2OWd6WG9t?=
 =?utf-8?B?L3JYM0E5NlIrajRZRTZ6cHpudktjczhkRmFCOExVWFBaSDQydTRoQThHSFpJ?=
 =?utf-8?B?L0tiUHdRcnBvZ201QnIrc2E5dC9MeUtSSGNwL2pRb3BoaUhnL3VXZUp2QU5r?=
 =?utf-8?B?ZlFWTURmcWFuTU1qakg5Ym1KbnJOZWhwY2FqUFcyOWVUbzBhMEN2UVFNMy9V?=
 =?utf-8?B?R0xwNnlxWjR3cDU2dHdmb0RWcm5QZjkwTCtiN1pHeEROMm9taGJUYys0ejJt?=
 =?utf-8?B?VlpvellKSUlVbzg3SmsvdTl4NUt2MUxCTklrSStLMnRKQVRNbEdHVkM4YVZZ?=
 =?utf-8?B?ZWxWcWdML0QxSTJIVHByNjdFdmZBTG1WRU02TUVtbVc0Ri9ha1JCbTdGNTVV?=
 =?utf-8?B?TU9mTHZyUmRia3JtODlKL3BxNURwTUFRMWlYeWdVR0ZTUkJxcGUrbmtjQnlT?=
 =?utf-8?B?TGFPRXhoWWMyUVp1MHQwMnp3anQwR0tjUzd6QTFudUcyNis1aFZteGlsZTJa?=
 =?utf-8?B?NVFvdm12d3lyWE9DcXMzcFBwSmpBSUpLZWNMTmkvYjNLUjZCbW9LSmNRc2VH?=
 =?utf-8?B?YlYyUXhRcGZXaXdrdUVDNG0xaTdCMDFYaUlxZGdjVW04OEQrVHB2MTVwRUtr?=
 =?utf-8?B?K05WeG0yQUkxSzYyQ094YVpTMnN2YkFDcjkxVHFQK3pUWFJUS1QvQUhXMURa?=
 =?utf-8?B?TUttcjc3a3NlVTByRmFSVkN2TldxSkZ1bFVUelp0K3YrUzZQYUQwQjVITGkw?=
 =?utf-8?B?OWgzRUprVFltTkJhYmtGcFEyRW5RK2MzRTVlRVR4OWFyY0ozcTJ4aUJCNzBr?=
 =?utf-8?B?N0VhNTl2NnVXaHFXNmt5Q29xYUZkeFlGeHdNc01tUGNqaW1YenNnMmJ2UGRz?=
 =?utf-8?B?N2Y5R1VYcllrOUJZb0pKYWxNbjljWTZrZmtVNnhTUGttV0lkczhYU0pzVi9W?=
 =?utf-8?B?SDFTRkpaZ0RsZjZKU3dKR3YvTFp6Z3Rhc0JpOVpLaVFIdThsb0pyQk9lbnkw?=
 =?utf-8?B?MnY0V3dJeWhPSGRYTWx5aTlNcExjdXFDMnFEa21nYzAvUUtBS3dVQlY0TE1Q?=
 =?utf-8?B?WENkYk84YzhBaG82MFRhSDk0R1NZSmpxS0VpZ0xNMUhsaTkxRXRqN1pVQlY5?=
 =?utf-8?B?ZUgzMnBWaTNtUG5TM0tBNGw2SWo1U0VlQ01sSmxYdGw0bjJ0Z0Vtd3p1Unpr?=
 =?utf-8?B?TnpqSjVkaXRpY3AxbmFrWVdBZHZTVnlRYTFjNThuZ1J4SkdBcmRUMFZoUUVl?=
 =?utf-8?B?QnJEU0pxUTRDTFRyQ2NnU2FMRG9RUFFoc1BZWmMwM2NhVWs2N0ZBU2N3TmxM?=
 =?utf-8?Q?4608w3SxW4V5H1BP3rZsG1G8t0M//VTjy12QTCeip+wM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d57b1-2c70-4fe7-d9eb-08dcb58803f0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 19:51:36.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7342

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCA1LCAyMDI0IDg6MjQgQU0NCj4gDQo+IE9uIDgvNC8yMDI0IDk6MDUgUE0sIFNh
dXJhYmggU2luZ2ggU2VuZ2FyIHdyb3RlOg0KPiA+IE9uIE1vbiwgQXVnIDA1LCAyMDI0IGF0IDAz
OjAxOjU4QU0gKzAwMDAsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+PiBGcm9tOiBSb21hbiBL
aXNlbCA8cm9tYW5rQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IEZyaWRheSwgSnVseSAyNiwg
MjAyNCAzOjU5DQo+IFBNDQo+ID4+Pg0KPiA+Pj4gS2NvbmZpZyBkZXBlbmRlbmNpZXMgZm9yIGFy
bTY0IGd1ZXN0cyBvbiBIeXBlci1WIHJlcXVpcmUgdGhhdCBiZSBBQ1BJIGVuYWJsZWQsDQo+ID4+
PiBhbmQgbGltaXQgVlRMIG1vZGUgdG8geDg2L3g2NC4gVG8gZW5hYmxlIFZUTCBtb2RlIG9uIGFy
bTY0IGFzIHdlbGwsIHVwZGF0ZSB0aGUNCj4gPj4+IGRlcGVuZGVuY2llcy4gU2luY2UgVlRMIG1v
ZGUgcmVxdWlyZXMgRGV2aWNlVHJlZSBpbnN0ZWFkIG9mIEFDUEksIGRvbid0IHJlcXVpcmUNCj4g
Pj4+IGFybTY0IGd1ZXN0cyBvbiBIeXBlci1WIHRvIGhhdmUgQUNQSS4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBSb21hbiBLaXNlbCA8cm9tYW5rQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+
ID4+PiAtLS0NCj4gPj4+ICAgZHJpdmVycy9odi9LY29uZmlnIHwgNiArKystLS0NCj4gPj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4+DQo+
ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9LY29uZmlnIGIvZHJpdmVycy9odi9LY29uZmln
DQo+ID4+PiBpbmRleCA4NjJjNDdiMTkxYWYuLmE1Y2QxMzY1ZTI0OCAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvaHYvS2NvbmZpZw0KPiA+Pj4gKysrIGIvZHJpdmVycy9odi9LY29uZmlnDQo+
ID4+PiBAQCAtNSw3ICs1LDcgQEAgbWVudSAiTWljcm9zb2Z0IEh5cGVyLVYgZ3Vlc3Qgc3VwcG9y
dCINCj4gPj4+ICAgY29uZmlnIEhZUEVSVg0KPiA+Pj4gICAJdHJpc3RhdGUgIk1pY3Jvc29mdCBI
eXBlci1WIGNsaWVudCBkcml2ZXJzIg0KPiA+Pj4gICAJZGVwZW5kcyBvbiAoWDg2ICYmIFg4Nl9M
T0NBTF9BUElDICYmIEhZUEVSVklTT1JfR1VFU1QpIFwNCj4gPj4+IC0JCXx8IChBQ1BJICYmIEFS
TTY0ICYmICFDUFVfQklHX0VORElBTikNCj4gPj4+ICsJCXx8IChBUk02NCAmJiAhQ1BVX0JJR19F
TkRJQU4pDQo+ID4+PiAgIAlzZWxlY3QgUEFSQVZJUlQNCj4gPj4+ICAgCXNlbGVjdCBYODZfSFZf
Q0FMTEJBQ0tfVkVDVE9SIGlmIFg4Ng0KPiA+Pj4gICAJc2VsZWN0IE9GX0VBUkxZX0ZMQVRUUkVF
IGlmIE9GDQo+ID4+PiBAQCAtMTUsNyArMTUsNyBAQCBjb25maWcgSFlQRVJWDQo+ID4+Pg0KPiA+
Pj4gICBjb25maWcgSFlQRVJWX1ZUTF9NT0RFDQo+ID4+PiAgIAlib29sICJFbmFibGUgTGludXgg
dG8gYm9vdCBpbiBWVEwgY29udGV4dCINCj4gPj4+IC0JZGVwZW5kcyBvbiBYODZfNjQgJiYgSFlQ
RVJWDQo+ID4+PiArCWRlcGVuZHMgb24gSFlQRVJWDQo+ID4+PiAgIAlkZXBlbmRzIG9uIFNNUA0K
PiA+Pj4gICAJZGVmYXVsdCBuDQo+ID4+PiAgIAloZWxwDQo+ID4+PiBAQCAtMzEsNyArMzEsNyBA
QCBjb25maWcgSFlQRVJWX1ZUTF9NT0RFDQo+ID4+Pg0KPiA+Pj4gICAJICBTZWxlY3QgdGhpcyBv
cHRpb24gdG8gYnVpbGQgYSBMaW51eCBrZXJuZWwgdG8gcnVuIGF0IGEgVlRMIG90aGVyIHRoYW4N
Cj4gPj4+ICAgCSAgdGhlIG5vcm1hbCBWVEwwLCB3aGljaCBjdXJyZW50bHkgaXMgb25seSBWVEwy
LiAgVGhpcyBvcHRpb24NCj4gPj4+IC0JICBpbml0aWFsaXplcyB0aGUgeDg2IHBsYXRmb3JtIGZv
ciBWVEwyLCBhbmQgYWRkcyB0aGUgYWJpbGl0eSB0byBib290DQo+ID4+PiArCSAgaW5pdGlhbGl6
ZXMgdGhlIGtlcm5lbCB0byBydW4gaW4gVlRMMiwgYW5kIGFkZHMgdGhlIGFiaWxpdHkgdG8gYm9v
dA0KPiA+Pj4gICAJICBzZWNvbmRhcnkgQ1BVcyBkaXJlY3RseSBpbnRvIDY0LWJpdCBjb250ZXh0
IGFzIHJlcXVpcmVkIGZvciBWVExzIG90aGVyDQo+ID4+PiAgIAkgIHRoYW4gMC4gIEEga2VybmVs
IGJ1aWx0IHdpdGggdGhpcyBvcHRpb24gbXVzdCBydW4gYXQgVlRMMiwgYW5kIHdpbGwNCj4gPj4+
ICAgCSAgbm90IHJ1biBhcyBhIG5vcm1hbCBndWVzdC4NCj4gPj4+IC0tDQo+ID4+PiAyLjM0LjEN
Cj4gPj4+DQo+ID4+DQo+ID4+IEluIHYyIG9mIHRoaXMgcGF0Y2gsIEkgc3VnZ2VzdGVkIFsxXSBt
YWtpbmcgYSBjb3VwbGUgYWRkaXRpb25hbCBtaW5vciBjaGFuZ2VzDQo+ID4+IHNvIHRoYXQga2Vy
bmVscyBidWlsdCAqd2l0aG91dCogSFlQRVJfVlRMX01PREUgd291bGQgc3RpbGwgcmVxdWlyZQ0K
PiA+PiBBQ1BJLiAgRGlkIHRoYXQgc3VnZ2VzdGlvbiBub3Qgd29yayBvdXQ/ICBJZiB0aGF0J3Mg
dGhlIGNhc2UsIEknbSBjdXJpb3VzDQo+ID4+IGFib3V0IHdoYXQgZ29lcyB3cm9uZy4NCj4gPg0K
PiA+IEhpIE1pY2hhZWwvUm9tYW4sDQo+ID4gSSB3YXMgY29uc2lkZXJpbmcgbWFraW5nIEhZUEVS
Vl9WVExfTU9ERSBkZXBlbmQgb24gQ09ORklHX09GLiBUaGF0IHNob3VsZA0KPiBhZGRyZXNzDQo+
ID4gYWJvdmUgY29uY2VybiBhcyB3ZWxsLiBEbyB5b3Ugc2VlIGFueSBwb3RlbnRpYWwgaXNzdWUg
d2l0aCBpdC4NCj4gPg0KPiBNaWNoYWVsLA0KPiANCj4gSSByYW4gaW50byBhIHByZXR0eSBnbmFy
bHkgcmVjdXJzaXZlIGRlcGVuZGVuY2llcyB3aGljaCBpbiBhbGwgZmFpcm5lc3MNCj4gbWlnaHQg
c3RlbSBmcm9tIG5vdCBiZWluZyBmbHVlbnQgZW5vdWdoIGluIHRoZSBLY29uZmlnIGxhbmd1YWdl
LiBBbnkNCj4gaGVscCBvZiBob3cgdG8gYXBwcm9hY2ggaW1wbGVtZW50aW5nIHlvdXIgaWRlYSB3
b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkIQ0KPiANCg0KVGhpcyBpcyB3aGF0IEkgaGFkIGlu
IG1pbmQ6DQoNCi0tLSBhL2RyaXZlcnMvaHYvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9odi9LY29u
ZmlnDQpAQCAtNSw3ICs1LDggQEAgbWVudSAiTWljcm9zb2Z0IEh5cGVyLVYgZ3Vlc3Qgc3VwcG9y
dCINCiBjb25maWcgSFlQRVJWDQogICAgICAgIHRyaXN0YXRlICJNaWNyb3NvZnQgSHlwZXItViBj
bGllbnQgZHJpdmVycyINCiAgICAgICAgZGVwZW5kcyBvbiAoWDg2ICYmIFg4Nl9MT0NBTF9BUElD
ICYmIEhZUEVSVklTT1JfR1VFU1QpIFwNCi0gICAgICAgICAgICAgICB8fCAoQUNQSSAmJiBBUk02
NCAmJiAhQ1BVX0JJR19FTkRJQU4pDQorICAgICAgICAgICAgICAgfHwgKEFSTTY0ICYmICFDUFVf
QklHX0VORElBTikNCisgICAgICAgZGVwZW5kcyBvbiAoQUNQSSB8fCBIWVBFUlZfVlRMX01PREUp
DQogICAgICAgIHNlbGVjdCBQQVJBVklSVA0KICAgICAgICBzZWxlY3QgWDg2X0hWX0NBTExCQUNL
X1ZFQ1RPUiBpZiBYODYNCiAgICAgICAgc2VsZWN0IE9GX0VBUkxZX0ZMQVRUUkVFIGlmIE9GDQpA
QCAtMTUsNyArMTYsNyBAQCBjb25maWcgSFlQRVJWDQoNCiBjb25maWcgSFlQRVJWX1ZUTF9NT0RF
DQogICAgICAgIGJvb2wgIkVuYWJsZSBMaW51eCB0byBib290IGluIFZUTCBjb250ZXh0Ig0KLSAg
ICAgICBkZXBlbmRzIG9uIFg4Nl82NCAmJiBIWVBFUlYNCisgICAgICAgZGVwZW5kcyBvbiBYODZf
NjQNCiAgICAgICAgZGVwZW5kcyBvbiBTTVANCiAgICAgICAgZGVmYXVsdCBuDQogICAgICAgIGhl
bHANCg0KSFlQRVJWX1ZUTF9NT0RFIGNhbiBub3cgYmUgc2VsZWN0ZWQgaW5kZXBlbmRlbnRseSBv
ZiBIWVBFUlYuDQpUaGUgZXhpc3RpbmcgY29kZSBzaG91bGQgYmUgc3VjaCB0aGF0IGV2ZW4gaWYg
c29tZW9uZSBpcyBidWlsZGluZyBhDQpyYW5kb20gY29uZmlnIGFuZCBnZXRzIEhZUEVSVl9WVExf
TU9ERSB3aXRob3V0IEhZUEVSViwgdGhlDQprZXJuZWwgd2lsbCBidWlsZCBhbmQgcnVuIGluIGEg
bm9uLUh5cGVyLVYgZW52aXJvbm1lbnQgYW5kIGlzbid0DQpicm9rZW4gc29tZWhvdy4NCg0KRm9y
IEhZUEVSViB0byBiZSBzZWxlY3RlZCwgZWl0aGVyIEFDUEkgbXVzdCBhbHJlYWR5IGJlIHNlbGVj
dGVkLCBvcg0KSFlQRVJWX1ZUTF9NT0RFIG11c3QgYWxyZWFkeSBiZSBzZWxlY3RlZC4gU28gIm5v
cm1hbCIga2VybmVscyBhcmUNCnN0aWxsIGVuZm9yY2VkIHRvIHJlcXVpcmUgQUNQSS4gQnV0IGlm
IGJ1aWxkaW5nIHdpdGggSFlQRVJWX1ZUTF9NT0RFLA0KdGhlbiBBQ1BJIGlzIG9wdGlvbmFsLg0K
DQpTYXVyYWJoJ3MgaWRlYSBvZiBhZGRpbmcgImRlcGVuZHMgb24gT0YiIHRvIEhZUEVSVl9WVExf
TU9ERQ0Kc2hvdWxkIGFsc28gd29yayB3aXRoIHRoZXNlIGNoYW5nZXMuDQoNCkkgaGF2ZW4ndCBm
dWxseSB0ZXN0ZWQgdGhlIGFib3ZlIHdpdGggYWxsIHRoZSByZWxldmFudCBjb21iaW5hdGlvbnMN
Cm9uIGJvdGggeDg2IGFuZCBhcm02NCwgYnV0IEkgdGhpbmsgdGhlIGxvZ2ljIG1ha2VzIHNlbnNl
Lg0KDQpNaWNoYWVsDQo=

