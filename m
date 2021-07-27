Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249B13D7166
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhG0Iog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 27 Jul 2021 04:44:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56168 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235885AbhG0Iog (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 04:44:36 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-2-V9oMQAtEOq6BFHQKDsaWeQ-1; Tue, 27 Jul 2021 09:44:23 +0100
X-MC-Unique: V9oMQAtEOq6BFHQKDsaWeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 27 Jul 2021 09:44:21 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 27 Jul 2021 09:44:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sven Eckelmann' <sven@narfation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Thread-Topic: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Thread-Index: AQHXgKmQSnOHUxbKO0+Mz34J8bnrJ6tWhKAw
Date:   Tue, 27 Jul 2021 08:44:21 +0000
Message-ID: <bb831fbad4f74e11b868d936f7616d1a@AcuMS.aculab.com>
References: <20210724162429.394792-1-sven@narfation.org>
In-Reply-To: <20210724162429.394792-1-sven@narfation.org>
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

From: Sven Eckelmann
> Sent: 24 July 2021 17:24
> 
> Sparse will try to check casting of simple integer types which are marked
> as __bitwise. This for example "disallows" simple casting of __be{16,32,64}
> or __le{16,32,64} to other types. This is also true for pointers to
> variables with this type.
> 
> But the new generic {get,put}_unaligned is doing that by (reinterpret)
> casting the original pointer to a new (anonymous) struct pointer. This will
> then create warnings like:
> 
>   net/batman-adv/distributed-arp-table.c:1461:19: warning: cast from restricted __be32 *
>   net/batman-adv/distributed-arp-table.c:1510:23: warning: cast from restricted __be32 [usertype]
> *[assigned] magic
>   net/batman-adv/distributed-arp-table.c:1588:24: warning: cast from restricted __be32 [usertype]
> *[assigned] yiaddr
> 
> The special attribute force must be used in such statements when the cast
> is known to be safe to avoid these warnings.

At least the __force is being added to an existing cast.

The real problems are when a (__force __le32)value cast is used
to silence sparse.
These should really be something like:
	__tell_sparce(__le32, value)
so that the whole thing can be removed by the preprocessor when
compiling the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

