Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226E70BE0C
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjEVM1R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjEVM0j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E6621FCB;
        Mon, 22 May 2023 05:24:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40691515;
        Mon, 22 May 2023 05:25:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29E7A3F59C;
        Mon, 22 May 2023 05:24:46 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 04/26] locking/atomic: make atomic*_{cmp,}xchg optional
Date:   Mon, 22 May 2023 13:24:07 +0100
Message-Id: <20230522122429.1915021-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Most architectures define the atomic/atomic64 xchg and cmpxchg
operations in terms of arch_xchg and arch_cmpxchg respectfully.

Add fallbacks for these cases and remove the trivial cases from arch
code. On some architectures the existing definitions are kept as these
are used to build other arch_atomic*() operations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/alpha/include/asm/atomic.h             |  10 --
 arch/arc/include/asm/atomic.h               |  24 ---
 arch/arc/include/asm/atomic64-arcv2.h       |   2 +
 arch/arm/include/asm/atomic.h               |   3 +-
 arch/arm64/include/asm/atomic.h             |  28 ----
 arch/csky/include/asm/atomic.h              |  35 -----
 arch/hexagon/include/asm/atomic.h           |   6 -
 arch/ia64/include/asm/atomic.h              |   7 -
 arch/loongarch/include/asm/atomic.h         |   7 -
 arch/m68k/include/asm/atomic.h              |   9 +-
 arch/mips/include/asm/atomic.h              |  11 --
 arch/openrisc/include/asm/atomic.h          |   3 -
 arch/parisc/include/asm/atomic.h            |   9 --
 arch/powerpc/include/asm/atomic.h           |  24 ---
 arch/riscv/include/asm/atomic.h             |  72 ---------
 arch/sh/include/asm/atomic.h                |   3 -
 arch/sparc/include/asm/atomic_32.h          |   2 +
 arch/sparc/include/asm/atomic_64.h          |  11 --
 arch/xtensa/include/asm/atomic.h            |   3 -
 include/asm-generic/atomic.h                |   3 -
 include/linux/atomic/atomic-arch-fallback.h | 158 +++++++++++++++++++-
 scripts/atomic/fallbacks/cmpxchg            |   7 +
 scripts/atomic/fallbacks/xchg               |   7 +
 23 files changed, 179 insertions(+), 265 deletions(-)
 create mode 100755 scripts/atomic/fallbacks/cmpxchg
 create mode 100755 scripts/atomic/fallbacks/xchg

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index f2861a43a61ef..ec8ab552c527a 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -200,16 +200,6 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define arch_atomic64_cmpxchg(v, old, new) \
-	(arch_cmpxchg(&((v)->counter), old, new))
-#define arch_atomic64_xchg(v, new) \
-	(arch_xchg(&((v)->counter), new))
-
-#define arch_atomic_cmpxchg(v, old, new) \
-	(arch_cmpxchg(&((v)->counter), old, new))
-#define arch_atomic_xchg(v, new) \
-	(arch_xchg(&((v)->counter), new))
-
 /**
  * arch_atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 52ee51e1ff7c2..592d7fffc223c 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -22,30 +22,6 @@
 #include <asm/atomic-spinlock.h>
 #endif
 
-#define arch_atomic_cmpxchg(v, o, n)					\
-({									\
-	arch_cmpxchg(&((v)->counter), (o), (n));			\
-})
-
-#ifdef arch_cmpxchg_relaxed
-#define arch_atomic_cmpxchg_relaxed(v, o, n)				\
-({									\
-	arch_cmpxchg_relaxed(&((v)->counter), (o), (n));		\
-})
-#endif
-
-#define arch_atomic_xchg(v, n)						\
-({									\
-	arch_xchg(&((v)->counter), (n));				\
-})
-
-#ifdef arch_xchg_relaxed
-#define arch_atomic_xchg_relaxed(v, n)					\
-({									\
-	arch_xchg_relaxed(&((v)->counter), (n));			\
-})
-#endif
-
 /*
  * 64-bit atomics
  */
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index c5a8010fdc97d..2b7c9e61a2947 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -159,6 +159,7 @@ arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 
 	return prev;
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
 static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 {
@@ -179,6 +180,7 @@ static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 
 	return prev;
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 /**
  * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index db8512d9a918d..9458d47ff209c 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -210,6 +210,7 @@ static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 
 	return ret;
 }
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
 #define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
 
@@ -240,8 +241,6 @@ ATOMIC_OPS(xor, ^=, eor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
 	s64 counter;
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index c9979273d3898..400d279e0f8d0 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -142,24 +142,6 @@ static __always_inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 #define arch_atomic_fetch_xor_release		arch_atomic_fetch_xor_release
 #define arch_atomic_fetch_xor			arch_atomic_fetch_xor
 
-#define arch_atomic_xchg_relaxed(v, new) \
-	arch_xchg_relaxed(&((v)->counter), (new))
-#define arch_atomic_xchg_acquire(v, new) \
-	arch_xchg_acquire(&((v)->counter), (new))
-#define arch_atomic_xchg_release(v, new) \
-	arch_xchg_release(&((v)->counter), (new))
-#define arch_atomic_xchg(v, new) \
-	arch_xchg(&((v)->counter), (new))
-
-#define arch_atomic_cmpxchg_relaxed(v, old, new) \
-	arch_cmpxchg_relaxed(&((v)->counter), (old), (new))
-#define arch_atomic_cmpxchg_acquire(v, old, new) \
-	arch_cmpxchg_acquire(&((v)->counter), (old), (new))
-#define arch_atomic_cmpxchg_release(v, old, new) \
-	arch_cmpxchg_release(&((v)->counter), (old), (new))
-#define arch_atomic_cmpxchg(v, old, new) \
-	arch_cmpxchg(&((v)->counter), (old), (new))
-
 #define arch_atomic_andnot			arch_atomic_andnot
 
 /*
@@ -209,16 +191,6 @@ static __always_inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 #define arch_atomic64_fetch_xor_release		arch_atomic64_fetch_xor_release
 #define arch_atomic64_fetch_xor			arch_atomic64_fetch_xor
 
-#define arch_atomic64_xchg_relaxed		arch_atomic_xchg_relaxed
-#define arch_atomic64_xchg_acquire		arch_atomic_xchg_acquire
-#define arch_atomic64_xchg_release		arch_atomic_xchg_release
-#define arch_atomic64_xchg			arch_atomic_xchg
-
-#define arch_atomic64_cmpxchg_relaxed		arch_atomic_cmpxchg_relaxed
-#define arch_atomic64_cmpxchg_acquire		arch_atomic_cmpxchg_acquire
-#define arch_atomic64_cmpxchg_release		arch_atomic_cmpxchg_release
-#define arch_atomic64_cmpxchg			arch_atomic_cmpxchg
-
 #define arch_atomic64_andnot			arch_atomic64_andnot
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
index 60406ef9c2bbc..4dab44f6143a5 100644
--- a/arch/csky/include/asm/atomic.h
+++ b/arch/csky/include/asm/atomic.h
@@ -195,41 +195,6 @@ arch_atomic_dec_if_positive(atomic_t *v)
 }
 #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 
-#define ATOMIC_OP()							\
-static __always_inline							\
-int arch_atomic_xchg_relaxed(atomic_t *v, int n)			\
-{									\
-	return __xchg_relaxed(n, &(v->counter), 4);			\
-}									\
-static __always_inline							\
-int arch_atomic_cmpxchg_relaxed(atomic_t *v, int o, int n)		\
-{									\
-	return __cmpxchg_relaxed(&(v->counter), o, n, 4);		\
-}									\
-static __always_inline							\
-int arch_atomic_cmpxchg_acquire(atomic_t *v, int o, int n)		\
-{									\
-	return __cmpxchg_acquire(&(v->counter), o, n, 4);		\
-}									\
-static __always_inline							\
-int arch_atomic_cmpxchg(atomic_t *v, int o, int n)			\
-{									\
-	return __cmpxchg(&(v->counter), o, n, 4);			\
-}
-
-#define ATOMIC_OPS()							\
-	ATOMIC_OP()
-
-ATOMIC_OPS()
-
-#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
-#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
-#define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
-#define arch_atomic_cmpxchg		arch_atomic_cmpxchg
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP
-
 #else
 #include <asm-generic/atomic.h>
 #endif
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 738857e10d6ec..ad6c111e9c10f 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -36,12 +36,6 @@ static inline void arch_atomic_set(atomic_t *v, int new)
  */
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
-#define arch_atomic_xchg(v, new)					\
-	(arch_xchg(&((v)->counter), (new)))
-
-#define arch_atomic_cmpxchg(v, old, new)				\
-	(arch_cmpxchg(&((v)->counter), (old), (new)))
-
 #define ATOMIC_OP(op)							\
 static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 266c429b91372..6540a628d2573 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -207,13 +207,6 @@ ATOMIC64_FETCH_OP(xor, ^)
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP
 
-#define arch_atomic_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
-#define arch_atomic64_cmpxchg(v, old, new) \
-	(arch_cmpxchg(&((v)->counter), old, new))
-#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 #define arch_atomic_add(i,v)		(void)arch_atomic_add_return((i), (v))
 #define arch_atomic_sub(i,v)		(void)arch_atomic_sub_return((i), (v))
 
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 6b9aca9ab6e9f..8d73c85911b08 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -181,9 +181,6 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 	return result;
 }
 
-#define arch_atomic_cmpxchg(v, o, n) (arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
-
 /*
  * arch_atomic_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
@@ -342,10 +339,6 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 	return result;
 }
 
-#define arch_atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
-
 /*
  * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic64_t
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index cfba83d230fde..190a032f19be7 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -158,12 +158,7 @@ static inline int arch_atomic_inc_and_test(atomic_t *v)
 }
 #define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
-#ifdef CONFIG_RMW_INSNS
-
-#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
-#else /* !CONFIG_RMW_INSNS */
+#ifndef CONFIG_RMW_INSNS
 
 static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
@@ -177,6 +172,7 @@ static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 	local_irq_restore(flags);
 	return prev;
 }
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
@@ -189,6 +185,7 @@ static inline int arch_atomic_xchg(atomic_t *v, int new)
 	local_irq_restore(flags);
 	return prev;
 }
+#define arch_atomic_xchg arch_atomic_xchg
 
 #endif /* !CONFIG_RMW_INSNS */
 
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 712fb5a6a5682..ba188e77768b2 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -33,17 +33,6 @@ static __always_inline void arch_##pfx##_set(pfx##_t *v, type i)	\
 {									\
 	WRITE_ONCE(v->counter, i);					\
 }									\
-									\
-static __always_inline type						\
-arch_##pfx##_cmpxchg(pfx##_t *v, type o, type n)			\
-{									\
-	return arch_cmpxchg(&v->counter, o, n);				\
-}									\
-									\
-static __always_inline type arch_##pfx##_xchg(pfx##_t *v, type n)	\
-{									\
-	return arch_xchg(&v->counter, n);				\
-}
 
 ATOMIC_OPS(atomic, int)
 
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
index 326167e4783a9..8ce67ec7c9a30 100644
--- a/arch/openrisc/include/asm/atomic.h
+++ b/arch/openrisc/include/asm/atomic.h
@@ -130,7 +130,4 @@ static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 #include <asm/cmpxchg.h>
 
-#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
-#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
-
 #endif /* __ASM_OPENRISC_ATOMIC_H */
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index dd5a299ada695..0b3f64c92e3c0 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -73,10 +73,6 @@ static __inline__ int arch_atomic_read(const atomic_t *v)
 	return READ_ONCE((v)->counter);
 }
 
-/* exported interface */
-#define arch_atomic_cmpxchg(v, o, n)	(arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
-
 #define ATOMIC_OP(op, c_op)						\
 static __inline__ void arch_atomic_##op(int i, atomic_t *v)		\
 {									\
@@ -218,11 +214,6 @@ arch_atomic64_read(const atomic64_t *v)
 	return READ_ONCE((v)->counter);
 }
 
-/* exported interface */
-#define arch_atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 #endif /* !CONFIG_64BIT */
 
 
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 47228b1774781..5bf6a4d49268c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -126,18 +126,6 @@ ATOMIC_OPS(xor, xor, "", K)
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-#define arch_atomic_cmpxchg(v, o, n) \
-	(arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic_cmpxchg_relaxed(v, o, n) \
-	arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define arch_atomic_cmpxchg_acquire(v, o, n) \
-	arch_cmpxchg_acquire(&((v)->counter), (o), (n))
-
-#define arch_atomic_xchg(v, new) \
-	(arch_xchg(&((v)->counter), new))
-#define arch_atomic_xchg_relaxed(v, new) \
-	arch_xchg_relaxed(&((v)->counter), (new))
-
 /**
  * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
@@ -396,18 +384,6 @@ static __inline__ s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 }
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-#define arch_atomic64_cmpxchg(v, o, n) \
-	(arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic64_cmpxchg_relaxed(v, o, n) \
-	arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define arch_atomic64_cmpxchg_acquire(v, o, n) \
-	arch_cmpxchg_acquire(&((v)->counter), (o), (n))
-
-#define arch_atomic64_xchg(v, new) \
-	(arch_xchg(&((v)->counter), new))
-#define arch_atomic64_xchg_relaxed(v, new) \
-	arch_xchg_relaxed(&((v)->counter), (new))
-
 /**
  * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index bba472928b539..f5dfef6c2153f 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -238,78 +238,6 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 #endif
 
-/*
- * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
- * {cmp,}xchg and the operations that return, so they need a full barrier.
- */
-#define ATOMIC_OP(c_t, prefix, size)					\
-static __always_inline							\
-c_t arch_atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)	\
-{									\
-	return __xchg_relaxed(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)	\
-{									\
-	return __xchg_acquire(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
-{									\
-	return __xchg_release(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
-{									\
-	return __arch_xchg(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
-				     c_t o, c_t n)			\
-{									\
-	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,	\
-				     c_t o, c_t n)			\
-{									\
-	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,	\
-				     c_t o, c_t n)			\
-{									\
-	return __cmpxchg_release(&(v->counter), o, n, size);		\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
-{									\
-	return __cmpxchg(&(v->counter), o, n, size);			\
-}
-
-#ifdef CONFIG_GENERIC_ATOMIC64
-#define ATOMIC_OPS()							\
-	ATOMIC_OP(int,   , 4)
-#else
-#define ATOMIC_OPS()							\
-	ATOMIC_OP(int,   , 4)						\
-	ATOMIC_OP(s64, 64, 8)
-#endif
-
-ATOMIC_OPS()
-
-#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
-#define arch_atomic_xchg_acquire	arch_atomic_xchg_acquire
-#define arch_atomic_xchg_release	arch_atomic_xchg_release
-#define arch_atomic_xchg		arch_atomic_xchg
-#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
-#define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
-#define arch_atomic_cmpxchg_release	arch_atomic_cmpxchg_release
-#define arch_atomic_cmpxchg		arch_atomic_cmpxchg
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP
-
 static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 {
 	int prev, rc;
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 528bfeda78f56..7a18cb2a1c1ac 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -30,9 +30,6 @@
 #include <asm/atomic-irq.h>
 #endif
 
-#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
-#define arch_atomic_cmpxchg(v, o, n)	(arch_cmpxchg(&((v)->counter), (o), (n)))
-
 #endif /* CONFIG_CPU_J2 */
 
 #endif /* __ASM_SH_ATOMIC_H */
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index d775daa83d129..1c9e6c7366e41 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -24,7 +24,9 @@ int arch_atomic_fetch_and(int, atomic_t *);
 int arch_atomic_fetch_or(int, atomic_t *);
 int arch_atomic_fetch_xor(int, atomic_t *);
 int arch_atomic_cmpxchg(atomic_t *, int, int);
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 int arch_atomic_xchg(atomic_t *, int);
+#define arch_atomic_xchg arch_atomic_xchg
 int arch_atomic_fetch_add_unless(atomic_t *, int, int);
 void arch_atomic_set(atomic_t *, int);
 
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 077891686715a..df6a8b07d7e63 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -49,17 +49,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define arch_atomic_cmpxchg(v, o, n) (arch_cmpxchg(&((v)->counter), (o), (n)))
-
-static inline int arch_atomic_xchg(atomic_t *v, int new)
-{
-	return arch_xchg(&v->counter, new);
-}
-
-#define arch_atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 s64 arch_atomic64_dec_if_positive(atomic64_t *v);
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 52da614f953ce..1d323a864002c 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -257,7 +257,4 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 #endif /* _XTENSA_ATOMIC_H */
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index e271d6708c876..22142c71d35a1 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -130,7 +130,4 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_read(v)			READ_ONCE((v)->counter)
 #define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
 
-#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (u32)(v)))
-#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (u32)(old), (u32)(new)))
-
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 3ce4cb5e790c5..1a2d81dbc2e48 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1091,9 +1091,48 @@ arch_atomic_fetch_xor(int i, atomic_t *v)
 #endif /* arch_atomic_fetch_xor_relaxed */
 
 #ifndef arch_atomic_xchg_relaxed
+#ifdef arch_atomic_xchg
 #define arch_atomic_xchg_acquire arch_atomic_xchg
 #define arch_atomic_xchg_release arch_atomic_xchg
 #define arch_atomic_xchg_relaxed arch_atomic_xchg
+#endif /* arch_atomic_xchg */
+
+#ifndef arch_atomic_xchg
+static __always_inline int
+arch_atomic_xchg(atomic_t *v, int new)
+{
+	return arch_xchg(&v->counter, new);
+}
+#define arch_atomic_xchg arch_atomic_xchg
+#endif
+
+#ifndef arch_atomic_xchg_acquire
+static __always_inline int
+arch_atomic_xchg_acquire(atomic_t *v, int new)
+{
+	return arch_xchg_acquire(&v->counter, new);
+}
+#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
+#endif
+
+#ifndef arch_atomic_xchg_release
+static __always_inline int
+arch_atomic_xchg_release(atomic_t *v, int new)
+{
+	return arch_xchg_release(&v->counter, new);
+}
+#define arch_atomic_xchg_release arch_atomic_xchg_release
+#endif
+
+#ifndef arch_atomic_xchg_relaxed
+static __always_inline int
+arch_atomic_xchg_relaxed(atomic_t *v, int new)
+{
+	return arch_xchg_relaxed(&v->counter, new);
+}
+#define arch_atomic_xchg_relaxed arch_atomic_xchg_relaxed
+#endif
+
 #else /* arch_atomic_xchg_relaxed */
 
 #ifndef arch_atomic_xchg_acquire
@@ -1133,9 +1172,48 @@ arch_atomic_xchg(atomic_t *v, int i)
 #endif /* arch_atomic_xchg_relaxed */
 
 #ifndef arch_atomic_cmpxchg_relaxed
+#ifdef arch_atomic_cmpxchg
 #define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
 #define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
 #define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#endif /* arch_atomic_cmpxchg */
+
+#ifndef arch_atomic_cmpxchg
+static __always_inline int
+arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return arch_cmpxchg(&v->counter, old, new);
+}
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
+#endif
+
+#ifndef arch_atomic_cmpxchg_acquire
+static __always_inline int
+arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	return arch_cmpxchg_acquire(&v->counter, old, new);
+}
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_cmpxchg_release
+static __always_inline int
+arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	return arch_cmpxchg_release(&v->counter, old, new);
+}
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_cmpxchg_relaxed
+static __always_inline int
+arch_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	return arch_cmpxchg_relaxed(&v->counter, old, new);
+}
+#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg_relaxed
+#endif
+
 #else /* arch_atomic_cmpxchg_relaxed */
 
 #ifndef arch_atomic_cmpxchg_acquire
@@ -2225,9 +2303,48 @@ arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 #endif /* arch_atomic64_fetch_xor_relaxed */
 
 #ifndef arch_atomic64_xchg_relaxed
+#ifdef arch_atomic64_xchg
 #define arch_atomic64_xchg_acquire arch_atomic64_xchg
 #define arch_atomic64_xchg_release arch_atomic64_xchg
 #define arch_atomic64_xchg_relaxed arch_atomic64_xchg
+#endif /* arch_atomic64_xchg */
+
+#ifndef arch_atomic64_xchg
+static __always_inline s64
+arch_atomic64_xchg(atomic64_t *v, s64 new)
+{
+	return arch_xchg(&v->counter, new);
+}
+#define arch_atomic64_xchg arch_atomic64_xchg
+#endif
+
+#ifndef arch_atomic64_xchg_acquire
+static __always_inline s64
+arch_atomic64_xchg_acquire(atomic64_t *v, s64 new)
+{
+	return arch_xchg_acquire(&v->counter, new);
+}
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#endif
+
+#ifndef arch_atomic64_xchg_release
+static __always_inline s64
+arch_atomic64_xchg_release(atomic64_t *v, s64 new)
+{
+	return arch_xchg_release(&v->counter, new);
+}
+#define arch_atomic64_xchg_release arch_atomic64_xchg_release
+#endif
+
+#ifndef arch_atomic64_xchg_relaxed
+static __always_inline s64
+arch_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
+{
+	return arch_xchg_relaxed(&v->counter, new);
+}
+#define arch_atomic64_xchg_relaxed arch_atomic64_xchg_relaxed
+#endif
+
 #else /* arch_atomic64_xchg_relaxed */
 
 #ifndef arch_atomic64_xchg_acquire
@@ -2267,9 +2384,48 @@ arch_atomic64_xchg(atomic64_t *v, s64 i)
 #endif /* arch_atomic64_xchg_relaxed */
 
 #ifndef arch_atomic64_cmpxchg_relaxed
+#ifdef arch_atomic64_cmpxchg
 #define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
 #define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
 #define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#endif /* arch_atomic64_cmpxchg */
+
+#ifndef arch_atomic64_cmpxchg
+static __always_inline s64
+arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_cmpxchg(&v->counter, old, new);
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+#endif
+
+#ifndef arch_atomic64_cmpxchg_acquire
+static __always_inline s64
+arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_cmpxchg_acquire(&v->counter, old, new);
+}
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_cmpxchg_release
+static __always_inline s64
+arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_cmpxchg_release(&v->counter, old, new);
+}
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_cmpxchg_relaxed
+static __always_inline s64
+arch_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_cmpxchg_relaxed(&v->counter, old, new);
+}
+#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg_relaxed
+#endif
+
 #else /* arch_atomic64_cmpxchg_relaxed */
 
 #ifndef arch_atomic64_cmpxchg_acquire
@@ -2597,4 +2753,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 9f0fd6ed53267c6ec64e36cd18e6fd8df57ea277
+// e1cee558cc61cae887890db30fcdf93baca9f498
diff --git a/scripts/atomic/fallbacks/cmpxchg b/scripts/atomic/fallbacks/cmpxchg
new file mode 100755
index 0000000000000..87cd010f98d58
--- /dev/null
+++ b/scripts/atomic/fallbacks/cmpxchg
@@ -0,0 +1,7 @@
+cat <<EOF
+static __always_inline ${int}
+arch_${atomic}_cmpxchg${order}(${atomic}_t *v, ${int} old, ${int} new)
+{
+	return arch_cmpxchg${order}(&v->counter, old, new);
+}
+EOF
diff --git a/scripts/atomic/fallbacks/xchg b/scripts/atomic/fallbacks/xchg
new file mode 100755
index 0000000000000..733b8980b2f3b
--- /dev/null
+++ b/scripts/atomic/fallbacks/xchg
@@ -0,0 +1,7 @@
+cat <<EOF
+static __always_inline ${int}
+arch_${atomic}_xchg${order}(${atomic}_t *v, ${int} new)
+{
+	return arch_xchg${order}(&v->counter, new);
+}
+EOF
-- 
2.30.2

