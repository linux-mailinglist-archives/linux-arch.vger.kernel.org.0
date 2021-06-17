Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E43ABE20
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFQVcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 17:32:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24226 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231168AbhFQVcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 17:32:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-Sn8vyFVWOEeBXSXssr6CKA-1; Thu, 17 Jun 2021 22:30:07 +0100
X-MC-Unique: Sn8vyFVWOEeBXSXssr6CKA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 17 Jun
 2021 22:30:06 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Thu, 17 Jun 2021 22:30:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        Guo Ren <guoren@kernel.org>
CC:     linux-riscv <linux-riscv@lists.infradead.org>,
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
Thread-Index: AQHXYuC4XkdMIImxVUmoQbZ37iIZIqsYtSAg
Date:   Thu, 17 Jun 2021 21:30:06 +0000
Message-ID: <f9b78350d9504e889813fc47df41f3fe@AcuMS.aculab.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com>
 <CAJF2gTTreOvQYYXHBYxznB9+vMaASKg8vwA5mkqVo1T6=eVhzw@mail.gmail.com>
 <CAFnufp1OHdRd-tbB+Hi0UnXARtxGPdkK6MJktnaNCNt65d3Oew@mail.gmail.com>
In-Reply-To: <CAFnufp1OHdRd-tbB+Hi0UnXARtxGPdkK6MJktnaNCNt65d3Oew@mail.gmail.com>
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

RnJvbTogTWF0dGVvIENyb2NlDQo+IFNlbnQ6IDE2IEp1bmUgMjAyMSAxOTo1Mg0KPiBUbzogR3Vv
IFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+DQo+IA0KPiBPbiBXZWQsIEp1biAxNiwgMjAyMSBhdCAx
OjQ2IFBNIEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpIE1h
dHRlbywNCj4gPg0KPiA+IEhhdmUgeW91IHRyaWVkIEdsaWJjIGdlbmVyaWMgaW1wbGVtZW50YXRp
b24gY29kZT8NCj4gPiByZWY6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFyY2gvMjAx
OTA2MjkwNTM2NDEuM2lCZms5LQ0KPiBJX0QyOWNEcDl5Sm5JZElnN29NdEhOWmxEbWhMUVBUdW1o
RWNAei8jdA0KPiA+DQo+ID4gSWYgR2xpYmMgY29kZXMgaGF2ZSB0aGUgc2FtZSBwZXJmb3JtYW5j
ZSBpbiB5b3VyIGhhcmR3YXJlLCB0aGVuIHlvdQ0KPiA+IGNvdWxkIGdpdmUgYSBnZW5lcmljIGlt
cGxlbWVudGF0aW9uIGZpcnN0Lg0KDQpJc24ndCB0aGF0IGEgYnl0ZSBjb3B5IGxvb3AgLSB0aGUg
cGVyZm9ybWFuY2Ugb2YgdGhhdCBvdWdodCB0byBiZSB0ZXJyaWJsZS4NCi4uLg0KDQo+IEkgaGFk
IGEgbG9vaywgaXQgc2VlbXMgdGhhdCBpdCdzIGEgQyB1bnJvbGxlZCB2ZXJzaW9uIHdpdGggdGhl
DQo+ICdyZWdpc3Rlcicga2V5d29yZC4NCj4gVGhlIHNhbWUgb25lIHdhcyBhbHJlYWR5IG1lcmdl
ZCBpbiBuaW9zMjoNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9hcmNoL25pb3MyL2xpYi9tZW1jcHkuYyNMNjgNCg0KSSBrbm93IGEgbG90IGFib3V0IHRo
ZSBuaW9zMiBpbnN0cnVjdGlvbiB0aW1pbmdzLg0KKEkndmUgbG9va2VkIGF0IGNvZGUgZXhlY3V0
aW9uIGluIHRoZSBmcGdhJ3MgaW50ZWwgJ2xvZ2ljIGFuYWxpc2VyLikNCkl0IGlzIGEgdmVyeSBz
aW1wbGUgNC1jbG9jayBwaXBlbGluZSBjcHUgd2l0aCBhIDItY2xvY2sgZGVsYXkNCmJlZm9yZSBh
IHZhbHVlIHJlYWQgZnJvbSAndGlnaHRseSBjb3VwbGVkIG1lbW9yeScgKGFrYSBjYWNoZSkNCmNh
biBiZSB1c2VkIGluIGFub3RoZXIgaW5zdHJ1Y3Rpb24uDQpUaGVyZSBpcyBhbHNvIGEgc3VidGxl
IHBpcGVsaW5lIHN0YWxsIGlmIGEgcmVhZCBmb2xsb3dzIGEgd3JpdGUNCnRvIHRoZSBzYW1lIG1l
bW9yeSBibG9jayBiZWNhdXNlIHRoZSB3cml0ZSBpcyBleGVjdXRlZCBvbmUNCmNsb2NrIGxhdGVy
IC0gYW5kIHdvdWxkIGNvbGxpZGUgd2l0aCB0aGUgcmVhZC4NClNpbmNlIGl0IG9ubHkgZXZlciBl
eGVjdXRlcyBvbmUgaW5zdHJ1Y3Rpb24gcGVyIGNsb2NrIGxvb3ANCnVucm9sbGluZyBkb2VzIGhl
bHAgLSBzaW5jZSB5b3UgbmV2ZXIgZ2V0IHRoZSBsb29wIGNvbnRyb2wgJ2ZvciBmcmVlJy4NCk9U
T0ggeW91IGRvbid0IG5lZWQgdG8gdXNlIHRoYXQgbWFueSByZWdpc3RlcnMuDQpCdXQgYW4gdW5y
b2xsZWQgbG9vcCBzaG91bGQgYXBwcm9hY2ggMiBieXRlcy9jbG9jayAoMzJiaXQgY3B1KS4NCg0K
PiBJIGNvcGllZCBfd29yZGNvcHlfZndkX2FsaWduZWQoKSBmcm9tIEdsaWJjLCBhbmQgSSBoYXZl
IGEgdmVyeSBzaW1pbGFyDQo+IHJlc3VsdCBvZiB0aGUgb3RoZXIgdmVyc2lvbnM6DQo+IA0KPiBb
ICA1NjMuMzU5MTI2XSBTdHJpbmdzIHNlbGZ0ZXN0OiBtZW1jcHkoc3JjKzcsIGRzdCs3KTogMjU3
IE1iL3MNCg0KV2hhdCBjbG9jayBzcGVlZCBpcyB0aGF0IHJ1bm5pbmcgYXQ/DQpJdCBzZWVtcyB2
ZXJ5IHNsb3cgZm9yIGEgNjRiaXQgY3B1ICh0aGF0IGlzbid0IGFuIGZwZ2Egc29mdC1jcHUpLg0K
DQpXaGlsZSB0aGUgc21hbGwgcmlzY3YgY3B1IG1pZ2h0IGJlIHNpbWlsYXIgdG8gdGhlIG5pb3My
IChhbmQgbWlwcw0KZm9yIHRoYXQgbWF0dGVyKSwgdGhlcmUgYXJlIGFsc28gYmlnZ2VyL2Zhc3Rl
ciBjcHUuDQpJJ20gc3VyZSB0aGVzZSBjYW4gZXhlY3V0ZSBtdWx0aXBsZSBpbnN0cnVjdGlvbnMv
Y2xvY2sNCmFuZCBwb3NzaWJsZSBldmVuIHJlYWQgYW5kIHdyaXRlIGF0IHRoZSBzYW1lIHRpbWUu
DQpVbmxlc3MgdGhleSBhbHNvIHN1cHBvcnQgc2lnbmlmaWNhbnQgaW5zdHJ1Y3Rpb24gcmUtb3Jk
ZXJpbmcNCnRoZSB0cml2aWFsIGNvcHkgbG9vcHMgYXJlIGdvaW5nIHRvIGJlIHNsb3cgb24gc3Vj
aCBjcHUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

