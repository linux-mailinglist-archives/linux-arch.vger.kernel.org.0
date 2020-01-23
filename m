Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6897D146F2F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWRHp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 12:07:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52870 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgAWRHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 12:07:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-V2hgLzYAN0OJMt6VOffMLQ-1; Thu, 23 Jan 2020 17:07:41 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jan 2020 17:07:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jan 2020 17:07:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Topic: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Index: AQHV0gKFFdfdrbkjnU+llP+aeIA9U6f4esgQ
Date:   Thu, 23 Jan 2020 17:07:40 +0000
Message-ID: <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: V2hgLzYAN0OJMt6VOffMLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogV2lsbCBEZWFjb24NCj4gU2VudDogMjMgSmFudWFyeSAyMDIwIDE1OjM0DQouLi4NCj4g
ICAqIE9ubHkgd2FybiBvbmNlIGF0IGJ1aWxkLXRpbWUgaWYgR0NDIHByaW9yIHRvIDQuOCBpcyBk
ZXRlY3RlZC4uLg0KPiANCj4gICAqIC4uLiBhbmQgdGhlbiByYWlzZSB0aGUgbWluaW11bSBHQ0Mg
dmVyc2lvbiB0byA0LjgsIHdpdGggYW4gZXJyb3IgZm9yDQo+ICAgICBvbGRlciB2ZXJzaW9ucyBv
ZiB0aGUgY29tcGlsZXINCg0KSWYgdGhlIGtlcm5lbCBjb21waWxlZCB3aXRoIGdjYyA0LjcgaXMg
bGlrZWx5IHRvIGJlIGJ1Z2d5LCBkb24ndCB0aGVzZQ0KbmVlZCB0byBiZSBpbiB0aGUgb3RoZXIg
b3JkZXI/DQoNCk90aGVyd2lzZSB5b3UgbmVlZCB0byBrZWVwIHRoZSBvbGQgdmVyc2lvbnMgZm9y
IHVzZSB3aXRoIHRoZSBvbGQNCmNvbXBpbGVycy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

