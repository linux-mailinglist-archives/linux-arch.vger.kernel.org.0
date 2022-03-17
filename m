Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE44DBD03
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 03:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354080AbiCQCdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358422AbiCQCc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 22:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A41D318;
        Wed, 16 Mar 2022 19:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8A7611CB;
        Thu, 17 Mar 2022 02:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6B9C340E9;
        Thu, 17 Mar 2022 02:31:39 +0000 (UTC)
Date:   Wed, 16 Mar 2022 22:31:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] locking: Add lock contention tracepoints
Message-ID: <20220316223138.30ceb025@gandalf.local.home>
In-Reply-To: <20220316224548.500123-2-namhyung@kernel.org>
References: <20220316224548.500123-1-namhyung@kernel.org>
        <20220316224548.500123-2-namhyung@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Mar 2022 15:45:47 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> This adds two new lock contention tracepoints like below:
> 
>  * lock:contention_begin
>  * lock:contention_end
> 
> The lock:contention_begin takes a flags argument to classify locks.  I
> found it useful to identify what kind of locks it's tracing like if
> it's spinning or sleeping, reader-writer lock, real-time, and per-cpu.
> 
> Move tracepoint definitions into mutex.c so that we can use them
> without lockdep.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/trace/events/lock.h | 54 ++++++++++++++++++++++++++++++++++---
>  kernel/locking/lockdep.c    |  1 -
>  kernel/locking/mutex.c      |  3 +++
>  3 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index d7512129a324..2a3df36d4fdb 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -5,11 +5,21 @@
>  #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_LOCK_H
>  
> -#include <linux/lockdep.h>
> +#include <linux/sched.h>
>  #include <linux/tracepoint.h>
>  
> +/* flags for lock:contention_begin */
> +#define LCB_F_SPIN	(1U << 0)
> +#define LCB_F_READ	(1U << 1)
> +#define LCB_F_WRITE	(1U << 2)
> +#define LCB_F_RT	(1U << 3)
> +#define LCB_F_PERCPU	(1U << 4)
> +
> +
>  #ifdef CONFIG_LOCKDEP
>  
> +#include <linux/lockdep.h>
> +
>  TRACE_EVENT(lock_acquire,
>  
>  	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
> @@ -78,8 +88,46 @@ DEFINE_EVENT(lock, lock_acquired,
>  	TP_ARGS(lock, ip)
>  );
>  
> -#endif
> -#endif
> +#endif /* CONFIG_LOCK_STAT */
> +#endif /* CONFIG_LOCKDEP */
> +
> +TRACE_EVENT(contention_begin,
> +
> +	TP_PROTO(void *lock, unsigned int flags),
> +
> +	TP_ARGS(lock, flags),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, lock_addr)
> +		__field(unsigned int, flags)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->lock_addr = lock;
> +		__entry->flags = flags;
> +	),
> +
> +	TP_printk("%p (flags=%x)", __entry->lock_addr, __entry->flags)

Perhaps make this into:

	TP_printk("%p (flags=%s)", __entry->lock_addr,
		__print_flags(__entry->flags, "|",
			{LCB_F_SPIN,   "spin" },
			{LCB_F_READ,   "read" },
			{LCB_F_WRITE,  "write" },
			{LCB_F_RT,     "rt" },
			{LCB_F_PERCPU, "percpu" }
			))

That way, the use doesn't need to figure out what the numbers mean.

-- Steve

			
> +);
> +
> +TRACE_EVENT(contention_end,
> +
> +	TP_PROTO(void *lock, int ret),
> +
> +	TP_ARGS(lock, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, lock_addr)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->lock_addr = lock;
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
> +);
>  
>  #endif /* _TRACE_LOCK_H */
>  
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 50036c10b518..08f8fb6a2d1e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -60,7 +60,6 @@
>  
>  #include "lockdep_internals.h"
>  
> -#define CREATE_TRACE_POINTS
>  #include <trace/events/lock.h>
>  
>  #ifdef CONFIG_PROVE_LOCKING
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 5e3585950ec8..ee2fd7614a93 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -30,6 +30,9 @@
>  #include <linux/debug_locks.h>
>  #include <linux/osq_lock.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/lock.h>
> +
>  #ifndef CONFIG_PREEMPT_RT
>  #include "mutex.h"
>  

