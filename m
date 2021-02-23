Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1677322D45
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhBWPRY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 10:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhBWPRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 10:17:23 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B6C06174A
        for <linux-arch@vger.kernel.org>; Tue, 23 Feb 2021 07:16:41 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 15so2659843qvp.13
        for <linux-arch@vger.kernel.org>; Tue, 23 Feb 2021 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yeydPNUBbnBa03B4CtFFI71u/VogiWMTrnYPrUvA5o=;
        b=uA/OwFba1OXPlE3eec0Lkuteazee/7d9Xd178WLkv5dnu8A92vJ3djvigMQ7jAUU3x
         nME8FehzY+kcVllN570rvIsKcFTRvTQDbwiIWDA0cQJz1KzNcJZX4h3plHWk+bqaBjZn
         SvN7Gfc1RxuY/+i/jtrAaPenwBNwNWegEHtOvmo0Vjx+8aRq1Ed96qCOX++Sjt87mB/X
         GTaVTu2K4unxbuD3deSDB5Gpq8x62S/upY7qcSNNBkfFos/vSWFzs2kFtXbKsusKVwNb
         7OlTcPYQlWfPWA0VtuzWC2Oxbe11yZH4qDiRafr6Ymkyv+N7fk7X9ZAaFHxyTMoLW8ij
         Er2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yeydPNUBbnBa03B4CtFFI71u/VogiWMTrnYPrUvA5o=;
        b=PhoFiC7HburhM5Vjp/CTnij6npN41e/6TwZ16NnBFPGwYP1pu1B/6HxyXB1LA8mIlj
         fYllJGXudGv/mivgfHutKa+uO76oiuv8+pzVkvChT41OWd2eb3mJia3s0WQkC75a7XCk
         qlgi/U0s9DsZmiYo6ociptSi4WbM/+7BV0IJuZuWoPdOAACreQqDfW7PYRu782DS2ajQ
         Gf42uu3TzkP6NGa5/fC/XqvbU5MRejqaD5wh8XVkmurubNkIDO8DITF42p5CjMFlL3ML
         DkIAGMOyBJE0YaAxzilpbSd4X3xB1YtX7GCSlQR80FY9tWla1lmEWF2sGY6205CJ5Euo
         qQEg==
X-Gm-Message-State: AOAM530VkJl3OcLGwraC+JvvRzllkYBbLr6DCRoLOyma0Sj3nVExtRcH
        ArkmbHLZ2C+dfUC7RalcF79o4ymG1MXAdwzUHzGnww==
X-Google-Smtp-Source: ABdhPJxLBKxZOO7lXuX++W27qocF5V5S96s4v/Tgf2IBWVEhIaFHgtodagR8vVVk8//B7pIxeik4PswMSc2P9YWh/9A=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr25737289qva.18.1614093400799;
 Tue, 23 Feb 2021 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-5-elver@google.com>
 <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com> <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com>
In-Reply-To: <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 16:16:29 +0100
Message-ID: <CACT4Y+ar7=q0p=LFxkbKbKhz-U3rwdf=PJ3Gg3=ZLP6w_sgTeA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
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
        linux-m68k@lists.linux-m68k.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 23, 2021 at 4:10 PM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> > > Encode information from breakpoint attributes into siginfo_t, which
> > > helps disambiguate which breakpoint fired.
> > >
> > > Note, providing the event fd may be unreliable, since the event may have
> > > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > > triggering and the signal being delivered to user space.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  kernel/events/core.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 8718763045fd..d7908322d796 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
> > >         info.si_signo = SIGTRAP;
> > >         info.si_code = TRAP_PERF;
> > >         info.si_errno = event->attr.type;
> > > +
> > > +       switch (event->attr.type) {
> > > +       case PERF_TYPE_BREAKPOINT:
> > > +               info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > > +               info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > > +               break;
> > > +       default:
> > > +               /* No additional info set. */
> >
> > Should we prohibit using attr.sigtrap for !PERF_TYPE_BREAKPOINT if we
> > don't know what info to pass yet?
>
> I don't think it's necessary. This way, by default we get support for
> other perf events. If user space observes si_perf==0, then there's no
> information available. That would require that any event type that
> sets si_perf in future, must ensure that it sets si_perf!=0.
>
> I can add a comment to document the requirement here (and user space
> facing documentation should get a copy of how the info is encoded,
> too).
>
> Alternatively, we could set si_errno to 0 if no info is available, at
> the cost of losing the type information for events not explicitly
> listed here.
>
> What do you prefer?

Ah, I see.
Let's wait for the opinions of other people. There are a number of
options for how to approach this.

> > > +               break;
> > > +       }
> > > +
> > >         force_sig_info(&info);
> > >  }
> > >
> > > --
> > > 2.30.0.617.g56c4b15f3c-goog
> > >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANpmjNP1wQvG0SNPP2L9QO%3Dnatf0XU8HXj-r2_-U4QZxtr-dVA%40mail.gmail.com.
