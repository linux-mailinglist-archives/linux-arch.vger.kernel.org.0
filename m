Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF13E0887
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhHDTQU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40388 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239215AbhHDTQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:18 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B74FEC0CD7;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=/qXDwrbmCfElcb/+B76kttTfY7GWTthqXCsydOnJoEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5+BFYPRmM3R42fIlOWUQjXVCdX+0v2bnffJYB9g6sPc5XUKIbWzcbjopK/jj0SUp
         f07BXeR7zsEJvY0dbiU3lBukiU0jgVaZkUTtGZ+LUCq0US5zJ/3OPZPz34faKvPLhM
         jwtA6yGlbuuZMLDp5wqj4aQCkVuRdym2KO0bcJ97YVu2ItbS2k5JDibv6gPDjFXAlp
         dcesBQzFj02Zc2kF6IRMdHBO5QHrdum0BTXaDZ0tLVQcNMFY3zti+9vLZLuiI9j29Z
         HpeF85LGRTycEMg3KEvNJ/YJ928/v5Le6VKuoD6cIigWFab7IqLDVxgoXkOhoA8QWG
         ImuPV66rTaXKQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3BBFBA0096;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 01/11] ARC: atomics: disintegrate header
Date:   Wed,  4 Aug 2021 12:15:44 -0700
Message-Id: <20210804191554.1252776-2-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Non functional change, to ease future addition/removal

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic-llsc.h     | 103 ++++++
 arch/arc/include/asm/atomic-spinlock.h | 111 +++++++
 arch/arc/include/asm/atomic.h          | 429 +------------------------
 arch/arc/include/asm/atomic64-arcv2.h  | 242 ++++++++++++++
 4 files changed, 461 insertions(+), 424 deletions(-)
 create mode 100644 arch/arc/include/asm/atomic-llsc.h
 create mode 100644 arch/arc/include/asm/atomic-spinlock.h
 create mode 100644 arch/arc/include/asm/atomic64-arcv2.h

diff --git a/arch/arc/include/asm/atomic-llsc.h b/arch/arc/include/asm/atomic-llsc.h
new file mode 100644
index 000000000000..aab4f2855457
--- /dev/null
+++ b/arch/arc/include/asm/atomic-llsc.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_ARC_ATOMIC_LLSC_H
+#define _ASM_ARC_ATOMIC_LLSC_H
+
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+
+#define ATOMIC_OP(op, c_op, asm_op)					\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	unsigned int val;						\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[val], [%[ctr]]		\n"		\
+	"	" #asm_op " %[val], %[val], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"	bnz     1b				\n"		\
+	: [val]	"=&r"	(val) /* Early clobber to prevent reg reuse */	\
+	: [ctr]	"r"	(&v->counter), /* Not "m": llock only supports reg direct addr mode */	\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+}									\
+
+#define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	unsigned int val;						\
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND themselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[val], [%[ctr]]		\n"		\
+	"	" #asm_op " %[val], %[val], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"	bnz     1b				\n"		\
+	: [val]	"=&r"	(val)						\
+	: [ctr]	"r"	(&v->counter),					\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return val;							\
+}
+
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	unsigned int val, orig;						\
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND themselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[orig], [%[ctr]]		\n"		\
+	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"	bnz     1b				\n"		\
+	: [val]	"=&r"	(val),						\
+	  [orig] "=&r" (orig)						\
+	: [ctr]	"r"	(&v->counter),					\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return orig;							\
+}
+
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(add, +=, add)
+ATOMIC_OPS(sub, -=, sub)
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(andnot, &= ~, bic)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, xor)
+
+#define arch_atomic_andnot		arch_atomic_andnot
+#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#endif
diff --git a/arch/arc/include/asm/atomic-spinlock.h b/arch/arc/include/asm/atomic-spinlock.h
new file mode 100644
index 000000000000..bdf87610b2d7
--- /dev/null
+++ b/arch/arc/include/asm/atomic-spinlock.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_ARC_ATOMIC_SPLOCK_H
+#define _ASM_ARC_ATOMIC_SPLOCK_H
+
+#ifndef CONFIG_SMP
+
+ /* violating atomic_xxx API locking protocol in UP for optimization sake */
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+
+#else
+
+static inline void arch_atomic_set(atomic_t *v, int i)
+{
+	/*
+	 * Independent of hardware support, all of the atomic_xxx() APIs need
+	 * to follow the same locking rules to make sure that a "hardware"
+	 * atomic insn (e.g. LD) doesn't clobber an "emulated" atomic insn
+	 * sequence
+	 *
+	 * Thus atomic_set() despite being 1 insn (and seemingly atomic)
+	 * requires the locking.
+	 */
+	unsigned long flags;
+
+	atomic_ops_lock(flags);
+	WRITE_ONCE(v->counter, i);
+	atomic_ops_unlock(flags);
+}
+
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
+
+#endif
+
+/*
+ * Non hardware assisted Atomic-R-M-W
+ * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
+ */
+
+#define ATOMIC_OP(op, c_op, asm_op)					\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+									\
+	atomic_ops_lock(flags);						\
+	v->counter c_op i;						\
+	atomic_ops_unlock(flags);					\
+}
+
+#define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	unsigned long flags;						\
+	unsigned long temp;						\
+									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
+	atomic_ops_lock(flags);						\
+	temp = v->counter;						\
+	temp c_op i;							\
+	v->counter = temp;						\
+	atomic_ops_unlock(flags);					\
+									\
+	return temp;							\
+}
+
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	unsigned long flags;						\
+	unsigned long orig;						\
+									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
+	atomic_ops_lock(flags);						\
+	orig = v->counter;						\
+	v->counter c_op i;						\
+	atomic_ops_unlock(flags);					\
+									\
+	return orig;							\
+}
+
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(add, +=, add)
+ATOMIC_OPS(sub, -=, sub)
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(andnot, &= ~, bic)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, xor)
+
+#define arch_atomic_andnot		arch_atomic_andnot
+#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#endif
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 7a36d79b5b2f..ee88e1dbaab5 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -17,435 +17,16 @@
 #define arch_atomic_read(v)  READ_ONCE((v)->counter)
 
 #ifdef CONFIG_ARC_HAS_LLSC
-
-#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
-
-#define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void arch_atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned int val;						\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock   %[val], [%[ctr]]		\n"		\
-	"	" #asm_op " %[val], %[val], %[i]	\n"		\
-	"	scond   %[val], [%[ctr]]		\n"		\
-	"	bnz     1b				\n"		\
-	: [val]	"=&r"	(val) /* Early clobber to prevent reg reuse */	\
-	: [ctr]	"r"	(&v->counter), /* Not "m": llock only supports reg direct addr mode */	\
-	  [i]	"ir"	(i)						\
-	: "cc");							\
-}									\
-
-#define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned int val;						\
-									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such semantics	\
-	 */								\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock   %[val], [%[ctr]]		\n"		\
-	"	" #asm_op " %[val], %[val], %[i]	\n"		\
-	"	scond   %[val], [%[ctr]]		\n"		\
-	"	bnz     1b				\n"		\
-	: [val]	"=&r"	(val)						\
-	: [ctr]	"r"	(&v->counter),					\
-	  [i]	"ir"	(i)						\
-	: "cc");							\
-									\
-	smp_mb();							\
-									\
-	return val;							\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
-{									\
-	unsigned int val, orig;						\
-									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such semantics	\
-	 */								\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock   %[orig], [%[ctr]]		\n"		\
-	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
-	"	scond   %[val], [%[ctr]]		\n"		\
-	"	bnz     1b				\n"		\
-	: [val]	"=&r"	(val),						\
-	  [orig] "=&r" (orig)						\
-	: [ctr]	"r"	(&v->counter),					\
-	  [i]	"ir"	(i)						\
-	: "cc");							\
-									\
-	smp_mb();							\
-									\
-	return orig;							\
-}
-
-#else	/* !CONFIG_ARC_HAS_LLSC */
-
-#ifndef CONFIG_SMP
-
- /* violating atomic_xxx API locking protocol in UP for optimization sake */
-#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
-
+#include <asm/atomic-llsc.h>
 #else
-
-static inline void arch_atomic_set(atomic_t *v, int i)
-{
-	/*
-	 * Independent of hardware support, all of the atomic_xxx() APIs need
-	 * to follow the same locking rules to make sure that a "hardware"
-	 * atomic insn (e.g. LD) doesn't clobber an "emulated" atomic insn
-	 * sequence
-	 *
-	 * Thus atomic_set() despite being 1 insn (and seemingly atomic)
-	 * requires the locking.
-	 */
-	unsigned long flags;
-
-	atomic_ops_lock(flags);
-	WRITE_ONCE(v->counter, i);
-	atomic_ops_unlock(flags);
-}
-
-#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
-
+#include <asm/atomic-spinlock.h>
 #endif
 
-/*
- * Non hardware assisted Atomic-R-M-W
- * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
- */
-
-#define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void arch_atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long flags;						\
-									\
-	atomic_ops_lock(flags);						\
-	v->counter c_op i;						\
-	atomic_ops_unlock(flags);					\
-}
-
-#define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned long flags;						\
-	unsigned long temp;						\
-									\
-	/*								\
-	 * spin lock/unlock provides the needed smp_mb() before/after	\
-	 */								\
-	atomic_ops_lock(flags);						\
-	temp = v->counter;						\
-	temp c_op i;							\
-	v->counter = temp;						\
-	atomic_ops_unlock(flags);					\
-									\
-	return temp;							\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
-{									\
-	unsigned long flags;						\
-	unsigned long orig;						\
-									\
-	/*								\
-	 * spin lock/unlock provides the needed smp_mb() before/after	\
-	 */								\
-	atomic_ops_lock(flags);						\
-	orig = v->counter;						\
-	v->counter c_op i;						\
-	atomic_ops_unlock(flags);					\
-									\
-	return orig;							\
-}
-
-#endif /* !CONFIG_ARC_HAS_LLSC */
-
-#define ATOMIC_OPS(op, c_op, asm_op)					\
-	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-	ATOMIC_FETCH_OP(op, c_op, asm_op)
-
-ATOMIC_OPS(add, +=, add)
-ATOMIC_OPS(sub, -=, sub)
-
-#undef ATOMIC_OPS
-#define ATOMIC_OPS(op, c_op, asm_op)					\
-	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_FETCH_OP(op, c_op, asm_op)
-
-ATOMIC_OPS(and, &=, and)
-ATOMIC_OPS(andnot, &= ~, bic)
-ATOMIC_OPS(or, |=, or)
-ATOMIC_OPS(xor, ^=, xor)
-
-#define arch_atomic_andnot		arch_atomic_andnot
-#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
-
-#undef ATOMIC_OPS
-#undef ATOMIC_FETCH_OP
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
-
 #ifdef CONFIG_GENERIC_ATOMIC64
-
 #include <asm-generic/atomic64.h>
-
-#else	/* Kconfig ensures this is only enabled with needed h/w assist */
-
-/*
- * ARCv2 supports 64-bit exclusive load (LLOCKD) / store (SCONDD)
- *  - The address HAS to be 64-bit aligned
- *  - There are 2 semantics involved here:
- *    = exclusive implies no interim update between load/store to same addr
- *    = both words are observed/updated together: this is guaranteed even
- *      for regular 64-bit load (LDD) / store (STD). Thus atomic64_set()
- *      is NOT required to use LLOCKD+SCONDD, STD suffices
- */
-
-typedef struct {
-	s64 __aligned(8) counter;
-} atomic64_t;
-
-#define ATOMIC64_INIT(a) { (a) }
-
-static inline s64 arch_atomic64_read(const atomic64_t *v)
-{
-	s64 val;
-
-	__asm__ __volatile__(
-	"	ldd   %0, [%1]	\n"
-	: "=r"(val)
-	: "r"(&v->counter));
-
-	return val;
-}
-
-static inline void arch_atomic64_set(atomic64_t *v, s64 a)
-{
-	/*
-	 * This could have been a simple assignment in "C" but would need
-	 * explicit volatile. Otherwise gcc optimizers could elide the store
-	 * which borked atomic64 self-test
-	 * In the inline asm version, memory clobber needed for exact same
-	 * reason, to tell gcc about the store.
-	 *
-	 * This however is not needed for sibling atomic64_add() etc since both
-	 * load/store are explicitly done in inline asm. As long as API is used
-	 * for each access, gcc has no way to optimize away any load/store
-	 */
-	__asm__ __volatile__(
-	"	std   %0, [%1]	\n"
-	:
-	: "r"(a), "r"(&v->counter)
-	: "memory");
-}
-
-#define ATOMIC64_OP(op, op1, op2)					\
-static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
-{									\
-	s64 val;							\
-									\
-	__asm__ __volatile__(						\
-	"1:				\n"				\
-	"	llockd  %0, [%1]	\n"				\
-	"	" #op1 " %L0, %L0, %L2	\n"				\
-	"	" #op2 " %H0, %H0, %H2	\n"				\
-	"	scondd   %0, [%1]	\n"				\
-	"	bnz     1b		\n"				\
-	: "=&r"(val)							\
-	: "r"(&v->counter), "ir"(a)					\
-	: "cc");							\
-}									\
-
-#define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
-{									\
-	s64 val;							\
-									\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:				\n"				\
-	"	llockd   %0, [%1]	\n"				\
-	"	" #op1 " %L0, %L0, %L2	\n"				\
-	"	" #op2 " %H0, %H0, %H2	\n"				\
-	"	scondd   %0, [%1]	\n"				\
-	"	bnz     1b		\n"				\
-	: [val] "=&r"(val)						\
-	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
-									\
-	smp_mb();							\
-									\
-	return val;							\
-}
-
-#define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
-{									\
-	s64 val, orig;							\
-									\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:				\n"				\
-	"	llockd   %0, [%2]	\n"				\
-	"	" #op1 " %L1, %L0, %L3	\n"				\
-	"	" #op2 " %H1, %H0, %H3	\n"				\
-	"	scondd   %1, [%2]	\n"				\
-	"	bnz     1b		\n"				\
-	: "=&r"(orig), "=&r"(val)					\
-	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
-									\
-	smp_mb();							\
-									\
-	return orig;							\
-}
-
-#define ATOMIC64_OPS(op, op1, op2)					\
-	ATOMIC64_OP(op, op1, op2)					\
-	ATOMIC64_OP_RETURN(op, op1, op2)				\
-	ATOMIC64_FETCH_OP(op, op1, op2)
-
-ATOMIC64_OPS(add, add.f, adc)
-ATOMIC64_OPS(sub, sub.f, sbc)
-ATOMIC64_OPS(and, and, and)
-ATOMIC64_OPS(andnot, bic, bic)
-ATOMIC64_OPS(or, or, or)
-ATOMIC64_OPS(xor, xor, xor)
-
-#define arch_atomic64_andnot		arch_atomic64_andnot
-#define arch_atomic64_fetch_andnot	arch_atomic64_fetch_andnot
-
-#undef ATOMIC64_OPS
-#undef ATOMIC64_FETCH_OP
-#undef ATOMIC64_OP_RETURN
-#undef ATOMIC64_OP
-
-static inline s64
-arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
-{
-	s64 prev;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llockd  %0, [%1]	\n"
-	"	brne    %L0, %L2, 2f	\n"
-	"	brne    %H0, %H2, 2f	\n"
-	"	scondd  %3, [%1]	\n"
-	"	bnz     1b		\n"
-	"2:				\n"
-	: "=&r"(prev)
-	: "r"(ptr), "ir"(expected), "r"(new)
-	: "cc");	/* memory clobber comes from smp_mb() */
-
-	smp_mb();
-
-	return prev;
-}
-
-static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
-{
-	s64 prev;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llockd  %0, [%1]	\n"
-	"	scondd  %2, [%1]	\n"
-	"	bnz     1b		\n"
-	"2:				\n"
-	: "=&r"(prev)
-	: "r"(ptr), "r"(new)
-	: "cc");	/* memory clobber comes from smp_mb() */
-
-	smp_mb();
-
-	return prev;
-}
-
-/**
- * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic64_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-
-static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
-{
-	s64 val;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llockd  %0, [%1]	\n"
-	"	sub.f   %L0, %L0, 1	# w0 - 1, set C on borrow\n"
-	"	sub.c   %H0, %H0, 1	# if C set, w1 - 1\n"
-	"	brlt    %H0, 0, 2f	\n"
-	"	scondd  %0, [%1]	\n"
-	"	bnz     1b		\n"
-	"2:				\n"
-	: "=&r"(val)
-	: "r"(&v->counter)
-	: "cc");	/* memory clobber comes from smp_mb() */
-
-	smp_mb();
-
-	return val;
-}
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
-
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if it was not @u.
- * Returns the old value of @v
- */
-static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	s64 old, temp;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llockd  %0, [%2]	\n"
-	"	brne	%L0, %L4, 2f	# continue to add since v != u \n"
-	"	breq.d	%H0, %H4, 3f	# return since v == u \n"
-	"2:				\n"
-	"	add.f   %L1, %L0, %L3	\n"
-	"	adc     %H1, %H0, %H3	\n"
-	"	scondd  %1, [%2]	\n"
-	"	bnz     1b		\n"
-	"3:				\n"
-	: "=&r"(old), "=&r" (temp)
-	: "r"(&v->counter), "r"(a), "r"(u)
-	: "cc");	/* memory clobber comes from smp_mb() */
-
-	smp_mb();
-
-	return old;
-}
-#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
-
-#endif	/* !CONFIG_GENERIC_ATOMIC64 */
+#else
+#include <asm/atomic64-arcv2.h>
+#endif
 
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
new file mode 100644
index 000000000000..53996b11b551
--- /dev/null
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * ARCv2 supports 64-bit exclusive load (LLOCKD) / store (SCONDD)
+ *  - The address HAS to be 64-bit aligned
+ */
+
+#ifndef _ASM_ARC_ATOMIC64_ARCV2_H
+#define _ASM_ARC_ATOMIC64_ARCV2_H
+
+typedef struct {
+	s64 __aligned(8) counter;
+} atomic64_t;
+
+#define ATOMIC64_INIT(a) { (a) }
+
+static inline s64 arch_atomic64_read(const atomic64_t *v)
+{
+	s64 val;
+
+	__asm__ __volatile__(
+	"	ldd   %0, [%1]	\n"
+	: "=r"(val)
+	: "r"(&v->counter));
+
+	return val;
+}
+
+static inline void arch_atomic64_set(atomic64_t *v, s64 a)
+{
+	/*
+	 * This could have been a simple assignment in "C" but would need
+	 * explicit volatile. Otherwise gcc optimizers could elide the store
+	 * which borked atomic64 self-test
+	 * In the inline asm version, memory clobber needed for exact same
+	 * reason, to tell gcc about the store.
+	 *
+	 * This however is not needed for sibling atomic64_add() etc since both
+	 * load/store are explicitly done in inline asm. As long as API is used
+	 * for each access, gcc has no way to optimize away any load/store
+	 */
+	__asm__ __volatile__(
+	"	std   %0, [%1]	\n"
+	:
+	: "r"(a), "r"(&v->counter)
+	: "memory");
+}
+
+#define ATOMIC64_OP(op, op1, op2)					\
+static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
+{									\
+	s64 val;							\
+									\
+	__asm__ __volatile__(						\
+	"1:				\n"				\
+	"	llockd  %0, [%1]	\n"				\
+	"	" #op1 " %L0, %L0, %L2	\n"				\
+	"	" #op2 " %H0, %H0, %H2	\n"				\
+	"	scondd   %0, [%1]	\n"				\
+	"	bnz     1b		\n"				\
+	: "=&r"(val)							\
+	: "r"(&v->counter), "ir"(a)					\
+	: "cc");							\
+}									\
+
+#define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
+static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
+{									\
+	s64 val;							\
+									\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:				\n"				\
+	"	llockd   %0, [%1]	\n"				\
+	"	" #op1 " %L0, %L0, %L2	\n"				\
+	"	" #op2 " %H0, %H0, %H2	\n"				\
+	"	scondd   %0, [%1]	\n"				\
+	"	bnz     1b		\n"				\
+	: [val] "=&r"(val)						\
+	: "r"(&v->counter), "ir"(a)					\
+	: "cc");	/* memory clobber comes from smp_mb() */	\
+									\
+	smp_mb();							\
+									\
+	return val;							\
+}
+
+#define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
+static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
+{									\
+	s64 val, orig;							\
+									\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:				\n"				\
+	"	llockd   %0, [%2]	\n"				\
+	"	" #op1 " %L1, %L0, %L3	\n"				\
+	"	" #op2 " %H1, %H0, %H3	\n"				\
+	"	scondd   %1, [%2]	\n"				\
+	"	bnz     1b		\n"				\
+	: "=&r"(orig), "=&r"(val)					\
+	: "r"(&v->counter), "ir"(a)					\
+	: "cc");	/* memory clobber comes from smp_mb() */	\
+									\
+	smp_mb();							\
+									\
+	return orig;							\
+}
+
+#define ATOMIC64_OPS(op, op1, op2)					\
+	ATOMIC64_OP(op, op1, op2)					\
+	ATOMIC64_OP_RETURN(op, op1, op2)				\
+	ATOMIC64_FETCH_OP(op, op1, op2)
+
+ATOMIC64_OPS(add, add.f, adc)
+ATOMIC64_OPS(sub, sub.f, sbc)
+ATOMIC64_OPS(and, and, and)
+ATOMIC64_OPS(andnot, bic, bic)
+ATOMIC64_OPS(or, or, or)
+ATOMIC64_OPS(xor, xor, xor)
+
+#define arch_atomic64_andnot		arch_atomic64_andnot
+#define arch_atomic64_fetch_andnot	arch_atomic64_fetch_andnot
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+static inline s64
+arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
+{
+	s64 prev;
+
+	smp_mb();
+
+	__asm__ __volatile__(
+	"1:	llockd  %0, [%1]	\n"
+	"	brne    %L0, %L2, 2f	\n"
+	"	brne    %H0, %H2, 2f	\n"
+	"	scondd  %3, [%1]	\n"
+	"	bnz     1b		\n"
+	"2:				\n"
+	: "=&r"(prev)
+	: "r"(ptr), "ir"(expected), "r"(new)
+	: "cc");	/* memory clobber comes from smp_mb() */
+
+	smp_mb();
+
+	return prev;
+}
+
+static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
+{
+	s64 prev;
+
+	smp_mb();
+
+	__asm__ __volatile__(
+	"1:	llockd  %0, [%1]	\n"
+	"	scondd  %2, [%1]	\n"
+	"	bnz     1b		\n"
+	"2:				\n"
+	: "=&r"(prev)
+	: "r"(ptr), "r"(new)
+	: "cc");	/* memory clobber comes from smp_mb() */
+
+	smp_mb();
+
+	return prev;
+}
+
+/**
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic64_t
+ *
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
+ */
+
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
+{
+	s64 val;
+
+	smp_mb();
+
+	__asm__ __volatile__(
+	"1:	llockd  %0, [%1]	\n"
+	"	sub.f   %L0, %L0, 1	# w0 - 1, set C on borrow\n"
+	"	sub.c   %H0, %H0, 1	# if C set, w1 - 1\n"
+	"	brlt    %H0, 0, 2f	\n"
+	"	scondd  %0, [%1]	\n"
+	"	bnz     1b		\n"
+	"2:				\n"
+	: "=&r"(val)
+	: "r"(&v->counter)
+	: "cc");	/* memory clobber comes from smp_mb() */
+
+	smp_mb();
+
+	return val;
+}
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+
+/**
+ * arch_atomic64_fetch_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if it was not @u.
+ * Returns the old value of @v
+ */
+static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	s64 old, temp;
+
+	smp_mb();
+
+	__asm__ __volatile__(
+	"1:	llockd  %0, [%2]	\n"
+	"	brne	%L0, %L4, 2f	# continue to add since v != u \n"
+	"	breq.d	%H0, %H4, 3f	# return since v == u \n"
+	"2:				\n"
+	"	add.f   %L1, %L0, %L3	\n"
+	"	adc     %H1, %H0, %H3	\n"
+	"	scondd  %1, [%2]	\n"
+	"	bnz     1b		\n"
+	"3:				\n"
+	: "=&r"(old), "=&r" (temp)
+	: "r"(&v->counter), "r"(a), "r"(u)
+	: "cc");	/* memory clobber comes from smp_mb() */
+
+	smp_mb();
+
+	return old;
+}
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+
+#endif
-- 
2.25.1

