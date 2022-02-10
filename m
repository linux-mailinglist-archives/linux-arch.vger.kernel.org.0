Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5334B1851
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 23:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiBJWi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 17:38:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbiBJWi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 17:38:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C0626D4
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 14:38:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-YriZOnoSNKCN8L5w2e2KaA-1; Thu, 10 Feb 2022 22:38:54 +0000
X-MC-Unique: YriZOnoSNKCN8L5w2e2KaA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 22:38:51 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 22:38:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: RE: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Index: AQHYHgPE4ng9s1QFWkGaF1pqJykcg6yNYAXA
Date:   Thu, 10 Feb 2022 22:38:51 +0000
Message-ID: <1b5d83dc4cd84309823f012a3dce24f0@AcuMS.aculab.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-19-rick.p.edgecombe@intel.com>
 <f92c5110-7d97-b68d-d387-7e6a16a29e49@intel.com>
In-Reply-To: <f92c5110-7d97-b68d-d387-7e6a16a29e49@intel.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDkgRmVicnVhcnkgMjAyMiAyMjoyNA0KPiANCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gSU5DU1NQKFEvRCkg
aW5jcmVtZW50cyBzaGFkb3cgc3RhY2sgcG9pbnRlciBhbmQgJ3BvcHMgYW5kIGRpc2NhcmRzJyB0
aGUNCj4gPiBmaXJzdCBhbmQgdGhlIGxhc3QgZWxlbWVudHMgaW4gdGhlIHJhbmdlLCBlZmZlY3Rp
dmVseSB0b3VjaGVzIHRob3NlIG1lbW9yeQ0KPiA+IGFyZWFzLg0KPiANCj4gVGhpcyBpcyBhIHBy
ZXR0eSBjbG9zZSBjb3B5IG9mIHRoZSBpbnN0cnVjdGlvbiByZWZlcmVuY2UgdGV4dCBmb3INCj4g
SU5DU1NQLiAgSSdtIGZlZWxpbmcgcmF0aGVyIGRlbnNlIHRvZGF5LCBidXQgdGhhdCdzIGp1c3Qg
bm90IG1ha2luZyBhbnkNCj4gc2Vuc2UuDQo+IA0KPiBUaGUgcHNldWRvY29kZSBpcyBtb3JlIHNl
bnNpYmxlIGluIHRoZSBTRE0uICBJIHRoaW5rIHRoaXMgbmVlZHMgYSBiZXR0ZXINCj4gZXhwbGFu
YXRpb246DQo+IA0KPiAJVGhlIElOQ1NTUCBpbnN0cnVjdGlvbiBpbmNyZW1lbnRzIHRoZSBzaGFk
b3cgc3RhY2sgcG9pbnRlci4gIEl0DQo+IAlpcyB0aGUgc2hhZG93IHN0YWNrIGFuYWxvZyBvZiBh
biBpbnN0cnVjdGlvbiBsaWtlOg0KPiANCj4gCQlhZGRxCSQweDgwLCAlcnNwDQo+IA0KPiAJSG93
ZXZlciwgdGhlcmUgaXMgb25lIGltcG9ydGFudCBkaWZmZXJlbmNlIGJldHdlZW4gYW4gQUREIG9u
DQo+IAklcnNwIGFuZCBJTkNTU1AuICBJbiBhZGRpdGlvbiB0byBtb2RpZnlpbmcgU1NQLCBJTkNT
U1AgYWxzbw0KPiAJcmVhZHMgZnJvbSB0aGUgbWVtb3J5IG9mIHRoZSBmaXJzdCBhbmQgbGFzdCBl
bGVtZW50cyB0aGF0IHdlcmUNCj4gCSJwb3BwZWQiLiAgWW91IGNhbiB0aGluayBvZiBpdCBhcyBh
Y3RpbmcgbGlrZSB0aGlzOg0KPiANCj4gCVJFQURfT05DRShzc3ApOyAgICAgICAvLyByZWFkK2Rp
c2NhcmQgdG9wIGVsZW1lbnQgb24gc3RhY2sNCj4gCXNzcCArPSBucl90b19wb3AgKiA4OyAvLyBt
b3ZlIHRoZSBzaGFkb3cgc3RhY2sNCj4gCVJFQURfT05DRShzc3AtOCk7ICAgICAvLyByZWFkK2Rp
c2NhcmQgbGFzdCBwb3BwZWQgc3RhY2sgZWxlbWVudA0KPiANCj4gDQo+ID4gVGhlIG1heGltdW0g
bW92aW5nIGRpc3RhbmNlIGJ5IElOQ1NTUFEgaXMgMjU1ICogOCA9IDIwNDAgYnl0ZXMgYW5kDQo+
ID4gMjU1ICogNCA9IDEwMjAgYnl0ZXMgYnkgSU5DU1NQRC4gIEJvdGggcmFuZ2VzIGFyZSBmYXIg
ZnJvbSBQQUdFX1NJWkUuDQo+IA0KPiAuLi4gVGhhdCBtYXhpbXVtIGRpc3RhbmNlLCBjb21iaW5l
ZCB3aXRoIGFuIGEgZ3VhcmQgcGFnZXMgYXQgdGhlIGVuZCBvZg0KPiBhIHNoYWRvdyBzdGFjayBl
bnN1cmVzIHRoYXQgSU5DU1NQIHdpbGwgZmF1bHQgYmVmb3JlIGl0IGlzIGFibGUgdG8gbW92ZQ0K
PiBhY3Jvc3MgYW4gZW50aXJlIGd1YXJkIHBhZ2UuDQo+IA0KPiA+IFRodXMsIHB1dHRpbmcgYSBn
YXAgcGFnZSBvbiBib3RoIGVuZHMgb2YgYSBzaGFkb3cgc3RhY2sgcHJldmVudHMgSU5DU1NQLA0K
PiA+IENBTEwsIGFuZCBSRVQgZnJvbSBnb2luZyBiZXlvbmQuDQoNCkRvIHlvdSBuZWVkIGEgcmVh
bCBndWFyZCBwYWdlPw0KT3IgaXMgaXQganVzdCBlbm91Z2ggdG8gZW5zdXJlIHRoYXQgdGhlIGFk
amFjZW50IHBhZ2UgaXNuJ3QgYW5vdGhlcg0Kc2hhZG93IHN0YWNrIHBhZ2U/DQoNCkFueSBvdGhl
ciBwYWdlIHdpbGwgY2F1c2UgYSBmYXVsdCBiZWNhdXNlIHRoZSBQVEUgaXNuJ3QgcmVhZG9ubHkr
ZGlydHkuDQoNCkknbSBub3Qgc3VyZSBob3cgY29tbW9uIHNpbmdsZSBwYWdlIGFsbG9jYXRlcyBh
cmUgaW4gTGludXguDQpCdXQgYWRqYWNlbnQgc2hhZG93IHN0YWNrcyBtYXkgYmUgcmFyZSBhbnl3
YXkuDQpTbyBhIGNoZWNrIGFnYWluc3QgYm90aCBhZGphY2VudCBQVEUgZW50cmllcyB3b3VsZCBz
dWZmaWNlLg0KT3IgbWF5YmUgYWx3YXlzIGFsbG9jYXRlIGFuIGV2ZW4gKG9yIG9kZCkgbnVtYmVy
ZWQgcGFnZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

