Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D254D22953D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGVJp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 05:45:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25919 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgGVJp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 05:45:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-100-hJ4njsgnPBGouKXOpXFVQg-1; Wed, 22 Jul 2020 10:45:24 +0100
X-MC-Unique: hJ4njsgnPBGouKXOpXFVQg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 22 Jul 2020 10:45:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 22 Jul 2020 10:45:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Topic: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Index: AQHWX6FKV5/AXh1RK02Ltj+ZPvbZjKkTV60Q
Date:   Wed, 22 Jul 2020 09:45:23 +0000
Message-ID: <773d830b89814ab8a92dc892ec6e65e2@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgSnVseSAyMDIwIDIxOjU1DQo+IE9uIFR1
ZSwgSnVsIDIxLCAyMDIwIGF0IDE6MjUgUE0gQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcu
dWs+IHdyb3RlOg0KPiA+DQo+ID4gUHJlcGFyYXRpb24gZm9yIHRoZSBjaGFuZ2Ugb2YgY2FsbGlu
ZyBjb252ZW50aW9uczsgcmlnaHQgbm93IGFsbA0KPiA+IGNhbGxlcnMgcGFzcyAwIGFzIGluaXRp
YWwgc3VtLiAgUGFzc2luZyAweGZmZmZmZmZmIGluc3RlYWQgeWllbGRzDQo+ID4gdGhlIHZhbHVl
cyBjb21wYXJhYmxlIG1vZCAweGZmZmYgYW5kIGd1YXJhbnRlZXMgdGhhdCAwIHdpbGwgbm90DQo+
ID4gYmUgcmV0dXJuZWQgb24gc3VjY2Vzcy4NCj4gDQo+IFRoaXMgc2VlbXMgZGFuZ2Vyb3VzIHRv
IG1lLg0KPiANCj4gTWF5YmUgc29tZSBpbXBsZW1lbnRhdGlvbiBkZXBlbmRzIG9uIHRoZSBmYWN0
IHRoYXQgdGhleSBhY3R1YWxseSBkbw0KPiB0aGUgY3N1bSAxNiBiaXRzIGF0IGEgdGltZSwgYW5k
IG5ldmVyIHNlZSBhbiBvdmVyZmxvdyBpbiAiaW50IiwNCj4gYmVjYXVzZSB0aGV5IGtlZXAgZm9s
ZGluZyB0aGluZ3MuDQo+IA0KPiBZb3Ugbm93IGJyZWFrIHRoYXQgYXNzdW1wdGlvbiwgYW5kIGdp
dmUgaXQgYW4gaW5pdGlhbCB2YWx1ZSB0aGF0IHRoZQ0KPiBjc3VtIGNvZGUgaXRzZWxmIHdvdWxk
IG5ldmVyIGdlbmVyYXRlLCBhbmQgd291bGRuJ3QgaGFuZGxlIHJpZ2h0Lg0KPiANCj4gQnV0IEkg
ZGlkbid0IGNoZWNrLiBNYXliZSB3ZSBkb24ndCBoYXZlIGFueXRoaW5nIHRoYXQgc3R1cGlkIGlu
IHRoZSBrZXJuZWwuDQoNCkl0IGlzbid0IG5lY2Vzc2FyaWx5IHN0dXBpZCA6LSkNCkEgNjRiaXQg
c3VtIGNhbiBiZSByZWR1Y2VkIHRvIDE2Yml0cyB1c2luZyBzaGlmdHMgYW5kIGFkZHMNCihhcyB1
cyB1c3VhbGx5IGRvbmUpIG9mIHVzaW5nICdzdW0gJSAweGZmZmYnLg0KUHJvdmlkZWQgdGhlIGNv
bXBpbGVyIHVzZXMgJ211bHRpcGx5IGJ5IHJlY2lwcm9jYWwnIHRoZSBjb2RlDQppc24ndCB0aGF0
IGJhZCAtIGl0IG1pZ2h0IGV2ZW4gYmUgZGlmZmljdWx0IHRvIHNheSB3aGljaCBpcyBmYXN0ZXIu
DQpIb3dldmVyIHRoYXQgbWFrZXMgdGhlIG91dHB1dCBkb21haW4gMC4uZmZmZSBub3QgMS4uZmZm
Zi4NCg0KVGhlIGNoZWNrc3VtIGdlbmVyYXRpb24gY29kZSByZWFsbHkgbmVlZHMgdG8ga25vdyB3
aGljaCBpcyB1c2VkLg0KU28gaXQgaXMgYmVzdCBuZXZlciB0byB1c2UgdGhlICUgdmVyc2lvbi4N
CklmIHRoZSBzdW0gaXMga25vd24gdG8gYmUgMS4uMHhmZmZmIHRoZW4gYWZ0ZXIgaW52ZXJzaW9u
IGl0IGlzDQowLi5mZmZlIGJ1dCB0aGUgcmVxdWlyZWQgZG9tYWluIGlzIDEuLmZmZmYuDQpUaGlz
IGNhbiBiZSBmaXhlZCBieSBhZGRpbmcgMSAtIHByb3ZpZGVkIGEgY29tcGVuc2F0aW5nIDEgaXMN
CmFkZGVkIGluIGJlZm9yZSB0aGUgaW52ZXJzaW9uLg0KVGhlIGVhc3kgcGxhY2UgdG8gZG8gdGhp
cyBpcyB0byBmZWVkIDEgKG5vdCAwIG9yIH4wKSBpbnRvIHRoZQ0KZmlyc3QgY2hlY2tzdW0gYmxv
Y2suDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

