Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC34DE3A1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 22:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiCRVot (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 17:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiCRVot (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 17:44:49 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC63076F7;
        Fri, 18 Mar 2022 14:43:29 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id a25so2656698lfm.10;
        Fri, 18 Mar 2022 14:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkOXZgVC9RFV9phupcfvnm2Iyq8yKsxWwQHR0CqwFok=;
        b=k8IKq+T2AA81jxApGV921gfpBLgrqSWk2LY5U2x4VtAvqCYYwNK+/OoB/zt3TasrMZ
         1BJHlAQ5rRdo7Z4TI6KkiBQ5fQAyGP+oGI4oIxyOuIu6sWGENUHr9Kcb0u93VJkqwm0t
         u4jRiZfoFXZZ1XiFD0t5YdNhTeGky75/t7EFqmD6xmyyAJABUlxSppMAfx1Cjyom+smb
         eiNp0qqFjNmjeO6+RcZhzuZMZbFvZm3Bb2jVq4uvo3HAZk4t78UE+47f5u2ttUROL7PL
         7KHcVHWzK6Dby4N+DNblUsBDJLc/gVcf1a5Cy+QvBF6MU2AU/vbYdoAk2kRvZNqt6wa1
         86bA==
X-Gm-Message-State: AOAM530qFX66USaXUpScgV5mjfTsR5QQqC0EY7RBTpaeon3Gf06Sv156
        JtJJf0VPtoEYi1fCKjDuBHRR4kVVRAXIxV/TPNh+IMl6
X-Google-Smtp-Source: ABdhPJzVIW4zkakMULW/3Vg1qBy0GcNjdUUZdEmrGQKxHYffqxi8JubRcC1sXrYOz/Dj5hQ1GA5MjqSoCruLFEGNghw=
X-Received: by 2002:a05:6512:1195:b0:448:4fcc:34f2 with SMTP id
 g21-20020a056512119500b004484fcc34f2mr7067127lfr.454.1647639808133; Fri, 18
 Mar 2022 14:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <YjN7wPMEBVIuOiGN@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YjN7wPMEBVIuOiGN@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 14:43:16 -0700
Message-ID: <CAM9d7ciM9zX_Mj95p6mMj_GMSmuvhKC_v30fufAcZSDJ0RyVug@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
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

On Thu, Mar 17, 2022 at 11:19 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> > Adding the lock contention tracepoints in various lock function slow
> > paths.  Note that each arch can define spinlock differently, I only
> > added it only to the generic qspinlock for now.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/locking/mutex.c        |  3 +++
> >  kernel/locking/percpu-rwsem.c |  3 +++
> >  kernel/locking/qrwlock.c      |  9 +++++++++
> >  kernel/locking/qspinlock.c    |  5 +++++
> >  kernel/locking/rtmutex.c      | 11 +++++++++++
> >  kernel/locking/rwbase_rt.c    |  3 +++
> >  kernel/locking/rwsem.c        |  9 +++++++++
> >  kernel/locking/semaphore.c    | 14 +++++++++++++-
> >  8 files changed, 56 insertions(+), 1 deletion(-)
> >
>
> [...]
>
> > diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> > index 9ee381e4d2a4..e3c19668dfee 100644
> > --- a/kernel/locking/semaphore.c
> > +++ b/kernel/locking/semaphore.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/semaphore.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/ftrace.h>
> > +#include <trace/events/lock.h>
> >
> >  static noinline void __down(struct semaphore *sem);
> >  static noinline int __down_interruptible(struct semaphore *sem);
> > @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >                                                               long timeout)
> >  {
> >       struct semaphore_waiter waiter;
> > +     bool tracing = false;
> >
> >       list_add_tail(&waiter.list, &sem->wait_list);
> >       waiter.task = current;
> > @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >               if (unlikely(timeout <= 0))
> >                       goto timed_out;
> >               __set_current_state(state);
> > +             if (!tracing) {
> > +                     trace_contention_begin(sem, 0);
> > +                     tracing = true;
> > +             }
> >               raw_spin_unlock_irq(&sem->lock);
> >               timeout = schedule_timeout(timeout);
> >               raw_spin_lock_irq(&sem->lock);
> > -             if (waiter.up)
> > +             if (waiter.up) {
> > +                     trace_contention_end(sem, 0);
> >                       return 0;
> > +             }
> >       }
> >
> >   timed_out:
> > +     if (tracing)
> > +             trace_contention_end(sem, -ETIME);
> >       list_del(&waiter.list);
> >       return -ETIME;
> >
> >   interrupted:
> > +     if (tracing)
> > +             trace_contention_end(sem, -EINTR);
> >       list_del(&waiter.list);
> >       return -EINTR;
> >  }
>
> why not simply remove tracing variable and call trace_contention_begin()
> earlier like in rwsem? we can ignore it if ret != 0.

Right, will change.  But we should not ignore the return value.

Thanks,
Namhyung
