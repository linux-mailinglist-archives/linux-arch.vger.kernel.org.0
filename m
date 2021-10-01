Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56941E8AD
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbhJAIID (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 04:08:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:26261 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352618AbhJAIIC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 04:08:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-34-W05ZMRukNYqLxn2NGHWQgw-1; Fri, 01 Oct 2021 09:06:14 +0100
X-MC-Unique: W05ZMRukNYqLxn2NGHWQgw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 1 Oct 2021 09:06:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 1 Oct 2021 09:06:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vineet Gupta' <vgupta@kernel.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Guo Ren <guoren@kernel.org>
CC:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: RE: [PATCH v5 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH v5 1/3] riscv: optimized memcpy
Thread-Index: AQHXtjOD+7ayCntxxUO0SHdTnQy2G6u9yEmA
Date:   Fri, 1 Oct 2021 08:06:13 +0000
Message-ID: <63ab9e73cb58404c99e271b11b2b5bf5@AcuMS.aculab.com>
References: <20210929172234.31620-1-mcroce@linux.microsoft.com>
 <20210929172234.31620-2-mcroce@linux.microsoft.com>
 <CAJF2gTRSVeUOwmaUcpMJL+jOofvX5iWLRLCfMajQcut_T409qA@mail.gmail.com>
 <CAFnufp1wHVY-yoUUDxT1mhv8HV=cmHZSwMP+8r-2CzNAYEn4DQ@mail.gmail.com>
 <a9ce9ea2-9e5d-0e56-d980-5dedd087f62d@kernel.org>
In-Reply-To: <a9ce9ea2-9e5d-0e56-d980-5dedd087f62d@kernel.org>
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

Li4uDQo+IEJUVyBvZmYgdG9waWMgKGJ1dCByZWxldmFudCB0byB0aGlzIHBhdGNoc2V0KSwgSSBz
dHJvbmdseSBmZWVsIHRoYXQNCj4gcm91dGluZXMgbGlrZSBtZW1zZXQvbWVtY3B5IGFyZSBiZXR0
ZXIgY29kZWQgaW4gYXNzZW1ibHkgZm9yIHJlYWxseQ0KPiB3YXRlciB0aWdodCBpbnN0cnVjdGlv
biBzY2hlZHVsaW5nIGFuZCBlYXNlIG9mIGZ1cnRoZXIgb3B0aW1pemluZyAoZS5nLg0KPiB1c2Ug
b2YgQ01PLnplcm8gZXRjIGFzIGV4cGVyaW1lbnRlZCBieSBQaGlsaXBwKS4gV2hhdCBpcyBibG9j
a2luZyB5b3UNCj4gZnJvbSBvcHRpbWl6aW5nIHRoZSBhc20gdmVyc2lvbiA/IFlvdSBhcmUgbGVh
dmluZyB0aGUgZmF0ZSBvZiB0aGVzZQ0KPiBjcml0aWNhbCByb3V0aW5lcyBpbiB0aGUgaGFuZCBv
ZiBjb21waWxlciAtIHRoaXMgY2FuIGxlYWQgdG8gcGVyZm9ybWFuY2UNCj4gc2hlbmFuaWdhbnMg
b24gYSBiaWcgZ2NjIHVwZ3JhZGUuDQoNCllvdSBhbHNvIG5lZWQgdG8gd29ycnkgYWJvdXQgdGhl
IGNvc3Qgb2Ygc2hvcnQgdHJhbnNmZXJzLg0KQSBmZXcgY3ljbGVzIHRoZXJlIGNvdWxkIGhhdmUg
YSBtdWNoIGJpZ2dlciBkaWZmZXJlbmNlDQp0aGF0IHNvbWV0aGluZyB0aGF0IHNwZWVkcyB1cCBs
b25nIHRyYW5zZmVycy4NClNob3J0IG9uZXMgYXJlIGxpa2VseSB0byBiZSBmYWlybHkgY29tbW9u
Lg0KSSBkb3VidCB0aGUgbG9vcCB1bnJvbGxpbmcgb3B0aW1pc2F0aW9uIGluIGdjYyBpcyBhY3R1
YWxseQ0KYW55IGdvb2QgZm9yIGxvb3BzIHRoYXQgbWlnaHQgYmUgZG9uZSBhIGZldyB0aW1lcy4N
Cg0KRm9ydHVuYXRlbHkgdGhlIGtlcm5lbCBkb2Vzbid0IGdldCAnaGl0IGJ5JyBnY2MgdW5yb2xs
aW5nDQpsb29wcyBpbnRvIHRoZSBBVlggaW5zdHJ1Y3Rpb25zLg0KVGhlIHNldHVwIGNvc3RzIGZv
ciB0aGF0IChhbmQgSS1jYWNoZSBmb290cHJpbnQpIGFyZSBob3JyaWQuDQpBbHRob3VnaCBJIHN1
c3BlY3QgaXQgaXMgdGhhdCBvcHRpbWlzYXRpb24gdGhhdCAnYnJva2UnDQpjb2RlIHRoYXQgdXNl
ZCBtaXNhbGlnbmVkIHBvaW50ZXJzIG9uIG92ZXJsYXBwaW5nIGRhdGEuDQoNCkl0IGlzIGEgZ2Vu
ZXJhbCBwcm9ibGVtIHdpdGggdGhlICdvbmUgc2l6ZSBmaXRzIGFsbCcgbWVtY3B5KCkuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

