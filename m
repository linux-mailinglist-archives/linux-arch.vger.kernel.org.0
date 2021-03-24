Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDBA347A2F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 15:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhCXOFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhCXOFN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 10:05:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0AC061763
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 07:05:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n140so20888899oig.9
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfhOIdD0/JF1R4rl2yl8LbcQIZX0RUkjo+PIbGE7ciE=;
        b=kIHyqH8JFqLF0l4tVjAXu/sDM7iO8ss5W7oPbFSR+Bn7bdjw8XPZ8DzVZ0pXACYIug
         qej0C40RTpmUdDOXTstZhp7o/4HIfBz5cmPb7OdHwtnOA1D17xLmO8kfJmUZpflPVgC6
         uE+W69lYB6c55FX+05RO8s69fjyyAw+ZxaUGJQiU99Ad6F4PLxJ2iYJgPcpew1hynsfq
         D3uO41v+JiL2vRWHp1vkjYLUNfx3T1jM9iiCUo0Tj904SMJVraupg67zLibhTU+MIVYm
         nB5vdFrZq9zkoHPiuSNX2xc4DdZ+vBuSVbLLitsupYGNTzEFGGsjHhxTxjsREvVYkR1k
         JpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfhOIdD0/JF1R4rl2yl8LbcQIZX0RUkjo+PIbGE7ciE=;
        b=byAbZJmkmdlDm+adcGkgGSNhJsZ6Kqr3G+KakE8LKg/pzrLVw2mMASI2vnc97Epss0
         EYWEzuzcpa+v9Mr11FHW+nHij5FEJhH8tfY4qFPTpn9z/lWLKLhJdwN3ArANBgd45pKl
         8/6m1Ir0SbXw/7zMBKElPN7+RYOtiY5qtXld8JRqaCKEMvaunWCSPjw2ZiJhbDVvbkss
         X+3hALrMrwRsarhD/eSTrUnrgAXjiBYv1TqrrBi9RNVP+qkNJmgcRPfEpymrBYQtaEXt
         PNA8PMNnPn74PBCKs+Oa0bnS7NaOvTmYmPGbn7W+NPFxcK8FR3iW7fASGTAJORxYD9nV
         4m0A==
X-Gm-Message-State: AOAM530RidrVM1fJkojaxlQmpsxSZxYy6XB2nsZ7smGx2mSOmmXEEvqf
        /pBcMyq1rZj+JQuQhLWkIjCAR7EQbsHx8t9Hts4gWw==
X-Google-Smtp-Source: ABdhPJxdAYITQjy6PUTtztEnIEr7S6Tr2BKexm3VGKs9O0tMTmBvQVzf6klIwBU1ixhxrhKmArzODSCAgIOrKl1qqew=
X-Received: by 2002:aca:44d6:: with SMTP id r205mr2482806oia.172.1616594712647;
 Wed, 24 Mar 2021 07:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net> <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net>
In-Reply-To: <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 24 Mar 2021 15:05:01 +0100
Message-ID: <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
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

On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> One last try, I'll leave it alone now, I promise :-)

This looks like it does what you suggested, thanks! :-)

I'll still need to think about it, because of the potential problem
with modify-signal-races and what the user's synchronization story
would look like then.

> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -778,6 +778,9 @@ struct perf_event {
>         void *security;
>  #endif
>         struct list_head                sb_list;
> +
> +       unsigned long                   si_uattr;
> +       unsigned long                   si_data;
>  #endif /* CONFIG_PERF_EVENTS */
>  };
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5652,13 +5652,17 @@ static long _perf_ioctl(struct perf_even
>                 return perf_event_query_prog_array(event, (void __user *)arg);
>
>         case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
> +               struct perf_event_attr __user *uattr;
>                 struct perf_event_attr new_attr;
> -               int err = perf_copy_attr((struct perf_event_attr __user *)arg,
> -                                        &new_attr);
> +               int err;
>
> +               uattr = (struct perf_event_attr __user *)arg;
> +               err = perf_copy_attr(uattr, &new_attr);
>                 if (err)
>                         return err;
>
> +               event->si_uattr = (unsigned long)uattr;
> +
>                 return perf_event_modify_attr(event,  &new_attr);
>         }
>         default:
> @@ -6399,7 +6403,12 @@ static void perf_sigtrap(struct perf_eve
>         clear_siginfo(&info);
>         info.si_signo = SIGTRAP;
>         info.si_code = TRAP_PERF;
> -       info.si_errno = event->attr.type;
> +       info.si_addr = (void *)event->si_data;
> +
> +       info.si_perf = event->si_uattr;
> +       if (event->parent)
> +               info.si_perf = event->parent->si_uattr;
> +
>         force_sig_info(&info);
>  }
>
> @@ -6414,8 +6423,8 @@ static void perf_pending_event_disable(s
>                 WRITE_ONCE(event->pending_disable, -1);
>
>                 if (event->attr.sigtrap) {
> -                       atomic_set(&event->event_limit, 1); /* rearm event */
>                         perf_sigtrap(event);
> +                       atomic_set_release(&event->event_limit, 1); /* rearm event */
>                         return;
>                 }
>
> @@ -9121,6 +9130,7 @@ static int __perf_event_overflow(struct
>         if (events && atomic_dec_and_test(&event->event_limit)) {
>                 ret = 1;
>                 event->pending_kill = POLL_HUP;
> +               event->si_data = data->addr;
>
>                 perf_event_disable_inatomic(event);
>         }
> @@ -12011,6 +12021,8 @@ SYSCALL_DEFINE5(perf_event_open,
>                 goto err_task;
>         }
>
> +       event->si_uattr = (unsigned long)attr_uptr;
> +
>         if (is_sampling_event(event)) {
>                 if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>                         err = -EOPNOTSUPP;
