Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96738222BF7
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGPTbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:31:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56399 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729675AbgGPTbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594927866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=4G03ao0IqhS+yawog6tsoUqq/BT2hKG9U4PF9Ly9ods=;
        b=TgAphQuya6Ei/EukxyPFedoT71XCJNK2gcovzuBAy/dJ3w3lAV4QjTJ5FILJ61SWtauo83
        /7FgoTrSHhnfBlGp91U21+7rYQLcfE5P5HoPUnyNCrxw+77xxtyqeuL+qXfRgM1VKjJuk2
        nA21wYwYgYB5jYOCSFcPxQ3iDfezm0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-5c7_pQlqNqi8Me3SVB25hw-1; Thu, 16 Jul 2020 15:30:56 -0400
X-MC-Unique: 5c7_pQlqNqi8Me3SVB25hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C94C91940920;
        Thu, 16 Jul 2020 19:30:54 +0000 (UTC)
Received: from llong.com (ovpn-119-61.rdu2.redhat.com [10.10.119.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9DBA74F70;
        Thu, 16 Jul 2020 19:30:53 +0000 (UTC)
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
Subject: [PATCH v2 3/5] locking/qspinlock: Pass lock value as function argument
Date:   Thu, 16 Jul 2020 15:29:25 -0400
Message-Id: <20200716192927.12944-4-longman@redhat.com>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update the various internal qspinlock functions to pass in the lock
value to be used as a function argument instead of hardcoding it to
_Q_LOCKED_VAL. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c          | 19 ++++++++++---------
 kernel/locking/qspinlock_paravirt.h | 24 +++++++++++++-----------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b256e2d03817..527601eab7bf 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -158,9 +158,9 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  *
  * Lock stealing is not allowed if this function is used.
  */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock, const u8 lockval)
 {
-	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked_pending, lockval);
 }
 
 /*
@@ -202,9 +202,9 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  *
  * *,1,0 -> *,0,1
  */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock, const u8 lockval)
 {
-	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+	atomic_add(-_Q_PENDING_VAL + lockval, &lock->val);
 }
 
 /**
@@ -258,9 +258,9 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
  *
  * *,*,0 -> *,0,1
  */
-static __always_inline void set_locked(struct qspinlock *lock)
+static __always_inline void set_locked(struct qspinlock *lock, const u8 lockval)
 {
-	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked, lockval);
 }
 
 
@@ -317,6 +317,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
 	int idx;
+	const u8 lockval = _Q_LOCKED_VAL;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -386,7 +387,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
-	clear_pending_set_locked(lock);
+	clear_pending_set_locked(lock, lockval);
 	lockevent_inc(lock_pending);
 	return;
 
@@ -529,7 +530,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, lockval))
 			goto release; /* No contention */
 	}
 
@@ -538,7 +539,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * which will then detect the remaining tail and queue behind us
 	 * ensuring we'll see a @next.
 	 */
-	set_locked(lock);
+	set_locked(lock, lockval);
 
 	/*
 	 * contended path; wait for next if not observed yet, release.
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 17878e531f51..c8558876fc69 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -80,6 +80,8 @@ struct pv_node {
 #define queued_spin_trylock(l)	pv_hybrid_queued_unfair_trylock(l)
 static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 {
+	const u8 lockval = _Q_LOCKED_VAL;
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
+static __always_inline int trylock_clear_pending(struct qspinlock *lock, const u8 lockval)
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
+static __always_inline int trylock_clear_pending(struct qspinlock *lock, const u8 lockval)
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
@@ -406,6 +408,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
+	const u8 lockval = _Q_LOCKED_VAL;
 
 	/*
 	 * If pv_kick_node() already advanced our state, we don't need to
@@ -432,7 +435,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 */
 		set_pending(lock);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
-			if (trylock_clear_pending(lock))
+			if (trylock_clear_pending(lock, lockval))
 				goto gotlock;
 			cpu_relax();
 		}
@@ -459,7 +462,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 				 * Change the lock value back to _Q_LOCKED_VAL
 				 * and unhash the table.
 				 */
-				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+				WRITE_ONCE(lock->locked, lockval);
 				WRITE_ONCE(*lp, NULL);
 				goto gotlock;
 			}
@@ -544,14 +547,13 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
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
+	u8 locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
+
 	if (likely(locked == _Q_LOCKED_VAL))
 		return;
 
-- 
2.18.1

