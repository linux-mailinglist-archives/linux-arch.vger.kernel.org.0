Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E527F8C6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 06:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgJAEvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 00:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgJAEvQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Oct 2020 00:51:16 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5774C20888;
        Thu,  1 Oct 2020 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601527876;
        bh=56/NQXRekQLOxrrnodOwJGve66GHBxBkrytoG7ugbkQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=SeT3a9SJpC9BMG3NGpQ5tQ/pFaRtUShyb1SwtCjw5l6cXhqf7vY7SiyG0nvUirv82
         ZzTmbhHwCBm/rstQWGS+e/WmBsRF8A2G58sYRFitkJcf8evDDo0u9b0J+Z89OrTWDu
         zcxsJq39pycx8yBD05ziTVZtHLopIu/dQ2LlWWi0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 23B6A3522A7F; Wed, 30 Sep 2020 21:51:16 -0700 (PDT)
Date:   Wed, 30 Sep 2020 21:51:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Litmus test for question from Al Viro
Message-ID: <20201001045116.GA5014@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

Al Viro posted the following query:

------------------------------------------------------------------------

<viro> fun question regarding barriers, if you have time for that
<viro>         V->A = V->B = 1;
<viro>
<viro> CPU1:
<viro>         to_free = NULL
<viro>         spin_lock(&LOCK)
<viro>         if (!smp_load_acquire(&V->B))
<viro>                 to_free = V
<viro>         V->A = 0
<viro>         spin_unlock(&LOCK)
<viro>         kfree(to_free)
<viro>
<viro> CPU2:
<viro>         to_free = V;
<viro>         if (READ_ONCE(V->A)) {
<viro>                 spin_lock(&LOCK)
<viro>                 if (V->A)
<viro>                         to_free = NULL
<viro>                 smp_store_release(&V->B, 0);
<viro>                 spin_unlock(&LOCK)
<viro>         }
<viro>         kfree(to_free);
<viro> 1) is it guaranteed that V will be freed exactly once and that
	  no accesses to *V will happen after freeing it?
<viro> 2) do we need smp_store_release() there?  I.e. will anything
	  break if it's replaced with plain V->B = 0?

------------------------------------------------------------------------

Of course herd7 supports neither structures nor arrays, but I was
crazy enough to try individual variables with made-up address and data
dependencies.  This litmus test must also detect use-after-free bugs,
but a simple variable should be able to do that.  So here is a
prototype:

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
	WRITE_ONCE(*a, r9b - r9b); // Use data dependency
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

	r0 = READ_ONCE(*v);
	r9a = r0; // Use after free?
	r8 = r9a - r9a; // Restore address dependency
	r8 = a + r8;
	r1 = READ_ONCE(*r8);
	if (r1) {
		spin_lock(l);
		r9b = READ_ONCE(*v); // Use after free?
		r8 = r9b - r9b; // Restore address dependency
		r8 = a + r8;
		r1a = READ_ONCE(*r8);
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

------------------------------------------------------------------------

This "exists" clause is satisfied:

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
Condition exists (0:r0=1:r0 \/ v=1 \/ 0:r2=0 \/ 1:r2=0 \/ 0:r9a=0 \/ 0:r9b=0 \/ 1:r9a=0 \/ 1:r9b=0 \/ 1:r9c=0)
Observation C-viro-2020.09.29a Sometimes 3 2
Time C-viro-2020.09.29a 14.33
Hash=89f74abff4de682ee0bea8ee6dd53134

------------------------------------------------------------------------

So did we end up with herd7 not respecting "fake" dependencies like
those shown above, or have I just messed up the translation from Al's
example to the litmus test?  (Given one thing and another over the past
couple of days, my guess would be that I just messed up the translation,
especially given that I don't see a reference to fake dependencies in
the documentation, but I figured that I should ask.)

							Thanx, Paul
