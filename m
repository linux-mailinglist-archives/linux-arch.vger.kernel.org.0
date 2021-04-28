Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09C36DBB9
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhD1PeW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 11:34:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:46656 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239793AbhD1PeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 11:34:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-90-SNanzEVoNu2IAa9tKQxnuw-1; Wed, 28 Apr 2021 16:33:32 +0100
X-MC-Unique: SNanzEVoNu2IAa9tKQxnuw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 28 Apr 2021 16:33:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 28 Apr 2021 16:33:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        Pengfei Xu <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>
Subject: RE: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
Thread-Topic: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
Thread-Index: AQHXO6ae1Nsozyj+DkCGokhshY0p/arKAkvwgAAI5giAAAIBgA==
Date:   Wed, 28 Apr 2021 15:33:29 +0000
Message-ID: <0c6e1c922bc54326b1121194759565f5@AcuMS.aculab.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
 <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
 <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
 <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
In-Reply-To: <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDI4IEFwcmlsIDIwMjEgMTY6MTUNCj4gDQo+
IE9uIFdlZCwgQXByIDI4LCAyMDIxIGF0IDc6NTcgQU0gSC5KLiBMdSA8aGpsLnRvb2xzQGdtYWls
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIEFwciAyOCwgMjAyMSBhdCA3OjUyIEFNIEFu
ZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBX
ZWQsIEFwciAyOCwgMjAyMSBhdCA3OjQ4IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBZdS1jaGVuZyBZdQ0KPiA+
ID4gPiA+IFNlbnQ6IDI3IEFwcmlsIDIwMjEgMjE6NDcNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENv
bnRyb2wtZmxvdyBFbmZvcmNlbWVudCAoQ0VUKSBpcyBhIG5ldyBJbnRlbCBwcm9jZXNzb3IgZmVh
dHVyZSB0aGF0IGJsb2Nrcw0KPiA+ID4gPiA+IHJldHVybi9qdW1wLW9yaWVudGVkIHByb2dyYW1t
aW5nIGF0dGFja3MuICBEZXRhaWxzIGFyZSBpbiAiSW50ZWwgNjQgYW5kDQo+ID4gPiA+ID4gSUEt
MzIgQXJjaGl0ZWN0dXJlcyBTb2Z0d2FyZSBEZXZlbG9wZXIncyBNYW51YWwiIFsxXS4NCj4gPiA+
ID4gLi4uDQo+ID4gPiA+DQo+ID4gPiA+IERvZXMgdGhpcyBmZWF0dXJlIHJlcXVpcmUgdGhhdCAn
YmluYXJ5IGJsb2JzJyBmb3Igb3V0IG9mIHRyZWUgZHJpdmVycw0KPiA+ID4gPiBiZSBjb21waWxl
ZCBieSBhIHZlcnNpb24gb2YgZ2NjIHRoYXQgYWRkcyB0aGUgRU5EQlJBIGluc3RydWN0aW9ucz8N
Cj4gPiA+ID4NCj4gPiA+ID4gSWYgZW5hYmxlZCBmb3IgdXNlcnNwYWNlLCB3aGF0IGhhcHBlbnMg
aWYgYW4gb2xkIC5zbyBpcyBkeW5hbWljYWxseQ0KPiA+ID4gPiBsb2FkZWQ/DQo+ID4NCj4gPiBD
RVQgd2lsbCBiZSBkaXNhYmxlZCBieSBsZC5zbyBpbiB0aGlzIGNhc2UuDQo+IA0KPiBXaGF0IGlm
IGEgcHJvZ3JhbSBzdGFydHMgYSB0aHJlYWQgYW5kIHRoZW4gZGxvcGVucyBhIGxlZ2FjeSAuc28/
DQoNCk9yIGhhcyBzaGFkb3cgc3RhY2sgZW5hYmxlZCBhbmQgb3BlbnMgYSAuc28gdGhhdCB1c2Vz
IHJldHBvbGluZXM/DQoNCj4gPiA+ID4gT3IgZG8gYWxsIHVzZXJzcGFjZSBwcm9ncmFtcyBhbmQg
bGlicmFyaWVzIGhhdmUgdG8gaGF2ZSBiZWVuIGNvbXBpbGVkDQo+ID4gPiA+IHdpdGggdGhlIEVO
REJSQSBpbnN0cnVjdGlvbnM/DQo+ID4NCj4gPiBDb3JyZWN0LiAgbGQgYW5kIGxkLnNvIGNoZWNr
IHRoaXMuDQo+ID4NCj4gPiA+IElmIHlvdSBiZWxpZXZlIHRoYXQgdGhlIHVzZXJzcGFjZSB0b29s
aW5nIGZvciB0aGUgbGVnYWN5IElCVCB0YWJsZQ0KPiA+ID4gYWN0dWFsbHkgd29ya3MsIHRoZW4g
aXQgc2hvdWxkIGp1c3Qgd29yay4gIFl1LWNoZW5nLCBldGM6IGhvdyB3ZWxsDQo+ID4gPiB0ZXN0
ZWQgaXMgaXQ/DQo+ID4gPg0KPiA+DQo+ID4gTGVnYWN5IElCVCBiaXRtYXAgaXNuJ3QgdW51c2Vk
IHNpbmNlIGl0IGRvZXNuJ3QgY292ZXIgbGVnYWN5IGNvZGVzDQo+ID4gZ2VuZXJhdGVkIGJ5IGxl
Z2FjeSBKSVRzLg0KPiA+DQo+IA0KPiBIb3cgZG9lcyBsZC5zbyBkZWNpZGUgd2hldGhlciBhIGxl
Z2FjeSBKSVQgaXMgaW4gdXNlPw0KDQpXaGF0IGlmIHlvdXIgbWFsd2FyZSBqdXN0IHByZWNlZGVz
IGl0cyAnanVtcCBpbnRvIHRoZSBtaWRkbGUgb2YgYSBmdW5jdGlvbicNCndpdGggYSAlZHMgc2Vn
bWVudCBvdmVycmlkZT8NCg0KSSBtYXkgaGF2ZSBhIHJlYWwgcHJvYmxlbSBoZXJlLg0KV2UgY3Vy
cmVudGx5IHJlbGVhc2UgcHJvZ3JhbS9saWJyYXJ5IGJpbmFyaWVzIHRoYXQgcnVuIG9uIExpbnV4
DQpkaXN0cmlidXRpb25zIHRoYXQgZ28gYmFjayBhcyBmYXIgYXMgUkhFTDYgKDIuNi4zMiBrZXJu
ZWwgZXJhKS4NClRvIGRvIHRoaXMgZXZlcnl0aGluZyBpcyBjb21waWxlZCBvbiBhIHVzZXJzcGFj
ZSBvZiB0aGUgc2FtZSB2aW50YWdlLg0KSSdtIG5vdCBhdCBhbGwgc3VyZSBhIG5ldyBlbm91Z2gg
Z2NjIHRvIGdlbmVyYXRlIHRoZSBFTkRCUjY0IGluc3RydWN0aW9ucw0Kd2lsbCBydW4gb24gdGhl
IHJlbGV2YW50IHN5c3RlbSAtIGFuZCBtYXkgYmFyZiBvbiB0aGUgc3lzdGVtIGhlYWRlcnMNCmV2
ZW4gaWYgd2UgZ290IGl0IHRvIHJ1bi4NCkkgcmVhbGx5IGRvbid0IHdhbnQgdG8gaGF2ZSB0byBi
dWlsZCBtdWx0aXBsZSBjb3BpZXMgb2YgZXZlcnl0aGluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

