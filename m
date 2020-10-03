Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1528256F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJCRNj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 13:13:39 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40253 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725798AbgJCRNj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 13:13:39 -0400
Received: (qmail 323712 invoked by uid 1000); 3 Oct 2020 13:13:38 -0400
Date:   Sat, 3 Oct 2020 13:13:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201003171338.GA323226@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
> Hi Alan,
> 
> Just a minor nit in the litmus test.
> 
> On Sat, 3 Oct 2020 09:22:12 -0400, Alan Stern wrote:
> > To expand on my statement about the LKMM's weakness regarding control 
> > constructs, here is a litmus test to illustrate the issue.  You might 
> > want to add this to one of the archives.
> > 
> > Alan
> > 
> > C crypto-control-data
> > (*
> >  * LB plus crypto-control-data plus data
> >  *
> >  * Expected result: allowed
> >  *
> >  * This is an example of OOTA and we would like it to be forbidden.
> >  * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> >  * control-dependent on the preceding READ_ONCE.  But the dependencies are
> >  * hidden by the form of the conditional control construct, hence the 
> >  * name "crypto-control-data".  The memory model doesn't recognize them.
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	int r1;
> > 
> > 	r1 = 1;
> > 	if (READ_ONCE(*x) == 0)
> > 		r1 = 0;
> > 	WRITE_ONCE(*y, r1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	WRITE_ONCE(*x, READ_ONCE(*y));
> 
> Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.

You're right.  This is definitely a bug in herd7.

Luc, were you aware of this?

> When I changed P1 to
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*y);
> 	WRITE_ONCE(*x, r1);
> }
> 
> and replaced the WRITE_ONCE() in P0 with smp_store_release(),
> I got the result of:
> 
> -----
> Test crypto-control-data Allowed
> States 1
> 0:r1=0;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (0:r1=1)
> Observation crypto-control-data Never 0 3
> Time crypto-control-data 0.01
> Hash=9b9aebbaf945dad8183d2be0ccb88e11
> -----
> 
> Restoring the WRITE_ONCE() in P0, I got the result of:
> 
> -----
> Test crypto-control-data Allowed
> States 2
> 0:r1=0;
> 0:r1=1;
> Ok
> Witnesses
> Positive: 1 Negative: 4
> Condition exists (0:r1=1)
> Observation crypto-control-data Sometimes 1 4
> Time crypto-control-data 0.01
> Hash=843eaa4974cec0efae79ce3cb73a1278
> -----

What you should have done was put smp_store_release in P0 and left P1 in 
its original form.  That test should not be allowed, but herd7 says that 
it is.

> As this is the same as the expected result, I suppose you have missed another
> limitation of herd7 + LKMM.

It would be more accurate to say that we all missed it.  :-)  (And it's 
a bug in herd7, not a limitation of either herd7 or LKMM.)  How did you 
notice it?

> By the way, I think this weakness on control dependency + data dependency
> deserves an entry in tools/memory-model/Documentation/litmus-tests.txt.
> 
> In the LIMITATIONS section, item #1 mentions some situation where
> LKMM may not recognize possible losses of control-dependencies by
> compiler optimizations.
> 
> What this litmus test demonstrates is a different class of mismatch.

Yes, one in which LKMM does not recognize a genuine dependency because 
it can't tell that some optimizations are not valid.

This flaw is fundamental to the way herd7 works.  It examines only one 
execution at a time, and it doesn't consider the code in a conditional 
branch while it's examining an execution where that branch wasn't taken.  
Therefore it has no way to know that the code in the unexecuted branch 
would prevent a certain optimization.  But the compiler does consider 
all the code in all branches when deciding what optimizations to apply.

Here's another trivial example:

	r1 = READ_ONCE(*x);
	if (r1 == 0)
		smp_mb();
	WRITE_ONCE(*y, 1);

The compiler can't move the WRITE_ONCE before the READ_ONCE or the "if" 
statement, because it's not allowed to move shared memory accesses past 
a memory barrier -- even if that memory barrier isn't always executed.  
Therefore the WRITE_ONCE actually is ordered after the READ_ONCE, but 
the memory model doesn't realize it.

> Alan, can you come up with an update in this regard?

I'll write something.

Alan
