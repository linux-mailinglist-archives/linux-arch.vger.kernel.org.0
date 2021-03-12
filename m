Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C35338296
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhCLAto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 19:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhCLAtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:23 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A4C061574
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:23 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u5so16987653qkj.10
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=kYWK0LnFOZQUSIgVrFyNXnXq3MuC82/VVIJ2++AQu2s=;
        b=oMXK92xYzFFfoJOoKcwJb28jCIk7pb8pDEzOHr256GwfhlElhlOgE4o82w/iz4ZT7d
         +V4cu2LqO0CEJK2kLSkD0Es+Ggg8N+9YIml4D+pvlOhEjBZQRc3xre0UHNTamO4be4b7
         pbfmN2pwlagJ3zLfqw2sddG8ViZFumtR750SHj19i++7MUmkbuqkw4p9hTJpmh47RLOv
         YT+YAfVXE6pR/fa7hX1vOBKlCpGVYb2BX8E8G80cQVeqxUCrCCWXfaTT8ClWQI/rxPJR
         4sJED1wWb/nEpWdlZsKcK8AUiCrJtxME50dsV4qgl/hFHC/tOWHyNld+EzcsLxKvF2Ia
         Fnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=kYWK0LnFOZQUSIgVrFyNXnXq3MuC82/VVIJ2++AQu2s=;
        b=O7BynrVhBO70UExD7Pypvif7cLv8VaIXJpfV2BIFWeoKvWbvkrHVCmnTUqTajllbW5
         TDsEPnijmoaajeX8U/mvXQ6ikKGPFV/dZCqrjbm6u2ZI931bjIlGmzUgE31p42zqKNkv
         6bLlydAwqD/gYmF87zdkUz/+YEA4C4qDWnh3F2mlj2HNaa+a09mAX4RXCwX2FeT5L/7q
         az51FpFkUmDqV4pnm2iI44R2yQGG/qrpXfBrea+NN2Ub8pHWLFQNUsd+ahAg5U+UcvRb
         BMtxnbrNeU42KwZa/J//yxcvJ7eBFR/1lrvdZDt5lRrf5YeFMgqa+ZowYKa6veY00hG6
         lr7A==
X-Gm-Message-State: AOAM5328pn/2bx6cAD7wkQFwsc9zRXuyxJhmX6pNKWA96tMNnL792Qt+
        yYjzUPsBwzRjHX5V/VAfS8a8Z1a9ELi5w5fcCHo=
X-Google-Smtp-Source: ABdhPJwEGVsKx2ovPS4g444wFkX3TkmdaWS9gvqhU/f0Ua52OAgVry8uJvld3sA8rgr4BKG4wtH0DIiz3MjA/nCRz/k=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:51c1:: with SMTP id
 p1mr10485236qvq.39.1615510162641; Thu, 11 Mar 2021 16:49:22 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:03 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 01/17] add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change adds support for Clang=E2=80=99s forward-edge Control Flow
Integrity (CFI) checking. With CONFIG_CFI_CLANG, the compiler
injects a runtime check before each indirect function call to ensure
the target is a valid function with the correct static type. This
restricts possible call targets and makes it more difficult for
an attacker to exploit bugs that allow the modification of stored
function pointers. For more details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

Clang requires CONFIG_LTO_CLANG to be enabled with CFI to gain
visibility to possible call targets. Kernel modules are supported
with Clang=E2=80=99s cross-DSO CFI mode, which allows checking between
independently compiled components.

With CFI enabled, the compiler injects a __cfi_check() function into
the kernel and each module for validating local call targets. For
cross-module calls that cannot be validated locally, the compiler
calls the global __cfi_slowpath_diag() function, which determines
the target module and calls the correct __cfi_check() function. This
patch includes a slowpath implementation that uses __module_address()
to resolve call targets, and with CONFIG_CFI_CLANG_SHADOW enabled, a
shadow map that speeds up module look-ups by ~3x.

Clang implements indirect call checking using jump tables and
offers two methods of generating them. With canonical jump tables,
the compiler renames each address-taken function to <function>.cfi
and points the original symbol to a jump table entry, which passes
__cfi_check() validation. This isn=E2=80=99t compatible with stand-alone
assembly code, which the compiler doesn=E2=80=99t instrument, and would
result in indirect calls to assembly code to fail. Therefore, we
default to using non-canonical jump tables instead, where the compiler
generates a local jump table entry <function>.cfi_jt for each
address-taken function, and replaces all references to the function
with the address of the jump table entry.

Note that because non-canonical jump table addresses are local
to each component, they break cross-module function address
equality. Specifically, the address of a global function will be
different in each module, as it's replaced with the address of a local
jump table entry. If this address is passed to a different module,
it won=E2=80=99t match the address of the same function taken there. This
may break code that relies on comparing addresses passed from other
components.

CFI checking can be disabled in a function with the __nocfi attribute.
Additionally, CFI can be disabled for an entire compilation unit by
filtering out CC_FLAGS_CFI.

By default, CFI failures result in a kernel panic to stop a potential
exploit. CONFIG_CFI_PERMISSIVE enables a permissive mode, where the
kernel prints out a rate-limited warning instead, and allows execution
to continue. This option is helpful for locating type mismatches, but
should only be enabled during development.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile                          |  17 ++
 arch/Kconfig                      |  45 ++++
 include/asm-generic/vmlinux.lds.h |  20 +-
 include/linux/cfi.h               |  41 ++++
 include/linux/compiler-clang.h    |   2 +
 include/linux/compiler_types.h    |   4 +
 include/linux/init.h              |   2 +-
 include/linux/module.h            |  13 +-
 init/Kconfig                      |   2 +-
 kernel/Makefile                   |   4 +
 kernel/cfi.c                      | 329 ++++++++++++++++++++++++++++++
 kernel/module.c                   |  43 ++++
 scripts/Makefile.modfinal         |   2 +-
 13 files changed, 518 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c

diff --git a/Makefile b/Makefile
index 31dcdb3d61fa..41c4bad50d31 100644
--- a/Makefile
+++ b/Makefile
@@ -918,6 +918,23 @@ KBUILD_AFLAGS	+=3D -fno-lto
 export CC_FLAGS_LTO
 endif
=20
+ifdef CONFIG_CFI_CLANG
+CC_FLAGS_CFI	:=3D -fsanitize=3Dcfi \
+		   -fsanitize-cfi-cross-dso \
+		   -fno-sanitize-cfi-canonical-jump-tables \
+		   -fno-sanitize-trap=3Dcfi \
+		   -fno-sanitize-blacklist
+
+ifdef CONFIG_CFI_PERMISSIVE
+CC_FLAGS_CFI	+=3D -fsanitize-recover=3Dcfi
+endif
+
+# If LTO flags are filtered out, we must also filter out CFI.
+CC_FLAGS_LTO	+=3D $(CC_FLAGS_CFI)
+KBUILD_CFLAGS	+=3D $(CC_FLAGS_CFI)
+export CC_FLAGS_CFI
+endif
+
 ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
 KBUILD_CFLAGS +=3D -falign-functions=3D32
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 2bb30673d8e6..57ec663828dc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -693,6 +693,51 @@ config LTO_CLANG_THIN
 	  If unsure, say Y.
 endchoice
=20
+config ARCH_SUPPORTS_CFI_CLANG
+	bool
+	help
+	  An architecture should select this option if it can support Clang's
+	  Control-Flow Integrity (CFI) checking.
+
+config CFI_CLANG
+	bool "Use Clang's Control Flow Integrity (CFI)"
+	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
+	# Clang >=3D 12:
+	# - https://bugs.llvm.org/show_bug.cgi?id=3D46258
+	# - https://bugs.llvm.org/show_bug.cgi?id=3D47479
+	depends on CLANG_VERSION >=3D 120000
+	select KALLSYMS
+	help
+	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
+	  (CFI) checking, where the compiler injects a runtime check to each
+	  indirect function call to ensure the target is a valid function with
+	  the correct static type. This restricts possible call targets and
+	  makes it more difficult for an attacker to exploit bugs that allow
+	  the modification of stored function pointers. More information can be
+	  found from Clang's documentation:
+
+	    https://clang.llvm.org/docs/ControlFlowIntegrity.html
+
+config CFI_CLANG_SHADOW
+	bool "Use CFI shadow to speed up cross-module checks"
+	default y
+	depends on CFI_CLANG && MODULES
+	help
+	  If you select this option, the kernel builds a fast look-up table of
+	  CFI check functions in loaded modules to reduce performance overhead.
+
+	  If unsure, say Y.
+
+config CFI_PERMISSIVE
+	bool "Use CFI in permissive mode"
+	depends on CFI_CLANG
+	help
+	  When selected, Control Flow Integrity (CFI) violations result in a
+	  warning instead of a kernel panic. This option should only be used
+	  for finding indirect call type mismatches during development.
+
+	  If unsure, say N.
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 0331d5d49551..40a9c101565e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -544,6 +544,22 @@
 	. =3D ALIGN((align));						\
 	__end_rodata =3D .;
=20
+
+/*
+ * .text..L.cfi.jumptable.* contain Control-Flow Integrity (CFI)
+ * jump table entries.
+ */
+#ifdef CONFIG_CFI_CLANG
+#define TEXT_CFI_JT							\
+		. =3D ALIGN(PMD_SIZE);					\
+		__cfi_jt_start =3D .;					\
+		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)	\
+		. =3D ALIGN(PMD_SIZE);					\
+		__cfi_jt_end =3D .;
+#else
+#define TEXT_CFI_JT
+#endif
+
 /*
  * Non-instrumentable text section
  */
@@ -570,6 +586,7 @@
 		NOINSTR_TEXT						\
 		*(.text..refcount)					\
 		*(.ref.text)						\
+		TEXT_CFI_JT						\
 	MEM_KEEP(init.text*)						\
 	MEM_KEEP(exit.text*)						\
=20
@@ -974,7 +991,8 @@
  * keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=3D46478
  */
-#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN)
+#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN) || \
+	defined(CONFIG_CFI_CLANG)
 # ifdef CONFIG_CONSTRUCTORS
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
new file mode 100644
index 000000000000..879744aaa6e0
--- /dev/null
+++ b/include/linux/cfi.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2021 Google LLC
+ */
+#ifndef _LINUX_CFI_H
+#define _LINUX_CFI_H
+
+#ifdef CONFIG_CFI_CLANG
+typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
+
+/* Compiler-generated function in each module, and the kernel */
+extern void __cfi_check(uint64_t id, void *ptr, void *diag);
+
+/*
+ * Force the compiler to generate a CFI jump table entry for a function
+ * and store the jump table address to __cfi_jt_<function>.
+ */
+#define __CFI_ADDRESSABLE(fn, __attr) \
+	const void *__cfi_jt_ ## fn __visible __attr =3D (void *)&fn
+
+#ifdef CONFIG_CFI_CLANG_SHADOW
+
+extern void cfi_module_add(struct module *mod, unsigned long base_addr);
+extern void cfi_module_remove(struct module *mod, unsigned long base_addr)=
;
+
+#else
+
+static inline void cfi_module_add(struct module *mod, unsigned long base_a=
ddr) {}
+static inline void cfi_module_remove(struct module *mod, unsigned long bas=
e_addr) {}
+
+#endif /* CONFIG_CFI_CLANG_SHADOW */
+
+#else /* !CONFIG_CFI_CLANG */
+
+#define __CFI_ADDRESSABLE(fn, __attr)
+
+#endif /* CONFIG_CFI_CLANG */
+
+#endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index 04c0a5a717f7..1ff22bdad992 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -55,3 +55,5 @@
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
+
+#define __nocfi		__attribute__((__no_sanitize__("cfi")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.=
h
index e5dd5a4ae946..796935a37e37 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -242,6 +242,10 @@ struct ftrace_likely_data {
 # define __noscs
 #endif
=20
+#ifndef __nocfi
+# define __nocfi
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/init.h b/include/linux/init.h
index 31f54de58429..b3ea15348fbd 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -47,7 +47,7 @@
=20
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(".init.text") __cold  __latent_entropy __noinitr=
etpoline
+#define __init		__section(".init.text") __cold  __latent_entropy __noinitr=
etpoline __nocfi
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
diff --git a/include/linux/module.h b/include/linux/module.h
index 59f094fa6f74..b0bbd3f336c5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -26,6 +26,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
+#include <linux/cfi.h>
=20
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -131,13 +132,17 @@ extern void cleanup_module(void);
 #define module_init(initfn)					\
 	static inline initcall_t __maybe_unused __inittest(void)		\
 	{ return initfn; }					\
-	int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
+	int init_module(void) __copy(initfn)			\
+		__attribute__((alias(#initfn)));		\
+	__CFI_ADDRESSABLE(init_module, __initdata);
=20
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __maybe_unused __exittest(void)		\
 	{ return exitfn; }					\
-	void cleanup_module(void) __copy(exitfn) __attribute__((alias(#exitfn)));
+	void cleanup_module(void) __copy(exitfn)		\
+		__attribute__((alias(#exitfn)));		\
+	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
=20
 #endif
=20
@@ -379,6 +384,10 @@ struct module {
 	const s32 *crcs;
 	unsigned int num_syms;
=20
+#ifdef CONFIG_CFI_CLANG
+	cfi_check_fn cfi_check;
+#endif
+
 	/* Kernel parameters. */
 #ifdef CONFIG_SYSFS
 	struct mutex param_lock;
diff --git a/init/Kconfig b/init/Kconfig
index 22946fe5ded9..2972df4e6060 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2297,7 +2297,7 @@ endif # MODULES
=20
 config MODULES_TREE_LOOKUP
 	def_bool y
-	depends on PERF_EVENTS || TRACING
+	depends on PERF_EVENTS || TRACING || CFI_CLANG
=20
 config INIT_ALL_POSSIBLE
 	bool
diff --git a/kernel/Makefile b/kernel/Makefile
index 320f1f3941b7..e8a6715f38dc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -41,6 +41,9 @@ KCSAN_SANITIZE_kcov.o :=3D n
 UBSAN_SANITIZE_kcov.o :=3D n
 CFLAGS_kcov.o :=3D $(call cc-option, -fno-conserve-stack) -fno-stack-prote=
ctor
=20
+# Don't instrument error handlers
+CFLAGS_REMOVE_cfi.o :=3D $(CC_FLAGS_CFI)
+
 obj-y +=3D sched/
 obj-y +=3D locking/
 obj-y +=3D power/
@@ -111,6 +114,7 @@ obj-$(CONFIG_BPF) +=3D bpf/
 obj-$(CONFIG_KCSAN) +=3D kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) +=3D scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) +=3D static_call.o
+obj-$(CONFIG_CFI_CLANG) +=3D cfi.o
=20
 obj-$(CONFIG_PERF_EVENTS) +=3D events/
=20
diff --git a/kernel/cfi.c b/kernel/cfi.c
new file mode 100644
index 000000000000..8c9ed3f7058a
--- /dev/null
+++ b/kernel/cfi.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clang Control Flow Integrity (CFI) error and slowpath handling.
+ *
+ * Copyright (C) 2021 Google LLC
+ */
+
+#include <linux/hardirq.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+#include <linux/rcupdate.h>
+#include <linux/vmalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
+
+/* Compiler-defined handler names */
+#ifdef CONFIG_CFI_PERMISSIVE
+#define cfi_failure_handler	__ubsan_handle_cfi_check_fail
+#else
+#define cfi_failure_handler	__ubsan_handle_cfi_check_fail_abort
+#endif
+
+static inline void handle_cfi_failure(void *ptr)
+{
+	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE))
+		WARN_RATELIMIT(1, "CFI failure (target: %pS):\n", ptr);
+	else
+		panic("CFI failure (target: %pS)\n", ptr);
+}
+
+#ifdef CONFIG_MODULES
+#ifdef CONFIG_CFI_CLANG_SHADOW
+/*
+ * Index type. A 16-bit index can address at most (2^16)-2 pages (taking
+ * into account SHADOW_INVALID), i.e. ~256M with 4k pages.
+ */
+typedef u16 shadow_t;
+#define SHADOW_INVALID		((shadow_t)~0UL)
+
+struct cfi_shadow {
+	/* Page index for the beginning of the shadow */
+	unsigned long base;
+	/* An array of __cfi_check locations (as indices to the shadow) */
+	shadow_t shadow[1];
+} __packed;
+
+/*
+ * The shadow covers ~128M from the beginning of the module region. If
+ * the region is larger, we fall back to __module_address for the rest.
+ */
+#define __SHADOW_RANGE		(_UL(SZ_128M) >> PAGE_SHIFT)
+
+/* The in-memory size of struct cfi_shadow, always at least one page */
+#define __SHADOW_PAGES		((__SHADOW_RANGE * sizeof(shadow_t)) >> PAGE_SHIFT=
)
+#define SHADOW_PAGES		max(1UL, __SHADOW_PAGES)
+#define SHADOW_SIZE		(SHADOW_PAGES << PAGE_SHIFT)
+
+/* The actual size of the shadow array, minus metadata */
+#define SHADOW_ARR_SIZE		(SHADOW_SIZE - offsetof(struct cfi_shadow, shadow=
))
+#define SHADOW_ARR_SLOTS	(SHADOW_ARR_SIZE / sizeof(shadow_t))
+
+static DEFINE_MUTEX(shadow_update_lock);
+static struct cfi_shadow __rcu *cfi_shadow __read_mostly;
+
+/* Returns the index in the shadow for the given address */
+static inline int ptr_to_shadow(const struct cfi_shadow *s, unsigned long =
ptr)
+{
+	unsigned long index;
+	unsigned long page =3D ptr >> PAGE_SHIFT;
+
+	if (unlikely(page < s->base))
+		return -1; /* Outside of module area */
+
+	index =3D page - s->base;
+
+	if (index >=3D SHADOW_ARR_SLOTS)
+		return -1; /* Cannot be addressed with shadow */
+
+	return (int)index;
+}
+
+/* Returns the page address for an index in the shadow */
+static inline unsigned long shadow_to_ptr(const struct cfi_shadow *s,
+	int index)
+{
+	if (unlikely(index < 0 || index >=3D SHADOW_ARR_SLOTS))
+		return 0;
+
+	return (s->base + index) << PAGE_SHIFT;
+}
+
+/* Returns the __cfi_check function address for the given shadow location =
*/
+static inline unsigned long shadow_to_check_fn(const struct cfi_shadow *s,
+	int index)
+{
+	if (unlikely(index < 0 || index >=3D SHADOW_ARR_SLOTS))
+		return 0;
+
+	if (unlikely(s->shadow[index] =3D=3D SHADOW_INVALID))
+		return 0;
+
+	/* __cfi_check is always page aligned */
+	return (s->base + s->shadow[index]) << PAGE_SHIFT;
+}
+
+static void prepare_next_shadow(const struct cfi_shadow __rcu *prev,
+		struct cfi_shadow *next)
+{
+	int i, index, check;
+
+	/* Mark everything invalid */
+	memset(next->shadow, 0xFF, SHADOW_ARR_SIZE);
+
+	if (!prev)
+		return; /* No previous shadow */
+
+	/* If the base address didn't change, an update is not needed */
+	if (prev->base =3D=3D next->base) {
+		memcpy(next->shadow, prev->shadow, SHADOW_ARR_SIZE);
+		return;
+	}
+
+	/* Convert the previous shadow to the new address range */
+	for (i =3D 0; i < SHADOW_ARR_SLOTS; ++i) {
+		if (prev->shadow[i] =3D=3D SHADOW_INVALID)
+			continue;
+
+		index =3D ptr_to_shadow(next, shadow_to_ptr(prev, i));
+		if (index < 0)
+			continue;
+
+		check =3D ptr_to_shadow(next,
+				shadow_to_check_fn(prev, prev->shadow[i]));
+		if (check < 0)
+			continue;
+
+		next->shadow[index] =3D (shadow_t)check;
+	}
+}
+
+static void add_module_to_shadow(struct cfi_shadow *s, struct module *mod,
+			unsigned long min_addr, unsigned long max_addr)
+{
+	int check_index;
+	unsigned long check =3D (unsigned long)mod->cfi_check;
+	unsigned long ptr;
+
+	if (unlikely(!PAGE_ALIGNED(check))) {
+		pr_warn("cfi: not using shadow for module %s\n", mod->name);
+		return;
+	}
+
+	check_index =3D ptr_to_shadow(s, check);
+	if (check_index < 0)
+		return; /* Module not addressable with shadow */
+
+	/* For each page, store the check function index in the shadow */
+	for (ptr =3D min_addr; ptr <=3D max_addr; ptr +=3D PAGE_SIZE) {
+		int index =3D ptr_to_shadow(s, ptr);
+
+		if (index >=3D 0) {
+			/* Each page must only contain one module */
+			WARN_ON_ONCE(s->shadow[index] !=3D SHADOW_INVALID);
+			s->shadow[index] =3D (shadow_t)check_index;
+		}
+	}
+}
+
+static void remove_module_from_shadow(struct cfi_shadow *s, struct module =
*mod,
+		unsigned long min_addr, unsigned long max_addr)
+{
+	unsigned long ptr;
+
+	for (ptr =3D min_addr; ptr <=3D max_addr; ptr +=3D PAGE_SIZE) {
+		int index =3D ptr_to_shadow(s, ptr);
+
+		if (index >=3D 0)
+			s->shadow[index] =3D SHADOW_INVALID;
+	}
+}
+
+typedef void (*update_shadow_fn)(struct cfi_shadow *, struct module *,
+			unsigned long min_addr, unsigned long max_addr);
+
+static void update_shadow(struct module *mod, unsigned long base_addr,
+		update_shadow_fn fn)
+{
+	struct cfi_shadow *prev;
+	struct cfi_shadow *next;
+	unsigned long min_addr, max_addr;
+
+	next =3D vmalloc(SHADOW_SIZE);
+
+	mutex_lock(&shadow_update_lock);
+	prev =3D rcu_dereference_protected(cfi_shadow,
+					 mutex_is_locked(&shadow_update_lock));
+
+	if (next) {
+		next->base =3D base_addr >> PAGE_SHIFT;
+		prepare_next_shadow(prev, next);
+
+		min_addr =3D (unsigned long)mod->core_layout.base;
+		max_addr =3D min_addr + mod->core_layout.text_size;
+		fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
+
+		set_memory_ro((unsigned long)next, SHADOW_PAGES);
+	}
+
+	rcu_assign_pointer(cfi_shadow, next);
+	mutex_unlock(&shadow_update_lock);
+	synchronize_rcu_expedited();
+
+	if (prev) {
+		set_memory_rw((unsigned long)prev, SHADOW_PAGES);
+		vfree(prev);
+	}
+}
+
+void cfi_module_add(struct module *mod, unsigned long base_addr)
+{
+	update_shadow(mod, base_addr, add_module_to_shadow);
+}
+
+void cfi_module_remove(struct module *mod, unsigned long base_addr)
+{
+	update_shadow(mod, base_addr, remove_module_from_shadow);
+}
+
+static inline cfi_check_fn ptr_to_check_fn(const struct cfi_shadow __rcu *=
s,
+	unsigned long ptr)
+{
+	int index;
+
+	if (unlikely(!s))
+		return NULL; /* No shadow available */
+
+	index =3D ptr_to_shadow(s, ptr);
+	if (index < 0)
+		return NULL; /* Cannot be addressed with shadow */
+
+	return (cfi_check_fn)shadow_to_check_fn(s, index);
+}
+
+static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
+{
+	cfi_check_fn fn;
+
+	rcu_read_lock_sched();
+	fn =3D ptr_to_check_fn(rcu_dereference_sched(cfi_shadow), ptr);
+	rcu_read_unlock_sched();
+
+	return fn;
+}
+
+#else /* !CONFIG_CFI_CLANG_SHADOW */
+
+static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_CFI_CLANG_SHADOW */
+
+static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
+{
+	cfi_check_fn fn =3D NULL;
+	struct module *mod;
+
+	rcu_read_lock_sched();
+	mod =3D __module_address(ptr);
+	if (mod)
+		fn =3D mod->cfi_check;
+	rcu_read_unlock_sched();
+
+	return fn;
+}
+
+static inline cfi_check_fn find_check_fn(unsigned long ptr)
+{
+	cfi_check_fn fn =3D NULL;
+
+	if (is_kernel_text(ptr))
+		return __cfi_check;
+
+	/*
+	 * Indirect call checks can happen when RCU is not watching. Both
+	 * the shadow and __module_address use RCU, so we need to wake it
+	 * up if necessary.
+	 */
+	RCU_NONIDLE({
+		if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
+			fn =3D find_shadow_check_fn(ptr);
+
+		if (!fn)
+			fn =3D find_module_check_fn(ptr);
+	});
+
+	return fn;
+}
+
+void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+{
+	cfi_check_fn fn =3D find_check_fn((unsigned long)ptr);
+
+	if (likely(fn))
+		fn(id, ptr, diag);
+	else /* Don't allow unchecked modules */
+		handle_cfi_failure(ptr);
+}
+EXPORT_SYMBOL(__cfi_slowpath_diag);
+
+#else /* !CONFIG_MODULES */
+
+void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+{
+	handle_cfi_failure(ptr); /* No modules */
+}
+EXPORT_SYMBOL(__cfi_slowpath_diag);
+
+#endif /* CONFIG_MODULES */
+
+void cfi_failure_handler(void *data, void *ptr, void *vtable)
+{
+	handle_cfi_failure(ptr);
+}
+EXPORT_SYMBOL(cfi_failure_handler);
diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..20fb004e7d8d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2146,6 +2146,8 @@ void __weak module_arch_freeing_init(struct module *m=
od)
 {
 }
=20
+static void cfi_cleanup(struct module *mod);
+
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -2187,6 +2189,9 @@ static void free_module(struct module *mod)
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
=20
+	/* Clean up CFI for the module. */
+	cfi_cleanup(mod);
+
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
@@ -3866,6 +3871,8 @@ static int unknown_module_param_cb(char *param, char =
*val, const char *modname,
 	return 0;
 }
=20
+static void cfi_init(struct module *mod);
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3997,6 +4004,9 @@ static int load_module(struct load_info *info, const =
char __user *uargs,
=20
 	flush_module_icache(mod);
=20
+	/* Setup CFI for the module. */
+	cfi_init(mod);
+
 	/* Now copy in args */
 	mod->args =3D strndup_user(uargs, ~0UL >> 1);
 	if (IS_ERR(mod->args)) {
@@ -4070,6 +4080,7 @@ static int load_module(struct load_info *info, const =
char __user *uargs,
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
+	cfi_cleanup(mod);
 	module_arch_cleanup(mod);
  free_modinfo:
 	free_modinfo(mod);
@@ -4415,6 +4426,38 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
 const char *,
 #endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
=20
+static void cfi_init(struct module *mod)
+{
+#ifdef CONFIG_CFI_CLANG
+	initcall_t *init;
+	exitcall_t *exit;
+
+	rcu_read_lock_sched();
+	mod->cfi_check =3D (cfi_check_fn)
+		find_kallsyms_symbol_value(mod, "__cfi_check");
+	init =3D (initcall_t *)
+		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
+	exit =3D (exitcall_t *)
+		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
+	rcu_read_unlock_sched();
+
+	/* Fix init/exit functions to point to the CFI jump table */
+	if (init)
+		mod->init =3D *init;
+	if (exit)
+		mod->exit =3D *exit;
+
+	cfi_module_add(mod, module_addr_min);
+#endif
+}
+
+static void cfi_cleanup(struct module *mod)
+{
+#ifdef CONFIG_CFI_CLANG
+	cfi_module_remove(mod, module_addr_min);
+#endif
+}
+
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
=20
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 735e11e9041b..dd87cea9fba7 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname =3D $(notdir $(@:.mod.o=3D))
 part-of-module =3D y
=20
 quiet_cmd_cc_o_c =3D CC [M]  $@
-      cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $@ $<
+      cmd_cc_o_c =3D $(CC) $(filter-out $(CC_FLAGS_CFI), $(c_flags)) -c -o=
 $@ $<
=20
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
--=20
2.31.0.rc2.261.g7f71774620-goog

