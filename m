Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0D34B8BB
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhC0SH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 14:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhC0SHa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 14:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3CB3619BB;
        Sat, 27 Mar 2021 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616868450;
        bh=DsrHsPtWDnnHmn30NT+r18yNYxdqI6C4be+2gqhoyC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riJh0/0iIDu7i9hn241DanZ0bIJyLp/J09SWZIldQpqVoJq6VRxGZZ/CyLDGsD7/9
         miWSJHXEsYzRPFNJERuw1N0M32YNpBFbkw8hgNjkRlxzMXvV/oOcU4oz/CM/DiB8k4
         sHEnXD0Y9dlznQv3jcBVKZkl27eaOxln6OnJNg4vbbrTsRbfMgI5o2ZXsYwZcNQokN
         BBqz2WnCEzzsGe0eRyGngpGATwdR9qCdj/B/O1akgK89sx7OvsJ7EZLxoC5luLz87o
         qh8+Iz151MquloFrNgC+/pEO9k4lqZktpB+jj03d1odC+WvspW4pRgwad4+9DGZwfI
         5GnpMNSZGsqdQ==
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
Subject: [PATCH v4 1/4] riscv: cmpxchg.h: Cleanup unused code
Date:   Sat, 27 Mar 2021 18:06:36 +0000
Message-Id: <1616868399-82848-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616868399-82848-1-git-send-email-guoren@kernel.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove unnecessary marco, they are no use or handled by generic
files (atomic-fallback.h, asm-generic/cmpxchg*).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/linux-riscv/CAJF2gTT1_mP-wiK2HsCpTeU61NqZVKZX1A5ye=TwqvGN4TPmrA@mail.gmail.com/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Clark <michaeljclark@mac.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/cmpxchg.h | 83 --------------------------------
 1 file changed, 83 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 262e5bbb2776..f1383c15e16b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -72,13 +72,6 @@
 	__ret;								\
 })
 
-#define xchg_acquire(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
 #define __xchg_release(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -107,13 +100,6 @@
 	__ret;								\
 })
 
-#define xchg_release(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
 #define __xchg(ptr, new, size)						\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -140,24 +126,6 @@
 	__ret;								\
 })
 
-#define xchg(ptr, x)							\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
-
-#define xchg32(ptr, x)							\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	xchg((ptr), (x));						\
-})
-
-#define xchg64(ptr, x)							\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	xchg((ptr), (x));						\
-})
-
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
@@ -245,14 +213,6 @@
 	__ret;								\
 })
 
-#define cmpxchg_acquire(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
-
 #define __cmpxchg_release(ptr, old, new, size)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -291,14 +251,6 @@
 	__ret;								\
 })
 
-#define cmpxchg_release(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
-
 #define __cmpxchg(ptr, old, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -337,39 +289,4 @@
 	__ret;								\
 })
 
-#define cmpxchg(ptr, o, n)						\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
-				       _o_, _n_, sizeof(*(ptr)));	\
-})
-
-#define cmpxchg_local(ptr, o, n)					\
-	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
-
-#define cmpxchg32(ptr, o, n)						\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	cmpxchg((ptr), (o), (n));					\
-})
-
-#define cmpxchg32_local(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	cmpxchg_relaxed((ptr), (o), (n))				\
-})
-
-#define cmpxchg64(ptr, o, n)						\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
-})
-
-#define cmpxchg64_local(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_relaxed((ptr), (o), (n));				\
-})
-
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.17.1

