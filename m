Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5239BF9D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDSby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 14:31:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:39809 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFDSby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 14:31:54 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154IPkRL003330;
        Fri, 4 Jun 2021 13:25:46 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154IPjK0003329;
        Fri, 4 Jun 2021 13:25:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 13:25:44 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604182544.GK18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com> <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net> <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com> <20210604172407.GJ18427@gate.crashing.org> <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Fri, Jun 04, 2021 at 10:38:43AM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 10:27 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > > Of course, we might want to make sure that the compiler doesn't go
> > > "oh, empty asm, I can ignore it",
> >
> > It isn't allowed to do that.  GCC has this arguable misfeature where it
> > doesn't show empty asm in the assembler output, but that has no bearing
> > on anything but how human-readable the output is.
> 
> That sounds about right, but we have had people talking about the
> compiler looking inside the asm string before.
> 
> So it worries me that some compiler person might at some point go all
> breathy-voice on us and say "I am altering the deal. Pray I don't
> alter it any further".

GCC will never do that.  And neither will any other compiler that claims
to implement the GCC asm extensions, if they are true to their word.

GCC *does* look inside the assembler template to estimate what code size
this asm will generate, and it tries to be pessimistic about its
estimate so that this will always work, but it always is possible to
mislead the compiler here, precisely because it does not actually
pretend it understands assembler code (think .irp or anything with
assembler macros for example).  In very rare cases this leads to
(assembler) errors ("jump target out of range", that kind of thing).
The most effective workaround is to write less silly code ;-)  And of
course this is documented, see
<https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html>

> Side note: when grepping for what "barrier()" does on different
> architectures and different compilers, I note that yes, it really is
> just an empty asm volatile with a "memory" barrier. That should in all
> way sbe sufficient.
> 
> BUT.
> 
> There's this really odd comment in <linux/compiler-intel.h> that talks
> about some "ECC" compiler:
> 
>   /* Intel ECC compiler doesn't support gcc specific asm stmts.
>    * It uses intrinsics to do the equivalent things.
>    */
> 
> and it defines it as "__memory_barrier()". This seems to be an ia64 thing, but:

"ecc" apparently was "icc" but for Itanium.  It ceased to exist some
time in the 2.4 era apparently.  It was still used in 2003.  Searching
for "ecpc" (the C++ compiler driver) will find a bit more.

>  - I cannot get google to find me any documentation on such an intrinsic
> 
>  - it seems to be bogus anyway, since we have "asm volatile" usage in
> at least arch/ia64/mm/tlb.c
> 
> So I do note that "barrier()" has an odd definition in one odd ia64
> case, and I can't find the semantics for it.
> 
> Admittedly I also cannot find it in myself to care.

Yeah, I love code archaeology, but I have work to do as well :-)

> I don't think that
> "Intel ECC" compiler case actually exists, and even if it does I don't
> think itanium is relevant any more. But it was an odd detail on what
> "barrier()" actually might mean to the compiler.

:-)


Segher
