Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D9254A9C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgH0QV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgH0QVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E9C061233;
        Thu, 27 Aug 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vstZ65825O0d4AlaB8xHb/9Z6b99W2ETEyUQUR+1KnM=; b=M6m4k157YKSl4nyEjrUYxYwKLa
        kRlsiZO9ky5QcG1iqO5DLjJFnvdYRoQ+aDjHGRXQd/4I5tb1NFgLP8jxxHC+Pztrtydg507Hh4Xrd
        A5oE9N/O1d7Wb92DmpLdk3uFw6DqwTfiX6agaBVZs4BgLF/jQSxC8t1AcSwoA7ifUV1K8iuEIRuR9
        d5Ye5A0TvBtoW+uksJuxVDavssurUKsfMS0Ts87Z2zwPoDswxHa7KdK58yTWwFUy4RT3Z+5S0YlLV
        VIdipNnCxcf7ycyb0Wal9asp8q++ctCjQjd787cw1L6fVErnykAODlKoHJSE9El1IUjlVBmRSA4XX
        2jXNwm1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe4-0001WM-IY; Thu, 27 Aug 2020 16:21:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3234C30782A;
        Thu, 27 Aug 2020 18:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 827DC2C2868F7; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.477032360@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 5/7] asm-generic/atomic: Add try_cmpxchg() fallbacks
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Only x86 provides try_cmpxchg() outside of the atomic_t interfaces,
provide generic fallbacks to create this interface from the widely
available cmpxchg() function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/x86/include/asm/atomic.h             |    2 
 arch/x86/include/asm/atomic64_64.h        |    2 
 arch/x86/include/asm/cmpxchg.h            |    2 
 include/asm-generic/atomic-instrumented.h |  216 ++++++++++++++++++------------
 include/linux/atomic-arch-fallback.h      |   90 +++++++++++-
 include/linux/atomic-fallback.h           |   90 +++++++++++-
 scripts/atomic/gen-atomic-fallback.sh     |   63 +++++++-
 scripts/atomic/gen-atomic-instrumented.sh |   29 +++-
 8 files changed, 372 insertions(+), 122 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -199,7 +199,7 @@ static __always_inline int arch_atomic_c
 
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -187,7 +187,7 @@ static inline s64 arch_atomic64_cmpxchg(
 
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,7 +221,7 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
-#define try_cmpxchg(ptr, pold, new) 					\
+#define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
 /*
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1642,148 +1642,192 @@ atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #if !defined(arch_xchg_relaxed) || defined(arch_xchg)
-#define xchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg(__ai_ptr, __VA_ARGS__);				\
+#define xchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_acquire)
-#define xchg_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
+#define xchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_release)
-#define xchg_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
+#define xchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_xchg_relaxed)
-#define xchg_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define xchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
-#define cmpxchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_acquire)
-#define cmpxchg_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_release)
-#define cmpxchg_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg_relaxed)
-#define cmpxchg_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
-#define cmpxchg64(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_acquire)
-#define cmpxchg64_acquire(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_release)
-#define cmpxchg64_release(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
 #if defined(arch_cmpxchg64_relaxed)
-#define cmpxchg64_relaxed(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 #endif
 
-#define cmpxchg_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
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
 })
 
-#define cmpxchg64_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg64_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
-#define sync_cmpxchg(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
-	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
+#define sync_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
-#define cmpxchg_double(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
-	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_double(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
 
 
-#define cmpxchg_double_local(ptr, ...)						\
-({									\
-	typeof(ptr) __ai_ptr = (ptr);					\
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
-	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
+#define cmpxchg_double_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 89bf97f3a7509b740845e51ddf31055b48a81f40
+// ff0fe7f81ee97f01f13bb78b0e3ce800bc56d9dd
--- a/include/linux/atomic-arch-fallback.h
+++ b/include/linux/atomic-arch-fallback.h
@@ -9,9 +9,9 @@
 #include <linux/compiler.h>
 
 #ifndef arch_xchg_relaxed
-#define arch_xchg_relaxed		arch_xchg
-#define arch_xchg_acquire		arch_xchg
-#define arch_xchg_release		arch_xchg
+#define arch_xchg_acquire arch_xchg
+#define arch_xchg_release arch_xchg
+#define arch_xchg_relaxed arch_xchg
 #else /* arch_xchg_relaxed */
 
 #ifndef arch_xchg_acquire
@@ -32,9 +32,9 @@
 #endif /* arch_xchg_relaxed */
 
 #ifndef arch_cmpxchg_relaxed
-#define arch_cmpxchg_relaxed		arch_cmpxchg
-#define arch_cmpxchg_acquire		arch_cmpxchg
-#define arch_cmpxchg_release		arch_cmpxchg
+#define arch_cmpxchg_acquire arch_cmpxchg
+#define arch_cmpxchg_release arch_cmpxchg
+#define arch_cmpxchg_relaxed arch_cmpxchg
 #else /* arch_cmpxchg_relaxed */
 
 #ifndef arch_cmpxchg_acquire
@@ -55,9 +55,9 @@
 #endif /* arch_cmpxchg_relaxed */
 
 #ifndef arch_cmpxchg64_relaxed
-#define arch_cmpxchg64_relaxed		arch_cmpxchg64
-#define arch_cmpxchg64_acquire		arch_cmpxchg64
-#define arch_cmpxchg64_release		arch_cmpxchg64
+#define arch_cmpxchg64_acquire arch_cmpxchg64
+#define arch_cmpxchg64_release arch_cmpxchg64
+#define arch_cmpxchg64_relaxed arch_cmpxchg64
 #else /* arch_cmpxchg64_relaxed */
 
 #ifndef arch_cmpxchg64_acquire
@@ -77,6 +77,76 @@
 
 #endif /* arch_cmpxchg64_relaxed */
 
+#ifndef arch_try_cmpxchg_relaxed
+#ifdef arch_try_cmpxchg
+#define arch_try_cmpxchg_acquire arch_try_cmpxchg
+#define arch_try_cmpxchg_release arch_try_cmpxchg
+#define arch_try_cmpxchg_relaxed arch_try_cmpxchg
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_acquire */
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_release */
+
+#ifndef arch_try_cmpxchg_relaxed
+#define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_relaxed */
+
+#else /* arch_try_cmpxchg_relaxed */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(...) \
+	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(...) \
+	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg_relaxed */
+
 #ifndef arch_atomic_read_acquire
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
@@ -2288,4 +2358,4 @@ arch_atomic64_dec_if_positive(atomic64_t
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 90cd26cfd69d2250303d654955a0cc12620fb91b
+// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -9,9 +9,9 @@
 #include <linux/compiler.h>
 
 #ifndef xchg_relaxed
-#define xchg_relaxed		xchg
-#define xchg_acquire		xchg
-#define xchg_release		xchg
+#define xchg_acquire xchg
+#define xchg_release xchg
+#define xchg_relaxed xchg
 #else /* xchg_relaxed */
 
 #ifndef xchg_acquire
@@ -32,9 +32,9 @@
 #endif /* xchg_relaxed */
 
 #ifndef cmpxchg_relaxed
-#define cmpxchg_relaxed		cmpxchg
-#define cmpxchg_acquire		cmpxchg
-#define cmpxchg_release		cmpxchg
+#define cmpxchg_acquire cmpxchg
+#define cmpxchg_release cmpxchg
+#define cmpxchg_relaxed cmpxchg
 #else /* cmpxchg_relaxed */
 
 #ifndef cmpxchg_acquire
@@ -55,9 +55,9 @@
 #endif /* cmpxchg_relaxed */
 
 #ifndef cmpxchg64_relaxed
-#define cmpxchg64_relaxed		cmpxchg64
-#define cmpxchg64_acquire		cmpxchg64
-#define cmpxchg64_release		cmpxchg64
+#define cmpxchg64_acquire cmpxchg64
+#define cmpxchg64_release cmpxchg64
+#define cmpxchg64_relaxed cmpxchg64
 #else /* cmpxchg64_relaxed */
 
 #ifndef cmpxchg64_acquire
@@ -77,6 +77,76 @@
 
 #endif /* cmpxchg64_relaxed */
 
+#ifndef try_cmpxchg_relaxed
+#ifdef try_cmpxchg
+#define try_cmpxchg_acquire try_cmpxchg
+#define try_cmpxchg_release try_cmpxchg
+#define try_cmpxchg_relaxed try_cmpxchg
+#endif /* try_cmpxchg */
+
+#ifndef try_cmpxchg
+#define try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg */
+
+#ifndef try_cmpxchg_acquire
+#define try_cmpxchg_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_acquire */
+
+#ifndef try_cmpxchg_release
+#define try_cmpxchg_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_release */
+
+#ifndef try_cmpxchg_relaxed
+#define try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* try_cmpxchg_relaxed */
+
+#else /* try_cmpxchg_relaxed */
+
+#ifndef try_cmpxchg_acquire
+#define try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef try_cmpxchg_release
+#define try_cmpxchg_release(...) \
+	__atomic_op_release(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef try_cmpxchg
+#define try_cmpxchg(...) \
+	__atomic_op_fence(try_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* try_cmpxchg_relaxed */
+
 #define arch_atomic_read atomic_read
 #define arch_atomic_read_acquire atomic_read_acquire
 
@@ -2522,4 +2592,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 9d95b56f98d82a2a26c7b79ccdd0c47572d50a6f
+// d78e6c293c661c15188f0ec05bce45188c8d5892
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -144,15 +144,11 @@ gen_proto_order_variants()
 	printf "#endif /* ${basename}_relaxed */\n\n"
 }
 
-gen_xchg_fallbacks()
+gen_order_fallbacks()
 {
 	local xchg="$1"; shift
+
 cat <<EOF
-#ifndef ${xchg}_relaxed
-#define ${xchg}_relaxed		${xchg}
-#define ${xchg}_acquire		${xchg}
-#define ${xchg}_release		${xchg}
-#else /* ${xchg}_relaxed */
 
 #ifndef ${xchg}_acquire
 #define ${xchg}_acquire(...) \\
@@ -169,11 +165,62 @@ cat <<EOF
 	__atomic_op_fence(${xchg}, __VA_ARGS__)
 #endif
 
-#endif /* ${xchg}_relaxed */
+EOF
+}
+
+gen_xchg_fallbacks()
+{
+	local xchg="$1"; shift
+	printf "#ifndef ${xchg}_relaxed\n"
+
+	gen_basic_fallbacks ${xchg}
+
+	printf "#else /* ${xchg}_relaxed */\n"
+
+	gen_order_fallbacks ${xchg}
+
+	printf "#endif /* ${xchg}_relaxed */\n\n"
+}
+
+gen_try_cmpxchg_fallback()
+{
+	local order="$1"; shift;
+
+cat <<EOF
+#ifndef ${ARCH}try_cmpxchg${order}
+#define ${ARCH}try_cmpxchg${order}(_ptr, _oldp, _new) \\
+({ \\
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
+	___r = ${ARCH}cmpxchg${order}((_ptr), ___o, (_new)); \\
+	if (unlikely(___r != ___o)) \\
+		*___op = ___r; \\
+	likely(___r == ___o); \\
+})
+#endif /* ${ARCH}try_cmpxchg${order} */
 
 EOF
 }
 
+gen_try_cmpxchg_fallbacks()
+{
+	printf "#ifndef ${ARCH}try_cmpxchg_relaxed\n"
+	printf "#ifdef ${ARCH}try_cmpxchg\n"
+
+	gen_basic_fallbacks "${ARCH}try_cmpxchg"
+
+	printf "#endif /* ${ARCH}try_cmpxchg */\n\n"
+
+	for order in "" "_acquire" "_release" "_relaxed"; do
+		gen_try_cmpxchg_fallback "${order}"
+	done
+
+	printf "#else /* ${ARCH}try_cmpxchg_relaxed */\n"
+
+	gen_order_fallbacks "${ARCH}try_cmpxchg"
+
+	printf "#endif /* ${ARCH}try_cmpxchg_relaxed */\n\n"
+}
+
 cat << EOF
 // SPDX-License-Identifier: GPL-2.0
 
@@ -191,6 +238,8 @@ for xchg in "${ARCH}xchg" "${ARCH}cmpxch
 	gen_xchg_fallbacks "${xchg}"
 done
 
+gen_try_cmpxchg_fallbacks
+
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -103,14 +103,31 @@ gen_xchg()
 	local xchg="$1"; shift
 	local mult="$1"; shift
 
+	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
+
 cat <<EOF
-#define ${xchg}(ptr, ...)						\\
-({									\\
-	typeof(ptr) __ai_ptr = (ptr);					\\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
-	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
+#define ${xchg}(ptr, oldp, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	typeof(oldp) __ai_oldp = (oldp); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
+	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
 })
 EOF
+
+	else
+
+cat <<EOF
+#define ${xchg}(ptr, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
+})
+EOF
+
+	fi
 }
 
 gen_optional_xchg()
@@ -160,7 +177,7 @@ grep '^[a-z]' "$1" | while read name met
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_optional_xchg "${xchg}" "${order}"
 	done


