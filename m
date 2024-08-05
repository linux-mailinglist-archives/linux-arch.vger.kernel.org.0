Return-Path: <linux-arch+bounces-6005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CB948370
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAE1C21CF0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDC1465B8;
	Mon,  5 Aug 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ExmQsR00"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011031.outbound.protection.outlook.com [52.103.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507713E881;
	Mon,  5 Aug 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889825; cv=fail; b=VNTqFdRUzI+sDxhMYgW2CT3le4sFJ3YIgbRHMAAdo+rscqntVMUfe/WTRt8LvwjRTrxLEPQXw+NCGwJbRZ7fBchtUwfJtLSm2JUsRSq8GnW9XTLKuYjMw95TiSiJIhVejhFjPpEL6DnbAM9FcbWPytW1aE6AGbgQMLZe6YtT2M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889825; c=relaxed/simple;
	bh=+nV1ncQMv5mzMfEpFkG4drvuZSC9cpyGIKuMKGC/uZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqFvoTbFb6NXaFJ+tAWyoHwKfHBDRaIiuDpoDFNgze07ComI5eTS1ir9XRgqk+Xb15vMBNDEKC0LGpIumwMzltjiqMz04O7T6yEb1r131ehWT5zwx5XGaC8IZUEGJllkeyRCugYLgW2znTDi7RgBS6Z4b9zA/gi2crETjGCx0SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ExmQsR00; arc=fail smtp.client-ip=52.103.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G89OufI4czB4XOQRgHNL2aBQox9C++FmZ3t/WbDOGT9SzLcqzz1zhwNaI+nQupM7WmL/NZRebtMOC6B5CDPVT3ivGqMHgNGg4ngZqS7OStTBmY84nCKxwaiSe7Dg3kiHSgmfcGzx0C1rBN56R4CoNTxxk5GtPwAxjyRFye34ltF9Ewb2ioM9msZe3s4cLLCzCVJdZ2oF/T3bo5EY0E3kDcqWp7HVCDMXR7rTLrWh+nPOs8IRVeyRDwlLq9Kla7ku15Hc64YRDPXAoipsfZlyCxhkMhkFRu9MDA68ZYuTCM1Eympoe5jh+8d980pgnq6azPZvlvcmXsgpvnFP4pUFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nV1ncQMv5mzMfEpFkG4drvuZSC9cpyGIKuMKGC/uZQ=;
 b=uC8G0Vmb79LuBL5E32g1VNU8BmB3GsXaxAYJy+S5bmn4Jg7Kcrl/CSe2pL0MhdDrzBm6Tf4eHHUHszZfTGrI8ymAN/w8Kn5A5E+TPyH4l/yQ2lb1TsoljON5nCZ1r+yw9ECYFWLilb12CP5xQonFQMmxLmauEyBuH+3PZI0c7UVEo1mAbGBZgqNVE7idibuApJewY84XiPBtLUmKFlab5Ko3M1szlJ9cKJSEV47yREtYQiDgHljDpD4fkxxLU+mOlW7l9VNz5iITCJSr4Il7HUAaBZQH38/ZJMY0jS9OPX/2Yaf59lKor3xE0+LT/2joB0fh+CrSFHwpuaSNWtSR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nV1ncQMv5mzMfEpFkG4drvuZSC9cpyGIKuMKGC/uZQ=;
 b=ExmQsR0042z3jGkk3E83zOhw8VJwlvkkTbbEJw7fjsLC5U6oa9K69Hpz799hoIrrQSLYdSy8o8uB3BfgNqzbDGNfaflZV5lXi6Q11ejOO5rDUw02HU4FmQ187QxZjV5IYJWlcrEdWIEsfkz0O1GwddmG30jYUrt3X9HwRELWYpopVKhfjETlllQn2R5fDTDlxqATz63iGf0tKYAZrUU0lkNrC/XdEkGJVw8b/IbS3kvUT4uUmLhAP0A6RcMeQ28oA/US8KfB22eItdWNS587ayd1ZapRNnk/d88kNNpDvY9cxEf0pf/VWYH+vOfvIucrI0S6dFC2mfk/YAcLfdMQRA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6502.namprd02.prod.outlook.com (2603:10b6:a03:1da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 20:30:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 20:30:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
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
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Thread-Topic: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Thread-Index: AQHa36+WUBGIaT7NY0yUh4aIGbbqLbIXSEtwgAGnh4CAADlSkA==
Date: Mon, 5 Aug 2024 20:30:19 +0000
Message-ID:
 <SN6PR02MB41571669ED254773D05E2721D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
 <SN6PR02MB41573831866B7FC9E267D72DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3398a7cb-b366-49e1-ae19-155490b4e42e@linux.microsoft.com>
In-Reply-To: <3398a7cb-b366-49e1-ae19-155490b4e42e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/+R+V7pRNZ15jBxsen7BOttg4sJPQ1RI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6502:EE_
x-ms-office365-filtering-correlation-id: 1936ce06-b5df-425a-ade3-08dcb58d6c3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8060799006|102099032|4302099013|3412199025|440099028|56899033|1602099012;
x-microsoft-antispam-message-info:
 au5oqM2tqr4y09xNaCX7SXFY6VwW/Yjl/co+W79KXJ7/0AVrAsohg2K6tR8bU6tngYc8NmKpEYS4kjaWOIMqR6wFUldx0ippN4r5SW6nO6vY8Q+0FEOkxfZUVbXPWi/Qbn/DAyOOx4RTldKqbFnme4KnBql/N78HJp9BfEJKqxg0YYLDTQ7VTe4wuNqtzEM8TUqAX1Yrh8hp5ncUI19HMrAQUPLvQY9lOtyGcRZXxKoiNDoKwjPHyaY/kfEaCNeoavjFsSAhB7wP5WpFwaq8zLQq5IXtgH16PBMLKkssRy+wSuKk9N8tx1p3H54uxgjj9b/DD/9duK50n4GlLE5xxYXS80aYWTXdnFCklyWbJo//1AwlLBRrJSToWyE4dAZ619H3UalV3GvsRFZkDgDl+jysbTNPS+KDPVqLsZVqoPwZAfMSyaz8i9eRzM8UmhII71HUH8dUHbRN4TmHs0ggisAR7M5M4rgMgdDimjz+f/VCBs4ciIzUxKqdHfYECztyUOIHhwnkloPlV7fOmXGdD1SNv0uu+4JvRFy5Ch6duOqugr4aWRt6ckmE5TgRfdDs+XUQvzm/p4UiUVxDWKNwVoYTH0/6l+o2I1RKCoezslSQlyjZQRZZMijDMVwfN5vnfQY3DX3JGE0sjAvUjthO1TT80Z3k0m5Pl1TCIQ8mi6QUddVJ2hqr/CIiIu8EEryIJGRBKodH9VSVY4CQIRGkKWLf0FxKART60lbcT/0KndPX0gvG5AySy1cwvq//4yp2
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzI0Rkp5NnduUEVIdzIzamFHWmlKVDlDQUpSK0JYOFI3VW5rWVJVRlZZQUtm?=
 =?utf-8?B?akwwM09WcTB2WndMUnBEMGlqVWtDdG1NdkIyYndhSUo4TWQ5VkV2TlhaZE9t?=
 =?utf-8?B?bmVrNE1nbWEyeG9za3I2UXB3L29JOVB3MjY5aXVWNWZEaDZrN1FEcndxdjVT?=
 =?utf-8?B?TDQzWmYzbG40V056OVcrdTJadTYwSmRQMWpyVHdrOStNM0Flcm45WEswZmhO?=
 =?utf-8?B?a3dJVFUyMkVLN3JTNjBRbzBQcC9VUGVzS3VuVEQvL3ZCT1kvbzlrcERtUWRC?=
 =?utf-8?B?emdCU0hHR2FxMWxhZUtYSFhwaUM0cGx0WTRXVmU1OTV5aSsyNDAvV0w2TElr?=
 =?utf-8?B?RnRqQ2QzZGhvSWFabms2cVpMWDBuM3VjU21lSzZML0VCWEo5cGZ6akRub2t3?=
 =?utf-8?B?b08xaFM4bkxxTVAvQ1pIMjQ5YWQ1U2hKbjd6bmY4em5EbE9aSnRVODVyenB0?=
 =?utf-8?B?b1Y0UFkxazZ3bzRtNDVZa1N5Rm0yb2Jya1ZKcGdSRFN0OXBZWENSVHpFcURB?=
 =?utf-8?B?Y3BFNTRUMlcwaDl6clpiNHc2M3RLYXMxN2hTbGpzZmVick0yVktrSXhGdlkr?=
 =?utf-8?B?U3pwc3JiM1k3TjNxc0g5d0xBdmJNbmUvK0I3Y3BwMk1tZmp6clNkcCtoaTFS?=
 =?utf-8?B?eENwQTJveFkrL1hjbjdnZW5RYUNVV1A5a0dHZFRxZ3dMMi9iSXdoQ1d3cXNO?=
 =?utf-8?B?ajZNQWJPMmxkK1U1Z0Vrc3hwbFFVSC9UVC9MME1WemZHL3JBVXBucTBBREQy?=
 =?utf-8?B?MGpVWjBMQnlSNDVJZ0hIeVRlUlYvRzl2bEFEUTY1eEU2QWhtV01Td1dFU1Yx?=
 =?utf-8?B?NkxYNSszRmZ2YTdkVndaZWVKY0RSRXp3TWpoQUE3bGJwZUxhbzJFMjdSTGhv?=
 =?utf-8?B?K3JCejY2WDRWMUMvTGNQaThEUEVXd2xpYXZ4ZHk0QnlrMlhveHRBNU9oUkEz?=
 =?utf-8?B?Mjl6N3h4enc5WkljUXErc2tHY2daYStlcWNWSzdnTnBGd2dBQkplN0ttbGxs?=
 =?utf-8?B?L2RlL0hUMm1UeEFwNWxRUTNzeEd4emJ5cmVLVm5jb2xhd1l6VlVGSmhGcmFF?=
 =?utf-8?B?SGZERFZOOVpSc0s1RGpFK3RHb1lqTmNCMS9UOFBPaDZ5NFlTTndJQ2NWZW5v?=
 =?utf-8?B?eHBKbnM1TmFSL0hiTFBhUzhsVDBJN1cyL2I2OThNNG9rNUxnUmJFS3lwNkJs?=
 =?utf-8?B?TXEvMXp3N3pWanFiS0lRbWpGMisxbjZRSFhrSDBpQlZla3B6NWhGTi9YbklP?=
 =?utf-8?B?bVhDWEluYm5xQmpFTndPTmNMUWErOHBkQ2lGRnVLbnRIRlVxRVVYcytVcWwy?=
 =?utf-8?B?eWszK2FUbnZnME1Wamhmbk5EYmNjOEZ1ZHJCTzdRSGVGL3FZTDRkcVpMcGNr?=
 =?utf-8?B?NFBSL050MTE1eG1LQURzSXFkMkdQUlpBd0R5R2YxR3doU1FhUWhFQ0ZBMTl3?=
 =?utf-8?B?WEZKQ1pEK2tVY3BzNjVLSkpTSWNiL2wvaURVeVdXVTFHZFJpS3U3R0JMeWlo?=
 =?utf-8?B?bEZ3c2Q2b1ZyQjAybUozaXV5WjdTM090eG1acGhKbEh3NnVEM1VFUHFwQ2Fx?=
 =?utf-8?B?VUE1c21GV3V6bUN0VTgxZDV1bldQVlR0aVpOTUMrU2RSczNhZEM0YzhDZVFr?=
 =?utf-8?Q?QIr2NvgmyVt50gHv68mcfBNLgQyD7CvxbyPpwRinKT1w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1936ce06-b5df-425a-ade3-08dcb58d6c3e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:30:19.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6502

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCA1LCAyMDI0IDk6NTEgQU0NCg0KW3NuaXBdDQoNCj4gPj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBiL2FyY2gvYXJtNjQvaW5j
bHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBpbmRleCBhOTc1ZTFhNjg5ZGQuLmE3YTM1ODZmN2Ni
MSAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQo+
ID4+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBAQCAtNTEs
NCArNTEsOSBAQCBzdGF0aWMgaW5saW5lIHU2NCBodl9nZXRfbXNyKHVuc2lnbmVkIGludCByZWcp
DQo+ID4+DQo+ID4+ICAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL21zaHlwZXJ2Lmg+DQo+ID4+DQo+
ID4+ICsjZGVmaW5lIEFSTV9TTUNDQ19WRU5ET1JfSFlQX1VJRF9IWVBFUlZfUkVHXzAJMHg3OTQ4
NzM0ZA0KPiA+PiArI2RlZmluZSBBUk1fU01DQ0NfVkVORE9SX0hZUF9VSURfSFlQRVJWX1JFR18x
CTB4NTY3MjY1NzANCj4gPj4gKyNkZWZpbmUgQVJNX1NNQ0NDX1ZFTkRPUl9IWVBfVUlEX0hZUEVS
Vl9SRUdfMgkwDQo+ID4+ICsjZGVmaW5lIEFSTV9TTUNDQ19WRU5ET1JfSFlQX1VJRF9IWVBFUlZf
UkVHXzMJMA0KPiA+PiArDQo+ID4NCj4gPiBTZWN0aW9uIDYuMiBvZiB0aGUgU01DQ0Mgc3BlY2lm
aWNhdGlvbiBzYXlzIHRoYXQgdGhlICJDYWxsIFVJRCBRdWVyeSINCj4gPiByZXR1cm5zIGEgVVVJ
RC4gVGhlIGFib3ZlICNkZWZpbmVzIGxvb2sgbGlrZSBhbiBBU0NJSSBzdHJpbmcgaXMgYmVpbmcN
Cj4gPiByZXR1cm5lZC4gQXJndWFibHkgdGhlIEFTQ0lJIHN0cmluZyBjYW4gYmUgdHJlYXRlZCBh
cyBhIHNldCBvZiAxMjggYml0cw0KPiA+IGp1c3QgbGlrZSBhIFVVSUQsIGJ1dCBpdCBkb2Vzbid0
IG1lZXQgdGhlIHNwaXJpdCBvZiB0aGUgc3BlYy4gQ2FuIEh5cGVyLVYNCj4gPiBiZSBjaGFuZ2Vk
IHRvIHJldHVybiBhIHJlYWwgVVVJRD8gV2hpbGUgdGhlIGRpc3RpbmN0aW9uIHByb2JhYmx5DQo+
ID4gd29uJ3QgbWFrZSBhIG1hdGVyaWFsIGRpZmZlcmVuY2UgaGVyZSwgd2UndmUgaGFkIHByb2Js
ZW1zIGluIHRoZSBwYXN0DQo+ID4gd2l0aCBIeXBlci1WIGRvaW5nIHNsaWdodGx5IHdlaXJkIHRo
aW5ncyB0aGF0IGxhdGVyIGNhdXNlZCB1bmV4cGVjdGVkDQo+ID4gdHJvdWJsZS4gUGxlYXNlIGp1
c3QgZ2V0IGl0IHJpZ2h0LiA6LSkNCj4gPg0KPiBUaGUgYWJvdmUgdmFsdWVzIGRvbid0IHZpb2xh
dGUgYW55dGhpbmcgaW4gdGhlIHNwZWMsIGFuZCBJIHRoaW5rIGl0DQo+IHdvdWxkIGJlIGhhcmQg
dG8gZ2l2ZSBhbiBleGFtcGxlIG9mIHdoYXQgY2FuIGJlIGJyb2tlbiBpbiB0aGUgd29ybGQgYnkN
Cj4gdXNpbmcgdGhlIGFib3ZlIHZhbHVlcy4NCg0KQWdyZWVkLiAgSG93ZXZlciwgbm90ZSB0aGF0
IFVVSURzICpkbyogaGF2ZSBzb21lIGludGVybmFsIHN0cnVjdHVyZS4NClNlZSBodHRwczovL3d3
dy51dWlkdG9vbHMuY29tL2RlY29kZSwgZm9yIGV4YW1wbGUuIFRoZSBVVUlEIGFib3ZlDQppczoN
Cg0KNGQ3MzQ4NzktNzA2NS03MjU2LTAwMDAtMDAwMDAwMDAwMDAwDQoNCkl0IGhhcyBhIHZlcnNp
b24gZGlnaXQgb2YgIjciLCB3aGljaCBpcyAidW5rbm93biIuICBJJ20gbm8gZXhwZXJ0IG9uIFVV
SURzLA0KYnV0IGFwcGFyZW50bHkgdGhlICI3IiBpc24ndCBuZWNlc3NhcmlseSBpbnZhbGlkLCB0
aG91Z2ggcGVyaGFwcyBhIGJpdCB1bmV4cGVjdGVkLg0KDQo+IEkgZG8gdW5kZXJzdGFuZCB3aGF0
IHlvdSdyZSBzYXlpbmcgd2hlbiB5b3UNCj4gbWVudGlvbiB0aGUgVUlEcyAmIHRoZSBzcGlyaXQg
b2YgdGhlIHNwZWMuIFB1dCBvbiB0aGUgcXVhbnRpdGF0aXZlDQo+IGZvb3RpbmcsIHRoZSBTaGFu
bm9uIGVudHJvcHkgb2YgdGhlc2UgdmFsdWVzIGlzIG11Y2ggbG93ZXIgdGhhbiB0aGF0IG9mDQo+
IGFuIFVJRC4gQSBjdXJzb3J5IHNlYXJjaCBpbiB0aGUga2VybmVsIHRyZWUgZG9lcyB0dXJuIHVw
IG90aGVyIFVJRHMgdGhhdA0KPiBkb24ndCBsb29rIHRvbyByYW5kb20uDQo+IA0KPiBBcyB0aGF0
IGlzIGltcGxlbWVudGVkIG9ubHkgaW4gdGhlIG5vbi1yZWxlYXNlIHZlcnNpb25zLCBoYXJkbHkg
c29tZW9uZQ0KPiBoYXMgdGFrZW4gYSBkZXBlbmRlbmN5IG9uIHRoZSBzcGVjaWZpYyB2YWx1ZXMg
aW4gdGhlaXIgcHJvZHVjdGlvbiBjb2RlLg0KPiBJIGd1ZXNzIHRoYXQgY2FuIGJlIGNoYW5nZWQg
d2l0aG91dCBjYXVzaW5nIGFueSBkaXN0dXJiYW5jZSB0byB0aGUNCj4gY3VzdG9tZXJzLCB3aWxs
IHJlcG9ydCBvZiBhbnkgY29uY2VybnMgdGhvdWdoLg0KDQpNeSBsYXN0IHRob3VnaHQgaXMgdGhh
dCB3aGVuIGRlYWxpbmcgd2l0aCB0aGUgb3BlbiBzb3VyY2Ugd29ybGQsIGFuZA0Kd2l0aCBwdWJs
aXNoZWQgc3RhbmRhcmRzLCBpdCdzIHVzdWFsbHkgYmVzdCB0byBkbyB3aGF0J3Mgbm9ybWFsIGFu
ZA0KZXhwZWN0ZWQsIHJhdGhlciB0aGFuIHRyeWluZyB0byBtYWtlIHRoZSBjYXNlIHRoYXQgc29t
ZXRoaW5nIHVuZXhwZWN0ZWQNCmlzIGFsbG93ZWQgYnkgdGhlIHNwZWMuIERvaW5nIHRoZSBsYXR0
ZXIgY2FuIGNvbWUgYmFjayB0byBiaXRlIHlvdSBpbg0KY29tcGxldGVseSB1bmV4cGVjdGVkIHdh
eXMuIDotKQ0KDQpXaXRoIHRoYXQsIEkgd29uJ3QgbWFrZSBhbnkgZnVydGhlciBjb21tZW50cyBv
biB0aGUgdG9waWMuIFlvdSBkbw0Kd2hhdGV2ZXIgeW91IGNhbiBkbyBpbiB3b3JraW5nIHdpdGgg
SHlwZXItVi4gRWl0aGVyIHdheSwgaXQgd29uJ3QgYmUNCmEgYmxvY2tlciB0byBteSBnaXZpbmcg
IlJldmlld2VkLWJ5IiBvbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQ0KcGF0Y2guDQoNCk1pY2hh
ZWwNCg==

