Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1639CC10
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFBax (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 21:30:53 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38751 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230025AbhFFBaw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jun 2021 21:30:52 -0400
Received: (qmail 1723601 invoked by uid 1000); 5 Jun 2021 21:29:03 -0400
Date:   Sat, 5 Jun 2021 21:29:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210606012903.GA1723421@rowland.harvard.edu>
References: <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 05:14:18PM -0700, Paul E. McKenney wrote:
> On Sat, Jun 05, 2021 at 10:57:39AM -0400, Alan Stern wrote:
> > Indeed, the expansion of the currently proposed version of
> > 
> > 	volatile_if (A) {
> > 		B;
> > 	} else {
> > 		C;
> > 	}
> > 
> > is basically the same as
> > 
> > 	if (A) {
> > 		barrier();
> > 		B;
> > 	} else {
> > 		barrier();
> > 		C;
> > 	}

> That does sound good, but...
> 
> Current compilers beg to differ at -O2: https://godbolt.org/z/5K55Gardn
> 
> ------------------------------------------------------------------------
> #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> #define WRITE_ONCE(x, val) (READ_ONCE(x) = (val))
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> int x, y;
> 
> int main(int argc, char *argv[])
> {
>     if (READ_ONCE(x)) {
>         barrier();
>         WRITE_ONCE(y, 1);
>     } else {
>         barrier();
>         WRITE_ONCE(y, 1);
>     }
>     return 0;
> }
> ------------------------------------------------------------------------
> 
> Both gcc and clang generate a load followed by a store, with no branch.
> ARM gets the same results from both compilers.
> 
> As Linus suggested, removing one (but not both!) invocations of barrier()
> does cause a branch to be emitted, so maybe that is a way forward.
> Assuming it is more than just dumb luck, anyway.  :-/

Interesting.  And changing one of the branches from barrier() to __asm__ 
__volatile__("nop": : :"memory") also causes a branch to be emitted.  So 
even though the compiler doesn't "look inside" assembly code, it does 
compare two pieces at least textually and apparently assumes if they are 
identical then they do the same thing.

Alan
