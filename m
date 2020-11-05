Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2623C2A896B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbgKEWAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgKEWAZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6453021734;
        Thu,  5 Nov 2020 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613624;
        bh=reAMOw/4tleva8M087IXBPk79Dfy7VEw4dnKVm5Ngig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDj6WWygQR8RYF8XTvZkVfCzdNf3dKyUIH6/GJnli7ZU3z+QYN4an3tSrKEOjsFKz
         mZjft59+3RQ0IgbCKZDeQP5f0JbDFcimeoeX25OCCh4ulPg/nyAsv9wzRAvhdvP/V8
         alZx/oRn7v2t6/6OAN0iNOK4LOrLLS9zLr/mYFN4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 8/8] tools/memory-model: Label MP tests' producers and consumers
Date:   Thu,  5 Nov 2020 14:00:17 -0800
Message-Id: <20201105220017.15410-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds comments that label the MP tests' producer and consumer
processes, and also that label the "exists" clause as the bad outcome.

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus        | 6 +++---
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus      | 6 +++---
 .../litmus-tests/MP+polockmbonce+poacquiresilsil.litmus             | 6 +++---
 .../memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus  | 6 +++---
 tools/memory-model/litmus-tests/MP+polocks.litmus                   | 6 +++---
 tools/memory-model/litmus-tests/MP+poonceonces.litmus               | 6 +++---
 .../memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus | 6 +++---
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                | 6 +++---
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index f15e501..c5c168d 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -13,14 +13,14 @@ C MP+fencewmbonceonce+fencermbonceonce
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	smp_wmb();
 	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -30,4 +30,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index ed8ee9b..20ff626 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -15,13 +15,13 @@ C MP+onceassign+derefonce
 	int y=0;
 }
 
-P0(int *x, int **p)
+P0(int *x, int **p) // Producer
 {
 	WRITE_ONCE(*x, 1);
 	rcu_assign_pointer(*p, x);
 }
 
-P1(int *x, int **p)
+P1(int *x, int **p) // Consumer
 {
 	int *r0;
 	int r1;
@@ -32,4 +32,4 @@ P1(int *x, int **p)
 	rcu_read_unlock();
 }
 
-exists (1:r0=x /\ 1:r1=0)
+exists (1:r0=x /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index b1b1266..153917a 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -15,7 +15,7 @@ C MP+polockmbonce+poacquiresilsil
 	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	smp_mb__after_spinlock();
@@ -23,7 +23,7 @@ P0(spinlock_t *lo, int *x)
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -34,4 +34,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index 867c75d..aad6439 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -15,14 +15,14 @@ C MP+polockonce+poacquiresilsil
 	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	WRITE_ONCE(*x, 1);
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -33,4 +33,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 4b0c2ed..21cbca6 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -17,7 +17,7 @@ C MP+polocks
 	int flag;
 }
 
-P0(int *buf, int *flag, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	spin_lock(mylock);
@@ -25,7 +25,7 @@ P0(int *buf, int *flag, spinlock_t *mylock)
 	spin_unlock(mylock);
 }
 
-P1(int *buf, int *flag, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
@@ -36,4 +36,4 @@ P1(int *buf, int *flag, spinlock_t *mylock)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 3010bba..9f9769d 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -12,13 +12,13 @@ C MP+poonceonces
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -27,4 +27,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index 21e825d..cbe28e7 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -13,13 +13,13 @@ C MP+pooncerelease+poacquireonce
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	smp_store_release(flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -28,4 +28,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 9691d55..012041b 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -17,7 +17,7 @@ C MP+porevlocks
 	int flag;
 }
 
-P0(int *buf, int *flag, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
@@ -28,7 +28,7 @@ P0(int *buf, int *flag, spinlock_t *mylock)
 	spin_unlock(mylock);
 }
 
-P1(int *buf, int *flag, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
 	spin_lock(mylock);
 	WRITE_ONCE(*buf, 1);
@@ -36,4 +36,4 @@ P1(int *buf, int *flag, spinlock_t *mylock)
 	WRITE_ONCE(*flag, 1);
 }
 
-exists (0:r0=1 /\ 0:r1=0)
+exists (0:r0=1 /\ 0:r1=0) (* Bad outcome. *)
-- 
2.9.5

