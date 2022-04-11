Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968414FBF96
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347514AbiDKOyZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347512AbiDKOyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 10:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D425C59;
        Mon, 11 Apr 2022 07:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E33614E6;
        Mon, 11 Apr 2022 14:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D401EC385A3;
        Mon, 11 Apr 2022 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688727;
        bh=Xp4ImSPeb4qq8tniBlGX8vZ2MFgbMYplDHWI2bqxnkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmkUiwXvapVmxGSNyBvfQjv4TwbHGUcnjk4WETPxl9xcN0UBbZobAqe7Gpqm0Hnab
         EcMYO57RZicU4J8cmn1BhCrUrvSSckwVfmUhShBQWH60BM2sA2I3zAZChZfjPfwFQP
         qd753P1n3EMlzukt/SAajseHpXxZVfIx4u5hatQapwRZBtrckqVEU2CDsLCLEWzc/y
         gJHKxq+dP3VmraCG2LNwLtfsO0A8aYSy5EmZVq3EGjjlfphXC9NnSXzTlQUIO4VBcf
         dPP0d5HMwE7ZjXdcaJqxM2D0/PDjEHyMyNO5zOWpyMcoQk5sychnTD+06L+nhL5Ysd
         7EFpn+bIsJqzA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/2] csky: atomic: Add custom atomic.h implementation
Date:   Mon, 11 Apr 2022 22:51:46 +0800
Message-Id: <20220411145146.920314-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411145146.920314-1-guoren@kernel.org>
References: <20220411145146.920314-1-guoren@kernel.org>
MIME-Version: 1.0
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

The generic atomic.h used cmpxchg to implement the atomic
operations, it will cause daul loop to reduce the forward
guarantee. The patch implement csky custom atomic operations with
ldex/stex instructions for the best performance.

Important reference comment by Rutland:
8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
full barrier semantics")

Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2683f8a181d6c3
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
Changes in V2:
 - Fixup use of acquire + release for barrier semantics by Rutland.
---
 arch/csky/include/asm/atomic.h | 130 +++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 arch/csky/include/asm/atomic.h

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
new file mode 100644
index 000000000000..2e1a22f55ea1
--- /dev/null
+++ b/arch/csky/include/asm/atomic.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_ATOMIC_H
+#define __ASM_CSKY_ATOMIC_H
+
+#ifdef CONFIG_SMP
+# include <asm-generic/atomic64.h>
+
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#define __atomic_acquire_fence()	__smp_acquire_fence()
+
+#define __atomic_release_fence()	__smp_release_fence()
+
+static __always_inline int arch_atomic_read(const atomic_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+static __always_inline void arch_atomic_set(atomic_t *v, int i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+#define ATOMIC_OP(op, asm_op, I)					\
+static __always_inline							\
+void arch_atomic_##op(int i, atomic_t *v)				\
+{									\
+	unsigned long tmp;						\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w		%0, (%2)	\n"			\
+	"	" #op "		%0, %1		\n"			\
+	"	stex.w		%0, (%2)	\n"			\
+	"	bez		%0, 1b		\n"			\
+	: "=&r" (tmp)							\
+	: "r" (I), "r" (&v->counter)					\
+	: "memory");							\
+}
+
+ATOMIC_OP(add, add,  i)
+ATOMIC_OP(sub, add, -i)
+ATOMIC_OP(and, and,  i)
+ATOMIC_OP( or,  or,  i)
+ATOMIC_OP(xor, xor,  i)
+
+#undef ATOMIC_OP
+
+#define ATOMIC_FETCH_OP(op, asm_op, I)					\
+static __always_inline							\
+int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)		\
+{									\
+	register int ret, tmp;						\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w		%0, (%3) \n"				\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	stex.w		%0, (%3) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (I), "r"(&v->counter) 				\
+		: "memory");						\
+	return ret;							\
+}
+
+#define ATOMIC_OP_RETURN(op, asm_op, c_op, I)				\
+static __always_inline							\
+int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)		\
+{									\
+        return arch_atomic_fetch_##op##_relaxed(i, v) c_op I;		\
+}
+
+#define ATOMIC_OPS(op, asm_op, c_op, I)					\
+        ATOMIC_FETCH_OP( op, asm_op,       I)				\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I)
+
+ATOMIC_OPS(add, add, +,  i)
+ATOMIC_OPS(sub, add, +, -i)
+
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP_RETURN
+
+#define ATOMIC_OPS(op, asm_op, I)					\
+        ATOMIC_FETCH_OP(op, asm_op, I)
+
+ATOMIC_OPS(and, and, i)
+ATOMIC_OPS( or,  or, i)
+ATOMIC_OPS(xor, xor, i)
+
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+
+#undef ATOMIC_OPS
+
+#undef ATOMIC_FETCH_OP
+
+#define ATOMIC_OP()							\
+static __always_inline							\
+int arch_atomic_xchg_relaxed(atomic_t *v, int n)			\
+{									\
+	return __xchg_relaxed(n, &(v->counter), 4);			\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_relaxed(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_relaxed(&(v->counter), o, n, 4);		\
+}
+
+#define ATOMIC_OPS()							\
+	ATOMIC_OP()
+
+ATOMIC_OPS()
+
+#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
+#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP
+
+#else
+# include <asm-generic/atomic.h>
+#endif
+
+#endif /* __ASM_CSKY_ATOMIC_H */
-- 
2.25.1

