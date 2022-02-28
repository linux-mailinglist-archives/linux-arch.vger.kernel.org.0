Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78A4C6CAB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 13:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiB1MhQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 07:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiB1MhO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 07:37:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C5DF75638
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 04:36:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-164--JsiAWFvP7mJeI5M5rTVpA-1; Mon, 28 Feb 2022 12:36:29 +0000
X-MC-Unique: -JsiAWFvP7mJeI5M5rTVpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 28 Feb 2022 12:36:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 28 Feb 2022 12:36:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>
CC:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "liush@allwinnertech.com" <liush@allwinnertech.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "wangjunqiang@iscas.ac.cn" <wangjunqiang@iscas.ac.cn>,
        "hch@lst.de" <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH V7 03/20] compat: consolidate the compat_flock{,64}
 definition
Thread-Topic: [PATCH V7 03/20] compat: consolidate the compat_flock{,64}
 definition
Thread-Index: AQHYK/ctkLOBFN5NzkqkonsQCyvC26yogbZggABZggCAAAIWoIAAA+wAgAADRgA=
Date:   Mon, 28 Feb 2022 12:36:26 +0000
Message-ID: <75af91aff07c43f4afd1f1a024e23bd4@AcuMS.aculab.com>
References: <20220227162831.674483-1-guoren@kernel.org>
 <20220227162831.674483-4-guoren@kernel.org>
 <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com>
 <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
 <e5ee4f6799704bd59b0c580157a05d2d@AcuMS.aculab.com>
 <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
In-Reply-To: <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAyOCBGZWJydWFyeSAyMDIyIDEyOjEzDQo+IA0KPiBPbiBN
b24sIEZlYiAyOCwgMjAyMiBhdCA4OjAyIFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogR3VvIFJlbg0KPiA+ID4gU2VudDogMjgg
RmVicnVhcnkgMjAyMiAxMTo1Mg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgRmViIDI4LCAyMDIyIGF0
IDI6NDAgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+
ID4gPiA+DQo+ID4gPiA+IEZyb206IGd1b3JlbkBrZXJuZWwub3JnDQo+ID4gPiA+ID4gU2VudDog
MjcgRmVicnVhcnkgMjAyMiAxNjoyOA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRnJvbTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBQcm92aWRlIGEg
c2luZ2xlIGNvbW1vbiBkZWZpbml0aW9uIGZvciB0aGUgY29tcGF0X2Zsb2NrIGFuZA0KPiA+ID4g
PiA+IGNvbXBhdF9mbG9jazY0IHN0cnVjdHVyZXMgdXNpbmcgdGhlIHNhbWUgdHJpY2tzIGFzIGZv
ciB0aGUgbmF0aXZlDQo+ID4gPiA+ID4gdmFyaWFudHMuICBBbm90aGVyIGV4dHJhIGRlZmluZSBp
cyBhZGRlZCBmb3IgdGhlIHBhY2tpbmcgcmVxdWlyZWQgb24NCj4gPiA+ID4gPiB4ODYuDQo+ID4g
PiA+IC4uLg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jb21w
YXQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NvbXBhdC5oDQo+ID4gPiA+IC4uLg0KPiA+ID4g
PiA+ICAvKg0KPiA+ID4gPiA+IC0gKiBJQTMyIHVzZXMgNCBieXRlIGFsaWdubWVudCBmb3IgNjQg
Yml0IHF1YW50aXRpZXMsDQo+ID4gPiA+ID4gLSAqIHNvIHdlIG5lZWQgdG8gcGFjayB0aGlzIHN0
cnVjdHVyZS4NCj4gPiA+ID4gPiArICogSUEzMiB1c2VzIDQgYnl0ZSBhbGlnbm1lbnQgZm9yIDY0
IGJpdCBxdWFudGl0aWVzLCBzbyB3ZSBuZWVkIHRvIHBhY2sgdGhlDQo+ID4gPiA+ID4gKyAqIGNv
bXBhdCBmbG9jazY0IHN0cnVjdHVyZS4NCj4gPiA+ID4gPiAgICovDQo+ID4gPiA+IC4uLg0KPiA+
ID4gPiA+ICsjZGVmaW5lIF9fQVJDSF9ORUVEX0NPTVBBVF9GTE9DSzY0X1BBQ0tFRA0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gIHN0cnVjdCBjb21wYXRfc3RhdGZzIHsNCj4gPiA+ID4gPiAgICAgICBp
bnQgICAgICAgICAgICAgZl90eXBlOw0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2NvbXBhdC5oIGIvaW5jbHVkZS9saW51eC9jb21wYXQuaA0KPiA+ID4gPiA+IGluZGV4IDFj
NzU4YjBlMDM1OS4uYTA0ODFmZTZjNWQ1IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvY29tcGF0LmgNCj4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBhdC5oDQo+
ID4gPiA+ID4gQEAgLTI1OCw2ICsyNTgsMzcgQEAgc3RydWN0IGNvbXBhdF9ybGltaXQgew0KPiA+
ID4gPiA+ICAgICAgIGNvbXBhdF91bG9uZ190ICBybGltX21heDsNCj4gPiA+ID4gPiAgfTsNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ICsjaWZkZWYgX19BUkNIX05FRURfQ09NUEFUX0ZMT0NLNjRfUEFD
S0VEDQo+ID4gPiA+ID4gKyNkZWZpbmUgX19BUkNIX0NPTVBBVF9GTE9DSzY0X1BBQ0sgICBfX2F0
dHJpYnV0ZV9fKChwYWNrZWQpKQ0KPiA+ID4gPiA+ICsjZWxzZQ0KPiA+ID4gPiA+ICsjZGVmaW5l
IF9fQVJDSF9DT01QQVRfRkxPQ0s2NF9QQUNLDQo+ID4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiAu
Li4NCj4gPiA+ID4gPiArc3RydWN0IGNvbXBhdF9mbG9jazY0IHsNCj4gPiA+ID4gPiArICAgICBz
aG9ydCAgICAgICAgICAgbF90eXBlOw0KPiA+ID4gPiA+ICsgICAgIHNob3J0ICAgICAgICAgICBs
X3doZW5jZTsNCj4gPiA+ID4gPiArICAgICBjb21wYXRfbG9mZl90ICAgbF9zdGFydDsNCj4gPiA+
ID4gPiArICAgICBjb21wYXRfbG9mZl90ICAgbF9sZW47DQo+ID4gPiA+ID4gKyAgICAgY29tcGF0
X3BpZF90ICAgIGxfcGlkOw0KPiA+ID4gPiA+ICsjaWZkZWYgX19BUkNIX0NPTVBBVF9GTE9DSzY0
X1BBRA0KPiA+ID4gPiA+ICsgICAgIF9fQVJDSF9DT01QQVRfRkxPQ0s2NF9QQUQNCj4gPiA+ID4g
PiArI2VuZGlmDQo+ID4gPiA+ID4gK30gX19BUkNIX0NPTVBBVF9GTE9DSzY0X1BBQ0s7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4gPiBQcm92aWRlZCBjb21wYXRfbG9mZl90IGFyZSBjb3Jy
ZWN0bHkgZGVmaW5lZCB3aXRoIF9fYWxpZ25lZF9fKDQpDQo+ID4gPiBTZWUgaW5jbHVkZS9hc20t
Z2VuZXJpYy9jb21wYXQuaA0KPiA+ID4NCj4gPiA+IHR5cGVkZWYgczY0IGNvbXBhdF9sb2ZmX3Q7
DQo+ID4gPg0KPiA+ID4gT25seToNCj4gPiA+ICNpZmRlZiBDT05GSUdfQ09NUEFUX0ZPUl9VNjRf
QUxJR05NRU5UDQo+ID4gPiB0eXBlZGVmIHM2NCBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKDQpKSkg
Y29tcGF0X3M2NDsNCj4gPiA+DQo+ID4gPiBTbyBob3cgZG8geW91IHRoaW5rIGNvbXBhdF9sb2Zm
X3QgY291bGQgYmUgZGVmaW5lZCB3aXRoIF9fYWxpZ25lZF9fKDQpPw0KPiA+DQo+ID4gY29tcGF0
X2xvZmZfdCBzaG91bGQgYmUgY29tcGF0X3M2NCBub3QgczY0Lg0KPiA+DQo+ID4gVGhlIHNhbWUg
c2hvdWxkIGJlIGRvbmUgZm9yIGFsbCA2NGJpdCAnY29tcGF0JyB0eXBlcy4NCj4gQ2hhbmdpbmcN
Cj4gdHlwZWRlZiBzNjQgY29tcGF0X2xvZmZfdDsNCj4gdG8NCj4gdHlwZWRlZiBjb21wYXRfczY0
IGNvbXBhdF9sb2ZmX3Q7DQo+IA0KPiBzaG91bGQgYmUgYW5vdGhlciBwYXRjaCBhbmQgaXQgYWZm
ZWN0cyBhbGwgYXJjaGl0ZWN0dXJlcywgSSBkb24ndA0KPiB0aGluayB3ZSBzaG91bGQgaW52b2x2
ZSBpdCBpbiB0aGlzIHNlcmllcy4NCg0KRXhjZXB0IHRoYXQgSSB0aGluayBvbmx5IHg4NiBzZXRz
IENPTkZJR19DT01QQVRfRk9SX1U2NF9BTElHTk1FTlQuDQoNCj4gbG9vayBhdCBrZXJuZWwvcG93
ZXIvdXNlci5jOg0KPiBzdHJ1Y3QgY29tcGF0X3Jlc3VtZV9zd2FwX2FyZWEgew0KPiAgICAgICAg
IGNvbXBhdF9sb2ZmX3Qgb2Zmc2V0Ow0KPiAgICAgICAgIHUzMiBkZXY7DQo+IH0gX19wYWNrZWQ7
DQoNClRoYXQgaXMgYSBidWchDQpUaGUgc2l6ZSBzaG91bGQgYmUgMTYgYnl0ZXMgb24gbW9zdCAz
MmJpdCBhcmNoaXRlY3R1cmVzLg0KU28gdGhlIGNvbXBhdCBjb2RlIHdvbid0IGZhdWx0IGlmIHRo
ZSBsYXN0IDQgYnl0ZXMgYXJlbid0IG1hcHBlZA0Kd2hlcmVhcyB0aGUgbmF0aXZlIDMyYml0IHZl
cnNpb24gd2lsbCBmYXVsdC4NCg0KSG9wZWZ1bGx5IHRoZSBjb21waWxlciByZWFsaXNlcyB0aGUg
b24tc3RhY2sgaXRlbSBpcyBhY3R1YWxseQ0KYWxpZ25lZCBhbmQgZG9lc24ndCB1c2UgYnl0ZSBs
b2FkcyBhbmQgc2hpZnRzIG9uIChlZykgc3BhcmM2NC4NCg0KPiBJIHRobmsga2VlcCAidHlwZWRl
ZiBzNjQgY29tcGF0X2xvZmZfdDsiIGlzIGEgc2Vuc2libGUgY2hvaWNlIGZvcg0KPiBDT01QQVQg
c3VwcG9ydCBwYXRjaHNldCBzZXJpZXMuDQoNCkJ1dCBpdCBpcyB3cm9uZyA6LSkNCg0KY29tcGF0
X1tzdV02NCBleGlzdCBzbyB0aGF0IGNvbXBhdCBzeXNjYWxscyB0aGF0IGNvbnRhaW4gNjRiaXQN
CnZhbHVlcyBnZXQgdGhlIGNvcnJlY3QgYWxpZ25tZW50Lg0KV2hpY2ggaXMgZXhhY3RseSB3aGF0
IHlvdSBoYXZlIGhlcmUuDQoNCkFGQUlDVCBtb3N0IG9mIHRoZSB1c2VzIG9mIF9fcGFja2VkIGlu
IHRoZSBrZXJuZWwgYXJlIHdyb25nLg0KSXQgc2hvdWxkIG9ubHkgYmUgdXNlZCAob24gYSBzdHJ1
Y3R1cmUpIGlmIHRoZSBzdHJ1Y3R1cmUgbWlnaHQNCmJlIG9uIGEgbWlzYWxpZ25lZCBhZGRyZXNz
Lg0KVGhpcyBjYW4gaGFwcGVuIGluIGRhdGEgZm9yIHNvbWUgbmV0d29yayBwcm90b2NvbHMuDQpJ
dCBzaG91bGQgbm90IGJlIHVzZWQgYmVjYXVzZSB0aGUgc3RydWN0dXJlIHNob3VsZCBoYXZlIG5v
IGhvbGVzLg0KKEVzcGVjaWFsbHkgaW4gb25lcyB0aGF0IGRvbid0IGhhdmUgYW55IGhvbGVzLikN
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

