Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65F4F63A7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiDFPjW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiDFPir (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 11:38:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992DB36B0;
        Wed,  6 Apr 2022 05:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC0AB82275;
        Wed,  6 Apr 2022 12:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEBC385A1;
        Wed,  6 Apr 2022 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649249691;
        bh=DfOgWxb3N9DOiQt9BDMl0FbPyPLPnEL6bZAkQrm703o=;
        h=From:To:Cc:Subject:Date:From;
        b=YgMzzR1nKE4E3uq4IQUFQ/pojxpn4HAUaU8XrnZucIxXGhCDqWTnTukaLA8kl8wkt
         VgpDFBxUbKykIvV7uEwWk9rzH2PVcMr7KhugMLnoP8wyzNrTklWFwylU30JMrwiGUe
         8NNQS49qfplBYrSTV1c9n357Y+t2F/Zdzb6gWQJxxtUJ4vIjGsUnzhh8441ThQdxzJ
         0GFG8xJiDpPo/qIOzSKW7afax6MKD7G/AgrHdrKWW9gSqB6o0B3ypdvzS5ZBwyyqrp
         ee2PhtFZss/TmqZeKG9M9MJOSt1YaD2CeLC6DYCJkuks7YsMY645KzNoxKAMX1T36B
         /3oV/+Gi3ELtw==
From:   guoren@kernel.org
To:     arnd@arndb.de, mark.rutland@arm.com, peterz@infradead.org
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] csky: atomic: Add custom atomic.h implementation
Date:   Wed,  6 Apr 2022 20:54:36 +0800
Message-Id: <20220406125436.685264-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/atomic.h | 251 +++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)
 create mode 100644 arch/csky/include/asm/atomic.h

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
new file mode 100644
index 000000000000..3157df8ad555
--- /dev/null
+++ b/arch/csky/include/asm/atomic.h
@@ -0,0 +1,251 @@
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
+}									\
+static __always_inline							\
+int arch_atomic_fetch_##op##_acquire(int i, atomic_t *v)		\
+{									\
+	register int ret, tmp;						\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w		%0, (%3) \n"				\
+	ACQUIRE_FENCE							\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	stex.w		%0, (%3) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (I), "r"(&v->counter) 				\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+int arch_atomic_fetch_##op##_release(int i, atomic_t *v)		\
+{									\
+	register int ret, tmp;						\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w		%0, (%3) \n"				\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	RELEASE_FENCE							\
+	"	stex.w		%0, (%3) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (I), "r"(&v->counter) 				\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+int arch_atomic_fetch_##op(int i, atomic_t *v)				\
+{									\
+	register int ret, tmp;						\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w		%0, (%3) \n"				\
+	ACQUIRE_FENCE							\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	RELEASE_FENCE							\
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
+}									\
+static __always_inline							\
+int arch_atomic_##op##_return_acquire(int i, atomic_t *v)		\
+{									\
+        return arch_atomic_fetch_##op##_relaxed(i, v) c_op I;		\
+}									\
+static __always_inline							\
+int arch_atomic_##op##_return_release(int i, atomic_t *v)		\
+{									\
+        return arch_atomic_fetch_##op##_release(i, v) c_op I;		\
+}									\
+static __always_inline							\
+int arch_atomic_##op##_return(int i, atomic_t *v)			\
+{									\
+        return arch_atomic_fetch_##op(i, v) c_op I;			\
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
+#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add_acquire
+#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub_acquire
+#define arch_atomic_fetch_add_release	arch_atomic_fetch_add_release
+#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub_release
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
+
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_add_return_acquire	arch_atomic_add_return_acquire
+#define arch_atomic_sub_return_acquire	arch_atomic_sub_return_acquire
+#define arch_atomic_add_return_release	arch_atomic_add_return_release
+#define arch_atomic_sub_return_release	arch_atomic_sub_return_release
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_sub_return		arch_atomic_sub_return
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
+#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and_acquire
+#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or_acquire
+#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor_acquire
+#define arch_atomic_fetch_and_release	arch_atomic_fetch_and_release
+#define arch_atomic_fetch_or_release	arch_atomic_fetch_or_release
+#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor_release
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
+
+#undef ATOMIC_OPS
+
+#undef ATOMIC_FETCH_OP
+
+#define ATOMIC_OP(size)							\
+static __always_inline							\
+int arch_atomic_xchg_relaxed(atomic_t *v, int n)			\
+{									\
+	return __xchg_relaxed(n, &(v->counter), size);			\
+}									\
+static __always_inline							\
+int arch_atomic_xchg_acquire(atomic_t *v, int n)			\
+{									\
+	return __xchg_acquire(n, &(v->counter), size);			\
+}									\
+static __always_inline							\
+int arch_atomic_xchg_release(atomic_t *v, int n)			\
+{									\
+	return __xchg_release(n, &(v->counter), size);			\
+}									\
+static __always_inline							\
+int arch_atomic_xchg(atomic_t *v, int n)				\
+{									\
+	return __xchg(n, &(v->counter), size);				\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_relaxed(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_acquire(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg_release(atomic_t *v, int o, int n)		\
+{									\
+	return __cmpxchg_release(&(v->counter), o, n, size);		\
+}									\
+static __always_inline							\
+int arch_atomic_cmpxchg(atomic_t *v, int o, int n)			\
+{									\
+	return __cmpxchg(&(v->counter), o, n, size);			\
+}
+
+#define ATOMIC_OPS()							\
+	ATOMIC_OP(4)
+
+ATOMIC_OPS()
+
+#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire	arch_atomic_xchg_acquire
+#define arch_atomic_xchg_release	arch_atomic_xchg_release
+#define arch_atomic_xchg		arch_atomic_xchg
+#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
+#define arch_atomic_cmpxchg_release	arch_atomic_cmpxchg_release
+#define arch_atomic_cmpxchg		arch_atomic_cmpxchg
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

