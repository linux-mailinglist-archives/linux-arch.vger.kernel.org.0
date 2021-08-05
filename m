Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826763E1014
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 10:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhHEIUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 04:20:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29828 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhHEIUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 04:20:35 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-ItXAGynfMm2D6VX6lXBPsw-1; Thu, 05 Aug 2021 09:20:16 +0100
X-MC-Unique: ItXAGynfMm2D6VX6lXBPsw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 5 Aug 2021 09:20:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 5 Aug 2021 09:20:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "mcroce@linux.microsoft.com" <mcroce@linux.microsoft.com>,
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
Thread-Index: AQHXiXDwMuHx//JaRE+MHXqCWo1pFatkkT8w
Date:   Thu, 5 Aug 2021 08:20:15 +0000
Message-ID: <b8d9437cae2248c7a2cb6244f5d760ec@AcuMS.aculab.com>
References: <CAFnufp1QpMc87+-hwPa887iQQGCjjkGNanVSKOUsE-0ti82jrA@mail.gmail.com>
 <mhng-7b8d3a12-e223-4b69-a35a-617b0d7ac8f7@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7b8d3a12-e223-4b69-a35a-617b0d7ac8f7@palmerdabbelt-glaptop>
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

RnJvbTogUGFsbWVyIERhYmJlbHQNCj4gU2VudDogMDQgQXVndXN0IDIwMjEgMjE6NDANCj4gDQo+
IE9uIFR1ZSwgMDMgQXVnIDIwMjEgMDk6NTQ6MzQgUERUICgtMDcwMCksIG1jcm9jZUBsaW51eC5t
aWNyb3NvZnQuY29tIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDE5LCAyMDIxIGF0IDE6NDQgUE0g
TWF0dGVvIENyb2NlIDxtY3JvY2VAbGludXgubWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4+DQo+
ID4+IEZyb206IE1hdHRlbyBDcm9jZSA8bWNyb2NlQG1pY3Jvc29mdC5jb20+DQo+ID4+DQo+ID4+
IFVzZSB0aGUgZ2VuZXJpYyByb3V0aW5lcyB3aGljaCBoYW5kbGUgYWxpZ25tZW50IHByb3Blcmx5
Lg0KPiA+Pg0KPiA+PiBUaGVzZSBhcmUgdGhlIHBlcmZvcm1hbmNlcyBtZWFzdXJlZCBvbiBhIEJl
YWdsZVYgbWFjaGluZSBmb3IgYQ0KPiA+PiAzMiBtYnl0ZSBidWZmZXI6DQo+ID4+DQo+ID4+IG1l
bWNweToNCj4gPj4gb3JpZ2luYWwgYWxpZ25lZDogICAgICAgIDc1IE1iL3MNCj4gPj4gb3JpZ2lu
YWwgdW5hbGlnbmVkOiAgICAgIDc1IE1iL3MNCj4gPj4gbmV3IGFsaWduZWQ6ICAgICAgICAgICAg
MTE0IE1iL3MNCj4gPj4gbmV3IHVuYWxpZ25lZDogICAgICAgICAgMTA3IE1iL3MNCj4gPj4NCj4g
Pj4gbWVtc2V0Og0KPiA+PiBvcmlnaW5hbCBhbGlnbmVkOiAgICAgICAxNDAgTWIvcw0KPiA+PiBv
cmlnaW5hbCB1bmFsaWduZWQ6ICAgICAxNDAgTWIvcw0KPiA+PiBuZXcgYWxpZ25lZDogICAgICAg
ICAgICAyNDEgTWIvcw0KPiA+PiBuZXcgdW5hbGlnbmVkOiAgICAgICAgICAyNDEgTWIvcw0KPiA+
Pg0KPiA+PiBUQ1AgdGhyb3VnaHB1dCB3aXRoIGlwZXJmMyBnaXZlcyBhIHNpbWlsYXIgaW1wcm92
ZW1lbnQgYXMgd2VsbC4NCj4gPj4NCj4gPj4gVGhpcyBpcyB0aGUgYmluYXJ5IHNpemUgaW5jcmVh
c2UgYWNjb3JkaW5nIHRvIGJsb2F0LW8tbWV0ZXI6DQo+ID4+DQo+ID4+IGFkZC9yZW1vdmU6IDAv
MCBncm93L3NocmluazogNC8yIHVwL2Rvd246IDQzMi8tMzYgKDM5NikNCj4gPj4gRnVuY3Rpb24g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2xkICAgICBuZXcgICBkZWx0YQ0K
PiA+PiBtZW1jcHkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzYgICAg
IDMyNCAgICArMjg4DQo+ID4+IG1lbXNldCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAzMiAgICAgMTQ4ICAgICsxMTYNCj4gPj4gc3RybGNweSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMTE2ICAgICAxMzIgICAgICsxNg0KPiA+PiBzdHJzY3B5X3Bh
ZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgODQgICAgICA5NiAgICAgKzEyDQo+
ID4+IHN0cmxjYXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE3NiAgICAg
MTY0ICAgICAtMTINCj4gPj4gbWVtbW92ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDc2ICAgICAgNTIgICAgIC0yNA0KPiA+PiBUb3RhbDogQmVmb3JlPTEyMjUzNzEsIEFm
dGVyPTEyMjU3NjcsIGNoZyArMC4wMyUNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWF0dGVv
IENyb2NlIDxtY3JvY2VAbWljcm9zb2Z0LmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRW1pbCBS
ZW5uZXIgQmVydGhpbmcgPGtlcm5lbEBlc21pbC5kaz4NCj4gPj4gLS0tDQo+ID4NCj4gPiBIaSwN
Cj4gPg0KPiA+IGNhbiBzb21lb25lIGhhdmUgYSBsb29rIGF0IHRoaXMgY2hhbmdlIGFuZCBzaGFy
ZSBvcGluaW9ucz8NCj4gDQo+IFRoaXMgTEdUTS4gIEhvdyBhcmUgdGhlIGdlbmVyaWMgc3RyaW5n
IHJvdXRpbmVzIGxhbmRpbmc/ICBJJ20gaGFwcHkgdG8NCj4gdGFrZSB0aGlzIGludG8gbXkgZm9y
LW5leHQsIGJ1dCBJSVVDIHdlIG5lZWQgdGhlIG9wdGltaXplZCBnZW5lcmljDQo+IHZlcnNpb25z
IGZpcnN0IHNvIHdlIGRvbid0IGhhdmUgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZhbGxpbmcg
YmFjayB0bw0KPiB0aGUgdHJpdmlhbCBvbmVzIGZvciBhIGJpdC4gIElzIHRoZXJlIGEgc2hhcmVk
IHRhZyBJIGNhbiBwdWxsIGluPw0KDQpJIHRob3VnaHQgdGhlIGFjdHVhbCBwcm9ibGVtIHdhcyB0
aGF0IHRoZSBhc20gY29weSBmdW5jdGlvbnMgd2VyZQ0KZG9pbmcgbWlzYWxpZ25lZCB0cmFuc2Zl
cnMgYW5kIGZhdWx0aW5nLg0KDQpUaGVyZSBpcyBubyB3YXkgdGhhdCB0aGUgc2ltcGxlIEMgbG9v
cCBzaG91bGQgYmUgYXMgZmFzdCBhcw0KdGhlIGFzbSBmdW5jdGlvbiBnaXZlbiB0aGUgZGVsYXkg
Y3ljbGVzIHJlYWRpbmcgZnJvbSBtZW1vcnkuDQoNCllvdSBkZWZpbml0ZWx5IG5lZWQgdG8gdGVz
dCBtdWNoIHNtYWxsZXIgY29waWVzIHdoZXJlIHRoZQ0KYnVmZmVycyBhcmUgcmVzaWRlbnQgaW4g
dGhlIEwxIGRhdGEgY2FjaGUuDQpBbnl0aGluZyBlbHNlIGlzIGNvbXBsZXRlbHkgZG9taW5hdGVk
IGJ5IHRoZSBjYWNoZSBsaW5lIGZpbGxzL3NwaWxscy4NCg0KWW91IGFsc28gbmVlZCB0byB0ZXN0
IG9uIHRoZSBtdWNoIGZhc3RlciByaXNjdiBpbXBsZW1lbnRhdGlvbnMNCm5vdCBqdXN0IG9uIHRo
ZSBiZWFnbGV2IGJvYXJkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

