Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2573A7F0C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFONUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:20:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53683 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhFONUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 09:20:41 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-4Fuj9aaaNA-wL3sLBMdlZw-1; Tue, 15 Jun 2021 14:18:34 +0100
X-MC-Unique: 4Fuj9aaaNA-wL3sLBMdlZw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 14:18:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 15 Jun 2021 14:18:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bin Meng' <bmeng.cn@gmail.com>
CC:     Matteo Croce <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        "Drew Fustini" <drew@beagleboard.org>
Subject: RE: [PATCH 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH 1/3] riscv: optimized memcpy
Thread-Index: AQHXYY/3XkdMIImxVUmoQbZ37iIZIqsUw3iggAA3zwCAABG+cA==
Date:   Tue, 15 Jun 2021 13:18:33 +0000
Message-ID: <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com>
 <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
In-Reply-To: <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
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

RnJvbTogQmluIE1lbmcNCj4gU2VudDogMTUgSnVuZSAyMDIxIDE0OjA5DQo+IA0KPiBPbiBUdWUs
IEp1biAxNSwgMjAyMSBhdCA0OjU3IFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxh
Yi5jb20+IHdyb3RlOg0KPiA+DQouLi4NCj4gPiBJJ20gc3VycHJpc2VkIHRoYXQgdGhlIEMgbG9v
cDoNCj4gPg0KPiA+ID4gKyAgICAgICAgICAgICBmb3IgKDsgY291bnQgPj0gYnl0ZXNfbG9uZzsg
Y291bnQgLT0gYnl0ZXNfbG9uZykNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAqZC51bG9u
ZysrID0gKnMudWxvbmcrKzsNCj4gPg0KPiA+IGVuZHMgdXAgYmVpbmcgZmFzdGVyIHRoYW4gdGhl
IEFTTSAncmVhZCBsb3RzJyAtICd3cml0ZSBsb3RzJyBsb29wLg0KPiANCj4gSSBiZWxpZXZlIHRo
YXQncyBiZWNhdXNlIHRoZSBhc3NlbWJseSB2ZXJzaW9uIGhhcyBzb21lIHVuYWxpZ25lZA0KPiBh
Y2Nlc3MgY2FzZXMsIHdoaWNoIGVuZCB1cCBiZWluZyB0cmFwLW4tZW11bGF0ZWQgaW4gdGhlIE9w
ZW5TQkkNCj4gZmlybXdhcmUsIGFuZCB0aGF0IGlzIGEgYmlnIG92ZXJoZWFkLg0KDQpBaCwgdGhh
dCB3b3VsZCBtYWtlIHNlbnNlIHNpbmNlIHRoZSBhc20gdXNlciBjb3B5IGNvZGUNCndhcyBicm9r
ZW4gZm9yIG1pc2FsaWduZWQgY29waWVzLg0KSSBzdXNwZWN0IG1lbWNweSgpIHdhcyBicm9rZW4g
dGhlIHNhbWUgd2F5Lg0KDQpJJ20gc3VycHJpc2VkIElQX05FVF9BTElHTiBpc24ndCBzZXQgdG8g
MiB0byB0cnkgdG8NCmF2b2lkIGFsbCB0aGVzZSBtaXNhbGlnbmVkIGNvcGllcyBpbiB0aGUgbmV0
d29yayBzdGFjay4NCkFsdGhvdWdoIGF2b2lkaW5nIDhuKzQgYWxpZ25lZCBkYXRhIGlzIHJhdGhl
ciBoYXJkZXIuDQoNCk1pc2FsaWduZWQgY29waWVzIGFyZSBqdXN0IGJlc3QgYXZvaWRlZCAtIHJl
YWxseSBldmVuIG9uIHg4Ni4NClRoZSAncmVhbCBmdW4nIGlzIHdoZW4gdGhlIGFjY2VzcyBjcm9z
c2VzIFRMQiBib3VuZGFyaWVzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

