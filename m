Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3170BE4C
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjEVM3a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjEVM1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11770133;
        Mon, 22 May 2023 05:25:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71B4139F;
        Mon, 22 May 2023 05:26:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47FDA3F59C;
        Mon, 22 May 2023 05:25:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 26/26] locking/atomic: treewide: delete arch_atomic_*() kerneldoc
Date:   Mon, 22 May 2023 13:24:29 +0100
Message-Id: <20230522122429.1915021-27-mark.rutland@arm.com>
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

Currently several architectures have kerneldoc comments for
arch_atomic_*(), which is unhelpful as these live in a shared namespace
where they clash, and the arch_atomic_*() ops are now an implementation
detail of the raw_atomic_*() ops, which no-one should use those
directly.

Delete the kerneldoc comments for arch_atomic_*(), along with
pseudo-kerneldoc comments which are in the correct style but are missing
the leading '/**' necessary to be true kerneldoc comments.

Drop x86's asm/atomic.h from Documentation/driver-api/basics.rst as it
no longer contains any relevant kerneldoc comments.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/driver-api/basics.rst   |  3 -
 arch/alpha/include/asm/atomic.h       | 25 --------
 arch/arc/include/asm/atomic64-arcv2.h | 17 ------
 arch/hexagon/include/asm/atomic.h     | 16 -----
 arch/loongarch/include/asm/atomic.h   | 49 ---------------
 arch/x86/include/asm/atomic.h         | 87 ---------------------------
 arch/x86/include/asm/atomic64_32.h    | 76 -----------------------
 arch/x86/include/asm/atomic64_64.h    | 81 -------------------------
 8 files changed, 354 deletions(-)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index a1fbd97fb79fb..d8e4e5c82bcf0 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -84,9 +84,6 @@ Reference counting
 Atomics
 -------
 
-.. kernel-doc:: arch/x86/include/asm/atomic.h
-   :internal:
-
 .. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
    :internal:
 
diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index ec8ab552c527a..cbd9244571af0 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -200,15 +200,6 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * arch_atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
 static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
@@ -232,15 +223,6 @@ static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
- */
 static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c, new, old;
@@ -264,13 +246,6 @@ static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
-/*
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
 static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 old, tmp;
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index 2b7c9e61a2947..6b6db981967ae 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -182,14 +182,6 @@ static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-/**
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic64_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-
 static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 val;
@@ -214,15 +206,6 @@ static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 }
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if it was not @u.
- * Returns the old value of @v
- */
 static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 old, temp;
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 5c8440016c762..2447d083c432f 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -28,12 +28,6 @@ static inline void arch_atomic_set(atomic_t *v, int new)
 
 #define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-/**
- * arch_atomic_read - reads a word, atomically
- * @v: pointer to atomic value
- *
- * Assumes all word reads on our architecture are atomic.
- */
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 #define ATOMIC_OP(op)							\
@@ -112,16 +106,6 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/**
- * arch_atomic_fetch_add_unless - add unless the number is a given value
- * @v: pointer to value
- * @a: amount to add
- * @u: unless value is equal to u
- *
- * Returns old value.
- *
- */
-
 static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int __oldval;
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 8d73c85911b08..e27f0c72d3242 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -29,21 +29,7 @@
 
 #define ATOMIC_INIT(i)	  { (i) }
 
-/*
- * arch_atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 #define arch_atomic_read(v)	READ_ONCE((v)->counter)
-
-/*
- * arch_atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 #define arch_atomic_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC_OP(op, I, asm_op)					\
@@ -139,14 +125,6 @@ static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
-/*
- * arch_atomic_sub_if_positive - conditionally subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically test @v and subtract @i if @v is greater or equal than @i.
- * The function returns the old value of @v minus @i.
- */
 static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 {
 	int result;
@@ -181,28 +159,13 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 	return result;
 }
 
-/*
- * arch_atomic_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- */
 #define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(1, v)
 
 #ifdef CONFIG_64BIT
 
 #define ATOMIC64_INIT(i)    { (i) }
 
-/*
- * arch_atomic64_read - read atomic variable
- * @v: pointer of type atomic64_t
- *
- */
 #define arch_atomic64_read(v)	READ_ONCE((v)->counter)
-
-/*
- * arch_atomic64_set - set atomic variable
- * @v: pointer of type atomic64_t
- * @i: required value
- */
 #define arch_atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC64_OP(op, I, asm_op)					\
@@ -297,14 +260,6 @@ static inline long arch_atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
-/*
- * arch_atomic64_sub_if_positive - conditionally subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically test @v and subtract @i if @v is greater or equal than @i.
- * The function returns the old value of @v minus @i.
- */
 static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 {
 	long result;
@@ -339,10 +294,6 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 	return result;
 }
 
-/*
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic64_t
- */
 #define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(1, v)
 
 #endif /* CONFIG_64BIT */
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 5e754e8957671..55a55ec043502 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -14,12 +14,6 @@
  * resource counting etc..
  */
 
-/**
- * arch_atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	/*
@@ -29,25 +23,11 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	return __READ_ONCE((v)->counter);
 }
 
-/**
- * arch_atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
 
-/**
- * arch_atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0"
@@ -55,13 +35,6 @@ static __always_inline void arch_atomic_add(int i, atomic_t *v)
 		     : "ir" (i) : "memory");
 }
 
-/**
- * arch_atomic_sub - subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "subl %1,%0"
@@ -69,27 +42,12 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 		     : "ir" (i) : "memory");
 }
 
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, e, "er", i);
 }
 #define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
-/**
- * arch_atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
@@ -97,12 +55,6 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
 }
 #define arch_atomic_inc arch_atomic_inc
 
-/**
- * arch_atomic_dec - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
@@ -110,69 +62,30 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
 }
 #define arch_atomic_dec arch_atomic_dec
 
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, e);
 }
 #define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, e);
 }
 #define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
-/**
- * arch_atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, s, "er", i);
 }
 #define arch_atomic_add_negative arch_atomic_add_negative
 
-/**
- * arch_atomic_add_return - add integer and return
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
 static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-/**
- * arch_atomic_sub_return - subtract integer and return
- * @v: pointer of type atomic_t
- * @i: integer value to subtract
- *
- * Atomically subtracts @i from @v and returns @v - @i
- */
 static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 808b4eece251e..3486d91b8595f 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -61,30 +61,12 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-/**
- * arch_atomic64_cmpxchg - cmpxchg atomic64 variable
- * @v: pointer to type atomic64_t
- * @o: expected value
- * @n: new value
- *
- * Atomically sets @v to @n if it was equal to @o and returns
- * the old value.
- */
-
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-/**
- * arch_atomic64_xchg - xchg atomic64 variable
- * @v: pointer to type atomic64_t
- * @n: value to assign
- *
- * Atomically xchgs the value of @v to @n and returns
- * the old value.
- */
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
@@ -97,13 +79,6 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-/**
- * arch_atomic64_set - set atomic64 variable
- * @v: pointer to type atomic64_t
- * @i: value to assign
- *
- * Atomically sets the value of @v to @n.
- */
 static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned high = (unsigned)(i >> 32);
@@ -113,12 +88,6 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 			     : "eax", "edx", "memory");
 }
 
-/**
- * arch_atomic64_read - read atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically reads the value of @v and returns it.
- */
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
@@ -126,13 +95,6 @@ static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 	return r;
 }
 
-/**
- * arch_atomic64_add_return - add and return
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns @i + *@v
- */
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
@@ -142,9 +104,6 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-/*
- * Other variants with different arithmetic operators:
- */
 static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
@@ -172,13 +131,6 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
 
-/**
- * arch_atomic64_add - add integer to atomic64 variable
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
@@ -187,13 +139,6 @@ static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 	return i;
 }
 
-/**
- * arch_atomic64_sub - subtract the atomic64 variable
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
@@ -202,12 +147,6 @@ static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 	return i;
 }
 
-/**
- * arch_atomic64_inc - increment atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
@@ -215,12 +154,6 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
-/**
- * arch_atomic64_dec - decrement atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
@@ -228,15 +161,6 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
-/**
- * arch_atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns non-zero if the add was done, zero otherwise.
- */
 static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned low = (unsigned)u;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index c496595bf6012..3165c0feedf74 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -10,37 +10,16 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-/**
- * arch_atomic64_read - read atomic64 variable
- * @v: pointer of type atomic64_t
- *
- * Atomically reads the value of @v.
- * Doesn't imply a read memory barrier.
- */
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return __READ_ONCE((v)->counter);
 }
 
-/**
- * arch_atomic64_set - set atomic64 variable
- * @v: pointer to type atomic64_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
 
-/**
- * arch_atomic64_add - add integer to atomic64 variable
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v.
- */
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "addq %1,%0"
@@ -48,13 +27,6 @@ static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
-/**
- * arch_atomic64_sub - subtract the atomic64 variable
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v.
- */
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
@@ -62,27 +34,12 @@ static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
-/**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, e, "er", i);
 }
 #define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
-/**
- * arch_atomic64_inc - increment atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1.
- */
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
@@ -91,12 +48,6 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
-/**
- * arch_atomic64_dec - decrement atomic64 variable
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1.
- */
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
@@ -105,56 +56,24 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
-/**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer to type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
 static __always_inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, e);
 }
 #define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
-/**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer to type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
 static __always_inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, e);
 }
 #define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
-/**
- * arch_atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
 static __always_inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, s, "er", i);
 }
 #define arch_atomic64_add_negative arch_atomic64_add_negative
 
-/**
- * arch_atomic64_add_return - add and return
- * @i: integer value to add
- * @v: pointer to type atomic64_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return i + xadd(&v->counter, i);
-- 
2.30.2

