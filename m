Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B12345B49
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCWJry (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCWJr1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 05:47:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE3C061764
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 02:47:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso18870639otq.3
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgweAXsQTwePYGvzySvRrmFVPab8jCtXeq0art5Xlzk=;
        b=c83oOIai0vT/1Ehf7TwcWcfH05xGv8gE6Hg9fLoNtkbRowQEpsxj0F9qOqpyseVzcK
         Q2rN4vwz/CFe7+PkWFTwCUeAyxAT31qQdtAeXfXs01n2UBp+LZwJq3hVB4sDOKwEeXyR
         RY+Hh9E6NspuxTBUJKfL2OA81sVHSqqt5Ih+LGq0V/NDMZOHpPIdEUkuL1e0trb8yM8c
         7MXr4IjK5B1jHwhY2nXdhfqGP8wCPR558Pk6EKwP+ETOoUDB9HndX6hp3wvxdcp6S2U6
         vmFQM21beG3mVjRFHTyq/nWVtwXAuSm3IyGLEtPu8jHKd067xDHfseWi99DCjr/vRArs
         5Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgweAXsQTwePYGvzySvRrmFVPab8jCtXeq0art5Xlzk=;
        b=gSa9oMxhEU3jVUwPJ2JuJmJiBUn0dQe7284uYsjNMAMTi7t6PJ0BznRt0QuXPs7fIx
         vXuttvN7NQOBLmjPyrJvDOvelGAmYg3Kt6JZnf1/pExBN5qZTwki6/p7JkV+vPTTsoFZ
         39Ge5kGE3k0nYh4iodhC4lZ35qBY75MGe0b91pZSxp3w/ncVSLdMql87mHslPILRWvI9
         6Pc1jk7RXTHAGTrIZu5HwFwvhJ9NvdhQZ69tTxqa+MCHUILECJKRLbI41YdvriN2qdJV
         CAmViAU22qg8I6NPqyExTfd3vQKHr+8VVo5XUZm/N4qI1V9Ko6o6rR4qgvqLqmhmAi1X
         HO6A==
X-Gm-Message-State: AOAM5303Frg3HFFCCsQq3ezLTbifNZWtH7O/DNPGYbHwALz1LCLI9yUK
        FEPhMvUYWuu2Ig3zCtiFcwCgVw6OOBkrV+tppXTtCQ==
X-Google-Smtp-Source: ABdhPJzMH/VSfRK/jh3ZF5YMuSkaPYCGAs70cdgURS9L1MinkG75zqWL9g7656lDBjdloiRtfRfpIaLvWD9vkS5E3HU=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3724534otq.251.1616492846280;
 Tue, 23 Mar 2021 02:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210310104139.679618-1-elver@google.com> <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com> <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
In-Reply-To: <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Mar 2021 10:47:13 +0100
Message-ID: <CANpmjNN6_jO5vK8fteJ7bEi1gM6Ho2kZxSq9avocM3A5TyFL=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for remove_on_exec
To:     Ian Rogers <irogers@google.com>
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
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 23 Mar 2021 at 04:10, Ian Rogers <irogers@google.com> wrote:
> On Mon, Mar 22, 2021 at 6:24 AM Marco Elver <elver@google.com> wrote:
> > On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> > > Add kselftest to test that remove_on_exec removes inherited events from
> > > child tasks.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > To make compatible with more recent libc, we'll need to fixup the tests
> > with the below.
> >
> > Also, I've seen that tools/perf/tests exists, however it seems to be
> > primarily about perf-tool related tests. Is this correct?
> >
> > I'd propose to keep these purely kernel ABI related tests separate, and
> > that way we can also make use of the kselftests framework which will
> > also integrate into various CI systems such as kernelci.org.
>
> Perhaps there is a way to have both? Having the perf tool spot an
> errant kernel feels like a feature. There are also
> tools/lib/perf/tests and Vince Weaver's tests [1]. It is possible to
> run standalone tests from within perf test by having them be executed
> by a shell test.

Thanks for the pointers. Sure, I'd support more additional tests.

But I had another look and it seems the tests in
tools/{perf,lib/perf}/tests do focus on perf-tool or the library
respectively, so adding kernel ABI tests there feels wrong. (If
perf-tool somehow finds use for sigtrap, or remove_on_exec, then
having a perf-tool specific test for those would make sense again.)

The tests at [1] do seem relevant, and its test strategy seems more
extensive, including testing older kernels. Unfortunately it is
out-of-tree, but that's probably because it was started before
kselftest came into existence. But there are probably things that [1]
contains that are not appropriate in-tree.

It's all a bit confusing.

Going forward, if you insist on tests being also added to [1], we can
perhaps mirror some of the kselftest tests there. There's also a
logistical problem with the tests added here, because the tests
require an up-to-date siginfo_t, and they use the kernel's
<asm/siginfo.h> with some trickery. Until libc's siginfo_t is updated,
it probably doesn't make sense to add these tests to [1].

The other question is, would it be possible to also copy some of the
tests in [1] and convert to kselftest, so that they live in-tree and
are tested regularly (CI, ...)?

Because I'd much prefer in-tree tests with little boilerplate, that
are structured with parsable output; in the kernel we have the
kselftest framework for tests with a user space component, and KUnit
for pure in-kernel tests.

Thanks,
-- Marco

> Thanks,
> Ian
>
> [1] https://github.com/deater/perf_event_tests
[...]
