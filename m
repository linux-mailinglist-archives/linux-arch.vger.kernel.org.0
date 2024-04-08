Return-Path: <linux-arch+bounces-3508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F289CD0B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DFD1C2235C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3CF146D6F;
	Mon,  8 Apr 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Gf5GXb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CB5FB8F;
	Mon,  8 Apr 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609184; cv=none; b=E5FBbg8V4goq3gsJyis3Yl+MCM/2nxDA6MMhebTlc6ZszIlfvLPmFGqqbO4rG6ipp85/xxGKhyIN477CxJKMPbUwJb6SQvVT54lOaPZdEoO+McEE3zAVAnmCspM3ddXZ2TDDcu8+7DXUXnVkyN+4UHAl1P/peU6g513seATgKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609184; c=relaxed/simple;
	bh=bawdjiIKxvS+NQAyajiRxWqDPypoasRV2+XE1wBqy8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDQDaMXQNCTrv1/M762jRnjC5te2WcsZWcez+O14vOUPxKL7WSuVq3mkbcnHVVea3YS44XgfP6qYWJOXmHsr884zDPG5ah3P7RgUnWuyU3oReD6naS77mAT3e4UEyZ1yKDAtui0S5q7Yj+uCEE4JOnImB3X95slcPbbDyrDEuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Gf5GXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B0C433C7;
	Mon,  8 Apr 2024 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712609183;
	bh=bawdjiIKxvS+NQAyajiRxWqDPypoasRV2+XE1wBqy8Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=m7Gf5GXb6iK22KgIcBH3SH58M9klBxgKQVofhd+Nb8m3rH6B1E64AmjDkXDTjJtpV
	 KMDbW9bJQ62vDPXXM++pnfd3qQm9H3iXL8If0Q+UOObnO5nHmEmh5F4f7/IzWPPJkg
	 31GiIpqQRGIpmWwd/++NpVLOljDPHxSZ6B3nEk3jpFrjF1kcmKD/rzCwUBtbLGA/bN
	 DgQnkFZCKnOwufxw+6nR/vn74S+9QPrYEKuXtzaKddQdYs7ApwVt0ngMZnLwNcHYwN
	 9u2AY9GyWBJGsrWPwhAjb/OsLVeHj2WAxFnhPCaujLG9zKiTdhxG0MPMftAOnmb4Tz
	 gJh9CVCrMkPBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1CAD5CE126C; Mon,  8 Apr 2024 13:46:23 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:46:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/3] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <88b71a34-3d50-40a8-b4b6-c2d29a5d93a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
 <20240404192649.531112-2-paulmck@kernel.org>
 <Zg/M141yzwnwPbCi@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg/M141yzwnwPbCi@andrea>

On Fri, Apr 05, 2024 at 12:05:11PM +0200, Andrea Parri wrote:
> >  DCL-broken.litmus
> > -	Demonstrates that double-checked locking needs more than just
> > -	the obvious lock acquisitions and releases.
> > +    Demonstrates that double-checked locking needs more than just
> > +    the obvious lock acquisitions and releases.
> >  
> >  DCL-fixed.litmus
> > -	Demonstrates corrected double-checked locking that uses
> > -	smp_store_release() and smp_load_acquire() in addition to the
> > -	obvious lock acquisitions and releases.
> > +    Demonstrates corrected double-checked locking that uses
> > +    smp_store_release() and smp_load_acquire() in addition to the
> > +    obvious lock acquisitions and releases.
> >  
> >  RM-broken.litmus
> > -	Demonstrates problems with "roach motel" locking, where code is
> > -	freely moved into lock-based critical sections.  This example also
> > -	shows how to use the "filter" clause to discard executions that
> > -	would be excluded by other code not modeled in the litmus test.
> > -	Note also that this "roach motel" optimization is emulated by
> > -	physically moving P1()'s two reads from x under the lock.
> > +    Demonstrates problems with "roach motel" locking, where code is
> > +    freely moved into lock-based critical sections.  This example also
> > +    shows how to use the "filter" clause to discard executions that
> > +    would be excluded by other code not modeled in the litmus test.
> > +    Note also that this "roach motel" optimization is emulated by
> > +    physically moving P1()'s two reads from x under the lock.
> >  
> > -	What is a roach motel?	This is from an old advertisement for
> > -	a cockroach trap, much later featured in one of the "Men in
> > -	Black" movies.	"The roaches check in.	They don't check out."
> > +    What is a roach motel?  This is from an old advertisement for
> > +    a cockroach trap, much later featured in one of the "Men in
> > +    Black" movies.  "The roaches check in.  They don't check out."
> >  
> >  RM-fixed.litmus
> > -	The counterpart to RM-broken.litmus, showing P0()'s two loads from
> > -	x safely outside of the critical section.
> > +    The counterpart to RM-broken.litmus, showing P0()'s two loads from
> > +    x safely outside of the critical section.
> 
> AFAIU, the changes above belong to patch #1.  Looks like you realigned
> the text, but forgot to integrate the changes in #1?

Good eyes!  I will catch this in my next rebase.

> > +C cmpxchg-fail-ordered-1
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Demonstrate that a failing cmpxchg() operation will act as a full
> > + * barrier when followed by smp_mb__after_atomic().
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y, int *z)
> > +{
> > +	int r0;
> > +	int r1;
> > +
> > +	WRITE_ONCE(*x, 1);
> > +	r1 = cmpxchg(z, 1, 0);
> > +	smp_mb__after_atomic();
> > +	r0 = READ_ONCE(*y);
> > +}
> > +
> > +P1(int *x, int *y, int *z)
> > +{
> > +	int r0;
> > +
> > +	WRITE_ONCE(*y, 1);
> > +	r1 = cmpxchg(z, 1, 0);
> 
> P1's r1 is undeclared (so klitmus7 will complain).
> 
> The same observation holds for cmpxchg-fail-unordered-1.litmus.

Good catch in all four tests, thank you!

Does the patch shown at the end of this email clear things up for you?

							Thanx, Paul

> > +	smp_mb__after_atomic();
> > +	r0 = READ_ONCE(*x);
> > +}
> > +
> > +locations[0:r1;1:r1]
> > +exists (0:r0=0 /\ 1:r0=0)
> 
> 
> > +C cmpxchg-fail-ordered-2
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Demonstrate use of smp_mb__after_atomic() to make a failing cmpxchg
> > + * operation have acquire ordering.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y)
> > +{
> > +	int r0;
> > +	int r1;
> > +
> > +	WRITE_ONCE(*x, 1);
> > +	r1 = cmpxchg(y, 0, 1);
> > +}
> > +
> > +P1(int *x, int *y)
> > +{
> > +	int r0;
> > +
> > +	r1 = cmpxchg(y, 0, 1);
> > +	smp_mb__after_atomic();
> > +	r2 = READ_ONCE(*x);
> 
> P1's r1 and r2 are undeclared.  P0's r0 and P1's r0 are unused.
> 
> Same for cmpxchg-fail-unordered-2.litmus.
> 
>   Andrea

------------------------------------------------------------------------

commit 5ce4d0efe11fd101ff938f6116cdd9b6fe46a98c
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Apr 8 13:41:22 2024 -0700

    Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus
    
    The four litmus tests in Documentation/litmus-tests/atomic do not
    declare all of their local variables.  Although this is just fine for LKMM
    analysis by herd7, it causes build failures when run in-kernel by klitmus.
    This commit therefore adjusts these tests to declare all local variables.
    
    Reported-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
index 3df1d140b189b..c0f93dc07105e 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
@@ -23,6 +23,7 @@ P0(int *x, int *y, int *z)
 P1(int *x, int *y, int *z)
 {
 	int r0;
+	int r1;
 
 	WRITE_ONCE(*y, 1);
 	r1 = cmpxchg(z, 1, 0);
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
index 54146044a16f6..5c06054f46947 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
@@ -11,7 +11,6 @@ C cmpxchg-fail-ordered-2
 
 P0(int *x, int *y)
 {
-	int r0;
 	int r1;
 
 	WRITE_ONCE(*x, 1);
@@ -20,7 +19,8 @@ P0(int *x, int *y)
 
 P1(int *x, int *y)
 {
-	int r0;
+	int r1;
+	int r2;
 
 	r1 = cmpxchg(y, 0, 1);
 	smp_mb__after_atomic();
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
index a727ce23b1a6e..39ea1f56a28d2 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
@@ -23,6 +23,7 @@ P0(int *x, int *y, int *z)
 P1(int *x, int *y, int *z)
 {
 	int r0;
+	int r1;
 
 	WRITE_ONCE(*y, 1);
 	r1 = cmpxchg(z, 1, 0);
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
index a245bac55b578..61aab24a4a643 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
@@ -12,7 +12,6 @@ C cmpxchg-fail-unordered-2
 
 P0(int *x, int *y)
 {
-	int r0;
 	int r1;
 
 	WRITE_ONCE(*x, 1);
@@ -21,7 +20,8 @@ P0(int *x, int *y)
 
 P1(int *x, int *y)
 {
-	int r0;
+	int r1;
+	int r2;
 
 	r1 = cmpxchg(y, 0, 1);
 	r2 = READ_ONCE(*x);

