Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF312583C5
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 23:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgHaVrl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 17:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbgHaVrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 17:47:40 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531DE2083E;
        Mon, 31 Aug 2020 21:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598910458;
        bh=LpFlnr5cPD2+2Z/0AU+nTqD+Jd//wQ602L7jls7aUgY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EEn57XzNc1nMqiIO/N0hOHNfUTpyzwaKcmLUJ3jW5rFWI0erkDfsKN16IcHy8Q7vx
         UuCDzFICgmRXHwCxlljPdElRRiVHAgeVg4/zn/TOuavuDfT64dNgKgyx7OfnByMfFT
         urq3lofInuyFwu5x3MGfpJtayc1rhXSHrAvdKXHg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 33DB435230F1; Mon, 31 Aug 2020 14:47:38 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:47:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200831214738.GE2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
 <20200831201701.GB558270@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831201701.GB558270@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 04:17:01PM -0400, Alan Stern wrote:
> On Mon, Aug 31, 2020 at 11:20:37AM -0700, paulmck@kernel.org wrote:
> > +No Roach-Motel Locking!
> > +-----------------------
> > +
> > +This example requires familiarity with the herd7 "filter" clause, so
> > +please read up on that topic in litmus-tests.txt.
> > +
> > +It is tempting to allow memory-reference instructions to be pulled
> > +into a critical section, but this cannot be allowed in the general case.
> > +For example, consider a spin loop preceding a lock-based critical section.
> > +Now, herd7 does not model spin loops, but we can emulate one with two
> > +loads, with a "filter" clause to constrain the first to return the
> > +initial value and the second to return the updated value, as shown below:
> > +
> > +	/* See Documentation/litmus-tests/locking/RM-fixed.litmus. */
> > +	P0(int *x, int *y, int *lck)
> > +	{
> > +		int r2;
> > +
> > +		spin_lock(lck);
> > +		r2 = atomic_inc_return(y);
> > +		WRITE_ONCE(*x, 1);
> > +		spin_unlock(lck);
> > +	}
> > +
> > +	P1(int *x, int *y, int *lck)
> > +	{
> > +		int r0;
> > +		int r1;
> > +		int r2;
> > +
> > +		r0 = READ_ONCE(*x);
> > +		r1 = READ_ONCE(*x);
> > +		spin_lock(lck);
> > +		r2 = atomic_inc_return(y);
> > +		spin_unlock(lck);
> > +	}
> > +
> > +	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> > +	exists (1:r2=1)
> > +
> > +The variable "x" is the control variable for the emulated spin loop.
> > +P0() sets it to "1" while holding the lock, and P1() emulates the
> > +spin loop by reading it twice, first into "1:r0" (which should get the
> > +initial value "0") and then into "1:r1" (which should get the updated
> > +value "1").
> > +
> > +The purpose of the variable "y" is to reject deadlocked executions.
> > +Only those executions where the final value of "y" have avoided deadlock.
> > +
> > +The "filter" clause takes all this into account, constraining "y" to
> > +equal "2", "1:r0" to equal "0", and "1:r1" to equal 1.
> > +
> > +Then the "exists" clause checks to see if P1() acquired its lock first,
> > +which should not happen given the filter clause because P0() updates
> > +"x" while holding the lock.  And herd7 confirms this.
> > +
> > +But suppose that the compiler was permitted to reorder the spin loop
> > +into P1()'s critical section, like this:
> > +
> > +	/* See Documentation/litmus-tests/locking/RM-broken.litmus. */
> > +	P0(int *x, int *y, int *lck)
> > +	{
> > +		int r2;
> > +
> > +		spin_lock(lck);
> > +		r2 = atomic_inc_return(y);
> > +		WRITE_ONCE(*x, 1);
> > +		spin_unlock(lck);
> > +	}
> > +
> > +	P1(int *x, int *y, int *lck)
> > +	{
> > +		int r0;
> > +		int r1;
> > +		int r2;
> > +
> > +		spin_lock(lck);
> > +		r0 = READ_ONCE(*x);
> > +		r1 = READ_ONCE(*x);
> > +		r2 = atomic_inc_return(y);
> > +		spin_unlock(lck);
> > +	}
> > +
> > +	locations [x;lck;0:r2;1:r0;1:r1;1:r2]
> > +	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> > +	exists (1:r2=1)
> > +
> > +If "1:r0" is equal to "0", "1:r1" can never equal "1" because P0()
> > +cannot update "x" while P1() holds the lock.  And herd7 confirms this,
> > +showing zero executions matching the "filter" criteria.
> > +
> > +And this is why Linux-kernel lock and unlock primitives must prevent
> > +code from entering critical sections.  It is not sufficient to only
> > +prevnt code from leaving them.
> 
> Is this discussion perhaps overkill?
> 
> Let's put it this way: Suppose we have the following code:
> 
> 	P0(int *x, int *lck)
> 	{
> 		spin_lock(lck);
> 		WRITE_ONCE(*x, 1);
> 		do_something();
> 		spin_unlock(lck);
> 	}
> 
> 	P1(int *x, int *lck)
> 	{
> 		while (READ_ONCE(*x) == 0)
> 			;
> 		spin_lock(lck);
> 		do_something_else();
> 		spin_unlock(lck);
> 	}
> 
> It's obvious that this test won't deadlock.  But if P1 is changed to:
> 
> 	P1(int *x, int *lck)
> 	{
> 		spin_lock(lck);
> 		while (READ_ONCE(*x) == 0)
> 			;
> 		do_something_else();
> 		spin_unlock(lck);
> 	}
> 
> then it's equally obvious that the test can deadlock.  No need for
> fancy memory models or litmus tests or anything else.

For people like you and me, who have been thinking about memory ordering
for longer than either of us care to admit, this level of exposition is
most definitely -way- overkill!!!

But I have had people be very happy and grateful that I explained this to
them at this level of detail.  Yes, I started parallel programming before
some of them were born, but they are definitely within our target audience
for this particular document.  And it is not just Linux kernel hackers
who need this level of detail.  A roughly similar transactional-memory
scenario proved to be so non-obvious to any number of noted researchers
that Blundell, Lewis, and Martin needed to feature it in this paper:
https://ieeexplore.ieee.org/abstract/document/4069174
(Alternative source: https://repository.upenn.edu/cgi/viewcontent.cgi?article=1344&context=cis_papers)

Please note that I am -not- advocating making (say) explanation.txt or
recipes.txt more newbie-accessible than they already are.  After all,
the point of the README file in that same directory is to direct people
to the documentation files that are the best fit for them, and both
explanation.txt and recipes.txt contain advanced material, and thus
require similarly advanced prerequisites.

Seem reasonable, or am I missing your point?

							Thanx, Paul
