Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908F659895
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiL3NOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 08:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiL3NOC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 08:14:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF681ADA3
        for <linux-arch@vger.kernel.org>; Fri, 30 Dec 2022 05:14:00 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-123-ujNxs6XjNyOZnr5eFmPVlQ-1; Fri, 30 Dec 2022 13:13:57 +0000
X-MC-Unique: ujNxs6XjNyOZnr5eFmPVlQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Dec
 2022 13:13:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 30 Dec 2022 13:13:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Holger Lubitz' <holger.lubitz@t-online.de>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: RE: [PATCH v2] kbuild: treat char as always unsigned
Thread-Topic: [PATCH v2] kbuild: treat char as always unsigned
Thread-Index: AQHZFV6o8tF/XYcvI0qqEtVNYsUlXa55tQ3wgAMV4YCACXsZ8IAAL/vQ
Date:   Fri, 30 Dec 2022 13:13:55 +0000
Message-ID: <a296bd41278d4bd4a4e9f0d31a540613@AcuMS.aculab.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
         <20221019203034.3795710-1-Jason@zx2c4.com>
         <20221221145332.GA2399037@roeck-us.net>
         <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
         <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
         <20221221155641.GB2468105@roeck-us.net>
         <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
         <b2144334261246aa8dc5004c5f1a58c9@AcuMS.aculab.com>
 <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
 <357cbd67260040e4bcf17d519aaafdcb@AcuMS.aculab.com>
In-Reply-To: <357cbd67260040e4bcf17d519aaafdcb@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Li4uLg0KPiA+IGludCBzdHJjbXAxKGNvbnN0IGNoYXIgKmNzLCBjb25zdCBjaGFyICpjdCkNCj4g
PiB7DQo+ID4gICAgICAgICBpbnQgcmVzOw0KPiA+DQo+ID4gICAgICAgICBhc20gKCJcbiINCj4g
PiAgICAgICAgICAgICAgICAgIjE6IG1vdmUuYiAgKCUwKSssJTJcbiIgIC8qIGdldCAqY3MgKi8N
Cj4gPiAgICAgICAgICAgICAgICAgIiAgIGplcSAgICAgMmZcbiIgICAgICAgIC8qIGVuZCBvZiBm
aXJzdCBzdHJpbmc/ICovDQo+ID4gICAgICAgICAgICAgICAgICIgICBjbXAuYiAgICglMSkrLCUy
XG4iICAvKiBjb21wYXJlICpjdCAqLw0KPiA+ICAgICAgICAgICAgICAgICAiICAgamVxICAgICAx
YlxuIiAgICAgICAgLyogaWYgZXF1YWwsIGNvbnRpbnVlICovDQo+ID4gICAgICAgICAgICAgICAg
ICIgICBqcmEgICAgIDNmXG4iICAgICAgICAvKiBlbHNlIHNraXAgdG8gdGFpbCAqLw0KPiA+ICAg
ICAgICAgICAgICAgICAiMjogY21wLmIgICAoJTEpKywlMlxuIiAgLyogY29tcGFyZSBvbmUgbGFz
dCBieXRlICovDQo+ID4gICAgICAgICAgICAgICAgICIzOiBzdWJ4LmwgICUyLCAlMlxuIiAgICAv
KiAtMSBpZiBib3Jyb3csIDAgaWYgbm90ICovDQo+ID4gICAgICAgICAgICAgICAgICIgICBqbHMg
ICAgIDRmXG4iICAgICAgICAvKiBpZiBzZXQsIHogaXMgZnJvbSBzdWIuYiAqLw0KPiANCj4gVGhl
IHN1Ynggd2lsbCBzZXQgWiB1bmxlc3MgQyB3YXMgc2V0Lg0KPiBTbyB0aGF0IGRvZXNuJ3Qgc2Vl
bSByaWdodC4NCg0KQ2xlYXJseSBteSBicmFpbiB3YXMgYXNsZWVwIGVhcmxpZXIuDQpzdWJ4IHdp
bGwgY2xlYXIgWiBub3Qgc2V0IGl0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

