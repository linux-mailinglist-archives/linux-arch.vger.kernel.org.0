Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3139D6A9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFGIDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 04:03:34 -0400
Received: from mail.ispras.ru ([83.149.199.84]:44152 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhFGIDe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 04:03:34 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id D692440594EB;
        Mon,  7 Jun 2021 08:01:39 +0000 (UTC)
Date:   Mon, 7 Jun 2021 11:01:39 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
In-Reply-To: <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com> <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 6 Jun 2021, Linus Torvalds wrote:

> On Sun, Jun 6, 2021 at 2:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> >
> > > So yeah, that seems like a nice solution to the issue, and should make
> > > the barriers all unique to the compiler.
> >
> > It also plants a nice LTO time-bomb (__COUNTER__ values will be unique
> > only within each LTO input unit, not across all of them).
> 
> That could be an issue in other circumstances, but for at least
> volatile_if() that doesn't much matter. The decision there is purely
> local, and it's literally about the two sides of the conditional not
> being merged.
> 
> Now, an optimizing linker or assembler can of course do anything at
> all in theory: and if that ends up being an issue we'd have to have
> some way to actually propagate the barrier from being just a compiler
> thing. Right now gcc doesn't even output the barrier in the assembly
> code, so it's invisible to any optimizing assembler/linker thing.
> 
> But I don't think that's an issue with what _currently_ goes on in an
> assembler or linker - not even a smart one like LTO.
> 
> And such things really are independent of "volatile_if()". We use
> barriers for other things where we need to force some kind of
> operation ordering, and right now the only thing that re-orders
> accesses etc is the compiler.

Uhh... I was not talking about some (non-existent) "optimizing linker".
LTO works by relaunching the compiler from the linker and letting it
consume multiple translation units (which are fully preprocessed by that
point). So the very thing you wanted to avoid -- such barriers appearing
in close proximity where they can be deduplicated -- may arise after a
little bit of cross-unit inlining.

My main point here is that using __COUNTER__ that way (making things
"unique" for the compiler) does not work in general when LTO enters the
picture. As long as that is remembered, I'm happy.

> Btw, since we have compiler people on line, the suggested 'barrier()'
> isn't actually perfect for this particular use:
> 
>    #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> 
> in the general barrier case, we very much want to have that "memory"
> clobber, because the whole point of the general barrier case is that
> we want to make sure that the compiler doesn't cache memory state
> across it (ie the traditional use was basically what we now use
> "cpu_relax()" for, and you would use it for busy-looping on some
> condition).
> 
> In the case of "volatile_if()", we actually would like to have not a
> memory clobber, but a "memory read". IOW, it would be a barrier for
> any writes taking place, but reads can move around it.
> 
> I don't know of any way to express that to the compiler. We've used
> hacks for it before (in gcc, BLKmode reads turn into that kind of
> barrier in practice, so you can do something like make the memory
> input to the asm be a big array). But that turned out to be fairly
> unreliable, so now we use memory clobbers even if we just mean "reads
> random memory".

So the barrier which is a compiler barrier but not a machine barrier is
__atomic_signal_fence(model), but internally GCC will not treat it smarter
than an asm-with-memory-clobber today.

> Example: variable_test_bit(), which generates a "bt" instruction, does
> 
>                      : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> 
> and the memory clobber is obviously wrong: 'bt' only *reads* memory,
> but since the whole reason we use it is that it's not just that word
> at address 'addr', in order to make sure that any previous writes are
> actually stable in memory, we use that "memory" clobber.
> 
> It would be much nicer to have a "memory read" marker instead, to let
> the compiler know "I need to have done all pending writes to memory,
> but I can still cache read values over this op because it doesn't
> _change_ memory".
> 
> Anybody have ideas or suggestions for something like that?

In the specific case of 'bt', the offset cannot be negative, so I think you
can simply spell out the extent of the array being accessed:

    : "m" *(unsigned long (*)[-1UL / 8 / sizeof(long) + 1])addr

In the general case (possibility of negative offsets, or no obvious base to
supply), have you considered adding a "wild read" through a char pointer
that is initialized in a non-transparent way? Like this:

  char *wild_pointer;

  asm(""
      : "=X"(wild_pointer)
      : "X"(base1)
      , "X"(base2)); // unknown value related to given base pointers

  asm("pattern"
      : // normal outputs
      : // normal inputs
      , "m"(*wild_pointer));

The "X" constraint in theory should not tie up neither a register nor a stack
slot.

Alexander
