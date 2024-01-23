Return-Path: <linux-arch+bounces-1440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF688838B82
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 11:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9C289C51
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875F5A10B;
	Tue, 23 Jan 2024 10:16:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAB5A110
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004989; cv=none; b=E2Y/ObZihcfe+E636m6zuAwYloMa9qgbg5Ytcu7VHB+BMcyruYNibucg7Mvbb7azU4qJeJ4j5qRppKw6PS5M9OgIuMz8TGTN5oPVfI1mc52wdZz1bYU+oQU/4+zvFU7qwbbh7T7fz6P7CxjmK7j6Y0B54f9jfKjq/ZoTbEWzA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004989; c=relaxed/simple;
	bh=ZJzzt+kCw+JOY/lQZt/D5cRgMP0CjOuRiNu9AtaiFBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HYpen2iJ2bLZsVIWwxX+WgbxFvtn3q+Pu36JQiK1PizMlgUXf58LLTCu5HnE4OHw+7CH3cb2A7g+2TlSEPwb2PZloNoVwOS57SrC7o8FoT7rYBQauawhUb7TatHIMElDkYv31K4N4nSWtntsVgeyQQ4YeOvwzNGFURjESR0vE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-76-TSOlSA3yNlmz_Bo-aU5ewQ-1; Tue, 23 Jan 2024 10:16:23 +0000
X-MC-Unique: TSOlSA3yNlmz_Bo-aU5ewQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 10:16:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 23 Jan 2024 10:16:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor@kernel.org>, "samuel.holland@sifive.com"
	<samuel.holland@sifive.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>,
	Evan Green <evan@rivosinc.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Topic: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Index: AQHaTVGn8AUolzpWZEe7KQadoytUPLDmCvsQgAAHpwCAAEjwsIAAOnOOgACYElA=
Date: Tue, 23 Jan 2024 10:16:06 +0000
Message-ID: <86411bbab15c42b8819aeb923fe42644@AcuMS.aculab.com>
References: <be959a4bb660466faba5ade7976485c8@AcuMS.aculab.com>
 <mhng-b5f26a34-7632-4423-9f07-3224170bae9f@palmer-ri-x1c9>
 <Za8AXnKCm4cPyVbp@ghost> <e548f697-650e-4333-9f39-19a472b7d90a@roeck-us.net>
In-Reply-To: <e548f697-650e-4333-9f39-19a472b7d90a@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjQgMDE6MDYNCi4uLg0K
PiA+PiAgICAgKyNkZWZpbmUgU1VQUE9SVEVEX0FMSUdOTUVOVCAoMSA8PCBORVRfSVBfQUxJR04p
DQo+ID4+ICAgICAgLyogVmFsdWVzIGZvciBhIGxpdHRsZSBlbmRpYW4gQ1BVLiBCeXRlIHN3YXAg
ZWFjaCBoYWxmIG9uIGJpZyBlbmRpYW4gQ1BVLiAqLw0KPiA+PiAgICAgIHN0YXRpYyBjb25zdCB1
MzIgcmFuZG9tX2luaXRfc3VtID0gMHgyODQ3YWFiOw0KPiA+PiAgICAgQEAgLTQ4Niw3ICs0ODgs
NyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NzdW1fZml4ZWRfcmFuZG9tX2lucHV0cyhzdHJ1Y3Qga3Vu
aXQgKnRlc3QpDQo+ID4+ICAgICAgCV9fc3VtMTYgcmVzdWx0LCBleHBlYzsNCj4gPj4gICAgICAJ
YXNzZXJ0X3NldHVwX2NvcnJlY3QodGVzdCk7DQo+ID4+ICAgICAtCWZvciAoYWxpZ24gPSAwOyBh
bGlnbiA8IFRFU1RfQlVGTEVOOyArK2FsaWduKSB7DQo+ID4+ICAgICArCWZvciAoYWxpZ24gPSAw
OyBhbGlnbiA8IFRFU1RfQlVGTEVOOyBhbGlnbiArPSBTVVBQT1JURURfQUxJR05NRU5UKSB7DQou
Li4NCg0KVGhhdCBpcyBhbGwgd3JvbmcuDQpORVRfSVBfQUxJR04gaXMgdGhlIG9mZnNldCBmb3Ig
dGhlIGJhc2Ugb2YgZXRoZXJuZXQgZnJhbWVzLg0KSWYgemVybyB0aGUgSVAgaGVhZGVyIHdpbGwg
KHVzdWFsbHkpIGJlIG1pc2FsaWduZWQuDQpJZiB0d28gdGhlIG1hYyBhZGRyZXNzZXMgYXJlIG1p
c2FsaWduZWQgaW4gb3JkZXIgdG8gYWxpZ24NCnRoZSBJUCBoZWFkZXIgKDYrNisyIGJ5dGVzIGlu
KS4NCkkgZG9uJ3QgdGhpbmsgYW55IG90aGVyIHZhbHVlcyBhcmUgYWN0dWFsbHkgdmFsaWQsIGJ1
dA0KdGhlcmUgaXMgYWx3YXlzIHRoYXQgcG9zc2liaWxpdHkuDQoNClNvIHRoZSBkZWZpbml0aW9u
IHNob3VsZCByZWFsbHkgYmU6DQojZGVmaW5lIFNVUFBPUlRFRF9BTElHTk1FTlQgKE5FVF9JUF9B
TElHTiA/IDQgOiAxKQ0KDQooV2hpY2ggbWlnaHQgaGFwcGVuIHRvIGJlIHRoZSBzYW1lIHZhbHVl
cyA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


