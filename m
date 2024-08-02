Return-Path: <linux-arch+bounces-5903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A867094554C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD0B1C21FCB
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0ED2EE;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDKpDYCf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055DA935;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=cGbC5Wvpi4TrIVqSgc0h866xqCXZFntDyrIXNK3AqPNXOzmePayMr9/qHM5L06ESt0mOMxYQoOZAdKNEp4eiRJ+N9rj2rd2pFiICCMQ2V2l93z9eA9kS/LFtmutu4TPqsbiDckdrIlwTsZGUC8nmF7yEjH8lrhOzyCTTSqMYG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=vebIt+Hpgy4uDqbFeEXyt1jdBxLf1nRFeVvnQsvQDyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fs2G7w+jFLWNJb67w144si0csAmhBKiCLkzfZsJHaDjKXSK+2icPhN1xpq4VFhvSXISDq01HN1+C/IXAAGcBbbL9BvijFMSz9D1e1mTEllLK3hnc+KODCav8aFgDCOv3JicDGpgSPe0wsaYSYOQF1d6qHNi2pyQEO9uTfr8nr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDKpDYCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C7C4AF0A;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=vebIt+Hpgy4uDqbFeEXyt1jdBxLf1nRFeVvnQsvQDyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDKpDYCf/uxuLxSPLyD2Cr3V4ipXBtyoTsCmZ5Czgd63LxKTXzws7sBRBtc/fPfj2
	 NCSPiOZ+AvmH7hnDBrc3K9LQ9Szc67A/YxE0uK72IVsHTfBvQWRroWNwhZxSmCWh5q
	 MWklL0XQKqKYucdxsF8zArfpTFT5X3zZGVdZUOdotOzp43yYirnikzxy5oMLAEN6tw
	 3W7tzxqUGGvbefttJjRUmsJQm2b6VloAc0P2oTERVxSOXnJ0+2WWJ3PgZoCIwY4Eab
	 14AJTUxstXcI7kR2dOjnW+eXxRvX58fN02h9kIqr7qkhlON9WQFwbnL1kmyiwgPlh6
	 snjJ+ZYXRq3pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3553FCE0BC3; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
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
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/7] tools/memory-model: Document herd7 (abstract) representation
Date: Thu,  1 Aug 2024 17:22:11 -0700
Message-Id: <20240802002215.4133695-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
References: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Parri <parri.andrea@gmail.com>

The Linux-kernel memory model (LKMM) source code and the herd7 tool are
closely linked in that the latter is responsible for (pre)processing
each C-like macro of a litmus test, and for providing the LKMM with a
set of events, or "representation", corresponding to the given macro.
This commit therefore provides herd-representation.txt to document
the representations of the concurrency macros, following their
"classification" in Documentation/atomic_t.txt.

Link: https://lore.kernel.org/all/ZnFZPJlILp5B9scN@andrea/

Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README       |   7 +-
 .../Documentation/herd-representation.txt     | 110 ++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/Documentation/herd-representation.txt

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 304162743a5b8..44e7dae73b296 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
 
 o	You are familiar with Linux-kernel concurrency and the use
 	of LKMM, and would like to learn about LKMM's requirements,
-	rationale, and implementation:	explanation.txt
+	rationale, and implementation:	explanation.txt and
+	herd-representation.txt
 
 o	You are interested in the publications related to LKMM, including
 	hardware manuals, academic literature, standards-committee
@@ -61,6 +62,10 @@ control-dependencies.txt
 explanation.txt
 	Detailed description of the memory model.
 
+herd-representation.txt
+	The (abstract) representation of the Linux-kernel concurrency
+	primitives in terms of events.
+
 litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
new file mode 100644
index 0000000000000..ed988906f2b71
--- /dev/null
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -0,0 +1,110 @@
+#
+# Legend:
+#	R,	a Load event
+#	W,	a Store event
+#	F,	a Fence event
+#	LKR,	a Lock-Read event
+#	LKW,	a Lock-Write event
+#	UL,	an Unlock event
+#	LF,	a Lock-Fail event
+#	RL,	a Read-Locked event
+#	RU,	a Read-Unlocked event
+#	R*,	a Load event included in RMW
+#	W*,	a Store event included in RMW
+#	SRCU,	a Sleepable-Read-Copy-Update event
+#
+#	po,	a Program-Order link
+#	rmw,	a Read-Modify-Write link - every rmw link is a po link
+#
+# By convention, a blank line in a cell means "same as the preceding line".
+#
+# Disclaimer.  The table includes representations of "add" and "and" operations;
+# corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
+# "andnot" operations are omitted.
+#
+    ------------------------------------------------------------------------------
+    |                        C macro | Events                                    |
+    ------------------------------------------------------------------------------
+    |                    Non-RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                      READ_ONCE | R[once]                                   |
+    |                    atomic_read |                                           |
+    |                     WRITE_ONCE | W[once]                                   |
+    |                     atomic_set |                                           |
+    |               smp_load_acquire | R[acquire]                                |
+    |            atomic_read_acquire |                                           |
+    |              smp_store_release | W[release]                                |
+    |             atomic_set_release |                                           |
+    |                   smp_store_mb | W[once] ->po F[mb]                        |
+    |                         smp_mb | F[mb]                                     |
+    |                        smp_rmb | F[rmb]                                    |
+    |                        smp_wmb | F[wmb]                                    |
+    |          smp_mb__before_atomic | F[before-atomic]                          |
+    |           smp_mb__after_atomic | F[after-atomic]                           |
+    |                    spin_unlock | UL                                        |
+    |                 spin_is_locked | On success: RL                            |
+    |                                | On failure: RU                            |
+    |         smp_mb__after_spinlock | F[after-spinlock]                         |
+    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
+    |                  rcu_read_lock | F[rcu-lock]                               |
+    |                rcu_read_unlock | F[rcu-unlock]                             |
+    |                synchronize_rcu | F[sync-rcu]                               |
+    |                rcu_dereference | R[once]                                   |
+    |             rcu_assign_pointer | W[release]                                |
+    |                 srcu_read_lock | R[srcu-lock]                              |
+    |                 srcu_down_read |                                           |
+    |               srcu_read_unlock | W[srcu-unlock]                            |
+    |                   srcu_up_read |                                           |
+    |               synchronize_srcu | SRCU[sync-srcu]                           |
+    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
+    ------------------------------------------------------------------------------
+    |       RMW ops w/o return value |                                           |
+    ------------------------------------------------------------------------------
+    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                     atomic_and |                                           |
+    |                      spin_lock | LKR ->po LKW                              |
+    ------------------------------------------------------------------------------
+    |        RMW ops w/ return value |                                           |
+    ------------------------------------------------------------------------------
+    |              atomic_add_return | F[mb] ->po R*[once]                       |
+    |                                |     ->rmw W*[once] ->po F[mb]             |
+    |               atomic_fetch_add |                                           |
+    |               atomic_fetch_and |                                           |
+    |                    atomic_xchg |                                           |
+    |                           xchg |                                           |
+    |            atomic_add_negative |                                           |
+    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
+    |       atomic_fetch_add_relaxed |                                           |
+    |       atomic_fetch_and_relaxed |                                           |
+    |            atomic_xchg_relaxed |                                           |
+    |                   xchg_relaxed |                                           |
+    |    atomic_add_negative_relaxed |                                           |
+    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |       atomic_fetch_add_acquire |                                           |
+    |       atomic_fetch_and_acquire |                                           |
+    |            atomic_xchg_acquire |                                           |
+    |                   xchg_acquire |                                           |
+    |    atomic_add_negative_acquire |                                           |
+    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |       atomic_fetch_add_release |                                           |
+    |       atomic_fetch_and_release |                                           |
+    |            atomic_xchg_release |                                           |
+    |                   xchg_release |                                           |
+    |    atomic_add_negative_release |                                           |
+    ------------------------------------------------------------------------------
+    |            Conditional RMW ops |                                           |
+    ------------------------------------------------------------------------------
+    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
+    |                                |                 ->rmw W*[once] ->po F[mb] |
+    |                                | On failure: R*[once]                      |
+    |                        cmpxchg |                                           |
+    |              atomic_add_unless |                                           |
+    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
+    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
+    |                                | On failure: R*[once]                      |
+    |                   spin_trylock | On success: LKR ->po LKW                  |
+    |                                | On failure: LF                            |
+    ------------------------------------------------------------------------------
-- 
2.40.1


