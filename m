Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDF653E73
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 11:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiLVKmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 05:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiLVKl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 05:41:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523613D7C
        for <linux-arch@vger.kernel.org>; Thu, 22 Dec 2022 02:41:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-172-D_exMaKhNCWc8qzlCOLIiw-1; Thu, 22 Dec 2022 10:41:53 +0000
X-MC-Unique: D_exMaKhNCWc8qzlCOLIiw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 22 Dec
 2022 10:41:52 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 22 Dec 2022 10:41:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: RE: [PATCH v2] kbuild: treat char as always unsigned
Thread-Topic: [PATCH v2] kbuild: treat char as always unsigned
Thread-Index: AQHZFV6o8tF/XYcvI0qqEtVNYsUlXa55tQ3w
Date:   Thu, 22 Dec 2022 10:41:52 +0000
Message-ID: <b2144334261246aa8dc5004c5f1a58c9@AcuMS.aculab.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
 <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
In-Reply-To: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgRGVjZW1iZXIgMjAyMiAxNzowNw0KPiAN
Cj4gT24gV2VkLCBEZWMgMjEsIDIwMjIgYXQgNzo1NiBBTSBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGFib3ZlIGFzc3VtZXMgYW4gdW5zaWdu
ZWQgY2hhciBhcyBpbnB1dCB0byBzdHJjbXAoKS4gSSBjb25zaWRlciB0aGF0DQo+ID4gYSBoeXBv
dGhldGljYWwgcHJvYmxlbSBiZWNhdXNlICJjb21wYXJpbmciIHN0cmluZ3Mgd2l0aCB1cHBlciBi
aXRzDQo+ID4gc2V0IGRvZXNuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2UgaW4gcHJhY3RpY2UgKEhvdyBk
b2VzIG9uZSBjb21wYXJlIEfDvG50ZXINCj4gPiBhZ2FpbnN0IEd1bnRlciA/IEFuZCBob3cgYWJv
dXQgR8eWbnRlciA/KS4gT24gdGhlIG90aGVyIHNpZGUsIHRoZSBwcm9ibGVtDQo+ID4gb2JzZXJ2
ZWQgaGVyZSBpcyByZWFsIGFuZCBpbW1lZGlhdGUuDQo+IA0KPiBQT1NJWCBkb2VzIGFjdHVhbGx5
IHNwZWNpZnkgIkfDvG50ZXIiIHZzICJHdW50ZXIiLg0KPiANCj4gVGhlIHdheSBzdHJjbXAgaXMg
c3VwcG9zZWQgdG8gd29yayBpcyB0byByZXR1cm4gdGhlIHNpZ24gb2YgdGhlDQo+IGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGUgYnl0ZSB2YWx1ZXMgKCJ1bnNpZ25lZCBjaGFyIikuDQo+IA0KPiBCdXQg
dGhhdCBzaWduIGhhcyB0byBiZSBjb21wdXRlZCBpbiAnaW50Jywgbm90IGluICdzaWduZWQgY2hh
cicuDQo+IA0KPiBTbyB5ZXMsIHRoZSBtNjhrIGltcGxlbWVudGF0aW9uIGlzIGJyb2tlbiByZWdh
cmRsZXNzLCBidXQgd2l0aCBhDQo+IHNpZ25lZCBjaGFyIGl0IGp1c3QgaGFwcGVuZWQgdG8gd29y
ayBmb3IgdGhlIFVTLUFTQ0lJIGNhc2UgdGhhdCB0aGUNCj4gY3J5cHRvIGNhc2UgdGVzdGVkLg0K
PiANCj4gSSB0aGluayB0aGUgcmVhbCBmaXggaXMgdG8ganVzdCByZW1vdmUgdGhhdCBicm9rZW4g
aW1wbGVtZW50YXRpb24NCj4gZW50aXJlbHksIGFuZCByZWx5IG9uIHRoZSBnZW5lcmljIG9uZS4N
Cg0KSSB3b25kZXIgaG93IG11Y2ggc2xvd2VyIGl0IGlzIC0gbTY4ayBpcyBsaWtlbHkgdG8gYmUg
bWljcm9jb2RlZA0KYW5kIEkgZG9uJ3QgdGhpbmsgaW5zdHJ1Y3Rpb24gdGltaW5ncyBhcmUgYWN0
dWFsbHkgYXZhaWxhYmxlLg0KVGhlIGZhc3Rlc3QgdmVyc2lvbiBwcm9iYWJseSB1c2VzIHN1Yngg
KHdpdGggY2FycnkpIHRvIGdlbmVyYXRlDQowLy0xIGFuZCBsZWF2ZXMgK2RlbHRhIGZvciB0aGUg
b3RoZXIgcmVzdWx0IC0gYnV0IGdldHRpbmcgdGhlDQpjb21wYXJlcyBhbmQgYnJhbmNoZXMgaW4g
dGhlIHJpZ2h0IG9yZGVyIGlzIGhhcmQuDQoNCkkgYmVsaWV2ZSBzb21lIG9mIHRoZSBvdGhlciBt
NjhrIGFzbSBmdW5jdGlvbnMgYXJlIGFsc28gbWlzc2luZw0KdGhlICJtZW1vcnkiICdjbG9iYmVy
JyBhbmQgc28gY291bGQgZ2V0IG1pcy1vcHRpbWlzZWQuDQpXaGlsZSBJIGNhbiB3cml0ZSAob3Ig
cmF0aGVyIGhhdmUgd3JpdHRlbikgbTY4ayBhc20gSSBkb24ndCBoYXZlDQphIGNvbXBpbGVyLg0K
DQpJIGFsc28gc3VzcGVjdCB0aGF0IGFueSB4ODYgY29kZSB0aGF0IHVzZXMgJ3JlcCBzY2FzJyBp
cyBnb2luZw0KdG8gYmUgc2xvdyBvbiBhbnl0aGluZyBtb2Rlcm4uDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

