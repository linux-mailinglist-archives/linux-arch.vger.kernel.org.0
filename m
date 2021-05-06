Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC441374FB1
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEFHCJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 03:02:09 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:38498 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhEFHCJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 03:02:09 -0400
Received: by mail-vs1-f52.google.com with SMTP id j128so2425040vsc.5;
        Thu, 06 May 2021 00:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoT+A0718WNsTbHBS5BGp5G+tj2RfytrZk7R7tgIl08=;
        b=X248YRswNzAfo6iG1kNtPokKkdBeSO8s61uJm6eTDuG4PrFnr/zB6gAcYTzegMUI4Z
         7Fx2czLZ55vauWk8OQ5WrPkt42CQ5BJI5FjbLf8m1xhxBX0tHRJvP9U+vBHMeNyaxAJI
         AV7hCQsNQXyGuIGDFTSgGFIl9JE0CQF4goqEE3mPsHqbcjaI65xlc4l+3iL2yZG6HiyF
         2AoZEQL10iJD0Q0NgwAI+s6QUMEaiSoOnHOmv4E33xUxYk6oHbbEn2yn38w+LsFYf75e
         zxIDlf2LrgGp6pYfceDVsbje3BNhitT06tWGt/xR9GPFrsLjM9itTWpHyqR5YibvMTgH
         JbLg==
X-Gm-Message-State: AOAM533z2oqp/Njt2gXVBeP4JbJ/wH3mLrRaHR+z67MOlVfxdnHQAJ4j
        7niDnJlGECU7b+fv8m91nNSTIAZSSNJxQ6fPIBfuqH4jwpA=
X-Google-Smtp-Source: ABdhPJwtWn/D8K3Zn0jy1HK/vfeVlKteOEghQDe5DwJ1/OrY0tE/MhHEc0uYnsYlAuAKkFm96EHQ1hlHO1JAX4ayqVg=
X-Received: by 2002:a67:f503:: with SMTP id u3mr1764571vsn.3.1620284470626;
 Thu, 06 May 2021 00:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 May 2021 09:00:59 +0200
Message-ID: <CAMuHMdUXh45iNmzrqqQc1kwD_OELHpujpst1BTMXDYTe7vKSCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
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

Hi Eric,

On Tue, May 4, 2021 at 11:14 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
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

Thanks for your series, which is now in next-20210506.

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

No changes needed for other architectures?
All m68k configs are broken with

arch/m68k/kernel/signal.c:626:35: error: 'siginfo_t' {aka 'struct
siginfo'} has no member named 'si_perf'; did you mean 'si_errno'?

See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14537820/

There are still a few more references left to si_perf:

$ git grep -n -w si_perf
Next/merge.log:2902:Merging userns/for-next (4cf4e48fff05 signal: sort
out si_trapno and si_perf)
arch/m68k/kernel/signal.c:626:  BUILD_BUG_ON(offsetof(siginfo_t,
si_perf) != 0x10);
include/uapi/linux/perf_event.h:467:     * siginfo_t::si_perf, e.g. to
permit user to identify the event.
tools/testing/selftests/perf_events/sigtrap_threads.c:46:/* Unique
value to check si_perf is correctly set from
perf_event_attr::sig_data. */

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
