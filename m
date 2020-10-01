Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECC280969
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 23:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgJAVav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 17:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVau (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Oct 2020 17:30:50 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48E620796;
        Thu,  1 Oct 2020 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601587848;
        bh=f4Nb2NYx6X2yxypHJc/DaT7ek5uyvHKo6KzogQYi/n8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TFanxDMEj5c96O6NFTE7Iag++hH8PCxLhwrqT82F1jXrIRL+ry6dZ6bVFZINTeTXA
         GOUq7Mml4bIXKNW/GVhPYPc0OfcSmLZutGxxaLUw5NwK/2NZEAxYAP+hkidJYSismT
         Iy6IPLqCxQR8SFuunHxM0Kl7wXSXBApSqDH1nHrw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB1153522B33; Thu,  1 Oct 2020 14:30:48 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:30:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201001213048.GF29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001161529.GA251468@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 12:15:29PM -0400, Alan Stern wrote:
> On Wed, Sep 30, 2020 at 09:51:16PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Al Viro posted the following query:
> > 
> > ------------------------------------------------------------------------
> > 
> > <viro> fun question regarding barriers, if you have time for that
> > <viro>         V->A = V->B = 1;
> > <viro>
> > <viro> CPU1:
> > <viro>         to_free = NULL
> > <viro>         spin_lock(&LOCK)
> > <viro>         if (!smp_load_acquire(&V->B))
> > <viro>                 to_free = V
> > <viro>         V->A = 0
> > <viro>         spin_unlock(&LOCK)
> > <viro>         kfree(to_free)
> > <viro>
> > <viro> CPU2:
> > <viro>         to_free = V;
> > <viro>         if (READ_ONCE(V->A)) {
> > <viro>                 spin_lock(&LOCK)
> > <viro>                 if (V->A)
> > <viro>                         to_free = NULL
> > <viro>                 smp_store_release(&V->B, 0);
> > <viro>                 spin_unlock(&LOCK)
> > <viro>         }
> > <viro>         kfree(to_free);
> > <viro> 1) is it guaranteed that V will be freed exactly once and that
> > 	  no accesses to *V will happen after freeing it?
> > <viro> 2) do we need smp_store_release() there?  I.e. will anything
> > 	  break if it's replaced with plain V->B = 0?
> 
> Here are my answers to Al's questions:
> 
> 1) It is guaranteed that V will be freed exactly once.  It is not 
> guaranteed that no accesses to *V will occur after it is freed, because 
> the test contains a data race.  CPU1's plain "V->A = 0" write races with 
> CPU2's READ_ONCE; if the plain write were replaced with 
> "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well, 
> CPU1's smp_load_acquire could be replaced with a plain read while the 
> plain write is replaced with smp_store_release.
> 
> 2) The smp_store_release in CPU2 is not needed.  Replacing it with a 
> plain V->B = 0 will not break anything.
> 
> Analysis: Apart from the kfree calls themselves, the only access to a 
> shared variable outside of a critical section is CPU2's READ_ONCE of 
> V->A.  So let's consider two possibilities:
> 
> 1: The READ_ONCE returns 0.  Then CPU2 doesn't execute its critical 
> section and does kfree(V).  However, the fact that the READ_ONCE got 0 
> means that CPU1 has already entered its critical section, has already 
> written to V->A (but with a plain write!) and therefore has already seen 
> V->B = 1 (because of the smp_load_acquire), and therefore will not free 
> V.  This case shows that the ordering we require is for CPU1 to read 
> V->B before it writes V->A.  The ordering can be enforced by using 
> either a load-acquire (as in the litmus test) or a store-release.
> 
> 2: The READ_ONCE returns 1.  Then CPU2 does execute its critical 
> section, and we can simply treat this case the same as if the critical 
> section was executed unconditionally.  Whichever CPU runs its critical 
> section second will free V, and the other CPU won't try to access V 
> after leaving its own critical section (and thus won't access V after it 
> has been freed).
> 
> > ------------------------------------------------------------------------
> > 
> > Of course herd7 supports neither structures nor arrays, but I was
> > crazy enough to try individual variables with made-up address and data
> > dependencies.  This litmus test must also detect use-after-free bugs,
> > but a simple variable should be able to do that.  So here is a
> > prototype:
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-viro-2020.09.29a
> > 
> > {
> > 	int a = 1;
> > 	int b = 1;
> > 	int v = 1;
> > }
> 
> Not the way I would have done it, but okay.  I would have modeled the 
> kfree by setting a and b both to some sentinel value.

Might be well worth pursuing!  But how would you model the address
dependencies in that approach?

> > P0(int *a, int *b, int *v, spinlock_t *l)
> > {
> > 	int r0;
> > 	int r1;
> > 	int r2 = 2;
> > 	int r8;
> > 	int r9a = 2;
> > 	int r9b = 2;
> > 
> > 	r0 = 0;
> > 	spin_lock(l);
> > 	r9a = READ_ONCE(*v); // Use after free?
> > 	r8 = r9a - r9a; // Restore address dependency
> > 	r8 = b + r8;
> > 	r1 = smp_load_acquire(r8);
> > 	if (r1 == 0)
> > 		r0 = 1;
> > 	r9b = READ_ONCE(*v); // Use after free?
> > 	WRITE_ONCE(*a, r9b - r9b); // Use data dependency
> > 	spin_unlock(l);
> > 	if (r0) {
> > 		r2 = READ_ONCE(*v);
> > 		WRITE_ONCE(*v, 0); /* kfree(). */
> > 	}
> > }
> > 
> > P1(int *a, int *b, int *v, spinlock_t *l)
> > {
> > 	int r0;
> > 	int r1;
> > 	int r1a;
> > 	int r2 = 2;
> > 	int r8;
> > 	int r9a = 2;
> > 	int r9b = 2;
> > 	int r9c = 2;
> > 
> > 	r0 = READ_ONCE(*v);
> > 	r9a = r0; // Use after free?
> 
> Wrong.  This should be:
> 
> 	r0 = 1;
> 	r9a = READ_ONCE(*v);

Thank you!  I was definitely suffering from a severe case of Programmer's
Blindness.  Fixed!

> > 	r8 = r9a - r9a; // Restore address dependency
> > 	r8 = a + r8;
> > 	r1 = READ_ONCE(*r8);
> > 	if (r1) {
> > 		spin_lock(l);
> > 		r9b = READ_ONCE(*v); // Use after free?
> > 		r8 = r9b - r9b; // Restore address dependency
> > 		r8 = a + r8;
> > 		r1a = READ_ONCE(*r8);
> > 		if (r1a)
> > 			r0 = 0;
> > 		r9c = READ_ONCE(*v); // Use after free?
> > 		smp_store_release(b, r9c - rc9); // Use data dependency
> > 		spin_unlock(l);
> > 	}
> > 	if (r0) {
> > 		r2 = READ_ONCE(*v);
> > 		WRITE_ONCE(*v, 0); /* kfree(). */
> > 	}
> > }
> > 
> > locations [a;b;v;0:r1;0:r8;1:r1;1:r8]
> > exists (0:r0=1:r0 \/ (* Both or neither did kfree(). *)
> > 	v=1 \/ (* Neither did kfree, redundant check. *)
> > 	0:r2=0 \/ 1:r2=0 \/  (* Both did kfree, redundant check. *)
> > 	0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ (* CPU1 use after free. *)
> > 	1:r9b=0 \/ 1:r9c=0) (* CPU2 use after free. *)
> > 
> > ------------------------------------------------------------------------
> > 
> > This "exists" clause is satisfied:
> > 
> > ------------------------------------------------------------------------
> > 
> > $ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/C-viro-2020.09.29a.litmus
> > Test C-viro-2020.09.29a Allowed
> > States 5
> > 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=0; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> > 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> > 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=0; 1:r1=1; 1:r2=2; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=1;
> 
> The values for this case don't make sense.  I haven't checked the other 
> four cases.  Printing a graph of the relations for this case (the only 
> state with v=1 at the end) might help.
> 
> > 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> > 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=1; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=0;
> > Ok
> > Witnesses
> > Positive: 3 Negative: 2
> > Condition exists (0:r0=1:r0 \/ v=1 \/ 0:r2=0 \/ 1:r2=0 \/ 0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ 1:r9b=0 \/ 1:r9c=0)
> > Observation C-viro-2020.09.29a Sometimes 3 2
> > Time C-viro-2020.09.29a 14.33
> > Hash=89f74abff4de682ee0bea8ee6dd53134
> 
> Why didn't this flag the data race?

Because I turned Al's simple assignments into *_ONCE() or better.
In doing this, I was following the default KCSAN settings which
(for better or worse) forgive the stores from data races.

> > ------------------------------------------------------------------------
> > 
> > So did we end up with herd7 not respecting "fake" dependencies like
> > those shown above, or have I just messed up the translation from Al's
> > example to the litmus test?  (Given one thing and another over the past
> > couple of days, my guess would be that I just messed up the translation,
> > especially given that I don't see a reference to fake dependencies in
> > the documentation, but I figured that I should ask.)
> 
> What do you get if you fix up the litmus test?

With your suggested change and using simple assignments where Al
indicated them:

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/C-viro-2020.09.29a.litmus
Test C-viro-2020.09.29a Allowed
States 5
0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=0; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=0; 1:r1=1; 1:r2=2; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=1;
0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=1; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=0;
Ok
Witnesses
Positive: 3 Negative: 2
Flag data-race
Condition exists (0:r0=1:r0 \/ v=1 \/ 0:r2=0 \/ 1:r2=0 \/ 0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ 1:r9b=0 \/ 1:r9c=0)
Observation C-viro-2020.09.29a Sometimes 3 2
Time C-viro-2020.09.29a 17.95
Hash=14ded51102b668bc38b790e8c3692227

------------------------------------------------------------------------

So still "Sometimes", but the "Flag data-race" you expected is there.

I posted the updated litmus test below.  Additional or other thoughts?

							Thanx, Paul

------------------------------------------------------------------------

C C-viro-2020.09.29a

{
	int a = 1;
	int b = 1;
	int v = 1;
}


P0(int *a, int *b, int *v, spinlock_t *l)
{
	int r0;
	int r1;
	int r2 = 2;
	int r8;
	int r9a = 2;
	int r9b = 2;

	r0 = 0;
	spin_lock(l);
	r9a = READ_ONCE(*v); // Use after free?
	r8 = r9a - r9a; // Restore address dependency
	r8 = b + r8;
	r1 = smp_load_acquire(r8);
	if (r1 == 0)
		r0 = 1;
	r9b = READ_ONCE(*v); // Use after free?
	// WRITE_ONCE(*a, r9b - r9b); // Use data dependency
	*a = r9b - r9b; // Use data dependency
	spin_unlock(l);
	if (r0) {
		r2 = READ_ONCE(*v);
		WRITE_ONCE(*v, 0); /* kfree(). */
	}
}

P1(int *a, int *b, int *v, spinlock_t *l)
{
	int r0;
	int r1;
	int r1a;
	int r2 = 2;
	int r8;
	int r9a = 2;
	int r9b = 2;
	int r9c = 2;

	r0 = 1;
	r9a = READ_ONCE(*v); // Use after free?
	r8 = r9a - r9a; // Restore address dependency
	r8 = a + r8;
	r1 = READ_ONCE(*r8);
	if (r1) {
		spin_lock(l);
		r9b = READ_ONCE(*v); // Use after free?
		r8 = r9b - r9b; // Restore address dependency
		r8 = a + r8;
		// r1a = READ_ONCE(*r8);
		r1a = *r8;
		if (r1a)
			r0 = 0;
		r9c = READ_ONCE(*v); // Use after free?
		smp_store_release(b, r9c - rc9); // Use data dependency
		spin_unlock(l);
	}
	if (r0) {
		r2 = READ_ONCE(*v);
		WRITE_ONCE(*v, 0); /* kfree(). */
	}
}

locations [a;b;v;0:r1;0:r8;1:r1;1:r8]
exists (0:r0=1:r0 \/ (* Both or neither did kfree(). *)
	v=1 \/ (* Neither did kfree, redundant check. *)
	0:r2=0 \/ 1:r2=0 \/  (* Both did kfree, redundant check. *)
	0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ (* CPU1 use after free. *)
	1:r9b=0 \/ 1:r9c=0) (* CPU2 use after free. *)
