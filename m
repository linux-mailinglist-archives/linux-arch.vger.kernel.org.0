Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72B4C62D4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiB1GQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 01:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiB1GQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 01:16:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C0FC3DDF6
        for <linux-arch@vger.kernel.org>; Sun, 27 Feb 2022 22:16:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-125-lgUm4UbTM6iVn5quhs8lMw-1; Mon, 28 Feb 2022 06:16:02 +0000
X-MC-Unique: lgUm4UbTM6iVn5quhs8lMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 28 Feb 2022 06:15:59 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 28 Feb 2022 06:15:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jakob <jakobkoschel@gmail.com>,
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
Thread-Index: AQHYK3er/AEA45TQBUCd0AhQFcgB96ym+KOQgADr1YCAAJR3MA==
Date:   Mon, 28 Feb 2022 06:15:59 +0000
Message-ID: <6729109ae6ad429f87270e2bef2eed2f@AcuMS.aculab.com>
References: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
 <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org>
 <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org>
 <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
 <20220227113245.GY614@gate.crashing.org>
 <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
 <20220227201724.GZ614@gate.crashing.org>
 <CAHk-=wijh=SQ_9_-H6O08HgmXrWz37_vcdm55oECo+31LUs2EQ@mail.gmail.com>
In-Reply-To: <CAHk-=wijh=SQ_9_-H6O08HgmXrWz37_vcdm55oECo+31LUs2EQ@mail.gmail.com>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjcgRmVicnVhcnkgMjAyMiAyMTowNQ0KLi4u
DQo+IEFuZCB0aGVuIHRoZSBDIHN0YW5kYXJkcyBwZW9wbGUgZGVjaWRlZCB0aGF0ICJiZWNhdXNl
IG91ciBqb2IgaXNuJ3QgdG8NCj4gZGVzY3JpYmUgYWxsIHRoZSBhcmNoaXRlY3R1cmFsIGlzc3Vl
cyB5b3UgY2FuIGhpdCwgd2UnbGwgY2FsbCBpdA0KPiB1bmRlZmluZWQsIGFuZCBpbiB0aGUgcHJv
Y2VzcyBsZXQgY29tcGlsZXIgcGVvcGxlIGludGVudGlvbmFsbHkgYnJlYWsNCj4gaXQiLg0KPiAN
Cj4gVEhBVCBpcyBhIHByb2JsZW0uDQoNCkknbSB3YWl0aW5nIGZvciB0aGVtIHRvIGRlY2lkZSB0
aGF0IG1lbXNldChwdHIsIDAsIGxlbikgb2YNCmFueSBzdHJ1Y3R1cmUgdGhhdCBjb250YWlucyBh
IHBvaW50ZXIgaXMgVUIgKGJlY2F1c2UgYSBOVUxMDQpwb2ludGVyIG5lZWQgbm90IGJlIHRoZSBh
bGwgemVybyBiaXQgcGF0dGVybikgc28gZGVjaWRlDQp0byBkaXNjYXJkIHRoZSBjYWxsIGNvbXBs
ZXRlbHkgKG9yIHNvbWUgc3VjaCkuDQoNCk5vbi16ZXJvIE5VTEwgcG9pbnRlcnMgaXMgdGhlIG9u
bHkgcmVhc29uIGFyaXRobWV0aWMgb24gTlVMTA0KcG9pbnRlcnMgaXNuJ3QgdmFsaWQuDQoNCk9y
IG1heWJlIHRoYXQgY2hhcmFjdGVyIHJhbmdlIHRlc3RzIGFyZSBVQiBiZWNhdXNlICcwJyB0byAn
OScNCmRvbid0IGhhdmUgdG8gYmUgYWRqYWNlbnQgLSB0aGV5IGFyZSBldmVuIGFkamFjZW50IGlu
IEVCQ0RJQy4NCg0KU29tZSBvZiB0aGUgJ3N0cmljdCBhbGlhc2luZycgYml0cyBhcmUgYWN0dWFs
bHkgdXNlZnVsIHNpbmNlDQp0aGV5IGxldCB0aGUgY29tcGlsZXIgcmVvcmRlciByZWFkcyBhbmQg
d3JpdGVzLg0KQnV0IHRoZSBkZWZpbml0aW9uIGlzIGJyYWluLWRlYWQuDQpTb21ldGltZXMgaXQg
d291bGQgYmUgbmljZSB0byBoYXZlIGJ5dGUgd3JpdGVzIHJlb3JkZXJlZCwNCmJ1dCBldmVuIHVz
aW5nIGludDo4IGRvZXNuJ3Qgd29yay4NCg0KSSBoYXZlIG5ldmVyIHdvcmtlZCBvdXQgd2hhdCAn
cmVzdHJpY3QnIGFjdHVhbGx5IGRvZXMsDQppbiBhbnkgcGxhY2VzIEkndmUgdHJpZWQgaXQgZGlk
IG5vdGhpbmcuDQpBbHRob3VnaCBJIG1heSBoYXZlIGJlZW4gaG9waW5nIGl0IHdvdWxkIHN0aWxs
IGhlbHAgd2hlbg0KdGhlIGZ1bmN0aW9uIGdvdCBpbmxpbmVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

