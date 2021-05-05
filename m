Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B999374785
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhEER61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhEER6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 13:58:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119CC00F78F
        for <linux-arch@vger.kernel.org>; Wed,  5 May 2021 10:28:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso2442728otl.0
        for <linux-arch@vger.kernel.org>; Wed, 05 May 2021 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4X2E1XRo1phsTQg3EtaDOCHvhUj1Tt6jnzKJ2/36r4=;
        b=Ci17lKNM6SGVNOqaBWBsKIWTYwwHJkNl1mRsigIQBzQUV+Fe7R1iEbp4p0Gi7GvMLt
         vpPFAF3pJjstdTj6jq3muVEeH8qUqVxVmGHZr24Pb3bnvcBdv12/sd389ZxY9jRAjLyh
         A5ziYDkfBaYnFip5b0Ud/+WFd/dJgrQJUN3KTfYLrHwlQZulsdUg0gPk3ej58DmJG9na
         6hzzjTzYsHRPDwgh/yQZUFTqLpQJJ7OtdlA6gz0OP37sYrKUJc7epGDksRCP9QDukzY1
         OKOgnsm2Bu0EUuSj/f0d3dCe6+8/dv21IaF7lQa6r8eIHy6VgML1pohdp9Zq326OyzGi
         4lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4X2E1XRo1phsTQg3EtaDOCHvhUj1Tt6jnzKJ2/36r4=;
        b=Drqpb6tklHeS9C60ecBmF+hftr0rMFFf0/U5BgCxegyAjxMWK1viuBJCy3+ifoReLy
         +TrAUzAbSOYBhIm7LBAEBC5E4S9tVOt72oxtUkGhkXfUVL9gzjsaxdf9+tG5ZhTKyndT
         HgS76Sc5DZq1PKgodnQL/6mCGa0n7km0hEXbJs3nUI1iPjA59FLOccjkCTD5vRSX5V6I
         LGd+b6Nx9shX8F4aG3ni7lkMn/LqTTkSQv1ndAKpXObjt+cO9CQ5JkMnsg6cATbT5UdA
         7eCGTvQ5NeD7qGJ+ZSur3myYOZkZvEpueNguKTDdVVmzR2wcv74tuscq5v8eYK/FVnDt
         sjfw==
X-Gm-Message-State: AOAM530k+Xx83NE0e+GkJ8nSxWuAKtbaO+MBc+HfGv4Bfhr7z5OxqX8F
        chLGXDsXpE3xqfnq6Ei+JPSBqLV1ZMQur+oB1a8yMg==
X-Google-Smtp-Source: ABdhPJzCrgcsmVZ17vp3OnrajNVg5oiT8XHdZ69sPTTuAVz+vJkCkBYQQwz+3urgaEY63+KWW5G2D2SF2vbGhXDm6yU=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr24974375otk.17.1620235736198;
 Wed, 05 May 2021 10:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:28:00 +0200
Message-ID: <CANpmjNMLbc_8HtUVB2fOu3eV7vO2rMdZAZ4BZ02hndeXu3hUoA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
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

On Tue, 4 May 2021 at 23:13, Eric W. Biederman <ebiederm@xmission.com> wrote:
> This set of changes sorts out the ABI issues with SIGTRAP TRAP_PERF, and
> hopefully will can get merged before any userspace code starts using the
> new ABI.
>
> The big ideas are:
> - Placing the asserts first to prevent unexpected ABI changes
> - si_trapno becomming ordinary fault subfield.
> - struct signalfd_siginfo is almost full
>
> This set of changes starts out with Marco's static_assert changes and
> additional one of my own that enforces the fact that the alignment of
> siginfo_t is also part of the ABI.  Together these build time
> checks verify there are no unexpected ABI changes in the changes
> that follow.
>
> The field si_trapno is changed to become an ordinary extension of the
> _sigfault member of siginfo.
>
> The code is refactored a bit and then si_perf_type is added along side
> si_perf_data in the _perf subfield of _sigfault of siginfo_t.
>
> Finally the signalfd_siginfo fields are removed as they appear to be
> filling up the structure without userspace actually being able to use
> them.
>
> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
>
> Eric W. Biederman (9):
>       signal: Verify the alignment and size of siginfo_t
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Use dedicated helpers to send signals with si_trapno set
>       signal: Remove __ARCH_SI_TRAPNO
>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the siginfo perf data in _perf
>       signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo
>
> Marco Elver (3):
>       sparc64: Add compile-time asserts for siginfo_t offsets
>       arm: Add compile-time asserts for siginfo_t offsets
>       arm64: Add compile-time asserts for siginfo_t offsets
>
>  arch/alpha/include/uapi/asm/siginfo.h              |   2 -
>  arch/alpha/kernel/osf_sys.c                        |   2 +-
>  arch/alpha/kernel/signal.c                         |   4 +-
>  arch/alpha/kernel/traps.c                          |  24 ++---
>  arch/alpha/mm/fault.c                              |   4 +-
>  arch/arm/kernel/signal.c                           |  39 +++++++
>  arch/arm64/kernel/signal.c                         |  39 +++++++
>  arch/arm64/kernel/signal32.c                       |  39 +++++++
>  arch/mips/include/uapi/asm/siginfo.h               |   2 -
>  arch/sparc/include/uapi/asm/siginfo.h              |   3 -
>  arch/sparc/kernel/process_64.c                     |   2 +-
>  arch/sparc/kernel/signal32.c                       |  37 +++++++
>  arch/sparc/kernel/signal_64.c                      |  36 +++++++
>  arch/sparc/kernel/sys_sparc_32.c                   |   2 +-
>  arch/sparc/kernel/sys_sparc_64.c                   |   2 +-
>  arch/sparc/kernel/traps_32.c                       |  22 ++--
>  arch/sparc/kernel/traps_64.c                       |  44 ++++----
>  arch/sparc/kernel/unaligned_32.c                   |   2 +-
>  arch/sparc/mm/fault_32.c                           |   2 +-
>  arch/sparc/mm/fault_64.c                           |   2 +-
>  arch/x86/kernel/signal_compat.c                    |  15 ++-
>  fs/signalfd.c                                      |  23 ++---
>  include/linux/compat.h                             |  10 +-
>  include/linux/sched/signal.h                       |  13 +--
>  include/linux/signal.h                             |   3 +-
>  include/uapi/asm-generic/siginfo.h                 |  20 ++--
>  include/uapi/linux/signalfd.h                      |   4 +-
>  kernel/events/core.c                               |  11 +-
>  kernel/signal.c                                    | 113 +++++++++++++--------
>  .../selftests/perf_events/sigtrap_threads.c        |  12 +--
>  30 files changed, 373 insertions(+), 160 deletions(-)

Looks good, thanks a lot! I ran selftests/perf_events on x86-64, and
build-tested x86-32, arm, arm64, sparc, alpha.

I added my Reviewed/Acked-by to the various patches.

Thanks,
-- Marco
