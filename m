Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1794F58C3B8
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiHHHOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiHHHOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:14:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59909FC0;
        Mon,  8 Aug 2022 00:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D57B80E07;
        Mon,  8 Aug 2022 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FA8C433D6;
        Mon,  8 Aug 2022 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942841;
        bh=VTgzxT5YWA/FXTGh2L0uPc4Dz3cqTkrreO/CY7INghE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfPqsa8VFloG1NRbhC8enTrVw0OkRGrGcLm+//WoDzQ9TvOTVF75xkB/W5QkB21ty
         X/CwZ9TYEc/E66B3wvCUHwWY38osrkJhBa/VQjO8x8sCm17Xq3EXus/jyOwRI6q6pl
         0i9vN7To7knSIEXDvUSRmzNFJUIT0B6XB9bx2kHRiTc4JjieQpAdn3tUdFr+36K4Li
         rV+PiNTwZ4E92wpAs5/tCcoRlJxu2vsxg9POGgIdKFPWqnm6QV5+GLcbA5mB4Hy4u3
         Y5xrgmB+hTFWRBsHoMNL+WpL4OBjFpR1yVnxV97fa+YUnvw9jhQFzFECEajyBhu4sp
         QRNjxJEU9Brlw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 04/15] asm-generic: ticket-lock: Keep ticket-lock the same semantic with qspinlock
Date:   Mon,  8 Aug 2022 03:13:07 -0400
Message-Id: <20220808071318.3335746-5-guoren@kernel.org>
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

Define smp_mb__after_spinlock by smp_mb as default behavior to give RCsc
synchronization point for all architectures. Keep the same semantic with
qspinlock, a acquire (RCpc) synchronization point. More detail, see
include/linux/spinlock.h.

Some architectures could give more robust semantics than smp_mb, eg.
riscv. Some architectures needn't smp_mb__after_spinlock because their
spinlocks have contained an RCsc.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/asm-generic/spinlock.h        |  5 +++++
 include/asm-generic/ticket_spinlock.h | 18 ++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 970590baf61b..6f5a1b838ca2 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -6,4 +6,9 @@
 #include <asm-generic/ticket_spinlock.h>
 #include <asm/qrwlock.h>
 
+/* See include/linux/spinlock.h */
+#ifndef smp_mb__after_spinlock
+#define smp_mb__after_spinlock()	smp_mb()
+#endif
+
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
index cfcff22b37b3..d8e6ec82f096 100644
--- a/include/asm-generic/ticket_spinlock.h
+++ b/include/asm-generic/ticket_spinlock.h
@@ -14,9 +14,8 @@
  * a test-and-set.
  *
  * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
- * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
- * a full fence after the spin to upgrade the otherwise-RCpc
- * atomic_cond_read_acquire().
+ * uses smp_mb__after_spinlock which is RCsc to create an RCsc hot path, See
+ * include/linux/spinlock.h
  *
  * The implementation uses smp_cond_load_acquire() to spin, so if the
  * architecture has WFE like instructions to sleep instead of poll for word
@@ -32,22 +31,13 @@
 
 static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
 {
-	u32 val = atomic_fetch_add(1<<16, &lock->val);
+	u32 val = atomic_fetch_add_acquire(1<<16, &lock->val);
 	u16 ticket = val >> 16;
 
 	if (ticket == (u16)val)
 		return;
 
-	/*
-	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
-	 * custom cond_read_rcsc() here we just emit a full fence.  We only
-	 * need the prior reads before subsequent writes ordering from
-	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
-	 * have no outstanding writes due to the atomic_fetch_add() the extra
-	 * orderings are free.
-	 */
 	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
-	smp_mb();
 }
 
 static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
@@ -57,7 +47,7 @@ static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
 	if ((old >> 16) != (old & 0xffff))
 		return false;
 
-	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
+	return atomic_try_cmpxchg_acquire(&lock->val, &old, old + (1<<16));
 }
 
 static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)
-- 
2.36.1

