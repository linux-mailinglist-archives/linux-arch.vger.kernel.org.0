Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395473FFDA3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbhICJ5j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235067AbhICJ5j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:57:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 142566056B;
        Fri,  3 Sep 2021 09:56:34 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 07/22] LoongArch: Add atomic/locking headers
Date:   Fri,  3 Sep 2021 17:51:58 +0800
Message-Id: <20210903095213.797973-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds common headers (atomic, bitops, barrier and locking)
for basic LoongArch support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/atomic.h         | 298 ++++++++++++++++++++
 arch/loongarch/include/asm/barrier.h        |  53 ++++
 arch/loongarch/include/asm/bitops.h         | 220 +++++++++++++++
 arch/loongarch/include/asm/bitrev.h         |  34 +++
 arch/loongarch/include/asm/local.h          | 138 +++++++++
 arch/loongarch/include/asm/percpu.h         |  20 ++
 arch/loongarch/include/asm/spinlock.h       |  12 +
 arch/loongarch/include/asm/spinlock_types.h |  11 +
 8 files changed, 786 insertions(+)
 create mode 100644 arch/loongarch/include/asm/atomic.h
 create mode 100644 arch/loongarch/include/asm/barrier.h
 create mode 100644 arch/loongarch/include/asm/bitops.h
 create mode 100644 arch/loongarch/include/asm/bitrev.h
 create mode 100644 arch/loongarch/include/asm/local.h
 create mode 100644 arch/loongarch/include/asm/percpu.h
 create mode 100644 arch/loongarch/include/asm/spinlock.h
 create mode 100644 arch/loongarch/include/asm/spinlock_types.h

diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
new file mode 100644
index 000000000000..091552d84aa0
--- /dev/null
+++ b/arch/loongarch/include/asm/atomic.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Atomic operations.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_ATOMIC_H
+#define _ASM_ATOMIC_H
+
+#include <linux/irqflags.h>
+#include <linux/types.h>
+#include <asm/barrier.h>
+#include <asm/compiler.h>
+#include <asm/cpu-features.h>
+#include <asm/cmpxchg.h>
+
+#define ATOMIC_INIT(i)	  { (i) }
+
+/*
+ * arch_atomic_read - read atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically reads the value of @v.
+ */
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+
+/*
+ * arch_atomic_set - set atomic variable
+ * @v: pointer of type atomic_t
+ * @i: required value
+ *
+ * Atomically sets the value of @v to @i.
+ */
+#define arch_atomic_set(v, i)	WRITE_ONCE((v)->counter, (i))
+
+#define ATOMIC_OP(op, I, asm_op)					\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	__asm__ __volatile__(						\
+	"am"#asm_op"_db.w" " $zero, %1, %0	\n"			\
+	: "+ZB" (v->counter)						\
+	: "r" (I)							\
+	: "memory");							\
+}
+
+#define ATOMIC_OP_RETURN(op, I, asm_op, c_op)				\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+{									\
+	int result;							\
+									\
+	__asm__ __volatile__(						\
+	"am"#asm_op"_db.w" " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)				\
+	: "r" (I)							\
+	: "memory");							\
+									\
+	return result c_op I;						\
+}
+
+#define ATOMIC_FETCH_OP(op, I, asm_op)					\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+{									\
+	int result;							\
+									\
+	__asm__ __volatile__(						\
+	"am"#asm_op"_db.w" " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)				\
+	: "r" (I)							\
+	: "memory");							\
+									\
+	return result;							\
+}
+
+#define ATOMIC_OPS(op, I, asm_op, c_op)					\
+	ATOMIC_OP(op, I, asm_op)					\
+	ATOMIC_OP_RETURN(op, I, asm_op, c_op)				\
+	ATOMIC_FETCH_OP(op, I, asm_op)
+
+ATOMIC_OPS(add, i, add, +)
+ATOMIC_OPS(sub, -i, add, +)
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
+/*
+ * arch_atomic_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically test @v and subtract @i if @v is greater or equal than @i.
+ * The function returns the old value of @v minus @i.
+ */
+static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
+{
+	int result;
+	int temp;
+
+	if (__builtin_constant_p(i)) {
+		__asm__ __volatile__(
+		"1:	ll.w	%1, %2		# atomic_sub_if_positive\n"
+		"	addi.w	%0, %1, %3				\n"
+		"	or	%1, %0, $zero				\n"
+		"	blt	%0, $zero, 2f				\n"
+		"	sc.w	%1, %2					\n"
+		"	beq	$zero, %1, 1b				\n"
+		"2:							\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "I" (-i));
+	} else {
+		__asm__ __volatile__(
+		"1:	ll.w	%1, %2		# atomic_sub_if_positive\n"
+		"	sub.w	%0, %1, %3				\n"
+		"	or	%1, %0, $zero				\n"
+		"	blt	%0, $zero, 2f				\n"
+		"	sc.w	%1, %2					\n"
+		"	beq	$zero, %1, 1b				\n"
+		"2:							\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "r" (i));
+	}
+
+	return result;
+}
+
+#define arch_atomic_cmpxchg(v, o, n) (arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
+
+/*
+ * arch_atomic_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic_t
+ */
+#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(1, v)
+
+#ifdef CONFIG_64BIT
+
+#define ATOMIC64_INIT(i)    { (i) }
+
+/*
+ * arch_atomic64_read - read atomic variable
+ * @v: pointer of type atomic64_t
+ *
+ */
+#define arch_atomic64_read(v)	READ_ONCE((v)->counter)
+
+/*
+ * arch_atomic64_set - set atomic variable
+ * @v: pointer of type atomic64_t
+ * @i: required value
+ */
+#define arch_atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
+
+#define ATOMIC64_OP(op, I, asm_op)					\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+{									\
+	__asm__ __volatile__(						\
+	"am"#asm_op"_db.d " " $zero, %1, %0	\n"			\
+	: "+ZB" (v->counter)						\
+	: "r" (I)							\
+	: "memory");							\
+}
+
+#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op)					\
+static inline long arch_atomic64_##op##_return_relaxed(long i, atomic64_t *v)	\
+{										\
+	long result;								\
+	__asm__ __volatile__(							\
+	"am"#asm_op"_db.d " " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)					\
+	: "r" (I)								\
+	: "memory");								\
+										\
+	return result c_op I;							\
+}
+
+#define ATOMIC64_FETCH_OP(op, I, asm_op)					\
+static inline long arch_atomic64_fetch_##op##_relaxed(long i, atomic64_t *v)	\
+{										\
+	long result;								\
+										\
+	__asm__ __volatile__(							\
+	"am"#asm_op"_db.d " " %1, %2, %0		\n"			\
+	: "+ZB" (v->counter), "=&r" (result)					\
+	: "r" (I)								\
+	: "memory");								\
+										\
+	return result;								\
+}
+
+#define ATOMIC64_OPS(op, I, asm_op, c_op)				      \
+	ATOMIC64_OP(op, I, asm_op)					      \
+	ATOMIC64_OP_RETURN(op, I, asm_op, c_op)				      \
+	ATOMIC64_FETCH_OP(op, I, asm_op)
+
+ATOMIC64_OPS(add, i, add, +)
+ATOMIC64_OPS(sub, -i, add, +)
+
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
+
+#undef ATOMIC64_OPS
+
+#define ATOMIC64_OPS(op, I, asm_op)					      \
+	ATOMIC64_OP(op, I, asm_op)					      \
+	ATOMIC64_FETCH_OP(op, I, asm_op)
+
+ATOMIC64_OPS(and, i, and)
+ATOMIC64_OPS(or, i, or)
+ATOMIC64_OPS(xor, i, xor)
+
+#define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+/*
+ * arch_atomic64_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically test @v and subtract @i if @v is greater or equal than @i.
+ * The function returns the old value of @v minus @i.
+ */
+static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
+{
+	long result;
+	long temp;
+
+	if (__builtin_constant_p(i)) {
+		__asm__ __volatile__(
+		"1:	ll.d	%1, %2	# atomic64_sub_if_positive	\n"
+		"	addi.d	%0, %1, %3				\n"
+		"	or	%1, %0, $zero				\n"
+		"	blt	%0, $zero, 2f				\n"
+		"	sc.d	%1, %2					\n"
+		"	beq	%1, $zero, 1b				\n"
+		"2:							\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "I" (-i));
+	} else {
+		__asm__ __volatile__(
+		"1:	ll.d	%1, %2	# atomic64_sub_if_positive	\n"
+		"	sub.d	%0, %1, %3				\n"
+		"	or	%1, %0, $zero				\n"
+		"	blt	%0, $zero, 2f				\n"
+		"	sc.d	%1, %2					\n"
+		"	beq	%1, $zero, 1b				\n"
+		"2:							\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "r" (i));
+	}
+
+	return result;
+}
+
+#define arch_atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
+
+/*
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic64_t
+ */
+#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(1, v)
+
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_ATOMIC_H */
diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
new file mode 100644
index 000000000000..8ab8d8f15b88
--- /dev/null
+++ b/arch/loongarch/include/asm/barrier.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#include <asm/addrspace.h>
+
+#define __sync()	__asm__ __volatile__("dbar 0" : : : "memory")
+
+#define fast_wmb()	__sync()
+#define fast_rmb()	__sync()
+#define fast_mb()	__sync()
+#define fast_iob()	__sync()
+#define wbflush()	__sync()
+
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		fast_mb()
+#define iob()		fast_iob()
+
+/**
+ * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (@index < @size)
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	__asm__ __volatile__(
+		"sltu	%0, %1, %2\n\t"
+#if (_LOONGARCH_SZLONG == 32)
+		"sub.w	%0, $r0, %0\n\t"
+#elif (_LOONGARCH_SZLONG == 64)
+		"sub.d	%0, $r0, %0\n\t"
+#endif
+		: "=r" (mask)
+		: "r" (index), "r" (size)
+		:);
+
+	return mask;
+}
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASM_BARRIER_H */
diff --git a/arch/loongarch/include/asm/bitops.h b/arch/loongarch/include/asm/bitops.h
new file mode 100644
index 000000000000..8b05d9683571
--- /dev/null
+++ b/arch/loongarch/include/asm/bitops.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_BITOPS_H
+#define _ASM_BITOPS_H
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/barrier.h>
+#include <asm/byteorder.h>
+#include <asm/compiler.h>
+#include <asm/cpu-features.h>
+
+#if _LOONGARCH_SZLONG == 32
+#define __LL		"ll.w	"
+#define __SC		"sc.w	"
+#define __AMADD		"amadd.w	"
+#define __AMAND_SYNC	"amand_db.w	"
+#define __AMOR_SYNC	"amor_db.w	"
+#define __AMXOR_SYNC	"amxor_db.w	"
+#elif _LOONGARCH_SZLONG == 64
+#define __LL		"ll.d	"
+#define __SC		"sc.d	"
+#define __AMADD		"amadd.d	"
+#define __AMAND_SYNC	"amand_db.d	"
+#define __AMOR_SYNC	"amor_db.d	"
+#define __AMXOR_SYNC	"amxor_db.d	"
+#endif
+
+/*
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ */
+static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMOR_SYNC "$zero, %1, %0        \n"
+	: "+ZB" (*m)
+	: "r" (1UL << bit)
+	: "memory");
+}
+
+/*
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMAND_SYNC "$zero, %1, %0       \n"
+	: "+ZB" (*m)
+	: "r" (~(1UL << bit))
+	: "memory");
+}
+
+/*
+ * clear_bit_unlock - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+/*
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ */
+static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMXOR_SYNC "$zero, %1, %0       \n"
+	: "+ZB" (*m)
+	: "r" (1UL << bit)
+	: "memory");
+}
+
+/*
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+static inline int test_and_set_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	unsigned long res;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMOR_SYNC "%1, %2, %0       \n"
+	: "+ZB" (*m), "=&r" (res)
+	: "r" (1UL << bit)
+	: "memory");
+
+	res = res & (1UL << bit);
+
+	return res != 0;
+}
+
+/*
+ * test_and_set_bit_lock - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+static inline int test_and_set_bit_lock(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	unsigned long res;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMOR_SYNC "%1, %2, %0       \n"
+	: "+ZB" (*m), "=&r" (res)
+	: "r" (1UL << bit)
+	: "memory");
+
+	res = res & (1UL << bit);
+
+	return res != 0;
+}
+/*
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ */
+static inline int test_and_clear_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	unsigned long res, temp;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMAND_SYNC "%1, %2, %0      \n"
+	: "+ZB" (*m), "=&r" (temp)
+	: "r" (~(1UL << bit))
+	: "memory");
+
+	res = temp & (1UL << bit);
+
+	return res != 0;
+}
+
+/*
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ */
+static inline int test_and_change_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	int bit = nr % BITS_PER_LONG;
+	unsigned long res;
+	volatile unsigned long *m = &addr[BIT_WORD(nr)];
+
+	__asm__ __volatile__(
+	"   " __AMXOR_SYNC "%1, %2, %0      \n"
+	: "+ZB" (*m), "=&r" (res)
+	: "r" (1UL << bit)
+	: "memory");
+
+	res = res & (1UL << bit);
+
+	return res != 0;
+}
+
+#include <asm-generic/bitops/non-atomic.h>
+
+/*
+ * __clear_bit_unlock - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+#include <asm-generic/bitops/builtin-ffs.h>
+#include <asm-generic/bitops/builtin-fls.h>
+#include <asm-generic/bitops/builtin-__ffs.h>
+#include <asm-generic/bitops/builtin-__fls.h>
+
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+
+#ifdef __KERNEL__
+
+#include <asm-generic/bitops/sched.h>
+
+#include <asm-generic/bitops/arch_hweight.h>
+#include <asm-generic/bitops/const_hweight.h>
+
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_BITOPS_H */
diff --git a/arch/loongarch/include/asm/bitrev.h b/arch/loongarch/include/asm/bitrev.h
new file mode 100644
index 000000000000..ed99da2027f2
--- /dev/null
+++ b/arch/loongarch/include/asm/bitrev.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __LOONGARCH_ASM_BITREV_H__
+#define __LOONGARCH_ASM_BITREV_H__
+
+#include <linux/swab.h>
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	u32 ret;
+
+	asm("bitrev.4b	%0, %1" : "=r"(ret) : "r"(__swab32(x)));
+	return ret;
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	u16 ret;
+
+	asm("bitrev.4b	%0, %1" : "=r"(ret) : "r"(__swab16(x)));
+	return ret;
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	u8 ret;
+
+	asm("bitrev.4b	%0, %1" : "=r"(ret) : "r"(x));
+	return ret;
+}
+
+#endif /* __LOONGARCH_ASM_BITREV_H__ */
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
new file mode 100644
index 000000000000..1d6faaf04c08
--- /dev/null
+++ b/arch/loongarch/include/asm/local.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ARCH_LOONGARCH_LOCAL_H
+#define _ARCH_LOONGARCH_LOCAL_H
+
+#include <linux/percpu.h>
+#include <linux/bitops.h>
+#include <linux/atomic.h>
+#include <asm/cmpxchg.h>
+#include <asm/compiler.h>
+
+typedef struct {
+	atomic_long_t a;
+} local_t;
+
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
+
+#define local_read(l)	atomic_long_read(&(l)->a)
+#define local_set(l, i) atomic_long_set(&(l)->a, (i))
+
+#define local_add(i, l) atomic_long_add((i), (&(l)->a))
+#define local_sub(i, l) atomic_long_sub((i), (&(l)->a))
+#define local_inc(l)	atomic_long_inc(&(l)->a)
+#define local_dec(l)	atomic_long_dec(&(l)->a)
+
+/*
+ * Same as above, but return the result value
+ */
+static inline long local_add_return(long i, local_t *l)
+{
+	unsigned long result;
+
+	__asm__ __volatile__(
+	"   " __AMADD " %1, %2, %0      \n"
+	: "+ZB" (l->a.counter), "=&r" (result)
+	: "r" (i)
+	: "memory");
+	result = result + i;
+
+	return result;
+}
+
+static inline long local_sub_return(long i, local_t *l)
+{
+	unsigned long result;
+
+	__asm__ __volatile__(
+	"   " __AMADD "%1, %2, %0       \n"
+	: "+ZB" (l->a.counter), "=&r" (result)
+	: "r" (-i)
+	: "memory");
+
+	result = result - i;
+
+	return result;
+}
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to l...
+ * @u: ...unless l is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+#define local_add_unless(l, a, u)				\
+({								\
+	long c, old;						\
+	c = local_read(l);					\
+	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
+		c = old;					\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_dec_return(l) local_sub_return(1, (l))
+#define local_inc_return(l) local_add_return(1, (l))
+
+/*
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ *
+ * Atomically subtracts @i from @l and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_sub_and_test(i, l) (local_sub_return((i), (l)) == 0)
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l) (local_inc_return(l) == 0)
+
+/*
+ * local_dec_and_test - decrement by 1 and test
+ * @l: pointer of type local_t
+ *
+ * Atomically decrements @l by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+#define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
+
+/*
+ * local_add_negative - add and test if negative
+ * @l: pointer of type local_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @l and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+#define local_add_negative(i, l) (local_add_return(i, (l)) < 0)
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+
+#define __local_inc(l)		((l)->a.counter++)
+#define __local_dec(l)		((l)->a.counter++)
+#define __local_add(i, l)	((l)->a.counter += (i))
+#define __local_sub(i, l)	((l)->a.counter -= (i))
+
+#endif /* _ARCH_LOONGARCH_LOCAL_H */
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
new file mode 100644
index 000000000000..ea5979872485
--- /dev/null
+++ b/arch/loongarch/include/asm/percpu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+/* Use r21 for fast access */
+register unsigned long __my_cpu_offset __asm__("$r21");
+
+static inline void set_my_cpu_offset(unsigned long off)
+{
+	__my_cpu_offset = off;
+	csr_writeq(off, PERCPU_BASE_KS);
+}
+#define __my_cpu_offset __my_cpu_offset
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
new file mode 100644
index 000000000000..2544ee546596
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_H
+#define _ASM_SPINLOCK_H
+
+#include <asm/processor.h>
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+#endif /* _ASM_SPINLOCK_H */
diff --git a/arch/loongarch/include/asm/spinlock_types.h b/arch/loongarch/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..91f258401ef9
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock_types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_TYPES_H
+#define _ASM_SPINLOCK_TYPES_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif
-- 
2.27.0

