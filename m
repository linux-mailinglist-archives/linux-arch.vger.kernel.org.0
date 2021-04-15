Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1802360FE6
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhDOQLB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 15 Apr 2021 12:11:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39366 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234032AbhDOQLA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 12:11:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-HfpTzEDNMauzyMEgPNRP_g-1; Thu, 15 Apr 2021 17:10:34 +0100
X-MC-Unique: HfpTzEDNMauzyMEgPNRP_g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 17:10:33 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 15 Apr 2021 17:10:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Niklas Schnelle' <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] sparc: explicitly set PCI_IOBASE to 0
Thread-Topic: [PATCH v2 1/2] sparc: explicitly set PCI_IOBASE to 0
Thread-Index: AQHXMfQU/v+fCAtEaUGryS2VPWnQoKq1vegA
Date:   Thu, 15 Apr 2021 16:10:33 +0000
Message-ID: <af5f3d8390654abda295860c756cb687@AcuMS.aculab.com>
References: <20210415123700.3030728-1-schnelle@linux.ibm.com>
 <20210415123700.3030728-2-schnelle@linux.ibm.com>
In-Reply-To: <20210415123700.3030728-2-schnelle@linux.ibm.com>
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

From: Niklas Schnelle
> Sent: 15 April 2021 13:37
> 
> Instead of relying on the fallback in asm-generic/io.h which sets
> PCI_IOBASE 0 if it is not defined set it explicitly.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/sparc/include/asm/io.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
> index 2eefa526b38f..100992ba1317 100644
> --- a/arch/sparc/include/asm/io.h
> +++ b/arch/sparc/include/asm/io.h
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef ___ASM_SPARC_IO_H
>  #define ___ASM_SPARC_IO_H
> +
> +/* On LEON I/O Space is accessed through low iomem */
> +#define PCI_IOBASE ((void __iomem *)0)
> +
>  #if defined(__sparc__) && defined(__arch64__)
>  #include <asm/io_64.h>
>  #else
> --
> 2.25.1

Not sure the comment is informative enough.
Maybe something like:

/*
 * On LEON PCI addresses below 64k are converted to IO accesses.
 * io_remap_xxx() (whatever is it called) returns a kernel virtual
 * address in the PCI window so inb() doesn't need to add an offset.
 */

That'll save the next person doing a lot of digging.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

