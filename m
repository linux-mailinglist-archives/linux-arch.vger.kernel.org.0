Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4450D03E
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiDXHcw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbiDXHcs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 03:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E770F151F4B;
        Sun, 24 Apr 2022 00:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F19861305;
        Sun, 24 Apr 2022 07:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC45C385AC;
        Sun, 24 Apr 2022 07:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650785386;
        bh=FQV8N0eLk4AtQ1VH8mq3+se93l+0KbFwvJtFQphXmxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSeeL9QRrlImtNcEzsT/DeqqmU+ixGcecS4w8gnug0ve9xyoL1qgfv+S54+86tC/7
         jU/sx1b+27bi6lhpl5XZ8iUYHYb5THPqdqfCVRH8IB72bwamebNAxWkf4yGUUmkR8R
         LD4a6yD8ukXt1I55I0Ih5+CUx39GAsAjOT++bfuho6kPTzV5e5XCLrwigFnclnqssD
         3snud2iqCV/shdF/F8QhieWIZrcxxgHLl8Q2tcCS2UuDbgCTZHhA/mBCvpGcn1vh0l
         lpfQO4ayZw714G4stlGT6EjcBPbYlxiHt9sJRep7zy03vZP/q6HLx4V0stRVcaWw+8
         Gnom9vN0SfzsA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 2/3] csky: atomic: Add custom atomic.h implementation
Date:   Sun, 24 Apr 2022 15:29:17 +0800
Message-Id: <20220424072918.2596899-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424072918.2596899-1-guoren@kernel.org>
References: <20220424072918.2596899-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Important comment by Rutland:
8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
full barrier semantics")

Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2683f8a181d6c3
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/csky/include/asm/atomic.h | 142 +++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 arch/csky/include/asm/atomic.h

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
new file mode 100644
index 000000000000..56c9dc8e91b3
--- /dev/null
+++ b/arch/csky/include/asm/atomic.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_ATOMIC_H
+#define __ASM_CSKY_ATOMIC_H
+
+#ifdef CONFIG_SMP
+#include <asm-generic/atomic64.h>
+
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#define __atomic_acquire_fence()	__bar_brarw()
+
+#define __atomic_release_fence()	__bar_brwaw()
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
+#define ATOMIC_OP(op)							\
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
+	: "r" (i), "r" (&v->counter)					\
+	: "memory");							\
+}
+
+ATOMIC_OP(add)
+ATOMIC_OP(sub)
+ATOMIC_OP(and)
+ATOMIC_OP( or)
+ATOMIC_OP(xor)
+
+#undef ATOMIC_OP
+
+#define ATOMIC_FETCH_OP(op)						\
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
+		: "r" (i), "r"(&v->counter) 				\
+		: "memory");						\
+	return ret;							\
+}
+
+#define ATOMIC_OP_RETURN(op, c_op)					\
+static __always_inline							\
+int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)		\
+{									\
+	return arch_atomic_fetch_##op##_relaxed(i, v) c_op i;		\
+}
+
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_FETCH_OP(op)						\
+	ATOMIC_OP_RETURN(op, c_op)
+
+ATOMIC_OPS(add, +)
+ATOMIC_OPS(sub, -)
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
+#define ATOMIC_OPS(op)							\
+	ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS( or)
+ATOMIC_OPS(xor)
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
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_acquire(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_acquire(&(v->counter), o, n, 4);		\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg(atomic_t *v, int o, int n)			\
+{									\
+	return __cmpxchg(&(v->counter), o, n, 4);			\
+}
+
+#define ATOMIC_OPS()							\
+	ATOMIC_OP()
+
+ATOMIC_OPS()
+
+#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
+#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
+#define arch_atomic_cmpxchg		arch_atomic_cmpxchg
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP
+
+#else
+#include <asm-generic/atomic.h>
+#endif
+
+#endif /* __ASM_CSKY_ATOMIC_H */
-- 
2.25.1

