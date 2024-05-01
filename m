Return-Path: <linux-arch+bounces-4124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375288B9237
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEFC1C21277
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD4168AF9;
	Wed,  1 May 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAD4W3nm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24122168AE2;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605695; cv=none; b=MXE8Nv7vfxIyegR5ZHusBQY4j0vgoaIDtWcnv+LPkdWgbALWwyMbty/vpTisnZ1j/+qUW0t9XCYYsxR9935tkIJWWixWhqsMOdZIU4GHs6vvWU55UNuxLhf6qvKaRLxSL+Ndo0waVUgWKz2lSXwKzpCPYwpx659GLQh+OPeVHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605695; c=relaxed/simple;
	bh=PjIIBgLr+DWstHxKJAAho0J12+hAPDhHwNbpvgl5zCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjDIyEcmVF6RuQPpkSWzskZu89SdNOa3+lf0kKVEoU/TcEWNR9LX0gs2i55EB1I2e5FErYXdO1KHrZWBEl3CctPGCyZpHLyU7bqbMlXk2OEtirAtDLfTYOvfeyAHn3BRNKKm3/HfVtmIFmctSIhIWhqvvw4E7bEERLN3POh+SSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAD4W3nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEB1C113CC;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605694;
	bh=PjIIBgLr+DWstHxKJAAho0J12+hAPDhHwNbpvgl5zCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAD4W3nmymLlQ101Ufjj+TJsSyo//tQXuHtAPRSXD79p+3bQip6eWH5pV5fOQCRsr
	 8OUisyyw6+oraEt33gcn80SGacU/H+CzZUXe5PvHQLtTwBLa4Yb3hF1R2+7oPAAnmT
	 m/KvKpe2FjkeZfNn83zirKlEJFk0wRHcrg/VB4VshlmHD7dmg9Vg9lpWcFRa9nRlJf
	 HsjTuCmgDSWBqQ8UrkHSK5U+gJ7jNvOiLfWz3Ye8hBm4bzGGXRujhNakHeQPOy/vML
	 /2sfqun0/G98sv9wBCVtqcx13pZxtThyjnhROMAPORxWrqeSMEH5d/MLDaXwd8T95m
	 DPHpfej2Inl/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 671A6CE12E9; Wed,  1 May 2024 16:21:34 -0700 (PDT)
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
Subject: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate unordered failing cmpxchg
Date: Wed,  1 May 2024 16:21:30 -0700
Message-Id: <20240501232132.1785861-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
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
 Documentation/litmus-tests/README             | 16 +++++++++
 .../atomic/cmpxchg-fail-ordered-1.litmus      | 34 +++++++++++++++++++
 .../atomic/cmpxchg-fail-ordered-2.litmus      | 30 ++++++++++++++++
 .../atomic/cmpxchg-fail-unordered-1.litmus    | 33 ++++++++++++++++++
 .../atomic/cmpxchg-fail-unordered-2.litmus    | 30 ++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 26ca56df02125..6c666f3422ea3 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -21,6 +21,22 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
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


