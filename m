Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE158C3D2
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiHHHPx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiHHHPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F112A9F;
        Mon,  8 Aug 2022 00:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC73860D24;
        Mon,  8 Aug 2022 07:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB243C433D6;
        Mon,  8 Aug 2022 07:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942893;
        bh=m7BB6dE2TLg0BfE1G3bhADCM2Cpp+bpUD503eZJTSow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFLyADkxN57udyvW/wSHNAj4DiqaQ2FY56CZ1wParcPOZHb/kjXXLdhhlK08AW+W2
         HKxgDweL8jQvu0EUGxHdTQJxYflSB8E1Vz/mKRScGy5JXhkLkTbXjwbbMRnfxBMo3o
         TgPH/0bfzn8hdLwOnwcLLAtDRoFsizdejk5yz7NKLTHWdwHfViQN8fj3swkHzM/Zfr
         YgJvWX8dHlZVp1hU+bDhIZECL1tv1PiMLyeX1CjdQOQRZduy92a/j3k7UUccxer3my
         ywTCOtqmibJ5uKZSobJ/uCSzV/Wot6TqaVGAjb2MWe4PuG96L33SQcEXRZBfyFlTuF
         y9YmF8pdVFMQQ==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH V9 13/15] openrisc: cmpxchg: Cleanup unnecessary codes
Date:   Mon,  8 Aug 2022 03:13:16 -0400
Message-Id: <20220808071318.3335746-14-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808071318.3335746-1-guoren@kernel.org>
References: <20220808071318.3335746-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove cmpxchg_small and xchg_small, because it's unnecessary now, and
they break the forward guarantee for atomic operations.

Also Remove unnecessary __HAVE_ARCH_CMPXCHG.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
---
 arch/openrisc/include/asm/cmpxchg.h | 167 +++++++++-------------------
 1 file changed, 50 insertions(+), 117 deletions(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 79fd16162ccb..df83b33b5882 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -20,10 +20,8 @@
 #include  <linux/compiler.h>
 #include  <linux/types.h>
 
-#define __HAVE_ARCH_CMPXCHG 1
-
-static inline unsigned long cmpxchg_u32(volatile void *ptr,
-		unsigned long old, unsigned long new)
+/* cmpxchg */
+static inline u32 cmpxchg32(volatile void *ptr, u32 old, u32 new)
 {
 	__asm__ __volatile__(
 		"1:	l.lwa %0, 0(%1)		\n"
@@ -41,8 +39,33 @@ static inline unsigned long cmpxchg_u32(volatile void *ptr,
 	return old;
 }
 
-static inline unsigned long xchg_u32(volatile void *ptr,
-		unsigned long val)
+#define __cmpxchg(ptr, old, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __new = (new);				\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__ret = (__typeof__(*(ptr)))				\
+			cmpxchg32(__ptr, (u32)__old, (u32)__new);	\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define arch_cmpxchg(ptr, o, n)						\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
+				       _o_, _n_, sizeof(*(ptr)));	\
+})
+
+/* xchg */
+static inline u32 xchg32(volatile void *ptr, u32 val)
 {
 	__asm__ __volatile__(
 		"1:	l.lwa %0, 0(%1)		\n"
@@ -56,116 +79,26 @@ static inline unsigned long xchg_u32(volatile void *ptr,
 	return val;
 }
 
-static inline u32 cmpxchg_small(volatile void *ptr, u32 old, u32 new,
-				int size)
-{
-	int off = (unsigned long)ptr % sizeof(u32);
-	volatile u32 *p = ptr - off;
-#ifdef __BIG_ENDIAN
-	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
-#else
-	int bitoff = off * BITS_PER_BYTE;
-#endif
-	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
-	u32 load32, old32, new32;
-	u32 ret;
-
-	load32 = READ_ONCE(*p);
-
-	while (true) {
-		ret = (load32 & bitmask) >> bitoff;
-		if (old != ret)
-			return ret;
-
-		old32 = (load32 & ~bitmask) | (old << bitoff);
-		new32 = (load32 & ~bitmask) | (new << bitoff);
-
-		/* Do 32 bit cmpxchg */
-		load32 = cmpxchg_u32(p, old32, new32);
-		if (load32 == old32)
-			return old;
-	}
-}
-
-/* xchg */
-
-static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
-{
-	int off = (unsigned long)ptr % sizeof(u32);
-	volatile u32 *p = ptr - off;
-#ifdef __BIG_ENDIAN
-	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
-#else
-	int bitoff = off * BITS_PER_BYTE;
-#endif
-	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
-	u32 oldv, newv;
-	u32 ret;
-
-	do {
-		oldv = READ_ONCE(*p);
-		ret = (oldv & bitmask) >> bitoff;
-		newv = (oldv & ~bitmask) | (x << bitoff);
-	} while (cmpxchg_u32(p, oldv, newv) != oldv);
-
-	return ret;
-}
-
-/*
- * This function doesn't exist, so you'll get a linker error
- * if something tries to do an invalid cmpxchg().
- */
-extern unsigned long __cmpxchg_called_with_bad_pointer(void)
-	__compiletime_error("Bad argument size for cmpxchg");
-
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-		unsigned long new, int size)
-{
-	switch (size) {
-	case 1:
-	case 2:
-		return cmpxchg_small(ptr, old, new, size);
-	case 4:
-		return cmpxchg_u32(ptr, old, new);
-	default:
-		return __cmpxchg_called_with_bad_pointer();
-	}
-}
-
-#define arch_cmpxchg(ptr, o, n)						\
-	({								\
-		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
-					       (unsigned long)(o),	\
-					       (unsigned long)(n),	\
-					       sizeof(*(ptr)));		\
-	})
-
-/*
- * This function doesn't exist, so you'll get a linker error if
- * something tries to do an invalidly-sized xchg().
- */
-extern unsigned long __xchg_called_with_bad_pointer(void)
-	__compiletime_error("Bad argument size for xchg");
-
-static inline unsigned long __xchg(volatile void *ptr, unsigned long with,
-		int size)
-{
-	switch (size) {
-	case 1:
-	case 2:
-		return xchg_small(ptr, with, size);
-	case 4:
-		return xchg_u32(ptr, with);
-	default:
-		return __xchg_called_with_bad_pointer();
-	}
-}
-
-#define arch_xchg(ptr, with) 						\
-	({								\
-		(__typeof__(*(ptr))) __xchg((ptr),			\
-					    (unsigned long)(with),	\
-					    sizeof(*(ptr)));		\
-	})
+#define __xchg(ptr, new, size)						\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	switch (size) {							\
+	case 4:								\
+		__ret = (__typeof__(*(ptr)))				\
+			xchg32(__ptr, (u32)__new);			\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define arch_xchg(ptr, x)						\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
+})
 
 #endif /* __ASM_OPENRISC_CMPXCHG_H */
-- 
2.36.1

