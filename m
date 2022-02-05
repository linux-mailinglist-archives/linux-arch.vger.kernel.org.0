Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20424AA91D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Feb 2022 14:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379971AbiBEN1Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Feb 2022 08:27:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49408 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240644AbiBEN1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Feb 2022 08:27:16 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-123-BRt4ukDkO9O74xW5paCCLg-1; Sat, 05 Feb 2022 13:27:02 +0000
X-MC-Unique: BRt4ukDkO9O74xW5paCCLg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 5 Feb 2022 13:27:00 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 5 Feb 2022 13:27:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Edgecombe, Rick P'" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: RE: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwCAAl19kA==
Date:   Sat, 5 Feb 2022 13:26:59 +0000
Message-ID: <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
References: <87fsozek0j.ffs@tglx>
 <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
In-Reply-To: <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
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

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFANCj4gU2VudDogMDQgRmVicnVhcnkgMjAyMiAwMTowOA0K
PiBIaSBUaG9tYXMsDQo+IA0KPiBUaGFua3MgZm9yIGZlZWRiYWNrIG9uIHRoZSBwbGFuLg0KPiAN
Cj4gT24gVGh1LCAyMDIyLTAyLTAzIGF0IDIyOjA3ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3Jv
dGU6DQo+ID4gPiBVbnRpbCBub3csIHRoZSBlbmFibGluZyBlZmZvcnQgd2FzIHRyeWluZyB0byBz
dXBwb3J0IGJvdGggU2hhZG93DQo+ID4gPiBTdGFjayBhbmQgSUJULg0KPiA+ID4gVGhpcyBoaXN0
b3J5IHdpbGwgZm9jdXMgb24gYSBmZXcgYXJlYXMgb2YgdGhlIHNoYWRvdyBzdGFjaw0KPiA+ID4g
ZGV2ZWxvcG1lbnQgaGlzdG9yeQ0KPiA+ID4gdGhhdCBJIHRob3VnaHQgc3Rvb2Qgb3V0Lg0KPiA+
ID4NCj4gPiA+ICAgICAgICBTaWduYWxzDQo+ID4gPiAgICAgICAgLS0tLS0tLQ0KPiA+ID4gICAg
ICAgIE9yaWdpbmFsbHkgc2lnbmFscyBwbGFjZWQgdGhlIGxvY2F0aW9uIG9mIHRoZSBzaGFkb3cg
c3RhY2sNCj4gPiA+IHJlc3RvcmUNCj4gPiA+ICAgICAgICB0b2tlbiBpbnNpZGUgdGhlIHNhdmVk
IHN0YXRlIG9uIHRoZSBzdGFjay4gVGhpcyB3YXMNCj4gPiA+IHByb2JsZW1hdGljIGZyb20gYQ0K
PiA+ID4gICAgICAgIHBhc3QgQUJJIHByb21pc2VzIHBlcnNwZWN0aXZlLiBTbyB0aGUgcmVzdG9y
ZSBsb2NhdGlvbiB3YXMNCj4gPiA+IGluc3RlYWQganVzdA0KPiA+ID4gICAgICAgIGFzc3VtZWQg
ZnJvbSB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIuIFRoaXMgd29ya3MgYmVjYXVzZSBpbg0KPiA+
ID4gbm9ybWFsDQo+ID4gPiAgICAgICAgYWxsb3dlZCBjYXNlcyBvZiBjYWxsaW5nIHNpZ3JldHVy
biwgdGhlIHNoYWRvdyBzdGFjayBwb2ludGVyDQo+ID4gPiBzaG91bGQgYmUNCj4gPiA+ICAgICAg
ICByaWdodCBhdCB0aGUgcmVzdG9yZSB0b2tlbiBhdCB0aGF0IHRpbWUuIFRoZXJlIGlzIG5vDQo+
ID4gPiBhbHRlcm5hdGUgc2hhZG93DQo+ID4gPiAgICAgICAgc3RhY2sgc3VwcG9ydC4gSWYgYW4g
YWx0IHNoYWRvdyBzdGFjayBpcyBhZGRlZCBsYXRlciB3ZQ0KPiA+ID4gd291bGQNCj4gPiA+ICAg
ICAgICBuZWVkIHRvDQo+ID4NCj4gPiBTbyBob3cgaXMgdGhhdCBnb2luZyB0byB3b3JrPyBhbHRz
dGFjayBpcyBub3QgYW4gZXNvdGVyaWMgY29ybmVyDQo+ID4gY2FzZS4NCj4gDQo+IE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCB0aGUgbWFpbiB1c2FnZXMgZm9yIHRoZSBzaWduYWwgc3RhY2sgd2Vy
ZQ0KPiBoYW5kbGluZyBzdGFjayBvdmVyZmxvd3MgYW5kIGNvcnJ1cHRpb24uIFNpbmNlIHRoZSBz
aGFkb3cgc3RhY2sgb25seQ0KPiBjb250YWlucyByZXR1cm4gYWRkcmVzc2VzIHJhdGhlciB0aGFu
IGxhcmdlIHN0YWNrIGFsbG9jYXRpb25zLCBhbmQgaXMNCj4gbm90IGdlbmVyYWxseSB3cml0YWJs
ZSBvciBwaXZvdGFibGUsIEkgdGhvdWdodCB0aGVyZSB3YXMgYSBnb29kDQo+IHBvc3NpYmlsaXR5
IGFuIGFsdCBzaGFkb3cgc3RhY2sgd291bGQgbm90IGVuZCB1cCBiZWluZyBlc3BlY2lhbGx5DQo+
IHVzZWZ1bC4gRG9lcyBpdCBzZWVtIGxpa2UgcmVhc29uYWJsZSBndWVzc3dvcms/DQoNClRoZSBv
dGhlciAncHJvYmxlbScgaXMgdGhhdCBpdCBpcyB2YWxpZCB0byBsb25nanVtcCBvdXQgb2YgYSBz
aWduYWwgaGFuZGxlci4NClRoZXNlIGRheXMgeW91IGhhdmUgdG8gdXNlIHNpZ2xvbmdqbXAoKSBu
b3QgbG9uZ2ptcCgpIGJ1dCBpdCBpcyBzdGlsbCB1c2VkLg0KDQpJdCBpcyBwcm9iYWJseSBhbHNv
IHZhbGlkIHRvIHVzZSBzaWdsb25nam1wKCkgdG8ganVtcCBmcm9tIGEgbmVzdGVkDQpzaWduYWwg
aGFuZGxlciBpbnRvIHRoZSBvdXRlciBoYW5kbGVyLg0KR2l2ZW4gYm90aCBzaWduYWwgaGFuZGxl
cnMgY2FuIGhhdmUgdGhlaXIgb3duIHN0YWNrLCB0aGVyZSBjYW4gYmUgdGhyZWUNCnN0YWNrcyBp
bnZvbHZlZC4NCg0KSSB0aGluayB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIgaGFzIHRvIGJlIGlu
IHVjb250ZXh0IC0gd2hpY2ggYWxzbw0KbWVhbnMgdGhlIGFwcGxpY2F0aW9uIGNhbiBjaGFuZ2Ug
aXQgYmVmb3JlIHJldHVybmluZyBmcm9tIGEgc2lnbmFsLg0KSW4gbXVjaCB0aGUgc2FtZSB3YXkg
YXMgYWxsIHRoZSBzZWdtZW50IHJlZ2lzdGVycyBjYW4gYmUgY2hhbmdlZA0KbGVhZGluZyB0byBh
bGwgdGhlIG5hc3R5IGJ1Z3Mgd2hlbiB0aGUgZmluYWwgJ3JldHVybiB0byB1c2VyJyBjb2RlDQp0
cmFwcyBpbiBrZXJuZWwgd2hlbiBsb2FkaW5nIGludmFsaWQgc2VnbWVudCByZWdpc3RlcnMgb3Ig
ZXhlY3V0aW5nIGlyZXQuDQoNCkhtbW0uLi4gZG8gc2hhZG93IHN0YWNrcyBtZWFuIHRoYXQgbG9u
Z2ptcCgpIGhhcyB0byBiZSBhIHN5c3RlbSBjYWxsPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

