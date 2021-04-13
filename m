Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4335DF87
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhDMM5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 08:57:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44465 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhDMM5I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 08:57:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-ltlbnxZ9N6qogcWxar3evA-1; Tue, 13 Apr 2021 13:56:45 +0100
X-MC-Unique: ltlbnxZ9N6qogcWxar3evA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 13:56:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 13:56:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: RE: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
Thread-Topic: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
Thread-Index: AQHXMGBrFmL3q8InjEiRDqC8qAyY5KqyZ1tA
Date:   Tue, 13 Apr 2021 12:56:44 +0000
Message-ID: <2783670cf610467ca19fd5abcad5a747@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
In-Reply-To: <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMyBBcHJpbCAyMDIxIDEzOjI3DQo+IA0KPiBP
biBUdWUsIEFwciAxMywgMjAyMSBhdCAxOjU0IFBNIE5pa2xhcyBTY2huZWxsZSA8c2NobmVsbGVA
bGludXguaWJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIFBDSV9JT0JBU0UgaXMgbm90IGRl
ZmluZWQsIGl0IGlzIHNldCB0byAwIHN1Y2ggdGhhdCBpdCBpcyBpZ25vcmVkDQo+ID4gaW4gY2Fs
bHMgdG8gdGhlIHJlYWRYL3dyaXRlWCBwcmltaXRpdmVzLiBXaGlsZSBtYXRoZW1hdGljYWxseSBv
YnZpb3VzDQo+ID4gdGhpcyB0cmlnZ2VycyBjbGFuZydzIC1XbnVsbC1wb2ludGVyLWFyaXRobWV0
aWMgd2FybmluZy4NCj4gDQo+IEluZGVlZCwgdGhpcyBpcyBhbiBhbm5veWluZyB3YXJuaW5nLg0K
PiANCj4gPiBBbiBhZGRpdGlvbmFsIGNvbXBsaWNhdGlvbiBpcyB0aGF0IFBDSV9JT0JBU0UgaXMg
ZXhwbGljaXRseSB0eXBlZCBhcw0KPiA+ICJ2b2lkIF9faW9tZW0gKiIgd2hpY2ggY2F1c2VzIHRo
ZSB0eXBlIGNvbnZlcnNpb24gdGhhdCBjb252ZXJ0cyB0aGUNCj4gPiAidW5zaWduZWQgbG9uZyIg
cG9ydC9hZGRyIHBhcmFtZXRlcnMgdG8gdGhlIGFwcHJvcHJpYXRlIHBvaW50ZXIgdHlwZS4NCj4g
PiBBcyBub24gcG9pbnRlciB0eXBlcyBhcmUgdXNlZCBieSBkcml2ZXJzIGF0IHRoZSBjYWxsc2l0
ZSBzaW5jZSB0aGVzZSBhcmUNCj4gPiBkZWFsaW5nIHdpdGggSS9PIHBvcnQgbnVtYmVycywgY2hh
bmdpbmcgdGhlIHBhcmFtZXRlciB0eXBlIHdvdWxkIGNhdXNlDQo+ID4gZnVydGhlciB3YXJuaW5n
cyBpbiBkcml2ZXJzLiBJbnN0ZWFkIHVzZSAidWludHB0cl90IiBmb3IgUENJX0lPQkFTRQ0KPiA+
IDAgYW5kIGV4cGxpY2l0bHkgY2FzdCB0byAidm9pZCBfX2lvbWVtICoiIHdoZW4gY2FsbGluZyBy
ZWFkWC93cml0ZVguDQoNClNpbmNlIHRoZSBkZWZpbml0aW9ucyBtYWtlIG5vIHNlbnNlIHdoZW4g
UENJX0lPQkFTRSBpbiB1bmRlZmluZWQNCm1heWJlIHRoZSBmdW5jdGlvbnMgc2hvdWxkIGVpdGhl
ciBub3QgYmUgZGVmaW5lZCwgYmUgc3R1YnMgdGhhdA0KZG8gbm90aGluZyBvciBzdHVicyB0aGF0
IGFyZSBCVUcoKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

