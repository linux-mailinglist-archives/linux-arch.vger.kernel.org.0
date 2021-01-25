Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA22E3049A6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbhAZFZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54977 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbhAYMtn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:43 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-82-6XwU-z6xP--r2gJKmt1_cg-1; Mon, 25 Jan 2021 12:23:59 +0000
X-MC-Unique: 6XwU-z6xP--r2gJKmt1_cg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 25 Jan 2021 12:24:01 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 25 Jan 2021 12:24:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Ding Tianhong <dingtianhong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Zefan Li" <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Topic: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Index: AQHW8vrJGsfXJcLsV0a1KHeguqyGFao4Q6bA
Date:   Mon, 25 Jan 2021 12:24:01 +0000
Message-ID: <7749b310046c4b9baa07037af1d97d87@AcuMS.aculab.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-12-npiggin@gmail.com>
 <933352bd-dcf3-c483-4d7a-07afe1116cf1@csgroup.eu>
In-Reply-To: <933352bd-dcf3-c483-4d7a-07afe1116cf1@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAyNSBKYW51YXJ5IDIwMjEgMDk6MTUNCj4g
DQo+IExlIDI0LzAxLzIwMjEgw6AgMDk6MjIsIE5pY2hvbGFzIFBpZ2dpbiBhIMOpY3JpdMKgOg0K
PiA+IFN1cHBvcnQgaHVnZSBwYWdlIHZtYWxsb2MgbWFwcGluZ3MuIENvbmZpZyBvcHRpb24gSEFW
RV9BUkNIX0hVR0VfVk1BTExPQw0KPiA+IGVuYWJsZXMgc3VwcG9ydCBvbiBhcmNoaXRlY3R1cmVz
IHRoYXQgZGVmaW5lIEhBVkVfQVJDSF9IVUdFX1ZNQVAgYW5kDQo+ID4gc3VwcG9ydHMgUE1EIHNp
emVkIHZtYXAgbWFwcGluZ3MuDQo+ID4NCj4gPiB2bWFsbG9jIHdpbGwgYXR0ZW1wdCB0byBhbGxv
Y2F0ZSBQTUQtc2l6ZWQgcGFnZXMgaWYgYWxsb2NhdGluZyBQTUQgc2l6ZQ0KPiA+IG9yIGxhcmdl
ciwgYW5kIGZhbGwgYmFjayB0byBzbWFsbCBwYWdlcyBpZiB0aGF0IHdhcyB1bnN1Y2Nlc3NmdWwu
DQo+ID4NCj4gPiBBcmNoaXRlY3R1cmVzIG11c3QgZW5zdXJlIHRoYXQgYW55IGFyY2ggc3BlY2lm
aWMgdm1hbGxvYyBhbGxvY2F0aW9ucw0KPiA+IHRoYXQgcmVxdWlyZSBQQUdFX1NJWkUgbWFwcGlu
Z3MgKGUuZy4sIG1vZHVsZSBhbGxvY2F0aW9ucyB2cyBzdHJpY3QNCj4gPiBtb2R1bGUgcnd4KSB1
c2UgdGhlIFZNX05PSFVHRSBmbGFnIHRvIGluaGliaXQgbGFyZ2VyIG1hcHBpbmdzLg0KPiA+DQo+
ID4gV2hlbiBodWdlcGFnZSB2bWFsbG9jIG1hcHBpbmdzIGFyZSBlbmFibGVkIGluIHRoZSBuZXh0
IHBhdGNoLCB0aGlzDQo+ID4gcmVkdWNlcyBUTEIgbWlzc2VzIGJ5IG5lYXJseSAzMHggb24gYSBg
Z2l0IGRpZmZgIHdvcmtsb2FkIG9uIGEgMi1ub2RlDQo+ID4gUE9XRVI5ICg1OSw4MDAgLT4gMiwx
MDApIGFuZCByZWR1Y2VzIENQVSBjeWNsZXMgYnkgMC41NCUuDQo+ID4NCj4gPiBUaGlzIGNhbiBy
ZXN1bHQgaW4gbW9yZSBpbnRlcm5hbCBmcmFnbWVudGF0aW9uIGFuZCBtZW1vcnkgb3ZlcmhlYWQg
Zm9yIGENCj4gPiBnaXZlbiBhbGxvY2F0aW9uLCBhbiBvcHRpb24gbm9odWdldm1hbGxvYyBpcyBh
ZGRlZCB0byBkaXNhYmxlIGF0IGJvb3QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xh
cyBQaWdnaW4gPG5waWdnaW5AZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9LY29uZmln
ICAgICAgICAgICAgfCAgMTAgKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L3ZtYWxsb2MuaCB8ICAx
OCArKysrDQo+ID4gICBtbS9wYWdlX2FsbG9jLmMgICAgICAgICB8ICAgNSArLQ0KPiA+ICAgbW0v
dm1hbGxvYy5jICAgICAgICAgICAgfCAxOTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKSwgNDgg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL21tL3ZtYWxsb2MuYyBiL21t
L3ZtYWxsb2MuYw0KPiA+IGluZGV4IDAzNzdlMWQwNTllNS4uZWVmNjFlMGY1MTcwIDEwMDY0NA0K
PiA+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiA+ICsrKyBiL21tL3ZtYWxsb2MuYw0KPiANCj4gPiBA
QCAtMjY5MSwxNSArMjc0NiwxOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh2bWFwX3Bmbik7DQo+ID4g
ICAjZW5kaWYgLyogQ09ORklHX1ZNQVBfUEZOICovDQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lkICpf
X3ZtYWxsb2NfYXJlYV9ub2RlKHN0cnVjdCB2bV9zdHJ1Y3QgKmFyZWEsIGdmcF90IGdmcF9tYXNr
LA0KPiA+IC0JCQkJIHBncHJvdF90IHByb3QsIGludCBub2RlKQ0KPiA+ICsJCQkJIHBncHJvdF90
IHByb3QsIHVuc2lnbmVkIGludCBwYWdlX3NoaWZ0LA0KPiA+ICsJCQkJIGludCBub2RlKQ0KPiA+
ICAgew0KPiA+ICAgCWNvbnN0IGdmcF90IG5lc3RlZF9nZnAgPSAoZ2ZwX21hc2sgJiBHRlBfUkVD
TEFJTV9NQVNLKSB8IF9fR0ZQX1pFUk87DQo+ID4gLQl1bnNpZ25lZCBpbnQgbnJfcGFnZXMgPSBn
ZXRfdm1fYXJlYV9zaXplKGFyZWEpID4+IFBBR0VfU0hJRlQ7DQo+ID4gLQl1bnNpZ25lZCBsb25n
IGFycmF5X3NpemU7DQo+ID4gLQl1bnNpZ25lZCBpbnQgaTsNCj4gPiArCXVuc2lnbmVkIGludCBw
YWdlX29yZGVyID0gcGFnZV9zaGlmdCAtIFBBR0VfU0hJRlQ7DQo+ID4gKwl1bnNpZ25lZCBsb25n
IGFkZHIgPSAodW5zaWduZWQgbG9uZylhcmVhLT5hZGRyOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBz
aXplID0gZ2V0X3ZtX2FyZWFfc2l6ZShhcmVhKTsNCj4gPiArCXVuc2lnbmVkIGludCBucl9zbWFs
bF9wYWdlcyA9IHNpemUgPj4gUEFHRV9TSElGVDsNCj4gPiAgIAlzdHJ1Y3QgcGFnZSAqKnBhZ2Vz
Ow0KPiA+ICsJdW5zaWduZWQgaW50IGk7DQo+ID4NCj4gPiAtCWFycmF5X3NpemUgPSAodW5zaWdu
ZWQgbG9uZylucl9wYWdlcyAqIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsNCj4gPiArCWFycmF5X3Np
emUgPSAodW5zaWduZWQgbG9uZylucl9zbWFsbF9wYWdlcyAqIHNpemVvZihzdHJ1Y3QgcGFnZSAq
KTsNCj4gDQo+IGFycmF5X3NpemUoKSBpcyBhIGZ1bmN0aW9uIGluIGluY2x1ZGUvbGludXgvb3Zl
cmZsb3cuaA0KPiANCj4gRm9yIHNvbWUgcmVhc29uLCBpdCBicmVha3MgdGhlIGJ1aWxkIHdpdGgg
eW91ciBzZXJpZXMuDQoNCkkgY2FuJ3Qgc2VlIHRoZSByZXBsYWNlbWVudCBkZWZpbml0aW9uIGZv
ciBhcnJheV9zaXplLg0KVGhlIG9sZCBsb2NhbCB2YXJpYWJsZSBpcyBkZWxldGVkLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

