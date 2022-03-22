Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2687B4E491F
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 23:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbiCVW06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 18:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCVW06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 18:26:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DEA35FDA
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 15:25:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-221-L8WDj-BAPC6RzW_zt8-M0Q-1; Tue, 22 Mar 2022 22:25:25 +0000
X-MC-Unique: L8WDj-BAPC6RzW_zt8-M0Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 22:25:24 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 22:25:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        "Borislav Petkov" <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: RE: [PATCH v1] random: block in /dev/urandom
Thread-Topic: [PATCH v1] random: block in /dev/urandom
Thread-Index: AQHYPjdo5DS5O+F7vE+Syg0/IRbshqzL+ctg
Date:   Tue, 22 Mar 2022 22:25:24 +0000
Message-ID: <2f2e90625940400da2d208cd3f52f55d@AcuMS.aculab.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net> <YjoUU+8zrzB02pW7@sirena.org.uk>
 <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
In-Reply-To: <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
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

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAyMiBNYXJjaCAyMDIyIDIxOjU0DQo+IA0KPiBP
biAzLzIyLzIyIDExOjI0LCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWFyIDIyLCAy
MDIyIGF0IDA4OjU4OjIwQU0gLTA3MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+ID4NCj4gPj4g
VGhpcyBwYXRjaCAob3IgYSBsYXRlciB2ZXJzaW9uIG9mIGl0KSBtYWRlIGl0IGludG8gbWFpbmxp
bmUgYW5kIGNhdXNlcyBhDQo+ID4+IGxhcmdlIG51bWJlciBvZiBxZW11IGJvb3QgdGVzdCBmYWls
dXJlcyBmb3IgdmFyaW91cyBhcmNoaXRlY3R1cmVzIChhcm0sDQo+ID4+IG02OGssIG1pY3JvYmxh
emUsIHNwYXJjMzIsIHh0ZW5zYSBhcmUgdGhlIG9uZXMgSSBvYnNlcnZlZCkuIENvbW1vbg0KPiA+
PiBkZW5vbWluYXRvciBpcyB0aGF0IGJvb3QgaGFuZ3MgYXQgIlNhdmluZyByYW5kb20gc2VlZDoi
LiBBIHNhbXBsZSBiaXNlY3QNCj4gPj4gbG9nIGlzIGF0dGFjaGVkLiBSZXZlcnRpbmcgdGhpcyBw
YXRjaCBmaXhlcyB0aGUgcHJvYmxlbS4NCj4gPg0KPiA+IEp1c3QgYXMgYSBkYXRhcG9pbnQgZm9y
IGRlYnVnZ2luZyBhdCBsZWFzdCBxZW11L2FybSBpcyBnZXR0aW5nIGNvdmVyYWdlDQo+ID4gaW4g
Q0kgc3lzdGVtcyAoS2VybmVsQ0kgaXMgY292ZXJpbmcgYSBidW5jaCBvZiBkaWZmZXJlbnQgZW11
bGF0ZWQNCj4gPiBtYWNoaW5lcyBhbmQgTEtGVCBoYXMgYXQgbGVhc3Qgb25lIGNvbmZpZ3VyYXRp
b24gYXMgd2VsbCwgY2xhbmcncyB0ZXN0cw0KPiA+IGhhdmUgc29tZSB3aWRlciBhcmNoaXRlY3R1
cmUgY292ZXJhZ2UgYXMgd2VsbCBJIHRoaW5rKSBhbmQgdGhleSBkb24ndA0KPiA+IHNlZW0gdG8g
YmUgc2VlaW5nIGFueSBwcm9ibGVtcyAtIHRoZXJlJ3Mgc29tZSBvdGhlciB2YXJpYWJsZSBpbiB0
aGVyZS4NCj4gPg0KPiA+IEZvciBleGFtcGxlIGN1cnJlbnQgYmFzaWMgYm9vdCB0ZXN0cyBmb3Ig
S2VybmVsQ0kgYXJlIGF0Og0KPiA+DQo+ID4gICAgIGh0dHBzOi8vbGludXgua2VybmVsY2kub3Jn
L3Rlc3Qvam9iL21haW5saW5lL2JyYW5jaC9tYXN0ZXIva2VybmVsL3Y1LjE3LTE0NDItDQo+IGdi
NDdkNWE0ZjZiOGQvcGxhbi9iYXNlbGluZS8NCj4gPg0KPiA+IGZvciBtYWlubGluZSBhbmQgLW5l
eHQgaGFzOg0KPiA+DQo+ID4gICAgIGh0dHBzOi8vbGludXgua2VybmVsY2kub3JnL3Rlc3Qvam9i
L25leHQvYnJhbmNoL21hc3Rlci9rZXJuZWwvbmV4dC0yMDIyMDMyMi9wbGFuL2Jhc2VsaW5lLw0K
PiA+DQo+ID4gVGhlc2UgYXJlIHdpdGggYSBidWlsZHJvb3QgYmFzZWQgcm9vdGZzIHRoYXQgaGFz
IGEgIlNhdmluZyByYW5kb20gc2VlZDogIg0KPiA+IHN0ZXAgaW4gdGhlIGJvb3QgcHJvY2VzcyBG
V0lXLg0KPiANCj4gSSB1c2UgYnVpbGRyb290IDIwMjEuMDIuMy4gSSBoYXZlIG5vdCBjaGFuZ2Vk
IHRoZSBidWlsZHJvb3QgY29kZSwgYW5kIGl0DQo+IHN0aWxsIHNlZW1zIHRvIGJlIHRoZSBzYW1l
IGluIDIwMjIuMDIuIEkgZG9uJ3Qgc2VlIHRoZSBwcm9ibGVtIHdpdGggYWxsDQo+IGJvb3QgdGVz
dHMsIG9ubHkgd2l0aCB0aGUgYXJjaGl0ZWN0dXJlcyBtZW50aW9uZWQgYWJvdmUsIGFuZCBub3Qg
d2l0aCBhbGwNCj4gcWVtdSBtYWNoaW5lcyBvbiB0aGUgYWZmZWN0ZWQgcGxhdGZvcm1zLiBGb3Ig
YXJtLCBtb3N0bHkgb2xkZXIgbWFjaGluZXMNCj4gYXJlIGFmZmVjdGVkICh2ZXJzYXRpbGUsIHJl
YWx2aWV3LCBweGEgY29uZmlndXJhdGlvbnMsIGNvbGxpZSwgaW50ZWdyYXRvcmNwLA0KPiBzeDEs
IG1wczItYW4zODUsIHZleHByZXNzLWE5LCBjdWJpZWJvYXJkKS4gSSBkaWRuJ3QgY2hlY2ssIGJ1
dCBtYXliZQ0KPiBrZXJuZWxjaSBkb2Vzbid0IHRlc3QgdGhvc2UgbWFjaGluZXMgPw0KDQpJIHdh
cyB0cnlpbmcgdG8gZml4IHRoZSBidWlsZHJvb3Qgc2F2ZS9yZXN0b3JlIHJhbmRvbSBzZWVkIG9m
IGEgc3lzdGVtDQpvZiBtaW5lLg0KSSB0aG91Z2h0IEknZCBmaXhlZCBpdCAtIG5lZWRlZCB0byB1
c2UgYSBwZXJzaXN0ZW50IGZpbGVzeXN0ZW0uDQpCdXQgSSBjYW4ndCBnZXQgcmlkIG9mIHRoZSAn
dW5pbml0aWFsaXNlZCByYW5kb20gcmVhZCcgbWVzc2FnZXMuDQooV2hpY2ggSSBleHBlY3RlZCB0
byBnbyBhd2F5IGFmdGVyIHdyaXRpbmcgdGhlIHNlZWQuKQ0KQnV0IGEgcXVpY2sgbG9vayBhdCB0
aGUga2VybmVsIGNvZGUgZGlkbid0IHNlZW0gdG8gY3JlZGl0IHRoZQ0Kd3JpdGUgaW50byB0aGUg
Y29ycmVjdCBsb2dpYy4NCkkgZGlkbid0IGNoZWNrIHdoZXRoZXIgdGhlIGRhdGEgYWN0dWFsbHkg
Z290IHVzZWQgdGhvdWdoLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

