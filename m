Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16934B8BA
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhC0SH5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 14:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhC0SHc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 14:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6690361991;
        Sat, 27 Mar 2021 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616868452;
        bh=Qa6OT7eFmBau8vPzDLJz0ISmmELm1dvO3bmq0s5juCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbI1c9dCyqddwz4XpqVGp+XIxzBmEdkrXa0WuxWogZgApEsrZref3oSR70ZG3PNKC
         9nTWvZmlNYLxLAlIh2Z9oUPtYo1wteyvsIgHQp2gjmTyeIhg16wX7JxjYYkwnMyrTa
         0WY5F1a6NsxxYDgcCOo89CSrMAWQX5J5yoZSsStRurunJMXf1W3MUatbAl5S5JK9c+
         BcZKUkvuxUf5RUcuiU9usPQR1u1AUUw8XNdSmT1BraNS/reh16XqTw8Kqbi1rvVpVb
         bJAtLbDkYQnaK9gGd7bFMRtQ2ZVSzUwFYLEJkc9Mn9KZcn1R5L+e9zrnLevlst6V08
         Jo4Iw8bGyxzxQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Clark <michaeljclark@mac.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 2/4] riscv: cmpxchg.h: Merge macros
Date:   Sat, 27 Mar 2021 18:06:37 +0000
Message-Id: <1616868399-82848-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616868399-82848-1-git-send-email-guoren@kernel.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

To reduce assembly codes, let's merge duplicate codes into one
(xchg_acquire, xchg_release, cmpxchg_release).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/linux-riscv/CAJF2gTT1_mP-wiK2HsCpTeU61NqZVKZX1A5ye=TwqvGN4TPmrA@mail.gmail.com/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Clark <michaeljclark@mac.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/cmpxchg.h | 92 +++++---------------------------
 1 file changed, 12 insertions(+), 80 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index f1383c15e16b..50513b95411d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,12 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define __local_acquire_fence()						\
+	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
+
+#define __local_release_fence()						\
+	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory")
+
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -46,58 +52,16 @@
 
 #define __xchg_acquire(ptr, new, size)					\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
+	__ret = __xchg_relaxed(ptr, new, size);				\
+	__local_acquire_fence();					\
 	__ret;								\
 })
 
 #define __xchg_release(ptr, new, size)					\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
+	__local_release_fence();					\
+	__xchg_relaxed(ptr, new, size);					\
 })
 
 #define __xchg(ptr, new, size)						\
@@ -215,40 +179,8 @@
 
 #define __cmpxchg_release(ptr, old, new, size)				\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
+	__local_release_fence();					\
+	__cmpxchg_relaxed(ptr, old, new, size);				\
 })
 
 #define __cmpxchg(ptr, old, new, size)					\
-- 
2.17.1

