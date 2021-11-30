Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DED4632D2
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhK3Lsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbhK3Lsg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:36 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0768C061756
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:16 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so13608939wma.5
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=05D+KiscSDDxRASVdY9PJsfP2IqeJxlbD6WimO+AarQ=;
        b=WjwZ3pB6+Vu2lNRFWXtsCYgVVT5dtFBAzdsiyINGDqy6ee2aK4TgF2jWEgxL5ZPGR+
         BTrTrwvc8indlreyV2WKOa9NjmGI82GHiWPYvkbvZnFbBuJNCPsE4Q0zqHcoWLrC5go1
         gu/Fo0LO9OQtmwAChCaBi+nxY9hyeY7yFTFhZcRk3+OC/W/SQcaC5YloxNOh/p2OLJY3
         a4xBHN5RELZaAM+6LlbS4sF6LMpAMUn3bLGB67G6PQbSBetLyxwWP8VahUs+13wfeINT
         wnA8fVDdM4CU9kWXpYnFKL5QIprJPNhuPavfTPxgfXB7NsiyaxVa29vZLTO9jytHU3CD
         2BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=05D+KiscSDDxRASVdY9PJsfP2IqeJxlbD6WimO+AarQ=;
        b=7A5Ayo/ME8MY0KSah7k4/1x0izaXDTAOPZKFemIY4KXqBKhNIiEQM5ioWjH90AlYQm
         LdoSlbkxPTeF63ag3eOx7XKovwIHfq4tm80QJyjwpwAQMuUYlu/RLrYiNuY4itOCb+fn
         ujQeYqvmWXEiT/38jsV6oy+kBoTtazG4arCehqhn/4ZAHYe4Cg+iqSBIpS2BgH8fj1mU
         oujj0+LZ+MpkdC1mA/fZKY1MWE/HrLAqsLWT62untcug2EJPRYBtZfzw7HbvjpmuUABy
         8UlMVmeevTsyk5MhbPDjjN9SyYp4ZPFhr6KkyljMWu1pk87pBf/m3vQaOnOvs+bRnojV
         dScg==
X-Gm-Message-State: AOAM533dpR1eWhvoIVXXAuZthDVdVAhzJEmnMSVfh4a+j4NlA+Mvq61Y
        watzmS4fL3RUXNCHPLPvXe8apbAwpQ==
X-Google-Smtp-Source: ABdhPJxGueGvV4chcqDmzeTnc8nSvFhiikLLTsZdezn3PPdCHiHIafheTtGZ0dHxd+eScv2RrVBGUnfycQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:6000:168f:: with SMTP id
 y15mr39633411wrd.61.1638272715140; Tue, 30 Nov 2021 03:45:15 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:13 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-6-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 05/25] kcsan: Add core memory barrier instrumentation functions
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the core memory barrier instrumentation functions. These invalidate
the current in-flight reordered access based on the rules for the
respective barrier types and in-flight access type.

To obtain barrier instrumentation that can be disabled via __no_kcsan
with appropriate compiler-support (and not just with objtool help),
barrier instrumentation repurposes __atomic_signal_fence(), instead of
inserting explicit calls. Crucially, __atomic_signal_fence() normally
does not map to any real instructions, but is still intercepted by
fsanitize=thread. As a result, like any other instrumentation done by
the compiler, barrier instrumentation can be disabled with __no_kcsan.

Unfortunately Clang and GCC currently differ in their __no_kcsan aka
__no_sanitize_thread behaviour with respect to builtin atomics (and
__tsan_func_{entry,exit}) instrumentation. This is already reflected in
Kconfig.kcsan's dependencies for KCSAN_WEAK_MEMORY. A later change will
introduce support for newer versions of Clang that can implement
__no_kcsan to also remove the additional instrumentation introduced by
KCSAN_WEAK_MEMORY.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rework to avoid inserting explicit calls, and instead repurpose
  __atomic_signal_fence (see comment at __tsan_atomic_signal_fence),
  which is known to the ThreadSanitizer instrumentation and can
  therefore be removed via function attributes.

v2:
* Rename kcsan_atomic_release() to kcsan_atomic_builtin_memorder() to
  avoid confusion.
---
 include/linux/kcsan-checks.h | 71 +++++++++++++++++++++++++++++++++++-
 kernel/kcsan/core.c          | 68 +++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index a1c6a89fde71..9d2c869167f2 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -36,6 +36,36 @@
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
+/*
+ * See definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
+ * Note: The mappings are arbitrary, and do not reflect any real mappings of C11
+ * memory orders to the LKMM memory orders and vice-versa!
+ */
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_mb	__ATOMIC_SEQ_CST
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_wmb	__ATOMIC_ACQ_REL
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_rmb	__ATOMIC_ACQUIRE
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_release	__ATOMIC_RELEASE
+
+/**
+ * __kcsan_mb - full memory barrier instrumentation
+ */
+void __kcsan_mb(void);
+
+/**
+ * __kcsan_wmb - write memory barrier instrumentation
+ */
+void __kcsan_wmb(void);
+
+/**
+ * __kcsan_rmb - read memory barrier instrumentation
+ */
+void __kcsan_rmb(void);
+
+/**
+ * __kcsan_release - release barrier instrumentation
+ */
+void __kcsan_release(void);
+
 /**
  * kcsan_disable_current - disable KCSAN for the current context
  *
@@ -159,6 +189,10 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
 
+static inline void __kcsan_mb(void)			{ }
+static inline void __kcsan_wmb(void)			{ }
+static inline void __kcsan_rmb(void)			{ }
+static inline void __kcsan_release(void)		{ }
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
 static inline void kcsan_enable_current_nowarn(void)	{ }
@@ -191,12 +225,45 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
  */
 #define __kcsan_disable_current kcsan_disable_current
 #define __kcsan_enable_current kcsan_enable_current_nowarn
-#else
+#else /* __SANITIZE_THREAD__ */
 static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 				      int type) { }
 static inline void __kcsan_enable_current(void)  { }
 static inline void __kcsan_disable_current(void) { }
-#endif
+#endif /* __SANITIZE_THREAD__ */
+
+#if defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__SANITIZE_THREAD__)
+/*
+ * Normal barrier instrumentation is not done via explicit calls, but by mapping
+ * to a repurposed __atomic_signal_fence(), which normally does not generate any
+ * real instructions, but is still intercepted by fsanitize=thread. This means,
+ * like any other compile-time instrumentation, barrier instrumentation can be
+ * disabled with the __no_kcsan function attribute.
+ *
+ * Also see definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
+ */
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE(name)					\
+	static __always_inline void kcsan_##name(void)				\
+	{									\
+		barrier();							\
+		__atomic_signal_fence(__KCSAN_BARRIER_TO_SIGNAL_FENCE_##name);	\
+		barrier();							\
+	}
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
+#elif defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__KCSAN_INSTRUMENT_BARRIERS__)
+#define kcsan_mb	__kcsan_mb
+#define kcsan_wmb	__kcsan_wmb
+#define kcsan_rmb	__kcsan_rmb
+#define kcsan_release	__kcsan_release
+#else /* CONFIG_KCSAN_WEAK_MEMORY && ... */
+static inline void kcsan_mb(void)		{ }
+static inline void kcsan_wmb(void)		{ }
+static inline void kcsan_rmb(void)		{ }
+static inline void kcsan_release(void)		{ }
+#endif /* CONFIG_KCSAN_WEAK_MEMORY && ... */
 
 /**
  * __kcsan_check_read - check regular read access for races
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 36a75e79a0bd..2254cb75cbb0 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -942,6 +942,22 @@ void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
 }
 EXPORT_SYMBOL(__kcsan_check_access);
 
+#define DEFINE_MEMORY_BARRIER(name, order_before_cond)				\
+	void __kcsan_##name(void)						\
+	{									\
+		struct kcsan_scoped_access *sa = get_reorder_access(get_ctx());	\
+		if (!sa)							\
+			return;							\
+		if (order_before_cond)						\
+			sa->size = 0;						\
+	}									\
+	EXPORT_SYMBOL(__kcsan_##name)
+
+DEFINE_MEMORY_BARRIER(mb, true);
+DEFINE_MEMORY_BARRIER(wmb, sa->type & (KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND));
+DEFINE_MEMORY_BARRIER(rmb, !(sa->type & KCSAN_ACCESS_WRITE) || (sa->type & KCSAN_ACCESS_COMPOUND));
+DEFINE_MEMORY_BARRIER(release, true);
+
 /*
  * KCSAN uses the same instrumentation that is emitted by supported compilers
  * for ThreadSanitizer (TSAN).
@@ -1130,10 +1146,19 @@ EXPORT_SYMBOL(__tsan_init);
  * functions, whose job is to also execute the operation itself.
  */
 
+static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
+{
+	if (memorder == __ATOMIC_RELEASE ||
+	    memorder == __ATOMIC_SEQ_CST ||
+	    memorder == __ATOMIC_ACQ_REL)
+		__kcsan_release();
+}
+
 #define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
 		}                                                                                  \
@@ -1143,6 +1168,7 @@ EXPORT_SYMBOL(__tsan_init);
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
@@ -1155,6 +1181,7 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1187,6 +1214,7 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(mo);                                                 \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1202,6 +1230,7 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(mo);                                                 \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1233,10 +1262,47 @@ DEFINE_TSAN_ATOMIC_OPS(64);
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
 {
+	kcsan_atomic_builtin_memorder(memorder);
 	__atomic_thread_fence(memorder);
 }
 EXPORT_SYMBOL(__tsan_atomic_thread_fence);
 
+/*
+ * In instrumented files, we emit instrumentation for barriers by mapping the
+ * kernel barriers to an __atomic_signal_fence(), which is interpreted specially
+ * and otherwise has no relation to a real __atomic_signal_fence(). No known
+ * kernel code uses __atomic_signal_fence().
+ *
+ * Since fsanitize=thread instrumentation handles __atomic_signal_fence(), which
+ * are turned into calls to __tsan_atomic_signal_fence(), such instrumentation
+ * can be disabled via the __no_kcsan function attribute (vs. an explicit call
+ * which could not). When __no_kcsan is requested, __atomic_signal_fence()
+ * generates no code.
+ *
+ * Note: The result of using __atomic_signal_fence() with KCSAN enabled is
+ * potentially limiting the compiler's ability to reorder operations; however,
+ * if barriers were instrumented with explicit calls (without LTO), the compiler
+ * couldn't optimize much anyway. The result of a hypothetical architecture
+ * using __atomic_signal_fence() in normal code would be KCSAN false negatives.
+ */
 void __tsan_atomic_signal_fence(int memorder);
-void __tsan_atomic_signal_fence(int memorder) { }
+noinline void __tsan_atomic_signal_fence(int memorder)
+{
+	switch (memorder) {
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_mb:
+		__kcsan_mb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_wmb:
+		__kcsan_wmb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_rmb:
+		__kcsan_rmb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_release:
+		__kcsan_release();
+		break;
+	default:
+		break;
+	}
+}
 EXPORT_SYMBOL(__tsan_atomic_signal_fence);
-- 
2.34.0.rc2.393.gf8c9666880-goog

