Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9072DF5F8
	for <lists+linux-arch@lfdr.de>; Sun, 20 Dec 2020 16:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgLTPk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Dec 2020 10:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbgLTPkO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 20 Dec 2020 10:40:14 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 3/5] csky: Fixup futex SMP implementation
Date:   Sun, 20 Dec 2020 15:39:21 +0000
Message-Id: <1608478763-60148-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608478763-60148-1-git-send-email-guoren@kernel.org>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Arnd said:
I would guess that for csky, this is a mistake, as the architecture
is fairly new and should be able to implement it.

Guo reply:
The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
with asm-generic's implementation.
For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
implementation, so futex_cmpxchg_enabled = 0.

Thx for point it out, we'll implement cmpxchg_inatomic/inuser for
C860 and still use asm-generic for non-smp CPUs.

LTP test:
futex_wait01    1  TPASS  :  futex_wait(): errno=ETIMEDOUT(110): Connection timed out
futex_wait01    2  TPASS  :  futex_wait(): errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
futex_wait01    3  TPASS  :  futex_wait(): errno=ETIMEDOUT(110): Connection timed out
futex_wait01    4  TPASS  :  futex_wait(): errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
futex_wait02    1  TPASS  :  futex_wait() woken up
futex_wait03    1  TPASS  :  futex_wait() woken up
futex_wait04    1  TPASS  :  futex_wait() returned -1: errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com/
---
 arch/csky/Kconfig             |   1 +
 arch/csky/include/asm/futex.h | 127 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 arch/csky/include/asm/futex.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 50bb8b4..e254dc2 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -49,6 +49,7 @@ config CSKY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUTEX_CMPXCHG if FUTEX && SMP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/csky/include/asm/futex.h b/arch/csky/include/asm/futex.h
new file mode 100644
index 00000000..dbe2f99
--- /dev/null
+++ b/arch/csky/include/asm/futex.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_FUTEX_H
+#define __ASM_CSKY_FUTEX_H
+
+#ifndef CONFIG_SMP
+#include <asm-generic/futex.h>
+#else
+#include <linux/atomic.h>
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <linux/errno.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
+{									\
+	u32 tmp;							\
+									\
+	__atomic_pre_full_fence();					\
+									\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w	%[ov], %[u]			\n"		\
+	"	"insn"					\n"		\
+	"2:	stex.w	%[t], %[u]			\n"		\
+	"	bez	%[t], 1b			\n"		\
+	"4:						\n"		\
+	"	.section .fixup,\"ax\"			\n"		\
+	"	.balign 4				\n"		\
+	"5:	mov %[r], %[e]				\n"		\
+	"	jmpi 4b					\n"		\
+	"	.previous				\n"		\
+	"	.section __ex_table,\"a\"		\n"		\
+	"	.balign 4				\n"		\
+	"	.long	1b, 5b				\n"		\
+	"	.long	2b, 5b				\n"		\
+	"	.previous				\n"		\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),				\
+	  [u] "+m" (*uaddr), [t] "=&r" (tmp)				\
+	: [op] "Jr" (oparg), [e] "jr" (-EFAULT)				\
+	: "memory");							\
+									\
+	__atomic_post_full_fence();					\
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("mov %[t], %[ov]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 val, tmp;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	__atomic_pre_full_fence();
+
+	__asm__ __volatile__ (
+	"1:	ldex.w	%[v], %[u]			\n"
+	"	cmpne	%[v], %[ov]			\n"
+	"	bt	4f				\n"
+	"	mov	%[t], %[nv]			\n"
+	"2:	stex.w	%[t], %[u]			\n"
+	"	bez	%[t], 1b			\n"
+	"4:						\n"
+	"	.section .fixup,\"ax\"			\n"
+	"	.balign 4				\n"
+	"5:	mov %[r], %[e]				\n"
+	"	jmpi 4b					\n"
+	"	.previous				\n"
+	"	.section __ex_table,\"a\"		\n"
+	"	.balign 4				\n"
+	"	.long	1b, 5b				\n"
+	"	.long	2b, 5b				\n"
+	"	.previous				\n"
+	: [r] "+r" (ret), [v] "=&r" (val), [u] "+m" (*uaddr),
+	  [t] "=&r" (tmp)
+	: [ov] "Jr" (oldval), [nv] "Jr" (newval), [e] "Jr" (-EFAULT)
+	: "memory");
+
+	__atomic_post_full_fence();
+
+	*uval = val;
+	return ret;
+}
+
+#endif /* CONFIG_SMP */
+#endif /* __ASM_CSKY_FUTEX_H */
-- 
2.7.4

