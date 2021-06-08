Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21CF39F9D0
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhFHPCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 11:02:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58297 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhFHPCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 11:02:14 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-162-9RBwFXs0Nk6I40uBzgaFIw-1; Tue, 08 Jun 2021 16:00:19 +0100
X-MC-Unique: 9RBwFXs0Nk6I40uBzgaFIw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 16:00:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 16:00:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>, Guo Ren <guoren@kernel.org>
CC:     Nick Kossifidis <mick@ics.forth.gr>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        =?utf-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: RE: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Topic: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Index: AQHXW2Yf+E+HbgFRkkm3Xv2DTkp7y6sKNaKQ
Date:   Tue, 8 Jun 2021 15:00:17 +0000
Message-ID: <2db975b5f24149b19191120b9f0f506b@AcuMS.aculab.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
 <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
 <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
 <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
 <20210607062701.GB24060@lst.de>
In-Reply-To: <20210607062701.GB24060@lst.de>
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

RnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcNCj4gU2VudDogMDcgSnVuZSAyMDIxIDA3OjI3DQo+IA0K
PiBPbiBNb24sIEp1biAwNywgMjAyMSBhdCAxMToxOTowM0FNICswODAwLCBHdW8gUmVuIHdyb3Rl
Og0KPiA+ID5Gcm9tIExpbnV4IG5vbi1jb2hlcmVuY3kgdmlldywgd2UgbmVlZDoNCj4gPiAgLSBO
b24tY2FjaGUgKyBTdHJvbmcgT3JkZXIgUFRFIGF0dHJpYnV0ZXMgdG8gZGVhbCB3aXRoIGRyaXZl
cnMnIERNQSBkZXNjcmlwdG9ycw0KPiA+ICAtIE5vbi1jYWNoZSArIHdlYWsgb3JkZXIgdG8gZGVh
bCB3aXRoIGZyYW1lYnVmZmVyIGRyaXZlcnMNCj4gPiAgLSBDTU8gZG1hX3N5bmMgdG8gc3luYyBj
YWNoZSB3aXRoIERNQSBkZXZpY2VzDQo+IA0KPiBUaGlzIGlzIG5vdCBzdHJpY3RseSB0cnVlLiAg
QXQgdGhlIHZlcnkgbWluaW11bSB5b3Ugb25seSBuZWVkIGNhY2hlDQo+IGludmFsaWRhdGlvbiBh
bmQgd3JpdGViYWNrIGluc3RydWN0aW9ucy4gIEZvciBleGFtcGxlIGVhcmx5IHBhcmlzYw0KPiBD
UFVzIGFuZCBzb21lIG02OGtub21tdSBTT0NzIGhhdmUgbm8gc3VwcG9ydCBmb3IgdW5jYWNoZWQg
YXJlYXMgYXQgYWxsLA0KPiBhbmQgTGludXggd29ya3MuICBCdXQgdG8gYmUgZmFpciB0aGlzIGlz
IHZlcnkgcGFpbmZ1bCBhbmQgc3VwcG9ydHMgb25seQ0KPiB2ZXJ5IGxpbWl0ZWQgcGVyaXBoYWxz
LiAgU28gZm9yIG1vZGVybiBmdWxsIExpbnV4IHN1cHBvcnQgc29tZSB1bmNhaGVkDQo+IG1lbW9y
eSBpcyBhZHZpc2FibGUuICBCdXQgdGhhdCBkb2Vzbid0IGhhdmUgdG8gYmUgdXNpbmcgUFRFIGF0
dHJpYnV0ZXMuDQo+IEl0IGNvdWxkIGFsc28gYmUgcGh5c2ljYWwgbWVtb3J5IHJlZ2lvbnMgdGhh
dCBhcmUgZWl0aGVyIHRvdGFsbHkgZml4ZWQNCj4gb3Igc29tZXdoYXQgZHluYW1pYy4NCg0KSXQg
aXMgYWxtb3N0IGltcG9zc2libGUgdG8gaW50ZXJmYWNlIHRvIG1hbnkgZXRoZXJuZXQgY2hpcHMg
d2l0aG91dA0KZWl0aGVyIGNvaGVyZW50IG9yIHVuY2FjaGVkIG1lbW9yeSBmb3IgdGhlIGRlc2Ny
aXB0b3IgcmluZ3MuDQpUaGUgc3RhdHVzIGJpdHMgb24gdGhlIHRyYW5zbWl0IHJpbmcgYXJlIHBh
cnRpY3VsYXJseSBwcm9ibGVtYXRpYy4NCg0KVGhlIHJlY2VpdmUgcmluZyBjYW4gYmUgZG9uZSB3
aXRoIHdyaXRlYmFjaytpbnZhbGlkYXRlIHByb3ZpZGVkIHlvdQ0KZmlsbCBhIGNhY2hlIGxpbmUg
YXQgYSB0aW1lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

