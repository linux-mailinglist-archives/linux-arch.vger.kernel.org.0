Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180165E244
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjAEBKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAEBJ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:09:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DB3055B;
        Wed,  4 Jan 2023 17:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56EEE618AC;
        Thu,  5 Jan 2023 01:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD816C433F2;
        Thu,  5 Jan 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880994;
        bh=DOted7FBYHC/UPK1yKry17PYXPvfX+1xx0FRT1Pw04k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbbN3Q9ODnFr8TGowjXzWOf/gkFS419mGtPPY5Hjt/Vxev8cmZg5PiiDgGXA3I2zj
         HQCrglp0a9yosw/quelj6HpZb5xQ14DKuB5DAzYU6jO4yfwKqfHYuRB84tt9Xrzd+5
         rrA8YWnjqPH1LhygLystDV5zUbjUeDgYSY1prwkcHheNwuGjubzyRDr+wLZipa5rJZ
         bUw0ZMWNwipfTJY4KSsMbEZVfzz8+bGmIVssiSpnNfc+n0pEBKgONAnZvafIl4I7Z1
         FTmZwVQxz8UX3IzzFAFXuC+bfV8ZfeT9QDydmnvqz4dy1r1W5mBHKnTgT+jUAnJgE5
         3j/tLBGBOdeTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A90B5C1456; Wed,  4 Jan 2023 17:09:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Viktor Vafeiadis <viktor@mpi-sws.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/4] tools: memory-model: Make plain accesses carry dependencies
Date:   Wed,  4 Jan 2023 17:09:52 -0800
Message-Id: <20230105010952.1774272-4-paulmck@kernel.org>
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

From: Jonas Oberhauser <jonas.oberhauser@huawei.com>

As reported by Viktor, plain accesses in LKMM are weaker than
accesses to registers: the latter carry dependencies but the former
do not. This is exemplified in the following snippet:

  int r = READ_ONCE(*x);
  WRITE_ONCE(*y, r);

Here a data dependency links the READ_ONCE() to the WRITE_ONCE(),
preserving their order, because the model treats r as a register.
If r is turned into a memory location accessed by plain accesses,
however, the link is broken and the order between READ_ONCE() and
WRITE_ONCE() is no longer preserved.

This is too conservative, since any optimizations on plain
accesses that might break dependencies are also possible on
registers; it also contradicts the intuitive notion of "dependency"
as the data stored by the WRITE_ONCE() does depend on the data read
by the READ_ONCE(), independently of whether r is a register or a
memory location.

This is resolved by redefining all dependencies to include
dependencies carried by memory accesses; a dependency is said to be
carried by memory accesses (in the model: carry-dep) from one load
to another load if the initial load is followed by an arbitrarily
long sequence alternating between stores and loads of the same
thread, where the data of each store depends on the previous load,
and is read by the next load.

Any dependency linking the final load in the sequence to another
access also links the initial load in the sequence to that access.

More deep details can be found in this LKML discussion:

https://lore.kernel.org/lkml/d86295788ad14a02874ab030ddb8a6f8@huawei.com/

Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/explanation.txt             |  9 +++++-
 tools/memory-model/linux-kernel.bell          |  6 ++++
 .../litmus-tests/dep+plain.litmus             | 31 +++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e901b47236c37..8e70852384709 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2575,7 +2575,7 @@ smp_store_release() -- which is basically how the Linux kernel treats
 them.
 
 Although we said that plain accesses are not linked by the ppo
-relation, they do contribute to it indirectly.  Namely, when there is
+relation, they do contribute to it indirectly.  Firstly, when there is
 an address dependency from a marked load R to a plain store W,
 followed by smp_wmb() and then a marked store W', the LKMM creates a
 ppo link from R to W'.  The reasoning behind this is perhaps a little
@@ -2584,6 +2584,13 @@ for this source code in which W' could execute before R.  Just as with
 pre-bounding by address dependencies, it is possible for the compiler
 to undermine this relation if sufficient care is not taken.
 
+Secondly, plain accesses can carry dependencies: If a data dependency
+links a marked load R to a store W, and the store is read by a load R'
+from the same thread, then the data loaded by R' depends on the data
+loaded originally by R. Thus, if R' is linked to any access X by a
+dependency, R is also linked to access X by the same dependency, even
+if W' or R' (or both!) are plain.
+
 There are a few oddball fences which need special treatment:
 smp_mb__before_atomic(), smp_mb__after_atomic(), and
 smp_mb__after_spinlock().  The LKMM uses fence events with special
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 5be86b1025e8d..70a9073dec3e5 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -82,3 +82,9 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
 		LKR | LKW | UL | LF | RL | RU
 let Plain = M \ Marked
+
+(* Redefine dependencies to include those carried through plain accesses *)
+let carry-dep = (data ; rfi)*
+let addr = carry-dep ; addr
+let ctrl = carry-dep ; ctrl
+let data = carry-dep ; data
diff --git a/tools/memory-model/litmus-tests/dep+plain.litmus b/tools/memory-model/litmus-tests/dep+plain.litmus
new file mode 100644
index 0000000000000..ebf84daa9a590
--- /dev/null
+++ b/tools/memory-model/litmus-tests/dep+plain.litmus
@@ -0,0 +1,31 @@
+C dep+plain
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that in LKMM, plain accesses
+ * carry dependencies much like accesses to registers:
+ * The data stored to *z1 and *z2 by P0() originates from P0()'s
+ * READ_ONCE(), and therefore using that data to compute the
+ * conditional of P0()'s if-statement creates a control dependency
+ * from that READ_ONCE() to P0()'s WRITE_ONCE().
+ *)
+
+{}
+
+P0(int *x, int *y, int *z1, int *z2)
+{
+	int a = READ_ONCE(*x);
+	*z1 = a;
+	*z2 = *z1;
+	if (*z2 == 1)
+		WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r = smp_load_acquire(y);
+	smp_store_release(x, r);
+}
+
+exists (x=1 /\ y=1)
-- 
2.31.1.189.g2e36527f23

