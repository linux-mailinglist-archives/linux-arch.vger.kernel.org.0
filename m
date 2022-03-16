Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30E4DBABD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiCPWrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCPWrQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 18:47:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32317AB6;
        Wed, 16 Mar 2022 15:46:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c2so1251067pga.10;
        Wed, 16 Mar 2022 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwEDDEJobGkNmiRYjqXq64WHLYJ5/paFbvAI6vzbTEw=;
        b=WSOjnn6pcFlNHew8Yfxxulx5PI5I5+KOVNLmo2Yb7G6G9gTiyihSejJPJmlAV9Hii4
         pi+1nAg+l4FbPfRGUD3ug/wVzbAWemC6jLm4g5/Pzn6aV5u9ltWwJ6dHwWHBbPejXbom
         ZYtYDcT/s896dlXqzI3lZ57JEqmPenKL5+3h0uIvIhDiBu/78DnEUgmk5UCvK/CcBsnX
         dqmgIwwVXrvXRio6FgfGAuUKH/kTlSscHRAwZyMiZC+EnsOTN6SPp8+8caJA7R1cLFA4
         tL9lo8E5nMStkVugfsQdfh+hn5XsBNBNeVHBGCGNvrA5n2YnISlBXcaLt4w0mOH2p3tw
         hY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VwEDDEJobGkNmiRYjqXq64WHLYJ5/paFbvAI6vzbTEw=;
        b=VvnLgcN4XIMj2DZIqOyy55LFdWxRQ48hBV/h6u6RvaKMpF73xtC1p1RGZK7IFzCB9Z
         fyLKwDysb1GSib1ASpwfUCGSD2RlL7Ml31p8M0uXsI6w68x6/yVSpQyJhFCgXylYkU1w
         TyDMovh5Cpk6He/lIYmXxuz5tDh3K24atOE6oofBWbu1MW+f82kzSDa7P3QpDyTOK5ZT
         1eLO6FLtUM3CXHenZNc7AgEkEJB7+k9sR/xAr+w2r4pf81+tFTFOGslHyRFZD/OfdWqP
         f8y65MBzGB/c7mYpq7NHchJMq1RGTdPhZ24p3D9GT5qjde7LzJnIGmhioWken6Lw4dm1
         jrgg==
X-Gm-Message-State: AOAM530OV3pTHYbfCtmZ2iREntv/wx6CnMQs2W0bKjLc0KAlRL59Rlsj
        aYsuOarZ5tzljBXCLLZsvZs=
X-Google-Smtp-Source: ABdhPJzTUccwATYE4P2rM1zaFpKWXdxokL4flpnseXPVJgWAtS/nhPMSO4rJPO9gjY6KEEvbfm8gHA==
X-Received: by 2002:a63:82c7:0:b0:37c:8729:a70c with SMTP id w190-20020a6382c7000000b0037c8729a70cmr1419597pgd.108.1647470760884;
        Wed, 16 Mar 2022 15:46:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:9b43:96ac:9f9:5093])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a088d00b001c64d30fa8bsm6397832pjc.1.2022.03.16.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:46:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
Date:   Wed, 16 Mar 2022 15:45:48 -0700
Message-Id: <20220316224548.500123-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220316224548.500123-1-namhyung@kernel.org>
References: <20220316224548.500123-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adding the lock contention tracepoints in various lock function slow
paths.  Note that each arch can define spinlock differently, I only
added it only to the generic qspinlock for now.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/mutex.c        |  3 +++
 kernel/locking/percpu-rwsem.c |  3 +++
 kernel/locking/qrwlock.c      |  9 +++++++++
 kernel/locking/qspinlock.c    |  5 +++++
 kernel/locking/rtmutex.c      | 11 +++++++++++
 kernel/locking/rwbase_rt.c    |  3 +++
 kernel/locking/rwsem.c        |  9 +++++++++
 kernel/locking/semaphore.c    | 14 +++++++++++++-
 8 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index ee2fd7614a93..c88deda77cf2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	set_current_state(state);
+	trace_contention_begin(lock, 0);
 	for (;;) {
 		bool first;
 
@@ -710,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 skip_wait:
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
+	trace_contention_end(lock, 0);
 
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
@@ -721,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 err:
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
+	trace_contention_end(lock, ret);
 err_early_kill:
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index c9fdae94e098..833043613af6 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/errno.h>
+#include <trace/events/lock.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
@@ -154,6 +155,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	}
 	spin_unlock_irq(&sem->waiters.lock);
 
+	trace_contention_begin(sem, LCB_F_PERCPU | (reader ? LCB_F_READ : LCB_F_WRITE));
 	while (wait) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!smp_load_acquire(&wq_entry.private))
@@ -161,6 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
+	trace_contention_end(sem, 0);
 }
 
 bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index ec36b73f4733..b9f6f963d77f 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -12,6 +12,7 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/spinlock.h>
+#include <trace/events/lock.h>
 
 /**
  * queued_read_lock_slowpath - acquire read lock of a queue rwlock
@@ -34,6 +35,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
 
+	trace_contention_begin(lock, LCB_F_READ | LCB_F_SPIN);
+
 	/*
 	 * Put the reader into the wait queue
 	 */
@@ -51,6 +54,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	 * Signal the next one in queue to become queue head
 	 */
 	arch_spin_unlock(&lock->wait_lock);
+
+	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_read_lock_slowpath);
 
@@ -62,6 +67,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	int cnts;
 
+	trace_contention_begin(lock, LCB_F_WRITE | LCB_F_SPIN);
+
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
@@ -79,5 +86,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
+
+	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_write_lock_slowpath);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..65a9a10caa6f 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -22,6 +22,7 @@
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
+#include <trace/events/lock.h>
 
 /*
  * Include queued spinlock statistics code
@@ -401,6 +402,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	trace_contention_begin(lock, LCB_F_SPIN);
+
 	/*
 	 * 4 nodes are allocated based on the assumption that there will
 	 * not be nested NMIs taking spinlocks. That may not be true in
@@ -554,6 +557,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	pv_kick_node(lock, next);
 
 release:
+	trace_contention_end(lock, 0);
+
 	/*
 	 * release the node
 	 */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8555c4efe97c..7779ee8abc2a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -24,6 +24,8 @@
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
 
+#include <trace/events/lock.h>
+
 #include "rtmutex_common.h"
 
 #ifndef WW_RT
@@ -1579,6 +1581,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	set_current_state(state);
 
+	trace_contention_begin(lock, LCB_F_RT);
+
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
 		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
@@ -1601,6 +1605,9 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+
+	trace_contention_end(lock, ret);
+
 	return ret;
 }
 
@@ -1683,6 +1690,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	/* Save current state and set state to TASK_RTLOCK_WAIT */
 	current_save_and_set_rtlock_wait_state();
 
+	trace_contention_begin(lock, LCB_F_RT);
+
 	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
 
 	for (;;) {
@@ -1712,6 +1721,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	 */
 	fixup_rt_mutex_waiters(lock);
 	debug_rt_mutex_free_waiter(&waiter);
+
+	trace_contention_end(lock, 0);
 }
 
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 6fd3162e4098..ec7b1fda7982 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -247,11 +247,13 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		goto out_unlock;
 
 	rwbase_set_and_save_current_state(state);
+	trace_contention_begin(rwb, LCB_F_WRITE | LCB_F_RT);
 	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
 
@@ -265,6 +267,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		set_current_state(state);
 	}
 	rwbase_restore_current_state();
+	trace_contention_end(rwb, 0);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acde5d6f1254..465db7bd84f8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <trace/events/lock.h>
 
 #ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
@@ -1014,6 +1015,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 
+	trace_contention_begin(sem, LCB_F_READ);
+
 	/* wait to be given the lock */
 	for (;;) {
 		set_current_state(state);
@@ -1035,6 +1038,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
+	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
@@ -1042,6 +1046,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
+	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
 }
 
@@ -1109,6 +1114,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
+	trace_contention_begin(sem, LCB_F_WRITE);
+
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
@@ -1148,6 +1155,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
+	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
@@ -1159,6 +1167,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
+	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
 }
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9ee381e4d2a4..e3c19668dfee 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -32,6 +32,7 @@
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
+#include <trace/events/lock.h>
 
 static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
@@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 								long timeout)
 {
 	struct semaphore_waiter waiter;
+	bool tracing = false;
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 	waiter.task = current;
@@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 		if (unlikely(timeout <= 0))
 			goto timed_out;
 		__set_current_state(state);
+		if (!tracing) {
+			trace_contention_begin(sem, 0);
+			tracing = true;
+		}
 		raw_spin_unlock_irq(&sem->lock);
 		timeout = schedule_timeout(timeout);
 		raw_spin_lock_irq(&sem->lock);
-		if (waiter.up)
+		if (waiter.up) {
+			trace_contention_end(sem, 0);
 			return 0;
+		}
 	}
 
  timed_out:
+	if (tracing)
+		trace_contention_end(sem, -ETIME);
 	list_del(&waiter.list);
 	return -ETIME;
 
  interrupted:
+	if (tracing)
+		trace_contention_end(sem, -EINTR);
 	list_del(&waiter.list);
 	return -EINTR;
 }
-- 
2.35.1.894.gb6a874cedc-goog

