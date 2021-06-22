Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62B53AFF63
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhFVIlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 04:41:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40888 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVIlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Jun 2021 04:41:09 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-1-aRG45FtSMtWCXO1T3F07Vw-1;
 Tue, 22 Jun 2021 09:38:51 +0100
X-MC-Unique: aRG45FtSMtWCXO1T3F07Vw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 09:38:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 09:38:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Kossifidis' <mick@ics.forth.gr>,
        Matteo Croce <mcroce@linux.microsoft.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Guo Ren <guoren@kernel.org>
Subject: RE: [PATCH v3 3/3] riscv: optimized memset
Thread-Topic: [PATCH v3 3/3] riscv: optimized memset
Thread-Index: AQHXZwMJWYnk4yvoiESUZuZXhHkP6qsfsYlg
Date:   Tue, 22 Jun 2021 08:38:50 +0000
Message-ID: <d0f11655f21243ad983bd24381cdc245@AcuMS.aculab.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com>
 <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
In-Reply-To: <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
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

RnJvbTogTmljayBLb3NzaWZpZGlzDQo+IFNlbnQ6IDIyIEp1bmUgMjAyMSAwMjowOA0KPiANCj4g
zqPPhM65z4IgMjAyMS0wNi0xNyAxODoyNywgTWF0dGVvIENyb2NlIM6tzrPPgc6xz4jOtToNCj4g
PiArDQo+ID4gK3ZvaWQgKl9fbWVtc2V0KHZvaWQgKnMsIGludCBjLCBzaXplX3QgY291bnQpDQo+
ID4gK3sNCj4gPiArCXVuaW9uIHR5cGVzIGRlc3QgPSB7IC51OCA9IHMgfTsNCj4gPiArDQo+ID4g
KwlpZiAoY291bnQgPj0gTUlOX1RIUkVTSE9MRCkgew0KPiA+ICsJCWNvbnN0IGludCBieXRlc19s
b25nID0gQklUU19QRVJfTE9ORyAvIDg7DQo+IA0KPiBZb3UgY291bGQgbWFrZSAnY29uc3QgaW50
IGJ5dGVzX2xvbmcgPSBCSVRTX1BFUl9MT05HIC8gODsnDQoNCldoYXQgaXMgd3Jvbmcgd2l0aCBz
aXplb2YgKGxvbmcpID8NCi4uLg0KPiA+ICsJCXVuc2lnbmVkIGxvbmcgY3UgPSAodW5zaWduZWQg
bG9uZyljOw0KPiA+ICsNCj4gPiArCQkvKiBDb21wb3NlIGFuIHVsb25nIHdpdGggJ2MnIHJlcGVh
dGVkIDQvOCB0aW1lcyAqLw0KPiA+ICsJCWN1IHw9IGN1IDw8IDg7DQo+ID4gKwkJY3UgfD0gY3Ug
PDwgMTY7DQo+ID4gKyNpZiBCSVRTX1BFUl9MT05HID09IDY0DQo+ID4gKwkJY3UgfD0gY3UgPDwg
MzI7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gDQo+IFlvdSBkb24ndCBoYXZlIHRvIGNyZWF0ZSBj
dSBoZXJlLCB5b3UnbGwgZmlsbCBkZXN0IGJ1ZmZlciB3aXRoICdjJw0KPiBhbnl3YXkgc28gYWZ0
ZXIgZmlsbGluZyB1cCBlbm91Z2ggJ2MncyB0byBiZSBhYmxlIHRvIGdyYWIgYW4gYWxpZ25lZA0K
PiB3b3JkIGZ1bGwgb2YgdGhlbSBmcm9tIGRlc3QsIHlvdSBjYW4ganVzdCBncmFiIHRoYXQgd29y
ZCBhbmQga2VlcA0KPiBmaWxsaW5nIHVwIGRlc3Qgd2l0aCBpdC4NCg0KVGhhdCB3aWxsIGJlIGEg
bG90IHNsb3dlciAtIGVzcGVjaWFsbHkgaWYgcnVuIG9uIHNvbWV0aGluZyBsaWtlIHg4Ni4NCkEg
d3JpdGUtcmVhZCBvZiB0aGUgc2FtZSBzaXplIGlzIG9wdGltaXNlZCBieSB0aGUgc3RvcmUtbG9h
ZCBmb3J3YXJkZXIuDQpCdXQgdGhlIGJ5dGUgd3JpdGUsIHdvcmQgcmVhZCB3aWxsIGhhdmUgdG8g
Z28gdmlhIHRoZSBjYWNoZS4NCg0KWW91IGNhbiBqdXN0IHdyaXRlOg0KCWN1ID0gKHVuc2lnbmVk
IGxvbmcpYyAqIDB4MDEwMTAxMDEwMTAxMDEwMXVsbDsNCmFuZCBsZXQgdGhlIGNvbXBpbGVyIHNv
cnQgb3V0IHRoZSBiZXN0IHdheSB0byBnZW5lcmF0ZSB0aGUgY29uc3RhbnQuDQoNCj4gDQo+ID4g
KyNpZm5kZWYgQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1MNCj4gPiArCQkv
KiBGaWxsIHRoZSBidWZmZXIgb25lIGJ5dGUgYXQgdGltZSB1bnRpbCB0aGUgZGVzdGluYXRpb24N
Cj4gPiArCQkgKiBpcyBhbGlnbmVkIG9uIGEgMzIvNjQgYml0IGJvdW5kYXJ5Lg0KPiA+ICsJCSAq
Lw0KPiA+ICsJCWZvciAoOyBjb3VudCAmJiBkZXN0LnVwdHIgJSBieXRlc19sb25nOyBjb3VudC0t
KQ0KPiANCj4gWW91IGNvdWxkIHJldXNlICYgbWFzayBoZXJlIGluc3RlYWQgb2YgJSBieXRlc19s
b25nLg0KPiANCj4gPiArCQkJKmRlc3QudTgrKyA9IGM7DQo+ID4gKyNlbmRpZg0KPiANCj4gSSBu
b3RpY2VkIHlvdSBhbHNvIHVzZWQgQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NF
U1Mgb24geW91cg0KPiBtZW1jcHkgcGF0Y2gsIGlzIGl0IHdvcnRoIGl0IGhlcmUgPyBUbyBiZWdp
biB3aXRoIHJpc2N2IGRvZXNuJ3Qgc2V0IGl0DQo+IGFuZCBldmVuIGlmIGl0IGRpZCB3ZSBhcmUg
dGFsa2luZyBhYm91dCBhIGxvb3AgdGhhdCB3aWxsIHJ1biBqdXN0IGEgZmV3DQo+IHRpbWVzIHRv
IHJlYWNoIHRoZSBhbGlnbm1lbnQgYm91bmRhcnkgKHdvcnN0IGNhc2Ugc2NlbmFyaW8gaXQnbGwg
cnVuIDcNCj4gdGltZXMpLCBJIGRvbid0IHRoaW5rIHdlIGdhaW4gbXVjaCBoZXJlLCBldmVuIGZv
ciBhcmNocyB0aGF0IGhhdmUNCj4gZWZmaWNpZW50IHVuYWxpZ25lZCBhY2Nlc3MuDQoNCldpdGgg
Q09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1MgaXQgcHJvYmFibHkgaXNuJ3Qg
d29ydGgNCmV2ZW4gY2hlY2tpbmcgdGhlIGFsaWdubWVudC4NCldoaWxlIGFsaWduaW5nIHRoZSBj
b3B5IHdpbGwgYmUgcXVpY2tlciBmb3IgYW4gdW5hbGlnbmVkIGJ1ZmZlciB0aGV5DQphbG1vc3Qg
Y2VydGFpbmx5IGRvbid0IGhhcHBlbiBvZnRlbiBlbm91Z2ggdG8gd29ycnkgYWJvdXQuDQpJbiBh
bnkgY2FzZSB5b3UnZCB3YW50IHRvIGRvIGEgbWlzYWxpZ25lZCB3b3JkIHdyaXRlIHRvIHRoZSBz
dGFydA0Kb2YgdGhlIGJ1ZmZlciAtIG5vdCBzZXBhcmF0ZSBieXRlIHdyaXRlcy4NClByb3ZpZGVk
IHRoZSBidWZmZXIgaXMgbG9uZyBlbm91Z2ggeW91IGNhbiBhbHNvIGRvIGEgbWlzYWxpZ25lZCB3
cml0ZQ0KdG8gdGhlIGVuZCBvZiB0aGUgYnVmZmVyIGJlZm9yZSBmaWxsaW5nIGZyb20gdGhlIHN0
YXJ0Lg0KDQpJIHN1c3BlY3QgeW91IG1heSBuZWVkIGVpdGhlciBiYXJyaWVyKCkgb3IgdXNlIGEg
cHRyIHRvIHBhY2tlZA0KdG8gYXZvaWQgdGhlIHBlcnZlcnRlZCAndW5kZWZpbmVkIGJlaGF2aW91
cicgZnViYXIuJw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

