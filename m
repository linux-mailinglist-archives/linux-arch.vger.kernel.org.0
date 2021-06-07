Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950CA39E04A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGP3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 11:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGP3E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 11:29:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D884461159;
        Mon,  7 Jun 2021 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623079632;
        bh=PmI+g6d05m0O1sqZS4bQGeSBmZdKbeu/jEjTNOkKCYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oHt5JgAGzA238x0WeyI4F9gAMj3YSneDaQjSKfEyPbjJh28qL6IajagjMr3ToutrF
         roYSM2gIMvKWeXJMdRfwfBCf25YMHRPvwJjTFnoaDWEyOdscbggyQZzc3glQMbwvSp
         /WQdZnB1/PUMLno/OY50ga9ltb1JdG68204vhmqG8f48VzhXHEhfTM9QcbRNmlvetQ
         tEZh/LIhGHH10fR1xoFHwl2nDaE/nPLCz2GoO1FNgIkPOzJHprNX+eHy9GzAb+azN4
         8RDA2PBiPmGTIf1r8ob656BQpIprsnpgIFhoT/IIXnbvClyatXfNGM7T8JPQJa4NlX
         BiTzmlZw0YpKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B15AF5C0395; Mon,  7 Jun 2021 08:27:12 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:27:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210607152712.GR4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org>
 <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
 <20210606195242.GA18427@gate.crashing.org>
 <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
 <20210606202616.GC18427@gate.crashing.org>
 <20210606233729.GN4397@paulmck-ThinkPad-P17-Gen-1>
 <20210607141242.GD18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607141242.GD18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 09:12:42AM -0500, Segher Boessenkool wrote:
> On Sun, Jun 06, 2021 at 04:37:29PM -0700, Paul E. McKenney wrote:
> > > > The barrier() thing can work - all we need to do is to simply make it
> > > > impossible for gcc to validly create anything but a conditional
> > > > branch.
> > > 
> > > And the only foolproof way of doing that is by writing a branch.
> 
> [ ... ]
> 
> > > I am saying that if you depend on that some C code you write will result
> > > in some particular machine code, without actually *forcing* the compiler
> > > to output that exact machine code, then you will be disappointed.  Maybe
> > > not today, and maybe it will take years, if you are lucky.
> > > 
> > > (s/forcing/instructing/ of course, compilers have feelings too!)
> > 
> > OK, I will bite...
> > 
> > What would you suggest as a way of instructing the compiler to emit the
> > conditional branch that we are looking for?
> 
> You write it in the assembler code.
> 
> Yes, it sucks.  But it is the only way to get a branch if you really
> want one.  Now, you do not really need one here anyway, so there may be
> some other way to satisfy the actual requirements.

Hmmm...  What do you see Peter asking for that is different than what
I am asking for?  ;-)

							Thanx, Paul
