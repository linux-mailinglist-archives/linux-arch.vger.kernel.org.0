Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988F55C3C9
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiF1ITc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbiF1IS7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 04:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2D2CDF1;
        Tue, 28 Jun 2022 01:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0886120E;
        Tue, 28 Jun 2022 08:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF3C341CD;
        Tue, 28 Jun 2022 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404255;
        bh=g2ZuhGG3HGmk8tNNjHUSt2Kmg34WaNBVGxTmVm8cja8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSSOjJGt1ih1Cn49RlFQ/mtXij9nI3mrKbgo/KUAzz6M+7lTMN4r27STXJaA/mTi+
         9WAi8FJ0XOu4hKOYkc7ten0V8/0J8PX34tTOJYp+r30fJYMsof+mcRCAlvrpveTfcp
         ZQfTMKJN/h9W9mVUufrYPoa7kY/FJsHeUqujR0nRYMpKER5/VJID8BMAGkPGvMHAWf
         h35douftA+2TFVW5mZ0py8HMNHQbV8TAqVThnvMbRbNj1wZf2e8Ir4b9+gEm1fJIzt
         IpvoSjw84UWafAvDo/wbXmsYRvEOGAgfxAhawgHotgOJarvwsIyepz+KPcRiqeOaGA
         uVJ+dnjRebBbw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket & queued)
Date:   Tue, 28 Jun 2022 04:17:06 -0400
Message-Id: <20220628081707.1997728-5-guoren@kernel.org>
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

Some architecture has a flexible requirement on the type of spinlock.
Some LL/SC architectures of ISA don't force micro-arch to give a strong
forward guarantee. Thus different kinds of memory model micro-arch would
come out in one ISA. The ticket lock is suitable for exclusive monitor
designed LL/SC micro-arch with limited cores and "!NUMA". The
queue-spinlock could deal with NUMA/large-scale scenarios with a strong
forward guarantee designed LL/SC micro-arch.

So, make the spinlock a combo with feature.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
 kernel/locking/qspinlock.c     |  2 ++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index f41dc7c2b900..a9b43089bf99 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -28,34 +28,73 @@
 #define __ASM_GENERIC_SPINLOCK_H
 
 #include <asm-generic/ticket_spinlock.h>
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+#include <linux/jump_label.h>
+#include <asm-generic/qspinlock.h>
+
+DECLARE_STATIC_KEY_TRUE(use_qspinlock_key);
+#endif
+
+#undef arch_spin_is_locked
+#undef arch_spin_is_contended
+#undef arch_spin_value_unlocked
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_unlock
 
 static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 {
-	ticket_spin_lock(lock);
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		queued_spin_lock(lock);
+	else
+#endif
+		ticket_spin_lock(lock);
 }
 
 static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
 {
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		return queued_spin_trylock(lock);
+#endif
 	return ticket_spin_trylock(lock);
 }
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	ticket_spin_unlock(lock);
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		queued_spin_unlock(lock);
+	else
+#endif
+		ticket_spin_unlock(lock);
 }
 
 static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		return queued_spin_is_locked(lock);
+#endif
 	return ticket_spin_is_locked(lock);
 }
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		return queued_spin_is_contended(lock);
+#endif
 	return ticket_spin_is_contended(lock);
 }
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+	if (static_branch_likely(&use_qspinlock_key))
+		return queued_spin_value_unlocked(lock);
+#endif
 	return ticket_spin_value_unlocked(lock);
 }
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 65a9a10caa6f..b7f7436f42f6 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -566,6 +566,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
+DEFINE_STATIC_KEY_TRUE_RO(use_qspinlock_key);
+
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
  */
-- 
2.36.1

