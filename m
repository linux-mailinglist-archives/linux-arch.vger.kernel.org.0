Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491146C26AE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCUBDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCUBDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E831BC0;
        Mon, 20 Mar 2023 18:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9921E618F4;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E74C4339C;
        Tue, 21 Mar 2023 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360568;
        bh=6bX96lqBuqkytWesc7/sc0GFPDrnpTONdzva8MA/OSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU9TPc9NSL5f21FTl3EsNTG6DgH0hpArAce22TpJMmOarpJB+ZzcKKFzbEgy6YzSK
         Z+qBn74DzVYa8d2PmoKLdQUFQjIX6H/ZVdq44FMPXtiwGdxe+V7P8uXKb9D+ZJv8+7
         StTgzn0/Lddy5Ztkyl/4FcZgEQm58KH8LGoaX8dbN8pWhkVTJt1EiLBsKcBj8cwjlU
         nAbJVtu9Jo2BFwC9kOJYJfmjt49AMGDYpooZmFxr3M81lLTT5RBTIa8knxEtWb8HOQ
         cIzLoNcENNKk4AAwl31QoW5X9SEeMKDhz8Az11knI8xBFxWk7dTru7hB5hij2HBCQk
         XoqIEX5lJsaRQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7D0CF15403A1; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH memory-model 5/8] tools/memory-model: Provide exact SRCU semantics
Date:   Mon, 20 Mar 2023 18:02:43 -0700
Message-Id: <20230321010246.50960-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

LKMM has long provided only approximate handling of SRCU read-side
critical sections.  This has not been a pressing problem because LKMM's
traditional handling is correct for the common cases of non-overlapping
and properly nested critical sections.  However, LKMM's traditional
handling of partially overlapping critical sections incorrectly fuses
them into one large critical section.

For example, consider the following litmus test:

------------------------------------------------------------------------

C C-srcu-nest-5

(*
 * Result: Sometimes
 *
 * This demonstrates non-nested overlapping of SRCU read-side critical
 * sections.  Unlike RCU, SRCU critical sections do not unconditionally
 * nest.
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1)
{
        int r1;
        int r2;
        int r3;
        int r4;

        r3 = srcu_read_lock(s1);
        r2 = READ_ONCE(*y);
        r4 = srcu_read_lock(s1);
        srcu_read_unlock(s1, r3);
        r1 = READ_ONCE(*x);
        srcu_read_unlock(s1, r4);
}

P1(int *x, int *y, struct srcu_struct *s1)
{
        WRITE_ONCE(*y, 1);
        synchronize_srcu(s1);
        WRITE_ONCE(*x, 1);
}

locations [0:r1]
exists (0:r1=1 /\ 0:r2=0)

------------------------------------------------------------------------

Current mainline incorrectly flattens the two critical sections into
one larger critical section, giving "Never" instead of the correct
"Sometimes":

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
Test C-srcu-nest-5 Allowed
States 3
0:r1=0; 0:r2=0;
0:r1=0; 0:r2=1;
0:r1=1; 0:r2=1;
No
Witnesses
Positive: 0 Negative: 3
Flag srcu-bad-nesting
Condition exists (0:r1=1 /\ 0:r2=0)
Observation C-srcu-nest-5 Never 0 3
Time C-srcu-nest-5 0.01
Hash=e692c106cf3e84e20f12991dc438ff1b

------------------------------------------------------------------------

To its credit, it does complain about bad nesting.  But with this
commit we get the following result, which has the virtue of being
correct:

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
Test C-srcu-nest-5 Allowed
States 4
0:r1=0; 0:r2=0;
0:r1=0; 0:r2=1;
0:r1=1; 0:r2=0;
0:r1=1; 0:r2=1;
Ok
Witnesses
Positive: 1 Negative: 3
Condition exists (0:r1=1 /\ 0:r2=0)
Observation C-srcu-nest-5 Sometimes 1 3
Time C-srcu-nest-5 0.05
Hash=e692c106cf3e84e20f12991dc438ff1b

------------------------------------------------------------------------

In addition, there are new srcu_down_read() and srcu_up_read()
functions on their way to mainline.  Roughly speaking, these are to
srcu_read_lock() and srcu_read_unlock() as down() and up() are to
mutex_lock() and mutex_unlock().  The key point is that
srcu_down_read() can execute in one process and the matching
srcu_up_read() in another, as shown in this litmus test:

------------------------------------------------------------------------

C C-srcu-nest-6

(*
 * Result: Never
 *
 * This would be valid for srcu_down_read() and srcu_up_read().
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
        int r2;
        int r3;

        r3 = srcu_down_read(s1);
        WRITE_ONCE(*idx, r3);
        r2 = READ_ONCE(*y);
        smp_store_release(f, 1);
}

P1(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
        int r1;
        int r3;
        int r4;

        r4 = smp_load_acquire(f);
        r1 = READ_ONCE(*x);
        r3 = READ_ONCE(*idx);
        srcu_up_read(s1, r3);
}

P2(int *x, int *y, struct srcu_struct *s1)
{
        WRITE_ONCE(*y, 1);
        synchronize_srcu(s1);
        WRITE_ONCE(*x, 1);
}

locations [0:r1]
filter (1:r4=1)
exists (1:r1=1 /\ 0:r2=0)

------------------------------------------------------------------------

When run on current mainline, this litmus test gets a complaint about
an unknown macro srcu_down_read().  With this commit:

------------------------------------------------------------------------

herd7 -conf linux-kernel.cfg C-srcu-nest-6.litmus
Test C-srcu-nest-6 Allowed
States 3
0:r1=0; 0:r2=0; 1:r1=0;
0:r1=0; 0:r2=1; 1:r1=0;
0:r1=0; 0:r2=1; 1:r1=1;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (1:r1=1 /\ 0:r2=0)
Observation C-srcu-nest-6 Never 0 3
Time C-srcu-nest-6 0.02
Hash=c1f20257d052ca5e899be508bedcb2a1

------------------------------------------------------------------------

Note that the user must supply the flag "f" and the "filter" clause,
similar to what must be done to emulate call_rcu().

The commit works by treating srcu_read_lock()/srcu_down_read() as
loads and srcu_read_unlock()/srcu_up_read() as stores.  This allows us
to determine which unlock matches which lock by looking for a data
dependency between them.  In order for this to work properly, the data
dependencies have to be tracked through stores to intermediate
variables such as "idx" in the litmus test above; this is handled by
the new carry-srcu-data relation.  But it's important here (and in the
existing carry-dep relation) to avoid tracking the dependencies
through SRCU unlock stores.  Otherwise, in situations resembling:

	A: r1 = srcu_read_lock(s);
	B: srcu_read_unlock(s, r1);
	C: r2 = srcu_read_lock(s);
	D: srcu_read_unlock(s, r2);

it would look as if D was dependent on both A and C, because "s" would
appear to be an intermediate variable written by B and read by C.
This explains the complications in the definitions of carry-srcu-dep
and carry-dep.

As a debugging aid, the commit adds a check for errors in which the
value returned by one call to srcu_read_lock()/srcu_down_read() is
passed to more than one instance of srcu_read_unlock()/srcu_up_read().

Finally, since these SRCU-related primitives are now treated as
ordinary reads and writes, we have to add them into the lists of
marked accesses (i.e., not subject to data races) and lock-related
accesses (i.e., one shouldn't try to access an srcu_struct with a
non-lock-related primitive such as READ_ONCE() or a plain write).

Portions of this approach were suggested by Boqun Feng and Jonas
Oberhauser.

[ paulmck: Fix space-before-tab whitespace nit. ]

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 17 +++++------------
 tools/memory-model/linux-kernel.def  |  6 ++++--
 tools/memory-model/lock.cat          |  6 +++---
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b92fdf7f6eeb..ce068700939c 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -58,20 +58,13 @@ flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
-let srcu-rscs = let rec
-	    unmatched-locks = Srcu-lock \ domain(matched)
-	and unmatched-unlocks = Srcu-unlock \ range(matched)
-	and unmatched = unmatched-locks | unmatched-unlocks
-	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
-	and unmatched-locks-to-unlocks =
-		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
-	and matched = matched | (unmatched-locks-to-unlocks \
-		(unmatched-po ; unmatched-po))
-	in matched
+let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
+let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
 flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
 flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
+flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
@@ -81,11 +74,11 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
-		LKR | LKW | UL | LF | RL | RU
+		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
 (* Redefine dependencies to include those carried through plain accesses *)
-let carry-dep = (data ; rfi)*
+let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a6b6fbc9d0b2..88a39601f525 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -50,8 +50,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // SRCU
-srcu_read_lock(X)  __srcu{srcu-lock}(X)
-srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
+srcu_read_lock(X) __load{srcu-lock}(*X)
+srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
+srcu_down_read(X) __load{srcu-lock}(*X)
+srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
 synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
 
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73a..53b5a492739d 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -36,9 +36,9 @@ let RU = try RU with emptyset
 (* Treat RL as a kind of LF: a read with no ordering properties *)
 let LF = LF | RL
 
-(* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF | RU
-flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
+(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
+let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
+flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 
 (* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
-- 
2.40.0.rc2

