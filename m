Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7200255A28
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgH1MbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbgH1Maf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:30:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D372086A;
        Fri, 28 Aug 2020 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617833;
        bh=u7jWEzjmTHQymX8r2x6fFv/1v1YPzQ31F/fYUsxwCy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKfbf51wrtP/U71ZTEtUp60C9zR2qXVPcuh/q0mNylCR/R93cfCIU27qAYp07d/eY
         sZVaaEL+i1qZaON8Ryaih3VIkKkcBm6mjM9ns17cZUJeBa+LMomJLL5ioaDIxcsiXk
         kx8F3SrSkdfnADrYVrRsmtFiiQB8NzPazzlbapto=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 21/23] asm-generic/atomic: Add try_cmpxchg() fallbacks
Date:   Fri, 28 Aug 2020 21:30:28 +0900
Message-Id: <159861782828.992023.16961291973798862888.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159861759775.992023.12553306821235086809.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Only x86 provides try_cmpxchg() outside of the atomic_t interfaces,
provide generic fallbacks to create this interface from the widely
available cmpxchg() function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/x86/include/asm/atomic.h             |    2 
 arch/x86/include/asm/atomic64_64.h        |    2 
 arch/x86/include/asm/cmpxchg.h            |    2 
 include/asm-generic/atomic-instrumented.h |  216 +++++++++++++++++------------
 include/linux/atomic-arch-fallback.h      |   90 +++++++++++-
 include/linux/atomic-fallback.h           |   90 +++++++++++-
 scripts/atomic/gen-atomic-fallback.sh     |   63 ++++++++
 scripts/atomic/gen-atomic-instrumented.sh |   29 +++-
 8 files changed, 372 insertions(+), 122 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b6cac6e9bb70..f732741ad7c7 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -199,7 +199,7 @@ static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 809bd010a751..7886d0578fc9 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -187,7 +187,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return arch_try_cmpxchg(&v->counter, old, new);
 }
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a8bfac131256..4d4ec5cbdc51 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,7 +221,7 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
-#define try_cmpxchg(ptr, pold, new) 					\
+#define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
 /*
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 379986e40159..2cab3fdaae3b 100644
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
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
index bcb6aa27cfa6..a3dba31df01e 100644
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
@@ -2288,4 +2358,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 90cd26cfd69d2250303d654955a0cc12620fb91b
+// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index fd525c71d676..2a3f55d98be9 100644
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
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 693dfa1de430..317a6cec76e1 100755
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
 
@@ -191,6 +238,8 @@ for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
+gen_try_cmpxchg_fallbacks
+
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 6afadf73da17..85dc25685c0d 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -103,14 +103,31 @@ gen_xchg()
 	local xchg="$1"; shift
 	local mult="$1"; shift
 
+	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
+
+cat <<EOF
+#define ${xchg}(ptr, oldp, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	typeof(oldp) __ai_oldp = (oldp); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
+	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
+})
+EOF
+
+	else
+
 cat <<EOF
-#define ${xchg}(ptr, ...)						\\
-({									\\
-	typeof(ptr) __ai_ptr = (ptr);					\\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
-	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
+#define ${xchg}(ptr, ...) \\
+({ \\
+	typeof(ptr) __ai_ptr = (ptr); \\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
+
+	fi
 }
 
 gen_optional_xchg()
@@ -160,7 +177,7 @@ grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_optional_xchg "${xchg}" "${order}"
 	done

