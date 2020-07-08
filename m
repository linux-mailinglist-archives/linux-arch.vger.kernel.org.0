Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C863217D98
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGHDeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 23:34:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729296AbgGHDd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 23:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594179234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqvBuIYke73bHM6ud+NpNIQKbqS2mnO5rw5gzCa8ZTo=;
        b=GaBH8hWPkUzXn3dmoKCJwMqXDXZ02nRKsp5UP6gpg3Ar9Rmo3qr4D9cJSPjgrpJ1LUq6PJ
        /ccyOO2nm8zMVKlPu4LmD4kF5E/bZMb6RlWUdkJ4+ya6D8fm00gZ88y6VES6bPWA0La1nP
        SyEUFRUU+lFNf/NSLfH3JPrLWUqK1Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-ujwpOIjjPvumdDCL-IeCzg-1; Tue, 07 Jul 2020 23:33:49 -0400
X-MC-Unique: ujwpOIjjPvumdDCL-IeCzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B4318A0760;
        Wed,  8 Jul 2020 03:33:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-81.rdu2.redhat.com [10.10.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9A6671662;
        Wed,  8 Jul 2020 03:33:45 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Date:   Tue, 7 Jul 2020 23:33:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1594101082.hfq9x5yact.astroid@bobo.none>
Content-Type: multipart/mixed;
 boundary="------------40473F93CD0C6D6973E234D5"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------40473F93CD0C6D6973E234D5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/20 1:57 AM, Nicholas Piggin wrote:
> Yes, powerpc could certainly get more performance out of the slow
> paths, and then there are a few parameters to tune.
>
> We don't have a good alternate patching for function calls yet, but
> that would be something to do for native vs pv.
>
> And then there seem to be one or two tunable parameters we could
> experiment with.
>
> The paravirt locks may need a bit more tuning. Some simple testing
> under KVM shows we might be a bit slower in some cases. Whether this
> is fairness or something else I'm not sure. The current simple pv
> spinlock code can do a directed yield to the lock holder CPU, whereas
> the pv qspl here just does a general yield. I think we might actually
> be able to change that to also support directed yield. Though I'm
> not sure if this is actually the cause of the slowdown yet.

Regarding the paravirt lock, I have taken a further look into the 
current PPC spinlock code. There is an equivalent of pv_wait() but no 
pv_kick(). Maybe PPC doesn't really need that. Attached are two 
additional qspinlock patches that adds a CONFIG_PARAVIRT_QSPINLOCKS_LITE 
option to not require pv_kick(). There is also a fixup patch to be 
applied after your patchset.

I don't have access to a PPC LPAR with shared processor at the moment, 
so I can't test the performance of the paravirt code. Would you mind 
adding my patches and do some performance test on your end to see if it 
gives better result?

Thanks,
Longman


--------------40473F93CD0C6D6973E234D5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-locking-pvqspinlock-Code-relocation-and-extraction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-locking-pvqspinlock-Code-relocation-and-extraction.patc";
 filename*1="h"

From 161e545523a7eb4c42c145c04e9a5a15903ba3d9 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 7 Jul 2020 20:46:51 -0400
Subject: [PATCH 1/9] locking/pvqspinlock: Code relocation and extraction

Move pv_kick_node() and the unlock functions up and extract out the hash
and lock code from pv_wait_head_or_lock() into pv_hash_lock(). There
is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_paravirt.h | 302 ++++++++++++++--------------
 1 file changed, 156 insertions(+), 146 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..8eec58320b85 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -55,6 +55,7 @@ struct pv_node {
 
 /*
  * Hybrid PV queued/unfair lock
+ * ----------------------------
  *
  * By replacing the regular queued_spin_trylock() with the function below,
  * it will be called once when a lock waiter enter the PV slowpath before
@@ -259,6 +260,156 @@ static struct pv_node *pv_unhash(struct qspinlock *lock)
 	BUG();
 }
 
+/*
+ * Insert lock into hash and set _Q_SLOW_VAL.
+ * Return true if lock acquired.
+ */
+static inline bool pv_hash_lock(struct qspinlock *lock, struct pv_node *node)
+{
+	struct qspinlock **lp = pv_hash(lock, node);
+
+	/*
+	 * We must hash before setting _Q_SLOW_VAL, such that
+	 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
+	 * we'll be sure to be able to observe our hash entry.
+	 *
+	 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
+	 *       MB                           RMB
+	 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
+	 *
+	 * Matches the smp_rmb() in __pv_queued_spin_unlock().
+	 */
+	if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
+		/*
+		 * The lock was free and now we own the lock.
+		 * Change the lock value back to _Q_LOCKED_VAL
+		 * and unhash the table.
+		 */
+		WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+		WRITE_ONCE(*lp, NULL);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Called after setting next->locked = 1 when we're the lock owner.
+ *
+ * Instead of waking the waiters stuck in pv_wait_node() advance their state
+ * such that they're waiting in pv_wait_head_or_lock(), this avoids a
+ * wake/sleep cycle.
+ */
+static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
+{
+	struct pv_node *pn = (struct pv_node *)node;
+
+	/*
+	 * If the vCPU is indeed halted, advance its state to match that of
+	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
+	 * observe its next->locked value and advance itself.
+	 *
+	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
+	 *
+	 * The write to next->locked in arch_mcs_spin_unlock_contended()
+	 * must be ordered before the read of pn->state in the cmpxchg()
+	 * below for the code to work correctly. To guarantee full ordering
+	 * irrespective of the success or failure of the cmpxchg(),
+	 * a relaxed version with explicit barrier is used. The control
+	 * dependency will order the reading of pn->state before any
+	 * subsequent writes.
+	 */
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
+	    != vcpu_halted)
+		return;
+
+	/*
+	 * Put the lock into the hash table and set the _Q_SLOW_VAL.
+	 *
+	 * As this is the same vCPU that will check the _Q_SLOW_VAL value and
+	 * the hash table later on at unlock time, no atomic instruction is
+	 * needed.
+	 */
+	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
+	(void)pv_hash(lock, pn);
+}
+
+/*
+ * PV versions of the unlock fastpath and slowpath functions to be used
+ * instead of queued_spin_unlock().
+ */
+__visible void
+__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
+{
+	struct pv_node *node;
+
+	if (unlikely(locked != _Q_SLOW_VAL)) {
+		WARN(!debug_locks_silent,
+		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
+		     (unsigned long)lock, atomic_read(&lock->val));
+		return;
+	}
+
+	/*
+	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
+	 * so we need a barrier to order the read of the node data in
+	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
+	 *
+	 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
+	 */
+	smp_rmb();
+
+	/*
+	 * Since the above failed to release, this must be the SLOW path.
+	 * Therefore start by looking up the blocked node and unhashing it.
+	 */
+	node = pv_unhash(lock);
+
+	/*
+	 * Now that we have a reference to the (likely) blocked pv_node,
+	 * release the lock.
+	 */
+	smp_store_release(&lock->locked, 0);
+
+	/*
+	 * At this point the memory pointed at by lock can be freed/reused,
+	 * however we can still use the pv_node to kick the CPU.
+	 * The other vCPU may not really be halted, but kicking an active
+	 * vCPU is harmless other than the additional latency in completing
+	 * the unlock.
+	 */
+	lockevent_inc(pv_kick_unlock);
+	pv_kick(node->cpu);
+}
+
+/*
+ * Include the architecture specific callee-save thunk of the
+ * __pv_queued_spin_unlock(). This thunk is put together with
+ * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
+ * function close to each other sharing consecutive instruction cachelines.
+ * Alternatively, architecture specific version of __pv_queued_spin_unlock()
+ * can be defined.
+ */
+#include <asm/qspinlock_paravirt.h>
+
+#ifndef __pv_queued_spin_unlock
+__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	u8 locked;
+
+	/*
+	 * We must not unlock if SLOW, because in that case we must first
+	 * unhash. Otherwise it would be possible to have multiple @lock
+	 * entries, which would be BAD.
+	 */
+	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
+	if (likely(locked == _Q_LOCKED_VAL))
+		return;
+
+	__pv_queued_spin_unlock_slowpath(lock, locked);
+}
+#endif /* __pv_queued_spin_unlock */
+
 /*
  * Return true if when it is time to check the previous node which is not
  * in a running state.
@@ -350,48 +501,6 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 	 */
 }
 
-/*
- * Called after setting next->locked = 1 when we're the lock owner.
- *
- * Instead of waking the waiters stuck in pv_wait_node() advance their state
- * such that they're waiting in pv_wait_head_or_lock(), this avoids a
- * wake/sleep cycle.
- */
-static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
-{
-	struct pv_node *pn = (struct pv_node *)node;
-
-	/*
-	 * If the vCPU is indeed halted, advance its state to match that of
-	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
-	 * observe its next->locked value and advance itself.
-	 *
-	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
-	 *
-	 * The write to next->locked in arch_mcs_spin_unlock_contended()
-	 * must be ordered before the read of pn->state in the cmpxchg()
-	 * below for the code to work correctly. To guarantee full ordering
-	 * irrespective of the success or failure of the cmpxchg(),
-	 * a relaxed version with explicit barrier is used. The control
-	 * dependency will order the reading of pn->state before any
-	 * subsequent writes.
-	 */
-	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
-	    != vcpu_halted)
-		return;
-
-	/*
-	 * Put the lock into the hash table and set the _Q_SLOW_VAL.
-	 *
-	 * As this is the same vCPU that will check the _Q_SLOW_VAL value and
-	 * the hash table later on at unlock time, no atomic instruction is
-	 * needed.
-	 */
-	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
-	(void)pv_hash(lock, pn);
-}
-
 /*
  * Wait for l->locked to become clear and acquire the lock;
  * halt the vcpu after a short spin.
@@ -403,16 +512,13 @@ static u32
 pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
-
 	/*
-	 * If pv_kick_node() already advanced our state, we don't need to
+	 * If pv_kick_node() had already advanced our state, we don't need to
 	 * insert ourselves into the hash table anymore.
 	 */
-	if (READ_ONCE(pn->state) == vcpu_hashed)
-		lp = (struct qspinlock **)1;
+	bool hashed = (READ_ONCE(pn->state) == vcpu_hashed);
 
 	/*
 	 * Tracking # of slowpath locking operations
@@ -439,30 +545,10 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		clear_pending(lock);
 
 
-		if (!lp) { /* ONCE */
-			lp = pv_hash(lock, pn);
-
-			/*
-			 * We must hash before setting _Q_SLOW_VAL, such that
-			 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
-			 * we'll be sure to be able to observe our hash entry.
-			 *
-			 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
-			 *       MB                           RMB
-			 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
-			 *
-			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
-			 */
-			if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
-				/*
-				 * The lock was free and now we own the lock.
-				 * Change the lock value back to _Q_LOCKED_VAL
-				 * and unhash the table.
-				 */
-				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
-				WRITE_ONCE(*lp, NULL);
+		if (!hashed) {	/* ONCE */
+			if (pv_hash_lock(lock, pn))
 				goto gotlock;
-			}
+			hashed = true;
 		}
 		WRITE_ONCE(pn->state, vcpu_hashed);
 		lockevent_inc(pv_wait_head);
@@ -484,79 +570,3 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 gotlock:
 	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
 }
-
-/*
- * PV versions of the unlock fastpath and slowpath functions to be used
- * instead of queued_spin_unlock().
- */
-__visible void
-__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
-{
-	struct pv_node *node;
-
-	if (unlikely(locked != _Q_SLOW_VAL)) {
-		WARN(!debug_locks_silent,
-		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
-		     (unsigned long)lock, atomic_read(&lock->val));
-		return;
-	}
-
-	/*
-	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
-	 * so we need a barrier to order the read of the node data in
-	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
-	 *
-	 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
-	 */
-	smp_rmb();
-
-	/*
-	 * Since the above failed to release, this must be the SLOW path.
-	 * Therefore start by looking up the blocked node and unhashing it.
-	 */
-	node = pv_unhash(lock);
-
-	/*
-	 * Now that we have a reference to the (likely) blocked pv_node,
-	 * release the lock.
-	 */
-	smp_store_release(&lock->locked, 0);
-
-	/*
-	 * At this point the memory pointed at by lock can be freed/reused,
-	 * however we can still use the pv_node to kick the CPU.
-	 * The other vCPU may not really be halted, but kicking an active
-	 * vCPU is harmless other than the additional latency in completing
-	 * the unlock.
-	 */
-	lockevent_inc(pv_kick_unlock);
-	pv_kick(node->cpu);
-}
-
-/*
- * Include the architecture specific callee-save thunk of the
- * __pv_queued_spin_unlock(). This thunk is put together with
- * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
- * function close to each other sharing consecutive instruction cachelines.
- * Alternatively, architecture specific version of __pv_queued_spin_unlock()
- * can be defined.
- */
-#include <asm/qspinlock_paravirt.h>
-
-#ifndef __pv_queued_spin_unlock
-__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
-{
-	u8 locked;
-
-	/*
-	 * We must not unlock if SLOW, because in that case we must first
-	 * unhash. Otherwise it would be possible to have multiple @lock
-	 * entries, which would be BAD.
-	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
-		return;
-
-	__pv_queued_spin_unlock_slowpath(lock, locked);
-}
-#endif /* __pv_queued_spin_unlock */
-- 
2.18.1


--------------40473F93CD0C6D6973E234D5
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-locking-pvqspinlock-Introduce-CONFIG_PARAVIRT_QSPINL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-locking-pvqspinlock-Introduce-CONFIG_PARAVIRT_QSPINL.pa";
 filename*1="tch"

From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 7 Jul 2020 22:29:16 -0400
Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
 CONFIG_PARAVIRT_QSPINLOCKS_LITE

Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
architectures to use the PV qspinlock code without the need to use or
implement a pv_kick() function, thus eliminating the atomic unlock
overhead. The non-atomic queued_spin_unlock() can be used instead.
The pv_wait() function will still be needed, but it can be a dummy
function.

With that option set, the hybrid PV queued/unfair locking code should
still be able to make it performant enough in a paravirtualized
environment.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/Kconfig.locks                |  4 +++
 kernel/locking/lock_events_list.h   |  3 ++
 kernel/locking/qspinlock_paravirt.h | 49 ++++++++++++++++++++++++-----
 kernel/locking/qspinlock_stat.h     |  5 +--
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..1824ba8c44a9 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -243,6 +243,10 @@ config QUEUED_SPINLOCKS
 	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
 	depends on SMP
 
+config PARAVIRT_QSPINLOCKS_LITE
+	bool
+	depends on QUEUED_SPINLOCKS && PARAVIRT_SPINLOCKS
+
 config BPF_ARCH_SPINLOCK
 	bool
 
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..9ae07a7148e8 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -22,11 +22,14 @@
 /*
  * Locking events for PV qspinlock.
  */
+#ifndef CONFIG_PARAVIRT_QSPINLOCKS_LITE
 LOCK_EVENT(pv_hash_hops)	/* Average # of hops per hashing operation */
 LOCK_EVENT(pv_kick_unlock)	/* # of vCPU kicks issued at unlock time   */
 LOCK_EVENT(pv_kick_wake)	/* # of vCPU kicks for pv_latency_wake	   */
 LOCK_EVENT(pv_latency_kick)	/* Average latency (ns) of vCPU kick	   */
 LOCK_EVENT(pv_latency_wake)	/* Average latency (ns) of kick-to-wakeup  */
+#endif
+
 LOCK_EVENT(pv_lock_stealing)	/* # of lock stealing operations	   */
 LOCK_EVENT(pv_spurious_wakeup)	/* # of spurious wakeups in non-head vCPUs */
 LOCK_EVENT(pv_wait_again)	/* # of wait's after queue head vCPU kick  */
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 8eec58320b85..2d24563aa9b9 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -77,6 +77,23 @@ struct pv_node {
  * This hybrid PV queued/unfair lock combines the best attributes of a
  * queued lock (no lock starvation) and an unfair lock (good performance
  * on not heavily contended locks).
+ *
+ * PV lock lite
+ * ------------
+ *
+ * By default, the PV lock uses two hypervisor specific functions pv_wait()
+ * and pv_kick() to release the vcpu back to the hypervisor and request the
+ * hypervisor to put the given vcpu online again respectively.
+ *
+ * The pv_kick() function is called at unlock time and requires the use of
+ * an atomic instruction to prevent missed wakeup. The unlock overhead of
+ * the PV lock is a major reason why the PV lock is slightly slower than
+ * the native lock. Not all the hypervisors need to really use both
+ * pv_wait() and pv_kick(). The PARAVIRT_QSPINLOCKS_LITE config option
+ * enables a lighter version of PV lock that relies mainly on the hybrid
+ * queued/unfair lock. The pv_wait() function will be used if provided.
+ * The pv_kick() function isn't used to eliminate the unlock overhead and
+ * the non-atomic queued_spin_unlock() can be used.
  */
 #define queued_spin_trylock(l)	pv_hybrid_queued_unfair_trylock(l)
 static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
@@ -153,6 +170,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 }
 #endif /* _Q_PENDING_BITS == 8 */
 
+#ifndef CONFIG_PARAVIRT_QSPINLOCKS_LITE
 /*
  * Lock and MCS node addresses hash table for fast lookup
  *
@@ -410,6 +428,29 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 }
 #endif /* __pv_queued_spin_unlock */
 
+static inline void set_pv_node_running(struct pv_node *pn)
+{
+	/*
+	 * If pv_kick_node() changed us to vcpu_hashed, retain that value so
+	 * that pv_wait_head_or_lock() will not try to hash this lock.
+	 */
+	cmpxchg(&pn->state, vcpu_halted, vcpu_running);
+}
+#else
+static inline bool pv_hash_lock(struct qspinlock *lock, struct pv_node *node)
+{
+	return false;
+}
+
+static inline void pv_kick_node(struct qspinlock *lock,
+				struct mcs_spinlock *node) { }
+
+static inline void set_pv_node_running(struct pv_node *pn)
+{
+	pn->state = vcpu_running;
+}
+#endif /* CONFIG_PARAVIRT_QSPINLOCKS_LITE */
+
 /*
  * Return true if when it is time to check the previous node which is not
  * in a running state.
@@ -475,13 +516,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 			lockevent_cond_inc(pv_wait_early, wait_early);
 			pv_wait(&pn->state, vcpu_halted);
 		}
-
-		/*
-		 * If pv_kick_node() changed us to vcpu_hashed, retain that
-		 * value so that pv_wait_head_or_lock() knows to not also try
-		 * to hash this lock.
-		 */
-		cmpxchg(&pn->state, vcpu_halted, vcpu_running);
+		set_pv_node_running(pn);
 
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index e625bb410aa2..e9f63240785b 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -7,7 +7,8 @@
 #include "lock_events.h"
 
 #ifdef CONFIG_LOCK_EVENT_COUNTS
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && \
+    !defined(CONFIG_PARAVIRT_QSPINLOCKS_LITE)
 /*
  * Collect pvqspinlock locking event counts
  */
@@ -133,7 +134,7 @@ static inline void __pv_wait(u8 *ptr, u8 val)
 #define pv_kick(c)	__pv_kick(c)
 #define pv_wait(p, v)	__pv_wait(p, v)
 
-#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+#endif /* CONFIG_PARAVIRT_SPINLOCKS && !CONFIG_PARAVIRT_QSPINLOCKS_LITE */
 
 #else /* CONFIG_LOCK_EVENT_COUNTS */
 
-- 
2.18.1


--------------40473F93CD0C6D6973E234D5
Content-Type: text/x-patch; charset=UTF-8;
 name="0009-powerpc-pseries-Fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0009-powerpc-pseries-Fixup.patch"

From 655d3a5d48a494a5674cf57454bf3e1f36b6eb83 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 7 Jul 2020 22:29:20 -0400
Subject: [PATCH 9/9] powerpc/pseries: Fixup

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/powerpc/include/asm/qspinlock.h   | 22 ----------------------
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 arch/powerpc/platforms/pseries/setup.c |  6 +-----
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index b752d34517b3..1fa724d27a2d 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -10,7 +10,6 @@
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_queued_spin_unlock(struct qspinlock *lock);
 
 static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
@@ -20,15 +19,6 @@ static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u3
 		__pv_queued_spin_lock_slowpath(lock, val);
 }
 
-#define queued_spin_unlock queued_spin_unlock
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	if (!is_shared_processor())
-		smp_store_release(&lock->locked, 0);
-	else
-		__pv_queued_spin_unlock(lock);
-}
-
 #else
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 #endif
@@ -72,18 +62,6 @@ static __always_inline void pv_wait(u8 *ptr, u8 val)
 	 */
 }
 
-static __always_inline void pv_kick(int cpu)
-{
-	prod_cpu(cpu);
-}
-
-extern void __pv_init_lock_hash(void);
-
-static inline void pv_spinlocks_init(void)
-{
-	__pv_init_lock_hash();
-}
-
 #endif
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 756e727b383f..1e3bbe27d664 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -33,6 +33,7 @@ config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
 	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
+	select PARAVIRT_QSPINLOCKS_LITE if PPC_QUEUED_SPINLOCKS
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 747a203d9453..2db8469e475f 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -771,12 +771,8 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca())) {
+		if (lppaca_shared_proc(get_lppaca()))
 			static_branch_enable(&shared_processor);
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-			pv_spinlocks_init();
-#endif
-		}
 
 		ppc_md.power_save = pseries_lpar_idle;
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
-- 
2.18.1


--------------40473F93CD0C6D6973E234D5--

