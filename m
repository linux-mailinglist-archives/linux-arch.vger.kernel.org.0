Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A602EC26E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 18:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAFRhX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 12:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbhAFRhX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Jan 2021 12:37:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCECA2312C;
        Wed,  6 Jan 2021 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954601;
        bh=fgGEVXAGkn+GWcSpaJJR2YOkZ3fOxiOUg5cJcvlHVa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQDRUR0ZlajjOcGUQpFuuwBrlbhwiX1UaVCfU53r6VeaBRPDw7tdYSodkD3cwNsVc
         5Lwo/UH9ma7EFwAgAZMW7ZLmBJL5rdg9+8aOWY4QV1pKGLU1oDNITa4KaLZ7iUlZuk
         wevYnBotXOGE1cvNUh/5JB/WkAe9IxseMQz3Zn6OtItFLprPw0zvFxDQVZhhnYWUG2
         5CB0xsZQwvhYUuUAFGY22LJrJNAtSfnpyBQsSTu85nCEklHQ4HnWrjNCc4J0XIsvAt
         0aSy1nJAhS4DTzA5sufAVOaq7QK/ZeVvzNVLftU+4m10D7bCEPPJ13fhtatwE2SAha
         Yftc0kMBCbm/A==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] tools/memory-model: Remove redundant initialization in litmus tests
Date:   Wed,  6 Jan 2021 09:36:37 -0800
Message-Id: <20210106173638.23741-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173548.GA23664@paulmck-ThinkPad-P72>
References: <20210106173548.GA23664@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

This is a revert of commit 1947bfcf81a9 ("tools/memory-model: Add types
to litmus tests") with conflict resolutions.

klitmus7 [1] is aware of default types of "int" and "int*".
It accepts litmus tests for herd7 without extra type info unless
non-"int" variables are referenced by an "exists", "locations",
or "filter" directive.

[1]: Tested with klitmus7 versions 7.49 or later.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus        | 4 +---
 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus        | 4 +---
 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus        | 4 +---
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus             | 4 +---
 .../litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus             | 5 +----
 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus   | 5 +----
 .../litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus        | 7 +------
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus            | 6 +-----
 .../ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus       | 6 +-----
 .../litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus            | 5 +----
 .../litmus-tests/LB+poacquireonce+pooncerelease.litmus             | 5 +----
 tools/memory-model/litmus-tests/LB+poonceonces.litmus              | 5 +----
 .../litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus       | 5 +----
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus     | 4 +---
 .../litmus-tests/MP+polockmbonce+poacquiresilsil.litmus            | 5 +----
 .../memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus | 5 +----
 tools/memory-model/litmus-tests/MP+polocks.litmus                  | 6 +-----
 tools/memory-model/litmus-tests/MP+poonceonces.litmus              | 5 +----
 .../litmus-tests/MP+pooncerelease+poacquireonce.litmus             | 5 +----
 tools/memory-model/litmus-tests/MP+porevlocks.litmus               | 6 +-----
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus          | 5 +----
 tools/memory-model/litmus-tests/R+poonceonces.litmus               | 5 +----
 .../litmus-tests/S+fencewmbonceonce+poacquireonce.litmus           | 5 +----
 tools/memory-model/litmus-tests/S+poonceonces.litmus               | 5 +----
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus         | 5 +----
 tools/memory-model/litmus-tests/SB+poonceonces.litmus              | 5 +----
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus  | 5 +----
 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus        | 5 +----
 .../litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus    | 5 +----
 .../litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus        | 7 +------
 .../litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus        | 7 +------
 .../Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus     | 6 +-----
 32 files changed, 32 insertions(+), 134 deletions(-)

diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 772544f..967f9f2 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRR+poonceonce+Once
  * reads from the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index 5faae98..4635739 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRW+poonceonce+Once
  * a given variable and a later write to that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index 77c9cc9..bb068c9 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoWR+poonceonce+Once
  * given variable and a later read from that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 85ef746..0d9f0a9 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -7,9 +7,7 @@ C CoWW+poonceonce
  * writes to the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index 87aa900..e729d27 100644
--- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+fencembonceonces+OnceOnce
  * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index f84022d..4b54dd6 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+poonceonces+OnceOnce
  * different process?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 398f624..094d58d 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -7,12 +7,7 @@ C ISA2+pooncelock+pooncelock+pombonce
  * (in P0() and P1()) is visible to external process P2().
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index 212a432..b321aa6 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -9,11 +9,7 @@ C ISA2+poonceonces
  * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 7afd856..025b046 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -11,11 +11,7 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
  * (AKA non-rf) link, so release-acquire is all that is needed.
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index c8a93c7..4727f5a 100644
--- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -11,10 +11,7 @@ C LB+fencembonceonce+ctrlonceonce
  * another control dependency and order would still be maintained.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 2fa0295..07b9904 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -8,10 +8,7 @@ C LB+poacquireonce+pooncerelease
  * to the other?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index 2107306..74c49cb 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -7,10 +7,7 @@ C LB+poonceonces
  * be prevented even with no explicit ordering?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index c5c168d..f8ca122 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -8,10 +8,7 @@ C MP+fencewmbonceonce+fencermbonceonce
  * is usually better to use smp_store_release() and smp_load_acquire().
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 20ff626..d84160b 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,9 +10,7 @@ C MP+onceassign+derefonce
  *)
 
 {
-	int *p=y;
-	int x;
-	int y=0;
+p=y;
 }
 
 P0(int *x, int **p) // Producer
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index 153917a..ba91cc6 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockmbonce+poacquiresilsil
  * executed before the lock was acquired (loosely speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index aad6439..a5ea3ed 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockonce+poacquiresilsil
  * speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 21cbca6..e6af05f 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -11,11 +11,7 @@ C MP+polocks
  * to see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 9f9769d..ba9c99c6 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -7,10 +7,7 @@ C MP+poonceonces
  * no ordering at all?
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index cbe28e7..f174bfe 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -8,10 +8,7 @@ C MP+pooncerelease+poacquireonce
  * pattern.
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 012041b..b959914 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -11,11 +11,7 @@ C MP+porevlocks
  * see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index af9463b..222a0b8 100644
--- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C R+fencembonceonces
  * cause the resulting test to be allowed.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index bcd5574e..5386f12 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -8,10 +8,7 @@ C R+poonceonces
  * store propagation delays.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index c36341d..1847982 100644
--- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -7,10 +7,7 @@ C S+fencewmbonceonce+poacquireonce
  * store against a subsequent store?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index 7775c23..8c9c2f8 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -9,10 +9,7 @@ C S+poonceonces
  * READ_ONCE(), is ordering preserved?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index 833cdfe..ed5fff1 100644
--- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C SB+fencembonceonces
  * suffice, but not much else.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index c92211e..10d5507 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -8,10 +8,7 @@ C SB+poonceonces
  * variable that the preceding process reads.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
index 84344b4..04a1660 100644
--- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -6,10 +6,7 @@ C SB+rfionceonce-poonceonces
  * This litmus test demonstrates that LKMM is not fully multicopy atomic.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index 4314947..6a2bc12 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -8,10 +8,7 @@ C WRC+poonceonces+Once
  * test has no ordering at all.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index 554999c..e994725 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -10,10 +10,7 @@ C WRC+pooncerelease+fencermbonceonce+Once
  * is A-cumulative in LKMM.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 265a95f..415248f 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -9,12 +9,7 @@ C Z6.0+pooncelock+poonceLock+pombonce
  * by CPUs not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index 0c9aea8..10a2aa0 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -8,12 +8,7 @@ C Z6.0+pooncelock+pooncelock+pombonce
  * seen as ordered by a third process not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index 661f9aa..88e70b8 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -14,11 +14,7 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
  * involving locking.)
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
-- 
2.9.5

