Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C694E9DB7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Mar 2022 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbiC1RnZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiC1RnZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 13:43:25 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA865153;
        Mon, 28 Mar 2022 10:41:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id k21so26067742lfe.4;
        Mon, 28 Mar 2022 10:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4odO6LdQTeKoOR53kyP85mV76dxJWB7kgHfBz/NFdA=;
        b=vWxO5xk481iha12C/UJta/Hg2i7+hKmzl7umYoxTW2rbqlpE36WzOlKzOin7oDIjXf
         xTCNMoJkzr0RVUTsouGpTexoZWL4AaUKA9yD++jHzLKKbOnxtW2ZZ8mfJlo2v0eNJoLd
         sM1GdytnF/++/NAS0sAZ8kV3aZnWd82zyZYIO559JFBdVkyboKqEvBqq1VEaNFG4SuJE
         ElrfYa7aOmhZ2j5mh3q2U4QXEu4W04w0dulLZq4lTjOjFuF6ZHizvoxcpzKGNW9gk9/9
         yxFpTFzSM+FIGrJ6m9dp67n32rwEY50ITxox1gb+97m/63RIn9WDDQLbbPvsGRsLkTbX
         55TQ==
X-Gm-Message-State: AOAM5329wPaj3827ZbrOuu+lkVObTf735xdTKJeC+RKOBesX0Oq9Fhx3
        NV+Nyux2uKsj+s5kAnp0/nDXxSNoyz0YpAAyVvo=
X-Google-Smtp-Source: ABdhPJzuF2w+Yd86D5U8fSkJrcu1HLlihTr1zWRCVQxmMATz3hgAzaTctXfsfD784zVzTVXMw5h816XlJvrerkn/zw0=
X-Received: by 2002:a19:4306:0:b0:44a:599b:468 with SMTP id
 q6-20020a194306000000b0044a599b0468mr20941954lfa.481.1648489302697; Mon, 28
 Mar 2022 10:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220322185709.141236-1-namhyung@kernel.org> <20220322185709.141236-3-namhyung@kernel.org>
 <20220328112921.GZ8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220328112921.GZ8939@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 28 Mar 2022 10:41:31 -0700
Message-ID: <CAM9d7cgaTdswDHKA364BN9Me-_LBxMfuZ70O=Y3_sZf3GNfgLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Mon, Mar 28, 2022 at 4:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 22, 2022 at 11:57:09AM -0700, Namhyung Kim wrote:
> > Adding the lock contention tracepoints in various lock function slow
> > paths.  Note that each arch can define spinlock differently, I only
> > added it only to the generic qspinlock for now.
> >
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/locking/mutex.c        |  3 +++
> >  kernel/locking/percpu-rwsem.c |  3 +++
> >  kernel/locking/qrwlock.c      |  9 +++++++++
> >  kernel/locking/qspinlock.c    |  5 +++++
> >  kernel/locking/rtmutex.c      | 11 +++++++++++
> >  kernel/locking/rwbase_rt.c    |  3 +++
> >  kernel/locking/rwsem.c        |  9 +++++++++
> >  kernel/locking/semaphore.c    | 15 ++++++++++++++-
> >  8 files changed, 57 insertions(+), 1 deletion(-)
>
> I had conflicts in rwsem.c due to Waiman's patches, but that was simple
> enough to resolve. However, I had a good look at the other sites and
> ended up with the below...
>
> Yes, I know I'm the one that suggested the percpu thing, but upon
> looking again it missed the largest part of percpu_down_write(), which
> very much includes that RCU grace period and waiting for the readers to
> bugger off
>
> Also, rwbase_rt was missing the entire READ side -- yes, I see that's
> also covered by the rtmuex.c part, but that's on a different address and
> with different flags, and it's very confusing to not have it annotated.
>
> Anyway, I'll queue this patch with the below folded in for post -rc1.

Thanks for doing this, the changes look good.

Namhyung

>
> ---
>
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -155,7 +155,6 @@ static void percpu_rwsem_wait(struct per
>         }
>         spin_unlock_irq(&sem->waiters.lock);
>
> -       trace_contention_begin(sem, LCB_F_PERCPU | (reader ? LCB_F_READ : LCB_F_WRITE));
>         while (wait) {
>                 set_current_state(TASK_UNINTERRUPTIBLE);
>                 if (!smp_load_acquire(&wq_entry.private))
> @@ -163,7 +162,6 @@ static void percpu_rwsem_wait(struct per
>                 schedule();
>         }
>         __set_current_state(TASK_RUNNING);
> -       trace_contention_end(sem, 0);
>  }
>
>  bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> @@ -174,9 +172,11 @@ bool __sched __percpu_down_read(struct p
>         if (try)
>                 return false;
>
> +       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_READ);
>         preempt_enable();
>         percpu_rwsem_wait(sem, /* .reader = */ true);
>         preempt_disable();
> +       trace_contention_end(sem, 0);
>
>         return true;
>  }
> @@ -219,6 +219,7 @@ void __sched percpu_down_write(struct pe
>  {
>         might_sleep();
>         rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> +       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
>
>         /* Notify readers to take the slow path. */
>         rcu_sync_enter(&sem->rss);
> @@ -240,6 +241,7 @@ void __sched percpu_down_write(struct pe
>
>         /* Wait for all active readers to complete. */
>         rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
> +       trace_contention_end(sem, 0);
>  }
>  EXPORT_SYMBOL_GPL(percpu_down_write);
>
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -35,7 +35,7 @@ void queued_read_lock_slowpath(struct qr
>         }
>         atomic_sub(_QR_BIAS, &lock->cnts);
>
> -       trace_contention_begin(lock, LCB_F_READ | LCB_F_SPIN);
> +       trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
>
>         /*
>          * Put the reader into the wait queue
> @@ -67,7 +67,7 @@ void queued_write_lock_slowpath(struct q
>  {
>         int cnts;
>
> -       trace_contention_begin(lock, LCB_F_WRITE | LCB_F_SPIN);
> +       trace_contention_begin(lock, LCB_F_SPIN | LCB_F_WRITE);
>
>         /* Put the writer into the wait queue */
>         arch_spin_lock(&lock->wait_lock);
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -112,6 +112,8 @@ static int __sched __rwbase_read_lock(st
>          * Reader2 to call up_read(), which might be unbound.
>          */
>
> +       trace_contention_begin(rwb, LCB_F_RT | LCB_F_READ);
> +
>         /*
>          * For rwlocks this returns 0 unconditionally, so the below
>          * !ret conditionals are optimized out.
> @@ -130,6 +132,8 @@ static int __sched __rwbase_read_lock(st
>         raw_spin_unlock_irq(&rtm->wait_lock);
>         if (!ret)
>                 rwbase_rtmutex_unlock(rtm);
> +
> +       trace_contention_end(rwb, ret);
>         return ret;
>  }
>
> @@ -247,7 +251,7 @@ static int __sched rwbase_write_lock(str
>                 goto out_unlock;
>
>         rwbase_set_and_save_current_state(state);
> -       trace_contention_begin(rwb, LCB_F_WRITE | LCB_F_RT);
> +       trace_contention_begin(rwb, LCB_F_RT | LCB_F_WRITE);
>         for (;;) {
>                 /* Optimized out for rwlocks */
>                 if (rwbase_signal_pending_state(state, current)) {
