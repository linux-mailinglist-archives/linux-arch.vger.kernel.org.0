Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B8F0148
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 16:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbfKEPZ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 10:25:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40161 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389800AbfKEPZ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 10:25:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id r27so17840484oij.7
        for <linux-arch@vger.kernel.org>; Tue, 05 Nov 2019 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+CYhJdTSBVhddLA7SYp46bo6WQRi/eEfG9ft70Vz4c=;
        b=u71G5vAuN5eK4YoBCJXnO2xds7IiybauVnqeGdwQsyuyUKRRK2KzpPy8AkptdNszl0
         Wq9Vt/ffCzkCv/uLd1uWoUG4vyVl2SBm9iWUDuL4oE7qUMJ4phsvzkjUxdA27V2ICx9o
         uBbxZFMVgjJjHRj1gL3mUrxJacQPLolbUyn4RB/h0DbC9ke/h+SVsE9Rm6bGY+eGMXOK
         30hQkUjoPYI4G0qkU+HujVyzOf0cNK6sVRcmhopEl8qxn12pEeeRSmyAUeMf9xr3ABrP
         so7aUxHrFqu6xs0RVD4EqX4GpWa+uzVVoDhwDzTVBU+1jHAhktEc2Vw312PLMQSDCV6d
         rB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+CYhJdTSBVhddLA7SYp46bo6WQRi/eEfG9ft70Vz4c=;
        b=XkFCOjiRe2L0wUKBhyE2/oOWDQq70TWGFkoSErMJJpWIIMCdAHXcgSNpHHpR7J6sZ3
         FG0CdvcAyo6qAcNQXpL9t2x6UedI5CF4YPBOAwAKYA9S5d0jDaB2USYZ0FzOLfKOhBqc
         O24GOIoPEFU7FeG/E22i6zs4vPTWNE5Bx7lgZHrs2i3J/hpN8fxCTh+Rcw7dCVVqO6dB
         wlsyCnzhM/nLF+4QlzQX8enkW9SHDIeYK3QgRkkt2X47MRsBZAcleaKwBqyDkdOT6n7+
         ftzhp3TCKQMK0JACHFAwWNk00DXbDyq/SGtF5cT3JqrNQGBPNN9nay0BM65GV8T9L9Y/
         20Cg==
X-Gm-Message-State: APjAAAVxELn6iHKcCC5+kMMQh+1GVXxV7FiUfGkK7GQiEIEYv8KxLwit
        sPQTlTWAdoOcF0vu40Vqpt7bJ1352QqVliLPPYUA1g==
X-Google-Smtp-Source: APXvYqwQPHjqYkXc5Iunuduc62ptGdrF5fouPXC6HOb4+99xjsnytfPeV4dt6tvvElLHXEhrxEU7gefGOW36iszyH58=
X-Received: by 2002:aca:f046:: with SMTP id o67mr1917381oih.155.1572967526641;
 Tue, 05 Nov 2019 07:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20191104142745.14722-1-elver@google.com> <20191104164717.GE20975@paulmck-ThinkPad-P72>
 <CANpmjNOtR6NEsXGo=M1o26d8vUyF7gwj=gew+LAeE_D+qfbEmQ@mail.gmail.com>
 <20191104194658.GK20975@paulmck-ThinkPad-P72> <CANpmjNPpVCRhgVgfaApZJCnMKHsGxVUno+o-Fe+7OYKmPvCboQ@mail.gmail.com>
 <20191105142035.GR20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191105142035.GR20975@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 Nov 2019 16:25:14 +0100
Message-ID: <CANpmjNPEukbQtD5BGpHdxqMvnq7Uyqr9o3QCByjCKxtPboEJtA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add Kernel Concurrency Sanitizer (KCSAN)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 Nov 2019 at 15:20, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Nov 05, 2019 at 12:10:56PM +0100, Marco Elver wrote:
> > On Mon, 4 Nov 2019 at 20:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Nov 04, 2019 at 07:41:30PM +0100, Marco Elver wrote:
> > > > On Mon, 4 Nov 2019 at 17:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Mon, Nov 04, 2019 at 03:27:36PM +0100, Marco Elver wrote:
> > > > > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > > > > KCSAN is a sampling watchpoint-based data-race detector. More details
> > > > > > are included in Documentation/dev-tools/kcsan.rst. This patch-series
> > > > > > only enables KCSAN for x86, but we expect adding support for other
> > > > > > architectures is relatively straightforward (we are aware of
> > > > > > experimental ARM64 and POWER support).
> > > > > >
> > > > > > To gather early feedback, we announced KCSAN back in September, and
> > > > > > have integrated the feedback where possible:
> > > > > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > > > >
> > > > > > We want to point out and acknowledge the work surrounding the LKMM,
> > > > > > including several articles that motivate why data-races are dangerous
> > > > > > [1, 2], justifying a data-race detector such as KCSAN.
> > > > > > [1] https://lwn.net/Articles/793253/
> > > > > > [2] https://lwn.net/Articles/799218/
> > > > > >
> > > > > > The current list of known upstream fixes for data-races found by KCSAN
> > > > > > can be found here:
> > > > > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > > >
> > > > > Making this more accessible to more people seems like a good thing.
> > > > > So, for the series:
> > > > >
> > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > Much appreciated. Thanks, Paul!
> > > >
> > > > Any suggestions which tree this could eventually land in?
> > >
> > > I would guess that Dmitry might have some suggestions.
> >
> > I checked and we're both unclear what the most obvious tree to land in
> > is (the other sanitizers are mm related, which KCSAN is not).
> >
> > One suggestion that comes to my mind is for KCSAN to go through the
> > same tree (rcu?) as the LKMM due to their inherent relationship. Would
> > that make most sense?
>
> It works for me, though you guys have to continue to be the main
> developers.  ;-)

Great, thanks. We did add an entry to MAINTAINERS, so yes of course. :-)

> I will go through the patches more carefully, and please look into the
> kbuild test robot complaint.

I just responded to that, it seems to be a sparse problem.

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> > Thanks,
> > -- Marco
> >
> > > >
> > > > > > Changelog
> > > > > > ---------
> > > > > > v3:
> > > > > > * Major changes:
> > > > > >  - Add microbenchmark.
> > > > > >  - Add instruction watchpoint skip randomization.
> > > > > >  - Refactor API and core runtime fast-path and slow-path. Compared to
> > > > > >    the previous version, with a default config and benchmarked using the
> > > > > >    added microbenchmark, this version is 3.8x faster.
> > > > > >  - Make __tsan_unaligned __alias of generic accesses.
> > > > > >  - Rename kcsan_{begin,end}_atomic ->
> > > > > >    kcsan_{nestable,flat}_atomic_{begin,end}
> > > > > >  - For filter list in debugfs.c use kmalloc+krealloc instead of
> > > > > >    kvmalloc.
> > > > > >  - Split Documentation into separate patch.
> > > > > >
> > > > > > v2: http://lkml.kernel.org/r/20191017141305.146193-1-elver@google.com
> > > > > > * Major changes:
> > > > > >  - Replace kcsan_check_access(.., {true, false}) with
> > > > > >    kcsan_check_{read,write}.
> > > > > >  - Change atomic-instrumented.h to use __atomic_check_{read,write}.
> > > > > >  - Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
> > > > > >    contexts.
> > > > > >
> > > > > > v1: http://lkml.kernel.org/r/20191016083959.186860-1-elver@google.com
> > > > > >
> > > > > > Marco Elver (9):
> > > > > >   kcsan: Add Kernel Concurrency Sanitizer infrastructure
> > > > > >   kcsan: Add Documentation entry in dev-tools
> > > > > >   objtool, kcsan: Add KCSAN runtime functions to whitelist
> > > > > >   build, kcsan: Add KCSAN build exceptions
> > > > > >   seqlock, kcsan: Add annotations for KCSAN
> > > > > >   seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
> > > > > >   asm-generic, kcsan: Add KCSAN instrumentation for bitops
> > > > > >   locking/atomics, kcsan: Add KCSAN instrumentation
> > > > > >   x86, kcsan: Enable KCSAN for x86
> > > > > >
> > > > > >  Documentation/dev-tools/index.rst         |   1 +
> > > > > >  Documentation/dev-tools/kcsan.rst         | 217 +++++++++
> > > > > >  MAINTAINERS                               |  11 +
> > > > > >  Makefile                                  |   3 +-
> > > > > >  arch/x86/Kconfig                          |   1 +
> > > > > >  arch/x86/boot/Makefile                    |   2 +
> > > > > >  arch/x86/boot/compressed/Makefile         |   2 +
> > > > > >  arch/x86/entry/vdso/Makefile              |   3 +
> > > > > >  arch/x86/include/asm/bitops.h             |   6 +-
> > > > > >  arch/x86/kernel/Makefile                  |   7 +
> > > > > >  arch/x86/kernel/cpu/Makefile              |   3 +
> > > > > >  arch/x86/lib/Makefile                     |   4 +
> > > > > >  arch/x86/mm/Makefile                      |   3 +
> > > > > >  arch/x86/purgatory/Makefile               |   2 +
> > > > > >  arch/x86/realmode/Makefile                |   3 +
> > > > > >  arch/x86/realmode/rm/Makefile             |   3 +
> > > > > >  drivers/firmware/efi/libstub/Makefile     |   2 +
> > > > > >  include/asm-generic/atomic-instrumented.h | 393 +++++++--------
> > > > > >  include/asm-generic/bitops-instrumented.h |  18 +
> > > > > >  include/linux/compiler-clang.h            |   9 +
> > > > > >  include/linux/compiler-gcc.h              |   7 +
> > > > > >  include/linux/compiler.h                  |  35 +-
> > > > > >  include/linux/kcsan-checks.h              |  97 ++++
> > > > > >  include/linux/kcsan.h                     | 115 +++++
> > > > > >  include/linux/sched.h                     |   4 +
> > > > > >  include/linux/seqlock.h                   |  51 +-
> > > > > >  init/init_task.c                          |   8 +
> > > > > >  init/main.c                               |   2 +
> > > > > >  kernel/Makefile                           |   6 +
> > > > > >  kernel/kcsan/Makefile                     |  11 +
> > > > > >  kernel/kcsan/atomic.h                     |  27 ++
> > > > > >  kernel/kcsan/core.c                       | 560 ++++++++++++++++++++++
> > > > > >  kernel/kcsan/debugfs.c                    | 275 +++++++++++
> > > > > >  kernel/kcsan/encoding.h                   |  94 ++++
> > > > > >  kernel/kcsan/kcsan.h                      | 131 +++++
> > > > > >  kernel/kcsan/report.c                     | 306 ++++++++++++
> > > > > >  kernel/kcsan/test.c                       | 121 +++++
> > > > > >  kernel/sched/Makefile                     |   6 +
> > > > > >  lib/Kconfig.debug                         |   2 +
> > > > > >  lib/Kconfig.kcsan                         | 119 +++++
> > > > > >  lib/Makefile                              |   3 +
> > > > > >  mm/Makefile                               |   8 +
> > > > > >  scripts/Makefile.kcsan                    |   6 +
> > > > > >  scripts/Makefile.lib                      |  10 +
> > > > > >  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
> > > > > >  tools/objtool/check.c                     |  18 +
> > > > > >  46 files changed, 2526 insertions(+), 206 deletions(-)
> > > > > >  create mode 100644 Documentation/dev-tools/kcsan.rst
> > > > > >  create mode 100644 include/linux/kcsan-checks.h
> > > > > >  create mode 100644 include/linux/kcsan.h
> > > > > >  create mode 100644 kernel/kcsan/Makefile
> > > > > >  create mode 100644 kernel/kcsan/atomic.h
> > > > > >  create mode 100644 kernel/kcsan/core.c
> > > > > >  create mode 100644 kernel/kcsan/debugfs.c
> > > > > >  create mode 100644 kernel/kcsan/encoding.h
> > > > > >  create mode 100644 kernel/kcsan/kcsan.h
> > > > > >  create mode 100644 kernel/kcsan/report.c
> > > > > >  create mode 100644 kernel/kcsan/test.c
> > > > > >  create mode 100644 lib/Kconfig.kcsan
> > > > > >  create mode 100644 scripts/Makefile.kcsan
> > > > > >
> > > > > > --
> > > > > > 2.24.0.rc1.363.gb1bccd3e3d-goog
> > > > > >
> > > > >
> > > > > --
> > > > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191104164717.GE20975%40paulmck-ThinkPad-P72.
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191104194658.GK20975%40paulmck-ThinkPad-P72.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191105142035.GR20975%40paulmck-ThinkPad-P72.
