Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C377D1B21C
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfEMIwq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 04:52:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58028 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728336AbfEMIwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 04:52:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-wJHPV_UlNTueMoK28eZKkA-1; Mon, 13 May 2019 09:52:42 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 13 May 2019 09:52:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 May 2019 09:52:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'christophe leroy' <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        "Stephen Rothwell" <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Topic: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Index: AQHVB1bC/iTC8Q7sI0elwkZY5/gFJaZowlxw
Date:   Mon, 13 May 2019 08:52:41 +0000
Message-ID: <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
In-Reply-To: <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: wJHPV_UlNTueMoK28eZKkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogY2hyaXN0b3BoZSBsZXJveQ0KPiBTZW50OiAxMCBNYXkgMjAxOSAxODozNQ0KPiBMZSAx
MC8wNS8yMDE5IMOgIDE4OjI0LCBTdGV2ZW4gUm9zdGVkdCBhIMOpY3JpdMKgOg0KPiA+IE9uIEZy
aSwgMTAgTWF5IDIwMTkgMTA6NDI6MTMgKzAyMDANCj4gPiBQZXRyIE1sYWRlayA8cG1sYWRla0Bz
dXNlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gICBzdGF0aWMgY29uc3QgY2hhciAqY2hlY2tfcG9p
bnRlcl9tc2coY29uc3Qgdm9pZCAqcHRyKQ0KPiA+PiAgIHsNCj4gPj4gLQljaGFyIGJ5dGU7DQo+
ID4+IC0NCj4gPj4gICAJaWYgKCFwdHIpDQo+ID4+ICAgCQlyZXR1cm4gIihudWxsKSI7DQo+ID4+
DQo+ID4+IC0JaWYgKHByb2JlX2tlcm5lbF9hZGRyZXNzKHB0ciwgYnl0ZSkpDQo+ID4+ICsJaWYg
KCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCj4g
Pj4gICAJCXJldHVybiAiKGVmYXVsdCkiOw0KDQoiZWZhdWx0IiBsb29rcyBhIGJpdCBsaWtlIGEg
c3BlbGxsaW5nIG1pc3Rha2UgZm9yICJkZWZhdWx0Ii4NCg0KPiA+IAk8IFBBR0VfU0laRSA/DQo+
ID4NCj4gPiBkbyB5b3UgbWVhbjogPCBUQVNLX1NJWkUgPw0KPiANCj4gSSBndWVzcyBub3QuDQo+
IA0KPiBVc3VhbGx5LCA8IFBBR0VfU0laRSBtZWFucyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
KHZpYSB0aGUgbWVtYmVyIG9mIGENCj4gc3RydWN0KQ0KDQpNYXliZSB0aGUgY2FsbGVyIHNob3Vs
ZCBwYXNzIGluIGEgc2hvcnQgYnVmZmVyIHNvIHRoYXQgeW91IGNhbiByZXR1cm4NCiIoZXJyLSVk
KSIgb3IgIihudWxsKyUjeCkiID8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

