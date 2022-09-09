Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCB5B2FCE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIIHaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 03:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIIHap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 03:30:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22AEC6E9E
        for <linux-arch@vger.kernel.org>; Fri,  9 Sep 2022 00:30:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-2rEwkm9hOGSozGWzT6J91w-1; Fri, 09 Sep 2022 08:30:39 +0100
X-MC-Unique: 2rEwkm9hOGSozGWzT6J91w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 9 Sep
 2022 08:30:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 9 Sep 2022 08:30:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "guoren@kernel.org" <guoren@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jszhang@kernel.org" <jszhang@kernel.org>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "falcon@tinylab.org" <falcon@tinylab.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: RE: [PATCH V4 6/8] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Thread-Topic: [PATCH V4 6/8] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Thread-Index: AQHYw51MXnnvxJJMF0u4mqq9TNC6Qa3Wsk0g
Date:   Fri, 9 Sep 2022 07:30:30 +0000
Message-ID: <0ff315c978d24215b00c42df51f51b2d@AcuMS.aculab.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-7-guoren@kernel.org> <YxoTdxk772vneG53@linutronix.de>
In-Reply-To: <YxoTdxk772vneG53@linutronix.de>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiBTZW50OiAwOCBTZXB0ZW1iZXIgMjAy
MiAxNzowOA0KPiANCj4gT24gMjAyMi0wOS0wNyAyMjoyNTowNCBbLTA0MDBdLCBndW9yZW5Aa2Vy
bmVsLm9yZyB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnIGIvYXJj
aC9yaXNjdi9LY29uZmlnDQo+ID4gaW5kZXggYTA3YmIzYjczYjViLi5hOGExMmI0YmExYTkgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9L
Y29uZmlnDQo+ID4gQEAgLTQzMyw2ICs0MzMsMTQgQEAgY29uZmlnIEZQVQ0KPiA+DQo+ID4gIAkg
IElmIHlvdSBkb24ndCBrbm93IHdoYXQgdG8gZG8gaGVyZSwgc2F5IFkuDQo+ID4NCj4gPiArY29u
ZmlnIElSUV9TVEFDS1MNCj4gPiArCWJvb2wgIkluZGVwZW5kZW50IGlycSBzdGFja3MiDQo+ID4g
KwlkZWZhdWx0IHkNCj4gPiArCXNlbGVjdCBIQVZFX0lSUV9FWElUX09OX0lSUV9TVEFDSw0KPiA+
ICsJaGVscA0KPiA+ICsJICBBZGQgaW5kZXBlbmRlbnQgaXJxIHN0YWNrcyBmb3IgcGVyY3B1IHRv
IHByZXZlbnQga2VybmVsIHN0YWNrIG92ZXJmbG93cy4NCj4gPiArCSAgV2UgbWF5IHNhdmUgc29t
ZSBtZW1vcnkgZm9vdHByaW50IGJ5IGRpc2FibGluZyBJUlFfU1RBQ0tTLg0KPiANCj4gRG8geW91
IHJlYWxseSB0aGluayB0aGF0IGl0IGlzIG5lZWRlZCB0byBzYXZlIG1lbW9yeSBoZXJlPyBBdm9p
ZGluZw0KPiBzdGFjayBvdmVyZmxvd3MgaW4gZGVlcCBjYWxsIGNoYWlucyBpcyBwcm9iYWJseSBt
b3JlIGltcG9ydGFudCB0aGFuDQo+IHNhdmluZyB+OEtpQiBwZXIgQ1BVLg0KDQpQYXJ0aWN1bGFy
bHkgaWYgYSA2NGJpdCBidWlsZCBpcyB1c2luZyBzbWFsbCBzdGFja3MuDQoNCldpdGhvdXQgc3Rh
dGljIGFuYWx5c2lzIG9mIGFjdHVhbCBjYWxsIGNoYWluIGRlcHRoIGl0IGlzDQpyZWFsbHkgZGlm
ZmljdWx0IHRvIHRyaW0gdGhlIHN0YWNrIHNpemUuDQoNCkknZCBiZXQgKGEgZmV3IGJlZXJzKSB0
aGF0IHRoZSBkZWVwZXN0IHN0YWNrIHVzZSBpbiBpbnNpZGUNCnRoZSBjb25zb2xlIHByaW50IGNv
ZGUgZm9ybSBhIHByaW50aygpIChlZyB3YXJuX29uX29uY2UpDQppbiBhbiBvYnNjdXJlIGVycm9y
IHBhdGggc29tZXdoZXJlLg0KVGhpcyB3b24ndCBiZSBoaXQgZHVyaW5nIGFueSBub3JtYWwgdGVz
dGluZy4NCg0KSSB0aGluayB0aGF0IHRoZSBhbmFseXNpcyBvYmp0b29sIGRvZXMgaXMgZ2V0dGlu
ZyBjbG9zZQ0KdG8gYmUgYWJsZSB0byBnZW5lcmF0ZSB0aGUgcmF3IGRhdGEgdGhhdCBjYW4gYmUg
dXNlZCBmb3INCnN0YXRpYyBzdGFjayBkZXB0aCBhbmFseXNpcy4NCllvdSBuZWVkIHRoZSAnQ0ZJ
JyBjb25zdGFudHMgZm9yIGluZGlyZWN0IGNhbGxzIGFuZA0Kc29tZSBhc3N1bXB0aW9ucyBhYm91
dCBkZXB0aCBvZiByZWN1cnNpdmUgY2FsbHMuDQpCdXQgYXBhcnQgZnJvbSB0aGF0IHRoZSBjb2Rl
IHRvIHByb2Nlc3MgdGhlIHJhdyBvdXRwdXQNCmlzbid0IHRoYXQgY29tcGxleC4NCg0KQSBuaWNl
IHRhc2sgZm9yIHNvbWVvbmUgd2l0aCBzb21lIHNwYXJlIHRpbWUuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

