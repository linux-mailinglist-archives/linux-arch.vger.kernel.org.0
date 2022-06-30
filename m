Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE46561420
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiF3IEv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiF3IEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 04:04:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C309E40A02
        for <linux-arch@vger.kernel.org>; Thu, 30 Jun 2022 01:04:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-9jXG4kaVPcae5B0FitiCbQ-1; Thu, 30 Jun 2022 09:04:45 +0100
X-MC-Unique: 9jXG4kaVPcae5B0FitiCbQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 30 Jun 2022 09:04:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 30 Jun 2022 09:04:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Schmitz' <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: RE: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Topic: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Index: AQHYi0Qnhtr21GMXN0qgKN5inTL9yK1nmAnQ
Date:   Thu, 30 Jun 2022 08:04:43 +0000
Message-ID: <26852797d822462abc1c9f96def7fa42@AcuMS.aculab.com>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
In-Reply-To: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTWljaGFlbCBTY2htaXR6DQo+IFNlbnQ6IDI5IEp1bmUgMjAyMiAwMDowOQ0KPiANCj4g
SGkgQXJuZCwNCj4gDQo+IE9uIDI5LzA2LzIyIDA5OjUwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiA+IE9uIFR1ZSwgSnVuIDI4LCAyMDIyIGF0IDExOjAzIFBNIE1pY2hhZWwgU2NobWl0eiA8c2No
bWl0em1pY0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAyOC8wNi8yMiAxOTowMywgR2VlcnQg
VXl0dGVyaG9ldmVuIHdyb3RlOg0KPiA+Pj4+IFRoZSBkcml2ZXIgYWxsb2NhdGVzIGJvdW5jZSBi
dWZmZXJzIHVzaW5nIGttYWxsb2MgaWYgaXQgaGl0cyBhbg0KPiA+Pj4+IHVuYWxpZ25lZCBkYXRh
IGJ1ZmZlciAtIGNhbiBzdWNoIGJ1ZmZlcnMgc3RpbGwgZXZlbiBoYXBwZW4gdGhlc2UgZGF5cz8N
Cj4gPj4+IE5vIGlkZWEuDQo+ID4+IEhtbW0gLSBJIHRoaW5rIEknbGwgc3RpY2sgYSBXQVJOX09O
Q0UoKSBpbiB0aGVyZSBzbyB3ZSBrbm93IHdoZXRoZXIgdGhpcw0KPiA+PiBjb2RlIHBhdGggaXMg
c3RpbGwgYmVpbmcgdXNlZC4NCj4gPiBrbWFsbG9jKCkgZ3VhcmFudGVlcyBhbGlnbm1lbnQgdG8g
dGhlIG5leHQgcG93ZXItb2YtdHdvIHNpemUgb3INCj4gPiBLTUFMTE9DX01JTl9BTElHTiwgd2hp
Y2hldmVyIGlzIGJpZ2dlci4gT24gbTY4ayB0aGlzIG1lYW5zIGl0DQo+ID4gaXMgY2FjaGVsaW5l
IGFsaWduZWQuDQo+IA0KPiBBbmQgYWxsIFNDU0kgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHVzaW5n
IGttYWxsb2M/IE5vIHdheSBhdCBhbGwgZm9yIHVzZXINCj4gc3BhY2UgdG8gcGFzcyB1bmFsaWdu
ZWQgZGF0YT8NCg0KSSBkaWRuJ3QgdGhpbmsga21hbGxvYygpIGdhdmUgYW55IHN1Y2ggZ3VhcmFu
dGVlIGFib3V0IGFsaWdubWVudC4NClRoZXJlIGFyZSBjYWNoZS1saW5lIGFsaWdubWVudCByZXF1
aXJlbWVudHMgb24gc3lzdGVtcyB3aXRoIG5vbi1jb2hlcmVudA0KZG1hLCBidXQgb3RoZXJ3aXNl
IHRoZSBhbGlnbm1lbnQgY2FuIGJlIG11Y2ggc21hbGxlci4NCg0KT25lIG9mIHRoZSBhbGxvY2F0
b3JzIGFkZHMgYSBoZWFkZXIgdG8gZWFjaCBpdGVtLCBJSVJDIHRoYXQgY2FuDQpsZWFkIHRvICd1
bmV4cGVjdGVkJyBhbGlnbm1lbnRzIC0gZXNwZWNpYWxseSBvbiBtNjhrLg0KDQpkbWFfYWxsb2Nf
Y29oZXJlbnQoKSBkb2VzIGFsaWduIHRvIG5leHQgJ3Bvd2VyIG9mIDInLg0KQW5kIHNvbWV0aW1l
cyB5b3UgbmVlZCAoZWcpIDE2ayBhbGxvY2F0ZXMgdGhhdCBhcmUgMTZrIGFsaWduZWQuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

