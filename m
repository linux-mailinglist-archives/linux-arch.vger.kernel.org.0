Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28A29AD8B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 14:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbgJ0NjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 27 Oct 2020 09:39:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26104 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752372AbgJ0NjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 09:39:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-143-A6UMcSG6OPSSg5scuWQWag-1; Tue, 27 Oct 2020 13:39:05 +0000
X-MC-Unique: A6UMcSG6OPSSg5scuWQWag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 27 Oct 2020 13:38:59 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 27 Oct 2020 13:38:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] qspinlock: use signed temporaries for cmpxchg
Thread-Topic: [PATCH] qspinlock: use signed temporaries for cmpxchg
Thread-Index: AQHWrEym5bCtH8iWbkWNW0uvsL7xg6mrczUA
Date:   Tue, 27 Oct 2020 13:38:59 +0000
Message-ID: <b26a7469dc1f4c6ca77d994af0bc7505@AcuMS.aculab.com>
References: <20201026165807.3724647-1-arnd@kernel.org>
 <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
 <20201027074726.GX2611@hirez.programming.kicks-ass.net>
 <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
 <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 27 October 2020 10:33
> 
> On Tue, Oct 27, 2020 at 09:33:32AM +0100, Arnd Bergmann wrote:
> > On Tue, Oct 27, 2020 at 8:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Oct 26, 2020 at 02:03:06PM -0400, Waiman Long wrote:
> > > > On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> > > > Yes, it shouldn't really matter if the value is defined as int or u32.
> > > > However, the only caveat that I see is queued_spin_lock_slowpath() is
> > > > expecting a u32 argument. Maybe you should cast it back to (u32) when
> > > > calling it.
> > >
> > > No, we're not going to confuse the code. That stuff is hard enough as it
> > > is. This warning is garbage and just needs to stay off.
> >
> > Ok, so the question then becomes: should we drop -Wpointer-sign from
> > W=2 and move it to W=3, or instead disable it locally. I could add
> > __diag_ignore(GCC, 4, "-Wpointer-sign") in the couple of header files
> > that produce this kind of warning if there is a general feeling that it
> > still helps to have this for drivers.
> 
> What is an actual geniune bug that this warning helps find?
> 
> Note that the kernel relies on -fno-strict-overflow to get rid of the
> signed UB that is otherwise present in C.
> 
> If you add that __diag_ignore() it should go in atomic.h I suppose,
> because all of atomic hard relies on this, and then the question becomes
> how much code is left that doesn't include that header and consequently
> doesn't ignore that warning.
> 
> So, is it useful to begin with in finding actual problems? and given we
> have to annotate away a bucket-load, how much coverage will there remain
> if we squish the known false-positives?

Especially since adding casts just makes the code harder to
read and can easily hide real bugs.

FWIW you might want to try -Wwrite-strings.
That ought to be fixable by sprinkling 'const.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

