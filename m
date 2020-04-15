Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5791AAED1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410515AbgDOQxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410507AbgDOQxG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:06 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F9620857;
        Wed, 15 Apr 2020 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969586;
        bh=ivjbcqqNZz7CQq6TOuUeyvjn01P+0xKmo2O2YAVvZQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8ecqzNL5nUZo8wrJDOpmBTZi+2+rc9TcDdg2OC33HmetCl3AqTmk5NVnA0m6da8S
         Bc/j8e16DKM2/YVKzvbJj0SHq0+lDB0+OiF76laKy7yXf1kijmQhmz+aRozb4PxJ6b
         3BGnVFXU2f8VZbcMO0Qy9eeXaIvk/TBmsTmuCikQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 06/12] READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
Date:   Wed, 15 Apr 2020 17:52:12 +0100
Message-Id: <20200415165218.20251-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The implementations of {READ,WRITE}_ONCE() suffer from a significant
amount of indirection and complexity due to a historic GCC bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

which was originally worked around by 230fa253df63 ("kernel: Provide
READ_ONCE and ASSIGN_ONCE").

Since GCC 4.8 is fairly vintage at this point and we emit a warning if
we detect it during the build, return {READ,WRITE}_ONCE() to their former
glory with an implementation that is easier to understand and, crucially,
more amenable to optimisation. A side effect of this simplification is
that WRITE_ONCE() no longer returns a value, but nobody seems to be
relying on that and the new behaviour is aligned with smp_store_release().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h | 104 ++++++++++-----------------------------
 1 file changed, 25 insertions(+), 79 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 034b0a644efc..0bf6c04b3f8f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,60 +177,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
-#include <uapi/linux/types.h>
-
-#define __READ_ONCE_SIZE						\
-({									\
-	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
-	default:							\
-		barrier();						\
-		__builtin_memcpy((void *)res, (const void *)p, size);	\
-		barrier();						\
-	}								\
-})
-
-static __always_inline
-void __read_once_size(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
-#ifdef CONFIG_KASAN
-/*
- * We can't declare function 'inline' because __no_sanitize_address confilcts
- * with inlining. Attempt to inline it may cause a build failure.
- * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
- * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
- */
-# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
-#else
-# define __no_kasan_or_inline __always_inline
-#endif
-
-static __no_kasan_or_inline
-void __read_once_size_nocheck(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
-static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-{
-	switch (size) {
-	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
-	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
-	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
-	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)p, (const void *)res, size);
-		barrier();
-	}
-}
-
 /*
  * Prevent the compiler from merging or refetching reads or writes. The
  * compiler is also forbidden from reordering successive instances of
@@ -240,11 +186,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * statements.
  *
  * These two macros will also work on aggregate data types like structs or
- * unions. If the size of the accessed data type exceeds the word size of
- * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
- * fall back to memcpy(). There's at least two memcpy()s: one for the
- * __builtin_memcpy() and then one for the macro doing the copy of variable
- * - '__u' allocated on the stack.
+ * unions.
  *
  * Their two major use cases are: (1) Mediating communication between
  * process-level code and irq/NMI handlers, all running on the same CPU,
@@ -256,23 +198,35 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #include <asm/barrier.h>
 #include <linux/kasan-checks.h>
 
-#define __READ_ONCE(x, check)						\
+/*
+ * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
+ * to hide memory access from KASAN.
+ */
+#define READ_ONCE_NOCHECK(x)						\
 ({									\
-	union { typeof(x) __val; char __c[1]; } __u;			\
-	if (check)							\
-		__read_once_size(&(x), __u.__c, sizeof(x));		\
-	else								\
-		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
-	__u.__val;							\
+	typeof(x) __x = *(volatile typeof(x) *)&(x);			\
+	smp_read_barrier_depends();					\
+	__x;								\
 })
-#define READ_ONCE(x) __READ_ONCE(x, 1)
 
+#define READ_ONCE(x)	READ_ONCE_NOCHECK(x)
+
+#define WRITE_ONCE(x, val)				\
+do {							\
+	*(volatile typeof(x) *)&(x) = (val);		\
+} while (0)
+
+#ifdef CONFIG_KASAN
 /*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
- * to hide memory access from KASAN.
+ * We can't declare function 'inline' because __no_sanitize_address conflicts
+ * with inlining. Attempt to inline it may cause a build failure.
+ *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
  */
-#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
+# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
+#else
+# define __no_kasan_or_inline __always_inline
+#endif
 
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
@@ -281,14 +235,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#define WRITE_ONCE(x, val) \
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (__force typeof(x)) (val) }; \
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
-
 #endif /* __KERNEL__ */
 
 /*
-- 
2.26.0.110.g2183baf09c-goog

