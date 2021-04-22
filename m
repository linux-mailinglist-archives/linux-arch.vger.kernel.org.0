Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED9367E21
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhDVJtW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 05:49:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48907 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235762AbhDVJtV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 05:49:21 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-u9EizjiyOa6oT5HDclJV4g-1; Thu, 22 Apr 2021 10:48:43 +0100
X-MC-Unique: u9EizjiyOa6oT5HDclJV4g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 10:48:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 22 Apr 2021 10:48:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marco Elver' <elver@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christian@brauner.io" <christian@brauner.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pcc@google.com" <pcc@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
Thread-Topic: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
Thread-Index: AQHXN0MFjTlB/ZNe8Eu7kYRWV5A4q6rAQy8Q
Date:   Thu, 22 Apr 2021 09:48:42 +0000
Message-ID: <d480a4f56d544fb98eb1cdd62f44ae91@AcuMS.aculab.com>
References: <20210422064437.3577327-1-elver@google.com>
In-Reply-To: <20210422064437.3577327-1-elver@google.com>
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

RnJvbTogTWFyY28gRWx2ZXINCj4gU2VudDogMjIgQXByaWwgMjAyMSAwNzo0NQ0KPiANCj4gT24g
c29tZSBhcmNoaXRlY3R1cmVzLCBsaWtlIEFybSwgdGhlIGFsaWdubWVudCBvZiBhIHN0cnVjdHVy
ZSBpcyB0aGF0IG9mDQo+IGl0cyBsYXJnZXN0IG1lbWJlci4NCg0KVGhhdCBpcyB0cnVlIGV2ZXJ5
d2hlcmUuDQooQXBhcnQgZnJvbSBvYnNjdXJlIEFCSSB3aGVyZSBzdHJ1Y3R1cmUgaGF2ZSBhdCBs
ZWFzdCA0IGJ5dGUgYWxpZ25tZW50ISkNCg0KPiBUaGlzIG1lYW5zIHRoYXQgdGhlcmUgaXMgbm8g
cG9ydGFibGUgd2F5IHRvIGFkZCA2NC1iaXQgaW50ZWdlcnMgdG8NCj4gc2lnaW5mb190IG9uIDMy
LWJpdCBhcmNoaXRlY3R1cmVzLCBiZWNhdXNlIHNpZ2luZm9fdCBkb2VzIG5vdCBjb250YWluDQo+
IGFueSA2NC1iaXQgaW50ZWdlcnMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuDQoNClVoPw0KDQpU
aGUgYWN0dWFsIHByb2JsZW0gaXMgdGhhdCBhZGRpbmcgYSA2NC1iaXQgYWxpZ25lZCBpdGVtIHRv
IHRoZSB1bmlvbg0KZm9yY2VzIHRoZSB1bmlvbiB0byBiZSA4IGJ5dGUgYWxpZ25lZCBhbmQgYWRk
cyBhIDQgYnl0ZSBwYWQgYmVmb3JlIGl0DQooYW5kIHBvc3NpYmx5IGFub3RoZXIgb25lIGF0IHRo
ZSBlbmQgb2YgdGhlIHN0cnVjdHVyZSkuDQoNCj4gSW4gdGhlIGNhc2Ugb2YgdGhlIHNpX3BlcmYg
ZmllbGQsIHdvcmQgc2l6ZSBpcyBzdWZmaWNpZW50IHNpbmNlIHRoZXJlIGlzDQo+IG5vIGV4YWN0
IHJlcXVpcmVtZW50IG9uIHNpemUsIGdpdmVuIHRoZSBkYXRhIGl0IGNvbnRhaW5zIGlzIHVzZXIt
ZGVmaW5lZA0KPiB2aWEgcGVyZl9ldmVudF9hdHRyOjpzaWdfZGF0YS4gT24gMzItYml0IGFyY2hp
dGVjdHVyZXMsIGFueSBleGNlc3MgYml0cw0KPiBvZiBwZXJmX2V2ZW50X2F0dHI6OnNpZ19kYXRh
IHdpbGwgdGhlcmVmb3JlIGJlIHRydW5jYXRlZCB3aGVuIGNvcHlpbmcNCj4gaW50byBzaV9wZXJm
Lg0KDQpJcyB0aGF0IHJpZ2h0IG9uIEJFIGFyY2hpdGVjdHVyZXM/DQoNCj4gU2luY2UgdGhpcyBm
aWVsZCBpcyBpbnRlbmRlZCB0byBkaXNhbWJpZ3VhdGUgZXZlbnRzIChlLmcuIGVuY29kaW5nDQo+
IHJlbGV2YW50IGluZm9ybWF0aW9uIGlmIHRoZXJlIGFyZSBtb3JlIGV2ZW50cyBvZiB0aGUgc2Ft
ZSB0eXBlKSwgMzIgYml0cw0KPiBzaG91bGQgcHJvdmlkZSBlbm91Z2ggZW50cm9weSB0byBkbyBz
byBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4NCg0KV2hhdCBpcyB0aGUgc2l6ZSBvZiB0aGUgZmll
bGQgdXNlZCB0byBzdXBwbHkgdGhlIGRhdGE/DQpUaGUgc2l6ZSBvZiB0aGUgcmV0dXJuZWQgaXRl
bSByZWFsbHkgb3VnaHQgdG8gbWF0Y2guDQoNCk11Y2ggYXMgSSBoYXRlIF9fcGFja2VkLCB5b3Ug
Y291bGQgYWRkIF9fcGFja2VkIHRvIHRoZQ0KZGVmaW5pdGlvbiBvZiB0aGUgc3RydWN0dXJlIG1l
bWJlciBfcGVyZi4NClRoZSBjb21waWxlciB3aWxsIHJlbW92ZSB0aGUgcGFkZGluZyBiZWZvcmUg
aXQgYW5kIHdpbGwNCmFzc3VtZSBpdCBoYXMgdGhlIGFsaWdubWVudCBvZiB0aGUgcHJldmlvdXMg
aXRlbS4NCg0KU28gaXQgd2lsbCBuZXZlciB1c2UgYnl0ZSBhY2Nlc3Nlcy4NCg0KCURhdmlkDQoN
Cj4gDQo+IEZvciA2NC1iaXQgYXJjaGl0ZWN0dXJlcywgbm8gY2hhbmdlIGlzIGludGVuZGVkLg0K
PiANCj4gRml4ZXM6IGZiNmNjMTI3ZTBiNiAoInNpZ25hbDogSW50cm9kdWNlIFRSQVBfUEVSRiBz
aV9jb2RlIGFuZCBzaV9wZXJmIHRvIHNpZ2luZm8iKQ0KPiBSZXBvcnRlZC1ieTogTWFyZWsgU3p5
cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPg0KPiBUZXN0ZWQtYnk6IE1hcmVrIFN6
eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IEpvbiBI
dW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjbyBFbHZl
ciA8ZWx2ZXJAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IA0KPiBOb3RlOiBJIGFkZGVkIHN0YXRpY19h
c3NlcnQoKXMgdG8gdmVyaWZ5IHRoZSBzaWdpbmZvX3QgbGF5b3V0IHRvDQo+IGFyY2gvYXJtIGFu
ZCBhcmNoL2FybTY0LCB3aGljaCBjYXVnaHQgdGhlIHByb2JsZW0uIEknbGwgc2VuZCB0aGVtDQo+
IHNlcGFyYXRlbHkgdG8gYXJtJmFybTY0IG1haW50YWluZXJzIHJlc3BlY3RpdmVseS4NCj4gLS0t
DQo+ICBpbmNsdWRlL2xpbnV4L2NvbXBhdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8IDIgKy0NCj4gIGluY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy9zaWdpbmZvLmggICAgICAgICAg
ICAgICAgICAgIHwgMiArLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGVyZl9ldmVudHMv
c2lndHJhcF90aHJlYWRzLmMgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Nv
bXBhdC5oIGIvaW5jbHVkZS9saW51eC9jb21wYXQuaA0KPiBpbmRleCBjODgyMWQ5NjY4MTIuLmYw
ZDJkZDM1ZDQwOCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9jb21wYXQuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L2NvbXBhdC5oDQo+IEBAIC0yMzcsNyArMjM3LDcgQEAgdHlwZWRlZiBz
dHJ1Y3QgY29tcGF0X3NpZ2luZm8gew0KPiAgCQkJCQl1MzIgX3BrZXk7DQo+ICAJCQkJfSBfYWRk
cl9wa2V5Ow0KPiAgCQkJCS8qIHVzZWQgd2hlbiBzaV9jb2RlPVRSQVBfUEVSRiAqLw0KPiAtCQkJ
CWNvbXBhdF91NjQgX3BlcmY7DQo+ICsJCQkJY29tcGF0X3Vsb25nX3QgX3BlcmY7DQo+ICAJCQl9
Ow0KPiAgCQl9IF9zaWdmYXVsdDsNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvYXNt
LWdlbmVyaWMvc2lnaW5mby5oIGIvaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3NpZ2luZm8uaA0K
PiBpbmRleCBkMGJiOTEyNWM4NTMuLjAzZDZmNmQyYzFmZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS91YXBpL2FzbS1nZW5lcmljL3NpZ2luZm8uaA0KPiArKysgYi9pbmNsdWRlL3VhcGkvYXNtLWdl
bmVyaWMvc2lnaW5mby5oDQo+IEBAIC05Miw3ICs5Miw3IEBAIHVuaW9uIF9fc2lmaWVsZHMgew0K
PiAgCQkJCV9fdTMyIF9wa2V5Ow0KPiAgCQkJfSBfYWRkcl9wa2V5Ow0KPiAgCQkJLyogdXNlZCB3
aGVuIHNpX2NvZGU9VFJBUF9QRVJGICovDQo+IC0JCQlfX3U2NCBfcGVyZjsNCj4gKwkJCXVuc2ln
bmVkIGxvbmcgX3BlcmY7DQo+ICAJCX07DQo+ICAJfSBfc2lnZmF1bHQ7DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGVyZl9ldmVudHMvc2lndHJhcF90aHJlYWRz
LmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9wZXJmX2V2ZW50cy9zaWd0cmFwX3RocmVh
ZHMuYw0KPiBpbmRleCA5YzBmZDQ0MmRhNjAuLjc4ZGRmNWUxMTYyNSAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGVyZl9ldmVudHMvc2lndHJhcF90aHJlYWRzLmMNCj4g
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGVyZl9ldmVudHMvc2lndHJhcF90aHJlYWRz
LmMNCj4gQEAgLTQ0LDcgKzQ0LDcgQEAgc3RhdGljIHN0cnVjdCB7DQo+ICB9IGN0eDsNCj4gDQo+
ICAvKiBVbmlxdWUgdmFsdWUgdG8gY2hlY2sgc2lfcGVyZiBpcyBjb3JyZWN0bHkgc2V0IGZyb20g
cGVyZl9ldmVudF9hdHRyOjpzaWdfZGF0YS4gKi8NCj4gLSNkZWZpbmUgVEVTVF9TSUdfREFUQShh
ZGRyKSAofih1aW50NjRfdCkoYWRkcikpDQo+ICsjZGVmaW5lIFRFU1RfU0lHX0RBVEEoYWRkcikg
KH4odW5zaWduZWQgbG9uZykoYWRkcikpDQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwZXJmX2V2ZW50
X2F0dHIgbWFrZV9ldmVudF9hdHRyKGJvb2wgZW5hYmxlZCwgdm9sYXRpbGUgdm9pZCAqYWRkcikN
Cj4gIHsNCj4gLS0NCj4gMi4zMS4xLjQ5OC5nNmMxZWJhOGVlM2QtZ29vZw0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

