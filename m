Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3338147E83
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgAXKLI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 05:11:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52749 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730743AbgAXKLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 05:11:08 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-18-4FpQZc8INzW3lfZ1t7ypNA-1; Fri, 24 Jan 2020 10:11:04 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 24 Jan 2020 10:11:03 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 24 Jan 2020 10:11:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Topic: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Index: AQHV0gKFFdfdrbkjnU+llP+aeIA9U6f4esgQgAAC9ICAAANF8IAAGghCgAD2osA=
Date:   Fri, 24 Jan 2020 10:11:03 +0000
Message-ID: <a9d4a3c113ed4f09897477d3a9be1f84@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
 <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
 <20200123190125.GA2683468@rani.riverdale.lan>
In-Reply-To: <20200123190125.GA2683468@rani.riverdale.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4FpQZc8INzW3lfZ1t7ypNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjAgMTk6MDENCi4uLg0K
PiA+ID4gT2ggLSBhbmQgSSBuZWVkIHRvIGZpbmQgYSBuZXdlciBjb21waWxlciA6LSgNCj4gPg0K
PiA+IFdoYXQgZGlzdHJvIGFyZSB5b3UgdXNpbmc/IERvZXMgaXQgaGF2ZSBhIHBhY2thZ2UgZm9y
IGEgbmV3ZXINCj4gPiBjb21waWxlcj8gIEknbSBob25lc3RseSBjdXJpb3VzIGFib3V0IHdoYXQg
cG9saWNpZXMgaWYgYW55IHRoZSBrZXJuZWwNCj4gPiBoYXMgZm9yIHN1cHBvcnRpbmcgZGV2ZWxv
cGVyJ3MgdG9vbGNoYWlucyBmcm9tIHRoZWlyIGRpc3RyaWJ1dGlvbnMuDQoNCkxpa2UgbWFueSBk
ZXZlbG9wZXJzIEkgZ2V0IGxhenkgd2l0aCB1cGdyYWRlcyBvZiBzb21lIHN5c3RlbXMuDQpTbyBt
eSBtYWluIExpbnV4ICdkZXNrdG9wJyBzeXN0ZW0gaXMgcnVubmluZyBVYnVudHUgMTMuMDQgdXNl
cnNwYWNlDQp3aXRoIGEgdmVyeSByZWNlbnQga2VybmVsLg0KU28gaXQgaGFzIGdjYyA0LjcuMyBh
cyBkZWZhdWx0IGFuZCBhIGdjYyA0LjguMSBpbnN0YWxsZWQgKHByb2JhYmx5IG5vdCBtYXR1cmUN
CmVub3VnaCB0byBiZSBzYWZlISkuDQooSSd2ZSAyIG90aGVyIGk3IHN5c3RlbXMgcnVubmluZyBV
YnVudHUgMTguMDQuMHggd2l0aCB0aGUgZGlzdHJvIGtlcm5lbHMuKQ0KLi4uDQo+IEkgdGhpbmsg
dGhlIGlzc3VlIGlzIG5vdCBqdXN0IGtlcm5lbCBkZXZzLiBVc2VycyBtYXkgbmVlZCB0byBjb21w
aWxlIGENCj4gY3VzdG9tIGtlcm5lbCBvciBhdCBsZWFzdCBidWlsZCBhIG1vZHVsZS4NCg0KSWYg
dGhleSBhcmUganVzdCBidWlsZGluZyBhIG1vZHVsZSB0aGV5J2xsIGJlIHVzaW5nIHRoZSBrZXJu
ZWwgaGVhZGVycw0KdGhhdCBnbyB3aXRoIHRoZSBkaXN0cm8ga2VybmVsIC0gYW5kIHRoZSBtb2R1
bGUgc291cmNlcyB3aWxsIG5lZWQgdG8NCm1hdGNoLiBTbyB0aGUgZGlzdHJvJ3MgZ2NjIHNob3Vs
ZCBtYXRjaC4NCg0KTXVjaCBtb3JlIGludGVyZXN0aW5nIGlzIHRoZSBnY2MgY29tcGlsZXIgd2Ug
dXNlIHRvIGdlbmVyYXRlIHRoZQ0KJ2JpbmFyeSBibG9iJyBmb3Igb3VyICdvdXQgb2YgdHJlZScg
ZHJpdmVycy4NClRoZXNlIGdldCBjb21waWxlZCAod2l0aG91dCBhbnkgb2YgdGhlIGtlcm5lbCBo
ZWFkZXJzKSBvbiB0aGUNCnNhbWUgc3lzdGVtIGFzIHdlIGJ1aWxkIHRoZSB1c2Vyc3BhY2UgcHJv
Z3JhbXMgb24uDQpUbyBnZXQgbGliYyBhbmQgKGVzcGVjaWFsbHkpIGxpYmMrKyBjb21wYXRpYmls
aXR5IHRoaXMgaGFzIHRvIGJlDQphIHZlcnkgb2xkIHN5c3RlbSAtIGFzIG9sZCBhcyB0aGUgb2xk
ZXN0IHN5c3RlbSBhbnkgb2Ygb3VyDQpjdXN0b21lcnMgYXJlIGxpa2VseSB0byB1c2UuDQpJbiBw
cmFjdGlzZSB0aGlzIChub3cpIG1lYW5zIHNvbWV0aGluZyBydW5uaW5nIGEgMi42LjMyIGVyYQ0K
a2VybmVsIChvciBzbGlnaHRseSBlYXJsaWVyKS4NClNvIGlzIGEgZGViaWFuIGdjYyA0LjMuMi0x
LjEgY29tcGlsZXIuDQpJIHRoaW5rIHdlJ3ZlIGZpbmFsbHkgcGVyc3VhZGVkIGFsbCBvdXIgY3Vz
dG9tZXJzIHRvIHVwZ3JhZGUgZnJvbSAyLjYuMTguDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

