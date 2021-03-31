Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89993350246
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhCaOcU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236056AbhCaObz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE45660FF1;
        Wed, 31 Mar 2021 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201114;
        bh=ZlgshpaCoA6zGi17OQe5KtXtUjgmxHsHhFE58+U5sOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFUJQ+P1xzQmaWQX8Swd0sEBGp6ODLnJGpzRzYpYmHK8ilk5c7PQAsgb4tqXDyJn4
         C8rYJIkzX5VwZ6DSngDJkzHCIPfe6zBDSfkXd3axY2xtONndhSnaMRJbEBI2nh3QN+
         FlBTndTouquw7fxhbY/3+9mmhXJHVVPYqIOz367B3GbxZJ9sD6fKUW6qcC0nc5Vmh7
         DsDqlI0e38DpWOpASf1pHsgfg2hPt7gwSaexx+iGLJVpymN7V8K6NzB6/pGOW4KqMG
         x6Sn6wZUrDToJQbAaynuurLgXGrc7YkieAd2kd5v4yOGIUWGWPDartHFmFTMyEvaSM
         05tSWZo4NrEww==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: [PATCH v6 1/9] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 14:30:32 +0000
Message-Id: <1617201040-83905-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Some architectures don't have sub-word swap atomic instruction,
they only have the full word's one.

The sub-word swap only improve the performance when:
NR_CPUS < 16K
 *  0- 7: locked byte
 *     8: pending
 *  9-15: not used
 * 16-17: tail index
 * 18-31: tail cpu (+1)

The 9-15 bits are wasted to use xchg16 in xchg_tail.

Please let architecture select xchg16/xchg32 to implement
xchg_tail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anup Patel <anup@brainfault.org>
---
 kernel/Kconfig.locks       |  3 +++
 kernel/locking/qspinlock.c | 46 +++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..d02f1261f73f 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
 config ARCH_USE_QUEUED_SPINLOCKS
 	bool
 
+config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
+	bool
+
 config QUEUED_SPINLOCKS
 	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
 	depends on SMP
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..4bfaa969bd15 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
 #else /* _Q_PENDING_BITS == 8 */
 
 /**
@@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
 	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
 }
+#endif /* _Q_PENDING_BITS == 8 */
+
+#if _Q_PENDING_BITS == 8 && !defined(CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32)
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else
 
 /**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
@@ -236,7 +240,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	}
 	return old;
 }
-#endif /* _Q_PENDING_BITS == 8 */
+#endif
 
 /**
  * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
-- 
2.17.1

