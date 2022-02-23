Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC64C1E5E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 23:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbiBWWWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 17:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBWWWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 17:22:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A050938BDA
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 14:22:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-52-47HVlWikMZ6aOVTG4W2bMg-1; Wed, 23 Feb 2022 22:22:00 +0000
X-MC-Unique: 47HVlWikMZ6aOVTG4W2bMg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 23 Feb 2022 22:21:59 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 23 Feb 2022 22:21:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Topic: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Index: AQHYKPelNzNrpGqQgkqTAOyaEHSAMayhspkg
Date:   Wed, 23 Feb 2022 22:21:59 +0000
Message-ID: <03f5e1f9ff89416d8b08906d4c776f00@AcuMS.aculab.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
 <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
 <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
 <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgRmVicnVhcnkgMjAyMiAyMDo1NQ0KPiAN
Cj4gT24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgMTI6NDMgUE0gTGludXMgVG9ydmFsZHMNCj4gPHRv
cnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9mIGNvdXJzZSwg
dGhlIEMgc3RhbmRhcmQgYmVpbmcgdGhlIGJ1bmNoIG9mIGluY29tcGV0ZW50cyB0aGV5IGFyZSwN
Cj4gPiB0aGV5IGluIHRoZSBwcm9jZXNzIGFwcGFyZW50bHkgbWFkZSBsZWZ0LXNoaWZ0cyB1bmRl
ZmluZWQgKHJhdGhlciB0aGFuDQo+ID4gaW1wbGVtZW50YXRpb24tZGVmaW5lZCkuIENocmlzdCwg
dGhleSBrZWVwIG9uIG1ha2luZyB0aGUgc2FtZSBtaXN0YWtlcw0KPiA+IG92ZXIgYW5kIG92ZXIu
IFdoYXQgd2FzIHRoZSBkZWZpbml0aW9uIG9mIGluc2FuaXR5IGFnYWluPw0KPiANCj4gSGV5LCBz
b21lIG1vcmUgZ29vZ2xpbmcgb24gbXkgcGFydCBzZWVtcyB0byBzYXkgdGhhdCBzb21lYm9keSBz
YXcgdGhlDQo+IGxpZ2h0LCBhbmQgaXQncyBsaWtlbHkgZ2V0dGluZyBmaXhlZCBpbiBuZXdlciBD
IHN0YW5kYXJkIHZlcnNpb24uDQo+IA0KPiBTbyBpdCB3YXMganVzdCBhIG1pc3Rha2UsIG5vdCBh
Y3R1YWwgbWFsaWNlLiBNYXliZSB3ZSBjYW4gaG9wZSB0aGF0DQo+IHRoZSB0aWRlIGlzIHR1cm5p
bmcgYWdhaW5zdCB0aGUgInVuZGVmaW5lZCIgY3Jvd2QgdGhhdCB1c2VkIHRvIHJ1bGUNCj4gdGhl
IHJvb3N0IGluIHRoZSBDIHN0YW5kYXJkcyBib2RpZXMuIE1heWJlIHRoZSBmdW5kYW1lbnRhbCBz
ZWN1cml0eQ0KPiBpc3N1ZXMgd2l0aCB1bmRlZmluZWQgYmVoYXZpb3IgZmluYWxseSBjb252aW5j
ZWQgcGVvcGxlIGhvdyBiYWQgaXQNCj4gd2FzPw0KDQpJSVJDIFVCIGluY2x1ZGVzICdmaXJlIGFu
IElDQk0gYXQgdGhlIHdyaXRlciBvZiB0aGUgc3RhbmRhcmRzIGRvY3VtZW50Jy4NClRoZXJlIGlz
bid0IGFuICd1bmRlZmluZWQgdmFsdWUnIG9yIGV2ZW4gJ3VuZGVmaW5lZCB2YWx1ZSBvciBwcm9n
cmFtIHRyYXAnDQpvcHRpb24uDQoNCkl0IGFsc28gc2VlbXMgdG8gbWUgdGhhdCB0aGUgY29tcGls
ZXIgcGVvcGxlIGFyZSBwaWNraW5nIG9uIHRoaW5ncw0KaW4gdGhlIHN0YW5kYXJkIHRoYXQgYXJl
IHRoZXJlIHRvIGxldCAnb2JzY3VyZSBtYWNoaW5lcyBjb25mb3JtJw0KYW5kIHRoZW4gdXNpbmcg
dGhlbSB0byBicmVhayBwZXJmZWN0bHkgcmVhc29uYWJsZSBwcm9ncmFtcy4NCg0KU2lnbmVkIGFy
aXRobWV0aWMgaXMgbm90IHJlcXVpcmVkIHRvIHdyYXAgc28gdGhhdCBjcHUgKGVnIERTUCkNCmNh
biBkbyBzYXR1cmF0aW5nIG1hdGhzIC0gbm90IHNvIHRoZSBjb21waWxlciBjYW4gcmVtb3ZlIHNv
bWUNCmNvbmRpdGlvbmFscy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

