Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B335C46B
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhDLKxs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 12 Apr 2021 06:53:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35784 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237944AbhDLKxr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 06:53:47 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-281-A9xhWcd5M3KabBODPhuZXA-1; Mon, 12 Apr 2021 11:53:26 +0100
X-MC-Unique: A9xhWcd5M3KabBODPhuZXA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 11:53:25 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 11:53:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Will Deacon' <will@kernel.org>,
        "'Thomas Bogendoerfer'" <tsbogend@alpha.franken.de>,
        "'James E.J. Bottomley'" <James.Bottomley@HansenPartnership.com>,
        'Helge Deller' <deller@gmx.de>,
        'Michael Ellerman' <mpe@ellerman.id.au>,
        'Heiko Carstens' <hca@linux.ibm.com>,
        'Vasily Gorbik' <gor@linux.ibm.com>,
        "'Christian Borntraeger'" <borntraeger@de.ibm.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'x86@kernel.org'" <x86@kernel.org>,
        'Arnd Bergmann' <arnd@arndb.de>
CC:     "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>,
        "'linux-s390@vger.kernel.org'" <linux-s390@vger.kernel.org>,
        "'linux-parisc@vger.kernel.org'" <linux-parisc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-mips@vger.kernel.org'" <linux-mips@vger.kernel.org>,
        "'sparclinux@vger.kernel.org'" <sparclinux@vger.kernel.org>,
        "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Topic: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Index: AQHXL3nAXViKKuH90kqxIUkBtWSuL6qwmWXwgAATjVA=
Date:   Mon, 12 Apr 2021 10:53:24 +0000
Message-ID: <5c3635a2b44a496b88d665e8686d9436@AcuMS.aculab.com>
References: <20210412085545.2595431-1-hch@lst.de>
 <20210412085545.2595431-6-hch@lst.de>
 <15be19af19174c7692dd795297884096@AcuMS.aculab.com>
In-Reply-To: <15be19af19174c7692dd795297884096@AcuMS.aculab.com>
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

From: David Laight
> Sent: 12 April 2021 10:37
...
> I'm guessing that compat_pid_t is 16 bits?
> So the native 32bit version has an unnamed 2 byte structure pad.
> The 'packed' removes this pad from the compat structure.
> 
> AFAICT (apart from mips) the __ARCH_COMPAT_FLOCK_PAD is just
> adding an explicit pad for the implicit pad the compiler
> would generate because compat_pid_t is 16 bits.

I've just looked at the header.
compat_pid_t is 32 bits.
So Linux must have gained 32bit pids at some earlier time.
(Historically Unix pids were 16 bit - even on 32bit systems.)

Which makes the explicit pad in 'sparc' rather 'interesting'.

Actually the tail pad can just be removed from the compat
structures.
Just a comment that mips and sparc have extra fields
in the uapi header is enough.

The kernel never needs to read/write the pad.
userspace must provide the pad in case the kernel writes it.

oh - compat_loff_t is only used in a couple of other places.
neither care in any way about the alignment.
(Provided get_user() doesn't fault on a 8n+4 aligned address.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

