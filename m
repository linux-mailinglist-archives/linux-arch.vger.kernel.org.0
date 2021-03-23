Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9530A345C12
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCWKlq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 06:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCWKlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 06:41:35 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4910C061574
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 03:41:34 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so4824352ook.2
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaMgAdM2KItPrKUMCZHabW9a3SL1RYlGywDdCoOttJE=;
        b=HaI/Ls3Xxp4PiIqn7YsRY6f0Wr7X/xAaryHq0Ns2IEfD0GdSCR+4ITbGkbJT9UXXsT
         kY1r5QTmgtILT6A0Ne1jGw3AadSpClsCy4ta4xdHyx2yexqhxsoCMXKNWtx9NgShVWAc
         ogQ4n8oSLpEG3tsagpYf3fWuTd8Pe7N0n404eqU0dqGgqUyHjWK3hr+cPkggOYqfoRXn
         A2vbwFHHLtsODjLZuiJ86pZ4uGIMzZUmInN6SWqsIKZQZCPlxb69hD4CP4aZg27rtAgK
         YccAtquOslR1+Z6W9VmOh5EyQ6Km8qzQean7EpYrWGCBLstwapCRvahHJkFGzTcoPFM7
         ZEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaMgAdM2KItPrKUMCZHabW9a3SL1RYlGywDdCoOttJE=;
        b=LbJKWAkxJ4T/jlVc4yDoPnFNee2gp14EnEgLCNhUl71PjNqv4HoDYF/c4s9X2YOPEW
         ++VDhiU5FBiqPe0vz3X1/QLdGghtGIfsY+HHnX3sW8nxQlI0CUSZUYVSYQ+yu563ehoI
         B1FkhA/hECAc+orJGwJJDaDQC6BH5wMJ3eEJcxFaRUOuAaDyETfNSZkMufzGFvjeT8Zs
         dSfg0ysds/VGUamNykid/aYiLVor4IZpjcloX3+P9qe6vuMqSycgbx7QqoaK6uBYq2sF
         fbhRW6dQr3+U9byQ1FSowrkECdd40BpYXSEh6L5RyQnrwG2ri56zcGfUAEWZnQG5Nvph
         pyug==
X-Gm-Message-State: AOAM532gKpXj7EvTTTvF8uVD5yOdgK9Wsc+zMfnznR9tghG9Iwj5KXdy
        0PoHAG9ZiZZ89iAWJ/zzfWR50sGZTn7puFmMXCcemA==
X-Google-Smtp-Source: ABdhPJx9cOfUC85pOdYrj8gQKReOta+wufUAU0wiHMXFo141kFatu3HmQkubYd5iSEuvXln2c4xjLNLCd7IZj2+2Fec=
X-Received: by 2002:a05:6820:273:: with SMTP id c19mr3310170ooe.54.1616496093820;
 Tue, 23 Mar 2021 03:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210310104139.679618-1-elver@google.com> <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com> <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com> <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
In-Reply-To: <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Mar 2021 11:41:22 +0100
Message-ID: <CANpmjNO1mRBFBQ6Rij-6ojVPKkaB6JLHD2WOVxhQeqxsqit2-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for remove_on_exec
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 23 Mar 2021 at 11:32, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 23, 2021 at 10:52:41AM +0100, Marco Elver wrote:
>
> > with efs->func==__perf_event_enable. I believe it's sufficient to add
> >
> >       mutex_lock(&parent_event->child_mutex);
> >       list_del_init(&event->child_list);
> >       mutex_unlock(&parent_event->child_mutex);
> >
> > right before removing from context. With the version I have now (below
> > for completeness), extended torture with the above test results in no
> > more warnings and the test also passes.
> >
>
> > +     list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
> > +             struct perf_event *parent_event = event->parent;
> > +
> > +             if (!event->attr.remove_on_exec)
> >                       continue;
> >
> > +             if (!is_kernel_event(event))
> > +                     perf_remove_from_owner(event);
> >
> > +             modified = true;
> > +
> > +             if (parent_event) {
> >                       /*
> > +                      * Remove event from parent, to avoid race where the
> > +                      * parent concurrently iterates through its children to
> > +                      * enable, disable, or otherwise modify an event.
> >                        */
> > +                     mutex_lock(&parent_event->child_mutex);
> > +                     list_del_init(&event->child_list);
> > +                     mutex_unlock(&parent_event->child_mutex);
> >               }
>
>                 ^^^ this, right?
>
> But that's something perf_event_exit_event() alread does. So then you're
> worried about the order of things.

Correct. We somehow need to prohibit the parent from doing an
event_function_call() while we potentially deactivate the context with
perf_remove_from_context().

> > +
> > +             perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
> > +             perf_event_exit_event(event, ctx, current, true);
> >       }
>
> perf_event_release_kernel() first does perf_remove_from_context() and
> then clears the child_list, and that makes sense because if we're there,
> there's no external access anymore, the filedesc is gone and nobody will
> be iterating child_list anymore.
>
> perf_event_exit_task_context() and perf_event_exit_event() OTOH seem to
> rely on ctx->task == TOMBSTONE to sabotage event_function_call() such
> that if anybody is iterating the child_list, it'll NOP out.
>
> But here we don't have neither, and thus need to worry about the order
> vs child_list iteration.
>
> I suppose we should stick sync_child_event() in there as well.
>
> And at that point there's very little value in still using
> perf_event_exit_event()... let me see if there's something to be done
> about that.

I don't mind dropping use of perf_event_exit_event() and open coding
all of this. That would also avoid modifying perf_event_exit_event().

But I leave it to you what you think is nicest.

Thanks,
-- Marco
