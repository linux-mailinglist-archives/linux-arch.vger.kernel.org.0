Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE114F62CF
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiDFPP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiDFPPL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 11:15:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4031517CC7;
        Wed,  6 Apr 2022 05:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF70FCE22E4;
        Wed,  6 Apr 2022 12:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D18C385B5;
        Wed,  6 Apr 2022 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649246715;
        bh=rt0wDlUOfXUFyUlSaOUV3jMwgpV+M0IZlrMbI4ZWEOs=;
        h=From:To:Cc:Subject:Date:From;
        b=t6F7+QgYocVCXRx6iQo1raESLOLbSQvOTLxig3SvJ5zdF7zIl43MxAfgMXt+/92jc
         KNDvYtcoQnBBnD8H8TsKxRJfhd3aDuTS/U0R++HkOiLhLQT620C8F54j8kw6X9qYoa
         T2avXcfndLpylpf46d93/gB6HFM3W5K8vkm5joHtldkwETtvm1MvMTkIgEeyoyd/DE
         66P+AOpcvtpckoCLzvNAJMU5IfBG8oA599Rl2xv0ll2x6WUf/eKFG+EWf/S8nOX7mt
         +xzWry/JI4Bkz74a5PG+MCkk3Zjl2dj8Uilt3aQsSjfCIQE45KxqmtsFp5pED6tykK
         i8ta3NDzDSf2g==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, mark.rutland@arm.com,
        peterz@infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] riscv: Optimize AMO acquire/release usage
Date:   Wed,  6 Apr 2022 20:04:05 +0800
Message-Id: <20220406120405.660354-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Using RISCV_ACQUIRE/RELEASE_BARRIER is over expensive for
xchg/cmpxchg_acquire/release than nature instructions' .aq/rl.
The patch fixed these issues under RISC-V Instruction Set Manual,
Volume I: RISC-V User-Level ISA “A” Standard Extension for Atomic
Instructions, Version 2.1.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
 arch/riscv/include/asm/cmpxchg.h | 30 +++++---------
 2 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index ac9bdf4fc404..364df773a36a 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -99,6 +99,30 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
 	return ret;							\
 }									\
 static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type ".aq %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type ".rl %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 {									\
 	register c_type ret;						\
@@ -118,6 +142,18 @@ c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
         return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
 }									\
 static __always_inline							\
+c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,		\
+					      atomic##prefix##_t *v)	\
+{									\
+        return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;	\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_##op##_return_release(c_type i,		\
+					      atomic##prefix##_t *v)	\
+{									\
+        return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;	\
+}									\
+static __always_inline							\
 c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
 {									\
         return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
@@ -140,22 +176,38 @@ ATOMIC_OPS(sub, add, +, -i)
 
 #define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
 #define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_add_return_acquire	arch_atomic_add_return_acquire
+#define arch_atomic_sub_return_acquire	arch_atomic_sub_return_acquire
+#define arch_atomic_add_return_release	arch_atomic_add_return_release
+#define arch_atomic_sub_return_release	arch_atomic_sub_return_release
 #define arch_atomic_add_return		arch_atomic_add_return
 #define arch_atomic_sub_return		arch_atomic_sub_return
 
 #define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
 #define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add_acquire
+#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub_acquire
+#define arch_atomic_fetch_add_release	arch_atomic_fetch_add_release
+#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub_release
 #define arch_atomic_fetch_add		arch_atomic_fetch_add
 #define arch_atomic_fetch_sub		arch_atomic_fetch_sub
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
 #define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_add_return_acquire	arch_atomic64_add_return_acquire
+#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return_acquire
+#define arch_atomic64_add_return_release	arch_atomic64_add_return_release
+#define arch_atomic64_sub_return_release	arch_atomic64_sub_return_release
 #define arch_atomic64_add_return		arch_atomic64_add_return
 #define arch_atomic64_sub_return		arch_atomic64_sub_return
 
 #define arch_atomic64_fetch_add_relaxed	arch_atomic64_fetch_add_relaxed
 #define arch_atomic64_fetch_sub_relaxed	arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_add_acquire	arch_atomic64_fetch_add_acquire
+#define arch_atomic64_fetch_sub_acquire	arch_atomic64_fetch_sub_acquire
+#define arch_atomic64_fetch_add_release	arch_atomic64_fetch_add_release
+#define arch_atomic64_fetch_sub_release	arch_atomic64_fetch_sub_release
 #define arch_atomic64_fetch_add		arch_atomic64_fetch_add
 #define arch_atomic64_fetch_sub		arch_atomic64_fetch_sub
 #endif
@@ -178,6 +230,12 @@ ATOMIC_OPS(xor, xor, i)
 #define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
 #define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
 #define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and_acquire
+#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or_acquire
+#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor_acquire
+#define arch_atomic_fetch_and_release	arch_atomic_fetch_and_release
+#define arch_atomic_fetch_or_release	arch_atomic_fetch_or_release
+#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor_release
 #define arch_atomic_fetch_and		arch_atomic_fetch_and
 #define arch_atomic_fetch_or		arch_atomic_fetch_or
 #define arch_atomic_fetch_xor		arch_atomic_fetch_xor
@@ -186,6 +244,12 @@ ATOMIC_OPS(xor, xor, i)
 #define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
 #define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
 #define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_acquire	arch_atomic64_fetch_and_acquire
+#define arch_atomic64_fetch_or_acquire	arch_atomic64_fetch_or_acquire
+#define arch_atomic64_fetch_xor_acquire	arch_atomic64_fetch_xor_acquire
+#define arch_atomic64_fetch_and_release	arch_atomic64_fetch_and_release
+#define arch_atomic64_fetch_or_release	arch_atomic64_fetch_or_release
+#define arch_atomic64_fetch_xor_release	arch_atomic64_fetch_xor_release
 #define arch_atomic64_fetch_and		arch_atomic64_fetch_and
 #define arch_atomic64_fetch_or		arch_atomic64_fetch_or
 #define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
@@ -315,12 +379,11 @@ static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
        int prev, rc;
 
 	__asm__ __volatile__ (
-		"0:	lr.w     %[p],  %[c]\n"
+		"0:	lr.w.aq  %[p],  %[c]\n"
 		"	sub      %[rc], %[p], %[o]\n"
 		"	bltz     %[rc], 1f\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
@@ -337,12 +400,11 @@ static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offs
        long rc;
 
 	__asm__ __volatile__ (
-		"0:	lr.d     %[p],  %[c]\n"
+		"0:	lr.d.aq  %[p],  %[c]\n"
 		"	sub      %[rc], %[p], %[o]\n"
 		"	bltz     %[rc], 1f\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 36dc962f6343..8ff1cd8162ba 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -52,16 +52,14 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
+			"	amoswap.w.aq %0, %2, %1\n"		\
 			: "=r" (__ret), "+A" (*__ptr)			\
 			: "r" (__new)					\
 			: "memory");					\
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
+			"	amoswap.d.aq %0, %2, %1\n"		\
 			: "=r" (__ret), "+A" (*__ptr)			\
 			: "r" (__new)					\
 			: "memory");					\
@@ -87,16 +85,14 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
+			"	amoswap.w.rl %0, %2, %1\n"		\
 			: "=r" (__ret), "+A" (*__ptr)			\
 			: "r" (__new)					\
 			: "memory");					\
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
+			"	amoswap.d.rl %0, %2, %1\n"		\
 			: "=r" (__ret), "+A" (*__ptr)			\
 			: "r" (__new)					\
 			: "memory");					\
@@ -217,11 +213,10 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
+			"0:	lr.w.aq %0, %2\n"			\
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc.w %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -229,11 +224,10 @@
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
+			"0:	lr.d.aq %0, %2\n"			\
 			"	bne %0, %z3, 1f\n"			\
 			"	sc.d %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
@@ -263,10 +257,9 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
 			"0:	lr.w %0, %2\n"				\
 			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
+			"	sc.w.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
@@ -275,10 +268,9 @@
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
+			"	sc.d.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
@@ -309,11 +301,10 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
+			"0:	lr.w.aq %0, %2\n"			\
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc.w.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -321,11 +312,10 @@
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
+			"0:	lr.d.aq %0, %2\n"			\
 			"	bne %0, %z3, 1f\n"			\
 			"	sc.d.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
-- 
2.25.1

