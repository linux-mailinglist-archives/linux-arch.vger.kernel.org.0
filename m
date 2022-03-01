Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520C64C874F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiCAJFD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 04:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCAJFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 04:05:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E67ED83;
        Tue,  1 Mar 2022 01:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jd5F7P7PXYQdauJMDTmuMe8admyVYY+mS/WVsu1CbVc=; b=KXWMkoBoXptBxbWMTW49W8dU9K
        7JePlrJsk3xIX1k7nTxRhnLbFwgJxLZeYDdHSitecrS0NvcEvoGu+gi/9w8HTQzsO+H2fBWNGrcA9
        6GBojfDzS+fPuSf79m9fQxl79x/+0YtQkqSwS06dCnnE5FFDzx0/A4mO27wjehiHJG8j3imBu/K5t
        KgLvixXUmlw0pHHXzti0A6TAYhcGpxFPsrgYbRniijtjClCp29oOSieSRPBbhzx1T0TMzLFqoPaRq
        ZQo7MW+F2dylKmuSVJMNo4J3SruI+ADXJGLp2B9esTHnO8uFXURZlpHfgHYWcRd8BPFRoWOee8DKY
        YRbM42EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOyQG-00ED68-Ea; Tue, 01 Mar 2022 09:03:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6E7030017F;
        Tue,  1 Mar 2022 10:03:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF0052024C933; Tue,  1 Mar 2022 10:03:54 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:03:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow
 path
Message-ID: <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
 <20220301010412.431299-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301010412.431299-3-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 05:04:10PM -0800, Namhyung Kim wrote:

> @@ -171,9 +172,12 @@ bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
>  	if (try)
>  		return false;
>  
> +	trace_contention_begin(sem, _RET_IP_,
> +			       LCB_F_READ | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE);

That is a bit unwieldy, isn't it ?

>  	preempt_enable();
>  	percpu_rwsem_wait(sem, /* .reader = */ true);
>  	preempt_disable();
> +	trace_contention_end(sem);
>  
>  	return true;
>  }
> @@ -224,8 +228,13 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>  	 * Try set sem->block; this provides writer-writer exclusion.
>  	 * Having sem->block set makes new readers block.
>  	 */
> -	if (!__percpu_down_write_trylock(sem))
> +	if (!__percpu_down_write_trylock(sem)) {
> +		unsigned int flags = LCB_F_WRITE | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE;
> +
> +		trace_contention_begin(sem, _RET_IP_, flags);
>  		percpu_rwsem_wait(sem, /* .reader = */ false);
> +		trace_contention_end(sem);
> +	}
>  
>  	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
>  

Wouldn't it be easier to stick all that inside percpu_rwsem_wait() and
have it only once? You can even re-frob the wait loop such that the
tracepoint can use current->__state or something.

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index c9fdae94e098..ca01f8ff88e5 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -154,13 +154,16 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	}
 	spin_unlock_irq(&sem->waiters.lock);
 
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	trace_contention_begin(sem, _RET_IP_, LCB_F_PERCPU | LCB_F_WRITE*!reader);
 	while (wait) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!smp_load_acquire(&wq_entry.private))
 			break;
 		schedule();
+		set_current_state(TASK_UNINTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
+	trace_contention_end(sem);
 }
 
 bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 8555c4efe97c..e49f5d2a232b 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -24,6 +24,8 @@
>  #include <linux/sched/wake_q.h>
>  #include <linux/ww_mutex.h>
>  
> +#include <trace/events/lock.h>
> +
>  #include "rtmutex_common.h"
>  
>  #ifndef WW_RT
> @@ -1652,10 +1654,16 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
>  static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
>  					   unsigned int state)
>  {
> +	int ret;
> +
>  	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
>  		return 0;
>  
> -	return rt_mutex_slowlock(lock, NULL, state);
> +	trace_contention_begin(lock, _RET_IP_, LCB_F_RT | state);
> +	ret = rt_mutex_slowlock(lock, NULL, state);
> +	trace_contention_end(lock);
> +
> +	return ret;
>  }
>  #endif /* RT_MUTEX_BUILD_MUTEX */
>  
> @@ -1718,9 +1726,11 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
>  {
>  	unsigned long flags;
>  
> +	trace_contention_begin(lock, _RET_IP_, LCB_F_RT | TASK_RTLOCK_WAIT);
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	rtlock_slowlock_locked(lock);
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> +	trace_contention_end(lock);
>  }

Same, if you do it one level in, you can have the tracepoint itself look
at current->__state. Also, you seem to have forgotten to trace the
return value. Now you can't tell if the lock was acquired, or was denied
(ww_mutex) or we were interrupted.

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8555c4efe97c..18b9f4bf6f34 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1579,6 +1579,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	set_current_state(state);
 
+	trace_contention_begin(lock, _RET_IP_, LCB_F_RT);
+
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
 		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
@@ -1601,6 +1603,9 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+
+	trace_contention_end(lock, ret);
+
 	return ret;
 }
 
@@ -1683,6 +1688,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	/* Save current state and set state to TASK_RTLOCK_WAIT */
 	current_save_and_set_rtlock_wait_state();
 
+	trace_contention_begin(lock, _RET_IP_, LCB_F_RT);
+
 	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
 
 	for (;;) {
@@ -1703,6 +1710,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 		set_current_state(TASK_RTLOCK_WAIT);
 	}
 
+	trace_contention_end(lock, 0);
+
 	/* Restore the task state */
 	current_restore_rtlock_saved_state();
 
