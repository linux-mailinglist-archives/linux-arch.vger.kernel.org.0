Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48044DC7D1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiCQNqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiCQNqq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 09:46:46 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440F1D4C38;
        Thu, 17 Mar 2022 06:45:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D24213EF6F2;
        Thu, 17 Mar 2022 09:45:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eI05lsRnsTj3; Thu, 17 Mar 2022 09:45:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1DCC93EF8F8;
        Thu, 17 Mar 2022 09:45:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1DCC93EF8F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1647524729;
        bh=9OxVWJ4vPMgt6fGn0jQ5iVj+WY+3QXU8NA1cjBO9lIk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cUSboxJjB0cAoob2yW7rCVLFTGf6Q6Ns4oFwG6a7Vli6cltVPQcrvXn/gZ7SRZVUT
         yXGVeOnH8WxE92Maa6yP4K1gdUVHXft9lN+gz8yVStyBG+9kd6rFRkl8mkm4fvWpiC
         mRl2KZP20DlqwB5pjKDkbIhMqJao4p2Rox0gAJGuO8ng0l2dtgp+F+1EIuDNa6dh1e
         RsYJYD8cIla4hRa6+uJnRK8n+PGlSMDyE+SKjcN+zcdJ/n81PhnZxoV5pl85pfcubd
         blo+USifsbOZDoEYobQ+Row+Tmk4rwxvFXt3iHMwcPVe756+vP7W7Ro7nxBe8p8YF3
         phnRr7zdaeaOw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J4lQgT7QznH7; Thu, 17 Mar 2022 09:45:29 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E5A5D3EFD1E;
        Thu, 17 Mar 2022 09:45:28 -0400 (EDT)
Date:   Thu, 17 Mar 2022 09:45:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        paulmck <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Message-ID: <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220316224548.500123-3-namhyung@kernel.org>
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: locking: Apply contention tracepoints in the slow path
Thread-Index: gDkcZNYUEH8fJg1vQNRPXNZ0Cqt22w==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 16, 2022, at 6:45 PM, Namhyung Kim namhyung@kernel.org wrote:

> Adding the lock contention tracepoints in various lock function slow
> paths.  Note that each arch can define spinlock differently, I only
> added it only to the generic qspinlock for now.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> kernel/locking/mutex.c        |  3 +++
> kernel/locking/percpu-rwsem.c |  3 +++
> kernel/locking/qrwlock.c      |  9 +++++++++
> kernel/locking/qspinlock.c    |  5 +++++
> kernel/locking/rtmutex.c      | 11 +++++++++++
> kernel/locking/rwbase_rt.c    |  3 +++
> kernel/locking/rwsem.c        |  9 +++++++++
> kernel/locking/semaphore.c    | 14 +++++++++++++-
> 8 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index ee2fd7614a93..c88deda77cf2 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> unsigned int subclas
> 	}
> 
> 	set_current_state(state);
> +	trace_contention_begin(lock, 0);

This should be LCB_F_SPIN rather than the hardcoded 0.

> 	for (;;) {
> 		bool first;
> 
> @@ -710,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> unsigned int subclas
> skip_wait:
> 	/* got the lock - cleanup and rejoice! */
> 	lock_acquired(&lock->dep_map, ip);
> +	trace_contention_end(lock, 0);
> 
> 	if (ww_ctx)
> 		ww_mutex_lock_acquired(ww, ww_ctx);
> @@ -721,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> unsigned int subclas
> err:
> 	__set_current_state(TASK_RUNNING);
> 	__mutex_remove_waiter(lock, &waiter);
> +	trace_contention_end(lock, ret);
> err_early_kill:
> 	raw_spin_unlock(&lock->wait_lock);
> 	debug_mutex_free_waiter(&waiter);
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index c9fdae94e098..833043613af6 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -9,6 +9,7 @@
> #include <linux/sched/task.h>
> #include <linux/sched/debug.h>
> #include <linux/errno.h>
> +#include <trace/events/lock.h>
> 
> int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
> 			const char *name, struct lock_class_key *key)
> @@ -154,6 +155,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore
> *sem, bool reader)
> 	}
> 	spin_unlock_irq(&sem->waiters.lock);
> 
> +	trace_contention_begin(sem, LCB_F_PERCPU | (reader ? LCB_F_READ :
> LCB_F_WRITE));
> 	while (wait) {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		if (!smp_load_acquire(&wq_entry.private))
> @@ -161,6 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore
> *sem, bool reader)
> 		schedule();
> 	}
> 	__set_current_state(TASK_RUNNING);
> +	trace_contention_end(sem, 0);

So for the reader-write locks, and percpu rwlocks, the "trace contention end" will always
have ret=0. Likewise for qspinlock, qrwlock, and rtlock. It seems to be a waste of trace
buffer space to always have space for a return value that is always 0.

Sorry if I missed prior dicussions of that topic, but why introduce this single
"trace contention begin/end" muxer tracepoint with flags rather than per-locking-type
tracepoint ? The per-locking-type tracepoint could be tuned to only have the fields
that are needed for each locking type.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
