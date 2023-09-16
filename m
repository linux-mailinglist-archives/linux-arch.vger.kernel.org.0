Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2A7A2F0A
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjIPJdW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Sep 2023 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjIPJcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Sep 2023 05:32:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ABE2173B
        for <linux-arch@vger.kernel.org>; Sat, 16 Sep 2023 02:32:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-244-9HYSYDoAOBG_m3lja_VXfg-1; Sat, 16 Sep 2023 10:32:44 +0100
X-MC-Unique: 9HYSYDoAOBG_m3lja_VXfg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 16 Sep
 2023 10:32:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 16 Sep 2023 10:32:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v6 3/4] riscv: Add checksum library
Thread-Topic: [PATCH v6 3/4] riscv: Add checksum library
Thread-Index: AQHZ5/ZuR2Nhj94ZDEWquHSBL7yNdbAdI/3w
Date:   Sat, 16 Sep 2023 09:32:40 +0000
Message-ID: <0357e092c05043fba13eccad77ba799f@AcuMS.aculab.com>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
 <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
In-Reply-To: <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQ2hhcmxpZSBKZW5raW5zDQo+IFNlbnQ6IDE1IFNlcHRlbWJlciAyMDIzIDE4OjAxDQo+
IA0KPiBQcm92aWRlIGEgMzIgYW5kIDY0IGJpdCB2ZXJzaW9uIG9mIGRvX2NzdW0uIFdoZW4gY29t
cGlsZWQgZm9yIDMyLWJpdA0KPiB3aWxsIGxvYWQgZnJvbSB0aGUgYnVmZmVyIGluIGdyb3VwcyBv
ZiAzMiBiaXRzLCBhbmQgd2hlbiBjb21waWxlZCBmb3INCj4gNjQtYml0IHdpbGwgbG9hZCBpbiBn
cm91cHMgb2YgNjQgYml0cy4NCj4gDQouLi4NCj4gKwkvKg0KPiArCSAqIERvIDMyLWJpdCByZWFk
cyBvbiBSVjMyIGFuZCA2NC1iaXQgcmVhZHMgb3RoZXJ3aXNlLiBUaGlzIHNob3VsZCBiZQ0KPiAr
CSAqIGZhc3RlciB0aGFuIGRvaW5nIDMyLWJpdCByZWFkcyBvbiBhcmNoaXRlY3R1cmVzIHRoYXQg
c3VwcG9ydCBsYXJnZXINCj4gKwkgKiByZWFkcy4NCj4gKwkgKi8NCj4gKwl3aGlsZSAobGVuID4g
MCkgew0KPiArCQljc3VtICs9IGRhdGE7DQo+ICsJCWNzdW0gKz0gY3N1bSA8IGRhdGE7DQo+ICsJ
CWxlbiAtPSBzaXplb2YodW5zaWduZWQgbG9uZyk7DQo+ICsJCXB0ciArPSAxOw0KPiArCQlkYXRh
ID0gKnB0cjsNCj4gKwl9DQoNCkkgdGhpbmsgeW91J2QgYmUgYmV0dGVyIGFkZGluZyB0aGUgJ2Nh
cnJ5JyBiaXRzIGluIGEgc2VwYXJhdGUNCnZhcmlhYmxlLg0KSXQgcmVkdWNlcyB0aGUgcmVnaXN0
ZXIgZGVwZW5kZW5jeSBjaGFpbiBsZW5ndGggaW4gdGhlIGxvb3AuDQooSGVscHMgaWYgdGhlIGNw
dSBjYW4gZXhlY3V0ZSB0d28gaW5zdHJ1Y3Rpb25zIGluIG9uZSBjbG9jay4pDQoNClRoZSBtYXNr
ZWQgbWlzYWxpZ25lZCBkYXRhIHZhbHVlcyBhcmUgbWF4IDI0IGJpdHMNCihpZiANCg0KWW91J2xs
IGFsc28gYWxtb3N0IGNlcnRhaW5seSByZW1vdmUgYXQgbGVhc3Qgb25lIGluc3RydWN0aW9uDQpm
cm9tIHRoZSBsb29wIGJ5IGNvbXBhcmluZyBhZ2FpbnN0IHRoZSBlbmQgYWRkcmVzcyByYXRoZXIg
dGhhbg0KY2hhbmdpbmcgJ2xlbicuDQoNClNvIGVuZGluZyB1cCB3aXRoIChzb21ldGhpbmcgbGlr
ZSk6DQoJZW5kID0gYnVmZiArIGxlbmd0aDsNCgkuLi4NCgl3aGlsZSAoKytwdHIgPCBlbmQpIHsN
CgkJY3N1bSArPSBkYXRhOw0KCQljYXJyeSArPSBjc3VtIDwgZGF0YTsNCgkJZGF0YSA9IHB0clst
MV07DQoJfQ0KKEFsdGhvdWdoIGEgZG8td2hpbGUgbG9vcCB0ZW5kcyB0byBnZW5lcmF0ZSBiZXR0
ZXIgY29kZQ0KYW5kIGdjYyB3aWxsIHByZXR0eSBtdWNoIGFsd2F5cyBtYWtlIHRoYXQgdHJhbnNm
b3JtYXRpb24uKQ0KDQpJIHRoaW5rIHRoYXQgaXMgNCBpbnN0cnVjdGlvbnMgcGVyIHdvcmQgKGxv
YWQsIGFkZCwgY21wK3NldCwgYWRkKS4NCkluIHByaW5jaXBsZSB0aGV5IGNvdWxkIGJlIGNvbXBs
ZXRlbHkgcGlwZWxpbmVkIGFuZCBhbGwNCmV4ZWN1dGUgKGZvciBkaWZmZXJlbnQgbG9vcCBpdGVy
YXRpb25zKSBpbiB0aGUgc2FtZSBjbG9jay4NCihCdXQgdGhhdCBpcyBwcmV0dHkgdW5saWtlbHkg
dG8gaGFwcGVuIC0gZXZlbiB4ODYgaXNuJ3QgdGhhdCBnb29kLikNCkJ1dCB0YWtpbmcgdHdvIGNs
b2NrcyBpcyBxdWl0ZSBwbGF1c2libGUuDQpQbHVzIDIgaW5zdHJ1Y3Rpb25zIHBlciBsb29wIChp
bmMsIGNtcCtqbXApLg0KVGhleSBtaWdodCBleGVjdXRlIGluIHBhcmFsbGVsLCBidXQgdW5yb2xs
aW5nIG9uY2UNCm1heSBiZSByZXF1aXJlZC4NCg0KLi4uDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09O
RklHX1JJU0NWX0lTQV9aQkIpICYmDQo+ICsJICAgIHJpc2N2X2hhc19leHRlbnNpb25fbGlrZWx5
KFJJU0NWX0lTQV9FWFRfWkJCKSkgew0KLi4uDQo+ICsJCX0NCj4gK2VuZDoNCj4gKwkJcmV0dXJu
IGNzdW0gPj4gMTY7DQo+ICsJfQ0KDQpJcyBpdCByZWFsbHkgd29ydGggZG9pbmcgYWxsIHRoYXQg
dG8gc2F2ZSAoSSB0aGluaykgNCBpbnN0cnVjdGlvbnM/DQooc2hpZnQsIHNoaWZ0LCBvciB3aXRo
IHJvdGF0ZSB0d2ljZSkuDQpUaGVyZSBpcyBtdWNoIG1vcmUgdG8gYmUgZ2FpbmVkIGJ5IGNhcmVm
dWwgaW5zcGVjdGlvbg0Kb2YgdGhlIGxvb3AgKGV2ZW4gbGVhdmluZyBpdCBpbiBDKS4NCg0KPiAr
DQo+ICsjaWZuZGVmIENPTkZJR18zMkJJVA0KPiArCWNzdW0gKz0gKGNzdW0gPj4gMzIpIHwgKGNz
dW0gPDwgMzIpOw0KPiArCWNzdW0gPj49IDMyOw0KPiArI2VuZGlmDQo+ICsJY3N1bSA9ICh1bnNp
Z25lZCBpbnQpY3N1bSArICgoKHVuc2lnbmVkIGludCljc3VtID4+IDE2KSB8ICgodW5zaWduZWQg
aW50KWNzdW0gPDwgMTYpKTsNCg0KVXNlIHJvcjY0KCkgYW5kIHJvcjMyKCkuDQoNCglEYXZpZA0K
DQo+ICsJaWYgKG9mZnNldCAmIDEpDQo+ICsJCXJldHVybiAodW5zaWduZWQgc2hvcnQpc3dhYjMy
KGNzdW0pOw0KPiArCXJldHVybiBjc3VtID4+IDE2Ow0KPiArfQ0KPiANCj4gLS0NCj4gMi40Mi4w
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

