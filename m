Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3C51A278
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiEDOsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiEDOsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 10:48:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0AC5419BB
        for <linux-arch@vger.kernel.org>; Wed,  4 May 2022 07:44:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-4y2cm3VXMb2M2NvceAkOCg-1; Wed, 04 May 2022 15:44:21 +0100
X-MC-Unique: 4y2cm3VXMb2M2NvceAkOCg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 4 May 2022 15:44:21 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 4 May 2022 15:44:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: RE: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
Thread-Topic: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
Thread-Index: AQHYX6JypL1TIYckSkiCK/R/RS2KH60OyGAg
Date:   Wed, 4 May 2022 14:44:21 +0000
Message-ID: <145b4021c7b14ada95ba0acf6f294b96@AcuMS.aculab.com>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com>
 <20220503233802.GA420374@bhelgaas>
 <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
In-Reply-To: <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNCBNYXkgMjAyMiAxMTozMw0KPiANCj4gT24g
V2VkLCBNYXkgNCwgMjAyMiBhdCAxOjM4IEFNIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+ID4gT24gRnJpLCBBcHIgMjksIDIwMjIgYXQgMDM6NTA6NDFQTSArMDIw
MCwgTmlrbGFzIFNjaG5lbGxlIHdyb3RlOg0KPiA+ID4gSW4gYSBmdXR1cmUgcGF0Y2ggSEFTX0lP
UE9SVD1uIHdpbGwgcmVzdWx0IGluIGluYigpL291dGIoKSBhbmQgZnJpZW5kcw0KPiA+ID4gbm90
IGJlaW5nIGRlY2xhcmVkLiBQQ01DSUEgZGV2aWNlcyBhcmUgZWl0aGVyIExFR0FDWV9QQ0kgZGV2
aWNlcw0KPiA+ID4gd2hpY2ggaW1wbGllcyBIQVNfSU9QT1JUIG9yIHJlcXVpcmUgSEFTX0lPUE9S
VC4NCj4gPiA+DQo+ID4gPiBBY2tlZC1ieTogRG9taW5payBCcm9kb3dza2kgPGxpbnV4QGRvbWlu
aWticm9kb3dza2kubmV0Pg0KPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGtlcm5lbC5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgU2NobmVsbGUgPHNj
aG5lbGxlQGxpbnV4LmlibS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3BjbWNpYS9L
Y29uZmlnIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjbWNpYS9LY29u
ZmlnIGIvZHJpdmVycy9wY21jaWEvS2NvbmZpZw0KPiA+ID4gaW5kZXggMmNlMjYxY2ZmZjhlLi4z
MmI1Y2QzMjRjNTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjbWNpYS9LY29uZmlnDQo+
ID4gPiArKysgYi9kcml2ZXJzL3BjbWNpYS9LY29uZmlnDQo+ID4gPiBAQCAtNSw3ICs1LDcgQEAN
Cj4gPiA+DQo+ID4gPiAgbWVudWNvbmZpZyBQQ0NBUkQNCj4gPiA+ICAgICAgIHRyaXN0YXRlICJQ
Q0NhcmQgKFBDTUNJQS9DYXJkQnVzKSBzdXBwb3J0Ig0KPiA+ID4gLSAgICAgZGVwZW5kcyBvbiAh
VU1MDQo+ID4gPiArICAgICBkZXBlbmRzIG9uIEhBU19JT1BPUlQNCj4gPg0KPiA+IEkgZG9uJ3Qg
a25vdyBtdWNoIGFib3V0IFBDIENhcmQuICBJcyB0aGVyZSBhIHJlcXVpcmVtZW50IHRoYXQgdGhl
c2UNCj4gPiBkZXZpY2VzIG11c3QgdXNlIEkvTyBwb3J0IHNwYWNlPyAgSWYgc28sIGNhbiB5b3Ug
aW5jbHVkZSBhIHNwZWMNCj4gPiByZWZlcmVuY2UgaW4gdGhlIGNvbW1pdCBsb2c/DQo+IA0KPiBJ
IHRoaW5rIGZvciBQQ01DSUEgZGV2aWNlcywgdGhlIGRlcGVuZGVuY3kgbWFrZXMgc2Vuc2UgYmVj
YXVzZQ0KPiBhbGwgZGV2aWNlIGRyaXZlcnMgZm9yIFBDTUNJQSBkZXZpY2VzIG5lZWQgSS9PIHBv
cnRzLg0KDQpJU1RSIHNvbWUgUENNQ0lBIGxpbmVhciBub24tdm9sYXRpbGUgbWVtb3J5IGNhcmRz
IHRoYXQgb25seQ0Kc3VwcG9ydGVkIG1lbW9yeSBhY2Nlc3Nlcy4NCkknbSBwcmV0dHkgc3VyZSBz
b21lIGRpZG4ndCBldmVuIGRlY29kZSBjb25maWcgc3BhY2UgcHJvcGVybHkuDQooSSBiZXQgbm9u
ZSBvZiB0aGVtIHN0aWxsIHdvcmsgYWZ0ZXIgMjUgeWVhcnMgdGhvdWdoLikNCg0KSSd2ZSB1c2Vk
IEkvTyBhZGRyZXNzZXMgb24gcGNtY2lhIGNhcmRzIGZyb20gc3BhcmMgYW5kIEFSTSBjcHUuDQoN
Cj4gRm9yIGNhcmRidXMsIHdlIGNhbiBnbyBlaXRoZXIgd2F5LCBJIGRvbid0IHNlZSBhbnkgcmVm
ZXJlbmNlIHRvDQo+IEkvTyBwb3J0cyBpbiB5ZW50YV9zb2NrZXQuYyBvciB0aGUgcGNjYXJkIGNv
cmUsIHNvIGl0IHdvdWxkIGJ1aWxkDQo+IGZpbmUgd2l0aCBvciB3aXRob3V0IEkvTyBwb3J0cy4N
Cg0KY2FyZGJ1cyBpcyBiYXNpY2FsbHkgUENJLg0KSSB0aGluayB5b3UgY2FuIGZpbmQgY2FyZGJ1
cyBjYXJkcyB0aGF0IGhhdmUgYSBwY2kgYnJpZGdlIGFuZCBhIGNhYmxlDQpsaW5rIHRvIGFuIGV4
cGFuc2lvbiBjaGFzc2lzIGludG8gd2hpY2ggeW91IGNhbiBpbnNlcnQgc3RhbmRhcmQgUENJIGNh
cmRzLg0KSWYgeW91IGFyZSByZWFsbHkgbHVja3kgdGhlIGluaXRpYWwgZW51bWVyYXRpb24gYWxs
b2NhdGVzIHRoZQ0KJ2hpZ2ggZmllbGQnIGJ1cyBudW1iZXJzLCBpbyBhZGRyZXNzZXMgYW5kIHBs
ZW50eSBvZiBtZW1vcnkNCnNwYWNlIHRvIHRoZSBicmlkZ2UgLSBvdGhlcndpc2UgeW91IGxvc2Uu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

