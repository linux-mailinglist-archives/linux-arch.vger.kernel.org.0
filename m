Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446279E201
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbjIMI0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbjIMI0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:26:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CED910C0
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:25:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-192-lGiFXdsMNTWbQGXrkH0Nsw-1; Wed, 13 Sep 2023 09:25:43 +0100
X-MC-Unique: lGiFXdsMNTWbQGXrkH0Nsw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Sep
 2023 09:25:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 13 Sep 2023 09:25:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Topic: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Index: AQHZ23Vdq8Esj5k0zUGYupOb09r6RrAF7nHAgAAb1ICAABQQEIANxBwAgAGZkGCAAg/ggIAAEt9wgAAOawCAAM6MQA==
Date:   Wed, 13 Sep 2023 08:25:40 +0000
Message-ID: <e0228468e054426c9737530fed594ad0@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
 <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com>
 <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
 <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com>
 <CAHk-=wiXw+NSW6usWH31Y6n4CnF5LiOs_vJREb8_U290W9w3KQ@mail.gmail.com>
 <fa01f553d57e436c8a7f5b1c2aae23a9@AcuMS.aculab.com>
 <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
In-Reply-To: <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTIgU2VwdGVtYmVyIDIwMjMgMjE6NDgNCj4g
DQo+IE9uIFR1ZSwgMTIgU2VwdCAyMDIzIGF0IDEyOjQxLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdoYXQgSSBmb3VuZCBzZWVtZWQgdG8g
aW1wbHkgdGhhdCAncmVwIG1vdnNxJyB1c2VkIHRoZSBzYW1lIGludGVybmFsDQo+ID4gbG9naWMg
YXMgJ3JlcCBtb3ZzYicgKHByZXR0eSBlYXN5IHRvIGRvIGluIGhhcmR3YXJlKQ0KPiANCj4gQ2hy
aXN0Lg0KPiANCj4gSSB0b2xkIHlvdS4gSXQncyBwcmV0dHkgZWFzeSBpbiBoYXJkd2FyZSAgQVMg
TE9ORyBBUyBJVCdTIEFMSUdORUQuDQo+IA0KPiBBbmQgaWYgaXQncyB1bmFsaWduZWQsICJyZXAg
bW92c3EiIGlzIEZVTkRBTUVOVEFMTFkgSEFSREVSLg0KDQpGb3IgY2FjaGVkIG1lbW9yeSBpdCBv
bmx5IGhhcyB0byBhcHBlYXIgdG8gaGF2ZSB1c2VkIDggYnl0ZQ0KYWNjZXNzZXMuDQpTbyBpbiB0
aGUgc2FtZSB3YXkgdGhhdCAncmVwIG1vdnNiJyBjb3VsZCBiZSBvcHRpbWlzZWQgdG8gZG8NCmNh
Y2hlIGxpbmUgc2l6ZWQgcmVhZHMgYW5kIHdyaXRlcyBldmVuIGlmIHRoZSBhZGRyZXNzIGFyZQ0K
Y29tcGxldGVseSBtaXNhbGlnbmVkICdyZXAgbW92c3EnIGNvdWxkIHVzZSBleGFjdGx5IHRoZSBz
YW1lDQpoYXJkd2FyZSBsb2dpYyB3aXRoIGEgYnl0ZSBjb3VudCB0aGF0IGlzIDggdGltZXMgbGFy
Z2VyLg0KDQpUaGUgb25seSBzdWJ0bGV0eSBpcyB0aGF0IHRoZSByZWFkIGxlbmd0aCB3b3VsZCBu
ZWVkIG1hc2tpbmcNCnRvIGEgbXVsdGlwbGUgb2YgOCBpZiB0aGVyZSBpcyBhIHBhZ2UgZmF1bHQg
b24gYSBtaXNhbGlnbmVkDQpyZWFkIHNpZGUgKHNvIHRoYXQgYSBtdWx0aXBsZSBvZiA4IGJ5dGVz
IHdvdWxkIGJlIHdyaXR0ZW4pLg0KVGhhdCB3b3VsZG4ndCByZWFsbHkgYmUgaGFyZC4NCg0KSSBk
ZWZpbml0ZWx5IHNhdyBleGFjdGx5IHRoZSBzYW1lIG51bWJlciBvZiBieXRlcy9jbG9jaw0KZm9y
ICdyZXAgbW92c2InIGFuZCAncmVwIG1vdnNxJyB3aGVuIHRoZSBkZXN0aW5hdGlvbiB3YXMNCm1p
c2FsaWduZWQuDQpUaGUgYWxpZ25tZW50IG1hZGUgbm8gZGlmZmVyZW5jZSBleGNlcHQgdGhhdCBh
IG11bHRpcGxlDQpvZiAzMiByYW4gKGFib3V0KSB0d2ljZSBhcyBmYXN0Lg0KSSBldmVuIGRvdWJs
ZS1jaGVja2VkIHRoZSBkaXNhc3NlbWJseSB0byBtYWtlIHN1cmUgSSB3YXMNCnJ1bm5pbmcgdGhl
IHJpZ2h0IGNvZGUuDQoNClNvIGl0IGxvb2tzIGxpa2UgdGhlIEludGVsIGhhcmR3YXJlIGVuZ2lu
ZWVycyBoYXZlIHNvbHZlZA0KdGhlICdGVU5EQU1FTlRBTExZIEhBUkRFUicgcHJvYmxlbS4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

