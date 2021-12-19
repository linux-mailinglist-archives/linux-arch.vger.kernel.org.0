Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB147A0E4
	for <lists+linux-arch@lfdr.de>; Sun, 19 Dec 2021 15:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhLSOXf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Dec 2021 09:23:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42948 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233051AbhLSOXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Dec 2021 09:23:33 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-47-lARwkb-CPHSriFWVJJMrNw-1; Sun, 19 Dec 2021 14:23:30 +0000
X-MC-Unique: lARwkb-CPHSriFWVJJMrNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sun, 19 Dec 2021 14:23:29 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sun, 19 Dec 2021 14:23:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Garry' <john.garry@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
Thread-Topic: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
Thread-Index: AQHX81JQISxKPCuGHU2T1v53saw8BKw53sKg
Date:   Sun, 19 Dec 2021 14:23:29 +0000
Message-ID: <3a10b91258bf432baf51932a08335f6e@AcuMS.aculab.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
 <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
 <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
 <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
 <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
 <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
 <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
In-Reply-To: <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
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

RnJvbTogSm9obiBHYXJyeQ0KPiBTZW50OiAxNyBEZWNlbWJlciAyMDIxIDE0OjI4DQo+IA0KPiBP
biAxNy8xMi8yMDIxIDEzOjUyLCBOaWtsYXMgU2NobmVsbGUgd3JvdGU6DQo+IA0KPiBUaGFua3Mg
Zm9yIGxvb2tpbmcgYXQgdGhpcyBhZ2Fpbi4NCj4gDQo+ID4+PiBJIGhhdmUgdGVzdGVkIHRoaXMg
b24gczM5MCB3aXRoIEhBU19JT1BPUlQ9biBhbmQgYWxseWVzY29uZmlnIGFzIHdlbGwNCj4gPj4+
IGFzIHJ1bm5pbmcgaXQgd2l0aCBkZWZjb25maWcuIEkndmUgYWxzbyBiZWVuIHVzaW5nIGl0IG9u
IG15IFJ5emVuIDM5OTBYDQo+ID4+PiB3b3Jrc3RhdGlvbiB3aXRoIExFR0FDWV9QQ0k9biBmb3Ig
YSBmZXcgZGF5cy4gSSBkbyBnZXQgYWJvdXQgNjAgTWlCDQo+ID4+PiBmZXdlciBtb2R1bGVzIGNv
bXBhcmVkIHdpdGggYSBzaW1pbGFyIGNvbmZpZyBvZiB2NS4xNS44LiBIYXJkIHRvIHNheQ0KPiA+
Pj4gd2hpY2ggb3RoZXIgc3lzdGVtcyBtaWdodCBtaXNzIHRoaW5ncyBvZiBjb3Vyc2UuDQo+ID4+
Pg0KPiA+Pj4gSSBoYXZlIG5vdCB5ZXQgd29ya2VkIG9uIHRoZSBkaXNjdXNzZWQgSU9QT1JUX05B
VElWRSBmbGFnLiBNb3N0bHkgSSdtDQo+ID4+PiB3b25kZXJpbmcgdHdvIHRoaW5ncy4gRm9yIG9u
ZSBpdCBmZWVscyBsaWtlIHRoYXQgY291bGQgYmUgYSBzZXBhcmF0ZQ0KPiA+Pj4gY2hhbmdlIG9u
IHRvcCBzaW5jZSBIQVNfSU9QT1JUICsgTEVHQUNZX1BDSSBpcyBhbHJlYWR5IHF1aXRlIGJpZy4N
Cj4gPj4+IFNlY29uZGx5IEknbSB3b25kZXJpbmcgYWJvdXQgZ29vZCB3YXlzIG9mIGlkZW50aWZ5
aW5nIHN1Y2ggZHJpdmVycyBhbmQNCj4gPj4+IGhvdyBtdWNoIHRoaXMgb3ZlcmxhcHMgd2l0aCB0
aGUgSVNBIGNvbmZpZyBmbGFnLg0KPiANCj4gSSB3YXMgaW50ZXJlc3RpbmcgaW4gdGhlIElPUE9S
VF9OQVRJVkUgZmxhZyAob3Igd2hhdGV2ZXIgd2UgY2FsbCBpdCkgYXMNCj4gaXQgc29sdmVzIHRo
ZSBwcm9ibGVtIG9mIGRyaXZlcnMgd2hpY2ggInVuY29uZGl0aW9uYWxseSBkbyBpbmIoKS9vdXRi
KCkNCj4gd2l0aG91dCBjaGVja2luZyB0aGUgdmFsaWRpdHkgb2YgdGhlIGFkZHJlc3MgdXNpbmcg
ZmlybXdhcmUgb3Igb3RoZXINCj4gbWV0aG9kcyBmaXJzdCIgYmVpbmcgYnVpbHQgZm9yIChhbmQg
bG9hZGVkIG9uIGFuZCBjcmFzaGluZykgdW5zdWl0YWJsZQ0KPiBzeXN0ZW1zLiBTdWNoIGEgcHJv
YmxlbSBpcyBpbiBbMF0NCj4gDQo+IFNvIGlmIHdlIHdhbnQgdG8gc3VwcG9ydCB0aGF0IGxhdGVy
LCB0aGVuIGl0IHNlZW1zIHRoYXQgc29tZW9uZSB3b3VsZA0KPiBuZWVkIHRvIGdvIGJhY2sgYW5k
IHJlLWVkaXQgbWFueSBzYW1lIGRyaXZlciBLY29uZmlncyDigJMgbGlrZSBod29uLCBmb3INCj4g
ZXhhbXBsZS4gSSB0aGluayBpdCdzIGJldHRlciB0byBhdm9pZCB0aGF0IGFuZCBkbyBpdCBub3cu
DQoNCkNvdWxkIHlvdSBkbyBzb21ldGhpbmcgd2hlcmUgdmFsaWQgYXJndW1lbnRzIHRvIGluYigp
IGhhdmUgdG8gY29tZQ0KZnJvbSBzb21lIGtlcm5lbCBtYXBwaW5nL3ZhbGlkYXRpb24gZnVuY3Rp
b24gYW5kIGFyZSBuZXZlciBpbiB0aGUNCnJhbmdlIFsweDAsIDB4MTAwMDApLg0KVGhlbiBkcml2
ZXJzIHRoYXQgYXJlIGNoZWF0aW5nIHRoZSBzeXN0ZW0gd2lsbCBmYWlsLg0KDQpPciwgbWF5YmUs
IG9ubHkgYWxsb3cgWzB4MCwgMHgxMDAwMCkgb24gc3lzdGVtcyB0aGF0IGhhdmUgYSBzdWl0YWJs
ZSBidXMuDQpXaXRoIHRoZSBtYXBwaW5nIGZ1bmN0aW9ucyByZXR1cm5pbmcgYSBkaWZmZXJlbnQg
dmFsdWUgKGVnIHRoZSBLVkEgaW50bw0KdGhlIFBDSSBtYXN0ZXIgd2luZG93KSB0aGF0IGNhbiBi
ZSBzZXBhcmF0ZWx5IHZlcmlmaWVkLg0KVGhhdCB3b3VsZCBsZXQgZHJpdmVycyBkbyAoc2F5KSBp
bmIoMHgxMjApIG9uIHN5c3RlbXMgdGhhdCBoYXZlIChzb21ldGhpbmcNCmxpa2UpIGFuZCBJU0Eg
YnVzLCBidXQgbm90IG9uIFBDSS1vbmx5IHN5c3RlbXMgd2hpY2ggc3VwcG9ydCBQQ0kgSU8NCmFj
Y2Vzc2VzIHRocm91Z2ggYSBwaHlzaWNhbCBhZGRyZXNzIHdpbmRvdy4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

