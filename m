Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F11146FC2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWRcM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Jan 2020 12:32:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20905 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbgAWRcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 12:32:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-253-NQWIpuFmOiaG-mYGmDywkg-1; Thu, 23 Jan 2020 17:32:07 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jan 2020 17:32:06 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jan 2020 17:32:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Topic: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Thread-Index: AQHV0gKFFdfdrbkjnU+llP+aeIA9U6f4esgQgAAC9ICAAANF8A==
Date:   Thu, 23 Jan 2020 17:32:06 +0000
Message-ID: <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
In-Reply-To: <20200123171641.GC20126@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: NQWIpuFmOiaG-mYGmDywkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Will Deacon
> Sent: 23 January 2020 17:17
> 
> On Thu, Jan 23, 2020 at 05:07:40PM +0000, David Laight wrote:
> > From: Will Deacon
> > > Sent: 23 January 2020 15:34
> > ...
> > >   * Only warn once at build-time if GCC prior to 4.8 is detected...
> > >
> > >   * ... and then raise the minimum GCC version to 4.8, with an error for
> > >     older versions of the compiler
> >
> > If the kernel compiled with gcc 4.7 is likely to be buggy, don't these
> > need to be in the other order?
> >
> > Otherwise you need to keep the old versions for use with the old
> > compilers.
> 
> I think it depends how much we care about those older compilers. My series
> first moves it to "Good luck mate, you're on your own" and then follows up
> with a "Let me take that off you it's sharp".

Depends on how 'sharp' it is.

If the kernel suffers from the code example in the gcc bug itself
(where 'volatile' is lost and some code is moved out of a loop)
then things will really break somewhere odd.

OTOH if it might generate code that reads something twice
you'd have to be unlucky as well.

Oh - and I need to find a newer compiler :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

