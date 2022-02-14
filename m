Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C994B5D77
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 23:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiBNWNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 17:13:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiBNWNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 17:13:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A04213DE09
        for <linux-arch@vger.kernel.org>; Mon, 14 Feb 2022 14:13:39 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-3-0IuFZHXpM1-VcUsNfepTpQ-1; Mon, 14 Feb 2022 22:13:36 +0000
X-MC-Unique: 0IuFZHXpM1-VcUsNfepTpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 22:13:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 22:13:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "Brian Cain" <bcain@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH 04/14] x86: use more conventional access_ok() definition
Thread-Topic: [PATCH 04/14] x86: use more conventional access_ok() definition
Thread-Index: AQHYIeHe9n+22PBgtUWxf89GrdwkK6yTmyQw
Date:   Mon, 14 Feb 2022 22:13:34 +0000
Message-ID: <2dda07f893cb4ef9b5ea2265adccb98f@AcuMS.aculab.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org> <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
 <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTQgRmVicnVhcnkgMjAyMiAyMDoyNA0KPiA+
DQo+ID4geDg2LTY0IGhhcyBhbHdheXMoKikgdXNlZCBUQVNLX1NJWkVfTUFYIGZvciBhY2Nlc3Nf
b2soKSwgYW5kIHRoZQ0KPiA+IGdldF91c2VyKCkgYXNzZW1ibGVyIGltcGxlbWVudGF0aW9uIGRv
ZXMgdGhlIHNhbWUuDQo+IA0KPiBTaWRlIG5vdGU6IHdlIGNvdWxkIGp1c3QgY2hlY2sgdGhlIHNp
Z24gYml0IGluc3RlYWQsIGFuZCBhdm9pZCBiaWcNCj4gY29uc3RhbnRzIHRoYXQgd2F5Lg0KDQpU
aGUgY2hlYXAgdGVzdCBmb3IgbW9zdCA2NGJpdCBpcyAoYWRkciB8IHNpemUpID4+IDYyICE9IDAu
DQoNCkkgZGlkIHNvbWUgdGVzdHMgbGFzdCB3ZWVrIGFuZCB0aGUgY29tcGlsZXJzIGNvcnJlY3Rs
eSBvcHRpbWlzZQ0Kb3V0IGNvbnN0YW50IHNpemUuDQoNCkRvZXNuJ3Qgc3BhcmM2NCBzdGlsbCBu
ZWVkIGEgd3JhcCB0ZXN0Pw0KT3IgaXMgdGhhdCBhc3N1bWVkIGJlY2F1c2UgdGhlcmUgaXMgYWx3
YXlzIGFuIHVubWFwcGVkIHBhZ2UNCmFuZCB0cmFuc2ZlciBhcmUgJ2FkZXF1YXRlbHknIGRvbmUg
b24gaW5jcmVhc2luZyBhZGRyZXNzZXM/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

