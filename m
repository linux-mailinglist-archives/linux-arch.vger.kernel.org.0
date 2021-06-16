Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7F3A94E8
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFPI0x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 16 Jun 2021 04:26:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41359 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhFPI0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 04:26:52 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-_scVxX6UNMWzThH1QiY4nA-1; Wed, 16 Jun 2021 09:24:44 +0100
X-MC-Unique: _scVxX6UNMWzThH1QiY4nA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Jun
 2021 09:24:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 16 Jun 2021 09:24:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        Bin Meng <bmeng.cn@gmail.com>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Gary Guo <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Subject: RE: [PATCH 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH 1/3] riscv: optimized memcpy
Thread-Index: AQHXYlOHXkdMIImxVUmoQbZ37iIZIqsWSUKQ
Date:   Wed, 16 Jun 2021 08:24:43 +0000
Message-ID: <db7a011867a742528beb6ec17b692842@AcuMS.aculab.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
        <20210615023812.50885-2-mcroce@linux.microsoft.com>
        <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
        <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
        <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
        <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
        <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
        <CAEUhbmX_wsfU9FfRJoOPE0gjUX=Bp7OZWOZDyMNfO6=M-fX_0A@mail.gmail.com>
 <20210616040132.7fbdf6fe@linux.microsoft.com>
In-Reply-To: <20210616040132.7fbdf6fe@linux.microsoft.com>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce
> Sent: 16 June 2021 03:02
...
> > > That's a good idea, but if you read the replies to Gary's original
> > > patch
> > > https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/
> > > .. both Gary, Palmer and David would rather like a C-based version.
> > > This is one attempt at providing that.
> >
> > Yep, I prefer C as well :)
> >
> > But if you check commit 04091d6, the assembly version was introduced
> > for KASAN. So if we are to change it back to C, please make sure KASAN
> > is not broken.
> >
...
> Leaving out the first memcpy/set of every test which is always slower, (maybe
> because of a cache miss?), the current implementation copies 260 Mb/s when
> the low order bits match, and 114 otherwise.
> Memset is stable at 278 Mb/s.
> 
> Gary's implementation is much faster, copies still 260 Mb/s when euqlly placed,
> and 230 Mb/s otherwise. Memset is the same as the current one.

Any idea what the attainable performance is for the cpu you are using?
Since both memset and memcpy are running at much the same speed
I suspect it is all limited by the writes.

272MB/s is only 34M writes/sec.
This seems horribly slow for a modern cpu.
So is this actually really limited by the cache writes to physical memory?

You might want to do some tests (userspace is fine) where you
check much smaller lengths that definitely sit within the data cache.

It is also worth checking how much overhead there is for
short copies - they are almost certainly more common than
you might expect.
This is one problem with excessive loop unrolling - the 'special
cases' for the ends of the buffer start having a big effect
on small copies.

For cpu that support misaligned memory accesses, one 'trick'
for transfers longer than a 'word' is to do a (probably) misaligned
transfer of the last word of the buffer first followed by the
transfer of the rest of the buffer (overlapping a few bytes at the end).
This saves on conditionals and temporary values.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

