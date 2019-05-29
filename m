Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC92DBA4
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 13:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfE2LVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 07:21:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37972 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfE2LVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 07:21:00 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-n6S3TAExMKGEa1CSkKSjew-1; Wed, 29 May 2019 12:20:57 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 29 May 2019 12:20:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 May 2019 12:20:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Vyukov' <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: RE: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Thread-Topic: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Thread-Index: AQHVFg1T4KMnNqJYZ0KJ/Gnew5X/QaaB8uxw
Date:   Wed, 29 May 2019 11:20:56 +0000
Message-ID: <a0157a8d778a48b7ba3935f3e6840d30@AcuMS.aculab.com>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
In-Reply-To: <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: n6S3TAExMKGEa1CSkKSjew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRG1pdHJ5IFZ5dWtvdg0KPiBTZW50OiAyOSBNYXkgMjAxOSAxMTo1Nw0KPiBPbiBXZWQs
IE1heSAyOSwgMjAxOSBhdCAxMjozMCBQTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBNYXkgMjksIDIwMTkgYXQgMTI6MTY6MzFQ
TSArMDIwMCwgTWFyY28gRWx2ZXIgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDI5IE1heSAyMDE5IGF0
IDEyOjAxLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiBXZWQsIE1heSAyOSwgMjAxOSBhdCAxMToyMDoxN0FNICswMjAwLCBN
YXJjbyBFbHZlciB3cm90ZToNCj4gPiA+ID4gPiBGb3IgdGhlIGRlZmF1bHQsIHdlIGRlY2lkZWQg
dG8gZXJyIG9uIHRoZSBjb25zZXJ2YXRpdmUgc2lkZSBmb3Igbm93LA0KPiA+ID4gPiA+IHNpbmNl
IGl0IHNlZW1zIHRoYXQgZS5nLiB4ODYgb3BlcmF0ZXMgb25seSBvbiB0aGUgYnl0ZSB0aGUgYml0
IGlzIG9uLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIG5vdCBjb3JyZWN0LCBzZWUgZm9yIGlu
c3RhbmNlIHNldF9iaXQoKToNCj4gPiA+ID4NCj4gPiA+ID4gc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSB2b2lkDQo+ID4gPiA+IHNldF9iaXQobG9uZyBuciwgdm9sYXRpbGUgdW5zaWduZWQgbG9uZyAq
YWRkcikNCj4gPiA+ID4gew0KPiA+ID4gPiAgICAgICAgIGlmIChJU19JTU1FRElBVEUobnIpKSB7
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBhc20gdm9sYXRpbGUoTE9DS19QUkVGSVggIm9yYiAl
MSwlMCINCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgOiBDT05TVF9NQVNLX0FERFIo
bnIsIGFkZHIpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIDogImlxIiAoKHU4KUNP
TlNUX01BU0sobnIpKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICA6ICJtZW1vcnki
KTsNCj4gPiA+ID4gICAgICAgICB9IGVsc2Ugew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgYXNt
IHZvbGF0aWxlKExPQ0tfUFJFRklYIF9fQVNNX1NJWkUoYnRzKSAiICUxLCUwIg0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICA6IDogUkxPTkdfQUREUihhZGRyKSwgIklyIiAobnIpIDog
Im1lbW9yeSIpOw0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gfQ0KPiA+ID4gPg0KPiA+ID4g
PiBUaGF0IHJlc3VsdHMgaW46DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgTE9DSyBCVFNRIG5y
LCAoYWRkcikNCj4gPiA+ID4NCj4gPiA+ID4gd2hlbiBAbnIgaXMgbm90IGFuIGltbWVkaWF0ZS4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBHaXZlbiB0aGF0IGFy
bTY0IGFscmVhZHkgaW5zdHJ1bWVudHMNCj4gPiA+IGJpdG9wcyBhY2Nlc3MgdG8gd2hvbGUgd29y
ZHMsIGFuZCB4ODYgbWF5IGFsc28gZG8gc28gZm9yIHNvbWUgYml0b3BzLA0KPiA+ID4gaXQgc2Vl
bXMgZmluZSB0byBpbnN0cnVtZW50IHdvcmQtc2l6ZWQgYWNjZXNzZXMgYnkgZGVmYXVsdC4gSXMg
dGhhdA0KPiA+ID4gcmVhc29uYWJsZT8NCj4gPg0KPiA+IEVtaW5lbnRseSAtLSB0aGUgQVBJIGlz
IGRlZmluZWQgc3VjaDsgZm9yIGJvbnVzIHBvaW50cyBLQVNBTiBzaG91bGQgYWxzbw0KPiA+IGRv
IGFsaWdubWVudCBjaGVja3Mgb24gYXRvbWljIG9wcy4gRnV0dXJlIGhhcmR3YXJlIHdpbGwgI0FD
IG9uIHVuYWxpZ25lZA0KPiA+IFsqXSBMT0NLIHByZWZpeCBpbnN0cnVjdGlvbnMuDQo+ID4NCj4g
PiAoKikgbm90IGVudGlyZWx5IGFjY3VyYXRlLCBpdCB3aWxsIG9ubHkgdHJhcCB3aGVuIGNyb3Nz
aW5nIGEgbGluZS4NCj4gPiAgICAgaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8xNTU2MTM0Mzgy
LTU4ODE0LTEtZ2l0LXNlbmQtZW1haWwtZmVuZ2h1YS55dUBpbnRlbC5jb20NCj4gDQo+IEludGVy
ZXN0aW5nLiBEb2VzIGFuIGFkZHJlc3MgcGFzc2VkIHRvIGJpdG9wcyBhbHNvIHNob3VsZCBiZSBh
bGlnbmVkLA0KPiBvciBhbGlnbm1lbnQgaXMgc3VwcG9zZWQgdG8gYmUgaGFuZGxlZCBieSBiaXRv
cHMgdGhlbXNlbHZlcz8NCg0KVGhlIGJpdG9wcyBhcmUgZGVmaW5lZCBvbiAnbG9uZyBbXScgYW5k
IGl0IGlzIGV4cGVjdGVkIHRvIGJlIGFsaWduZWQuDQpBbnkgY29kZSB0aGF0IGNhc3RzIHRoZSBh
cmd1bWVudCBpcyBsaWtlbHkgdG8gYmUgYnJva2VuIG9uIGJpZy1lbmRpYW4uDQpJIGRpZCBhIHF1
aWNrIGdyZXAgYSBmZXcgd2Vla3MgYWdvIGFuZCBmb3VuZCBzb21lIHZlcnkgZHViaW91cyBjb2Rl
Lg0KTm90IGFsbCB0aGUgY2FzdHMgc2VlbWVkIHRvIGJlIG9uIGNvZGUgdGhhdCB3YXMgTEUgb25s
eSAoYWx0aG91Z2gNCkkgZGlkbid0IHRyeSB0byBmaW5kIG91dCB3aGF0IHRoZSBjYXN0cyB3ZXJl
IGZyb20pLg0KDQpUaGUgYWxpZ25tZW50IHRyYXAgb24geDg2IGNvdWxkIGJlIGF2b2lkZWQgYnkg
b25seSBldmVyIHJlcXVlc3RpbmcgMzJiaXQNCmN5Y2xlcyAtIGFuZCBhc3N1bWluZyB0aGUgYnVm
ZmVyIGlzIGFsd2F5cyAzMmJpdCBhbGlnbmVkIChlZyBpbnQgW10pLg0KQnV0IG9uIEJFIHBhc3Np
bmcgYW4gJ2ludCBbXScgaXMganVzdCBzbyB3cm9uZyAuLi4uDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

