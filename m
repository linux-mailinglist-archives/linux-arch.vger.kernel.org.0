Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9737717B
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhEHLnU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 8 May 2021 07:43:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39842 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEHLnT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 May 2021 07:43:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-30-pslduLlcNaOjNqxPJEEhyg-1; Sat, 08 May 2021 12:42:15 +0100
X-MC-Unique: pslduLlcNaOjNqxPJEEhyg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 8 May 2021 12:42:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 8 May 2021 12:42:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 02/12] openrisc: always use unaligned-struct header
Thread-Topic: [RFC 02/12] openrisc: always use unaligned-struct header
Thread-Index: AQHXQ42+sCloTJU1UUOieiWkxU7/TarZco2w
Date:   Sat, 8 May 2021 11:42:13 +0000
Message-ID: <7f2ca7e366a444108932c4c3bb95c2f9@AcuMS.aculab.com>
References: <20210507220813.365382-1-arnd@kernel.org>
 <20210507220813.365382-3-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-3-arnd@kernel.org>
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

From: Arnd Bergmann
> Sent: 07 May 2021 23:08
...
> I don't know how the loads/store perform compared to the shift version
> on a particular microarchitecture, but my guess is that the shifts
> are better.

What does the nios use?
Shifts generate reasonable code for put_unaligned() but
they get horrid for get_unaligned().

On the nios writing the 4 bytes to memory and reading back
a 32bit value should generate shorter faster code.
You do need to generate 4 byte loads, 4 bytes stores, 32bit load.
(The load will cause a stall if the data is needed for one
of the next two instructions, and there is a (undocumented)
stall between a write and read to the same memory area.
The shift version requires 3 shifts and 3 ors - but I think
gcc makes a bigger pig's breakfast of it.)

OTOH I'm not sure anyone in their right mind would run Linux on nios.
It is a soft cpu for the altera (now intel) fpgas.
We use them with 4k code and sub 64k data for real time processing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

