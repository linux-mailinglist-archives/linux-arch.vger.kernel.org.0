Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732EA347A62
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhCXON0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbhCXONI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 10:13:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CCC061763
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 07:13:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u8so1464925qtq.12
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XohPHX9rWTqjJvRyYcCWXA2q1vwA5OihINXfd2z/zo=;
        b=AuieUtcnBKgIlZBHY2MKXvJautp8rnH0/Zc3JfbrCzf4TZ/rkCzaCA+R+RmUvrIH1m
         E4S/ubhyqRRoc1wlHeic5TQS6wicvYaXwOjwAcwbynBZ8V/eh7b8OnJI4JjrQ3gp/auj
         zVni+ROSpwREgwKdrkLXequdeu3ax3xYqlF4ZdOTk9qAwTMz9EbW9WjZ3aYk4B+y1Mm7
         zOJGAqkEWaoy5cTjKaEKmogGG1iuc60Kh4iioFap/Xz//fJLQwHzk2XUc/vrYgOMIWcb
         JvNS96i/uzRwWCSWr3Q0/EGYKggxIJxNvHGEfid0i7V+xW3/NXdVqs5frh7Vyz20oGVI
         43Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XohPHX9rWTqjJvRyYcCWXA2q1vwA5OihINXfd2z/zo=;
        b=Ks4TLIxDI9E6TP3iZVJJSLMGe46+tjvxDFfjw0ivy41c15xKKl94A+sFKwuNlmniuL
         CZd50Zh/wRJKKbH/fwIEPh12lRTvGae7OIq8w2zPslINs5sVQfnvoeAm+eBIlLBQMmfZ
         gGGQoORJNHmhAfhLc0SRsb3exI4gx4IFF2fL8K5M1kLZgMMjcpqg7me9X87Nond4ppm2
         IsaXSzvagAf4oGEMndrKdV9HuhaKV2b8lQkcYNWor9f54+Re0miXQnd/q3OtrakvZ5X6
         n0D3QaVSBaiLda6YvPykC4Eb4zAJOLOjp7ZmN2ZiVaCdZvzFGTbiug7lAEgyuMY3yYtu
         xxfA==
X-Gm-Message-State: AOAM532yQ+T+wiyQ8pzLlbMtuQz9Vr/PiLXoh6nsxIvAXLnJaqc9cAsJ
        Lj2S3fw7hwkEyAd3lWMNqxWDqG14V4FZOfSz0fn1wQ==
X-Google-Smtp-Source: ABdhPJzyooXz/NQhT+vi8P+u5nAIKlMdHjMTa2M9OF4QnEon669FPBFrYSdo99++4/nKZIEWLO6wULgnA8OT/OATrfc=
X-Received: by 2002:ac8:6696:: with SMTP id d22mr3164170qtp.67.1616595187453;
 Wed, 24 Mar 2021 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net> <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net> <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
In-Reply-To: <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Mar 2021 15:12:56 +0100
Message-ID: <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
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

On Wed, Mar 24, 2021 at 3:05 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > One last try, I'll leave it alone now, I promise :-)
>
> This looks like it does what you suggested, thanks! :-)
>
> I'll still need to think about it, because of the potential problem
> with modify-signal-races and what the user's synchronization story
> would look like then.

I agree that this looks inherently racy. The attr can't be allocated
on stack, user synchronization may be tricky and expensive. The API
may provoke bugs and some users may not even realize the race problem.

One potential alternative is use of an opaque u64 context (if we could
shove it into the attr). A user can pass a pointer to the attr in
there (makes it equivalent to this proposal), or bit-pack size/type
(as we want), pass some sequence number or whatever.



> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -778,6 +778,9 @@ struct perf_event {
> >         void *security;
> >  #endif
> >         struct list_head                sb_list;
> > +
> > +       unsigned long                   si_uattr;
> > +       unsigned long                   si_data;
> >  #endif /* CONFIG_PERF_EVENTS */
> >  };
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5652,13 +5652,17 @@ static long _perf_ioctl(struct perf_even
> >                 return perf_event_query_prog_array(event, (void __user *)arg);
> >
> >         case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
> > +               struct perf_event_attr __user *uattr;
> >                 struct perf_event_attr new_attr;
> > -               int err = perf_copy_attr((struct perf_event_attr __user *)arg,
> > -                                        &new_attr);
> > +               int err;
> >
> > +               uattr = (struct perf_event_attr __user *)arg;
> > +               err = perf_copy_attr(uattr, &new_attr);
> >                 if (err)
> >                         return err;
> >
> > +               event->si_uattr = (unsigned long)uattr;
> > +
> >                 return perf_event_modify_attr(event,  &new_attr);
> >         }
> >         default:
> > @@ -6399,7 +6403,12 @@ static void perf_sigtrap(struct perf_eve
> >         clear_siginfo(&info);
> >         info.si_signo = SIGTRAP;
> >         info.si_code = TRAP_PERF;
> > -       info.si_errno = event->attr.type;
> > +       info.si_addr = (void *)event->si_data;
> > +
> > +       info.si_perf = event->si_uattr;
> > +       if (event->parent)
> > +               info.si_perf = event->parent->si_uattr;
> > +
> >         force_sig_info(&info);
> >  }
> >
> > @@ -6414,8 +6423,8 @@ static void perf_pending_event_disable(s
> >                 WRITE_ONCE(event->pending_disable, -1);
> >
> >                 if (event->attr.sigtrap) {
> > -                       atomic_set(&event->event_limit, 1); /* rearm event */
> >                         perf_sigtrap(event);
> > +                       atomic_set_release(&event->event_limit, 1); /* rearm event */
> >                         return;
> >                 }
> >
> > @@ -9121,6 +9130,7 @@ static int __perf_event_overflow(struct
> >         if (events && atomic_dec_and_test(&event->event_limit)) {
> >                 ret = 1;
> >                 event->pending_kill = POLL_HUP;
> > +               event->si_data = data->addr;
> >
> >                 perf_event_disable_inatomic(event);
> >         }
> > @@ -12011,6 +12021,8 @@ SYSCALL_DEFINE5(perf_event_open,
> >                 goto err_task;
> >         }
> >
> > +       event->si_uattr = (unsigned long)attr_uptr;
> > +
> >         if (is_sampling_event(event)) {
> >                 if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> >                         err = -EOPNOTSUPP;
