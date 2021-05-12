Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7637B7A0
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhELINn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 04:13:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27716 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhELINm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 May 2021 04:13:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-24-Mu4ZH7yROfqaElxRZepFWA-1; Wed, 12 May 2021 09:12:32 +0100
X-MC-Unique: Mu4ZH7yROfqaElxRZepFWA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 12 May 2021 09:12:30 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 12 May 2021 09:12:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>
Subject: RE: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
Thread-Index: AQHXRoh6HV4c4+Eb3km5gqBECdAPb6rff7ZQ
Date:   Wed, 12 May 2021 08:12:29 +0000
Message-ID: <e22d3116efef4e25a45fc6b58d5622ef@AcuMS.aculab.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com> <YJlADyc/9pn8Sjkn@zn.tnic>
 <89598d32-4bf8-b989-ee77-5b4b55a138a9@intel.com> <YJq6VZ/XMAtfkrMc@zn.tnic>
In-Reply-To: <YJq6VZ/XMAtfkrMc@zn.tnic>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDExIE1heSAyMDIxIDE4OjEwDQo+IA0KPiBP
biBNb24sIE1heSAxMCwgMjAyMSBhdCAwMzo1Nzo1NlBNIC0wNzAwLCBZdSwgWXUtY2hlbmcgd3Jv
dGU6DQo+ID4gU28gdGhpcyBzdHJ1Y3Qgd2lsbCBiZToNCj4gPg0KPiA+IHN0cnVjdCB0aHJlYWRf
c2hzdGsgew0KPiA+IAl1NjQgc2hzdGtfYmFzZTsNCj4gPiAJdTY0IHNoc3RrX3NpemU7DQo+ID4g
CXU2NCBsb2NrZWQ6MTsNCj4gPiAJdTY0IGlidDoxOw0KDQpObyBwb2ludCBpbiBiaXQgZmllbGRz
Pw0KDQo+ID4gfTsNCj4gPg0KPiA+IE9rPw0KPiANCj4gUHJldHR5IG11Y2guDQo+IA0KPiBZb3Ug
Y2FuIGV2ZW4gcmVtb3ZlIHRoZSAic2hzdGtfIiBmcm9tIHRoZSBtZW1iZXJzIGFuZCB3aGVuIHlv
dSBjYWxsIHRoZQ0KPiBwb2ludGVyICJzaHN0ayIsIGFjY2Vzc2luZyB0aGUgbWVtYmVycyB3aWxs
IHJlYWQNCj4gDQo+IAlzaHN0ay0+YmFzZQ0KPiAJc2hzdGstPnNpemUNCj4gCS4uLg0KPiANCj4g
YW5kIGFsbCBpcyBvcmdhbmljIGFuZCByZWFkYWJsZSA6KQ0KDQpBbmQgZW50aXJlbHkgbm90IGdy
ZXBwYWJsZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

