Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3027A39D06C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFFSYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:24:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37273 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229573AbhFFSYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:24:04 -0400
Received: (qmail 1741840 invoked by uid 1000); 6 Jun 2021 14:22:13 -0400
Date:   Sun, 6 Jun 2021 14:22:13 -0400
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
Message-ID: <20210606182213.GA1741684@rowland.harvard.edu>
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 11:04:49AM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 4:56 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > And that is a simple fact, since the same assembler code (at the same
> > spot in the program) will do the same thing no matter how that ended up
> > there.
> 
> The thing is, that's exactl;y what gcc violates.
> 
> The example - you may not have been cc'd personally on that one - was
> something like
> 
>     if (READ_ONCE(a)) {
>         barrier();
>         WRITE_ONCE(b,1);
>    } else {
>         barrier();
>         WRITE_ONCE(b, 1);
>     }
> 
> and currently because gcc thinks "same exact code", it will actually
> optimize this to (pseudo-asm):
> 
>     LD A
>     "empty asm"
>     ST $1,B
> 
> which is very much NOT equivalent to
> 
>     LD A
>     BEQ over
>     "empty asm"
>     ST $1,B
>     JMP join
> 
> over:
>     "empty asm"
>     ST $1,B
> 
> join:
> 
> and that's the whole point of the barriers.
> 
> It's not equivalent exactly because of memory ordering. In the first
> case, there is no ordering on weak architectures. In the second case,
> there is always an ordering, because of CPU consistency guarantees.
> 
> And no, gcc doesn't understand about memory ordering. But that's
> exactly why we use inline asms.
> 
> > And the compiler always is allowed to duplicate, join, delete, you name
> > it, inline assembler code.  The only thing that it cares about is
> > semantics of the code, just like for any other code.
> 
> See, but it VIOLATES the semantics of the code.
> 
> You can't join those two empty asm's (and then remove the branch),
> because the semantics of the code really aren't the same any more if
> you do. Truly.

To be fair, the same argument applies even without the asm code.  The 
compiler will translate

     if (READ_ONCE(a))
         WRITE_ONCE(b, 1);
     else
         WRITE_ONCE(b, 1);

to

     LD A
     ST $1,B

intstead of

     LD A
     BEQ over
     ST $1,B
     JMP join
 
 over:
     ST $1,B
 
 join:

And these two are different for the same memory ordering reasons as 
above.

Alan
