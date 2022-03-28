Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A024E9DD3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Mar 2022 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiC1Rux (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiC1Rux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 13:50:53 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0B3C4B7;
        Mon, 28 Mar 2022 10:49:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a30so12799584ljq.13;
        Mon, 28 Mar 2022 10:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyQ8IXVuGy+MjhTeeviL9/NWr5Oku+oE3kNpUwAlM28=;
        b=mzUsrqs1v9Oox0FLiZXA0oFdHuqoEo4Bzxx8RTE8IW2/gN/kMRw5hJyIY1cmLV6Vch
         b6Nuh4yNiUtWICDHF+U+Xi7w19MAMZYQopDF/k/64vSbPj2J08FkzE1YDipEaOJdrHwp
         i+7eYODLfGrZRKcuVHHvxaO+HAVbX1MsVmpewDujMWBFaIHgdYaKrEJZC4ZFAr7k8t9X
         hFVDpYaLKnGJsiG8kU0DmOQoHIU5kS2DLvZY89xpazFhW6uNRSc9fd28pfIeFJrlerbB
         U/r3suyr+U/rD0SEZ0uJV4lF0txJxYuDjEbQGfgMglFrMVwOqvk0Wlkxo9mj4Z9ctItd
         gKJQ==
X-Gm-Message-State: AOAM531oqij7enAauyfowhgvcSv9RMgJUMYpCgsdQYG0i3mSfBFW9g8W
        MaPas58lBD2uy/kRC2pGlmPcRXaile2sd4wAM40=
X-Google-Smtp-Source: ABdhPJylsb5/U29MfMdIeOIKZdvUSIE4MIawm5G11yaSRrZfEr1IXA3xAF9bfyuvUtx6BVZVZ6Fg7r4xnLNf7VJDTG4=
X-Received: by 2002:a05:651c:248:b0:245:5b3d:9abb with SMTP id
 x8-20020a05651c024800b002455b3d9abbmr21451205ljn.366.1648489750323; Mon, 28
 Mar 2022 10:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220322185709.141236-1-namhyung@kernel.org> <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220328113946.GA8939@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 28 Mar 2022 10:48:59 -0700
Message-ID: <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
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

On Mon, Mar 28, 2022 at 4:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 22, 2022 at 11:57:09AM -0700, Namhyung Kim wrote:
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index ee2fd7614a93..c88deda77cf2 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >       }
> >
> >       set_current_state(state);
> > +     trace_contention_begin(lock, 0);
> >       for (;;) {
> >               bool first;
> >
> > @@ -710,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >  skip_wait:
> >       /* got the lock - cleanup and rejoice! */
> >       lock_acquired(&lock->dep_map, ip);
> > +     trace_contention_end(lock, 0);
> >
> >       if (ww_ctx)
> >               ww_mutex_lock_acquired(ww, ww_ctx);
>
> (note: it's possible to get to this trace_contention_end() without ever
> having passed a _begin -- fixed in the below)
>
> > @@ -721,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >  err:
> >       __set_current_state(TASK_RUNNING);
> >       __mutex_remove_waiter(lock, &waiter);
> > +     trace_contention_end(lock, ret);
> >  err_early_kill:
> >       raw_spin_unlock(&lock->wait_lock);
> >       debug_mutex_free_waiter(&waiter);
>
>
> So there was one thing here, that might or might not be important, but
> is somewhat inconsistent with the whole thing. That is, do you want to
> include optimistic spinning in the contention time or not?

Yes, this was in a grey area and would create begin -> begin -> end
path for mutexes.  But I think tools can handle it with the flags.

>
> Because currently you do it sometimes.
>
> Also, if you were to add LCB_F_MUTEX then you could have something like:

Yep, I'm ok with having the mutex flag.  Do you want me to send
v5 with this change or would you like to do it by yourself?

Thanks,
Namhyung


>
>
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -602,12 +602,14 @@ __mutex_lock_common(struct mutex *lock,
>         preempt_disable();
>         mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
>
> +       trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
>         if (__mutex_trylock(lock) ||
>             mutex_optimistic_spin(lock, ww_ctx, NULL)) {
>                 /* got the lock, yay! */
>                 lock_acquired(&lock->dep_map, ip);
>                 if (ww_ctx)
>                         ww_mutex_set_context_fastpath(ww, ww_ctx);
> +               trace_contention_end(lock, 0);
>                 preempt_enable();
>                 return 0;
>         }
> @@ -644,7 +646,7 @@ __mutex_lock_common(struct mutex *lock,
>         }
>
>         set_current_state(state);
> -       trace_contention_begin(lock, 0);
> +       trace_contention_begin(lock, LCB_F_MUTEX);
>         for (;;) {
>                 bool first;
>
> @@ -684,10 +686,16 @@ __mutex_lock_common(struct mutex *lock,
>                  * state back to RUNNING and fall through the next schedule(),
>                  * or we must see its unlock and acquire.
>                  */
> -               if (__mutex_trylock_or_handoff(lock, first) ||
> -                   (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
> +               if (__mutex_trylock_or_handoff(lock, first))
>                         break;
>
> +               if (first) {
> +                       trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> +                       if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> +                               break;
> +                       trace_contention_begin(lock, LCB_F_MUTEX);
> +               }
> +
>                 raw_spin_lock(&lock->wait_lock);
>         }
>         raw_spin_lock(&lock->wait_lock);
> @@ -723,8 +731,8 @@ __mutex_lock_common(struct mutex *lock,
>  err:
>         __set_current_state(TASK_RUNNING);
>         __mutex_remove_waiter(lock, &waiter);
> -       trace_contention_end(lock, ret);
>  err_early_kill:
> +       trace_contention_end(lock, ret);
>         raw_spin_unlock(&lock->wait_lock);
>         debug_mutex_free_waiter(&waiter);
>         mutex_release(&lock->dep_map, ip);
