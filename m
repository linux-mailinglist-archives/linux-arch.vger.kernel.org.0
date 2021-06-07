Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5358339E5FC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFGR6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 13:58:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:37131 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFGR6M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 13:58:12 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157Hq28m015783;
        Mon, 7 Jun 2021 12:52:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157Hq13C015762;
        Mon, 7 Jun 2021 12:52:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 12:52:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210607175200.GG18427@gate.crashing.org>
References: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 11:01:39AM +0300, Alexander Monakov wrote:
> Uhh... I was not talking about some (non-existent) "optimizing linker".
> LTO works by relaunching the compiler from the linker and letting it
> consume multiple translation units (which are fully preprocessed by that
> point). So the very thing you wanted to avoid -- such barriers appearing
> in close proximity where they can be deduplicated -- may arise after a
> little bit of cross-unit inlining.
> 
> My main point here is that using __COUNTER__ that way (making things
> "unique" for the compiler) does not work in general when LTO enters the
> picture. As long as that is remembered, I'm happy.

Yup.  Exactly the same issue as using this in any function that may end
up inlined.

> > In the case of "volatile_if()", we actually would like to have not a
> > memory clobber, but a "memory read". IOW, it would be a barrier for
> > any writes taking place, but reads can move around it.
> > 
> > I don't know of any way to express that to the compiler. We've used
> > hacks for it before (in gcc, BLKmode reads turn into that kind of
> > barrier in practice, so you can do something like make the memory
> > input to the asm be a big array). But that turned out to be fairly
> > unreliable, so now we use memory clobbers even if we just mean "reads
> > random memory".
> 
> So the barrier which is a compiler barrier but not a machine barrier is
> __atomic_signal_fence(model), but internally GCC will not treat it smarter
> than an asm-with-memory-clobber today.

It will do nothing for relaxed ordering, and do blockage for everything
else.  Can it do anything weaker than that?


Segher
