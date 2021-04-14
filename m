Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C735F589
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhDNNu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 09:50:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35022 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237770AbhDNNu4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 09:50:56 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-gomfhLBpMGmSQ6lS9xz_RQ-1; Wed, 14 Apr 2021 14:50:23 +0100
X-MC-Unique: gomfhLBpMGmSQ6lS9xz_RQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 14:50:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 14:50:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Niklas Schnelle' <schnelle@linux.ibm.com>,
        'Arnd Bergmann' <arnd@arndb.de>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "Guo Ren" <guoren@kernel.org>
Subject: RE: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
Thread-Topic: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
Thread-Index: AQHXMGSVFmL3q8InjEiRDqC8qAyY5Kqyacdg///5xgCAABWwYIABakUAgAAh4xA=
Date:   Wed, 14 Apr 2021 13:50:23 +0000
Message-ID: <ac3447d8db2146798b86135e9f49891d@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
         <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
         <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
         <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
         <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
         <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
         <40d4114fa34043d0841b81d09457c415@AcuMS.aculab.com>
 <c6f3c9a70e054e9087f657bf4f142732fd43784c.camel@linux.ibm.com>
In-Reply-To: <c6f3c9a70e054e9087f657bf4f142732fd43784c.camel@linux.ibm.com>
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

RnJvbTogTmlrbGFzIFNjaG5lbGxlDQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjEgMTM6MzUNCj4gDQo+
IE9uIFR1ZSwgMjAyMS0wNC0xMyBhdCAxNDoxMiArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0K
PiA+IEZyb206IEFybmQgQmVyZ21hbm4NCj4gPiA+IFNlbnQ6IDEzIEFwcmlsIDIwMjEgMTQ6NDAN
Cj4gPiA+DQo+ID4gPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAzOjA2IFBNIERhdmlkIExhaWdo
dCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBBcm5kIEJl
cmdtYW5uDQo+ID4gPiA+ID4gU2VudDogMTMgQXByaWwgMjAyMSAxMzo1OA0KPiA+ID4gPiAuLi4N
Cj4gPiA+ID4gPiBUaGUgcmVtYWluaW5nIG9uZXMgKGNza3ksIG02OGssIHNwYXJjMzIpIG5lZWQg
dG8gYmUgaW5zcGVjdGVkDQo+ID4gPiA+ID4gbWFudWFsbHkgdG8gc2VlIGlmIHRoZXkgY3VycmVu
dGx5IHN1cHBvcnQgUENJIEkvTyBzcGFjZSBidXQgaW4NCj4gPiA+ID4gPiBmYWN0IHVzZSBhZGRy
ZXNzIHplcm8gYXMgdGhlIGJhc2UgKHdpdGggbGFyZ2UgcmVzb3VyY2VzKSBvciB0aGV5DQo+ID4g
PiA+ID4gc2hvdWxkIGFsc28gdHVybiB0aGUgb3BlcmF0aW9ucyBpbnRvIGEgTk9QLg0KPiA+ID4g
Pg0KPiA+ID4gPiBJJ2QgZXhwZWN0IHNwYXJjMzIgdG8gdXNlIGFuIEFTSSB0byBhY2Nlc3MgUENJ
IElPIHNwYWNlLg0KPiA+ID4gPiBJIGNhbid0IHF1aXRlIHJlbWVtYmVyIHdoZXRoZXIgSU8gc3Bh
Y2Ugd2FzIHN1cHBvcnRlZCBhdCBhbGwuDQo+ID4gPg0KPiA+ID4gSSBzZWUgdGhpcyBiaXQgaW4g
YXJjaC9zcGFyYy9rZXJuZWwvbGVvbl9wY2kuYw0KPiA+ID4NCj4gPiA+ICAqIFBDSSBNZW1vcnkg
YW5kIFByZWZldGNoYWJsZSBNZW1vcnkgaXMgZGlyZWN0LW1hcHBlZC4gSG93ZXZlciBJL08gU3Bh
Y2UgaXMNCj4gPiA+ICAqIGFjY2Vzc2VkIHRocm91Z2ggYSBXaW5kb3cgd2hpY2ggaXMgdHJhbnNs
YXRlZCB0byBsb3cgNjRLQiBpbiBQQ0kgc3BhY2UsIHRoZQ0KPiA+ID4gICogZmlyc3QgNEtCIGlz
IG5vdCB1c2VkIHNvIDYwS0IgaXMgYXZhaWxhYmxlLg0KPiA+ID4gLi4uDQo+ID4gPiAgICAgICAg
IHBjaV9hZGRfcmVzb3VyY2Vfb2Zmc2V0KCZyZXNvdXJjZXMsICZpbmZvLT5pb19zcGFjZSwNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+aW9fc3BhY2Uuc3RhcnQg
LSAweDEwMDApOw0KPiA+ID4NCj4gPiA+IHdoaWNoIG1lYW5zIHRoYXQgdGhlcmUgaXMgSS9PIHNw
YWNlLCB3aGljaCBnZXRzIGFjY2Vzc2VkIHRocm91Z2ggd2hpY2hldmVyDQo+ID4gPiBtZXRob2Qg
cmVhZGIoKSB1c2VzLiBIYXZpbmcgdGhlIG9mZnNldCBlcXVhbCB0byB0aGUgcmVzb3VyY2UgbWVh
bnMgdGhhdA0KPiA+ID4gdGhlICcodm9pZCAqKTAnIHN0YXJ0IGlzIGNvcnJlY3QuDQo+ID4NCj4g
PiBJdCBtdXN0IGhhdmUgYmVlbiB0aGUgVk1FYnVzIChhbmQgbWF5YmUgc0J1cykgc3BhcmMgdGhh
dCB1c2VkIGFuIEFTSS4NCj4gPg0KPiA+IEkgZG8gcmVtZW1iZXIgaXNzdWVzIHdpdGggU29sYXJp
cyBvZiBzb21lIFBDSSBjYXJkcyBub3QgbGlraW5nDQo+ID4gYmVpbmcgYXNzaWduZWQgYSBCQVIg
YWRkcmVzcyBvZiB6ZXJvLg0KPiA+IFRoYXQgbWF5IGJlIHdoeSB0aGUgbG93IDRrIElPIHNwYWNl
IGlzbid0IGFzc2lnbmVkIGhlcmUuDQo+ID4gKEkndmUgbmV2ZXIgcnVuIExpbnV4IG9uIHNwYXJj
LCBqdXN0IFNWUjQgYW5kIFNvbGFyaXMuKQ0KPiA+DQo+ID4gSSBndWVzcyBzZXR0aW5nIFBDSV9J
T0JBU0UgdG8gemVybyBpcyBzYWZlciB3aGVuIHlvdSBjYW4ndCB0cnVzdA0KPiA+IGRyaXZlcnMg
bm90IHRvIHVzZSBpbmIoKSBpbnN0ZWFkIG9mIHJlYWRiKCkuDQo+ID4gT3Igd2hhdGV2ZXIgaW9f
cmVhZCgpIGVuZHMgdXAgYmVpbmcuDQo+ID4NCj4gPiAJRGF2aWQNCj4gDQo+IFNvICJJIGd1ZXNz
IHNldHRpbmcgUENJX0lPQkFTRSB0byB6ZXJvIGlzIHNhZmVyIHdoZW4geW91IGNhbid0IHRydXN0
DQo+IGRyaXZlcnMgbm90IHRvIHVzZSBpbmIoKeKApiIgaW4gcHJpbmNpcGxlIGlzIHRydWUgb24g
b3RoZXIgYXJjaGl0ZWN0dXJlcw0KPiB0aGFuIHNwYXJjIHRvbywgcmlnaHQ/IFNvIGRvIHlvdSB0
aGluayB0aGlzIG1lYW5zIHdlIHNob3VsZG4ndCBnbyB3aXRoDQo+IEFybmQncyBpZGVhIG9mIG1h
a2luZyBpbmIoKSBqdXN0IFdBUk5fT05DRSgpIGlmIFBDSV9JT0JBU0UgaXMgbm90DQo+IGRlZmlu
ZWQgb3IganVzdCB0aGF0IGZvciBzcGFyYyBkZWZpbmluZyBpdCBhcyAwIHdvdWxkIGJlIHByZWZl
cnJlZD8NCj4gDQo+IEFzIGZvciBzMzkwIHNpbmNlIHdlIG9ubHkgc3VwcG9ydCBhIGxpbWl0ZWQg
bnVtYmVyIG9mIGRyaXZlcnMgSSB0aGluaw0KPiBmb3IgdXMgc3VjaCBhIFdBUk5fT05DRSgpIGZv
ciBpbmIoKSB3b3VsZCBiZSBwcmVmZXJhYmxlLg0KPiANCj4gSSBndWVzcyBvbmUgb3B0aW9uIHdv
dWxkIGJlIHRvIGxldCBlYWNoIGFyY2hpdGVjdHVyZSBvcHQgaW4gdG8gbGVhdmluZw0KPiBQQ0lf
SU9CQVNFIHVuZGVmaW5lZCBidXQgaW4gdGhlIGZpcnN0IHBhdGNoIHB1c2ggUENJX0lPQkFTRSAw
IGludG8gYWxsDQo+IGRyaXZlcnMgdGhhdCBjdXJyZW50bHkgZG9uJ3QgZGVmaW5lIGl0IGF0IGFs
bCBfYW5kXyBkbyBub3QgZGVmaW5lIHRoZWlyDQo+IG93biBpbmIoKSBldGMuDQoNCkhvdyBtdWNo
IGNvZGUgb3V0c2lkZSBvZiBsZWdhY3kgeDg2IGRyaXZlcnMgc2hvdWxkIGJlIHVzaW5nIGluYigp
IGV0Yz8NCkknbSBub3Qgc3VyZSBhbnkgb3RoZXIgKG1vZGVybikgY3B1IGhhdmUgc2VwYXJhdGUg
SU8gaW5zdHJ1Y3Rpb25zLg0KDQpCZWNhdXNlIHNvbWUgUENJKGUpIHJlc291cmNlcyBtaWdodCBi
ZSBhdmFpbGFibGUgb24gbWVtb3J5IG9yIElPIEJBUnMNCihwb3NzaWJsZSBkdXBsaWNhdGUgQkFS
IG9uIHNvbWUgY2FyZHMpIGFyZW4ndCB0aGVyZSBhbHNvIGlvcmVhZGIoKQ0KZnVuY3Rpb25zICh3
aXRoIGFkZHJlc3NlcyBhcyBwYXJhbWV0ZXJzKT8NCklJUkMgb24geDg2IHRoZXkgdHJlYXQgc21h
bGwgdmFsdWVzIGFzIElPIHBvcnRzIGFuZCBsYXJnZSBvbmVzDQphcyBtZW1vcnkgbWFwcGVkIGFk
ZHJlc3Nlcy4NCklmIFBDSSBJTyBzcGFjZSBpcyBtZW1vcnkgbWFwcGVkIHRoZW4gdGhlc2Ugd291
bGQgYmUgZGlyZWN0bHkgZXF1aXZhbGVudA0KdG8gcmVhZGIoKSAoZXRjKS4NCg0KU28gcGVyaGFw
cyBpbmIoKSBzaG91bGQganVzdCBub3QgYmUgZGVmaW5lZCBhdCBhbGwgZXhjZXB0IG9uIHg4Nj8N
CihQZXJoYXBzIGV4Y2VwdCBmb3IgQ09NUElMRV9URVNUKS4NCklmIGl0IGlzIGRlZmluZWQsIHRo
ZW4gbWF5YmUgaXQgc2hvdWxkIG5ldmVyIGJlIGNhbGxlZD8NClNvIGEgV0FSTl9PTkNFKCkgcmV0
dXJuaW5nIH4wIGZvciByZWFkcyBtaWdodCBldmVuIGJlIGJlc3QuDQoNCk9mIGNvdXJzZSwgdGhl
cmUgd2lsbCBiZSBzb21lIG9ic2N1cmUgZmFsbG91dCAtIHRoZXJlIGFsd2F5cyBpcy4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

