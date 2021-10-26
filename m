Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3C43AFAF
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhJZKHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 06:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbhJZKHJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Oct 2021 06:07:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C94860551;
        Tue, 26 Oct 2021 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635242686;
        bh=mueXg1F3T64Z32N3VW1n8boTWbbmg7I1y/7PkQQVs6I=;
        h=From:To:Cc:Subject:Date:From;
        b=sXZIFRtmURYWbYpeH4TdmXwzXr4RZqqFMbiFASxsr06ZANE0pHmwOxAihUXQ638mG
         EIC5Y/Yzawqfm3tXW84MGVHsrmgVcY1hVAE5f9DpogFzmVcimKX2752EjcCUa8nQ7k
         YUm51TngJedNpMy3ew0vggnkNIsdQ0DU+TKLsooAiuVEF2/HpHWf2W7on5d6+Eo4mz
         H6javFuFTUYRTHbzjfnRQ37vXaVsUqR+L0Sa588RxUFJIAyOm3BoREgil1t/i6lHkV
         +Dv+0/qiiB9DpCNgHsFClLM7EDhnlaymt+DY2OnFv2gGBXuL/h+6AQsm7tYI9hIffU
         Vglh1dzxS+D0A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/2] futex: ensure futex_atomic_cmpxchg_inatomic() is present
Date:   Tue, 26 Oct 2021 12:03:47 +0200
Message-Id: <20211026100432.1730393-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The boot-time detection of futex_atomic_cmpxchg_inatomic()
has a bug on some 32-bit arm builds, and Thomas Gleixner
suggested that setting CONFIG_HAVE_FUTEX_CMPXCHG would
avoid the problem, as it is always present anyway.

Looking into which other architectures could do the same
showed that almost all architectures have it, the exceptions
being:

 - some old 32-bit MIPS uniprocessor cores without ll/sc
 - one xtensa variant with no SMP
 - 32-bit SPARC when built for SMP

Fix MIPS And Xtensa by rearranging the generic code to let it be used
as a fallback.

For SPARC, the SMP definition just ends up turning off futex anyway,
so this can be done at Kconfig time instead. Note that sparc32
glibc requires the CASA instruction for its mutexes anyway,
which is only available when running on SPARCv9 or LEON CPUs,
but needs to be implemented in the sparc32 kernel for those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/futex.h   | 29 ++++++++++++++++++-----------
 arch/xtensa/include/asm/futex.h |  8 ++++++--
 include/asm-generic/futex.h     | 31 +++++++++++--------------------
 init/Kconfig                    |  1 +
 4 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index d85248404c52..9287110cb06d 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -19,7 +19,11 @@
 #include <asm/sync.h>
 #include <asm/war.h>
 
-#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
+#define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
+#define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
+#include <asm-generic/futex.h>
+
+#define __futex_atomic_op(op, insn, ret, oldval, uaddr, oparg)		\
 {									\
 	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {	\
 		__asm__ __volatile__(					\
@@ -80,9 +84,11 @@
 		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
 		  "i" (-EFAULT)						\
 		: "memory");						\
-	} else								\
-		ret = -ENOSYS;						\
-}
+	} else {							\
+		/* fallback for non-SMP */				\
+		ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
+							uaddr);	\
+	}
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
@@ -94,23 +100,23 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("move $1, %z5", ret, oldval, uaddr, oparg);
+		__futex_atomic_op(op, "move $1, %z5", ret, oldval, uaddr, oparg);
 		break;
 
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("addu $1, %1, %z5",
+		__futex_atomic_op(op, "addu $1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("or	$1, %1, %z5",
+		__futex_atomic_op(op, "or	$1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	$1, %1, %z5",
+		__futex_atomic_op(op, "and	$1, %1, %z5",
 				  ret, oldval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("xor	$1, %1, %z5",
+		__futex_atomic_op(op, "xor	$1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	default:
@@ -193,8 +199,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
-	} else
-		return -ENOSYS;
+	} else {
+		return futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval);
+	}
 
 	*uval = val;
 	return ret;
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index a1a27b2ea460..fe8f31575ab1 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -16,6 +16,10 @@
 #include <linux/uaccess.h>
 #include <linux/errno.h>
 
+#define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
+#define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
+#include <asm-generic/futex.h>
+
 #if XCHAL_HAVE_EXCLUSIVE
 #define __futex_atomic_op(insn, ret, old, uaddr, arg)	\
 	__asm__ __volatile(				\
@@ -105,7 +109,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	return ret;
 #else
-	return -ENOSYS;
+	return arch_futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
 #endif
 }
 
@@ -156,7 +160,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	return ret;
 #else
-	return -ENOSYS;
+	return futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval);
 #endif
 }
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index f4c3470480c7..30e7fa63b5df 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -6,15 +6,22 @@
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 
+#ifndef futex_atomic_cmpxchg_inatomic
 #ifndef CONFIG_SMP
 /*
  * The following implementation only for uniprocessor machines.
  * It relies on preempt_disable() ensuring mutual exclusion.
  *
  */
+#define futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval) \
+	futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newval)
+#define arch_futex_atomic_op_inuser(op, oparg, oval, uaddr) \
+	arch_futex_atomic_op_inuser_local_generic(op, oparg, oval, uaddr)
+#endif /* CONFIG_SMP */
+#endif
 
 /**
- * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
+ * arch_futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
@@ -28,7 +35,7 @@
  * -ENOSYS - Operation not supported
  */
 static inline int
-arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+futex_atomic_op_inuser_local(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval, ret;
 	u32 tmp;
@@ -75,7 +82,7 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 }
 
 /**
- * futex_atomic_cmpxchg_inatomic() - Compare and exchange the content of the
+ * futex_atomic_cmpxchg_inatomic_local() - Compare and exchange the content of the
  *				uaddr with newval if the current value is
  *				oldval.
  * @uval:	pointer to store content of @uaddr
@@ -87,10 +94,9 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
  * 0 - On success
  * -EFAULT - User access resulted in a page fault
  * -EAGAIN - Atomic operation was unable to complete due to contention
- * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
  */
 static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+futex_atomic_cmpxchg_inatomic_local(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
 {
 	u32 val;
@@ -112,19 +118,4 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	return 0;
 }
 
-#else
-static inline int
-arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
-{
-	return -ENOSYS;
-}
-
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_SMP */
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index edc0a0228f14..c0f55ea5a71f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1584,6 +1584,7 @@ config BASE_FULL
 
 config FUTEX
 	bool "Enable futex support" if EXPERT
+	depends on !(SPARC32 && SMP)
 	default y
 	imply RT_MUTEXES
 	help
-- 
2.29.2

