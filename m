Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA1138FF2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMLU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 06:20:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45384 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMLU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 06:20:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-ohsiXHuwM3ybrcsKDdx_-Q-1; Mon, 13 Jan 2020 11:20:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 Jan 2020 11:20:50 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Jan 2020 11:20:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Thread-Topic: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Thread-Index: AQHVx9bxDvKCHYVgoEK2bShJK6k/+qfobsqw
Date:   Mon, 13 Jan 2020 11:20:50 +0000
Message-ID: <c1c18e9a4f144c6a92a250a206dfef02@AcuMS.aculab.com>
References: <20200110165636.28035-1-will@kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ohsiXHuwM3ybrcsKDdx_-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogV2lsbCBEZWFjb24NCj4gU2VudDogMTAgSmFudWFyeSAyMDIwIDE2OjU2DQouLi4NCj4g
VGhlIHJvdWdoIHN1bW1hcnkgb2YgdGhlIHNlcmllcyBpczoNCj4gDQo+ICAgKiBEcm9wIHRoZSBH
Q0MgNC44IHdvcmthcm91bmRzLCBzbyB0aGF0IFJFQURfT05DRSgpIGlzIGENCj4gICAgIHN0cmFp
Z2h0Zm9yd2FyZCBkZXJlZmVyZW5jZSBvZiBhIGNhc3QtdG8tdm9sYXRpbGUgcG9pbnRlci4NCg0K
V2hhdCBpcyB0aGUgZWZmZWN0IG9mIHVzaW5nIHRoZSBjaGFuZ2VkIGNvZGUgb24gb2xkZXIgY29t
cGlsZXJzIChlc3AuIHg4Ni02NCk/DQpSZXF1aXJpbmcgZ2NjID4gNC44IGlzIGEgc2lnbmlmaWNh
bnQgYnVtcC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

