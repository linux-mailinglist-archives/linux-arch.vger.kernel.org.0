Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7D3280713
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJASkD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 14:40:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35901 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733166AbgJASj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 14:39:26 -0400
Received: (qmail 260205 invoked by uid 1000); 1 Oct 2020 14:39:25 -0400
Date:   Thu, 1 Oct 2020 14:39:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201001183925.GA259470@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001163646.GG3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001163646.GG3421308@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 05:36:46PM +0100, Al Viro wrote:
> On Thu, Oct 01, 2020 at 12:15:29PM -0400, Alan Stern wrote:
> > > <viro> CPU1:
> > > <viro>         to_free = NULL
> > > <viro>         spin_lock(&LOCK)
> > > <viro>         if (!smp_load_acquire(&V->B))
> > > <viro>                 to_free = V
> > > <viro>         V->A = 0
> > > <viro>         spin_unlock(&LOCK)
> > > <viro>         kfree(to_free)
> > > <viro>
> > > <viro> CPU2:
> > > <viro>         to_free = V;
> > > <viro>         if (READ_ONCE(V->A)) {
> > > <viro>                 spin_lock(&LOCK)
> > > <viro>                 if (V->A)
> > > <viro>                         to_free = NULL
> > > <viro>                 smp_store_release(&V->B, 0);
> > > <viro>                 spin_unlock(&LOCK)
> > > <viro>         }
> > > <viro>         kfree(to_free);
> > > <viro> 1) is it guaranteed that V will be freed exactly once and that
> > > 	  no accesses to *V will happen after freeing it?
> > > <viro> 2) do we need smp_store_release() there?  I.e. will anything
> > > 	  break if it's replaced with plain V->B = 0?
> > 
> > Here are my answers to Al's questions:
> > 
> > 1) It is guaranteed that V will be freed exactly once.  It is not 
> > guaranteed that no accesses to *V will occur after it is freed, because 
> > the test contains a data race.  CPU1's plain "V->A = 0" write races with 
> > CPU2's READ_ONCE;
> 
> What will that READ_ONCE() yield in that case?  If it's non-zero, we should
> be fine - we won't get to kfree() until after we are done with the spinlock.
> And if it's zero...  What will CPU1 do with *V accesses _after_ it has issued
> the store to V->A?
> 
> Confused...

Presumably CPU2's READ_ONCE will yield either 0 or 1.  For the sake of 
argument, suppose it yields 0.  But that's not the problem.

The problem with a plain write is that it isn't guaranteed to be atomic 
in any sense.  In principle, the compiler could generate code for CPU1 
which would write 0 to V->A more than once.

Although I strongly doubt that any real compiler would actually do this, 
the memory model does allow for it, out of an overabundance of caution.  
So what could happen is:

	CPU1				CPU2
	Writes 0 to V->A a first time
					READ_ONCE(V->A) returns 0
					Skips the critical section
					Does kfree(V)
	Tries to write 0 to V->A a
	 second time

> > if the plain write were replaced with 
> > "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well, 
> > CPU1's smp_load_acquire could be replaced with a plain read while the 
> > plain write is replaced with smp_store_release.
> 
> Er...  Do you mean the write to ->A on CPU1?

Yes; that's the only plain write in the litmus test.

Alan
