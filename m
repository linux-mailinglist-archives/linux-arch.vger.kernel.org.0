Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9983B166E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFWJIL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 05:08:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58792 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229970AbhFWJIK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 05:08:10 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-108-3xH7Sk6BPwS58IEzlMBB7Q-1; Wed, 23 Jun 2021 10:05:49 +0100
X-MC-Unique: 3xH7Sk6BPwS58IEzlMBB7Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 10:05:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 23 Jun 2021 10:05:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>
CC:     Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Guo Ren <guoren@kernel.org>
Subject: RE: [PATCH v3 3/3] riscv: optimized memset
Thread-Topic: [PATCH v3 3/3] riscv: optimized memset
Thread-Index: AQHXZwMJWYnk4yvoiESUZuZXhHkP6qsfsYlggAEJ8ACAAJGKIA==
Date:   Wed, 23 Jun 2021 09:05:48 +0000
Message-ID: <fe6c2f646cf1468c89622cc1d848ae0c@AcuMS.aculab.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com>
 <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
 <d0f11655f21243ad983bd24381cdc245@AcuMS.aculab.com>
 <CAFnufp1XeKM-N1MdWsNpU6NnF-dYUgGXL1W9r_DDWazTMyRHVA@mail.gmail.com>
In-Reply-To: <CAFnufp1XeKM-N1MdWsNpU6NnF-dYUgGXL1W9r_DDWazTMyRHVA@mail.gmail.com>
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

RnJvbTogTWF0dGVvIENyb2NlDQo+IFNlbnQ6IDIzIEp1bmUgMjAyMSAwMjoxNQ0KPiANCj4gT24g
VHVlLCBKdW4gMjIsIDIwMjEgYXQgMTA6MzggQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBOaWNrIEtvc3NpZmlkaXMNCi4uLg0K
PiA+IFlvdSBjYW4ganVzdCB3cml0ZToNCj4gPiAgICAgICAgIGN1ID0gKHVuc2lnbmVkIGxvbmcp
YyAqIDB4MDEwMTAxMDEwMTAxMDEwMXVsbDsNCj4gPiBhbmQgbGV0IHRoZSBjb21waWxlciBzb3J0
IG91dCB0aGUgYmVzdCB3YXkgdG8gZ2VuZXJhdGUgdGhlIGNvbnN0YW50Lg0KPiA+DQo+IA0KPiBJ
bnRlcmVzdGluZy4gSSBzZWUgdGhhdCBtb3N0IGNvbXBpbGVycyBkbyBhbiBpbnRlZ2VyIG11bHRp
cGxpY2F0aW9uLA0KPiBpcyBpdCBmYXN0ZXIgdGhhbiB0aHJlZSBzaGlmdCBhbmQgdGhyZWUgb3I/
DQo+IA0KPiBjbGFuZyBvbiByaXNjdiBnZW5lcmF0ZXMgZXZlbiBtb3JlIGluc3RydWN0aW9ucyB0
byBjcmVhdGUgdGhlIGltbWVkaWF0ZToNCj4gDQo+IHVuc2lnbmVkIGxvbmcgcmVwZWF0X3NoaWZ0
KGludCBjKQ0KPiB7DQo+ICAgdW5zaWduZWQgbG9uZyBjdSA9ICh1bnNpZ25lZCBsb25nKWM7DQo+
ICAgY3UgfD0gY3UgPDwgODsNCj4gICBjdSB8PSBjdSA8PCAxNjsNCj4gICBjdSB8PSBjdSA8PCAz
MjsNCj4gDQo+ICAgcmV0dXJuIGN1Ow0KPiB9DQo+IA0KPiB1bnNpZ25lZCBsb25nIHJlcGVhdF9t
dWwoaW50IGMpDQo+IHsNCj4gICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpYyAqIDB4MDEwMTAxMDEw
MTAxMDEwMXVsbDsNCj4gfQ0KPiANCj4gcmVwZWF0X3NoaWZ0Og0KPiAgIHNsbGkgYTEsIGEwLCA4
DQo+ICAgb3IgYTAsIGEwLCBhMQ0KPiAgIHNsbGkgYTEsIGEwLCAxNg0KPiAgIG9yIGEwLCBhMCwg
YTENCj4gICBzbGxpIGExLCBhMCwgMzINCj4gICBvciBhMCwgYTAsIGExDQo+ICAgcmV0DQo+IA0K
PiByZXBlYXRfbXVsOg0KPiAgIGx1aSBhMSwgNDExMg0KPiAgIGFkZGl3IGExLCBhMSwgMjU3DQo+
ICAgc2xsaSBhMSwgYTEsIDE2DQo+ICAgYWRkaSBhMSwgYTEsIDI1Nw0KPiAgIHNsbGkgYTEsIGEx
LCAxNg0KPiAgIGFkZGkgYTEsIGExLCAyNTcNCj4gICBtdWwgYTAsIGEwLCBhMQ0KPiAgIHJldA0K
DQpIbW1tLi4uIEkgZXhwZWN0ZWQgdGhlIGNvbXBpbGVyIHRvIGNvbnZlcnQgaXQgdG8gdGhlIGZp
cnN0IGZvcm0uDQpJdCBpcyBhbHNvIHByZXR0eSBjcmFwIGF0IGdlbmVyYXRpbmcgdGhhdCBjb25z
dGFudC4NClN0dXBpZCBjb21waWxlcnMuDQoNCkluIGFueSBjYXNlLCBmb3IgdGhlIHVzdWFsIGNh
c2Ugb2YgJ2MnIGJlaW5nIGEgY29uc3RhbnQgemVybw0KeW91IHJlYWxseSBkb24ndCB3YW50IHRo
ZSBsYXRlbmN5IG9mIHRob3NlIGluc3RydWN0aW9ucyBhdCBhbGwuDQoNCkl0IGlzIGFsbW9zdCB3
b3J0aCBqdXN0IHB1c2hpbmcgdGhhdCBleHBhbnNpb24gaW50byB0aGUgY2FsbGVyLg0KDQplZyBi
eSBoYXZpbmc6DQojZGVmaW5lIG1lbXNldChwLCB2LCBsKSBtZW1zZXRfdyhwLCAodikgKiAweDAx
MDEwMTAxMDEwMTAxMDEsIGwpDQoob3Igc29tZSBvdGhlciBieXRlIHJlcGxpY2F0b3IpLg0KDQpS
ZWFsbHkgYW5ub3lpbmdseSB5b3Ugd2FudCB0byB3cml0ZSB0aGUgY29kZSB0aGF0IGdlbmVyYXRl
cw0KdGhlIDY0Yml0IGNvbnN0YW50LCBhbmQgdGhlbiBoYXZlIHRoZSBjb21waWxlciBvcHRpbWlz
ZSBhd2F5DQp0aGUgcGFydCB0aGF0IGdlbmVyYXRlcyB0aGUgaGlnaCAzMiBiaXRzIG9uIDMyIGJp
dHMgc3lzdGVtcy4NCkJ1dCBvbmUgb2YgdGhlIGNvbXBpbGVycyBpcyBnb2luZyB0byAnYmxlYXQn
IGFib3V0IHRydW5jYXRpbmcNCmEgY29uc3RhbnQgdmFsdWUuDQpTdHVwaWQgY29tcGlsZXJzIChh
Z2FpbikuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

