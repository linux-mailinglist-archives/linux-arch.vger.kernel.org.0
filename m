Return-Path: <linux-arch+bounces-1166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8881C795
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 10:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E12F1F24DA0
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E22FBEC;
	Fri, 22 Dec 2023 09:49:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90BFBE2
	for <linux-arch@vger.kernel.org>; Fri, 22 Dec 2023 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-xxkVxGO6MsmbccshvsSNZw-1; Fri, 22 Dec 2023 09:49:05 +0000
X-MC-Unique: xxkVxGO6MsmbccshvsSNZw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 09:48:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 09:48:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Masahiro Yamada' <masahiroy@kernel.org>, "deller@kernel.org"
	<deller@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: RE: [PATCH 0/4] Section alignment issues?
Thread-Topic: [PATCH 0/4] Section alignment issues?
Thread-Index: AQHaNCSyd9J1TYqeG0+E9FwMBBtJGrC1Dx7A
Date: Fri, 22 Dec 2023 09:48:50 +0000
Message-ID: <364b3128f40d44939586bdc8e8ae7c9d@AcuMS.aculab.com>
References: <20231122221814.139916-1-deller@kernel.org>
 <CAK7LNAQZO0g-B7UUEvdJWh3FhdhmWaaSaJyyEUoVoSYG0j8v-Q@mail.gmail.com>
 <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
In-Reply-To: <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
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

Li4uDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2luaXQuaCBiL2luY2x1ZGUvbGludXgv
aW5pdC5oDQo+IGluZGV4IDNmYTNmNjI0MTM1MC4uNjUwMzExZTRiMjE1IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2luaXQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2luaXQuaA0KPiBA
QCAtMjY0LDYgKzI2NCw3IEBAIGV4dGVybiBzdHJ1Y3QgbW9kdWxlIF9fdGhpc19tb2R1bGU7DQo+
ICAjZGVmaW5lIF9fX19kZWZpbmVfaW5pdGNhbGwoZm4sIF9fc3R1YiwgX19uYW1lLCBfX3NlYykg
ICAgICAgICBcDQo+ICAgICAgICAgX19kZWZpbmVfaW5pdGNhbGxfc3R1YihfX3N0dWIsIGZuKSAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgYXNtKCIuc2VjdGlvbiAgIFwiIiBfX3Nl
YyAiXCIsIFwiYVwiICAgICAgICAgICAgXG4iICAgICBcDQo+ICsgICAgICAgICAgICIuYmFsaWdu
IDQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG4iICAgICBcDQo+ICAgICAgICAg
ICAgIF9fc3RyaW5naWZ5KF9fbmFtZSkgIjogICAgICAgICAgICAgICAgICAgICAgXG4iICAgICBc
DQo+ICAgICAgICAgICAgICIubG9uZyAgICAgICIgX19zdHJpbmdpZnkoX19zdHViKSAiIC0gLiAg
ICAgXG4iICAgICBcDQo+ICAgICAgICAgICAgICIucHJldmlvdXMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXG4iKTsgICBcDQo+IA0KPiANCj4gDQo+IFRoZW4sICJ0aGlzIHNlY3Rp
b24gcmVxdWlyZXMgYXQgbGVhc3QgNCBieXRlIGFsaWdubWVudCINCj4gaXMgcmVjb3JkZWQgaW4g
dGhlIHNoX2FkZHJhbGlnbiBmaWVsZC4NCg0KUGVyaGFwcyBvbmUgb2YgdGhlIGhlYWRlcnMgc2hv
dWxkIGNvbnRhaW4gKHNvbWV0aGluZyBsaWtlKToNCiNpZmRlZiBDT05GSUdfNjQNCiNkZWZpbmUg
QkFMSUdOX1BUUiAiLmJhbGlnbiA4XG4iDQojZWxzZQ0KI2RlZmluZSBCQUxJR05fUFRSICIuYmFs
aWduIDRcbiINCiNlbmRpZg0KDQp0byBtYWtlIGl0IGFsbCBlYXNpZXIgKGFsdGhvdWdoIHRoYXQg
ZXhhbXBsZSBkb2Vzbid0IG5lZWQgaXQpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


