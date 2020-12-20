Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B472DF5F2
	for <lists+linux-arch@lfdr.de>; Sun, 20 Dec 2020 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLTPkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Dec 2020 10:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgLTPkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 20 Dec 2020 10:40:16 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 4/5] csky: Fixup asm/cmpxchg.h with correct ordering barrier
Date:   Sun, 20 Dec 2020 15:39:22 +0000
Message-Id: <1608478763-60148-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608478763-60148-1-git-send-email-guoren@kernel.org>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Optimize the performance of cmpxchg by using more fine-grained
acquire/release barriers.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 arch/csky/include/asm/cmpxchg.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 8922453..dabc8e4 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -3,12 +3,12 @@
 #ifndef __ASM_CSKY_CMPXCHG_H
 #define __ASM_CSKY_CMPXCHG_H
 
-#ifdef CONFIG_CPU_HAS_LDSTEX
+#ifdef CONFIG_SMP
 #include <asm/barrier.h>
 
 extern void __bad_xchg(void);
 
-#define __xchg(new, ptr, size)					\
+#define __xchg_relaxed(new, ptr, size)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -16,7 +16,6 @@ extern void __bad_xchg(void);
 	unsigned long tmp;					\
 	switch (size) {						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	mov		%1, %2   \n"		\
@@ -25,7 +24,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (tmp)		\
 			: "r" (__new), "r"(__ptr)		\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -33,9 +31,10 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
+#define xchg_relaxed(ptr, x) \
+		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
-#define __cmpxchg(ptr, old, new, size)				\
+#define __cmpxchg_relaxed(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -44,7 +43,6 @@ extern void __bad_xchg(void);
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	cmpne		%0, %4   \n"		\
@@ -56,7 +54,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (__tmp)		\
 			: "r" (__new), "r"(__ptr), "r"(__old)	\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -64,8 +61,18 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define cmpxchg(ptr, o, n) \
-	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+#define cmpxchg_relaxed(ptr, o, n) \
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg(ptr, o, n) 					\
+({								\
+	__typeof__(*(ptr)) __ret;				\
+	__smp_release_fence();					\
+	__ret = cmpxchg_relaxed(ptr, o, n);			\
+	__smp_acquire_fence();					\
+	__ret;							\
+})
+
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.7.4

