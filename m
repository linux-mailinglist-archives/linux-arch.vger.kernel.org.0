Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2140E39BF80
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDSZo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 14:25:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58765 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229982AbhFDSZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 14:25:44 -0400
Received: (qmail 1689062 invoked by uid 1000); 4 Jun 2021 14:23:57 -0400
Date:   Fri, 4 Jun 2021 14:23:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210604182357.GA1688170@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
 <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
 <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 10:10:29AM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 9:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > >
> > > Why is "volatile_if()" not just
> > >
> > >        #define barier_true() ({ barrier(); 1; })
> > >
> > >        #define volatile_if(x) if ((x) && barrier_true())
> >
> > Because we weren't sure compilers weren't still allowed to optimize the
> > branch away.
> 
> This isn't about some "compiler folks think".
> 
> The above CANNOT be compiled any other way than with a branch.
> 
> A compiler that optimizes a branch away is simply broken.
> 
> Of course, the actual condition (ie "x" above) has to be something
> that the compiler cannot statically determine is a constant, but since
> the whole - and only - point is that there will be a READ_ONCE() or
> similar there, that's not an issue.

In fact there is one weird case where it is an issue (mentioned in 
memory-barriers.txt):

If some obscure arch-specific header file does:

	#define FOO	1

and an unwitting programmer writes:

	volatile_if (READ_ONCE(*y) % FOO == 0)
		WRITE_ONCE(*z, 5);

then the compiler _can_ statically determine that the condition is a 
constant, in spite of the READ_ONCE, but this fact isn't apparent to the 
programmer.  The generated object code will include both the read and 
the write, but there won't necessarily be any ordering between them.

I don't know if cases like this exist in the kernel.  It wouldn't be 
surprising if they did though, particularly in situations where a 
feature (like multi-level page tables) may be compiled away.

Alan
