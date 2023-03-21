Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994746C26AD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCUBDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUBDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C26E32539;
        Mon, 20 Mar 2023 18:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19475618FA;
        Tue, 21 Mar 2023 01:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7BFC433A7;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360568;
        bh=NMit92Hlr8O4Fd55QLFN98QDjh2AfQaJejrMU0aDepc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSYqFqzLttFaecsizZG22Lw21QYOJCr/4sTVpj/73kiF4/M9aeSVUA6jD54qIzwGk
         +jad2Nlu2cVuvJAZpfbKiuZ9e/kF6YqxnpA4a4csTbxwPBVCYnA1c3TSGBY9949d/W
         IzvgD0zzkJwcWQHEdzcwFeToCz7ZXdUnEJ2MWfKxsSvzYd4tz9GbhhX0Ga2NZ2xHRm
         RTrio7SrsEmZBSAKy/eoRlmwoWWXGbIBFaBz8QdEB7kf5PTsY44WV2AbH2O+goH1i2
         h7tpL71mDLT5rFpabcvwcmvPbeHViC47swbyrhTdbQTsPS9EydvFEWWdh2Be3B64Ej
         qrgO9dLZ5rUxA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 85A2D15403A5; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 7/8] tools/memory-model: Add documentation about SRCU read-side critical sections
Date:   Mon, 20 Mar 2023 18:02:45 -0700
Message-Id: <20230321010246.50960-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
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

Expand the discussion of SRCU and its read-side critical sections in
the Linux Kernel Memory Model documentation file explanation.txt.  The
new material discusses recent changes to the memory model made in
commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
semantics").

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
CC: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/explanation.txt             | 178 ++++++++++++++++--
 1 file changed, 167 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 8e7085238470..6dc8b3642458 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory Consistency Model
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
   22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
-  23. LOCKING
-  24. PLAIN ACCESSES AND DATA RACES
-  25. ODDS AND ENDS
+  23. SRCU READ-SIDE CRITICAL SECTIONS
+  24. LOCKING
+  25. PLAIN ACCESSES AND DATA RACES
+  26. ODDS AND ENDS
 
 
 
@@ -1848,14 +1849,169 @@ section in P0 both starts before P1's grace period does and ends
 before it does, and the critical section in P2 both starts after P1's
 grace period does and ends after it does.
 
-Addendum: The LKMM now supports SRCU (Sleepable Read-Copy-Update) in
-addition to normal RCU.  The ideas involved are much the same as
-above, with new relations srcu-gp and srcu-rscsi added to represent
-SRCU grace periods and read-side critical sections.  There is a
-restriction on the srcu-gp and srcu-rscsi links that can appear in an
-rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
-links having the same SRCU domain with proper nesting); the details
-are relatively unimportant.
+The LKMM supports SRCU (Sleepable Read-Copy-Update) in addition to
+normal RCU.  The ideas involved are much the same as above, with new
+relations srcu-gp and srcu-rscsi added to represent SRCU grace periods
+and read-side critical sections.  However, there are some significant
+differences between RCU read-side critical sections and their SRCU
+counterparts, as described in the next section.
+
+
+SRCU READ-SIDE CRITICAL SECTIONS
+--------------------------------
+
+The LKMM uses the srcu-rscsi relation to model SRCU read-side critical
+sections.  They differ from RCU read-side critical sections in the
+following respects:
+
+1.	Unlike the analogous RCU primitives, synchronize_srcu(),
+	srcu_read_lock(), and srcu_read_unlock() take a pointer to a
+	struct srcu_struct as an argument.  This structure is called
+	an SRCU domain, and calls linked by srcu-rscsi must have the
+	same domain.  Read-side critical sections and grace periods
+	associated with different domains are independent of one
+	another; the SRCU version of the RCU Guarantee applies only
+	to pairs of critical sections and grace periods having the
+	same domain.
+
+2.	srcu_read_lock() returns a value, called the index, which must
+	be passed to the matching srcu_read_unlock() call.  Unlike
+	rcu_read_lock() and rcu_read_unlock(), an srcu_read_lock()
+	call does not always have to match the next unpaired
+	srcu_read_unlock().  In fact, it is possible for two SRCU
+	read-side critical sections to overlap partially, as in the
+	following example (where s is an srcu_struct and idx1 and idx2
+	are integer variables):
+
+		idx1 = srcu_read_lock(&s);	// Start of first RSCS
+		idx2 = srcu_read_lock(&s);	// Start of second RSCS
+		srcu_read_unlock(&s, idx1);	// End of first RSCS
+		srcu_read_unlock(&s, idx2);	// End of second RSCS
+
+	The matching is determined entirely by the domain pointer and
+	index value.  By contrast, if the calls had been
+	rcu_read_lock() and rcu_read_unlock() then they would have
+	created two nested (fully overlapping) read-side critical
+	sections: an inner one and an outer one.
+
+3.	The srcu_down_read() and srcu_up_read() primitives work
+	exactly like srcu_read_lock() and srcu_read_unlock(), except
+	that matching calls don't have to execute on the same CPU.
+	(The names are meant to be suggestive of operations on
+	semaphores.)  Since the matching is determined by the domain
+	pointer and index value, these primitives make it possible for
+	an SRCU read-side critical section to start on one CPU and end
+	on another, so to speak.
+
+In order to account for these properties of SRCU, the LKMM models
+srcu_read_lock() as a special type of load event (which is
+appropriate, since it takes a memory location as argument and returns
+a value, just as a load does) and srcu_read_unlock() as a special type
+of store event (again appropriate, since it takes as arguments a
+memory location and a value).  These loads and stores are annotated as
+belonging to the "srcu-lock" and "srcu-unlock" event classes
+respectively.
+
+This approach allows the LKMM to tell whether two events are
+associated with the same SRCU domain, simply by checking whether they
+access the same memory location (i.e., they are linked by the loc
+relation).  It also gives a way to tell which unlock matches a
+particular lock, by checking for the presence of a data dependency
+from the load (srcu-lock) to the store (srcu-unlock).  For example,
+given the situation outlined earlier (with statement labels added):
+
+	A: idx1 = srcu_read_lock(&s);
+	B: idx2 = srcu_read_lock(&s);
+	C: srcu_read_unlock(&s, idx1);
+	D: srcu_read_unlock(&s, idx2);
+
+the LKMM will treat A and B as loads from s yielding values saved in
+idx1 and idx2 respectively.  Similarly, it will treat C and D as
+though they stored the values from idx1 and idx2 in s.  The end result
+is much as if we had written:
+
+	A: idx1 = READ_ONCE(s);
+	B: idx2 = READ_ONCE(s);
+	C: WRITE_ONCE(s, idx1);
+	D: WRITE_ONCE(s, idx2);
+
+except for the presence of the special srcu-lock and srcu-unlock
+annotations.  You can see at once that we have A ->data C and
+B ->data D.  These dependencies tell the LKMM that C is the
+srcu-unlock event matching srcu-lock event A, and D is the
+srcu-unlock event matching srcu-lock event B.
+
+This approach is admittedly a hack, and it has the potential to lead
+to problems.  For example, in:
+
+	idx1 = srcu_read_lock(&s);
+	srcu_read_unlock(&s, idx1);
+	idx2 = srcu_read_lock(&s);
+	srcu_read_unlock(&s, idx2);
+
+the LKMM will believe that idx2 must have the same value as idx1,
+since it reads from the immediately preceding store of idx1 in s.
+Fortunately this won't matter, assuming that litmus tests never do
+anything with SRCU index values other than pass them to
+srcu_read_unlock() or srcu_up_read() calls.
+
+However, sometimes it is necessary to store an index value in a
+shared variable temporarily.  In fact, this is the only way for
+srcu_down_read() to pass the index it gets to an srcu_up_read() call
+on a different CPU.  In more detail, we might have soething like:
+
+	struct srcu_struct s;
+	int x;
+
+	P0()
+	{
+		int r0;
+
+		A: r0 = srcu_down_read(&s);
+		B: WRITE_ONCE(x, r0);
+	}
+
+	P1()
+	{
+		int r1;
+
+		C: r1 = READ_ONCE(x);
+		D: srcu_up_read(&s, r1);
+	}
+
+Assuming that P1 executes after P0 and does read the index value
+stored in x, we can write this (using brackets to represent event
+annotations) as:
+
+	A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
+
+The LKMM defines a carry-srcu-data relation to express this pattern;
+it permits an arbitrarily long sequence of
+
+	data ; rf
+
+pairs (that is, a data link followed by an rf link) to occur between
+an srcu-lock event and the final data dependency leading to the
+matching srcu-unlock event.  carry-srcu-data is complicated by the
+need to ensure that none of the intermediate store events in this
+sequence are instances of srcu-unlock.  This is necessary because in a
+pattern like the one above:
+
+	A: idx1 = srcu_read_lock(&s);
+	B: srcu_read_unlock(&s, idx1);
+	C: idx2 = srcu_read_lock(&s);
+	D: srcu_read_unlock(&s, idx2);
+
+the LKMM treats B as a store to the variable s and C as a load from
+that variable, creating an undesirable rf link from B to C:
+
+	A ->data B ->rf C ->data D.
+
+This would cause carry-srcu-data to mistakenly extend a data
+dependency from A to D, giving the impression that D was the
+srcu-unlock event matching A's srcu-lock.  To avoid such problems,
+carry-srcu-data does not accept sequences in which the ends of any of
+the intermediate ->data links (B above) is an srcu-unlock event.
 
 
 LOCKING
-- 
2.40.0.rc2

