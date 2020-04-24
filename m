Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D61B711A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXJlf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 05:41:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30004 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgDXJle (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 05:41:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-238-t_Zt5DGvOoelu7WWLG6BdA-1; Fri, 24 Apr 2020 10:41:30 +0100
X-MC-Unique: t_Zt5DGvOoelu7WWLG6BdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 24 Apr 2020 10:41:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 24 Apr 2020 10:41:30 +0100
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
Thread-Index: AQHWGJKn2Kpp2f5dBUqU7GxfOqWk0qiE6POAgAMcVSA=
Date:   Fri, 24 Apr 2020 09:41:30 +0000
Message-ID: <db86e9fa88754d59ac5f8d3f4fe0f9a3@AcuMS.aculab.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
 <20200422094951.GA54428@lakrids.cambridge.arm.com>
 <20200422104138.GA30265@willie-the-truck>
 <6efa0cc1-bd3e-b9b6-4e69-7ac05e6efe35@arm.com>
In-Reply-To: <6efa0cc1-bd3e-b9b6-4e69-7ac05e6efe35@arm.com>
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

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDIyIEFwcmlsIDIwMjAgMTI6MDINCi4uDQo+IFN1
cmUgLSBJIGhhdmUgYSBuYWdnaW5nIGZlZWxpbmcgdGhhdCBpdCBjb3VsZCBzdGlsbCBkbyBiZXR0
ZXIgV1JUDQo+IHBpcGVsaW5pbmcgdGhlIGxvYWRzIGFueXdheSwgc28gSSdtIGhhcHB5IHRvIGNv
bWUgYmFjayBhbmQgcmVjb25zaWRlcg0KPiB0aGUgbG9jYWwgY29kZWdlbiBsYXRlci4gSXQgY2Vy
dGFpbmx5IGRvZXNuJ3QgZGVzZXJ2ZSB0byBzdGFuZCBpbiB0aGUNCj4gd2F5IG9mIGNyb3NzLWFy
Y2ggcmV3b3JrLg0KDQpIb3cgZmFzdCBkb2VzIHRoYXQgbG9vcCBhY3R1YWxseSBydW4/DQpUbyBt
eSBtaW5kIGl0IHNlZW1zIHRvIGRvIGEgbG90IG9mIG9wZXJhdGlvbnMgb24gZWFjaCA2NGJpdCB2
YWx1ZS4NCkknZCBoYXZlIHRob3VnaHQgdGhhdCBhIGxvb3AgYmFzZWQgb246DQoJc3VtNjQgPSAq
cHRyOw0KCXN1bTY0X2hpZ2ggPSAqcHRyKysgPj4gMzI7DQphbmQgdGhlbiBmaXhpbmcgdXAgdGhl
IHJlc3VsdCB3b3VsZCBiZSBmYXN0ZXIuDQoNClRoZSB4ODYtNjQgY29kZSBpcyBhbHNvIGJhZCEN
Ck9uIGludGVsIGNwdSBwcmlvciB0byBoYXN3ZWxsIGEgc2ltcGxlOg0KCXN1bV82NCArPSAqcHRy
MzIrKzsNCmlzIGZhc3RlciB0aGFuIHRoZSBjdXJyZW50IGNvZGUuDQooQWx0aG91Z2ggeW91IGNh
biBkbyBhIGxvdCBiZXR0ZXIgZXZlbiBvbiBpdnkgYnJpZGdlLikNCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

