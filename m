Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8435C287
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhDLJp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 12 Apr 2021 05:45:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:28226 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239556AbhDLJhp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 05:37:45 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-82-C7COxs-EPmWmM_DfUiqZhw-1; Mon, 12 Apr 2021 10:37:23 +0100
X-MC-Unique: C7COxs-EPmWmM_DfUiqZhw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Apr 2021 10:37:22 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 10:37:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Topic: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Index: AQHXL3nAXViKKuH90kqxIUkBtWSuL6qwmWXw
Date:   Mon, 12 Apr 2021 09:37:21 +0000
Message-ID: <15be19af19174c7692dd795297884096@AcuMS.aculab.com>
References: <20210412085545.2595431-1-hch@lst.de>
 <20210412085545.2595431-6-hch@lst.de>
In-Reply-To: <20210412085545.2595431-6-hch@lst.de>
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
> Sent: 12 April 2021 09:56
> 
> Provide a single common definition for the compat_flock and
> compat_flock64 structures using the same tricks as for the native
> variants.  An extra define is added for the packing required on x86.
> 
...
>  /*
> - * IA32 uses 4 byte alignment for 64 bit quantities,
> - * so we need to pack this structure.
> + * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
> + * compat flock64 structure.
>   */
> -struct compat_flock64 {
> -	short		l_type;
> -	short		l_whence;
> -	compat_loff_t	l_start;
> -	compat_loff_t	l_len;
> -	compat_pid_t	l_pid;
> -} __attribute__((packed));
> +#define __ARCH_NEED_COMPAT_FLOCK64_PACKED

That shouldn't need to be packed at all.
(Since the 32bit variant isn't packed.)

compat_loff_t should itself have __attribute__((aligned(4)))
probably inherited from compat_s64.
So l_start will be at offset 4 without the __packed.

I'm guessing that compat_pid_t is 16 bits?
So the native 32bit version has an unnamed 2 byte structure pad.
The 'packed' removes this pad from the compat structure.

AFAICT (apart from mips) the __ARCH_COMPAT_FLOCK_PAD is just
adding an explicit pad for the implicit pad the compiler
would generate because compat_pid_t is 16 bits.

If the padding need not be named for the 64bit system calls.
(Where there is probably rather more padding all over the place.)
then it doesn't need to be named for the compat variants.

Even the mips extra padding could be removed.
F_GETLK might be expected to do a read-write of them, so
return EFAULT if not mapped.
But nothing should be testing the EFAULT is returned!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

