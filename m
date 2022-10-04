Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4C5F4072
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJDJ6F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJDJ6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 05:58:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5971D660
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 02:57:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-228-I6jkKZ2OO_aSqVMjuCOGMA-1; Tue, 04 Oct 2022 10:57:56 +0100
X-MC-Unique: I6jkKZ2OO_aSqVMjuCOGMA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 10:57:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 4 Oct 2022 10:57:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>, Jann Horn <jannh@google.com>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>
Subject: RE: [PATCH v2 00/39] Shadowstacks for userspace
Thread-Topic: [PATCH v2 00/39] Shadowstacks for userspace
Thread-Index: AQHY165UjpEHDRdyM0abW5Nx06znV639/yBQ
Date:   Tue, 4 Oct 2022 09:57:48 +0000
Message-ID: <752d296b68f04c2282bd898cf7ec3f0f@AcuMS.aculab.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <202210030946.CB90B94C11@keescook>
 <CAG48ez2TGdwcr-jUPm1EL1D6X2a-wbx+gXLZUq46qxO-FTctHQ@mail.gmail.com>
 <202210032158.CE0941C4D@keescook>
In-Reply-To: <202210032158.CE0941C4D@keescook>
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

RnJvbTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQouLi4NCj4gPg0KPiA+IElm
IHlvdSBkb24ndCB3YW50IC9wcm9jLyRwaWQvbWVtIHRvIGJlIGFibGUgdG8gZG8gc3R1ZmYgbGlr
ZSB0aGF0LA0KPiA+IHRoZW4gSU1PIHRoZSB3YXkgdG8gZ28gaXMgdG8gY2hhbmdlIHdoZW4gL3By
b2MvJHBpZC9tZW0gdXNlcw0KPiA+IEZPTExfRk9SQ0UsIG9yIHRvIGxpbWl0IG92ZXJhbGwgd3Jp
dGUgYWNjZXNzIHRvIC9wcm9jLyRwaWQvbWVtLg0KPiANCj4gWWVhaCwgYWxsIHJlYXNvbmFibGUu
IEkganVzdCB3aXNoIHdlIGNvdWxkIGRpdGNoIEZPTExfRk9SQ0U7IGl0IGNvbnRpbnVlcw0KPiB0
byB3ZWlyZCBtZSBvdXQgaG93IHBvd2VyZnVsIHRoYXQgZmQncyBzaWRlLWVmZmVjdHMgYXJlLg0K
DQpDb3VsZCB5b3UgcmVtb3ZlIEZPTExfRk9SQ0UgZnJvbSAvcHJvYy8kcGlkL21lbSBhbmQgYWRk
IGENCi9wcm9jLyRwaWQvbWVtX2ZvcmNlIHRoYXQgZW5hYmxlIEZPTExfRk9SQ0UgYnV0IHJlcXVp
cmVzIHJvb3QNCihvciBzaW1pbGFyKSBhY2Nlc3MuDQoNCkFsdGhvdWdoIEkgc3VzcGVjdCBnZGIg
bWF5IGxpa2UgdG8gaGF2ZSB3cml0ZSBhY2Nlc3MgdG8NCmNvZGU/DQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

