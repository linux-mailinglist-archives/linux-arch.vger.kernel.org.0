Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0208E282047
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJCCBi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 22:01:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34959 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725550AbgJCCBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 22:01:37 -0400
Received: (qmail 308317 invoked by uid 1000); 2 Oct 2020 22:01:36 -0400
Date:   Fri, 2 Oct 2020 22:01:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201003020136.GA307978@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001213048.GF29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 02:30:48PM -0700, Paul E. McKenney wrote:
> > Not the way I would have done it, but okay.  I would have modeled the 
> > kfree by setting a and b both to some sentinel value.
> 
> Might be well worth pursuing!  But how would you model the address
> dependencies in that approach?

Al's original test never writes to V.  So the address dependencies don't 
matter.

> > Why didn't this flag the data race?
> 
> Because I turned Al's simple assignments into *_ONCE() or better.
> In doing this, I was following the default KCSAN settings which
> (for better or worse) forgive the stores from data races.

Ah, yes.  I had realized that when reading the litmus test for the first 
time, and then forgot it.

> With your suggested change and using simple assignments where Al
> indicated them:
> 
> ------------------------------------------------------------------------
> 
> $ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/C-viro-2020.09.29a.litmus
> Test C-viro-2020.09.29a Allowed
> States 5
> 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=0; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=0; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=0; 1:r1=1; 1:r2=2; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=1;
> 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=0; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=2; 1:r9c=2; a=0; b=1; v=0;
> 0:r0=0; 0:r1=1; 0:r2=2; 0:r8=b; 0:r9a=1; 0:r9b=1; 1:r0=1; 1:r1=1; 1:r2=1; 1:r8=a; 1:r9a=1; 1:r9b=1; 1:r9c=1; a=0; b=1; v=0;
> Ok
> Witnesses
> Positive: 3 Negative: 2
> Flag data-race
> Condition exists (0:r0=1:r0 \/ v=1 \/ 0:r2=0 \/ 1:r2=0 \/ 0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ 1:r9b=0 \/ 1:r9c=0)
> Observation C-viro-2020.09.29a Sometimes 3 2
> Time C-viro-2020.09.29a 17.95
> Hash=14ded51102b668bc38b790e8c3692227
> 
> ------------------------------------------------------------------------
> 
> So still "Sometimes", but the "Flag data-race" you expected is there.
> 
> I posted the updated litmus test below.  Additional or other thoughts?

Two problems remaining.  One in the litmus test and one in the memory 
model itself...

> ------------------------------------------------------------------------
> 
> C C-viro-2020.09.29a
> 
> {
> 	int a = 1;
> 	int b = 1;
> 	int v = 1;
> }
> 
> 
> P0(int *a, int *b, int *v, spinlock_t *l)
> {
> 	int r0;
> 	int r1;
> 	int r2 = 2;
> 	int r8;
> 	int r9a = 2;
> 	int r9b = 2;
> 
> 	r0 = 0;
> 	spin_lock(l);
> 	r9a = READ_ONCE(*v); // Use after free?
> 	r8 = r9a - r9a; // Restore address dependency
> 	r8 = b + r8;
> 	r1 = smp_load_acquire(r8);
> 	if (r1 == 0)
> 		r0 = 1;
> 	r9b = READ_ONCE(*v); // Use after free?
> 	// WRITE_ONCE(*a, r9b - r9b); // Use data dependency
> 	*a = r9b - r9b; // Use data dependency
> 	spin_unlock(l);
> 	if (r0) {
> 		r2 = READ_ONCE(*v);
> 		WRITE_ONCE(*v, 0); /* kfree(). */
> 	}
> }
> 
> P1(int *a, int *b, int *v, spinlock_t *l)
> {
> 	int r0;
> 	int r1;
> 	int r1a;
> 	int r2 = 2;
> 	int r8;
> 	int r9a = 2;
> 	int r9b = 2;
> 	int r9c = 2;
> 
> 	r0 = 1;
> 	r9a = READ_ONCE(*v); // Use after free?
> 	r8 = r9a - r9a; // Restore address dependency
> 	r8 = a + r8;
> 	r1 = READ_ONCE(*r8);
> 	if (r1) {
> 		spin_lock(l);
> 		r9b = READ_ONCE(*v); // Use after free?
> 		r8 = r9b - r9b; // Restore address dependency
> 		r8 = a + r8;
> 		// r1a = READ_ONCE(*r8);
> 		r1a = *r8;
> 		if (r1a)
> 			r0 = 0;
> 		r9c = READ_ONCE(*v); // Use after free?
> 		smp_store_release(b, r9c - rc9); // Use data dependency
-------------------------------------------^^^
Typo: this should be r9c.  Too bad herd7 doesn't warn about undeclared 
local variables.

> 		spin_unlock(l);
> 	}
> 	if (r0) {
> 		r2 = READ_ONCE(*v);
> 		WRITE_ONCE(*v, 0); /* kfree(). */
> 	}
> }
> 
> locations [a;b;v;0:r1;0:r8;1:r1;1:r8]
> exists (0:r0=1:r0 \/ (* Both or neither did kfree(). *)
> 	v=1 \/ (* Neither did kfree, redundant check. *)
> 	0:r2=0 \/ 1:r2=0 \/  (* Both did kfree, redundant check. *)
> 	0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ (* CPU1 use after free. *)
> 	1:r9b=0 \/ 1:r9c=0) (* CPU2 use after free. *)

When you fix the typo, the test still fails.  But now it all makes 
sense.  The reason for the failure is because of the way we don't model 
control dependencies.

In short, suppose P1 reads 0 for V->A.  Then it does:

	if (READ_ONCE(V->A)) {
		... skipped ...
	}
	WRITE_ONCE(V, 0); /* actually kfree(to_free); */

Because the WRITE_ONCE is beyond the end of the "if" statement, there is 
no control dependency.  Nevertheless, the compiler is not allowed to 
reorder those statements because the conditional code modifies to_free.

Since the memory model thinks there isn't any control dependency, herd7 
generates a potential execution (actually two of them) in which the 
WRITE_ONCE executes before the READ_ONCE.  And of course that messes 
everything up; in one of the executions 0:r9b is 0, and in the other 
both 0:r9a and 0:r9b are 0.

This failure to detect control dependencies properly is perhaps the 
weakest aspect of the memory model.

Alan
