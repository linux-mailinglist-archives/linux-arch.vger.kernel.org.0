Return-Path: <linux-arch+bounces-1431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BF4837591
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3698B22C1A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18536482EF;
	Mon, 22 Jan 2024 21:42:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1647A47
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959745; cv=none; b=MwtTr5fZW4lWGGzzsgpSA3xO8Bihk/2+BJTQSHDjBB5RfSg3A3rGpnJIOpu3DbDUOsCjr4WsGDv11ZYiwYqTx9LHVlLTIOtBFeP/YGJwsP9LsrgmcXzvQdvgnuUICrf5kcYCIOm4hu66MEZ3v54WhFacAi7W9Le6UEP6tMn7Ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959745; c=relaxed/simple;
	bh=io+7IaJFn/feWesqaRgk9TY52nteThiIZlX7mv4DhKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=X5nbWwkW6QK9k/O9pxAx7cT9ewMpfd/xS/VLKFCEChqnxykj2LT4x8kgmo2hGIOtr817w6N69J7Ib5OoVBzlE0gjf4V/6IzcRLtWdyS6saAszg6U4eQv9atfsQiPAZZdOk7HU1pwJP2gj++Q05IUAVeexpX0j66O64pPtOYIOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-d2RyxRAbOJurcsKymIa9DQ-1; Mon, 22 Jan 2024 21:42:17 +0000
X-MC-Unique: d2RyxRAbOJurcsKymIa9DQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 21:41:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 Jan 2024 21:41:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>, Xiao Wang
	<xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>, Guo Ren
	<guoren@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Topic: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Thread-Index: AQHaTVGn8AUolzpWZEe7KQadoytUPLDmCvsQgAAHpwCAAEjwsA==
Date: Mon, 22 Jan 2024 21:41:48 +0000
Message-ID: <be959a4bb660466faba5ade7976485c8@AcuMS.aculab.com>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
 <20240108-optimize_checksum-v15-5-1c50de5f2167@rivosinc.com>
 <2c8e98b6-336e-4bc7-81ba-5a4d35ac868a@roeck-us.net>
 <6b0dc20f392c488a9080651a2a2cd4bd@AcuMS.aculab.com>
 <1dd253a5-9fe9-4d0a-b0cd-3775f089ca0c@roeck-us.net>
In-Reply-To: <1dd253a5-9fe9-4d0a-b0cd-3775f089ca0c@roeck-us.net>
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

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAyMiBKYW51YXJ5IDIwMjQgMTc6MTYNCj4gDQo+
IE9uIDEvMjIvMjQgMDg6NTIsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBHdWVudGVy
IFJvZWNrDQo+ID4+IFNlbnQ6IDIyIEphbnVhcnkgMjAyNCAxNjo0MA0KPiA+Pg0KPiA+PiBIaSwN
Cj4gPj4NCj4gPj4gT24gTW9uLCBKYW4gMDgsIDIwMjQgYXQgMDM6NTc6MDZQTSAtMDgwMCwgQ2hh
cmxpZSBKZW5raW5zIHdyb3RlOg0KPiA+Pj4gU3VwcGxlbWVudCBleGlzdGluZyBjaGVja3N1bSB0
ZXN0cyB3aXRoIHRlc3RzIGZvciBjc3VtX2lwdjZfbWFnaWMgYW5kDQo+ID4+PiBpcF9mYXN0X2Nz
dW0uDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGll
QHJpdm9zaW5jLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pg0KPiA+PiBXaXRoIHRoaXMgcGF0Y2ggaW4g
dGhlIHRyZWUsIHRoZSBhcm06bXBzMi1hbjM4NSBxZW11IGVtdWxhdGlvbiBnZXRzIGEgYmFkIGhp
Y2N1cC4NCj4gPj4NCj4gPj4gWyAgICAxLjgzOTU1Nl0gVW5oYW5kbGVkIGV4Y2VwdGlvbjogSVBT
UiA9IDAwMDAwMDA2IExSID0gZmZmZmZmZjENCj4gPj4gWyAgICAxLjgzOTgwNF0gQ1BVOiAwIFBJ
RDogMTY0IENvbW06IGt1bml0X3RyeV9jYXRjaCBUYWludGVkOiBHICAgICAgICAgICAgICAgICBO
IDYuOC4wLXJjMSAjMQ0KPiA+PiBbICAgIDEuODM5OTQ4XSBIYXJkd2FyZSBuYW1lOiBHZW5lcmlj
IERUIGJhc2VkIHN5c3RlbQ0KPiA+PiBbICAgIDEuODQwMDYyXSBQQyBpcyBhdCBfX2NzdW1faXB2
Nl9tYWdpYysweDgvMHhiNA0KPiA+PiBbICAgIDEuODQwNDA4XSBMUiBpcyBhdCB0ZXN0X2NzdW1f
aXB2Nl9tYWdpYysweDNkLzB4YTQNCj4gPj4gWyAgICAxLjg0MDQ5M10gcGMgOiBbPDIxMjEyZjM0
Pl0gICAgbHIgOiBbPDIxMTE3ZmQ1Pl0gICAgcHNyOiAwMTAwMDIwYg0KPiA+PiBbICAgIDEuODQw
NTg2XSBzcCA6IDIxODBiZWJjICBpcCA6IDQ2YzdmMGQyICBmcCA6IDIxMjc1YjM4DQo+ID4+IFsg
ICAgMS44NDA2NjRdIHIxMDogMjEyNzZiNjAgIHI5IDogMjEyNzViMjggIHI4IDogMjE0NjVjZmMN
Cj4gPj4gWyAgICAxLjg0MDc1MV0gcjcgOiAwMDAwMzA4NSAgcjYgOiAyMTI3NWI0ZSAgcjUgOiAy
MTM4NzAyYyAgcjQgOiAwMDAwMDAwMQ0KPiA+PiBbICAgIDEuODQwODQ3XSByMyA6IDJjMDAwMDAw
ICByMiA6IDFhYzdmMGQyICByMSA6IDIxMjc1YjM5ICByMCA6IDIxMjc1YjI5DQo+ID4+IFsgICAg
MS44NDA5NDJdIHhQU1I6IDAxMDAwMjBiDQo+ID4+DQo+ID4+IFRoaXMgdHJhbnNsYXRlcyB0bzoN
Cj4gPj4NCj4gPj4gUEMgaXMgYXQgX19jc3VtX2lwdjZfbWFnaWMgKGFyY2gvYXJtL2xpYi9jc3Vt
aXB2Ni5TOjE1KQ0KPiA+PiBMUiBpcyBhdCB0ZXN0X2NzdW1faXB2Nl9tYWdpYyAoLi9hcmNoL2Fy
bS9pbmNsdWRlL2FzbS9jaGVja3N1bS5oOjYwDQo+ID4+IC4vYXJjaC9hcm0vaW5jbHVkZS9hc20v
Y2hlY2tzdW0uaDoxNjMgbGliL2NoZWNrc3VtX2t1bml0LmM6NjE3KQ0KPiA+Pg0KPiA+PiBPYnZp
b3VzbHkgSSBjYW4gbm90IHNheSBpZiB0aGlzIGlzIGEgcHJvYmxlbSB3aXRoIHFlbXUgb3IgYSBw
cm9ibGVtIHdpdGgNCj4gPj4gdGhlIExpbnV4IGtlcm5lbC4gR2l2ZW4gdGhhdCwgYW5kIHRoZSBw
cmVzdW1hYmx5IGxvdyBpbnRlcmVzdCBpbg0KPiA+PiBydW5uaW5nIG1wczItYW4zODUgd2l0aCBM
aW51eCwgSSdsbCBzaW1wbHkgZGlzYWJsZSB0aGF0IHRlc3QuIEp1c3QgdGFrZQ0KPiA+PiBpdCBh
cyBhIGhlYWRzIHVwIHRoYXQgdGhlcmUgX21heV8gYmUgYSBwcm9ibGVtIHdpdGggdGhpcyBvbiBh
cm0NCj4gPj4gbm9tbXUgc3lzdGVtcy4NCj4gPg0KPiA+IENhbiB5b3UgZHJvcCBpbiBhIGRpc2Fz
c2VtYmx5IG9mIF9fY3N1bV9pcHY2X21hZ2ljID8NCj4gPiBBY3R1YWxseSBJIHRoaW5rIGl0IGlz
Og0KPiANCj4gSXQgaXMsIGFzIHBlciB0aGUgUEMgcG9pbnRlciBhYm92ZS4gSSBkb24ndCBrbm93
IGFueXRoaW5nIGFib3V0IGFybSBhc3NlbWJsZXIsDQo+IG11Y2ggbGVzcyBhYm91dCBpdHMgYmVo
YXZpb3Igd2l0aCBUSFVNQiBjb2RlLg0KDQpEb2Vzbid0IGxvb2sgbGlrZSB0aHVtYiB0byBtZSAo
b2Zmc2V0IDggaXMgdHdvIDQtYnl0ZSBpbnN0cnVjdGlvbnMpIGFuZA0KdGhlIGNvZGUgSSBmb3Vu
ZCBsb29rcyBsaWtlIGFybSB0byBtZS4NCihJIGhhdmVuJ3Qgd3JpdHRlbiBhbnkgYXJtIGFzbSBz
aW5jZSBiZWZvcmUgdGhleSBpbnZlbnRlZCB0aHVtYiEpDQoNCj4gPiBFTlRSWShfX2NzdW1faXB2
Nl9tYWdpYykNCj4gPiAJCXN0cglsciwgW3NwLCAjLTRdIQ0KPiA+IAkJYWRkcwlpcCwgcjIsIHIz
DQo+ID4gCQlsZG1pYQlyMSwge3IxIC0gcjMsIGxyfQ0KPiA+DQo+ID4gU28gdGhlIGZhdWx0IGlz
IChwcm9iYWJseSkgYSBtaXNhbGlnbmVkIGxkbWlhID8NCj4gPiBBcmUgdGhleSBldmVyIHN1cHBv
cnRlZD8NCj4gPg0KPiANCj4gR29vZCBxdWVzdGlvbi4gTXkgcHJpbWFyeSBndWVzcyBpcyB0aGF0
IHRoaXMgbmV2ZXIgd29ya2VkLiBBcyBJIHNhaWQsDQo+IHRoaXMgd2FzIGp1c3QgaW50ZW5kZWQg
dG8gYmUgaW5mb3JtYXRpb25hbCwgKHByb2JhYmx5KSBubyByZWFzb24gdG8gYm90aGVyLg0KPiAN
Cj4gT2YgY291cnNlIG9uZSBtaWdodCBhc2sgaWYgaXQgbWFrZXMgc2Vuc2UgdG8gZXZlbiBrZWVw
IHRoZSBhcm0gbm9tbXUgY29kZQ0KPiBpbiB0aGUga2VybmVsLCBidXQgdGhhdCBpcyBvZiBjb3Vy
c2UgYSBkaWZmZXJlbnQgcXVlc3Rpb24uIEkgZG8gd29uZGVyIHRob3VnaA0KPiBpZiBhbnlvbmUg
YnV0IG1lIGlzIHJ1bm5pbmcgaXQuDQoNCklmIGl0IGlzIGFuIGFsaWdubWVudCBmYXVsdCBpdCBp
c24ndCBhICdub21tdScgYnVnLg0KDQpBbmQgdHJhZGl0aW9uYWxseSBhcm0gZGlkbid0IHN1cHBv
cnQgbWlzYWxpZ25lZCB0cmFuc2ZlcnMgKHdlbGwgbm90DQppbiBhbnl3YXkgYW55IG90aGVyIGNw
dSBkaWQhKS4NCkl0IG1pZ2h0IGJlIHRoYXQgdGhlIGtlcm5lbCBhc3N1bWVzIHRoYXQgYWxsIGV0
aGVybmV0IHBhY2tldHMgYXJlDQphbGlnbmVkLCBidXQgdGhlIHRlc3Qgc3VpdGUgaXNuJ3QgYWxp
Z25pbmcgdGhlIGJ1ZmZlci4NCldoaWNoIHdvdWxkIG1ha2UgaXQgYSB0ZXN0IHN1aXRlIGJ1Zy4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


