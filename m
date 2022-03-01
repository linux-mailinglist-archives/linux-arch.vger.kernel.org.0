Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0656B4C9299
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiCASMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiCASMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 13:12:39 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7B45501;
        Tue,  1 Mar 2022 10:11:57 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id j15so28235579lfe.11;
        Tue, 01 Mar 2022 10:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCVUmbcsV9SaN4JDzsufRNe/l6x6Xce18A0t7Uw6oCU=;
        b=2uZXIgUNOWwo65mDLenBLZEhOJYywPwKxJAs4HQFfrqsmbWk/dSu1qSzhcZNInuJK2
         d7Sr+Q5tmAn6eRxNXJTC0MDORShz+xm5LYTAJAdX9FE1AzA0a6LtRc41Unw2iPiECuQA
         aOiucu/S58LULltK7cGonNZqOD8PX9s4QIIuMUJC0QhI+bRyjVXj0fK0YqN7fbQmDiMk
         ihV2yT8AI9ERV2hPu+E8ngLDTD58BmQGaPB0/evl3vgQ66WryKhZuvb8QrZeCf3uJoQt
         jZSOZ6doIH15ih3ivdStPGePMfhn2BRWLZtkZcW35HKMAwt98vEI5BTiSQ0O4vjuodKD
         HpXw==
X-Gm-Message-State: AOAM530AOZZoo/jEm5jIUEUFfXUlPZm2Jn8rrgZ8QqXrdtecf4jzsX3s
        DiBnqeq/8jSCvWLSC+OYnYrOVgIHsPri26KR8G4=
X-Google-Smtp-Source: ABdhPJyZGK1VKEJczYNEFSl0rCxd+1JK1BOZmvuehMT5NCZcsmi5sAx+R1Po//tWHa8lzK/K8NQQUk6ji72grd2p33s=
X-Received: by 2002:a05:6512:33d6:b0:43b:8dc3:130f with SMTP id
 d22-20020a05651233d600b0043b8dc3130fmr16772331lfg.47.1646158315464; Tue, 01
 Mar 2022 10:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-3-namhyung@kernel.org>
 <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Mar 2022 10:11:44 -0800
Message-ID: <CAM9d7cjOX2-wRisXdQ2tLLKJx-R8dWWEXEjsd7wCb1rE=9cThQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow path
To:     Peter Zijlstra <peterz@infradead.org>
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
        bpf <bpf@vger.kernel.org>, Radoslaw Burny <rburny@google.com>
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

On Tue, Mar 1, 2022 at 1:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 05:04:10PM -0800, Namhyung Kim wrote:
>
> > @@ -171,9 +172,12 @@ bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> >       if (try)
> >               return false;
> >
> > +     trace_contention_begin(sem, _RET_IP_,
> > +                            LCB_F_READ | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE);
>
> That is a bit unwieldy, isn't it ?
>
> >       preempt_enable();
> >       percpu_rwsem_wait(sem, /* .reader = */ true);
> >       preempt_disable();
> > +     trace_contention_end(sem);
> >
> >       return true;
> >  }
> > @@ -224,8 +228,13 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> >        * Try set sem->block; this provides writer-writer exclusion.
> >        * Having sem->block set makes new readers block.
> >        */
> > -     if (!__percpu_down_write_trylock(sem))
> > +     if (!__percpu_down_write_trylock(sem)) {
> > +             unsigned int flags = LCB_F_WRITE | LCB_F_PERCPU | TASK_UNINTERRUPTIBLE;
> > +
> > +             trace_contention_begin(sem, _RET_IP_, flags);
> >               percpu_rwsem_wait(sem, /* .reader = */ false);
> > +             trace_contention_end(sem);
> > +     }
> >
> >       /* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
> >
>
> Wouldn't it be easier to stick all that inside percpu_rwsem_wait() and
> have it only once? You can even re-frob the wait loop such that the
> tracepoint can use current->__state or something.
>
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index c9fdae94e098..ca01f8ff88e5 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -154,13 +154,16 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
>         }
>         spin_unlock_irq(&sem->waiters.lock);
>
> +       set_current_state(TASK_UNINTERRUPTIBLE);
> +       trace_contention_begin(sem, _RET_IP_, LCB_F_PERCPU | LCB_F_WRITE*!reader);
>         while (wait) {
> -               set_current_state(TASK_UNINTERRUPTIBLE);
>                 if (!smp_load_acquire(&wq_entry.private))
>                         break;
>                 schedule();
> +               set_current_state(TASK_UNINTERRUPTIBLE);
>         }
>         __set_current_state(TASK_RUNNING);
> +       trace_contention_end(sem);
>  }

Looks good.  I'll make similar changes in other places too.

One general concern of moving inside is that it makes the _RET_IP_
useless.  If we can pass the caller ip to the slowpath function,
it'd be fine.

>
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 8555c4efe97c..e49f5d2a232b 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/sched/wake_q.h>
> >  #include <linux/ww_mutex.h>
> >
> > +#include <trace/events/lock.h>
> > +
> >  #include "rtmutex_common.h"
> >
> >  #ifndef WW_RT
> > @@ -1652,10 +1654,16 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
> >  static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
> >                                          unsigned int state)
> >  {
> > +     int ret;
> > +
> >       if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
> >               return 0;
> >
> > -     return rt_mutex_slowlock(lock, NULL, state);
> > +     trace_contention_begin(lock, _RET_IP_, LCB_F_RT | state);
> > +     ret = rt_mutex_slowlock(lock, NULL, state);
> > +     trace_contention_end(lock);
> > +
> > +     return ret;
> >  }
> >  #endif /* RT_MUTEX_BUILD_MUTEX */
> >
> > @@ -1718,9 +1726,11 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
> >  {
> >       unsigned long flags;
> >
> > +     trace_contention_begin(lock, _RET_IP_, LCB_F_RT | TASK_RTLOCK_WAIT);
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> >       rtlock_slowlock_locked(lock);
> >       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> > +     trace_contention_end(lock);
> >  }
>
> Same, if you do it one level in, you can have the tracepoint itself look
> at current->__state. Also, you seem to have forgotten to trace the
> return value. Now you can't tell if the lock was acquired, or was denied
> (ww_mutex) or we were interrupted.

Right, thanks for pointing that out.  Will add that.

Thanks,
Namhyung

>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 8555c4efe97c..18b9f4bf6f34 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1579,6 +1579,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
>
>         set_current_state(state);
>
> +       trace_contention_begin(lock, _RET_IP_, LCB_F_RT);
> +
>         ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
>         if (likely(!ret))
>                 ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
> @@ -1601,6 +1603,9 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
>          * unconditionally. We might have to fix that up.
>          */
>         fixup_rt_mutex_waiters(lock);
> +
> +       trace_contention_end(lock, ret);
> +
>         return ret;
>  }
>
> @@ -1683,6 +1688,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
>         /* Save current state and set state to TASK_RTLOCK_WAIT */
>         current_save_and_set_rtlock_wait_state();
>
> +       trace_contention_begin(lock, _RET_IP_, LCB_F_RT);
> +
>         task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
>
>         for (;;) {
> @@ -1703,6 +1710,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
>                 set_current_state(TASK_RTLOCK_WAIT);
>         }
>
> +       trace_contention_end(lock, 0);
> +
>         /* Restore the task state */
>         current_restore_rtlock_saved_state();
>
