Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B339D07A
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFFSnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:43:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41493 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229764AbhFFSnk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:43:40 -0400
Received: (qmail 1742359 invoked by uid 1000); 6 Jun 2021 14:41:50 -0400
Date:   Sun, 6 Jun 2021 14:41:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20210606184150.GA1742067@rowland.harvard.edu>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> On Sat, Jun 5, 2021 at 6:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
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
> 
> I think it's something of a bug when it comes to "asm volatile", but
> the documentation isn't exactly super-specific.
> 
> There is a statement of "Under certain circumstances, GCC may
> duplicate (or remove duplicates of) your assembly code when
> optimizing" and a suggestion of using "%=" to generate a unique
> instance of an asm.
> 
> Which might actually be a good idea for "barrier()", just in case.
> However, the problem with that is that I don't think we are guaranteed
> to have a universal comment character for asm statements.
> 
> IOW, it might be a good idea to do something like
> 
>    #define barrier() \
>         __asm__ __volatile__("# barrier %=": : :"memory")
> 
> but I'm  not 100% convinced that '#' is always a comment in asm code,
> so the above might not actually build everywhere.
> 
> However, *testing* the above (in my config, where '#' does work as a
> comment character) shows that gcc doesn't actually consider them to be
> distinct EVEN THEN, and will still merge two barrier statements.
> 
> That's distressing.
> 
> So the gcc docs are actively wrong, and %= does nothing - it will
> still compare as the exact same inline asm, because the string
> equality testing is apparently done before any expansion.
> 
> Something like this *does* seem to work:
> 
>    #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
>    #define __barrier(id) ____barrier(id)
>    #define barrier() __barrier(__COUNTER__)
> 
> which is "interesting" or "disgusting" depending on how you happen to feel.
> 
> And again - the above works only as long as "#" is a valid comment
> character in the assembler. And I have this very dim memory of us
> having comments in inline asm, and it breaking certain configurations
> (for when the assembler that the compiler uses is a special
> human-unfriendly one that only accepts compiler output).
> 
> You could make even more disgusting hacks, and have it generate something like
> 
>     .pushsection .discard.barrier
>     .long #id
>     .popsection
> 
> instead of a comment. We already expect that to work and have generic
> inline asm cases that generate code like that.

I tried the experiment with this code:

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define WRITE_ONCE(x, val) (READ_ONCE(x) = (val))
#define barrier() __asm__ __volatile__("": : :"memory")

int x, y;

int main(int argc, char *argv[])
{
    if (READ_ONCE(x)) {
        barrier();
        y = 1;
    } else {
        y = 1;
    }
    return 0;
}

The output from gcc -O2 is:

main:
        mov     eax, DWORD PTR x[rip]
        test    eax, eax
        je      .L2
.L2:
        mov     DWORD PTR y[rip], 1

The output from clang is essentially the same (the mov and test are 
replaced by a cmp).

This does what we want, but I wouldn't bet against a future 
optimization pass getting rid of the "useless" test and branch.

Alan
