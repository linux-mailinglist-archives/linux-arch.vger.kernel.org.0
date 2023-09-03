Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7B790DEC
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbjICUnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjICUnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 16:43:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C894102
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 13:43:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-_YuK4C4IP2q1PYjAxiCTSA-1; Sun, 03 Sep 2023 21:43:03 +0100
X-MC-Unique: _YuK4C4IP2q1PYjAxiCTSA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 21:42:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 3 Sep 2023 21:42:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mateusz Guzik' <mjguzik@gmail.com>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Topic: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Index: AQHZ23Vdq8Esj5k0zUGYupOb09r6RrAF7nHAgAAb1ICAABQQEA==
Date:   Sun, 3 Sep 2023 20:42:55 +0000
Message-ID: <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
In-Reply-To: <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Li4uDQo+IFdoZW4gSSB3YXMgcGxheWluZyB3aXRoIHRoaXMgc3R1ZmYgYWJvdXQgNSB5ZWFycyBh
Z28gSSBmb3VuZCAzMi1ieXRlDQo+IGxvb3BzIHRvIGJlIG9wdGltYWwgZm9yIHVhcmNocyBvZiB0
aGUgcHJpb2QgKFNreWxha2UsIEJyb2Fkd2VsbCwNCj4gSGFzd2VsbCBhbmQgc28gb24pLCBidXQg
b25seSB1cCB0byBhIHBvaW50IHdoZXJlIHJlcCB3aW5zLg0KDQpEb2VzIHRoZSAncmVwIG1vdnNx
JyBldmVyIGFjdHVhbGx5IHdpbj8NCihVbmxlc3MgeW91IGZpbmQgb25lIG9mIHRoZSBFTVJTIChv
ciBzaW1pbGFyKSB2ZXJzaW9ucy4pDQpJSVJDIGl0IG9ubHkgZXZlciBkb2VzIG9uZSBpdGVyYXRp
b24gcGVyIGNsb2NrIC0gYW5kIHlvdQ0Kc2hvdWxkIGJlIGFibGUgdG8gbWF0Y2ggdGhhdCB3aXRo
IGEgY2FyZWZ1bGx5IGNvbnN0cnVjdGVkIGxvb3AuDQoNCk1hbnkgeWVhcnMgYWdvIEkgZ290IG15
IEF0aGxvbi03MDAgdG8gZXhlY3V0ZSBhIGNvcHkgbG9vcA0KYXMgZmFzdCBhcyAncmVwIG1vdnMn
IC0gYnV0IHRoZSBzZXR1cCB0aW1lcyB3ZXJlIGxvbmdlci4NCg0KVGhlIGtpbGxlciBmb3IgJ3Jl
cCBtb3ZzJyBzZXR1cCB3YXMgYWx3YXlzIFA0LW5ldGJ1cnN0IC0gb3ZlciA0MCBjbG9ja3MuDQpC
dXQgSSB0aGluayBzb21lIG9mIHRoZSBtb3JlIHJlY2VudCBjcHUgYXJlIHN0aWxsIGluIGRvdWJs
ZSBmaWd1cmVzDQooYXBhcnQgZnJvbSBzb21lIG9wdGltaXNlZCBjb3BpZXMpLg0KU28gSSdtIG5v
dCBhY3R1YWxseSBzdXJlIHlvdSBzaG91bGQgZXZlciBuZWVkIHRvIHN3aXRjaA0KdG8gYSAncmVw
IG1vdnNxJyBsb29wIC0gYnV0IEkndmUgbm90IHRyaWVkIHRvIHdyaXRlIGl0Lg0KDQpJIGRpZCBo
YXZlIHRvIHVucm9sbCB0aGUgaXAtY2tzdW0gbG9vcCA0IHRpbWVzIChhcyk6DQorICAgICAgIGFz
bSggICAgIiAgICAgICBidCAgICAkNCwgJVtsZW5dXG4iDQorICAgICAgICAgICAgICAgIiAgICAg
ICBqbmMgICAxMGZcbiINCisgICAgICAgICAgICAgICAiICAgICAgIGFkZCAgICglW2J1ZmZdLCAl
W2xlbl0pLCAlW3N1bV8wXVxuIg0KKyAgICAgICAgICAgICAgICIgICAgICAgYWRjICAgOCglW2J1
ZmZdLCAlW2xlbl0pLCAlW3N1bV8xXVxuIg0KKyAgICAgICAgICAgICAgICIgICAgICAgbGVhICAg
MTYoJVtsZW5dKSwgJVtsZW5dXG4iDQorICAgICAgICAgICAgICAgIjEwOiAgICBqZWN4eiAyMGZc
biIgICAvLyAlW2xlbl0gaXMgJXJjeA0KKyAgICAgICAgICAgICAgICIgICAgICAgYWRjICAgKCVb
YnVmZl0sICVbbGVuXSksICVbc3VtXzBdXG4iDQorICAgICAgICAgICAgICAgIiAgICAgICBhZGMg
ICA4KCVbYnVmZl0sICVbbGVuXSksICVbc3VtXzFdXG4iDQorICAgICAgICAgICAgICAgIiAgICAg
ICBsZWEgICAzMiglW2xlbl0pLCAlW2xlbl90bXBdXG4iDQorICAgICAgICAgICAgICAgIiAgICAg
ICBhZGMgICAxNiglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8wXVxuIg0KKyAgICAgICAgICAgICAg
ICIgICAgICAgYWRjICAgMjQoJVtidWZmXSwgJVtsZW5dKSwgJVtzdW1fMV1cbiINCisgICAgICAg
ICAgICAgICAiICAgICAgIG1vdiAgICVbbGVuX3RtcF0sICVbbGVuXVxuIg0KKyAgICAgICAgICAg
ICAgICIgICAgICAgam1wICAgMTBiXG4iDQorICAgICAgICAgICAgICAgIjIwOiAgICBhZGMgICAl
W3N1bV8wXSwgJVtzdW1dXG4iDQorICAgICAgICAgICAgICAgIiAgICAgICBhZGMgICAlW3N1bV8x
XSwgJVtzdW1dXG4iDQorICAgICAgICAgICAgICAgIiAgICAgICBhZGMgICAkMCwgJVtzdW1dXG4i
DQpJbiBvcmRlciB0byBnZXQgb25lIGFkYyBldmVyeSBjbG9jay4NCkJ1dCBvbmx5IGJlY2F1c2Ug
b2YgdGhlIHN0cmFuZ2UgbG9vcCByZXF1aXJlZCB0byAnbG9vcCBjYXJyeScgdGhlDQpjYXJyeSBm
bGFnICh0aGUgJ2xvb3AnIGluc3RydWN0aW9uIGlzIE9LIG9uIEFNRCBjcHUsIGJ1dCBub3Qgb24g
SW50ZWwuKQ0KQSBzaW1pbGFyIGxvb3AgdXNpbmcgYWRveCBhbmQgYWRjeCB3aWxsIGJlYXQgb25l
IHJlYWQvY2xvY2sNCnByb3ZpZGVkIGl0IGlzIHVucm9sbGVkIGFnYWluLg0KKElJUkMgSSBnb3Qg
dG8gYWJvdXQgMTIgYnl0ZXMvY2xvY2suKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

