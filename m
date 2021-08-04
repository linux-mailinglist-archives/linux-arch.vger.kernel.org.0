Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842573E088B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhHDTQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:22 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40428 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239266AbhHDTQT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:19 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D21B4C0CDC;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=i2F/9YRMlOyy1XZaqz44Wx2eOceMuhjPj2C/x/to/4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJCxmScrYoShGfaG0I9WL5yUKSMBjZchJ04WFUC8YzFDDlV8PfUIAajnhanD6BqLs
         mAFbhJiuXF2XrwoSV4oIdZXNM0RfiV5HcRo3xZrBD32kwCuOFJ0RfSS4iO8354Ynw5
         Hhjw5w8IN1GdAR9ZHz4BGFDZBX7yhbpUm+K2VHAIELGl0F9KYb4+A9beDHiEMAwx0v
         8Z1P1Acx3bB0pe3IPne1dANjlFQ8z/FDW8KEOLfjQmJrzaww3N3XqyQoWYPlYkPHp5
         t7FVt3bR9b8W4fzx8g1ar7S3mk7yV46QhmVwgepH/KDw2PB+PRrcJ+og+QubPPIbzQ
         tvf3DBQVQXo2g==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 51DD5A009D;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 05/11] ARC: atomics: implement relaxed variants
Date:   Wed,  4 Aug 2021 12:15:48 -0700
Message-Id: <20210804191554.1252776-6-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current ARC fetch/return atomics provide fully ordered semantics
only with 2 full barriers around the operation.

Instead implement them as relaxed variants without any barriers and
rely on generic code to generate the fully-ordered, acquire and release
varaints by adding the appropriate full barriers.

This helps elide some extra barriers in case of acquire/release/relaxed
calls.

bloat-o-meter for hsdk defconfig shows codegen improvements, although
numbers below inflated due to unrelated inlining heuristic changes

| bloat-o-meter vmlinux-643babe34fd7-non-relaxed vmlinux-45aa05cb44d7-relaxed
| add/remove: 2/5 grow/shrink: 42/1222 up/down: 4158/-14312 (-10154)
| Function                                     old     new   delta
| ..
| sys_renameat                                 462     476     +14
| ip_mc_inc_group                              424     436     +12
| do_read_cache_page                          1882    1894     +12
| ..
| refcount_dec_and_mutex_lock                  254     250      -4
| refcount_dec_and_lock_irqsave                258     254      -4
| refcount_dec_and_lock                        254     250      -4
| ..
| tcp_v6_route_req                             246     238      -8
| tcp_v4_destroy_sock                          286     278      -8
| tcp_twsk_unique                              352     344      -8

Link: https://lore.kernel.org/r/20180830144344.GW24142@hirez.programming.kicks-ass.net
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic-llsc.h    | 32 +++++++++++----------------
 arch/arc/include/asm/atomic64-arcv2.h | 24 +++++++++++---------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/arc/include/asm/atomic-llsc.h b/arch/arc/include/asm/atomic-llsc.h
index aab4f2855457..088d348781c1 100644
--- a/arch/arc/include/asm/atomic-llsc.h
+++ b/arch/arc/include/asm/atomic-llsc.h
@@ -22,16 +22,10 @@ static inline void arch_atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val;						\
 									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such semantics	\
-	 */								\
-	smp_mb();							\
-									\
 	__asm__ __volatile__(						\
 	"1:	llock   %[val], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[val], %[i]	\n"		\
@@ -42,22 +36,17 @@ static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 	  [i]	"ir"	(i)						\
 	: "cc");							\
 									\
-	smp_mb();							\
-									\
 	return val;							\
 }
 
+#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
+
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val, orig;						\
 									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such semantics	\
-	 */								\
-	smp_mb();							\
-									\
 	__asm__ __volatile__(						\
 	"1:	llock   %[orig], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
@@ -69,11 +58,17 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 	  [i]	"ir"	(i)						\
 	: "cc");							\
 									\
-	smp_mb();							\
-									\
 	return orig;							\
 }
 
+#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
+
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
+
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
 	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
@@ -93,7 +88,6 @@ ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
 #define arch_atomic_andnot		arch_atomic_andnot
-#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
 
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index 22ef1cbb94e2..c5a8010fdc97 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -64,12 +64,10 @@ static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
+static inline s64 arch_atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)	\
 {									\
 	s64 val;							\
 									\
-	smp_mb();							\
-									\
 	__asm__ __volatile__(						\
 	"1:				\n"				\
 	"	llockd   %0, [%1]	\n"				\
@@ -81,18 +79,17 @@ static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
 	: "r"(&v->counter), "ir"(a)					\
 	: "cc");	/* memory clobber comes from smp_mb() */	\
 									\
-	smp_mb();							\
-									\
 	return val;							\
 }
 
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
+static inline s64 arch_atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)	\
 {									\
 	s64 val, orig;							\
 									\
-	smp_mb();							\
-									\
 	__asm__ __volatile__(						\
 	"1:				\n"				\
 	"	llockd   %0, [%2]	\n"				\
@@ -104,11 +101,17 @@ static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
 	: "r"(&v->counter), "ir"(a)					\
 	: "cc");	/* memory clobber comes from smp_mb() */	\
 									\
-	smp_mb();							\
-									\
 	return orig;							\
 }
 
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
+
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
+
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
@@ -128,7 +131,6 @@ ATOMIC64_OPS(or, or, or)
 ATOMIC64_OPS(xor, xor, xor)
 
 #define arch_atomic64_andnot		arch_atomic64_andnot
-#define arch_atomic64_fetch_andnot	arch_atomic64_fetch_andnot
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
-- 
2.25.1

