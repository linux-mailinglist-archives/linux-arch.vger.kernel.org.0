Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B913D4190
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGWTwQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 15:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhGWTwP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 15:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF71760BD3;
        Fri, 23 Jul 2021 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627072368;
        bh=in6b+5u7t92PVOGj1WvqNrcjmMpAHD0cYSbWtJlLjBs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=abg1gkbNV0ohE8n9+AQOR3A7efYRm511wxqobEKiOxYcMTVl4jkkTecDD9uwKAFcE
         Pb/PiLXLPCsSvsFO8y2a38wgR5oKJSKag7OVi/NoFFp+IoiUcxsA5FfKPxcjKqJ2Xf
         hazoNujKofN261rvkWSZhXaDOKst4JMdu+PwN3QcdMR2lLxAwjlGMPJfviqweWJg0M
         MmVSOKtc1SjIsbRDjdtODYM3vy7miQ0Ndv98wd9HAjEZUT4qMlwhz3jhYpkK4AFBgT
         00TRYUDzD0KE297KxvhUJd8HE4Z1QD+XjqnphrnycnSlwfERLJ0cqj7/r0NBYhHa98
         TDjLkaiMCT3nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AEFF35C068F; Fri, 23 Jul 2021 13:32:48 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:32:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210723203248.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <e4aa3346-ba2c-f6cc-9f3c-349e22cd6ee8@colorfullife.com>
 <20210723130554.GA38923@rowland.harvard.edu>
 <20210723163008.GG4397@paulmck-ThinkPad-P17-Gen-1>
 <20210723170820.GB46562@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723170820.GB46562@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 01:08:20PM -0400, Alan Stern wrote:
> On Fri, Jul 23, 2021 at 09:30:08AM -0700, Paul E. McKenney wrote:
> > How about like this?
> > 
> > 							Thanx, Paul
> 
> Generally a lot better, but still at least one issue.
> 
> > ------------------------------------------------------------------------
> > 
> > Lock-Protected Writes With Heuristic Lockless Reads
> > ---------------------------------------------------
> > 
> > For another example, suppose that the code can normally make use of
> > a per-data-structure lock, but there are times when a global lock
> > is required.  These times are indicated via a global flag.  The code
> > might look as follows, and is based loosely on nf_conntrack_lock(),
> > nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
> > 
> > 	bool global_flag;
> > 	DEFINE_SPINLOCK(global_lock);
> > 	struct foo {
> > 		spinlock_t f_lock;
> > 		int f_data;
> > 	};
> > 
> > 	/* All foo structures are in the following array. */
> > 	int nfoo;
> > 	struct foo *foo_array;
> > 
> > 	void do_something_locked(struct foo *fp)
> > 	{
> > 		/* IMPORTANT: Heuristic plus spin_lock()! */
> > 		if (!data_race(global_flag)) {
> > 			spin_lock(&fp->f_lock);
> > 			if (!smp_load_acquire(&global_flag)) {
> > 				do_something(fp);
> > 				spin_unlock(&fp->f_lock);
> > 				return;
> > 			}
> > 			spin_unlock(&fp->f_lock);
> > 		}
> > 		spin_lock(&global_lock);
> > 		/* global_lock held, thus global flag cannot be set. */
> > 		spin_lock(&fp->f_lock);
> > 		spin_unlock(&global_lock);
> > 		/*
> > 		 * global_flag might be set here, but begin_global()
> > 		 * will wait for ->f_lock to be released.
> > 		 */
> > 		do_something(fp);
> > 		spin_lock(&fp->f_lock);
> 
> spin_unlock.

Good eyes, fixed.

> > }
> > 
> > 	void begin_global(void)
> > 	{
> > 		int i;
> > 
> > 		spin_lock(&global_lock);
> > 		WRITE_ONCE(global_flag, true);
> > 		for (i = 0; i < nfoo; i++) {
> > 			/*
> > 			 * Wait for pre-existing local locks.  One at
> > 			 * a time to avoid lockdep limitations.
> > 			 */
> > 			spin_lock(&fp->f_lock);
> > 			spin_unlock(&fp->f_lock);
> > 		}
> > 	}
> > 
> > 	void end_global(void)
> > 	{
> > 		smp_store_release(&global_flag, false);
> > 		spin_unlock(&global_lock);
> > 	}
> > 
> > All code paths leading from the do_something_locked() function's first
> > read from global_flag acquire a lock, so endless load fusing cannot
> > happen.
> > 
> > If the value read from global_flag is true, then global_flag is
> > rechecked while holding ->f_lock, which, if global_flag is now false,
> > prevents begin_global() from completing.  It is therefore safe to invoke
> > do_something().
> > 
> > Otherwise, if either value read from global_flag is true, then after
> > global_lock is acquired global_flag must be false.  The acquisition of
> > ->f_lock will prevent any call to begin_global() from returning, which
> > means that it is safe to release global_lock and invoke do_something().
> > 
> > For this to work, only those foo structures in foo_array[] may be passed
> > to do_something_locked().  The reason for this is that the synchronization
> > with begin_global() relies on momentarily holding the lock of each and
> > every foo structure.
> 
> This doesn't mention the reason for the acquire-release
> synchronization of global_flag.  It's needed because work done between
> begin_global() and end_global() can affect a foo structure without
> holding its private f_lock member, and we want all such work to be
> visible to other threads when they call do_something_locked() later.

Like this added paragraph at the end?

	The smp_load_acquire() and smp_store_release() are required
	because changes to a foo structure between calls to begin_global()
	and end_global() are carried out without holding that structure's
	->f_lock.  The smp_load_acquire() and smp_store_release()
	ensure that the next invocation of do_something() from the call
	to do_something_locked() that acquires that ->f_lock will see
	those changes.

							Thanx, Paul
