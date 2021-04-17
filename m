Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BA362D06
	for <lists+linux-arch@lfdr.de>; Sat, 17 Apr 2021 04:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDQC6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 22:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhDQC6X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 22:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76581610A6;
        Sat, 17 Apr 2021 02:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618628277;
        bh=+JmE/v3oFUO4I0103fRBthfFLpndj44+LF9dFv2oKiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=O/+wuGAb2tDuJ5kzsJnOXKjdh+DflY9TWEZM6FfPgjSwyu/LlkgK6DdQFXB0EVN4g
         Upt01XP4QGcC/SRkgQNezZ9h9jpTOgfmABPpJVtpxDUNN0IoBpJ2QW8830RPGjD04A
         pOT9hBsDNU5Ym37D5KdXw5h7SwWXaLlkz5R+Q/CfrPlB5emJvy3hv4ioAhd5FDbJBN
         17KxrrfVM5nOfa7hm3/XWGABsXPEobJ/PuVnIKBfYGpL617EUusV4DjXhOfcTzBsuX
         GjAxcJfUQ0jRSAacEut9LcA3cywINWZWupGrsqNZytSPALs+o2PYw3z7iZWYkWdm/F
         dCRkCkbfX4k8w==
From:   guoren@kernel.org
To:     guoren@kernel.org, peterz@infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/2] locking/atomics: Fixup GENERIC_ATOMIC64 conflict with atomic-arch-fallback.h
Date:   Sat, 17 Apr 2021 02:57:10 +0000
Message-Id: <1618628231-86789-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current GENERIC_ATOMIC64 in atomic-arch-fallback.h is broken. When a 32-bit
arch use atomic-arch-fallback.h will cause compile error.

In file included from include/linux/atomic.h:81,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/atomic-arch-fallback.h: In function 'arch_atomic64_inc':
>> include/linux/atomic-arch-fallback.h:1447:2: error: implicit declaration of function 'arch_atomic64_add'; did you mean 'arch_atomic_add'? [-Werror=implicit-function-declaration]
    1447 |  arch_atomic64_add(1, v);
         |  ^~~~~~~~~~~~~~~~~
         |  arch_atomic_add

The atomic-arch-fallback.h & atomic-fallback.h &
atomic-instrumented.h are generated by gen-atomic-fallback.sh &
gen-atomic-instrumented.sh, so just take care the bash files.

Remove the dependency of atomic-*-fallback.h in atomic64.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/atomic-instrumented.h | 307 +++++++++++++++++-------------
 include/asm-generic/atomic64.h            |  89 +++++++++
 include/linux/atomic-arch-fallback.h      |   5 +-
 include/linux/atomic-fallback.h           |   5 +-
 scripts/atomic/gen-atomic-fallback.sh     |   3 +-
 scripts/atomic/gen-atomic-instrumented.sh |  23 ++-
 6 files changed, 294 insertions(+), 138 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 888b6cf..f6ce7a2 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -831,6 +831,180 @@ atomic_dec_if_positive(atomic_t *v)
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
+#if !defined(arch_xchg_relaxed) || defined(arch_xchg)
+#define xchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_xchg_acquire)
+#define xchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_xchg_release)
+#define xchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_xchg_relaxed)
+#define xchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
+#define cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg_acquire)
+#define cmpxchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg_release)
+#define cmpxchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg_relaxed)
+#define cmpxchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
+#define cmpxchg64(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg64_acquire)
+#define cmpxchg64_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg64_release)
+#define cmpxchg64_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_cmpxchg64_relaxed)
+#define cmpxchg64_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+#endif
+
+#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
+#define try_cmpxchg(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_acquire)
+#define try_cmpxchg_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_release)
+#define try_cmpxchg_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#if defined(arch_try_cmpxchg_relaxed)
+#define try_cmpxchg_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+#endif
+
+#define cmpxchg_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
+})
+
+#define sync_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+
+#ifndef CONFIG_GENERIC_ATOMIC64
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
@@ -1641,78 +1815,6 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 #endif
 
-#if !defined(arch_xchg_relaxed) || defined(arch_xchg)
-#define xchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_xchg_acquire)
-#define xchg_acquire(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_xchg_release)
-#define xchg_release(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_xchg_relaxed)
-#define xchg_relaxed(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
-#define cmpxchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_cmpxchg_acquire)
-#define cmpxchg_acquire(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_cmpxchg_release)
-#define cmpxchg_release(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_cmpxchg_relaxed)
-#define cmpxchg_relaxed(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
-})
-#endif
-
 #if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
 #define cmpxchg64(ptr, ...) \
 ({ \
@@ -1749,57 +1851,6 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 #endif
 
-#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
-#define try_cmpxchg(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_try_cmpxchg_acquire)
-#define try_cmpxchg_acquire(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_try_cmpxchg_release)
-#define try_cmpxchg_release(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-#endif
-
-#if defined(arch_try_cmpxchg_relaxed)
-#define try_cmpxchg_relaxed(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-#endif
-
-#define cmpxchg_local(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
-})
-
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1807,13 +1858,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
-#define sync_cmpxchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
-})
-
+#endif
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1830,4 +1875,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 4bec382e44520f4d8267e42620054db26a659ea3
+// 701f331c42f0e10e2effb6d113873d44a7495f15
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d..bb5cf1e 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -34,6 +34,18 @@ extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
 
+#define atomic64_add_relaxed atomic64_add
+#define atomic64_add_acquire atomic64_add
+#define atomic64_add_release atomic64_add
+
+#define atomic64_add_return_relaxed atomic64_add_return
+#define atomic64_add_return_acquire atomic64_add_return
+#define atomic64_add_return_release atomic64_add_return
+
+#define atomic64_fetch_add_relaxed atomic64_fetch_add
+#define atomic64_fetch_add_acquire atomic64_fetch_add
+#define atomic64_fetch_add_release atomic64_fetch_add
+
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_FETCH_OP(op)
 
@@ -49,8 +61,85 @@ ATOMIC64_OPS(xor)
 extern s64 atomic64_dec_if_positive(atomic64_t *v);
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
+#define atomic64_cmpxchg_relaxed atomic64_cmpxchg
+#define atomic64_cmpxchg_acquire atomic64_cmpxchg
+#define atomic64_cmpxchg_release atomic64_cmpxchg
 extern s64 atomic64_xchg(atomic64_t *v, s64 new);
+#define atomic64_xchg_relaxed atomic64_xchg
+#define atomic64_xchg_acquire atomic64_xchg
+#define atomic64_xchg_release atomic64_xchg
 extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
+static __always_inline void
+atomic64_inc(atomic64_t *v)
+{
+	atomic64_add(1, v);
+}
+
+static __always_inline s64
+atomic64_inc_return(atomic64_t *v)
+{
+	return atomic64_add_return(1, v);
+}
+
+static __always_inline s64
+atomic64_fetch_inc(atomic64_t *v)
+{
+	return atomic64_fetch_add(1, v);
+}
+
+static __always_inline void
+atomic64_dec(atomic64_t *v)
+{
+	atomic64_sub(1, v);
+}
+
+static __always_inline s64
+atomic64_dec_return(atomic64_t *v)
+{
+	return atomic64_sub_return(1, v);
+}
+
+static __always_inline s64
+atomic64_fetch_dec(atomic64_t *v)
+{
+	return atomic64_fetch_sub(1, v);
+}
+
+static __always_inline void
+atomic64_andnot(s64 i, atomic64_t *v)
+{
+	atomic64_and(~i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and(~i, v);
+}
+
+static __always_inline bool
+atomic64_sub_and_test(int i, atomic64_t *v)
+{
+	return atomic64_sub_return(i, v) == 0;
+}
+
+static __always_inline bool
+atomic64_dec_and_test(atomic64_t *v)
+{
+	return atomic64_dec_return(v) == 0;
+}
+
+static __always_inline bool
+atomic64_inc_and_test(atomic64_t *v)
+{
+	return atomic64_inc_return(v) == 0;
+}
+
+static __always_inline bool
+atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v) < 0;
+}
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
index a3dba31..2f1db6a 100644
--- a/include/linux/atomic-arch-fallback.h
+++ b/include/linux/atomic-arch-fallback.h
@@ -1252,7 +1252,7 @@ arch_atomic_dec_if_positive(atomic_t *v)
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
-#endif
+#else
 
 #ifndef arch_atomic64_read_acquire
 static __always_inline s64
@@ -2357,5 +2357,6 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 #endif
 
+#endif /* CONFIG_GENERIC_ATOMIC64 */
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
+// ae31a21075855e67a9b2927f8241dedddafda046
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index 2a3f55d..7dda483 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -1369,7 +1369,7 @@ atomic_dec_if_positive(atomic_t *v)
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
-#endif
+#else
 
 #define arch_atomic64_read atomic64_read
 #define arch_atomic64_read_acquire atomic64_read_acquire
@@ -2591,5 +2591,6 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 #endif
 
+#endif /* CONFIG_GENERIC_ATOMIC64 */
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// d78e6c293c661c15188f0ec05bce45188c8d5892
+// b809c8e3c88910826f765bdba4a74f21c527029d
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 317a6ce..8b7a685 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -247,7 +247,7 @@ done
 cat <<EOF
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
-#endif
+#else
 
 EOF
 
@@ -256,5 +256,6 @@ grep '^[a-z]' "$1" | while read name meta args; do
 done
 
 cat <<EOF
+#endif /* CONFIG_GENERIC_ATOMIC64 */
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
 EOF
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 5766ffc..c4e0611 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -182,21 +182,40 @@ grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
 done
 
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_optional_xchg "${xchg}" "${order}"
+	done
+done
+
+for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+	gen_xchg "${xchg}" ""
+	printf "\n"
+done
+
+cat <<EOF
+#ifndef CONFIG_GENERIC_ATOMIC64
+EOF
+
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
+for xchg in "cmpxchg64"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_optional_xchg "${xchg}" "${order}"
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+for xchg in "cmpxchg64_local"; do
 	gen_xchg "${xchg}" ""
 	printf "\n"
 done
 
+cat <<EOF
+#endif
+EOF
+
 gen_xchg "cmpxchg_double" "2 * "
 
 printf "\n\n"
-- 
2.7.4

