Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCCD70BE03
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjEVM07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjEVM0e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28BA26A2;
        Mon, 22 May 2023 05:24:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF111480;
        Mon, 22 May 2023 05:25:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 163BB3F59C;
        Mon, 22 May 2023 05:24:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 02/26] locking/atomic: remove fallback comments
Date:   Mon, 22 May 2023 13:24:05 +0100
Message-Id: <20230522122429.1915021-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently a subset of the fallback templates have kerneldoc comments,
resulting in a haphazard set of generated kerneldoc comments as only
some operations have fallback templates to begin with.

We'd like to generate more consistent kerneldoc comments, and to do so
we'll need to restructure the way the fallback code is generated.

To minimize churn and to make it easier to restructure the fallback
code, this patch removes the existing kerneldoc comments from the
fallback templates. We can add new kerneldoc comments in subsequent
patches.

Aside from generated documentation being reduced, there should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 166 +-------------------
 scripts/atomic/fallbacks/add_negative       |   8 -
 scripts/atomic/fallbacks/add_unless         |   9 --
 scripts/atomic/fallbacks/dec_and_test       |   8 -
 scripts/atomic/fallbacks/fetch_add_unless   |   9 --
 scripts/atomic/fallbacks/inc_and_test       |   8 -
 scripts/atomic/fallbacks/inc_not_zero       |   7 -
 scripts/atomic/fallbacks/sub_and_test       |   9 --
 8 files changed, 1 insertion(+), 223 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 1722ddb6f17e0..3ce4cb5e790c5 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1272,15 +1272,6 @@ arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif /* arch_atomic_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic_sub_and_test
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -1290,14 +1281,6 @@ arch_atomic_sub_and_test(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_dec_and_test
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_atomic_dec_and_test(atomic_t *v)
 {
@@ -1307,14 +1290,6 @@ arch_atomic_dec_and_test(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_and_test
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic_inc_and_test(atomic_t *v)
 {
@@ -1331,14 +1306,6 @@ arch_atomic_inc_and_test(atomic_t *v)
 #endif /* arch_atomic_add_negative */
 
 #ifndef arch_atomic_add_negative
-/**
- * arch_atomic_add_negative - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative(int i, atomic_t *v)
 {
@@ -1348,14 +1315,6 @@ arch_atomic_add_negative(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_acquire
-/**
- * arch_atomic_add_negative_acquire - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_acquire(int i, atomic_t *v)
 {
@@ -1365,14 +1324,6 @@ arch_atomic_add_negative_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_release
-/**
- * arch_atomic_add_negative_release - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_release(int i, atomic_t *v)
 {
@@ -1382,14 +1333,6 @@ arch_atomic_add_negative_release(int i, atomic_t *v)
 #endif
 
 #ifndef arch_atomic_add_negative_relaxed
-/**
- * arch_atomic_add_negative_relaxed - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
@@ -1437,15 +1380,6 @@ arch_atomic_add_negative(int i, atomic_t *v)
 #endif /* arch_atomic_add_negative_relaxed */
 
 #ifndef arch_atomic_fetch_add_unless
-/**
- * arch_atomic_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline int
 arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
@@ -1462,15 +1396,6 @@ arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #ifndef arch_atomic_add_unless
-/**
- * arch_atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -1480,13 +1405,6 @@ arch_atomic_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #ifndef arch_atomic_inc_not_zero
-/**
- * arch_atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_atomic_inc_not_zero(atomic_t *v)
 {
@@ -2488,15 +2406,6 @@ arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif /* arch_atomic64_try_cmpxchg_relaxed */
 
 #ifndef arch_atomic64_sub_and_test
-/**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
@@ -2506,14 +2415,6 @@ arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_dec_and_test
-/**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_atomic64_dec_and_test(atomic64_t *v)
 {
@@ -2523,14 +2424,6 @@ arch_atomic64_dec_and_test(atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_inc_and_test
-/**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_atomic64_inc_and_test(atomic64_t *v)
 {
@@ -2547,14 +2440,6 @@ arch_atomic64_inc_and_test(atomic64_t *v)
 #endif /* arch_atomic64_add_negative */
 
 #ifndef arch_atomic64_add_negative
-/**
- * arch_atomic64_add_negative - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
@@ -2564,14 +2449,6 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_acquire
-/**
- * arch_atomic64_add_negative_acquire - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 {
@@ -2581,14 +2458,6 @@ arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_release
-/**
- * arch_atomic64_add_negative_release - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 {
@@ -2598,14 +2467,6 @@ arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef arch_atomic64_add_negative_relaxed
-/**
- * arch_atomic64_add_negative_relaxed - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
@@ -2653,15 +2514,6 @@ arch_atomic64_add_negative(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_add_negative_relaxed */
 
 #ifndef arch_atomic64_fetch_add_unless
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline s64
 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2678,15 +2530,6 @@ arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 
 #ifndef arch_atomic64_add_unless
-/**
- * arch_atomic64_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
@@ -2696,13 +2539,6 @@ arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 #endif
 
 #ifndef arch_atomic64_inc_not_zero
-/**
- * arch_atomic64_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -2761,4 +2597,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 52dfc6fe4a2e7234bbd2aa3e16a377c1db793a53
+// 9f0fd6ed53267c6ec64e36cd18e6fd8df57ea277
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e5980abf5904e..d0bd2dfbb244c 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_add_negative${order} - Add and test if negative
- * @i: integer value to add
- * @v: pointer of type ${atomic}_t
- *
- * Atomically adds @i to @v and returns true if the result is negative,
- * or false when the result is greater than or equal to zero.
- */
 static __always_inline bool
 arch_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 9e5159c2ccfc8..cf79b9da38dbb 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,13 +1,4 @@
 cat << EOF
-/**
- * arch_${atomic}_add_unless - add unless the number is already a given value
- * @v: pointer of type ${atomic}_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
 static __always_inline bool
 arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 8549f359bd0ef..3f6b6a8b47733 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_dec_and_test - decrement and test
- * @v: pointer of type ${atomic}_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool
 arch_${atomic}_dec_and_test(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 68ce13c8b9dad..81d2834f03d23 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,13 +1,4 @@
 cat << EOF
-/**
- * arch_${atomic}_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type ${atomic}_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
 static __always_inline ${int}
 arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 0cf23fe1efb85..c726a6d0634d3 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,12 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_inc_and_test - increment and test
- * @v: pointer of type ${atomic}_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_${atomic}_inc_and_test(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index ed8a1f5626675..97603591aac2a 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,11 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_inc_not_zero - increment unless the number is zero
- * @v: pointer of type ${atomic}_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
 static __always_inline bool
 arch_${atomic}_inc_not_zero(${atomic}_t *v)
 {
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 260f37341c888..da8a049c9b02b 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,13 +1,4 @@
 cat <<EOF
-/**
- * arch_${atomic}_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type ${atomic}_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool
 arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-- 
2.30.2

