Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1205C3AC629
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhFRIee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 04:34:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31970 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233875AbhFRIe0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jun 2021 04:34:26 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-11-fKdMvnO2P96mfGP2YKpuQQ-1; Fri, 18 Jun 2021 09:32:15 +0100
X-MC-Unique: fKdMvnO2P96mfGP2YKpuQQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 18 Jun
 2021 09:32:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Fri, 18 Jun 2021 09:32:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>
CC:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Akira Tsukamoto" <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH 1/3] riscv: optimized memcpy
Thread-Index: AQHXYuC4XkdMIImxVUmoQbZ37iIZIqsYtSAggABBV22AAHkiQA==
Date:   Fri, 18 Jun 2021 08:32:14 +0000
Message-ID: <0fe90e43868f49b5953afe5abba41327@AcuMS.aculab.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com>
 <CAJF2gTTreOvQYYXHBYxznB9+vMaASKg8vwA5mkqVo1T6=eVhzw@mail.gmail.com>
 <CAFnufp1OHdRd-tbB+Hi0UnXARtxGPdkK6MJktnaNCNt65d3Oew@mail.gmail.com>
 <f9b78350d9504e889813fc47df41f3fe@AcuMS.aculab.com>
 <CAFnufp1CA7g=poF3UpKjX7YYz569Wxc1YORSv+uhpU5847xuXw@mail.gmail.com>
 <CAFnufp2LmXxs6+aH7cjH=T4Ye_Yo6yvJpF93JcY+HtVvXB44oQ@mail.gmail.com>
 <CAFnufp0qjJG4fr=rcAHYrZp3CVfSs0TBuDN_eAOwOM-K804yow@mail.gmail.com>
In-Reply-To: <CAFnufp0qjJG4fr=rcAHYrZp3CVfSs0TBuDN_eAOwOM-K804yow@mail.gmail.com>
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

RnJvbTogTWF0dGVvIENyb2NlDQo+IFNlbnQ6IDE4IEp1bmUgMjAyMSAwMjowNQ0KLi4uDQo+ID4g
PiBJdCdzIHJ1bm5pbmcgYXQgMSBHSHouDQo+ID4gPg0KPiA+ID4gSSBnZXQgMjU3IE1iL3Mgd2l0
aCBhIG1lbWNweSwgYSBiaXQgbW9yZSB3aXRoIGEgbWVtc2V0LA0KPiA+ID4gYnV0IEkgZ2V0IDEy
MDAgTWIvcyB3aXRoIGEgY3lsZSB3aGljaCBqdXN0IHJlYWRzIG1lbW9yeSB3aXRoIDY0IGJpdCBh
ZGRyZXNzaW5nLg0KPiA+ID4NCj4gPg0KPiA+IEVyciwgSSBmb3JnZXQgYSBtbG9jaygpIGJlZm9y
ZSBhY2Nlc3NpbmcgdGhlIG1lbW9yeSBpbiB1c2Vyc3BhY2UuDQoNCldoYXQgaXMgdGhlIG1sb2Nr
KCkgZm9yPw0KVGhlIGRhdGEgZm9yIGEgcXVpY2sgbG9vcCB3b24ndCBnZXQgcGFnZWQgb3V0Lg0K
WW91IHdhbnQgdG8gdGVzdCBjYWNoZSB0byBjYWNoZSBjb3BpZXMsIHNvIHRoZSBmaXJzdCBsb29w
DQp3aWxsIGFsd2F5cyBiZSBzbG93Lg0KQWZ0ZXIgdGhhdCBlYWNoIGl0ZXJhdGlvbiBzaG91bGQg
YmUgbXVjaCB0aGUgc2FtZS4NCkkgdXNlIGNvZGUgbGlrZToNCglmb3IgKDs7KSB7DQoJCXN0YXJ0
ID0gcmVhZF90c2MoKTsNCgkJZG9fdGVzdCgpOw0KCQloaXN0b2dyYW1bKHJlYWRfdHNjKCkgLSBz
dGFydCkgPj4gbl0rKw0KCX0NCihZb3UgbmVlZCB0byBleGNsdWRlIG91dGxpZXJzKQ0KdG8gZ2V0
IGEgZGlzdHJpYnV0aW9uIGZvciB0aGUgZXhlY3V0aW9uIHRpbWVzLg0KVGVuZHMgdG8gYmUgcHJl
dHR5IHN0YWJsZSAtIGV2ZW4gdGhvdWdoIGRpZmZlcmVudCBwcm9ncmFtDQpydW5zIGNhbiBnaXZl
IGRpZmZlcmVudCB2YWx1ZXMhDQoJDQo+ID4gVGhlIHJlYWwgc3BlZWQgaGVyZSBpczoNCj4gPg0K
PiA+IDggYml0IHJlYWQ6IDE1NS40MiBNYi9zDQo+ID4gNjQgYml0IHJlYWQ6IDI3Ny4yOSBNYi9z
DQo+ID4gOCBiaXQgd3JpdGU6IDEzOC41NyBNYi9zDQo+ID4gNjQgYml0IHdyaXRlOiAyMzkuMjEg
TWIvcw0KPiA+DQo+IA0KPiBBbnl3YXksIHRoYW5rcyBmb3IgdGhlIGluZm8gb24gbmlvMiB0aW1p
bmdzLg0KPiBJZiB5b3UgdGhpbmsgdGhhdCBhbiB1bnJvbGxlZCBsb29wIHdvdWxkIGhlbHAsIHdl
IGNhbiBhY2hpZXZlIHRoZSBzYW1lIGluIEMuDQo+IEkgdGhpbmsgd2UgY291bGQgY29kZSBzb21l
dGhpbmcgc2ltaWxhciB0byBhIER1ZmYgZGV2aWNlIChvciB3aXRoIGp1bXANCj4gbGFiZWxzKSB0
byB1bnJvbGwgdGhlIGxvb3AgYnV0IGF0IHRoZSBzYW1lIHRpbWUgZG9pbmcgZWZmaWNpZW50IHNt
YWxsIGNvcGllcy4NCg0KVW5yb2xsaW5nIGhhcyB0byBiZSBkb25lIHdpdGggY2FyZS4NCkl0IHRl
bmRzIHRvIGltcHJvdmUgYmVuY2htYXJrcywgYnV0IHRoZSBleHRyYSBjb2RlIGRpc3BsYWNlcw0K
b3RoZXIgY29kZSBmcm9tIHRoZSBpLWNhY2hlIGFuZCBzbG93cyBkb3duIG92ZXJhbGwgcGVyZm9y
bWFuY2UuDQpTbyB5b3UgbmVlZCAnanVzdCBlbm91Z2gnIHVucm9sbGluZyB0byBhdm9pZCBjcHUg
c3RhbGxzLg0KDQpPbiB5b3VyIHN5c3RlbSBpdCBsb29rcyBsaWtlIHRoZSBtZW1vcnkvY2FjaGUg
c3Vic3lzdGVtDQppcyB0aGUgYm90dGxlbmVjayBmb3IgdGhlIHRlc3RzIHlvdSBhcmUgZG9pbmcu
DQpJJ2QgcmVhbGx5IGV4cGVjdCBhIDFHSHogY3B1IHRvIGJlIGFibGUgdG8gcmVhZC93cml0ZSBm
cm9tDQppdHMgZGF0YSBjYWNoZSBldmVyeSBjbG9jay4NClNvIEknZCBleHBlY3QgdHJhbnNmZXIg
cmF0ZXMgbmVhcmVyIDgwMDAgTUIvcywgbm90IDI1MCBNQi9zLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

