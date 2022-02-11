Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1B4B2102
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbiBKJIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 04:08:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiBKJIv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 04:08:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A69FFF5F
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 01:08:50 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-XP-PeTqnNb6M-AeFx-qu4A-1; Fri, 11 Feb 2022 09:08:48 +0000
X-MC-Unique: XP-PeTqnNb6M-AeFx-qu4A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 09:08:45 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 09:08:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Edgecombe, Rick P'" <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: RE: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Index: AQHYHgPE4ng9s1QFWkGaF1pqJykcg6yNYAXAgAATt4CAAJxvEA==
Date:   Fri, 11 Feb 2022 09:08:45 +0000
Message-ID: <09ed01cc5e564ef78875b18001955bb1@AcuMS.aculab.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-19-rick.p.edgecombe@intel.com>
         <f92c5110-7d97-b68d-d387-7e6a16a29e49@intel.com>
         <1b5d83dc4cd84309823f012a3dce24f0@AcuMS.aculab.com>
 <6a4c11e506874293df13cb94b9dd578bba1819d7.camel@intel.com>
In-Reply-To: <6a4c11e506874293df13cb94b9dd578bba1819d7.camel@intel.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFANCj4gU2VudDogMTAgRmVicnVhcnkgMjAyMiAyMzo0Mw0K
PiANCj4gT24gVGh1LCAyMDIyLTAyLTEwIGF0IDIyOjM4ICswMDAwLCBEYXZpZCBMYWlnaHQgd3Jv
dGU6DQo+ID4gRG8geW91IG5lZWQgYSByZWFsIGd1YXJkIHBhZ2U/DQo+ID4gT3IgaXMgaXQganVz
dCBlbm91Z2ggdG8gZW5zdXJlIHRoYXQgdGhlIGFkamFjZW50IHBhZ2UgaXNuJ3QgYW5vdGhlcg0K
PiA+IHNoYWRvdyBzdGFjayBwYWdlPw0KPiA+DQo+ID4gQW55IG90aGVyIHBhZ2Ugd2lsbCBjYXVz
ZSBhIGZhdWx0IGJlY2F1c2UgdGhlIFBURSBpc24ndA0KPiA+IHJlYWRvbmx5K2RpcnR5Lg0KPiA+
DQo+ID4gSSdtIG5vdCBzdXJlIGhvdyBjb21tb24gc2luZ2xlIHBhZ2UgYWxsb2NhdGVzIGFyZSBp
biBMaW51eC4NCj4gDQo+IEkgdGhpbmsgaXQgY2FtZSBmcm9tIHRoaXMgZGlzY3Vzc2lvbjoNCj4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FHNDhlejF5dE9mUXlOWk1OUEZwN1hx
S2NwZDdfYVJhaTlHNXM3cngwVj04WkcrcjJBQG1haWwuZ21haWwuY29tLyN0DQo+IA0KPiA+IEJ1
dCBhZGphY2VudCBzaGFkb3cgc3RhY2tzIG1heSBiZSByYXJlIGFueXdheS4NCj4gPiBTbyBhIGNo
ZWNrIGFnYWluc3QgYm90aCBhZGphY2VudCBQVEUgZW50cmllcyB3b3VsZCBzdWZmaWNlLg0KPiA+
IE9yIG1heWJlIGFsd2F5cyBhbGxvY2F0ZSBhbiBldmVuIChvciBvZGQpIG51bWJlcmVkIHBhZ2Uu
DQo+IA0KPiBJdCBqdXN0IG5lZWRzIHRvIG5vdCBiZSBhZGphY2VudCB0byBzaGFkb3cgc3RhY2sg
bWVtb3J5IHRvIGRvIHRoZSBqb2IuDQo+IFdvdWxkIHRoYXQgYmUgc21hbGwgdG8gaW1wbGVtZW50
PyBJdCBtaWdodCBiZSBhIHRyYWRlb2ZmIG9mIGNvZGUNCj4gY29tcGxleGl0eS4NCg0KVGhhdCdz
IHdoYXQgSSB0aG91Z2h0Lg0KQWx0aG91Z2ggdGhlIFZBIHVzZSBmb3IgZ3VhcmQgcGFnZXMgbWln
aHQgYmUgYSBwcm9ibGVtIGluIGl0c2VsZi4NCg0KSSdtIG5vdCBzdXJlIHdoeSBJIHRob3VnaHQg
c2hhZG93IHN0YWNrcyB3b3VsZCBiZSBhIHNpbmdsZSBwYWdlLg0KRm9yIHVzZXIgc3BhY2UgdGhh
dCAnb25seScgYWxsb3dzIDUxMiBjYWxscy4NCkZvciBrZXJuZWwgaXQgaXMgYSBtYXNzaXZlIHdh
c3RlIG9mIG1lbW9yeS4NCkl0IGlzIHByb2JhYmx5IHdvcnRoIHB1dHRpbmcgbXVsdGlwbGUga2Vy
bmVsIHNoYWRvdyBzdGFja3MgaW50byB0aGUgc2FtZSBwYWdlLg0KKENvZGUgdGhhdCBjYW4gb3Zl
cnJ1biBjYW4gZG8gb3RoZXIgc3R1ZmYgbW9yZSBlYXNpbHkuKQ0KDQpUaGUgaGFyZHdhcmUgZW5n
aW5lZXJzIGZhaWxlZCB0byB0aGluayBhYm91dCB0aGUgaW1wbGVtZW50YXRpb24gKGFnYWluKS4N
ClRoZSBzaGFkb3cgc3RhY2sgc2hvdWxkIChwcm9iYWJseSkgcnVuIGluIHRoZSBvcHBvc2l0ZSBk
aXJlY3Rpb24gdG8NCnRoZSBub3JtYWwgc3RhY2suDQpUaGVuIHRoZSBzaGFkb3cgc3RhY2sgY2Fu
IGJlIHBsYWNlZCBhdCB0aGUgb3RoZXIgZW5kIG9mIHRoZSBWQSBhbGxvY2F0ZWQNCnRvIGEgdXNl
ciBzcGFjZSBzdGFjay4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

