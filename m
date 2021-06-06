Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAC39CF40
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFFNGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 09:06:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:44515 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhFFNGG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 09:06:06 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156CxvIK028160;
        Sun, 6 Jun 2021 07:59:57 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156CxtIb028148;
        Sun, 6 Jun 2021 07:59:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 07:59:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20210606125955.GT18427@gate.crashing.org>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com> <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com> <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> On Sat, Jun 5, 2021 at 6:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Interesting.  And changing one of the branches from barrier() to __asm__
> > __volatile__("nop": : :"memory") also causes a branch to be emitted.  So
> > even though the compiler doesn't "look inside" assembly code, it does
> > compare two pieces at least textually and apparently assumes if they are
> > identical then they do the same thing.
> 
> That's actually a feature in some cases, ie the ability to do CSE on
> asm statements (ie the "always has the same output" optimization that
> the docs talk about).
> 
> So gcc has always looked at the asm string for that reason, afaik.

GCC does not pretend it can understand the asm.  But it can see when
two asm statements are identical.

> I think it's something of a bug when it comes to "asm volatile", but
> the documentation isn't exactly super-specific.

Why would that be?  "asm volatile" does not prevent optimisation.  It
says this code has some unspecified side effect, and that is all!  All
the usual C rules cover everything needed: the same side effects have to
be executed in the same order on the real machine as they would on the
abstract machine.

> There is a statement of "Under certain circumstances, GCC may
> duplicate (or remove duplicates of) your assembly code when
> optimizing" and a suggestion of using "%=" to generate a unique
> instance of an asm.

"%=" outputs a number unique for every output instruction (the whole asm
is one instruction; these are GCC internal instructions, not the same
thing as machine instructions).  This will not help here.  The actual
thing the manual says is
  Under certain circumstances, GCC may duplicate (or remove duplicates
  of) your assembly code when optimizing.  This can lead to unexpected
  duplicate symbol errors during compilation if your 'asm' code defines
  symbols or labels.  Using '%=' may help resolve this problem.
It helps prevent duplicated symbols and labels.  It does not do much
else.

> Which might actually be a good idea for "barrier()", just in case.
> However, the problem with that is that I don't think we are guaranteed
> to have a universal comment character for asm statements.

That's right.  But ";#" works on most systems, you may be able to use
that?

> IOW, it might be a good idea to do something like
> 
>    #define barrier() \
>         __asm__ __volatile__("# barrier %=": : :"memory")
> 
> but I'm  not 100% convinced that '#' is always a comment in asm code,
> so the above might not actually build everywhere.

Some assemblers use ";", some use "!", and there are more variations.

But this will not do what you want.  "%=" is output as a unique number
*after* everything GCC has done with the asm.

> However, *testing* the above (in my config, where '#' does work as a
> comment character) shows that gcc doesn't actually consider them to be
> distinct EVEN THEN, and will still merge two barrier statements.

Yes, the insns have the same templates, will output the exact same to
the generated assembler code, so are CSEd.

> So the gcc docs are actively wrong, and %= does nothing - it will
> still compare as the exact same inline asm, because the string
> equality testing is apparently done before any expansion.

They are not wrong.  Maybe the doc could be clearer though?  Patches
welcome.

> Something like this *does* seem to work:
> 
>    #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
>    #define __barrier(id) ____barrier(id)
>    #define barrier() __barrier(__COUNTER__)
> 
> which is "interesting" or "disgusting" depending on how you happen to feel.

__COUNTER__ is a preprocessor thing, much more like what you want here:
this does its work *before* everything the compiler does, while %= does
its thing *after* :-)

(Not that I actually understand what you are trying to do with this).


Segher
