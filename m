Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A74FBF97
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbiDKOyZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiDKOyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 10:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF281B9;
        Mon, 11 Apr 2022 07:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A27BEB81649;
        Mon, 11 Apr 2022 14:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4570CC385AA;
        Mon, 11 Apr 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688725;
        bh=7Herwyg859Hm73dHIXsR7AzUXkxBAZbVYjJ8KndKbEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMKZFyWcYa5eVqFZ4MEbslDV47qw5MoxOzKnY0cLLPg4s/iqGYYJqLKIMwOggfFha
         N+jImHG9ackDKQuvf06YoeVarLm9yd3FQykaO1yZJtLKY5JT3bssvCUbtuedCy0mbq
         0RG3q5Ptb8JC6OXVkBAWfwM+8YwIcsryEDwFq8XX3kYCFRjoNuQHxhOVvSnVTWDKjp
         85jwidY1YWNoIoHSX5LgBiMQTLEfAIUJUmgD7q7/3IueIpro+6Ike2SJ8lhk0RUbsc
         g2vfEyUUJk1qnQK8mNRt/z972Jy7Ho9DySakr5VUcDLYfZMRsBPzVgYvKnQSzDeFsh
         Cth36Iz5bWbeQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 1/2] csky: cmpxchg: Optimize with acquire & release
Date:   Mon, 11 Apr 2022 22:51:45 +0800
Message-Id: <20220411145146.920314-2-guoren@kernel.org>
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

Optimize arch_xchg|cmpxchg|cmpxchg_local with  ASM acquire|release
instructions instead of previous C based.

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
 arch/csky/include/asm/barrier.h |  8 +++--
 arch/csky/include/asm/cmpxchg.h | 61 +++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index f4045dd53e17..a075f17d02dd 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -37,6 +37,9 @@
  * bar.brar
  * bar.bwaw
  */
+#define ACQUIRE_FENCE		".long 0x8427c000\n"
+#define RELEASE_FENCE		".long 0x842ec000\n"
+
 #define __bar_brw()	asm volatile (".long 0x842cc000\n":::"memory")
 #define __bar_br()	asm volatile (".long 0x8424c000\n":::"memory")
 #define __bar_bw()	asm volatile (".long 0x8428c000\n":::"memory")
@@ -44,10 +47,10 @@
 #define __bar_ar()	asm volatile (".long 0x8421c000\n":::"memory")
 #define __bar_aw()	asm volatile (".long 0x8422c000\n":::"memory")
 #define __bar_brwarw()	asm volatile (".long 0x842fc000\n":::"memory")
-#define __bar_brarw()	asm volatile (".long 0x8427c000\n":::"memory")
+#define __bar_brarw()	asm volatile (ACQUIRE_FENCE:::"memory")
 #define __bar_bwarw()	asm volatile (".long 0x842bc000\n":::"memory")
 #define __bar_brwar()	asm volatile (".long 0x842dc000\n":::"memory")
-#define __bar_brwaw()	asm volatile (".long 0x842ec000\n":::"memory")
+#define __bar_brwaw()	asm volatile (RELEASE_FENCE:::"memory")
 #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
 #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
 #define __bar_bwaw()	asm volatile (".long 0x842ac000\n":::"memory")
@@ -56,7 +59,6 @@
 #define __smp_rmb()	__bar_brar()
 #define __smp_wmb()	__bar_bwaw()
 
-#define ACQUIRE_FENCE		".long 0x8427c000\n"
 #define __smp_acquire_fence()	__bar_brarw()
 #define __smp_release_fence()	__bar_brwaw()
 
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index d1bef11f8dc9..1a6f2f445c12 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -30,10 +30,36 @@ extern void __bad_xchg(void);
 	}							\
 	__ret;							\
 })
-
 #define arch_xchg_relaxed(ptr, x) \
 		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
+#define __xchg(new, ptr, size)					\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	unsigned long tmp;					\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	mov		%1, %2   \n"		\
+		RELEASE_FENCE					\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(__ptr)		\
+			:);					\
+		__smp_mb();					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+#define arch_xchg(ptr, x) \
+		(__xchg((x), (ptr), sizeof(*(ptr))))
+
 #define __cmpxchg_relaxed(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
@@ -60,19 +86,42 @@ extern void __bad_xchg(void);
 	}							\
 	__ret;							\
 })
-
 #define arch_cmpxchg_relaxed(ptr, o, n) \
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define arch_cmpxchg(ptr, o, n) 				\
+#define __cmpxchg(ptr, old, new, size)				\
 ({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
-	__smp_release_fence();					\
-	__ret = arch_cmpxchg_relaxed(ptr, o, n);		\
-	__smp_acquire_fence();					\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		RELEASE_FENCE					\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		"2:				 \n"		\
+			: "=&r" (__ret), "=&r" (__tmp)		\
+			: "r" (__new), "r"(__ptr), "r"(__old)	\
+			:);					\
+		__smp_mb();					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
 	__ret;							\
 })
+#define arch_cmpxchg(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
 
+#define arch_cmpxchg_local(ptr, o, n)				\
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.25.1

