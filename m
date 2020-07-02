Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249A1211D68
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGBHtP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:49:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B89BC08C5C1;
        Thu,  2 Jul 2020 00:49:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m9so1920918pfh.0;
        Thu, 02 Jul 2020 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjWMms9hqssB2L3Uqzup8R5/c6eD/F4/doDU2/0geL4=;
        b=Y66qi7KTnT1taneBq0c2GknBYUbrHkrBf/yTwbY7xqDkyk3fxovXrCCfbuZHG2Ryng
         00jrh2jlN7r2buYyolaKrujXgkbR5TOM0A701cllTUEhrwjhkl+0kzS6FVNjG2rSmrL2
         wGdNzDZU1Utarq78GrxyKgL3Qeme4Ilmej1yA/zF20NfGWn8xS5BOtyamd1gbL/K8sni
         Yds84pcbWeHKloWRVuyaWkVKhACeDzd92QdDwfyVxbNnMy8kh7EgnkodeY3+VVGhisq0
         8G1GhV76Jn/hpFUT9xj3SH7iHFO9D3Q6UJxRQ4LKrgq7D06XIwRK2NNgRVP6wAEiVLfm
         xBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjWMms9hqssB2L3Uqzup8R5/c6eD/F4/doDU2/0geL4=;
        b=McypAptLMj8x9BRYe+MtA9n50fBe89dDn4RkMQjwpKL4WpspDtuYAJPc0ptTdfX7Dg
         WzQn6LP9C3wJcMhrz8lWwKnb/ws545YE9VhTvBfpABKkMCKtWWUfhY0l8LRo1sSVBMMH
         Be7n9GXqh3i6TA8F+af+aHF2KAwAY6MHft63dBs66sPyuvxqyAUjvwjHzwBPJEZYdt6V
         GA2dGjWoiNDUE5yqOFBWQr6tFHeeYjWm02+rSgyUUWS6VCJS9psQi+3UM0Abmra/ooWS
         piBVtgHkztFts0zzJBwSm6d1bAaWlMtwOmQtM48RIOlPq2moMMrPP37n6yT4B+Cqj9WF
         +s/A==
X-Gm-Message-State: AOAM531PTtEJnMqz7nLe/v8WC4/mdn51ixlHfS8JRRwsfB74FHgm2Vyf
        d2zzcsjrQtmba/9fqKKDyMLo4dsQ
X-Google-Smtp-Source: ABdhPJy+mTm8LCuyZKYqIjPkX4VwTYXnSZPzyCK/ivHCmlYEheRX+fVlVZz+rtbe49RiPU/50WEUfA==
X-Received: by 2002:a05:6a00:2257:: with SMTP id i23mr21115807pfu.25.1593676154625;
        Thu, 02 Jul 2020 00:49:14 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:49:14 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 4/8] powerpc: move spinlock implementation to simple_spinlock
Date:   Thu,  2 Jul 2020 17:48:35 +1000
Message-Id: <20200702074839.1057733-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To prepare for queued spinlocks. This is a simple rename except to update
preprocessor guard name and a file reference.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/simple_spinlock.h    | 292 ++++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 285 +----------------
 arch/powerpc/include/asm/spinlock_types.h     |  12 +-
 4 files changed, 315 insertions(+), 295 deletions(-)
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
new file mode 100644
index 000000000000..e048c041c4a9
--- /dev/null
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_SIMPLE_SPINLOCK_H
+#define __ASM_SIMPLE_SPINLOCK_H
+#ifdef __KERNEL__
+
+/*
+ * Simple spin lock operations.  
+ *
+ * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
+ * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2002 Dave Engebretsen <engebret@us.ibm.com>, IBM
+ *	Rework to support virtual processors
+ *
+ * Type of int is used as a full 64b word is not necessary.
+ *
+ * (the type definitions are in asm/simple_spinlock_types.h)
+ */
+#include <linux/irqflags.h>
+#include <asm/paravirt.h>
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+#endif
+#include <asm/synch.h>
+#include <asm/ppc-opcode.h>
+
+#ifdef CONFIG_PPC64
+/* use 0x800000yy when locked, where yy == CPU number */
+#ifdef __BIG_ENDIAN__
+#define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
+#else
+#define LOCK_TOKEN	(*(u32 *)(&get_paca()->paca_index))
+#endif
+#else
+#define LOCK_TOKEN	1
+#endif
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.slock == 0;
+}
+
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	smp_mb();
+	return !arch_spin_value_unlocked(*lock);
+}
+
+/*
+ * This returns the old value in the lock, so we succeeded
+ * in getting the lock if the return value is 0.
+ */
+static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
+{
+	unsigned long tmp, token;
+
+	token = LOCK_TOKEN;
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
+	cmpwi		0,%0,0\n\
+	bne-		2f\n\
+	stwcx.		%1,0,%2\n\
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"
+	: "=&r" (tmp)
+	: "r" (token), "r" (&lock->slock)
+	: "cr0", "memory");
+
+	return tmp;
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	return __arch_spin_trylock(lock) == 0;
+}
+
+/*
+ * On a system with shared processors (that is, where a physical
+ * processor is multiplexed between several virtual processors),
+ * there is no point spinning on a lock if the holder of the lock
+ * isn't currently scheduled on a physical processor.  Instead
+ * we detect this situation and ask the hypervisor to give the
+ * rest of our timeslice to the lock holder.
+ *
+ * So that we can tell which virtual processor is holding a lock,
+ * we put 0x80000000 | smp_processor_id() in the lock when it is
+ * held.  Conveniently, we have a word in the paca that holds this
+ * value.
+ */
+
+#if defined(CONFIG_PPC_SPLPAR)
+/* We only yield to the hypervisor if we are in shared processor mode */
+void splpar_spin_yield(arch_spinlock_t *lock);
+void splpar_rw_yield(arch_rwlock_t *lock);
+#else /* SPLPAR */
+static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
+static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
+#endif
+
+static inline void spin_yield(arch_spinlock_t *lock)
+{
+	if (is_shared_processor())
+		splpar_spin_yield(lock);
+	else
+		barrier();
+}
+
+static inline void rw_yield(arch_rwlock_t *lock)
+{
+	if (is_shared_processor())
+		splpar_rw_yield(lock);
+	else
+		barrier();
+}
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	while (1) {
+		if (likely(__arch_spin_trylock(lock) == 0))
+			break;
+		do {
+			HMT_low();
+			if (is_shared_processor())
+				splpar_spin_yield(lock);
+		} while (unlikely(lock->slock != 0));
+		HMT_medium();
+	}
+}
+
+static inline
+void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
+{
+	unsigned long flags_dis;
+
+	while (1) {
+		if (likely(__arch_spin_trylock(lock) == 0))
+			break;
+		local_save_flags(flags_dis);
+		local_irq_restore(flags);
+		do {
+			HMT_low();
+			if (is_shared_processor())
+				splpar_spin_yield(lock);
+		} while (unlikely(lock->slock != 0));
+		HMT_medium();
+		local_irq_restore(flags_dis);
+	}
+}
+#define arch_spin_lock_flags arch_spin_lock_flags
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	__asm__ __volatile__("# arch_spin_unlock\n\t"
+				PPC_RELEASE_BARRIER: : :"memory");
+	lock->slock = 0;
+}
+
+/*
+ * Read-write spinlocks, allowing multiple readers
+ * but only one writer.
+ *
+ * NOTE! it is quite common to have readers in interrupts
+ * but no interrupt writers. For those circumstances we
+ * can "mix" irq-safe locks - any writer needs to get a
+ * irq-safe write-lock, but readers can get non-irqsafe
+ * read-locks.
+ */
+
+#ifdef CONFIG_PPC64
+#define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
+#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
+#else
+#define __DO_SIGN_EXTEND
+#define WRLOCK_TOKEN		(-1)
+#endif
+
+/*
+ * This returns the old value in the lock + 1,
+ * so we got a read lock if the return value is > 0.
+ */
+static inline long __arch_read_trylock(arch_rwlock_t *rw)
+{
+	long tmp;
+
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0,0,%1,1) "\n"
+	__DO_SIGN_EXTEND
+"	addic.		%0,%0,1\n\
+	ble-		2f\n"
+"	stwcx.		%0,0,%1\n\
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"	: "=&r" (tmp)
+	: "r" (&rw->lock)
+	: "cr0", "xer", "memory");
+
+	return tmp;
+}
+
+/*
+ * This returns the old value in the lock,
+ * so we got the write lock if the return value is 0.
+ */
+static inline long __arch_write_trylock(arch_rwlock_t *rw)
+{
+	long tmp, token;
+
+	token = WRLOCK_TOKEN;
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
+	cmpwi		0,%0,0\n\
+	bne-		2f\n"
+"	stwcx.		%1,0,%2\n\
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"	: "=&r" (tmp)
+	: "r" (token), "r" (&rw->lock)
+	: "cr0", "memory");
+
+	return tmp;
+}
+
+static inline void arch_read_lock(arch_rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__arch_read_trylock(rw) > 0))
+			break;
+		do {
+			HMT_low();
+			if (is_shared_processor())
+				splpar_rw_yield(rw);
+		} while (unlikely(rw->lock < 0));
+		HMT_medium();
+	}
+}
+
+static inline void arch_write_lock(arch_rwlock_t *rw)
+{
+	while (1) {
+		if (likely(__arch_write_trylock(rw) == 0))
+			break;
+		do {
+			HMT_low();
+			if (is_shared_processor())
+				splpar_rw_yield(rw);
+		} while (unlikely(rw->lock != 0));
+		HMT_medium();
+	}
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *rw)
+{
+	return __arch_read_trylock(rw) > 0;
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *rw)
+{
+	return __arch_write_trylock(rw) == 0;
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *rw)
+{
+	long tmp;
+
+	__asm__ __volatile__(
+	"# read_unlock\n\t"
+	PPC_RELEASE_BARRIER
+"1:	lwarx		%0,0,%1\n\
+	addic		%0,%0,-1\n"
+"	stwcx.		%0,0,%1\n\
+	bne-		1b"
+	: "=&r"(tmp)
+	: "r"(&rw->lock)
+	: "cr0", "xer", "memory");
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *rw)
+{
+	__asm__ __volatile__("# write_unlock\n\t"
+				PPC_RELEASE_BARRIER: : :"memory");
+	rw->lock = 0;
+}
+
+#define arch_spin_relax(lock)	spin_yield(lock)
+#define arch_read_relax(lock)	rw_yield(lock)
+#define arch_write_relax(lock)	rw_yield(lock)
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()   smp_mb()
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_SIMPLE_SPINLOCK_H */
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/include/asm/simple_spinlock_types.h
new file mode 100644
index 000000000000..7c2b48ce62dc
--- /dev/null
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
+#define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile signed int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 79be9bb10bbb..21357fe05fe0 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -3,290 +3,7 @@
 #define __ASM_SPINLOCK_H
 #ifdef __KERNEL__
 
-/*
- * Simple spin lock operations.  
- *
- * Copyright (C) 2001-2004 Paul Mackerras <paulus@au.ibm.com>, IBM
- * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
- * Copyright (C) 2002 Dave Engebretsen <engebret@us.ibm.com>, IBM
- *	Rework to support virtual processors
- *
- * Type of int is used as a full 64b word is not necessary.
- *
- * (the type definitions are in asm/spinlock_types.h)
- */
-#include <linux/irqflags.h>
-#include <asm/paravirt.h>
-#ifdef CONFIG_PPC64
-#include <asm/paca.h>
-#endif
-#include <asm/synch.h>
-#include <asm/ppc-opcode.h>
-
-#ifdef CONFIG_PPC64
-/* use 0x800000yy when locked, where yy == CPU number */
-#ifdef __BIG_ENDIAN__
-#define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
-#else
-#define LOCK_TOKEN	(*(u32 *)(&get_paca()->paca_index))
-#endif
-#else
-#define LOCK_TOKEN	1
-#endif
-
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.slock == 0;
-}
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	smp_mb();
-	return !arch_spin_value_unlocked(*lock);
-}
-
-/*
- * This returns the old value in the lock, so we succeeded
- * in getting the lock if the return value is 0.
- */
-static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
-{
-	unsigned long tmp, token;
-
-	token = LOCK_TOKEN;
-	__asm__ __volatile__(
-"1:	" PPC_LWARX(%0,0,%2,1) "\n\
-	cmpwi		0,%0,0\n\
-	bne-		2f\n\
-	stwcx.		%1,0,%2\n\
-	bne-		1b\n"
-	PPC_ACQUIRE_BARRIER
-"2:"
-	: "=&r" (tmp)
-	: "r" (token), "r" (&lock->slock)
-	: "cr0", "memory");
-
-	return tmp;
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	return __arch_spin_trylock(lock) == 0;
-}
-
-/*
- * On a system with shared processors (that is, where a physical
- * processor is multiplexed between several virtual processors),
- * there is no point spinning on a lock if the holder of the lock
- * isn't currently scheduled on a physical processor.  Instead
- * we detect this situation and ask the hypervisor to give the
- * rest of our timeslice to the lock holder.
- *
- * So that we can tell which virtual processor is holding a lock,
- * we put 0x80000000 | smp_processor_id() in the lock when it is
- * held.  Conveniently, we have a word in the paca that holds this
- * value.
- */
-
-#if defined(CONFIG_PPC_SPLPAR)
-/* We only yield to the hypervisor if we are in shared processor mode */
-void splpar_spin_yield(arch_spinlock_t *lock);
-void splpar_rw_yield(arch_rwlock_t *lock);
-#else /* SPLPAR */
-static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
-static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
-#endif
-
-static inline void spin_yield(arch_spinlock_t *lock)
-{
-	if (is_shared_processor())
-		splpar_spin_yield(lock);
-	else
-		barrier();
-}
-
-static inline void rw_yield(arch_rwlock_t *lock)
-{
-	if (is_shared_processor())
-		splpar_rw_yield(lock);
-	else
-		barrier();
-}
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	while (1) {
-		if (likely(__arch_spin_trylock(lock) == 0))
-			break;
-		do {
-			HMT_low();
-			if (is_shared_processor())
-				splpar_spin_yield(lock);
-		} while (unlikely(lock->slock != 0));
-		HMT_medium();
-	}
-}
-
-static inline
-void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
-{
-	unsigned long flags_dis;
-
-	while (1) {
-		if (likely(__arch_spin_trylock(lock) == 0))
-			break;
-		local_save_flags(flags_dis);
-		local_irq_restore(flags);
-		do {
-			HMT_low();
-			if (is_shared_processor())
-				splpar_spin_yield(lock);
-		} while (unlikely(lock->slock != 0));
-		HMT_medium();
-		local_irq_restore(flags_dis);
-	}
-}
-#define arch_spin_lock_flags arch_spin_lock_flags
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	__asm__ __volatile__("# arch_spin_unlock\n\t"
-				PPC_RELEASE_BARRIER: : :"memory");
-	lock->slock = 0;
-}
-
-/*
- * Read-write spinlocks, allowing multiple readers
- * but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts
- * but no interrupt writers. For those circumstances we
- * can "mix" irq-safe locks - any writer needs to get a
- * irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-
-#ifdef CONFIG_PPC64
-#define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
-#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
-#else
-#define __DO_SIGN_EXTEND
-#define WRLOCK_TOKEN		(-1)
-#endif
-
-/*
- * This returns the old value in the lock + 1,
- * so we got a read lock if the return value is > 0.
- */
-static inline long __arch_read_trylock(arch_rwlock_t *rw)
-{
-	long tmp;
-
-	__asm__ __volatile__(
-"1:	" PPC_LWARX(%0,0,%1,1) "\n"
-	__DO_SIGN_EXTEND
-"	addic.		%0,%0,1\n\
-	ble-		2f\n"
-"	stwcx.		%0,0,%1\n\
-	bne-		1b\n"
-	PPC_ACQUIRE_BARRIER
-"2:"	: "=&r" (tmp)
-	: "r" (&rw->lock)
-	: "cr0", "xer", "memory");
-
-	return tmp;
-}
-
-/*
- * This returns the old value in the lock,
- * so we got the write lock if the return value is 0.
- */
-static inline long __arch_write_trylock(arch_rwlock_t *rw)
-{
-	long tmp, token;
-
-	token = WRLOCK_TOKEN;
-	__asm__ __volatile__(
-"1:	" PPC_LWARX(%0,0,%2,1) "\n\
-	cmpwi		0,%0,0\n\
-	bne-		2f\n"
-"	stwcx.		%1,0,%2\n\
-	bne-		1b\n"
-	PPC_ACQUIRE_BARRIER
-"2:"	: "=&r" (tmp)
-	: "r" (token), "r" (&rw->lock)
-	: "cr0", "memory");
-
-	return tmp;
-}
-
-static inline void arch_read_lock(arch_rwlock_t *rw)
-{
-	while (1) {
-		if (likely(__arch_read_trylock(rw) > 0))
-			break;
-		do {
-			HMT_low();
-			if (is_shared_processor())
-				splpar_rw_yield(rw);
-		} while (unlikely(rw->lock < 0));
-		HMT_medium();
-	}
-}
-
-static inline void arch_write_lock(arch_rwlock_t *rw)
-{
-	while (1) {
-		if (likely(__arch_write_trylock(rw) == 0))
-			break;
-		do {
-			HMT_low();
-			if (is_shared_processor())
-				splpar_rw_yield(rw);
-		} while (unlikely(rw->lock != 0));
-		HMT_medium();
-	}
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *rw)
-{
-	return __arch_read_trylock(rw) > 0;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *rw)
-{
-	return __arch_write_trylock(rw) == 0;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *rw)
-{
-	long tmp;
-
-	__asm__ __volatile__(
-	"# read_unlock\n\t"
-	PPC_RELEASE_BARRIER
-"1:	lwarx		%0,0,%1\n\
-	addic		%0,%0,-1\n"
-"	stwcx.		%0,0,%1\n\
-	bne-		1b"
-	: "=&r"(tmp)
-	: "r"(&rw->lock)
-	: "cr0", "xer", "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *rw)
-{
-	__asm__ __volatile__("# write_unlock\n\t"
-				PPC_RELEASE_BARRIER: : :"memory");
-	rw->lock = 0;
-}
-
-#define arch_spin_relax(lock)	spin_yield(lock)
-#define arch_read_relax(lock)	rw_yield(lock)
-#define arch_write_relax(lock)	rw_yield(lock)
-
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()   smp_mb()
+#include <asm/simple_spinlock.h>
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 87adaf13b7e8..3906f52dae65 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -6,16 +6,6 @@
 # error "please don't include this file directly"
 #endif
 
-typedef struct {
-	volatile unsigned int slock;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile signed int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm/simple_spinlock_types.h>
 
 #endif
-- 
2.23.0

