Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDFE39D0FB
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFFTZT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 15:25:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:38735 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFFTZS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 15:25:18 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156JJABB011187;
        Sun, 6 Jun 2021 14:19:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156JJ9oV011186;
        Sun, 6 Jun 2021 14:19:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 14:19:09 -0500
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
Message-ID: <20210606191909.GZ18427@gate.crashing.org>
References: <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com> <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606125955.GT18427@gate.crashing.org> <CAHk-=wgPUaj7tv-JYzKQ34ukP3LEuGf82g+Nyp96pTnxN=xOtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPUaj7tv-JYzKQ34ukP3LEuGf82g+Nyp96pTnxN=xOtA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 11:25:46AM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 6:03 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> > >
> > > I think it's something of a bug when it comes to "asm volatile", but
> > > the documentation isn't exactly super-specific.
> >
> > Why would that be?  "asm volatile" does not prevent optimisation.
> 
> Sure it does.
> 
> That's the whole and only *POINT* of the "volatile".
> 
> It's the same as a vol;atile memory access. That very much prevents
> certain optimizations. You can't just join two volatile reads or
> writes, because they have side effects.

You can though.  In exactly this same way:

volatile int x;
void g(int);
void f(int n) { if (n) g(x); else g(x); }

==>

f:
        movl    x(%rip), %edi
        jmp     g

You can do whatever you want with code with side effects.  The only
thing required is that the side effects are executed as often as before
and in the same order.  Merging identical sides of a diamond is just
fine.

> And the exact same thing is true of inline asm. Even when they are
> *identical*, inline asms have side effects that gcc simply doesn't
> understand.

Only volatile asm does (including all asm without outputs).  But that
still does not mean GCC cannot manipulate the asm!

> And yes, those side effects can - and do - include "you can't just merge these".

They do not.  That is not what a side effect is.

> > It says this code has some unspecified side effect, and that is all!
> 
> And that should be sufficient. But gcc then violates it, because gcc
> doesn't understand the side effects.
> 
> Now, the side effects may be *subtle*, but they are very very real.
> Just placement of code wrt a branch will actually affect memory
> ordering, as that one example was.

You have a different definition of "side effect" than C does apparently.

5.1.2.3/2:
  Accessing a volatile object, modifying an object, modifying a file, or
  calling a function that does any of those operations are all side
  effects, which are changes in the state of the execution environment.
  Evaluation of an expression in general includes both value
  computations and initiation of side effects.  Value computation for an
  lvalue expression includes determining the identity of the designated
  object.

> But that's what we need a compiler barrier for in the first place -
> the compiler certainly doesn't understand about this very subtle
> memory ordering issue, and we want to make sure that the code sequence
> *remains* that "if A then write B".

The compiler doesn't magically understand your intention, no.  Some real
work will need to be done to make this work.


Segher
