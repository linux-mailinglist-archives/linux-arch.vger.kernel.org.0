Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C159EE25B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfKDO3B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 09:29:01 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:51205 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfKDO26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Nov 2019 09:28:58 -0500
Received: by mail-wm1-f73.google.com with SMTP id f191so2397809wme.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Nov 2019 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W2KMc75T+ey98cQATeXScdAroFGPFLtMgEgekCTGnp4=;
        b=khHV2SIAKHkd352HaLsUVqwJ92TOqfDzaFA7Hkz00Z0PuPSTF2SuNcIMV6wsPXM0Qi
         ISIP+PppUWbkHSlCLe+tz++ARU8GPcONVzDvLn2YESUtHaNx79xrQPNlIJvd26CitKh/
         m5WOCOmbGjqgYsuilgY58QLUbgrNqxYo2yClwXjBoa3NV+RAo0IDFEGqpcRUYOJJpaNk
         DUK6KR6zG6Zj02hEaPQ5B5PcTyrQdB/oSOJqmW4jMace+fPLa1KVsDX0ZXsUJ1LOE4bH
         xSLeuEQ3Dedw5PJHxLHj6iC0FKZ0JILP+Xtv1ruZZsJxmnfyw6ePFHZSZCbSRDhfmEf3
         n+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W2KMc75T+ey98cQATeXScdAroFGPFLtMgEgekCTGnp4=;
        b=O6PPa2q9/Ing379EHcIMobsbA7g++OJ25NXKyMyI7hoig44g+3lS9qyLq6JjVSi62d
         Rj+O5ntS+/N6KbGmGPGx1HudCl3ZSsHCkYWO/z8SkzzJQsgPOLwmth0c0LwOcwHAOJyo
         Xj/JeW0tQ1rswPOn2P//Zd6OWg81z9sTlILxzaa/ibi7JvkbyL6GhXtfgNub9ddUAza6
         G6YUUvWyC+aqCvJnmjrneFx02zWKNc0cynD17Kw/CAnD4v8k17KWzjCw2pUGca8mgDoZ
         cR4HA75RVQu9pzb2cu62FqlTYjMyXhsdDLHvTJm7MY12YGvMVP5myb6nv6bmpC7mCb3a
         +5hQ==
X-Gm-Message-State: APjAAAXUH4wrNsiD4gn92M++lfFbvFTSwU3HuP6YW55BFAqI6/chVxpc
        NfVZDESNCpzFoxwXTb+mEfuoqqDYjQ==
X-Google-Smtp-Source: APXvYqy2MM7n8v3QVs4WzH/3u5Yz2iIYf80J9dFAuV7/VaHSZPbnbfyKTvF5xhiVPcWVcA86l9Y+M0wX5A==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr17167512wru.158.1572877731936;
 Mon, 04 Nov 2019 06:28:51 -0800 (PST)
Date:   Mon,  4 Nov 2019 15:27:37 +0100
In-Reply-To: <20191104142745.14722-1-elver@google.com>
Message-Id: <20191104142745.14722-2-elver@google.com>
Mime-Version: 1.0
References: <20191104142745.14722-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3 1/9] kcsan: Add Kernel Concurrency Sanitizer infrastructure
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kernel Concurrency Sanitizer (KCSAN) is a dynamic data-race detector for
kernel space. KCSAN is a sampling watchpoint-based data-race detector.
See the included Documentation/dev-tools/kcsan.rst for more details.

This patch adds basic infrastructure, but does not yet enable KCSAN for
any architecture.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Move Documentation to separate patch.
* Default init_task 'disable_count' to 0, since kcsan_enabled is sufficient.
* Fix CFLAGS for compilers that do not support all options.
* lib/Kconfig.kcsan:
 - Clarify preference of config option over boot param in comment.
 - Add ref to Documentation
 - Remove unnecessary "KCSAN:"
* include/linux/compiler.h: Remove (const void*) casts
* include/linux/kcsan.h:
 - Reword atomic nestable and flat region comment, and clarify that they
   are independent.
 - Rename atomic_region -> atomic_nest_count.
 - Rename atomic_region_flat -> in_flat_atomic.
 - Rename kcsan_{begin,end}_atomic -> kcsan_{nestable,flat}_atomic_{begin,end}
* kernel/kcsan/kcsan.h:
 - Capitalize enums.
 - Make KCSAN_NUM_WATCHPOINTS configurable -> lib/Kconfig.kcsan.
* Make kcsan_is_atomic inlinable by turning atomic.c into atomic.h.
* kernel/kcsan/core.c (merged with previous kcsan.c):
 - Make __tsan_unaligned __alias of generic accesses.
 - user_access_save/restore() usage comment.
 - Add instruction watchpoint skip randomization.
 - Refactor API and core runtime fast-path and slow-path; check_access is
   now the single entry point for checking an access. Compared to the
   previous version, with a default config and benchmarked using the
   microbenchmark, this version is 3.8x faster.
* kernel/kcsan/test.c: Add more comments where appropriate.
* kernel/kcsan/report.c:
 - get_thread_desc should just return "interrupt" for any interrupt.
 - increase NUM_STACK_ENTRIES to 64.
* kernel/kcsan/debugfs.c
 - More appropriate error codes.
 - Use kmalloc+krealloc instead of kvmalloc.
 - Handle kmalloc failures.
 - Add debugfs based microbenchmark.
* Use '{ }' on same line where appropriate.
* Prefer IS_ENABLED instead of #ifdef.
* Use common spelling: "data-race" -> "data race"
* Other typos.

v2:
* Elaborate comment about instrumentation calls emitted by compilers.
* Replace kcsan_check_access(.., {true, false}) with
  kcsan_check_{read,write} for improved readability.
* Change bug title of race of unknown origin to just say "data-race in".
* Refine "Key Properties" in kcsan.rst, and mention observed slow-down.
* Add comment about safety of find_watchpoint without user_access_save.
* Remove unnecessary preempt_disable/enable and elaborate on comment why
  we want to disable interrupts and preemptions.
* Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
  contexts [Suggested by Mark Rutland].
---
 MAINTAINERS                    |  11 +
 Makefile                       |   3 +-
 include/linux/compiler-clang.h |   9 +
 include/linux/compiler-gcc.h   |   7 +
 include/linux/compiler.h       |  35 ++-
 include/linux/kcsan-checks.h   |  97 ++++++
 include/linux/kcsan.h          | 115 +++++++
 include/linux/sched.h          |   4 +
 init/init_task.c               |   8 +
 init/main.c                    |   2 +
 kernel/Makefile                |   1 +
 kernel/kcsan/Makefile          |  11 +
 kernel/kcsan/atomic.h          |  27 ++
 kernel/kcsan/core.c            | 560 +++++++++++++++++++++++++++++++++
 kernel/kcsan/debugfs.c         | 275 ++++++++++++++++
 kernel/kcsan/encoding.h        |  94 ++++++
 kernel/kcsan/kcsan.h           | 131 ++++++++
 kernel/kcsan/report.c          | 306 ++++++++++++++++++
 kernel/kcsan/test.c            | 121 +++++++
 lib/Kconfig.debug              |   2 +
 lib/Kconfig.kcsan              | 119 +++++++
 lib/Makefile                   |   3 +
 scripts/Makefile.kcsan         |   6 +
 scripts/Makefile.lib           |  10 +
 24 files changed, 1948 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan

diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..ac9cceb6a8ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8848,6 +8848,17 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/kconfig/
 F:	scripts/Kconfig.include
 
+KCSAN
+M:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kcsan.rst
+F:	include/linux/kcsan*.h
+F:	kernel/kcsan/
+F:	lib/Kconfig.kcsan
+F:	scripts/Makefile.kcsan
+
 KDUMP
 M:	Dave Young <dyoung@redhat.com>
 M:	Baoquan He <bhe@redhat.com>
diff --git a/Makefile b/Makefile
index b37d0e8fc61d..79154b0b69db 100644
--- a/Makefile
+++ b/Makefile
@@ -478,7 +478,7 @@ export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
-export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_KCSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
@@ -900,6 +900,7 @@ endif
 include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 include scripts/Makefile.ubsan
+include scripts/Makefile.kcsan
 
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918..a213eb55e725 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -24,6 +24,15 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_feature(thread_sanitizer)
+/* emulate gcc's __SANITIZE_THREAD__ flag */
+#define __SANITIZE_THREAD__
+#define __no_sanitize_thread \
+		__attribute__((no_sanitize("thread")))
+#else
+#define __no_sanitize_thread
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..de105ca29282 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -145,6 +145,13 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
+#define __no_sanitize_thread                                                   \
+	__attribute__((__noinline__)) __attribute__((no_sanitize_thread))
+#else
+#define __no_sanitize_thread
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e88e7e33abe..0b6506b9dd11 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -178,6 +178,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #include <uapi/linux/types.h>
+#include <linux/kcsan-checks.h>
 
 #define __READ_ONCE_SIZE						\
 ({									\
@@ -193,12 +194,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	}								\
 })
 
-static __always_inline
-void __read_once_size(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
@@ -211,14 +206,38 @@ void __read_once_size(const volatile void *p, void *res, int size)
 # define __no_kasan_or_inline __always_inline
 #endif
 
-static __no_kasan_or_inline
+#ifdef CONFIG_KCSAN
+# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
+#else
+# define __no_kcsan_or_inline __always_inline
+#endif
+
+#if defined(CONFIG_KASAN) || defined(CONFIG_KCSAN)
+/* Avoid any instrumentation or inline. */
+#define __no_sanitize_or_inline                                                \
+	__no_sanitize_address __no_sanitize_thread notrace __maybe_unused
+#else
+#define __no_sanitize_or_inline __always_inline
+#endif
+
+static __no_kcsan_or_inline
+void __read_once_size(const volatile void *p, void *res, int size)
+{
+	kcsan_check_atomic_read(p, size);
+	__READ_ONCE_SIZE;
+}
+
+static __no_sanitize_or_inline
 void __read_once_size_nocheck(const volatile void *p, void *res, int size)
 {
 	__READ_ONCE_SIZE;
 }
 
-static __always_inline void __write_once_size(volatile void *p, void *res, int size)
+static __no_kcsan_or_inline
+void __write_once_size(volatile void *p, void *res, int size)
 {
+	kcsan_check_atomic_write(p, size);
+
 	switch (size) {
 	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
 	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
new file mode 100644
index 000000000000..e78220661086
--- /dev/null
+++ b/include/linux/kcsan-checks.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KCSAN_CHECKS_H
+#define _LINUX_KCSAN_CHECKS_H
+
+#include <linux/types.h>
+
+/*
+ * Access type modifiers.
+ */
+#define KCSAN_ACCESS_WRITE 0x1
+#define KCSAN_ACCESS_ATOMIC 0x2
+
+/*
+ * __kcsan_*: Always calls into runtime when KCSAN is enabled. This may be used
+ * even in compilation units that selectively disable KCSAN, but must use KCSAN
+ * to validate access to an address.   Never use these in header files!
+ */
+#ifdef CONFIG_KCSAN
+/**
+ * __kcsan_check_access - check generic access for data race
+ *
+ * @ptr address of access
+ * @size size of access
+ * @type access type modifier
+ */
+void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
+
+#else
+static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
+					int type) { }
+#endif
+
+/*
+ * kcsan_*: Only calls into runtime when the particular compilation unit has
+ * KCSAN instrumentation enabled. May be used in header files.
+ */
+#ifdef __SANITIZE_THREAD__
+#define kcsan_check_access __kcsan_check_access
+#else
+static inline void kcsan_check_access(const volatile void *ptr, size_t size,
+				      int type) { }
+#endif
+
+/**
+ * __kcsan_check_read - check regular read access for data races
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+#define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
+
+/**
+ * __kcsan_check_write - check regular write access for data races
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+#define __kcsan_check_write(ptr, size)                                         \
+	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+
+/**
+ * kcsan_check_read - check regular read access for data races
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+#define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
+
+/**
+ * kcsan_check_write - check regular write access for data races
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+#define kcsan_check_write(ptr, size)                                           \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+
+/*
+ * Check for atomic accesses: if atomic access are not ignored, this simply
+ * aliases to kcsan_check_access, otherwise becomes a no-op.
+ */
+#ifdef CONFIG_KCSAN_IGNORE_ATOMICS
+#define kcsan_check_atomic_read(...)                                           \
+	do {                                                                   \
+	} while (0)
+#define kcsan_check_atomic_write(...)                                          \
+	do {                                                                   \
+	} while (0)
+#else
+#define kcsan_check_atomic_read(ptr, size)                                     \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
+#define kcsan_check_atomic_write(ptr, size)                                    \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
+#endif
+
+#endif /* _LINUX_KCSAN_CHECKS_H */
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
new file mode 100644
index 000000000000..bd8122acae01
--- /dev/null
+++ b/include/linux/kcsan.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KCSAN_H
+#define _LINUX_KCSAN_H
+
+#include <linux/types.h>
+#include <linux/kcsan-checks.h>
+
+#ifdef CONFIG_KCSAN
+
+/*
+ * Context for each thread of execution: for tasks, this is stored in
+ * task_struct, and interrupts access internal per-CPU storage.
+ */
+struct kcsan_ctx {
+	int disable_count; /* disable counter */
+	int atomic_next; /* number of following atomic ops */
+
+	/*
+	 * We distinguish between: (a) nestable atomic regions that may contain
+	 * other nestable regions; and (b) flat atomic regions that do not keep
+	 * track of nesting. Both (a) and (b) are entirely independent of each
+	 * other, and a flat region may be started in a nestable region or
+	 * vice-versa.
+	 *
+	 * This is required because, for example, in the annotations for
+	 * seqlocks, we declare seqlock writer critical sections as (a) nestable
+	 * atomic regions, but reader critical sections as (b) flat atomic
+	 * regions, but have encountered cases where seqlock reader critical
+	 * sections are contained within writer critical sections (the opposite
+	 * may be possible, too).
+	 *
+	 * To support these cases, we independently track the depth of nesting
+	 * for (a), and whether the leaf level is flat for (b).
+	 */
+	int atomic_nest_count;
+	bool in_flat_atomic;
+};
+
+/**
+ * kcsan_init - initialize KCSAN runtime
+ */
+void kcsan_init(void);
+
+/**
+ * kcsan_disable_current - disable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_disable_current(void);
+
+/**
+ * kcsan_enable_current - re-enable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_enable_current(void);
+
+/**
+ * kcsan_nestable_atomic_begin - begin nestable atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_nestable_atomic_begin(void);
+
+/**
+ * kcsan_nestable_atomic_end - end nestable atomic region
+ */
+void kcsan_nestable_atomic_end(void);
+
+/**
+ * kcsan_flat_atomic_begin - begin flat atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_flat_atomic_begin(void);
+
+/**
+ * kcsan_flat_atomic_end - end flat atomic region
+ */
+void kcsan_flat_atomic_end(void);
+
+/**
+ * kcsan_atomic_next - consider following accesses as atomic
+ *
+ * Force treating the next n memory accesses for the current context as atomic
+ * operations.
+ *
+ * @n number of following memory accesses to treat as atomic.
+ */
+void kcsan_atomic_next(int n);
+
+#else /* CONFIG_KCSAN */
+
+static inline void kcsan_init(void) { }
+
+static inline void kcsan_disable_current(void) { }
+
+static inline void kcsan_enable_current(void) { }
+
+static inline void kcsan_nestable_atomic_begin(void) { }
+
+static inline void kcsan_nestable_atomic_end(void) { }
+
+static inline void kcsan_flat_atomic_begin(void) { }
+
+static inline void kcsan_flat_atomic_end(void) { }
+
+static inline void kcsan_atomic_next(int n) { }
+
+#endif /* CONFIG_KCSAN */
+
+#endif /* _LINUX_KCSAN_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 67a1d86981a9..ae4f341c1db4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -31,6 +31,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
+#include <linux/kcsan.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1172,6 +1173,9 @@ struct task_struct {
 #ifdef CONFIG_KASAN
 	unsigned int			kasan_depth;
 #endif
+#ifdef CONFIG_KCSAN
+	struct kcsan_ctx		kcsan_ctx;
+#endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..2b4fe98b0f09 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -161,6 +161,14 @@ struct task_struct init_task
 #ifdef CONFIG_KASAN
 	.kasan_depth	= 1,
 #endif
+#ifdef CONFIG_KCSAN
+	.kcsan_ctx = {
+		.disable_count		= 0,
+		.atomic_next		= 0,
+		.atomic_nest_count	= 0,
+		.in_flat_atomic		= false,
+	},
+#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	.softirqs_enabled = 1,
 #endif
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..4d814de017ee 100644
--- a/init/main.c
+++ b/init/main.c
@@ -93,6 +93,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/kcsan.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -779,6 +780,7 @@ asmlinkage __visible void __init start_kernel(void)
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
+	kcsan_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
diff --git a/kernel/Makefile b/kernel/Makefile
index daad787fb795..74ab46e2ebd1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_KCSAN) += kcsan/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
new file mode 100644
index 000000000000..dd15b62ec0b5
--- /dev/null
+++ b/kernel/kcsan/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+KCSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+
+CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
+
+CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
+	$(call cc-option,-fno-stack-protector,)
+
+obj-y := core.o debugfs.o report.o
+obj-$(CONFIG_KCSAN_SELFTEST) += test.o
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
new file mode 100644
index 000000000000..c9c3fe628011
--- /dev/null
+++ b/kernel/kcsan/atomic.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_KCSAN_ATOMIC_H
+#define _KERNEL_KCSAN_ATOMIC_H
+
+#include <linux/jiffies.h>
+
+/*
+ * Helper that returns true if access to ptr should be considered as an atomic
+ * access, even though it is not explicitly atomic.
+ *
+ * List all volatile globals that have been observed in races, to suppress
+ * data race reports between accesses to these variables.
+ *
+ * For now, we assume that volatile accesses of globals are as strong as atomic
+ * accesses (READ_ONCE, WRITE_ONCE cast to volatile). The situation is still not
+ * entirely clear, as on some architectures (Alpha) READ_ONCE/WRITE_ONCE do more
+ * than cast to volatile. Eventually, we hope to be able to remove this
+ * function.
+ */
+static inline bool kcsan_is_atomic(const volatile void *ptr)
+{
+	/* only jiffies for now */
+	return ptr == &jiffies;
+}
+
+#endif /* _KERNEL_KCSAN_ATOMIC_H */
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
new file mode 100644
index 000000000000..3755f09acf17
--- /dev/null
+++ b/kernel/kcsan/core.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+
+#include "kcsan.h"
+#include "atomic.h"
+#include "encoding.h"
+
+/*
+ * Helper macros to iterate slots, starting from address slot itself, followed
+ * by the right and left slots.
+ */
+#define CHECK_NUM_SLOTS (1 + 2 * KCSAN_CHECK_ADJACENT)
+#define SLOT_IDX(slot, i)                                                      \
+	((slot + (((i + KCSAN_CHECK_ADJACENT) % CHECK_NUM_SLOTS) -             \
+		  KCSAN_CHECK_ADJACENT)) %                                     \
+	 CONFIG_KCSAN_NUM_WATCHPOINTS)
+
+bool kcsan_enabled;
+
+/* Per-CPU kcsan_ctx for interrupts */
+static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
+	.disable_count = 0,
+	.atomic_next = 0,
+	.atomic_nest_count = 0,
+	.in_flat_atomic = false,
+};
+
+/*
+ * Watchpoints, with each entry encoded as defined in encoding.h: in order to be
+ * able to safely update and access a watchpoint without introducing locking
+ * overhead, we encode each watchpoint as a single atomic long. The initial
+ * zero-initialized state matches INVALID_WATCHPOINT.
+ */
+static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS];
+
+/*
+ * Instructions to skip watching counter, used in should_watch(). We use a
+ * per-CPU counter to avoid excessive contention.
+ */
+static DEFINE_PER_CPU(long, kcsan_skip);
+
+static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
+					     bool expect_write,
+					     long *encoded_watchpoint)
+{
+	const int slot = watchpoint_slot(addr);
+	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
+	atomic_long_t *watchpoint;
+	unsigned long wp_addr_masked;
+	size_t wp_size;
+	bool is_write;
+	int i;
+
+	BUILD_BUG_ON(CONFIG_KCSAN_NUM_WATCHPOINTS < CHECK_NUM_SLOTS);
+
+	for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
+		watchpoint = &watchpoints[SLOT_IDX(slot, i)];
+		*encoded_watchpoint = atomic_long_read(watchpoint);
+		if (!decode_watchpoint(*encoded_watchpoint, &wp_addr_masked,
+				       &wp_size, &is_write))
+			continue;
+
+		if (expect_write && !is_write)
+			continue;
+
+		/* Check if the watchpoint matches the access. */
+		if (matching_access(wp_addr_masked, wp_size, addr_masked, size))
+			return watchpoint;
+	}
+
+	return NULL;
+}
+
+static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
+					       bool is_write)
+{
+	const int slot = watchpoint_slot(addr);
+	const long encoded_watchpoint = encode_watchpoint(addr, size, is_write);
+	atomic_long_t *watchpoint;
+	int i;
+
+	for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
+		long expect_val = INVALID_WATCHPOINT;
+
+		/* Try to acquire this slot. */
+		watchpoint = &watchpoints[SLOT_IDX(slot, i)];
+		if (atomic_long_try_cmpxchg_relaxed(watchpoint, &expect_val,
+						    encoded_watchpoint))
+			return watchpoint;
+	}
+
+	return NULL;
+}
+
+/*
+ * Return true if watchpoint was successfully consumed, false otherwise.
+ *
+ * This may return false if:
+ *
+ *	1. another thread already consumed the watchpoint;
+ *	2. the thread that set up the watchpoint already removed it;
+ *	3. the watchpoint was removed and then re-used.
+ */
+static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
+					  long encoded_watchpoint)
+{
+	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint,
+					       CONSUMED_WATCHPOINT);
+}
+
+/*
+ * Return true if watchpoint was not touched, false if consumed.
+ */
+static inline bool remove_watchpoint(atomic_long_t *watchpoint)
+{
+	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) !=
+	       CONSUMED_WATCHPOINT;
+}
+
+static inline struct kcsan_ctx *get_ctx(void)
+{
+	/*
+	 * In interrupt, use raw_cpu_ptr to avoid unnecessary checks, that would
+	 * also result in calls that generate warnings in uaccess regions.
+	 */
+	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
+}
+
+static inline bool is_atomic(const volatile void *ptr)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+
+	if (unlikely(ctx->atomic_next > 0)) {
+		--ctx->atomic_next;
+		return true;
+	}
+	if (unlikely(ctx->atomic_nest_count > 0 || ctx->in_flat_atomic))
+		return true;
+
+	return kcsan_is_atomic(ptr);
+}
+
+static inline bool should_watch(const volatile void *ptr, int type)
+{
+	/*
+	 * Never set up watchpoints when memory operations are atomic.
+	 *
+	 * Need to check this first, before kcsan_skip check below: (1) atomics
+	 * should not count towards skipped instructions, and (2) to actually
+	 * decrement kcsan_atomic_next for consecutive instruction stream.
+	 */
+	if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
+		return false;
+
+	if (this_cpu_dec_return(kcsan_skip) >= 0)
+		return false;
+
+	/* avoid underflow if !kcsan_is_enabled() */
+	this_cpu_write(kcsan_skip, -1);
+
+	/* this operation should be watched */
+	return true;
+}
+
+static inline void reset_kcsan_skip(void)
+{
+	long skip_count = CONFIG_KCSAN_SKIP_WATCH -
+			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
+				   prandom_u32_max(CONFIG_KCSAN_SKIP_WATCH) :
+				   0);
+	this_cpu_write(kcsan_skip, skip_count);
+}
+
+static inline bool kcsan_is_enabled(void)
+{
+	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
+}
+
+static inline unsigned int get_delay(void)
+{
+	unsigned int delay = in_task() ? CONFIG_KCSAN_UDELAY_TASK :
+					 CONFIG_KCSAN_UDELAY_INTERRUPT;
+	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
+				prandom_u32_max(delay) :
+				0);
+}
+
+/*
+ * Pull everything together: check_access() below contains the performance
+ * critical operations; the fast-path (including check_access) functions should
+ * all be inlinable by the instrumentation functions.
+ *
+ * The slow-path (kcsan_found_watchpoint, kcsan_setup_watchpoint) are
+ * non-inlinable -- note that, we prefix these with "kcsan_" to ensure they can
+ * be filtered from the stacktrace, as well as give them unique names for the
+ * UACCESS whitelist of objtool. Each function uses user_access_save/restore(),
+ * since they do not access any user memory, but instrumentation is still
+ * emitted in UACCESS regions.
+ */
+
+static noinline void kcsan_found_watchpoint(const volatile void *ptr,
+					    size_t size, bool is_write,
+					    bool consumed)
+{
+	unsigned long flags = user_access_save();
+	enum kcsan_report_type report_type;
+
+	if (!consumed) {
+		/*
+		 * The other thread may not print any diagnostics, as it has
+		 * already removed the watchpoint, or another thread consumed
+		 * the watchpoint before this thread.
+		 */
+		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
+		report_type = KCSAN_REPORT_RACE_CHECK_RACE;
+	} else {
+		report_type = KCSAN_REPORT_RACE_CHECK;
+	}
+
+	kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+	kcsan_report(ptr, size, is_write, raw_smp_processor_id(), report_type);
+
+	user_access_restore(flags);
+}
+
+static noinline void kcsan_setup_watchpoint(const volatile void *ptr,
+					    size_t size, bool is_write)
+{
+	atomic_long_t *watchpoint;
+	union {
+		u8 _1;
+		u16 _2;
+		u32 _4;
+		u64 _8;
+	} expect_value;
+	bool is_expected = true;
+	unsigned long ua_flags = user_access_save();
+	unsigned long irq_flags;
+
+	if (!check_encodable((unsigned long)ptr, size)) {
+		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
+		goto out;
+	}
+
+	/*
+	 * Disable interrupts & preemptions to avoid another thread on the same
+	 * CPU accessing memory locations for the set up watchpoint; this is to
+	 * avoid reporting races to e.g. CPU-local data.
+	 *
+	 * An alternative would be adding the source CPU to the watchpoint
+	 * encoding, and checking that watchpoint-CPU != this-CPU. There are
+	 * several problems with this:
+	 *   1. we should avoid stealing more bits from the watchpoint encoding
+	 *      as it would affect accuracy, as well as increase performance
+	 *      overhead in the fast-path;
+	 *   2. if we are preempted, but there *is* a genuine data race, we
+	 *      would *not* report it -- since this is the common case (vs.
+	 *      CPU-local data accesses), it makes more sense (from a data race
+	 *      detection point of view) to simply disable preemptions to ensure
+	 *      as many tasks as possible run on other CPUs.
+	 */
+	local_irq_save(irq_flags);
+
+	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
+	if (watchpoint == NULL) {
+		/*
+		 * Out of capacity: the size of `watchpoints`, and the frequency
+		 * with which `should_watch()` returns true should be tweaked so
+		 * that this case happens very rarely.
+		 */
+		kcsan_counter_inc(KCSAN_COUNTER_NO_CAPACITY);
+		goto out_unlock;
+	}
+
+	/*
+	 * Reset kcsan_skip counter: only do this if we succeeded in setting up
+	 * a watchpoint.
+	 */
+	reset_kcsan_skip();
+
+	kcsan_counter_inc(KCSAN_COUNTER_SETUP_WATCHPOINTS);
+	kcsan_counter_inc(KCSAN_COUNTER_USED_WATCHPOINTS);
+
+	/*
+	 * Read the current value, to later check and infer a race if the data
+	 * was modified via a non-instrumented access, e.g. from a device.
+	 */
+	switch (size) {
+	case 1:
+		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
+		break;
+	case 2:
+		expect_value._2 = READ_ONCE(*(const u16 *)ptr);
+		break;
+	case 4:
+		expect_value._4 = READ_ONCE(*(const u32 *)ptr);
+		break;
+	case 8:
+		expect_value._8 = READ_ONCE(*(const u64 *)ptr);
+		break;
+	default:
+		break; /* ignore; we do not diff the values */
+	}
+
+	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
+		kcsan_disable_current();
+		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
+		       is_write ? "write" : "read", size, ptr,
+		       watchpoint_slot((unsigned long)ptr),
+		       encode_watchpoint((unsigned long)ptr, size, is_write));
+		kcsan_enable_current();
+	}
+
+	/*
+	 * Delay this thread, to increase probability of observing a racy
+	 * conflicting access.
+	 */
+	udelay(get_delay());
+
+	/*
+	 * Re-read value, and check if it is as expected; if not, we infer a
+	 * racy access.
+	 */
+	switch (size) {
+	case 1:
+		is_expected = expect_value._1 == READ_ONCE(*(const u8 *)ptr);
+		break;
+	case 2:
+		is_expected = expect_value._2 == READ_ONCE(*(const u16 *)ptr);
+		break;
+	case 4:
+		is_expected = expect_value._4 == READ_ONCE(*(const u32 *)ptr);
+		break;
+	case 8:
+		is_expected = expect_value._8 == READ_ONCE(*(const u64 *)ptr);
+		break;
+	default:
+		break; /* ignore; we do not diff the values */
+	}
+
+	/* Check if this access raced with another. */
+	if (!remove_watchpoint(watchpoint)) {
+		/*
+		 * No need to increment 'data_races' counter, as the racing
+		 * thread already did.
+		 */
+		kcsan_report(ptr, size, is_write, smp_processor_id(),
+			     KCSAN_REPORT_RACE_SETUP);
+	} else if (!is_expected) {
+		/* Inferring a race, since the value should not have changed. */
+		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN))
+			kcsan_report(ptr, size, is_write, smp_processor_id(),
+				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
+	}
+
+	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
+out_unlock:
+	local_irq_restore(irq_flags);
+out:
+	user_access_restore(ua_flags);
+}
+
+static inline void check_access(const volatile void *ptr, size_t size, int type)
+{
+	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	atomic_long_t *watchpoint;
+	long encoded_watchpoint;
+
+	if (IS_ENABLED(CONFIG_KCSAN_PLAIN_WRITE_PRETEND_ONCE) && is_write)
+		type |= KCSAN_ACCESS_ATOMIC;
+
+	/*
+	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
+	 * user_access_save, as the address that ptr points to is only used to
+	 * check if a watchpoint exists; ptr is never dereferenced.
+	 */
+	watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
+				     &encoded_watchpoint);
+
+	/*
+	 * It is safe to check kcsan_is_enabled() after find_watchpoint, but
+	 * right before we would enter the slow-path: no state changes that
+	 * cause a data race to be detected and reported have occurred yet.
+	 */
+
+	if (unlikely(watchpoint != NULL) && kcsan_is_enabled()) {
+		/*
+		 * Try consume the watchpoint as soon after finding the
+		 * watchpoint as possible; this must always be guarded by
+		 * kcsan_is_enabled() check, as otherwise we might erroneously
+		 * triggering reports when disabled.
+		 */
+		const bool consumed =
+			try_consume_watchpoint(watchpoint, encoded_watchpoint);
+
+		kcsan_found_watchpoint(ptr, size, is_write, consumed);
+	} else if (unlikely(should_watch(ptr, type)) && kcsan_is_enabled()) {
+		kcsan_setup_watchpoint(ptr, size, is_write);
+	}
+}
+
+/* === Public interface ===================================================== */
+
+void __init kcsan_init(void)
+{
+	BUG_ON(!in_task());
+
+	kcsan_debugfs_init();
+
+	/*
+	 * We are in the init task, and no other tasks should be running;
+	 * WRITE_ONCE without memory barrier is sufficient.
+	 */
+	if (IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE))
+		WRITE_ONCE(kcsan_enabled, true);
+}
+
+/* === Exported interface =================================================== */
+
+void kcsan_disable_current(void)
+{
+	++get_ctx()->disable_count;
+}
+EXPORT_SYMBOL(kcsan_disable_current);
+
+void kcsan_enable_current(void)
+{
+	if (get_ctx()->disable_count-- == 0) {
+		kcsan_disable_current(); /* restore to 0 */
+		kcsan_disable_current();
+		WARN(1, "mismatching %s", __func__);
+		kcsan_enable_current();
+	}
+}
+EXPORT_SYMBOL(kcsan_enable_current);
+
+void kcsan_nestable_atomic_begin(void)
+{
+	/*
+	 * Do *not* check and warn if we are in a flat atomic region: nestable
+	 * and flat atomic regions are independent from each other.
+	 * See include/linux/kcsan.h: struct kcsan_ctx comments for more
+	 * comments.
+	 */
+
+	++get_ctx()->atomic_nest_count;
+}
+EXPORT_SYMBOL(kcsan_nestable_atomic_begin);
+
+void kcsan_nestable_atomic_end(void)
+{
+	if (get_ctx()->atomic_nest_count-- == 0) {
+		kcsan_nestable_atomic_begin(); /* restore to 0 */
+		kcsan_disable_current();
+		WARN(1, "mismatching %s", __func__);
+		kcsan_enable_current();
+	}
+}
+EXPORT_SYMBOL(kcsan_nestable_atomic_end);
+
+void kcsan_flat_atomic_begin(void)
+{
+	get_ctx()->in_flat_atomic = true;
+}
+EXPORT_SYMBOL(kcsan_flat_atomic_begin);
+
+void kcsan_flat_atomic_end(void)
+{
+	get_ctx()->in_flat_atomic = false;
+}
+EXPORT_SYMBOL(kcsan_flat_atomic_end);
+
+void kcsan_atomic_next(int n)
+{
+	get_ctx()->atomic_next = n;
+}
+EXPORT_SYMBOL(kcsan_atomic_next);
+
+void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
+{
+	check_access(ptr, size, type);
+}
+EXPORT_SYMBOL(__kcsan_check_access);
+
+/*
+ * KCSAN uses the same instrumentation that is emitted by supported compilers
+ * for ThreadSanitizer (TSAN).
+ *
+ * When enabled, the compiler emits instrumentation calls (the functions
+ * prefixed with "__tsan" below) for all loads and stores that it generated;
+ * inline asm is not instrumented.
+ *
+ * Note that, not all supported compiler versions distinguish aligned/unaligned
+ * accesses, but e.g. recent versions of Clang do. We simply alias the unaligned
+ * version to the generic version, which can handle both.
+ */
+
+#define DEFINE_TSAN_READ_WRITE(size)                                           \
+	void __tsan_read##size(void *ptr)                                      \
+	{                                                                      \
+		check_access(ptr, size, 0);                                    \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_read##size);                                      \
+	void __tsan_unaligned_read##size(void *ptr)                            \
+		__alias(__tsan_read##size);                                    \
+	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
+	void __tsan_write##size(void *ptr)                                     \
+	{                                                                      \
+		check_access(ptr, size, KCSAN_ACCESS_WRITE);                   \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_write##size);                                     \
+	void __tsan_unaligned_write##size(void *ptr)                           \
+		__alias(__tsan_write##size);                                   \
+	EXPORT_SYMBOL(__tsan_unaligned_write##size)
+
+DEFINE_TSAN_READ_WRITE(1);
+DEFINE_TSAN_READ_WRITE(2);
+DEFINE_TSAN_READ_WRITE(4);
+DEFINE_TSAN_READ_WRITE(8);
+DEFINE_TSAN_READ_WRITE(16);
+
+void __tsan_read_range(void *ptr, size_t size)
+{
+	check_access(ptr, size, 0);
+}
+EXPORT_SYMBOL(__tsan_read_range);
+
+void __tsan_write_range(void *ptr, size_t size)
+{
+	check_access(ptr, size, KCSAN_ACCESS_WRITE);
+}
+EXPORT_SYMBOL(__tsan_write_range);
+
+/*
+ * The below are not required by KCSAN, but can still be emitted by the
+ * compiler.
+ */
+void __tsan_func_entry(void *call_pc)
+{
+}
+EXPORT_SYMBOL(__tsan_func_entry);
+void __tsan_func_exit(void)
+{
+}
+EXPORT_SYMBOL(__tsan_func_exit);
+void __tsan_init(void)
+{
+}
+EXPORT_SYMBOL(__tsan_init);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
new file mode 100644
index 000000000000..8f1403085032
--- /dev/null
+++ b/kernel/kcsan/debugfs.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/atomic.h>
+#include <linux/bsearch.h>
+#include <linux/bug.h>
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/kallsyms.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kcsan.h"
+
+/*
+ * Statistics counters.
+ */
+static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+
+/*
+ * Addresses for filtering functions from reporting. This list can be used as a
+ * whitelist or blacklist.
+ */
+static struct {
+	unsigned long *addrs; /* array of addresses */
+	size_t size; /* current size */
+	int used; /* number of elements used */
+	bool sorted; /* if elements are sorted */
+	bool whitelist; /* if list is a blacklist or whitelist */
+} report_filterlist = {
+	.addrs = NULL,
+	.size = 8, /* small initial size */
+	.used = 0,
+	.sorted = false,
+	.whitelist = false, /* default is blacklist */
+};
+static DEFINE_SPINLOCK(report_filterlist_lock);
+
+static const char *counter_to_name(enum kcsan_counter_id id)
+{
+	switch (id) {
+	case KCSAN_COUNTER_USED_WATCHPOINTS:
+		return "used_watchpoints";
+	case KCSAN_COUNTER_SETUP_WATCHPOINTS:
+		return "setup_watchpoints";
+	case KCSAN_COUNTER_DATA_RACES:
+		return "data_races";
+	case KCSAN_COUNTER_NO_CAPACITY:
+		return "no_capacity";
+	case KCSAN_COUNTER_REPORT_RACES:
+		return "report_races";
+	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:
+		return "races_unknown_origin";
+	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:
+		return "unencodable_accesses";
+	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:
+		return "encoding_false_positives";
+	case KCSAN_COUNTER_COUNT:
+		BUG();
+	}
+	return NULL;
+}
+
+void kcsan_counter_inc(enum kcsan_counter_id id)
+{
+	atomic_long_inc(&counters[id]);
+}
+
+void kcsan_counter_dec(enum kcsan_counter_id id)
+{
+	atomic_long_dec(&counters[id]);
+}
+
+/*
+ * The microbenchmark allows benchmarking KCSAN core runtime only. To run
+ * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
+ * debugfs file.
+ */
+static void microbenchmark(unsigned long iters)
+{
+	cycles_t cycles;
+
+	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+
+	cycles = get_cycles();
+	while (iters--) {
+		/*
+		 * We can run this benchmark from multiple tasks; this address
+		 * calculation increases likelyhood of some accesses overlapping
+		 * (they still won't conflict because all are reads).
+		 */
+		unsigned long addr =
+			iters % (CONFIG_KCSAN_NUM_WATCHPOINTS * PAGE_SIZE);
+		__kcsan_check_read((void *)addr, sizeof(long));
+	}
+	cycles = get_cycles() - cycles;
+
+	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+}
+
+static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
+{
+	const unsigned long a = *(const unsigned long *)rhs;
+	const unsigned long b = *(const unsigned long *)lhs;
+
+	return a < b ? -1 : a == b ? 0 : 1;
+}
+
+bool kcsan_skip_report(unsigned long func_addr)
+{
+	unsigned long symbolsize, offset;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!kallsyms_lookup_size_offset(func_addr, &symbolsize, &offset))
+		return false;
+	func_addr -= offset; /* get function start */
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (report_filterlist.used == 0)
+		goto out;
+
+	/* Sort array if it is unsorted, and then do a binary search. */
+	if (!report_filterlist.sorted) {
+		sort(report_filterlist.addrs, report_filterlist.used,
+		     sizeof(unsigned long), cmp_filterlist_addrs, NULL);
+		report_filterlist.sorted = true;
+	}
+	ret = !!bsearch(&func_addr, report_filterlist.addrs,
+			report_filterlist.used, sizeof(unsigned long),
+			cmp_filterlist_addrs);
+	if (report_filterlist.whitelist)
+		ret = !ret;
+
+out:
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	return ret;
+}
+
+static void set_report_filterlist_whitelist(bool whitelist)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	report_filterlist.whitelist = whitelist;
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+}
+
+/* Returns 0 on success, error-code otherwise. */
+static ssize_t insert_report_filterlist(const char *func)
+{
+	unsigned long flags;
+	unsigned long addr = kallsyms_lookup_name(func);
+	ssize_t ret = 0;
+
+	if (!addr) {
+		pr_err("KCSAN: could not find function: '%s'\n", func);
+		return -ENOENT;
+	}
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+
+	if (report_filterlist.addrs == NULL) {
+		/* initial allocation */
+		report_filterlist.addrs =
+			kmalloc_array(report_filterlist.size,
+				      sizeof(unsigned long), GFP_KERNEL);
+		if (report_filterlist.addrs == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (report_filterlist.used == report_filterlist.size) {
+		/* resize filterlist */
+		size_t new_size = report_filterlist.size * 2;
+		unsigned long *new_addrs =
+			krealloc(report_filterlist.addrs,
+				 new_size * sizeof(unsigned long), GFP_KERNEL);
+
+		if (new_addrs == NULL) {
+			/* leave filterlist itself untouched */
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		report_filterlist.size = new_size;
+		report_filterlist.addrs = new_addrs;
+	}
+
+	/* Note: deduplicating should be done in userspace. */
+	report_filterlist.addrs[report_filterlist.used++] =
+		kallsyms_lookup_name(func);
+	report_filterlist.sorted = false;
+
+out:
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	return ret;
+}
+
+static int show_info(struct seq_file *file, void *v)
+{
+	int i;
+	unsigned long flags;
+
+	/* show stats */
+	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
+	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
+		seq_printf(file, "%s: %ld\n", counter_to_name(i),
+			   atomic_long_read(&counters[i]));
+
+	/* show filter functions, and filter type */
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	seq_printf(file, "\n%s functions: %s\n",
+		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
+		   report_filterlist.used == 0 ? "none" : "");
+	for (i = 0; i < report_filterlist.used; ++i)
+		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+
+	return 0;
+}
+
+static int debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, show_info, NULL);
+}
+
+static ssize_t debugfs_write(struct file *file, const char __user *buf,
+			     size_t count, loff_t *off)
+{
+	char kbuf[KSYM_NAME_LEN];
+	char *arg;
+	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+	arg = strstrip(kbuf);
+
+	if (!strcmp(arg, "on")) {
+		WRITE_ONCE(kcsan_enabled, true);
+	} else if (!strcmp(arg, "off")) {
+		WRITE_ONCE(kcsan_enabled, false);
+	} else if (!strncmp(arg, "microbench=", sizeof("microbench=") - 1)) {
+		unsigned long iters;
+
+		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
+			return -EINVAL;
+		microbenchmark(iters);
+	} else if (!strcmp(arg, "whitelist")) {
+		set_report_filterlist_whitelist(true);
+	} else if (!strcmp(arg, "blacklist")) {
+		set_report_filterlist_whitelist(false);
+	} else if (arg[0] == '!') {
+		ssize_t ret = insert_report_filterlist(&arg[1]);
+
+		if (ret < 0)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations debugfs_ops = { .read = seq_read,
+						    .open = debugfs_open,
+						    .write = debugfs_write,
+						    .release = single_release };
+
+void __init kcsan_debugfs_init(void)
+{
+	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
+}
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
new file mode 100644
index 000000000000..e17bdac0e54b
--- /dev/null
+++ b/kernel/kcsan/encoding.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_KCSAN_ENCODING_H
+#define _KERNEL_KCSAN_ENCODING_H
+
+#include <linux/bits.h>
+#include <linux/log2.h>
+#include <linux/mm.h>
+
+#include "kcsan.h"
+
+#define SLOT_RANGE PAGE_SIZE
+#define INVALID_WATCHPOINT 0
+#define CONSUMED_WATCHPOINT 1
+
+/*
+ * The maximum useful size of accesses for which we set up watchpoints is the
+ * max range of slots we check on an access.
+ */
+#define MAX_ENCODABLE_SIZE (SLOT_RANGE * (1 + KCSAN_CHECK_ADJACENT))
+
+/*
+ * Number of bits we use to store size info.
+ */
+#define WATCHPOINT_SIZE_BITS bits_per(MAX_ENCODABLE_SIZE)
+/*
+ * This encoding for addresses discards the upper (1 for is-write + SIZE_BITS);
+ * however, most 64-bit architectures do not use the full 64-bit address space.
+ * Also, in order for a false positive to be observable 2 things need to happen:
+ *
+ *	1. different addresses but with the same encoded address race;
+ *	2. and both map onto the same watchpoint slots;
+ *
+ * Both these are assumed to be very unlikely. However, in case it still happens
+ * happens, the report logic will filter out the false positive (see report.c).
+ */
+#define WATCHPOINT_ADDR_BITS (BITS_PER_LONG - 1 - WATCHPOINT_SIZE_BITS)
+
+/*
+ * Masks to set/retrieve the encoded data.
+ */
+#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG - 1)
+#define WATCHPOINT_SIZE_MASK                                                   \
+	GENMASK(BITS_PER_LONG - 2, BITS_PER_LONG - 2 - WATCHPOINT_SIZE_BITS)
+#define WATCHPOINT_ADDR_MASK                                                   \
+	GENMASK(BITS_PER_LONG - 3 - WATCHPOINT_SIZE_BITS, 0)
+
+static inline bool check_encodable(unsigned long addr, size_t size)
+{
+	return size <= MAX_ENCODABLE_SIZE;
+}
+
+static inline long encode_watchpoint(unsigned long addr, size_t size,
+				     bool is_write)
+{
+	return (long)((is_write ? WATCHPOINT_WRITE_MASK : 0) |
+		      (size << WATCHPOINT_ADDR_BITS) |
+		      (addr & WATCHPOINT_ADDR_MASK));
+}
+
+static inline bool decode_watchpoint(long watchpoint,
+				     unsigned long *addr_masked, size_t *size,
+				     bool *is_write)
+{
+	if (watchpoint == INVALID_WATCHPOINT ||
+	    watchpoint == CONSUMED_WATCHPOINT)
+		return false;
+
+	*addr_masked = (unsigned long)watchpoint & WATCHPOINT_ADDR_MASK;
+	*size = ((unsigned long)watchpoint & WATCHPOINT_SIZE_MASK) >>
+		WATCHPOINT_ADDR_BITS;
+	*is_write = !!((unsigned long)watchpoint & WATCHPOINT_WRITE_MASK);
+
+	return true;
+}
+
+/*
+ * Return watchpoint slot for an address.
+ */
+static inline int watchpoint_slot(unsigned long addr)
+{
+	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
+}
+
+static inline bool matching_access(unsigned long addr1, size_t size1,
+				   unsigned long addr2, size_t size2)
+{
+	unsigned long end_range1 = addr1 + size1 - 1;
+	unsigned long end_range2 = addr2 + size2 - 1;
+
+	return addr1 <= end_range2 && addr2 <= end_range1;
+}
+
+#endif /* _KERNEL_KCSAN_ENCODING_H */
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
new file mode 100644
index 000000000000..f35f71e124c7
--- /dev/null
+++ b/kernel/kcsan/kcsan.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
+ * see Documentation/dev-tools/kcsan.rst.
+ */
+
+#ifndef _KERNEL_KCSAN_KCSAN_H
+#define _KERNEL_KCSAN_KCSAN_H
+
+#include <linux/kcsan.h>
+
+/*
+ * The number of adjacent watchpoints to check; the purpose is 2-fold:
+ *
+ *	1. the address slot is already occupied, check if any adjacent slots are
+ *	   free;
+ *	2. accesses that straddle a slot boundary due to size that exceeds a
+ *	   slot's range may check adjacent slots if any watchpoint matches.
+ *
+ * Note that accesses with very large size may still miss a watchpoint; however,
+ * given this should be rare, this is a reasonable trade-off to make, since this
+ * will avoid:
+ *
+ *	1. excessive contention between watchpoint checks and setup;
+ *	2. larger number of simultaneous watchpoints without sacrificing
+ *	   performance.
+ */
+#define KCSAN_CHECK_ADJACENT 1
+
+/*
+ * Globally enable and disable KCSAN.
+ */
+extern bool kcsan_enabled;
+
+/*
+ * Initialize debugfs file.
+ */
+void kcsan_debugfs_init(void);
+
+enum kcsan_counter_id {
+	/*
+	 * Number of watchpoints currently in use.
+	 */
+	KCSAN_COUNTER_USED_WATCHPOINTS,
+
+	/*
+	 * Total number of watchpoints set up.
+	 */
+	KCSAN_COUNTER_SETUP_WATCHPOINTS,
+
+	/*
+	 * Total number of data races.
+	 */
+	KCSAN_COUNTER_DATA_RACES,
+
+	/*
+	 * Number of times no watchpoints were available.
+	 */
+	KCSAN_COUNTER_NO_CAPACITY,
+
+	/*
+	 * A thread checking a watchpoint raced with another checking thread;
+	 * only one will be reported.
+	 */
+	KCSAN_COUNTER_REPORT_RACES,
+
+	/*
+	 * Observed data value change, but writer thread unknown.
+	 */
+	KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN,
+
+	/*
+	 * The access cannot be encoded to a valid watchpoint.
+	 */
+	KCSAN_COUNTER_UNENCODABLE_ACCESSES,
+
+	/*
+	 * Watchpoint encoding caused a watchpoint to fire on mismatching
+	 * accesses.
+	 */
+	KCSAN_COUNTER_ENCODING_FALSE_POSITIVES,
+
+	KCSAN_COUNTER_COUNT, /* number of counters */
+};
+
+/*
+ * Increment/decrement counter with given id; avoid calling these in fast-path.
+ */
+void kcsan_counter_inc(enum kcsan_counter_id id);
+void kcsan_counter_dec(enum kcsan_counter_id id);
+
+/*
+ * Returns true if data races in the function symbol that maps to func_addr
+ * (offsets are ignored) should *not* be reported.
+ */
+bool kcsan_skip_report(unsigned long func_addr);
+
+enum kcsan_report_type {
+	/*
+	 * The thread that set up the watchpoint and briefly stalled was
+	 * signalled that another thread triggered the watchpoint, and thus a
+	 * race was encountered.
+	 */
+	KCSAN_REPORT_RACE_SETUP,
+
+	/*
+	 * A thread encountered a watchpoint for the access, therefore a race
+	 * was encountered.
+	 */
+	KCSAN_REPORT_RACE_CHECK,
+
+	/*
+	 * A thread encountered a watchpoint for the access, but the other
+	 * racing thread can no longer be signaled that a race occurred.
+	 */
+	KCSAN_REPORT_RACE_CHECK_RACE,
+
+	/*
+	 * No other thread was observed to race with the access, but the data
+	 * value before and after the stall differs.
+	 */
+	KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
+};
+/*
+ * Print a race report from thread that encountered the race.
+ */
+void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
+		  int cpu_id, enum kcsan_report_type type);
+
+#endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
new file mode 100644
index 000000000000..6c37b0c1c6da
--- /dev/null
+++ b/kernel/kcsan/report.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/preempt.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/stacktrace.h>
+
+#include "kcsan.h"
+#include "encoding.h"
+
+/*
+ * Max. number of stack entries to show in the report.
+ */
+#define NUM_STACK_ENTRIES 64
+
+/*
+ * Other thread info: communicated from other racing thread to thread that set
+ * up the watchpoint, which then prints the complete report atomically. Only
+ * need one struct, as all threads should to be serialized regardless to print
+ * the reports, with reporting being in the slow-path.
+ */
+static struct {
+	const volatile void *ptr;
+	size_t size;
+	bool is_write;
+	int task_pid;
+	int cpu_id;
+	unsigned long stack_entries[NUM_STACK_ENTRIES];
+	int num_stack_entries;
+} other_info = { .ptr = NULL };
+
+static DEFINE_SPINLOCK(other_info_lock);
+static DEFINE_SPINLOCK(report_lock);
+
+static bool set_or_lock_other_info(unsigned long *flags,
+				   const volatile void *ptr, size_t size,
+				   bool is_write, int cpu_id,
+				   enum kcsan_report_type type)
+{
+	if (type != KCSAN_REPORT_RACE_CHECK && type != KCSAN_REPORT_RACE_SETUP)
+		return true;
+
+	for (;;) {
+		spin_lock_irqsave(&other_info_lock, *flags);
+
+		switch (type) {
+		case KCSAN_REPORT_RACE_CHECK:
+			if (other_info.ptr != NULL) {
+				/* still in use, retry */
+				break;
+			}
+			other_info.ptr = ptr;
+			other_info.size = size;
+			other_info.is_write = is_write;
+			other_info.task_pid =
+				in_task() ? task_pid_nr(current) : -1;
+			other_info.cpu_id = cpu_id;
+			other_info.num_stack_entries = stack_trace_save(
+				other_info.stack_entries, NUM_STACK_ENTRIES, 1);
+			/*
+			 * other_info may now be consumed by thread we raced
+			 * with.
+			 */
+			spin_unlock_irqrestore(&other_info_lock, *flags);
+			return false;
+
+		case KCSAN_REPORT_RACE_SETUP:
+			if (other_info.ptr == NULL)
+				break; /* no data available yet, retry */
+
+			/*
+			 * First check if matching based on how watchpoint was
+			 * encoded.
+			 */
+			if (!matching_access((unsigned long)other_info.ptr &
+						     WATCHPOINT_ADDR_MASK,
+					     other_info.size,
+					     (unsigned long)ptr &
+						     WATCHPOINT_ADDR_MASK,
+					     size))
+				break; /* mismatching access, retry */
+
+			if (!matching_access((unsigned long)other_info.ptr,
+					     other_info.size,
+					     (unsigned long)ptr, size)) {
+				/*
+				 * If the actual accesses to not match, this was
+				 * a false positive due to watchpoint encoding.
+				 */
+				other_info.ptr = NULL; /* mark for reuse */
+				kcsan_counter_inc(
+					KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+				spin_unlock_irqrestore(&other_info_lock,
+						       *flags);
+				return false;
+			}
+
+			/*
+			 * Matching access: keep other_info locked, as this
+			 * thread uses it to print the full report; unlocked in
+			 * end_report.
+			 */
+			return true;
+
+		default:
+			BUG();
+		}
+
+		spin_unlock_irqrestore(&other_info_lock, *flags);
+	}
+}
+
+static void start_report(unsigned long *flags, enum kcsan_report_type type)
+{
+	switch (type) {
+	case KCSAN_REPORT_RACE_SETUP:
+		/* irqsaved already via other_info_lock */
+		spin_lock(&report_lock);
+		break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		spin_lock_irqsave(&report_lock, *flags);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+static void end_report(unsigned long *flags, enum kcsan_report_type type)
+{
+	switch (type) {
+	case KCSAN_REPORT_RACE_SETUP:
+		other_info.ptr = NULL; /* mark for reuse */
+		spin_unlock(&report_lock);
+		spin_unlock_irqrestore(&other_info_lock, *flags);
+		break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		spin_unlock_irqrestore(&report_lock, *flags);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+static const char *get_access_type(bool is_write)
+{
+	return is_write ? "write" : "read";
+}
+
+/* Return thread description: in task or interrupt. */
+static const char *get_thread_desc(int task_id)
+{
+	if (task_id != -1) {
+		static char buf[32]; /* safe: protected by report_lock */
+
+		snprintf(buf, sizeof(buf), "task %i", task_id);
+		return buf;
+	}
+	return "interrupt";
+}
+
+/* Helper to skip KCSAN-related functions in stack-trace. */
+static int get_stack_skipnr(unsigned long stack_entries[], int num_entries)
+{
+	char buf[64];
+	int skip = 0;
+
+	for (; skip < num_entries; ++skip) {
+		snprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
+		if (!strnstr(buf, "csan_", sizeof(buf)) &&
+		    !strnstr(buf, "tsan_", sizeof(buf)) &&
+		    !strnstr(buf, "_once_size", sizeof(buf))) {
+			break;
+		}
+	}
+	return skip;
+}
+
+/* Compares symbolized strings of addr1 and addr2. */
+static int sym_strcmp(void *addr1, void *addr2)
+{
+	char buf1[64];
+	char buf2[64];
+
+	snprintf(buf1, sizeof(buf1), "%pS", addr1);
+	snprintf(buf2, sizeof(buf2), "%pS", addr2);
+	return strncmp(buf1, buf2, sizeof(buf1));
+}
+
+/*
+ * Returns true if a report was generated, false otherwise.
+ */
+static bool print_summary(const volatile void *ptr, size_t size, bool is_write,
+			  int cpu_id, enum kcsan_report_type type)
+{
+	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
+	int num_stack_entries =
+		stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
+	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
+	int other_skipnr;
+
+	/* Check if the top stackframe is in a blacklisted function. */
+	if (kcsan_skip_report(stack_entries[skipnr]))
+		return false;
+	if (type == KCSAN_REPORT_RACE_SETUP) {
+		other_skipnr = get_stack_skipnr(other_info.stack_entries,
+						other_info.num_stack_entries);
+		if (kcsan_skip_report(other_info.stack_entries[other_skipnr]))
+			return false;
+	}
+
+	/* Print report header. */
+	pr_err("==================================================================\n");
+	switch (type) {
+	case KCSAN_REPORT_RACE_SETUP: {
+		void *this_fn = (void *)stack_entries[skipnr];
+		void *other_fn = (void *)other_info.stack_entries[other_skipnr];
+		int cmp;
+
+		/*
+		 * Order functions lexographically for consistent bug titles.
+		 * Do not print offset of functions to keep title short.
+		 */
+		cmp = sym_strcmp(other_fn, this_fn);
+		pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
+		       cmp < 0 ? other_fn : this_fn,
+		       cmp < 0 ? this_fn : other_fn);
+	} break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		pr_err("BUG: KCSAN: data-race in %pS\n",
+		       (void *)stack_entries[skipnr]);
+		break;
+
+	default:
+		BUG();
+	}
+
+	pr_err("\n");
+
+	/* Print information about the racing accesses. */
+	switch (type) {
+	case KCSAN_REPORT_RACE_SETUP:
+		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(other_info.is_write), other_info.ptr,
+		       other_info.size, get_thread_desc(other_info.task_pid),
+		       other_info.cpu_id);
+
+		/* Print the other thread's stack trace. */
+		stack_trace_print(other_info.stack_entries + other_skipnr,
+				  other_info.num_stack_entries - other_skipnr,
+				  0);
+
+		pr_err("\n");
+		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(is_write), ptr, size,
+		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
+		       cpu_id);
+		break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(is_write), ptr, size,
+		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
+		       cpu_id);
+		break;
+
+	default:
+		BUG();
+	}
+	/* Print stack trace of this thread. */
+	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
+			  0);
+
+	/* Print report footer. */
+	pr_err("\n");
+	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
+	dump_stack_print_info(KERN_DEFAULT);
+	pr_err("==================================================================\n");
+
+	return true;
+}
+
+void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
+		  int cpu_id, enum kcsan_report_type type)
+{
+	unsigned long flags = 0;
+
+	if (type == KCSAN_REPORT_RACE_CHECK_RACE)
+		return;
+
+	kcsan_disable_current();
+	if (set_or_lock_other_info(&flags, ptr, size, is_write, cpu_id, type)) {
+		start_report(&flags, type);
+		if (print_summary(ptr, size, is_write, cpu_id, type) &&
+		    panic_on_warn)
+			panic("panic_on_warn set ...\n");
+		end_report(&flags, type);
+	}
+	kcsan_enable_current();
+}
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
new file mode 100644
index 000000000000..0bae63c5ca65
--- /dev/null
+++ b/kernel/kcsan/test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/types.h>
+
+#include "encoding.h"
+
+#define ITERS_PER_TEST 2000
+
+/* Test requirements. */
+static bool test_requires(void)
+{
+	/* random should be initialized for the below tests */
+	return prandom_u32() + prandom_u32() != 0;
+}
+
+/*
+ * Test watchpoint encode and decode: check that encoding some access's info,
+ * and then subsequent decode preserves the access's info.
+ */
+static bool test_encode_decode(void)
+{
+	int i;
+
+	for (i = 0; i < ITERS_PER_TEST; ++i) {
+		size_t size = prandom_u32_max(MAX_ENCODABLE_SIZE) + 1;
+		bool is_write = !!prandom_u32_max(2);
+		unsigned long addr;
+
+		prandom_bytes(&addr, sizeof(addr));
+		if (WARN_ON(!check_encodable(addr, size)))
+			return false;
+
+		/* encode and decode */
+		{
+			const long encoded_watchpoint =
+				encode_watchpoint(addr, size, is_write);
+			unsigned long verif_masked_addr;
+			size_t verif_size;
+			bool verif_is_write;
+
+			/* check special watchpoints */
+			if (WARN_ON(decode_watchpoint(
+				    INVALID_WATCHPOINT, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+			if (WARN_ON(decode_watchpoint(
+				    CONSUMED_WATCHPOINT, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+
+			/* check decoding watchpoint returns same data */
+			if (WARN_ON(!decode_watchpoint(
+				    encoded_watchpoint, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+			if (WARN_ON(verif_masked_addr !=
+				    (addr & WATCHPOINT_ADDR_MASK)))
+				goto fail;
+			if (WARN_ON(verif_size != size))
+				goto fail;
+			if (WARN_ON(is_write != verif_is_write))
+				goto fail;
+
+			continue;
+fail:
+			pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
+			       __func__, is_write ? "write" : "read", size,
+			       addr, encoded_watchpoint,
+			       verif_is_write ? "write" : "read", verif_size,
+			       verif_masked_addr);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/* Test access matching function. */
+static bool test_matching_access(void)
+{
+	if (WARN_ON(!matching_access(10, 1, 10, 1)))
+		return false;
+	if (WARN_ON(!matching_access(10, 2, 11, 1)))
+		return false;
+	if (WARN_ON(!matching_access(10, 1, 9, 2)))
+		return false;
+	if (WARN_ON(matching_access(10, 1, 11, 1)))
+		return false;
+	if (WARN_ON(matching_access(9, 1, 10, 1)))
+		return false;
+	return true;
+}
+
+static int __init kcsan_selftest(void)
+{
+	int passed = 0;
+	int total = 0;
+
+#define RUN_TEST(do_test)                                                      \
+	do {                                                                   \
+		++total;                                                       \
+		if (do_test())                                                 \
+			++passed;                                              \
+		else                                                           \
+			pr_err("KCSAN selftest: " #do_test " failed");         \
+	} while (0)
+
+	RUN_TEST(test_requires);
+	RUN_TEST(test_encode_decode);
+	RUN_TEST(test_matching_access);
+
+	pr_info("KCSAN selftest: %d/%d tests passed\n", passed, total);
+	if (passed != total)
+		panic("KCSAN selftests failed");
+	return 0;
+}
+postcore_initcall(kcsan_selftest);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..35accd1d93de 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2086,6 +2086,8 @@ source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
 
+source "lib/Kconfig.kcsan"
+
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
new file mode 100644
index 000000000000..ffe83a79cfe6
--- /dev/null
+++ b/lib/Kconfig.kcsan
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config HAVE_ARCH_KCSAN
+	bool
+
+menuconfig KCSAN
+	bool "KCSAN: watchpoint-based dynamic data race detector"
+	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
+	default n
+	help
+	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
+	  uses a watchpoint-based sampling approach to detect races. See
+	  <file:Documentation/dev-tools/kcsan.rst> for more details.
+
+if KCSAN
+
+config KCSAN_DEBUG
+	bool "Debugging of KCSAN internals"
+	default n
+
+config KCSAN_SELFTEST
+	bool "Perform short selftests on boot"
+	default y
+	help
+	  Run KCSAN selftests on boot. On test failure, causes kernel to panic.
+
+config KCSAN_EARLY_ENABLE
+	bool "Early enable during boot"
+	default y
+	help
+	  If KCSAN should be enabled globally as soon as possible. KCSAN can
+	  later be enabled/disabled via debugfs.
+
+config KCSAN_NUM_WATCHPOINTS
+	int "Number of available watchpoints"
+	default 64
+	help
+	  Total number of available watchpoints. An address range maps into a
+	  specific watchpoint slot as specified in kernel/kcsan/encoding.h.
+	  Although larger number of watchpoints may not be usable due to
+	  limited number of CPUs, a larger value helps to improve performance
+	  due to reducing cache-line contention. The chosen default is a
+	  conservative value; we should almost never observe "no_capacity"
+	  events (see /sys/kernel/debug/kcsan).
+
+config KCSAN_UDELAY_TASK
+	int "Delay in microseconds (for tasks)"
+	default 80
+	help
+	  For tasks, the microsecond delay after setting up a watchpoint.
+
+config KCSAN_UDELAY_INTERRUPT
+	int "Delay in microseconds (for interrupts)"
+	default 20
+	help
+	  For interrupts, the microsecond delay after setting up a watchpoint.
+	  Interrupts have tighter latency requirements, and their delay should
+	  be lower than for tasks.
+
+config KCSAN_DELAY_RANDOMIZE
+	bool "Randomize above delays"
+	default y
+	help
+	  If delays should be randomized, where the maximum is KCSAN_UDELAY_*.
+	  If false, the chosen delays are always KCSAN_UDELAY_* defined above.
+
+config KCSAN_SKIP_WATCH
+	int "Skip instructions before setting up watchpoint"
+	default 4000
+	help
+	  The number of per-CPU memory operations to skip, before another
+	  watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
+	  memory operations are used to set up a watchpoint. A smaller value
+	  results in more aggressive race detection, whereas a larger value
+	  improves system performance at the cost of missing some races.
+
+config KCSAN_SKIP_WATCH_RANDOMIZE
+	bool "Randomize watchpoint instruction skip count"
+	default y
+	help
+	  If instruction skip count should be randomized, where the maximum is
+	  KCSAN_WATCH_SKIP. If false, the chosen value is always
+	  KCSAN_WATCH_SKIP.
+
+# Note that, while some of the below options could be turned into boot
+# parameters, to optimize for the common use-case, we avoid this because:
+# (a) it would impact performance (and we want to avoid static branch for all
+# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
+# without real benefit. The main purpose of the below options are for use in
+# fuzzer configs to control initially reported data races, and are not expected
+# to be switched frequently by a user. Finally, since the below options hide
+# data races, they should eventually be removed entirely!
+
+config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
+	bool "Report races of unknown origin"
+	default y
+	help
+	  If KCSAN should report races where only one access is known, and the
+	  conflicting access is of unknown origin. This type of race is
+	  reported if it was only possible to infer a race due to a data-value
+	  change while an access is being delayed on a watchpoint.
+
+config KCSAN_IGNORE_ATOMICS
+	bool "Do not instrument marked atomic accesses"
+	default n
+	help
+	  If enabled, never instruments marked atomic accesses. This results in
+	  not reporting data races where one access is atomic and the other is
+	  a plain access.
+
+config KCSAN_PLAIN_WRITE_PRETEND_ONCE
+	bool "Pretend plain writes are WRITE_ONCE"
+	default n
+	help
+	  This option makes KCSAN pretend that all plain writes are WRITE_ONCE.
+	  This option should only be used to prune initial data races found in
+	  existing code.
+
+endif # KCSAN
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..778ab704e3ad 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,6 +24,9 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
+# Used by KCSAN while enabled, avoid recursion.
+KCSAN_SANITIZE_random32.o := n
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o \
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
new file mode 100644
index 000000000000..caf1111a28ae
--- /dev/null
+++ b/scripts/Makefile.kcsan
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+ifdef CONFIG_KCSAN
+
+CFLAGS_KCSAN := -fsanitize=thread
+
+endif # CONFIG_KCSAN
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 179d55af5852..8952f909f7c9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -152,6 +152,16 @@ _c_flags += $(if $(patsubst n%,, \
 	$(CFLAGS_KCOV))
 endif
 
+#
+# Enable KCSAN flags except some files or directories we don't want to check
+# (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
+#
+ifeq ($(CONFIG_KCSAN),y)
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
+	$(CFLAGS_KCSAN))
+endif
+
 # $(srctree)/$(src) for including checkin headers from generated source files
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

