Return-Path: <linux-arch+bounces-2987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3287B71F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 05:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7469E284DCB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 04:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3548BF0;
	Thu, 14 Mar 2024 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VQl7FF4J"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2054.outbound.protection.outlook.com [40.92.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44E7F;
	Thu, 14 Mar 2024 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390655; cv=fail; b=H2swJsM62DOIr3TjckfKyxjaGMu81vlc+IMQxZbPc8VN46Tr4BC25YMBNkjAAtk6dYE/Z0kX0iK/9Bw0cbAk3M1vHfBCRoNzj8cxuHO4fGXCa667de7pHxvsmcRiioxKqIq1FNy7jdzXKnFM3bMJOjpHi0mgsan6YoAMvoeLKeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390655; c=relaxed/simple;
	bh=z6UEWM/47L/K2WWL44unvk/Fu6RgWuiaUAWctA4a6ZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FX/GZpr/zSLi+UKxlaZN0CvCrwEifemdo8WKoShqnOa4Qf+HyRiPhpuX60bCWRLNiJ8o+ZhxulMBuDDuZ/lxkpHYXLCShJoa9gTHUFpUilRr2vz7JAR9h6GzKodquVBAnwDjxdqq+uvU+X+f5e6O8rZz3qukdMXdQbw6TvW7W74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VQl7FF4J; arc=fail smtp.client-ip=40.92.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGXzDzJrc91td3LeRkJXsbUcwQqJJu7n83ta163QNduPAe1dfsxqVjeX8fAbFUpkKVgzemipHJ1KXT4wP9DvasjETceQ0o9jjK9SEnJm4QEri7KanKxtjmNjAkHxBFe+ea4ZHecta9/OgDp0ZLJeSOtEgkcqa+5ZJ4v2oJ4dUuTqf2MSHtCY9TeIFkcJjDn6TVe4NDdv0SqE09+nApZqpjXwW8QblaPtVAPa0Vnlkxs00iXO/dQo/0N8A54gOBSmQGFJeGR7iZxMf2x1MH7cEvwMiJR8n+8gwFRWY4Z1lPbRtuDQaaOmyZbEtkZ35hNpYt4GZcsZGmFxaepRTaKDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6UEWM/47L/K2WWL44unvk/Fu6RgWuiaUAWctA4a6ZE=;
 b=GDpoQ/asttDuyM9hpIGO4GdFlzg5FfOt4NGq49YOwf9kgX+lupqySqraq/CtbSAiCVtti9p5wAbNnrtt59tkfQLE8MwrhGI2ZaDbswP5ehPI1ZK/R+X/Vt9aCUSNOijZALhjqozygOB+FjCBLzc5NWrPN1/gPURmU3x7qj8Hv3/d0cdrvKtCxE42AZr9LY+jcMpsOtoO/gAYTFyPukuaEzgCPst/B6Zr/OHIZswP4wsY/g+EUBYeoigiC2psFAZd7pRmmDPTsiWQRPFyHrvFktgG6KHm56iLeJPw1HdNZSmT7l2MK3oq0gXJaujWPE17fmVSldhsrIApMnNFxWh79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6UEWM/47L/K2WWL44unvk/Fu6RgWuiaUAWctA4a6ZE=;
 b=VQl7FF4JW/hIzkW2dRuS9DcK2+5Q36+OWpTvAnY5sVToBXcoeunvL5zMCw+CEeeX8ASl0qDxo5dK9ZxN9suraDZCLOXvccW4fk4F1cDc6OKH6RKfvTxRa8co5w7ahSo19HEFs/e68sXZn7rfacfBQIg3RSs8IWAQTqjNA08E2EWJZGdoUnKfBYzN345Xn1Huog+JS0y7pz5R1fkao/RZwT/y0n1hb7HWNHrAKgAmwn/ilJbEgOA1zY/GCVCI5jR9GIBlGkvBIMH4veRbRxgvpLzPVwkLcrNqgyIQ8Ka0nAggPAv0PR4CQ4n/1Ss3mu6qT1P1sjO08wB/MC3LVMiLrA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BN0PR02MB8255.namprd02.prod.outlook.com (2603:10b6:408:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 04:30:51 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6af6:2e8d:b2b:440c]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6af6:2e8d:b2b:440c%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:30:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHacMAZOd50lMXg2E+WGXTGLlHRJ7E2XAeAgAAJkfCAADH2gIAAEsIQ
Date: Thu, 14 Mar 2024 04:30:50 +0000
Message-ID:
 <BN7PR02MB4148FA0075DCB43F1971485BD4292@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
 <ZfI3owmQOKc4Ta_X@zx2c4.com>
 <SN6PR02MB41576DD458EB3C72F3784EDBD4292@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZfJpk94mtwzRaJzv@zx2c4.com>
In-Reply-To: <ZfJpk94mtwzRaJzv@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [snsAulPdIihcHRBXIUVXX1jZMb8R60W5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BN0PR02MB8255:EE_
x-ms-office365-filtering-correlation-id: b0fcf2b5-6b71-4ab4-725d-08dc43df8740
x-ms-exchange-slblob-mailprops:
 laRBL560oLSe/9Q5IB3Njmz1L8k5XvjVGEv+uxVCUhsRtPWglBYndiTfutZghGB7CqfhyWEM4jAApS44b8fRtC0pOkkD3/9l2nTDVj1Pa+f3TS2Y+hzg+Du1oPDkDA2l+5IoHmg1t+wQAlEt/Z4O3/twOKDCeOSd0WlwGx6M5bG6bO4vkN5LYIUGgBZ7itcGZ4xyqKyZ6jauPDn8OHN/bZM9L2ZbWwplUEptjFxQJ/324UDdjC1qnrPOFklbnaVy/tMHeGN8LrFVJkFxv6iGOW7EJ6nvWOjmuTwaeL+2rOODL9Ojnzt/5qJHB8GgYPWyYtoP5RLRivhQ+eeSpDJx10D2cPpTHSr5+vVhG6iFy7LQ6AVOvcMi5f9UXF1bde5x0CE+sV1A14puCSKiLW/ZkH/jzaMJr19TEFVmF3zB4Z+YA/EKvHm8wHTAckHA8UTLsGXVcDLGnfCo/RNsxCo/dHT5UghPp97DUNekIunpULreyxpRU5DAnTA5fRDtMHANp6SFpsl2WCZPb67NTm4Mp2vL5U0QrEv17EnVk7IyqVNA3tXSgmzXX97COdyPZi0tZpV2m0WTBdXGmSPWQDOg864D5bGUOevmTzwtAgHXre5kAMoTW2naAGpvgJ2iPlyyQBZzuX6TyhwTjmU0YZHfa7MoQnPzpdkPiOKUfwZNupXym5FcovP9+VfzeUfLBRrfI6PPJs+l6K6Jt4gg+IVv6xAzk+qqBmhqt1Kgek2AGAwHYIlFzJdxEClstU40SCfYo5qcKvkvl7/LRwlZlQu+pa9YDnfIRJHn
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VpHH5SfURVgJOLi1vChkjEhVLZCZVKW8FEtzBdsTwI5GYJiA2b42N4gUvo4hyUjQGTr0jYYsXi/Ir5CU0f1JgbGa1sq+gVDSPtZRn9SjhQpW4OSO9Ey5u3PlT/RxYiX5IDvBSSJ5BjfBexVhtNNr1mwLAp/C6uq/G0DXjm4tngPBXfcViTRsIsY929ysOy2AThw1VBgJ3pj+exhuQgVXnk6csxKJJdTRzG2EgSDc98C89Z1ZVGVIgRtFBSTChTRLDTOdfA6PZwX+nOmven5QEP2L71PouP1x8wXMvWaYIkmuhcWpkU2KqLBd0h/7diyLkwd56LHOAzjkoSar8eYKFUqhuxbEYHOweqhKn8u6WmQieIHj0MiY2fdGyRewMudaeqNS3cno+BjXdtdSPn6k4Vsh5DUIMic+Bb8li+ZYiAAGZ0KxhCNhdJqSSPUqJBEeJ1uh+YSm8T1iOhGUXNfRL4BDRTwNczWsz/OP5F5AG014oe4PIJaL4Ri1l0HSRhIAlob6vkR4abot7aRiNSjxrQYxDznIkhCysBetc5Y/8Ismt9AbmcUC9bG5RUsdDeVZ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWF6bkFhY3F2WWc1WDZEQmo4elI4MjV5TmVubWdxbGFuVlBmSzNPMTRCNEEz?=
 =?utf-8?B?em5wYy9mSGt0ZEhqUk5rbWs3V2U0V1BORTVncms0MllzVVAwdU5ONm5hdnhH?=
 =?utf-8?B?WXkxNHJTTlp5VWNYQm94VEJXV3hYVEk2M05qTDkzUVRKd2ZMSysxNXUybmdr?=
 =?utf-8?B?ek5OQWc1NUFGYko3cXc2UTlQdDJFQzBCZHIwb2RjQi96NmZIalJIOGsvSEN3?=
 =?utf-8?B?c21iQ1dCSlA3a2tlRzFiaVJoZk81d0p2NDZwRi9IMVljc3JyUVp6ektQMlM0?=
 =?utf-8?B?RkR2Um5KSkgzV1l3K3A3Y2NIV0Q2V21XU29aZ2E5Q0pmdkk3dk1mUkswWmNy?=
 =?utf-8?B?ZnpVWk9aU1FsR3VRcThnU1M0MDFKMlhxQUxMZkYySk1FQXhCcmswZG1ad3kz?=
 =?utf-8?B?dk5IWWlNWUxRNWlZSDFncWtTRHVPc1l6MnI5L1ZZMWc4WDMvUHpoejc5N3FZ?=
 =?utf-8?B?eG5NbzVjZk4zN2dTdHhVNGljaG9xSVpyQlNXVnJEWFVxdm9WN3NwelJ0ZHFB?=
 =?utf-8?B?Yi82Y2RKNWRlemxTY1J1SFJYcVZuTngxbmpXdm44QW1CUWwxR0RXTDNxNE9l?=
 =?utf-8?B?dGJEczRnMit1dzRzY2llVnc0OCswRVBFQUhXcCtMK3dNK1pHcU80ZnRIUjZP?=
 =?utf-8?B?cjlHSzVYQ0p4MW90alpabmJteDViV3ozT0dMNFNlbEFZbmtnWmdlV0dyZlUy?=
 =?utf-8?B?OXkycVdTNEltb3ErK0hkRER2cEc3eUNxcFI2SWp1eDYxMVowTFRNdDRneVpW?=
 =?utf-8?B?TnYzR0MrQTVVN3d5bWlsenlQNWlmNnRzK2k3cWc4djdGQ0lhZ1BaSi9Xc2tj?=
 =?utf-8?B?dnk4eWQwYWVnYnJrT2RvbVc5d3ZaQ0hFaGVhb21MQjJ2QVlWRzRWZGIrem9a?=
 =?utf-8?B?ejN1ZUNTWTJHa1o4cnlKaHBpWTRlRThFdHV1LytpdUtaNUV1SU9yT2NlSlpv?=
 =?utf-8?B?amVRVUl0UmFZRjlaT3QrNXBraW83bmVtUTZvZkhDTTZ3dzFhTnpTUDBNYkpu?=
 =?utf-8?B?RThtSHJzYUpwenUyR1VPdUlvZU1GNEhtaFhWRFhIdnYyRzA4NEU1MXpXYmhM?=
 =?utf-8?B?czg1aVhKdkh0RHNSRm44M0c4djc1VUNpV2dqZjd6QVZHQlVyT0ZQSmZCMm9N?=
 =?utf-8?B?QTE1bmVMQzhza0lMOHpvc0FqWGZWTHNBK1VtekJndzRDaWRWUHB3elB6YlFn?=
 =?utf-8?B?RnRlMnROdVlxV2F1SWtMWFlBNXNOR1dER3dyZGdTajY4V2FqeGZzbDFCenI4?=
 =?utf-8?B?UWhzZlZWS3R0ekI3VzJkazJ1MHBpa0M2dGRRVWlUYWd1TC9EWDJXNGZseEwx?=
 =?utf-8?B?VEx6dE15NE5Za05JbDdsRzFjTWt1eVFmV0VXT0RtSGZncTZSYm80TnUzMXVO?=
 =?utf-8?B?Y3NhL1BFRGh3RlEydFp6blJTbFAzSUplN2V2ZlQxQ3dPVnN0dFdnTmVJUWJY?=
 =?utf-8?B?cWJXNHhzRml0L2dNSkdEUDVLZE1FNUFWVU9zOE85akVSbnRJL2RTUjRCODh5?=
 =?utf-8?B?VklKM1JvUVBrT0dOOWIyOTgySnJENUFMakVXMEQvWGRIdDBBSE5zZExyU3Bk?=
 =?utf-8?B?SmpmSXkwWDlKdENYRFdSeHpOWjg0VFMrcjdJcjMxSS9BNE94TGlwVFNYOHFS?=
 =?utf-8?B?dVZuTERHKzBvcDVwOTRCWHR1VVdBSmc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fcf2b5-6b71-4ab4-725d-08dc43df8740
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 04:30:50.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8255

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IA0KPiBIaSBNaWNo
YWVsLA0KPiANCj4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgMTI6MzA6MDZBTSArMDAwMCwgTWlj
aGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gT0ssIGZhaXIgZW5vdWdoLiAgQnV0IGp1c3QgdG8gZG91
YmxlLWNoZWNrOiAgV2hlbiB0aGlzIGlzIGNhbGxlZCwNCj4gPiB0aGUgRUZJIFJORyBwcm90b2Nv
bCBoYXMgYWxyZWFkeSBpbnZva2VkIGFkZF9ib290bG9hZGVyX3JhbmRvbW5lc3MoKSwNCj4gPiAg
YW5kIHRoaXMgbGluZSBoYXMgYmVlbiBvdXRwdXQ6DQo+ID4NCj4gPiBbICAgIDAuMDAwMDAwXSBy
YW5kb206IGNybmcgaW5pdCBkb25lDQo+ID4NCj4gPiBJIGRvbid0IHNlZSBhbiBvYnZpb3VzIHBy
b2JsZW0gd2l0aCBjYWxsaW5nIGFkZF9ib290bG9hZGVyX3JhbmRvbW5lc3MoKQ0KPiA+IGFnYWlu
LCBidXQgd2FudGVkIHRvIGNvbmZpcm0uDQo+IA0KPiBZZWEsIHRoYXQncyB2ZXJ5IG11Y2ggb2th
eS4gSXQnbGwganVzdCBnZXQgYWRkZWQgYXMgZXh0cmEsIHdoaWNoIGNhbid0DQo+IGh1cnQuDQo+
IA0KPiA+IEFsc28sIGlmIHdlJ3JlIGFkZGluZyB0aGlzIEFDUEktYmFzZWQgcmFuZG9tbmVzcyBm
b3IgVk1zIHRoYXQNCj4gPiBib290IHZpYSBFRkksIHRoZW4gZm9yIGNvbnNpc3RlbmN5IHdlIHNo
b3VsZCB1c2UgaXQgb24gSHlwZXItVg0KPiA+IGJhc2VkIEFSTTY0IFZNcyBhcyB3ZWxsLg0KPiAN
Cj4gQWdyZWVkLg0KPiANCj4gPiBCb3RoIGJvdW5kcyBhcmUganVzdCBhIGNoZWNrIGZvciBib2d1
c25lc3MuICBIYXZpbmcgdGhlIGh5cGVydmlzb3INCj4gPiBwcm92aWRlIGp1c3QgNCBieXRlcyAo
Zm9yIGV4YW1wbGUpIG9mIHJhbmRvbW5lc3Mgc2VlbXMgbGlrZQ0KPiA+IHRoZXJlIG1pZ2h0IGJl
IHNvbWV0aGluZyB3ZWlyZCBnb2luZyBvbi4gIEJ1dCB3aWRlbmluZyB0aGUgYm91bmRzDQo+ID4g
aXMgZmluZSB3aXRoIG1lLiAgSSdsbCB1c2UgIjgiIGFuZCAiU1pfNEsiLg0KPiANCj4gQWhoLCBh
cyBhIHNhbml0eSBjaGVjayB0aGF0IHNlZW1zIGxpa2UgYSByZWFzb25hYmxlIGhldXJpc3RpYy4N
Cj4gDQo+ID4gPiA+ICsJZm9yIChpID0gMDsgaSA8IGxlbmd0aDsgaSsrKSB7DQo+ID4gPiA+ICsJ
CWhlYWRlci0+Y2hlY2tzdW0gKz0gcmFuZG9tZGF0YVtpXTsNCj4gPiA+ID4gKwkJcmFuZG9tZGF0
YVtpXSA9IDA7DQo+ID4gPiA+ICsJfQ0KPiA+ID4NCj4gPiA+IFNlZW1zIGRhbmdlcm91cyBmb3Ig
a2V4ZWMgYW5kIHN1Y2guIFdoYXQgaWYsIGluIGFkZGl0aW9uIHRvIHplcm9pbmcgb3V0DQo+ID4g
PiB0aGUgYWN0dWFsIGRhdGEsIHlvdSBhbHNvIHNldCBoZWFkZXItPmxlbmd0aCB0byAwLCBzbyB0
aGF0IGl0IGRvZXNuJ3QNCj4gPiA+IGdldCB1c2VkIGFnYWluIGFzIDMyIGJ5dGVzIG9mIGtub3du
IHplcm9zPw0KPiA+DQo+ID4gV2hhdCdzIHlvdXIgdGFrZSBvbiB0aGUgd2hvbGUgaWRlYSBvZiB6
ZXJvJ2luZyB0aGUgcmFuZG9tIGRhdGE/ICAgSQ0KPiA+IHNhdyB0aGUgRUZJIFJORyBwcm90b2Nv
bCBoYW5kbGluZyB3YXMgZG9pbmcgc29tZXRoaW5nIHJvdWdobHkNCj4gPiBzaW1pbGlhci4gIEJ1
dCB5ZXMsIGdvb2QgcG9pbnQgYWJvdXQga2V4ZWMoKS4gIFplcm9pbmcgdGhlIGhlYWRlci0+bGVu
Z3RoDQo+ID4gd291bGQgbWFrZSBzZW5zZSB0byBwcmV2ZW50IGFueSByZS11c2UuDQo+IA0KPiBZ
ZXMsIEkgdGhpbmsgemVyb2luZyBpdCBvdXQgaXMgdGhlIHJpZ2h0IGNhbGwuIEkgd29uZGVyLCB0
aG91Z2gsIHdoYXQncw0KPiB0aGUgZGVhbCB3aXRoIHRoZSBjaGVja3N1bSBhZGp1c3RtZW50PyBT
aG91bGQgd2UgYmUgY2hlY2tpbmcgdGhlDQo+IGNoZWNrc3VtIGJlZm9yZSB1c2luZyB0aGUgcmFu
ZG9tIGRhdGE/IEFuZCBkbyB3ZSBoYXZlIHRvIGFkanVzdCBpdCBsaWtlDQo+IHRoYXQgYXQgdGhl
IGVuZCwgb3IgY2FuIHdlIGp1c3QgemVybyBvdXQgdGhlIGVudGlyZSBoZWFkZXIgKGluY2x1ZGlu
Zw0KPiBsZW5ndGgpIGFsb25nIHdpdGggdGhlIHJhbmRvbSBkYXRhPw0KPiANCg0KQnkgZGVmYXVs
dCwgTGludXggZG9lc24ndCB2ZXJpZnkgY2hlY2tzdW1zIHdoZW4gYWNjZXNzaW5nIEFDUEkgdGFi
bGVzDQpkdXJpbmcgZWFybHkgYm9vdCwgdGhvdWdoIHlvdSBjYW4gYWRkICJhY3BpX2ZvcmNlX3Rh
YmxlX3ZlcmlmaWNhdGlvbiINCnRvIHRoZSBrZXJuZWwgYm9vdCBsaW5lLiAgVGhlIGRlZmF1bHQg
aXMgc2hvd24gaW4gZG1lc2cgbGlrZSB0aGlzOg0KDQpbICAgIDAuMDA0NDE5XSBBQ1BJOiBFYXJs
eSB0YWJsZSBjaGVja3N1bSB2ZXJpZmljYXRpb24gZGlzYWJsZWQNCg0KVGhlIGNoZWNrc3VtIG9m
IGFsbCB0YWJsZXMgaXMgY2hlY2tlZCBzbGlnaHRseSBsYXRlciBpbiBib290LCB0aG91Z2gNCml0
J3MgYWZ0ZXIgbXkgZW50cm9weSBjb2RlIGhhcyBydW4uICBXaXRob3V0IHRoZSBjaGVja3N1bSBm
aXh1cCwNCnRoaXMgZXJyb3IgaXMgb3V0cHV0Og0KDQpbICAgIDAuMDUzNzUyXSBBQ1BJIEJJT1Mg
V2FybmluZyAoYnVnKTogSW5jb3JyZWN0IGNoZWNrc3VtIGluIHRhYmxlDQoJCVtPRU0wXSAtIDB4
OEIsIHNob3VsZCBiZSAweDgyICgyMDIzMDYyOC91dGNrc3VtLTU4KQ0KDQpBdCB0aGlzIHBvaW50
LCB0aGUgY2hlY2tzdW0gZXJyb3IgZG9lc24ndCByZWFsbHkgbWF0dGVyLCBidXQgSQ0KZG9uJ3Qg
d2FudCB0aGUgd2FybmluZyBzaG93aW5nIHVwLiAgSSBuZWVkIHRvIGV4cGVyaW1lbnQgYQ0KYml0
LCBidXQgcHJvYmFibHkgdGhlIGJlc3QgYXBwcm9hY2ggaXMgdG8gc2V0IHRoZSBkYXRhIGxlbmd0
aCB0bw0KemVybyAoYW5kIGFkanVzdCB0aGUgY2hlY2tzdW0pIHdoaWxlIGxlYXZpbmcgdGhlIHJl
c3Qgb2YgdGhlIEFDUEkNCnRhYmxlIGhlYWRlciBpbnRhY3QuICBJdCB3aWxsIGJlIG1vcmUgZGlm
ZmljdWx0IHRvIG1ha2UgdGhlIHRhYmxlDQpkaXNhcHBlYXIgZW50aXJlbHkgYXMgaXQgYXBwZWFy
cyBpbiBhIGdsb2JhbCBsaXN0IG9mIEFDUEkgdGFibGVzLg0KDQpNaWNoYWVsDQo=

