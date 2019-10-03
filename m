Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0CC95D6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJCA2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfJCA0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAA7222C8;
        Thu,  3 Oct 2019 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062413;
        bh=s/ZYke5jns5Eo7bH7u9pNXsmfjKWbKjWUUN/3Txz7k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9Y+jPau66A6HvmgSvpy/24FsX4WGd8ugmpDtihd+j0R4E86UXvmek5b7RGiirYFE
         jpGEb2G6Z78gVs7JTL7LljHuUm3mo1Fuk26gVizLMGe60Jrbmwi9jXLoGvfS/kk5Pk
         zCw2tGglXlFaqxprJ8HmDML66DTM8IvfFje7XTDY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/32] tools/memory-model/Documentation: Put redefinition of rcu-fence into explanation.txt
Date:   Wed,  2 Oct 2019 17:26:21 -0700
Message-Id: <20191003002650.11249-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch updates the Linux Kernel Memory Model's explanation.txt
file to incorporate the introduction of the rcu-order relation and
the redefinition of rcu-fence made by commit 15aa25cbf0cc
("tools/memory-model: Change definition of rcu-fence").

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 53 ++++++++++++++++--------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1b52645..ecf6ccc 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory Consistency Model
   19. AND THEN THERE WAS ALPHA
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
-  22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
+  22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
   23. LOCKING
   24. ODDS AND ENDS
 
@@ -1425,8 +1425,8 @@ they execute means that it cannot have cycles.  This requirement is
 the content of the LKMM's "propagation" axiom.
 
 
-RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
--------------------------------------------------------------
+RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
+------------------------------------------------------------------------
 
 RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
 rests on two concepts: grace periods and read-side critical sections.
@@ -1536,29 +1536,29 @@ Z's CPU before Z begins but doesn't propagate to some other CPU until
 after X ends.)  Similarly, X ->rcu-rscsi Y ->rcu-link Z says that X is
 the end of a critical section which starts before Z begins.
 
-The LKMM goes on to define the rcu-fence relation as a sequence of
+The LKMM goes on to define the rcu-order relation as a sequence of
 rcu-gp and rcu-rscsi links separated by rcu-link links, in which the
 number of rcu-gp links is >= the number of rcu-rscsi links.  For
 example:
 
 	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-would imply that X ->rcu-fence V, because this sequence contains two
+would imply that X ->rcu-order V, because this sequence contains two
 rcu-gp links and one rcu-rscsi link.  (It also implies that
-X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand:
+X ->rcu-order T and Z ->rcu-order V.)  On the other hand:
 
 	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-does not imply X ->rcu-fence V, because the sequence contains only
+does not imply X ->rcu-order V, because the sequence contains only
 one rcu-gp link but two rcu-rscsi links.
 
-The rcu-fence relation is important because the Grace Period Guarantee
-means that rcu-fence acts kind of like a strong fence.  In particular,
-E ->rcu-fence F implies not only that E begins before F ends, but also
-that any write po-before E will propagate to every CPU before any
-instruction po-after F can execute.  (However, it does not imply that
-E must execute before F; in fact, each synchronize_rcu() fence event
-is linked to itself by rcu-fence as a degenerate case.)
+The rcu-order relation is important because the Grace Period Guarantee
+means that rcu-order links act kind of like strong fences.  In
+particular, E ->rcu-order F implies not only that E begins before F
+ends, but also that any write po-before E will propagate to every CPU
+before any instruction po-after F can execute.  (However, it does not
+imply that E must execute before F; in fact, each synchronize_rcu()
+fence event is linked to itself by rcu-order as a degenerate case.)
 
 To prove this in full generality requires some intellectual effort.
 We'll consider just a very simple case:
@@ -1585,7 +1585,26 @@ G's CPU before G starts must propagate to every CPU before C starts.
 In particular, the write propagates to every CPU before F finishes
 executing and hence before any instruction po-after F can execute.
 This sort of reasoning can be extended to handle all the situations
-covered by rcu-fence.
+covered by rcu-order.
+
+The rcu-fence relation is a simple extension of rcu-order.  While
+rcu-order only links certain fence events (calls to synchronize_rcu(),
+rcu_read_lock(), or rcu_read_unlock()), rcu-fence links any events
+that are separated by an rcu-order link.  This is analogous to the way
+the strong-fence relation links events that are separated by an
+smp_mb() fence event (as mentioned above, rcu-order links act kind of
+like strong fences).  Written symbolically, X ->rcu-fence Y means
+there are fence events E and F such that:
+
+	X ->po E ->rcu-order F ->po Y.
+
+From the discussion above, we see this implies not only that X
+executes before Y, but also (if X is a store) that X propagates to
+every CPU before Y executes.  Thus rcu-fence is sort of a
+"super-strong" fence: Unlike the original strong fences (smp_mb() and
+synchronize_rcu()), rcu-fence is able to link events on different
+CPUs.  (Perhaps this fact should lead us to say that rcu-fence isn't
+really a fence at all!)
 
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
@@ -1596,7 +1615,7 @@ before F, just as E ->pb F does (and for much the same reasons).
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that the rb relation does not contain a cycle.
 Equivalently, this "rcu" axiom requires that there are no events E
-and F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way,
+and F with E ->rcu-link F ->rcu-order E.  Or to put it a third way,
 the axiom requires that there are no cycles consisting of rcu-gp and
 rcu-rscsi alternating with rcu-link, where the number of rcu-gp links
 is >= the number of rcu-rscsi links.
@@ -1750,7 +1769,7 @@ addition to normal RCU.  The ideas involved are much the same as
 above, with new relations srcu-gp and srcu-rscsi added to represent
 SRCU grace periods and read-side critical sections.  There is a
 restriction on the srcu-gp and srcu-rscsi links that can appear in an
-rcu-fence sequence (the srcu-rscsi links must be paired with srcu-gp
+rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
 links having the same SRCU domain with proper nesting); the details
 are relatively unimportant.
 
-- 
2.9.5

