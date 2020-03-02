Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC524176160
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBRoQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 12:44:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54230 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbgCBRoQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 12:44:16 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-SXZ8HwqhNeywIeCkwMp4SA-1; Mon, 02 Mar 2020 17:44:12 +0000
X-MC-Unique: SXZ8HwqhNeywIeCkwMp4SA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Mar 2020 17:44:11 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Mar 2020 17:44:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marco Elver' <elver@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2] tools/memory-model/Documentation: Fix "conflict"
 definition
Thread-Topic: [PATCH v2] tools/memory-model/Documentation: Fix "conflict"
 definition
Thread-Index: AQHV8J155VDezGAX9EWDGQvLVJz3h6g1j37g
Date:   Mon, 2 Mar 2020 17:44:11 +0000
Message-ID: <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
References: <20200302141819.40270-1-elver@google.com>
In-Reply-To: <20200302141819.40270-1-elver@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogTWFyY28gRWx2ZXINCj4gU2VudDogMDIgTWFyY2ggMjAyMCAxNDoxOA0KPiANCj4gVGhl
IGRlZmluaXRpb24gb2YgImNvbmZsaWN0IiBzaG91bGQgbm90IGluY2x1ZGUgdGhlIHR5cGUgb2Yg
YWNjZXNzIG5vcg0KPiB3aGV0aGVyIHRoZSBhY2Nlc3NlcyBhcmUgY29uY3VycmVudCBvciBub3Qs
IHdoaWNoIHRoaXMgcGF0Y2ggYWRkcmVzc2VzLg0KPiBUaGUgZGVmaW5pdGlvbiBvZiAiZGF0YSBy
YWNlIiByZW1haW5zIHVuY2hhbmdlZC4NCj4gDQo+IFRoZSBkZWZpbml0aW9uIG9mICJjb25mbGlj
dCIgYXMgd2Uga25vdyBpdCBhbmQgaXMgY2l0ZWQgYnkgdmFyaW91cw0KPiBwYXBlcnMgb24gbWVt
b3J5IGNvbnNpc3RlbmN5IG1vZGVscyBhcHBlYXJlZCBpbiBbMV06ICJUd28gYWNjZXNzZXMgdG8N
Cj4gdGhlIHNhbWUgdmFyaWFibGUgY29uZmxpY3QgaWYgYXQgbGVhc3Qgb25lIGlzIGEgd3JpdGU7
IHR3byBvcGVyYXRpb25zDQo+IGNvbmZsaWN0IGlmIHRoZXkgZXhlY3V0ZSBjb25mbGljdGluZyBh
Y2Nlc3Nlcy4iDQoNCkknbSBwcmV0dHkgc3VyZSB0aGF0IExpbnV4IHJlcXVpcmVzIHRoYXQgdGhl
IHVuZGVybHlpbmcgbWVtb3J5DQpzdWJzeXN0ZW0gcmVtb3ZlIGFueSBwb3NzaWJsZSAnY29uZmxp
Y3RzJyBieSBzZXJpYWxpc2luZyB0aGUNCnJlcXVlc3RzIChpbiBhbiBhcmJpdHJhcnkgb3JkZXIp
Lg0KDQpTbyAnY29uZmxpY3RzJyBhcmUgbmV2ZXIgcmVsZXZhbnQuDQoNClRoZXJlIGFyZSBtZW1v
cnkgc3Vic3lzdGVtcyB3aGVyZSBjb25mbGljdHMgTVVTVCBiZSBhdm9pZGVkLg0KRm9yIGluc3Rh
bmNlIHRoZSBmcGdhIEkgdXNlIGhhdmUgc29tZSBkdWFsLXBvcnRlZCBtZW1vcnkuDQpDb25jdXJy
ZW50IGFjY2Vzc2VzIG9uIHRoZSB0d28gcG9ydHMgZm9yIHRoZSBzYW1lIGFkZHJlc3MNCm11c3Qg
KHVzdWFsbHkpIGJlIGF2b2lkZWQgaWYgb25lIGlzIGEgd3JpdGUuDQpUd28gd3JpdGVzIHdpbGwg
Z2VuZXJhdGUgY29ycnVwdCBtZW1vcnkuDQpBIGNvbmN1cnJlbnQgd3JpdGUrcmVhZCB3aWxsIGdl
bmVyYXRlIGEgZ2FyYmFnZSByZWFkLg0KSW4gdGhlIHNwZWNpYWwgY2FzZSB3aGVyZSB0aGUgdHdv
IHBvcnRzIHVzZSB0aGUgc2FtZSBjbG9jaw0KaXQgaXMgcG9zc2libGUgdG8gZm9yY2UgdGhlIHJl
YWQgdG8gYmUgJ29sZCBkYXRhJyBidXQgdGhhdA0KY29uc3RyYWlucyB0aGUgdGltaW5ncy4NCg0K
T24gc3VjaCBzeXN0ZW1zIHRoZSBjb2RlIG11c3QgYXZvaWQgY29uZmxpY3RpbmcgY3ljbGVzLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

