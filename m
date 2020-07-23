Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7E22AAA0
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGWI3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Jul 2020 04:29:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21727 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbgGWI3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 04:29:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-yLbMdh2jNnOD6IwmQddN9g-1; Thu, 23 Jul 2020 09:29:03 +0100
X-MC-Unique: yLbMdh2jNnOD6IwmQddN9g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 09:29:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jul 2020 09:29:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Topic: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Index: AQHWX51MlcPCEWebQUuN/OB/armWnKkTU0FggABJU4CAABlpkP//+uQAgAAU8xCAAAgogIABBOPg
Date:   Thu, 23 Jul 2020 08:29:02 +0000
Message-ID: <b8c5cecfcbad428a9146bd01ad7d03c7@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
 <20200722173903.GG2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200722173903.GG2786714@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro
> Sent: 22 July 2020 18:39
> On Wed, Jul 22, 2020 at 04:17:02PM +0000, David Laight wrote:
> > > David, do you *ever* bother to RTFS?  I mean, competent supercilious twits
> > > are annoying, but at least with those you can generally assume that what
> > > they say makes sense and has some relation to reality.  You, OTOH, keep
> > > spewing utter bollocks, without ever lowering yourself to checking if your
> > > guesses have anything to do with the reality.  With supercilious twit part
> > > proudly on the display - you do speak with confidence, and the way you
> > > dispense the oh-so-valuable advice to everyone around...
> >
> > Yes, I do look at the code.
> > I've actually spent a lot of time looking at the x86 checksum code.
> > I've posted a patch for a version that is about twice as fast as the
> > current one on a large range of x86 cpus.
> >
> > Possibly I meant the 32bit reduction inside csum_add()
> > rather than what csum_fold() does.
> 
> Really?
> static inline unsigned add32_with_carry(unsigned a, unsigned b)
> {
>         asm("addl %2,%0\n\t"
>             "adcl $0,%0"
>             : "=r" (a)
>             : "0" (a), "rm" (b));
>         return a;
> }

I agree it isn't much, but both those instructions almost certainly
get replicated with the initial value fed into the checksum function.

Everything except x86, sparc/64 and powerpc/64 uses the C code
from include/net/checksum.h which is the longer sequences:
	csum += addend;
	csum += csum < addend;
That's three instructions on something like MIPS - not too bad.
I'm not sure about ARM - ARM could probably use adc.
Some architectures may end up with an actual conditional jump.

Quite how the instructions get scheduled probably makes more
difference.
The sequence is a register dependency chain, and the checksum
register could easily be limiting the execution speed.
On x86 the 'adc' loop runs at two clocks per adc on a wide
range of Intel cpus.

Actually there is lot more to be gained in the code that reads
the iovec[] from userspace.
The calling sequences for the two nexted functions used are horrid.
Fixing that does make a measurable difference to semdmsg().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

