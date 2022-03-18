Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9E4DE3C9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 22:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiCRV5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbiCRV47 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 17:56:59 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB230A882;
        Fri, 18 Mar 2022 14:55:39 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t25so16063633lfg.7;
        Fri, 18 Mar 2022 14:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiM2o7+WvhkUxC02l3Vrb5uNgnPHPpHM0pgA8i6E2so=;
        b=Bbg+bxp2UySbPVchJ8a0AOTNv5+UhnoXcGHnckHFIWsa6+GLTb6ER8kFZfKU0t1NhV
         4VhA6M7vSGzYNIO/EJHr5v74pZr+h5BNTyUyeoQo5BmLgeK+paLcX4a82pZG7fkMN61+
         55JhPrRPJ7NZsQ0Uu7wcI23CluUFg91l3PeOYLEQU+zE80uBXj95o0IC8d9HOzYvZEkP
         /i4QG701ubv4n8RWNdvHzWY4ytrKYpOejOPfra6Q+t1BFZkGlN4gsWY188/+M6Vfy3+D
         Mvmzoc7W+BXiB2StNxp8M0WuqMPhvBd0GNaahPYRT4nz299By8UNiOX1b41FKrjNupLY
         tvMw==
X-Gm-Message-State: AOAM532I5uIcoB/kuImtDnqMSivo4BVsiQRzEaSGUY1H4CREluSEmdqm
        7RRMhOw6ON4p/N6R/W6pEKj+8gwg43I+oxv6Z7g=
X-Google-Smtp-Source: ABdhPJx5SM9SOhMKq6xSILDAw1chQzpIZCBgXyppSzPpNYA01GgaYe+nqdgX2hE9tBTi2QT24BheAOhTktXlrizKBvY=
X-Received: by 2002:a05:6512:2104:b0:448:68c5:e78f with SMTP id
 q4-20020a056512210400b0044868c5e78fmr7140679lfr.47.1647640538186; Fri, 18 Mar
 2022 14:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux> <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
In-Reply-To: <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 14:55:27 -0700
Message-ID: <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
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

Hello,

On Fri, Mar 18, 2022 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 18, 2022 at 08:55:32PM +0800, Boqun Feng wrote:
> > On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> > [...]
> > > @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> > >                                                             long timeout)
> > >  {
> > >     struct semaphore_waiter waiter;
> > > +   bool tracing = false;
> > >
> > >     list_add_tail(&waiter.list, &sem->wait_list);
> > >     waiter.task = current;
> > > @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> > >             if (unlikely(timeout <= 0))
> > >                     goto timed_out;
> > >             __set_current_state(state);
> > > +           if (!tracing) {
> > > +                   trace_contention_begin(sem, 0);
> >
> > This looks a littl ugly ;-/ Maybe we can rename __down_common() to
> > ___down_common() and implement __down_common() as:
> >
> >       static inline int __sched __down_common(...)
> >       {
> >               int ret;
> >               trace_contention_begin(sem, 0);
> >               ret = ___down_common(...);
> >               trace_contention_end(sem, ret);
> >               return ret;
> >       }
> >
> > Thoughts?
>
> Yeah, that works, except I think he wants a few extra
> __set_current_state()'s like so:

Not anymore, I decided not to because of noise in the task state.

Also I'm considering two tracepoints for the return path to reduce
the buffer size as Mathieu suggested.  Normally it'd return with 0
so we can ignore it in the contention_end.  For non-zero cases,
we can add a new tracepoint to save the return value.

Thanks,
Namhyung

>
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 9ee381e4d2a4..e2049a7e0ea4 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -205,8 +205,7 @@ struct semaphore_waiter {
>   * constant, and thus optimised away by the compiler.  Likewise the
>   * 'timeout' parameter for the cases without timeouts.
>   */
> -static inline int __sched __down_common(struct semaphore *sem, long state,
> -                                                               long timeout)
> +static __always_inline int ___down_common(struct semaphore *sem, long state, long timeout)
>  {
>         struct semaphore_waiter waiter;
>
> @@ -227,15 +226,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>                         return 0;
>         }
>
> - timed_out:
> +timed_out:
>         list_del(&waiter.list);
>         return -ETIME;
>
> - interrupted:
> +interrupted:
>         list_del(&waiter.list);
>         return -EINTR;
>  }
>
> +static __always_inline int __down_common(struct semaphore *sem, long state, long timeout)
> +{
> +       int ret;
> +
> +       __set_current_state(state);
> +       trace_contention_begin(sem, 0);
> +       ret = ___down_common(sem, state, timeout);
> +       __set_current_state(TASK_RUNNING);
> +       trace_contention_end(sem, ret);
> +
> +       return ret;
> +}
> +
>  static noinline void __sched __down(struct semaphore *sem)
>  {
>         __down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
