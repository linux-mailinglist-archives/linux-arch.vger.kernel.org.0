Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FFF689288
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBCIqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBCIqa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 03:46:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA8079237
        for <linux-arch@vger.kernel.org>; Fri,  3 Feb 2023 00:46:28 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-hQ5rIG0kMFGt6l0xOnfJhw-1; Fri, 03 Feb 2023 08:46:26 +0000
X-MC-Unique: hQ5rIG0kMFGt6l0xOnfJhw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Fri, 3 Feb
 2023 08:46:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Fri, 3 Feb 2023 08:46:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Huacai Chen' <chenhuacai@kernel.org>
CC:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] LoongArch: Make -mstrict-align be configurable
Thread-Topic: [PATCH] LoongArch: Make -mstrict-align be configurable
Thread-Index: AQHZNuKTZOpLs+GXMEuRBwFbIvBWLq67WwCQgAEd3gCAAG+cUA==
Date:   Fri, 3 Feb 2023 08:46:25 +0000
Message-ID: <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
In-Reply-To: <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogSHVhY2FpIENoZW4NCj4gU2VudDogMDMgRmVicnVhcnkgMjAyMyAwMjowMQ0KPiANCj4g
SGksIERhdmlkLA0KPiANCj4gT24gVGh1LCBGZWIgMiwgMjAyMyBhdCA1OjAxIFBNIERhdmlkIExh
aWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSHVh
Y2FpIENoZW4NCj4gPiA+IFNlbnQ6IDAyIEZlYnJ1YXJ5IDIwMjMgMDg6NDMNCj4gPiA+DQo+ID4g
PiBJbnRyb2R1Y2UgS2NvbmZpZyBvcHRpb24gQVJDSF9TVFJJQ1RfQUxJR04gdG8gbWFrZSAtbXN0
cmljdC1hbGlnbiBiZQ0KPiA+ID4gY29uZmlndXJhYmxlLg0KPiA+ID4NCj4gPiA+IE5vdCBhbGwg
TG9vbmdBcmNoIGNvcmVzIHN1cHBvcnQgaC93IHVuYWxpZ25lZCBhY2Nlc3MsIHdlIGNhbiB1c2Ug
dGhlDQo+ID4gPiAtbXN0cmljdC1hbGlnbiBidWlsZCBwYXJhbWV0ZXIgdG8gcHJldmVudCB1bmFs
aWduZWQgYWNjZXNzZXMuDQo+ID4gPg0KPiA+ID4gVGhpcyBvcHRpb24gaXMgZGlzYWJsZWQgYnkg
ZGVmYXVsdCB0byBvcHRpbWlzZSBmb3IgcGVyZm9ybWFuY2UsIGJ1dCB5b3UNCj4gPiA+IGNhbiBl
bmFibGVkIGl0IG1hbnVhbGx5IGlmIHlvdSB3YW50IHRvIHJ1biBrZXJuZWwgb24gc3lzdGVtcyB3
aXRob3V0IGgvdw0KPiA+ID4gdW5hbGlnbmVkIGFjY2VzcyBzdXBwb3J0Lg0KPiA+DQo+ID4gU2hv
dWxkIHRoZXJlIGJlIGFuIGFzc29jaWF0ZWQgcnVuLXRpbWUgY2hlY2sgZHVyaW5nIGtlcm5lbCBp
bml0aWFsaXNhdGlvbg0KPiA+IHRoYXQgYSBrZXJuZWwgY29tcGlsZWQgd2l0aG91dCAtbXN0cmlj
dC1hbGlnbiBpc24ndCBiZWluZyBydW4gb24gaGFyZHdhcmUNCj4gPiB0aGF0IGRvZXNuJ3Qgc3Vw
cG9ydCB1bmFsaWduZWQgYWNjZXNzZXMuDQo+ID4NCj4gPiBJdCBjYW4gYmUgcXVpdGUgYSB3aGls
ZSBiZWZvcmUgeW91IGdldCBhIGNvbXBpbGVyLWdlbmVyYXRlZCBtaXNhbGlnbmVkIGFjY2Vzc2Vz
Lg0KPg0KPiBJZiB3ZSBkb24ndCB1c2UgLW1zdHJpY3QtYWxpZ24sIHRoZSBrZXJuZWwgY2Fubm90
IGJlIHJ1biBvbiBoYXJkd2FyZQ0KPiB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCB1bmFsaWduZWQgYWNj
ZXNzZXMsIHNvIEkgdGhpbmsgdGhlIHJ1bi10aW1lIGNoZWNrDQo+IGlzIHVzZWxlc3MsIGFuZCBp
dCBoYXMgbm8gY2hhbmNlIHRvIHJ1biB0aGUgY2hlY2tpbmcuDQoNCklmIHlvdSBkb24ndCBhZGQg
dGhlIGNoZWNrIGFuZCBzb21lb25lIGJvb3RzIHRoZSB3cm9uZyB0eXBlIG9mIGtlcm5lbA0KdGhl
biB0aGV5J2xsIHByb2JhYmx5IGdldCBhIHBhbmljIHdlbGwgYWZ0ZXIgYm9vdGluZy4NCllvdSBy
ZWFsbHkgZG8gd2FudCBhIGNoZWNrIGluIHRoZSBib3QgY29kZS4NCg0KVGhlcmUgaXMgYWxzbyB0
aGUgcXVlc3Rpb24gb2YgaG93IHVzZXJzcGFjZSBpcyBjb21waWxlZC4NCllvdSBwcmV0dHkgbXVj
aCBkb24ndCB3YW50IHRvIGJlIHRha2luZyB0cmFwcyB0byBmaXh1cCBtaXNhbGlnbmVkIGFjY2Vz
c2VzLg0KU28gdGhlIGRlZmF1bHQgY29tcGlsZXIgb3B0aW9ucyBiZXR0ZXIgaW5jbHVkZSAtbXN0
cmljdC1hbGlnbi4NCg0KWW91IHNob3VsZCBsb29rIGF0IC1tbm8tc3RyaWN0LWFsaWduIGJlaW5n
IGEgcGVyZm9ybWFuY2Ugb3B0aW9uIHdoZW4NCnJ1bm5pbmcgb24ga25vd24gaGFyZHdhcmUsIG5v
dCBhIGRlZmF1bHQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

