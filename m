Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B493821C5BB
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jul 2020 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGKSXD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jul 2020 14:23:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728555AbgGKSXB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jul 2020 14:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594491778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=y8h94Bqz+BKftRH9Dx2xn18lhW8t9AdLeUZzkeRDIxw=;
        b=OpACyHqAqCZVvH34qz68QHDdIpr8e2FdNQaiWT6zb/uvQP+x/Txkf3JN63XwfP+scIJdun
        XFulk9UTlaVaDg7HWcct9gza7VbwLY57GOp+ntnTx2erPPdrd9iQ6rDurNTGRPtoRsrYDC
        i+uvGoHJSqTpkBE7i/l4ADDIwZiwRNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-1St-WQzEMG23PMApXIyeQw-1; Sat, 11 Jul 2020 14:22:56 -0400
X-MC-Unique: 1St-WQzEMG23PMApXIyeQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6DAC1800D42;
        Sat, 11 Jul 2020 18:22:54 +0000 (UTC)
Received: from llong.com (ovpn-112-135.rdu2.redhat.com [10.10.112.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74A8F5D9CC;
        Sat, 11 Jul 2020 18:22:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu into lock
Date:   Sat, 11 Jul 2020 14:21:28 -0400
Message-Id: <20200711182128.29130-3-longman@redhat.com>
In-Reply-To: <20200711182128.29130-1-longman@redhat.com>
References: <20200711182128.29130-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The previous patch enables native qspinlock to store lock holder cpu
number into the lock word when the lock is acquired via the slowpath.
Since PV qspinlock uses atomic unlock, allowing the fastpath and
slowpath to put different values into the lock word will further slow
down the performance. This is certainly undesirable.

The only way we can do that without too much performance impact is to
make fastpath and slowpath put in the same value. Still there is a slight
performance overhead in the additional access to a percpu variable in the
fastpath as well as the less optimized x86-64 PV qspinlock unlock path.

A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
distros to decide if they want to enable lock holder cpu information in
the lock itself for both native and PV qspinlocks across both fastpath
and slowpath. If this option is not configureed, only native qspinlocks
in the slowpath will put the lock holder cpu information in the lock
word.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig                              | 12 +++++++
 arch/x86/include/asm/qspinlock_paravirt.h |  9 +++--
 include/asm-generic/qspinlock.h           | 13 +++++--
 kernel/locking/qspinlock.c                |  5 ++-
 kernel/locking/qspinlock_paravirt.h       | 41 ++++++++++++-----------
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..1e6fea12be41 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -954,6 +954,18 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config QUEUED_SPINLOCKS_CPUINFO
+	bool "Store lock holder cpu information into queued spinlocks"
+	depends on QUEUED_SPINLOCKS
+	help
+	  Enable queued spinlocks to encode (by adding 2) the lock holder
+	  cpu number into the least significant 8 bits of the 32-bit
+	  lock word as long as the cpu number is not larger than 252.
+	  A value of 1 will be stored for larger cpu numbers. Having the
+	  lock holder cpu information in the lock helps debugging and
+	  crash dump analysis. There might be a very slight performance
+	  overhead in enabling this option.
+
 # Select if the architecture has support for applying RELR relocations.
 config ARCH_HAS_RELR
 	bool
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 159622ee0674..9897aedea660 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -7,8 +7,11 @@
  * registers. For i386, however, only 1 32-bit register needs to be saved
  * and restored. So an optimized version of __pv_queued_spin_unlock() is
  * hand-coded for 64-bit, but it isn't worthwhile to do it for 32-bit.
+ *
+ * Accessing percpu variable when QUEUED_SPINLOCKS_CPUINFO is defined is
+ * tricky. So disable this optimization for now.
  */
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(CONFIG_QUEUED_SPINLOCKS_CPUINFO)
 
 PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
@@ -26,13 +29,13 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *
  *	if (likely(lockval == _Q_LOCKED_VAL))
  *		return;
- *	pv_queued_spin_unlock_slowpath(lock, lockval);
+ *	__pv_queued_spin_unlock_slowpath(lock, lockval);
  * }
  *
  * For x86-64,
  *   rdi = lock              (first argument)
  *   rsi = lockval           (second argument)
- *   rdx = internal variable (set to 0)
+ *   rdx = internal variable for cmpxchg
  */
 asm    (".pushsection .text;"
 	".globl " PV_UNLOCK ";"
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fde943d180e0..d5badc1e544e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -12,6 +12,13 @@
 
 #include <asm-generic/qspinlock_types.h>
 
+#ifdef CONFIG_QUEUED_SPINLOCKS_CPUINFO
+DECLARE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval);
+#define QUEUED_LOCKED_VAL	this_cpu_read(pcpu_lockval)
+#else
+#define QUEUED_LOCKED_VAL	_Q_LOCKED_VAL
+#endif
+
 /**
  * queued_spin_is_locked - is the spinlock locked?
  * @lock: Pointer to queued spinlock structure
@@ -20,7 +27,7 @@
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
-	 * Any !0 state indicates it is locked, even if _Q_LOCKED_VAL
+	 * Any !0 state indicates it is locked, even if QUEUED_LOCKED_VAL
 	 * isn't immediately observable.
 	 */
 	return atomic_read(&lock->val);
@@ -62,7 +69,7 @@ static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 	if (unlikely(val))
 		return 0;
 
-	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, QUEUED_LOCKED_VAL));
 }
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
@@ -75,7 +82,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
 	u32 val = 0;
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, QUEUED_LOCKED_VAL)))
 		return;
 
 	queued_spin_lock_slowpath(lock, val);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 13feefa85db4..5d297901dda5 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -106,7 +106,10 @@ struct qnode {
  * PV doubles the storage and uses the second cacheline for PV state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
-static DEFINE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval) = _Q_LOCKED_VAL;
+DEFINE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval) = _Q_LOCKED_VAL;
+#ifdef CONFIG_QUEUED_SPINLOCKS_CPUINFO
+EXPORT_PER_CPU_SYMBOL(pcpu_lockval);
+#endif
 
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..d198916944c6 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -21,7 +21,7 @@
  * native_queued_spin_unlock().
  */
 
-#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
+#define _Q_SLOW_VAL	(255U << _Q_LOCKED_OFFSET)
 
 /*
  * Queue Node Adaptive Spinning
@@ -80,6 +80,8 @@ struct pv_node {
 #define queued_spin_trylock(l)	pv_hybrid_queued_unfair_trylock(l)
 static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 {
+	u8 lockval = QUEUED_LOCKED_VAL;
+
 	/*
 	 * Stay in unfair lock mode as long as queued mode waiters are
 	 * present in the MCS wait queue but the pending bit isn't set.
@@ -88,7 +90,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 		int val = atomic_read(&lock->val);
 
 		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+		   (cmpxchg_acquire(&lock->locked, 0, lockval) == 0)) {
 			lockevent_inc(pv_lock_stealing);
 			return true;
 		}
@@ -112,15 +114,15 @@ static __always_inline void set_pending(struct qspinlock *lock)
 }
 
 /*
- * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
+ * The pending bit check in pv_hybrid_queued_unfair_trylock() isn't a memory
  * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
  * lock just to be sure that it will get it.
  */
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline int trylock_clear_pending(struct qspinlock *lock, u8 lockval)
 {
 	return !READ_ONCE(lock->locked) &&
 	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
-				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
+				lockval) == _Q_PENDING_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
 static __always_inline void set_pending(struct qspinlock *lock)
@@ -128,7 +130,7 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline int trylock_clear_pending(struct qspinlock *lock, u8 lockval)
 {
 	int val = atomic_read(&lock->val);
 
@@ -142,7 +144,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 		 * Try to clear pending bit & set locked bit
 		 */
 		old = val;
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+		new = (val & ~_Q_PENDING_MASK) | lockval;
 		val = atomic_cmpxchg_acquire(&lock->val, old, new);
 
 		if (val == old)
@@ -280,9 +282,8 @@ static void pv_init_node(struct mcs_spinlock *node)
 	struct pv_node *pn = (struct pv_node *)node;
 
 	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
-
-	pn->cpu = smp_processor_id();
 	pn->state = vcpu_running;
+	pn->cpu = smp_processor_id();
 }
 
 /*
@@ -406,6 +407,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
+	u8 lockval = QUEUED_LOCKED_VAL;
 
 	/*
 	 * If pv_kick_node() already advanced our state, we don't need to
@@ -432,7 +434,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 */
 		set_pending(lock);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
-			if (trylock_clear_pending(lock))
+			if (trylock_clear_pending(lock, lockval))
 				goto gotlock;
 			cpu_relax();
 		}
@@ -459,7 +461,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 				 * Change the lock value back to _Q_LOCKED_VAL
 				 * and unhash the table.
 				 */
-				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+				WRITE_ONCE(lock->locked, lockval);
 				WRITE_ONCE(*lp, NULL);
 				goto gotlock;
 			}
@@ -477,12 +479,10 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 
 	/*
 	 * The cmpxchg() or xchg() call before coming here provides the
-	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
-	 * here is to indicate to the compiler that the value will always
-	 * be nozero to enable better code optimization.
+	 * acquire semantics for locking.
 	 */
 gotlock:
-	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
+	return (u32)atomic_read(&lock->val);
 }
 
 /*
@@ -495,9 +495,10 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	struct pv_node *node;
 
 	if (unlikely(locked != _Q_SLOW_VAL)) {
-		WARN(!debug_locks_silent,
+		WARN_ONCE(!debug_locks_silent,
 		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
 		     (unsigned long)lock, atomic_read(&lock->val));
+		smp_store_release(&lock->locked, 0);
 		return;
 	}
 
@@ -546,15 +547,15 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	u8 locked;
-
 	/*
 	 * We must not unlock if SLOW, because in that case we must first
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
+	u8 lockval = QUEUED_LOCKED_VAL;
+	u8 locked = cmpxchg_release(&lock->locked, lockval, 0);
+
+	if (likely(locked == lockval))
 		return;
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
-- 
2.18.1

