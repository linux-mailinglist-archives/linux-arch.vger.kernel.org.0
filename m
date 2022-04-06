Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4714F6356
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiDFPcK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiDFPb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 11:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6E58E576;
        Wed,  6 Apr 2022 05:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F29561AE9;
        Wed,  6 Apr 2022 12:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A26C385A1;
        Wed,  6 Apr 2022 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649248967;
        bh=n0Gx6rXzEJ5x8PHVVo2FUk8hi6eJH5i6TOhLchywSr4=;
        h=From:To:Cc:Subject:Date:From;
        b=WnPF/XBAaH6laxmBiLvDB7e5XpQFJgKigQMRBC2pzkXW1l44ggbHQEWeojJC5Q9Sa
         nKXLfAFkWzki81esvq+ld0VdJ3j00lcFElQYUYoN1uZ5LPIC1d5PL8Kw8RmoSgSETx
         E+h4VtAoUGiyCtC3968pxNT3SVB/9jgm+PQKiDJ3JPZdhTiobcJrx86fvW0iN/lGce
         kDk7KtcA31cH6ENmNd4mWIqIdnjrOcaBO2ZK8546uC41eYzZ3mOrBrfPPbPJyLG/ru
         XAAzruNaRCHiEqBAy7HHHQTIrXNGrHzgp2ks9mlj/t/pDWdr1OXc/9hIMJINv/XXkH
         /C3yAUVOE2yGA==
From:   guoren@kernel.org
To:     arnd@arndb.de, mark.rutland@arm.com, peterz@infradead.org
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] csky: cmpxchg: Optimize with acquire & release
Date:   Wed,  6 Apr 2022 20:40:56 +0800
Message-Id: <20220406124056.684117-1-guoren@kernel.org>
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

Optimize arch_xchg|cmpxchg|cmpxchg_local with  ASM acquire|release
instructions instead of previous C based.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/barrier.h |   8 +-
 arch/csky/include/asm/cmpxchg.h | 173 ++++++++++++++++++++++++++++++--
 2 files changed, 172 insertions(+), 9 deletions(-)

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
index d1bef11f8dc9..7baf9a706b5b 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -30,10 +30,88 @@ extern void __bad_xchg(void);
 	}							\
 	__ret;							\
 })
-
 #define arch_xchg_relaxed(ptr, x) \
 		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
+#define __xchg_acquire(new, ptr, size)				\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	unsigned long tmp;					\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		ACQUIRE_FENCE					\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(__ptr)		\
+			:);					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+#define arch_xchg_acquire(ptr, x) \
+		(__xchg_acquire((x), (ptr), sizeof(*(ptr))))
+
+#define __xchg_release(new, ptr, size)				\
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
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+#define arch_xchg_release(ptr, x) \
+		(__xchg_release((x), (ptr), sizeof(*(ptr))))
+
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
+		ACQUIRE_FENCE					\
+		"	mov		%1, %2   \n"		\
+		RELEASE_FENCE					\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(__ptr)		\
+			:);					\
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
@@ -60,19 +138,102 @@ extern void __bad_xchg(void);
 	}							\
 	__ret;							\
 })
-
 #define arch_cmpxchg_relaxed(ptr, o, n) \
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define arch_cmpxchg(ptr, o, n) 				\
+#define __cmpxchg_acquire(ptr, old, new, size)			\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		ACQUIRE_FENCE					\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
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
+#define arch_cmpxchg_acquire(ptr, o, n) \
+	(__cmpxchg_acquire((ptr), (o), (n), sizeof(*(ptr))))
+
+#define __cmpxchg_release(ptr, old, new, size)			\
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
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
 	__ret;							\
 })
+#define arch_cmpxchg_release(ptr, o, n) \
+	(__cmpxchg_release((ptr), (o), (n), sizeof(*(ptr))))
 
+#define __cmpxchg(ptr, old, new, size)				\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		ACQUIRE_FENCE					\
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
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+#define arch_cmpxchg(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+
+#define arch_cmpxchg_local(ptr, o, n)				\
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.25.1

