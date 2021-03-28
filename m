Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688E734BB4F
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 08:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhC1Gby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 02:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhC1Gb2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 02:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 331216197C;
        Sun, 28 Mar 2021 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616913088;
        bh=aYDkJQnGePK/+lkF8hDtexkWagQ4SRB6bigpJhVfgAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAgaTJnJOmusUtmymyBNZXGK1BUiB+LA57rvQXmHTnMcTLIWlPLGv0PPjuf3tTRRr
         2M7sjdWDdwVjcO7G7yxZCrx9l+ZUtk+0DDg1pMt3NRHZMphNHPFG0G7hgysB/LzNXL
         Qk+qoQKbLwUilgC6hb7zxfcsvrM9A3HaNy/c8TSQG4x2zdRyPx3pAS67nZoGmcISIM
         93imAG0DvPoKRNOZTqu4k854xndY6bJpFXoFuhV/ny4XCRhKJ0GsX6mARj0YJylwLR
         a8OiaIYEGfIi7XB3XgVeDPDpsGXg7Tm6jCxNm6emiN9+uFIgg5DJNngRhzrFEk3zLp
         l+WH2kaYZxeFQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 3/7] csky: Convert custom spinlock/rwlock to generic qspinlock/qrwlock
Date:   Sun, 28 Mar 2021 06:30:24 +0000
Message-Id: <1616913028-83376-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616913028-83376-1-git-send-email-guoren@kernel.org>
References: <1616913028-83376-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Update the C-SKY port to use the generic qspinlock and qrwlock.

C-SKY only support ldex.w/stex.w with word(double word) size &
align access. So it must select XCHG32 to let qspinlock only use
word atomic xchg_tail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                      |  2 +
 arch/csky/include/asm/Kbuild           |  2 +
 arch/csky/include/asm/spinlock.h       | 82 +-------------------------
 arch/csky/include/asm/spinlock_types.h | 16 +----
 4 files changed, 6 insertions(+), 96 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 34e91224adc3..5910eb6ddde2 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,6 +8,8 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index cc24bb8e539f..2a2d09963bb9 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -2,6 +2,8 @@
 generic-y += asm-offsets.h
 generic-y += gpio.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 69f5aa249c5f..fcff36753c25 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -3,87 +3,7 @@
 #ifndef __ASM_CSKY_SPINLOCK_H
 #define __ASM_CSKY_SPINLOCK_H
 
-#include <linux/spinlock_types.h>
-#include <asm/barrier.h>
-
-/*
- * Ticket-based spin-locking.
- */
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lockval;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%2) \n"
-		"	mov		%1, %0	 \n"
-		"	add		%0, %3	 \n"
-		"	stex.w		%0, (%2) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp), "=&r" (lockval)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-
-	while (lockval.tickets.next != lockval.tickets.owner)
-		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
-
-	smp_mb();
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 tmp, contended, res;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-
-	do {
-		asm volatile (
-		"	ldex.w		%0, (%3)   \n"
-		"	movi		%2, 1	   \n"
-		"	rotli		%1, %0, 16 \n"
-		"	cmpne		%1, %0     \n"
-		"	bt		1f         \n"
-		"	movi		%2, 0	   \n"
-		"	add		%0, %0, %4 \n"
-		"	stex.w		%0, (%3)   \n"
-		"1:				   \n"
-		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-	} while (!res);
-
-	if (!contended)
-		smp_mb();
-
-	return !contended;
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
-}
-
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.tickets.owner == lock.tickets.next;
-}
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	return !arch_spin_value_unlocked(READ_ONCE(*lock));
-}
-
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
-
-	return (tickets.next - tickets.owner) > 1;
-}
-#define arch_spin_is_contended	arch_spin_is_contended
-
+#include <asm/qspinlock.h>
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 8ff0f6ff3a00..757594760e65 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -7,21 +7,7 @@
 # error "please don't include this file directly"
 #endif
 
-#define TICKET_NEXT	16
-
-typedef struct {
-	union {
-		u32 lock;
-		struct __raw_tickets {
-			/* little endian */
-			u16 owner;
-			u16 next;
-		} tickets;
-	};
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
-
+#include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
 #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.17.1

