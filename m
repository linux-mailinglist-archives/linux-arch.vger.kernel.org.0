Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C621A1EA8B
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEOJA1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 May 2019 05:00:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43254 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfEOJA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 05:00:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-151-LzCPBcH1MgOVKjpg1pcjcg-1; Wed, 15 May 2019 10:00:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 May 2019 10:00:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 May 2019 10:00:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Russell Currey" <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Topic: [PATCH] vsprintf: Do not break early boot with probing addresses
Thread-Index: AQHVB1bC/iTC8Q7sI0elwkZY5/gFJaZowlxwgAEika2AAGmPsIABhHoSgAAVWGA=
Date:   Wed, 15 May 2019 09:00:23 +0000
Message-ID: <0a816ea272a0405f89d8ca7178604531@AcuMS.aculab.com>
References: <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
 <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
 <20190515073542.y6ru2nfagtcrpdl7@pathway.suse.cz>
In-Reply-To: <20190515073542.y6ru2nfagtcrpdl7@pathway.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: LzCPBcH1MgOVKjpg1pcjcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Petr Mladek
> Sent: 15 May 2019 08:36
> On Tue 2019-05-14 14:37:51, Steven Rostedt wrote:
> >
> > [ Purple is a nice shade on the bike shed. ;-) ]
> >
> > On Tue, 14 May 2019 11:02:17 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > > On Tue, May 14, 2019 at 10:29 AM David Laight <David.Laight@aculab.com> wrote:
> > > > > And I like Steven's "(fault)" idea.
> > > > > How about this:
> > > > >
> > > > >       if ptr < PAGE_SIZE              -> "(null)"
> > > > >       if IS_ERR_VALUE(ptr)            -> "(fault)"
> > > > >
> > > > >       -ss
> > > >
> > > > Or:
> > > >         if (ptr < PAGE_SIZE)
> > > >                 return ptr ? "(null+)" : "(null)";
> >
> > Hmm, that is useful.
> >
> > > >         if IS_ERR_VALUE(ptr)
> > > >                 return "(errno)"
> >
> > I still prefer "(fault)" as is pretty much all I would expect from a
> > pointer dereference, even if it is just bad parsing of, say, a parsing
> > an MAC address. "fault" is generic enough. "errno" will be confusing,
> > because that's normally a variable not a output.
> >
> > >
> > > Do we care about the value? "(-E%u)"?
> >
> > That too could be confusing. What would (-E22) be considered by a user
> > doing an sprintf() on some string. I know that would confuse me, or I
> > would think that it was what the %pX displayed, and wonder why it
> > displayed it that way. Whereas "(fault)" is quite obvious for any %p
> > use case.
> 
> This discussion clearly shows that it is hard to make anyone happy.
> 
> I considered switching to "(fault)" because there seems to be more
> people in favor of this.
> 
> But there is used also "(einval)" when an unsupported pointer
> modifier is passed. The idea is to show error codes that people
> are familiar with.
> 
> It might have been better to use the uppercase "(EFAULT)" and
> "(EINVAL)" to make it more obvious. But I wanted to follow
> the existing style with the lowercase "(null)".

Printing 'fault' when the code was (trying to) validate the
address was ok.
When the only check is for an -errno value it seems wrong as
most invalid addresses will actually fault (and panic).

The reason modern printf generate "(null)" is that it is far too
easy for a diagnostic print to fail to test a pointer.
It also makes it easier when 'throwing in' printf while debugging
to add a single trace that will work regardless of whether a
call had succeeded or not.

With the Linux kernel putting errno values into pointers it
seems likely that most invalid pointers in printf will actaully
be error values.
Printing the value will be helpful during debugging - as a
trace can be put after a call and show the parameters and result.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

