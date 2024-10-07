Return-Path: <linux-arch+bounces-7768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639F99309D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED2AB2675C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B961D7E52;
	Mon,  7 Oct 2024 15:06:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8071D7E58
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313575; cv=none; b=nzS+kBDbyZFagJC3wVVxWWGADi+90xTe1fGEudhHMhxvKWpyrzGDb2hEd0IKNMtDPB81Tr8IrEuLTmrDDrLxh/46805jwM4yV0LVnzUI06Y3nXAP1bepnfTWaZtBPLOFgvuDT32ZaAhBnch0APmzNi0kYqg+naCh73h5vaH0xfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313575; c=relaxed/simple;
	bh=qOFVxykhSVlIVsq2bjFdLZUF6bYo6t9t4bBeCOflGPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DISg4FrqLnNN/aadBm67lSUtRjMeKNAVvm2/wdNfOcBKOHmrNHYk3hg4OTUsTAIM1PBIJef6k3r0JY7t2v9PPxd+6JWN0XkcRL5P84YFFzxeeo+IhsEXDCc/Uo5NuPc91RqaR8zbzM7VTKD47KkaezXDfv0x9eGOQ6sMglL71io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-aUrwyiLbNiapukeT1FqU2A-1; Mon, 07 Oct 2024 16:06:10 +0100
X-MC-Unique: aUrwyiLbNiapukeT1FqU2A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Oct
 2024 16:05:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Oct 2024 16:05:13 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, "Marius.Cristea@microchip.com"
	<Marius.Cristea@microchip.com>
CC: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Topic: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Index: AQHbELg4aDeytMgGcUifSLsY4O8Q9LJvRwDwgAwmSNmAAAVXEA==
Date: Mon, 7 Oct 2024 15:05:13 +0000
Message-ID: <a55a7abb5fc745c8bb4bc081356ed7eb@AcuMS.aculab.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
 <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
 <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
In-Reply-To: <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMjQgMTU6NDUNCj4gT24g
TW9uLCBPY3QgNywgMjAyNCwgYXQgMTQ6NDAsIE1hcml1cy5DcmlzdGVhQG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+ID4gT24gU3VuLCAyMDI0LTA5LTI5IGF0IDIxOjE2ICswMDAwLCBEYXZpZCBMYWln
aHQgd3JvdGU6DQo+ID4+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gZGF2aWQubGFp
Z2h0QGFjdWxhYi5jb20uIExlYXJuIHdoeQ0KPiA+PiB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gPj4NCj4gPj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UNCj4gPj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4+DQo+ID4+IEZyb206
IG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20NCj4gPj4gPiBTZW50OiAyNyBTZXB0ZW1iZXIg
MjAyNCAwOTozNg0KPiA+PiA+DQo+ID4+ID4gVGhlIFBBQzE5NFgsIElJTyBkcml2ZXIsIGlzIHVz
aW5nIHNvbWUgdW5hbGlnbmVkIDU2IGJpdCByZWdpc3RlcnMuDQo+ID4+ID4gUHJvdmlkZSBzb21l
IGhlbHBlciBhY2Nlc3NvcnMgaW4gcHJlcGFyYXRpb24gZm9yIHRoZSBuZXcgZHJpdmVyLg0KPiA+
Pg0KPiA+PiBTb21lb25lIHBsZWFzZSBzaG9vdCB0aGUgaGFyZHdhcmUgZW5naW5lZXIgOy0pDQo+
ID4+DQo+ID4+IERvIHNlcGFyYXRlIHVuYWxpZ25lZCBhY2Nlc3Mgb2YgdGhlIGZpcnN0IDQgYnl0
ZXMgYW5kIGxhc3QgZm91cg0KPiA+PiBieXRlcy4NCj4gPj4gSXQgY2FuJ3QgbWF0dGVyIGlmIHRo
ZSBtaWRkbGUgYnl0ZSBpcyBhY2Nlc3NlZCB0d2ljZS4NCj4gPj4NCj4gPj4gT3IsIGZvciByZWFk
cyByZWFkIDggYnl0ZXMgZnJvbSAncCAmIH4xdWwnIGFuZCB0aGVuIGZpeHVwDQo+ID4+IHRoZSB2
YWx1ZS4NCj4gPj4NCj4gPg0KPiA+IERvIHlvdSByZWNvbW1lbmQgbWUgdG8gZHJvcCB0aGlzIHBh
dGNoPw0KPiA+DQo+ID4gSSBrbm93IHRoYXQgdGhlcmUgYXJlIHNvbWUgIndvcmthcm91bmRzIiwg
YnV0IHRob3NlIGRpZG4ndCAibG9va3MiDQo+ID4gbmljZS4gSSB3YXMgdXNpbmcgdGhhdCBmdW5j
dGlvbiBsb2NhbGx5IGFuZCBJIGdvdCBhIHN1Z2dlc3Rpb24gZnJvbSB0aGUNCj4gPiBJSU8gc3Vi
c3lzdGVtIG1haW50YWluZXIgdG8gbW92ZSBpdCBpbnRvIHRoZSBrZXJuZWwgaW4gb3JkZXIgZm9y
IG90aGVycw0KPiA+IHRvIHVzZWQgaXQuDQo+IA0KPiBNeSBmZWVsaW5nIGlzIHRoYXQgdGhpcyBp
cyB0b28gc3BlY2lmaWMgdG8gb25lIGRyaXZlciwgSSBkb24ndA0KPiBleHBlY3QgaXQgdG8gYmUg
c2hhcmVkIG11Y2guIEkgYWxzbyBzdXNwZWN0IHRoYXQgbW9zdCA1Ni1iaXQNCj4gaW50ZWdlcnMg
aW4gZGF0YSBzdHJ1Y3R1cmVzIGFyZSBhY3R1YWxseSBhbHdheXMgcGFydCBvZiBhIG5hdHVyYWxs
eQ0KPiBhbGlnbmVkIDY0LWJpdCB3b3JkLiBJZiB0aGF0IGlzIHRoZSBjYXNlIGhlcmUsIHRoZSBk
cml2ZXIgY2FuDQo+IHByb2JhYmx5IGJldHRlciBhY2Nlc3MgaXQgYXMgYSBub3JtYWwgNjQtYml0
IG51bWJlciBhbmQgbWFzaw0KPiBvdXQgdGhlIHVwcGVyIDU2IGJpdHMgdXNpbmcgdGhlIGluY2x1
ZGUvbGludXgvYml0ZmllbGQuaCBoZWxwZXJzLg0KDQpPciBnZXQgdGhlIGNvbXBpbGVyIHRvIGRv
IGl0IGZvciB5b3UuDQpUaGlzIERUUlQgaHR0cHM6Ly93d3cuZ29kYm9sdC5vcmcvei9HTWRlUGpZ
TVk6DQoNCnN0cnVjdCBmb28gew0KICAgIHVuc2lnbmVkIGxvbmcgYTsNCiAgICB1bnNpZ25lZCBj
aGFyIGI7DQogICAgdW5zaWduZWQgbG9uZyBjOjU2IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOw0K
ICAgIHVuc2lnbmVkIGxvbmcgZDsNCn07DQoNCkFsdGhvdWdoIHlvdSdsbCBuZWVkICNkZWZpbmUg
aHRvYmU1Nih4KSAoaHRvYmU2NCh4KSA+PiA4KSBvbiBMRS4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


