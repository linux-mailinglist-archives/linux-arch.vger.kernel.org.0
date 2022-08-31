Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146965A8595
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiHaS2y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiHaS2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 14:28:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8856478;
        Wed, 31 Aug 2022 11:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35FC3B82274;
        Wed, 31 Aug 2022 18:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF846C433C1;
        Wed, 31 Aug 2022 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970235;
        bh=xN5D2ShxxNPlDuwNTCWUnmxwkBxFPNBZHBLxsbMlkKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEawr4TxzETNjqYk/WUPrJi36MXKNnvLL4s+Rf2+OXVHuaAgJf8FofJuf2Jpgx1iR
         XXvOA5futmG6pFxYWtEFZdHLX+tGy6ZjFncK7j6vu88a5WxSH+fPN4zil28FK/Srew
         hRx2Dq+2xY3oqjSTpuFZ91aYm0N+DToaEuPAbjrlS7A1/2vA11Cxa+EbIGKq0Vzomy
         fqnushRgVMBphTxbfJbAtkuqJOWY12ouI+0Uy8MU3ZGpbqeqLTZ3M8DGQngsyDrUQ+
         yVueg5RIqm/aj1gwgXmfRMRkYN6dR1I/UBoh6+AckiNWJyM191e5H2nFekj2ogcHYH
         08ce80hd5VfLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 800355C019C; Wed, 31 Aug 2022 11:23:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH memory-model 2/3] docs/memory-barriers.txt: Fixup long lines
Date:   Wed, 31 Aug 2022 11:23:52 -0700
Message-Id: <20220831182353.2699262-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182350.GA2698943@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182350.GA2698943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

Substitution of "data dependency barrier" with "address-dependency
barrier" left quite a lot of lines exceeding 80 columns.

Reflow those lines as well as a few short ones not related to
the substitution.

No changes in documentation text.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 93 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b16767cb6d31d..06f80e3785c5d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -187,9 +187,9 @@ As a further example, consider this sequence of events:
 	B = 4;		Q = P;
 	P = &B;		D = *Q;
 
-There is an obvious address dependency here, as the value loaded into D depends on
-the address retrieved from P by CPU 2.  At the end of the sequence, any of the
-following results are possible:
+There is an obvious address dependency here, as the value loaded into D depends
+on the address retrieved from P by CPU 2.  At the end of the sequence, any of
+the following results are possible:
 
 	(Q == &A) and (D == 1)
 	(Q == &B) and (D == 2)
@@ -397,25 +397,25 @@ Memory barriers come in four basic varieties:
 
  (2) Address-dependency barriers (historical).
 
-     An address-dependency barrier is a weaker form of read barrier.  In the case
-     where two loads are performed such that the second depends on the result
-     of the first (eg: the first load retrieves the address to which the second
-     load will be directed), an address-dependency barrier would be required to
-     make sure that the target of the second load is updated after the address
-     obtained by the first load is accessed.
+     An address-dependency barrier is a weaker form of read barrier.  In the
+     case where two loads are performed such that the second depends on the
+     result of the first (eg: the first load retrieves the address to which
+     the second load will be directed), an address-dependency barrier would
+     be required to make sure that the target of the second load is updated
+     after the address obtained by the first load is accessed.
 
-     An address-dependency barrier is a partial ordering on interdependent loads
-     only; it is not required to have any effect on stores, independent loads
-     or overlapping loads.
+     An address-dependency barrier is a partial ordering on interdependent
+     loads only; it is not required to have any effect on stores, independent
+     loads or overlapping loads.
 
      As mentioned in (1), the other CPUs in the system can be viewed as
      committing sequences of stores to the memory system that the CPU being
-     considered can then perceive.  An address-dependency barrier issued by the CPU
-     under consideration guarantees that for any load preceding it, if that
-     load touches one of a sequence of stores from another CPU, then by the
-     time the barrier completes, the effects of all the stores prior to that
-     touched by the load will be perceptible to any loads issued after the address-
-     dependency barrier.
+     considered can then perceive.  An address-dependency barrier issued by
+     the CPU under consideration guarantees that for any load preceding it,
+     if that load touches one of a sequence of stores from another CPU, then
+     by the time the barrier completes, the effects of all the stores prior to
+     that touched by the load will be perceptible to any loads issued after
+     the address-dependency barrier.
 
      See the "Examples of memory barrier sequences" subsection for diagrams
      showing the ordering constraints.
@@ -437,16 +437,16 @@ Memory barriers come in four basic varieties:
 
  (3) Read (or load) memory barriers.
 
-     A read barrier is an address-dependency barrier plus a guarantee that all the
-     LOAD operations specified before the barrier will appear to happen before
-     all the LOAD operations specified after the barrier with respect to the
-     other components of the system.
+     A read barrier is an address-dependency barrier plus a guarantee that all
+     the LOAD operations specified before the barrier will appear to happen
+     before all the LOAD operations specified after the barrier with respect to
+     the other components of the system.
 
      A read barrier is a partial ordering on loads only; it is not required to
      have any effect on stores.
 
-     Read memory barriers imply address-dependency barriers, and so can substitute
-     for them.
+     Read memory barriers imply address-dependency barriers, and so can
+     substitute for them.
 
      [!] Note that read barriers should normally be paired with write barriers;
      see the "SMP barrier pairing" subsection.
@@ -584,8 +584,8 @@ following sequence of events:
 [!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which
 doesn't imply an address-dependency barrier.
 
-There's a clear address dependency here, and it would seem that by the end of the
-sequence, Q must be either &A or &B, and that:
+There's a clear address dependency here, and it would seem that by the end of
+the sequence, Q must be either &A or &B, and that:
 
 	(Q == &A) implies (D == 1)
 	(Q == &B) implies (D == 4)
@@ -599,8 +599,8 @@ While this may seem like a failure of coherency or causality maintenance, it
 isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
-To deal with this, READ_ONCE() provides an implicit address-dependency
-barrier since kernel release v4.15:
+To deal with this, READ_ONCE() provides an implicit address-dependency barrier
+since kernel release v4.15:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -627,12 +627,12 @@ but the old value of the variable B (2).
 
 
 An address-dependency barrier is not required to order dependent writes
-because the CPUs that the Linux kernel supports don't do writes
-until they are certain (1) that the write will actually happen, (2)
-of the location of the write, and (3) of the value to be written.
+because the CPUs that the Linux kernel supports don't do writes until they
+are certain (1) that the write will actually happen, (2) of the location of
+the write, and (3) of the value to be written.
 But please carefully read the "CONTROL DEPENDENCIES" section and the
-Documentation/RCU/rcu_dereference.rst file:  The compiler can and does
-break dependencies in a great many highly creative ways.
+Documentation/RCU/rcu_dereference.rst file:  The compiler can and does break
+dependencies in a great many highly creative ways.
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -678,8 +678,8 @@ not understand them.  The purpose of this section is to help you prevent
 the compiler's ignorance from breaking your code.
 
 A load-load control dependency requires a full read memory barrier, not
-simply an (implicit) address-dependency barrier to make it work correctly.  Consider the
-following bit of code:
+simply an (implicit) address-dependency barrier to make it work correctly.
+Consider the following bit of code:
 
 	q = READ_ONCE(a);
 	<implicit address-dependency barrier>
@@ -691,8 +691,8 @@ following bit of code:
 This will not have the desired effect because there is no actual address
 dependency, but rather a control dependency that the CPU may short-circuit
 by attempting to predict the outcome in advance, so that other CPUs see
-the load from b as having happened before the load from a.  In such a
-case what's actually required is:
+the load from b as having happened before the load from a.  In such a case
+what's actually required is:
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -980,8 +980,8 @@ Basically, the read barrier always has to be there, even though it can be of
 the "weaker" type.
 
 [!] Note that the stores before the write barrier would normally be expected to
-match the loads after the read barrier or the address-dependency barrier, and vice
-versa:
+match the loads after the read barrier or the address-dependency barrier, and
+vice versa:
 
 	CPU 1                               CPU 2
 	===================                 ===================
@@ -1033,8 +1033,8 @@ STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 	                   V
 
 
-Secondly, address-dependency barriers act as partial orderings on address-dependent
-loads.  Consider the following sequence of events:
+Secondly, address-dependency barriers act as partial orderings on address-
+dependent loads.  Consider the following sequence of events:
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1079,8 +1079,8 @@ effectively random order, despite the write barrier issued by CPU 1:
 In the above example, CPU 2 perceives that B is 7, despite the load of *C
 (which would be B) coming after the LOAD of C.
 
-If, however, an address-dependency barrier were to be placed between the load of C
-and the load of *C (ie: B) on CPU 2:
+If, however, an address-dependency barrier were to be placed between the load
+of C and the load of *C (ie: B) on CPU 2:
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -2761,7 +2761,8 @@ is discarded from the CPU's cache and reloaded.  To deal with this, the
 appropriate part of the kernel must invalidate the overlapping bits of the
 cache on each CPU.
 
-See Documentation/core-api/cachetlb.rst for more information on cache management.
+See Documentation/core-api/cachetlb.rst for more information on cache
+management.
 
 
 CACHE COHERENCY VS MMIO
@@ -2901,8 +2902,8 @@ AND THEN THERE'S THE ALPHA
 The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
 some versions of the Alpha CPU have a split data cache, permitting them to have
 two semantically-related cache lines updated at separate times.  This is where
-the address-dependency barrier really becomes necessary as this synchronises both
-caches with the memory coherence system, thus making it seem like pointer
+the address-dependency barrier really becomes necessary as this synchronises
+both caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
 The Alpha defines the Linux kernel's memory model, although as of v4.15
-- 
2.31.1.189.g2e36527f23

