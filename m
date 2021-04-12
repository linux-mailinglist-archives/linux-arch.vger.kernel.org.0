Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C293935C72F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhDLNMK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 09:12:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22849 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241758AbhDLNMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 09:12:07 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-107-jlA7rlBNM9W_p6yNzfFSUA-1; Mon, 12 Apr 2021 14:11:46 +0100
X-MC-Unique: jlA7rlBNM9W_p6yNzfFSUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 14:11:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 14:11:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>
CC:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Topic: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Index: AQHXL3nAXViKKuH90kqxIUkBtWSuL6qwmWXwgAATjVCAAACRAIAAKVLA
Date:   Mon, 12 Apr 2021 13:11:45 +0000
Message-ID: <0bef075082b244d2b7a5a140336a40d5@AcuMS.aculab.com>
References: <20210412085545.2595431-1-hch@lst.de>
 <20210412085545.2595431-6-hch@lst.de>
 <15be19af19174c7692dd795297884096@AcuMS.aculab.com>
 <5c3635a2b44a496b88d665e8686d9436@AcuMS.aculab.com>
 <CAK8P3a1JZ=JerasdkntzX_ApaCF7C29ZS1E31aPQATOts0ZiLw@mail.gmail.com>
In-Reply-To: <CAK8P3a1JZ=JerasdkntzX_ApaCF7C29ZS1E31aPQATOts0ZiLw@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMiBBcHJpbCAyMDIxIDEyOjI2DQo+IA0KPiBP
biBNb24sIEFwciAxMiwgMjAyMSBhdCAxMjo1NCBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBEYXZpZCBMYWlnaHQgPiBTZW50OiAxMiBB
cHJpbCAyMDIxIDEwOjM3DQo+ID4gLi4uDQo+ID4gPiBJJ20gZ3Vlc3NpbmcgdGhhdCBjb21wYXRf
cGlkX3QgaXMgMTYgYml0cz8NCj4gPiA+IFNvIHRoZSBuYXRpdmUgMzJiaXQgdmVyc2lvbiBoYXMg
YW4gdW5uYW1lZCAyIGJ5dGUgc3RydWN0dXJlIHBhZC4NCj4gPiA+IFRoZSAncGFja2VkJyByZW1v
dmVzIHRoaXMgcGFkIGZyb20gdGhlIGNvbXBhdCBzdHJ1Y3R1cmUuDQo+ID4gPg0KPiA+ID4gQUZB
SUNUIChhcGFydCBmcm9tIG1pcHMpIHRoZSBfX0FSQ0hfQ09NUEFUX0ZMT0NLX1BBRCBpcyBqdXN0
DQo+ID4gPiBhZGRpbmcgYW4gZXhwbGljaXQgcGFkIGZvciB0aGUgaW1wbGljaXQgcGFkIHRoZSBj
b21waWxlcg0KPiA+ID4gd291bGQgZ2VuZXJhdGUgYmVjYXVzZSBjb21wYXRfcGlkX3QgaXMgMTYg
Yml0cy4NCj4gPg0KPiA+IEkndmUganVzdCBsb29rZWQgYXQgdGhlIGhlYWRlci4NCj4gPiBjb21w
YXRfcGlkX3QgaXMgMzIgYml0cy4NCj4gPiBTbyBMaW51eCBtdXN0IGhhdmUgZ2FpbmVkIDMyYml0
IHBpZHMgYXQgc29tZSBlYXJsaWVyIHRpbWUuDQo+ID4gKEhpc3RvcmljYWxseSBVbml4IHBpZHMg
d2VyZSAxNiBiaXQgLSBldmVuIG9uIDMyYml0IHN5c3RlbXMuKQ0KPiA+DQo+ID4gV2hpY2ggbWFr
ZXMgdGhlIGV4cGxpY2l0IHBhZCBpbiAnc3BhcmMnIHJhdGhlciAnaW50ZXJlc3RpbmcnLg0KPiAN
Cj4gSSBzYXcgaXQgd2FzIHRoZXJlIHNpbmNlIHRoZSBzcGFyYyBrZXJuZWwgc3VwcG9ydCBnb3Qg
bWVyZ2VkIGluDQo+IGxpbnV4LTEuMywgcG9zc2libHkgY29waWVkIGZyb20gYW4gb2xkZXIgc3Vu
b3MgdmVyc2lvbi4NCg0KV2hpY2ggaGFkIGEgMTZiaXQgcGlkIHdoZW4gSSB1c2VkIGl0Lg0KU28g
dGhpcyBpcyBhIGJ1ZyBpbiB0aGUgc3BhcmMgbWVyZ2UhDQoNClRoZSBleHBsaWNpdCAnc2hvcnQn
IHBhZCBjb3VsZCBiZSByZW1vdmVkIGZyb20gdGhlIDY0Yml0IHZhcmlhbnQNCmJlY2F1c2UgdGhl
cmUgYXJlIGFsd2F5cyA0IGJ5dGVzIG9mIHBhZCBhZnRlciBsX3BpZC4NCkJ1dCBpdCBkb2VzIGV4
dGVuZCB0aGUgYXBwbGljYXRpb24gc3RydWN0dXJlIG9uIDMyYml0IHNwYXJjIHNvIG11c3QNCnJl
bWFpbiBpbiB0aGUgdWFwaSBoZWFkZXIuDQpJdCBkb2Vzbid0IG5lZWQgdG8gYmUgaW4gdGhlICdj
b21wYXQnIGRlZmluaXRpb24uDQoNCj4gPiBvaCAtIGNvbXBhdF9sb2ZmX3QgaXMgb25seSB1c2Vk
IGluIGEgY291cGxlIG9mIG90aGVyIHBsYWNlcy4NCj4gPiBuZWl0aGVyIGNhcmUgaW4gYW55IHdh
eSBhYm91dCB0aGUgYWxpZ25tZW50Lg0KPiA+IChQcm92aWRlZCBnZXRfdXNlcigpIGRvZXNuJ3Qg
ZmF1bHQgb24gYSA4bis0IGFsaWduZWQgYWRkcmVzcy4pDQo+IA0KPiBBaCByaWdodCwgSSBhbHNv
IHNlZSB0aGF0IGFmdGVyIHRoaXMgc2VyaWVzIGl0J3Mgb25seSB1c2VkIGluIHRvIG90aGVyDQo+
IHBsYWNlczogIGNvbXBhdF9yZXN1bWVfc3dhcF9hcmVhLCB3aGljaCBjb3VsZCBhbHNvIGxvc2Ug
dGhlDQo+IF9fcGFja2VkIGFubm90YXRpb24sDQoNClRoYXQgc3RydWN0dXJlIGp1c3QgZGVmaW5l
cyAwIGFuZCA4LCB0aGUgc3RydWN0dXJlIHNpemUgZG9lc24ndA0KbWF0dGVyIGFuZCB0aGUgb2Zm
c2V0cyBhcmUgJ3Bhc3NlZCB0bycgZ2V0X3VzZXIoKSBzbyBieXRlDQphY2Nlc3NlcyBhcmVuJ3Qg
cGVyZm9ybWVkLg0KDQo+IGFuZCBpbiB0aGUgZGVjbGFyYXRpb24gb2YNCj4gY29tcGF0X3N5c19z
ZW5kZmlsZTY0LCB3aGVyZSBpdCBtYWtlcyBubyBkaWZmZXJlbmNlLg0KDQpXaGljaCBzaG91bGQg
cHJvYmFibHkgdXNlIGdldF91c2VyKCkgcmF0aGVyIHRoYW4gY29weV9mcm9tX3VzZXIoKS4NCg0K
QWx0aG91Z2ggc29tZSBhcmNoaXRlY3R1cmVzIG1heSBuZWVkIGZhbGxiYWNrIGNvZGUgZm9yDQpt
aXNhbGlnbmVkIGdldF91c2VyKCkgPw0KT3IgaXMgdGhlcmUgYSBnZW5lcmFsICdjb3Agb3V0JyB0
aGF0IHN0cnVjdHVyZXMgcGFzc2VkIHRvIHRoZQ0Ka2VybmVsIGFyZSByZXF1aXJlZCB0byBiZSBj
b3JyZWN0bHkgYWxpZ25lZC4NClRoZXkgc2hvdWxkIGJlIGFsaWduZWQgdW5sZXNzIHRoZSBrZXJu
ZWwgaXMgJ3BsYXlpbmcgZ2FtZXMnDQpsaWtlIHJlYWRpbmcgJ3N0cnVjdCBwb2xsZmQnIGFzIGEg
NjRiaXQgaXRlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

