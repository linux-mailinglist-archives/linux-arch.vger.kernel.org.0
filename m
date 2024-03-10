Return-Path: <linux-arch+bounces-2918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42687751A
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE46281A4B
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CF3B197;
	Sun, 10 Mar 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYGgxAod"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982893A8CD
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036368; cv=none; b=H2t1g2Z4C4z9dfSqO7VlJoBrBSxqfQZLV4Mp4XeMeBEOx1ARcjsuqjRqEmGiEI0Eteyak9dZOG9LDDg7XWs2/HhCkQnPDpNe2ThOFrH/+ILhysemSPoN4CJlWUr2WDBQn2EQdzrr0P09BPZjLyTofsRD4dqSvufPt2pp3iPZQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036368; c=relaxed/simple;
	bh=D+WVQMhwRypD8nl8dEaKGNc4FgLhg4MD7Y3hz1hpLdc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GZsszM01lFC8ol23CDy5sG0D4z18qq+79X7NP0va12HaB15kb4v/h1RxBqbxmPKaD5ai4gQ9rL4SaAbOrux7vf2zEtrx0SsJOSbmyz6ubP9WcqxT0hsLOrpoSRf+pTS7hi9+xsKIjPxTaXo8xd01Kjd0UtWe6K8ectSsovFS5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYGgxAod; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fd9b371eso39965637b3.2
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036363; x=1710641163; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRqsfboWv5Zh6OH/JuRhFYk4oui3DIZMw9JEaY/sNCw=;
        b=eYGgxAodmEMN8sV+P3coMLUDPJsg2JJyffk8MlIl6PX6OmDVo6oHqWh7gUL5459SPo
         I79aCyu/FqPyqDz+sQhRGCkDAr0PKOI+qwr3CTV5CvuGsulOQ+p8i47OJG2MklTRK3ea
         FeR8WVkYW28zsEkooMAnR7dzyGGo/kGASO0zI2cXmjLU4lo1B9r6VIforrCXThC9XF4S
         dp2y5pYFS3oARNS5foTAQVrCScrC6gqv81CA8SNU5ZFrnt+O/TdkP0cDO0iyNVAxzj/E
         vfby3thyryEjSK/hS3Fm7bA8G34pxcNsiO7iQ2r00dkRW0hB6mZ1GeAMsl9h7/CYLC6a
         bHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036363; x=1710641163;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRqsfboWv5Zh6OH/JuRhFYk4oui3DIZMw9JEaY/sNCw=;
        b=fUgAGwXaZW9JfDM0HTP2xcWJhpD4vEt+hgU9maH0q/okOYY7k33ojArOC/cV1ZdlPw
         i+1qHq1+QE/yJdYa1+wXm3mmctgIZaCJqkFN0h0u4zRKeXjLDUk2B7yT/pzOMKvjPdt/
         71n/zLU0/eue10LgC368SYtb5MXHnEsUjM+9+z2mAKcRaernWWCaFUCQXG3EbNmrEmrg
         P2n3G/9o9X5fIvJB1ah4MMayuRTUyjxMNl000oxLht0zLkEt2FpLbnt0GmZbMtu+zMHM
         tHvSxRQPG1KlATCUWAPSTMBGo35eYn85gYWE5oaL9F66584emQ9VlykgslkNQg/Ru+Lk
         l0sw==
X-Forwarded-Encrypted: i=1; AJvYcCVet/LM8EWa1wYRxpk2Q2ww+gq/kqta+A4mA/dDPdFImVg2R4yRWtxp02c0T1CYaD7Dftlf3dW/KKBxNdLnWpyW+/Ap1N1/bxnpjw==
X-Gm-Message-State: AOJu0Yz3CL3iowPBXlzbZAxmAJC2UKHA6gjFY7BTeb3t5OBEVOq1bvM+
	YW9EpXk59PMeSKhAo7y8xXVYjMUq7uzD6hL+VE8QOa5NQqy1Mss+5v/MTbpmANe+qEkhNX7f1/M
	U1UMDRg==
X-Google-Smtp-Source: AGHT+IGwpyvJDe4STLMxiIjv/94D/Vemn22ewF6Ekh50t8w85TdxO+eKEEet39Wy/WMstNvxkG1x6+NrSLj4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a81:6cc8:0:b0:608:4cec:3e65 with SMTP id
 h191-20020a816cc8000000b006084cec3e65mr792184ywc.5.1710036362654; Sat, 09 Mar
 2024 18:06:02 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:07 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/13] tools headers: Sync compiler.h headers
From: Ian Rogers <irogers@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

compiler.h - synced from include/linux/compiler.h, guards were
 added to definitions to avoid redefinition of macros
 in libc. ftrace, CONFIG_OBJTOOL and kentry logic was removed as
 redundant.

compiler-gcc.h - synced from include/linux/compiler-gcc.h

compiler-clang.h - added from include/linux/compiler-gcc.h

compiler_attributes.h - added from
 include/linux/compiler_attributes.h,
 guards were added to definitions to avoid redefinition of macros
 in libc.

compiler_types.h - added from include/linux/compiler_types.h,
 guards were added to definitions to avoid redefinition of macros
 in libc.

asm/rwonce.h - added as dependency of compiler.h but added from
 asm-generic/rwonce.h.

asm-generic/bitops/non-atomic.h - add linux/types.h so that bool
 is defined. This file is heavily forked from the kernel one and
 so synchronizing with the kernel version was infeasible.

rbtree.h - add linux/types.h so that bool is defined. This file
 is heavily forked from the kernel one and so synchronizing with
 the kernel version was infeasible.

string.h - add compiler.h include as definitions from types.h
 were removed to avoid compiler.h collisions. This file is
 heavily forked from the kernel one and so synchronizing with the
 kernel version was infeasible.

types.h - remove __must_check definition that conflicts with
 compiler.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/asm-generic/bitops/non-atomic.h |   1 +
 tools/include/asm/rwonce.h                    |  63 +++
 tools/include/linux/compiler-clang.h          | 124 +++++
 tools/include/linux/compiler-gcc.h            | 145 +++++-
 tools/include/linux/compiler.h                | 221 ++-------
 tools/include/linux/compiler_attributes.h     | 449 ++++++++++++++++++
 tools/include/linux/compiler_types.h          | 171 ++++++-
 tools/include/linux/rbtree.h                  |   1 +
 tools/include/linux/string.h                  |   1 +
 tools/include/linux/types.h                   |   2 +-
 10 files changed, 968 insertions(+), 210 deletions(-)
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/include/linux/compiler-clang.h
 create mode 100644 tools/include/linux/compiler_attributes.h

diff --git a/tools/include/asm-generic/bitops/non-atomic.h b/tools/include/asm-generic/bitops/non-atomic.h
index 0c472a833408..5266796df48c 100644
--- a/tools/include/asm-generic/bitops/non-atomic.h
+++ b/tools/include/asm-generic/bitops/non-atomic.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
 
 #include <linux/bits.h>
+#include <linux/types.h> /* for bool */
 
 /**
  * ___set_bit - Set a bit in memory
diff --git a/tools/include/asm/rwonce.h b/tools/include/asm/rwonce.h
new file mode 100644
index 000000000000..9d61f0c87371
--- /dev/null
+++ b/tools/include/asm/rwonce.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Prevent the compiler from merging or refetching reads or writes. The
+ * compiler is also forbidden from reordering successive instances of
+ * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
+ * particular ordering. One way to make the compiler aware of ordering is to
+ * put the two invocations of READ_ONCE or WRITE_ONCE in different C
+ * statements.
+ *
+ * These two macros will also work on aggregate data types like structs or
+ * unions.
+ *
+ * Their two major use cases are: (1) Mediating communication between
+ * process-level code and irq/NMI handlers, all running on the same CPU,
+ * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
+ * mutilate accesses that either do not require ordering or that interact
+ * with an explicit memory barrier or atomic instruction that provides the
+ * required ordering.
+ */
+#ifndef __ASM_GENERIC_RWONCE_H
+#define __ASM_GENERIC_RWONCE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler_types.h>
+
+/*
+ * Yes, this permits 64-bit accesses on 32-bit architectures. These will
+ * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
+ * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
+ * (e.g. a virtual address) and a strong prevailing wind.
+ */
+#define compiletime_assert_rwonce_type(t)					\
+	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
+		"Unsupported access size for {READ,WRITE}_ONCE().")
+
+/*
+ * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+ * atomicity. Note that this may result in tears!
+ */
+#ifndef __READ_ONCE
+#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#endif
+
+#define READ_ONCE(x)							\
+({									\
+	compiletime_assert_rwonce_type(x);				\
+	__READ_ONCE(x);							\
+})
+
+#define __WRITE_ONCE(x, val)						\
+do {									\
+	*(volatile typeof(x) *)&(x) = (val);				\
+} while (0)
+
+#define WRITE_ONCE(x, val)						\
+do {									\
+	compiletime_assert_rwonce_type(x);				\
+	__WRITE_ONCE(x, val);						\
+} while (0)
+
+#endif /* __ASSEMBLY__ */
+#endif	/* __ASM_GENERIC_RWONCE_H */
diff --git a/tools/include/linux/compiler-clang.h b/tools/include/linux/compiler-clang.h
new file mode 100644
index 000000000000..ddab1ef22bee
--- /dev/null
+++ b/tools/include/linux/compiler-clang.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_COMPILER_TYPES_H
+#error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/* Compiler specific definitions for Clang compiler */
+
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://reviews.llvm.org/D152180
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
+/* all clang versions usable with the kernel support KASAN ABI version 5 */
+#define KASAN_ABI_VERSION 5
+
+/*
+ * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
+ * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
+ * to avoid adding redundant attributes in other configurations.
+ */
+
+#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
+/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
+#define __SANITIZE_ADDRESS__
+#define __no_sanitize_address \
+		__attribute__((no_sanitize("address", "hwaddress")))
+#else
+#define __no_sanitize_address
+#endif
+
+#if __has_feature(thread_sanitizer)
+/* emulate gcc's __SANITIZE_THREAD__ flag */
+#define __SANITIZE_THREAD__
+#define __no_sanitize_thread \
+		__attribute__((no_sanitize("thread")))
+#else
+#define __no_sanitize_thread
+#endif
+
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#define __HAVE_BUILTIN_BSWAP16__
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
+
+#if __has_feature(undefined_behavior_sanitizer)
+/* GCC does not have __SANITIZE_UNDEFINED__ */
+#define __no_sanitize_undefined \
+		__attribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
+
+#if __has_feature(memory_sanitizer)
+#define __SANITIZE_MEMORY__
+/*
+ * Unlike other sanitizers, KMSAN still inserts code into functions marked with
+ * no_sanitize("kernel-memory"). Using disable_sanitizer_instrumentation
+ * provides the behavior consistent with other __no_sanitize_ attributes,
+ * guaranteeing that __no_sanitize_memory functions remain uninstrumented.
+ */
+#define __no_sanitize_memory __disable_sanitizer_instrumentation
+
+/*
+ * The __no_kmsan_checks attribute ensures that a function does not produce
+ * false positive reports by:
+ *  - initializing all local variables and memory stores in this function;
+ *  - skipping all shadow checks;
+ *  - passing initialized arguments to this function's callees.
+ */
+#define __no_kmsan_checks __attribute__((no_sanitize("kernel-memory")))
+#else
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+#endif
+
+/*
+ * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
+ * with no_sanitize("coverage"). Prior versions of Clang support coverage
+ * instrumentation, but cannot be queried for support by the preprocessor.
+ */
+#if __has_feature(coverage_sanitizer)
+#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
+#else
+#define __no_sanitize_coverage
+#endif
+
+#if __has_feature(shadow_call_stack)
+# define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
+#endif
+
+#if __has_feature(kcfi)
+/* Disable CFI checking inside a function. */
+#define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+#endif
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_clang(version, severity, s) \
+	__diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore	ignored
+#define __diag_clang_warn	warning
+#define __diag_clang_error	error
+
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
+
+#if CONFIG_CLANG_VERSION >= 110000
+#define __diag_clang_11(s)	__diag(s)
+#else
+#define __diag_clang_11(s)
+#endif
+
+#define __diag_ignore_all(option, comment) \
+	__diag_clang(11, ignore, option)
diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 62e7c901ac28..aebb65bf95a7 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -1,42 +1,147 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TOOLS_LINUX_COMPILER_H_
+#ifndef __LINUX_COMPILER_TYPES_H
 #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
 #endif
 
 /*
  * Common definitions for all gcc versions go here.
  */
-#ifndef GCC_VERSION
 #define GCC_VERSION (__GNUC__ * 10000		\
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
+
+/*
+ * This macro obfuscates arithmetic on a variable address so that gcc
+ * shouldn't recognize the original var, and make assumptions about it.
+ *
+ * This is needed because the C standard makes it undefined to do
+ * pointer arithmetic on "objects" outside their boundaries and the
+ * gcc optimizers assume this is the case. In particular they
+ * assume such arithmetic does not wrap.
+ *
+ * A miscompilation has been observed because of this on PPC.
+ * To work around it we hide the relationship of the pointer and the object
+ * using this macro.
+ *
+ * Versions of the ppc64 compiler before 4.1 had a bug where use of
+ * RELOC_HIDE could trash r30. The bug can be worked around by changing
+ * the inline assembly constraint from =g to =r, in this particular
+ * case either is valid.
+ */
+#define RELOC_HIDE(ptr, off)						\
+({									\
+	unsigned long __ptr;						\
+	__asm__ ("" : "=r"(__ptr) : "0"(ptr));				\
+	(typeof(ptr)) (__ptr + (off));					\
+})
+
+#ifdef CONFIG_RETPOLINE
+#define __noretpoline __attribute__((__indirect_branch__("keep")))
+#endif
+
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
+#define __latent_entropy __attribute__((latent_entropy))
 #endif
 
-#if __has_attribute(__fallthrough__)
-# define fallthrough                    __attribute__((__fallthrough__))
+/*
+ * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
+ * confuse the stack allocation in gcc, leading to overly large stack
+ * frames, see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
+ *
+ * Adding an empty inline assembly before it works around the problem
+ */
+#define barrier_before_unreachable() asm volatile("")
+
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ */
+#define unreachable() \
+	do {					\
+		annotate_unreachable();		\
+		barrier_before_unreachable();	\
+		__builtin_unreachable();	\
+	} while (0)
+
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#define __HAVE_BUILTIN_BSWAP16__
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
+
+#if GCC_VERSION >= 70000
+#define KASAN_ABI_VERSION 5
 #else
-# define fallthrough                    do {} while (0)  /* fallthrough */
+#define KASAN_ABI_VERSION 4
 #endif
 
-#if __has_attribute(__error__)
-# define __compiletime_error(message) __attribute__((error(message)))
+#ifdef CONFIG_SHADOW_CALL_STACK
+#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 
-#ifndef __pure
-#define  __pure		__attribute__((pure))
+#if defined(__SANITIZE_THREAD__)
+#define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
+#else
+#define __no_sanitize_thread
 #endif
-#define  noinline	__attribute__((noinline))
-#ifndef __packed
-#define __packed	__attribute__((packed))
+
+#define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
+
+/*
+ * Only supported since gcc >= 12
+ */
+#if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
+#define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
+#else
+#define __no_sanitize_coverage
 #endif
-#ifndef __noreturn
-#define __noreturn	__attribute__((noreturn))
+
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel,
+ * matching the defines used by Clang.
+ */
+#ifdef __SANITIZE_HWADDRESS__
+#define __SANITIZE_ADDRESS__
+#endif
+
+/*
+ * GCC does not support KMSAN.
+ */
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_GCC(version, severity, s) \
+	__diag_GCC_ ## version(__diag_GCC_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_GCC_ignore	ignored
+#define __diag_GCC_warn		warning
+#define __diag_GCC_error	error
+
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
+
+#if GCC_VERSION >= 80000
+#define __diag_GCC_8(s)		__diag(s)
+#else
+#define __diag_GCC_8(s)
 #endif
-#ifndef __aligned
-#define __aligned(x)	__attribute__((aligned(x)))
+
+#define __diag_ignore_all(option, comment) \
+	__diag(__diag_GCC_ignore option)
+
+/*
+ * Prior to 9.1, -Wno-alloc-size-larger-than (and therefore the "alloc_size"
+ * attribute) do not work, and must be disabled.
+ */
+#if GCC_VERSION < 90100
+#undef __alloc_size__
 #endif
-#define __printf(a, b)	__attribute__((format(printf, a, b)))
-#define __scanf(a, b)	__attribute__((format(scanf, a, b)))
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 7b65566f3e42..968d025ca8c1 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -4,65 +4,49 @@
 
 #include <linux/compiler_types.h>
 
-#ifndef __compiletime_error
-# define __compiletime_error(message)
+#ifndef likely
+# define likely(x)	__builtin_expect(!!(x), 1)
 #endif
-
-#ifdef __OPTIMIZE__
-# define __compiletime_assert(condition, msg, prefix, suffix)		\
-	do {								\
-		extern void prefix ## suffix(void) __compiletime_error(msg); \
-		if (!(condition))					\
-			prefix ## suffix();				\
-	} while (0)
-#else
-# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
+#ifndef unlikely
+# define unlikely(x)	__builtin_expect(!!(x), 0)
 #endif
 
-#define _compiletime_assert(condition, msg, prefix, suffix) \
-	__compiletime_assert(condition, msg, prefix, suffix)
-
-/**
- * compiletime_assert - break build and emit msg if condition is false
- * @condition: a compile-time constant condition to check
- * @msg:       a message to emit if condition is false
- *
- * In tradition of POSIX assert, this macro will break the build if the
- * supplied condition is *false*, emitting the supplied error message if the
- * compiler has support to do so.
- */
-#define compiletime_assert(condition, msg) \
-	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
-
 /* Optimization barrier */
+#ifndef barrier
 /* The "volatile" is due to gcc bugs */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
-#ifndef __always_inline
-# define __always_inline	inline __attribute__((always_inline))
-#endif
-
-#ifndef __always_unused
-#define __always_unused __attribute__((__unused__))
+# define barrier() __asm__ __volatile__("": : :"memory")
 #endif
 
-#ifndef __noreturn
-#define __noreturn __attribute__((__noreturn__))
+#ifndef barrier_data
+/*
+ * This version is i.e. to prevent dead stores elimination on @ptr
+ * where gcc and llvm may behave differently when otherwise using
+ * normal barrier(): while gcc behavior gets along with a normal
+ * barrier(), llvm needs an explicit input variable to be assumed
+ * clobbered. The issue is as follows: while the inline asm might
+ * access any memory it wants, the compiler could have fit all of
+ * @ptr into memory registers instead, and since @ptr never escaped
+ * from that, it proved that the inline asm wasn't touching any of
+ * it. This version works well with both compilers, i.e. we're telling
+ * the compiler that the inline asm absolutely may see the contents
+ * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
+ */
+# define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
 #endif
 
 #ifndef unreachable
-#define unreachable() __builtin_unreachable()
-#endif
-
-#ifndef noinline
-#define noinline
+# define unreachable() do {		\
+	annotate_unreachable();		\
+	__builtin_unreachable();	\
+} while (0)
 #endif
 
-/* Are two types/vars the same type (ignoring qualifiers)? */
-#ifndef __same_type
-# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+#ifndef __must_be_array
+/* &a[0] degrades to a pointer: a different type from an array */
+# define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #endif
 
+#ifndef __is_constexpr
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
@@ -70,150 +54,19 @@
  */
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+#endif
 
-#ifdef __ANDROID__
 /*
- * FIXME: Big hammer to get rid of tons of:
- *   "warning: always_inline function might not be inlinable"
- *
- * At least on android-ndk-r12/platforms/android-24/arch-arm
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types.
  */
-#undef __always_inline
-#define __always_inline	inline
-#endif
-
-#define __user
-#define __rcu
-#define __read_mostly
-
-#ifndef __attribute_const__
-# define __attribute_const__
-#endif
-
-#ifndef __maybe_unused
-# define __maybe_unused		__attribute__((unused))
-#endif
-
-#ifndef __used
-# define __used		__attribute__((__unused__))
-#endif
-
-#ifndef __packed
-# define __packed		__attribute__((__packed__))
-#endif
-
-#ifndef __force
-# define __force
-#endif
-
-#ifndef __weak
-# define __weak			__attribute__((weak))
-#endif
-
-#ifndef likely
-# define likely(x)		__builtin_expect(!!(x), 1)
+#ifndef is_signed_type
+# define is_signed_type(type) (((type)(-1)) < (__force type)1)
 #endif
-
-#ifndef unlikely
-# define unlikely(x)		__builtin_expect(!!(x), 0)
-#endif
-
-#ifndef __init
-# define __init
+#ifndef is_unsigned_type
+# define is_unsigned_type(type) (!is_signed_type(type))
 #endif
 
-#include <linux/types.h>
-
-/*
- * Following functions are taken from kernel sources and
- * break aliasing rules in their original form.
- *
- * While kernel is compiled with -fno-strict-aliasing,
- * perf uses -Wstrict-aliasing=3 which makes build fail
- * under gcc 4.4.
- *
- * Using extra __may_alias__ type to allow aliasing
- * in this case.
- */
-typedef __u8  __attribute__((__may_alias__))  __u8_alias_t;
-typedef __u16 __attribute__((__may_alias__)) __u16_alias_t;
-typedef __u32 __attribute__((__may_alias__)) __u32_alias_t;
-typedef __u64 __attribute__((__may_alias__)) __u64_alias_t;
-
-static __always_inline void __read_once_size(const volatile void *p, void *res, int size)
-{
-	switch (size) {
-	case 1: *(__u8_alias_t  *) res = *(volatile __u8_alias_t  *) p; break;
-	case 2: *(__u16_alias_t *) res = *(volatile __u16_alias_t *) p; break;
-	case 4: *(__u32_alias_t *) res = *(volatile __u32_alias_t *) p; break;
-	case 8: *(__u64_alias_t *) res = *(volatile __u64_alias_t *) p; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)res, (const void *)p, size);
-		barrier();
-	}
-}
-
-static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-{
-	switch (size) {
-	case 1: *(volatile  __u8_alias_t *) p = *(__u8_alias_t  *) res; break;
-	case 2: *(volatile __u16_alias_t *) p = *(__u16_alias_t *) res; break;
-	case 4: *(volatile __u32_alias_t *) p = *(__u32_alias_t *) res; break;
-	case 8: *(volatile __u64_alias_t *) p = *(__u64_alias_t *) res; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)p, (const void *)res, size);
-		barrier();
-	}
-}
-
-/*
- * Prevent the compiler from merging or refetching reads or writes. The
- * compiler is also forbidden from reordering successive instances of
- * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
- * particular ordering. One way to make the compiler aware of ordering is to
- * put the two invocations of READ_ONCE or WRITE_ONCE in different C
- * statements.
- *
- * These two macros will also work on aggregate data types like structs or
- * unions. If the size of the accessed data type exceeds the word size of
- * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
- * fall back to memcpy and print a compile-time warning.
- *
- * Their two major use cases are: (1) Mediating communication between
- * process-level code and irq/NMI handlers, all running on the same CPU,
- * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
- * mutilate accesses that either do not require ordering or that interact
- * with an explicit memory barrier or atomic instruction that provides the
- * required ordering.
- */
-
-#define READ_ONCE(x)					\
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__c = { 0 } };			\
-	__read_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
-
-#define WRITE_ONCE(x, val)				\
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (val) }; 			\
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
-
-
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a, b) a##b
-#define __PASTE(a, b) ___PASTE(a, b)
-
-#ifndef OPTIMIZER_HIDE_VAR
-/* Make the optimizer believe the variable can be manipulated arbitrarily. */
-#define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
-#endif
+#include <asm/rwonce.h>
 
 #endif /* _TOOLS_LINUX_COMPILER_H */
diff --git a/tools/include/linux/compiler_attributes.h b/tools/include/linux/compiler_attributes.h
new file mode 100644
index 000000000000..9bfaec783e48
--- /dev/null
+++ b/tools/include/linux/compiler_attributes.h
@@ -0,0 +1,449 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_COMPILER_ATTRIBUTES_H
+#define __LINUX_COMPILER_ATTRIBUTES_H
+
+/*
+ * The attributes in this file are unconditionally defined and they directly
+ * map to compiler attribute(s), unless one of the compilers does not support
+ * the attribute. In that case, __has_attribute is used to check for support
+ * and the reason is stated in its comment ("Optional: ...").
+ *
+ * Note, in the tools/include version the definitions are conditional to avoid
+ * conflicts with libc.
+ *
+ * Any other "attributes" (i.e. those that depend on a configuration option,
+ * on a compiler, on an architecture, on plugins, on other attributes...)
+ * should be defined elsewhere (e.g. compiler_types.h or compiler-*.h).
+ * The intention is to keep this file as simple as possible, as well as
+ * compiler- and version-agnostic (e.g. avoiding GCC_VERSION checks).
+ *
+ * This file is meant to be sorted (by actual attribute name,
+ * not by #define identifier). Use the __attribute__((__name__)) syntax
+ * (i.e. with underscores) to avoid future collisions with other macros.
+ * Provide links to the documentation of each supported compiler, if it exists.
+ */
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
+ */
+#ifndef __alias
+# define __alias(symbol)                 __attribute__((__alias__(#symbol)))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-aligned-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-aligned-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-aligned-variable-attribute
+ */
+#ifndef __aligned
+# define __aligned(x)                    __attribute__((__aligned__(x)))
+#endif
+#ifndef __aligned_largest
+# define __aligned_largest               __attribute__((__aligned__))
+#endif
+
+/*
+ * Note: do not use this directly. Instead, use __alloc_size() since it is conditionally
+ * available and includes other attributes. For GCC < 9.1, __alloc_size__ gets undefined
+ * in compiler-gcc.h, due to misbehaviors.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
+ */
+//#ifndef __alloc_size__
+//# define __alloc_size__(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
+//#endif
+
+/*
+ * Note: users of __always_inline currently do not write "inline" themselves,
+ * which seems to be required by gcc to apply the attribute according
+ * to its docs (and also "warning: always_inline function might not be
+ * inlinable [-Wattributes]" is emitted).
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-always_005finline-function-attribute
+ * clang: mentioned
+ */
+#ifndef __always_inline
+# define __always_inline                 inline __attribute__((__always_inline__))
+#endif
+
+/*
+ * The second argument is optional (default 0), so we use a variadic macro
+ * to make the shorthand.
+ *
+ * Beware: Do not apply this to functions which may return
+ * ERR_PTRs. Also, it is probably unwise to apply it to functions
+ * returning extra information in the low bits (but in that case the
+ * compiler should see some alignment anyway, when the return value is
+ * massaged by 'flags = ptr & 3; ptr &= ~3;').
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned
+ */
+#ifndef __assume_aligned
+# define __assume_aligned(a, ...)        __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
+ */
+#ifndef __cleanup
+# define __cleanup(func)			__attribute__((__cleanup__(func)))
+#endif
+
+/*
+ * Note the long name.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-const-function-attribute
+ */
+#ifndef __attribute_const__
+# define __attribute_const__             __attribute__((__const__))
+#endif
+
+/*
+ * Optional: only supported since gcc >= 9
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-copy-function-attribute
+ */
+#if __has_attribute(__copy__)
+# define __copy(symbol)                 __attribute__((__copy__(symbol)))
+#else
+# define __copy(symbol)
+#endif
+
+/*
+ * Optional: only supported since gcc >= 14
+ * Optional: only supported since clang >= 18
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__counted_by__)
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 14.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#diagnose_as_builtin
+ */
+#if __has_attribute(__diagnose_as_builtin__)
+# define __diagnose_as(builtin...)	__attribute__((__diagnose_as_builtin__(builtin)))
+#else
+# define __diagnose_as(builtin...)
+#endif
+
+/*
+ * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
+ * attribute warnings entirely and for good") for more information.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-deprecated-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-deprecated-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-deprecated-variable-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Enumerator-Attributes.html#index-deprecated-enumerator-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#deprecated
+ */
+#ifndef __deprecated
+# define __deprecated
+#endif
+
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-designated_005finit-type-attribute
+ */
+#if __has_attribute(__designated_init__)
+# define __designated_init              __attribute__((__designated_init__))
+#else
+# define __designated_init
+#endif
+
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-error-function-attribute
+ */
+#if __has_attribute(__error__)
+# define __compiletime_error(msg)       __attribute__((__error__(msg)))
+#else
+# define __compiletime_error(msg)
+#endif
+
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-externally_005fvisible-function-attribute
+ */
+#if __has_attribute(__externally_visible__)
+# define __visible                      __attribute__((__externally_visible__))
+#else
+# define __visible
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#format
+ */
+#ifndef __printf
+# define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
+#endif
+#ifndef __scanf
+# define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-gnu_005finline-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#gnu-inline
+ */
+#ifndef __gnu_inline
+# define __gnu_inline                    __attribute__((__gnu_inline__))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-malloc-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#malloc
+ */
+#ifndef __malloc
+# define __malloc                        __attribute__((__malloc__))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-mode-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-mode-variable-attribute
+ */
+#ifndef __mode
+# define __mode(x)                       __attribute__((__mode__(x)))
+#endif
+
+/*
+ * Optional: only supported since gcc >= 7
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#index-no_005fcaller_005fsaved_005fregisters-function-attribute_002c-x86
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registers
+ */
+#if __has_attribute(__no_caller_saved_registers__)
+# define __no_caller_saved_registers	__attribute__((__no_caller_saved_registers__))
+#else
+# define __no_caller_saved_registers
+#endif
+
+/*
+ * Optional: not supported by clang
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute
+ */
+#if __has_attribute(__noclone__)
+# define __noclone                      __attribute__((__noclone__))
+#else
+# define __noclone
+#endif
+
+/*
+ * Add the pseudo keyword 'fallthrough' so case statement blocks
+ * must end with any of these keywords:
+ *   break;
+ *   fallthrough;
+ *   continue;
+ *   goto <label>;
+ *   return [expression];
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
+ */
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif
+
+/*
+ * gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#flatten
+ */
+# define __flatten			__attribute__((flatten))
+
+/*
+ * Note the missing underscores.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noinline-function-attribute
+ * clang: mentioned
+ */
+#define   noinline                      __attribute__((__noinline__))
+
+/*
+ * Optional: only supported since gcc >= 8
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute
+ */
+#if __has_attribute(__nonstring__)
+# define __nonstring                    __attribute__((__nonstring__))
+#else
+# define __nonstring
+#endif
+
+/*
+ * Optional: only supported since GCC >= 7.1, clang >= 13.0.
+ *
+ *      gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fprofile_005finstrument_005ffunction-function-attribute
+ *    clang: https://clang.llvm.org/docs/AttributeReference.html#no-profile-instrument-function
+ */
+#if __has_attribute(__no_profile_instrument_function__)
+# define __no_profile                  __attribute__((__no_profile_instrument_function__))
+#else
+# define __no_profile
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#id1
+ */
+#define __noreturn                      __attribute__((__noreturn__))
+
+/*
+ * Optional: only supported since GCC >= 11.1, clang >= 7.0.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fstack_005fprotector-function-attribute
+ *   clang: https://clang.llvm.org/docs/AttributeReference.html#no-stack-protector-safebuffers
+ */
+#if __has_attribute(__no_stack_protector__)
+# define __no_stack_protector		__attribute__((__no_stack_protector__))
+#else
+# define __no_stack_protector
+#endif
+
+/*
+ * Optional: not supported by gcc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#overloadable
+ */
+#if __has_attribute(__overloadable__)
+# define __overloadable			__attribute__((__overloadable__))
+#else
+# define __overloadable
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-packed-type-attribute
+ * clang: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-packed-variable-attribute
+ */
+#ifndef __packed
+# define __packed                        __attribute__((__packed__))
+#endif
+
+/*
+ * Note: the "type" argument should match any __builtin_object_size(p, type) usage.
+ *
+ * Optional: not supported by gcc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
+ */
+#if __has_attribute(__pass_dynamic_object_size__)
+# define __pass_dynamic_object_size(type)	__attribute__((__pass_dynamic_object_size__(type)))
+#else
+# define __pass_dynamic_object_size(type)
+#endif
+#if __has_attribute(__pass_object_size__)
+# define __pass_object_size(type)	__attribute__((__pass_object_size__(type)))
+#else
+# define __pass_object_size(type)
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
+ */
+#ifndef __pure
+# define __pure                          __attribute__((__pure__))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec-allocate
+ */
+#ifndef __section
+# define __section(section)              __attribute__((__section__(section)))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-unused-label-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#maybe-unused-unused
+ */
+#ifndef __always_unused
+# define __always_unused                 __attribute__((__unused__))
+#endif
+#ifndef __maybe_unused
+# define __maybe_unused                  __attribute__((__unused__))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-used-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-used-variable-attribute
+ */
+#ifndef __used
+# define __used                          __attribute__((__used__))
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warn_005funused_005fresult-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
+ */
+#ifndef __must_check
+# define __must_check                    __attribute__((__warn_unused_result__))
+#endif
+
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
+ */
+#if __has_attribute(__warning__)
+# define __compiletime_warning(msg)     __attribute__((__warning__(msg)))
+#else
+# define __compiletime_warning(msg)
+#endif
+
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#disable-sanitizer-instrumentation
+ *
+ * disable_sanitizer_instrumentation is not always similar to
+ * no_sanitize((<sanitizer-name>)): the latter may still let specific sanitizers
+ * insert code into functions to prevent false positives. Unlike that,
+ * disable_sanitizer_instrumentation prevents all kinds of instrumentation to
+ * functions with the attribute.
+ */
+#if __has_attribute(disable_sanitizer_instrumentation)
+# define __disable_sanitizer_instrumentation \
+	 __attribute__((disable_sanitizer_instrumentation))
+#else
+# define __disable_sanitizer_instrumentation
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
+ */
+#ifndef __weak
+# define __weak                          __attribute__((__weak__))
+#endif
+
+/*
+ * Used by functions that use '__builtin_return_address'. These function
+ * don't want to be splited or made inline, which can make
+ * the '__builtin_return_address' get unexpected address.
+ */
+#ifndef __fix_address
+# define __fix_address noinline __noclone
+#endif
+
+#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index 1bdd834bdd57..6f7217110e05 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -2,8 +2,6 @@
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
-/* Builtins */
-
 /*
  * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
  * In the meantime, to support gcc < 10, we implement __has_builtin
@@ -13,31 +11,194 @@
 #define __has_builtin(x) (0)
 #endif
 
+/* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
+/* address spaces */
+# define __kernel	__attribute__((address_space(0)))
+# define __user		__attribute__((noderef, address_space(__user)))
+# define __iomem	__attribute__((noderef, address_space(__iomem)))
+# define __percpu	__attribute__((noderef, address_space(__percpu)))
+# define __rcu		__attribute__((noderef, address_space(__rcu)))
+static inline void __chk_user_ptr(const volatile void __user *ptr) { }
+static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* context/locking */
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))
+# define __cond_acquires(x) __attribute__((context(x,0,-1)))
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
+/* other */
+# define __force	__attribute__((force))
+# define __nocast	__attribute__((nocast))
+# define __safe		__attribute__((safe))
+# define __private	__attribute__((noderef))
+# define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
 #else /* __CHECKER__ */
+/* address spaces */
+# define __kernel
+# ifdef STRUCTLEAK_PLUGIN
+#  define __user	__attribute__((user))
+# else
+//#  define __user	BTF_TYPE_TAG(user)
+# endif
+# define __iomem
+# define __percpu	BTF_TYPE_TAG(percpu)
+# define __rcu		BTF_TYPE_TAG(rcu)
+
+# define __chk_user_ptr(x)	(void)0
+# define __chk_io_ptr(x)	(void)0
 /* context/locking */
 # define __must_hold(x)
 # define __acquires(x)
+# define __cond_acquires(x)
 # define __releases(x)
 # define __acquire(x)	(void)0
 # define __release(x)	(void)0
 # define __cond_lock(x,c) (c)
+/* other */
+# define __force
+# define __nocast
+# define __safe
+# define __private
+# define ACCESS_PRIVATE(p, member) ((p)->member)
+# define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a,b) a##b
+#define __PASTE(a,b) ___PASTE(a,b)
+
+/* Attributes */
+#include <linux/compiler_attributes.h>
+
 /* Compiler specific macros. */
-#ifdef __GNUC__
+#ifdef __clang__
+#include <linux/compiler-clang.h>
+#elif defined(__GNUC__)
+/* The above compilers also define __GNUC__, so order is important here. */
 #include <linux/compiler-gcc.h>
+#else
+#error "Unknown compiler"
+#endif
+
+/*
+ * Any place that could be marked with the "alloc_size" attribute is also
+ * a place to be marked with the "malloc" attribute, except those that may
+ * be performing a _reallocation_, as that may alias the existing pointer.
+ * For these, use __realloc_size().
+ */
+#ifdef __alloc_size__
+# define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
+# define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
+#else
+# define __alloc_size(x, ...)	__malloc
+# define __realloc_size(x, ...)
+#endif
+
+/*
+ * When the size of an allocated object is needed, use the best available
+ * mechanism to find it. (For cases where sizeof() cannot be used.)
+ */
+#if __has_builtin(__builtin_dynamic_object_size)
+#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
+#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
+#else
+#define __struct_size(p)	__builtin_object_size(p, 0)
+#define __member_size(p)	__builtin_object_size(p, 1)
+#endif
+
+/* Are two types/vars the same type (ignoring qualifiers)? */
+#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+/*
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(signed type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+
+/* Is this type a native word size -- useful for atomic operations */
+#define __native_word(t) \
+	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
+	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+
+#ifndef NDEBUG
+# ifndef __cplusplus
+#  pragma GCC diagnostic ignored "-Wnested-externs"
+# endif
+# define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		/*							\
+		 * __noreturn is needed to give the compiler enough	\
+		 * information to avoid certain possibly-uninitialized	\
+		 * warnings (regardless of the build failing).		\
+		 */							\
+		__noreturn extern void prefix ## suffix(void)		\
+			__compiletime_error(msg);			\
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#else
+# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
+#endif
+
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+
+/**
+ * compiletime_assert - break build and emit msg if condition is false
+ * @condition: a compile-time constant condition to check
+ * @msg:       a message to emit if condition is false
+ *
+ * In tradition of POSIX assert, this macro will break the build if the
+ * supplied condition is *false*, emitting the supplied error message if the
+ * compiler has support to do so.
+ */
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
+
+#define compiletime_assert_atomic_type(t)				\
+	compiletime_assert(__native_word(t),				\
+		"Need native word sized stores/loads for atomicity.")
+
+/* Helpers for emitting diagnostics in pragmas. */
+#ifndef __diag
+#define __diag(string)
 #endif
 
-#ifndef asm_volatile_goto
-#define asm_volatile_goto(x...) asm goto(x)
+#ifndef __diag_GCC
+#define __diag_GCC(version, severity, string)
+#endif
+
+#define __diag_push()	__diag(push)
+#define __diag_pop()	__diag(pop)
+
+#define __diag_ignore(compiler, version, option, comment) \
+	__diag_ ## compiler(version, ignore, option)
+#define __diag_warn(compiler, version, option, comment) \
+	__diag_ ## compiler(version, warn, option)
+#define __diag_error(compiler, version, option, comment) \
+	__diag_ ## compiler(version, error, option)
+
+#ifndef __diag_ignore_all
+#define __diag_ignore_all(option, comment)
 #endif
 
 #endif /* __LINUX_COMPILER_TYPES_H */
diff --git a/tools/include/linux/rbtree.h b/tools/include/linux/rbtree.h
index 2680f2edb837..446345a10918 100644
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -19,6 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/stddef.h>
+#include <linux/types.h> /* for bool */
 
 struct rb_node {
 	unsigned long  __rb_parent_color;
diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index db5c99318c79..38289a2caa40 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_STRING_H_
 
 #include <linux/types.h>	/* for size_t */
+#include <linux/compiler.h>
 #include <string.h>
 
 void *memdup(const void *src, size_t len);
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index cb1f44f1ed5e..2ea932fcd575 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -55,7 +55,7 @@ typedef __s8  s8;
 #ifndef __user
 #define __user
 #endif
-#define __must_check
+
 #define __cold
 
 typedef __u16 __bitwise __le16;
-- 
2.44.0.278.ge034bb2e1d-goog


