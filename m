Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67D6DE67E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 23:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDKVep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDKVeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 17:34:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70284527A
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 14:34:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-zsA8Q_GJNdGPDl24cMCxtg-1; Tue, 11 Apr 2023 22:34:38 +0100
X-MC-Unique: zsA8Q_GJNdGPDl24cMCxtg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 11 Apr
 2023 22:34:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 11 Apr 2023 22:34:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Uros Bizjak <ubizjak@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
Subject: RE: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Thread-Topic: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Thread-Index: AQHZbHulp5OquwuviUmDAgAFAiF/7K8moCeA
Date:   Tue, 11 Apr 2023 21:34:35 +0000
Message-ID: <bd5753622f2f42248495a42593b497f3@AcuMS.aculab.com>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
 <ZDVGFhMwOtpxJtnQ@FVFF77S0Q05N>
 <1fee0372-3a3b-5e09-38c3-ffb3523fe195@intel.com>
In-Reply-To: <1fee0372-3a3b-5e09-38c3-ffb3523fe195@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMTEgQXByaWwgMjAyMyAxNDo0NA0KPiANCj4gT24g
NC8xMS8yMyAwNDozNSwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPiA+IEkgYWdyZWUgaXQnZCBiZSBu
aWNlIHRvIGhhdmUgcGVyZm9ybWFuY2UgZmlndXJlcywgYnV0IEkgdGhpbmsgdGhvc2Ugd291bGQg
b25seQ0KPiA+IG5lZWQgdG8gZGVtb25zdHJhdGUgYSBsYWNrIG9mIGEgcmVncmVzc2lvbiByYXRo
ZXIgdGhhbiBhIHBlcmZvcm1hbmNlDQo+ID4gaW1wcm92ZW1lbnQsIGFuZCBJIHRoaW5rIGl0J3Mg
ZmFpcmx5IGNsZWFyIGZyb20gZXllYmFsbGluZyB0aGUgZ2VuZXJhdGVkDQo+ID4gaW5zdHJ1Y3Rp
b25zIHRoYXQgYSByZWdyZXNzaW9uIGlzbid0IGxpa2VseS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IGFkZGl0aW9uYWwgY29udGV4dC4NCj4gDQo+IEkgdG90YWxseSBhZ3JlZSB0aGF0IHRoZXJlJ3Mg
emVybyBidXJkZW4gaGVyZSB0byBzaG93IGEgcGVyZm9ybWFuY2UNCj4gaW5jcmVhc2UuICBJZiBh
bnlvbmUgY2FuIHRoaW5rIG9mIGEgcXVpY2sgd2F5IHRvIGRvIF9zb21lXyBraW5kIG9mDQo+IGJl
bmNobWFyayBvbiB0aGUgY29kZSBiZWluZyBjaGFuZ2VkIGFuZCBqdXN0IHNob3cgdGhhdCBpdCdz
IGZyZWUgb2YNCj4gYnJvd24gcGFwZXIgYmFncywgaXQgd291bGQgYmUgYXBwcmVjaWF0ZWQuICBO
b3RoaW5nIGNyYXp5LCBqdXN0IHRoaW5rIG9mDQo+IG9uZSB3b3JrbG9hZCAoc3ludGhldGljIG9y
IG5vdCkgdGhhdCB3aWxsIHN0cmVzcyB0aGUgcGF0aHMgYmVpbmcgY2hhbmdlZA0KPiBhbmQgcnVu
IGl0IHdpdGggYW5kIHdpdGhvdXQgdGhlc2UgY2hhbmdlcy4gIE1ha2Ugc3VyZSB0aGVyZSBhcmUg
bm90DQo+IHN1cnByaXNlcy4NCj4gDQo+IEkgYWxzbyBhZ3JlZSB0aGF0IGl0J3MgdW5saWtlbHkg
dG8gYmUgYnJvd24gcGFwZXIgYmFnIG1hdGVyaWFsLg0KDQpUaGUgb25seSB0aGluZyBJIGNhbiB0
aGluayBvZiBpcyB0aGF0LCBvbiB4ODYsIHRoZSBsb2NrZWQNCnZhcmlhbnQgbWF5IGFjdHVhbGx5
IGJlIGZhc3RlciENCkJvdGggcmVxdWlyZSBleGNsdXNpdmUgYWNjZXNzIHRvIHRoZSBjYWNoZSBs
aW5lICh0aGUgdW5sb2NrZWQNCnZhcmlhbnQgYWx3YXlzIGRvZXMgdGhlIHdyaXRlISBbMV0pLg0K
U28gaWYgdGhlIGNhY2hlIGxpbmUgaXMgY29udGVuZGVkIGJldHdlZW4gY3B1IHRoZSB1bmxvY2tl
ZA0KdmFyaWFudCBtaWdodCBwaW5nLXBvbmcgdGhlIGNhY2hlIGxpbmUgdHdpY2UhDQpPZiBjb3Vy
c2UsIGlmIHRoZSBsaW5lIGlzIHNoYXJlZCBsaWtlIHRoYXQgdGhlbiBwZXJmb3JtYW5jZQ0KaXMg
aG9ycmlkLg0KDQpbMV0gSSBjaGVja2VkIG9uIGFuIHVuY2FjaGVkIFBDSWUgYWRkcmVzcyBvbiB3
aGljaCBJIGNhbiBtb25pdG9yDQp0aGUgVExQLiBUaGUgd3JpdGUgYWx3YXlzIGhhcHBlbnMgc28g
eW91IGNhbiB1c2UgY21weGNoZzE4Yg0Kd2l0aCBhICdrbm93biBiYWQgdmFsdWUnIHRvIGRvIGEg
MTYgYnl0ZSByZWFkIGFzIGEgc2luZ2xlIFRMUA0KKHdpdGhvdXQgdXNpbmcgYW4gU1NFIHJlZ2lz
dGVyKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

