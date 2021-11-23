Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15B45A971
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhKWRCr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 23 Nov 2021 12:02:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:53235 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237077AbhKWRCp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 12:02:45 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-dyIDGajdPWOdiVq8f9AjNQ-1; Tue, 23 Nov 2021 16:58:31 +0000
X-MC-Unique: dyIDGajdPWOdiVq8f9AjNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 16:58:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 16:58:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Thread-Topic: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Thread-Index: AQHX4InVzhztkrNZME2rQ+mb6OtfjawRUyrg
Date:   Tue, 23 Nov 2021 16:58:30 +0000
Message-ID: <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <1618289.1637686052@warthog.procyon.org.uk>
In-Reply-To: <1618289.1637686052@warthog.procyon.org.uk>
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

From: David Howells
> Sent: 23 November 2021 16:48
> 
> Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > long long (unsigned) int to just long (unsigned) int in order to match
> > the uint64_t and int64_t size in userspace.

That is a massive UAPI change you can't do.

> Can you guarantee this won't break anything in userspace?  Granted the types
> *ought* to be the same size, but anyone who's written code on the basis that
> these are "(unsigned) long long int" may suddenly get a bunch of warnings
> where they didn't before from the C compiler.  Anyone using C++, say, may find
> their code no longer compiles because overloaded function matching no longer
> finds a correct match.

Indeed

> Also, whilst your point about PRIu64 and PRId64 modifiers in printf() is a
> good one, it doesn't help someone whose compiler doesn't support that (I don't
> know if anyone's likely to encounter such these days).  At the moment, I think
> a user can assume that %llu will work correctly both on 32-bit and 64-bit on
> all arches, but you're definitely breaking that assumption.

PRIu64 (etc) don't require compiler support, just the correct header file.

I'm pretty sure that portable user code needs to allow for int64_t being
either 'long' or 'long long' on 64bit architectures.
(Indeed 'long' may not even be 64bit.)

On 32bit int32_t can definitely be either 'int' of 'long' at whim.

I'm not sure anyone has tried a 64bit long with a 128bit long-long.
But the C language might lead you to do that.

Of course, fully portable code has to allow for char, short, int and long
all being the same size!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

