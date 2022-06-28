Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53E55C6CA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiF1ITc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiF1IS6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 04:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025329834;
        Tue, 28 Jun 2022 01:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2FA6119B;
        Tue, 28 Jun 2022 08:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93ACC341C8;
        Tue, 28 Jun 2022 08:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404251;
        bh=Ff1W2padqNEGnlp4EIi4Fy64JmW9kRjF1/cl2+7Ky3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8QiMoK8ZdSz+GxqAv8Z2XDdz1Ng3XR3AuUc8N+3nejjToYoMpavzerYLKhO8OoMs
         LjNNk4X7I13v1BKjESxet2/Gg2ho8FhU2Fh2zxJtLwIEjfhFQMyZMRaPKJfK69lg6P
         pzAulekaNRGTxQTJ+/a00jw/OW6phjURGxu+l2VrTtvtiNH5dc+oQ771y2LX+zZAr7
         op3A++IRhO7WlkAVnXHU5nt5drQqTVD8hDjolXbzTNdDrofQHVV0T11vi2JPmiDC8D
         jOZjWYqwFy4rbaDKuu4nW3F06MA/QcLZ6X12SlON47n9Q82BiLOt2y81Fv8HWqpXWl
         1WhUg2hhtQgzQ==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V7 3/5] asm-generic: ticket-lock: Move into ticket_spinlock.h
Date:   Tue, 28 Jun 2022 04:17:05 -0400
Message-Id: <20220628081707.1997728-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628081707.1997728-1-guoren@kernel.org>
References: <20220628081707.1997728-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Move ticket-lock definition into an independent file. It's a preparation
patch for the following combo spinlock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/spinlock.h        | 44 ++-----------
 include/asm-generic/ticket_spinlock.h | 92 +++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 37 deletions(-)
 create mode 100644 include/asm-generic/ticket_spinlock.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 4caeb8cebe53..f41dc7c2b900 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -27,66 +27,36 @@
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
 
-#include <linux/atomic.h>
-#include <asm-generic/spinlock_types.h>
+#include <asm-generic/ticket_spinlock.h>
 
 static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 {
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
+	ticket_spin_lock(lock);
 }
 
 static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
 {
-	u32 old = atomic_read(&lock->val);
-
-	if ((old >> 16) != (old & 0xffff))
-		return false;
-
-	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
+	return ticket_spin_trylock(lock);
 }
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(&lock->val);
-
-	smp_store_release(ptr, (u16)val + 1);
+	ticket_spin_unlock(lock);
 }
 
 static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(&lock->val);
-
-	return ((val >> 16) != (val & 0xffff));
+	return ticket_spin_is_locked(lock);
 }
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(&lock->val);
-
-	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+	return ticket_spin_is_contended(lock);
 }
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	u32 val = lock.val.counter;
-
-	return ((val >> 16) == (val & 0xffff));
+	return ticket_spin_value_unlocked(lock);
 }
 
 #include <asm/qrwlock.h>
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
new file mode 100644
index 000000000000..83e769398eea
--- /dev/null
+++ b/include/asm-generic/ticket_spinlock.h
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
+static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(&lock->val);
+
+	return ((val >> 16) != (val & 0xffff));
+}
+
+static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(&lock->val);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.val.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
+#endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
-- 
2.36.1

