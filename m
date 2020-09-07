Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4725F59D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgIGItd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 7 Sep 2020 04:49:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37291 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbgIGItc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 04:49:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-5zmwIGe8NUucU3bez4pxOg-1; Mon, 07 Sep 2020 09:49:28 +0100
X-MC-Unique: 5zmwIGe8NUucU3bez4pxOg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Sep 2020 09:49:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Sep 2020 09:49:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Using asm_volatile_goto for get_user()
Thread-Topic: Using asm_volatile_goto for get_user()
Thread-Index: AdaE8q1aQOesIAbfTka1rFFrCf3mnA==
Date:   Mon, 7 Sep 2020 08:49:27 +0000
Message-ID: <39a56b046b104566922dd0d0ce7f794a@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I had an idea that might let 'asm_volatile_goto' be used for
get_user() even though gcc doesn't allow outputs.

What if (eg) 'register eax asm ("eax") is used for the
output and (probably) given in the 'clobber' list.

Such variables are usually used to get explicit registers
used when there is no suitable constraint.
I don't see why it shouldn't work for 'asm goto' as well
as just 'asm'.

While this forces the read value into a specific register
that probably doesn't make much difference to the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

