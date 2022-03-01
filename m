Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860B4C8000
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiCABFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiCABFF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:05:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3DD0076;
        Mon, 28 Feb 2022 17:04:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso778326pjb.4;
        Mon, 28 Feb 2022 17:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3mjWWtnWgZ4Cp3dmXaVNszTfT+EcKE+NFcUN6juSww=;
        b=c5pBuFrzTEj/W2MOwFc215Jh+fETy7HWn/8+8Kb8dOFNxgUJkCorLOVwlmCNw4Cx/b
         1t7JDRZ0SAqKa/+/gBtPVUJQLmFbg6Uk361SPrWRbT1kVUx+SRsUOErnms6ti8g/88dw
         SD74lDYg+0+2PzOO7Jxix8zLhU0pWjBH44Xjxc0AXQS53QwFFHmwMsn8XFiipJ0KWh0l
         2UNjYwTOmCsnzJd4KGZxMa+kErfvNVXcm9vJuUJpjYPUz0F6UQX3URn6G+fRsJ2RjTdn
         fUWcilVvJKY/fpRbrL9Qy4XiUWRxcUjXrvhqwiKpQAq4LGUYFAdsREL2THjy5jryonXj
         mZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=e3mjWWtnWgZ4Cp3dmXaVNszTfT+EcKE+NFcUN6juSww=;
        b=F4oJaA6shahtqKQBT3ePLJKMs1ds9ALSq1rKKhfw+MhfPlzxRTb13huZ/VAJvBQddX
         9nshEV26RSnB07OvXbDeICS/mzq8fqIxDfJpkytVRiHmfys0t/vO3+WeEiI08EP7sv7G
         GKX5vR+9uBUTq7cG5D+K7S6jvDZhgqvGKVtF++WCT5lg3lKFbLbbTQsY2SLVtl/LVHIF
         HArjy7UBZffjXqDV1IhfmpPIqo8tXO1D8VrTEjGk0aeme2xeG83DHq/5vumL5gLZaxhs
         dmKUu2ZhAdl49lM6sLPBoE/E/Tv+rZwinT8TwfqOxq0ZG/LvQ3GstZeVbCcgbXgW+uJL
         96Wg==
X-Gm-Message-State: AOAM533nuGbZPUI6y2COONJ7peNokaRGnQxchx80i1qsAfO7Bsgi9MAx
        mPEiYYVCQJ/auamA9J2rvblSD6/v28k=
X-Google-Smtp-Source: ABdhPJyq+TBrS+sYb8zCNrTKowKRQLey/6xDnCndrQ7EaPRHK0foCRd7WJ9GqjANzWx5C/IlNDf6jg==
X-Received: by 2002:a17:90b:1104:b0:1b8:b90b:22c7 with SMTP id gi4-20020a17090b110400b001b8b90b22c7mr19571738pjb.45.1646096664401;
        Mon, 28 Feb 2022 17:04:24 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:726c:585a:8796:a60a])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm83861pjb.57.2022.02.28.17.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:04:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: [PATCH 2/4] locking: Apply contention tracepoints in the slow path
Date:   Mon, 28 Feb 2022 17:04:10 -0800
Message-Id: <20220301010412.431299-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
In-Reply-To: <20220301010412.431299-1-namhyung@kernel.org>
References: <20220301010412.431299-1-namhyung@kernel.org>
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
 include/asm-generic/qrwlock.h   |  5 +++++
 include/asm-generic/qspinlock.h |  3 +++
 include/trace/events/lock.h     |  1 +
 kernel/locking/mutex.c          |  4 ++++
 kernel/locking/percpu-rwsem.c   | 11 ++++++++++-
 kernel/locking/rtmutex.c        | 12 +++++++++++-
 kernel/locking/rwbase_rt.c      | 11 ++++++++++-
 kernel/locking/rwsem.c          | 16 ++++++++++++++--
 8 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..9735c39b05bb 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <asm/barrier.h>
 #include <asm/processor.h>
+#include <linux/lock_trace.h>
 
 #include <asm-generic/qrwlock_types.h>
 
@@ -80,7 +81,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
 		return;
 
 	/* The slowpath will decrement the reader count, if necessary. */
+	LOCK_CONTENTION_BEGIN(lock, LCB_F_READ);
 	queued_read_lock_slowpath(lock);
+	LOCK_CONTENTION_END(lock);
 }
 
 /**
@@ -94,7 +97,9 @@ static inline void queued_write_lock(struct qrwlock *lock)
 	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
 
+	LOCK_CONTENTION_BEGIN(lock, LCB_F_WRITE);
 	queued_write_lock_slowpath(lock);
+	LOCK_CONTENTION_END(lock);
 }
 
 /**
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..986b96fadbf9 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -12,6 +12,7 @@
 
 #include <asm-generic/qspinlock_types.h>
 #include <linux/atomic.h>
+#include <linux/lock_trace.h>
 
 #ifndef queued_spin_is_locked
 /**
@@ -82,7 +83,9 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 
+	LOCK_CONTENTION_BEGIN(lock, 0);
 	queued_spin_lock_slowpath(lock, val);
+	LOCK_CONTENTION_END(lock);
 }
 #endif
 
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 7bca0a537dbd..9b285083f88f 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -6,6 +6,7 @@
 #define _TRACE_LOCK_H
 
 #include <linux/tracepoint.h>
+#include <linux/lock_trace.h>
 
 #ifdef CONFIG_LOCKDEP
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e3585950ec8..756624c14dfd 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,6 +30,8 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#include <trace/events/lock.h>
+
 #ifndef CONFIG_PREEMPT_RT
 #include "mutex.h"
 
@@ -626,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
+	trace_contention_begin(lock, ip, state);
 
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
@@ -688,6 +691,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 	raw_spin_lock(&lock->wait_lock);
 acquired:
+	trace_contention_end(lock);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index c9fdae94e098..4049b79b3dcc 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/errno.h>
+#include <trace/events/lock.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
@@ -171,9 +172,12 @@ bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 	if (try)
 		return false;
 
+	trace_contention_begin(sem, _RET_IP_,
+			       LCB_F_READ | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE);
 	preempt_enable();
 	percpu_rwsem_wait(sem, /* .reader = */ true);
 	preempt_disable();
+	trace_contention_end(sem);
 
 	return true;
 }
@@ -224,8 +228,13 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 	 * Try set sem->block; this provides writer-writer exclusion.
 	 * Having sem->block set makes new readers block.
 	 */
-	if (!__percpu_down_write_trylock(sem))
+	if (!__percpu_down_write_trylock(sem)) {
+		unsigned int flags = LCB_F_WRITE | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE;
+
+		trace_contention_begin(sem, _RET_IP_, flags);
 		percpu_rwsem_wait(sem, /* .reader = */ false);
+		trace_contention_end(sem);
+	}
 
 	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8555c4efe97c..e49f5d2a232b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -24,6 +24,8 @@
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
 
+#include <trace/events/lock.h>
+
 #include "rtmutex_common.h"
 
 #ifndef WW_RT
@@ -1652,10 +1654,16 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	int ret;
+
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, NULL, state);
+	trace_contention_begin(lock, _RET_IP_, LCB_F_RT | state);
+	ret = rt_mutex_slowlock(lock, NULL, state);
+	trace_contention_end(lock);
+
+	return ret;
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
 
@@ -1718,9 +1726,11 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
 {
 	unsigned long flags;
 
+	trace_contention_begin(lock, _RET_IP_, LCB_F_RT | TASK_RTLOCK_WAIT);
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	rtlock_slowlock_locked(lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	trace_contention_end(lock);
 }
 
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 6fd3162e4098..8a28f1195c58 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -136,10 +136,16 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	int ret;
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
-	return __rwbase_read_lock(rwb, state);
+	trace_contention_begin(rwb, _RET_IP_, LCB_F_READ | LCB_F_RT | state);
+	ret = __rwbase_read_lock(rwb, state);
+	trace_contention_end(rwb);
+
+	return ret;
 }
 
 static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
@@ -246,12 +252,14 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	if (__rwbase_write_trylock(rwb))
 		goto out_unlock;
 
+	trace_contention_begin(rwb, _RET_IP_, LCB_F_WRITE | LCB_F_RT | state);
 	rwbase_set_and_save_current_state(state);
 	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			trace_contention_end(rwb);
 			return -EINTR;
 		}
 
@@ -265,6 +273,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		set_current_state(state);
 	}
 	rwbase_restore_current_state();
+	trace_contention_end(rwb);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acde5d6f1254..a1a17af7f747 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <trace/events/lock.h>
 
 #ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
@@ -1209,9 +1210,14 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	long count;
+	void *ret;
 
 	if (!rwsem_read_trylock(sem, &count)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state)))
+		trace_contention_begin(sem, _RET_IP_, LCB_F_READ | state);
+		ret = rwsem_down_read_slowpath(sem, count, state);
+		trace_contention_end(sem);
+
+		if (IS_ERR(ret))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	}
@@ -1255,8 +1261,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
+	void *ret;
+
 	if (unlikely(!rwsem_write_trylock(sem))) {
-		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
+		trace_contention_begin(sem, _RET_IP_, LCB_F_WRITE | state);
+		ret = rwsem_down_write_slowpath(sem, state);
+		trace_contention_end(sem);
+
+		if (IS_ERR(ret))
 			return -EINTR;
 	}
 
-- 
2.35.1.574.g5d30c73bfb-goog

