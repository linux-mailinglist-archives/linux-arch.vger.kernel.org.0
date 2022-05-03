Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5951851F
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 15:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiECNLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 May 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiECNLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2022 09:11:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B3662B184
        for <linux-arch@vger.kernel.org>; Tue,  3 May 2022 06:08:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-234-VLCMgDn0OwqNyGTPU6svxg-1; Tue, 03 May 2022 14:08:05 +0100
X-MC-Unique: VLCMgDn0OwqNyGTPU6svxg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 3 May 2022 14:08:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 3 May 2022 14:08:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Walleij' <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Thread-Topic: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Thread-Index: AQHYXaY4HSGVKKYe1UmuRZfv/6NY/a0NHk4Q
Date:   Tue, 3 May 2022 13:08:04 +0000
Message-ID: <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora>
 <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
 <YmwGLrh4U+pVJo0m@fedora>
 <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
In-Reply-To: <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
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

RnJvbTogTGludXMgV2FsbGVpag0KPiBTZW50OiAwMSBNYXkgMjAyMiAyMjo1Ng0KPiANCj4gT24g
RnJpLCBBcHIgMjksIDIwMjIgYXQgNTozNyBQTSBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5DQo+IDx3
aWxsaWFtLmdyYXlAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gT24gRnJpLCBBcHIgMjksIDIwMjIg
YXQgMDQ6NDY6MDBQTSArMDIwMCwgTmlrbGFzIFNjaG5lbGxlIHdyb3RlOg0KPiANCj4gPiA+IEdv
b2QgcXVlc3Rpb24uIEFzIGZhciBhcyBJIGNhbiBzZWUgbW9zdCAoYWxsPykgb2YgdGhlc2UgaGF2
ZSAic2VsZWN0DQo+ID4gPiBJU0FfQlVTX0FQSSIgd2hpY2ggaXMgImRlZl9ib29sIElTQSIuIE5v
dyAiY29uZmlnIElTQSIgc2VlbXMgdG8NCj4gPiA+IGN1cnJlbnRseSBiZSByZXBlYXRlZCBpbiBh
cmNoaXRlY3R1cmVzIGFuZCBkb2Vzbid0IGhhdmUgYW4gZXhwbGljaXQNCj4gPiA+IEhBU19JT1BP
UlQgZGVwZW5kZW5jeSAoaXQgbWF5YmUgc2hvdWxkIGhhdmUgb25lKS4gQnV0IGl0IGRvZXMgb25s
eSBtYWtlDQo+ID4gPiBzZW5zZSBvbiBhcmNoaXRlY3R1cmVzIHdpdGggSEFTX0lPUE9SVCBzZXQu
DQo+ID4NCj4gPiBUaGVyZSBpcyBzdWNoIGEgdGhpbmcgYXMgSVNBIERNQSwgYnV0IHlvdSdsbCBz
dGlsbCBuZWVkIHRvIGluaXRpYWxpemUNCj4gPiB0aGUgZGV2aWNlIHZpYSB0aGUgSU8gUG9ydCBi
dXMgZmlyc3QsIHNvIHBlcmhhcHMgc2V0dGluZyBIQVNfSU9QT1JUIGZvcg0KPiA+ICJjb25maWcg
SVNBIiBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG86IGFsbCBJU0EgZGV2aWNlcyBhcmUgZXhwZWN0
ZWQgdG8NCj4gPiBjb21tdW5pY2F0ZSBpbiBzb21lIHdheSB2aWEgaW9wb3J0Lg0KPiANCj4gQWRk
aW5nIHRoYXQgZGVwZW5kZW5jeSBzZWVtcyBsaWtlIHRoZSByaWdodCBzb2x1dGlvbiB0byBtZS4N
Cg0KSSB0aGluayBpdCBhbGwgZGVwZW5kcyBvbiB3aGF0IEhBU19JT1BPUlQgaXMgbWVhbnQgdG8g
bWVhbiBhbmQNCmhvdyBwb3J0YWJsZSBrZXJuZWwgYmluYXJpZXMgbmVlZCB0byBiZS4NCg0KeDg2
IGlzIChwcm9iYWJseSkgdGhlIG9ubHkgYXJjaGl0ZWN0dXJlIHRoYXQgYWN0dWFsbHkgaGFzICdp
bicNCmFuZCAnb3V0JyBpbnN0cnVjdGlvbnMgLSBidXQgdGhhdCBkb2Vzbid0IG1lYW4gdGhhdCBz
b21lIG90aGVyDQpjcHUgKGFuZCBJIG1lYW4gY3B1K3BjYiBub3QgYXJjaGl0ZWN0dXJlKSBoYXZl
IHRoZSBhYmlsaXR5IHRvDQpnZW5lcmF0ZSAnSU8nIGJ1cyBjeWNsZXMgb24gYSBzcGVjaWZpYyBw
aHlzaWNhbCBidXMuDQoNCldoaWxlIHRoZSBvYnZpb3VzIGNhc2UgaXMgYSBwaHlzaWNhbCBhZGRy
ZXNzIHdpbmRvdyB0aGF0IGdlbmVyYXRlcw0KUENJKGUpIElPIGN5Y2xlcyBmcm9tIG5vcm1hbCBt
ZW1vcnkgY3ljbGVzIGl0IGlzbid0IHRoZSBvbmx5IG9uZS4NCg0KSSd2ZSB1c2VkIHNwYXJjIGNw
dSBzeXN0ZW1zIHRoYXQgaGF2ZSBwY21jaWEgY2FyZCBzbG90cy4NClRoZXNlIGFyZSBwcmV0dHkg
bXVjaCBJU0EgYW5kIHRoZSBkcml2ZXJzIG1pZ2h0IGV4cGVjdCB0bw0KYWNjZXNzIHBvcnQgMHgz
MDAgKGV0YykgLSBjZXJ0YWlubHkgdGhhdCB3b3VsZCBiZSByaWdodCBvbiB4ODYuDQoNCkluIHRo
aXMgY2FzZSBpcyBpc24ndCBzbyBtdWNoIHRoYXQgdGhlIElTQV9CVVMgZGVwZW5kcyBvbiBzdXBw
b3J0DQpmb3IgaW4vb3V0IGJ1dCB0aGF0IHByZXNlbmNlIG9mIHRoZSBJU0EgYnVzIHByb3ZpZGVz
IHRoZSByZXF1aXJlZA0KaW4vb3V0IHN1cHBvcnQuDQoNCk5vdywgbWF5YmUsIHRoZSBkcml2ZXJz
IHNob3VsZCBiZSB1c2luZyBzb21lIGlvcmVtYXAgdmFyaWFudCBhbmQNCnRoZW4gY2FsbGluZyBp
b3JlYWQ4KCkgcmF0aGVyIHRoYW4gZGlyZWN0bHkgY2FsbGluZyBpbmIoKS4NCkJ1dCB0aGF0IHNl
ZW1zIG9ydGhvZ29uYWwgdG8gdGhpcyBjaGFuZ2VzZXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

