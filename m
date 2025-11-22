Return-Path: <linux-arch+bounces-15035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BCC7C629
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D58D4E202D
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453261C5D77;
	Sat, 22 Nov 2025 04:37:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338F381AF;
	Sat, 22 Nov 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786223; cv=none; b=Rr6cN0nGJA79QZKh51n2gpf+6LNP+vwPg5i6nRySSI1KME/GB0G75c1XHBaW2oxqEEC0hW7rNd4BGJnY1Zy8p3sYR8NJdeD0fPMNMAYtDI2HRiIb73PBt/aMu32TOlgOZP9frTO1H0x9uQJZ/IAWUskhEJdVV7HSiY0HIeuFSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786223; c=relaxed/simple;
	bh=F8slmda6vCjyF6xh0edwI5ZDt99WD9OHTx/+q2HuiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGHk0Xrn5xiiZ8qYO9Iorb3kkhhoCq6F+KmveSQOcRBBcOgCYZJRYCxOw25TP/vza3MiJzsJJ7moCTkrSLGSngFudliEmki9etuCpYKZxMTl+uTH8hBUXOc8aEjtEjI7/1+5eLiKGqweGL1Fu2q/tYqTpGbtCshPUOZCVSR6bbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F50C4CEF5;
	Sat, 22 Nov 2025 04:37:00 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 01/14] LoongArch: Add atomic operations for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:21 +0800
Message-ID: <20251122043634.3447854-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch64 has both AMO and LL/SC instructions, while LoongArch32 only
has LL/SC intstructions. So we add a Kconfig option CPU_HAS_AMO here and
implement atomic operations (also including local operations and percpu
operations) for both 32BIT and 64BIT platforms.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                   |   4 +
 arch/loongarch/include/asm/atomic-amo.h  | 206 +++++++++++++++++++++++
 arch/loongarch/include/asm/atomic-llsc.h | 100 +++++++++++
 arch/loongarch/include/asm/atomic.h      | 197 ++--------------------
 arch/loongarch/include/asm/cmpxchg.h     |  48 ++++--
 arch/loongarch/include/asm/local.h       |  37 ++++
 arch/loongarch/include/asm/percpu.h      |  40 +++--
 7 files changed, 413 insertions(+), 219 deletions(-)
 create mode 100644 arch/loongarch/include/asm/atomic-amo.h
 create mode 100644 arch/loongarch/include/asm/atomic-llsc.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a672f689cb03..730f34214519 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -568,6 +568,10 @@ config ARCH_STRICT_ALIGN
 	  to run kernel only on systems with h/w unaligned access support in
 	  order to optimise for performance.
 
+config CPU_HAS_AMO
+	bool
+	default 64BIT
+
 config CPU_HAS_FPU
 	bool
 	default y
diff --git a/arch/loongarch/include/asm/atomic-amo.h b/arch/loongarch/include/asm/atomic-amo.h
new file mode 100644
index 000000000000..d5efa5252d56
--- /dev/null
+++ b/arch/loongarch/include/asm/atomic-amo.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Atomic operations (AMO).
+ *
+ * Copyright (C) 2020-2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_ATOMIC_AMO_H
+#define _ASM_ATOMIC_AMO_H
+
+#include <linux/types.h>
+#include <asm/barrier.h>
+#include <asm/cmpxchg.h>
+
+#define ATOMIC_OP(op, I, asm_op)					\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	__asm__ __volatile__(						\
+	"am"#asm_op".w" " $zero, %1, %0	\n"				\
+	: "+ZB" (v->counter)						\
+	: "r" (I)							\
+	: "memory");							\
+}
+
+#define ATOMIC_OP_RETURN(op, I, asm_op, c_op, mb, suffix)		\
+static inline int arch_atomic_##op##_return##suffix(int i, atomic_t *v)	\
+{									\
+	int result;							\
+									\
+	__asm__ __volatile__(						\
+	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)				\
+	: "r" (I)							\
+	: "memory");							\
+									\
+	return result c_op I;						\
+}
+
+#define ATOMIC_FETCH_OP(op, I, asm_op, mb, suffix)			\
+static inline int arch_atomic_fetch_##op##suffix(int i, atomic_t *v)	\
+{									\
+	int result;							\
+									\
+	__asm__ __volatile__(						\
+	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)				\
+	: "r" (I)							\
+	: "memory");							\
+									\
+	return result;							\
+}
+
+#define ATOMIC_OPS(op, I, asm_op, c_op)					\
+	ATOMIC_OP(op, I, asm_op)					\
+	ATOMIC_OP_RETURN(op, I, asm_op, c_op, _db,         )		\
+	ATOMIC_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		\
+	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
+	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
+
+ATOMIC_OPS(add, i, add, +)
+ATOMIC_OPS(sub, -i, add, +)
+
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_add_return_acquire	arch_atomic_add_return
+#define arch_atomic_add_return_release	arch_atomic_add_return
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return		arch_atomic_sub_return
+#define arch_atomic_sub_return_acquire	arch_atomic_sub_return
+#define arch_atomic_sub_return_release	arch_atomic_sub_return
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release	arch_atomic_fetch_add
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+
+#undef ATOMIC_OPS
+
+#define ATOMIC_OPS(op, I, asm_op)					\
+	ATOMIC_OP(op, I, asm_op)					\
+	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
+	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
+
+ATOMIC_OPS(and, i, and)
+ATOMIC_OPS(or, i, or)
+ATOMIC_OPS(xor, i, xor)
+
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
+#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release	arch_atomic_fetch_and
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release	arch_atomic_fetch_or
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#ifdef CONFIG_64BIT
+
+#define ATOMIC64_OP(op, I, asm_op)					\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+{									\
+	__asm__ __volatile__(						\
+	"am"#asm_op".d " " $zero, %1, %0	\n"			\
+	: "+ZB" (v->counter)						\
+	: "r" (I)							\
+	: "memory");							\
+}
+
+#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op, mb, suffix)			\
+static inline long arch_atomic64_##op##_return##suffix(long i, atomic64_t *v)	\
+{										\
+	long result;								\
+	__asm__ __volatile__(							\
+	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)					\
+	: "r" (I)								\
+	: "memory");								\
+										\
+	return result c_op I;							\
+}
+
+#define ATOMIC64_FETCH_OP(op, I, asm_op, mb, suffix)				\
+static inline long arch_atomic64_fetch_##op##suffix(long i, atomic64_t *v)	\
+{										\
+	long result;								\
+										\
+	__asm__ __volatile__(							\
+	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)					\
+	: "r" (I)								\
+	: "memory");								\
+										\
+	return result;								\
+}
+
+#define ATOMIC64_OPS(op, I, asm_op, c_op)				      \
+	ATOMIC64_OP(op, I, asm_op)					      \
+	ATOMIC64_OP_RETURN(op, I, asm_op, c_op, _db,         )		      \
+	ATOMIC64_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		      \
+	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
+	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
+
+ATOMIC64_OPS(add, i, add, +)
+ATOMIC64_OPS(sub, -i, add, +)
+
+#define arch_atomic64_add_return		arch_atomic64_add_return
+#define arch_atomic64_add_return_acquire	arch_atomic64_add_return
+#define arch_atomic64_add_return_release	arch_atomic64_add_return
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release	arch_atomic64_sub_return
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_acquire		arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release		arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_acquire		arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release		arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
+
+#undef ATOMIC64_OPS
+
+#define ATOMIC64_OPS(op, I, asm_op)					      \
+	ATOMIC64_OP(op, I, asm_op)					      \
+	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
+	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
+
+ATOMIC64_OPS(and, i, and)
+ATOMIC64_OPS(or, i, or)
+ATOMIC64_OPS(xor, i, xor)
+
+#define arch_atomic64_fetch_and		arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_acquire	arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release	arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_or		arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_acquire	arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release	arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_acquire	arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release	arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+#endif
+
+#endif /* _ASM_ATOMIC_AMO_H */
diff --git a/arch/loongarch/include/asm/atomic-llsc.h b/arch/loongarch/include/asm/atomic-llsc.h
new file mode 100644
index 000000000000..b4f5670b85cf
--- /dev/null
+++ b/arch/loongarch/include/asm/atomic-llsc.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Atomic operations (LLSC).
+ *
+ * Copyright (C) 2024-2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_ATOMIC_LLSC_H
+#define _ASM_ATOMIC_LLSC_H
+
+#include <linux/types.h>
+#include <asm/barrier.h>
+#include <asm/cmpxchg.h>
+
+#define ATOMIC_OP(op, I, asm_op)					\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	int temp;							\
+									\
+	__asm__ __volatile__(						\
+	"1:	ll.w		%0, %1      #atomic_" #op "	\n"	\
+	"       " #asm_op "	%0, %0, %2			\n"	\
+	"	sc.w		%0, %1				\n"	\
+	"       beq		%0, $r0, 1b			\n"	\
+	:"=&r" (temp) , "+ZB"(v->counter)				\
+	:"r" (I)							\
+	);								\
+}
+
+#define ATOMIC_OP_RETURN(op, I, asm_op)					\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+{									\
+	int result, temp;						\
+									\
+	__asm__ __volatile__(						\
+	"1:     ll.w		%1, %2      # atomic_" #op "_return \n"	\
+	"       " #asm_op "	%0, %1, %3                          \n"	\
+	"       sc.w		%0, %2                              \n"	\
+	"       beq		%0, $r0 ,1b                         \n"	\
+	"       " #asm_op "	%0, %1, %3                          \n"	\
+	: "=&r" (result), "=&r" (temp),	"+ZB"(v->counter)		\
+	: "r" (I));							\
+									\
+	return result;							\
+}
+
+#define ATOMIC_FETCH_OP(op, I, asm_op)					\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+{									\
+	int result, temp;						\
+									\
+	__asm__ __volatile__(						\
+	"1:     ll.w		%1, %2      # atomic_fetch_" #op "  \n"	\
+	"       " #asm_op "	%0, %1, %3                          \n" \
+	"       sc.w		%0, %2                              \n"	\
+	"       beq		%0, $r0 ,1b                         \n"	\
+	"       add.w		%0, %1  ,$r0                        \n"	\
+	: "=&r" (result), "=&r" (temp), "+ZB" (v->counter)		\
+	: "r" (I));							\
+									\
+	return result;							\
+}
+
+#define ATOMIC_OPS(op,I ,asm_op, c_op)					\
+	ATOMIC_OP(op, I, asm_op)					\
+	ATOMIC_OP_RETURN(op, I , asm_op)				\
+	ATOMIC_FETCH_OP(op, I, asm_op)
+
+ATOMIC_OPS(add, i , add.w ,+=)
+ATOMIC_OPS(sub, -i , add.w ,+=)
+
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+
+#undef ATOMIC_OPS
+
+#define ATOMIC_OPS(op, I, asm_op)					\
+	ATOMIC_OP(op, I, asm_op)					\
+	ATOMIC_FETCH_OP(op, I, asm_op)
+
+ATOMIC_OPS(and, i, and)
+ATOMIC_OPS(or, i, or)
+ATOMIC_OPS(xor, i, xor)
+
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#ifdef CONFIG_64BIT
+#error "64-bit LLSC atomic operations are not supported"
+#endif
+
+#endif /* _ASM_ATOMIC_LLSC_H */
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index c86f0ab922ec..444b9ddcd004 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -11,6 +11,16 @@
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
 
+#ifdef CONFIG_CPU_HAS_AMO
+#include <asm/atomic-amo.h>
+#else
+#include <asm/atomic-llsc.h>
+#endif
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
 #if __SIZEOF_LONG__ == 4
 #define __LL		"ll.w	"
 #define __SC		"sc.w	"
@@ -34,100 +44,6 @@
 #define arch_atomic_read(v)	READ_ONCE((v)->counter)
 #define arch_atomic_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
-#define ATOMIC_OP(op, I, asm_op)					\
-static inline void arch_atomic_##op(int i, atomic_t *v)			\
-{									\
-	__asm__ __volatile__(						\
-	"am"#asm_op".w" " $zero, %1, %0	\n"				\
-	: "+ZB" (v->counter)						\
-	: "r" (I)							\
-	: "memory");							\
-}
-
-#define ATOMIC_OP_RETURN(op, I, asm_op, c_op, mb, suffix)		\
-static inline int arch_atomic_##op##_return##suffix(int i, atomic_t *v)	\
-{									\
-	int result;							\
-									\
-	__asm__ __volatile__(						\
-	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
-	: "+ZB" (v->counter), "=&r" (result)				\
-	: "r" (I)							\
-	: "memory");							\
-									\
-	return result c_op I;						\
-}
-
-#define ATOMIC_FETCH_OP(op, I, asm_op, mb, suffix)			\
-static inline int arch_atomic_fetch_##op##suffix(int i, atomic_t *v)	\
-{									\
-	int result;							\
-									\
-	__asm__ __volatile__(						\
-	"am"#asm_op#mb".w" " %1, %2, %0		\n"			\
-	: "+ZB" (v->counter), "=&r" (result)				\
-	: "r" (I)							\
-	: "memory");							\
-									\
-	return result;							\
-}
-
-#define ATOMIC_OPS(op, I, asm_op, c_op)					\
-	ATOMIC_OP(op, I, asm_op)					\
-	ATOMIC_OP_RETURN(op, I, asm_op, c_op, _db,         )		\
-	ATOMIC_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		\
-	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
-	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
-
-ATOMIC_OPS(add, i, add, +)
-ATOMIC_OPS(sub, -i, add, +)
-
-#define arch_atomic_add_return		arch_atomic_add_return
-#define arch_atomic_add_return_acquire	arch_atomic_add_return
-#define arch_atomic_add_return_release	arch_atomic_add_return
-#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
-#define arch_atomic_sub_return		arch_atomic_sub_return
-#define arch_atomic_sub_return_acquire	arch_atomic_sub_return
-#define arch_atomic_sub_return_release	arch_atomic_sub_return
-#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
-#define arch_atomic_fetch_add		arch_atomic_fetch_add
-#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add
-#define arch_atomic_fetch_add_release	arch_atomic_fetch_add
-#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
-#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
-
-#undef ATOMIC_OPS
-
-#define ATOMIC_OPS(op, I, asm_op)					\
-	ATOMIC_OP(op, I, asm_op)					\
-	ATOMIC_FETCH_OP(op, I, asm_op, _db,         )			\
-	ATOMIC_FETCH_OP(op, I, asm_op,    , _relaxed)
-
-ATOMIC_OPS(and, i, and)
-ATOMIC_OPS(or, i, or)
-ATOMIC_OPS(xor, i, xor)
-
-#define arch_atomic_fetch_and		arch_atomic_fetch_and
-#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and
-#define arch_atomic_fetch_and_release	arch_atomic_fetch_and
-#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
-#define arch_atomic_fetch_or		arch_atomic_fetch_or
-#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or
-#define arch_atomic_fetch_or_release	arch_atomic_fetch_or
-#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
-#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
-
-#undef ATOMIC_OPS
-#undef ATOMIC_FETCH_OP
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
-
 static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
@@ -194,99 +110,6 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 #define arch_atomic64_read(v)	READ_ONCE((v)->counter)
 #define arch_atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
-#define ATOMIC64_OP(op, I, asm_op)					\
-static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
-{									\
-	__asm__ __volatile__(						\
-	"am"#asm_op".d " " $zero, %1, %0	\n"			\
-	: "+ZB" (v->counter)						\
-	: "r" (I)							\
-	: "memory");							\
-}
-
-#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op, mb, suffix)			\
-static inline long arch_atomic64_##op##_return##suffix(long i, atomic64_t *v)	\
-{										\
-	long result;								\
-	__asm__ __volatile__(							\
-	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
-	: "+ZB" (v->counter), "=&r" (result)					\
-	: "r" (I)								\
-	: "memory");								\
-										\
-	return result c_op I;							\
-}
-
-#define ATOMIC64_FETCH_OP(op, I, asm_op, mb, suffix)				\
-static inline long arch_atomic64_fetch_##op##suffix(long i, atomic64_t *v)	\
-{										\
-	long result;								\
-										\
-	__asm__ __volatile__(							\
-	"am"#asm_op#mb".d " " %1, %2, %0		\n"			\
-	: "+ZB" (v->counter), "=&r" (result)					\
-	: "r" (I)								\
-	: "memory");								\
-										\
-	return result;								\
-}
-
-#define ATOMIC64_OPS(op, I, asm_op, c_op)				      \
-	ATOMIC64_OP(op, I, asm_op)					      \
-	ATOMIC64_OP_RETURN(op, I, asm_op, c_op, _db,         )		      \
-	ATOMIC64_OP_RETURN(op, I, asm_op, c_op,    , _relaxed)		      \
-	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
-	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
-
-ATOMIC64_OPS(add, i, add, +)
-ATOMIC64_OPS(sub, -i, add, +)
-
-#define arch_atomic64_add_return		arch_atomic64_add_return
-#define arch_atomic64_add_return_acquire	arch_atomic64_add_return
-#define arch_atomic64_add_return_release	arch_atomic64_add_return
-#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
-#define arch_atomic64_sub_return		arch_atomic64_sub_return
-#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return
-#define arch_atomic64_sub_return_release	arch_atomic64_sub_return
-#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
-#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_acquire		arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_release		arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
-#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_acquire		arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_release		arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
-
-#undef ATOMIC64_OPS
-
-#define ATOMIC64_OPS(op, I, asm_op)					      \
-	ATOMIC64_OP(op, I, asm_op)					      \
-	ATOMIC64_FETCH_OP(op, I, asm_op, _db,         )			      \
-	ATOMIC64_FETCH_OP(op, I, asm_op,    , _relaxed)
-
-ATOMIC64_OPS(and, i, and)
-ATOMIC64_OPS(or, i, or)
-ATOMIC64_OPS(xor, i, xor)
-
-#define arch_atomic64_fetch_and		arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_acquire	arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_release	arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
-#define arch_atomic64_fetch_or		arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_acquire	arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_release	arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
-#define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_acquire	arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_release	arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
-
-#undef ATOMIC64_OPS
-#undef ATOMIC64_FETCH_OP
-#undef ATOMIC64_OP_RETURN
-#undef ATOMIC64_OP
-
 static inline long arch_atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
        long prev, rc;
diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
index 979fde61bba8..0494c2ab553e 100644
--- a/arch/loongarch/include/asm/cmpxchg.h
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -9,17 +9,33 @@
 #include <linux/build_bug.h>
 #include <asm/barrier.h>
 
-#define __xchg_asm(amswap_db, m, val)		\
+#define __xchg_amo_asm(amswap_db, m, val)	\
 ({						\
-		__typeof(val) __ret;		\
+	__typeof(val) __ret;			\
 						\
-		__asm__ __volatile__ (		\
-		" "amswap_db" %1, %z2, %0 \n"	\
-		: "+ZB" (*m), "=&r" (__ret)	\
-		: "Jr" (val)			\
-		: "memory");			\
+	__asm__ __volatile__ (			\
+	" "amswap_db" %1, %z2, %0 \n"		\
+	: "+ZB" (*m), "=&r" (__ret)		\
+	: "Jr" (val)				\
+	: "memory");				\
 						\
-		__ret;				\
+	__ret;					\
+})
+
+#define __xchg_llsc_asm(ld, st, m, val)			\
+({							\
+	__typeof(val) __ret, __tmp;			\
+							\
+	asm volatile (					\
+	"1:	ll.w	%0, %3		\n"		\
+	"	move	%1, %z4		\n"		\
+	"	sc.w	%1, %2		\n"		\
+	"	beqz	%1, 1b		\n"		\
+	: "=&r" (__ret), "=&r" (__tmp), "=ZC" (*m)	\
+	: "ZC" (*m), "Jr" (val)				\
+	: "memory");					\
+							\
+	__ret;						\
 })
 
 static inline unsigned int __xchg_small(volatile void *ptr, unsigned int val,
@@ -67,13 +83,23 @@ __arch_xchg(volatile void *ptr, unsigned long x, int size)
 	switch (size) {
 	case 1:
 	case 2:
-		return __xchg_small(ptr, x, size);
+		return __xchg_small((volatile void *)ptr, x, size);
 
 	case 4:
-		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
+#ifdef CONFIG_CPU_HAS_AMO
+		return __xchg_amo_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
+#else
+		return __xchg_llsc_asm("ll.w", "sc.w", (volatile u32 *)ptr, (u32)x);
+#endif /* CONFIG_CPU_HAS_AMO */
 
+#ifdef CONFIG_64BIT
 	case 8:
-		return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
+#ifdef CONFIG_CPU_HAS_AMO
+		return __xchg_amo_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
+#else
+		return __xchg_llsc_asm("ll.d", "sc.d", (volatile u64 *)ptr, (u64)x);
+#endif /* CONFIG_CPU_HAS_AMO */
+#endif /* CONFIG_64BIT */
 
 	default:
 		BUILD_BUG();
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index f53ea653af76..65ace8e4350a 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -8,6 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/bitops.h>
 #include <linux/atomic.h>
+#include <asm/asm.h>
 #include <asm/cmpxchg.h>
 
 typedef struct {
@@ -27,6 +28,7 @@ typedef struct {
 /*
  * Same as above, but return the result value
  */
+#ifdef CONFIG_CPU_HAS_AMO
 static inline long local_add_return(long i, local_t *l)
 {
 	unsigned long result;
@@ -55,6 +57,41 @@ static inline long local_sub_return(long i, local_t *l)
 
 	return result;
 }
+#else
+static inline long local_add_return(long i, local_t * l)
+{
+        unsigned long result, temp;
+
+        __asm__ __volatile__(
+        "1:"    __LL    "%1, %2         # local_add_return      \n"
+        __stringify(LONG_ADD) "   %0, %1, %3                    \n"
+                __SC    "%0, %2                                 \n"
+        "       beq     %0, $r0, 1b                             \n"
+        __stringify(LONG_ADD) "   %0, %1, %3                    \n"
+        : "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
+        : "r" (i), "m" (l->a.counter)
+        : "memory");
+
+        return result;
+}
+
+static inline long local_sub_return(long i, local_t * l)
+{
+        unsigned long result, temp;
+
+        __asm__ __volatile__(
+        "1:"    __LL    "%1, %2         # local_sub_return      \n"
+        __stringify(LONG_SUB) "   %0, %1, %3                    \n"
+                __SC    "%0, %2                                 \n"
+        "       beq     %0, $r0, 1b                             \n"
+	__stringify(LONG_SUB) "   %0, %1, %3                    \n"
+        : "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
+        : "r" (i), "m" (l->a.counter)
+        : "memory");
+
+        return result;
+}
+#endif
 
 static inline long local_cmpxchg(local_t *l, long old, long new)
 {
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 87be9b14e9da..1619c1d15e6b 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -36,6 +36,8 @@ static inline void set_my_cpu_offset(unsigned long off)
 	__my_cpu_offset;				\
 })
 
+#ifdef CONFIG_CPU_HAS_AMO
+
 #define PERCPU_OP(op, asm_op, c_op)					\
 static __always_inline unsigned long __percpu_##op(void *ptr,		\
 			unsigned long val, int size)			\
@@ -68,25 +70,9 @@ PERCPU_OP(and, and, &)
 PERCPU_OP(or, or, |)
 #undef PERCPU_OP
 
-static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned long val, int size)
-{
-	switch (size) {
-	case 1:
-	case 2:
-		return __xchg_small((volatile void *)ptr, val, size);
-
-	case 4:
-		return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
-
-	case 8:
-		return __xchg_asm("amswap.d", (volatile u64 *)ptr, (u64)val);
+#endif
 
-	default:
-		BUILD_BUG();
-	}
-
-	return 0;
-}
+#ifdef CONFIG_64BIT
 
 #define __pcpu_op_1(op)		op ".b "
 #define __pcpu_op_2(op)		op ".h "
@@ -115,6 +101,10 @@ do {									\
 		: "memory");						\
 } while (0)
 
+#endif
+
+#define __percpu_xchg __arch_xchg
+
 /* this_cpu_cmpxchg */
 #define _protect_cmpxchg_local(pcp, o, n)			\
 ({								\
@@ -135,6 +125,8 @@ do {									\
 	__retval;						\
 })
 
+#ifdef CONFIG_CPU_HAS_AMO
+
 #define _percpu_add(pcp, val) \
 	_pcp_protect(__percpu_add, pcp, val)
 
@@ -146,9 +138,6 @@ do {									\
 #define _percpu_or(pcp, val) \
 	_pcp_protect(__percpu_or, pcp, val)
 
-#define _percpu_xchg(pcp, val) ((typeof(pcp)) \
-	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val)))
-
 #define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
 #define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
 
@@ -161,6 +150,10 @@ do {									\
 #define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
 #define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
 
+#endif
+
+#ifdef CONFIG_64BIT
+
 #define this_cpu_read_1(pcp) _percpu_read(1, pcp)
 #define this_cpu_read_2(pcp) _percpu_read(2, pcp)
 #define this_cpu_read_4(pcp) _percpu_read(4, pcp)
@@ -171,6 +164,11 @@ do {									\
 #define this_cpu_write_4(pcp, val) _percpu_write(4, pcp, val)
 #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
 
+#endif
+
+#define _percpu_xchg(pcp, val) ((typeof(pcp)) \
+	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val)))
+
 #define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
-- 
2.47.3


