Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1039D172
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFFUc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 16:32:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:54568 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhFFUcZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 16:32:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156KQInJ013180;
        Sun, 6 Jun 2021 15:26:18 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156KQGXe013177;
        Sun, 6 Jun 2021 15:26:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 15:26:16 -0500
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
Message-ID: <20210606202616.GC18427@gate.crashing.org>
References: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com> <20210606195242.GA18427@gate.crashing.org> <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 01:11:53PM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 12:56 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > Yes, I know.  But it is literally the *only* way to *always* get a
> > conditional branch: by writing one.
> 
> The thing is, I don't actually believe you.

Fortune favours the bold!

> The barrier() thing can work - all we need to do is to simply make it
> impossible for gcc to validly create anything but a conditional
> branch.

And the only foolproof way of doing that is by writing a branch.

> If either side of the thing have an asm that cannot be combined, gcc
> simply doesn't have any choice in the matter. There's no other valid
> model than a conditional branch around it (of some sort - doing an
> indirect branch that has a data dependency isn't wrong either, it just
> wouldn't be something that a sane compiler would generate because it's
> obviously much slower and more complicated).

Or push something to the stack and return.  Or rewrite the whole thing
as an FSM.  Or or or.

(And yes, there are existing compilers that can do both of these things
on some code).

> We are very used to just making the compiler generate the code we
> need. That is, fundamentally, what any use of inline asm is all about.
> We want the compiler to generate all the common cases and all the
> regular instructions.
> 
> The conditional branch itself - and the instructions leading up to it
> - are exactly those "common regular instructions" that we'd want the
> compiler to generate. That is in fact more true here than for most
> inline asm, exactly because there are so many different possible
> combinations of conditional branches (equal, not equal, less than,..)
> and so many ways to generate the code that generates the condition.
> 
> So we are much better off letting the compiler do all that for us -
> it's very much what the compiler is good at.

Yes, exactly.

I am saying that if you depend on that some C code you write will result
in some particular machine code, without actually *forcing* the compiler
to output that exact machine code, then you will be disappointed.  Maybe
not today, and maybe it will take years, if you are lucky.

(s/forcing/instructing/ of course, compilers have feelings too!)


Segher
