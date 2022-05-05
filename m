Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15FF51B6D0
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiEED7m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbiEED7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095B4BFF4;
        Wed,  4 May 2022 20:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906BC61977;
        Thu,  5 May 2022 03:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5986C385A4;
        Thu,  5 May 2022 03:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722957;
        bh=0v6ObbrAdmPbTrFO/udpzX7A+GrHtoKSTX5QoRJ+xrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzIXWQco6g6JV4dAzlbltsr8V0oE5Qyj1Gc26OCZMCNCGGJ+cFiIeTTGy4/eLO2DE
         lcnuNQ20LKvW7zSZi7AbgLKoaKUebZUyRJrw7kxHGsiltA1VhQPM0E0F7jyp2zQ12z
         OCIq4bJhp3m429WQ2cAncxwSrK3MyqpCBui+UTlGY5ClQ9/3GUS60lbnoWw5vG37SS
         DU3Y1PF8yFehqzGlux2/tk2Qn3aWXbLP747AoY8VZt5YLw1miSgQxc3h2sON9rh0QW
         REewB/mS+qdxDlTPoyyN59gYi/M3sMqCHMgREHQomdhDwYpQ7U3qfP5oIxj6Gr30Ia
         76Tak31K+CMpg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 4/5] riscv: atomic: Optimize atomic_ops & xchg with .aq/rl annotation
Date:   Thu,  5 May 2022 11:55:25 +0800
Message-Id: <20220505035526.2974382-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505035526.2974382-1-guoren@kernel.org>
References: <20220505035526.2974382-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current atomic_ops' acquire & release implementations are using
fence instruction which causes another extra bad "fence r/fence
,w" performance effect. They are too heavy for Linux atomic
acquire & release semantic requirements. RISC-V AMO instructions
could embed aquire and release into AMO instructions. Here is the
related description from RISC-V ISA spec:

To help implement multiprocessor synchronization, the AMOs
optionally provide release consistency semantics.
 - .aq:   If the aq bit is set, then no later memory operations
          in this RISC-V hart can be observed to take place
          before the AMO.
 - .rl:   If the rl bit is set, then other RISC-V harts will not
          observe the AMO before memory accesses preceding the
          AMO in this RISC-V hart.
 - .aqrl: Setting both the aq and the rl bit on an AMO makes the
          sequence sequentially consistent, meaning that it cannot
          be reordered with earlier or later memory operations
          from the same hart.

Let's use the above to optimize riscv atomic performance, just
like arm64/include/asm/atomic_lse.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Dan Lustig <dlustig@nvidia.com>
---
 arch/riscv/include/asm/atomic.h  | 64 ++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/cmpxchg.h | 12 ++----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0dfe9d857a76..34f757dfc8f2 100644
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
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e5..1af8db92250b 100644
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
-- 
2.25.1

