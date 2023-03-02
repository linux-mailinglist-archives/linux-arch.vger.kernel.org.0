Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518D6A7D2E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCBJAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCBJAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:00:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9A392BC;
        Thu,  2 Mar 2023 01:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DF22B811A1;
        Thu,  2 Mar 2023 09:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3020DC433D2;
        Thu,  2 Mar 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677747638;
        bh=Ebb3ot/MKrEX9PZqTOLwhhuImbtXpjRuOQVB90BniQY=;
        h=From:To:Cc:Subject:Date:From;
        b=cpzf7ma+ctc+LuCj9wJ7uRvZWsBa/ogBWcU5vYxz+PUs1CmIJ2euxkIoy+twdxpxM
         Ed6rzepfq8FUOAHgkagE3ojujl0E1MWtifIWCTxKXKKLi1sFFrkhMnBeH5iQUoOOIt
         MFUSpEPXruw1IEE+h/EpiGHOCFvQ/mrWCJORjGRIA5o4MH5yYv7KHnHPU2LKyKKPpf
         jjzwu6/IJiVnxj/s3GqKTTiypI6o/MK9duqV7aOIDkkJryupHzjk4eGX3F7YmCRnWY
         zbIyv7+WLvsfPatfvzqHDJC1eqPVMqu2pGmLWnwy54EeJt2Mr3pna9i0kXwYcfhuHw
         +WfWCq4yQu/QA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Matt Evans <mev@rivosinc.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: avoid __generic_cmpxchg_local warnings
Date:   Thu,  2 Mar 2023 10:00:22 +0100
Message-Id: <20230302090032.3740505-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Code that passes a 32-bit constant into cmpxchg() produces a harmless
sparse warning because of the truncation in the branch that is not taken:

fs/erofs/zdata.c: note: in included file (through /home/arnd/arm-soc/arch/arm/include/asm/cmpxchg.h, /home/arnd/arm-soc/arch/arm/include/asm/atomic.h, /home/arnd/arm-soc/include/linux/atomic.h, ...):
include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates bits from constant value (5f0ecafe becomes fe)
include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates bits from constant value (5f0ecafe becomes cafe)
include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates bits from constant value (5f0ecafe becomes fe)
include/asm-generic/cmpxchg-local.h:30:42: warning: cast truncates bits from constant value (5f0edead becomes ad)
include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates bits from constant value (5f0ecafe becomes cafe)
include/asm-generic/cmpxchg-local.h:34:44: warning: cast truncates bits from constant value (5f0edead becomes dead)

This was reported as a regression to Matt's recent __generic_cmpxchg_local
patch, though this patch only added more warnings on top of the ones
that were already there.

Rewording the truncation to use an explicit bitmask instead of a cast
to a smaller type avoids the warning but otherwise leaves the code
unchanged.

I had another look at why the cast is even needed for atomic_cmpxchg(),
and as Matt describes the problem here is that atomic_t contains a
signed 'int', but cmpxchg() takes an 'unsigned long' argument, and
converting between the two leads to a 64-bit sign-extension of
negative 32-bit atomics.

I checked the other implementations of arch_cmpxchg() and did not find
any others that run into the same problem as __generic_cmpxchg_local(),
but it's easy to be on the safe side here and always convert the
signed int into an unsigned int when calling arch_cmpxchg(), as this
will work even when any of the arch_cmpxchg() implementations run
into the same problem.

Fixes: 624654152284 ("locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare against zero-extended 'old' value")
Reviewed-by: Matt Evans <mev@rivosinc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/atomic.h        |  4 ++--
 include/asm-generic/cmpxchg-local.h | 12 ++++++------
 include/asm-generic/cmpxchg.h       |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 04b8be9f1a77..e271d6708c87 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -130,7 +130,7 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_read(v)			READ_ONCE((v)->counter)
 #define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
 
-#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
-#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
+#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (u32)(v)))
+#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (u32)(old), (u32)(new)))
 
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index c3e7315b7c1d..3df9f59a544e 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -26,16 +26,16 @@ static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
 	raw_local_irq_save(flags);
 	switch (size) {
 	case 1: prev = *(u8 *)ptr;
-		if (prev == (u8)old)
-			*(u8 *)ptr = (u8)new;
+		if (prev == (old & 0xffu))
+			*(u8 *)ptr = (new & 0xffu);
 		break;
 	case 2: prev = *(u16 *)ptr;
-		if (prev == (u16)old)
-			*(u16 *)ptr = (u16)new;
+		if (prev == (old & 0xffffu))
+			*(u16 *)ptr = (new & 0xffffu);
 		break;
 	case 4: prev = *(u32 *)ptr;
-		if (prev == (u32)old)
-			*(u32 *)ptr = (u32)new;
+		if (prev == (old & 0xffffffffffu))
+			*(u32 *)ptr = (new & 0xffffffffu);
 		break;
 	case 8: prev = *(u64 *)ptr;
 		if (prev == old)
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index dca4419922a9..848de25fc4bf 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -32,7 +32,7 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 #else
 		local_irq_save(flags);
 		ret = *(volatile u8 *)ptr;
-		*(volatile u8 *)ptr = x;
+		*(volatile u8 *)ptr = (x & 0xffu);
 		local_irq_restore(flags);
 		return ret;
 #endif /* __xchg_u8 */
@@ -43,7 +43,7 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 #else
 		local_irq_save(flags);
 		ret = *(volatile u16 *)ptr;
-		*(volatile u16 *)ptr = x;
+		*(volatile u16 *)ptr = (x & 0xffffu);
 		local_irq_restore(flags);
 		return ret;
 #endif /* __xchg_u16 */
@@ -54,7 +54,7 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 #else
 		local_irq_save(flags);
 		ret = *(volatile u32 *)ptr;
-		*(volatile u32 *)ptr = x;
+		*(volatile u32 *)ptr = (x & 0xffffffffu);
 		local_irq_restore(flags);
 		return ret;
 #endif /* __xchg_u32 */
-- 
2.39.2

