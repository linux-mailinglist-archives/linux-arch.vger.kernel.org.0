Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751C65E248
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAEBKO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjAEBJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4930571;
        Wed,  4 Jan 2023 17:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBEF0B81982;
        Thu,  5 Jan 2023 01:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A915DC433F0;
        Thu,  5 Jan 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880994;
        bh=Jl/wA3obCQ6eP+HMrthbAFT6/bCzL6xUl5XhR4SNk5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtAp4j8g5wH01QrSdGedWr8TVWTjosN386/GaatyBP9EPwxuVUa0ZvQHTxXy7uJDn
         1RlL4eU5IfHfWduKnd4ULOUmWDO8AekemMFuH4pP59dEbqAopYSxrO9ijrvfVmeq3f
         OcQVPidUI1LX1xx0oxBuQPTOCP9Awh8cjGXFCNk3gDC2J3ox8IkBddaUzG+MXLQjAA
         CFYzL/G/ZAqOOnN7E9eVuVcVd2bIoqN3X+ryJz6mg6Qu7R2HMkh7N97MZVwe47pRAd
         XnSYwNW7EuBG1CZqiiIT+fhJHPzftb9jmOPxFtEBKCLeJt4VqMb2Nvv0UG5hRQvH50
         /AXa7YM7iWs4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 665A15C086D; Wed,  4 Jan 2023 17:09:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Viktor Vafeiadis <viktor@mpi-sws.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/4] tools: memory-model: Add rmw-sequences to the LKMM
Date:   Wed,  4 Jan 2023 17:09:50 -0800
Message-Id: <20230105010952.1774272-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Viktor (as relayed by Jonas) has pointed out a weakness in the Linux
Kernel Memory Model.  Namely, the memory ordering properties of atomic
operations are not monotonic: An atomic op with full-barrier semantics
does not always provide ordering as strong as one with release-barrier
semantics.

The following litmus test illustrates the problem:

--------------------------------------------------
C atomics-not-monotonic

{}

P0(int *x, atomic_t *y)
{
	WRITE_ONCE(*x, 1);
	smp_wmb();
	atomic_set(y, 1);
}

P1(atomic_t *y)
{
	int r1;

	r1 = atomic_inc_return(y);
}

P2(int *x, atomic_t *y)
{
	int r2;
	int r3;

	r2 = atomic_read(y);
	smp_rmb();
	r3 = READ_ONCE(*x);
}

exists (2:r2=2 /\ 2:r3=0)
--------------------------------------------------

The litmus test is allowed as shown with atomic_inc_return(), which
has full-barrier semantics.  But if the operation is changed to
atomic_inc_return_release(), which only has release-barrier semantics,
the litmus test is forbidden.  Clearly this violates monotonicity.

The reason is because the LKMM treats full-barrier atomic ops as if
they were written:

	mb();
	load();
	store();
	mb();

(where the load() and store() are the two parts of an atomic RMW op),
whereas it treats release-barrier atomic ops as if they were written:

	load();
	release_barrier();
	store();

The difference is that here the release barrier orders the load part
of the atomic op before the store part with A-cumulativity, whereas
the mb()'s above do not.  This means that release-barrier atomics can
effectively extend the cumul-fence relation but full-barrier atomics
cannot.

To resolve this problem we introduce the rmw-sequence relation,
representing an arbitrarily long sequence of atomic RMW operations in
which each operation reads from the previous one, and explicitly allow
it to extend cumul-fence.  This modification of the memory model is
sound; it holds for PPC because of B-cumulativity, it holds for TSO
and ARM64 because of other-multicopy atomicity, and we can assume that
atomic ops on all other architectures will be implemented so as to
make it hold for them.

For similar reasons we also allow rmw-sequence to extend the
w-post-bounded relation, which is analogous to cumul-fence in some
ways.

Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/explanation.txt             | 30 +++++++++++++++++++
 tools/memory-model/linux-kernel.cat           |  5 ++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 11a1d2d4f681c..e901b47236c37 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1007,6 +1007,36 @@ order.  Equivalently,
 where the rmw relation links the read and write events making up each
 atomic update.  This is what the LKMM's "atomic" axiom says.
 
+Atomic rmw updates play one more role in the LKMM: They can form "rmw
+sequences".  An rmw sequence is simply a bunch of atomic updates where
+each update reads from the previous one.  Written using events, it
+looks like this:
+
+	Z0 ->rf Y1 ->rmw Z1 ->rf ... ->rf Yn ->rmw Zn,
+
+where Z0 is some store event and n can be any number (even 0, in the
+degenerate case).  We write this relation as: Z0 ->rmw-sequence Zn.
+Note that this implies Z0 and Zn are stores to the same variable.
+
+Rmw sequences have a special property in the LKMM: They can extend the
+cumul-fence relation.  That is, if we have:
+
+	U ->cumul-fence X -> rmw-sequence Y
+
+then also U ->cumul-fence Y.  Thinking about this in terms of the
+operational model, U ->cumul-fence X says that the store U propagates
+to each CPU before the store X does.  Then the fact that X and Y are
+linked by an rmw sequence means that U also propagates to each CPU
+before Y does.  In an analogous way, rmw sequences can also extend
+the w-post-bounded relation defined below in the PLAIN ACCESSES AND
+DATA RACES section.
+
+(The notion of rmw sequences in the LKMM is similar to, but not quite
+the same as, that of release sequences in the C11 memory model.  They
+were added to the LKMM to fix an obscure bug; without them, atomic
+updates with full-barrier semantics did not always guarantee ordering
+at least as strong as atomic updates with release-barrier semantics.)
+
 
 THE PRESERVED PROGRAM ORDER RELATION: ppo
 -----------------------------------------
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index d70315fddef6e..07f884f9b2bff 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -74,8 +74,9 @@ let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
+let rmw-sequence = (rf ; rmw)*
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked] ; rmw-sequence
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
@@ -174,7 +175,7 @@ let vis = cumul-fence* ; rfe? ; [Marked] ;
 let w-pre-bounded = [Marked] ; (addr | fence)?
 let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
 	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
-let w-post-bounded = fence? ; [Marked]
+let w-post-bounded = fence? ; [Marked] ; rmw-sequence
 let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
 	[Marked]
 
-- 
2.31.1.189.g2e36527f23

