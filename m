Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC24079D6
	for <lists+linux-arch@lfdr.de>; Sat, 11 Sep 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhIKR1d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Sep 2021 13:27:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22068 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232615AbhIKR1c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Sep 2021 13:27:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-4qc9EUa1M6qeRLmgOwokUA-1; Sat, 11 Sep 2021 18:26:13 +0100
X-MC-Unique: 4qc9EUa1M6qeRLmgOwokUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 11 Sep 2021 18:26:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 11 Sep 2021 18:26:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "mcroce@linux.microsoft.com" <mcroce@linux.microsoft.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "akira.tsukamoto@gmail.com" <akira.tsukamoto@gmail.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: RE: [PATCH] riscv: use the generic string routines
Thread-Topic: [PATCH] riscv: use the generic string routines
Thread-Index: AQHXpr/5qgNlr7pPJkaLpUnMWph5s6ufDaMA
Date:   Sat, 11 Sep 2021 17:26:12 +0000
Message-ID: <241c29b27c4c4acbbf893516bfa6f5aa@AcuMS.aculab.com>
References: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
 <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
In-Reply-To: <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
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

Li4NCj4gVGhlc2UgZW5kZWQgdXAgZ2V0dGluZyByZWplY3RlZCBieSBMaW51cywgc28gSSdtIGdv
aW5nIHRvIGhvbGQgb2ZmIG9uDQo+IHRoaXMgZm9yIG5vdy4gIElmIHRoZXkncmUgcmVhbGx5IG91
dCBvZiBsaWIvIHRoZW4gSSdsbCB0YWtlIHRoZSBDDQo+IHJvdXRpbmVzIGluIGFyY2gvcmlzY3Ys
IGJ1dCBlaXRoZXIgd2F5IGl0J3MgYW4gaXNzdWUgZm9yIHRoZSBuZXh0DQo+IHJlbGVhc2UuDQoN
CkkndmUgYmVlbiBoYWxmIGZvbGxvd2luZyB0aGlzLg0KSSd2ZSBub3Qgc2VlbiBhbnkgY29tcGFy
aXNvbnMgYmV0d2VlbiB0aGUgQyBmdW5jdGlvbnMgcHJvcG9zZWQNCmhlcmUgYW5kIHRoZSByaXNj
diBhc20gb25lcyB0aGF0IGhhZCB0aGUgZml4IGZvciBtaXNhbGlnbmVkDQp0cmFuc2ZlcnMgYXBw
bGllZC4NCg0KSUlSQyB0aGVyZSBpcyBhIGNvbW1lbnQgaW4gdGhlIGFzbSBvbmVzIHRoYXQgdGhl
IHVucm9sbGVkDQoncmVhZCBsb3RzJyAtICd3cml0ZSBsb3RzJyBsb29wIGlzIGZhc3RlciB0aGFu
IHRoZSBvbGRlcg0KKGFzbSkgcmVhZC13cml0ZSBsb29wLg0KDQpCdXQgSSd2ZSBub3Qgc2VlbiBh
bnkgYXJjaGljdHVyYWwgZGlzY3Vzc2lvbnMgYXQgYWxsLg0KDQpBIHNpbXBsZSBpbi1vcmRlciBz
aW5nbGUtaXNzdWUgY3B1IHdpbGwgZXhlY3V0ZSB0aGUNCnVucm9sbGVkIGxvb3AgZmFzdGVyIGp1
c3QgYmVjYXVzZSBpdCBoYXMgZmV3ZXIgaW5zdHJ1Y3Rpb25zLg0KVGhlIHJlYWQtbG90cyAtIHdy
aXRlLWxvdHMgYWxtb3N0IGNlcnRhaW5seSBoZWxwcw0KYXZvaWQgcmVhZC1sYXRlbmN5IGRlbGF5
aW5nIHRoaW5ncyBpZiBtdWx0aXBsZSByZWFkcw0KY2FuIGJlIHBpcGVsaW5lZC4NClRoZSB3cml0
ZXMgYXJlIGFsbW9zdCBjZXJ0YWlubHkgJ3Bvc3RlZCcgYW5kIHBpcGVsaW5lZCwNCkJ1dCBhIHNp
bXBsZSBjcHUgY291bGQgZWFzaWx5IHJlcXVpcmUgYWxsIHdyaXRlcyBmaW5pc2gNCmJlZm9yZSBk
b2luZyBhIHJlYWQuDQoNCkEgc3VwZXItc2NhbGVyIChtdWx0aS1pc3N1ZSkgY3B1IGdpdmVzIHlv
dSB0aGUgYWJpbGl0eQ0KdG8gZ2V0IHRoZSBsb29wIGNvbnRyb2wgaW5zdHJ1Y3Rpb25zICdmb3Ig
ZnJlZScgd2l0aA0KY2FyZWZ1bGx5IHdyaXR0ZW4gYXNzZW1ibGVyLg0KQXQgd2hpY2ggcG9pbnQg
YSBjb3B5IGZvciAnbGlmZSBjYWNoZScgZGF0YSBzaG91bGQgYmUNCmxpbWl0ZWQgb25seSBieSB0
aGUgY3B1J3MgY2FjaGUgbWVtb3J5IGJhbmR3aWR0aC4NCg0KSWYgcmVhZHMgYW5kIHdyaXRlcyBj
YW4gaW50ZXJsZWF2ZSB0aGVuIGEgbG9vcCB0aGF0DQphbHRlcm5hdGVzIHJlYWRzIGFuZCB3cml0
ZXMgKHJlYWQgZWFjaCByZWdpc3Rlcg0KanVzdCBhZnRlciB3cml0aW5nIGl0KSBtYXkgbWVhbiB0
aGF0IHlvdSBhbHdheXMNCmtlZXAgdGhlIGNwdS1jYWNoZSBpbnRlcmZhY2UgYnVzeS4NClRoaXMg
d291bGQgYmUgZXNwZWNpYWxseSB0cnVlIGlmIHRoZSBjcHUgY2FuIGV4ZWN1dGUNCmJvdGggYSBj
YWNoZSByZWFkIGFuZCB3cml0ZSBpbiB0aGUgc2FtZSBjeWNsZS4NCihXaGljaCBtYW55IG1vZGVy
YXRlIHBlcmZvcm1hbmNlIGNwdSBjYW4uKQ0KDQpOb25lIG9mIHRoZSByZXF1aXJlcyBvdXQtb2Yt
b3JkZXIgZXhlY3V0aW9uLCBqdXN0DQpleGVjdXRpb24gdG8gY29udGludWUgd2hpbGUgYSByZWFk
IGlzIGluIHByb2dyZXNzLg0KDQpJJ20gYWxzbyBndWVzc2luZyB0aGF0IGFueSBwZXJmb3JtYW5j
ZSB0ZXN0aW5nIGhhcyBiZWVuDQpkb25lIHdpdGggdGhlIChyZWxhdGl2ZWx5KSBjaGVhcCBib2Fy
ZHMgdGhhdCBhcmUgcmVhZGlseQ0KYXZhaWxhYmxlLg0KDQpCdXQgSSd2ZSBhbHNvIHNlZW4gcmVm
ZXJlbmNlcyBpbiB0aGUgcHJlc3MgdG8gbXVjaCBmYXN0ZXINCnJpc2N2IGNwdSB0aGF0IGFyZSBk
ZWZpbml0ZWx5IG11bHRpLWlzc3VlIGFuZCBtYXkgaGF2ZQ0Kc29tZSBzaW1wbGUgb3V0LW9mLW9y
ZGVyIGV4ZWN1dGlvbi4NCkFueSBjaGFuZ2VzIG91Z2h0IHRvIGJlIHRlc3RlZCBvbiB0aGVzZSBm
YXN0ZXIgc3lzdGVtcy4NCg0KSSBhbHNvIHJlY2FsbCB0aGF0IHNvbWUgb2YgdGhlIHBlcmZvcm1h
bmNlIG1lYXN1cmVtZW50cw0Kd2VyZSBtYWRlIHdpdGggbG9uZyBidWZmZXJzIC0gdGhleSB3aWxs
IGJlIGRvbWluYXRlZCBieSB0aGUNCmNhY2hlIHRvIERSQU0gKGFuZCBtYXliZSBUTEIgbG9va3Vw
KSB0aW1pbmdzLCBub3QgdGhlIGNvcHkNCmxvb3AuDQoNCkZvciBhIHNpbXBsZSBjcHUgeW91IG91
Z2h0IHRvIGJlIGFibGUgdG8gbWVhc3VyZSB0aGUNCm51bWJlciBvZiBjcHUgY3ljbGVzIHVzZWQg
Zm9yIGEgY29weSAtIGFuZCBhY2NvdW50IGZvcg0KYWxsIG9mIHRoZW0uDQpGb3Igc29tZXRoaW5n
IGxpa2UgeDg2IHlvdSBjYW4gc2hvdyB0aGF0IHRoZSBjb3B5IGlzDQpiZWluZyBsaW1pdGVkIGJ5
IHRoZSBjcHUtY2FjaGUgYmFuZHdpZHRoLg0KKEZXSVcgbWVhc3VyZW1lbnRzIG9mIHRoZSBpbmV0
IGNoZWNrc3VtIGNvZGUgb24geDg2DQpzaG93IGl0IHJ1bnMgYXQgaGFsZiB0aGUgZXhwZWN0ZWQg
c3BlZWQgb24gYSBsb3Qgb2YNCkludGVsIGNwdSAtIG5vIG9uZSBldmVyIG1lYXN1cmVkIGl0LikN
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

