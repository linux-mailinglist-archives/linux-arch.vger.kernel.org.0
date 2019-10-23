Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECAE166C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfJWJlW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 05:41:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42337 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403822AbfJWJlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 05:41:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so31297021qto.9
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPICzfN8jk9a5YVfl1sh7UIdtbJViu655bwlF7LS658=;
        b=V55CsmiOpeLnJkYC3XZ9LgUKCTF/e+fwX5C1OCgb7GVIkeWQ17UuR/hVI0XVMhk+7h
         3lUlWcEXX01Zs+PiCvq9e4pJ1HRR4BKmYFaFc4Db60kbvCptSjkMs/dp55CTl9hAfnIn
         K2bMIRGHlUW015jd7uYJ6BQXmRSlffkeOcewxxnOO0XZcEFUrxwR5zNeMay0eVZs3JpS
         RoFtqd5yf9avX7udBaSnBYDV00Gy8PdhfcKUQ/m2Ar9GkFV5zJt2lSix2+T8BRydPCYa
         sMLk9X1o/UsaiCmXmmzxTsa/XHLwgS1P3z8woWnRFr3hJVGegN8Ghn99b6ngpBNd8Atj
         D7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPICzfN8jk9a5YVfl1sh7UIdtbJViu655bwlF7LS658=;
        b=PJMWosX+V9tb+qi6Cz5DiePns+c4L3BZrSMt/Ru1+QNzZI46an900DAKuID3owdZhV
         O5ME3WfDff4+FHsUzD7VyXwb0vpRNc2j05HZAXPtAClY+WOV1HpVTsaWI5X/P5fsDeIK
         iB4Xnp+fTCvvzP6IFV3cHNpNtuGR5NK7vbJp8pMSuN18gVj6+4p67b/bUijYvM9o05xZ
         vmb/i58aOT3fwe/sID+y/TBE+23ECg7iwD/IrPxXYe88GKj2a/zdNzT8zPtNr+kSnjk8
         bcz1jkOBEgwi64v1zSr6+zKPcXFz7uA2TCnXunmhidWQOQxZoW9JVSSnhlxmWaBuO0yf
         dXAQ==
X-Gm-Message-State: APjAAAXotaXqAkybdPXDqHDLgL+zme+lX24PKbJ1pEAF1mRfhGsk5n6z
        qnbXBwBfqMwJ/3HeJGVT3IFTGTC4EA38/7ufy/TGPA==
X-Google-Smtp-Source: APXvYqxEa0EHYeg5nrO5OjL/EUtKztI3T07M3CyjIPcWFSUPcM1mAohpRKdXWQcF6NHxGTzzdjAiYMy/DZuVzDywewU=
X-Received: by 2002:ad4:4345:: with SMTP id q5mr7859172qvs.80.1571823677972;
 Wed, 23 Oct 2019 02:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-2-elver@google.com>
In-Reply-To: <20191017141305.146193-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 11:41:06 +0200
Message-ID: <CACT4Y+Z0SNqx1FyK8rHYX6HeUfLSfifNRiQ5LXf3iParNYvCpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
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
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

" "On Thu, Oct 17, 2019 at 4:13 PM Marco Elver <elver@google.com> wrote:
>
> Kernel Concurrency Sanitizer (KCSAN) is a dynamic data-race detector for
> kernel space. KCSAN is a sampling watchpoint-based data-race detector.
> See the included Documentation/dev-tools/kcsan.rst for more details.
>
> This patch adds basic infrastructure, but does not yet enable KCSAN for
> any architecture.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Elaborate comment about instrumentation calls emitted by compilers.
> * Replace kcsan_check_access(.., {true, false}) with
>   kcsan_check_{read,write} for improved readability.
> * Change bug title of race of unknown origin to just say "data-race in".
> * Refine "Key Properties" in kcsan.rst, and mention observed slow-down.
> * Add comment about safety of find_watchpoint without user_access_save.
> * Remove unnecessary preempt_disable/enable and elaborate on comment why
>   we want to disable interrupts and preemptions.
> * Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
>   contexts [Suggested by Mark Rutland].
> ---
>  Documentation/dev-tools/kcsan.rst | 203 ++++++++++++++
>  MAINTAINERS                       |  11 +
>  Makefile                          |   3 +-
>  include/linux/compiler-clang.h    |   9 +
>  include/linux/compiler-gcc.h      |   7 +
>  include/linux/compiler.h          |  35 ++-
>  include/linux/kcsan-checks.h      | 147 ++++++++++
>  include/linux/kcsan.h             | 108 ++++++++
>  include/linux/sched.h             |   4 +
>  init/init_task.c                  |   8 +
>  init/main.c                       |   2 +
>  kernel/Makefile                   |   1 +
>  kernel/kcsan/Makefile             |  14 +
>  kernel/kcsan/atomic.c             |  21 ++
>  kernel/kcsan/core.c               | 428 ++++++++++++++++++++++++++++++
>  kernel/kcsan/debugfs.c            | 225 ++++++++++++++++
>  kernel/kcsan/encoding.h           |  94 +++++++
>  kernel/kcsan/kcsan.c              |  86 ++++++
>  kernel/kcsan/kcsan.h              | 140 ++++++++++
>  kernel/kcsan/report.c             | 306 +++++++++++++++++++++
>  kernel/kcsan/test.c               | 117 ++++++++
>  lib/Kconfig.debug                 |   2 +
>  lib/Kconfig.kcsan                 |  88 ++++++
>  lib/Makefile                      |   3 +
>  scripts/Makefile.kcsan            |   6 +
>  scripts/Makefile.lib              |  10 +
>  26 files changed, 2069 insertions(+), 9 deletions(-)
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
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> new file mode 100644
> index 000000000000..497b09e5cc96
> --- /dev/null
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -0,0 +1,203 @@
> +The Kernel Concurrency Sanitizer (KCSAN)
> +========================================
> +
> +Overview
> +--------
> +
> +*Kernel Concurrency Sanitizer (KCSAN)* is a dynamic data-race detector for
> +kernel space. KCSAN is a sampling watchpoint-based data-race detector -- this
> +is unlike Kernel Thread Sanitizer (KTSAN), which is a happens-before data-race
> +detector. Key priorities in KCSAN's design are lack of false positives,
> +scalability, and simplicity. More details can be found in `Implementation
> +Details`_.
> +
> +KCSAN uses compile-time instrumentation to instrument memory accesses. KCSAN is
> +supported in both GCC and Clang. With GCC it requires version 7.3.0 or later.
> +With Clang it requires version 7.0.0 or later.
> +
> +Usage
> +-----
> +
> +To enable KCSAN configure kernel with::
> +
> +    CONFIG_KCSAN = y
> +
> +KCSAN provides several other configuration options to customize behaviour (see
> +their respective help text for more info).
> +
> +debugfs
> +~~~~~~~
> +
> +* The file ``/sys/kernel/debug/kcsan`` can be read to get stats.
> +
> +* KCSAN can be turned on or off by writing ``on`` or ``off`` to
> +  ``/sys/kernel/debug/kcsan``.
> +
> +* Writing ``!some_func_name`` to ``/sys/kernel/debug/kcsan`` adds
> +  ``some_func_name`` to the report filter list, which (by default) blacklists
> +  reporting data-races where either one of the top stackframes are a function
> +  in the list.
> +
> +* Writing either ``blacklist`` or ``whitelist`` to ``/sys/kernel/debug/kcsan``
> +  changes the report filtering behaviour. For example, the blacklist feature
> +  can be used to silence frequently occurring data-races; the whitelist feature
> +  can help with reproduction and testing of fixes.
> +
> +Error reports
> +~~~~~~~~~~~~~
> +
> +A typical data-race report looks like this::
> +
> +    ==================================================================
> +    BUG: KCSAN: data-race in generic_permission / kernfs_refresh_inode
> +
> +    write to 0xffff8fee4c40700c of 4 bytes by task 175 on cpu 4:
> +     kernfs_refresh_inode+0x70/0x170
> +     kernfs_iop_permission+0x4f/0x90
> +     inode_permission+0x190/0x200
> +     link_path_walk.part.0+0x503/0x8e0
> +     path_lookupat.isra.0+0x69/0x4d0
> +     filename_lookup+0x136/0x280
> +     user_path_at_empty+0x47/0x60
> +     vfs_statx+0x9b/0x130
> +     __do_sys_newlstat+0x50/0xb0
> +     __x64_sys_newlstat+0x37/0x50
> +     do_syscall_64+0x85/0x260
> +     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> +
> +    read to 0xffff8fee4c40700c of 4 bytes by task 166 on cpu 6:
> +     generic_permission+0x5b/0x2a0
> +     kernfs_iop_permission+0x66/0x90
> +     inode_permission+0x190/0x200
> +     link_path_walk.part.0+0x503/0x8e0
> +     path_lookupat.isra.0+0x69/0x4d0
> +     filename_lookup+0x136/0x280
> +     user_path_at_empty+0x47/0x60
> +     do_faccessat+0x11a/0x390
> +     __x64_sys_access+0x3c/0x50
> +     do_syscall_64+0x85/0x260
> +     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> +
> +    Reported by Kernel Concurrency Sanitizer on:
> +    CPU: 6 PID: 166 Comm: systemd-journal Not tainted 5.3.0-rc7+ #1
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> +    ==================================================================
> +
> +The header of the report provides a short summary of the functions involved in
> +the race. It is followed by the access types and stack traces of the 2 threads
> +involved in the data-race.
> +
> +The other less common type of data-race report looks like this::
> +
> +    ==================================================================
> +    BUG: KCSAN: data-race in e1000_clean_rx_irq+0x551/0xb10
> +
> +    race at unknown origin, with read to 0xffff933db8a2ae6c of 1 bytes by interrupt on cpu 0:
> +     e1000_clean_rx_irq+0x551/0xb10
> +     e1000_clean+0x533/0xda0
> +     net_rx_action+0x329/0x900
> +     __do_softirq+0xdb/0x2db
> +     irq_exit+0x9b/0xa0
> +     do_IRQ+0x9c/0xf0
> +     ret_from_intr+0x0/0x18
> +     default_idle+0x3f/0x220
> +     arch_cpu_idle+0x21/0x30
> +     do_idle+0x1df/0x230
> +     cpu_startup_entry+0x14/0x20
> +     rest_init+0xc5/0xcb
> +     arch_call_rest_init+0x13/0x2b
> +     start_kernel+0x6db/0x700
> +
> +    Reported by Kernel Concurrency Sanitizer on:
> +    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc7+ #2
> +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> +    ==================================================================
> +
> +This report is generated where it was not possible to determine the other
> +racing thread, but a race was inferred due to the data-value of the watched
> +memory location having changed. These can occur either due to missing
> +instrumentation or e.g. DMA accesses.
> +
> +Data-Races
> +----------
> +
> +Informally, two operations *conflict* if they access the same memory location,
> +and at least one of them is a write operation. In an execution, two memory
> +operations from different threads form a **data-race** if they *conflict*, at
> +least one of them is a *plain access* (non-atomic), and they are *unordered* in
> +the "happens-before" order according to the `LKMM
> +<../../tools/memory-model/Documentation/explanation.txt>`_.
> +
> +Relationship with the Linux Kernel Memory Model (LKMM)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The LKMM defines the propagation and ordering rules of various memory
> +operations, which gives developers the ability to reason about concurrent code.
> +Ultimately this allows to determine the possible executions of concurrent code,
> +and if that code is free from data-races.
> +
> +KCSAN is aware of *atomic* accesses (``READ_ONCE``, ``WRITE_ONCE``,
> +``atomic_*``, etc.), but is oblivious of any ordering guarantees. In other
> +words, KCSAN assumes that as long as a plain access is not observed to race
> +with another conflicting access, memory operations are correctly ordered.
> +
> +This means that KCSAN will not report *potential* data-races due to missing
> +memory ordering. If, however, missing memory ordering (that is observable with
> +a particular compiler and architecture) leads to an observable data-race (e.g.
> +entering a critical section erroneously), KCSAN would report the resulting
> +data-race.
> +
> +Implementation Details
> +----------------------
> +
> +The general approach is inspired by `DataCollider
> +<http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>`_.
> +Unlike DataCollider, KCSAN does not use hardware watchpoints, but instead
> +relies on compiler instrumentation. Watchpoints are implemented using an
> +efficient encoding that stores access type, size, and address in a long; the
> +benefits of using "soft watchpoints" are portability and greater flexibility in
> +limiting which accesses trigger a watchpoint.
> +
> +More specifically, KCSAN requires instrumenting plain (unmarked, non-atomic)
> +memory operations; for each instrumented plain access:
> +
> +1. Check if a matching watchpoint exists; if yes, and at least one access is a
> +   write, then we encountered a racing access.
> +
> +2. Periodically, if no matching watchpoint exists, set up a watchpoint and
> +   stall some delay.

Is it grammatically correct "to stall a delay"? Shouldn't stall be
used with "for"?


> +
> +3. Also check the data value before the delay, and re-check the data value
> +   after delay; if the values mismatch, we infer a race of unknown origin.
> +
> +To detect data-races between plain and atomic memory operations, KCSAN also
> +annotates atomic accesses, but only to check if a watchpoint exists
> +(``kcsan_check_atomic_*``); i.e.  KCSAN never sets up a watchpoint on atomic
> +accesses.
> +
> +Key Properties
> +~~~~~~~~~~~~~~
> +
> +1. **Memory Overhead:** No shadow memory is required. The current
> +   implementation uses a small array of longs to encode watchpoint information,
> +   which is negligible.
> +
> +2. **Performance Overhead:** KCSAN's runtime aims to be minimal, using an
> +   efficient watchpoint encoding that does not require acquiring any shared
> +   locks in the fast-path. For kernel boot with a default config on a system
> +   where nproc=8 we measure a slow-down of 10-15x.

Is it a correct number? 10-15x does not look particularly fast. TSAN
is much faster.
If it's a correct number, perhaps we need to tune the defaults to get
it to a reasonable leve.
Also, what's the minimal level of overhead with infinitely large
sampling? That may be a useful number to provide as well.

> +3. **Memory Ordering:** KCSAN is *not* aware of the LKMM's ordering rules. This
> +   may result in missed data-races (false negatives), compared to a
> +   happens-before data-race detector.

Well, it definitely aware of some of them, e.g. program order :)
It's just not aware of some of the finer details.

> +
> +4. **Accuracy:** Imprecise, since it uses a sampling strategy.

A common term I've seen for this is completeness/incompleteness.
Do we want to mention Soundness? That's more important for any dynamic tool.


> +5. **Annotation Overheads:** Minimal annotation is required outside the KCSAN
> +   runtime. With a happens-before data-race detector, any omission leads to
> +   false positives, which is especially important in the context of the kernel
> +   which includes numerous custom synchronization mechanisms. With KCSAN, as a
> +   result, maintenance overheads are minimal as the kernel evolves.

The whole doc is sprinkled with explicit and implicit comparisons with
and diffs on top of a happens-before-based detector (starting from the
very first sentences, KCSAN is effectively defined as being
"not-KTSAN"). This is reasonable for us at this particular point in
time, but it's not so reasonable for most users of this doc and for
future. No happens-before race detector officially exists for kernel.
I would consider adding a separate section for alternative approaches,
rationale and comparison with a happens-before-based detector. Such
section would be a good place to talk about our previous experience
and e.g. shadow memory. Currently the first thing you say about memory
overhead is "No shadow memory is required", and I am like "why are you
even mentioning this? and what is even shadow memory?".
