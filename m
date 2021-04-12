Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740EB35C3BB
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbhDLKXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 06:23:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58377 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239022AbhDLKXB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-128-DnwYs6UTM2mO74AA5I6jBQ-1; Mon, 12 Apr 2021 11:22:40 +0100
X-MC-Unique: DnwYs6UTM2mO74AA5I6jBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 11:22:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 11:22:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Helge Deller <deller@gmx.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: consolidate the flock uapi definitions
Thread-Topic: consolidate the flock uapi definitions
Thread-Index: AQHXL4M0xqfui6+bp0WfMrJF+xIqXKqwqyrg
Date:   Mon, 12 Apr 2021 10:22:38 +0000
Message-ID: <16c471554aa5424fbe2f6a4fd60bd662@AcuMS.aculab.com>
References: <20210412085545.2595431-1-hch@lst.de>
 <CAK8P3a38qgkjkh4+fDKp4TufL+2_W-quZBFK9pJFf7wXP=84xQ@mail.gmail.com>
In-Reply-To: <CAK8P3a38qgkjkh4+fDKp4TufL+2_W-quZBFK9pJFf7wXP=84xQ@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMiBBcHJpbCAyMDIxIDExOjA0DQo+IA0KPiBP
biBNb24sIEFwciAxMiwgMjAyMSBhdCAxMDo1NSBBTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBjdXJyZW50bHkgd2UgZGVh
bCB3aXRoIHRoZSBzbGlnaHQgZGlmZmVyZW50cyBpbiB0aGUgdmFyaW91cyBhcmNoaXRlY3R1cmUN
Cj4gPiB2YXJpYW50cyBvZiB0aGUgZmxvY2sgYW5kIGZsb2NrNjQgc3R1Y3R1cmVzIGluIGEgdmVy
eSBjcnVmdCB3YXkuICBUaGlzDQo+ID4gc2VyaWVzIHN3aXRjaGVzIHRvIGp1c3QgdXNlIHNtYWxs
IGFyY2ggaG9va3MgYW5kIGRlZmluZSB0aGUgcmVzdCBpbg0KPiA+IGFzbS1nZW5lcmljIGFuZCBs
aW51eC9jb21wYXQuaCBpbnN0ZWFkLg0KPiANCj4gTmljZSBjbGVhbnVwLiBJIGNhbiBtZXJnZSBp
dCB0aHJvdWdoIHRoZSBhc20tZ2VuZXJpYyB0cmVlIGlmIHlvdSBsaWtlLA0KPiB0aG91Z2ggaXQn
cyBhIGxpdHRsZSBsYXRlIGp1c3QgYWhlYWQgb2YgdGhlIG1lcmdlIHdpbmRvdy4NCj4gDQo+IEkg
d291bGQgbm90IHdhbnQgdG8gY2hhbmdlIHRoZSBjb21wYXRfbG9mZl90IGRlZmluaXRpb24gdG8g
Y29tcGF0X3M2NA0KPiB0byBhdm9pZCB0aGUgcGFkZGluZyBhdCB0aGlzIHRpbWUsIHRob3VnaCB0
aGF0IG1pZ2h0IGJlIGEgdXNlZnVsIGNsZWFudXANCj4gZm9yIGEgZnV0dXJlIGN5Y2xlLg0KDQpJ
cyB4ODYgdGhlIG9ubHkgYXJjaGl0ZWN0dXJlIHRoYXQgaGFzIDMyYml0IGFuZCA2NGJpdCB2YXJp
YW50cyB3aGVyZQ0KdGhlIDMyYml0IHZhcmlhbnQgYWxpZ25zIDY0Yml0IGl0ZW1zIG9uIDMyYml0
IGJvdW5kYXJpZXM/DQoNCkkndmUganVzdCBjaGVja2VkIE1JUFMgYW5kIEFSTSwgYW5kIEknbSBm
YWlybHkgc3VyZSBzcGFyYyA2NGJpdA0KYWxpZ25zIHRoZW0uDQoNCkFyZSB0aGVyZSBhbnkgb3Ro
ZXJzPw0KDQpNaWdodCBhbHNvIGJlIGludGVyZXN0aW5nIHRvIGNoZWNrIHdoZXRoZXIgY29tcGF0
X2xvZmZfdCBnZXRzDQp1c2VkIGFueXdoZXJlIGVsc2UgLSB3aGVyZSB0aGUgeDY0LTY0IGNvbXBh
dCBjb2RlIHdpbGwgZ2V0IGl0DQp3cm9uZy4NCg0KSVNUTSB0aGF0IGZpeGluZyBjb21wYXRfbG9m
Zl90IHNob3VsZG4ndCBoYXZlIGFueSBmYWxsb3V0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

