Return-Path: <linux-arch+bounces-4962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA290D5B4
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081711F21CAF
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D316DC20;
	Tue, 18 Jun 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN3juXFQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C516DC13;
	Tue, 18 Jun 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720954; cv=none; b=dQpgfl9LuBuH+jIgevn4CuqPA+oV2vZ2F77klKBc6ZmAfJ9a1SYrJrjeyde51PtfQ39RqXBfQyLje+8ODsxYqdb2A9QcDdCMSYBE14ycD23hRD8JaK+iyasKnDjwnMwbt90MVwEaXv4RWdXuXvi2YIB0Wc3rCVpDgin6XnOncLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720954; c=relaxed/simple;
	bh=arD01RFmjVuX2d7MMTwsJJG8uCSWu9fkHeBWtc/BlM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E69GoQVgVqDmBXpdYgB/wMkgGbb5atpC+HqtQDialf2A4Lh6SuqxF+DSDZ5Q8LK+/z2gzUxfXQugUphjP4o9sDgYr6nyuZ5DeJ/rddHgyOlnfnzDVEe1QnUMOVCQAlxSwMr69x/FSlN065d/Fx6k/9Ngo2N8ZCGsN2inQJTR2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN3juXFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4CC4AF1D;
	Tue, 18 Jun 2024 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720953;
	bh=arD01RFmjVuX2d7MMTwsJJG8uCSWu9fkHeBWtc/BlM0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NN3juXFQ5WL4OcCKjvnQlfUYcn5ctYFJynDTvFiDW2MN2dDsyPFw826tROSXhN24N
	 FHki7lQx/sWw3dG9rfZf/n7xJ/RSqNip6r+M2LrOIO2LMOCuq2IFVmHJcCh2lgiMG6
	 5wvEB6odz7DVW2CD37jQF1WJe56PgSwrbNe2vybQLv1+KtNhP84gz/voRrK9arVBPW
	 wdWabDGVxNdmmzM404nnMtx9Zp3ju/J16Mh2gR+zsqikHmdCmXf+bN1YHwVCvItFgU
	 R5LV8NbtzJAokdmcdmWkeZWQ7xwevlk1c41o0NqnX8VngjYyW0XJtIDhJ8XiPtyV/m
	 O0D+ijHqyuTxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33938CE04AF; Tue, 18 Jun 2024 07:29:13 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:29:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <6a7235ae-047d-484f-9180-1bd90e935468@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617201759.1670994-1-parri.andrea@gmail.com>

On Mon, Jun 17, 2024 at 10:17:59PM +0200, Andrea Parri wrote:
> tools/memory-model/ and herdtool7 are closely linked: the latter is
> responsible for (pre)processing each C-like macro of a litmus test,
> and for providing the LKMM with a set of events, or "representation",
> corresponding to the given macro.  Provide herd-representation.txt
> to document the representations of the concurrency macros, following
> their "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Queued, thank you!

I added Boqun's and Hernan's Reviewed-by tags and did the usual
wordsmithing.  Please check below to make sure that I did not mess
anything up.

Also, Puranjay added atomic_and()/or()/xor() and add_negative, which
is slated to go in to the next merge window:

be98107ab8a5 ("tools/memory-model: Add atomic_and()/or()/xor() and add_negative")

Would you like to add the corresponding lines to this table?

							Thanx, Paul

------------------------------------------------------------------------

commit 0e72657b7cb518ef8d996e2bf9bf14676da9af3f
Author: Andrea Parri <parri.andrea@gmail.com>
Date:   Mon Jun 17 22:17:59 2024 +0200

    tools/memory-model: Document herd7 (abstract) representation
    
    The Linux-kernel memory model (LKMM) source code and the herd7 tool are
    closely linked in that the latter is responsible for (pre)processing
    each C-like macro of a litmus test, and for providing the LKMM with a
    set of events, or "representation", corresponding to the given macro.
    This commit therefore provides herd-representation.txt to document
    the representations of the concurrency macros, following their
    "classification" in Documentation/atomic_t.txt.
    
    Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
    Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
    Reviewed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 304162743a5b8..44e7dae73b296 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
 
 o	You are familiar with Linux-kernel concurrency and the use
 	of LKMM, and would like to learn about LKMM's requirements,
-	rationale, and implementation:	explanation.txt
+	rationale, and implementation:	explanation.txt and
+	herd-representation.txt
 
 o	You are interested in the publications related to LKMM, including
 	hardware manuals, academic literature, standards-committee
@@ -61,6 +62,10 @@ control-dependencies.txt
 explanation.txt
 	Detailed description of the memory model.
 
+herd-representation.txt
+	The (abstract) representation of the Linux-kernel concurrency
+	primitives in terms of events.
+
 litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
new file mode 100644
index 0000000000000..6f09df2372d2f
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,106 @@
+#
+# Legend:
+#	R,	a Load event
+#	W,	a Store event
+#	F,	a Fence event
+#	LKR,	a Lock-Read event
+#	LKW,	a Lock-Write event
+#	UL,	an Unlock event
+#	LF,	a Lock-Fail event
+#	RL,	a Read-Locked event
+#	RU,	a Read-Unlocked event
+#	R*,	a Load event included in RMW
+#	W*,	a Store event included in RMW
+#	SRCU,	a Sleepable-Read-Copy-Update event
+#
+#	po,	a Program-Order link
+#	rmw,	a Read-Modify-Write link
+#
+# By convention, a blank line in a cell means "same as the preceding line".
+#
+    ------------------------------------------------------------------------------
+    |                        C macro | Events                                    |
+    ------------------------------------------------------------------------------
+    |                    Non-RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                      READ_ONCE | R[once]                                   |
+    |                    atomic_read |                                           |
+    |                     WRITE_ONCE | W[once]                                   |
+    |                     atomic_set |                                           |
+    |               smp_load_acquire | R[acquire]                                |
+    |            atomic_read_acquire |                                           |
+    |              smp_store_release | W[release]                                |
+    |             atomic_set_release |                                           |
+    |                   smp_store_mb | W[once] ->po F[mb]                        |
+    |                         smp_mb | F[mb]                                     |
+    |                        smp_rmb | F[rmb]                                    |
+    |                        smp_wmb | F[wmb]                                    |
+    |          smp_mb__before_atomic | F[before-atomic]                          |
+    |           smp_mb__after_atomic | F[after-atomic]                           |
+    |                    spin_unlock | UL                                        |
+    |                 spin_is_locked | On success: RL                            |
+    |                                | On failure: RU                            |
+    |         smp_mb__after_spinlock | F[after-spinlock]                         |
+    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
+    |                  rcu_read_lock | F[rcu-lock]                               |
+    |                rcu_read_unlock | F[rcu-unlock]                             |
+    |                synchronize_rcu | F[sync-rcu]                               |
+    |                rcu_dereference | R[once]                                   |
+    |             rcu_assign_pointer | W[release]                                |
+    |                 srcu_read_lock | R[srcu-lock]                              |
+    |                 srcu_down_read |                                           |
+    |               srcu_read_unlock | W[srcu-unlock]                            |
+    |                   srcu_up_read |                                           |
+    |               synchronize_srcu | SRCU[sync-srcu]                           |
+    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
+    ------------------------------------------------------------------------------
+    |       RMW ops w/o return value |                                           |
+    ------------------------------------------------------------------------------
+    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                     atomic_and |                                           |
+    |                      spin_lock | LKR ->po LKW                              |
+    ------------------------------------------------------------------------------
+    |        RMW ops w/ return value |                                           |
+    ------------------------------------------------------------------------------
+    |              atomic_add_return | F[mb] ->po R*[once]                       |
+    |                                |     ->rmw W*[once] ->po F[mb]             |
+    |               atomic_fetch_add |                                           |
+    |               atomic_fetch_and |                                           |
+    |                    atomic_xchg |                                           |
+    |                           xchg |                                           |
+    |            atomic_add_negative |                                           |
+    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
+    |       atomic_fetch_add_relaxed |                                           |
+    |       atomic_fetch_and_relaxed |                                           |
+    |            atomic_xchg_relaxed |                                           |
+    |                   xchg_relaxed |                                           |
+    |    atomic_add_negative_relaxed |                                           |
+    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |       atomic_fetch_add_acquire |                                           |
+    |       atomic_fetch_and_acquire |                                           |
+    |            atomic_xchg_acquire |                                           |
+    |                   xchg_acquire |                                           |
+    |    atomic_add_negative_acquire |                                           |
+    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |       atomic_fetch_add_release |                                           |
+    |       atomic_fetch_and_release |                                           |
+    |            atomic_xchg_release |                                           |
+    |                   xchg_release |                                           |
+    |    atomic_add_negative_release |                                           |
+    ------------------------------------------------------------------------------
+    |            Conditional RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
+    |                                |                 ->rmw W*[once] ->po F[mb] |
+    |                                | On failure: R*[once]                      |
+    |                        cmpxchg |                                           |
+    |              atomic_add_unless |                                           |
+    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
+    |                                | On failure: R*[once]                      |
+    |                   spin_trylock | On success: LKR ->po LKW                  |
+    |                                | On failure: LF                            |
+    ------------------------------------------------------------------------------

