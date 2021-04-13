Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04A35E121
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbhDMOM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 10:12:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:28288 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245036AbhDMOM1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 10:12:27 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-278-AvhJ3iXtMyqzl2W9G4PAMw-1; Tue, 13 Apr 2021 15:12:05 +0100
X-MC-Unique: AvhJ3iXtMyqzl2W9G4PAMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 15:12:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 15:12:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>
CC:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
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
Thread-Index: AQHXMGSVFmL3q8InjEiRDqC8qAyY5Kqyacdg///5xgCAABWwYA==
Date:   Tue, 13 Apr 2021 14:12:03 +0000
Message-ID: <40d4114fa34043d0841b81d09457c415@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
 <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
 <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
 <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
 <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
In-Reply-To: <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMyBBcHJpbCAyMDIxIDE0OjQwDQo+IA0KPiBP
biBUdWUsIEFwciAxMywgMjAyMSBhdCAzOjA2IFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQXJuZCBCZXJnbWFubg0KPiA+ID4g
U2VudDogMTMgQXByaWwgMjAyMSAxMzo1OA0KPiA+IC4uLg0KPiA+ID4gVGhlIHJlbWFpbmluZyBv
bmVzIChjc2t5LCBtNjhrLCBzcGFyYzMyKSBuZWVkIHRvIGJlIGluc3BlY3RlZA0KPiA+ID4gbWFu
dWFsbHkgdG8gc2VlIGlmIHRoZXkgY3VycmVudGx5IHN1cHBvcnQgUENJIEkvTyBzcGFjZSBidXQg
aW4NCj4gPiA+IGZhY3QgdXNlIGFkZHJlc3MgemVybyBhcyB0aGUgYmFzZSAod2l0aCBsYXJnZSBy
ZXNvdXJjZXMpIG9yIHRoZXkNCj4gPiA+IHNob3VsZCBhbHNvIHR1cm4gdGhlIG9wZXJhdGlvbnMg
aW50byBhIE5PUC4NCj4gPg0KPiA+IEknZCBleHBlY3Qgc3BhcmMzMiB0byB1c2UgYW4gQVNJIHRv
IGFjY2VzcyBQQ0kgSU8gc3BhY2UuDQo+ID4gSSBjYW4ndCBxdWl0ZSByZW1lbWJlciB3aGV0aGVy
IElPIHNwYWNlIHdhcyBzdXBwb3J0ZWQgYXQgYWxsLg0KPiANCj4gSSBzZWUgdGhpcyBiaXQgaW4g
YXJjaC9zcGFyYy9rZXJuZWwvbGVvbl9wY2kuYw0KPiANCj4gICogUENJIE1lbW9yeSBhbmQgUHJl
ZmV0Y2hhYmxlIE1lbW9yeSBpcyBkaXJlY3QtbWFwcGVkLiBIb3dldmVyIEkvTyBTcGFjZSBpcw0K
PiAgKiBhY2Nlc3NlZCB0aHJvdWdoIGEgV2luZG93IHdoaWNoIGlzIHRyYW5zbGF0ZWQgdG8gbG93
IDY0S0IgaW4gUENJIHNwYWNlLCB0aGUNCj4gICogZmlyc3QgNEtCIGlzIG5vdCB1c2VkIHNvIDYw
S0IgaXMgYXZhaWxhYmxlLg0KPiAuLi4NCj4gICAgICAgICBwY2lfYWRkX3Jlc291cmNlX29mZnNl
dCgmcmVzb3VyY2VzLCAmaW5mby0+aW9fc3BhY2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5mby0+aW9fc3BhY2Uuc3RhcnQgLSAweDEwMDApOw0KPiANCj4gd2hpY2ggbWVh
bnMgdGhhdCB0aGVyZSBpcyBJL08gc3BhY2UsIHdoaWNoIGdldHMgYWNjZXNzZWQgdGhyb3VnaCB3
aGljaGV2ZXINCj4gbWV0aG9kIHJlYWRiKCkgdXNlcy4gSGF2aW5nIHRoZSBvZmZzZXQgZXF1YWwg
dG8gdGhlIHJlc291cmNlIG1lYW5zIHRoYXQNCj4gdGhlICcodm9pZCAqKTAnIHN0YXJ0IGlzIGNv
cnJlY3QuDQoNCkl0IG11c3QgaGF2ZSBiZWVuIHRoZSBWTUVidXMgKGFuZCBtYXliZSBzQnVzKSBz
cGFyYyB0aGF0IHVzZWQgYW4gQVNJLg0KDQpJIGRvIHJlbWVtYmVyIGlzc3VlcyB3aXRoIFNvbGFy
aXMgb2Ygc29tZSBQQ0kgY2FyZHMgbm90IGxpa2luZw0KYmVpbmcgYXNzaWduZWQgYSBCQVIgYWRk
cmVzcyBvZiB6ZXJvLg0KVGhhdCBtYXkgYmUgd2h5IHRoZSBsb3cgNGsgSU8gc3BhY2UgaXNuJ3Qg
YXNzaWduZWQgaGVyZS4NCihJJ3ZlIG5ldmVyIHJ1biBMaW51eCBvbiBzcGFyYywganVzdCBTVlI0
IGFuZCBTb2xhcmlzLikNCg0KSSBndWVzcyBzZXR0aW5nIFBDSV9JT0JBU0UgdG8gemVybyBpcyBz
YWZlciB3aGVuIHlvdSBjYW4ndCB0cnVzdA0KZHJpdmVycyBub3QgdG8gdXNlIGluYigpIGluc3Rl
YWQgb2YgcmVhZGIoKS4NCk9yIHdoYXRldmVyIGlvX3JlYWQoKSBlbmRzIHVwIGJlaW5nLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

