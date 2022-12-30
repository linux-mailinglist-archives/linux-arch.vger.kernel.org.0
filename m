Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49306597CD
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiL3Ljo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 06:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiL3Ljm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 06:39:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E81ADA8
        for <linux-arch@vger.kernel.org>; Fri, 30 Dec 2022 03:39:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-WrOCWDbRMD26Er3ijSrmqw-1; Fri, 30 Dec 2022 11:39:37 +0000
X-MC-Unique: WrOCWDbRMD26Er3ijSrmqw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Dec
 2022 11:39:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 30 Dec 2022 11:39:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Holger Lubitz' <holger.lubitz@t-online.de>,
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
Thread-Index: AQHZFV6o8tF/XYcvI0qqEtVNYsUlXa55tQ3wgAMV4YCACXsZ8A==
Date:   Fri, 30 Dec 2022 11:39:35 +0000
Message-ID: <357cbd67260040e4bcf17d519aaafdcb@AcuMS.aculab.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
         <20221019203034.3795710-1-Jason@zx2c4.com>
         <20221221145332.GA2399037@roeck-us.net>
         <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
         <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
         <20221221155641.GB2468105@roeck-us.net>
         <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
         <b2144334261246aa8dc5004c5f1a58c9@AcuMS.aculab.com>
 <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
In-Reply-To: <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
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

RnJvbTogSG9sZ2VyIEx1Yml0eg0KPiBTZW50OiAyNCBEZWNlbWJlciAyMDIyIDA5OjM0DQo+IA0K
PiBPbiBUaHUsIDIwMjItMTItMjIgYXQgMTA6NDEgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToN
Cj4gPiBJIHdvbmRlciBob3cgbXVjaCBzbG93ZXIgaXQgaXMgLSBtNjhrIGlzIGxpa2VseSB0byBi
ZSBtaWNyb2NvZGVkDQo+ID4gYW5kIEkgZG9uJ3QgdGhpbmsgaW5zdHJ1Y3Rpb24gdGltaW5ncyBh
cmUgYWN0dWFsbHkgYXZhaWxhYmxlLg0KPiANCj4gTm90IHN1cmUgaWYgdGhlc2UgYXJlIGluIGFu
eSB3YXkgb2ZmaWNpYWwsIGJ1dA0KPiBodHRwOi8vb2xkd3d3Lm52Zy5udG51Lm5vL2FtaWdhL01D
NjgweDBfU2VjdGlvbnMvbWM2ODAzMHRpbWluZy5IVE1MDQoNCkkgdGhvdWdodCBhYm91dCB0aGF0
IHNvbWUgbW9yZSBhbmQgcmVtZW1iZXIgc2VlaW5nIG1lbW9yeSB0aW1pbmdzDQpvbiBhIGxvZ2lj
IGFuYWx5c2VyIC0gYW5kIGdldHRpbmcgdGltaW5ncyB0aGF0IChtb3JlIG9yIGxlc3MpDQppbXBs
aWVkIHNlcXVlbnRpYWwgZXhlY3V0aW9uIGxpbWl0ZWQgYnkgdGhlIG9idmlvdXMgbWVtb3J5IChj
YWNoZSkNCmFjY2Vzc2VzLg0KDQpUaGUgbWljcm9jb2RpbmcgaXMgbW9yZSBhcHBhcmVudCBpbiB0
aGUgbGFyZ2UgbWlkLWluc3RydWN0aW9uDQppbnRlcnJ1cHQgc3RhY2sgZnJhbWVzIC0gZWcgZm9y
IHBhZ2UgZmF1bHRzLg0KDQoNCj4gDQo+IChUaGVyZSdzIGFsc28NCj4gaHR0cDovL29sZHd3dy5u
dmcubnRudS5uby9hbWlnYS9NQzY4MHgwX1NlY3Rpb25zL21jNjgwMDB0aW1pbmcuSFRNTA0KPiBi
dXQgdGhhdCBpcyBwcm9iYWJseSBvbmx5IGludGVyZXN0aW5nIHRvIGRlbW8gY29kZXJzIGJ5IG5v
dykNCj4gDQo+ID4gVGhlIGZhc3Rlc3QgdmVyc2lvbiBwcm9iYWJseSB1c2VzIHN1YnggKHdpdGgg
Y2FycnkpIHRvIGdlbmVyYXRlDQo+ID4gMC8tMSBhbmQgbGVhdmVzICtkZWx0YSBmb3IgdGhlIG90
aGVyIHJlc3VsdCAtIGJ1dCBnZXR0aW5nIHRoZQ0KPiA+IGNvbXBhcmVzIGFuZCBicmFuY2hlcyBp
biB0aGUgcmlnaHQgb3JkZXIgaXMgaGFyZC4NCj4gDQo+IEd1ZXNzIGl0IG11c3QgaGF2ZSBiZWVu
IG92ZXIgMjAgeWVhcnMgc2luY2UgSSB3cm90ZSBhbnkgNjhrIGFzbSwgYnV0DQo+IG5vdyBJIGFj
dHVhbGx5IGVuZGVkIHVwIGluc3RhbGxpbmcgRGViaWFuIG9uIHFlbXUgdG8gZXhwZXJpbWVudC4N
Cj4gDQo+IFRoZXJlIGFyZSB0d28gaW50ZXJlc3RpbmcgZGlmZmVyZW5jZXMgYmV0d2VlbiA2OGsg
YW5kIHg4NiB0aGF0IGNhbiBiZQ0KPiB1c2VmdWwgaGVyZTogVW5saWtlIHg4NiwgTU9WIG9uIDY4
ayBzZXRzIHRoZSBmbGFncy4gQW5kIGFsc28sIHN1YngNCj4gZGlmZmVycyBmcm9tIHNiYiBpbiB0
aGF0IGl0IHJlc2V0cyB0aGUgemVybyBmbGFnIG9uIGEgbm9uLXplcm8gcmVzdWx0LA0KPiBidXQg
ZG9lcyBub3Qgc2V0IGl0IG9uIGEgemVybyByZXN1bHQuIFNvIGlmIGl0IGlzIHNldCwgaXQgbXVz
dCBoYXZlDQo+IGJlZW4gc2V0IGJlZm9yZS4NCj4gDQo+IEhlcmUgYXJlIHRoZSB0d28gZnVuY3Rp
b25zIEkgY2FtZSB1cCB3aXRoICh0ZXN0ZWQgb25seSBzdGFuZC1hbG9uZSwgbm90DQo+IGluIGEg
a2VybmVsIGJ1aWxkLiBBbHNvIG5vIGJlbmNobWFya3MgYmVjYXVzZSB0aGlzIDY4MDQwIGlzIG9u
bHkNCj4gZW11bGF0ZWQpDQo+ICMxIChvcHRpbWl6ZWQgZm9yIG1pbmltdW0gaW5zdHJ1Y3Rpb24g
Y291bnQgaW4gbG9vcCwNCj4gICAgIDY4ayArIENvbGRmaXJlIElTQV9CKQ0KPiANCj4gaW50IHN0
cmNtcDEoY29uc3QgY2hhciAqY3MsIGNvbnN0IGNoYXIgKmN0KQ0KPiB7DQo+ICAgICAgICAgaW50
IHJlczsNCj4gDQo+ICAgICAgICAgYXNtICgiXG4iDQo+ICAgICAgICAgICAgICAgICAiMTogbW92
ZS5iICAoJTApKywlMlxuIiAgLyogZ2V0ICpjcyAqLw0KPiAgICAgICAgICAgICAgICAgIiAgIGpl
cSAgICAgMmZcbiIgICAgICAgIC8qIGVuZCBvZiBmaXJzdCBzdHJpbmc/ICovDQo+ICAgICAgICAg
ICAgICAgICAiICAgY21wLmIgICAoJTEpKywlMlxuIiAgLyogY29tcGFyZSAqY3QgKi8NCj4gICAg
ICAgICAgICAgICAgICIgICBqZXEgICAgIDFiXG4iICAgICAgICAvKiBpZiBlcXVhbCwgY29udGlu
dWUgKi8NCj4gICAgICAgICAgICAgICAgICIgICBqcmEgICAgIDNmXG4iICAgICAgICAvKiBlbHNl
IHNraXAgdG8gdGFpbCAqLw0KPiAgICAgICAgICAgICAgICAgIjI6IGNtcC5iICAgKCUxKSssJTJc
biIgIC8qIGNvbXBhcmUgb25lIGxhc3QgYnl0ZSAqLw0KPiAgICAgICAgICAgICAgICAgIjM6IHN1
YngubCAgJTIsICUyXG4iICAgIC8qIC0xIGlmIGJvcnJvdywgMCBpZiBub3QgKi8NCj4gICAgICAg
ICAgICAgICAgICIgICBqbHMgICAgIDRmXG4iICAgICAgICAvKiBpZiBzZXQsIHogaXMgZnJvbSBz
dWIuYiAqLw0KDQpUaGUgc3VieCB3aWxsIHNldCBaIHVubGVzcyBDIHdhcyBzZXQuDQpTbyB0aGF0
IGRvZXNuJ3Qgc2VlbSByaWdodC4NCg0KPiAgICAgICAgICAgICAgICAgIiAgIG1vdmVxLmwgIzEs
ICUyXG4iICAgIC8qIDEgaWYgIWJvcnJvdyAgKi8NCj4gICAgICAgICAgICAgICAgICI0OiINCj4g
ICAgICAgICAgICAgICAgIDogIithIiAoY3MpLCAiK2EiIChjdCksICI9ZCIgKHJlcykpOw0KPiAg
ICAgICAgIHJldHVybiByZXM7DQo+IH0NCg0KSSB0aGluayB0aGlzIHNob3VsZCB3b3JrOg0KKEJ1
dCB0aGUgamMgbWlnaHQgbmVlZCB0byBiZSBqbmMuKQ0KDQogICAgICAgICAgICAgICAgICIgICBt
b3ZlcS5sICMwLCUyXG4iICAgICAvKiB6ZXJvIGhpZ2ggYml0cyBvZiByZXN1bHQgKi8NCiAgICAg
ICAgICAgICAgICAgIjE6IG1vdmUuYiAgKCUxKSssJTJcbiIgIC8qIGdldCAqY3QgKi8NCiAgICAg
ICAgICAgICAgICAgIiAgIGplcSAgICAgMmZcbiIgICAgICAgIC8qIGVuZCBvZiBzZWNvbmQgc3Ry
aW5nPyAqLw0KICAgICAgICAgICAgICAgICAiICAgY21wLmIgICAoJTApKywlMlxuIiAgLyogY29t
cGFyZSAqY3MgKi8NCiAgICAgICAgICAgICAgICAgIiAgIGplcSAgICAgMWJcbiIgICAgICAgIC8q
IGlmIGVxdWFsLCBjb250aW51ZSAqLw0KICAgICAgICAgICAgICAgICAiICAgamMgICAgICA0ZiAg
ICAgICAgICAgLyogcmV0dXJuICt2ZSAqLw0KICAgICAgICAgICAgICAgICAiICAgbW92ZXEubCAj
LTEsICUyXG4iICAgLyogcmV0dXJuIC12ZSAqLw0KICAgICAgICAgICAgICAgICAiICAganJhICAg
ICA0ZlxuIg0KICAgICAgICAgICAgICAgICAiMjogbW92ZS5iICAoJTApLCUyXG4iICAgLyogY2hl
Y2sgZm9yIG1hdGNoaW5nIHN0cmluZ3MgKi8NCiAgICAgICAgICAgICAgICAgIjQ6Ig0KDQoNCj4g
IzIgKG9wdGltaXplZCBmb3IgbWluaW11bSBjb2RlIHNpemUsDQo+ICAgICBDb2xkZmlyZSBJU0Ff
QSBjb21wYXRpYmxlKQ0KPiANCj4gaW50IHN0cmNtcDIoY29uc3QgY2hhciAqY3MsIGNvbnN0IGNo
YXIgKmN0KQ0KPiB7DQo+ICAgICAgICAgaW50IHJlcyA9IDAsIHRtcCA9IDA7DQo+IA0KPiAgICAg
ICAgIGFzbSAoIlxuIg0KPiAgICAgICAgICAgICAgICAgIjE6IG1vdmUuYiAoJTApKywlMlxuIiAv
KiBnZXQgKmNzICovDQo+ICAgICAgICAgICAgICAgICAiICAgbW92ZS5iICglMSkrLCUzXG4iIC8q
IGdldCAqY3QgKi8NCj4gICAgICAgICAgICAgICAgICIgICBzdWJ4LmwgJTMsJTJcbiIgICAgLyog
Y29tcGFyZSBhIGJ5dGUgKi8NCj4gICAgICAgICAgICAgICAgICIgICBqZXEgICAgMmZcbiIgICAg
ICAgLyogYm90aCBpbnB1dHMgd2VyZSB6ZXJvICovDQoNClRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0
Lg0KWiB3aWxsIGJlIHNldCBpZiBlaXRoZXIgKmN0IGlzIHplcm8gb3IgdGhlIGJ5dGVzIG1hdGNo
Lg0KDQo+ICAgICAgICAgICAgICAgICAiICAgdHN0LmwgICUyXG4iICAgICAgIC8qIGNoZWNrIHJl
c3VsdCAqLw0KDQpUaGlzIG9ubHkgc2V0cyBaIHdoZW4gaXQgd2FzIGFscmVhZHkgc2V0IGJ5IHRo
ZSBzdWJ4Lg0KDQo+ICAgICAgICAgICAgICAgICAiICAgamVxICAgIDFiXG4iICAgICAgIC8qIGlm
IHplcm8sIGNvbnRpbnVlICovDQo+ICAgICAgICAgICAgICAgICAiMjoiDQo+ICAgICAgICAgICAg
ICAgICA6ICIrYSIgKGNzKSwgIithIiAoY3QpLCAiK2QiIChyZXMpLCAiK2QiICh0bXApKTsNCj4g
ICAgICAgICByZXR1cm4gcmVzOw0KPiB9DQo+IA0KPiBIb3dldmVyLCB0aGlzIG9uZSBuZWVkcyBy
ZXMgYW5kIHRtcCB0byBiZSBzZXQgdG8gemVybywgYmVjYXVzZSB3ZSByZWFkDQo+IG9ubHkgYnl0
ZXMgKG5vIGF1dG9tYXRpYyB6ZXJvLWV4dGVuZCBvbiA2OGspLCBidXQgdGhlbiBkbyBhIGxvbmcN
Cj4gb3BlcmF0aW9uIG9uIHRoZW0uIENvbGRmaXJlIElTQV9BIGRyb3BwZWQgY21wYiwgaXQgb25s
eSByZWFwcGVhcmVkIGluDQo+IElTQV9CLg0KPiANCj4gU28gdGhlIHJlYWwgaW5zdHJ1Y3Rpb24g
Y291bnQgaXMgbGlrZWx5IHRvIGJlIHR3byBtb3JlLCB1bmxlc3MgZ2NjDQo+IGhhcHBlbnMgdG8g
aGF2ZSBvbmUgb3IgdHdvIHplcm9zIGl0IGNhbiByZXVzZS4NCj4gDQo+ID4gSSBiZWxpZXZlIHNv
bWUgb2YgdGhlIG90aGVyIG02OGsgYXNtIGZ1bmN0aW9ucyBhcmUgYWxzbyBtaXNzaW5nDQo+ID4g
dGhlICJtZW1vcnkiICdjbG9iYmVyJyBhbmQgc28gY291bGQgZ2V0IG1pcy1vcHRpbWlzZWQuDQo+
IA0KPiBJbiB3aGljaCBjYXNlIHdvdWxkIHRoYXQgaGFwcGVuPyBUaGlzIGZ1bmN0aW9uIGRvZXNu
J3QgY2xvYmJlciBtZW1vcnkNCj4gYW5kIGl0cyByZXN1bHQgZG9lcyBnZXQgdXNlZC4gSWYgZ2Nj
IG1pc3Rha2VubHkgdGhpbmtzIHRoZSBwYXJhbWV0ZXJzDQo+IGhhdmVuJ3QgY2hhbmdlZCBhbmQg
dXNlcyBhIHByZXZpb3VzbHkgY2FjaGVkIHJlc3VsdCwgd291bGRuJ3QgdGhhdA0KPiBhcHBseSB0
byBhIEMgZnVuY3Rpb24gdG9vPw0KDQpZb3UgbmVlZCBhIG1lbW9yeSAnY2xvYmJlcicgb24gYW55
dGhpbmcgdGhhdCBSRUFEUyBtZW1vcnkgYXMgd2VsbA0KYXMgd3JpdGVzIGl0Lg0KDQo+ID4gV2hp
bGUgSSBjYW4gd3JpdGUgKG9yIHJhdGhlciBoYXZlIHdyaXR0ZW4pIG02OGsgYXNtIEkgZG9uJ3Qg
aGF2ZQ0KPiA+IGEgY29tcGlsZXIuDQo+IA0KPiBXZWxsLCBJIG5vdyBoYXZlIGFuIGVtdWxhdGVk
IFF1YWRyYSA4MDAgcnVubmluZyBEZWJpYW4gNjhrLihHZXR0aW5nIHRoZQ0KPiBlbXVsYXRlZCBu
ZXR3b3JraW5nIHRvIHdvcmsgcmVsaWFibHkgd2FzIGEgYml0IHByb2JsZW1hdGljLCB0aG91Z2gu
IEJ1dA0KPiBub3cgaXQgcnVucyBLZXJuZWwgNi4wKSBxZW11IGNvdWxkIGVtdWxhdGUgQ29sZGZp
cmUgdG9vLCBidXQgSSBhbSBub3QNCj4gc3VyZSB3aGVyZSBJIHdvdWxkIGZpbmQgYSBkaXN0cmli
dXRpb24gZm9yIHRoYXQuDQo+IA0KPiBJIGRpZCBub3QgYXR0YWNoIGEgcGF0Y2ggYmVjYXVzZSBp
dCBzZWVtcyBhbHJlYWR5IHRvIGJlIGRlY2lkZWQgdGhhdA0KPiB0aGUgZnVuY3Rpb24gaXMgZ29u
ZS4gQnV0IHNob3VsZCBhbnlvbmUgc3RpbGwgd2FudCB0byBpbmNsdWRlIG9uZSAob3INCj4gYm90
aCkgb2YgdGhlc2UgZnVuY3Rpb25zLCBqdXN0IGdpdmUgY3JlZGl0IHRvIG1lIGFuZCBJJ20gZmlu
ZS4NCg0KVGhpbmtpbmcgZnVydGhlciB0aGUgZmFzdGVzdCBzdHJjbXAoKSBwcm9iYWJseSB1c2Vz
IGJpZy1lbmRpYW4gd29yZCBjb21wYXJlcw0Kd2l0aCBhIGNoZWNrIGZvciBhIHplcm8gYnl0ZS4N
CkVzcGVjaWFsbHkgb24gNjQgYml0IHN5c3RlbXMgdGhhdCBzdXBwb3J0IG1pc2FsaWduZWQgbG9h
ZHMuDQpCdXQgSSdkIG5lZWQgdG8gdGhpbmsgaGFyZCBhYm91dCB0aGUgYWN0dWFsIGRldGFpbHMu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

