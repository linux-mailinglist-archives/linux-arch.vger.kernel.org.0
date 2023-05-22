Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC770BE38
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjEVM2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEVM13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D1E9132;
        Mon, 22 May 2023 05:25:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D461516;
        Mon, 22 May 2023 05:26:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 371B23F59C;
        Mon, 22 May 2023 05:25:23 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 19/26] locking/atomic: scripts: build raw_atomic_long*() directly
Date:   Mon, 22 May 2023 13:24:22 +0100
Message-Id: <20230522122429.1915021-20-mark.rutland@arm.com>
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

Now that arch_atomic*() usage is limited to the atomic headers, we no
longer have any users of arch_atomic_long_*(), and can generate
raw_atomic_long_*() directly.

Generate the raw_atomic_long_*() ops directly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/atomic.h             |   2 +-
 include/linux/atomic/atomic-long.h | 682 ++++++++++++++---------------
 include/linux/atomic/atomic-raw.h  | 512 +---------------------
 scripts/atomic/gen-atomic-long.sh  |   4 +-
 scripts/atomic/gen-atomic-raw.sh   |   4 -
 5 files changed, 345 insertions(+), 859 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 127f5dc63a7df..296cfae0389fe 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -78,8 +78,8 @@
 })
 
 #include <linux/atomic/atomic-arch-fallback.h>
-#include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-raw.h>
+#include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>
 
 #endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 2fc51ba66bebd..92dc82ce1ce6d 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -24,1027 +24,1027 @@ typedef atomic_t atomic_long_t;
 #ifdef CONFIG_64BIT
 
 static __always_inline long
-arch_atomic_long_read(const atomic_long_t *v)
+raw_atomic_long_read(const atomic_long_t *v)
 {
-	return arch_atomic64_read(v);
+	return raw_atomic64_read(v);
 }
 
 static __always_inline long
-arch_atomic_long_read_acquire(const atomic_long_t *v)
+raw_atomic_long_read_acquire(const atomic_long_t *v)
 {
-	return arch_atomic64_read_acquire(v);
+	return raw_atomic64_read_acquire(v);
 }
 
 static __always_inline void
-arch_atomic_long_set(atomic_long_t *v, long i)
+raw_atomic_long_set(atomic_long_t *v, long i)
 {
-	arch_atomic64_set(v, i);
+	raw_atomic64_set(v, i);
 }
 
 static __always_inline void
-arch_atomic_long_set_release(atomic_long_t *v, long i)
+raw_atomic_long_set_release(atomic_long_t *v, long i)
 {
-	arch_atomic64_set_release(v, i);
+	raw_atomic64_set_release(v, i);
 }
 
 static __always_inline void
-arch_atomic_long_add(long i, atomic_long_t *v)
+raw_atomic_long_add(long i, atomic_long_t *v)
 {
-	arch_atomic64_add(i, v);
+	raw_atomic64_add(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return(long i, atomic_long_t *v)
+raw_atomic_long_add_return(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_return(i, v);
+	return raw_atomic64_add_return(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_acquire(long i, atomic_long_t *v)
+raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_return_acquire(i, v);
+	return raw_atomic64_add_return_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_release(long i, atomic_long_t *v)
+raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_return_release(i, v);
+	return raw_atomic64_add_return_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_return_relaxed(i, v);
+	return raw_atomic64_add_return_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_add(i, v);
+	return raw_atomic64_fetch_add(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_add_acquire(i, v);
+	return raw_atomic64_fetch_add_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_add_release(i, v);
+	return raw_atomic64_fetch_add_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_add_relaxed(i, v);
+	return raw_atomic64_fetch_add_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_sub(long i, atomic_long_t *v)
+raw_atomic_long_sub(long i, atomic_long_t *v)
 {
-	arch_atomic64_sub(i, v);
+	raw_atomic64_sub(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return(long i, atomic_long_t *v)
+raw_atomic_long_sub_return(long i, atomic_long_t *v)
 {
-	return arch_atomic64_sub_return(i, v);
+	return raw_atomic64_sub_return(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_sub_return_acquire(i, v);
+	return raw_atomic64_sub_return_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_release(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_sub_return_release(i, v);
+	return raw_atomic64_sub_return_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_sub_return_relaxed(i, v);
+	return raw_atomic64_sub_return_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_sub(i, v);
+	return raw_atomic64_fetch_sub(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_sub_acquire(i, v);
+	return raw_atomic64_fetch_sub_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_sub_release(i, v);
+	return raw_atomic64_fetch_sub_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_sub_relaxed(i, v);
+	return raw_atomic64_fetch_sub_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_inc(atomic_long_t *v)
+raw_atomic_long_inc(atomic_long_t *v)
 {
-	arch_atomic64_inc(v);
+	raw_atomic64_inc(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return(atomic_long_t *v)
+raw_atomic_long_inc_return(atomic_long_t *v)
 {
-	return arch_atomic64_inc_return(v);
+	return raw_atomic64_inc_return(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_acquire(atomic_long_t *v)
+raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 {
-	return arch_atomic64_inc_return_acquire(v);
+	return raw_atomic64_inc_return_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_release(atomic_long_t *v)
+raw_atomic_long_inc_return_release(atomic_long_t *v)
 {
-	return arch_atomic64_inc_return_release(v);
+	return raw_atomic64_inc_return_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_relaxed(atomic_long_t *v)
+raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
-	return arch_atomic64_inc_return_relaxed(v);
+	return raw_atomic64_inc_return_relaxed(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc(atomic_long_t *v)
+raw_atomic_long_fetch_inc(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_inc(v);
+	return raw_atomic64_fetch_inc(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_acquire(atomic_long_t *v)
+raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_inc_acquire(v);
+	return raw_atomic64_fetch_inc_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_release(atomic_long_t *v)
+raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_inc_release(v);
+	return raw_atomic64_fetch_inc_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_inc_relaxed(v);
+	return raw_atomic64_fetch_inc_relaxed(v);
 }
 
 static __always_inline void
-arch_atomic_long_dec(atomic_long_t *v)
+raw_atomic_long_dec(atomic_long_t *v)
 {
-	arch_atomic64_dec(v);
+	raw_atomic64_dec(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return(atomic_long_t *v)
+raw_atomic_long_dec_return(atomic_long_t *v)
 {
-	return arch_atomic64_dec_return(v);
+	return raw_atomic64_dec_return(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_acquire(atomic_long_t *v)
+raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 {
-	return arch_atomic64_dec_return_acquire(v);
+	return raw_atomic64_dec_return_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_release(atomic_long_t *v)
+raw_atomic_long_dec_return_release(atomic_long_t *v)
 {
-	return arch_atomic64_dec_return_release(v);
+	return raw_atomic64_dec_return_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_relaxed(atomic_long_t *v)
+raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
-	return arch_atomic64_dec_return_relaxed(v);
+	return raw_atomic64_dec_return_relaxed(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec(atomic_long_t *v)
+raw_atomic_long_fetch_dec(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_dec(v);
+	return raw_atomic64_fetch_dec(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_acquire(atomic_long_t *v)
+raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_dec_acquire(v);
+	return raw_atomic64_fetch_dec_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_release(atomic_long_t *v)
+raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_dec_release(v);
+	return raw_atomic64_fetch_dec_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
-	return arch_atomic64_fetch_dec_relaxed(v);
+	return raw_atomic64_fetch_dec_relaxed(v);
 }
 
 static __always_inline void
-arch_atomic_long_and(long i, atomic_long_t *v)
+raw_atomic_long_and(long i, atomic_long_t *v)
 {
-	arch_atomic64_and(i, v);
+	raw_atomic64_and(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_and(i, v);
+	return raw_atomic64_fetch_and(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_and_acquire(i, v);
+	return raw_atomic64_fetch_and_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_and_release(i, v);
+	return raw_atomic64_fetch_and_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_and_relaxed(i, v);
+	return raw_atomic64_fetch_and_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_andnot(long i, atomic_long_t *v)
+raw_atomic_long_andnot(long i, atomic_long_t *v)
 {
-	arch_atomic64_andnot(i, v);
+	raw_atomic64_andnot(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_andnot(i, v);
+	return raw_atomic64_fetch_andnot(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_andnot_acquire(i, v);
+	return raw_atomic64_fetch_andnot_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_andnot_release(i, v);
+	return raw_atomic64_fetch_andnot_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
+	return raw_atomic64_fetch_andnot_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_or(long i, atomic_long_t *v)
+raw_atomic_long_or(long i, atomic_long_t *v)
 {
-	arch_atomic64_or(i, v);
+	raw_atomic64_or(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_or(i, v);
+	return raw_atomic64_fetch_or(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_or_acquire(i, v);
+	return raw_atomic64_fetch_or_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_or_release(i, v);
+	return raw_atomic64_fetch_or_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_or_relaxed(i, v);
+	return raw_atomic64_fetch_or_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_xor(long i, atomic_long_t *v)
+raw_atomic_long_xor(long i, atomic_long_t *v)
 {
-	arch_atomic64_xor(i, v);
+	raw_atomic64_xor(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_xor(i, v);
+	return raw_atomic64_fetch_xor(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_xor_acquire(i, v);
+	return raw_atomic64_fetch_xor_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_xor_release(i, v);
+	return raw_atomic64_fetch_xor_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_fetch_xor_relaxed(i, v);
+	return raw_atomic64_fetch_xor_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_xchg(atomic_long_t *v, long i)
+raw_atomic_long_xchg(atomic_long_t *v, long i)
 {
-	return arch_atomic64_xchg(v, i);
+	return raw_atomic64_xchg(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
-	return arch_atomic64_xchg_acquire(v, i);
+	return raw_atomic64_xchg_acquire(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_release(atomic_long_t *v, long i)
+raw_atomic_long_xchg_release(atomic_long_t *v, long i)
 {
-	return arch_atomic64_xchg_release(v, i);
+	return raw_atomic64_xchg_release(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
-	return arch_atomic64_xchg_relaxed(v, i);
+	return raw_atomic64_xchg_relaxed(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic64_cmpxchg(v, old, new);
+	return raw_atomic64_cmpxchg(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic64_cmpxchg_acquire(v, old, new);
+	return raw_atomic64_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic64_cmpxchg_release(v, old, new);
+	return raw_atomic64_cmpxchg_release(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+	return raw_atomic64_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic64_try_cmpxchg(v, (s64 *)old, new);
+	return raw_atomic64_try_cmpxchg(v, (s64 *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
+	return raw_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
+	return raw_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
+	return raw_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_sub_and_test(long i, atomic_long_t *v)
+raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
-	return arch_atomic64_sub_and_test(i, v);
+	return raw_atomic64_sub_and_test(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_dec_and_test(atomic_long_t *v)
+raw_atomic_long_dec_and_test(atomic_long_t *v)
 {
-	return arch_atomic64_dec_and_test(v);
+	return raw_atomic64_dec_and_test(v);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_and_test(atomic_long_t *v)
+raw_atomic_long_inc_and_test(atomic_long_t *v)
 {
-	return arch_atomic64_inc_and_test(v);
+	return raw_atomic64_inc_and_test(v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative(long i, atomic_long_t *v)
+raw_atomic_long_add_negative(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_negative(i, v);
+	return raw_atomic64_add_negative(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_negative_acquire(i, v);
+	return raw_atomic64_add_negative_acquire(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_release(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_negative_release(i, v);
+	return raw_atomic64_add_negative_release(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic64_add_negative_relaxed(i, v);
+	return raw_atomic64_add_negative_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
-	return arch_atomic64_fetch_add_unless(v, a, u);
+	return raw_atomic64_fetch_add_unless(v, a, u);
 }
 
 static __always_inline bool
-arch_atomic_long_add_unless(atomic_long_t *v, long a, long u)
+raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
-	return arch_atomic64_add_unless(v, a, u);
+	return raw_atomic64_add_unless(v, a, u);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_not_zero(atomic_long_t *v)
+raw_atomic_long_inc_not_zero(atomic_long_t *v)
 {
-	return arch_atomic64_inc_not_zero(v);
+	return raw_atomic64_inc_not_zero(v);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_unless_negative(atomic_long_t *v)
+raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 {
-	return arch_atomic64_inc_unless_negative(v);
+	return raw_atomic64_inc_unless_negative(v);
 }
 
 static __always_inline bool
-arch_atomic_long_dec_unless_positive(atomic_long_t *v)
+raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 {
-	return arch_atomic64_dec_unless_positive(v);
+	return raw_atomic64_dec_unless_positive(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_if_positive(atomic_long_t *v)
+raw_atomic_long_dec_if_positive(atomic_long_t *v)
 {
-	return arch_atomic64_dec_if_positive(v);
+	return raw_atomic64_dec_if_positive(v);
 }
 
 #else /* CONFIG_64BIT */
 
 static __always_inline long
-arch_atomic_long_read(const atomic_long_t *v)
+raw_atomic_long_read(const atomic_long_t *v)
 {
-	return arch_atomic_read(v);
+	return raw_atomic_read(v);
 }
 
 static __always_inline long
-arch_atomic_long_read_acquire(const atomic_long_t *v)
+raw_atomic_long_read_acquire(const atomic_long_t *v)
 {
-	return arch_atomic_read_acquire(v);
+	return raw_atomic_read_acquire(v);
 }
 
 static __always_inline void
-arch_atomic_long_set(atomic_long_t *v, long i)
+raw_atomic_long_set(atomic_long_t *v, long i)
 {
-	arch_atomic_set(v, i);
+	raw_atomic_set(v, i);
 }
 
 static __always_inline void
-arch_atomic_long_set_release(atomic_long_t *v, long i)
+raw_atomic_long_set_release(atomic_long_t *v, long i)
 {
-	arch_atomic_set_release(v, i);
+	raw_atomic_set_release(v, i);
 }
 
 static __always_inline void
-arch_atomic_long_add(long i, atomic_long_t *v)
+raw_atomic_long_add(long i, atomic_long_t *v)
 {
-	arch_atomic_add(i, v);
+	raw_atomic_add(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return(long i, atomic_long_t *v)
+raw_atomic_long_add_return(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_return(i, v);
+	return raw_atomic_add_return(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_acquire(long i, atomic_long_t *v)
+raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_return_acquire(i, v);
+	return raw_atomic_add_return_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_release(long i, atomic_long_t *v)
+raw_atomic_long_add_return_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_return_release(i, v);
+	return raw_atomic_add_return_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_return_relaxed(i, v);
+	return raw_atomic_add_return_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_add(i, v);
+	return raw_atomic_fetch_add(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_add_acquire(i, v);
+	return raw_atomic_fetch_add_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_add_release(i, v);
+	return raw_atomic_fetch_add_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_add_relaxed(i, v);
+	return raw_atomic_fetch_add_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_sub(long i, atomic_long_t *v)
+raw_atomic_long_sub(long i, atomic_long_t *v)
 {
-	arch_atomic_sub(i, v);
+	raw_atomic_sub(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return(long i, atomic_long_t *v)
+raw_atomic_long_sub_return(long i, atomic_long_t *v)
 {
-	return arch_atomic_sub_return(i, v);
+	return raw_atomic_sub_return(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_sub_return_acquire(i, v);
+	return raw_atomic_sub_return_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_release(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_sub_return_release(i, v);
+	return raw_atomic_sub_return_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_sub_return_relaxed(i, v);
+	return raw_atomic_sub_return_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_sub(i, v);
+	return raw_atomic_fetch_sub(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_sub_acquire(i, v);
+	return raw_atomic_fetch_sub_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_sub_release(i, v);
+	return raw_atomic_fetch_sub_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_sub_relaxed(i, v);
+	return raw_atomic_fetch_sub_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_inc(atomic_long_t *v)
+raw_atomic_long_inc(atomic_long_t *v)
 {
-	arch_atomic_inc(v);
+	raw_atomic_inc(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return(atomic_long_t *v)
+raw_atomic_long_inc_return(atomic_long_t *v)
 {
-	return arch_atomic_inc_return(v);
+	return raw_atomic_inc_return(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_acquire(atomic_long_t *v)
+raw_atomic_long_inc_return_acquire(atomic_long_t *v)
 {
-	return arch_atomic_inc_return_acquire(v);
+	return raw_atomic_inc_return_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_release(atomic_long_t *v)
+raw_atomic_long_inc_return_release(atomic_long_t *v)
 {
-	return arch_atomic_inc_return_release(v);
+	return raw_atomic_inc_return_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_inc_return_relaxed(atomic_long_t *v)
+raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
-	return arch_atomic_inc_return_relaxed(v);
+	return raw_atomic_inc_return_relaxed(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc(atomic_long_t *v)
+raw_atomic_long_fetch_inc(atomic_long_t *v)
 {
-	return arch_atomic_fetch_inc(v);
+	return raw_atomic_fetch_inc(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_acquire(atomic_long_t *v)
+raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
-	return arch_atomic_fetch_inc_acquire(v);
+	return raw_atomic_fetch_inc_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_release(atomic_long_t *v)
+raw_atomic_long_fetch_inc_release(atomic_long_t *v)
 {
-	return arch_atomic_fetch_inc_release(v);
+	return raw_atomic_fetch_inc_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
-	return arch_atomic_fetch_inc_relaxed(v);
+	return raw_atomic_fetch_inc_relaxed(v);
 }
 
 static __always_inline void
-arch_atomic_long_dec(atomic_long_t *v)
+raw_atomic_long_dec(atomic_long_t *v)
 {
-	arch_atomic_dec(v);
+	raw_atomic_dec(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return(atomic_long_t *v)
+raw_atomic_long_dec_return(atomic_long_t *v)
 {
-	return arch_atomic_dec_return(v);
+	return raw_atomic_dec_return(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_acquire(atomic_long_t *v)
+raw_atomic_long_dec_return_acquire(atomic_long_t *v)
 {
-	return arch_atomic_dec_return_acquire(v);
+	return raw_atomic_dec_return_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_release(atomic_long_t *v)
+raw_atomic_long_dec_return_release(atomic_long_t *v)
 {
-	return arch_atomic_dec_return_release(v);
+	return raw_atomic_dec_return_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_return_relaxed(atomic_long_t *v)
+raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
-	return arch_atomic_dec_return_relaxed(v);
+	return raw_atomic_dec_return_relaxed(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec(atomic_long_t *v)
+raw_atomic_long_fetch_dec(atomic_long_t *v)
 {
-	return arch_atomic_fetch_dec(v);
+	return raw_atomic_fetch_dec(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_acquire(atomic_long_t *v)
+raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
-	return arch_atomic_fetch_dec_acquire(v);
+	return raw_atomic_fetch_dec_acquire(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_release(atomic_long_t *v)
+raw_atomic_long_fetch_dec_release(atomic_long_t *v)
 {
-	return arch_atomic_fetch_dec_release(v);
+	return raw_atomic_fetch_dec_release(v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
-	return arch_atomic_fetch_dec_relaxed(v);
+	return raw_atomic_fetch_dec_relaxed(v);
 }
 
 static __always_inline void
-arch_atomic_long_and(long i, atomic_long_t *v)
+raw_atomic_long_and(long i, atomic_long_t *v)
 {
-	arch_atomic_and(i, v);
+	raw_atomic_and(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_and(i, v);
+	return raw_atomic_fetch_and(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_and_acquire(i, v);
+	return raw_atomic_fetch_and_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_and_release(i, v);
+	return raw_atomic_fetch_and_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_and_relaxed(i, v);
+	return raw_atomic_fetch_and_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_andnot(long i, atomic_long_t *v)
+raw_atomic_long_andnot(long i, atomic_long_t *v)
 {
-	arch_atomic_andnot(i, v);
+	raw_atomic_andnot(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_andnot(i, v);
+	return raw_atomic_fetch_andnot(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_andnot_acquire(i, v);
+	return raw_atomic_fetch_andnot_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_andnot_release(i, v);
+	return raw_atomic_fetch_andnot_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_andnot_relaxed(i, v);
+	return raw_atomic_fetch_andnot_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_or(long i, atomic_long_t *v)
+raw_atomic_long_or(long i, atomic_long_t *v)
 {
-	arch_atomic_or(i, v);
+	raw_atomic_or(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_or(i, v);
+	return raw_atomic_fetch_or(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_or_acquire(i, v);
+	return raw_atomic_fetch_or_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_or_release(i, v);
+	return raw_atomic_fetch_or_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_or_relaxed(i, v);
+	return raw_atomic_fetch_or_relaxed(i, v);
 }
 
 static __always_inline void
-arch_atomic_long_xor(long i, atomic_long_t *v)
+raw_atomic_long_xor(long i, atomic_long_t *v)
 {
-	arch_atomic_xor(i, v);
+	raw_atomic_xor(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_xor(i, v);
+	return raw_atomic_fetch_xor(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_xor_acquire(i, v);
+	return raw_atomic_fetch_xor_acquire(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_xor_release(i, v);
+	return raw_atomic_fetch_xor_release(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_fetch_xor_relaxed(i, v);
+	return raw_atomic_fetch_xor_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_xchg(atomic_long_t *v, long i)
+raw_atomic_long_xchg(atomic_long_t *v, long i)
 {
-	return arch_atomic_xchg(v, i);
+	return raw_atomic_xchg(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
-	return arch_atomic_xchg_acquire(v, i);
+	return raw_atomic_xchg_acquire(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_release(atomic_long_t *v, long i)
+raw_atomic_long_xchg_release(atomic_long_t *v, long i)
 {
-	return arch_atomic_xchg_release(v, i);
+	return raw_atomic_xchg_release(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
-	return arch_atomic_xchg_relaxed(v, i);
+	return raw_atomic_xchg_relaxed(v, i);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic_cmpxchg(v, old, new);
+	return raw_atomic_cmpxchg(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic_cmpxchg_acquire(v, old, new);
+	return raw_atomic_cmpxchg_acquire(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic_cmpxchg_release(v, old, new);
+	return raw_atomic_cmpxchg_release(v, old, new);
 }
 
 static __always_inline long
-arch_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
+	return raw_atomic_cmpxchg_relaxed(v, old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic_try_cmpxchg(v, (int *)old, new);
+	return raw_atomic_try_cmpxchg(v, (int *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic_try_cmpxchg_acquire(v, (int *)old, new);
+	return raw_atomic_try_cmpxchg_acquire(v, (int *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic_try_cmpxchg_release(v, (int *)old, new);
+	return raw_atomic_try_cmpxchg_release(v, (int *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
-	return arch_atomic_try_cmpxchg_relaxed(v, (int *)old, new);
+	return raw_atomic_try_cmpxchg_relaxed(v, (int *)old, new);
 }
 
 static __always_inline bool
-arch_atomic_long_sub_and_test(long i, atomic_long_t *v)
+raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
-	return arch_atomic_sub_and_test(i, v);
+	return raw_atomic_sub_and_test(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_dec_and_test(atomic_long_t *v)
+raw_atomic_long_dec_and_test(atomic_long_t *v)
 {
-	return arch_atomic_dec_and_test(v);
+	return raw_atomic_dec_and_test(v);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_and_test(atomic_long_t *v)
+raw_atomic_long_inc_and_test(atomic_long_t *v)
 {
-	return arch_atomic_inc_and_test(v);
+	return raw_atomic_inc_and_test(v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative(long i, atomic_long_t *v)
+raw_atomic_long_add_negative(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_negative(i, v);
+	return raw_atomic_add_negative(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_negative_acquire(i, v);
+	return raw_atomic_add_negative_acquire(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_release(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_negative_release(i, v);
+	return raw_atomic_add_negative_release(i, v);
 }
 
 static __always_inline bool
-arch_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
+raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
 {
-	return arch_atomic_add_negative_relaxed(i, v);
+	return raw_atomic_add_negative_relaxed(i, v);
 }
 
 static __always_inline long
-arch_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
-	return arch_atomic_fetch_add_unless(v, a, u);
+	return raw_atomic_fetch_add_unless(v, a, u);
 }
 
 static __always_inline bool
-arch_atomic_long_add_unless(atomic_long_t *v, long a, long u)
+raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
-	return arch_atomic_add_unless(v, a, u);
+	return raw_atomic_add_unless(v, a, u);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_not_zero(atomic_long_t *v)
+raw_atomic_long_inc_not_zero(atomic_long_t *v)
 {
-	return arch_atomic_inc_not_zero(v);
+	return raw_atomic_inc_not_zero(v);
 }
 
 static __always_inline bool
-arch_atomic_long_inc_unless_negative(atomic_long_t *v)
+raw_atomic_long_inc_unless_negative(atomic_long_t *v)
 {
-	return arch_atomic_inc_unless_negative(v);
+	return raw_atomic_inc_unless_negative(v);
 }
 
 static __always_inline bool
-arch_atomic_long_dec_unless_positive(atomic_long_t *v)
+raw_atomic_long_dec_unless_positive(atomic_long_t *v)
 {
-	return arch_atomic_dec_unless_positive(v);
+	return raw_atomic_dec_unless_positive(v);
 }
 
 static __always_inline long
-arch_atomic_long_dec_if_positive(atomic_long_t *v)
+raw_atomic_long_dec_if_positive(atomic_long_t *v)
 {
-	return arch_atomic_dec_if_positive(v);
+	return raw_atomic_dec_if_positive(v);
 }
 
 #endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
-// a194c07d7d2f4b0e178d3c118c919775d5d65f50
+// 108784846d3bbbb201b8dabe621c5dc30b216206
diff --git a/include/linux/atomic/atomic-raw.h b/include/linux/atomic/atomic-raw.h
index 83ff0269657e7..8b2fc04cf8c54 100644
--- a/include/linux/atomic/atomic-raw.h
+++ b/include/linux/atomic/atomic-raw.h
@@ -1026,516 +1026,6 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
-static __always_inline long
-raw_atomic_long_read(const atomic_long_t *v)
-{
-	return arch_atomic_long_read(v);
-}
-
-static __always_inline long
-raw_atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return arch_atomic_long_read_acquire(v);
-}
-
-static __always_inline void
-raw_atomic_long_set(atomic_long_t *v, long i)
-{
-	arch_atomic_long_set(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_set_release(atomic_long_t *v, long i)
-{
-	arch_atomic_long_set_release(v, i);
-}
-
-static __always_inline void
-raw_atomic_long_add(long i, atomic_long_t *v)
-{
-	arch_atomic_long_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_add(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_add_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_sub(long i, atomic_long_t *v)
-{
-	arch_atomic_long_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_sub_return(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_sub_return_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_sub(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_inc(atomic_long_t *v)
-{
-	arch_atomic_long_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_inc(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_inc_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_dec(atomic_long_t *v)
-{
-	arch_atomic_long_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_return(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_return_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_return_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_return_relaxed(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_dec(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_dec_release(v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-raw_atomic_long_and(long i, atomic_long_t *v)
-{
-	arch_atomic_long_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_and(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_and_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_andnot(long i, atomic_long_t *v)
-{
-	arch_atomic_long_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_andnot(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_or(long i, atomic_long_t *v)
-{
-	arch_atomic_long_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_or(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_or_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-raw_atomic_long_xor(long i, atomic_long_t *v)
-{
-	arch_atomic_long_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_xor(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return arch_atomic_long_xchg(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return arch_atomic_long_xchg_acquire(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return arch_atomic_long_xchg_release(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return arch_atomic_long_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return arch_atomic_long_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return arch_atomic_long_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return arch_atomic_long_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return arch_atomic_long_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return arch_atomic_long_try_cmpxchg(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return arch_atomic_long_try_cmpxchg_release(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-raw_atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_sub_and_test(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_and_test(v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_negative(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_acquire(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_negative_acquire(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_release(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_negative_release(i, v);
-}
-
-static __always_inline bool
-raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
-{
-	return arch_atomic_long_add_negative_relaxed(i, v);
-}
-
-static __always_inline long
-raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return arch_atomic_long_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return arch_atomic_long_add_unless(v, a, u);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_not_zero(v);
-}
-
-static __always_inline bool
-raw_atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return arch_atomic_long_inc_unless_negative(v);
-}
-
-static __always_inline bool
-raw_atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_unless_positive(v);
-}
-
-static __always_inline long
-raw_atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return arch_atomic_long_dec_if_positive(v);
-}
-
 #define raw_xchg(...) \
 	arch_xchg(__VA_ARGS__)
 
@@ -1642,4 +1132,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_try_cmpxchg128_local(__VA_ARGS__)
 
 #endif /* _LINUX_ATOMIC_RAW_H */
-// 01d54200571b3857755a07c10074a4fd58cef6b1
+// b23ed4424e85200e200ded094522e1d743b3a5b1
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index eda89cea6e1d1..75e91d6da30d3 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -47,9 +47,9 @@ gen_proto_order_variant()
 
 cat <<EOF
 static __always_inline ${ret}
-arch_atomic_long_${name}(${params})
+raw_atomic_long_${name}(${params})
 {
-	${retstmt}arch_${atomic}_${name}(${argscast});
+	${retstmt}raw_${atomic}_${name}(${argscast});
 }
 
 EOF
diff --git a/scripts/atomic/gen-atomic-raw.sh b/scripts/atomic/gen-atomic-raw.sh
index ba8d136f30e4c..c7e3c52b49279 100755
--- a/scripts/atomic/gen-atomic-raw.sh
+++ b/scripts/atomic/gen-atomic-raw.sh
@@ -63,10 +63,6 @@ grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
-grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
-done
-
 for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}" "${order}"
-- 
2.30.2

