Return-Path: <linux-arch+bounces-3449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A2898EF9
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 21:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A68F1C28140
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80405135A6D;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB9oAm/x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06E15EA6;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258812; cv=none; b=fwuKT3ZlAc7B7bWyZH8Qs5Z/Ha2Vi0xBLjg/qzyeCUfS4bRNnAaD+Dr2k8lBo3qJsZ8hX0OePhaOvGbrFqDlBzIkO+oskF7KqCNeBVmOzMCn3mIPk9JG7xnWr39gZaIB8W3ook/3INNPzLaRrPfd8GVkzRt9xfTzf2fJr3byfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258812; c=relaxed/simple;
	bh=EdNvKx2O5c+vvjNaWxfRZSP6Ftir/oLJKykWQvklzVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0a9ah9h+Ziq/FZEEbLXCq+dSkFTdbmJszG/Q2OU2d2aPv4tNk/AVuJFKSNCrcFBWIh4P5rh2+JL85hF8+m5b40G/NBSjljmH2mlLCoTWgVt5xh5l7Fu791e/7nNleqO8zC7vjErzgSumeEXrXAd+7byd/DQNtOSNgKHsitvq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB9oAm/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C04C433B2;
	Thu,  4 Apr 2024 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712258812;
	bh=EdNvKx2O5c+vvjNaWxfRZSP6Ftir/oLJKykWQvklzVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qB9oAm/x/mX6qTk2wwOIZrgGmA9qtOMhTYSl/RHf832fEsSKzzpBal7339nvTyiNK
	 c81oPNwKK/++h0VImLjP7ODxw7+CJamPowVr0AsGmfhMwAcPKZUslJzGoYkyWb97vS
	 UDfsHnKwmUbImvjPPyZdSpNuEfgy0+CC5cpS5ul/FvLTL0ncKIicuYTKr4WbsBIaXv
	 CtOwGyspNrKeM28PqF/UI0YWYNf0zDlcNFKlSqMARvVZo5QBnGOcem1vEMHaeUcy4B
	 DGlltj6W+oaeK8pyQSgkkA1olfa9DkX1bcrdRT0rSKl0hGqVFXGXzOzxPFuNM5ILg1
	 Db0gCbL/N83Yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94D86CE12BF; Thu,  4 Apr 2024 12:26:51 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH memory-model 2/3] Documentation/litmus-tests: Demonstrate unordered failing cmpxchg
Date: Thu,  4 Apr 2024 12:26:48 -0700
Message-Id: <20240404192649.531112-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds four litmus tests showing that a failing cmpxchg()
operation is unordered unless followed by an smp_mb__after_atomic()
operation.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/litmus-tests/README             | 48 ++++++++++++-------
 .../atomic/cmpxchg-fail-ordered-1.litmus      | 34 +++++++++++++
 .../atomic/cmpxchg-fail-ordered-2.litmus      | 30 ++++++++++++
 .../atomic/cmpxchg-fail-unordered-1.litmus    | 33 +++++++++++++
 .../atomic/cmpxchg-fail-unordered-2.litmus    | 30 ++++++++++++
 5 files changed, 159 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 5c8915e6fb684..6c666f3422ea3 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -21,34 +21,50 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
     Test that atomic_set() cannot break the atomicity of atomic RMWs.
     NOTE: Require herd7 7.56 or later which supports "(void)expr".
 
+cmpxchg-fail-ordered-1.litmus
+    Demonstrate that a failing cmpxchg() operation acts as a full barrier
+    when followed by smp_mb__after_atomic().
+
+cmpxchg-fail-ordered-2.litmus
+    Demonstrate that a failing cmpxchg() operation acts as an acquire
+    operation when followed by smp_mb__after_atomic().
+
+cmpxchg-fail-unordered-1.litmus
+    Demonstrate that a failing cmpxchg() operation does not act as a
+    full barrier.
+
+cmpxchg-fail-unordered-2.litmus
+    Demonstrate that a failing cmpxchg() operation does not act as an
+    acquire operation.
+
 
 locking (/locking directory)
 ----------------------------
 
 DCL-broken.litmus
-	Demonstrates that double-checked locking needs more than just
-	the obvious lock acquisitions and releases.
+    Demonstrates that double-checked locking needs more than just
+    the obvious lock acquisitions and releases.
 
 DCL-fixed.litmus
-	Demonstrates corrected double-checked locking that uses
-	smp_store_release() and smp_load_acquire() in addition to the
-	obvious lock acquisitions and releases.
+    Demonstrates corrected double-checked locking that uses
+    smp_store_release() and smp_load_acquire() in addition to the
+    obvious lock acquisitions and releases.
 
 RM-broken.litmus
-	Demonstrates problems with "roach motel" locking, where code is
-	freely moved into lock-based critical sections.  This example also
-	shows how to use the "filter" clause to discard executions that
-	would be excluded by other code not modeled in the litmus test.
-	Note also that this "roach motel" optimization is emulated by
-	physically moving P1()'s two reads from x under the lock.
+    Demonstrates problems with "roach motel" locking, where code is
+    freely moved into lock-based critical sections.  This example also
+    shows how to use the "filter" clause to discard executions that
+    would be excluded by other code not modeled in the litmus test.
+    Note also that this "roach motel" optimization is emulated by
+    physically moving P1()'s two reads from x under the lock.
 
-	What is a roach motel?	This is from an old advertisement for
-	a cockroach trap, much later featured in one of the "Men in
-	Black" movies.	"The roaches check in.	They don't check out."
+    What is a roach motel?  This is from an old advertisement for
+    a cockroach trap, much later featured in one of the "Men in
+    Black" movies.  "The roaches check in.  They don't check out."
 
 RM-fixed.litmus
-	The counterpart to RM-broken.litmus, showing P0()'s two loads from
-	x safely outside of the critical section.
+    The counterpart to RM-broken.litmus, showing P0()'s two loads from
+    x safely outside of the critical section.
 
 
 RCU (/rcu directory)
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
new file mode 100644
index 0000000000000..3df1d140b189b
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
@@ -0,0 +1,34 @@
+C cmpxchg-fail-ordered-1
+
+(*
+ * Result: Never
+ *
+ * Demonstrate that a failing cmpxchg() operation will act as a full
+ * barrier when followed by smp_mb__after_atomic().
+ *)
+
+{}
+
+P0(int *x, int *y, int *z)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*x, 1);
+	r1 = cmpxchg(z, 1, 0);
+	smp_mb__after_atomic();
+	r0 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *z)
+{
+	int r0;
+
+	WRITE_ONCE(*y, 1);
+	r1 = cmpxchg(z, 1, 0);
+	smp_mb__after_atomic();
+	r0 = READ_ONCE(*x);
+}
+
+locations[0:r1;1:r1]
+exists (0:r0=0 /\ 1:r0=0)
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
new file mode 100644
index 0000000000000..54146044a16f6
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
@@ -0,0 +1,30 @@
+C cmpxchg-fail-ordered-2
+
+(*
+ * Result: Never
+ *
+ * Demonstrate use of smp_mb__after_atomic() to make a failing cmpxchg
+ * operation have acquire ordering.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*x, 1);
+	r1 = cmpxchg(y, 0, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	r1 = cmpxchg(y, 0, 1);
+	smp_mb__after_atomic();
+	r2 = READ_ONCE(*x);
+}
+
+exists (0:r1=0 /\ 1:r1=1 /\ 1:r2=0)
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
new file mode 100644
index 0000000000000..a727ce23b1a6e
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
@@ -0,0 +1,33 @@
+C cmpxchg-fail-unordered-1
+
+(*
+ * Result: Sometimes
+ *
+ * Demonstrate that a failing cmpxchg() operation does not act as a
+ * full barrier.  (In contrast, a successful cmpxchg() does act as a
+ * full barrier.)
+ *)
+
+{}
+
+P0(int *x, int *y, int *z)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*x, 1);
+	r1 = cmpxchg(z, 1, 0);
+	r0 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *z)
+{
+	int r0;
+
+	WRITE_ONCE(*y, 1);
+	r1 = cmpxchg(z, 1, 0);
+	r0 = READ_ONCE(*x);
+}
+
+locations[0:r1;1:r1]
+exists (0:r0=0 /\ 1:r0=0)
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
new file mode 100644
index 0000000000000..a245bac55b578
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
@@ -0,0 +1,30 @@
+C cmpxchg-fail-unordered-2
+
+(*
+ * Result: Sometimes
+ *
+ * Demonstrate that a failing cmpxchg() operation does not act as either
+ * an acquire release operation.  (In contrast, a successful cmpxchg()
+ * does act as both an acquire and a release operation.)
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*x, 1);
+	r1 = cmpxchg(y, 0, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	r1 = cmpxchg(y, 0, 1);
+	r2 = READ_ONCE(*x);
+}
+
+exists (0:r1=0 /\ 1:r1=1 /\ 1:r2=0)
-- 
2.40.1


