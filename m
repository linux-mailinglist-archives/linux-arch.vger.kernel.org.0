Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C268258252
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgHaURC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 16:17:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47255 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726939AbgHaURC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 16:17:02 -0400
Received: (qmail 564170 invoked by uid 1000); 31 Aug 2020 16:17:01 -0400
Date:   Mon, 31 Aug 2020 16:17:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200831201701.GB558270@rowland.harvard.edu>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182037.2034-9-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 11:20:37AM -0700, paulmck@kernel.org wrote:
> +No Roach-Motel Locking!
> +-----------------------
> +
> +This example requires familiarity with the herd7 "filter" clause, so
> +please read up on that topic in litmus-tests.txt.
> +
> +It is tempting to allow memory-reference instructions to be pulled
> +into a critical section, but this cannot be allowed in the general case.
> +For example, consider a spin loop preceding a lock-based critical section.
> +Now, herd7 does not model spin loops, but we can emulate one with two
> +loads, with a "filter" clause to constrain the first to return the
> +initial value and the second to return the updated value, as shown below:
> +
> +	/* See Documentation/litmus-tests/locking/RM-fixed.litmus. */
> +	P0(int *x, int *y, int *lck)
> +	{
> +		int r2;
> +
> +		spin_lock(lck);
> +		r2 = atomic_inc_return(y);
> +		WRITE_ONCE(*x, 1);
> +		spin_unlock(lck);
> +	}
> +
> +	P1(int *x, int *y, int *lck)
> +	{
> +		int r0;
> +		int r1;
> +		int r2;
> +
> +		r0 = READ_ONCE(*x);
> +		r1 = READ_ONCE(*x);
> +		spin_lock(lck);
> +		r2 = atomic_inc_return(y);
> +		spin_unlock(lck);
> +	}
> +
> +	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +	exists (1:r2=1)
> +
> +The variable "x" is the control variable for the emulated spin loop.
> +P0() sets it to "1" while holding the lock, and P1() emulates the
> +spin loop by reading it twice, first into "1:r0" (which should get the
> +initial value "0") and then into "1:r1" (which should get the updated
> +value "1").
> +
> +The purpose of the variable "y" is to reject deadlocked executions.
> +Only those executions where the final value of "y" have avoided deadlock.
> +
> +The "filter" clause takes all this into account, constraining "y" to
> +equal "2", "1:r0" to equal "0", and "1:r1" to equal 1.
> +
> +Then the "exists" clause checks to see if P1() acquired its lock first,
> +which should not happen given the filter clause because P0() updates
> +"x" while holding the lock.  And herd7 confirms this.
> +
> +But suppose that the compiler was permitted to reorder the spin loop
> +into P1()'s critical section, like this:
> +
> +	/* See Documentation/litmus-tests/locking/RM-broken.litmus. */
> +	P0(int *x, int *y, int *lck)
> +	{
> +		int r2;
> +
> +		spin_lock(lck);
> +		r2 = atomic_inc_return(y);
> +		WRITE_ONCE(*x, 1);
> +		spin_unlock(lck);
> +	}
> +
> +	P1(int *x, int *y, int *lck)
> +	{
> +		int r0;
> +		int r1;
> +		int r2;
> +
> +		spin_lock(lck);
> +		r0 = READ_ONCE(*x);
> +		r1 = READ_ONCE(*x);
> +		r2 = atomic_inc_return(y);
> +		spin_unlock(lck);
> +	}
> +
> +	locations [x;lck;0:r2;1:r0;1:r1;1:r2]
> +	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +	exists (1:r2=1)
> +
> +If "1:r0" is equal to "0", "1:r1" can never equal "1" because P0()
> +cannot update "x" while P1() holds the lock.  And herd7 confirms this,
> +showing zero executions matching the "filter" criteria.
> +
> +And this is why Linux-kernel lock and unlock primitives must prevent
> +code from entering critical sections.  It is not sufficient to only
> +prevnt code from leaving them.

Is this discussion perhaps overkill?

Let's put it this way: Suppose we have the following code:

	P0(int *x, int *lck)
	{
		spin_lock(lck);
		WRITE_ONCE(*x, 1);
		do_something();
		spin_unlock(lck);
	}

	P1(int *x, int *lck)
	{
		while (READ_ONCE(*x) == 0)
			;
		spin_lock(lck);
		do_something_else();
		spin_unlock(lck);
	}

It's obvious that this test won't deadlock.  But if P1 is changed to:

	P1(int *x, int *lck)
	{
		spin_lock(lck);
		while (READ_ONCE(*x) == 0)
			;
		do_something_else();
		spin_unlock(lck);
	}

then it's equally obvious that the test can deadlock.  No need for
fancy memory models or litmus tests or anything else.

Alan
