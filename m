Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496DE4B18C4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 23:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbiBJWrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 17:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345219AbiBJWrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 17:47:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 864A55F4B
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 14:47:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-tnvpk8ZBMl6vvx44NdPNoA-1; Thu, 10 Feb 2022 22:45:02 +0000
X-MC-Unique: tnvpk8ZBMl6vvx44NdPNoA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 22:45:00 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 22:45:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: RE: [PATCH 20/35] mm: Update can_follow_write_pte() for shadow stack
Thread-Topic: [PATCH 20/35] mm: Update can_follow_write_pte() for shadow stack
Thread-Index: AQHYHgex3kDJpMh0kE6CJu25wcKQLKyNYu3Q
Date:   Thu, 10 Feb 2022 22:45:00 +0000
Message-ID: <cd5e3eb792474e41bca1bd04d1747c9a@AcuMS.aculab.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-21-rick.p.edgecombe@intel.com>
 <37426b64-2139-dc24-c7be-f3cefa4f0dd9@intel.com>
In-Reply-To: <37426b64-2139-dc24-c7be-f3cefa4f0dd9@intel.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDkgRmVicnVhcnkgMjAyMiAyMjo1Mg0KPiANCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gTGlrZSBhIHdyaXRh
YmxlIGRhdGEgcGFnZSwgYSBzaGFkb3cgc3RhY2sgcGFnZSBpcyB3cml0YWJsZSwgYW5kIGJlY29t
ZXMNCj4gPiByZWFkLW9ubHkgZHVyaW5nIGNvcHktb24td3JpdGUsIGJ1dCBpdCBpcyBhbHdheXMg
ZGlydHkuDQo+IA0KPiBPbmUgb3RoZXIgdGhpbmcuLi4NCj4gDQo+IFRoZSBsYW5ndWFnZSBpbiB0
aGVzZSBjaGFuZ2Vsb2dzIGlzIGEgYml0IHNsb3BweS4gIEZvciBpbnN0YW5jZSwgd2hhdA0KPiBk
b2VzICJhbHdheXMgZGlydHkiIG1lYW4gaGVyZT8gIHB0ZV9kaXJ0eSgpPyAgT3Igc3RyaWN0bHkg
X1BBR0VfRElSVFk/DQo+IA0KPiBJbiBvdGhlciB3b3JkcywgbG9naWNhbGx5IGRpcnR5LCBvciBs
aXRlcmFsbHkgImhhcyAqdGhlKiBkaXJ0eSBiaXQgc2V0Ij8NCg0KRG9lc24ndCBDT1cgaGF2ZSB0
byBzZXQgaXQgcmVhZG9ubHkgLSBzbyB0aGF0IHRoZSBhY2Nlc3MgZmF1bHRzLg0KQW5kIHRoZW4g
c2V0IHRoZSBmYXVsdCBjb2RlIHNldCBpdCByZWFkb25seStkaXJ0eSAod2l0aG91dCB3cml0ZSkN
CnRvIGFsbG93IHRoZSBzaGFkb3cgc3RhY2sgYWNjZXNzZXMgdG8gbm90LWZhdWx0Lg0KDQpPciBh
bSBJIG1pcy1ndWVzc2luZyB3aGF0IHRoZSBkb2NzIGFjdHVhbGx5IHNheT8NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

