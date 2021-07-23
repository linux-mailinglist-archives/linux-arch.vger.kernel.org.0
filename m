Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E23D3E2F
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGWQ1s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 12:27:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54581 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229847AbhGWQ1r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 12:27:47 -0400
Received: (qmail 47172 invoked by uid 1000); 23 Jul 2021 13:08:20 -0400
Date:   Fri, 23 Jul 2021 13:08:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210723170820.GB46562@rowland.harvard.edu>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <e4aa3346-ba2c-f6cc-9f3c-349e22cd6ee8@colorfullife.com>
 <20210723130554.GA38923@rowland.harvard.edu>
 <20210723163008.GG4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723163008.GG4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 09:30:08AM -0700, Paul E. McKenney wrote:
> How about like this?
> 
> 							Thanx, Paul

Generally a lot better, but still at least one issue.

> ------------------------------------------------------------------------
> 
> Lock-Protected Writes With Heuristic Lockless Reads
> ---------------------------------------------------
> 
> For another example, suppose that the code can normally make use of
> a per-data-structure lock, but there are times when a global lock
> is required.  These times are indicated via a global flag.  The code
> might look as follows, and is based loosely on nf_conntrack_lock(),
> nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
> 
> 	bool global_flag;
> 	DEFINE_SPINLOCK(global_lock);
> 	struct foo {
> 		spinlock_t f_lock;
> 		int f_data;
> 	};
> 
> 	/* All foo structures are in the following array. */
> 	int nfoo;
> 	struct foo *foo_array;
> 
> 	void do_something_locked(struct foo *fp)
> 	{
> 		/* IMPORTANT: Heuristic plus spin_lock()! */
> 		if (!data_race(global_flag)) {
> 			spin_lock(&fp->f_lock);
> 			if (!smp_load_acquire(&global_flag)) {
> 				do_something(fp);
> 				spin_unlock(&fp->f_lock);
> 				return;
> 			}
> 			spin_unlock(&fp->f_lock);
> 		}
> 		spin_lock(&global_lock);
> 		/* global_lock held, thus global flag cannot be set. */
> 		spin_lock(&fp->f_lock);
> 		spin_unlock(&global_lock);
> 		/*
> 		 * global_flag might be set here, but begin_global()
> 		 * will wait for ->f_lock to be released.
> 		 */
> 		do_something(fp);
> 		spin_lock(&fp->f_lock);

spin_unlock.

> }
> 
> 	void begin_global(void)
> 	{
> 		int i;
> 
> 		spin_lock(&global_lock);
> 		WRITE_ONCE(global_flag, true);
> 		for (i = 0; i < nfoo; i++) {
> 			/*
> 			 * Wait for pre-existing local locks.  One at
> 			 * a time to avoid lockdep limitations.
> 			 */
> 			spin_lock(&fp->f_lock);
> 			spin_unlock(&fp->f_lock);
> 		}
> 	}
> 
> 	void end_global(void)
> 	{
> 		smp_store_release(&global_flag, false);
> 		spin_unlock(&global_lock);
> 	}
> 
> All code paths leading from the do_something_locked() function's first
> read from global_flag acquire a lock, so endless load fusing cannot
> happen.
> 
> If the value read from global_flag is true, then global_flag is
> rechecked while holding ->f_lock, which, if global_flag is now false,
> prevents begin_global() from completing.  It is therefore safe to invoke
> do_something().
> 
> Otherwise, if either value read from global_flag is true, then after
> global_lock is acquired global_flag must be false.  The acquisition of
> ->f_lock will prevent any call to begin_global() from returning, which
> means that it is safe to release global_lock and invoke do_something().
> 
> For this to work, only those foo structures in foo_array[] may be passed
> to do_something_locked().  The reason for this is that the synchronization
> with begin_global() relies on momentarily holding the lock of each and
> every foo structure.

This doesn't mention the reason for the acquire-release
synchronization of global_flag.  It's needed because work done between
begin_global() and end_global() can affect a foo structure without
holding its private f_lock member, and we want all such work to be
visible to other threads when they call do_something_locked() later.

Alan
