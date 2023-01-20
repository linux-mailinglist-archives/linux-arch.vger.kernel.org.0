Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6193675697
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjATOLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjATOLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:43 -0500
Received: from fx408.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1488C63B3
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:10:45 -0800 (PST)
Received: from localhost (fx408.security-mail.net [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 70E48322BAC
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223832;
        bh=Rr9QfC52jxWXt9/L6/0rXr58eBV1kbp/PCidEQ6niXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a2gvWIDYicwURek2prNsBHdw/qrKpGsVqft9DPlPFrgjW2HCGVFrGzmP4Gz6op5xz
         Nko1t3KK5BB/nraj3gB03N9S37TcvUpjJxkHcoZYU1QO9inUkrBkXM+uQLE1rIifYt
         l1HfenLWwY7FwN+G0mYN8aw90/b3ggrEQNcegqj8=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 2CE6F322B6D; Fri, 20 Jan
 2023 15:10:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 2F716322939; Fri, 20 Jan
 2023 15:10:30 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id DEDF827E0442; Fri, 20 Jan 2023
 15:10:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BA21327E043E; Fri, 20 Jan 2023 15:10:29 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 IVLBnrnY8q7M; Fri, 20 Jan 2023 15:10:29 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 3038927E0439; Fri, 20 Jan 2023
 15:10:29 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <8eb9.63caa0d6.2d305.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BA21327E043E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223829;
 bh=VF1oksnoaKlh4VeYXhJaqi0lsOke2F/Yys7H8lI9zVo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=py7k0YutOlZqWwMG5lZJu6/TDyjQJDv+WqktPHeaionlMv9JDM0vUt7RyUtwuAvEc
 BAaiO7pdNQhE8prp3XxiJKJo9FO4waSZpPdSMO2dSvz3s8gvb8ZkIDzBvXuiXEwQxt
 BrrCzIEAI8NSGikf8xD35M5SllBU3r29he3vWp5M=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 11/31] kvx: Add atomic/locking headers
Date:   Fri, 20 Jan 2023 15:09:42 +0100
Message-ID: <20230120141002.2442-12-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add common headers (atomic, bitops, barrier and locking) for basic
kvx support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2:
     - use {READ,WRITE}_ONCE for arch_atomic64_{read,set}
     - use asm-generic/bitops/atomic.h instead of __test_and_*_bit
     - removed duplicated includes
     - rewrite xchg and cmpxchg in C using builtins for acswap insn

 arch/kvx/include/asm/atomic.h  | 104 ++++++++++++++++++++
 arch/kvx/include/asm/barrier.h |  15 +++
 arch/kvx/include/asm/bitops.h  | 115 ++++++++++++++++++++++
 arch/kvx/include/asm/bitrev.h  |  32 +++++++
 arch/kvx/include/asm/cmpxchg.h | 170 +++++++++++++++++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 arch/kvx/include/asm/atomic.h
 create mode 100644 arch/kvx/include/asm/barrier.h
 create mode 100644 arch/kvx/include/asm/bitops.h
 create mode 100644 arch/kvx/include/asm/bitrev.h
 create mode 100644 arch/kvx/include/asm/cmpxchg.h

diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
new file mode 100644
index 000000000000..bea3d70785b1
--- /dev/null
+++ b/arch/kvx/include/asm/atomic.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ATOMIC_H
+#define _ASM_KVX_ATOMIC_H
+
+#include <linux/types.h>
+
+#include <asm/cmpxchg.h>
+
+#define ATOMIC64_INIT(i)     { (i) }
+
+#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
+
+static inline long arch_atomic64_read(const atomic64_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+
+static inline void arch_atomic64_set(atomic64_t *v, long i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+#define ATOMIC64_RETURN_OP(op, c_op)					\
+static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return new;							\
+}
+
+#define ATOMIC64_OP(op, c_op)						\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return old;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_RETURN_OP(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &)
+ATOMIC64_OPS(or, |)
+ATOMIC64_OPS(xor, ^)
+ATOMIC64_OPS(add, +)
+ATOMIC64_OPS(sub, -)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP
+
+static inline int arch_atomic_add_return(int i, atomic_t *v)
+{
+	int new, old, ret;
+
+	do {
+		old = v->counter;
+		new = old + i;
+		ret = arch_cmpxchg(&v->counter, old, new);
+	} while (ret != old);
+
+	return new;
+}
+
+static inline int arch_atomic_sub_return(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(-i, v);
+}
+
+#include <asm-generic/atomic.h>
+
+#endif	/* _ASM_KVX_ATOMIC_H */
diff --git a/arch/kvx/include/asm/barrier.h b/arch/kvx/include/asm/barrier.h
new file mode 100644
index 000000000000..371f1c70746d
--- /dev/null
+++ b/arch/kvx/include/asm/barrier.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BARRIER_H
+#define _ASM_KVX_BARRIER_H
+
+/* fence is sufficient to guarantee write ordering */
+#define mb()	__builtin_kvx_fence()
+
+#include <asm-generic/barrier.h>
+
+#endif /* _ASM_KVX_BARRIER_H */
diff --git a/arch/kvx/include/asm/bitops.h b/arch/kvx/include/asm/bitops.h
new file mode 100644
index 000000000000..c643f4765059
--- /dev/null
+++ b/arch/kvx/include/asm/bitops.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_BITOPS_H
+#define _ASM_KVX_BITOPS_H
+
+#ifdef __KERNEL__
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm/cmpxchg.h>
+
+static inline int fls(int x)
+{
+	return 32 - __builtin_kvx_clzw(x);
+}
+
+static inline int fls64(__u64 x)
+{
+	return 64 - __builtin_kvx_clzd(x);
+}
+
+/**
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	return __builtin_kvx_ctzd(word);
+}
+
+/**
+ * __fls - find last set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __fls(unsigned long word)
+{
+	return 63 - __builtin_kvx_clzd(word);
+}
+
+
+/**
+ * ffs - find first set bit in word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs
+ * routines, therefore differs in spirit from the other bitops.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first
+ * set bit if value is nonzero. The first (least significant) bit
+ * is at position 1.
+ */
+static inline int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __builtin_kvx_ctzw(x) + 1;
+}
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsw %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight64(__u64 w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsd %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __arch_hweight32(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __arch_hweight32(w & 0xff);
+}
+
+#include <asm-generic/bitops/ffz.h>
+
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/const_hweight.h>
+
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif
+
+#endif
diff --git a/arch/kvx/include/asm/bitrev.h b/arch/kvx/include/asm/bitrev.h
new file mode 100644
index 000000000000..79865081905a
--- /dev/null
+++ b/arch/kvx/include/asm/bitrev.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BITREV_H
+#define _ASM_KVX_BITREV_H
+
+#include <linux/swab.h>
+
+/* Bit reversal constant for matrix multiply */
+#define BIT_REVERSE 0x0102040810204080ULL
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 32 LSB */
+	return swab32(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 16 LSB */
+	return swab16(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	return __builtin_kvx_sbmm8(BIT_REVERSE, x);
+}
+
+#endif
diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..51ccb83757cc
--- /dev/null
+++ b/arch/kvx/include/asm/cmpxchg.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Jules Maselbas
+ */
+
+#ifndef _ASM_KVX_CMPXCHG_H
+#define _ASM_KVX_CMPXCHG_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/align.h>
+#include <linux/build_bug.h>
+
+/*
+ * On kvx, we have a boolean compare and swap which means that the operation
+ * returns only the success of operation.
+ * If operation succeed, this is simple, we just need to return the provided
+ * old value. However, if it fails, we need to load the value to return it for
+ * the caller. If the loaded value is different from the "old" provided by the
+ * caller, we can return it since it will means it failed.
+ * However, if for some reason the value we read is equal to the old value
+ * provided by the caller, we can't simply return it or the caller will think it
+ * succeeded. So if the value we read is the same as the "old" provided by
+ * the caller, we try again until either we succeed or we fail with a different
+ * value than the provided one.
+ */
+
+static inline unsigned int __cmpxchg_u32(unsigned int old, unsigned int new,
+					 volatile unsigned int *ptr)
+{
+	unsigned int exp = old;
+
+	__builtin_kvx_fence();
+	while (exp == old) {
+		if (__builtin_kvx_acswapw((void *)ptr, new, exp))
+			break; /* acswap succeed */
+		exp = *ptr;
+	}
+
+	return exp;
+}
+
+static inline unsigned long __cmpxchg_u64(unsigned long old, unsigned long new,
+					  volatile unsigned long *ptr)
+{
+	unsigned long exp = old;
+
+	__builtin_kvx_fence();
+	while (exp == old) {
+		if (__builtin_kvx_acswapd((void *)ptr, new, exp))
+			break; /* acswap succeed */
+		exp = *ptr;
+	}
+
+	return exp;
+}
+
+extern unsigned long __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
+
+static __always_inline unsigned long __cmpxchg(unsigned long old,
+					       unsigned long new,
+					       volatile void *ptr, int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32(old, new, ptr);
+	case 8:
+		return __cmpxchg_u64(old, new, ptr);
+	default:
+		return __cmpxchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_cmpxchg(ptr, old, new)					\
+	((__typeof__(*(ptr))) __cmpxchg(				\
+		(unsigned long)(old), (unsigned long)(new),		\
+		(ptr), sizeof(*(ptr))))
+
+/*
+ * In order to optimize xchg for 16 byte, we can use insf/extfs if we know the
+ * bounds. This way, we only take one more bundle than standard xchg.
+ * We simply do a read modify acswap on a 32 bit word.
+ */
+
+#define __kvx_insf(org, val, start, stop) __asm__ __volatile__(	\
+		"insf %[_org] = %[_val], %[_stop], %[_start]\n\t;;"	\
+		: [_org]"+r"(org)					\
+		: [_val]"r"(val), [_stop]"i"(stop), [_start]"i"(start))
+
+#define __kvx_extfz(out, val, start, stop) __asm__ __volatile__(	\
+		"extfz %[_out] = %[_val], %[_stop], %[_start]\n\t;;"	\
+		: [_out]"=r"(out)					\
+		: [_val]"r"(val), [_stop]"i"(stop), [_start]"i"(start))
+
+/* Needed for generic qspinlock implementation */
+static inline unsigned int __xchg_u16(unsigned int old, unsigned int new,
+				      volatile unsigned int *ptr)
+{
+	unsigned int off = ((unsigned long)ptr) % sizeof(unsigned int);
+	unsigned int val;
+
+	ptr = PTR_ALIGN_DOWN(ptr, sizeof(unsigned int));
+	__builtin_kvx_fence();
+	do {
+		old = *ptr;
+		val = old;
+		if (off == 0)
+			__kvx_insf(val, new, 0, 15);
+		else
+			__kvx_insf(val, new, 16, 31);
+	} while (!__builtin_kvx_acswapw((void *)ptr, val, old));
+
+	if (off == 0)
+		__kvx_extfz(old, old, 0, 15);
+	else
+		__kvx_extfz(old, old, 16, 31);
+
+	return old;
+}
+
+static inline unsigned int __xchg_u32(unsigned int old, unsigned int new,
+				      volatile unsigned int *ptr)
+{
+	__builtin_kvx_fence();
+	do
+		old = *ptr;
+	while (!__builtin_kvx_acswapw((void *)ptr, new, old));
+
+	return old;
+}
+
+static inline unsigned long __xchg_u64(unsigned long old, unsigned long new,
+				       volatile unsigned long *ptr)
+{
+	__builtin_kvx_fence();
+	do
+		old = *ptr;
+	while (!__builtin_kvx_acswapd((void *)ptr, new, old));
+
+	return old;
+}
+
+extern unsigned long __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
+
+static __always_inline unsigned long __xchg(unsigned long val,
+					    volatile void *ptr, int size)
+{
+	switch (size) {
+	case 2:
+		return __xchg_u16(0, val, ptr);
+	case 4:
+		return __xchg_u32(0, val, ptr);
+	case 8:
+		return __xchg_u64(0, val, ptr);
+	default:
+		return __xchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_xchg(ptr, val)						\
+	((__typeof__(*(ptr))) __xchg(					\
+		(unsigned long)(val),					\
+		(ptr), sizeof(*(ptr))))
+
+#endif
-- 
2.37.2





