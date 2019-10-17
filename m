Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC312DAF92
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394835AbfJQOPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:15:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35772 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJQOPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:15:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so2296381oig.2
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNom0VFlbRYX78r4OKfXRzBJyj1ZzMem6+U6GRAPZGs=;
        b=Kv2dqE7DBOjguEO+g1W15SDaL2UD4S+vcY1QNPVx8SnJ2E5T2gdGww8rE+GRAhGYAF
         ILBKEBvVHXtMZ3BmzKphs7G2RPP27C2X9+3swp8cGF2i/u/m66J9i9veo+ceI3Bj3osq
         MWlFe3gqzbgrf9H5LWLUoOvE3Mg2Hr3oEmfWcYTbw5kZC11hxu6xajsIp6aP88N8Ct22
         ZTltpyBZZS0029i8Cfhdn6iROub4bj69y7h+zPK6we8swLKJcmbnUZt3w2D0PXT19Z7X
         n98Y+SLmGCkEjEMCpEuotp9DxZ2U01vOh+RKvP1EMnD5m2ntbhD2ntvxfPt1+/6e0XPl
         W8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNom0VFlbRYX78r4OKfXRzBJyj1ZzMem6+U6GRAPZGs=;
        b=kB1TxGizCd9Bc+P+j1Pw2YBK2xyMTgpnyGBEZdh3m/7jrW5Q94JW2NhD3ZhiSjHKCc
         g2p2MsWwoVWDsIY6uiVlc/c4HgxVv8IerKrL1v5WUJWlngB/CppFiJaDmdzrpuVB3zCZ
         W/afj/65tvNB/N2x37wsO6djiU1ITg1sKVnl28xFjxvgITdXUTz5n5eXK/OLcJzqWDPw
         UHikx+j7vzQsOJfWwVBiAr/UlmtnLMoWzg3xp0llS/Xt6z2hVZ/xLlJnt0IILpcG1S2d
         t+r5lQZmhob7FzNu23UGSM93URYLWlZp9fIxn6ybIzyfohyL0z5l0WVqjLKzx7c+1Jbq
         SAoQ==
X-Gm-Message-State: APjAAAWdJ4+HwVHN1Jo9sRWWsDebpTGgLrPdocHGVMCHNUZ9SpwC9cdH
        N95gPczu5CO3VSd40eZMszH91wW//50u3Uqz/yNNnQ==
X-Google-Smtp-Source: APXvYqyuauWsvEE+jliJ5S7S3Gh0NvhZGewq3BAb0qQ2dVeR8Gj7daShagq5yO57tbCuu+twdnA3Uh6Z3wF+KW7VHrc=
X-Received: by 2002:aca:5015:: with SMTP id e21mr3502104oib.121.1571321732803;
 Thu, 17 Oct 2019 07:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
In-Reply-To: <20191016083959.186860-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Oct 2019 16:15:20 +0200
Message-ID: <CANpmjNPB8mFso7=WpUQ8Nbxon3kKTEGRUFMCVhjLNkfzey+TJg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add Kernel Concurrency Sanitizer (KCSAN)
To:     Marco Elver <elver@google.com>
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
        dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Wed, 16 Oct 2019 at 10:41, Marco Elver <elver@google.com> wrote:
>
> This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> KCSAN is a sampling watchpoint-based data-race detector. More details
> are included in Documentation/dev-tools/kcsan.rst. This patch-series
> only enables KCSAN for x86, but we expect adding support for other
> architectures is relatively straightforward (we are aware of
> experimental ARM64 and POWER support).
>
> To gather early feedback, we announced KCSAN back in September, and
> have integrated the feedback where possible:
> http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
>
> We want to point out and acknowledge the work surrounding the LKMM,
> including several articles that motivate why data-races are dangerous
> [1, 2], justifying a data-race detector such as KCSAN.
> [1] https://lwn.net/Articles/793253/
> [2] https://lwn.net/Articles/799218/
>
> The current list of known upstream fixes for data-races found by KCSAN
> can be found here:
> https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

Sent v2: http://lkml.kernel.org/r/20191017141305.146193-1-elver@google.com

Many thanks,
-- Marco

> Marco Elver (8):
>   kcsan: Add Kernel Concurrency Sanitizer infrastructure
>   objtool, kcsan: Add KCSAN runtime functions to whitelist
>   build, kcsan: Add KCSAN build exceptions
>   seqlock, kcsan: Add annotations for KCSAN
>   seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
>   asm-generic, kcsan: Add KCSAN instrumentation for bitops
>   locking/atomics, kcsan: Add KCSAN instrumentation
>   x86, kcsan: Enable KCSAN for x86
>
>  Documentation/dev-tools/kcsan.rst         | 202 ++++++++++
>  MAINTAINERS                               |  11 +
>  Makefile                                  |   3 +-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/boot/Makefile                    |   1 +
>  arch/x86/boot/compressed/Makefile         |   1 +
>  arch/x86/entry/vdso/Makefile              |   1 +
>  arch/x86/include/asm/bitops.h             |   2 +-
>  arch/x86/kernel/Makefile                  |   6 +
>  arch/x86/kernel/cpu/Makefile              |   3 +
>  arch/x86/lib/Makefile                     |   2 +
>  arch/x86/mm/Makefile                      |   3 +
>  arch/x86/purgatory/Makefile               |   1 +
>  arch/x86/realmode/Makefile                |   1 +
>  arch/x86/realmode/rm/Makefile             |   1 +
>  drivers/firmware/efi/libstub/Makefile     |   1 +
>  include/asm-generic/atomic-instrumented.h | 192 ++++++++-
>  include/asm-generic/bitops-instrumented.h |  18 +
>  include/linux/compiler-clang.h            |   9 +
>  include/linux/compiler-gcc.h              |   7 +
>  include/linux/compiler.h                  |  35 +-
>  include/linux/kcsan-checks.h              | 116 ++++++
>  include/linux/kcsan.h                     |  85 ++++
>  include/linux/sched.h                     |   7 +
>  include/linux/seqlock.h                   |  51 ++-
>  init/init_task.c                          |   6 +
>  init/main.c                               |   2 +
>  kernel/Makefile                           |   6 +
>  kernel/kcsan/Makefile                     |  14 +
>  kernel/kcsan/atomic.c                     |  21 +
>  kernel/kcsan/core.c                       | 458 ++++++++++++++++++++++
>  kernel/kcsan/debugfs.c                    | 225 +++++++++++
>  kernel/kcsan/encoding.h                   |  94 +++++
>  kernel/kcsan/kcsan.c                      |  81 ++++
>  kernel/kcsan/kcsan.h                      | 140 +++++++
>  kernel/kcsan/report.c                     | 307 +++++++++++++++
>  kernel/kcsan/test.c                       | 117 ++++++
>  kernel/sched/Makefile                     |   6 +
>  lib/Kconfig.debug                         |   2 +
>  lib/Kconfig.kcsan                         |  88 +++++
>  lib/Makefile                              |   3 +
>  mm/Makefile                               |   8 +
>  scripts/Makefile.kcsan                    |   6 +
>  scripts/Makefile.lib                      |  10 +
>  scripts/atomic/gen-atomic-instrumented.sh |   9 +-
>  tools/objtool/check.c                     |  17 +
>  46 files changed, 2364 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/dev-tools/kcsan.rst
>  create mode 100644 include/linux/kcsan-checks.h
>  create mode 100644 include/linux/kcsan.h
>  create mode 100644 kernel/kcsan/Makefile
>  create mode 100644 kernel/kcsan/atomic.c
>  create mode 100644 kernel/kcsan/core.c
>  create mode 100644 kernel/kcsan/debugfs.c
>  create mode 100644 kernel/kcsan/encoding.h
>  create mode 100644 kernel/kcsan/kcsan.c
>  create mode 100644 kernel/kcsan/kcsan.h
>  create mode 100644 kernel/kcsan/report.c
>  create mode 100644 kernel/kcsan/test.c
>  create mode 100644 lib/Kconfig.kcsan
>  create mode 100644 scripts/Makefile.kcsan
>
> --
> 2.23.0.700.g56cf767bdb-goog
>
