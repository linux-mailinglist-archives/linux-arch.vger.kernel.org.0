Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A776D404
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHBQsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjHBQsQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F312706;
        Wed,  2 Aug 2023 09:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1037861A0D;
        Wed,  2 Aug 2023 16:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32D9C433C8;
        Wed,  2 Aug 2023 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994892;
        bh=sgIzdUVfUlz4ZBKJCMetJmqx5CuZ4IfTQ/ixE/F16i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wmu46JkGCDo6zaZLidoc9nt6bFZsvfYzwQYZie47Sodhkvu2MBtrSZn0nnQsDTShh
         xoRfMUwHEPsQkRiRZDm5yFSYGVC4KiAwfH8m9r3dBxxc8wIJD1cpKGUfYBp3rd09W3
         QTRqfelv4Upu2MoQr8tIicZ1lvQ5BOXKquIvkL8uRju5ld0GyBHpd7o1J+k+vN6/IJ
         7RUDNTiykWSNxwrb2eIJHUz3nfqgjYbXMUKoyQSUg128dZEyh51KjJ6CoJLXJaHuiO
         9m7qoB8Yu0HFq2W7dWO6xhupFhznj9m0FCb2JLlQ78g/sS7d3SRjQ79g9PNgZK5JdV
         IW+6etgrHhAlg==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V10 02/19] asm-generic: ticket-lock: Move into ticket_spinlock.h
Date:   Wed,  2 Aug 2023 12:46:44 -0400
Message-Id: <20230802164701.192791-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
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

Move ticket-lock definition into an independent file. This is the
preparation for the next combo spinlock of riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/asm-generic/spinlock.h        |  87 +---------------------
 include/asm-generic/ticket_spinlock.h | 103 ++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 86 deletions(-)
 create mode 100644 include/asm-generic/ticket_spinlock.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 4773334ee638..970590baf61b 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,94 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/*
- * 'Generic' ticket-lock implementation.
- *
- * It relies on atomic_fetch_add() having well defined forward progress
- * guarantees under contention. If your architecture cannot provide this, stick
- * to a test-and-set lock.
- *
- * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
- * sub-word of the value. This is generally true for anything LL/SC although
- * you'd be hard pressed to find anything useful in architecture specifications
- * about this. If your architecture cannot do this you might be better off with
- * a test-and-set.
- *
- * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
- * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
- * a full fence after the spin to upgrade the otherwise-RCpc
- * atomic_cond_read_acquire().
- *
- * The implementation uses smp_cond_load_acquire() to spin, so if the
- * architecture has WFE like instructions to sleep instead of poll for word
- * modifications be sure to implement that (see ARM64 for example).
- *
- */
-
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
 
-#include <linux/atomic.h>
-#include <asm-generic/spinlock_types.h>
-
-static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	u32 val = atomic_fetch_add(1<<16, &lock->val);
-	u16 ticket = val >> 16;
-
-	if (ticket == (u16)val)
-		return;
-
-	/*
-	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
-	 * custom cond_read_rcsc() here we just emit a full fence.  We only
-	 * need the prior reads before subsequent writes ordering from
-	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
-	 * have no outstanding writes due to the atomic_fetch_add() the extra
-	 * orderings are free.
-	 */
-	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
-	smp_mb();
-}
-
-static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 old = atomic_read(&lock->val);
-
-	if ((old >> 16) != (old & 0xffff))
-		return false;
-
-	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
-}
-
-static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(&lock->val);
-
-	smp_store_release(ptr, (u16)val + 1);
-}
-
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	u32 val = lock.val.counter;
-
-	return ((val >> 16) == (val & 0xffff));
-}
-
-static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	arch_spinlock_t val = READ_ONCE(*lock);
-
-	return !arch_spin_value_unlocked(val);
-}
-
-static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	u32 val = atomic_read(&lock->val);
-
-	return (s16)((val >> 16) - (val & 0xffff)) > 1;
-}
-
+#include <asm-generic/ticket_spinlock.h>
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
new file mode 100644
index 000000000000..cfcff22b37b3
--- /dev/null
+++ b/include/asm-generic/ticket_spinlock.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
+ * a full fence after the spin to upgrade the otherwise-RCpc
+ * atomic_cond_read_acquire().
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
+ */
+
+#ifndef __ASM_GENERIC_TICKET_SPINLOCK_H
+#define __ASM_GENERIC_TICKET_SPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/spinlock_types.h>
+
+static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, &lock->val);
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	/*
+	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
+	 * custom cond_read_rcsc() here we just emit a full fence.  We only
+	 * need the prior reads before subsequent writes ordering from
+	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
+	 * have no outstanding writes due to the atomic_fetch_add() the extra
+	 * orderings are free.
+	 */
+	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(&lock->val);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	u32 val = atomic_read(&lock->val);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.val.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
+static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
+{
+	arch_spinlock_t val = READ_ONCE(*lock);
+
+	return !ticket_spin_value_unlocked(val);
+}
+
+static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(&lock->val);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+/*
+ * Remapping spinlock architecture specific functions to the corresponding
+ * ticket spinlock functions.
+ */
+#define arch_spin_is_locked(l)		ticket_spin_is_locked(l)
+#define arch_spin_is_contended(l)	ticket_spin_is_contended(l)
+#define arch_spin_value_unlocked(l)	ticket_spin_value_unlocked(l)
+#define arch_spin_lock(l)		ticket_spin_lock(l)
+#define arch_spin_trylock(l)		ticket_spin_trylock(l)
+#define arch_spin_unlock(l)		ticket_spin_unlock(l)
+
+#endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
-- 
2.36.1

