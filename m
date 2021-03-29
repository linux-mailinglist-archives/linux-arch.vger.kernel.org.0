Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018E334D26A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhC2Ocp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhC2Ocb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 10:32:31 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43199C061756
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 07:32:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so12451003otq.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pd5+1lyxF0IpfUFm+C/Q0BotbJ7mj/8xSGsdykFryU=;
        b=WOGPfNiBH1rBOn7rKEj2te7OWuckEUpvJ+NQWbuqa1LLPtC8ni5+XceiDdRhii9Ezo
         M3ZPxxLkR1FXKmahCW23aHCLAWw+1OTM6ecK7JG1myf3fkFFkHbKy3NxP5RvTvpov7Y9
         EsByzRGNkr3bhxp3Sv7v6YCoNu0qTBw+quXgG6uVUGQ8KuWIX4x/qiDMmEaufKVIHUXm
         6yyKWYP37AglSKbupam4uq5h1Nmct7LqgHslu+LbupQAHibZM9OqxzCSknm9Ae0xDYpl
         o0BLDukK5niYeGEuiSDb/YFoa+1gQZhKm0HpxsyBbqblfmPZjrQumWmzZOKLO9gjRBmK
         Nx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pd5+1lyxF0IpfUFm+C/Q0BotbJ7mj/8xSGsdykFryU=;
        b=D8GnTMh+yknwsXoihajr03mGKunLpISrvmRz82H3JZ4sNBPz4b5mUMCgK9K+5SO8MU
         Ld4CAcaMbW0DMPP2fmwGjAYB32fG5y+q6bGnOAUhTJ3ADRhkw5mOVNaqau0xAOtJ1Rph
         METX8ABKhWN4/k7teCrFFnt0YMtHay0Y5VT3pGsRWvuUWfc+QdHiY7EQ2g+c5g3oN/TH
         6vCbBvKI8BeAalPCgNvLEkU98PEDu3ppNa2pmDnksOjHZq+F+KnHg0fTdIrF7z5+KMrn
         /lMnEhm5UNt2l/SAcp0OyQy0h+wN+NvBCOR/9oDkX0ClqxDjCBnqxsW36MWsvPQnLbEn
         LlLw==
X-Gm-Message-State: AOAM531tASHM3wMBa71FS3/ZjQbAhr5jacOoNGnsj6RTjJlvb4HObcB8
        frsdHdhYmkOcg23or2W7u0L6FpKYZIw11mRfHmLtjg==
X-Google-Smtp-Source: ABdhPJxXlJbzmAzqT33taumiK8BdMN/OkVmDMWa6AP1XrX+5I2Yys/7Pp8HpnlAdCIy2hzJQig2Zesc70wVcHKDSdNI=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr23773028otq.251.1617028350375;
 Mon, 29 Mar 2021 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <20210329142705.GA24849@redhat.com>
In-Reply-To: <20210329142705.GA24849@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 16:32:18 +0200
Message-ID: <CANpmjNN4kiGiuSSm2g0empgKo3DW-UJ=eNDB6sv1bpypD13vqQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Oleg Nesterov <oleg@redhat.com>
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
        <linux-kselftest@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Mar 2021 at 16:27, Oleg Nesterov <oleg@redhat.com> wrote:
> On 03/29, Peter Zijlstra wrote:
> >
> > On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> > > @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
> > >  {
> > >     struct kernel_siginfo info;
> > >
> > > +   /*
> > > +    * This irq_work can race with an exiting task; bail out if sighand has
> > > +    * already been released in release_task().
> > > +    */
> > > +   if (!current->sighand)
> > > +           return;
>
> This is racy. If "current" has already passed exit_notify(), current->parent
> can do release_task() and destroy current->sighand right after the check.
>
> > Urgh.. I'm not entirely sure that check is correct, but I always forget
> > the rules with signal. It could be we ought to be testing PF_EXISTING
> > instead.
>
> Agreed, PF_EXISTING check makes more sense in any case, the exiting task
> can't receive the signal anyway.

Thanks for confirming. I'll switch to just checking PF_EXITING
(PF_EXISTING does not exist :-)).

Thanks,
-- Marco
