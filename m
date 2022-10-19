Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9C6051BB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 23:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiJSVHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 17:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiJSVHG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 17:07:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C31C73E7
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 14:07:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-W1fNxx02PquJ4hRcvsmAdg-1; Wed, 19 Oct 2022 22:07:01 +0100
X-MC-Unique: W1fNxx02PquJ4hRcvsmAdg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Oct
 2022 22:07:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 19 Oct 2022 22:07:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] kbuild: treat char as always signed
Thread-Topic: [PATCH] kbuild: treat char as always signed
Thread-Index: AQHY4+Y9hyAXVET2lkaxpfvqAx79z64WM2og
Date:   Wed, 19 Oct 2022 21:07:01 +0000
Message-ID: <e0f6a641c7464d71abbddb4befd35e59@AcuMS.aculab.com>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgT2N0b2JlciAyMDIyIDE5OjExDQouLi4N
Cj4gRXhwbGljaXQgY2FzdHMgYXJlIGJhZCAodW5sZXNzLCBvZiBjb3Vyc2UsIHlvdSBhcmUgZXhw
bGljaXRseSB0cnlpbmcNCj4gdG8gdmlvbGF0ZSB0aGUgdHlwZSBzeXN0ZW0sIHdoZW4gdGhleSBh
cmUgYm90aCByZXF1aXJlZCwgYW5kIGEgZ3JlYXQNCj4gd2F5IHRvIHNheSAibG9vaywgSSdtIGRv
aW5nIHNvbWV0aGluZyBkYW5nZXJvdXMiKS4NCg0KVGhlIHdvcnN0IG9uZXMgaW4gdGhlIGtlcm5l
bCBhcmUgdGhlIF9fZm9yY2Ugb25lcyBmb3Igc3BhcnNlLg0KVGhleSByZWFsbHkgb3VnaHQgdG8g
YmUgYSBmdW5jdGlvbiAoI2RlZmluZSkgc28gdGhhdCB0aGV5DQphcmUgbm90IHNlZW4gYnkgdGhl
IGNvbXBpbGVyIGF0IGFsbC4NCk90aGVyd2lzZSB0aGV5IGNhbiBoaWRlIGEgbXVsdGl0dWRlIG9m
IHNpbnMuDQoNClRoZXJlIGFyZSBhbHNvIHRoZSBjYXN0cyB0byBjb252ZXJ0IGludGVnZXIgdmFs
dWVzIHRvL2Zyb20gdW5zaWduZWQuDQphbmQgdG8gZGlmZmVyZW50IHNpemVkIGludGVnZXJzLg0K
VGhleSBhbGwgaGFwcGVuIGZhciB0b28gb2Z0ZW4gYW5kIGNhbiBoaWRlIHRoaW5ncy4NCkEgJysg
MHUnIHdpbGwgY29udmVydCBpbnRvIHRvIHVuc2lnbmVkIGludCB3aXRob3V0IGEgY2FzdC4NCkNh
c3RzIHJlYWxseSBvdWdodCB0byBiZSByYXJlLg0KRXZlbiB0aGUgY2FzdHMgdG8gZnJvbSAodm9p
ZCAqKSAoZm9yICdidWZmZXJzJykgY2FuIHVzdWFsbHkgYmUNCm1hZGUgaW1wbGljaXQgaW4gYSBm
dW5jdGlvbiBjYWxsIGFyZ3VtZW50Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

