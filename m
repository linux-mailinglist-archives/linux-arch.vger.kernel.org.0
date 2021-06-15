Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C902D3A79A6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFOI7P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 15 Jun 2021 04:59:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57063 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhFOI7P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 04:59:15 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-ED9ugU7XN0-kOTjofplO1Q-1; Tue, 15 Jun 2021 09:57:08 +0100
X-MC-Unique: ED9ugU7XN0-kOTjofplO1Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 09:57:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 15 Jun 2021 09:57:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH 1/3] riscv: optimized memcpy
Thread-Index: AQHXYY/3XkdMIImxVUmoQbZ37iIZIqsUw3ig
Date:   Tue, 15 Jun 2021 08:57:07 +0000
Message-ID: <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com>
In-Reply-To: <20210615023812.50885-2-mcroce@linux.microsoft.com>
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
> Sent: 15 June 2021 03:38
> 
> Write a C version of memcpy() which uses the biggest data size allowed,
> without generating unaligned accesses.

I'm surprised that the C loop:

> +		for (; count >= bytes_long; count -= bytes_long)
> +			*d.ulong++ = *s.ulong++;

ends up being faster than the ASM 'read lots' - 'write lots' loop.

Especially since there was an earlier patch to convert
copy_to/from_user() to use the ASM 'read lots' - 'write lots' loop
instead of a tight single register copy loop.

I'd also guess that the performance needs to be measured on
different classes of riscv cpu.

A simple cpu will behave differently to one that can execute
multiple instructions per clock.
Any form of 'out of order' execution also changes things.
The other big change is whether the cpu can to a memory
read and write in the same clock.

I'd guess that riscv exist with some/all of those features.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

