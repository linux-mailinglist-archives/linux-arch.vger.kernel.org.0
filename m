Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11616D9179
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjDFI0L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjDFI0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 04:26:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A309A76A2
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 01:26:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-D1tdxv4cNzaW0ds0adK_fQ-1; Thu, 06 Apr 2023 09:25:59 +0100
X-MC-Unique: D1tdxv4cNzaW0ds0adK_fQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Apr
 2023 09:25:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 6 Apr 2023 09:25:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Henderson <richard.henderson@linaro.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
Subject: RE: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Thread-Topic: [PATCH v2 0/5] locking: Introduce local{,64}_try_cmpxchg
Thread-Index: AQHZZ9zo4aQfYkHe8kGrF8tSkNZCGa8d8QYA
Date:   Thu, 6 Apr 2023 08:25:57 +0000
Message-ID: <5c10520ac747430cb421badcb293c706@AcuMS.aculab.com>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
In-Reply-To: <7360ffd2-a5aa-1373-8309-93e71ff36cbb@intel.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDUgQXByaWwgMjAyMyAxNzozNw0KPiANCj4gT24g
NC81LzIzIDA3OjE3LCBVcm9zIEJpemphayB3cm90ZToNCj4gPiBBZGQgZ2VuZXJpYyBhbmQgdGFy
Z2V0IHNwZWNpZmljIHN1cHBvcnQgZm9yIGxvY2Fseyw2NH1fdHJ5X2NtcHhjaGcNCj4gPiBhbmQg
d2lyZSB1cCBzdXBwb3J0IGZvciBhbGwgdGFyZ2V0cyB0aGF0IHVzZSBsb2NhbF90IGluZnJhc3Ry
dWN0dXJlLg0KPiANCj4gSSBmZWVsIGxpa2UgSSdtIG1pc3Npbmcgc29tZSBjb250ZXh0Lg0KPiAN
Cj4gV2hhdCBhcmUgdGhlIGFjdHVhbCBlbmQgdXNlciB2aXNpYmxlIGVmZmVjdHMgb2YgdGhpcyBz
ZXJpZXM/ICBJcyB0aGVyZSBhDQo+IG1lYXN1cmFibGUgZGVjcmVhc2UgaW4gcGVyZiBvdmVyaGVh
ZD8gIFdoeSBnbyB0byBhbGwgdGhpcyB0cm91YmxlIGZvcg0KPiBwZXJmPyAgV2hvIGVsc2Ugd2ls
bCB1c2UgbG9jYWxfdHJ5X2NtcHhjaGcoKT8NCg0KSSdtIGFzc3VtaW5nIHRoZSBsb2NhbF94eHgg
b3BlcmF0aW9ucyBvbmx5IGhhdmUgdG8gYmUgc2F2ZSB3cnQgaW50ZXJydXB0cz8NCk9uIHg4NiBp
dCBpcyBwb3NzaWJsZSB0aGF0IGFuIGFsdGVybmF0ZSBpbnN0cnVjdGlvbiBzZXF1ZW5jZQ0KdGhh
dCBkb2Vzbid0IHVzZSBhIGxvY2tlZCBpbnN0cnVjdGlvbiBtYXkgYWN0dWFsbHkgYmUgZmFzdGVy
IQ0KDQpBbHRob3VnaCwgbWF5YmUsIGFueSBraW5kIG9mIGxvY2tlZCBjbXB4Y2hnIGp1c3QgbmVl
ZHMgdG8gZW5zdXJlDQp0aGUgY2FjaGUgbGluZSBpc24ndCAnc3RvbGVuJywgc28gYXBhcnQgZnJv
bSBwb3NzaWJsZSBzbGlnaHQNCmRlbGF5cyBvbiBhbm90aGVyIGNwdSB0aGF0IGdldHMgYSBjYWNo
ZSBtaXNzIGZvciB0aGUgbGluZSBpbg0KYWxsIG1ha2VzIGxpdHRsZSBkaWZmZXJlbmNlLg0KVGhl
IGNhY2hlIGxpbmUgbWlzcyBjb3N0cyBhIGxvdCBhbnl3YXksIGxpbmUgYm91bmNpbmcgbW9yZQ0K
YW5kIGlzIGJlc3QgYXZvaWRlZC4NClNvIGlzIHRoZXJlIGFjdHVhbGx5IG11Y2ggb2YgYSBiZW5l
Zml0IGF0IGFsbD8NCg0KQ2xlYXJseSB0aGUgdHJ5X2NtcHhjaGcgaGVscCAtIGJ1dCB0aGF0IGlz
IGEgZGlmZmVyZW50IGlzc3VlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

