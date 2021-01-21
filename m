Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1582FF80E
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 23:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAUWhl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 17:37:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56170 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbhAUWhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 17:37:38 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-38-cV8mqR_5PLm3VtoUQ_JE_Q-1; Thu, 21 Jan 2021 22:32:43 +0000
X-MC-Unique: cV8mqR_5PLm3VtoUQ_JE_Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 21 Jan 2021 22:32:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 21 Jan 2021 22:32:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        "'Yu, Yu-cheng'" <yu-cheng.yu@intel.com>,
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: RE: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHW8DMjsVkr7OKTZEWf0jgz1DSfFaoyopGAgAAD/wCAAAFTAA==
Date:   Thu, 21 Jan 2021 22:32:35 +0000
Message-ID: <b6eda0f414f34634b4e1aca80c4b5d5d@AcuMS.aculab.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
 <cd9d04ab66d144b7942b5030d9813115@AcuMS.aculab.com>
 <9344cd90-1818-a716-91d2-2b85df01347b@infradead.org>
In-Reply-To: <9344cd90-1818-a716-91d2-2b85df01347b@infradead.org>
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

RnJvbTogUmFuZHkgRHVubGFwDQo+IFNlbnQ6IDIxIEphbnVhcnkgMjAyMSAyMjoxOQ0KPiANCj4g
T24gMS8yMS8yMSAyOjE2IFBNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogWXUsIFl1
LWNoZW5nDQo+ID4+DQo+ID4+IE9uIDEvMjEvMjAyMSAxMDo0NCBBTSwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiA+Pj4gT24gVHVlLCBEZWMgMjksIDIwMjAgYXQgMDE6MzA6MzVQTSAtMDgwMCwg
WXUtY2hlbmcgWXUgd3JvdGU6DQo+ID4+IFsuLi5dDQo+ID4+Pj4gQEAgLTM0Myw2ICszNDksMTYg
QEAgc3RhdGljIGlubGluZSBwdGVfdCBwdGVfbWtvbGQocHRlX3QgcHRlKQ0KPiA+Pj4+DQo+ID4+
Pj4gICBzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV93cnByb3RlY3QocHRlX3QgcHRlKQ0KPiA+Pj4+
ICAgew0KPiA+Pj4+ICsJLyoNCj4gPj4+PiArCSAqIEJsaW5kbHkgY2xlYXJpbmcgX1BBR0VfUlcg
bWlnaHQgYWNjaWRlbnRhbGx5IGNyZWF0ZQ0KPiA+Pj4+ICsJICogYSBzaGFkb3cgc3RhY2sgUFRF
IChSVz0wLCBEaXJ0eT0xKS4gIE1vdmUgdGhlIGhhcmR3YXJlDQo+ID4+Pj4gKwkgKiBkaXJ0eSB2
YWx1ZSB0byB0aGUgc29mdHdhcmUgYml0Lg0KPiA+Pj4+ICsJICovDQo+ID4+Pj4gKwlpZiAoY3B1
X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNUSykpIHsNCj4gPj4+PiArCQlwdGUucHRl
IHw9IChwdGUucHRlICYgX1BBR0VfRElSVFkpID4+IF9QQUdFX0JJVF9ESVJUWSA8PCBfUEFHRV9C
SVRfQ09XOw0KPiA+Pj4NCj4gPj4+IFdoeSB0aGUgdW5yZWFkYWJsZSBzaGlmdGluZyB3aGVuIHlv
dSBjYW4gc2ltcGx5IGRvOg0KPiA+Pj4NCj4gPj4+ICAgICAgICAgICAgICAgICAgaWYgKHB0ZS5w
dGUgJiBfUEFHRV9ESVJUWSkNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBwdGUucHRl
IHw9IF9QQUdFX0NPVzsNCj4gPj4+DQo+ID4NCj4gPj4+ID8NCj4gPj4NCj4gPj4gSXQgY2xlYXJz
IF9QQUdFX0RJUlRZIGFuZCBzZXRzIF9QQUdFX0NPVy4gIFRoYXQgaXMsDQo+ID4+DQo+ID4+IGlm
IChwdGUucHRlICYgX1BBR0VfRElSVFkpIHsNCj4gPj4gCXB0ZS5wdGUgJj0gfl9QQUdFX0RJUlRZ
Ow0KPiA+PiAJcHRlLnB0ZSB8PSBfUEFHRV9DT1c7DQo+ID4+IH0NCj4gPj4NCj4gPj4gU28sIHNo
aWZ0aW5nIG1ha2VzIHJlc3VsdGluZyBjb2RlIG1vcmUgZWZmaWNpZW50Lg0KPiA+DQo+ID4gRG9l
cyB0aGUgY29tcGlsZXIgbWFuYWdlIHRvIGRvIG9uZSBzaGlmdD8NCj4gPg0KPiA+IEhvdyBjYW4g
aXQgY2xlYXIgYW55dGhpbmc/DQo+IA0KPiBJdCBjb3VsZCBzaGlmdCBpdCBvZmYgZWl0aGVyIGVu
ZCBzaW5jZSB0aGVyZSBhcmUgYm90aCA8PCBhbmQgPj4uDQoNCkl0IGlzIHN0aWxsOg0KCXB0ZS5w
dGUgfD0geHh4eHh4eDsNCg0KPiA+IFRoZXJlIGlzIG9ubHkgYW4gfD0gYWdhaW5zdCB0aGUgdGFy
Z2V0Lg0KPiA+DQo+ID4gU29tZXRoaW5nIGhvcnJpZCB3aXRoIF49IG1pZ2h0IHNldCBhbmQgY2xl
YXIuDQoNCkl0IGNvdWxkIGJlIDQgaW5zdHJ1Y3Rpb25zOg0KCWlzX2RpcnR5ID0gcHRlLnB0ZSAm
IFBBR0VfRElSVFk7DQoJcHRlLnB0ZSAmPSB+UEFHRV9ESVJUWTsgLy8gb3IgcHRlLnB0ZSBePSBp
c19kaXJ0eQ0KCWlzX2NvdyA9IGlzX2RpcnR5IDw8IChCSVRfQ09XIC0gQklUX0RJUlRZKTsgLy8g
b3IgZXF1aXZhbGVudCA+Pg0KCXB0ZS5wdGUgfD0gaXNfY293Ow0KcHJvdmlkZWQgeW91J3ZlIGEg
dGhyZWUgb3BlcmFuZCBmb3JtIGZvciBvbmUgb2YgdGhlIGZpcnN0IHR3byBpbnN0cnVjdGlvbnMu
DQpTb21ldGhpbmcgbGlrZSBBUk0gbWlnaHQgbWFuYWdlIHRvIG1lcmdlIHRoZSBsYXN0IHR3byBh
cyB3ZWxsLg0KQnV0IHRoZSByZWdpc3RlciBkZXBlbmRlbmN5IGNoYWluIGxlbmd0aCBtYXkgbWF0
dGVyIG1vcmUgdGhhbg0KdGhlIG51bWJlciBvZiBpbnN0cnVjdGlvbnMuDQpUaGUgYWJvdmUgaXMg
bGlrZWx5IHRvIGJlIHRocmVlIGxvbmcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

