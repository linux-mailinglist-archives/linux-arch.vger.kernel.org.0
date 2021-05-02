Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69C9370EBE
	for <lists+linux-arch@lfdr.de>; Sun,  2 May 2021 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhEBTOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 May 2021 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhEBTOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 May 2021 15:14:38 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD418C06138B
        for <linux-arch@vger.kernel.org>; Sun,  2 May 2021 12:13:46 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so783335ooj.9
        for <linux-arch@vger.kernel.org>; Sun, 02 May 2021 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emMfiYi99q3nX4v+CBQmuXsA/kqjvpixR7oLzYPLuiM=;
        b=eRrh8/FTxx8mY93zg7f5u2PqJag/AV+2CsamonnCrPl50D5ybWNE9RjM9IHFNGK0Hp
         tsQCQr9ZC0GehGcA6cOcwWjxeWjJU/S5VN/vJm45DBqcCLu0rlO90skMuIBy2K9DlLkg
         ukIAGtF3hQFZqp6AexAJ9ojqZ6R6plqZsdvVHcD+Q3hnqs3zSlCcUxdIXr8zVrKT0b90
         K9S1dNQqshSjqZqacgx4pkJCgXGhv7suX4I0XIqsmEW7olqA2qVrMj9ulfZezJAI479J
         Sc35Ku4NkEnOxygYrD+m2aeiOpvlD9SRGRymQrSXXTsljf/pKMCvCCY++dEYJEDOAYfq
         T+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emMfiYi99q3nX4v+CBQmuXsA/kqjvpixR7oLzYPLuiM=;
        b=TT9h2HjjLNDhX/kHaLncJHy1zdILpfUxFnmZHHW3d0JlMg4uKJZR42awJ/jS91GaYa
         h7wfmiJ5Cl/eAYrycx7IWOlUqJ0hZYO1mcqm5tSWX268K+c7I/SqPJUdzCtDE0mqzIzi
         DN6tXkeGMPqLqIyS/62epr6H2sNz1Lj95EbAywwbYDhTZH4DaeRfgkzLOXvk7xeNaY86
         VU/Xz58Ns0bbjU4wNhxTjnHk+GqCb4muSZrt8nzr0k+Tv6RasX28qyJlk4zwxn7jUUJS
         B+EVvnS14Mov6cyMjkoErk+nGj7k39PSW73yn2wFCpNFwvdF7/IEYQpMqOpm8NjUSAFP
         ImKw==
X-Gm-Message-State: AOAM5331ZlmACWfHLGO/tfGMgwhYh9gH6tmJfnctEVe0j3DDFZrjtSAe
        gtb4zvy3ClHYTg9gyq5WDbW3RLwgnaAwVh3+MF0QWA==
X-Google-Smtp-Source: ABdhPJxwRjSJbo3C+Nwhf9lgspATPfUeP4Li99I0sKmagHuY+vIt3q37BWEwAiuogCr1O2KSyZDFBjA9IZlwBT6otMg=
X-Received: by 2002:a4a:e715:: with SMTP id y21mr2293005oou.54.1619982825669;
 Sun, 02 May 2021 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m11rarqqx2.fsf_-_@fess.ebiederm.org>
 <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com> <m1wnshm14b.fsf@fess.ebiederm.org>
In-Reply-To: <m1wnshm14b.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sun, 2 May 2021 21:13:34 +0200
Message-ID: <CANpmjNNpsdqCp51_P=NCM=fMREhN6HWQL7aiOdyfqu=aUmkR7A@mail.gmail.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2 May 2021 at 20:39, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Sat, 1 May 2021 at 01:44, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Don't abuse si_errno and deliver all of the perf data in si_perf.
> >>
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >
> > Thank you for the fix, this looks cleaner.
> >
> > Just note that this patch needs to include updates to
> > tools/testing/selftests/perf_events. This should do it:
> >>  sed -i 's/si_perf/si_perf.data/g; s/si_errno/si_perf.type/g' tools/testing/selftests/perf_events/*.c
> >
> > Subject: s/perf_data/perf data/ ?
> >
> > For uapi, need to switch to __u32, see below.
>
> Good point.
>
> The one thing that this doesn't do is give you a 64bit field
> on 32bit architectures.
>
> On 32bit builds the layout is:
>
>         int si_signo;
>         int si_errno;
>         int si_code;
>         void __user *_addr;
>
> So I believe if the first 3 fields were moved into the _sifields union
> si_perf could define a 64bit field as it's first member and it would not
> break anything else.
>
> Given that the data field is 64bit that seems desirable.

Yes, it's quite unfortunate -- it was __u64 at first, but then we
noticed it broke 32-bit architectures like arm:
https://lore.kernel.org/linux-arch/20210422191823.79012-1-elver@google.com/

Thanks,
-- Marco
