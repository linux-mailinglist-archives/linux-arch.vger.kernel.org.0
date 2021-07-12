Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82873C5687
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357723AbhGLITp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 04:19:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:42960 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhGLISe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 04:18:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-16XOylRrMuGIO2YWwYe6Qg-1; Mon, 12 Jul 2021 09:15:43 +0100
X-MC-Unique: 16XOylRrMuGIO2YWwYe6Qg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Mon, 12 Jul 2021 09:15:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 12 Jul 2021 09:15:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 0/3] lib/string: optimized mem* functions
Thread-Topic: [PATCH v2 0/3] lib/string: optimized mem* functions
Thread-Index: AQHXdeB//rSAJETS7k2opSDlamOLfqs+/N5w
Date:   Mon, 12 Jul 2021 08:15:41 +0000
Message-ID: <af19820cd24544cd8833d6db6d38154b@AcuMS.aculab.com>
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
 <20210710143109.fd5062902ef4d5d59e83f5bb@linux-foundation.org>
 <CAFnufp1d+FH1K5QAx+Z=KvMUvrveJAVnjJJc8xoDCn2wmzUOoQ@mail.gmail.com>
In-Reply-To: <CAFnufp1d+FH1K5QAx+Z=KvMUvrveJAVnjJJc8xoDCn2wmzUOoQ@mail.gmail.com>
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

RnJvbTogTWF0dGVvIENyb2NlDQo+IFNlbnQ6IDExIEp1bHkgMjAyMSAwMDowOA0KPiANCj4gT24g
U2F0LCBKdWwgMTAsIDIwMjEgYXQgMTE6MzEgUE0gQW5kcmV3IE1vcnRvbg0KPiA8YWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksICAyIEp1bCAyMDIxIDE0
OjMxOjUwICswMjAwIE1hdHRlbyBDcm9jZSA8bWNyb2NlQGxpbnV4Lm1pY3Jvc29mdC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBNYXR0ZW8gQ3JvY2UgPG1jcm9jZUBtaWNyb3NvZnQuY29t
Pg0KPiA+ID4NCj4gPiA+IFJld3JpdGUgdGhlIGdlbmVyaWMgbWVte2NweSxtb3ZlLHNldH0gc28g
dGhhdCBtZW1vcnkgaXMgYWNjZXNzZWQgd2l0aA0KPiA+ID4gdGhlIHdpZGVzdCBzaXplIHBvc3Np
YmxlLCBidXQgd2l0aG91dCBkb2luZyB1bmFsaWduZWQgYWNjZXNzZXMuDQo+ID4gPg0KPiA+ID4g
VGhpcyB3YXMgb3JpZ2luYWxseSBwb3N0ZWQgYXMgQyBzdHJpbmcgZnVuY3Rpb25zIGZvciBSSVND
LVZbMV0sIGJ1dCBhcw0KPiA+ID4gdGhlcmUgd2FzIG5vIHNwZWNpZmljIFJJU0MtViBjb2RlLCBp
dCB3YXMgcHJvcG9zZWQgZm9yIHRoZSBnZW5lcmljDQo+ID4gPiBsaWIvc3RyaW5nLmMgaW1wbGVt
ZW50YXRpb24uDQo+ID4gPg0KPiA+ID4gVGVzdGVkIG9uIFJJU0MtViBhbmQgb24geDg2XzY0IGJ5
IHVuZGVmaW5pbmcgX19IQVZFX0FSQ0hfTUVNe0NQWSxTRVQsTU9WRX0NCj4gPiA+IGFuZCBIQVZF
X0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTLg0KPiA+ID4NCj4gPiA+IFRoZXNlIGFyZSB0aGUg
cGVyZm9ybWFuY2VzIG9mIG1lbWNweSgpIGFuZCBtZW1zZXQoKSBvZiBhIFJJU0MtViBtYWNoaW5l
DQo+ID4gPiBvbiBhIDMyIG1ieXRlIGJ1ZmZlcjoNCj4gPiA+DQo+ID4gPiBtZW1jcHk6DQo+ID4g
PiBvcmlnaW5hbCBhbGlnbmVkOiAgICAgIDc1IE1iL3MNCj4gPiA+IG9yaWdpbmFsIHVuYWxpZ25l
ZDogICAgNzUgTWIvcw0KPiA+ID4gbmV3IGFsaWduZWQ6ICAgICAgICAgIDExNCBNYi9zDQo+ID4g
PiBuZXcgdW5hbGlnbmVkOiAgICAgICAgICAgICAgICAxMDcgTWIvcw0KPiA+ID4NCj4gPiA+IG1l
bXNldDoNCj4gPiA+IG9yaWdpbmFsIGFsaWduZWQ6ICAgICAxNDAgTWIvcw0KPiA+ID4gb3JpZ2lu
YWwgdW5hbGlnbmVkOiAgIDE0MCBNYi9zDQo+ID4gPiBuZXcgYWxpZ25lZDogICAgICAgICAgMjQx
IE1iL3MNCj4gPiA+IG5ldyB1bmFsaWduZWQ6ICAgICAgICAgICAgICAgIDI0MSBNYi9zDQo+ID4N
Cj4gPiBEaWQgeW91IHJlY29yZCB0aGUgeDg2XzY0IHBlcmZvcm1hbmNlPw0KPiA+DQo+ID4NCj4g
PiBXaGljaCBvdGhlciBhcmNoaXRlY3R1cmVzIGFyZSBhZmZlY3RlZCBieSB0aGlzIGNoYW5nZT8N
Cj4gDQo+IHg4Nl82NCB3b24ndCB1c2UgdGhlc2UgZnVuY3Rpb25zIGJlY2F1c2UgaXQgZGVmaW5l
cyBfX0hBVkVfQVJDSF9NRU1DUFkNCj4gYW5kIGhhcyBvcHRpbWl6ZWQgaW1wbGVtZW50YXRpb25z
IGluIGFyY2gveDg2L2xpYi4NCj4gQW55d2F5LCBJIHdhcyBjdXJpb3VzIGFuZCBJIHRlc3RlZCB0
aGVtIG9uIHg4Nl82NCB0b28sIHRoZXJlIHdhcyB6ZXJvDQo+IGdhaW4gb3ZlciB0aGUgZ2VuZXJp
YyBvbmVzLg0KDQp4ODYgcGVyZm9ybWFuY2UgKGFuZCBhdHRhaW5hYmxlIHBlcmZvcm1hbmNlKSBk
b2VzIGRlcGVuZCBvbiB0aGUgY3B1DQptaWNyby1hcmNoaWVjdHVyZS4NCg0KQW55IHJlY2VudCAn
ZGVza3RvcCcgaW50ZWwgY3B1IHdpbGwgYWxtb3N0IGNlcnRhaW5seSBtYW5hZ2UgdG8NCnJlLW9y
ZGVyIHRoZSBleGVjdXRpb24gb2YgYWxtb3N0IGFueSBjb3B5IGxvb3AgYW5kIGF0dGFpbiAxIHdy
aXRlIHBlciBjbG9jay4NCihFdmVuIHRoZSB0cml2aWFsICd3aGlsZSAoY291bnQtLSkgKmRlc3Qr
KyA9ICpzcmMrKzsnIGxvb3AuKQ0KDQpUaGUgc2FtZSBpc24ndCB0cnVlIG9mIHRoZSBBdG9tIGJh
c2VkIGNwdSB0aGF0IG1heSBiZSBvbiBzbWFsbCBzZXJ2ZXJzLg0KVGhlc2VzIGFyZSBubyBzbG91
Y2hlcyAoZWcgNCBjb3JlcyBhdCAyLjRHSHopIGJ1dCBvbmx5IGhhdmUgbGltaXRlZA0Kb3V0LW9m
LW9yZGVyIGV4ZWN1dGlvbiBhbmQgc28gYXJlIG11Y2ggbW9yZSBzZW5zaXRpdmUgdG8gaW5zdHJ1
Y3Rpb24NCm9yZGVyaW5nLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

