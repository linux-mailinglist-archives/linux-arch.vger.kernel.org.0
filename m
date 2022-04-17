Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7150471E
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiDQIfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDQIfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 04:35:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256022BDA;
        Sun, 17 Apr 2022 01:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EFC3B80AB8;
        Sun, 17 Apr 2022 08:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EDFC385A7;
        Sun, 17 Apr 2022 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650184346;
        bh=aYiZYeIshnaSiZ6d6WBe6NcWpMN/JFn2nH/bghcbAaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjSisn4tVGQ4eatVm6Skl2PcP6CCR8C8jmNBiGk+SSV/D7u5GjlsBzO7+YkF1bl30
         n5C0IHtxazOKC1Q+84ZKAjVpxPiWPa2Aqw/00eS7Ulr8EeCYmt9I48bp375sqdslxl
         wVnmnTN5MwKMz73FGYR8IGvFTF9Tr7kJymvnPgbTHIph6K7NM5tpeFHFc9AKUBhPDo
         htqPxLkjNQZo9g6zUJfpIRrd6vzLft/fEc5XJFXlJmH8Ye9MxvjWmAEi3Kmp/rZXgD
         srp0pAgRVKoP6KGEDRS1KSu8i3oMqQWMAHmUlukx8d0ycxF5UEbrrXHhMT4NkCP57A
         rYnmQp3Uzn8Nw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 2/3] csky: atomic: Add custom atomic.h implementation
Date:   Sun, 17 Apr 2022 16:32:03 +0800
Message-Id: <20220417083204.2048364-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417083204.2048364-1-guoren@kernel.org>
References: <20220417083204.2048364-1-guoren@kernel.org>
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
 arch/csky/include/asm/atomic.h | 154 +++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 arch/csky/include/asm/atomic.h

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
new file mode 100644
index 000000000000..5ecc657a2a66
--- /dev/null
+++ b/arch/csky/include/asm/atomic.h
@@ -0,0 +1,154 @@
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
+}									\
+static __always_inline							\
+int arch_atomic_##op##_return(int i, atomic_t *v)			\
+{									\
+	return arch_atomic_fetch_##op(i, v) c_op i;			\
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
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_sub_return		arch_atomic_sub_return
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
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
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
+int arch_atomic_xchg(atomic_t *v, int n)				\
+{									\
+	return __xchg(n, &(v->counter), 4);				\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_relaxed(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_relaxed(&(v->counter), o, n, 4);		\
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
+#define arch_atomic_xchg		arch_atomic_xchg
+#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
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

