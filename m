Return-Path: <linux-arch+bounces-2698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63E86115E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B3E1F25A6B
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E37C0B7;
	Fri, 23 Feb 2024 12:19:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF07B3D1
	for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690772; cv=none; b=udZEHkJxyo9tncNJc4vEnm238tliCZjYI4lj9X2C97g4hMnncU0rAx39v+pOasyKD/Ng21rOAU+0dcflQNPmpR4u83q5QAYWVeaB+4oZbthDAGCYN0oKqJO/mVPC//IdCFk+mRS8+r6/AMwopQ4TGWFyxEm704YPnK6rzaOU0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690772; c=relaxed/simple;
	bh=+h7QB2mSCliHIE6dgXnLeLYBYOVXTQ3fqQSLNKViWTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HzLC3EMVpZ5p/P2JPG4FAMFoh6+cw5wy5vdvcBwPP6/i2qJwFo9DkH+PXGxros2ZXRNyEege21WpiYWNn4ss3ZJ4asfx1kGE5KkXYMEey0c7Cx8xCkJT0waW+4rdqmz1qdQqmIKrWyGNNOn4L/OanmMSqCVukpoKc5B4zkAmerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-egogS_GzMva3HTTIelYnIA-1; Fri, 23 Feb 2024 12:19:26 +0000
X-MC-Unique: egogS_GzMva3HTTIelYnIA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb
 2024 12:19:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 23 Feb 2024 12:19:24 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Niklas Schnelle' <schnelle@linux.ibm.com>, 'Jason Gunthorpe'
	<jgg@nvidia.com>
CC: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt
	<justinstitt@google.com>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Ingo Molnar
	<mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Yisen Zhuang
	<yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Leon Romanovsky <leonro@mellanox.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Topic: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Index: AQHaZGPOOI9/P4jwQk+N+/Phnt6M8bEW6XcggAAM2oCAAKwjYIAALlsAgAACWrA=
Date: Fri, 23 Feb 2024 12:19:24 +0000
Message-ID: <d4150af74d7c45b79c770cd1c5d8eed7@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
	 <20240222223617.GC13330@nvidia.com>
	 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
In-Reply-To: <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
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

RnJvbTogTmlrbGFzIFNjaG5lbGxlDQo+IFNlbnQ6IDIzIEZlYnJ1YXJ5IDIwMjQgMTE6MzgNCi4u
Lg0KPiA+IEFsdGhvdWdoIEkgZG91YnQgdGhhdCBnZW5lcmF0aW5nIGxvbmcgVExQIGZyb20gYnl0
ZSB3cml0ZXMgaXMNCj4gPiByZWFsbHkgbmVjZXNzYXJ5Lg0KPiANCj4gSSBtaWdodCBoYXZlIGdv
dHRlbiBjb25mdXNlZCBidXQgSSB0aGluayB0aGVzZSBhcmUgbm90IGJ5dGUgd3JpdGVzLg0KPiBS
ZW1lbWJlciB0aGF0IHRoZSBjb3VudCBpcyBpbiB0ZXJtcyBvZiB0aGUgbnVtYmVyIG9mIGJpdHMg
c2l6ZWQNCj4gcXVhbnRpdGllcyB0byBjb3B5IHNvICJjb3VudCA9PSAxIiBpcyA0LzggYnl0ZXMg
aGVyZS4NCg0KU29tZXRoaW5nIG1hZGUgbWUgdGhpbmsgeW91IHdlcmUgZ2VuZXJhdGluZyBhIGJ5
dGUgdmVyc2lvbg0KYXMgd2VsbCBhcyB0aGUgMzIgYW5kIDY0IGJpdCBvbmVzLg0KDQouLi4NCj4g
PiBXaGlsZSB3cml0ZS1jb21iaW5pbmcgdG8gZ2VuZXJhdGUgbG9uZyBUTFAgaXMgcHJvYmFibHkg
bW9zdGx5DQo+ID4gc2FmZSBmb3IgUENJZSB0YXJnZXRzLCB0aGVyZSBhcmUgc29tZSB0aGF0IHdp
bGwgb25seSBoYW5kbGUNCj4gPiBUTFAgZm9yIHNpbmdsZSAzMmJpdCBkYXRhIGl0ZW1zLg0KPiA+
IFdoaWNoIG1pZ2h0IGJlIHdoeSB0aGUgY29kZSBpcyBleHBsaWNpdGx5IHJlcXVlc3RpbmcgNCBi
eXRlIGNvcGllcy4NCj4gPiBTbyBpdCBtYXkgYmUgZW50aXJlbHkgd3JvbmcgdG8gd3JpdGUtY29t
YmluZSBhbnl0aGluZyBleGNlcHQNCj4gPiB0aGUgZ2VuZXJpYyBtZW1jcHlfdG9pbygpLg0KPiA+
DQo+ID4gCURhdmlkDQo+IA0KPiBPbiBhbnl0aGluZyBvdGhlciB0aGFuIHMzOTB4IHRoaXMgc2hv
dWxkIG9ubHkgZG8gd3JpdGUtY29tYmluZSBpZiB0aGUNCj4gbWVtb3J5IG1hcHBpbmcgYWxsb3dz
IGl0LCBubz8gTWVhbmluZyBhIGRyaXZlciB0aGF0IGNhbid0IGhhbmRsZSBsYXJnZXINCj4gVExQ
cyByZWFsbHkgc2hvdWxkbid0IHVzZSBpb3JlbWFwX3djKCkgdGhlbi4NCg0KSSBjYW4ndCBkZWNp
ZGUgd2hldGhlciBtZXJnZWQgd3JpdGVzIGNvdWxkIGJlIHJlcXVpcmVkIGZvciBzb21lDQp0YXJn
ZXQgYWRkcmVzc2VzIGJ1dCBiZSBwcm9ibGVtYXRpYyBvbiBvdGhlcnMuDQpQcm9iYWJseSBub3Qu
DQoNCj4gT24gczM5MHggb25lIGNvdWxkIGFyZ3VlIHRoYXQgb3VyIHZlcnNpb24gb2YgX19pb3dy
aXRlWFhfY29weSgpIGlzDQo+IHN0cmljdGx5IHNwZWFraW5nIG5vdCBjb3JyZWN0IGluIHRoYXQg
enBjaV9tZW1jcHlfdG9pbygpIGRvZXNuJ3QgcmVhbGx5DQo+IHVzZSBYWCBiaXQgd3JpdGVzIHdo
aWNoIGlzIHdoeSBmb3IgdXMgbWVtY3B5X3RvaW8oKSB3YXMgYWN0dWFsbHkgYQ0KPiBiZXR0ZXIg
Zml0IGluZGVlZC4gT24gdGhlIG90aGVyIGhhbmQgZG9pbmcgMzIgYml0IFBDSSBzdG9yZXMgKGFu
IHMzOTB4DQo+IHRoaW5nKSBjYW4ndCBjb21iaW5lIG11bHRpcGxlIHN0b3JlcyBpbnRvIGEgc2lu
Z2xlIFRMUCB3aGljaCB0aGVzZQ0KPiBmdW5jdGlvbnMgYXJlIHVzZWQgZm9yIGFuZCB3aGljaCBo
YXMgbXVjaCBtb3JlIHVzZSBjYXNlcyB0aGFuIGZvcmNpbmcgYQ0KPiBjb3B5IGxvb3Agd2l0aCAz
Mi82NCBiaXQgc2l6ZWQgd3JpdGVzIHdoaWNoIHdvdWxkIGFsc28gYmUgYSBsb3Qgc2xvd2VyDQo+
IG9uIHMzOTB4IHRoYW4gYW4gYWxpZ25lZCB6cGNpX21lbWNweV90b2lvKCkuDQoNCklmIEkgcmVh
ZCB0aGF0IGNvcnJlY3RseSAzMmJpdCB3cml0ZXMgZG9uJ3QgZ2V0IG1lcmdlZD8NCkluZGVlZCBh
bnkgY29kZSB0aGF0IHdpbGwgYmVuZWZpdCBmcm9tIG1lcmdpbmcgY2FuIChwcm9iYWJseSkNCmRv
IDY0Yml0IHdyaXRlcyBzbyBpcyBldmVuIGF0dGVtcHRpbmcgdG8gbWVyZ2UgMzJiaXQgb25lcw0K
d29ydGggdGhlIGVmZm9ydD8NCg0KU2luY2Ugd3JpdGVzIGdldCAncG9zdGVkJyBhbGwgb3ZlciB0
aGUgcGxhY2UuDQpIb3cgbWFueSB3cml0ZXMgZG8geW91IG5lZWQgdG8gZG8gYmVmb3JlIHdyaXRl
LWNvbWJpbmluZyBtYWtlcyBhIGRpZmZlcmVuY2U/DQpXZSd2ZSBsb2dpYyBpbiBvdXIgZnBnYSB0
byB0cmFjZSB0aGUgUlggYW5kIFRYIFRMUCBbMV0uDQpBbHRob3VnaCB0aGUgbGluayBpcyBzbG93
OyBiYWNrIHRvIGJhY2sgd3JpdGVzIGFyZSBsaW1pdGVkIGJ5DQp3aGF0IGhhcHBlbnMgbGF0ZXIg
aW4gdGhlIGZwZ2EgbG9naWMgLSBub3QgdGhlIHBjaWUgbGluay4NCg0KUmVhZHMgYXJlIGFub3Ro
ZXIgbWF0dGVyIGVudGlyZWx5Lg0KVGhlIHg4NiBjcHUgSSd2ZSB1c2VkIGFzc2lnbiBhIHRhZyB0
byBlYWNoIGNwdSBjb3JlLg0KU28gd2hpbGUgcmVhZHMgZnJvbSBtdWx0aXBsZSBwcm9jZXNzZXMg
aGFwcGVuIGluIHBhcmFsbGVsLCB0aG9zZQ0KZnJvbSBhIHNpbmdsZSBwcm9jZXNzIGFyZSBkZWZp
bml0ZWx5IHN5bmNocm9ub3VzLg0KVGhlIGNwdSBzdGFsbHMgZm9yIGEgZmV3IHRob3VzYW5kIGNs
b2NrIG9uIGV2ZXJ5IHJlYWQuDQoNCkxhcmdlIHJlYWQgVExQcyAoYW5kIG92ZXJsYXBwZWQgcmVh
ZCBUTFBzKSB3b3VsZCBoYXZlIGEgbXVjaA0KYmlnZ2VyIGVmZmVjdCB0aGFuIGxhcmdlIHdyaXRl
IFRMUC4NCg0KWzFdIEl0IGlzIG5pY2UgdG8gYmUgYWJsZSB0byBzZWUgd2hhdCBpcyBnb2luZyBv
biB3aXRob3V0IGhhdmluZw0KdG8gYmVnL3N0ZWFsL2JvcnJvdyBhbiBleHBlbnNpdmUgUENJZSBh
bmFseXNlciBhbmQgcGVyc3VhZGUgdGhlDQpoYXJkd2FyZSB0byB3b3JrIHdpdGggaXQgY29ubmVj
dGVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


