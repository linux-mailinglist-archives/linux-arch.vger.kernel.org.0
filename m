Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33CB48AAD3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 10:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiAKJwW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Jan 2022 04:52:22 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45546 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237038AbiAKJwV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jan 2022 04:52:21 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-rXUlX-ehMDyIXirCKi7aCg-1; Tue, 11 Jan 2022 09:52:18 +0000
X-MC-Unique: rXUlX-ehMDyIXirCKi7aCg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 09:52:18 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 11 Jan 2022 09:52:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
CC:     Guo Ren <guoren@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Topic: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Thread-Index: AQHYBsZBTBglXUWeOki+cPQc77mslqxdkbpw
Date:   Tue, 11 Jan 2022 09:52:17 +0000
Message-ID: <f69d570127db4f78a6b30e1775a020c4@AcuMS.aculab.com>
References: <20220111083515.502308-1-hch@lst.de>
 <20220111083515.502308-6-hch@lst.de>
In-Reply-To: <20220111083515.502308-6-hch@lst.de>
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
> Sent: 11 January 2022 08:35
> 
> Provide a single common definition for the compat_flock and
> compat_flock64 structures using the same tricks as for the native
> variants.  Another extra define is added for the packing required on
> x86.
> 
...
>  /*
> - * IA32 uses 4 byte alignment for 64 bit quantities,
> - * so we need to pack this structure.
> + * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
> + * compat flock64 structure.
>   */
...
> +#define __ARCH_NEED_COMPAT_FLOCK64_PACKED

Maybe:
#define __ARCH_COMPAT_FLOCK64_ATTR (packed),(aligned(4)

...
Delete this bit:
> +#ifdef __ARCH_NEED_COMPAT_FLOCK64_PACKED
> +#define __ARCH_COMPAT_FLOCK64_PACK	__attribute__((packed))
> +#else
> +#define __ARCH_COMPAT_FLOCK64_PACK
> +#endif
...
> +struct compat_flock64 {
> +	short		l_type;
> +	short		l_whence;
> +	compat_loff_t	l_start;
> +	compat_loff_t	l_len;
> +	compat_pid_t	l_pid;
> +#ifdef __ARCH_COMPAT_FLOCK64_PAD
> +	__ARCH_COMPAT_FLOCK64_PAD
> +#endif
> +} __ARCH_COMPAT_FLOCK64_PACK;

then:
#ifdef __ARCH_COMPAT_FLOCK64_ATTR
} __attribute__(__ARCH_COMPAT_FLOCK64_ATTR);
#else
};
#endif

Makes it a bit more like the xxx_PAD bits.
Although the trailing ; does cause a bit of grief.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

