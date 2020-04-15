Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD71AB103
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411801AbgDOTI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416866AbgDOStu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDAE216FD;
        Wed, 15 Apr 2020 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976589;
        bh=+77x5whDjRYIYIEKhtra1cHGuZpcH2tP4qOEZzeVFjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3TNoJls4hPhoOA4VxCdJLgSEqj8lkqqE9plTnfW0oxubJrkZBcZC5Dx8+QLa59Zm
         LzpD/qAWSQCOMjBgmJHwaUiqekedwXymBtBui2/SO45AM/RYoos31z6ji09wNjADOR
         hTqbxoYfFdym3SDvSzR0PX0BCyLpa9sITAuGQY/U=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lkmm tip/core/rcu 10/10] Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
Date:   Wed, 15 Apr 2020 11:49:45 -0700
Message-Id: <20200415184945.16487-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

We already use a litmus test in atomic_t.txt to describe atomic RMW +
smp_mb__after_atomic() is stronger than acquire (both the read and the
write parts are ordered). So make it a litmus test in atomic-tests
directory, so that people can access the litmus easily.

Additionally, change the processor numbers "P1, P2" to "P0, P1" in
atomic_t.txt for the consistency with the processor numbers in the
litmus test, which herd can handle.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/atomic_t.txt                         | 10 +++----
 ...b__after_atomic-is-stronger-than-acquire.litmus | 32 ++++++++++++++++++++++
 Documentation/litmus-tests/atomic/README           |  5 ++++
 3 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 67d1d99f..0f1fded 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -233,19 +233,19 @@ as well. Similarly, something like:
 is an ACQUIRE pattern (though very much not typical), but again the barrier is
 strictly stronger than ACQUIRE. As illustrated:
 
-  C strong-acquire
+  C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
 
   {
   }
 
-  P1(int *x, atomic_t *y)
+  P0(int *x, atomic_t *y)
   {
     r0 = READ_ONCE(*x);
     smp_rmb();
     r1 = atomic_read(y);
   }
 
-  P2(int *x, atomic_t *y)
+  P1(int *x, atomic_t *y)
   {
     atomic_inc(y);
     smp_mb__after_atomic();
@@ -253,14 +253,14 @@ strictly stronger than ACQUIRE. As illustrated:
   }
 
   exists
-  (r0=1 /\ r1=0)
+  (0:r0=1 /\ 0:r1=0)
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
 because it would not order the W part of the RMW against the following
 WRITE_ONCE.  Thus:
 
-  P1			P2
+  P0			P1
 
 			t = LL.acq *y (0)
 			t++;
diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
new file mode 100644
index 0000000..9a8e31a
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
@@ -0,0 +1,32 @@
+C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
+
+(*
+ * Result: Never
+ *
+ * Test that an atomic RMW followed by a smp_mb__after_atomic() is
+ * stronger than a normal acquire: both the read and write parts of
+ * the RMW are ordered before the subsequential memory accesses.
+ *)
+
+{
+}
+
+P0(int *x, atomic_t *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	smp_rmb();
+	r1 = atomic_read(y);
+}
+
+P1(int *x, atomic_t *y)
+{
+	atomic_inc(y);
+	smp_mb__after_atomic();
+	WRITE_ONCE(*x, 1);
+}
+
+exists
+(0:r0=1 /\ 0:r1=0)
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
index a1b7241..714cf93 100644
--- a/Documentation/litmus-tests/atomic/README
+++ b/Documentation/litmus-tests/atomic/README
@@ -7,5 +7,10 @@ tools/memory-model/README.
 LITMUS TESTS
 ============
 
+Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
+	Test that an atomic RMW followed by a smp_mb__after_atomic() is
+	stronger than a normal acquire: both the read and write parts of
+	the RMW are ordered before the subsequential memory accesses.
+
 Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 	Test that atomic_set() cannot break the atomicity of atomic RMWs.
-- 
2.9.5

