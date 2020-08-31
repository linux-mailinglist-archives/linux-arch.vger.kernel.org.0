Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62122580E7
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgHaSUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgHaSUn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:43 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85D421527;
        Mon, 31 Aug 2020 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898041;
        bh=heC54HJZJRhKoXK7S58uiKiSEON3T0nWjfDpYeIt8jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqINwVWtK/QKH4YfjDPOyDf6dOf13nPtE7H1HOCS5+1M4Hi6JV6kYz3pxibagNJE+
         +sqGrfGUNJA3/6BMi+KnAoczPsAz7AsOWXFd4P6KtjOCEE0B0Dt5n3UuGgRhoRSSbG
         YUVpb7c3c2+41B15D0RmKkMnHpBgNkGb+dR6Eea8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner cases
Date:   Mon, 31 Aug 2020 11:20:37 -0700
Message-Id: <20200831182037.2034-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Most Linux-kernel uses of locking are straightforward, but there are
corner-case uses that rely on less well-known aspects of the lock and
unlock primitives.  This commit therefore adds a locking.txt and litmus
tests in Documentation/litmus-tests/locking to explain these corner-case
uses.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../litmus-tests/locking/DCL-broken.litmus         |  55 ++++
 .../litmus-tests/locking/DCL-fixed.litmus          |  56 ++++
 .../litmus-tests/locking/RM-broken.litmus          |  42 +++
 Documentation/litmus-tests/locking/RM-fixed.litmus |  42 +++
 tools/memory-model/Documentation/locking.txt       | 320 +++++++++++++++++++++
 5 files changed, 515 insertions(+)
 create mode 100644 Documentation/litmus-tests/locking/DCL-broken.litmus
 create mode 100644 Documentation/litmus-tests/locking/DCL-fixed.litmus
 create mode 100644 Documentation/litmus-tests/locking/RM-broken.litmus
 create mode 100644 Documentation/litmus-tests/locking/RM-fixed.litmus
 create mode 100644 tools/memory-model/Documentation/locking.txt

diff --git a/Documentation/litmus-tests/locking/DCL-broken.litmus b/Documentation/litmus-tests/locking/DCL-broken.litmus
new file mode 100644
index 0000000..cfaa25f
--- /dev/null
+++ b/Documentation/litmus-tests/locking/DCL-broken.litmus
@@ -0,0 +1,55 @@
+C DCL-broken
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates more than just locking is required to
+ * correctly implement double-checked locking.
+ *)
+
+{
+	int flag;
+	int data;
+	int lck;
+}
+
+P0(int *flag, int *data, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = READ_ONCE(*flag);
+	if (r0 == 0) {
+		spin_lock(lck);
+		r1 = READ_ONCE(*flag);
+		if (r1 == 0) {
+			WRITE_ONCE(*data, 1);
+			WRITE_ONCE(*flag, 1);
+		}
+		spin_unlock(lck);
+	}
+	r2 = READ_ONCE(*data);
+}
+
+P1(int *flag, int *data, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = READ_ONCE(*flag);
+	if (r0 == 0) {
+		spin_lock(lck);
+		r1 = READ_ONCE(*flag);
+		if (r1 == 0) {
+			WRITE_ONCE(*data, 1);
+			WRITE_ONCE(*flag, 1);
+		}
+		spin_unlock(lck);
+	}
+	r2 = READ_ONCE(*data);
+}
+
+locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
+exists (0:r2=0 \/ 1:r2=0)
diff --git a/Documentation/litmus-tests/locking/DCL-fixed.litmus b/Documentation/litmus-tests/locking/DCL-fixed.litmus
new file mode 100644
index 0000000..579d6c2
--- /dev/null
+++ b/Documentation/litmus-tests/locking/DCL-fixed.litmus
@@ -0,0 +1,56 @@
+C DCL-fixed
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that double-checked locking can be
+ * reliable given proper use of smp_load_acquire() and smp_store_release()
+ * in addition to the locking.
+ *)
+
+{
+	int flag;
+	int data;
+	int lck;
+}
+
+P0(int *flag, int *data, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = smp_load_acquire(flag);
+	if (r0 == 0) {
+		spin_lock(lck);
+		r1 = READ_ONCE(*flag);
+		if (r1 == 0) {
+			WRITE_ONCE(*data, 1);
+			smp_store_release(flag, 1);
+		}
+		spin_unlock(lck);
+	}
+	r2 = READ_ONCE(*data);
+}
+
+P1(int *flag, int *data, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = smp_load_acquire(flag);
+	if (r0 == 0) {
+		spin_lock(lck);
+		r1 = READ_ONCE(*flag);
+		if (r1 == 0) {
+			WRITE_ONCE(*data, 1);
+			smp_store_release(flag, 1);
+		}
+		spin_unlock(lck);
+	}
+	r2 = READ_ONCE(*data);
+}
+
+locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
+exists (0:r2=0 \/ 1:r2=0)
diff --git a/Documentation/litmus-tests/locking/RM-broken.litmus b/Documentation/litmus-tests/locking/RM-broken.litmus
new file mode 100644
index 0000000..c586ae4
--- /dev/null
+++ b/Documentation/litmus-tests/locking/RM-broken.litmus
@@ -0,0 +1,42 @@
+C RM-broken
+
+(*
+ * Result: DEADLOCK
+ *
+ * This litmus test demonstrates that the old "roach motel" approach
+ * to locking, where code can be freely moved into critical sections,
+ * cannot be used in the Linux kernel.
+ *)
+
+{
+	int lck;
+	int x;
+	int y;
+}
+
+P0(int *x, int *y, int *lck)
+{
+	int r2;
+
+	spin_lock(lck);
+	r2 = atomic_inc_return(y);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(lck);
+}
+
+P1(int *x, int *y, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	spin_lock(lck);
+	r0 = READ_ONCE(*x);
+	r1 = READ_ONCE(*x);
+	r2 = atomic_inc_return(y);
+	spin_unlock(lck);
+}
+
+locations [x;lck;0:r2;1:r0;1:r1;1:r2]
+filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+exists (1:r2=1)
diff --git a/Documentation/litmus-tests/locking/RM-fixed.litmus b/Documentation/litmus-tests/locking/RM-fixed.litmus
new file mode 100644
index 0000000..6728567
--- /dev/null
+++ b/Documentation/litmus-tests/locking/RM-fixed.litmus
@@ -0,0 +1,42 @@
+C RM-fixed
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that the old "roach motel" approach
+ * to locking, where code can be freely moved into critical sections,
+ * cannot be used in the Linux kernel.
+ *)
+
+{
+	int lck;
+	int x;
+	int y;
+}
+
+P0(int *x, int *y, int *lck)
+{
+	int r2;
+
+	spin_lock(lck);
+	r2 = atomic_inc_return(y);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(lck);
+}
+
+P1(int *x, int *y, int *lck)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = READ_ONCE(*x);
+	r1 = READ_ONCE(*x);
+	spin_lock(lck);
+	r2 = atomic_inc_return(y);
+	spin_unlock(lck);
+}
+
+locations [x;lck;0:r2;1:r0;1:r1;1:r2]
+filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+exists (1:r2=1)
diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
new file mode 100644
index 0000000..a6ad6aa
--- /dev/null
+++ b/tools/memory-model/Documentation/locking.txt
@@ -0,0 +1,320 @@
+Locking
+=======
+
+Locking is well-known and the common use cases are straightforward: Any
+CPU holding a given lock sees any changes previously seen or made by any
+CPU before it previously released that same lock.  This last sentence
+is the only part of this document that most developers will need to read.
+
+However, developers who would like to also access lock-protected shared
+variables outside of their corresponding locks should continue reading.
+
+
+Locking and Prior Accesses
+--------------------------
+
+The basic rule of locking is worth repeating:
+
+	Any CPU holding a given lock sees any changes previously seen
+	or made by any CPU before it previously released that same lock.
+
+Note that this statement is a bit stronger than "Any CPU holding a
+given lock sees all changes made by any CPU during the time that CPU was
+previously holding this same lock".  For example, consider the following
+pair of code fragments:
+
+	/* See MP+polocks.litmus. */
+	void CPU0(void)
+	{
+		WRITE_ONCE(x, 1);
+		spin_lock(&mylock);
+		WRITE_ONCE(y, 1);
+		spin_unlock(&mylock);
+	}
+
+	void CPU1(void)
+	{
+		spin_lock(&mylock);
+		r0 = READ_ONCE(y);
+		spin_unlock(&mylock);
+		r1 = READ_ONCE(x);
+	}
+
+The basic rule guarantees that if CPU0() acquires mylock before CPU1(),
+then both r0 and r1 must be set to the value 1.  This also has the
+consequence that if the final value of r0 is equal to 1, then the final
+value of r1 must also be equal to 1.  In contrast, the weaker rule would
+say nothing about the final value of r1.
+
+
+Locking and Subsequent Accesses
+-------------------------------
+
+The converse to the basic rule also holds:  Any CPU holding a given
+lock will not see any changes that will be made by any CPU after it
+subsequently acquires this same lock.  This converse statement is
+illustrated by the following litmus test:
+
+	/* See MP+porevlocks.litmus. */
+	void CPU0(void)
+	{
+		r0 = READ_ONCE(y);
+		spin_lock(&mylock);
+		r1 = READ_ONCE(x);
+		spin_unlock(&mylock);
+	}
+
+	void CPU1(void)
+	{
+		spin_lock(&mylock);
+		WRITE_ONCE(x, 1);
+		spin_unlock(&mylock);
+		WRITE_ONCE(y, 1);
+	}
+
+This converse to the basic rule guarantees that if CPU0() acquires
+mylock before CPU1(), then both r0 and r1 must be set to the value 0.
+This also has the consequence that if the final value of r1 is equal
+to 0, then the final value of r0 must also be equal to 0.  In contrast,
+the weaker rule would say nothing about the final value of r0.
+
+These examples show only a single pair of CPUs, but the effects of the
+locking basic rule extend across multiple acquisitions of a given lock
+across multiple CPUs.
+
+
+Double-Checked Locking
+----------------------
+
+It is well known that more than just a lock is required to make
+double-checked locking work correctly,  This litmus test illustrates
+one incorrect approach:
+
+	/* See Documentation/litmus-tests/locking/DCL-broken.litmus. */
+	P0(int *flag, int *data, int *lck)
+	{
+		int r0;
+		int r1;
+		int r2;
+
+		r0 = READ_ONCE(*flag);
+		if (r0 == 0) {
+			spin_lock(lck);
+			r1 = READ_ONCE(*flag);
+			if (r1 == 0) {
+				WRITE_ONCE(*data, 1);
+				WRITE_ONCE(*flag, 1);
+			}
+			spin_unlock(lck);
+		}
+		r2 = READ_ONCE(*data);
+	}
+	/* P1() is the exactly the same as P0(). */
+
+There are two problems.  First, there is no ordering between the first
+READ_ONCE() of "flag" and the READ_ONCE() of "data".  Second, there is
+no ordering between the two WRITE_ONCE() calls.  It should therefore be
+no surprise that "r2" can be zero, and a quick herd7 run confirms this.
+
+One way to fix this is to use smp_load_acquire() and smp_store_release()
+as shown in this corrected version:
+
+	/* See Documentation/litmus-tests/locking/DCL-fixed.litmus. */
+	P0(int *flag, int *data, int *lck)
+	{
+		int r0;
+		int r1;
+		int r2;
+
+		r0 = smp_load_acquire(flag);
+		if (r0 == 0) {
+			spin_lock(lck);
+			r1 = READ_ONCE(*flag);
+			if (r1 == 0) {
+				WRITE_ONCE(*data, 1);
+				smp_store_release(flag, 1);
+			}
+			spin_unlock(lck);
+		}
+		r2 = READ_ONCE(*data);
+	}
+	/* P1() is the exactly the same as P0(). */
+
+The smp_load_acquire() guarantees that its load from "flags" will
+be ordered before the READ_ONCE() from data, thus solving the first
+problem.  The smp_store_release() guarantees that its store will be
+ordered after the WRITE_ONCE() to "data", solving the second problem.
+The smp_store_release() pairs with the smp_load_acquire(), thus ensuring
+that the ordering provided by each actually takes effect.  Again, a
+quick herd7 run confirms this.
+
+In short, if you access a lock-protected variable without holding the
+corresponding lock, you will need to provide additional ordering, in
+this case, via the smp_load_acquire() and the smp_store_release().
+
+
+Ordering Provided by a Lock to CPUs Not Holding That Lock
+---------------------------------------------------------
+
+It is not necessarily the case that accesses ordered by locking will be
+seen as ordered by CPUs not holding that lock.  Consider this example:
+
+	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
+	void CPU0(void)
+	{
+		spin_lock(&mylock);
+		WRITE_ONCE(x, 1);
+		WRITE_ONCE(y, 1);
+		spin_unlock(&mylock);
+	}
+
+	void CPU1(void)
+	{
+		spin_lock(&mylock);
+		r0 = READ_ONCE(y);
+		WRITE_ONCE(z, 1);
+		spin_unlock(&mylock);
+	}
+
+	void CPU2(void)
+	{
+		WRITE_ONCE(z, 2);
+		smp_mb();
+		r1 = READ_ONCE(x);
+	}
+
+Counter-intuitive though it might be, it is quite possible to have
+the final value of r0 be 1, the final value of z be 2, and the final
+value of r1 be 0.  The reason for this surprising outcome is that CPU2()
+never acquired the lock, and thus did not fully benefit from the lock's
+ordering properties.
+
+Ordering can be extended to CPUs not holding the lock by careful use
+of smp_mb__after_spinlock():
+
+	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
+	void CPU0(void)
+	{
+		spin_lock(&mylock);
+		WRITE_ONCE(x, 1);
+		WRITE_ONCE(y, 1);
+		spin_unlock(&mylock);
+	}
+
+	void CPU1(void)
+	{
+		spin_lock(&mylock);
+		smp_mb__after_spinlock();
+		r0 = READ_ONCE(y);
+		WRITE_ONCE(z, 1);
+		spin_unlock(&mylock);
+	}
+
+	void CPU2(void)
+	{
+		WRITE_ONCE(z, 2);
+		smp_mb();
+		r1 = READ_ONCE(x);
+	}
+
+This addition of smp_mb__after_spinlock() strengthens the lock
+acquisition sufficiently to rule out the counter-intuitive outcome.
+In other words, the addition of the smp_mb__after_spinlock() prohibits
+the counter-intuitive result where the final value of r0 is 1, the final
+value of z is 2, and the final value of r1 is 0.
+
+
+No Roach-Motel Locking!
+-----------------------
+
+This example requires familiarity with the herd7 "filter" clause, so
+please read up on that topic in litmus-tests.txt.
+
+It is tempting to allow memory-reference instructions to be pulled
+into a critical section, but this cannot be allowed in the general case.
+For example, consider a spin loop preceding a lock-based critical section.
+Now, herd7 does not model spin loops, but we can emulate one with two
+loads, with a "filter" clause to constrain the first to return the
+initial value and the second to return the updated value, as shown below:
+
+	/* See Documentation/litmus-tests/locking/RM-fixed.litmus. */
+	P0(int *x, int *y, int *lck)
+	{
+		int r2;
+
+		spin_lock(lck);
+		r2 = atomic_inc_return(y);
+		WRITE_ONCE(*x, 1);
+		spin_unlock(lck);
+	}
+
+	P1(int *x, int *y, int *lck)
+	{
+		int r0;
+		int r1;
+		int r2;
+
+		r0 = READ_ONCE(*x);
+		r1 = READ_ONCE(*x);
+		spin_lock(lck);
+		r2 = atomic_inc_return(y);
+		spin_unlock(lck);
+	}
+
+	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+	exists (1:r2=1)
+
+The variable "x" is the control variable for the emulated spin loop.
+P0() sets it to "1" while holding the lock, and P1() emulates the
+spin loop by reading it twice, first into "1:r0" (which should get the
+initial value "0") and then into "1:r1" (which should get the updated
+value "1").
+
+The purpose of the variable "y" is to reject deadlocked executions.
+Only those executions where the final value of "y" have avoided deadlock.
+
+The "filter" clause takes all this into account, constraining "y" to
+equal "2", "1:r0" to equal "0", and "1:r1" to equal 1.
+
+Then the "exists" clause checks to see if P1() acquired its lock first,
+which should not happen given the filter clause because P0() updates
+"x" while holding the lock.  And herd7 confirms this.
+
+But suppose that the compiler was permitted to reorder the spin loop
+into P1()'s critical section, like this:
+
+	/* See Documentation/litmus-tests/locking/RM-broken.litmus. */
+	P0(int *x, int *y, int *lck)
+	{
+		int r2;
+
+		spin_lock(lck);
+		r2 = atomic_inc_return(y);
+		WRITE_ONCE(*x, 1);
+		spin_unlock(lck);
+	}
+
+	P1(int *x, int *y, int *lck)
+	{
+		int r0;
+		int r1;
+		int r2;
+
+		spin_lock(lck);
+		r0 = READ_ONCE(*x);
+		r1 = READ_ONCE(*x);
+		r2 = atomic_inc_return(y);
+		spin_unlock(lck);
+	}
+
+	locations [x;lck;0:r2;1:r0;1:r1;1:r2]
+	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
+	exists (1:r2=1)
+
+If "1:r0" is equal to "0", "1:r1" can never equal "1" because P0()
+cannot update "x" while P1() holds the lock.  And herd7 confirms this,
+showing zero executions matching the "filter" criteria.
+
+And this is why Linux-kernel lock and unlock primitives must prevent
+code from entering critical sections.  It is not sufficient to only
+prevnt code from leaving them.
-- 
2.9.5

