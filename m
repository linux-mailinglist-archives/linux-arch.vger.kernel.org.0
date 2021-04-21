Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA33669E1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhDULZZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 21 Apr 2021 07:25:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47377 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234152AbhDULZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 07:25:24 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-145-Cn1hkKd9P9uw5RfL9DWEDg-1; Wed, 21 Apr 2021 12:24:48 +0100
X-MC-Unique: Cn1hkKd9P9uw5RfL9DWEDg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 21 Apr 2021 12:24:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 21 Apr 2021 12:24:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Niklas Schnelle' <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] asm-generic/io.h: Silence
 -Wnull-pointer-arithmetic warning on PCI_IOBASE
Thread-Topic: [PATCH v3 3/3] asm-generic/io.h: Silence
 -Wnull-pointer-arithmetic warning on PCI_IOBASE
Thread-Index: AQHXNqAK6EZxeEzVYUmXQlgF5xc7+Kq+079Q
Date:   Wed, 21 Apr 2021 11:24:47 +0000
Message-ID: <bb21141706d7477794453f7f52f6bc98@AcuMS.aculab.com>
References: <20210421111759.2059976-1-schnelle@linux.ibm.com>
 <20210421111759.2059976-4-schnelle@linux.ibm.com>
In-Reply-To: <20210421111759.2059976-4-schnelle@linux.ibm.com>
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
> Sent: 21 April 2021 12:18
> 
> When PCI_IOBASE is not defined, it is set to 0 such that it is ignored
> in calls to the readX/writeX primitives. This triggers clang's
> -Wnull-pointer-arithmetic warning and will result in illegal accesses on
> platforms that do not support I/O ports if drivers do still attempt to
> access them.
> 
> Make things explicit and silence the warning by letting inb() and
> friends fail with WARN_ONCE() and a 0xff... return in case PCI_IOBASE is
> not defined.
...
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index c6af40ce03be..aabb0a8186ee 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
...
> @@ -458,12 +454,17 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
>  #define _inb _inb
>  static inline u8 _inb(unsigned long addr)
>  {
> +#ifdef PCI_IOBASE
>  	u8 val;
> 
>  	__io_pbr();
>  	val = __raw_readb(PCI_IOBASE + addr);
>  	__io_par(val);
>  	return val;
> +#else
> +	WARN_ONCE(1, "No I/O port support\n");
> +	return ~0;
> +#endif
>  }
>  #endif

I suspect that this might be better not inlined
when PCI_IOBASE is undefined.

Otherwise you get quite a lot of bloat from all the
WARN_ONCE() calls.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

