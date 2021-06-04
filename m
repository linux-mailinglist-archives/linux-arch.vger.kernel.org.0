Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38D39B573
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDJET (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 05:04:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41023 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhFDJET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 05:04:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-237-NXl5cs6NMkGVq-pfDNrTRg-1; Fri, 04 Jun 2021 10:02:30 +0100
X-MC-Unique: NXl5cs6NMkGVq-pfDNrTRg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Fri, 4 Jun 2021 10:02:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Fri, 4 Jun 2021 10:02:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "guoren@kernel.org" <guoren@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: RE: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Topic: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Index: AQHXWI67+E+HbgFRkkm3Xv2DTkp7y6sDjh4w
Date:   Fri, 4 Jun 2021 09:02:29 +0000
Message-ID: <f3d84841a80e4244887939624f6d3c10@AcuMS.aculab.com>
References: <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
 <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop>
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

RnJvbTogUGFsbWVyIERhYmJlbHQNCj4gU2VudDogMDMgSnVuZSAyMDIxIDE2OjM5DQouLi4NCj4g
QW4gZXhhbXBsZSBoZXJlIHdvdWxkIGJlIHRoZSBlcnJhdGE6IGV2ZXJ5IHN5c3RlbSBoYXMgZXJy
YXRhIG9mIHNvbWUNCj4gc29ydCwgc28gaWYgd2Ugc3RhcnQgZmxpcHBpbmcgb2ZmIHZhcmlvdXMg
dmVuZG9yJ3MgZXJyYXRhIEtjb25maWdzDQo+IHlvdSdsbCBlbmQgdXAgd2l0aCBrZXJuZWxzIHRo
YXQgb25seSBmdW5jdGlvbiBwcm9wZXJseSBvbiBzb21lIHN5c3RlbXMuDQo+IFRoYXQncyBmaW5l
IHdpdGggbWUsIGFzIGxvbmcgYXMgaXQncyBwb3NzaWJsZSB0byB0dXJuIG9uIGFsbCB2ZW5kb3In
cw0KPiBlcnJhdGEgS2NvbmZpZ3MgYXQgdGhlIHNhbWUgdGltZSBhbmQgdGhlIHJlc3VsdGluZyBr
ZXJuZWwgZnVuY3Rpb25zDQo+IGNvcnJlY3RseSBvbiBhbGwgc3lzdGVtcy4NCg0KSVNUTSB0aGF0
IGlmIHlvdSBjYW4gKGVhc2lseSkgZGV0ZWN0IHRoZSBlcnJhdGEgdGhlbiB0aGUgZGV0ZWN0aW9u
DQpzaG91bGQgYmUgbGVmdCBpdCAtIGJ1dCB0aGUga2VybmVsIGZhaWwgdG8gYm9vdCBpZiB0aGUg
c3lzdGVtDQpuZWVkcyB0aGUgZXJyYXRhIGZpeGVkLg0KDQpUaGUgc2FtZSB3b3VsZCBiZSBuZWVk
ZWQgZm9yIERNQSBpbiBzeXN0ZW1zIHdpdGggbm9uLWNvaGVyZW50IG1lbW9yeS4NCg0KT25seSBh
IGhhcmR3YXJlIGVuZ2luZWVyIHdvdWxkIGJ1aWxkIGEgc3lzdGVtIHdpdGggbm9uLWNvaGVyZW50
IG1lbW9yeQ0KYW5kIHdpdGhvdXQgdGhlIGFiaWxpdHkgdG8gZG8gdW5jYWNoZWQgYWNjZXNzZXMg
YW5kIGZsdXNoL2ludmFsaWRhdGUNCnNtYWxsIHNlY3Rpb25zIG9mIGNhY2hlLg0KDQpNaW5kIHlv
dSB3ZSBkaWQgZ2V0IGEgZHVhbC1jcHUgc3lzdGVtIHRoYXQgZGlkbid0IGhhdmUgY2FjaGUtY29o
ZXJlbmN5DQpiZXR3ZWVuIHRoZSBjcHVzISBUaGF0IHdhcyBzaW5ndWxhcmx5IHVzZWxlc3MuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

