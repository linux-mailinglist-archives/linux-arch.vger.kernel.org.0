Return-Path: <linux-arch+bounces-10249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56513A3E02B
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E008619C018B
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DB20FAAB;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMmjgDM6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9F1D63F9;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068045; cv=none; b=DZ2Q9JZWxuwwdMHq9WDxCejvcVOfSxf1R4EZr4/kqR0yuUSOEun3RJKaACPH8Mn5P1Tsh2wdcgE55YTHa+PAdp67+LNkH4TCjED+DC8ZJkXxMtdb/O41NcTSoMHVClxrBmnduM/FHKzlrQIFPE7gyyPa5laRZPdGk0Vm9Htig5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068045; c=relaxed/simple;
	bh=Ir6n/IUN5eZ6fqNje+Lapg2qN2Ln3avRnjBN51w/tq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkrKh0dFcJtkWGI2m/KWd0sATXFudVSugZ9f8W75j1gZMkhX44UFLu7MECRhOO0ia7qxnI7xS2imbfMga0KhkFlCzV4xy+kTIbaetgmTmw9msVjeUmHfXU6Vm61RenHt38Kn9BmeWEDjzDkRHZHRDuwaIas9Gyq73YvcnD7GKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMmjgDM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB0FC4CEF5;
	Thu, 20 Feb 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068045;
	bh=Ir6n/IUN5eZ6fqNje+Lapg2qN2Ln3avRnjBN51w/tq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMmjgDM60Ij6GucPXAVvJmvbHP0uyAdllzMMDkdRtACxm54F+8VV1Blx1Gr5ioQOC
	 o5K/n33zHwg/KFIMSeoIXY4mrqv8fQr2y86rdISlgs00fwXCAbIa/FJkO276qTld1N
	 CuiIZCN3oNv/nMR3eeFEa04atXtXbLqSFjVI7DdFAd1n7P7cAp6FHpGJSi9MlRBKV/
	 7Ig/2AYfV0UVztBjaMdA/omccH7D03ENPIe2oCqnmyqILI+5Jy47uaWUUFjXHPb6UD
	 h/A0uwPD7EsfdfH24drLm81RA/8i958bvKUVgCCr6i/7viri7Py28UhHeIUMs7JToz
	 osAOL3tKg5INg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B05C1CE0D99; Thu, 20 Feb 2025 08:14:04 -0800 (PST)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 7/7] tools/memory-model: Distinguish between syntactic and semantic tags
Date: Thu, 20 Feb 2025 08:14:03 -0800
Message-Id: <20250220161403.800831-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Not all annotated accesses provide the semantics their syntactic tags
would imply. For example, an 'acquire tag on a write does not imply that
the write is finally in the Acquire set and provides acquire ordering.

To distinguish in those cases between the syntactic tags and actual
sets, we capitalize the former, so 'ACQUIRE tags may be present on both
reads and writes, but only reads will appear in the Acquire set.

For tags where the two concepts are the same we do not use specific
capitalization to make this distinction.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/herd-representation.txt     |  44 ++--
 tools/memory-model/linux-kernel.bell          |  22 +-
 tools/memory-model/linux-kernel.def           | 198 +++++++++---------
 3 files changed, 132 insertions(+), 132 deletions(-)

diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
index 7ae1ff3d3769e..4e19b4f2a476e 100644
--- a/tools/memory-model/Documentation/herd-representation.txt
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -21,7 +21,7 @@
 # Note that the syntactic representation does not always match the sets and
 # relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
 # lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
-# link, and W[acquire] are not included in the Acquire set.
+# link, and W[ACQUIRE] are not included in the Acquire set.
 #
 # Disclaimer.  The table includes representations of "add" and "and" operations;
 # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
@@ -32,16 +32,16 @@
     ------------------------------------------------------------------------------
     |                    Non-RMW ops |                                           |
     ------------------------------------------------------------------------------
-    |                      READ_ONCE | R[once]                                   |
+    |                      READ_ONCE | R[ONCE]                                   |
     |                    atomic_read |                                           |
-    |                     WRITE_ONCE | W[once]                                   |
+    |                     WRITE_ONCE | W[ONCE]                                   |
     |                     atomic_set |                                           |
-    |               smp_load_acquire | R[acquire]                                |
+    |               smp_load_acquire | R[ACQUIRE]                                |
     |            atomic_read_acquire |                                           |
-    |              smp_store_release | W[release]                                |
+    |              smp_store_release | W[RELEASE]                                |
     |             atomic_set_release |                                           |
-    |                   smp_store_mb | W[once] ->po F[mb]                        |
-    |                         smp_mb | F[mb]                                     |
+    |                   smp_store_mb | W[ONCE] ->po F[MB]                        |
+    |                         smp_mb | F[MB]                                     |
     |                        smp_rmb | F[rmb]                                    |
     |                        smp_wmb | F[wmb]                                    |
     |          smp_mb__before_atomic | F[before-atomic]                          |
@@ -54,8 +54,8 @@
     |                  rcu_read_lock | F[rcu-lock]                               |
     |                rcu_read_unlock | F[rcu-unlock]                             |
     |                synchronize_rcu | F[sync-rcu]                               |
-    |                rcu_dereference | R[once]                                   |
-    |             rcu_assign_pointer | W[release]                                |
+    |                rcu_dereference | R[ONCE]                                   |
+    |             rcu_assign_pointer | W[RELEASE]                                |
     |                 srcu_read_lock | R[srcu-lock]                              |
     |                 srcu_down_read |                                           |
     |               srcu_read_unlock | W[srcu-unlock]                            |
@@ -65,31 +65,31 @@
     ------------------------------------------------------------------------------
     |       RMW ops w/o return value |                                           |
     ------------------------------------------------------------------------------
-    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
+    |                     atomic_add | R*[NORETURN] ->rmw W*[NORETURN]           |
     |                     atomic_and |                                           |
     |                      spin_lock | LKR ->po LKW                              |
     ------------------------------------------------------------------------------
     |        RMW ops w/ return value |                                           |
     ------------------------------------------------------------------------------
-    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
+    |              atomic_add_return | R*[MB] ->rmw W*[MB]                       |
     |               atomic_fetch_add |                                           |
     |               atomic_fetch_and |                                           |
     |                    atomic_xchg |                                           |
     |                           xchg |                                           |
     |            atomic_add_negative |                                           |
-    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
+    |      atomic_add_return_relaxed | R*[ONCE] ->rmw W*[ONCE]                   |
     |       atomic_fetch_add_relaxed |                                           |
     |       atomic_fetch_and_relaxed |                                           |
     |            atomic_xchg_relaxed |                                           |
     |                   xchg_relaxed |                                           |
     |    atomic_add_negative_relaxed |                                           |
-    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
+    |      atomic_add_return_acquire | R*[ACQUIRE] ->rmw W*[ACQUIRE]             |
     |       atomic_fetch_add_acquire |                                           |
     |       atomic_fetch_and_acquire |                                           |
     |            atomic_xchg_acquire |                                           |
     |                   xchg_acquire |                                           |
     |    atomic_add_negative_acquire |                                           |
-    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
+    |      atomic_add_return_release | R*[RELEASE] ->rmw W*[RELEASE]             |
     |       atomic_fetch_add_release |                                           |
     |       atomic_fetch_and_release |                                           |
     |            atomic_xchg_release |                                           |
@@ -98,16 +98,16 @@
     ------------------------------------------------------------------------------
     |            Conditional RMW ops |                                           |
     ------------------------------------------------------------------------------
-    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
-    |                                | On failure: R*[mb]                        |
+    |                 atomic_cmpxchg | On success: R*[MB] ->rmw W*[MB]           |
+    |                                | On failure: R*[MB]                        |
     |                        cmpxchg |                                           |
     |              atomic_add_unless |                                           |
-    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
-    |                                | On failure: R*[once]                      |
-    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
-    |                                | On failure: R*[acquire]                   |
-    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
-    |                                | On failure: R*[release]                   |
+    |         atomic_cmpxchg_relaxed | On success: R*[ONCE] ->rmw W*[ONCE]       |
+    |                                | On failure: R*[ONCE]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[ACQUIRE] ->rmw W*[ACQUIRE] |
+    |                                | On failure: R*[ACQUIRE]                   |
+    |         atomic_cmpxchg_release | On success: R*[RELEASE] ->rmw W*[RELEASE] |
+    |                                | On failure: R*[RELEASE]                   |
     |                   spin_trylock | On success: LKR ->po LKW                  |
     |                                | On failure: LF                            |
     ------------------------------------------------------------------------------
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 8ae47545df978..fe65998002b99 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,18 +13,18 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
-		'release (*smp_store_release*) ||
-		'acquire (*smp_load_acquire*) ||
-		'noreturn (* R of non-return RMW *) ||
-		'mb (*xchg(),cmpxchg(),...*)
+enum Accesses = 'ONCE (*READ_ONCE,WRITE_ONCE*) ||
+		'RELEASE (*smp_store_release*) ||
+		'ACQUIRE (*smp_load_acquire*) ||
+		'NORETURN (* R of non-return RMW *) ||
+		'MB (*xchg(),cmpxchg(),...*)
 instructions R[Accesses]
 instructions W[Accesses]
 instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-		'mb (*smp_mb*) ||
+		'MB (*smp_mb*) ||
 		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
@@ -42,10 +42,10 @@ instructions F[Barriers]
  * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
  *)
 let FailedRMW = RMW \ (domain(rmw) | range(rmw))
-let Acquire = Acquire \ W \ FailedRMW
-let Release = Release \ R \ FailedRMW
-let Mb = Mb \ FailedRMW
-let Noreturn = Noreturn \ W
+let Acquire = ACQUIRE \ W \ FailedRMW
+let Release = RELEASE \ R \ FailedRMW
+let Mb = MB \ FailedRMW
+let Noreturn = NORETURN \ W
 
 (* SRCU *)
 enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
@@ -85,7 +85,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
-let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | RMW |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index d7279a357cba0..49e402782e49c 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -6,18 +6,18 @@
 // which appeared in ASPLOS 2018.
 
 // ONCE
-READ_ONCE(X) __load{once}(X)
-WRITE_ONCE(X,V) { __store{once}(X,V); }
+READ_ONCE(X) __load{ONCE}(X)
+WRITE_ONCE(X,V) { __store{ONCE}(X,V); }
 
 // Release Acquire and friends
-smp_store_release(X,V) { __store{release}(*X,V); }
-smp_load_acquire(X) __load{acquire}(*X)
-rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{once}(X)
-smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
+smp_store_release(X,V) { __store{RELEASE}(*X,V); }
+smp_load_acquire(X) __load{ACQUIRE}(*X)
+rcu_assign_pointer(X,V) { __store{RELEASE}(X,V); }
+rcu_dereference(X) __load{ONCE}(X)
+smp_store_mb(X,V) { __store{ONCE}(X,V); __fence{MB}; }
 
 // Fences
-smp_mb() { __fence{mb}; }
+smp_mb() { __fence{MB}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
@@ -28,14 +28,14 @@ smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
 barrier() { __fence{barrier}; }
 
 // Exchange
-xchg(X,V)  __xchg{mb}(X,V)
-xchg_relaxed(X,V) __xchg{once}(X,V)
-xchg_release(X,V) __xchg{release}(X,V)
-xchg_acquire(X,V) __xchg{acquire}(X,V)
-cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
+xchg(X,V)  __xchg{MB}(X,V)
+xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+xchg_release(X,V) __xchg{RELEASE}(X,V)
+xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
 
 // Spinlocks
 spin_lock(X) { __lock(X); }
@@ -63,86 +63,86 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
-atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
-atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
-atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
-atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
-atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
-atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
-atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
-
-atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
-atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
-atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)
-atomic_add_return_release(V,X) __atomic_op_return{release}(X,+,V)
-atomic_fetch_add(V,X) __atomic_fetch_op{mb}(X,+,V)
-atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
-atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
-atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
-
-atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
-atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
-atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
-atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
-
-atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
-atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
-atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
-atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
-
-atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
-atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
-atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
-atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
-
-atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
-atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
-atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
-atomic_inc_return_release(X) __atomic_op_return{release}(X,+,1)
-atomic_fetch_inc(X) __atomic_fetch_op{mb}(X,+,1)
-atomic_fetch_inc_relaxed(X) __atomic_fetch_op{once}(X,+,1)
-atomic_fetch_inc_acquire(X) __atomic_fetch_op{acquire}(X,+,1)
-atomic_fetch_inc_release(X) __atomic_fetch_op{release}(X,+,1)
-
-atomic_sub_return(V,X) __atomic_op_return{mb}(X,-,V)
-atomic_sub_return_relaxed(V,X) __atomic_op_return{once}(X,-,V)
-atomic_sub_return_acquire(V,X) __atomic_op_return{acquire}(X,-,V)
-atomic_sub_return_release(V,X) __atomic_op_return{release}(X,-,V)
-atomic_fetch_sub(V,X) __atomic_fetch_op{mb}(X,-,V)
-atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{once}(X,-,V)
-atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{acquire}(X,-,V)
-atomic_fetch_sub_release(V,X) __atomic_fetch_op{release}(X,-,V)
-
-atomic_dec_return(X) __atomic_op_return{mb}(X,-,1)
-atomic_dec_return_relaxed(X) __atomic_op_return{once}(X,-,1)
-atomic_dec_return_acquire(X) __atomic_op_return{acquire}(X,-,1)
-atomic_dec_return_release(X) __atomic_op_return{release}(X,-,1)
-atomic_fetch_dec(X) __atomic_fetch_op{mb}(X,-,1)
-atomic_fetch_dec_relaxed(X) __atomic_fetch_op{once}(X,-,1)
-atomic_fetch_dec_acquire(X) __atomic_fetch_op{acquire}(X,-,1)
-atomic_fetch_dec_release(X) __atomic_fetch_op{release}(X,-,1)
-
-atomic_xchg(X,V) __xchg{mb}(X,V)
-atomic_xchg_relaxed(X,V) __xchg{once}(X,V)
-atomic_xchg_release(X,V) __xchg{release}(X,V)
-atomic_xchg_acquire(X,V) __xchg{acquire}(X,V)
-atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
-
-atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
-atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
-atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
-atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
-atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
-atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
-atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
-
-atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
-atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
-atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
-atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
-
-atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
+atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
+atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
+atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
+atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }
+
+atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
+atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
+atomic_add_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V)
+atomic_add_return_release(V,X) __atomic_op_return{RELEASE}(X,+,V)
+atomic_fetch_add(V,X) __atomic_fetch_op{MB}(X,+,V)
+atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{ONCE}(X,+,V)
+atomic_fetch_add_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,+,V)
+atomic_fetch_add_release(V,X) __atomic_fetch_op{RELEASE}(X,+,V)
+
+atomic_fetch_and(V,X) __atomic_fetch_op{MB}(X,&,V)
+atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&,V)
+atomic_fetch_and_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&,V)
+atomic_fetch_and_release(V,X) __atomic_fetch_op{RELEASE}(X,&,V)
+
+atomic_fetch_or(V,X) __atomic_fetch_op{MB}(X,|,V)
+atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{ONCE}(X,|,V)
+atomic_fetch_or_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,|,V)
+atomic_fetch_or_release(V,X) __atomic_fetch_op{RELEASE}(X,|,V)
+
+atomic_fetch_xor(V,X) __atomic_fetch_op{MB}(X,^,V)
+atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{ONCE}(X,^,V)
+atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,^,V)
+atomic_fetch_xor_release(V,X) __atomic_fetch_op{RELEASE}(X,^,V)
+
+atomic_inc_return(X) __atomic_op_return{MB}(X,+,1)
+atomic_inc_return_relaxed(X) __atomic_op_return{ONCE}(X,+,1)
+atomic_inc_return_acquire(X) __atomic_op_return{ACQUIRE}(X,+,1)
+atomic_inc_return_release(X) __atomic_op_return{RELEASE}(X,+,1)
+atomic_fetch_inc(X) __atomic_fetch_op{MB}(X,+,1)
+atomic_fetch_inc_relaxed(X) __atomic_fetch_op{ONCE}(X,+,1)
+atomic_fetch_inc_acquire(X) __atomic_fetch_op{ACQUIRE}(X,+,1)
+atomic_fetch_inc_release(X) __atomic_fetch_op{RELEASE}(X,+,1)
+
+atomic_sub_return(V,X) __atomic_op_return{MB}(X,-,V)
+atomic_sub_return_relaxed(V,X) __atomic_op_return{ONCE}(X,-,V)
+atomic_sub_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,-,V)
+atomic_sub_return_release(V,X) __atomic_op_return{RELEASE}(X,-,V)
+atomic_fetch_sub(V,X) __atomic_fetch_op{MB}(X,-,V)
+atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{ONCE}(X,-,V)
+atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,-,V)
+atomic_fetch_sub_release(V,X) __atomic_fetch_op{RELEASE}(X,-,V)
+
+atomic_dec_return(X) __atomic_op_return{MB}(X,-,1)
+atomic_dec_return_relaxed(X) __atomic_op_return{ONCE}(X,-,1)
+atomic_dec_return_acquire(X) __atomic_op_return{ACQUIRE}(X,-,1)
+atomic_dec_return_release(X) __atomic_op_return{RELEASE}(X,-,1)
+atomic_fetch_dec(X) __atomic_fetch_op{MB}(X,-,1)
+atomic_fetch_dec_relaxed(X) __atomic_fetch_op{ONCE}(X,-,1)
+atomic_fetch_dec_acquire(X) __atomic_fetch_op{ACQUIRE}(X,-,1)
+atomic_fetch_dec_release(X) __atomic_fetch_op{RELEASE}(X,-,1)
+
+atomic_xchg(X,V) __xchg{MB}(X,V)
+atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
+atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
+
+atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
+atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0
+atomic_inc_and_test(X)  __atomic_op_return{MB}(X,+,1) == 0
+atomic_add_negative(V,X) __atomic_op_return{MB}(X,+,V) < 0
+atomic_add_negative_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V) < 0
+atomic_add_negative_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V) < 0
+atomic_add_negative_release(V,X) __atomic_op_return{RELEASE}(X,+,V) < 0
+
+atomic_fetch_andnot(V,X) __atomic_fetch_op{MB}(X,&~,V)
+atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&~,V)
+atomic_fetch_andnot_release(V,X) __atomic_fetch_op{RELEASE}(X,&~,V)
+atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&~,V)
+
+atomic_add_unless(X,V,W) __atomic_add_unless{MB}(X,V,W)
-- 
2.40.1


