Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB950D03A
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiDXHcr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiDXHco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 03:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EA151868;
        Sun, 24 Apr 2022 00:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21E9612FF;
        Sun, 24 Apr 2022 07:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2AFC385B1;
        Sun, 24 Apr 2022 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650785383;
        bh=rk4+4zbLu6epppwE4WRbBhd3KaAhjfLplCUb8DsR/0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maI4dy3txuTIlTp12VhWrkJqf4Q2kXf50o6qzRDipwCRtRxdMi5EGsLqmLXGNWxSe
         DRwL1uqb+YDJJMsRfjHp1/wwSVzfme+sij4aaFWWgKtBCQyuZ4PZTCbJkv8sErUVBe
         zUD68Co8XO3b2J8Jbcp8kVYdX8BI79hcYIO0lGlctfuYZsiZEaJQ9YUh+RgZWadVo4
         CIauvWLbcafUpqoD9G+Jm4n+rBmEqGVVsVxOqwmLdjRtjdHIWggj40/wFjmgt2gWBy
         r6khlE2b+CkXPnJd9yW+sGlNkwfGz1UNpU8KDUoCaek+n/Uk9h9qx1RzoxYdrqt3yD
         m495G7bFCk8ww==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 1/3] csky: atomic: Optimize cmpxchg with acquire & release
Date:   Sun, 24 Apr 2022 15:29:16 +0800
Message-Id: <20220424072918.2596899-2-guoren@kernel.org>
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

Optimize cmpxchg with ASM acquire/release fence ASM instructions
instead of previous generic based. Prevent a fence when cmxchg's
first load != old.

Comments by Rutland:

8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
full barrier semantics")

Comments by Boqun:

FWIW, you probably need to make sure that a barrier instruction inside
an lr/sc loop is a good thing. IIUC, the execution time of a barrier
instruction is determined by the status of store buffers and invalidate
queues (and probably other stuffs), so it may increase the execution
time of the lr/sc loop, and make it unlikely to succeed. But this really
depends on how the arch executes these instructions.

Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2683f8a181d6c3
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/csky/include/asm/barrier.h | 11 +++---
 arch/csky/include/asm/cmpxchg.h | 64 ++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index f4045dd53e17..15de58b10aec 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -37,17 +37,21 @@
  * bar.brar
  * bar.bwaw
  */
+#define FULL_FENCE		".long 0x842fc000\n"
+#define ACQUIRE_FENCE		".long 0x8427c000\n"
+#define RELEASE_FENCE		".long 0x842ec000\n"
+
 #define __bar_brw()	asm volatile (".long 0x842cc000\n":::"memory")
 #define __bar_br()	asm volatile (".long 0x8424c000\n":::"memory")
 #define __bar_bw()	asm volatile (".long 0x8428c000\n":::"memory")
 #define __bar_arw()	asm volatile (".long 0x8423c000\n":::"memory")
 #define __bar_ar()	asm volatile (".long 0x8421c000\n":::"memory")
 #define __bar_aw()	asm volatile (".long 0x8422c000\n":::"memory")
-#define __bar_brwarw()	asm volatile (".long 0x842fc000\n":::"memory")
-#define __bar_brarw()	asm volatile (".long 0x8427c000\n":::"memory")
+#define __bar_brwarw()	asm volatile (FULL_FENCE:::"memory")
+#define __bar_brarw()	asm volatile (ACQUIRE_FENCE:::"memory")
 #define __bar_bwarw()	asm volatile (".long 0x842bc000\n":::"memory")
 #define __bar_brwar()	asm volatile (".long 0x842dc000\n":::"memory")
-#define __bar_brwaw()	asm volatile (".long 0x842ec000\n":::"memory")
+#define __bar_brwaw()	asm volatile (RELEASE_FENCE:::"memory")
 #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
 #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
 #define __bar_bwaw()	asm volatile (".long 0x842ac000\n":::"memory")
@@ -56,7 +60,6 @@
 #define __smp_rmb()	__bar_brar()
 #define __smp_wmb()	__bar_bwaw()
 
-#define ACQUIRE_FENCE		".long 0x8427c000\n"
 #define __smp_acquire_fence()	__bar_brarw()
 #define __smp_release_fence()	__bar_brwaw()
 
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index d1bef11f8dc9..5b8faccd65e4 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -64,15 +64,71 @@ extern void __bad_xchg(void);
 #define arch_cmpxchg_relaxed(ptr, o, n) \
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define arch_cmpxchg(ptr, o, n) 				\
+#define __cmpxchg_acquire(ptr, old, new, size)			\
 ({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		ACQUIRE_FENCE					\
+		"2:				 \n"		\
+			: "=&r" (__ret), "=&r" (__tmp)		\
+			: "r" (__new), "r"(__ptr), "r"(__old)	\
+			:);					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+
+#define arch_cmpxchg_acquire(ptr, o, n) \
+	(__cmpxchg_acquire((ptr), (o), (n), sizeof(*(ptr))))
+
+#define __cmpxchg(ptr, old, new, size)				\
+({								\
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
+		RELEASE_FENCE					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		FULL_FENCE					\
+		"2:				 \n"		\
+			: "=&r" (__ret), "=&r" (__tmp)		\
+			: "r" (__new), "r"(__ptr), "r"(__old)	\
+			:);					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
 	__ret;							\
 })
 
+#define arch_cmpxchg(ptr, o, n)					\
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+
+#define arch_cmpxchg_local(ptr, o, n)				\
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.25.1

