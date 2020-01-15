Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9637E13BD7D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 11:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgAOKfL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 05:35:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:21720 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729650AbgAOKfL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 05:35:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-253-5k3V9LDIOLu6s8nwG4L9TQ-1; Wed, 15 Jan 2020 10:35:08 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 10:35:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 10:35:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "segher@kernel.crashing.org" <segher@kernel.crashing.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Subject: RE: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Thread-Topic: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Thread-Index: AQHVyyMVgF6HO8Jdi06IZAPRmOjAuafrh5dA
Date:   Wed, 15 Jan 2020 10:35:07 +0000
Message-ID: <25ac63eaebb44564b830c697c27f959c@AcuMS.aculab.com>
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
 <20200114213914.198223-1-ndesaulniers@google.com>
In-Reply-To: <20200114213914.198223-1-ndesaulniers@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 5k3V9LDIOLu6s8nwG4L9TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxNCBKYW51YXJ5IDIwMjAgMjE6MzkNCi4u
Lg0KPiBZZWFoLCBoYXJkIHJlcXVpcmVtZW50IHNvdW5kcyBnb29kIHRvIG1lLiBBcm5kLCBkbyB5
b3UgaGF2ZSBzdGF0cyBvbiB3aGljaA0KPiBkaXN0cm9zIGhhdmUgd2hpY2ggdmVyc2lvbnMgb2Yg
R0NDIChJSVJDLCB5b3UgaGFkIHNvbWUgc3RhdHMgZm9yIHRoZSBHQ0MgNC42DQo+IHVwZ3JhZGUp
PyBUaGlzIGFsbG93cyB1cyB0byBjbGVhbiB1cCBtb3JlIGNydWZ0IGluIHRoZSBrZXJuZWwgKGdy
ZXAgZm9yDQo+IEdDQ19WRVJTSU9OKS4NCg0KRldJVyBNeSBVYnVudHUgMTMuMDQgc3lzdGVtIGhh
cyBnY2MgNC43LjMuDQooQWN0dWFsbHksIGxvb2tpbmcgaW4gL3Vzci9iaW4gdGhlcmUgaXMgYSBj
b3B5IG9mIDQuOC4xIGZyb20gdGhlIG9yaWdpbmFsIGluc3RhbGwuKQ0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

