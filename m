Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8983AFF06
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVIVd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 22 Jun 2021 04:21:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:48321 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVIVd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Jun 2021 04:21:33 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-282-wLA-a1MnNfeOyAoMKIhy9g-1; Tue, 22 Jun 2021 09:19:14 +0100
X-MC-Unique: wLA-a1MnNfeOyAoMKIhy9g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 09:19:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 09:19:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        "Drew Fustini" <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Guo Ren <guoren@kernel.org>
Subject: RE: [PATCH v3 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH v3 1/3] riscv: optimized memcpy
Thread-Index: AQHXZqmHnPZVnMdu5kGR4HMAzUIzKqsfrz9Q
Date:   Tue, 22 Jun 2021 08:19:13 +0000
Message-ID: <17bb90eef20145cd9cca1b8e72a514ad@AcuMS.aculab.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com>
 <YNChl0tkofSGzvIX@infradead.org>
In-Reply-To: <YNChl0tkofSGzvIX@infradead.org>
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

From: Christoph Hellwig
> Sent: 21 June 2021 15:27
...
> > +		for (next = s.ulong[0]; count >= bytes_long + mask; count -= bytes_long) {
> 
> Please avoid the pointlessly overlong line.  And (just as a matter of
> personal preference) I find for loop that don't actually use a single
> iterator rather confusing.  Wjy not simply:
> 
> 		next = s.ulong[0];
> 		while (count >= bytes_long + mask) {
> 			...
> 			count -= bytes_long;
> 		}

My fist attack on long 'for' statements is just to move the
initialisation to the previous line.
Then make sure there is nothing in the comparison that needs
to be calculated every iteration.
I suspect you can subtract 'mask' from 'count'.
Giving:
		count -= mask;
		next = s.ulong[0];
		for (;; count > bytes_long; count -= bytes_long) {

Next is to shorten the variable names!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

