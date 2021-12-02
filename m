Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22C4465B68
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 01:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbhLBAyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Dec 2021 19:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354966AbhLBAyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2021 19:54:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3DC061574;
        Wed,  1 Dec 2021 16:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18185B8200D;
        Thu,  2 Dec 2021 00:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE9AC53FCC;
        Thu,  2 Dec 2021 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638406273;
        bh=usHTyL5u4Wf3/UMC1gxnsM2gVUInm3kaU+A4fFlwv3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usukUZL2sP4JVPihRiXVVHKbhGCSBFWAiLxTkC4/HS8hnsBAf39bgUUAFbKoX9IIX
         MWv4V/yuLxALEXXGXf90XXhD7ojz5jswgKyjawmcg3ePDfC3BLVZo9oI91JShslvJs
         3PXuD1p7aRmjbv3jcPUvSVkafK/ispN54KqzoywWXZdo2zkIy5IrgcHyj7ao0HcVvT
         qBdtIfbzzqcsBL4WWCwY1aj6K9VFaFNg2LqeHPr9MuR0k9U5lgrD9m8OsrPctBLYTB
         GVLMFBGSxCyCKcJ1QDwEnW6NDEqcjMHIBls3aJKPCTZGQvoctVhIimQkyJLA16grPo
         h/e5785Hb3LhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 703B25C1010; Wed,  1 Dec 2021 16:51:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/3] tools/memory-model: litmus: Add two tests for unlock(A)+lock(B) ordering
Date:   Wed,  1 Dec 2021 16:50:53 -0800
Message-Id: <20211202005053.3131071-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
References: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The memory model has been updated to provide a stronger ordering
guarantee for unlock(A)+lock(B) on the same CPU/thread. Therefore add
two litmus tests describing this new guarantee, these tests are simple
yet can clearly show the usage of the new guarantee, also they can serve
as the self tests for the modification in the model.

Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 ...LB+unlocklockonceonce+poacquireonce.litmus | 35 +++++++++++++++++++
 ...unlocklockonceonce+fencermbonceonce.litmus | 33 +++++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 +++++
 3 files changed, 76 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus

diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
new file mode 100644
index 0000000000000..eb34123a6ffe0
--- /dev/null
+++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
@@ -0,0 +1,35 @@
+C LB+unlocklockonceonce+poacquireonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, all accesses
+ * in the first must execute before any accesses in the second, even if the
+ * critical sections are protected by different locks.  Note: Even when a
+ * write executes before a read, their memory effects can be reordered from
+ * the viewpoint of another CPU (the kind of reordering allowed by TSO).
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	int r1;
+
+	spin_lock(s);
+	r1 = READ_ONCE(*x);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r2;
+
+	r2 = smp_load_acquire(y);
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r2=1)
diff --git a/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
new file mode 100644
index 0000000000000..2feb1398be716
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
@@ -0,0 +1,33 @@
+C MP+unlocklockonceonce+fencermbonceonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, stores in the
+ * first must propagate to each CPU before stores in the second do, even if
+ * the critical sections are protected by different locks.
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	spin_lock(s);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	r2 = READ_ONCE(*x);
+}
+
+exists (1:r1=1 /\ 1:r2=0)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9ed..d311a0ff1ae64 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,6 +63,10 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
+LB+unlocklockonceonce+poacquireonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	load and a store?
+
 MP+onceassign+derefonce.litmus
 	As below, but with rcu_assign_pointer() and an rcu_dereference().
 
@@ -90,6 +94,10 @@ MP+porevlocks.litmus
 	As below, but with the first access of the writer process
 	and the second access of reader process protected by a lock.
 
+MP+unlocklockonceonce+fencermbonceonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	store and another store?
+
 MP+fencewmbonceonce+fencermbonceonce.litmus
 	Does a smp_wmb() (between the stores) and an smp_rmb() (between
 	the loads) suffice for the message-passing litmus test, where one
-- 
2.31.1.189.g2e36527f23

