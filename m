Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC01B7627
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgDXNEL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 09:04:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42217 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgDXNEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 09:04:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-185-UrVzaojJPnqLU4NtvZTopg-1; Fri, 24 Apr 2020 14:04:05 +0100
X-MC-Unique: UrVzaojJPnqLU4NtvZTopg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 24 Apr 2020 14:04:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 24 Apr 2020 14:04:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Thread-Topic: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Thread-Index: AQHWGJKn2Kpp2f5dBUqU7GxfOqWk0qiE6POAgAMcVSCAAAgMAIAAJSwg
Date:   Fri, 24 Apr 2020 13:04:04 +0000
Message-ID: <cdfcda98bce54632953cae5e05305dc7@AcuMS.aculab.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
 <20200422094951.GA54428@lakrids.cambridge.arm.com>
 <20200422104138.GA30265@willie-the-truck>
 <6efa0cc1-bd3e-b9b6-4e69-7ac05e6efe35@arm.com>
 <db86e9fa88754d59ac5f8d3f4fe0f9a3@AcuMS.aculab.com>
 <a4ddb547-ea46-d79d-3088-a97b9a033997@arm.com>
In-Reply-To: <a4ddb547-ea46-d79d-3088-a97b9a033997@arm.com>
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

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDI0IEFwcmlsIDIwMjAgMTI6MDENCj4gT24gMjAy
MC0wNC0yNCAxMDo0MSBhbSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IFJvYmluIE11
cnBoeQ0KPiA+PiBTZW50OiAyMiBBcHJpbCAyMDIwIDEyOjAyDQo+ID4gLi4NCj4gPj4gU3VyZSAt
IEkgaGF2ZSBhIG5hZ2dpbmcgZmVlbGluZyB0aGF0IGl0IGNvdWxkIHN0aWxsIGRvIGJldHRlciBX
UlQNCj4gPj4gcGlwZWxpbmluZyB0aGUgbG9hZHMgYW55d2F5LCBzbyBJJ20gaGFwcHkgdG8gY29t
ZSBiYWNrIGFuZCByZWNvbnNpZGVyDQo+ID4+IHRoZSBsb2NhbCBjb2RlZ2VuIGxhdGVyLiBJdCBj
ZXJ0YWlubHkgZG9lc24ndCBkZXNlcnZlIHRvIHN0YW5kIGluIHRoZQ0KPiA+PiB3YXkgb2YgY3Jv
c3MtYXJjaCByZXdvcmsuDQo+ID4NCj4gPiBIb3cgZmFzdCBkb2VzIHRoYXQgbG9vcCBhY3R1YWxs
eSBydW4/DQo+IA0KPiBJJ3ZlIG5vdCBjaGFyYWN0ZXJpc2VkIGl0IGluIGRldGFpbCwgYnV0IGZh
c3RlciB0aGFuIGFueSBvZiB0aGUgb3RoZXINCj4gYXR0ZW1wdHMgc28gZmFyIDspDQouLi4NCj4g
VGhlIGFpbSBoZXJlIGlzIHRvIG1pbmltaXNlIGxvYWQgYmFuZHdpZHRoIC0gbW9zdCBBcm0gY29y
ZXMgY2FuIHNsdXJwIDE2DQo+IGJ5dGVzIGZyb20gTDEgaW4gYSBzaW5nbGUgbG9hZCBhcyBxdWlj
a2x5IGFzIGFueSBzbWFsbGVyIGFtb3VudCwgc28NCj4gbmliYmxpbmcgYXdheSBpbiBsaXR0bGUg
MzItYml0IGNodW5rcyB3b3VsZCByZXN1bHQgaW4gdXAgdG8gNHggbW9yZSBsb2FkDQo+IGN5Y2xl
cy4NCg0KVGhlIHg4NiAncHJvYmxlbScgaXMgdGhhdCAnYWRjJyB0YWtlcyB0d28gY2xvY2tzIGFu
ZCB0aGUgY2FycnkNCmZsYWcgJ3JlZ2lzdGVyIGNoYWluJyBtZWFucyB5b3UgY2FuIG9ubHkgc3Vt
IDQgYnl0ZXMvY2xvY2sgcmVnYXJkbGVzcw0Kb2YgdGhlIG1lbW9yeSBhY2Nlc3Nlcy4NCg0KPiBZ
ZXMsIHRoZSBDIGNvZGUgbG9va3MgcmlkaWN1bG91cywgYnV0IHRoZSBvdGhlciB0cmljayBpcyB0
aGF0DQo+IG1vc3Qgb2YgdGhvc2Ugb3BlcmF0aW9ucyBkb24ndCBhY3R1YWxseSBleGlzdC4gU2lu
Y2UgYSBfX3VpbnQxMjhfdCBpcw0KPiByZWFsbHkgYmFja2VkIGJ5IGFueSB0d28gNjQtYml0IEdQ
UnMgLSBvciBpZiB5b3UncmUgY2FyZWZ1bCwgb25lIDY0LWJpdA0KPiBHUFIgYW5kIHRoZSBjYXJy
eSBmbGFnIC0gYWxsIHRob3NlIHNoaWZ0cyBhbmQgcm90YXRpb25zIGFyZSBpbiBmYWN0DQo+IHJl
c29sdmVkIGJ5IHJlZ2lzdGVyIGFsbG9jYXRpb24sIHNvIHdoYXQgd2UgZW5kIHVwIHdpdGggaXMg
YSB2ZXJ5IG5lYXQNCj4gbG9vcCBvZiBlc3NlbnRpYWxseSBqdXN0IGxvYWRzIGFuZCA2NC1iaXQg
YWNjdW11bGF0aW9uOg0KPiANCj4gLi4uDQo+ICAgMTM4OiAgIGE5NDAzMGMzICAgICAgICBsZHAg
ICAgIHgzLCB4MTIsIFt4Nl0NCj4gICAxM2M6ICAgYTk0MTJjYzggICAgICAgIGxkcCAgICAgeDgs
IHgxMSwgW3g2LCAjMTZdDQo+ICAgMTQwOiAgIGE5NDIyOGM0ICAgICAgICBsZHAgICAgIHg0LCB4
MTAsIFt4NiwgIzMyXQ0KPiAgIDE0NDogICBhOTQzMjRjNyAgICAgICAgbGRwICAgICB4NywgeDks
IFt4NiwgIzQ4XQ0KPiAgIDE0ODogICBhYjAzMDE4ZCAgICAgICAgYWRkcyAgICB4MTMsIHgxMiwg
eDMNCj4gICAxNGM6ICAgNTEwMTAwYTUgICAgICAgIHN1YiAgICAgdzUsIHc1LCAjMHg0MA0KPiAg
IDE1MDogICA5YTBjMDA2MyAgICAgICAgYWRjICAgICB4MywgeDMsIHgxMg0KPiAgIDE1NDogICBh
YjA4MDE2YyAgICAgICAgYWRkcyAgICB4MTIsIHgxMSwgeDgNCj4gICAxNTg6ICAgOWEwYjAxMDgg
ICAgICAgIGFkYyAgICAgeDgsIHg4LCB4MTENCj4gICAxNWM6ICAgYWIwNDAxNGIgICAgICAgIGFk
ZHMgICAgeDExLCB4MTAsIHg0DQo+ICAgMTYwOiAgIDlhMGEwMDg0ICAgICAgICBhZGMgICAgIHg0
LCB4NCwgeDEwDQo+ICAgMTY0OiAgIGFiMDcwMTJhICAgICAgICBhZGRzICAgIHgxMCwgeDksIHg3
DQo+ICAgMTY4OiAgIDlhMDkwMGU3ICAgICAgICBhZGMgICAgIHg3LCB4NywgeDkNCj4gICAxNmM6
ICAgYWIwODAwNjkgICAgICAgIGFkZHMgICAgeDksIHgzLCB4OA0KPiAgIDE3MDogICA5YTA4MDA2
MyAgICAgICAgYWRjICAgICB4MywgeDMsIHg4DQo+ICAgMTc0OiAgIGFiMDcwMDg4ICAgICAgICBh
ZGRzICAgIHg4LCB4NCwgeDcNCj4gICAxNzg6ICAgOWEwNzAwODQgICAgICAgIGFkYyAgICAgeDQs
IHg0LCB4Nw0KPiAgIDE3YzogICA5MTAxMDBjNiAgICAgICAgYWRkICAgICB4NiwgeDYsICMweDQw
DQo+ICAgMTgwOiAgIGFiMDQwMDY3ICAgICAgICBhZGRzICAgIHg3LCB4MywgeDQNCj4gICAxODQ6
ICAgOWEwNDAwNjMgICAgICAgIGFkYyAgICAgeDMsIHgzLCB4NA0KPiAgIDE4ODogICBhYjAxMDA2
NCAgICAgICAgYWRkcyAgICB4NCwgeDMsIHgxDQo+ICAgMThjOiAgIDlhMDMwMDIzICAgICAgICBh
ZGMgICAgIHgzLCB4MSwgeDMNCj4gICAxOTA6ICAgNzEwMTAwYmYgICAgICAgIGNtcCAgICAgdzUs
ICMweDQwDQo+ICAgMTk0OiAgIGFhMDMwM2UxICAgICAgICBtb3YgICAgIHgxLCB4Mw0KPiAgIDE5
ODogICA1NGZmZmQwYyAgICAgICAgYi5ndCAgICAxMzggPGRvX2NzdW0rMHhkOD4NCj4gLi4uDQo+
IA0KPiBJbnN0cnVjdGlvbi13aXNlLCB0aGF0J3MgYWJvdXQgYXMgZ29vZCBhcyBpdCBjYW4gZ2V0
IHNob3J0IG9mDQo+IG1haW50YWluaW5nIG11bHRpcGxlIGFjY3VtdWxhdG9ycyBhbmQgbW92aW5n
IHRoZSBwYWlyd2lzZSBmb2xkaW5nIG91dCBvZg0KPiB0aGUgbG9vcC4gVGhlIG1haW4gdGhpbmcg
dGhhdCBJIHRoaW5rIGlzIHN0aWxsIGxlZnQgb24gdGhlIHRhYmxlIGlzIHRoYXQNCj4gdGhlIGxv
YWQtdG8tdXNlIGRpc3RhbmNlcyBhcmUgcHJldHR5IHNob3J0IGFuZCB0aGVyZSdzIGNsZWFybHkg
c2NvcGUgdG8NCj4gc3ByZWFkIG91dCBhbmQgYW1vcnRpc2UgdGhlIGxvYWQgY3ljbGVzIGJldHRl
ciwgd2hpY2ggc3RhbmRzIHRvIGJlbmVmaXQNCj4gYm90aCBiaWcgYW5kIGxpdHRsZSBjb3Jlcy4N
Cg0KSSByZWFsaXNlZCBtb3N0IG9mIHRoZSBDIHdvdWxkIGRpc2FwcGVhciAtIGp1c3QgaGFyZCB0
byBzZWUgd2hhdA0KdGhlIHJlc3VsdCB3b3VsZCBiZS4NCkxvb2tpbmcgYXQgdGhlIGFib3ZlIHRo
ZXJlIGFyZSA4ICg2NGJpdCkgbG9hZHMgYW5kIDE2IGFkZHMuDQooUGx1cyAyIGFkZHMgZm9yIHRo
ZSBsb29wIGNvbnRyb2wsIHNob3VsZCBvbmx5IG5lZWQgb25lIQ0KYW5kIGEgc3BhcmUgcmVnaXN0
ZXIgbW92ZS4pDQpXaXRob3V0IG11bHRpcGxlIGNhcnJ5IGZsYWdzIHRoZSBiZXN0IHlvdSBhcmUg
Z29pbmcgdG8gZ2V0DQppcyBvbmUgYWRkIGluc3RydWN0aW9uIGFuZCBvbmUgJ3NhdmUgdGhlIGNh
cnJ5IGZsYWcnIGluc3RydWN0aW9uDQpmb3IgZWFjaCAnd29yZCcuDQpUaGUgdGhpbmcgdGhlbiBp
cyB0byBhcnJhbmdlIHRoZSBjb2RlIHRvIGF2b2lkIHJlZ2lzdGVyIGRlcGVuZGVuY3kNCmNoYWlu
cyBzbyB0aGF0IHRoZSBpbnN0cnVjdGlvbnMgY2FuIHJ1biBpbiBwYXJhbGxlbC4NCkkgdGhpbmsg
eW91IGxvc2UgYXQgdGhlIGJvdHRvbSBvZiB0aGUgYWJvdmUgd2hlbiB5b3UgYWRkIHRvDQp0aGUg
Z2xvYmFsIHN1bSAtIG1pZ2h0IGJlIGZhc3RlciB3aXRoIDIgc3Vtcy4NCkFjdHVhbGx5IHRyeWlu
ZyB0byBkbyBvbmUgbG9hZCBhbmQgNCBhZGRzIGV2ZXJ5IGNsb2NrIG1pZ2h0DQpiZSBwb3NzaWJs
ZSAtIGlmIHRoZSBjcHUgY2FuIGV4ZWN1dGUgdGhlbS4NCkJ1dCB0aGF0IHdvdWxkIHJlcXVpcmUg
YSBob3JyaWQgaW50ZXJsZWF2ZWQgbG9vcC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

