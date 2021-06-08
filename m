Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6C39FC20
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHQNd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 12:13:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21881 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhFHQNL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 12:13:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-62pR9OyRO-SSSIbw5JosqQ-1; Tue, 08 Jun 2021 17:11:16 +0100
X-MC-Unique: 62pR9OyRO-SSSIbw5JosqQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 17:11:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 17:11:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>
CC:     Guo Ren <guoren@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>,
        "Drew Fustini" <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        =?utf-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: RE: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Topic: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Index: AQHXW2Yf+E+HbgFRkkm3Xv2DTkp7y6sKNaKQ///5qoCAABnpEA==
Date:   Tue, 8 Jun 2021 16:11:15 +0000
Message-ID: <7a11939f4c7f4494a7d86b8d5f1bb702@AcuMS.aculab.com>
References: <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
 <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
 <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
 <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
 <20210607062701.GB24060@lst.de>
 <2db975b5f24149b19191120b9f0f506b@AcuMS.aculab.com>
 <20210608153203.GA6802@lst.de>
In-Reply-To: <20210608153203.GA6802@lst.de>
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

RnJvbTogJ0NocmlzdG9waCBIZWxsd2lnJw0KPiBTZW50OiAwOCBKdW5lIDIwMjEgMTY6MzINCj4g
DQo+IE9uIFR1ZSwgSnVuIDA4LCAyMDIxIGF0IDAzOjAwOjE3UE0gKzAwMDAsIERhdmlkIExhaWdo
dCB3cm90ZToNCj4gPiBJdCBpcyBhbG1vc3QgaW1wb3NzaWJsZSB0byBpbnRlcmZhY2UgdG8gbWFu
eSBldGhlcm5ldCBjaGlwcyB3aXRob3V0DQo+ID4gZWl0aGVyIGNvaGVyZW50IG9yIHVuY2FjaGVk
IG1lbW9yeSBmb3IgdGhlIGRlc2NyaXB0b3IgcmluZ3MuDQo+ID4gVGhlIHN0YXR1cyBiaXRzIG9u
IHRoZSB0cmFuc21pdCByaW5nIGFyZSBwYXJ0aWN1bGFybHkgcHJvYmxlbWF0aWMuDQo+ID4NCj4g
PiBUaGUgcmVjZWl2ZSByaW5nIGNhbiBiZSBkb25lIHdpdGggd3JpdGViYWNrK2ludmFsaWRhdGUg
cHJvdmlkZWQgeW91DQo+ID4gZmlsbCBhIGNhY2hlIGxpbmUgYXQgYSB0aW1lLg0KPiANCj4gSXQg
aXMgaG9ycmlibGUsIGJ1dCBpdCBoYXMgYmVlbiBkb25lLiAgVGFrZSBhIGxvb2sgYXQ6DQo+IA0K
PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pODI1eHgvbGFzaV84MjU5Ni5jIGFuZA0KPiBkcml2ZXJz
L25ldC9ldGhlcm5ldC9zZWVxL3NnaXNlZXEuYw0KDQpJIGd1ZXNzIHRoYXQgZWFjaCB0cmFuc21p
dCBoYXMgdG8gYmUgc3BsaXQgaW50byBlbm91Z2gNCmZyYWdtZW50cyB0aGF0IHRoZXkgZmlsbCBh
IGNhY2hlIGxpbmUuDQpUaGF0IHdvbid0IHdvcmsgd2l0aCBzb21lIChwcm9iYWJseSBvbGQgbm93
KSBkZXZpY2VzIHRoYXQNCnJlcXVpcmUgdGhlIGZpcnN0IGZyYWdtZW50IHRvIGJlIDY0IGJ5dGVz
IGJlY2F1c2UgaXQgd29uJ3QNCmJhY2stdXAgdGhlIGRlc2NyaXB0b3JzIGFmdGVyIGEgY29sbGlz
aW9uLg0KDQpJdCdzIGFsbCBhcyBob3JyaWQgYXMgYSBEU1Agd2UgaGF2ZSB0aGF0IGNhbid0IHJl
Y2VpdmUgZXRoZXJuZXQNCmZyYW1lcyBvbnRvIGEgNG4rMiBib3VuZGFyeSBhbmQgZG9lc24ndCBz
dXBwb3J0IG1pc2FsaWduZWQgYWNjZXNzZXMuDQoNCk1pbmQgeW91LCBTdW4ncyBvcmlnaW5hbCBT
YnVzIGV0aGVybmV0IGJvYXJkIGhhZCB0byBiZSBnaXZlbg0KYSA0biBhbGlnbmVkIHJ4IGJ1ZmZl
ciBhbmQgdGhlbiBhIG1pc2FsaWduZWQgY29weSBkb25lIGluIGtlcm5lbA0KaW4gb3JkZXIgdG8g
bm90IGRyb3AgcGFja2V0cyENCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

