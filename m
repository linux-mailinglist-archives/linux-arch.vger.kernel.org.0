Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2801130AC41
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBAQEw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 1 Feb 2021 11:04:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55286 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhBAQEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2021 11:04:16 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-126-PcACmDPgN8eBY-riyOM1Ww-2; Mon, 01 Feb 2021 16:02:34 +0000
X-MC-Unique: PcACmDPgN8eBY-riyOM1Ww-2
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Feb 2021 16:02:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Feb 2021 16:02:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
CC:     "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        "Wei Yang" <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH 7/8] lib: add fast path for find_next_*_bit()
Thread-Topic: [PATCH 7/8] lib: add fast path for find_next_*_bit()
Thread-Index: AQHW+KGAlZZqB0fkUkaHyblyx7z9eqpDdQ9g
Date:   Mon, 1 Feb 2021 16:02:30 +0000
Message-ID: <e9c66d506a614a7e95d039bea325c241@AcuMS.aculab.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-8-yury.norov@gmail.com>
 <YBgG35UTDLpVSYWV@smile.fi.intel.com>
In-Reply-To: <YBgG35UTDLpVSYWV@smile.fi.intel.com>
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

From: Andy Shevchenko
> Sent: 01 February 2021 13:49
> 
> On Sat, Jan 30, 2021 at 11:17:18AM -0800, Yury Norov wrote:
> > Similarly to bitmap functions, find_next_*_bit() users will benefit
> > if we'll handle a case of bitmaps that fit into a single word. In the
> > very best case, the compiler may replace a function call with a
> > single ffs or ffz instruction.
> 
> Would be nice to have the examples how it reduces the actual code size (based
> on the existing code in kernel, especially in widely used frameworks /
> subsystems, like PCI).

I bet it makes the kernel bigger but very slightly faster.
But the fact that the wrappers end up in the i-cache may
mean that inlining actually makes it slower for some calling
sequences.

If a bitmap fits in a single word (as a compile-time constant)
then you should (probably) be using different functions if
you care about performance.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

