Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5F3DD21E
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhHBIhQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 04:37:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58772 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232656AbhHBIhQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 04:37:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-162-VSQlMBHJP8uFUMwjOp7oTQ-1; Mon, 02 Aug 2021 09:37:05 +0100
X-MC-Unique: VSQlMBHJP8uFUMwjOp7oTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 2 Aug 2021 09:37:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 2 Aug 2021 09:37:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [Question] Alignment requirement for readX() and writeX()
Thread-Topic: [Question] Alignment requirement for readX() and writeX()
Thread-Index: AQHXhWQsVwxTTLVBq060hnEUvvCVsqtf5hLQ
Date:   Mon, 2 Aug 2021 08:37:02 +0000
Message-ID: <7353d0d46f9f4a908b73ac0ff1c070fc@AcuMS.aculab.com>
References: <YQQr+twAYHk2jXs6@boqun-archlinux>
 <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
In-Reply-To: <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAzMCBKdWx5IDIwMjEgMTc6NTkNCi4uLg0KPiBJ
IGFtIG5vdCBhd2FyZSBvZiBhbnkgZHJpdmVyIHRoYXQgcmVxdWlyZXMgdW5hbGlnbmVkIGFjY2Vz
cyBvbiBfX2lvbWVtDQo+IHBvaW50ZXJzLCBhbmQgc2luY2UgaXQgZGVmaW5pdGVseSBkb2Vzbid0
IHdvcmsgb24gbW9zdCBhcmNoaXRlY3R1cmVzLCAuLi4NCg0KVW5hbGlnbmVkIGFjY2Vzc2VzIGlu
dG8gUENJZSBzcGFjZSBjYW4gZ2VuZXJhdGUgYSBUTFAgdGhhdCByZXF1ZXN0cw0Kb25seSBzb21l
IGJ5dGVzIG9mIHRoZSBmaXJzdCBhbmQgbGFzdCAzMmJpdCB3b3JkcyBiZSB0cmFuc2ZlcnJlZC4N
ClRoZSB0YXJnZXQgaXMgZXhwZWN0ZWQgdG8gaG9ub3VyIHN1Y2ggcmVxdWVzdHMuDQoNCk9uIHRo
ZSB4ODYgc3lzdGVtcyB3aGVyZSBJJ3ZlIGxvb2tlZCBhdCBhIFRMUCB0cmFjZSBtaXNhbGlnbmVk
DQphY2Nlc3NlcyBhcmUgZXZlbiBhdG9taWMgcHJvdmlkZWQgdGhlIHRhcmdldCBkb2Vzbid0IGxl
dCBhIGxvY2FsDQpyZXF1ZXN0IGludGVybGVhdmUuDQoNCk9UT0ggZHJpdmVycyBhcmUgdW5saWtl
bHkgdG8gbWFrZSBzdWNoIHJlcXVlc3RzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

