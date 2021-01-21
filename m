Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411562FF7D2
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbhAUWRw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 17:17:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54986 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbhAUWRt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 17:17:49 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-244-l2OEnG_AOqSZjOQ6quE8Sw-1; Thu, 21 Jan 2021 22:16:09 +0000
X-MC-Unique: l2OEnG_AOqSZjOQ6quE8Sw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 21 Jan 2021 22:16:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 21 Jan 2021 22:16:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Yu, Yu-cheng'" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: RE: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHW8DMjsVkr7OKTZEWf0jgz1DSfFaoyopGA
Date:   Thu, 21 Jan 2021 22:16:08 +0000
Message-ID: <cd9d04ab66d144b7942b5030d9813115@AcuMS.aculab.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
In-Reply-To: <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
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

RnJvbTogWXUsIFl1LWNoZW5nIA0KPiANCj4gT24gMS8yMS8yMDIxIDEwOjQ0IEFNLCBCb3Jpc2xh
diBQZXRrb3Ygd3JvdGU6DQo+ID4gT24gVHVlLCBEZWMgMjksIDIwMjAgYXQgMDE6MzA6MzVQTSAt
MDgwMCwgWXUtY2hlbmcgWXUgd3JvdGU6DQo+IFsuLi5dDQo+ID4+IEBAIC0zNDMsNiArMzQ5LDE2
IEBAIHN0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX21rb2xkKHB0ZV90IHB0ZSkNCj4gPj4NCj4gPj4g
ICBzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV93cnByb3RlY3QocHRlX3QgcHRlKQ0KPiA+PiAgIHsN
Cj4gPj4gKwkvKg0KPiA+PiArCSAqIEJsaW5kbHkgY2xlYXJpbmcgX1BBR0VfUlcgbWlnaHQgYWNj
aWRlbnRhbGx5IGNyZWF0ZQ0KPiA+PiArCSAqIGEgc2hhZG93IHN0YWNrIFBURSAoUlc9MCwgRGly
dHk9MSkuICBNb3ZlIHRoZSBoYXJkd2FyZQ0KPiA+PiArCSAqIGRpcnR5IHZhbHVlIHRvIHRoZSBz
b2Z0d2FyZSBiaXQuDQo+ID4+ICsJICovDQo+ID4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfU0hTVEspKSB7DQo+ID4+ICsJCXB0ZS5wdGUgfD0gKHB0ZS5wdGUgJiBfUEFH
RV9ESVJUWSkgPj4gX1BBR0VfQklUX0RJUlRZIDw8IF9QQUdFX0JJVF9DT1c7DQo+ID4NCj4gPiBX
aHkgdGhlIHVucmVhZGFibGUgc2hpZnRpbmcgd2hlbiB5b3UgY2FuIHNpbXBseSBkbzoNCj4gPg0K
PiA+ICAgICAgICAgICAgICAgICAgaWYgKHB0ZS5wdGUgJiBfUEFHRV9ESVJUWSkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgcHRlLnB0ZSB8PSBfUEFHRV9DT1c7DQo+ID4NCg0KPiA+ID8N
Cj4gDQo+IEl0IGNsZWFycyBfUEFHRV9ESVJUWSBhbmQgc2V0cyBfUEFHRV9DT1cuICBUaGF0IGlz
LA0KPiANCj4gaWYgKHB0ZS5wdGUgJiBfUEFHRV9ESVJUWSkgew0KPiAJcHRlLnB0ZSAmPSB+X1BB
R0VfRElSVFk7DQo+IAlwdGUucHRlIHw9IF9QQUdFX0NPVzsNCj4gfQ0KPiANCj4gU28sIHNoaWZ0
aW5nIG1ha2VzIHJlc3VsdGluZyBjb2RlIG1vcmUgZWZmaWNpZW50Lg0KDQpEb2VzIHRoZSBjb21w
aWxlciBtYW5hZ2UgdG8gZG8gb25lIHNoaWZ0Pw0KDQpIb3cgY2FuIGl0IGNsZWFyIGFueXRoaW5n
Pw0KVGhlcmUgaXMgb25seSBhbiB8PSBhZ2FpbnN0IHRoZSB0YXJnZXQuDQoNClNvbWV0aGluZyBo
b3JyaWQgd2l0aCBePSBtaWdodCBzZXQgYW5kIGNsZWFyLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

