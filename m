Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D342A8969
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgKEWAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732612AbgKEWAY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E728421D81;
        Thu,  5 Nov 2020 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613623;
        bh=yL6Vs8K9hxUJ/pCdvntLce6v5pwZHWs6K1+Ok4rOBeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dgf9pc3IblN/l0ynHklEuFAEVJxJFix8tIaOAoh+zyQxX+CFYvUXejA3hUEMBGOaR
         zbBjrS9iOSfzoycukjExwTdVKE408W+bus4j34001UnokhgUvmRMGE1fwgYY7jtbW0
         /abz0T1+8ds3I1+uYkWuYRweDO3ESrwnxFexVwxE=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 7/8] tools/memory-model: Use "buf" and "flag" for message-passing tests
Date:   Thu,  5 Nov 2020 14:00:16 -0800
Message-Id: <20201105220017.15410-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The use of "x" and "y" for message-passing tests is fine for people
familiar with memory models and litmus-test nomenclature, but is a bit
obtuse for others.  This commit therefore substitutes "buf" for "x" and
"flag" for "y" for the MP tests.  There are a few special-case MP tests
that use locks and these are unchanged.  There is another MP test that
uses pointers, and this is changed to name the pointer "p".

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../MP+fencewmbonceonce+fencermbonceonce.litmus          | 16 ++++++++--------
 .../litmus-tests/MP+onceassign+derefonce.litmus          | 12 ++++++------
 tools/memory-model/litmus-tests/MP+polocks.litmus        | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+poonceonces.litmus    | 16 ++++++++--------
 .../litmus-tests/MP+pooncerelease+poacquireonce.litmus   | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+porevlocks.litmus     | 16 ++++++++--------
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index e04b71b..f15e501 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -9,25 +9,25 @@ C MP+fencewmbonceonce+fencermbonceonce
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	smp_wmb();
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	smp_rmb();
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 18df682..ed8ee9b 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,24 +10,24 @@ C MP+onceassign+derefonce
  *)
 
 {
+	int *p=y;
 	int x;
-	int *y=z;
-	int z=0;
+	int y=0;
 }
 
-P0(int *x, int **y)
+P0(int *x, int **p)
 {
 	WRITE_ONCE(*x, 1);
-	rcu_assign_pointer(*y, x);
+	rcu_assign_pointer(*p, x);
 }
 
-P1(int *x, int **y)
+P1(int *x, int **p)
 {
 	int *r0;
 	int r1;
 
 	rcu_read_lock();
-	r0 = rcu_dereference(*y);
+	r0 = rcu_dereference(*p);
 	r1 = READ_ONCE(*r0);
 	rcu_read_unlock();
 }
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 63e0f67..4b0c2ed 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -13,27 +13,27 @@ C MP+polocks
 
 {
 	spinlock_t mylock;
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock)
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_lock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock)
 {
 	int r0;
 	int r1;
 
 	spin_lock(mylock);
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_unlock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 68180a4..3010bba 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -8,23 +8,23 @@ C MP+poonceonces
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*buf, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
-	r1 = READ_ONCE(*x);
+	r0 = READ_ONCE(*flag);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index 19f3e68..21e825d 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -9,23 +9,23 @@ C MP+pooncerelease+poacquireonce
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
-	smp_store_release(y, 1);
+	WRITE_ONCE(*buf, 1);
+	smp_store_release(flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = smp_load_acquire(y);
-	r1 = READ_ONCE(*x);
+	r0 = smp_load_acquire(flag);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 4ac189a..9691d55 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -13,27 +13,27 @@ C MP+porevlocks
 
 {
 	spinlock_t mylock;
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_lock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock)
 {
 	spin_lock(mylock);
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_unlock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
 exists (0:r0=1 /\ 0:r1=0)
-- 
2.9.5

