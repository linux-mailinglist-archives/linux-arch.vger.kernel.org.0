Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B56ABFEC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCFMxd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 07:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCFMxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 07:53:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630441688A
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 04:53:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-_7Vu1xbAPCyVrGMFDnxLvQ-1; Mon, 06 Mar 2023 12:53:27 +0000
X-MC-Unique: _7Vu1xbAPCyVrGMFDnxLvQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 6 Mar
 2023 12:53:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Mon, 6 Mar 2023 12:53:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'WANG Xuerui' <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Xi Ruoyao" <xry111@xry111.site>
CC:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: RE: [PATCH] LoongArch: Provide kernel fpu functions
Thread-Topic: [PATCH] LoongArch: Provide kernel fpu functions
Thread-Index: AQHZT9H8Gz9FKQs5kk+HZBSlKM6d1a7ttCfQ
Date:   Mon, 6 Mar 2023 12:53:24 +0000
Message-ID: <50dd43063e244fa9a4d025873c862331@AcuMS.aculab.com>
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
 <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
 <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
 <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
 <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
 <65d890c8-9c37-070c-f5c6-db26ab8cfe54@xen0n.name>
In-Reply-To: <65d890c8-9c37-070c-f5c6-db26ab8cfe54@xen0n.name>
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

Li4uDQo+IEFsc28sIGlmIHRoZSBvbGQgd29ybGQgaXMgdGFrZW4gaW50byBjb25zaWRlcmF0aW9u
ICh3aGljaCB3ZSBub3JtYWxseQ0KPiBoYXZlIHRoZSBsdXh1cnkgb2Ygbm90IGhhdmluZyB0byBk
byBzbyksIGNvbnNpZGVyIFJ1b3lhbydzIGNhc2Ugd2hlcmUgYQ0KPiBjb21tZXJjaWFsIHBhcnRu
ZXIgb2YgTG9vbmdzb24gd2FudHMgdG8gZG8gdGhpcyB3aXRoIHRoZSB2ZW5kb3Iga2VybmVsLA0K
PiBidXQgdGhlIHN5bWJvbHMgYXJlIGV4cG9ydGVkIEdQTCAtLSBpbiB0aGlzIGNhc2UgSSBkb3Vi
dCB0aGUgR1BMIG1hcmtpbmcNCj4gd2lsbCByZW1haW4sIHRodXMgY3JlYXRpbmcgaW5jb25zaXN0
ZW5jeSBiZXR3ZWVuIHVwc3RyZWFtIGFuZCB2ZW5kb3INCj4ga2VybmVscywgYW5kIGNvbW11bml0
eSBkaXN0cm9zIGFyZSBnb2luZyB0byBjb21wbGFpbiBsb3VkbHkgYWJvdXQgdGhlDQo+IG5lZWQg
dG8gcGF0Y2ggdGhpbmdzLiBJdCdzIHByb2JhYmx5IGJlc3QgdG8gYXZvaWQgYWxsIG9mIHRoaXMg
dXBmcm9udC4NCg0KSXQgaXMgcHJldHR5IGVhc3kgdG8gbG9hZCBhIG5vbi1HUEwgbW9kdWxlIGlu
dG8gYSBkaXN0cm8tYnVpbHQNCmtlcm5lbCBhbmQgY2FsbCBHUEwtb25seSBmdW5jdGlvbnMuDQoo
QW5kIHdpdGhvdXQgZG9pbmcgaG9ycmlkIHRoaW5ncyB3aXRoIGthbGxzeW1zLikNCkFzIHNvb24g
YXMgeW91IGFjdHVhbGx5IG5lZWQgdG8gZG8gb25lLCBhZGRpbmcgb3RoZXJzIGlzbid0IGEgcHJv
YmxlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

