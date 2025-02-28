Return-Path: <linux-arch+bounces-10458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B8A48D8D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D8F3B4009
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E455522F;
	Fri, 28 Feb 2025 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F/Jo7Km5"
X-Original-To: linux-arch@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010076.outbound.protection.outlook.com [52.103.2.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87283211C;
	Fri, 28 Feb 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703841; cv=fail; b=MSS2SvMjXsNdO8sYaOqRZSBnWdxec8CTTGgQIScChnZQmhRuTB51JJo5ulcRQ3n6CG4l7BDeovcuxTKwK6UBmkIWAUau4gxAN0wo9dSnN//NUciL/hDalV6aB7vLg36dj52LPLCL/cng3AiNZN3cjqmGQUr/IWXmQQGQJFFVrp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703841; c=relaxed/simple;
	bh=Xbk31/YGJKYQEKcEZTUaa5PBwhfXyenk5+Uag/cS3xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DujpoMv/z4JqsKzIO1PTUxoQgw0dFfMMxQCwn1Wi2AMOEfKwT5EgBLCh8KNnSLdmxbyLQ4T0siOxJFsZAtQ3MpQnHx+6VYFr0GfeK80ceLlgiqrKSWj6BSQvDE4SiDBDUCucfouJZHiItzSx70qWIEc0HuZyBPWoRhiGI6nePmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F/Jo7Km5; arc=fail smtp.client-ip=52.103.2.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxxxsHOprcej9QAaR6Q++XzBULCHAEfXm9AvR4jm9O/zLt22Zm50vH3tXOiDQEqdQa3oTlPj8u4t3DiocFHKMUx3HuUnn9ngtT4F5ZPhv7xt6ZkIHhRXPSQvnRWpBlBwnG20rcIMRlkKsNYfQB7G9ZON/9PtBlERL9bcDDwUAz8LU43C72ZMLVQ2baZn7OTuo0U1GzRagpm0HlWgqxE1lcu59sgSYd1l1fvgxaGIcCXmQOhiE+SY/g4B5f4XI1dtGPQyreLQTG1FBUT+l+SjXxELnhuH70bUBVMBXtGdV5F816jxaV4q9ymMWvvHXG2BEXvb1DWGUl8AoYCodvb3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbk31/YGJKYQEKcEZTUaa5PBwhfXyenk5+Uag/cS3xE=;
 b=VxRuWtqoRZwG+hcNjpirt/e0YPtMJ9ag7V5vMFV43X0z7ecDXPr7MWWIAT+TWJEe+0lX04HSANTlXCL+S0dyUCHeGB5bwtDTda4YgfS1ujA2gfEIunjPM8DeEB72l6vYG1wTqtErwQpzjxk9Yo2yCVNYHVu3DWu8yz8ddFDO8zla9hkbAADZQhbZ+rU/Q7F71ZTAUHGnGYTAK9s898kKZ6Dgf0oIQmG0tbK+Z33MjZkWlELEWhbx0sve3lPS9NwXbE2mf8H4su41kqilWrmAm9pQB/erPocL2wkzceHabtzgbgnDBNcgjlPpFdP00bqBAQjW32/RzbfLvnrXtqVGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbk31/YGJKYQEKcEZTUaa5PBwhfXyenk5+Uag/cS3xE=;
 b=F/Jo7Km53Fy3Dc1hm4YaINCuHS5NT1P/qV6g/O1PNjO1JPA2ma9/gyv/kEZk2UU8cDCK+BFsG5F5gZgk54Lui0zGXWdlIFAB5AS5xYaxzjQJBvisiM7Y1SWX56U3WLodLyvA0M8lEl4ZepERo3t5FExIcTZoliILvu86+XShh3lyATDWVcqclP0McHjY9b1z8mFE5rU90sxMKD/9pIPYtt7wuOm+UGNgqwdcitit7REv1aR+7BD+19UTJ3p2RlE/khuBoy8mCbCq1V92fzlcZQM7n9xp+3waX75NrxlwFsa+btHlhmfbi5JuVhIriKVQJ8kUmD+U7wpsoBWygw10Pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7533.namprd02.prod.outlook.com (2603:10b6:a03:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 00:50:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 00:50:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH 3/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall
 arguments -- part 1
Thread-Topic: [PATCH 3/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall
 arguments -- part 1
Thread-Index: AQHbiIpAnyiq114PNk+OdgeSwwf847NbpkEAgAA2jmA=
Date: Fri, 28 Feb 2025 00:50:35 +0000
Message-ID:
 <SN6PR02MB415752B5971A2D29EBB385B1D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-4-mhklinux@outlook.com>
 <f9b3d2b7-59d6-42b7-b0eb-d26be3405b22@linux.microsoft.com>
In-Reply-To: <f9b3d2b7-59d6-42b7-b0eb-d26be3405b22@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7533:EE_
x-ms-office365-filtering-correlation-id: 1ca19135-0780-4f86-edc9-08dd5791e970
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|461199028|12121999004|19110799003|15080799006|102099032|440099028|3412199025|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkJYa3BWeE9vbEVWek1uKytOenFtT2F6ZEJFcXRVY1BVMi9DQTdhMTU5MDNt?=
 =?utf-8?B?TmZpbXlpOUh1ZHQ1cmVKelF2cWljdnVuUlNSaEJIUTBTdXRzejB3aXo1UVhj?=
 =?utf-8?B?WDlLWHM0UkFZNzlMT01Ba3JDbktOTTJOQ3VSOHBpakhXTVZzQ2p4cHhqME42?=
 =?utf-8?B?eHJxc2lqcE5jc09XdW1aQXkzQktMbWNpeTRrS1RxYnU4ZVZidEtTVlU4R3R4?=
 =?utf-8?B?cWFTMnZaMGtMTUtmNE1JcVFPdTdzclh2NUdGSWtkQURVWG1hZUtZOWNoMDVo?=
 =?utf-8?B?MXNXR051Q292N0MrQlNlT3FrTWJBOFhibkd4WUlycnZZTFQxMkFEMjhLNGd1?=
 =?utf-8?B?dmlNTXBIT2tjaUJ4amdLTVhHbzRqdFpiL0U1VWZNYUtLMzcyajl3VStEc1Y4?=
 =?utf-8?B?MFdsN25jUEU5TjVJUEFCUnNrZDFLcEpmNWFWQWs5am5haXVnS2l0RVYrME5y?=
 =?utf-8?B?SDV6bGQvRGpVN1FOUXMvemdVSis4Z0MwT05XZnl0NTNjeVIwQ2tlaEQvcDBt?=
 =?utf-8?B?aDNMQzlXbDc5R3FJV3lnaHM5TU9VSmcyVGNRcEVLV1JIUVpSVU5VMmFaNjdW?=
 =?utf-8?B?dStDMmlsVFN6RW1jdzg3WmFGb1FiS0dKNmRvcVZaWDlWSUM0cmZhMHorNHFW?=
 =?utf-8?B?V0lwSjFocVhvQVF1dzNFcUJ2RmxaeTN3L1ZxOXczUkVIRXlqNmd2V0I0cUhF?=
 =?utf-8?B?MjJ5d2FCQmV2cjlPWllQRHpLTEhEM1RqendOUzA1Y0FUQUxHWFZzWnVEVGtk?=
 =?utf-8?B?Zm9iRnhqSXBHUTJvelMrSjg0UDB1YVpLbHBOMy9kTFRNOG1QTjNYNkc3bUlL?=
 =?utf-8?B?aGxGNUpaREt0aXRFRUgyeDRIK0RUeTlMSllYbmRqNUVjeXU4cDdMeDMraTRK?=
 =?utf-8?B?d1VKcWpTN3RvM0U0a2svU2NwMzdOQ1Z2RkNUNUQweHdLRXpzejhHYkx0Y2xC?=
 =?utf-8?B?SDQveTNRT0VoelRvNDl3K1pHSlZoQWRtb3k2ZHQ2WEUrbURpUDVKbnZ6OFZG?=
 =?utf-8?B?T0VGbnc1S2JEN3d0bVlrc2x1WXNlSHp4emoxY0xZQnZydWxpYVJETXhlU1ZT?=
 =?utf-8?B?SERpWWVIcWtXQkduZWZ2MmdFR0pmdGk4aVFvM0tySGhlbExpNXdsRUNBKytK?=
 =?utf-8?B?TEFYMWtoNHlFTXRrN2YvRmhqbEppbHBzYnd4cE5yUTlUM25KNGtMbXZKckVD?=
 =?utf-8?B?NU5QNlBVb0hZUkJPbXh4a0xCcDk2Mm5Hd25Gbmsyb2J2UDFxRldzOFdRd3dh?=
 =?utf-8?B?RUV1WWUrbWlnRzBVaWQwUnA4MUdkNFg3aUd1N2FxZU9lQkRGZ1V5Ny96YnpX?=
 =?utf-8?B?OWY3dEc1alMxUHhuN3NocHBpWmZ4Z2dINkx6dnpNT1BqWVJ2ZUo3ZG9hbFFy?=
 =?utf-8?B?TStoeUEyTlpIazJtYWFkekxRdUZWQWo0dVNYMEpBdzlxQWRRR29WdFNmVlQ1?=
 =?utf-8?B?SGV6RkVLQ3NTcGxKVG83VGprSU1weTYvTloybUw2cXljL24ybWpEcWtDOWkz?=
 =?utf-8?B?SEpDYk9aa1pOTlIzZHBPN0NLRjg5d1MwYjBJd3RaUVQwa2Y1WFdiVUo0VkJa?=
 =?utf-8?B?VllOUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THR0bGw0RDNlSUdGLzBzUEh3K2F0Ny9teXBmdUpDVmhlK2Z4ZWtWWmdoMkt0?=
 =?utf-8?B?OFFEbzE5WTBOL3lDNTloR3QxUGppeFhOemNrdTRuYUhmc2RXRzBMWnVDZWNt?=
 =?utf-8?B?aDF5ZkJDbys1N3NmUlZMcUNzR2F4alBKOHovN3BRbTFkUk5oN0NwcFEvRDdN?=
 =?utf-8?B?eHZSWkpzdmY2QytIK3NWcXlYc0VsTmE0Rk9YMFdEaFNQY0krVWozbVpxY0FM?=
 =?utf-8?B?NGkyVklIZDVpd2VwSk5IanhSaERZTnJ2MVBmSEkrTXJlaThkc3N4amFVRWlF?=
 =?utf-8?B?UXdLVFUwQlAyZHVtU2Fmclk1N2xkM3lEcXlib2hlZGdUclZVdzhoOHlsZlBh?=
 =?utf-8?B?bjJHR2h1WmxRQk1DUU81R3RCbmwvYWRISVBkSnptejBlQzcrd2xHVzZjZnY0?=
 =?utf-8?B?a3VOK09JYVNtUU9tdlVRVE9KaDRYYXdiRUE1MUhncmJKYzhOaHExNko5OEhz?=
 =?utf-8?B?VWdobk51ZW9LZUhVTkg1bnhOMWJzWGhyalB2aWVyNUVpUko0UTNlQnBVV3U3?=
 =?utf-8?B?cDRrazNhaUo3RHBmd1QvdWc0UDNTNWVGRjNadnp0YmwzWVoyL0dEeTdFYTgv?=
 =?utf-8?B?bU9RUDg5VGxJQ1pOUTN2VTdqWTBxVyt6TEdjRzdwaXo2L3E2cnZKekljRmJj?=
 =?utf-8?B?aDFSR0ZkZTFBcTRnUEpJd0oxS3RLMDBzZFp3T29KSFFqMUczS2FrL0trOTdp?=
 =?utf-8?B?RDFiRGRMRnYrcTNiRDdXMnQrUzNLeGlaRXdYUUtwRzVTUUVZeUx3QzlTTWFv?=
 =?utf-8?B?UDlIbzdoRTl6ajN0akI5WENnS1lMOFFPN0IyUTJLWmN0ZldpVksyMjJWamtL?=
 =?utf-8?B?dnc1YTBRNlUyUU11c05yNW41ZUlGNHUyWFBiUmtLVEdNcyt0d3g0cDRWbmFh?=
 =?utf-8?B?MStaUThGUkk5dWU1NUFvUXF5b1VJbmltMlNkLzVxRk1hZC85VTRlZWtZdjBI?=
 =?utf-8?B?eG8rNVE5MjN2YWJVdm5JUTFnQWQ0OCswRUxEb0VFb2hXbHJJK1VIalA3TnVt?=
 =?utf-8?B?c3BYNWhoOEtYQTR3QmxZNThOdE1NOUJ3c3NHN2x0ZDBMNmsvY0lVU2U4TjdL?=
 =?utf-8?B?U1JPdEhSNkJ6Y25JbnhpdzErTzl0bHUxbFhFWEplb2FibzNGZHc4L3gxWDZt?=
 =?utf-8?B?eE9heVlNcHJEWDRTRWlFLzhPeVhudVN6OUZyenpwWTMzKzVvZ3lqejdsZXRq?=
 =?utf-8?B?SXBzRXFKOGRna2Jzdk1FSTcvdDhlNDQyM01CRXAzMkhxcmZjT2ZmMmFPN0pv?=
 =?utf-8?B?L2Y4N1RGcjRvKzBxQ3VJWUxsWVhSVHFvREdjenByZmVGZzdqTU14UnFEWFNG?=
 =?utf-8?B?cnpOQUpZNVkzdUE3MUdCa2gwSmlQQ0JNTVhGYVg5R3d0ci92eXg0WUdVbklX?=
 =?utf-8?B?cFFuQW1xN2pxYkpEMk9mL0g4VlM1RGZwbTBmamNuampUS1YvaVV4bGhnWEZY?=
 =?utf-8?B?YWpzSWhOVjBsZGZiUXZmUkJJdVlBSDJRaG9vTlBwRCtLYU5NWWhZeUhBOG01?=
 =?utf-8?B?U3l1SzE4YlAzTy9nSkRvTDRqRS9tU2xFVDh4dFJFNUd4aEZBTVo5LzVIMVlY?=
 =?utf-8?B?ZjdxUzYyNWNpRGpxTmMzVlRHVjQ2ckg4ZlhCVGZueTdSVm93K2VhT2pyaERi?=
 =?utf-8?Q?k5UWtAz9Ym9Jt0NWQpEwIXcXG2uJB/BSaA2FDjZlW+NU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca19135-0780-4f86-edc9-08dd5791e970
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 00:50:35.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7533

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjcsIDIwMjUgMTowOCBQTQ0KPiANCj4gT24gMi8yNi8y
MDI1IDEyOjA2IFBNLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBNaWNo
YWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+ID4NCj4gPiBVcGRhdGUgaHlwZXJj
YWxsIGNhbGwgc2l0ZXMgdG8gdXNlIHRoZSBuZXcgaHZfaHZjYWxsXyooKSBmdW5jdGlvbnMNCj4g
PiB0byBzZXQgdXAgaHlwZXJjYWxsIGFyZ3VtZW50cy4gU2luY2UgdGhlc2UgZnVuY3Rpb25zIHpl
cm8gdGhlDQo+ID4gZml4ZWQgcG9ydGlvbiBvZiBpbnB1dCBtZW1vcnksIHJlbW92ZSBub3cgcmVk
dW5kYW50IGNhbGxzIHRvIG1lbXNldCgpDQo+ID4gYW5kIGV4cGxpY2l0IHplcm8naW5nIG9mIGlu
cHV0IGZpZWxkcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGts
aW51eEBvdXRsb29rLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMu
YyAgIHwgIDYgKystLS0tDQo+ID4gIGFyY2gveDg2L2h5cGVydi9odl9pbml0LmMgICB8ICA1ICst
LS0tDQo+ID4gIGFyY2gveDg2L2h5cGVydi9odl92dGwuYyAgICB8ICA4ICsrLS0tLS0tDQo+ID4g
IGFyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYyB8IDEwICsrKystLS0tLS0NCj4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9hcGljLmMgYi9hcmNoL3g4Ni9oeXBlcnYvaHZf
YXBpYy5jDQo+ID4gaW5kZXggZjAyMmQ1ZjY0ZmI2Li5jMTZmODFkZDM2ZmMgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2h5cGVy
di9odl9hcGljLmMNCj4gPiBAQCAtMTE1LDE0ICsxMTUsMTIgQEAgc3RhdGljIGJvb2wgX19zZW5k
X2lwaV9tYXNrX2V4KGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrLCBpbnQgdmVjdG9yLA0KPiA+
ICAJCXJldHVybiBmYWxzZTsNCj4gPg0KPiA+ICAJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiA+
IC0JaXBpX2FyZyA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4gPiAt
DQo+ID4gKwlodl9odmNhbGxfaW5fYXJyYXkoJmlwaV9hcmcsIHNpemVvZigqaXBpX2FyZyksDQo+
ID4gKwkJCQlzaXplb2YoaXBpX2FyZy0+dnBfc2V0LmJhbmtfY29udGVudHNbMF0pKTsNCj4gSSB0
aGluayB0aGUgcmV0dXJuZWQgImJhdGNoIHNpemUiIHNob3VsZCBiZSBjaGVja2VkIHRvIGVuc3Vy
ZSBpdCBpcyBub3QgdG9vIHNtYWxsIHRvIGhvbGQgdGhlDQo+IHZhcmlhYmxlLXNpemVkIHBhcnQg
b2YgdGhlIGhlYWRlci4NCg0KQXJlIHlvdSBzYXlpbmcgdG8gY2hlY2sgdGhlIGJhdGNoX3NpemUg
YWdhaW5zdCBucl9iYW5rICh3aGljaCBpcyB0aGUNCnNpemUgb2YgdGhlIGFycmF5IGVtYmVkZGVk
IGluIHZwX3NldCk/ICANCg0KPiANCj4gPiAgCWlmICh1bmxpa2VseSghaXBpX2FyZykpDQo+ID4g
IAkJZ290byBpcGlfbWFza19leF9kb25lOw0KPiA+DQo+IFdoaWxlIGhlcmUsIGlzIHRoaXMgY2hl
Y2sgcmVhbGx5IG5lZWRlZD8gSWYgc28sIG1heWJlIGEgY2hlY2sgZm9yIHRoZSBwZXJjcHUgcGFn
ZShzKSBjb3VsZCBiZQ0KPiBiYWtlZCBpbnRvIGh2X2h2Y2FsbF9pbm91dF9hcnJheSgpPw0KDQpZ
ZXMsIEkgd2FudGVkIHRvIGJha2UgdGhlIGNoZWNrIGludG8gaHZfaHZjYWxsX2lub3V0X2FycmF5
KCkuIEJ1dCB0aGlzDQpjaGVjayByZWFsbHkgaXMgbmVlZGVkLiAgaHZfc2VuZF9pcGkoKSwgd2hp
Y2ggY2FuIHByb3BhZ2F0ZSBkb3duIHRvDQpfX3NlbmRfaXBpX21hc2tfZXgoKSwgY2FuIGdldCBj
YWxsZWQgZWFybHkgZHVyaW5nIGJvb3QgYmVmb3JlIHRoZSBwZXItY3B1DQpoeXBlcmNhbGwgYXJn
dW1lbnQgcGFnZSBpcyBhbGxvY2F0ZWQuIFRoZSBsYWNrIG9mIHRoZSBoeXBlcmNhbGwgYXJndW1l
bnQNCnBhZ2UgbXVzdCBjbGVhbmx5IHByb3BhZ2F0ZSBiYWNrIHRvIGh2X3NlbmRfaXBpKCkgc28g
aXQgY2FuIHVzZSB0aGUgbmF0aXZlDQpBUElDICJzZW5kIElQSSIgZnVuY3Rpb24gdGhhdCB3b3Jr
cyB3aXRob3V0IGEgaHlwZXJjYWxsLCBidXQgaXMgc2xvd2VyLg0KDQo+IA0KPiA+ICAJaXBpX2Fy
Zy0+dmVjdG9yID0gdmVjdG9yOw0KPiA+IC0JaXBpX2FyZy0+cmVzZXJ2ZWQgPSAwOw0KPiA+IC0J
aXBpX2FyZy0+dnBfc2V0LnZhbGlkX2JhbmtfbWFzayA9IDA7DQo+ID4NCj4gPiAgCS8qDQo+ID4g
IAkgKiBVc2UgSFZfR0VORVJJQ19TRVRfQUxMIGFuZCBhdm9pZCBjb252ZXJ0aW5nIGNwdW1hc2sg
dG8gVlBfU0VUDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMgYi9h
cmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ID4gaW5kZXggZGRlYjQwOTMwYmM4Li5jNWM5NTEx
Y2I3ZWQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KPiA+ICsr
KyBiL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMNCj4gPiBAQCAtNDAwLDEzICs0MDAsMTAgQEAg
c3RhdGljIHU4IF9faW5pdCBnZXRfdnRsKHZvaWQpDQo+ID4gIAl1NjQgcmV0Ow0KPiA+DQo+ID4g
IAlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+ID4gLQlpbnB1dCA9ICp0aGlzX2NwdV9wdHIoaHlw
ZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4gPiAtCW91dHB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2
X3BjcHVfb3V0cHV0X2FyZyk7DQo+ID4NCj4gPiAtCW1lbXNldChpbnB1dCwgMCwgc3RydWN0X3Np
emUoaW5wdXQsIG5hbWVzLCAxKSk7DQo+ID4gKwlodl9odmNhbGxfaW5vdXQoJmlucHV0LCBzaXpl
b2YoKmlucHV0KSwgJm91dHB1dCwgc2l6ZW9mKCpvdXRwdXQpKTsNCj4gDQo+IFRoaXMgZG9lc24n
dCBsb29rIHJpZ2h0LCB0aGlzIGlzIGEgcmVwIGh5cGVyY2FsbCB0YWtpbmcgYW4gYXJyYXkgb2Yg
cmVnaXN0ZXIgbmFtZXMNCj4gYW5kIG91dHB1dHRpbmcgYW4gYXJyYXkgb2YgcmVnaXN0ZXIgdmFs
dWVzLg0KPiANCj4gaHZfaHZjYWxsX2lub3V0X2FycmF5KCkgc2hvdWxkIGJlIGZ1bGx5IHV0aWxp
emVkIChpbnB1dCBhbmQgb3V0cHV0IGFycmF5cykgaGVyZS4NCj4gDQo+IFRoZSBjdXJyZW50IGNv
ZGUgbWF5IGFjdHVhbGx5IHdvcmssIGJ1dCBpdCB3aWxsIG92ZXJsYXAgdGhlIGlucHV0IGFuZCBv
dXRwdXQhDQoNClllcC4gIEkgbWVzc2VkIHRoaXMgdXAuICBOb3Qgc3VyZSB3aHkuIDotKCAgIFdp
bGwgZml4Lg0KDQo+IA0KPiA+ICAJaW5wdXQtPnBhcnRpdGlvbl9pZCA9IEhWX1BBUlRJVElPTl9J
RF9TRUxGOw0KPiA+ICAJaW5wdXQtPnZwX2luZGV4ID0gSFZfVlBfSU5ERVhfU0VMRjsNCj4gPiAt
CWlucHV0LT5pbnB1dF92dGwuYXNfdWludDggPSAwOw0KPiA+ICAJaW5wdXQtPm5hbWVzWzBdID0g
SFZfUkVHSVNURVJfVlNNX1ZQX1NUQVRVUzsNCj4gPg0KPiA+ICAJcmV0ID0gaHZfZG9faHlwZXJj
YWxsKGNvbnRyb2wsIGlucHV0LCBvdXRwdXQpOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9o
eXBlcnYvaHZfdnRsLmMgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfdnRsLmMNCj4gPiBpbmRleCAzZjRl
MjBkN2I3MjQuLjNkZDI3ZDU0OGRiNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYv
aHZfdnRsLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfdnRsLmMNCj4gPHNuaXA+DQo+
ID4gQEAgLTE4NSwxMyArMTg0LDEwIEBAIHN0YXRpYyBpbnQgaHZfdnRsX2FwaWNpZF90b192cF9p
ZCh1MzIgYXBpY19pZCkNCj4gPg0KPiA+ICAJbG9jYWxfaXJxX3NhdmUoaXJxX2ZsYWdzKTsNCj4g
Pg0KPiA+IC0JaW5wdXQgPSAqdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2FyZyk7DQo+
ID4gLQltZW1zZXQoaW5wdXQsIDAsIHNpemVvZigqaW5wdXQpKTsNCj4gPiArCWh2X2h2Y2FsbF9p
bm91dCgmaW5wdXQsIHNpemVvZigqaW5wdXQpLCAmb3V0cHV0LCBzaXplb2YoKm91dHB1dCkpOw0K
PiBUaGlzIGhhcyB0aGUgc2FtZSBpc3N1ZSBhcyBhYm92ZSAtIGl0IGlzIGEgcmVwIGh5cGVyY2Fs
bCBzbyBuZWVkcyBodl9odmNhbGxfaW5vdXRfYXJyYXkoKQ0KDQpBZ3JlZWQuICBXaWxsIGZpeC4N
Cg0KPiANCj4gPiAgCWlucHV0LT5wYXJ0aXRpb25faWQgPSBIVl9QQVJUSVRJT05fSURfU0VMRjsN
Cj4gPiAgCWlucHV0LT5hcGljX2lkc1swXSA9IGFwaWNfaWQ7DQo+ID4NCj4gPiAtCW91dHB1dCA9
ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfb3V0cHV0X2FyZyk7DQo+ID4gLQ0KPiA+ICAJY29u
dHJvbCA9IEhWX0hZUEVSQ0FMTF9SRVBfQ09NUF8xIHwgSFZDQUxMX0dFVF9WUF9JRF9GUk9NX0FQ
SUNfSUQ7DQo+ID4gIAlzdGF0dXMgPSBodl9kb19oeXBlcmNhbGwoY29udHJvbCwgaW5wdXQsIG91
dHB1dCk7DQo+ID4gIAlyZXQgPSBvdXRwdXRbMF07DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2h5cGVydi9pcnFkb21haW4uYyBiL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYw0KPiA+IGlu
ZGV4IDY0YjkyMTM2MGIwZi4uODAzYjFhOTQ1YzVjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2
L2h5cGVydi9pcnFkb21haW4uYw0KPiA+ICsrKyBiL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4u
Yw0KPiA+IEBAIC0yNCwxMSArMjQsMTEgQEAgc3RhdGljIGludCBodl9tYXBfaW50ZXJydXB0KHVu
aW9uIGh2X2RldmljZV9pZCBkZXZpY2VfaWQsIGJvb2wgbGV2ZWwsDQo+ID4NCj4gPiAgCWxvY2Fs
X2lycV9zYXZlKGZsYWdzKTsNCj4gPg0KPiA+IC0JaW5wdXQgPSAqdGhpc19jcHVfcHRyKGh5cGVy
dl9wY3B1X2lucHV0X2FyZyk7DQo+ID4gLQlvdXRwdXQgPSAqdGhpc19jcHVfcHRyKGh5cGVydl9w
Y3B1X291dHB1dF9hcmcpOw0KPiA+ICsJaHZfaHZjYWxsX2lub3V0X2FycmF5KCZpbnB1dCwgc2l6
ZW9mKCppbnB1dCksDQo+ID4gKwkJCXNpemVvZihpbnB1dC0+aW50ZXJydXB0X2Rlc2NyaXB0b3Iu
dGFyZ2V0LnZwX3NldC5iYW5rX2NvbnRlbnRzWzBdKSwNCj4gPiArCQkJJm91dHB1dCwgc2l6ZW9m
KCpvdXRwdXQpLCAwKTsNCj4gQXMgbm90ZWQgYmVmb3JlIEkgdGhpbmsgdGhlIGJhdGNoIHNpemUg
c2hvdWxkIGJlIGNoZWNrZWQgdG8gZW5zdXJlIGl0IGlzIGxhcmdlIGVub3VnaC4NCj4gDQo+IFNp
ZGUgbm90ZSAtIGl0IHNlZW1zIGluIHRoaXMgaHlwZXJjYWxsLCBucl9iYW5rcyArIDEgaXMgdXNl
ZCBhcyB0aGUgdmFyaGVhZCBzaXplLCB3aGljaA0KPiBjb3VudHMgdGhlIHZwIHZhbGlkIG1hc2ss
IGJ1dCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBpbiBfX3NlbmRfaXBpX21hc2tfZXgoKS4gRG8geW91
IGhhcHBlbg0KPiB0byBrbm93IHdoeSB0aGF0IG1pZ2h0IGJlPw0KDQpJbnRlcmVzdGluZyBkaXNj
cmVwYW5jeS4gIFJpZ2h0IG9mZiB0aGUgYmF0LCBJIGRvbid0IGtub3cgd2h5LiAgVGhlIGNvbW1l
bnQNCmluIGh2X21hcF9pbnRlcnJ1cHQoKSBpcyB2ZXJ5IHNwZWNpZmljIGFuZCBzb3VuZHMgbGlr
ZSBpdCBrbm93cyB3aGF0IGl0IGlzDQp0YWxraW5nIGFib3V0LiBoeXBlcnZfZmx1c2hfdGxiX290
aGVyc19leCgpIGRvZXMgaXQgbGlrZSBfX3NlbmRfaXBpX21hc2tfZXgoKSwNCmJ1dCBodl9hcmNo
X2lycV91bm1hc2soKSBkb2VzIGl0IGxpa2UgaHZfbWFwX2ludGVycnVwdCgpLCBhbmQgd2l0aCB0
aGUgc2FtZQ0KY29tbWVudC4gIFNvIHR3byB2b3RlcyBmb3IgZWFjaCB3YXkuIDotKCAgSSdsbCBy
ZXNlYXJjaCBmdXJ0aGVyLg0KDQpUaGFua3MgZm9yIHRoZSBjYXJlZnVsIHJldmlldyBhbmQgZmxh
Z2dpbmcgdGhlIG1pc3Rha2VzIQ0KDQpNaWNoYWVsDQo=

