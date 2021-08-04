Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D210F3E088C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhHDTQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40442 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239339AbhHDTQT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:19 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2361BC0CDD;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104566; bh=QyqbSWaxkm/w5jcclBgYrp3iEHYiXcg9BrVfB0MGCGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5wsiKAdo/OK7FTxyBMA1VaJtl4a3gxAdtlXcs2CJd0NDQIp47/2DxJoL1n8qpkbs
         K1Ai9pDu/A5lqgJTInm6atC0s8+BL3OWHDCcpWLqus6htx2wL65qZMlT9mRBmtE2nu
         v+HTsYpQVqPnnetUa5zEcaZKrZP0n/u1r7iw0jBnl9u2dhGl4hTXlRbK53xxp8DYyR
         5jB8Fr+HHcVkoR+QPUnnJoySDIjbtgDRHXXlCsQv1s/eJSTr97fbPEqGwqTK+21D2w
         xI2m88AEe8Kkx1EfWF9oIHKRMAV67olTY27Xvh1s+p0LjqtaRRqosnO2QiGIHE5CLU
         FeHRvs0l8vu1A==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B6AA9A0095;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Will Deacon <will.deacon@arm.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 06/11] ARC: switch to generic bitops
Date:   Wed,  4 Aug 2021 12:15:49 -0700
Message-Id: <20210804191554.1252776-7-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

 - !LLSC now only needs a single spinlock for atomics and bitops

 - Some codegen changes (slight bloat) with generic bitops

   1. code increase due to LD-check-atomic paradigm vs. unconditonal
      atomic (but dirty'ing the cache line even if set already).
      So despite increase, generic is right thing to do.

   2. code decrease (but use of costlier instructions such as DIV vs.
      shifts based math) due to signed arithmetic.
      This needs to be revisited seperately.

     arc:
     static inline int test_bit(unsigned int nr, const volatile unsigned long *addr)
                                ^^^^^^^^^^^^
     generic:
     static inline int test_bit(int nr, const volatile unsigned long *addr)
                                ^^^

Link: https://lore.kernel.org/r/20180830135749.GA13005@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[vgupta: wrote patch based on Will's poc, analysed codegen diffs]
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/bitops.h | 184 +---------------------------------
 arch/arc/include/asm/smp.h    |  14 ---
 arch/arc/kernel/smp.c         |   2 -
 3 files changed, 2 insertions(+), 198 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index fb98440c0bd4..4f35130f5ba3 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -14,188 +14,6 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <asm/barrier.h>
-#ifndef CONFIG_ARC_HAS_LLSC
-#include <asm/smp.h>
-#endif
-
-#ifdef CONFIG_ARC_HAS_LLSC
-
-/*
- * Hardware assisted Atomic-R-M-W
- */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned int temp;						\
-									\
-	m += nr >> 5;							\
-									\
-	nr &= 0x1f;							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock       %0, [%1]		\n"			\
-	"	" #asm_op " %0, %0, %2	\n"				\
-	"	scond       %0, [%1]		\n"			\
-	"	bnz         1b			\n"			\
-	: "=&r"(temp)	/* Early clobber, to prevent reg reuse */	\
-	: "r"(m),	/* Not "m": llock only supports reg direct addr mode */	\
-	  "ir"(nr)							\
-	: "cc");							\
-}
-
-/*
- * Semantically:
- *    Test the bit
- *    if clear
- *        set it and return 0 (old value)
- *    else
- *        return 1 (old value).
- *
- * Since ARC lacks a equivalent h/w primitive, the bit is set unconditionally
- * and the old value of bit is returned
- */
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old, temp;					\
-									\
-	m += nr >> 5;							\
-									\
-	nr &= 0x1f;							\
-									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such smenatic	\
-	 */								\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock       %0, [%2]	\n"				\
-	"	" #asm_op " %1, %0, %3	\n"				\
-	"	scond       %1, [%2]	\n"				\
-	"	bnz         1b		\n"				\
-	: "=&r"(old), "=&r"(temp)					\
-	: "r"(m), "ir"(nr)						\
-	: "cc");							\
-									\
-	smp_mb();							\
-									\
-	return (old & (1 << nr)) != 0;					\
-}
-
-#else /* !CONFIG_ARC_HAS_LLSC */
-
-/*
- * Non hardware assisted Atomic-R-M-W
- * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
- *
- * There's "significant" micro-optimization in writing our own variants of
- * bitops (over generic variants)
- *
- * (1) The generic APIs have "signed" @nr while we have it "unsigned"
- *     This avoids extra code to be generated for pointer arithmatic, since
- *     is "not sure" that index is NOT -ve
- * (2) Utilize the fact that ARCompact bit fidding insn (BSET/BCLR/ASL) etc
- *     only consider bottom 5 bits of @nr, so NO need to mask them off.
- *     (GCC Quirk: however for constant @nr we still need to do the masking
- *             at compile time)
- */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long temp, flags;					\
-	m += nr >> 5;							\
-									\
-	/*								\
-	 * spin lock/unlock provide the needed smp_mb() before/after	\
-	 */								\
-	bitops_lock(flags);						\
-									\
-	temp = *m;							\
-	*m = temp c_op (1UL << (nr & 0x1f));					\
-									\
-	bitops_unlock(flags);						\
-}
-
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old, flags;					\
-	m += nr >> 5;							\
-									\
-	bitops_lock(flags);						\
-									\
-	old = *m;							\
-	*m = old c_op (1UL << (nr & 0x1f));				\
-									\
-	bitops_unlock(flags);						\
-									\
-	return (old & (1UL << (nr & 0x1f))) != 0;			\
-}
-
-#endif
-
-/***************************************
- * Non atomic variants
- **************************************/
-
-#define __BIT_OP(op, c_op, asm_op)					\
-static inline void __##op##_bit(unsigned long nr, volatile unsigned long *m)	\
-{									\
-	unsigned long temp;						\
-	m += nr >> 5;							\
-									\
-	temp = *m;							\
-	*m = temp c_op (1UL << (nr & 0x1f));				\
-}
-
-#define __TEST_N_BIT_OP(op, c_op, asm_op)				\
-static inline int __test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old;						\
-	m += nr >> 5;							\
-									\
-	old = *m;							\
-	*m = old c_op (1UL << (nr & 0x1f));				\
-									\
-	return (old & (1UL << (nr & 0x1f))) != 0;			\
-}
-
-#define BIT_OPS(op, c_op, asm_op)					\
-									\
-	/* set_bit(), clear_bit(), change_bit() */			\
-	BIT_OP(op, c_op, asm_op)					\
-									\
-	/* test_and_set_bit(), test_and_clear_bit(), test_and_change_bit() */\
-	TEST_N_BIT_OP(op, c_op, asm_op)					\
-									\
-	/* __set_bit(), __clear_bit(), __change_bit() */		\
-	__BIT_OP(op, c_op, asm_op)					\
-									\
-	/* __test_and_set_bit(), __test_and_clear_bit(), __test_and_change_bit() */\
-	__TEST_N_BIT_OP(op, c_op, asm_op)
-
-BIT_OPS(set, |, bset)
-BIT_OPS(clear, & ~, bclr)
-BIT_OPS(change, ^, bxor)
-
-/*
- * This routine doesn't need to be atomic.
- */
-static inline int
-test_bit(unsigned int nr, const volatile unsigned long *addr)
-{
-	unsigned long mask;
-
-	addr += nr >> 5;
-
-	mask = 1UL << (nr & 0x1f);
-
-	return ((mask & *addr) != 0);
-}
 
 #ifdef CONFIG_ISA_ARCOMPACT
 
@@ -368,6 +186,8 @@ static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
 
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/arc/include/asm/smp.h b/arch/arc/include/asm/smp.h
index c5de4008d19f..d856491606ac 100644
--- a/arch/arc/include/asm/smp.h
+++ b/arch/arc/include/asm/smp.h
@@ -105,7 +105,6 @@ static inline const char *arc_platform_smp_cpuinfo(void)
 #include <asm/spinlock.h>
 
 extern arch_spinlock_t smp_atomic_ops_lock;
-extern arch_spinlock_t smp_bitops_lock;
 
 #define atomic_ops_lock(flags)	do {		\
 	local_irq_save(flags);			\
@@ -117,24 +116,11 @@ extern arch_spinlock_t smp_bitops_lock;
 	local_irq_restore(flags);		\
 } while (0)
 
-#define bitops_lock(flags)	do {		\
-	local_irq_save(flags);			\
-	arch_spin_lock(&smp_bitops_lock);	\
-} while (0)
-
-#define bitops_unlock(flags) do {		\
-	arch_spin_unlock(&smp_bitops_lock);	\
-	local_irq_restore(flags);		\
-} while (0)
-
 #else /* !CONFIG_SMP */
 
 #define atomic_ops_lock(flags)		local_irq_save(flags)
 #define atomic_ops_unlock(flags)	local_irq_restore(flags)
 
-#define bitops_lock(flags)		local_irq_save(flags)
-#define bitops_unlock(flags)		local_irq_restore(flags)
-
 #endif /* !CONFIG_SMP */
 
 #endif	/* !CONFIG_ARC_HAS_LLSC */
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index db0e104d6835..62f641c9a493 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -29,10 +29,8 @@
 
 #ifndef CONFIG_ARC_HAS_LLSC
 arch_spinlock_t smp_atomic_ops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-arch_spinlock_t smp_bitops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
 EXPORT_SYMBOL_GPL(smp_atomic_ops_lock);
-EXPORT_SYMBOL_GPL(smp_bitops_lock);
 #endif
 
 struct plat_smp_ops  __weak plat_smp_ops;
-- 
2.25.1

