Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BB370440
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhD3XvK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhD3XvJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 19:51:09 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF2C06138D
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 16:50:20 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so15877422oop.12
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/q7DptLC8egYbR7opYakYP8H9u2iTP4dEK6HMA0wYI=;
        b=cI3yQrkNwf6EUbrFxXy4L8iUKQfRVeS7b27mJg8q4vPtLahufJGGltwG+4Qf/9Ruwm
         f/wwpUsV1hedJDN6gO+CDbXQFd1EDANy5OWSYC5txTLOr6HwQ3Hdp+RAJRrEyM51E0b1
         Ay4KYZqHN+MIFPvtAgJRfdW8fCFI0WdceWauCiiGhO7jRSnzhliA82FIEVEeImYwJUse
         gsrxp7fSduKCZ8Re3n2SedOIotgrbj3y0duChsFTVKbjNdb1Zdrbzjclv+ylIqUeYPWk
         xYjRFZ0b1s3S9OjWnRDpozoQSQZ9qpwojgea2yAHW2WavS+J07N6pNxM5D4IJEv1vw3a
         Hhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/q7DptLC8egYbR7opYakYP8H9u2iTP4dEK6HMA0wYI=;
        b=p0Ld5Mch1Uu8iR+m0uK6a6BCLKI3My7JHZxe4DTCM5IZYswTzB+7C87x0CzpoBgR6t
         RyNw/zdDE62JMfsdZXMaQS2unp9Rew3SL8cbaK60n7Ygu5AJbYyiYsanfkQbQlmwYCkM
         GCVTCdGJV1IoEoCtVXOanQ5URZQ6IhMohlzH8L2z7MABK2RFLs8tw5n6sWgNINS1LG8K
         1o9eGoF8Ms4C8cIPAhZ5IequmHJO9FZbxeyj4Wywd2n4dQae4KSRel8KNa3jrww46Glr
         mBvl8fGUQnD7W6DHvVKkmY8dHVdmZeohFtabIXh8SU64kvJ1mTBlKJRfqmmw+lo2tA/r
         ZTQg==
X-Gm-Message-State: AOAM5339ih8xYUbIfTicEmwEMp8ApLjSGFeo4maMjeufxIXJvTxDD8t7
        85ELOOLjanejuP0IOcOjATGD45yE8ChCtlXUmChGKw==
X-Google-Smtp-Source: ABdhPJyxcbYG0z/wbFYM2KfbPDk4IEK2fp9FIJ5gR9LNAk+AoOPt5KThaXTWfhI4EkWsyRXXiXzxtUETGhL2umOnUNk=
X-Received: by 2002:a4a:e692:: with SMTP id u18mr6616156oot.54.1619826619823;
 Fri, 30 Apr 2021 16:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com> <m17dkjttpj.fsf@fess.ebiederm.org>
In-Reply-To: <m17dkjttpj.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 01:50:08 +0200
Message-ID: <CANpmjNNU=00iq50xyVpqeg21kata+cTS=wZ7zcU_78K=rWL-=w@mail.gmail.com>
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
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

On Fri, 30 Apr 2021 at 22:15, Eric W. Biederman <ebiederm@xmission.com> wrote:
[...]
> arm64 only abuses si_errno in compat code for bug compatibility with
> arm32.
>
> > Given it'd be wasted space otherwise, and we define the semantics of
> > whatever is stored in siginfo on the new signal, it'd be good to keep.
>
> Except you don't completely.  You are not defining a new signal.  You
> are extending the definition of SIGTRAP.  Anything generic that
> responds to all SIGTRAPs can reasonably be looking at si_errno.

I see where you're coming from, and agree with this if si_errno
already had some semantics for some subset of SIGTRAPs. I've tried to
analyze the situation a bit further, since siginfo seems to be a giant
minefield and semantics is underspecified at best. :-)

Do any of the existing SIGTRAPs define si_errno to be set? As far as I
can tell, they don't.

If this is true, I think there are benefits and downsides to
repurposing si_errno (similar to what SIGSYS did). The obvious
downside is as you suggest, it's not always a real errno. The benefit
is that we avoid introducing more and more fields -- i.e. if we permit
si_errno to be repurposed for SIGTRAP and its value depends on the
precise si_code, too, we simplify siginfo's overall definition (also
given every new field needs more code in kernel/signal.c, too).

Given SIGTRAPs are in response to some user-selected event in the
user's code (breakpoints, ptrace, etc. ... now perf events), the user
must already check the si_code to select the right action because
SIGTRAPs are not alike (unlike, e.g. SIGSEGV). Because of this, I
think that repurposing si_errno in an si_code-dependent way for
SIGTRAPs is safe.

If you think it is simply untenable to repurpose si_errno for
SIGTRAPs, please confirm -- I'll just send a minimal patch to fix (I'd
probably just remove setting it... everything else is too intrusive as
a "fix".. sigh).

The cleanups as you outline below seem orthogonal and not urgent for
5.13 (all changes and cleanups for __ARCH_SI_TRAPNO seem too intrusive
without -next exposure).

Thanks,
-- Marco

> Further you are already adding a field with si_perf you can just as
> easily add a second field with well defined semantics for that data.
>
> >> The code is only safe if the analysis that says we can move si_trapno
> >> and perhaps the ia64 fields into the union is correct.  It looks like
> >> ia64 much more actively uses it's signal extension fields including for
> >> SIGTRAP, so I am not at all certain the generic definition of
> >> perf_sigtrap is safe on ia64.
> >
> > Trying to understand the requirements of si_trapno myself: safe here
> > would mean that si_trapno is not required if we fire our SIGTRAP /
> > TRAP_PERF.
> >
> > As far as I can tell that is the case -- see below.
> >
> >> > I suppose in theory sparc64 or alpha might start using the other
> >> > fields in the future, and an application might be compiled against
> >> > mismatched headers, but that is unlikely and is already broken
> >> > with the current headers.
> >>
> >> If we localize the use of si_trapno to just a few special cases on alpha
> >> and sparc I think we don't even need to worry about breaking userspace
> >> on any architecture.  It will complicate siginfo_layout, but it is a
> >> complication that reflects reality.
> >>
> >> I don't have a clue how any of this affects ia64.  Does perf work on
> >> ia64?  Does perf work on sparc, and alpha?
> >>
> >> If perf works on ia64 we need to take a hard look at what is going on
> >> there as well.
> >
> > No perf on ia64, but it seems alpha and sparc have perf:
> >
> >       $ git grep 'select.*HAVE_PERF_EVENTS$' -- arch/
> >       arch/alpha/Kconfig:     select HAVE_PERF_EVENTS    <--
> >       arch/arc/Kconfig:       select HAVE_PERF_EVENTS
> >       arch/arm/Kconfig:       select HAVE_PERF_EVENTS
> >       arch/arm64/Kconfig:     select HAVE_PERF_EVENTS
> >       arch/csky/Kconfig:      select HAVE_PERF_EVENTS
> >       arch/hexagon/Kconfig:   select HAVE_PERF_EVENTS
> >       arch/mips/Kconfig:      select HAVE_PERF_EVENTS
> >       arch/nds32/Kconfig:     select HAVE_PERF_EVENTS
> >       arch/parisc/Kconfig:    select HAVE_PERF_EVENTS
> >       arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS
> >       arch/riscv/Kconfig:     select HAVE_PERF_EVENTS
> >       arch/s390/Kconfig:      select HAVE_PERF_EVENTS
> >       arch/sh/Kconfig:        select HAVE_PERF_EVENTS
> >       arch/sparc/Kconfig:     select HAVE_PERF_EVENTS    <--
> >       arch/x86/Kconfig:       select HAVE_PERF_EVENTS
> >       arch/xtensa/Kconfig:    select HAVE_PERF_EVENTS
> >
> > Now, given ia64 is not an issue, I wanted to understand the semantics of
> > si_trapno. Per https://man7.org/linux/man-pages/man2/sigaction.2.html, I
> > see:
> >
> >       int si_trapno;    /* Trap number that caused
> >                            hardware-generated signal
> >                            (unused on most architectures) */
> >
> > ... its intended semantics seem to suggest it would only be used by some
> > architecture-specific signal like you identified above. So if the
> > semantics is some code of a hardware trap/fault, then we're fine and do
> > not need to set it.
> >
> > Also bearing in mind we define the semantics any new signal, and given
> > most architectures do not have si_trapno, definitions of new generic
> > signals should probably not include odd architecture specific details
> > related to old architectures.
> >
> > From all this, my understanding now is that we can move si_trapno into
> > the union, correct? What else did you have in mind?
>
> Yes.  Let's move si_trapno into the union.
>
> That implies a few things like siginfo_layout needs to change.
>
> The helpers in kernel/signal.c can change to not imply that
> if you define __ARCH_SI_TRAPNO you must always define and
> pass in si_trapno.  A force_sig_trapno could be defined instead
> to handle the cases that alpha and sparc use si_trapno.
>
> It would be nice if a force_sig_perf_trap could be factored
> out of perf_trap and placed in kernel/signal.c.
>
> My experience (especially this round) is that it becomes much easier to
> audit the users of siginfo if there is a dedicated function in
> kernel/signal.c that is simply passed the parameters that need
> to be placed in siginfo.
>
> So I would very much like to see if I can make force_sig_info static.
>
> Eric
>
