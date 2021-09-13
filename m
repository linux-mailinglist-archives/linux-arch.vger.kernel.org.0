Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94B408A54
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbhIMLhD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 07:37:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:40534 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239171AbhIMLhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 07:37:03 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-116-XKsHmU05P0uDSHZhfMD-Lg-1; Mon, 13 Sep 2021 12:35:43 +0100
X-MC-Unique: XKsHmU05P0uDSHZhfMD-Lg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 13 Sep 2021 12:35:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 13 Sep 2021 12:35:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
CC:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: RE: [PATCH] riscv: use the generic string routines
Thread-Topic: [PATCH] riscv: use the generic string routines
Thread-Index: AQHXp2qWqgNlr7pPJkaLpUnMWph5s6uh17IQ
Date:   Mon, 13 Sep 2021 11:35:40 +0000
Message-ID: <9a8137149a164a13a7a04d72b133ad3b@AcuMS.aculab.com>
References: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
 <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
 <CAJF2gTTJ8M5FpL4=PDnPQgrrPaLxVhsZCTO2rXqaOm6MEn=gnA@mail.gmail.com>
In-Reply-To: <CAJF2gTTJ8M5FpL4=PDnPQgrrPaLxVhsZCTO2rXqaOm6MEn=gnA@mail.gmail.com>
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

PiA+IFRoZXNlIGVuZGVkIHVwIGdldHRpbmcgcmVqZWN0ZWQgYnkgTGludXMsIHNvIEknbSBnb2lu
ZyB0byBob2xkIG9mZiBvbg0KPiA+IHRoaXMgZm9yIG5vdy4gIElmIHRoZXkncmUgcmVhbGx5IG91
dCBvZiBsaWIvIHRoZW4gSSdsbCB0YWtlIHRoZSBDDQo+ID4gcm91dGluZXMgaW4gYXJjaC9yaXNj
diwgYnV0IGVpdGhlciB3YXkgaXQncyBhbiBpc3N1ZSBmb3IgdGhlIG5leHQNCj4gPiByZWxlYXNl
Lg0KPiBBZ3JlZSwgd2Ugc2hvdWxkIHRha2UgdGhlIEMgcm91dGluZSBpbiBhcmNoL3Jpc2N2IGZv
ciBjb21tb24NCj4gaW1wbGVtZW50YXRpb24uIElmIGFueSB2ZW5kb3Igd2hhdCBjdXN0b20gaW1w
bGVtZW50YXRpb24gdGhleSBjb3VsZA0KPiB1c2UgdGhlIGFsdGVybmF0aXZlIGZyYW1ld29yayBp
biBlcnJhdGEgZm9yIHN0cmluZyBvcGVyYXRpb25zLg0KDQpJIHRob3VnaCB0aGUgYXNtIG9uZXMg
d2VyZSBzaWduaWZpY2FudGx5IGZhc3RlciBiZWNhdXNlDQp0aGV5IHdlcmUgbGVzcyBhZmZlY3Rl
ZCBieSByZWFkIGxhdGVuY3kuDQoNCihCdXQgdGhleSB3ZXJlIGhvcnJpYmx5IGJyb2tlbiBmb3Ig
bWlzYWxpZ25lZCB0cmFuc2ZlcnMuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

