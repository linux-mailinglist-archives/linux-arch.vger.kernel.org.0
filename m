Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8819835DFBC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbhDMNHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 09:07:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52770 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343958AbhDMNHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 09:07:12 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-41-32ADAULqOdK603jqA7XY6g-1; Tue, 13 Apr 2021 14:06:50 +0100
X-MC-Unique: 32ADAULqOdK603jqA7XY6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 14:06:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 14:06:50 +0100
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
Thread-Index: AQHXMGSVFmL3q8InjEiRDqC8qAyY5Kqyacdg
Date:   Tue, 13 Apr 2021 13:06:49 +0000
Message-ID: <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
 <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
 <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
In-Reply-To: <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMyBBcHJpbCAyMDIxIDEzOjU4DQouLi4NCj4g
VGhlIHJlbWFpbmluZyBvbmVzIChjc2t5LCBtNjhrLCBzcGFyYzMyKSBuZWVkIHRvIGJlIGluc3Bl
Y3RlZA0KPiBtYW51YWxseSB0byBzZWUgaWYgdGhleSBjdXJyZW50bHkgc3VwcG9ydCBQQ0kgSS9P
IHNwYWNlIGJ1dCBpbg0KPiBmYWN0IHVzZSBhZGRyZXNzIHplcm8gYXMgdGhlIGJhc2UgKHdpdGgg
bGFyZ2UgcmVzb3VyY2VzKSBvciB0aGV5DQo+IHNob3VsZCBhbHNvIHR1cm4gdGhlIG9wZXJhdGlv
bnMgaW50byBhIE5PUC4NCg0KSSdkIGV4cGVjdCBzcGFyYzMyIHRvIHVzZSBhbiBBU0kgdG8gYWNj
ZXNzIFBDSSBJTyBzcGFjZS4NCkkgY2FuJ3QgcXVpdGUgcmVtZW1iZXIgd2hldGhlciBJTyBzcGFj
ZSB3YXMgc3VwcG9ydGVkIGF0IGFsbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

