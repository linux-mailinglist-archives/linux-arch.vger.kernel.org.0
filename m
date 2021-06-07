Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19FD39E051
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGPaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 11:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGP36 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 11:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A633B61107;
        Mon,  7 Jun 2021 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623079686;
        bh=+irQ4OfSn/B6So3CGtbHcUXwW+NtMEimNFyHIBqUBjs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=erJwQ9z21n0vQpmOSUgxYBNBRUEQljLOQvTy2TcYiCKL1RW//dElzpi2Yi1NBQb1m
         eq3fBeN/ewjvsZPQ8WDg3vzFO+uSci2boCnj77F8B5stCgacfJsc4kKwAjuO8zulOl
         HfimBd9N/Y5xGG6ywtecZYe9d63Cif0IhTyPdp2j92FTiDp7U8UysdARbOFR/IWp48
         5mkUT23BvsIn0iLOXNtCDeIU68dVuhKEHM7zJMXue1ZWWV6uXq5sdT27gVCJRtW5hB
         NjrDbSYlid9UZFpcuKcNIAkvuthDlhXHJpXJxIkRdmqnMarz5MhIBB7EyHAwW9ZDBM
         thMmYpaZoKpUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E6175C0395; Mon,  7 Jun 2021 08:28:06 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:28:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
 <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 10:27:10AM +0200, Marco Elver wrote:
> On Mon, 7 Jun 2021 at 10:02, Alexander Monakov <amonakov@ispras.ru> wrote:
> > On Sun, 6 Jun 2021, Linus Torvalds wrote:
> [...]
> > > On Sun, Jun 6, 2021 at 2:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> [...]
> > > Btw, since we have compiler people on line, the suggested 'barrier()'
> > > isn't actually perfect for this particular use:
> > >
> > >    #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> > >
> > > in the general barrier case, we very much want to have that "memory"
> > > clobber, because the whole point of the general barrier case is that
> > > we want to make sure that the compiler doesn't cache memory state
> > > across it (ie the traditional use was basically what we now use
> > > "cpu_relax()" for, and you would use it for busy-looping on some
> > > condition).
> > >
> > > In the case of "volatile_if()", we actually would like to have not a
> > > memory clobber, but a "memory read". IOW, it would be a barrier for
> > > any writes taking place, but reads can move around it.
> > >
> > > I don't know of any way to express that to the compiler. We've used
> > > hacks for it before (in gcc, BLKmode reads turn into that kind of
> > > barrier in practice, so you can do something like make the memory
> > > input to the asm be a big array). But that turned out to be fairly
> > > unreliable, so now we use memory clobbers even if we just mean "reads
> > > random memory".
> >
> > So the barrier which is a compiler barrier but not a machine barrier is
> > __atomic_signal_fence(model), but internally GCC will not treat it smarter
> > than an asm-with-memory-clobber today.
> 
> FWIW, Clang seems to be cleverer about it, and seems to do the optimal
> thing if I use a __atomic_signal_fence(__ATOMIC_RELEASE):
> https://godbolt.org/z/4v5xojqaY

Indeed it does!  But I don't know of a guarantee for that helpful
behavior.

							Thanx, Paul
