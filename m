Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2338C3881ED
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbhERVPi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 17:15:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:36129 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241969AbhERVPh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 17:15:37 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-258-XZiFWQz-NZmRbfTBBekA3Q-1; Tue, 18 May 2021 22:14:06 +0100
X-MC-Unique: XZiFWQz-NZmRbfTBBekA3Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 22:14:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 18 May 2021 22:14:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Subject: RE: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
Thread-Topic: [PATCH v2 07/13] asm-generic: unaligned always use struct
 helpers
Thread-Index: AQHXS/YCMZkjEhef40atSxJR3LrT4Krpu4HQ
Date:   Tue, 18 May 2021 21:14:04 +0000
Message-ID: <2a31acad459d4e37b31da5b270dcf0ba@AcuMS.aculab.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-8-arnd@kernel.org> <YKLlyQnR+3uW4ETD@gmail.com>
 <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
In-Reply-To: <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTggTWF5IDIwMjEgMTU6NTYNCj4gDQo+IE9u
IFR1ZSwgTWF5IDE4LCAyMDIxIGF0IDEyOjI3IEFNIEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSSB3b25kZXIgaWYgdGhlIGtlcm5lbCBzaG91bGQg
ZG8gdGhlIHNhbWUsIG9yIHdoZXRoZXIgdGhlcmUgYXJlIHN0aWxsIGNhc2VzDQo+ID4gPiB3aGVy
ZSBtZW1jcHkoKSBpc24ndCBjb21waWxlZCBvcHRpbWFsbHkuICBhcm12Ni83IHVzZWQgdG8gYmUg
b25lIHN1Y2ggY2FzZSwgYnV0DQo+ID4gPiBpdCB3YXMgZml4ZWQgaW4gZ2NjIDYuDQo+ID4NCj4g
PiBJdCB3b3VsZCBoYXZlIHRvIGJlIG1lbW1vdmUoKSwgbm90IG1lbWNweSgpIGluIHRoaXMgY2Fz
ZSwgcmlnaHQ/DQo+IA0KPiBObywgaXQgd291bGQgc2ltcGx5IGJlIHNvbWV0aGluZyBsaWtlDQo+
IA0KPiAgICNkZWZpbmUgX19nZXRfdW5hbGlnbmVkX3QodHlwZSwgcHRyKSBcDQo+ICAgICAgICAg
KHsgdHlwZSBfX3ZhbDsgbWVtY3B5KCZfX3ZhbCwgcHRyLCBzaXplb2YodHlwZSkpOyBfX3ZhbDsg
fSkNCg0KWW91IHN0aWxsIG5lZWQgc29tZXRoaW5nIHRvIGVuc3VyZSB0aGF0IGdjYyBjYW4ndCBh
c3N1bWUgdGhhdA0KJ3B0cicgaGFzIGFuIGFsaWduZWQgdHlwZS4NCklmIHRoZXJlIGlzIGFuICdp
bnQgKnB0cicgdmlzaWJsZSBpbiB0aGUgY2FsbCBjaGFpbiBubyBhbW91bnQNCm9mICh2b2lkICop
IGNhc3RzIHdpbGwgbWFrZSBnY2MgZm9yZ2V0IHRoZSBhbGlnbm1lbnQuDQpTbyB0aGUgbWVtY3B5
KCkgd2lsbCBnZXQgY29udmVydGVkIHRvIGFuIGFsaWduZWQgbG9hZC1zdG9yZSBwYWlyLg0KKFRo
aXMgaGFzIGFsd2F5cyBjYXVzZWQgZ3JpZWYgb24gc3BhcmMuKQ0KDQpBIGNhc3QgdGhvdWdoIChs
b25nKSBtaWdodCBiZSBlbm91Z2gsIGFzIG1pZ2h0IGEgY2FzdCB0byBhIF9fcGFja2VkDQpzdHJ1
Y3QgcG9pbnRlciB0eXBlLg0KVXNpbmcgYSB1bmlvbiBvZiB0aGUgdHdvIHBvaW50ZXIgdHlwZXMg
bWlnaHQgYmUgb2sgLSBidXQgbWlnaHQNCmdlbmVyYXRlIGEgc3RvcmUvbG9hZCB0byBzdGFjay4N
CkFuIGFsdGVybmF0aXZlIGlzIGFuIGFzbSBzdGF0ZW1lbnQgd2l0aCBpbnB1dCBhbmQgb3V0cHV0
IG9mIGRpZmZlcmVudA0KcG9pbnRlciB0eXBlcyBidXQgdXNpbmcgdGhlIHNhbWUgcmVnaXN0ZXIg
Zm9yIGJvdGguDQpUaGF0IG91Z2h0IHRvIGZvcmNlIHRoZSBjb21waWxlIHRvIGZvcmdldCBhbnkg
dHJhY2tlZCB0eXBlDQphbmQgdmFsdWUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

