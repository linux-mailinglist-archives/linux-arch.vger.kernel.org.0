Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D724C6B7E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 13:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiB1MD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbiB1MDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 07:03:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8B2363F4
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 04:02:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-166-d7SEXvIjOR2492KDyKN4ug-1; Mon, 28 Feb 2022 12:02:41 +0000
X-MC-Unique: d7SEXvIjOR2492KDyKN4ug-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 28 Feb 2022 12:02:38 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 28 Feb 2022 12:02:38 +0000
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
Thread-Index: AQHYK/ctkLOBFN5NzkqkonsQCyvC26yogbZggABZggCAAAIWoA==
Date:   Mon, 28 Feb 2022 12:02:38 +0000
Message-ID: <e5ee4f6799704bd59b0c580157a05d2d@AcuMS.aculab.com>
References: <20220227162831.674483-1-guoren@kernel.org>
 <20220227162831.674483-4-guoren@kernel.org>
 <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com>
 <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAyOCBGZWJydWFyeSAyMDIyIDExOjUyDQo+IA0KPiBPbiBN
b24sIEZlYiAyOCwgMjAyMiBhdCAyOjQwIFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogZ3VvcmVuQGtlcm5lbC5vcmcNCj4gPiA+
IFNlbnQ6IDI3IEZlYnJ1YXJ5IDIwMjIgMTY6MjgNCj4gPiA+DQo+ID4gPiBGcm9tOiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiA+DQo+ID4gPiBQcm92aWRlIGEgc2luZ2xlIGNv
bW1vbiBkZWZpbml0aW9uIGZvciB0aGUgY29tcGF0X2Zsb2NrIGFuZA0KPiA+ID4gY29tcGF0X2Zs
b2NrNjQgc3RydWN0dXJlcyB1c2luZyB0aGUgc2FtZSB0cmlja3MgYXMgZm9yIHRoZSBuYXRpdmUN
Cj4gPiA+IHZhcmlhbnRzLiAgQW5vdGhlciBleHRyYSBkZWZpbmUgaXMgYWRkZWQgZm9yIHRoZSBw
YWNraW5nIHJlcXVpcmVkIG9uDQo+ID4gPiB4ODYuDQo+ID4gLi4uDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY29tcGF0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9j
b21wYXQuaA0KPiA+IC4uLg0KPiA+ID4gIC8qDQo+ID4gPiAtICogSUEzMiB1c2VzIDQgYnl0ZSBh
bGlnbm1lbnQgZm9yIDY0IGJpdCBxdWFudGl0aWVzLA0KPiA+ID4gLSAqIHNvIHdlIG5lZWQgdG8g
cGFjayB0aGlzIHN0cnVjdHVyZS4NCj4gPiA+ICsgKiBJQTMyIHVzZXMgNCBieXRlIGFsaWdubWVu
dCBmb3IgNjQgYml0IHF1YW50aXRpZXMsIHNvIHdlIG5lZWQgdG8gcGFjayB0aGUNCj4gPiA+ICsg
KiBjb21wYXQgZmxvY2s2NCBzdHJ1Y3R1cmUuDQo+ID4gPiAgICovDQo+ID4gLi4uDQo+ID4gPiAr
I2RlZmluZSBfX0FSQ0hfTkVFRF9DT01QQVRfRkxPQ0s2NF9QQUNLRUQNCj4gPiA+DQo+ID4gPiAg
c3RydWN0IGNvbXBhdF9zdGF0ZnMgew0KPiA+ID4gICAgICAgaW50ICAgICAgICAgICAgIGZfdHlw
ZTsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBhdC5oIGIvaW5jbHVkZS9s
aW51eC9jb21wYXQuaA0KPiA+ID4gaW5kZXggMWM3NThiMGUwMzU5Li5hMDQ4MWZlNmM1ZDUgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBhdC5oDQo+ID4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L2NvbXBhdC5oDQo+ID4gPiBAQCAtMjU4LDYgKzI1OCwzNyBAQCBzdHJ1Y3QgY29t
cGF0X3JsaW1pdCB7DQo+ID4gPiAgICAgICBjb21wYXRfdWxvbmdfdCAgcmxpbV9tYXg7DQo+ID4g
PiAgfTsNCj4gPiA+DQo+ID4gPiArI2lmZGVmIF9fQVJDSF9ORUVEX0NPTVBBVF9GTE9DSzY0X1BB
Q0tFRA0KPiA+ID4gKyNkZWZpbmUgX19BUkNIX0NPTVBBVF9GTE9DSzY0X1BBQ0sgICBfX2F0dHJp
YnV0ZV9fKChwYWNrZWQpKQ0KPiA+ID4gKyNlbHNlDQo+ID4gPiArI2RlZmluZSBfX0FSQ0hfQ09N
UEFUX0ZMT0NLNjRfUEFDSw0KPiA+ID4gKyNlbmRpZg0KPiA+IC4uLg0KPiA+ID4gK3N0cnVjdCBj
b21wYXRfZmxvY2s2NCB7DQo+ID4gPiArICAgICBzaG9ydCAgICAgICAgICAgbF90eXBlOw0KPiA+
ID4gKyAgICAgc2hvcnQgICAgICAgICAgIGxfd2hlbmNlOw0KPiA+ID4gKyAgICAgY29tcGF0X2xv
ZmZfdCAgIGxfc3RhcnQ7DQo+ID4gPiArICAgICBjb21wYXRfbG9mZl90ICAgbF9sZW47DQo+ID4g
PiArICAgICBjb21wYXRfcGlkX3QgICAgbF9waWQ7DQo+ID4gPiArI2lmZGVmIF9fQVJDSF9DT01Q
QVRfRkxPQ0s2NF9QQUQNCj4gPiA+ICsgICAgIF9fQVJDSF9DT01QQVRfRkxPQ0s2NF9QQUQNCj4g
PiA+ICsjZW5kaWYNCj4gPiA+ICt9IF9fQVJDSF9DT01QQVRfRkxPQ0s2NF9QQUNLOw0KPiA+ID4g
Kw0KPiA+DQo+ID4gUHJvdmlkZWQgY29tcGF0X2xvZmZfdCBhcmUgY29ycmVjdGx5IGRlZmluZWQg
d2l0aCBfX2FsaWduZWRfXyg0KQ0KPiBTZWUgaW5jbHVkZS9hc20tZ2VuZXJpYy9jb21wYXQuaA0K
PiANCj4gdHlwZWRlZiBzNjQgY29tcGF0X2xvZmZfdDsNCj4gDQo+IE9ubHk6DQo+ICNpZmRlZiBD
T05GSUdfQ09NUEFUX0ZPUl9VNjRfQUxJR05NRU5UDQo+IHR5cGVkZWYgczY0IF9fYXR0cmlidXRl
X18oKGFsaWduZWQoNCkpKSBjb21wYXRfczY0Ow0KPiANCj4gU28gaG93IGRvIHlvdSB0aGluayBj
b21wYXRfbG9mZl90IGNvdWxkIGJlIGRlZmluZWQgd2l0aCBfX2FsaWduZWRfXyg0KT8NCg0KY29t
cGF0X2xvZmZfdCBzaG91bGQgYmUgY29tcGF0X3M2NCBub3QgczY0Lg0KDQpUaGUgc2FtZSBzaG91
bGQgYmUgZG9uZSBmb3IgYWxsIDY0Yml0ICdjb21wYXQnIHR5cGVzLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

