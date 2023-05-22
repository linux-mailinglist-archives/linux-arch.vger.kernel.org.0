Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA15170BE3D
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjEVM2t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjEVM1c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50DDBC5;
        Mon, 22 May 2023 05:25:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1808E1480;
        Mon, 22 May 2023 05:26:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E1053F59C;
        Mon, 22 May 2023 05:25:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 22/26] locking/atomic: scripts: simplify raw_atomic_long*() definitions
Date:   Mon, 22 May 2023 13:24:25 +0100
Message-Id: <20230522122429.1915021-23-mark.rutland@arm.com>
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

Currently, atomic-long is split into two sections, one defining the
raw_atomic_long_*() ops for CONFIG_64BIT, and one defining the raw
atomic_long_*() ops for !CONFIG_64BIT.

With many lines elided, this looks like:

| #ifdef CONFIG_64BIT
| ...
| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
|         return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
| }
| ...
| #else /* CONFIG_64BIT */
| ...
| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
|         return raw_atomic_try_cmpxchg(v, (int *)old, new);
| }
| ...
| #endif

The two definitions are spread far apart in the file, and duplicate the
prototype, making it hard to have a legible set of kerneldoc comments.

Make this simpler by defining the C prototype once, and writing the two
definitions inline. For example, the above becomes:

| static __always_inline bool
| raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
| {
| #ifdef CONFIG_64BIT
|         return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
| #else
|         return raw_atomic_try_cmpxchg(v, (int *)old, new);
| #endif
| }

As we now always have a single copy of the C prototype wrapping all the
potential definitions, we now have an obvious single location for kerneldoc
comments. As a bonus, both the script and the generated file are
somewhat shorter.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/atomic/atomic-long.h | 857 ++++++++++++-----------------
 scripts/atomic/gen-atomic-long.sh  |  27 +-
 2 files changed, 350 insertions(+), 534 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 92dc82ce1ce6d..63e0b4078ebd5 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -21,1030 +21,855 @@ typedef atomic_t atomic_long_t;
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
 #endif
 
-#ifdef CONFIG_64BIT
-
-static __always_inline long
-raw_atomic_long_read(const atomic_long_t *v)
-{
-	return raw_atomic64_read(v);
-}
-
-static __always_inline long
-raw_atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return raw_atomic64_read_acquire(v);
-}
-
-static __always_inline void
-raw_atomic_long_set(atomic_long_t *v, long i)
-{
-	raw_atomic64_set(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_set_release(atomic_long_t *v, long i)
-{
-	raw_atomic64_set_release(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_add(long i, atomic_long_t *v)
-{
-	raw_atomic64_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_sub(long i, atomic_long_t *v)
-{
-	raw_atomic64_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_inc(atomic_long_t *v)
-{
-	raw_atomic64_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_dec(atomic_long_t *v)
-{
-	raw_atomic64_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return raw_atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_and(long i, atomic_long_t *v)
-{
-	raw_atomic64_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_andnot(long i, atomic_long_t *v)
-{
-	raw_atomic64_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_or(long i, atomic_long_t *v)
-{
-	raw_atomic64_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_xor(long i, atomic_long_t *v)
-{
-	raw_atomic64_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_release(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return raw_atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return raw_atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return raw_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return raw_atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return raw_atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return raw_atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_acquire(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_release(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
-{
-	return raw_atomic64_add_negative_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return raw_atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return raw_atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return raw_atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return raw_atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return raw_atomic64_dec_unless_positive(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return raw_atomic64_dec_if_positive(v);
-}
-
-#else /* CONFIG_64BIT */
-
 static __always_inline long
 raw_atomic_long_read(const atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_read(v);
+#else
 	return raw_atomic_read(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_read_acquire(const atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_read_acquire(v);
+#else
 	return raw_atomic_read_acquire(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_set(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_set(v, i);
+#else
 	raw_atomic_set(v, i);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_set_release(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_set_release(v, i);
+#else
 	raw_atomic_set_release(v, i);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_add(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_add(i, v);
+#else
 	raw_atomic_add(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return(i, v);
+#else
 	return raw_atomic_add_return(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_acquire(i, v);
+#else
 	return raw_atomic_add_return_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_release(i, v);
+#else
 	return raw_atomic_add_return_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_return_relaxed(i, v);
+#else
 	return raw_atomic_add_return_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add(i, v);
+#else
 	return raw_atomic_fetch_add(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_acquire(i, v);
+#else
 	return raw_atomic_fetch_add_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_release(i, v);
+#else
 	return raw_atomic_fetch_add_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_relaxed(i, v);
+#else
 	return raw_atomic_fetch_add_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_sub(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_sub(i, v);
+#else
 	raw_atomic_sub(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return(i, v);
+#else
 	return raw_atomic_sub_return(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_acquire(i, v);
+#else
 	return raw_atomic_sub_return_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_release(i, v);
+#else
 	return raw_atomic_sub_return_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_return_relaxed(i, v);
+#else
 	return raw_atomic_sub_return_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub(i, v);
+#else
 	return raw_atomic_fetch_sub(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_acquire(i, v);
+#else
 	return raw_atomic_fetch_sub_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_release(i, v);
+#else
 	return raw_atomic_fetch_sub_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_sub_relaxed(i, v);
+#else
 	return raw_atomic_fetch_sub_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_inc(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_inc(v);
+#else
 	raw_atomic_inc(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return(v);
+#else
 	return raw_atomic_inc_return(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_acquire(v);
+#else
 	return raw_atomic_inc_return_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_release(v);
+#else
 	return raw_atomic_inc_return_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_return_relaxed(v);
+#else
 	return raw_atomic_inc_return_relaxed(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc(v);
+#else
 	return raw_atomic_fetch_inc(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_acquire(v);
+#else
 	return raw_atomic_fetch_inc_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_release(v);
+#else
 	return raw_atomic_fetch_inc_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_inc_relaxed(v);
+#else
 	return raw_atomic_fetch_inc_relaxed(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_dec(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_dec(v);
+#else
 	raw_atomic_dec(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return(v);
+#else
 	return raw_atomic_dec_return(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_acquire(v);
+#else
 	return raw_atomic_dec_return_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_release(v);
+#else
 	return raw_atomic_dec_return_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_return_relaxed(v);
+#else
 	return raw_atomic_dec_return_relaxed(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec(v);
+#else
 	return raw_atomic_fetch_dec(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_acquire(v);
+#else
 	return raw_atomic_fetch_dec_acquire(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_release(v);
+#else
 	return raw_atomic_fetch_dec_release(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_dec_relaxed(v);
+#else
 	return raw_atomic_fetch_dec_relaxed(v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_and(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_and(i, v);
+#else
 	raw_atomic_and(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and(i, v);
+#else
 	return raw_atomic_fetch_and(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_acquire(i, v);
+#else
 	return raw_atomic_fetch_and_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_release(i, v);
+#else
 	return raw_atomic_fetch_and_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_and_relaxed(i, v);
+#else
 	return raw_atomic_fetch_and_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_andnot(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_andnot(i, v);
+#else
 	raw_atomic_andnot(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot(i, v);
+#else
 	return raw_atomic_fetch_andnot(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_acquire(i, v);
+#else
 	return raw_atomic_fetch_andnot_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_release(i, v);
+#else
 	return raw_atomic_fetch_andnot_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_andnot_relaxed(i, v);
+#else
 	return raw_atomic_fetch_andnot_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_or(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_or(i, v);
+#else
 	raw_atomic_or(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or(i, v);
+#else
 	return raw_atomic_fetch_or(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_acquire(i, v);
+#else
 	return raw_atomic_fetch_or_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_release(i, v);
+#else
 	return raw_atomic_fetch_or_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_or_relaxed(i, v);
+#else
 	return raw_atomic_fetch_or_relaxed(i, v);
+#endif
 }
 
 static __always_inline void
 raw_atomic_long_xor(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	raw_atomic64_xor(i, v);
+#else
 	raw_atomic_xor(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor(i, v);
+#else
 	return raw_atomic_fetch_xor(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_acquire(i, v);
+#else
 	return raw_atomic_fetch_xor_acquire(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_release(i, v);
+#else
 	return raw_atomic_fetch_xor_release(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_xor_relaxed(i, v);
+#else
 	return raw_atomic_fetch_xor_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg(v, i);
+#else
 	return raw_atomic_xchg(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_acquire(v, i);
+#else
 	return raw_atomic_xchg_acquire(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_release(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_release(v, i);
+#else
 	return raw_atomic_xchg_release(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_xchg_relaxed(v, i);
+#else
 	return raw_atomic_xchg_relaxed(v, i);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg(v, old, new);
+#else
 	return raw_atomic_cmpxchg(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_acquire(v, old, new);
+#else
 	return raw_atomic_cmpxchg_acquire(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_release(v, old, new);
+#else
 	return raw_atomic_cmpxchg_release(v, old, new);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_cmpxchg_relaxed(v, old, new);
+#else
 	return raw_atomic_cmpxchg_relaxed(v, old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_acquire(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_release(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
+#else
 	return raw_atomic_try_cmpxchg_relaxed(v, (int *)old, new);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_sub_and_test(i, v);
+#else
 	return raw_atomic_sub_and_test(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_dec_and_test(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_and_test(v);
+#else
 	return raw_atomic_dec_and_test(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_and_test(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_and_test(v);
+#else
 	return raw_atomic_inc_and_test(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative(i, v);
+#else
 	return raw_atomic_add_negative(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_acquire(i, v);
+#else
 	return raw_atomic_add_negative_acquire(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_release(i, v);
+#else
 	return raw_atomic_add_negative_release(i, v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_negative_relaxed(i, v);
+#else
 	return raw_atomic_add_negative_relaxed(i, v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_fetch_add_unless(v, a, u);
+#else
 	return raw_atomic_fetch_add_unless(v, a, u);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_add_unless(v, a, u);
+#else
 	return raw_atomic_add_unless(v, a, u);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_not_zero(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_not_zero(v);
+#else
 	return raw_atomic_inc_not_zero(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_inc_unless_negative(v);
+#else
 	return raw_atomic_inc_unless_negative(v);
+#endif
 }
 
 static __always_inline bool
 raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_unless_positive(v);
+#else
 	return raw_atomic_dec_unless_positive(v);
+#endif
 }
 
 static __always_inline long
 raw_atomic_long_dec_if_positive(atomic_long_t *v)
 {
+#ifdef CONFIG_64BIT
+	return raw_atomic64_dec_if_positive(v);
+#else
 	return raw_atomic_dec_if_positive(v);
+#endif
 }
 
-#endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 108784846d3bbbb201b8dabe621c5dc30b216206
+// ad09f849db0db5b30c82e497eeb9056a394c5f22
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 13832171f7219..af27a71b37ef1 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -32,7 +32,7 @@ gen_args_cast()
 	done
 }
 
-#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+#gen_proto_order_variant(meta, pfx, name, sfx, order, arg...)
 gen_proto_order_variant()
 {
 	local meta="$1"; shift
@@ -40,21 +40,24 @@ gen_proto_order_variant()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
-	local atomic="$1"; shift
-	local int="$1"; shift
 
 	local atomicname="${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "long")"
 	local params="$(gen_params "long" "atomic_long" "$@")"
-	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
+	local argscast_32="$(gen_args_cast "int" "atomic" "$@")"
+	local argscast_64="$(gen_args_cast "s64" "atomic64" "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
 static __always_inline ${ret}
 raw_atomic_long_${atomicname}(${params})
 {
-	${retstmt}raw_${atomic}_${atomicname}(${argscast});
+#ifdef CONFIG_64BIT
+	${retstmt}raw_atomic64_${atomicname}(${argscast_64});
+#else
+	${retstmt}raw_atomic_${atomicname}(${argscast_32});
+#endif
 }
 
 EOF
@@ -84,24 +87,12 @@ typedef atomic_t atomic_long_t;
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
 #endif
 
-#ifdef CONFIG_64BIT
-
-EOF
-
-grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
-done
-
-cat <<EOF
-#else /* CONFIG_64BIT */
-
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" ${args}
 done
 
 cat <<EOF
-#endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
 EOF
-- 
2.30.2

