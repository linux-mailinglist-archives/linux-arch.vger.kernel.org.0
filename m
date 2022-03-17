Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A64DC7A0
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiCQNeP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCQNeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 09:34:15 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526284EC1;
        Thu, 17 Mar 2022 06:32:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D71BD3EF8C9;
        Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XwBmmPWWkR0C; Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4F70D3EF77F;
        Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4F70D3EF77F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1647523975;
        bh=wct8eVEa0hyiF8ndwRu5T5PaGpotfWjNhp+9R8kW+s8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lGnED4zxgbG0vseXdlUEavmRoPLg4UR394DvrGypfKoiiEMidhk9TLgbIcCY0KpOz
         DRse9pJkcPn2acV0pe8YeElkPGA+cU5LxWAD+j0IamHsxFh8x6rXt1qgj3ae7yyCbV
         81iEu+yA17cwl++bvfzucRRGsZ4S51iT0irUtJsP0U0G13hKo3/0dZw2EtvMAhGZF3
         PUhfOKR73ccoiszTXWmWXfSZozyeIWu6Tc99N/M4zpMA1FTGHoGlnbOIfaXLVn0Wr0
         6upvTZ4E5ciHcvM3BLCAbOnTLUeazTLKWCzxOxHnzDmFzdu78i42OdsyGxXVdI2KbG
         UPMi16FjDA8bw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id msDecMQlYrpc; Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 39C4C3EFA91;
        Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
Date:   Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
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
Message-ID: <636955156.156341.1647523975127.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220316224548.500123-2-namhyung@kernel.org>
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-2-namhyung@kernel.org>
Subject: Re: [PATCH 1/2] locking: Add lock contention tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: locking: Add lock contention tracepoints
Thread-Index: PDRNuPsg7auX4dM8Q+u651v+KCfqMw==
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

> This adds two new lock contention tracepoints like below:
> 
> * lock:contention_begin
> * lock:contention_end
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
> include/trace/events/lock.h | 54 ++++++++++++++++++++++++++++++++++---
> kernel/locking/lockdep.c    |  1 -
> kernel/locking/mutex.c      |  3 +++
> 3 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index d7512129a324..2a3df36d4fdb 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -5,11 +5,21 @@
> #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> #define _TRACE_LOCK_H
> 
> -#include <linux/lockdep.h>
> +#include <linux/sched.h>
> #include <linux/tracepoint.h>
> 
> +/* flags for lock:contention_begin */
> +#define LCB_F_SPIN	(1U << 0)
> +#define LCB_F_READ	(1U << 1)
> +#define LCB_F_WRITE	(1U << 2)
> +#define LCB_F_RT	(1U << 3)
> +#define LCB_F_PERCPU	(1U << 4)

Unless there is a particular reason for using preprocessor defines here, the
following form is typically better because it does not pollute the preprocessor
defines, e.g.:

enum lock_contention_flags {
        LCB_F_SPIN =   1U << 0;
        LCB_F_READ =   1U << 1;
        LCB_F_WRITE =  1U << 2;
        LCB_F_RT =     1U << 3;
        LCB_F_PERCPU = 1U << 4;
};

Thanks,

Mathieu

> +
> +
> #ifdef CONFIG_LOCKDEP
> 
> +#include <linux/lockdep.h>
> +
> TRACE_EVENT(lock_acquire,
> 
> 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
> @@ -78,8 +88,46 @@ DEFINE_EVENT(lock, lock_acquired,
> 	TP_ARGS(lock, ip)
> );
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
> #endif /* _TRACE_LOCK_H */
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 50036c10b518..08f8fb6a2d1e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -60,7 +60,6 @@
> 
> #include "lockdep_internals.h"
> 
> -#define CREATE_TRACE_POINTS
> #include <trace/events/lock.h>
> 
> #ifdef CONFIG_PROVE_LOCKING
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 5e3585950ec8..ee2fd7614a93 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -30,6 +30,9 @@
> #include <linux/debug_locks.h>
> #include <linux/osq_lock.h>
> 
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/lock.h>
> +
> #ifndef CONFIG_PREEMPT_RT
> #include "mutex.h"
> 
> --
> 2.35.1.894.gb6a874cedc-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
