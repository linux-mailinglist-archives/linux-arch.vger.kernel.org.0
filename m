Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6232D6889FD
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 23:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBBWqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 17:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjBBWqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 17:46:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298006A31A
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 14:46:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-y36o5xIlPiWVEvSaXEynsQ-1; Thu, 02 Feb 2023 22:45:59 +0000
X-MC-Unique: y36o5xIlPiWVEvSaXEynsQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 2 Feb
 2023 22:45:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 2 Feb 2023 22:45:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "will@kernel.org" <will@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Thread-Topic: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Thread-Index: AQHZNz4vE8dWPUdohk2nkEpDmnikoa68PlfA
Date:   Thu, 2 Feb 2023 22:45:57 +0000
Message-ID: <fe484df93b1d437b84edfd85fed66191@AcuMS.aculab.com>
References: <20230202145030.223740842@infradead.org>
 <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
In-Reply-To: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDIgRmVicnVhcnkgMjAyMyAxOTozOQ0KPiAN
Cj4gT24gVGh1LCBGZWIgMiwgMjAyMyBhdCA3OjI5IEFNIFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiAgLSBmaXhlZCB1cCB0aGUgaW5saW5lIGFz
bSB0byB1c2UgJ3UxMjggKicgbWVtIGFyZ3VtZW50IHNvIHRoZSBjb21waWxlciBrbm93cw0KPiA+
ICAgIGhvdyB3aWRlIHRoZSBtb2RpZmljYXRpb24gaXMuDQo+ID4gIC0gcmV3b3JrZWQgdGhlIHBl
cmNwdSB0aGluZyB0byB1c2UgdW5pb24gYmFzZWQgdHlwZS1wdW5uaW5nIGluc3RlYWQgb2YNCj4g
PiAgICBfR2VuZXJpYygpIGJhc2VkIGNhc3RzLg0KPiANCj4gTG9va3MgbG92ZWx5IHRvIG1lLiBU
aGlzIHJlbW92ZWQgYWxsIG15IGNvbmNlcm5zIChleGNlcHQgZm9yIHRoZQ0KPiB0ZXN0aW5nIG9u
ZSwgYnV0IGFsbCB0aGUgcGF0Y2hlcyBsb29rZWQgbmljZSBhbmQgY2xlYW4gdG8gbWUsIHNvDQo+
IGNsZWFybHkgaXQgbXVzdCBiZSBwZXJmZWN0KS4NCg0KVGhlIGNoYW5nZSBpcyBhbG1vc3QgY2Vy
dGFpbmx5IGZvciB0aGUgYmV0dGVyLg0KDQpCdXQgZGlkIEkgc3BvdCBvbmUgb2YgdGhlIGJpdHMg
dXNpbmcgY21weGNoZzEyOCBqdXN0IHRvIGRvIGFuIGF0b21pYyB3cml0ZT8NCkkgdGhpbmsgaXQg
d2FzIHVwZGF0aW5nIHNvbWUgaW50ZXJydXB0IGluZm8gdGhhdCB3YXMgYXQgZmlyc3QgZ2xhbmNl
IG5vdA0KZGlzc2ltaWxhciB0byB0aGF0IHVzZWQgYnkgTVNJLVggKGl0IHdhc24ndCBNU0ktWCku
DQoNCklmIHRoYXQgd2FzIGEgaGFyZHdhcmUgcmVnaXN0ZXIgdGhlbiBpdCBjb3VsZCB3ZWxsIHJl
cXVpcmUgYSBmdWxsIGJ1cyBsb2NrLg0KVXNpbmcgYSB3cml0ZSBvZiBhIHNzZSAob3IgZXF1aXYp
IDEyOGJpdCByZWdpc3RlciB3b3VsZCBiZSBhbiBhdG9taWMgd3JpdGUNCndpdGhvdXQgdGhlIGJ1
cyBsb2NrIHByb2JsZW0uDQoNCkFsc28sIHRoYXQgaXMgb25seSBnb2luZyB0byB3b3JrIGlmIHRo
ZSBoYXJkd2FyZS9sb2dpYyBzaWRlIGd1YXJhbnRlZXMgdG8NCnRyZWF0IGEgc2luZ2xlIHdyaXRl
IGFzIGF0b21pYy4NCkkga25vdyB0aGVyZSBhcmUgTVNJLVggaW1wbGVtZW50YXRpb25zIG91dCB0
aGVyZSB3aGVyZSB0aGUgY3B1IHdyaXRlDQp3aWxsIGJlIHNwbGl0IGludG8gZm91ciAzMmJpdCB3
cml0ZXMgdG8gc29tZSBpbnRlcm5hbCBtZW1vcnkgYW5kIHRoZQ0KaGFyZHdhcmUgc2lkZSB3aWxs
IGFsc28gZG8gbXVsdGlwbGUgYWNjZXNzZXMuDQooUHJldHR5IG11Y2ggYW55IGltcGxlbWVudGF0
aW9uIG9uIGFuIGZwZ2Egd2lsbCBiZWhhdmUgbGlrZSB0aGF0LA0Kbm90IGp1c3QgdGhlIG9uZSBJ
IHdyb3RlLikNCkkgZGlkbid0IHNlZSB0aGUgTVNJLVggY29kZSB0aGVyZSwgYnV0IEkgZG8gd29u
ZGVyIGhvdyBpdCBzYWZlbHkgY2hhbmdlcw0KYWZmaW5pdGllcy4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

