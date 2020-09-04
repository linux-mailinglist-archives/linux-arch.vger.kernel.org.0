Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84CE25E239
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIDTw3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 15:52:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53619 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726621AbgIDTw3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 15:52:29 -0400
Received: (qmail 701042 invoked by uid 1000); 4 Sep 2020 15:52:28 -0400
Date:   Fri, 4 Sep 2020 15:52:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200904195228.GB699781@rowland.harvard.edu>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
 <20200831201701.GB558270@rowland.harvard.edu>
 <20200831214738.GE2855@paulmck-ThinkPad-P72>
 <20200901014504.GB571008@rowland.harvard.edu>
 <20200901170421.GF29330@paulmck-ThinkPad-P72>
 <20200901201110.GB599114@rowland.harvard.edu>
 <20200903234507.GA24261@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903234507.GA24261@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 04:45:07PM -0700, Paul E. McKenney wrote:

> The hope was to have a good version of them completed some weeks ago,
> but life intervened.
> 
> My current thought is to move these three patches out of my queue for
> v5.10 to try again in v5.11:
> 
> 0b8c06b75ea1 ("tools/memory-model: Add a simple entry point document")
> dc372dc0dc89 ("tools/memory-model: Move Documentation description to Documentation/README")
> 0d9aaf8df7cb ("tools/memory-model: Document categories of ordering primitives")
> 35dd5f6d17a0 ("tools/memory-model:  Document locking corner cases")
> 
> These would remain in my v5.10 queue:
> 
> 1e44e6e82e7b ("Replace HTTP links with HTTPS ones: LKMM")
> cc9628b45c9f ("tools/memory-model: Update recipes.txt prime_numbers.c path")
> 984f272be9d7 ("tools/memory-model: Improve litmus-test documentation")
> 7c22cf3b731f ("tools/memory-model: Expand the cheatsheet.txt notion of relaxed")
> 	(But with the updates from the other thread.)
> 
> Does that work?  If not, what would?

That sounds reasonable.

> > > > Just what you want to achieve here is not clear from the context.
> > > 
> > > People who have internalized the "roach motel" model of locking
> > > (https://www.cs.umd.edu/~pugh/java/memoryModel/BidirectionalMemoryBarrier.html)
> > > need their internalization adjusted.
> > 
> > Shucks, if you only want to show that letting arbitrary code (i.e., 
> > branches) migrate into a critical section is unsafe, all you need is 
> > this uniprocessor example:
> > 
> > 	P0(int *sl)
> > 	{
> > 		goto Skip;
> > 		spin_lock(sl);
> > 		spin_unlock(sl);
> > 	Skip:
> > 		spin_lock(sl);
> > 		spin_unlock(sl);
> > 	}
> > 
> > This does nothing but runs fine.  Letting the branch move into the first 
> > critical section gives:
> > 
> > 	P0(int *sl)
> > 	{
> > 		spin_lock(sl);
> > 		goto Skip;
> > 		spin_unlock(sl);
> > 	Skip:
> > 		spin_lock(sl);
> > 		spin_unlock(sl);
> > 	}
> > 
> > which self-deadlocks 100% of the time.  You don't need to know anything 
> > about memory models or concurrency to understand this.
> 
> Although your example does an excellent job of illustrating the general
> point about branches, I am not convinced that it would be seen as
> demonstrating the dangers of moving an entire loop into a critical
> section.

All right, how about this?

	P0(int *sl)
	{
		while (spin_is_locked(sl))
			cpu_relax();
		spin_lock(sl);
		spin_unlock(sl);
	}

Runs normally, even if other threads are doing unknown locking and 
unlocking at the same time.  But:

	P0(int *sl)
	{
		spin_lock(sl);
		while (spin_is_locked(sl))
			cpu_relax();
		spin_unlock(sl);
	}

always goes into an infinite loop.

> > On the other hand, if you want to show that letting memory accesses leak 
> > into a critical section is unsafe then you need a different example: 
> > spin loops won't do it.
> 
> I am not immediately coming up with an example that is broken by leaking
> isolated memory accesses into a critical section.  I will give it some
> more thought.

It may turn out to be a hard challenge.  As far as I know, there are no 
such examples, unless you want to count something like this:

	spin_lock(sl);
	spin_unlock(sl);
	spin_lock(sl);
	spin_unlock(sl);

transformed to:

	spin_lock(sl);
	spin_lock(sl);
	spin_unlock(sl);
	spin_unlock(sl);

You could view this transformation as moving the second spin_lock up 
into the first critical section (obviously dangerous since spin_lock 
involves a loop), or as moving the first spin_unlock down into the 
second critical section (not so obvious since spin_unlock is just a 
memory access).

Okay, so let's restrict ourselves to memory accesses and loops that 
don't touch the spinlock variable itself.  Then we would need something 
more similar to the original example, like this:

	P0(spin_lock *sl, int *x)
	{
		while (READ_ONCE(x) == 0)
			cpu_relax();
		spin_lock(sl);
		spin_unlock(sl);
	}

	P1(spin_lock *sl, int *x)
	{
		spin_lock(sl);
		WRITE_ONCE(x, 1);
		spin_unlock(sl);
	}

This will always run to completion.  But if the loop in P0 is moved into 
the critical section, the test may never end.  Again, you don't need 
fancy memory models to understand this; you just need to know that 
critical sections are mutually exclusive.

But if this example didn't have a loop, allowing the memory access to 
leak into the critical section would be fine.

Alan
