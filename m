Return-Path: <linux-arch+bounces-2915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC389877509
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D85281A6B
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C638F82;
	Sun, 10 Mar 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et8oLd0U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AC376E4
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036357; cv=none; b=F6WteHlYrIEanFVP7awZUTm5MZio2HmB3x5WBPWMQYAln1xNp0K8IHiUSoCDk3MbHsbGk/V2Q+YnXCVeflDP9IoLT+EUlCPM/CLOe/nVf3MCZR/XaF/2bB4/UniYupnBKBtTwT2RKy/N+Ptw97XvrjP8WgAwZxh+MQBiCsYZFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036357; c=relaxed/simple;
	bh=Fq4lcFad9HT9JmjkJEm98VVUDFCHd+jm9iRP80ik0Qk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aa3NnH4BSyhXl02hSxtq7kBuiTk1hBAz+wWV30exSLDlb7H3Xm1gopirwyJ0oOOguti1tFcSXGJU82ZDanJkzP/qqFOlF0adu+Z9GLozIJhgNc/illTGr28wCtekfUScVUPxAO7Bq17LC8oex8XTVDXtRZVe937fRA53FnamVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Et8oLd0U; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso5900388276.0
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036354; x=1710641154; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfWQCgRQvC61dW45rBVZGuz4IKfn5r36xpIYwQ99OM0=;
        b=Et8oLd0Uuwwe4+7kI3T6ViWYA6cGKXI7GR4TrQvRkiTDQYe/9R5M+ZfD2kWjDZvRbh
         X9CZYfs9El9ORL0q4RbfIWLW0QB4VriOmBvSW5cm9KsvKdimt3+rxA+ILZyat14alDI+
         kdBPW1hPBca7cHrzJeFFsZ47zB3LuwqJjoGY+xMp1SFZIACbxh+P9x4u6vGiqqs2UKnn
         Tm2EscMTADk8ui3t0JiF0wxcs0P9EvfiH/VoRFLrT4dm6T4pbP+WZf+FPL0m/lZe0Utc
         JT6jgNebAvTjy9xU8z4MQmxi5+4xZ4dh461NZ30LZ76+3AXvAOpZcEsV6kOiWkuUhk4Z
         1dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036354; x=1710641154;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfWQCgRQvC61dW45rBVZGuz4IKfn5r36xpIYwQ99OM0=;
        b=GEv+G767nFyWiyApFfZHW5LqwPXtwBPtv7wKE9XglvCvOP4uiyrea6oGP1t0qU1li7
         E6E6naFcldpyzPQCvxIgvOBNC5SRfPACq0BCwjqfMBNVrL2/Re8K/GSrWym/iHlLCtWH
         77KZQEg9DTOCCcLfyZ+O43FIsCnFPPCIFTtCf551oDXzhtI26KRBUfyWxQt9DAozUuZv
         KusVHEskm3B7/XOXivfeIoIm8mG94U0JaFdWPCs1ckc97KeTnQP8+wL5qUaMbi1fkg3Y
         458hI9iATQckLy+ju5lSCTpTgAZNOLreToUOvWfTwgqq0Fg+WE6m6qPcq4N+GeWy9eEq
         F8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LLPIJ7FLmSgTn9QJy8N9wFZXBdSEnrW2A7A0wftOlNnBBYTI6fs2WHlPZzju10Zac4qI5GBuhBsJF4OL2hEW+rvX50IitS4EgA==
X-Gm-Message-State: AOJu0YzUsRpUnXS4lu0oTo7ROZZEDo57STb8HP/GfKutFsOvww+YvvpD
	HjApX+PXB5iYtPLeLYuxHKJbRdIGz/3902EuBsOIEWlzHtRQNhpKupS8nJ/TBcwgIHkqLsGnyth
	B093J0A==
X-Google-Smtp-Source: AGHT+IEbgF9/L10MqEQsfT/YgldjotiYAys6nVxOfaOObgpu5qrtCsaN68T0Sw/VHfW+vmC7K4OzTmNsXC8h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c2:b0:dbd:b4e8:1565 with SMTP
 id w2-20020a05690210c200b00dbdb4e81565mr1091906ybu.4.1710036354130; Sat, 09
 Mar 2024 18:05:54 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:04 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/13] tools headers: Rewrite linux/atomic.h using C11's stdatomic.h
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

Code in tools tries to follow the patterns of the kernel, so the
atomic functions names match. However, having include/linux/atomic.h
in tools complicates building code in tools as assembly and other
functions are necessary - these are often configured in the kernel
using CONFIG options. As tools C code is compiled with the -std=gnu11
flag, it is possible to use stdatomic.h and move the build and other
complications to the compiler/libc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/arch/x86/include/asm/atomic.h           |  84 --------------
 tools/include/asm-generic/atomic-gcc.h        |  95 ----------------
 tools/include/asm/atomic.h                    |  11 --
 tools/include/linux/atomic.h                  | 107 ++++++++++++++++--
 tools/include/linux/types.h                   |  15 ++-
 .../selftests/kvm/include/kvm_util_base.h     |   3 +-
 6 files changed, 110 insertions(+), 205 deletions(-)
 delete mode 100644 tools/arch/x86/include/asm/atomic.h
 delete mode 100644 tools/include/asm-generic/atomic-gcc.h
 delete mode 100644 tools/include/asm/atomic.h

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
deleted file mode 100644
index 365cf182df12..000000000000
--- a/tools/arch/x86/include/asm/atomic.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TOOLS_LINUX_ASM_X86_ATOMIC_H
-#define _TOOLS_LINUX_ASM_X86_ATOMIC_H
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include "rmwcc.h"
-
-#define LOCK_PREFIX "\n\tlock; "
-
-#include <asm/asm.h>
-#include <asm/cmpxchg.h>
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
-static inline int atomic_read(const atomic_t *v)
-{
-	return READ_ONCE((v)->counter);
-}
-
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
-static inline void atomic_set(atomic_t *v, int i)
-{
-	v->counter = i;
-}
-
-/**
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-static inline void atomic_inc(atomic_t *v)
-{
-	asm volatile(LOCK_PREFIX "incl %0"
-		     : "+m" (v->counter));
-}
-
-/**
- * atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static inline int atomic_dec_and_test(atomic_t *v)
-{
-	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", "e");
-}
-
-static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	return cmpxchg(&v->counter, old, new);
-}
-
-static inline int test_and_set_bit(long nr, unsigned long *addr)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
-}
-
-static inline int test_and_clear_bit(long nr, unsigned long *addr)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, "Ir", nr, "%0", "c");
-}
-
-#endif /* _TOOLS_LINUX_ASM_X86_ATOMIC_H */
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
deleted file mode 100644
index 9b3c528bab92..000000000000
--- a/tools/include/asm-generic/atomic-gcc.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TOOLS_ASM_GENERIC_ATOMIC_H
-#define __TOOLS_ASM_GENERIC_ATOMIC_H
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/bitops.h>
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- *
- * Excerpts obtained from the Linux kernel sources.
- */
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
-static inline int atomic_read(const atomic_t *v)
-{
-	return READ_ONCE((v)->counter);
-}
-
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
-static inline void atomic_set(atomic_t *v, int i)
-{
-        v->counter = i;
-}
-
-/**
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-static inline void atomic_inc(atomic_t *v)
-{
-	__sync_add_and_fetch(&v->counter, 1);
-}
-
-/**
- * atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static inline int atomic_dec_and_test(atomic_t *v)
-{
-	return __sync_sub_and_fetch(&v->counter, 1) == 0;
-}
-
-#define cmpxchg(ptr, oldval, newval) \
-	__sync_val_compare_and_swap(ptr, oldval, newval)
-
-static inline int atomic_cmpxchg(atomic_t *v, int oldval, int newval)
-{
-	return cmpxchg(&(v)->counter, oldval, newval);
-}
-
-static inline int test_and_set_bit(long nr, unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	long old;
-
-	addr += BIT_WORD(nr);
-
-	old = __sync_fetch_and_or(addr, mask);
-	return !!(old & mask);
-}
-
-static inline int test_and_clear_bit(long nr, unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	long old;
-
-	addr += BIT_WORD(nr);
-
-	old = __sync_fetch_and_and(addr, ~mask);
-	return !!(old & mask);
-}
-
-#endif /* __TOOLS_ASM_GENERIC_ATOMIC_H */
diff --git a/tools/include/asm/atomic.h b/tools/include/asm/atomic.h
deleted file mode 100644
index 8c9bfffd4191..000000000000
--- a/tools/include/asm/atomic.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TOOLS_LINUX_ASM_ATOMIC_H
-#define __TOOLS_LINUX_ASM_ATOMIC_H
-
-#if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/asm/atomic.h"
-#else
-#include <asm-generic/atomic-gcc.h>
-#endif
-
-#endif /* __TOOLS_LINUX_ASM_ATOMIC_H */
diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 01907b33537e..2cf4791ddd5d 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -2,14 +2,107 @@
 #ifndef __TOOLS_LINUX_ATOMIC_H
 #define __TOOLS_LINUX_ATOMIC_H
 
-#include <asm/atomic.h>
+#include <stdatomic.h>
+#include <linux/types.h>  // For atomic_t
 
-void atomic_long_set(atomic_long_t *v, long i);
+/*
+ * Reimplementation of the kernel's atomic.h using C11's stdatomic.h to avoid
+ * build logic around compilers, inline assembler, etc.
+ */
 
-/* atomic_cmpxchg_relaxed */
-#ifndef atomic_cmpxchg_relaxed
-#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
-#define  atomic_cmpxchg_release         atomic_cmpxchg
-#endif /* atomic_cmpxchg_relaxed */
+#define ATOMIC_OP(op, c_op)						\
+static inline void generic_atomic_##op(int i, atomic_t *v)		\
+{									\
+	atomic_fetch_##op(v, i);				\
+}
+
+#define ATOMIC_OP_RETURN(op, c_op)					\
+static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
+{									\
+	int c =	atomic_fetch_##op(v, i);			\
+									\
+	return c c_op i;						\
+}
+
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	return atomic_fetch_##op(v, i);			\
+}
+
+static inline int generic_atomic_read(const atomic_t *v)
+{
+	return atomic_load(v);
+}
+
+static inline void generic_atomic_set(atomic_t *v, int i)
+{
+	atomic_store(v, i);
+}
+
+static inline int generic_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	int expected = old;
+
+	atomic_compare_exchange_weak_explicit(v, &expected, new,
+					memory_order_relaxed, memory_order_relaxed);
+	return expected;
+}
+
+static inline int generic_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	int expected = old;
+
+	/*
+	 * Note, the stricter memory_order_seq_cst is used as
+	 * memory_order_release fails with an invalid-memory-model error.
+	 */
+	atomic_compare_exchange_weak_explicit(v, &expected, new,
+					memory_order_seq_cst, memory_order_seq_cst);
+	return expected;
+}
+
+ATOMIC_OP_RETURN(add, +)
+ATOMIC_OP_RETURN(sub, -)
+
+ATOMIC_FETCH_OP(add, +)
+ATOMIC_FETCH_OP(sub, -)
+ATOMIC_FETCH_OP(and, &)
+ATOMIC_FETCH_OP(or, |)
+ATOMIC_FETCH_OP(xor, ^)
+
+ATOMIC_OP(add, +)
+ATOMIC_OP(sub, -)
+ATOMIC_OP(and, &)
+ATOMIC_OP(or, |)
+ATOMIC_OP(xor, ^)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#define arch_atomic_add_return			generic_atomic_add_return
+#define arch_atomic_sub_return			generic_atomic_sub_return
+
+#define arch_atomic_fetch_add			generic_atomic_fetch_add
+#define arch_atomic_fetch_sub			generic_atomic_fetch_sub
+#define arch_atomic_fetch_and			generic_atomic_fetch_and
+#define arch_atomic_fetch_or			generic_atomic_fetch_or
+#define arch_atomic_fetch_xor			generic_atomic_fetch_xor
+
+#define arch_atomic_add				generic_atomic_add
+#define arch_atomic_sub				generic_atomic_sub
+#define arch_atomic_and				generic_atomic_and
+#define arch_atomic_or				generic_atomic_or
+#define arch_atomic_xor				generic_atomic_xor
+
+#define arch_atomic_read(v)			generic_atomic_read(v)
+#define arch_atomic_set(v, i)			generic_atomic_set(v, i)
+#define atomic_set(v, i)			generic_atomic_set(v, i)
+#define atomic_read(v)				generic_atomic_read(v)
+#define atomic_cmpxchg_relaxed(v, o, n)		generic_atomic_cmpxchg_relaxed(v, o, n)
+#define atomic_cmpxchg_release(v, o, n)		generic_atomic_cmpxchg_release(v, o, n)
+#define atomic_inc(v)				generic_atomic_add(1, v)
+#define atomic_dec(v)				generic_atomic_sub(1, v)
 
 #endif /* __TOOLS_LINUX_ATOMIC_H */
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 8519386acd23..cb1f44f1ed5e 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -74,13 +74,16 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
-typedef struct {
-	int counter;
-} atomic_t;
+#ifndef __cplusplus
+/* C++17 doesn't support stdatomic.h but C++23 does. */
+#include <stdatomic.h>
 
-typedef struct {
-	long counter;
-} atomic_long_t;
+typedef atomic_int atomic_t;
+
+#define ATOMIC_INIT(i) (i)
+
+typedef atomic_long atomic_long_t;
+#endif
 
 #ifndef __aligned_u64
 # define __aligned_u64 __u64 __attribute__((aligned(8)))
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e5afc472c14..7c81da425abc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -9,6 +9,7 @@
 
 #include "test_util.h"
 
+#include <linux/atomic.h>
 #include <linux/compiler.h>
 #include "linux/hashtable.h"
 #include "linux/list.h"
@@ -17,8 +18,6 @@
 #include "linux/rbtree.h"
 #include <linux/types.h>
 
-#include <asm/atomic.h>
-
 #include <sys/ioctl.h>
 
 #include "sparsebit.h"
-- 
2.44.0.278.ge034bb2e1d-goog


