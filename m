Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51D74DE399
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiCRVg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCRVg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 17:36:27 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CB223858;
        Fri, 18 Mar 2022 14:35:07 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id bx44so6358711ljb.13;
        Fri, 18 Mar 2022 14:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmNrK/0TVfWJk8R0ovTzUXynuF+kFI2QuCNhtLcQl8I=;
        b=HAUZVqkX9chRsevOejcswOUKI5oD2Q5wf5k8CRTwz5UXydLO/N6eEAwR4+zXEke/yl
         XrR/EAH5TNfhTEoE0yKyTqD7RxDYetHUO4mq4v/ktuYEcyclearYyHszg/TDPy1mvXdE
         ZbuAxIUJm1nJoqNIWxTxvnma6axcjxhBwev0RSa6R9qp6QbAo8qJGK/1JzUfSk1jyIrb
         DuYjZsH5MSNXyAcQjragjyYEvRR2grhoUn9APNPyb5ILs5ShoCqMjLviVDP1wOcEAYJm
         Ad1J90lMoFImJws8kIyCQXVLjfb2NEgXRvn9kilL0CCDectsY0qqxcxQlEOrg/Gk5hbi
         6ZsA==
X-Gm-Message-State: AOAM5328cHbF+7MKzwxXZalqe6N3I00i/nBDckKW5dPJ6ZDgnTaGHA83
        uFpA+6M2PLrn/zHInm4vgWha/iC3fHErziTBa2M=
X-Google-Smtp-Source: ABdhPJwiLPmoLHdEN2HDYWChXlmjkxr2z/nl8WdGLQzSzWtV0HJp8/eiCaUH5zCVt6teYO1o0i0tz7MpMs80E3aFZVE=
X-Received: by 2002:a05:651c:516:b0:249:23ef:d9c7 with SMTP id
 o22-20020a05651c051600b0024923efd9c7mr7177966ljp.202.1647639304557; Fri, 18
 Mar 2022 14:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com>
In-Reply-To: <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 14:34:53 -0700
Message-ID: <CAM9d7chFVp6SPGoZPJF6+CMkbZyp1Fmxxu2Xn3Ks=DYcgbUG5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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

On Thu, Mar 17, 2022 at 6:45 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 16, 2022, at 6:45 PM, Namhyung Kim namhyung@kernel.org wrote:
>
> > Adding the lock contention tracepoints in various lock function slow
> > paths.  Note that each arch can define spinlock differently, I only
> > added it only to the generic qspinlock for now.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > kernel/locking/mutex.c        |  3 +++
> > kernel/locking/percpu-rwsem.c |  3 +++
> > kernel/locking/qrwlock.c      |  9 +++++++++
> > kernel/locking/qspinlock.c    |  5 +++++
> > kernel/locking/rtmutex.c      | 11 +++++++++++
> > kernel/locking/rwbase_rt.c    |  3 +++
> > kernel/locking/rwsem.c        |  9 +++++++++
> > kernel/locking/semaphore.c    | 14 +++++++++++++-
> > 8 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index ee2fd7614a93..c88deda77cf2 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> > unsigned int subclas
> >       }
> >
> >       set_current_state(state);
> > +     trace_contention_begin(lock, 0);
>
> This should be LCB_F_SPIN rather than the hardcoded 0.

I don't think so.  LCB_F_SPIN is for spin locks indicating that
it's spinning on a cpu.  And the value is not 0.

>
> >       for (;;) {
> >               bool first;
> >
> > @@ -710,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> > unsigned int subclas
> > skip_wait:
> >       /* got the lock - cleanup and rejoice! */
> >       lock_acquired(&lock->dep_map, ip);
> > +     trace_contention_end(lock, 0);
> >
> >       if (ww_ctx)
> >               ww_mutex_lock_acquired(ww, ww_ctx);
> > @@ -721,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state,
> > unsigned int subclas
> > err:
> >       __set_current_state(TASK_RUNNING);
> >       __mutex_remove_waiter(lock, &waiter);
> > +     trace_contention_end(lock, ret);
> > err_early_kill:
> >       raw_spin_unlock(&lock->wait_lock);
> >       debug_mutex_free_waiter(&waiter);
> > diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> > index c9fdae94e098..833043613af6 100644
> > --- a/kernel/locking/percpu-rwsem.c
> > +++ b/kernel/locking/percpu-rwsem.c
> > @@ -9,6 +9,7 @@
> > #include <linux/sched/task.h>
> > #include <linux/sched/debug.h>
> > #include <linux/errno.h>
> > +#include <trace/events/lock.h>
> >
> > int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
> >                       const char *name, struct lock_class_key *key)
> > @@ -154,6 +155,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore
> > *sem, bool reader)
> >       }
> >       spin_unlock_irq(&sem->waiters.lock);
> >
> > +     trace_contention_begin(sem, LCB_F_PERCPU | (reader ? LCB_F_READ :
> > LCB_F_WRITE));
> >       while (wait) {
> >               set_current_state(TASK_UNINTERRUPTIBLE);
> >               if (!smp_load_acquire(&wq_entry.private))
> > @@ -161,6 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore
> > *sem, bool reader)
> >               schedule();
> >       }
> >       __set_current_state(TASK_RUNNING);
> > +     trace_contention_end(sem, 0);
>
> So for the reader-write locks, and percpu rwlocks, the "trace contention end" will always
> have ret=0. Likewise for qspinlock, qrwlock, and rtlock. It seems to be a waste of trace
> buffer space to always have space for a return value that is always 0.

Right, I think it'd be better to have a new tracepoint for the error cases
and get rid of the return value in the contention_end.

Like contention_error or contention_return ?

>
> Sorry if I missed prior dicussions of that topic, but why introduce this single
> "trace contention begin/end" muxer tracepoint with flags rather than per-locking-type
> tracepoint ? The per-locking-type tracepoint could be tuned to only have the fields
> that are needed for each locking type.

No prior discussions on that topic and thanks for bringing it out.

Having per-locking-type tracepoints will help if you want to filter
out specific types of locks efficiently.  Otherwise it'd be simpler
for users to have a single set of tracepoints to handle all locking
types like the existing lockdep tracepoints do.

As it's in a contended path, I think it's allowed to be a little bit
less efficient and the flags can tell which type of locks it's tracing
so you can filter it out anyway.

Thanks,
Namhyung
