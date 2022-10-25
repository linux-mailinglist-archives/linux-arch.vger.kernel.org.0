Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB560C9D5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiJYKUU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiJYKUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 06:20:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E510824C
        for <linux-arch@vger.kernel.org>; Tue, 25 Oct 2022 03:16:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-XRHPgPYkNDayEQTJ0UJOag-1; Tue, 25 Oct 2022 11:16:26 +0100
X-MC-Unique: XRHPgPYkNDayEQTJ0UJOag-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Oct
 2022 11:16:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 25 Oct 2022 11:16:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2] kbuild: treat char as always unsigned
Thread-Topic: [PATCH v2] kbuild: treat char as always unsigned
Thread-Index: AQHY59f6M0xaP7/PP0yp5ZydqE10B64e5SbQ
Date:   Tue, 25 Oct 2022 10:16:24 +0000
Message-ID: <64e9baf317cc4211a46829546f8960ff@AcuMS.aculab.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com> <Y1ZZyP4ZRBIbv+Kg@kili>
 <Y1ZbI4IzAOaNwhoD@kadam> <Y1a+cHkFt54gJv54@zx2c4.com>
 <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
In-Reply-To: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgT2N0b2JlciAyMDIyIDE4OjExDQouLi4N
Cj4gDQo+IEFzIGZhciBhcyBJIGtub3csIHRoZXJlIGFyZSBubyBhY3R1YWwgcnVsZXMgZm9yIFNT
SUQgY2hhcmFjdGVyIHNldHMsDQo+IGFuZCB3aGlsZSB1c2luZyB1dGYtOCBvciBzb21ldGhpbmcg
ZWxzZSBtaWdodCBjYXVzZSBpbnRlcm9wZXJhYmlsaXR5DQo+IHByb2JsZW1zLCB0aGlzIGRyaXZl
ciBzZWVtcyB0byBiZSBqdXN0IGNvbmZ1c2VkLiBJZiB5b3Ugd2FudCB0byBjaGVjaw0KPiBmb3Ig
InByaW50YWJsZSBjaGFyYWN0ZXJzIiwgdGhhdCBjaGVjayBpcyBzdGlsbCB3cm9uZy4NCg0KQXJl
IFNTSUQgZXZlbiByZXF1aXJlZCB0byBiZSBwcmludGFibGUgYXQgYWxsPw0KV2hpbGUgbW9zdCBz
eXN0ZW1zIG9ubHkgbGV0IHlvdSBjb25maWd1cmUgJ3N0cmluZ3MnIEkgZG9uJ3QNCnJlbWVtYmVy
IHRoYXQgYWN0dWFsbHkgYmVpbmcgYSByZXF1aXJlbWVudC4NCihJJ3ZlIHN1cmUgSSByZWFkIHVw
IG9uIHRoaXMgeWVhcnMgYWdvLikNCg0KVGhlIGZyYW1lIGZvcm1hdCB3aWxsIGJlIHVzaW5nIGFu
IGV4cGxpY2l0IGxlbmd0aC4NClNvIGV2ZW4gZW1iZWRkZWQgemVyb3MgbWF5IGJlIHZhbGlkIQ0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

