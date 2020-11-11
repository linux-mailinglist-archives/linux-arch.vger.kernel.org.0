Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729672AEF2E
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 12:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKKLHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 06:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKKLHr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2020 06:07:47 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C07C0613D1;
        Wed, 11 Nov 2020 03:07:47 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b23so567551pju.5;
        Wed, 11 Nov 2020 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UIW1gAUzBEzTUOsAcWn7qW7OyNqnASsw4lDTZl0FWE=;
        b=hoPLSr65fhCBlKT1VNnZGlpp8320ybiNzghiUtSrUpv4/rDqBW0OKg+vyPC1uwlNSt
         sWE0BQKb4meLQW4OLVtf3emKnHCI+B5XOgIz2Vn2yjZ0yTg1OUtwbrcI7if+dAVk0uwp
         Mlsp/KMqIOjw8jQ8nskLyJlTWyk9itq0T98mbAWoft+44ItCTUVz/XrDoZsFSDqidgav
         N37EIWcUXMLohDADRbySWIj0HW3QvAsxH4j6A761Q/Gh9K/B1tLC/2iyNileIB8bSlYZ
         HcsCUJvoAM0z17ikkTSmN4fYl1CF3ijhlA2tRQKokAvkbwGo6EnpNUPRzLjfk78EwES8
         UcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UIW1gAUzBEzTUOsAcWn7qW7OyNqnASsw4lDTZl0FWE=;
        b=MpO+Cyck8sCwu1qNP5sF5g3OjbHj+KBP0NzIRZDKk9N1HjGocsgNaTpjSIHnQ+WOmq
         W+ij6cEDhrQkYj5xQVpUSnKySSIMoEwAOiIN4vrECVphkfOccWt/dIcIWrJCCic8tp4S
         +YEhYSFGGG4I2kVcP+zZV9QneDR5WKj6LS48FdOha2+/fpvxC4u+gOubOBnEsyMXy8zV
         KlfKQcgwRcX+UKw7R5clbBRd0n1ZpnCx8aUHycNWXU8DS/rJl17XpQ4lutNrN9pzuxvx
         iil/rFpWYp0nYkfkcsPGovfBaUc13995l6QdyhkjWu/Stirzy8tjudWwh6JLTUGSLNq/
         lSrA==
X-Gm-Message-State: AOAM530YyssJ7IoU7BCZUYgPln2VW4sBAdd9PkGEuXFfaQId7lh3X7sy
        2ztCkRpIK693MHO3pE1Wzeo=
X-Google-Smtp-Source: ABdhPJwr0jUOBgYEsvk/u4lRLIWKVDdyqiy0TRizYXEn5puj5GHS6DqNpyDGCk5ZX5dL8sGMDVajEg==
X-Received: by 2002:a17:902:26a:b029:d6:caca:620a with SMTP id 97-20020a170902026ab02900d6caca620amr21811870plc.46.1605092866694;
        Wed, 11 Nov 2020 03:07:46 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id 9sm2154943pfp.102.2020.11.11.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:07:46 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/3] powerpc: rewrite atomics to use ARCH_ATOMIC
Date:   Wed, 11 Nov 2020 21:07:23 +1000
Message-Id: <20201111110723.3148665-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201111110723.3148665-1-npiggin@gmail.com>
References: <20201111110723.3148665-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All the cool kids are doing it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/atomic.h  | 681 ++++++++++-------------------
 arch/powerpc/include/asm/cmpxchg.h |  62 +--
 2 files changed, 248 insertions(+), 495 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 8a55eb8cc97b..899aa2403ba7 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,185 +11,285 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
+#define ARCH_ATOMIC
+
+#ifndef CONFIG_64BIT
+#include <asm-generic/atomic64.h>
+#endif
+
 /*
  * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
  * on the platform without lwsync.
  */
 #define __atomic_acquire_fence()					\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
+	asm volatile(PPC_ACQUIRE_BARRIER "" : : : "memory")
 
 #define __atomic_release_fence()					\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
+	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory")
 
-static __inline__ int atomic_read(const atomic_t *v)
-{
-	int t;
+#define __atomic_pre_full_fence		smp_mb
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
+#define __atomic_post_full_fence	smp_mb
 
-	return t;
+#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
+#ifdef CONFIG_64BIT
+#define ATOMIC64_INIT(i)			{ (i) }
+#define arch_atomic64_read(v)			__READ_ONCE((v)->counter)
+#define arch_atomic64_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
+#endif
+
+#define ATOMIC_OP(name, type, dtype, width, asm_op)			\
+static inline void arch_##name(dtype a, type *v)			\
+{									\
+	dtype t;							\
+									\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%3		# " #name		"\n"	\
+"\t"	#asm_op " %0,%2,%0					\n"	\
+"	st" #width "cx.	%0,0,%3					\n"	\
+"	bne-	1b						\n"	\
+	: "=&r" (t), "+m" (v->counter)					\
+	: "r" (a), "r" (&v->counter)					\
+	: "cr0", "xer");						\
 }
 
-static __inline__ void atomic_set(atomic_t *v, int i)
-{
-	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
+#define ATOMIC_OP_IMM(name, type, dtype, width, asm_op, imm)		\
+static inline void arch_##name(type *v)					\
+{									\
+	dtype t;							\
+									\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%3		# " #name		"\n"	\
+"\t"	#asm_op " %0,%0,%2					\n"	\
+"	st" #width "cx.	%0,0,%3					\n"	\
+"	bne-	1b						\n"	\
+	: "=&r" (t), "+m" (v->counter)					\
+	: "i" (imm), "r" (&v->counter)					\
+	: "cr0", "xer");						\
 }
 
-#define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int a, atomic_t *v)			\
+#define ATOMIC_OP_RETURN_RELAXED(name, type, dtype, width, asm_op)	\
+static inline dtype arch_##name##_relaxed(dtype a, type *v)		\
 {									\
-	int t;								\
+	dtype t;							\
 									\
-	__asm__ __volatile__(						\
-"1:	lwarx	%0,0,%3		# atomic_" #op "\n"			\
-	#asm_op " %0,%2,%0\n"						\
-"	stwcx.	%0,0,%3 \n"						\
-"	bne-	1b\n"							\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%3		# " #name 		"\n"	\
+"\t"	#asm_op " %0,%2,%0					\n"	\
+"	st" #width "cx.	%0,0,%3					\n"	\
+"	bne-	1b						\n"	\
 	: "=&r" (t), "+m" (v->counter)					\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
-}									\
+	: "cr0", "xer");						\
+									\
+	return t;							\
+}
 
-#define ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
-static inline int atomic_##op##_return_relaxed(int a, atomic_t *v)	\
+#define ATOMIC_OP_IMM_RETURN_RELAXED(name, type, dtype, width, asm_op, imm) \
+static inline dtype arch_##name##_relaxed(type *v)			\
 {									\
-	int t;								\
+	dtype t;							\
 									\
-	__asm__ __volatile__(						\
-"1:	lwarx	%0,0,%3		# atomic_" #op "_return_relaxed\n"	\
-	#asm_op " %0,%2,%0\n"						\
-"	stwcx.	%0,0,%3\n"						\
-"	bne-	1b\n"							\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%3		# " #name		"\n"	\
+"\t"	#asm_op " %0,%0,%2					\n"	\
+"	st" #width "cx.	%0,0,%3					\n"	\
+"	bne-	1b						\n"	\
 	: "=&r" (t), "+m" (v->counter)					\
-	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
+	: "i" (imm), "r" (&v->counter)					\
+	: "cr0", "xer");						\
 									\
 	return t;							\
 }
 
-#define ATOMIC_FETCH_OP_RELAXED(op, asm_op)				\
-static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
+#define ATOMIC_FETCH_OP_RELAXED(name, type, dtype, width, asm_op)	\
+static inline dtype arch_##name##_relaxed(dtype a, type *v)		\
 {									\
-	int res, t;							\
+	dtype res, t;							\
 									\
-	__asm__ __volatile__(						\
-"1:	lwarx	%0,0,%4		# atomic_fetch_" #op "_relaxed\n"	\
-	#asm_op " %1,%3,%0\n"						\
-"	stwcx.	%1,0,%4\n"						\
-"	bne-	1b\n"							\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%4		# " #name		"\n"	\
+"\t"	#asm_op " %1,%3,%0					\n"	\
+"	st" #width "cx.	%1,0,%4					\n"	\
+"	bne-	1b						\n"	\
 	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
+	: "cr0", "xer");						\
 									\
 	return res;							\
 }
 
+#define ATOMIC_FETCH_OP_UNLESS_RELAXED(name, type, dtype, width, asm_op) \
+static inline int arch_##name##_relaxed(type *v, dtype a, dtype u)	\
+{									\
+	dtype res, t;							\
+									\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%5		# " #name		"\n"	\
+"	cmp" #width "	0,%0,%3					\n"	\
+"	beq-	2f						\n"	\
+"\t"	#asm_op " %1,%2,%0					\n"	\
+"	st" #width "cx.	%1,0,%5					\n"	\
+"	bne-	1b						\n"	\
+"2:								\n"	\
+	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
+	: "r" (a), "r" (u), "r" (&v->counter)				\
+	: "cr0", "xer");						\
+									\
+	return res;							\
+}
+
+#define ATOMIC_INC_NOT_ZERO_RELAXED(name, type, dtype, width)		\
+static inline dtype arch_##name##_relaxed(type *v)			\
+{									\
+	dtype t1, t2;							\
+									\
+	asm volatile(							\
+"1:	l" #width "arx	%0,0,%3		# " #name		"\n"	\
+"	cmp" #width "i	0,%0,0					\n"	\
+"	beq-	2f						\n"	\
+"	addic	%1,%2,1						\n"	\
+"	st" #width "cx.	%1,0,%3					\n"	\
+"	bne-	1b						\n"	\
+"2:								\n"	\
+	: "=&r" (t1), "=&r" (t2), "+m" (v->counter)			\
+	: "r" (&v->counter)						\
+	: "cr0", "xer");						\
+									\
+	return t1;							\
+}
+
+#undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm_op)						\
-	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
-	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
+ATOMIC_OP(atomic_##op, atomic_t, int, w, asm_op)			\
+ATOMIC_OP_RETURN_RELAXED(atomic_##op##_return, atomic_t, int, w, asm_op) \
+ATOMIC_FETCH_OP_RELAXED(atomic_fetch_##op, atomic_t, int, w, asm_op)	\
+ATOMIC_FETCH_OP_UNLESS_RELAXED(atomic_fetch_##op##_unless, atomic_t, int, w, asm_op)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, asm_op)					\
+ATOMIC_OP(atomic64_##op, atomic64_t, u64, d, asm_op)			\
+ATOMIC_OP_RETURN_RELAXED(atomic64_##op##_return, atomic64_t, u64, d, asm_op) \
+ATOMIC_FETCH_OP_RELAXED(atomic64_fetch_##op, atomic64_t, u64, d, asm_op) \
+ATOMIC_FETCH_OP_UNLESS_RELAXED(atomic64_fetch_##op##_unless, atomic64_t, u64, d, asm_op)
 
 ATOMIC_OPS(add, add)
+#define arch_atomic_add arch_atomic_add
+#define arch_atomic_add_return_relaxed arch_atomic_add_return_relaxed
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_unless_relaxed arch_atomic_fetch_add_unless_relaxed
+
 ATOMIC_OPS(sub, subf)
+#define arch_atomic_sub arch_atomic_sub
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub_relaxed
+/* skip atomic_fetch_sub_unless_relaxed */
 
-#define atomic_add_return_relaxed atomic_add_return_relaxed
-#define atomic_sub_return_relaxed atomic_sub_return_relaxed
+#ifdef CONFIG_64BIT
+ATOMIC64_OPS(add, add)
+#define arch_atomic64_add arch_atomic64_add
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return_relaxed
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_unless_relaxed arch_atomic64_fetch_add_unless_relaxed
 
-#define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
+ATOMIC64_OPS(sub, subf)
+#define arch_atomic64_sub arch_atomic64_sub
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub_relaxed
+/* skip atomic64_fetch_sub_unless_relaxed */
+#endif
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm_op)						\
-	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
+ATOMIC_OP(atomic_##op, atomic_t, int, w, asm_op)			\
+ATOMIC_FETCH_OP_RELAXED(atomic_fetch_##op, atomic_t, int, w, asm_op)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, asm_op)					\
+ATOMIC_OP(atomic64_##op, atomic64_t, u64, d, asm_op)			\
+ATOMIC_FETCH_OP_RELAXED(atomic64_fetch_##op, atomic64_t, u64, d, asm_op)
 
 ATOMIC_OPS(and, and)
+#define arch_atomic_and arch_atomic_and
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and_relaxed
+
 ATOMIC_OPS(or, or)
+#define arch_atomic_or arch_atomic_or
+#define arch_atomic_fetch_or_relaxed  arch_atomic_fetch_or_relaxed
+
 ATOMIC_OPS(xor, xor)
+#define arch_atomic_xor arch_atomic_xor
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor_relaxed
+
+#ifdef CONFIG_64BIT
+ATOMIC64_OPS(and, and)
+#define arch_atomic64_and arch_atomic64_and
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and_relaxed
 
-#define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
-#define atomic_fetch_or_relaxed  atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
+ATOMIC64_OPS(or, or)
+#define arch_atomic64_or arch_atomic64_or
+#define arch_atomic64_fetch_or_relaxed  arch_atomic64_fetch_or_relaxed
+
+ATOMIC64_OPS(xor, xor)
+#define arch_atomic64_xor arch_atomic64_xor
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor_relaxed
+#endif
 
 #undef ATOMIC_OPS
+#define ATOMIC_OPS(op, asm_op, imm)					\
+ATOMIC_OP_IMM(atomic_##op, atomic_t, int, w, asm_op, imm)		\
+ATOMIC_OP_IMM_RETURN_RELAXED(atomic_##op##_return, atomic_t, int, w, asm_op, imm)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, asm_op, imm)					\
+ATOMIC_OP_IMM(atomic64_##op, atomic64_t, u64, d, asm_op, imm)		\
+ATOMIC_OP_IMM_RETURN_RELAXED(atomic64_##op##_return, atomic64_t, u64, d, asm_op, imm)
+
+ATOMIC_OPS(inc, addic, 1)
+#define arch_atomic_inc arch_atomic_inc
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+
+ATOMIC_OPS(dec, addic, -1)
+#define arch_atomic_dec arch_atomic_dec
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+
+#ifdef CONFIG_64BIT
+ATOMIC64_OPS(inc, addic, 1)
+#define arch_atomic64_inc arch_atomic64_inc
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+
+ATOMIC64_OPS(dec, addic, -1)
+#define arch_atomic64_dec arch_atomic64_dec
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#endif
+
+ATOMIC_INC_NOT_ZERO_RELAXED(atomic_inc_not_zero, atomic_t, int, w)
+#define arch_atomic_inc_not_zero_relaxed(v) arch_atomic_inc_not_zero_relaxed(v)
+
+#ifdef CONFIG_64BIT
+ATOMIC_INC_NOT_ZERO_RELAXED(atomic64_inc_not_zero, atomic64_t, u64, d)
+#define arch_atomic64_inc_not_zero_relaxed(v) arch_atomic64_inc_not_zero_relaxed(v)
+#endif
+
+#undef ATOMIC_INC_NOT_ZERO_RELAXED
+#undef ATOMIC_FETCH_OP_UNLESS_RELAXED
 #undef ATOMIC_FETCH_OP_RELAXED
+#undef ATOMIC_OP_IMM_RETURN_RELAXED
 #undef ATOMIC_OP_RETURN_RELAXED
+#undef ATOMIC_OP_IMM
 #undef ATOMIC_OP
+#undef ATOMIC_OPS
+#undef ATOMIC64_OPS
 
-static __inline__ void atomic_inc(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc\n\
-	addic	%0,%0,1\n"
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define atomic_inc atomic_inc
-
-static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc_return_relaxed\n"
-"	addic	%0,%0,1\n"
-"	stwcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-static __inline__ void atomic_dec(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec\n\
-	addic	%0,%0,-1\n"
-"	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define atomic_dec atomic_dec
-
-static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec_return_relaxed\n"
-"	addic	%0,%0,-1\n"
-"	stwcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-#define atomic_inc_return_relaxed atomic_inc_return_relaxed
-#define atomic_dec_return_relaxed atomic_dec_return_relaxed
-
-#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_cmpxchg_relaxed(v, o, n) \
-	cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define atomic_cmpxchg_acquire(v, o, n) \
-	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define arch_atomic_cmpxchg_relaxed(v, o, n) arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define arch_atomic_xchg_relaxed(v, new) arch_xchg_relaxed(&((v)->counter), (new))
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-#define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
+#ifdef CONFIG_64BIT
+#define arch_atomic64_cmpxchg_relaxed(v, o, n) arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define arch_atomic64_xchg_relaxed(v, new) arch_xchg_relaxed(&((v)->counter), (new))
+#endif
 
 /*
  * Don't want to override the generic atomic_try_cmpxchg_acquire, because
@@ -203,7 +303,7 @@ atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
 	int r, o = *old;
 
 	__asm__ __volatile__ (
-"1:\t"	PPC_LWARX(%0,0,%2,1) "	# atomic_try_cmpxchg_acquire	\n"
+"1:\t"	PPC_LWARX(%0,0,%2,1) "	# atomic_try_cmpxchg_lock		\n"
 "	cmpw	0,%0,%3							\n"
 "	bne-	2f							\n"
 "	stwcx.	%4,0,%2							\n"
@@ -219,270 +319,41 @@ atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
 	return likely(r == o);
 }
 
-/**
- * atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int t;
-
-	__asm__ __volatile__ (
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%1		# atomic_fetch_add_unless\n\
-	cmpw	0,%0,%3 \n\
-	beq	2f \n\
-	add	%0,%2,%0 \n"
-"	stwcx.	%0,0,%1 \n\
-	bne-	1b \n"
-	PPC_ATOMIC_EXIT_BARRIER
-"	subf	%0,%2,%0 \n\
-2:"
-	: "=&r" (t)
-	: "r" (&v->counter), "r" (a), "r" (u)
-	: "cc", "memory");
-
-	return t;
-}
-#define atomic_fetch_add_unless atomic_fetch_add_unless
-
-/**
- * atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, so long as @v is non-zero.
- * Returns non-zero if @v was non-zero, and zero otherwise.
- */
-static __inline__ int atomic_inc_not_zero(atomic_t *v)
-{
-	int t1, t2;
-
-	__asm__ __volatile__ (
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%2		# atomic_inc_not_zero\n\
-	cmpwi	0,%0,0\n\
-	beq-	2f\n\
-	addic	%1,%0,1\n"
-"	stwcx.	%1,0,%2\n\
-	bne-	1b\n"
-	PPC_ATOMIC_EXIT_BARRIER
-	"\n\
-2:"
-	: "=&r" (t1), "=&r" (t2)
-	: "r" (&v->counter)
-	: "cc", "xer", "memory");
-
-	return t1;
-}
-#define atomic_inc_not_zero(v) atomic_inc_not_zero((v))
-
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static __inline__ int atomic_dec_if_positive(atomic_t *v)
+static inline int atomic_dec_if_positive_relaxed(atomic_t *v)
 {
 	int t;
 
-	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
-	cmpwi	%0,1\n\
-	addi	%0,%0,-1\n\
-	blt-	2f\n"
-"	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
-	"\n\
-2:"	: "=&b" (t)
+	asm volatile(
+"1:	lwarx	%0,0,%1		# atomic_dec_if_positive		\n"
+"	cmpwi	%0,1							\n"
+"	addi	%0,%0,-1						\n"
+"	blt-	2f							\n"
+"	stwcx.	%0,0,%1							\n"
+"	bne-	1b							\n"
+"2:									\n"
+	: "=&b" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
 
 	return t;
 }
-#define atomic_dec_if_positive atomic_dec_if_positive
-
-#ifdef __powerpc64__
-
-#define ATOMIC64_INIT(i)	{ (i) }
-
-static __inline__ s64 atomic64_read(const atomic64_t *v)
-{
-	s64 t;
-
-	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
-
-	return t;
-}
-
-static __inline__ void atomic64_set(atomic64_t *v, s64 i)
-{
-	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
-}
-
-#define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(s64 a, atomic64_t *v)		\
-{									\
-	s64 t;								\
-									\
-	__asm__ __volatile__(						\
-"1:	ldarx	%0,0,%3		# atomic64_" #op "\n"			\
-	#asm_op " %0,%2,%0\n"						\
-"	stdcx.	%0,0,%3 \n"						\
-"	bne-	1b\n"							\
-	: "=&r" (t), "+m" (v->counter)					\
-	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
-}
-
-#define ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
-static inline s64							\
-atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)			\
-{									\
-	s64 t;								\
-									\
-	__asm__ __volatile__(						\
-"1:	ldarx	%0,0,%3		# atomic64_" #op "_return_relaxed\n"	\
-	#asm_op " %0,%2,%0\n"						\
-"	stdcx.	%0,0,%3\n"						\
-"	bne-	1b\n"							\
-	: "=&r" (t), "+m" (v->counter)					\
-	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
-									\
-	return t;							\
-}
-
-#define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
-static inline s64							\
-atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)			\
-{									\
-	s64 res, t;							\
-									\
-	__asm__ __volatile__(						\
-"1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
-	#asm_op " %1,%3,%0\n"						\
-"	stdcx.	%1,0,%4\n"						\
-"	bne-	1b\n"							\
-	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
-	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
-									\
-	return res;							\
-}
-
-#define ATOMIC64_OPS(op, asm_op)					\
-	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
-	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
-
-ATOMIC64_OPS(add, add)
-ATOMIC64_OPS(sub, subf)
-
-#define atomic64_add_return_relaxed atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
-
-#define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
-
-#undef ATOMIC64_OPS
-#define ATOMIC64_OPS(op, asm_op)					\
-	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
-
-ATOMIC64_OPS(and, and)
-ATOMIC64_OPS(or, or)
-ATOMIC64_OPS(xor, xor)
-
-#define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
-#define atomic64_fetch_or_relaxed  atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
-
-#undef ATOPIC64_OPS
-#undef ATOMIC64_FETCH_OP_RELAXED
-#undef ATOMIC64_OP_RETURN_RELAXED
-#undef ATOMIC64_OP
-
-static __inline__ void atomic64_inc(atomic64_t *v)
-{
-	s64 t;
-
-	__asm__ __volatile__(
-"1:	ldarx	%0,0,%2		# atomic64_inc\n\
-	addic	%0,%0,1\n\
-	stdcx.	%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define atomic64_inc atomic64_inc
-
-static __inline__ s64 atomic64_inc_return_relaxed(atomic64_t *v)
-{
-	s64 t;
-
-	__asm__ __volatile__(
-"1:	ldarx	%0,0,%2		# atomic64_inc_return_relaxed\n"
-"	addic	%0,%0,1\n"
-"	stdcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-static __inline__ void atomic64_dec(atomic64_t *v)
-{
-	s64 t;
-
-	__asm__ __volatile__(
-"1:	ldarx	%0,0,%2		# atomic64_dec\n\
-	addic	%0,%0,-1\n\
-	stdcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-}
-#define atomic64_dec atomic64_dec
-
-static __inline__ s64 atomic64_dec_return_relaxed(atomic64_t *v)
-{
-	s64 t;
-
-	__asm__ __volatile__(
-"1:	ldarx	%0,0,%2		# atomic64_dec_return_relaxed\n"
-"	addic	%0,%0,-1\n"
-"	stdcx.	%0,0,%2\n"
-"	bne-	1b"
-	: "=&r" (t), "+m" (v->counter)
-	: "r" (&v->counter)
-	: "cc", "xer");
-
-	return t;
-}
-
-#define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
-#define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
+#define atomic_dec_if_positive_relaxed atomic_dec_if_positive_relaxed
 
+#ifdef CONFIG_64BIT
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1.
  */
-static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 atomic64_dec_if_positive_relaxed(atomic64_t *v)
 {
 	s64 t;
 
-	__asm__ __volatile__(
+	asm volatile(
 	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_dec_if_positive\n\
 	addic.	%0,%0,-1\n\
@@ -497,80 +368,8 @@ static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return t;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-
-#define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic64_cmpxchg_relaxed(v, o, n) \
-	cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define atomic64_cmpxchg_acquire(v, o, n) \
-	cmpxchg_acquire(&((v)->counter), (o), (n))
-
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
-#define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
-
-/**
- * atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
-static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	s64 t;
-
-	__asm__ __volatile__ (
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	ldarx	%0,0,%1		# atomic64_fetch_add_unless\n\
-	cmpd	0,%0,%3 \n\
-	beq	2f \n\
-	add	%0,%2,%0 \n"
-"	stdcx.	%0,0,%1 \n\
-	bne-	1b \n"
-	PPC_ATOMIC_EXIT_BARRIER
-"	subf	%0,%2,%0 \n\
-2:"
-	: "=&r" (t)
-	: "r" (&v->counter), "r" (a), "r" (u)
-	: "cc", "memory");
-
-	return t;
-}
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
-
-/**
- * atomic_inc64_not_zero - increment unless the number is zero
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1, so long as @v is non-zero.
- * Returns non-zero if @v was non-zero, and zero otherwise.
- */
-static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
-{
-	s64 t1, t2;
-
-	__asm__ __volatile__ (
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	ldarx	%0,0,%2		# atomic64_inc_not_zero\n\
-	cmpdi	0,%0,0\n\
-	beq-	2f\n\
-	addic	%1,%0,1\n\
-	stdcx.	%1,0,%2\n\
-	bne-	1b\n"
-	PPC_ATOMIC_EXIT_BARRIER
-	"\n\
-2:"
-	: "=&r" (t1), "=&r" (t2)
-	: "r" (&v->counter)
-	: "cc", "xer", "memory");
-
-	return t1 != 0;
-}
-#define atomic64_inc_not_zero(v) atomic64_inc_not_zero((v))
-
-#endif /* __powerpc64__ */
+#define atomic64_dec_if_positive_relaxed atomic64_dec_if_positive_relaxed
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ATOMIC_H_ */
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index cf091c4c22e5..181f7e8b3281 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -192,7 +192,7 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
      		(unsigned long)_x_, sizeof(*(ptr))); 			     \
   })
 
-#define xchg_relaxed(ptr, x)						\
+#define arch_xchg_relaxed(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
@@ -448,35 +448,7 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
 	return old;
 }
 
-static __always_inline unsigned long
-__cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
-		  unsigned int size)
-{
-	switch (size) {
-	case 1:
-		return __cmpxchg_u8_acquire(ptr, old, new);
-	case 2:
-		return __cmpxchg_u16_acquire(ptr, old, new);
-	case 4:
-		return __cmpxchg_u32_acquire(ptr, old, new);
-#ifdef CONFIG_PPC64
-	case 8:
-		return __cmpxchg_u64_acquire(ptr, old, new);
-#endif
-	}
-	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
-	return old;
-}
-#define cmpxchg(ptr, o, n)						 \
-  ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
-     __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
-  })
-
-
-#define cmpxchg_local(ptr, o, n)					 \
+#define arch_cmpxchg_local(ptr, o, n)					 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
@@ -484,7 +456,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
-#define cmpxchg_relaxed(ptr, o, n)					\
+#define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -493,38 +465,20 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			sizeof(*(ptr)));				\
 })
 
-#define cmpxchg_acquire(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
-			(unsigned long)_o_, (unsigned long)_n_,		\
-			sizeof(*(ptr)));				\
-})
 #ifdef CONFIG_PPC64
-#define cmpxchg64(ptr, o, n)						\
-  ({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
-  })
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
   })
-#define cmpxchg64_relaxed(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_relaxed((ptr), (o), (n));				\
-})
-#define cmpxchg64_acquire(ptr, o, n)					\
+#define arch_cmpxchg64_relaxed(ptr, o, n)				\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_acquire((ptr), (o), (n));				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 #else
 #include <asm-generic/cmpxchg-local.h>
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
-- 
2.23.0

