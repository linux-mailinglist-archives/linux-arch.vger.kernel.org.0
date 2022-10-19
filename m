Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB79F6051A7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiJSU61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJSU60 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:58:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7511C19C0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 13:58:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-TU_RwXfeOCir53l4hE-8bg-1; Wed, 19 Oct 2022 21:58:19 +0100
X-MC-Unique: TU_RwXfeOCir53l4hE-8bg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Oct
 2022 21:58:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 19 Oct 2022 21:58:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHY4/SnObmw28AtX0ic5yIlEoAaH64WMdrw
Date:   Wed, 19 Oct 2022 20:58:18 +0000
Message-ID: <191893d857c44b71abf19cce3d77956a@AcuMS.aculab.com>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
In-Reply-To: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgT2N0b2JlciAyMDIyIDIwOjU0DQo+IA0K
PiBPbiBXZWQsIE9jdCAxOSwgMjAyMiBhdCA5OjI3IEFNIEphc29uIEEuIERvbmVuZmVsZCA8SmFz
b25AengyYzQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNvIGxldCdzIGp1c3QgZWxpbWluYXRlIHRo
aXMgcGFydGljdWxhciB2YXJpZXR5IG9mIGhlaXNlbnNpZ25lZCBidWdzDQo+ID4gZW50aXJlbHku
IFNldCBgLWZzaWduZWQtY2hhcmAgZ2xvYmFsbHksIHNvIHRoYXQgZ2NjIG1ha2VzIHRoZSB0eXBl
DQo+ID4gc2lnbmVkIG9uIGFsbCBhcmNoaXRlY3R1cmVzLg0KPiANCj4gQnR3LCBJIGRvIHdvbmRl
ciBpZiB3ZSBtaWdodCBhY3R1YWxseSBiZSBiZXR0ZXIgb2ZmIGRvaW5nIHRoaXMgLSBidXQNCj4g
ZG9pbmcgaXQgdGhlIG90aGVyIHdheSBhcm91bmQuDQo+IA0KPiBJT1csIG1ha2UgJ2NoYXInIGFs
d2F5cyBVTnNpZ25lZC4gVW5saWtlIHRoZSBzaWduZWQgY2hhciB0aGluZywgaXQNCj4gc2hvdWxk
bid0IGdlbmVyYXRlIGFueSB3b3JzZSBjb2RlIG9uIGFueSBjb21tb24gYXJjaGl0ZWN0dXJlLg0K
PiANCj4gQW5kIEkgZG8gdGhpbmsgdGhhdCBoYXZpbmcgb2RkIGFyY2hpdGVjdHVyZSBkaWZmZXJl
bmNlcyBpcyBnZW5lcmFsbHkgYQ0KPiBiYWQgaWRlYSwgYW5kIG1ha2luZyB0aGUgbGFuZ3VhZ2Ug
cnVsZXMgc3RyaWN0ZXIgdG8gYXZvaWQgZGlmZmVyZW5jZXMNCj4gaXMgYSBnb29kIHRoaW5nLg0K
PiANCj4gTm93LCB5b3UgZGlkICctZnNpZ25lZC1jaGFyJywgYmVjYXVzZSB0aGF0J3MgdGhlICJj
b21tb24gZGVmYXVsdCIgaW4NCj4gYW4geDg2LWNlbnRyaWMgd29ybGQuDQoNCkknbSBwcmV0dHkg
c3VyZSBjaGFyIGlzIHNpZ25lZCBiZWNhdXNlIHRoZSBwZHAxMSBvbmx5IGhhZA0Kc2lnbi1leHRl
bmRpbmcgYnl0ZSBsb2Fkcy4NCg0KPiBZb3UgYXJlIGFsc28gcmlnaHQgdGhhdCBwZW9wbGUgbWln
aHQgdGhpbmsgdGhhdCAiY2hhciIgd29ya3MgbGlrZQ0KPiAiaW50IiwgYW5kIHRoYXQgaWYgeW91
IGRvbid0IHNwZWNpZnkgdGhlIHNpZ24sIGl0J3Mgc2lnbmVkLg0KDQpCdXQgZXZlbiAndW5zaWdu
ZWQgY2hhcicgd29ya3MgbGlrZSBpbnQuDQpUaGUgdmFsdWVzIGFyZSBwcm9tb3RlZCB0byBpbnQg
KHRoYW5rcyB0byB0aGUgYnJhaW4tZGVhZCBBTlNJLUMNCmNvbW1pdHRlZSkgcmF0aGVyIHRoYW4g
dW5zaWduZWQgaW50ICh3aGljaCBJIHRoaW5rIHdhcyBpbiBLJlIgQykuDQooVGhlcmUgaXMgYW4g
ZXhjZXB0aW9uLCBpbnQsIHNob3J0IGFuZCBjaGFyIGNhbiBhbGwgYmUgdGhlIHNhbWUgc2l6ZS4N
CkluIHdoaWNoIGNhc2UgdW5zaWduZWQgY2hhciBwcm9tb3RlcyB0byB1bnNpZ25lZCBpbnQuKQ0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

