Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EA8377254
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhEHOUF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 8 May 2021 10:20:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25080 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhEHOUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 May 2021 10:20:03 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-7-Y7zwXQ6EN4uScP4hg-f8Eg-1;
 Sat, 08 May 2021 15:18:58 +0100
X-MC-Unique: Y7zwXQ6EN4uScP4hg-f8Eg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 8 May 2021 15:18:56 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 8 May 2021 15:18:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Vineet Gupta' <vgupta@synopsys.com>,
        'Arnd Bergmann' <arnd@arndb.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 12/12] asm-generic: simplify asm/unaligned.h
Thread-Topic: [RFC 12/12] asm-generic: simplify asm/unaligned.h
Thread-Index: AQHXQ44THJRTTBSqUkSVDsewAlm13qrZaWdAgAA4mTA=
Date:   Sat, 8 May 2021 14:18:56 +0000
Message-ID: <98e7af705bf54b88a99dfec46308bb7a@AcuMS.aculab.com>
References: <20210507220813.365382-1-arnd@kernel.org>
 <20210507220813.365382-13-arnd@kernel.org>
 <0b599cc80612436bb8d688fa2ad1dc34@AcuMS.aculab.com>
In-Reply-To: <0b599cc80612436bb8d688fa2ad1dc34@AcuMS.aculab.com>
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
> Sent: 08 May 2021 12:03
> 
> From: Arnd Bergmann
> > Sent: 07 May 2021 23:08
> >
> > The get_unaligned()/put_unaligned() implementations are much more complex
> > than necessary, now that all architectures use the same code.
> >
> ...
> > +#define __get_unaligned_t(type, ptr) ({						\
> > +	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> > +	__pptr->x; 								\
> > +})
> 
> I thought gcc was likely to track through the alignment of the
> variable holding the source pointer (through any (void *) casts
> implied by inlined function calls) through to the pointer used
> for the actual access - so it would tend to issue a single
> instruction that assumed an aligned address.
> 
> I know that has caused grief trying to copy unaligned data
> to an aligned structure.
> 
> Possibly adding:
> 	asm ("" :: "+r" (__pptr)) );
> in the middle stops that assumption without generating any code.

That is the wrong asm.
You need the one where an input operand and output operand
share the same register and use it for the assignment.

I've been trying to get godbolt to do something useful.
But it seems to be stuck in C++ mode and is missing something like
sparc which definitely doesn't do misaligned accesses.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

