Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3C5534EF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiFUOuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiFUOtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 10:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFAD275E7;
        Tue, 21 Jun 2022 07:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD780616C3;
        Tue, 21 Jun 2022 14:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D0EC341C0;
        Tue, 21 Jun 2022 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655822987;
        bh=o7k5aZt+GPZLT7AuMi7ejxspY8QjEmA3Qfnf6gZmvRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbxceeGo4Rfq03hmZY7hQfj7fGA2j2+J9UAesk6KId9yP9v5gbCsUYOTCtfwhKxWb
         mpVzFpUkMYxyhVage0lH5AP+0ImXKHRql1FHq9M/X37DewFxw/Sginw4mJq5fxgMtr
         E5Gp+faUZPQxyzW3mRDygHO4Yd3VtT16GyGXMP7QKSmbkZNXENaEfGaAoK7VN4Rd0E
         yZquxtpOfq6tw9dlLeaMQK2BTRBNd7+zjUDksyxex3t3i28rnS0qaAKv6unnsGHPBL
         MOYRpvnPBPJB7LAiS0bjuddfQsf5QoOYNM3JAKbZj9trolZ3Hrjrz66NtPF9vAwWu+
         2Vy7M0/zMC0KA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, peterz@infradead.org,
        longman@redhat.com, boqun.feng@gmail.com,
        Conor.Dooley@microchip.com, chenhuacai@loongson.cn,
        kernel@xen0n.name, r@hev.cc, shorne@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V6 1/2] asm-generic: spinlock: Move qspinlock & ticket-lock into generic spinlock.h
Date:   Tue, 21 Jun 2022 10:49:19 -0400
Message-Id: <20220621144920.2945595-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621144920.2945595-1-guoren@kernel.org>
References: <20220621144920.2945595-1-guoren@kernel.org>
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

Separate ticket-lock into tspinlock.h and let generic spinlock support
qspinlock or ticket-lock selected by CONFIG_ARCH_USE_QUEUED_SPINLOCKS
config.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/spinlock.h        | 90 ++------------------------
 include/asm-generic/spinlock_types.h  | 14 ++--
 include/asm-generic/tspinlock.h       | 92 +++++++++++++++++++++++++++
 include/asm-generic/tspinlock_types.h | 17 +++++
 4 files changed, 119 insertions(+), 94 deletions(-)
 create mode 100644 include/asm-generic/tspinlock.h
 create mode 100644 include/asm-generic/tspinlock_types.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb050f4..4eca2488af38 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,92 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
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
-	u32 val = atomic_fetch_add(1<<16, lock);
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
-	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
-	smp_mb();
-}
-
-static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 old = atomic_read(lock);
-
-	if ((old >> 16) != (old & 0xffff))
-		return false;
-
-	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
-}
-
-static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(lock);
-
-	smp_store_release(ptr, (u16)val + 1);
-}
-
-static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	u32 val = atomic_read(lock);
-
-	return ((val >> 16) != (val & 0xffff));
-}
-
-static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	u32 val = atomic_read(lock);
-
-	return (s16)((val >> 16) - (val & 0xffff)) > 1;
-}
-
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return !arch_spin_is_locked(&lock);
-}
-
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
 #include <asm/qrwlock.h>
+#else
+#include <asm-generic/tspinlock.h>
+#endif
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
index 8962bb730945..9875c1d058b3 100644
--- a/include/asm-generic/spinlock_types.h
+++ b/include/asm-generic/spinlock_types.h
@@ -3,15 +3,11 @@
 #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
 #define __ASM_GENERIC_SPINLOCK_TYPES_H
 
-#include <linux/types.h>
-typedef atomic_t arch_spinlock_t;
-
-/*
- * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
- * include.
- */
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
 #include <asm/qrwlock_types.h>
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+#else
+#include <asm-generic/tspinlock_types.h>
+#endif
 
 #endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
diff --git a/include/asm-generic/tspinlock.h b/include/asm-generic/tspinlock.h
new file mode 100644
index 000000000000..def7b8f0f4f4
--- /dev/null
+++ b/include/asm-generic/tspinlock.h
@@ -0,0 +1,92 @@
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
+#ifndef __ASM_GENERIC_TSPINLOCK_H
+#define __ASM_GENERIC_TSPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/tspinlock_types.h>
+
+static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, lock);
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
+	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(lock);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	u32 val = atomic_read(lock);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return ((val >> 16) != (val & 0xffff));
+}
+
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return !arch_spin_is_locked(&lock);
+}
+
+#include <asm/qrwlock.h>
+
+#endif /* __ASM_GENERIC_TSPINLOCK_H */
diff --git a/include/asm-generic/tspinlock_types.h b/include/asm-generic/tspinlock_types.h
new file mode 100644
index 000000000000..ca3ea5acd172
--- /dev/null
+++ b/include/asm-generic/tspinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_GENERIC_TSPINLOCK_TYPES_H
+#define __ASM_GENERIC_TSPINLOCK_TYPES_H
+
+#include <linux/types.h>
+typedef atomic_t arch_spinlock_t;
+
+/*
+ * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
+ * include.
+ */
+#include <asm/qrwlock_types.h>
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+
+#endif /* __ASM_GENERIC_TSPINLOCK_TYPES_H */
-- 
2.36.1

