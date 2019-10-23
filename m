Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491A8E188A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404543AbfJWLJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 07:09:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46185 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404670AbfJWLJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 07:09:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so31577472qtq.13
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJIRvae5Tadr5tpoTeQKMwZtBWAiqA2ri1+8GTwKn9A=;
        b=ZU8k+TEFHf8De71GB/w6dKf0EvFXULUUBVHiKmofOelJNlP7/aP9s7Whbktw/lzxy2
         GZuS5pOjFxu7p8qlziIG/F//TjH5r3mV0Dxa/zRWNeSBP4vfPiDqqrgvLFVjoovgv5hE
         ihuD61FerrmcDqxFlxFFgbX9fnCSbN7h4Hn1+44De+ObgKJkaEWfgpSORn39Qr6PDYUI
         sm4N7hnVj4bM7E2jZjExw1ZTYFt/AVhK78tq7i4U5I0/0oFHWh85lVBGolE72XVvvkph
         rnfMA3J/QERLi9cZ2J2mewsYwzezfLX/G+w8eh8yy0lM1ZHYw3P1SgR60aRJbv8NqI5E
         TKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJIRvae5Tadr5tpoTeQKMwZtBWAiqA2ri1+8GTwKn9A=;
        b=BCqNYPJHd8fHHbGDlfGwXdsyGEaIddkNTfTyo6Li8Ba89otu3fxa7HkpFICjqO6fGJ
         RpnNW8xdf0Y8WsP0RBQ5USNkx/UtycdMx5CUCQxVlBI1x8TzDu35qZ0tlcM3eyS3X0/+
         VgoCZ2UfPzXztbbYq7no4gw1IhXfoasV94eO9eXay1tQNJauG1HTsKjXW6XWrfCgGB3X
         ydSXdRVadn81sTa/z06nnsYFqvqjkBXd4v229bQ95qATYoAVMu6HX4jzxdtjhVqF9aaz
         MnNKgJf7cPX5FoPj+jbOXbZm365qQ9vd6HHdH8Zz3xWzua65jzWDA+mVf9+z72qbhKoe
         fMpg==
X-Gm-Message-State: APjAAAUZNY6XrzGrUw83xsuHtdbJqgdGaJRpi/KViV6zFG0uESpysVqP
        tsejJPxJs5QvOw8xE7vxMbeLew+OOikt6N4SL7vaJQ==
X-Google-Smtp-Source: APXvYqzhaC0M6hDtaaBrQSjiowl7ZvTNNzOp1lc3D+pzJMe65FkqmaY/hv9WNV2eZw/Ho0m8+++thqJJdTDgdvl32PQ=
X-Received: by 2002:aed:24af:: with SMTP id t44mr8144640qtc.57.1571828941930;
 Wed, 23 Oct 2019 04:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-2-elver@google.com>
In-Reply-To: <20191017141305.146193-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 13:08:49 +0200
Message-ID: <CACT4Y+bsTHAOtMKj_kWps1UdORWM1C8C7AN+ogPvw1gg1ugY7A@mail.gmail.com>
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

 w?

 On Thu, Oct 17, 2019 at 4:13 PM Marco Elver <elver@google.com> wrote:
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
> +
> +3. **Memory Ordering:** KCSAN is *not* aware of the LKMM's ordering rules. This
> +   may result in missed data-races (false negatives), compared to a
> +   happens-before data-race detector.
> +
> +4. **Accuracy:** Imprecise, since it uses a sampling strategy.
> +
> +5. **Annotation Overheads:** Minimal annotation is required outside the KCSAN
> +   runtime. With a happens-before data-race detector, any omission leads to
> +   false positives, which is especially important in the context of the kernel
> +   which includes numerous custom synchronization mechanisms. With KCSAN, as a
> +   result, maintenance overheads are minimal as the kernel evolves.
> +
> +6. **Detects Racy Writes from Devices:** Due to checking data values upon
> +   setting up watchpoints, racy writes from devices can also be detected.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0154674cbad3..71f7fb625490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8847,6 +8847,17 @@ F:       Documentation/kbuild/kconfig*
>  F:     scripts/kconfig/
>  F:     scripts/Kconfig.include
>
> +KCSAN
> +M:     Marco Elver <elver@google.com>
> +R:     Dmitry Vyukov <dvyukov@google.com>
> +L:     kasan-dev@googlegroups.com
> +S:     Maintained
> +F:     Documentation/dev-tools/kcsan.rst
> +F:     include/linux/kcsan*.h
> +F:     kernel/kcsan/
> +F:     lib/Kconfig.kcsan
> +F:     scripts/Makefile.kcsan
> +
>  KDUMP
>  M:     Dave Young <dyoung@redhat.com>
>  M:     Baoquan He <bhe@redhat.com>
> diff --git a/Makefile b/Makefile
> index ffd7a912fc46..ad4729176252 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -478,7 +478,7 @@ export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> -export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
> +export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_KCSAN
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> @@ -900,6 +900,7 @@ endif
>  include scripts/Makefile.kasan
>  include scripts/Makefile.extrawarn
>  include scripts/Makefile.ubsan
> +include scripts/Makefile.kcsan
>
>  # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
>  KBUILD_CPPFLAGS += $(KCPPFLAGS)
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 333a6695a918..a213eb55e725 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -24,6 +24,15 @@
>  #define __no_sanitize_address
>  #endif
>
> +#if __has_feature(thread_sanitizer)
> +/* emulate gcc's __SANITIZE_THREAD__ flag */
> +#define __SANITIZE_THREAD__
> +#define __no_sanitize_thread \
> +               __attribute__((no_sanitize("thread")))
> +#else
> +#define __no_sanitize_thread
> +#endif
> +
>  /*
>   * Not all versions of clang implement the the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index d7ee4c6bad48..de105ca29282 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -145,6 +145,13 @@
>  #define __no_sanitize_address
>  #endif
>
> +#if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
> +#define __no_sanitize_thread                                                   \
> +       __attribute__((__noinline__)) __attribute__((no_sanitize_thread))
> +#else
> +#define __no_sanitize_thread
> +#endif
> +
>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 5e88e7e33abe..350d80dbee4d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -178,6 +178,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #endif
>
>  #include <uapi/linux/types.h>
> +#include <linux/kcsan-checks.h>
>
>  #define __READ_ONCE_SIZE                                               \
>  ({                                                                     \
> @@ -193,12 +194,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>         }                                                               \
>  })
>
> -static __always_inline
> -void __read_once_size(const volatile void *p, void *res, int size)
> -{
> -       __READ_ONCE_SIZE;
> -}
> -
>  #ifdef CONFIG_KASAN
>  /*
>   * We can't declare function 'inline' because __no_sanitize_address confilcts
> @@ -211,14 +206,38 @@ void __read_once_size(const volatile void *p, void *res, int size)
>  # define __no_kasan_or_inline __always_inline
>  #endif
>
> -static __no_kasan_or_inline
> +#ifdef CONFIG_KCSAN
> +# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
> +#else
> +# define __no_kcsan_or_inline __always_inline
> +#endif
> +
> +#if defined(CONFIG_KASAN) || defined(CONFIG_KCSAN)
> +/* Avoid any instrumentation or inline. */
> +#define __no_sanitize_or_inline                                                \
> +       __no_sanitize_address __no_sanitize_thread notrace __maybe_unused
> +#else
> +#define __no_sanitize_or_inline __always_inline
> +#endif
> +
> +static __no_kcsan_or_inline
> +void __read_once_size(const volatile void *p, void *res, int size)
> +{
> +       kcsan_check_atomic_read((const void *)p, size);
> +       __READ_ONCE_SIZE;
> +}
> +
> +static __no_sanitize_or_inline
>  void __read_once_size_nocheck(const volatile void *p, void *res, int size)
>  {
>         __READ_ONCE_SIZE;
>  }
>
> -static __always_inline void __write_once_size(volatile void *p, void *res, int size)
> +static __no_kcsan_or_inline
> +void __write_once_size(volatile void *p, void *res, int size)
>  {
> +       kcsan_check_atomic_write((const void *)p, size);
> +
>         switch (size) {
>         case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
>         case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> new file mode 100644
> index 000000000000..4203603ae852
> --- /dev/null
> +++ b/include/linux/kcsan-checks.h
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_KCSAN_CHECKS_H
> +#define _LINUX_KCSAN_CHECKS_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * __kcsan_*: Always available when KCSAN is enabled. This may be used
> + * even in compilation units that selectively disable KCSAN, but must use KCSAN
> + * to validate access to an address.   Never use these in header files!
> + */
> +#ifdef CONFIG_KCSAN
> +/**
> + * __kcsan_check_watchpoint - check if a watchpoint exists
> + *
> + * Returns true if no race was detected, and we may then proceed to set up a
> + * watchpoint after. Returns false if either KCSAN is disabled or a race was
> + * encountered, and we may not set up a watchpoint after.
> + *
> + * @ptr address of access
> + * @size size of access
> + * @is_write is access a write
> + * @return true if no race was detected, false otherwise.
> + */
> +bool __kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> +                             bool is_write);
> +
> +/**
> + * __kcsan_setup_watchpoint - set up watchpoint and report data-races
> + *
> + * Sets up a watchpoint (if sampled), and if a racing access was observed,
> + * reports the data-race.
> + *
> + * @ptr address of access
> + * @size size of access
> + * @is_write is access a write
> + */
> +void __kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> +                             bool is_write);
> +#else
> +static inline bool __kcsan_check_watchpoint(const volatile void *ptr,
> +                                           size_t size, bool is_write)
> +{
> +       return true;
> +}
> +static inline void __kcsan_setup_watchpoint(const volatile void *ptr,
> +                                           size_t size, bool is_write)
> +{
> +}
> +#endif
> +
> +/*
> + * kcsan_*: Only available when the particular compilation unit has KCSAN
> + * instrumentation enabled. May be used in header files.
> + */
> +#ifdef __SANITIZE_THREAD__
> +#define kcsan_check_watchpoint __kcsan_check_watchpoint
> +#define kcsan_setup_watchpoint __kcsan_setup_watchpoint
> +#else
> +static inline bool kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> +                                         bool is_write)
> +{
> +       return true;
> +}
> +static inline void kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> +                                         bool is_write)
> +{
> +}
> +#endif
> +
> +/**
> + * __kcsan_check_read - check regular read access for data-races
> + *
> + * Full read access that checks watchpoint and sets up a watchpoint if this
> + * access is sampled. Note that, setting up watchpoints for plain reads is
> + * required to also detect data-races with atomic accesses.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +#define __kcsan_check_read(ptr, size)                                          \
> +       do {                                                                   \
> +               if (__kcsan_check_watchpoint(ptr, size, false))                \
> +                       __kcsan_setup_watchpoint(ptr, size, false);            \
> +       } while (0)
> +
> +/**
> + * __kcsan_check_write - check regular write access for data-races
> + *
> + * Full write access that checks watchpoint and sets up a watchpoint if this
> + * access is sampled.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +#define __kcsan_check_write(ptr, size)                                         \
> +       do {                                                                   \
> +               if (__kcsan_check_watchpoint(ptr, size, true) &&               \
> +                   !IS_ENABLED(CONFIG_KCSAN_PLAIN_WRITE_PRETEND_ONCE))        \
> +                       __kcsan_setup_watchpoint(ptr, size, true);             \
> +       } while (0)
> +
> +/**
> + * kcsan_check_read - check regular read access for data-races
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +#define kcsan_check_read(ptr, size)                                            \
> +       do {                                                                   \
> +               if (kcsan_check_watchpoint(ptr, size, false))                  \
> +                       kcsan_setup_watchpoint(ptr, size, false);              \
> +       } while (0)
> +
> +/**
> + * kcsan_check_write - check regular write access for data-races
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +#define kcsan_check_write(ptr, size)                                           \
> +       do {                                                                   \
> +               if (kcsan_check_watchpoint(ptr, size, true) &&                 \
> +                   !IS_ENABLED(CONFIG_KCSAN_PLAIN_WRITE_PRETEND_ONCE))        \
> +                       kcsan_setup_watchpoint(ptr, size, true);               \
> +       } while (0)
> +
> +/*
> + * Check for atomic accesses: if atomic access are not ignored, this simply
> + * aliases to kcsan_check_watchpoint, otherwise becomes a no-op.
> + */
> +#ifdef CONFIG_KCSAN_IGNORE_ATOMICS
> +#define kcsan_check_atomic_read(...)                                           \
> +       do {                                                                   \
> +       } while (0)
> +#define kcsan_check_atomic_write(...)                                          \
> +       do {                                                                   \
> +       } while (0)
> +#else
> +#define kcsan_check_atomic_read(ptr, size)                                     \
> +       kcsan_check_watchpoint(ptr, size, false)
> +#define kcsan_check_atomic_write(ptr, size)                                    \
> +       kcsan_check_watchpoint(ptr, size, true)
> +#endif
> +
> +#endif /* _LINUX_KCSAN_CHECKS_H */
> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> new file mode 100644
> index 000000000000..fd5de2ba3a16
> --- /dev/null
> +++ b/include/linux/kcsan.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_KCSAN_H
> +#define _LINUX_KCSAN_H
> +
> +#include <linux/types.h>
> +#include <linux/kcsan-checks.h>
> +
> +#ifdef CONFIG_KCSAN
> +
> +/*
> + * Context for each thread of execution: for tasks, this is stored in
> + * task_struct, and interrupts access internal per-CPU storage.
> + */
> +struct kcsan_ctx {
> +       int disable; /* disable counter */
> +       int atomic_next; /* number of following atomic ops */
> +
> +       /*
> +        * We use separate variables to store if we are in a nestable or flat
> +        * atomic region. This helps make sure that an atomic region with
> +        * nesting support is not suddenly aborted when a flat region is
> +        * contained within. Effectively this allows supporting nesting flat
> +        * atomic regions within an outer nestable atomic region. Support for
> +        * this is required as there are cases where a seqlock reader critical
> +        * section (flat atomic region) is contained within a seqlock writer
> +        * critical section (nestable atomic region), and the "mismatching
> +        * kcsan_end_atomic()" warning would trigger otherwise.
> +        */
> +       int atomic_region;
> +       bool atomic_region_flat;
> +};
> +
> +/**
> + * kcsan_init - initialize KCSAN runtime
> + */
> +void kcsan_init(void);
> +
> +/**
> + * kcsan_disable_current - disable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_disable_current(void);
> +
> +/**
> + * kcsan_enable_current - re-enable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_enable_current(void);
> +
> +/**
> + * kcsan_begin_atomic - use to denote an atomic region
> + *
> + * Accesses within the atomic region may appear to race with other accesses but
> + * should be considered atomic.
> + *
> + * @nest true if regions may be nested, or false for flat region
> + */
> +void kcsan_begin_atomic(bool nest);
> +
> +/**
> + * kcsan_end_atomic - end atomic region
> + *
> + * @nest must match argument to kcsan_begin_atomic().
> + */
> +void kcsan_end_atomic(bool nest);
> +
> +/**
> + * kcsan_atomic_next - consider following accesses as atomic
> + *
> + * Force treating the next n memory accesses for the current context as atomic
> + * operations.
> + *
> + * @n number of following memory accesses to treat as atomic.
> + */
> +void kcsan_atomic_next(int n);
> +
> +#else /* CONFIG_KCSAN */
> +
> +static inline void kcsan_init(void)
> +{
> +}
> +
> +static inline void kcsan_disable_current(void)
> +{
> +}
> +
> +static inline void kcsan_enable_current(void)
> +{
> +}
> +
> +static inline void kcsan_begin_atomic(bool nest)
> +{
> +}
> +
> +static inline void kcsan_end_atomic(bool nest)
> +{
> +}
> +
> +static inline void kcsan_atomic_next(int n)
> +{
> +}
> +
> +#endif /* CONFIG_KCSAN */
> +
> +#endif /* _LINUX_KCSAN_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..9490e417bf4a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -31,6 +31,7 @@
>  #include <linux/task_io_accounting.h>
>  #include <linux/posix-timers.h>
>  #include <linux/rseq.h>
> +#include <linux/kcsan.h>
>
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -1171,6 +1172,9 @@ struct task_struct {
>  #ifdef CONFIG_KASAN
>         unsigned int                    kasan_depth;
>  #endif
> +#ifdef CONFIG_KCSAN
> +       struct kcsan_ctx                kcsan_ctx;
> +#endif
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         /* Index of current stored address in ret_stack: */
> diff --git a/init/init_task.c b/init/init_task.c
> index 9e5cbe5eab7b..e229416c3314 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -161,6 +161,14 @@ struct task_struct init_task
>  #ifdef CONFIG_KASAN
>         .kasan_depth    = 1,
>  #endif
> +#ifdef CONFIG_KCSAN
> +       .kcsan_ctx = {
> +               .disable                = 1,
> +               .atomic_next            = 0,
> +               .atomic_region          = 0,
> +               .atomic_region_flat     = 0,
> +       },
> +#endif
>  #ifdef CONFIG_TRACE_IRQFLAGS
>         .softirqs_enabled = 1,
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 91f6ebb30ef0..4d814de017ee 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -93,6 +93,7 @@
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/kcsan.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -779,6 +780,7 @@ asmlinkage __visible void __init start_kernel(void)
>         acpi_subsystem_init();
>         arch_post_acpi_subsys_init();
>         sfi_init_late();
> +       kcsan_init();
>
>         /* Do the rest non-__init'ed, we're now alive */
>         arch_call_rest_init();
> diff --git a/kernel/Makefile b/kernel/Makefile
> index daad787fb795..74ab46e2ebd1 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/
> +obj-$(CONFIG_KCSAN) += kcsan/
>
>  obj-$(CONFIG_PERF_EVENTS) += events/
>
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> new file mode 100644
> index 000000000000..c25f07062d26
> --- /dev/null
> +++ b/kernel/kcsan/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +KCSAN_SANITIZE := n
> +KCOV_INSTRUMENT := n
> +
> +CFLAGS_REMOVE_kcsan.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_atomic.o = $(CC_FLAGS_FTRACE)
> +
> +CFLAGS_kcsan.o = $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_core.o = $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_atomic.o = $(call cc-option, -fno-conserve-stack -fno-stack-protector)

Building with clang 10, I still see:

  CC      kernel/kcsan/core.o
kernel/kcsan/core.o: warning: objtool:
__kcsan_check_watchpoint()+0x228: call to __stack_chk_fail() with
UACCESS enabled
kernel/kcsan/core.o: warning: objtool:
__kcsan_setup_watchpoint()+0x3be: call to __stack_chk_fail() with
UACCESS enabled


> +obj-y := kcsan.o core.o atomic.o debugfs.o report.o
> +obj-$(CONFIG_KCSAN_SELFTEST) += test.o
> diff --git a/kernel/kcsan/atomic.c b/kernel/kcsan/atomic.c
> new file mode 100644
> index 000000000000..dd44f7d9e491
> --- /dev/null
> +++ b/kernel/kcsan/atomic.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/jiffies.h>
> +
> +#include "kcsan.h"
> +
> +/*
> + * List all volatile globals that have been observed in races, to suppress
> + * data-race reports between accesses to these variables.
> + *
> + * For now, we assume that volatile accesses of globals are as strong as atomic
> + * accesses (READ_ONCE, WRITE_ONCE cast to volatile). The situation is still not
> + * entirely clear, as on some architectures (Alpha) READ_ONCE/WRITE_ONCE do more
> + * than cast to volatile. Eventually, we hope to be able to remove this
> + * function.
> + */
> +bool kcsan_is_atomic(const volatile void *ptr)
> +{
> +       /* only jiffies for now */
> +       return ptr == &jiffies;
> +}
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> new file mode 100644
> index 000000000000..bc8d60b129eb
> --- /dev/null
> +++ b/kernel/kcsan/core.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/atomic.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
> +#include <linux/random.h>
> +#include <linux/sched.h>
> +#include <linux/uaccess.h>
> +
> +#include "kcsan.h"
> +#include "encoding.h"
> +
> +/*
> + * Helper macros to iterate slots, starting from address slot itself, followed
> + * by the right and left slots.
> + */
> +#define CHECK_NUM_SLOTS (1 + 2 * KCSAN_CHECK_ADJACENT)
> +#define SLOT_IDX(slot, i)                                                      \
> +       ((slot + (((i + KCSAN_CHECK_ADJACENT) % CHECK_NUM_SLOTS) -             \
> +                 KCSAN_CHECK_ADJACENT)) %                                     \
> +        KCSAN_NUM_WATCHPOINTS)
> +
> +bool kcsan_enabled;
> +
> +/* Per-CPU kcsan_ctx for interrupts */
> +static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
> +       .disable = 0,
> +       .atomic_next = 0,
> +       .atomic_region = 0,
> +       .atomic_region_flat = 0,
> +};
> +
> +/*
> + * Watchpoints, with each entry encoded as defined in encoding.h: in order to be
> + * able to safely update and access a watchpoint without introducing locking
> + * overhead, we encode each watchpoint as a single atomic long. The initial
> + * zero-initialized state matches INVALID_WATCHPOINT.
> + */
> +static atomic_long_t watchpoints[KCSAN_NUM_WATCHPOINTS];
> +
> +/*
> + * Instructions skipped counter; see should_watch().
> + */
> +static DEFINE_PER_CPU(unsigned long, kcsan_skip);
> +
> +static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
> +                                            bool expect_write,
> +                                            long *encoded_watchpoint)
> +{
> +       const int slot = watchpoint_slot(addr);
> +       const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> +       atomic_long_t *watchpoint;
> +       unsigned long wp_addr_masked;
> +       size_t wp_size;
> +       bool is_write;
> +       int i;
> +
> +       for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
> +               watchpoint = &watchpoints[SLOT_IDX(slot, i)];
> +               *encoded_watchpoint = atomic_long_read(watchpoint);
> +               if (!decode_watchpoint(*encoded_watchpoint, &wp_addr_masked,
> +                                      &wp_size, &is_write))
> +                       continue;
> +
> +               if (expect_write && !is_write)
> +                       continue;
> +
> +               /* Check if the watchpoint matches the access. */
> +               if (matching_access(wp_addr_masked, wp_size, addr_masked, size))
> +                       return watchpoint;
> +       }
> +
> +       return NULL;
> +}
> +
> +static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
> +                                              bool is_write)
> +{
> +       const int slot = watchpoint_slot(addr);
> +       const long encoded_watchpoint = encode_watchpoint(addr, size, is_write);
> +       atomic_long_t *watchpoint;
> +       int i;
> +
> +       for (i = 0; i < CHECK_NUM_SLOTS; ++i) {
> +               long expect_val = INVALID_WATCHPOINT;
> +
> +               /* Try to acquire this slot. */
> +               watchpoint = &watchpoints[SLOT_IDX(slot, i)];
> +               if (atomic_long_try_cmpxchg_relaxed(watchpoint, &expect_val,
> +                                                   encoded_watchpoint))
> +                       return watchpoint;
> +       }
> +
> +       return NULL;
> +}
> +
> +/*
> + * Return true if watchpoint was successfully consumed, false otherwise.
> + *
> + * This may return false if:
> + *
> + *     1. another thread already consumed the watchpoint;
> + *     2. the thread that set up the watchpoint already removed it;
> + *     3. the watchpoint was removed and then re-used.
> + */
> +static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
> +                                         long encoded_watchpoint)
> +{
> +       return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint,
> +                                              CONSUMED_WATCHPOINT);
> +}
> +
> +/*
> + * Return true if watchpoint was not touched, false if consumed.
> + */
> +static inline bool remove_watchpoint(atomic_long_t *watchpoint)
> +{
> +       return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) !=
> +              CONSUMED_WATCHPOINT;
> +}
> +
> +static inline struct kcsan_ctx *get_ctx(void)
> +{
> +       /*
> +        * In interrupt, use raw_cpu_ptr to avoid unnecessary checks, that would
> +        * also result in calls that generate warnings in uaccess regions.
> +        */
> +       return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> +}
> +
> +static inline bool is_atomic(const volatile void *ptr)
> +{
> +       struct kcsan_ctx *ctx = get_ctx();
> +
> +       if (unlikely(ctx->atomic_next > 0)) {
> +               --ctx->atomic_next;
> +               return true;
> +       }
> +       if (unlikely(ctx->atomic_region > 0 || ctx->atomic_region_flat))
> +               return true;
> +
> +       return kcsan_is_atomic(ptr);
> +}
> +
> +static inline bool should_watch(const volatile void *ptr)
> +{
> +       /*
> +        * Never set up watchpoints when memory operations are atomic.
> +        *
> +        * We need to check this first, because: 1) atomics should not count
> +        * towards skipped instructions below, and 2) to actually decrement
> +        * kcsan_atomic_next for each atomic.
> +        */
> +       if (is_atomic(ptr))
> +               return false;
> +
> +       /*
> +        * We use a per-CPU counter, to avoid excessive contention; there is
> +        * still enough non-determinism for the precise instructions that end up
> +        * being watched to be mostly unpredictable. Using a PRNG like
> +        * prandom_u32() turned out to be too slow.
> +        */
> +       return (this_cpu_inc_return(kcsan_skip) %
> +               CONFIG_KCSAN_WATCH_SKIP_INST) == 0;
> +}
> +
> +static inline bool is_enabled(void)
> +{
> +       return READ_ONCE(kcsan_enabled) && get_ctx()->disable == 0;
> +}
> +
> +static inline unsigned int get_delay(void)
> +{
> +       unsigned int max_delay = in_task() ? CONFIG_KCSAN_UDELAY_MAX_TASK :
> +                                            CONFIG_KCSAN_UDELAY_MAX_INTERRUPT;
> +       return IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
> +                      ((prandom_u32() % max_delay) + 1) :
> +                      max_delay;
> +}
> +
> +/* === Public interface ===================================================== */
> +
> +void __init kcsan_init(void)
> +{
> +       BUG_ON(!in_task());
> +
> +       kcsan_debugfs_init();
> +       kcsan_enable_current();
> +#ifdef CONFIG_KCSAN_EARLY_ENABLE
> +       /*
> +        * We are in the init task, and no other tasks should be running.
> +        */
> +       WRITE_ONCE(kcsan_enabled, true);
> +#endif
> +}
> +
> +/* === Exported interface =================================================== */
> +
> +void kcsan_disable_current(void)
> +{
> +       ++get_ctx()->disable;
> +}
> +EXPORT_SYMBOL(kcsan_disable_current);
> +
> +void kcsan_enable_current(void)
> +{
> +       if (get_ctx()->disable-- == 0) {
> +               kcsan_disable_current(); /* restore to 0 */
> +               kcsan_disable_current();
> +               WARN(1, "mismatching %s", __func__);
> +               kcsan_enable_current();
> +       }
> +}
> +EXPORT_SYMBOL(kcsan_enable_current);
> +
> +void kcsan_begin_atomic(bool nest)
> +{
> +       if (nest)
> +               ++get_ctx()->atomic_region;
> +       else

If it's flat, shoudn't we do WARN_ON(get_ctx()->atomic_region_flat)?

> +               get_ctx()->atomic_region_flat = true;
> +}
> +EXPORT_SYMBOL(kcsan_begin_atomic);
> +
> +void kcsan_end_atomic(bool nest)
> +{
> +       if (nest) {
> +               if (get_ctx()->atomic_region-- == 0) {
> +                       kcsan_begin_atomic(true); /* restore to 0 */
> +                       kcsan_disable_current();
> +                       WARN(1, "mismatching %s", __func__);
> +                       kcsan_enable_current();
> +               }
> +       } else {

WARN_ON(!get_ctx()->atomic_region_flat)?

> +               get_ctx()->atomic_region_flat = false;
> +       }
> +}
> +EXPORT_SYMBOL(kcsan_end_atomic);
> +
> +void kcsan_atomic_next(int n)
> +{
> +       get_ctx()->atomic_next = n;
> +}
> +EXPORT_SYMBOL(kcsan_atomic_next);
> +
> +bool __kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> +                             bool is_write)
> +{
> +       atomic_long_t *watchpoint;
> +       long encoded_watchpoint;
> +       unsigned long flags;
> +       enum kcsan_report_type report_type;
> +
> +       if (unlikely(!is_enabled()))
> +               return false;
> +
> +       /*
> +        * Avoid user_access_save in fast-path here: find_watchpoint is safe
> +        * without user_access_save, as the address that ptr points to is only
> +        * used to check if a watchpoint exists; ptr is never dereferenced.
> +        */
> +       watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
> +                                    &encoded_watchpoint);
> +       if (watchpoint == NULL)
> +               return true;
> +
> +       flags = user_access_save();
> +       if (!try_consume_watchpoint(watchpoint, encoded_watchpoint)) {
> +               /*
> +                * The other thread may not print any diagnostics, as it has
> +                * already removed the watchpoint, or another thread consumed
> +                * the watchpoint before this thread.
> +                */
> +               kcsan_counter_inc(kcsan_counter_report_races);
> +               report_type = kcsan_report_race_check_race;
> +       } else {
> +               report_type = kcsan_report_race_check;
> +       }
> +
> +       /* Encountered a data-race. */
> +       kcsan_counter_inc(kcsan_counter_data_races);
> +       kcsan_report(ptr, size, is_write, raw_smp_processor_id(), report_type);
> +
> +       user_access_restore(flags);
> +       return false;
> +}
> +EXPORT_SYMBOL(__kcsan_check_watchpoint);
> +
> +void __kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> +                             bool is_write)
> +{
> +       atomic_long_t *watchpoint;
> +       union {
> +               u8 _1;
> +               u16 _2;
> +               u32 _4;
> +               u64 _8;
> +       } expect_value;
> +       bool is_expected = true;
> +       unsigned long ua_flags = user_access_save();
> +       unsigned long irq_flags;
> +
> +       if (!should_watch(ptr))
> +               goto out;
> +
> +       if (!check_encodable((unsigned long)ptr, size)) {
> +               kcsan_counter_inc(kcsan_counter_unencodable_accesses);
> +               goto out;
> +       }
> +
> +       /*
> +        * Disable interrupts & preemptions to avoid another thread on the same
> +        * CPU accessing memory locations for the set up watchpoint; this is to
> +        * avoid reporting races to e.g. CPU-local data.
> +        *
> +        * An alternative would be adding the source CPU to the watchpoint
> +        * encoding, and checking that watchpoint-CPU != this-CPU. There are
> +        * several problems with this:
> +        *   1. we should avoid stealing more bits from the watchpoint encoding
> +        *      as it would affect accuracy, as well as increase performance
> +        *      overhead in the fast-path;
> +        *   2. if we are preempted, but there *is* a genuine data-race, we
> +        *      would *not* report it -- since this is the common case (vs.
> +        *      CPU-local data accesses), it makes more sense (from a data-race
> +        *      detection PoV) to simply disable preemptions to ensure as many
> +        *      tasks as possible run on other CPUs.
> +        */
> +       local_irq_save(irq_flags);
> +
> +       watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> +       if (watchpoint == NULL) {
> +               /*
> +                * Out of capacity: the size of `watchpoints`, and the frequency
> +                * with which `should_watch()` returns true should be tweaked so
> +                * that this case happens very rarely.
> +                */
> +               kcsan_counter_inc(kcsan_counter_no_capacity);
> +               goto out_unlock;
> +       }
> +
> +       kcsan_counter_inc(kcsan_counter_setup_watchpoints);
> +       kcsan_counter_inc(kcsan_counter_used_watchpoints);
> +
> +       /*
> +        * Read the current value, to later check and infer a race if the data
> +        * was modified via a non-instrumented access, e.g. from a device.
> +        */
> +       switch (size) {
> +       case 1:
> +               expect_value._1 = READ_ONCE(*(const u8 *)ptr);
> +               break;
> +       case 2:
> +               expect_value._2 = READ_ONCE(*(const u16 *)ptr);
> +               break;
> +       case 4:
> +               expect_value._4 = READ_ONCE(*(const u32 *)ptr);
> +               break;
> +       case 8:
> +               expect_value._8 = READ_ONCE(*(const u64 *)ptr);
> +               break;
> +       default:
> +               break; /* ignore; we do not diff the values */
> +       }
> +
> +#ifdef CONFIG_KCSAN_DEBUG
> +       kcsan_disable_current();
> +       pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
> +              is_write ? "write" : "read", size, ptr,
> +              watchpoint_slot((unsigned long)ptr),
> +              encode_watchpoint((unsigned long)ptr, size, is_write));
> +       kcsan_enable_current();
> +#endif
> +
> +       /*
> +        * Delay this thread, to increase probability of observing a racy
> +        * conflicting access.
> +        */
> +       udelay(get_delay());
> +
> +       /*
> +        * Re-read value, and check if it is as expected; if not, we infer a
> +        * racy access.
> +        */
> +       switch (size) {
> +       case 1:
> +               is_expected = expect_value._1 == READ_ONCE(*(const u8 *)ptr);
> +               break;
> +       case 2:
> +               is_expected = expect_value._2 == READ_ONCE(*(const u16 *)ptr);
> +               break;
> +       case 4:
> +               is_expected = expect_value._4 == READ_ONCE(*(const u32 *)ptr);
> +               break;
> +       case 8:
> +               is_expected = expect_value._8 == READ_ONCE(*(const u64 *)ptr);
> +               break;
> +       default:
> +               break; /* ignore; we do not diff the values */
> +       }
> +
> +       /* Check if this access raced with another. */
> +       if (!remove_watchpoint(watchpoint)) {
> +               /*
> +                * No need to increment 'race' counter, as the racing thread
> +                * already did.
> +                */
> +               kcsan_report(ptr, size, is_write, smp_processor_id(),
> +                            kcsan_report_race_setup);
> +       } else if (!is_expected) {
> +               /* Inferring a race, since the value should not have changed. */
> +               kcsan_counter_inc(kcsan_counter_races_unknown_origin);
> +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> +               kcsan_report(ptr, size, is_write, smp_processor_id(),
> +                            kcsan_report_race_unknown_origin);
> +#endif
> +       }
> +
> +       kcsan_counter_dec(kcsan_counter_used_watchpoints);
> +out_unlock:
> +       local_irq_restore(irq_flags);
> +out:
> +       user_access_restore(ua_flags);
> +}
> +EXPORT_SYMBOL(__kcsan_setup_watchpoint);
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> new file mode 100644
> index 000000000000..6ddcbd185f3a
> --- /dev/null
> +++ b/kernel/kcsan/debugfs.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/atomic.h>
> +#include <linux/bsearch.h>
> +#include <linux/bug.h>
> +#include <linux/debugfs.h>
> +#include <linux/init.h>
> +#include <linux/kallsyms.h>
> +#include <linux/mm.h>
> +#include <linux/seq_file.h>
> +#include <linux/sort.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +
> +#include "kcsan.h"
> +
> +/*
> + * Statistics counters.
> + */
> +static atomic_long_t counters[kcsan_counter_count];
> +
> +/*
> + * Addresses for filtering functions from reporting. This list can be used as a
> + * whitelist or blacklist.
> + */
> +static struct {
> +       unsigned long *addrs; /* array of addresses */
> +       size_t size; /* current size */
> +       int used; /* number of elements used */
> +       bool sorted; /* if elements are sorted */
> +       bool whitelist; /* if list is a blacklist or whitelist */
> +} report_filterlist = {
> +       .addrs = NULL,
> +       .size = 8, /* small initial size */
> +       .used = 0,
> +       .sorted = false,
> +       .whitelist = false, /* default is blacklist */
> +};
> +static DEFINE_SPINLOCK(report_filterlist_lock);
> +
> +static const char *counter_to_name(enum kcsan_counter_id id)
> +{
> +       switch (id) {
> +       case kcsan_counter_used_watchpoints:
> +               return "used_watchpoints";
> +       case kcsan_counter_setup_watchpoints:
> +               return "setup_watchpoints";
> +       case kcsan_counter_data_races:
> +               return "data_races";
> +       case kcsan_counter_no_capacity:
> +               return "no_capacity";
> +       case kcsan_counter_report_races:
> +               return "report_races";
> +       case kcsan_counter_races_unknown_origin:
> +               return "races_unknown_origin";
> +       case kcsan_counter_unencodable_accesses:
> +               return "unencodable_accesses";
> +       case kcsan_counter_encoding_false_positives:
> +               return "encoding_false_positives";
> +       case kcsan_counter_count:
> +               BUG();
> +       }
> +       return NULL;
> +}
> +
> +void kcsan_counter_inc(enum kcsan_counter_id id)
> +{
> +       atomic_long_inc(&counters[id]);
> +}
> +
> +void kcsan_counter_dec(enum kcsan_counter_id id)
> +{
> +       atomic_long_dec(&counters[id]);
> +}
> +
> +static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
> +{
> +       const unsigned long a = *(const unsigned long *)rhs;
> +       const unsigned long b = *(const unsigned long *)lhs;
> +
> +       return a < b ? -1 : a == b ? 0 : 1;
> +}
> +
> +bool kcsan_skip_report(unsigned long func_addr)
> +{
> +       unsigned long symbolsize, offset;
> +       unsigned long flags;
> +       bool ret = false;
> +
> +       if (!kallsyms_lookup_size_offset(func_addr, &symbolsize, &offset))
> +               return false;
> +       func_addr -= offset; /* get function start */
> +
> +       spin_lock_irqsave(&report_filterlist_lock, flags);
> +       if (report_filterlist.used == 0)
> +               goto out;
> +
> +       /* Sort array if it is unsorted, and then do a binary search. */
> +       if (!report_filterlist.sorted) {
> +               sort(report_filterlist.addrs, report_filterlist.used,
> +                    sizeof(unsigned long), cmp_filterlist_addrs, NULL);
> +               report_filterlist.sorted = true;
> +       }
> +       ret = !!bsearch(&func_addr, report_filterlist.addrs,
> +                       report_filterlist.used, sizeof(unsigned long),
> +                       cmp_filterlist_addrs);
> +       if (report_filterlist.whitelist)
> +               ret = !ret;
> +
> +out:
> +       spin_unlock_irqrestore(&report_filterlist_lock, flags);
> +       return ret;
> +}
> +
> +static void set_report_filterlist_whitelist(bool whitelist)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&report_filterlist_lock, flags);
> +       report_filterlist.whitelist = whitelist;
> +       spin_unlock_irqrestore(&report_filterlist_lock, flags);
> +}
> +
> +static void insert_report_filterlist(const char *func)
> +{
> +       unsigned long flags;
> +       unsigned long addr = kallsyms_lookup_name(func);
> +
> +       if (!addr) {
> +               pr_err("KCSAN: could not find function: '%s'\n", func);
> +               return;

Would be reasonable to return ENOENT to user.

> +       }
> +
> +       spin_lock_irqsave(&report_filterlist_lock, flags);
> +
> +       if (report_filterlist.addrs == NULL)
> +               report_filterlist.addrs = /* initial allocation */
> +                       kvmalloc_array(report_filterlist.size,
> +                                      sizeof(unsigned long), GFP_KERNEL);

This can fail.

> +       else if (report_filterlist.used == report_filterlist.size) {
> +               /* resize filterlist */
> +               unsigned long *new_addrs;
> +
> +               report_filterlist.size *= 2;
> +               new_addrs = kvmalloc_array(report_filterlist.size,
> +                                          sizeof(unsigned long), GFP_KERNEL);

This can fail.
Would it be easier to use krealloc? It's usefule to have a cap on list
size anyway.

> +               memcpy(new_addrs, report_filterlist.addrs,
> +                      report_filterlist.used * sizeof(unsigned long));
> +               kvfree(report_filterlist.addrs);
> +               report_filterlist.addrs = new_addrs;
> +       }
> +
> +       /* Note: deduplicating should be done in userspace. */
> +       report_filterlist.addrs[report_filterlist.used++] =
> +               kallsyms_lookup_name(func);
> +       report_filterlist.sorted = false;
> +
> +       spin_unlock_irqrestore(&report_filterlist_lock, flags);
> +}
> +
> +static int show_info(struct seq_file *file, void *v)
> +{
> +       int i;
> +       unsigned long flags;
> +
> +       /* show stats */
> +       seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
> +       for (i = 0; i < kcsan_counter_count; ++i)
> +               seq_printf(file, "%s: %ld\n", counter_to_name(i),
> +                          atomic_long_read(&counters[i]));
> +
> +       /* show filter functions, and filter type */
> +       spin_lock_irqsave(&report_filterlist_lock, flags);
> +       seq_printf(file, "\n%s functions: %s\n",
> +                  report_filterlist.whitelist ? "whitelisted" : "blacklisted",
> +                  report_filterlist.used == 0 ? "none" : "");
> +       for (i = 0; i < report_filterlist.used; ++i)
> +               seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
> +       spin_unlock_irqrestore(&report_filterlist_lock, flags);
> +
> +       return 0;
> +}
> +
> +static int debugfs_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, show_info, NULL);
> +}
> +
> +static ssize_t debugfs_write(struct file *file, const char __user *buf,
> +                            size_t count, loff_t *off)
> +{
> +       char kbuf[KSYM_NAME_LEN];
> +       char *arg;
> +       int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
> +
> +       if (copy_from_user(kbuf, buf, read_len))
> +               return -EINVAL;

EFAULT

> +       kbuf[read_len] = '\0';
> +       arg = strstrip(kbuf);
> +
> +       if (!strncmp(arg, "on", sizeof("on") - 1))

I would be cleaner to use strcmp (trim trailing newline first).
Otherwise we accept anything starting with "on".


> +               WRITE_ONCE(kcsan_enabled, true);
> +       else if (!strncmp(arg, "off", sizeof("off") - 1))
> +               WRITE_ONCE(kcsan_enabled, false);
> +       else if (!strncmp(arg, "whitelist", sizeof("whitelist") - 1))
> +               set_report_filterlist_whitelist(true);
> +       else if (!strncmp(arg, "blacklist", sizeof("blacklist") - 1))
> +               set_report_filterlist_whitelist(false);
> +       else if (arg[0] == '!')
> +               insert_report_filterlist(&arg[1]);
> +       else
> +               return -EINVAL;
> +
> +       return count;
> +}
> +
> +static const struct file_operations debugfs_ops = { .read = seq_read,
> +                                                   .open = debugfs_open,
> +                                                   .write = debugfs_write,
> +                                                   .release = single_release };
> +
> +void __init kcsan_debugfs_init(void)
> +{
> +       debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
> +}
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> new file mode 100644
> index 000000000000..8f9b1ce0e59f
> --- /dev/null
> +++ b/kernel/kcsan/encoding.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _MM_KCSAN_ENCODING_H
> +#define _MM_KCSAN_ENCODING_H
> +
> +#include <linux/bits.h>
> +#include <linux/log2.h>
> +#include <linux/mm.h>
> +
> +#include "kcsan.h"
> +
> +#define SLOT_RANGE PAGE_SIZE
> +#define INVALID_WATCHPOINT 0
> +#define CONSUMED_WATCHPOINT 1
> +
> +/*
> + * The maximum useful size of accesses for which we set up watchpoints is the
> + * max range of slots we check on an access.
> + */
> +#define MAX_ENCODABLE_SIZE (SLOT_RANGE * (1 + KCSAN_CHECK_ADJACENT))
> +
> +/*
> + * Number of bits we use to store size info.
> + */
> +#define WATCHPOINT_SIZE_BITS bits_per(MAX_ENCODABLE_SIZE)
> +/*
> + * This encoding for addresses discards the upper (1 for is-write + SIZE_BITS);
> + * however, most 64-bit architectures do not use the full 64-bit address space.
> + * Also, in order for a false positive to be observable 2 things need to happen:
> + *
> + *     1. different addresses but with the same encoded address race;
> + *     2. and both map onto the same watchpoint slots;
> + *
> + * Both these are assumed to be very unlikely. However, in case it still happens
> + * happens, the report logic will filter out the false positive (see report.c).
> + */
> +#define WATCHPOINT_ADDR_BITS (BITS_PER_LONG - 1 - WATCHPOINT_SIZE_BITS)
> +
> +/*
> + * Masks to set/retrieve the encoded data.
> + */
> +#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG - 1)
> +#define WATCHPOINT_SIZE_MASK                                                   \
> +       GENMASK(BITS_PER_LONG - 2, BITS_PER_LONG - 2 - WATCHPOINT_SIZE_BITS)
> +#define WATCHPOINT_ADDR_MASK                                                   \
> +       GENMASK(BITS_PER_LONG - 3 - WATCHPOINT_SIZE_BITS, 0)
> +
> +static inline bool check_encodable(unsigned long addr, size_t size)
> +{
> +       return size <= MAX_ENCODABLE_SIZE;
> +}
> +
> +static inline long encode_watchpoint(unsigned long addr, size_t size,
> +                                    bool is_write)
> +{
> +       return (long)((is_write ? WATCHPOINT_WRITE_MASK : 0) |
> +                     (size << WATCHPOINT_ADDR_BITS) |
> +                     (addr & WATCHPOINT_ADDR_MASK));
> +}
> +
> +static inline bool decode_watchpoint(long watchpoint,
> +                                    unsigned long *addr_masked, size_t *size,
> +                                    bool *is_write)
> +{
> +       if (watchpoint == INVALID_WATCHPOINT ||
> +           watchpoint == CONSUMED_WATCHPOINT)
> +               return false;
> +
> +       *addr_masked = (unsigned long)watchpoint & WATCHPOINT_ADDR_MASK;
> +       *size = ((unsigned long)watchpoint & WATCHPOINT_SIZE_MASK) >>
> +               WATCHPOINT_ADDR_BITS;
> +       *is_write = !!((unsigned long)watchpoint & WATCHPOINT_WRITE_MASK);
> +
> +       return true;
> +}
> +
> +/*
> + * Return watchpoint slot for an address.
> + */
> +static inline int watchpoint_slot(unsigned long addr)
> +{
> +       return (addr / PAGE_SIZE) % KCSAN_NUM_WATCHPOINTS;
> +}
> +
> +static inline bool matching_access(unsigned long addr1, size_t size1,
> +                                  unsigned long addr2, size_t size2)
> +{
> +       unsigned long end_range1 = addr1 + size1 - 1;
> +       unsigned long end_range2 = addr2 + size2 - 1;
> +
> +       return addr1 <= end_range2 && addr2 <= end_range1;
> +}
> +
> +#endif /* _MM_KCSAN_ENCODING_H */
> diff --git a/kernel/kcsan/kcsan.c b/kernel/kcsan/kcsan.c
> new file mode 100644
> index 000000000000..45cf2fffd8a0
> --- /dev/null
> +++ b/kernel/kcsan/kcsan.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
> + * see Documentation/dev-tools/kcsan.rst.
> + */
> +
> +#include <linux/export.h>
> +
> +#include "kcsan.h"
> +
> +/*
> + * KCSAN uses the same instrumentation that is emitted by supported compilers
> + * for Thread Sanitizer (TSAN).
> + *
> + * When enabled, the compiler emits instrumentation calls (the functions
> + * prefixed with "__tsan" below) for all loads and stores that it generated;
> + * inline asm is not instrumented.
> + */
> +
> +#define DEFINE_TSAN_READ_WRITE(size)                                           \
> +       void __tsan_read##size(void *ptr)                                      \
> +       {                                                                      \
> +               __kcsan_check_read(ptr, size);                                 \
> +       }                                                                      \
> +       EXPORT_SYMBOL(__tsan_read##size);                                      \
> +       void __tsan_write##size(void *ptr)                                     \
> +       {                                                                      \
> +               __kcsan_check_write(ptr, size);                                \
> +       }                                                                      \
> +       EXPORT_SYMBOL(__tsan_write##size)
> +
> +DEFINE_TSAN_READ_WRITE(1);
> +DEFINE_TSAN_READ_WRITE(2);
> +DEFINE_TSAN_READ_WRITE(4);
> +DEFINE_TSAN_READ_WRITE(8);
> +DEFINE_TSAN_READ_WRITE(16);
> +
> +/*
> + * Not all supported compiler versions distinguish aligned/unaligned accesses,
> + * but e.g. recent versions of Clang do.
> + */
> +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                                 \
> +       void __tsan_unaligned_read##size(void *ptr)                            \
> +       {                                                                      \
> +               __kcsan_check_read(ptr, size);                                 \
> +       }                                                                      \
> +       EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
> +       void __tsan_unaligned_write##size(void *ptr)                           \
> +       {                                                                      \
> +               __kcsan_check_write(ptr, size);                                \
> +       }                                                                      \
> +       EXPORT_SYMBOL(__tsan_unaligned_write##size)
> +
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> +
> +void __tsan_read_range(void *ptr, size_t size)
> +{
> +       __kcsan_check_read(ptr, size);
> +}
> +EXPORT_SYMBOL(__tsan_read_range);
> +
> +void __tsan_write_range(void *ptr, size_t size)
> +{
> +       __kcsan_check_write(ptr, size);
> +}
> +EXPORT_SYMBOL(__tsan_write_range);
> +
> +/*
> + * The below are not required KCSAN, but can still be emitted by the compiler.

Is "for" missed before KCSAN?

> + */
> +void __tsan_func_entry(void *call_pc)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_entry);
> +void __tsan_func_exit(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_exit);
> +void __tsan_init(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_init);
> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> new file mode 100644
> index 000000000000..429479b3041d
> --- /dev/null
> +++ b/kernel/kcsan/kcsan.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _MM_KCSAN_KCSAN_H
> +#define _MM_KCSAN_KCSAN_H
> +
> +#include <linux/kcsan.h>
> +
> +/*
> + * Total number of watchpoints. An address range maps into a specific slot as
> + * specified in `encoding.h`. Although larger number of watchpoints may not even
> + * be usable due to limited thread count, a larger value will improve
> + * performance due to reducing cache-line contention.
> + */
> +#define KCSAN_NUM_WATCHPOINTS 64
> +
> +/*
> + * The number of adjacent watchpoints to check; the purpose is 2-fold:
> + *
> + *     1. the address slot is already occupied, check if any adjacent slots are
> + *        free;
> + *     2. accesses that straddle a slot boundary due to size that exceeds a
> + *        slot's range may check adjacent slots if any watchpoint matches.
> + *
> + * Note that accesses with very large size may still miss a watchpoint; however,
> + * given this should be rare, this is a reasonable trade-off to make, since this
> + * will avoid:
> + *
> + *     1. excessive contention between watchpoint checks and setup;
> + *     2. larger number of simultaneous watchpoints without sacrificing
> + *        performance.
> + */
> +#define KCSAN_CHECK_ADJACENT 1
> +
> +/*
> + * Globally enable and disable KCSAN.
> + */
> +extern bool kcsan_enabled;
> +
> +/*
> + * Helper that returns true if access to ptr should be considered as an atomic
> + * access, even though it is not explicitly atomic.
> + */
> +bool kcsan_is_atomic(const volatile void *ptr);
> +
> +/*
> + * Initialize debugfs file.
> + */
> +void kcsan_debugfs_init(void);
> +
> +enum kcsan_counter_id {
> +       /*
> +        * Number of watchpoints currently in use.
> +        */
> +       kcsan_counter_used_watchpoints,
> +
> +       /*
> +        * Total number of watchpoints set up.
> +        */
> +       kcsan_counter_setup_watchpoints,
> +
> +       /*
> +        * Total number of data-races.
> +        */
> +       kcsan_counter_data_races,
> +
> +       /*
> +        * Number of times no watchpoints were available.
> +        */
> +       kcsan_counter_no_capacity,
> +
> +       /*
> +        * A thread checking a watchpoint raced with another checking thread;
> +        * only one will be reported.
> +        */
> +       kcsan_counter_report_races,
> +
> +       /*
> +        * Observed data value change, but writer thread unknown.
> +        */
> +       kcsan_counter_races_unknown_origin,
> +
> +       /*
> +        * The access cannot be encoded to a valid watchpoint.
> +        */
> +       kcsan_counter_unencodable_accesses,
> +
> +       /*
> +        * Watchpoint encoding caused a watchpoint to fire on mismatching
> +        * accesses.
> +        */
> +       kcsan_counter_encoding_false_positives,
> +
> +       kcsan_counter_count, /* number of counters */
> +};
> +
> +/*
> + * Increment/decrement counter with given id; avoid calling these in fast-path.
> + */
> +void kcsan_counter_inc(enum kcsan_counter_id id);
> +void kcsan_counter_dec(enum kcsan_counter_id id);
> +
> +/*
> + * Returns true if data-races in the function symbol that maps to addr (offsets
> + * are ignored) should *not* be reported.
> + */
> +bool kcsan_skip_report(unsigned long func_addr);
> +
> +enum kcsan_report_type {
> +       /*
> +        * The thread that set up the watchpoint and briefly stalled was
> +        * signalled that another thread triggered the watchpoint, and thus a
> +        * race was encountered.
> +        */
> +       kcsan_report_race_setup,
> +
> +       /*
> +        * A thread encountered a watchpoint for the access, therefore a race
> +        * was encountered.
> +        */
> +       kcsan_report_race_check,
> +
> +       /*
> +        * A thread encountered a watchpoint for the access, but the other
> +        * racing thread can no longer be signaled that a race occurred.
> +        */
> +       kcsan_report_race_check_race,
> +
> +       /*
> +        * No other thread was observed to race with the access, but the data
> +        * value before and after the stall differs.
> +        */
> +       kcsan_report_race_unknown_origin,
> +};
> +/*
> + * Print a race report from thread that encountered the race.
> + */
> +void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
> +                 int cpu_id, enum kcsan_report_type type);
> +
> +#endif /* _MM_KCSAN_KCSAN_H */
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> new file mode 100644
> index 000000000000..517db539e4e7
> --- /dev/null
> +++ b/kernel/kcsan/report.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/preempt.h>
> +#include <linux/printk.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/stacktrace.h>
> +
> +#include "kcsan.h"
> +#include "encoding.h"
> +
> +/*
> + * Max. number of stack entries to show in the report.
> + */
> +#define NUM_STACK_ENTRIES 16

Increase it to 64 at least. No reason to truncate potentailly useful info.

> +
> +/*
> + * Other thread info: communicated from other racing thread to thread that set
> + * up the watchpoint, which then prints the complete report atomically. Only
> + * need one struct, as all threads should to be serialized regardless to print
> + * the reports, with reporting being in the slow-path.
> + */
> +static struct {
> +       const volatile void *ptr;
> +       size_t size;
> +       bool is_write;
> +       int task_pid;
> +       int cpu_id;
> +       unsigned long stack_entries[NUM_STACK_ENTRIES];
> +       int num_stack_entries;
> +} other_info = { .ptr = NULL };
> +
> +static DEFINE_SPINLOCK(other_info_lock);
> +static DEFINE_SPINLOCK(report_lock);
> +
> +static bool set_or_lock_other_info(unsigned long *flags,
> +                                  const volatile void *ptr, size_t size,
> +                                  bool is_write, int cpu_id,
> +                                  enum kcsan_report_type type)
> +{
> +       if (type != kcsan_report_race_check && type != kcsan_report_race_setup)
> +               return true;
> +
> +       for (;;) {
> +               spin_lock_irqsave(&other_info_lock, *flags);
> +
> +               switch (type) {
> +               case kcsan_report_race_check:
> +                       if (other_info.ptr != NULL) {
> +                               /* still in use, retry */
> +                               break;
> +                       }
> +                       other_info.ptr = ptr;
> +                       other_info.size = size;
> +                       other_info.is_write = is_write;
> +                       other_info.task_pid =
> +                               in_task() ? task_pid_nr(current) : -1;
> +                       other_info.cpu_id = cpu_id;
> +                       other_info.num_stack_entries = stack_trace_save(
> +                               other_info.stack_entries, NUM_STACK_ENTRIES, 1);
> +                       /*
> +                        * other_info may now be consumed by thread we raced
> +                        * with.
> +                        */
> +                       spin_unlock_irqrestore(&other_info_lock, *flags);
> +                       return false;
> +
> +               case kcsan_report_race_setup:
> +                       if (other_info.ptr == NULL)
> +                               break; /* no data available yet, retry */
> +
> +                       /*
> +                        * First check if matching based on how watchpoint was
> +                        * encoded.
> +                        */
> +                       if (!matching_access((unsigned long)other_info.ptr &
> +                                                    WATCHPOINT_ADDR_MASK,
> +                                            other_info.size,
> +                                            (unsigned long)ptr &
> +                                                    WATCHPOINT_ADDR_MASK,
> +                                            size))
> +                               break; /* mismatching access, retry */
> +
> +                       if (!matching_access((unsigned long)other_info.ptr,
> +                                            other_info.size,
> +                                            (unsigned long)ptr, size)) {
> +                               /*
> +                                * If the actual accesses to not match, this was
> +                                * a false positive due to watchpoint encoding.
> +                                */
> +                               other_info.ptr = NULL; /* mark for reuse */
> +                               kcsan_counter_inc(
> +                                       kcsan_counter_encoding_false_positives);
> +                               spin_unlock_irqrestore(&other_info_lock,
> +                                                      *flags);
> +                               return false;
> +                       }
> +
> +                       /*
> +                        * Matching access: keep other_info locked, as this
> +                        * thread uses it to print the full report; unlocked in
> +                        * end_report.
> +                        */
> +                       return true;
> +
> +               default:
> +                       BUG();
> +               }
> +
> +               spin_unlock_irqrestore(&other_info_lock, *flags);
> +       }
> +}
> +
> +static void start_report(unsigned long *flags, enum kcsan_report_type type)
> +{
> +       switch (type) {
> +       case kcsan_report_race_setup:
> +               /* irqsaved already via other_info_lock */
> +               spin_lock(&report_lock);
> +               break;
> +
> +       case kcsan_report_race_unknown_origin:
> +               spin_lock_irqsave(&report_lock, *flags);
> +               break;
> +
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static void end_report(unsigned long *flags, enum kcsan_report_type type)
> +{
> +       switch (type) {
> +       case kcsan_report_race_setup:
> +               other_info.ptr = NULL; /* mark for reuse */
> +               spin_unlock(&report_lock);
> +               spin_unlock_irqrestore(&other_info_lock, *flags);
> +               break;
> +
> +       case kcsan_report_race_unknown_origin:
> +               spin_unlock_irqrestore(&report_lock, *flags);
> +               break;
> +
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static const char *get_access_type(bool is_write)
> +{
> +       return is_write ? "write" : "read";
> +}
> +
> +/* Return thread description: in task or interrupt. */
> +static const char *get_thread_desc(int task_id)
> +{
> +       if (task_id != -1) {
> +               static char buf[32]; /* safe: protected by report_lock */
> +
> +               snprintf(buf, sizeof(buf), "task %i", task_id);
> +               return buf;
> +       }
> +       return in_nmi() ? "NMI" : "interrupt";

in_nmi() will return a wrong thing for the other thread. We either
need to memorize it with the pid, or I would simply always print
"interrupt" b/c nmi/non-nmi is inferrable from the stack if necessary.


> +}
> +
> +/* Helper to skip KCSAN-related functions in stack-trace. */
> +static int get_stack_skipnr(unsigned long stack_entries[], int num_entries)
> +{
> +       char buf[64];
> +       int skip = 0;
> +
> +       for (; skip < num_entries; ++skip) {
> +               snprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
> +               if (!strnstr(buf, "csan_", sizeof(buf)) &&
> +                   !strnstr(buf, "tsan_", sizeof(buf)) &&
> +                   !strnstr(buf, "_once_size", sizeof(buf))) {
> +                       break;
> +               }
> +       }
> +       return skip;
> +}
> +
> +/* Compares symbolized strings of addr1 and addr2. */
> +static int sym_strcmp(void *addr1, void *addr2)
> +{
> +       char buf1[64];
> +       char buf2[64];
> +
> +       snprintf(buf1, sizeof(buf1), "%pS", addr1);
> +       snprintf(buf2, sizeof(buf2), "%pS", addr2);
> +       return strncmp(buf1, buf2, sizeof(buf1));
> +}
> +
> +/*
> + * Returns true if a report was generated, false otherwise.
> + */
> +static bool print_summary(const volatile void *ptr, size_t size, bool is_write,
> +                         int cpu_id, enum kcsan_report_type type)
> +{
> +       unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
> +       int num_stack_entries =
> +               stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
> +       int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
> +       int other_skipnr;
> +
> +       /* Check if the top stackframe is in a blacklisted function. */
> +       if (kcsan_skip_report(stack_entries[skipnr]))
> +               return false;
> +       if (type == kcsan_report_race_setup) {
> +               other_skipnr = get_stack_skipnr(other_info.stack_entries,
> +                                               other_info.num_stack_entries);
> +               if (kcsan_skip_report(other_info.stack_entries[other_skipnr]))
> +                       return false;
> +       }
> +
> +       /* Print report header. */
> +       pr_err("==================================================================\n");
> +       switch (type) {
> +       case kcsan_report_race_setup: {
> +               void *this_fn = (void *)stack_entries[skipnr];
> +               void *other_fn = (void *)other_info.stack_entries[other_skipnr];
> +               int cmp;
> +
> +               /*
> +                * Order functions lexographically for consistent bug titles.
> +                * Do not print offset of functions to keep title short.
> +                */
> +               cmp = sym_strcmp(other_fn, this_fn);
> +               pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
> +                      cmp < 0 ? other_fn : this_fn,
> +                      cmp < 0 ? this_fn : other_fn);
> +       } break;
> +
> +       case kcsan_report_race_unknown_origin:
> +               pr_err("BUG: KCSAN: data-race in %pS\n",
> +                      (void *)stack_entries[skipnr]);
> +               break;
> +
> +       default:
> +               BUG();
> +       }
> +
> +       pr_err("\n");
> +
> +       /* Print information about the racing accesses. */
> +       switch (type) {
> +       case kcsan_report_race_setup:
> +               pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> +                      get_access_type(other_info.is_write), other_info.ptr,
> +                      other_info.size, get_thread_desc(other_info.task_pid),
> +                      other_info.cpu_id);
> +
> +               /* Print the other thread's stack trace. */
> +               stack_trace_print(other_info.stack_entries + other_skipnr,
> +                                 other_info.num_stack_entries - other_skipnr,
> +                                 0);
> +
> +               pr_err("\n");
> +               pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> +                      get_access_type(is_write), ptr, size,
> +                      get_thread_desc(in_task() ? task_pid_nr(current) : -1),
> +                      cpu_id);
> +               break;
> +
> +       case kcsan_report_race_unknown_origin:
> +               pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
> +                      get_access_type(is_write), ptr, size,
> +                      get_thread_desc(in_task() ? task_pid_nr(current) : -1),
> +                      cpu_id);
> +               break;
> +
> +       default:
> +               BUG();
> +       }
> +       /* Print stack trace of this thread. */
> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
> +                         0);
> +
> +       /* Print report footer. */
> +       pr_err("\n");
> +       pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> +       dump_stack_print_info(KERN_DEFAULT);
> +       pr_err("==================================================================\n");
> +
> +       return true;
> +}
> +
> +void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
> +                 int cpu_id, enum kcsan_report_type type)
> +{
> +       unsigned long flags = 0;
> +
> +       if (type == kcsan_report_race_check_race)
> +               return;
> +
> +       kcsan_disable_current();
> +       if (set_or_lock_other_info(&flags, ptr, size, is_write, cpu_id, type)) {
> +               start_report(&flags, type);
> +               if (print_summary(ptr, size, is_write, cpu_id, type) &&
> +                   panic_on_warn)
> +                       panic("panic_on_warn set ...\n");
> +               end_report(&flags, type);
> +       }
> +       kcsan_enable_current();
> +}
> diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
> new file mode 100644
> index 000000000000..68c896a24529
> --- /dev/null
> +++ b/kernel/kcsan/test.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/random.h>
> +#include <linux/types.h>
> +
> +#include "encoding.h"
> +
> +#define ITERS_PER_TEST 2000
> +
> +/* Test requirements. */
> +static bool test_requires(void)
> +{
> +       /* random should be initialized */
> +       return prandom_u32() + prandom_u32() != 0;
> +}
> +
> +/* Test watchpoint encode and decode. */
> +static bool test_encode_decode(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ITERS_PER_TEST; ++i) {
> +               size_t size = prandom_u32() % MAX_ENCODABLE_SIZE + 1;
> +               bool is_write = prandom_u32() % 2;
> +               unsigned long addr;
> +
> +               prandom_bytes(&addr, sizeof(addr));
> +               if (WARN_ON(!check_encodable(addr, size)))
> +                       return false;
> +
> +               /* encode and decode */
> +               {
> +                       const long encoded_watchpoint =
> +                               encode_watchpoint(addr, size, is_write);
> +                       unsigned long verif_masked_addr;
> +                       size_t verif_size;
> +                       bool verif_is_write;
> +
> +                       /* check special watchpoints */
> +                       if (WARN_ON(decode_watchpoint(
> +                                   INVALID_WATCHPOINT, &verif_masked_addr,
> +                                   &verif_size, &verif_is_write)))
> +                               return false;
> +                       if (WARN_ON(decode_watchpoint(
> +                                   CONSUMED_WATCHPOINT, &verif_masked_addr,
> +                                   &verif_size, &verif_is_write)))
> +                               return false;
> +
> +                       /* check decoding watchpoint returns same data */
> +                       if (WARN_ON(!decode_watchpoint(
> +                                   encoded_watchpoint, &verif_masked_addr,
> +                                   &verif_size, &verif_is_write)))
> +                               return false;
> +                       if (WARN_ON(verif_masked_addr !=
> +                                   (addr & WATCHPOINT_ADDR_MASK)))
> +                               goto fail;
> +                       if (WARN_ON(verif_size != size))
> +                               goto fail;
> +                       if (WARN_ON(is_write != verif_is_write))
> +                               goto fail;
> +
> +                       continue;
> +fail:
> +                       pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
> +                              __func__, is_write ? "write" : "read", size,
> +                              addr, encoded_watchpoint,
> +                              verif_is_write ? "write" : "read", verif_size,
> +                              verif_masked_addr);
> +                       return false;
> +               }
> +       }
> +
> +       return true;
> +}
> +
> +static bool test_matching_access(void)
> +{
> +       if (WARN_ON(!matching_access(10, 1, 10, 1)))
> +               return false;
> +       if (WARN_ON(!matching_access(10, 2, 11, 1)))
> +               return false;
> +       if (WARN_ON(!matching_access(10, 1, 9, 2)))
> +               return false;
> +       if (WARN_ON(matching_access(10, 1, 11, 1)))
> +               return false;
> +       if (WARN_ON(matching_access(9, 1, 10, 1)))
> +               return false;
> +       return true;
> +}
> +
> +static int __init kcsan_selftest(void)
> +{
> +       int passed = 0;
> +       int total = 0;
> +
> +#define RUN_TEST(do_test)                                                      \
> +       do {                                                                   \
> +               ++total;                                                       \
> +               if (do_test())                                                 \
> +                       ++passed;                                              \
> +               else                                                           \
> +                       pr_err("KCSAN selftest: " #do_test " failed");         \
> +       } while (0)
> +
> +       RUN_TEST(test_requires);
> +       RUN_TEST(test_encode_decode);
> +       RUN_TEST(test_matching_access);
> +
> +       pr_info("KCSAN selftest: %d/%d tests passed\n", passed, total);
> +       if (passed != total)
> +               panic("KCSAN selftests failed");
> +       return 0;
> +}
> +postcore_initcall(kcsan_selftest);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 93d97f9b0157..35accd1d93de 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2086,6 +2086,8 @@ source "lib/Kconfig.kgdb"
>
>  source "lib/Kconfig.ubsan"
>
> +source "lib/Kconfig.kcsan"
> +
>  config ARCH_HAS_DEVMEM_IS_ALLOWED
>         bool
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> new file mode 100644
> index 000000000000..3e1f1acfb24b
> --- /dev/null
> +++ b/lib/Kconfig.kcsan
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config HAVE_ARCH_KCSAN
> +       bool
> +
> +menuconfig KCSAN
> +       bool "KCSAN: watchpoint-based dynamic data-race detector"
> +       depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
> +       default n
> +       help
> +         Kernel Concurrency Sanitizer is a dynamic data-race detector, which
> +         uses a watchpoint-based sampling approach to detect races.
> +
> +if KCSAN
> +
> +config KCSAN_SELFTEST
> +       bool "KCSAN: perform short selftests on boot"
> +       default y
> +       help
> +         Run KCSAN selftests on boot. On test failure, causes kernel to panic.
> +
> +config KCSAN_EARLY_ENABLE
> +       bool "KCSAN: early enable"
> +       default y
> +       help
> +         If KCSAN should be enabled globally as soon as possible. KCSAN can
> +         later be enabled/disabled via debugfs.
> +
> +config KCSAN_UDELAY_MAX_TASK
> +       int "KCSAN: maximum delay in microseconds (for tasks)"
> +       default 80
> +       help
> +         For tasks, the max. microsecond delay after setting up a watchpoint.
> +
> +config KCSAN_UDELAY_MAX_INTERRUPT
> +       int "KCSAN: maximum delay in microseconds (for interrupts)"
> +       default 20
> +       help
> +         For interrupts, the max. microsecond delay after setting up a watchpoint.
> +
> +config KCSAN_DELAY_RANDOMIZE
> +       bool "KCSAN: randomize delays"
> +       default y
> +       help
> +         If delays should be randomized; if false, the chosen delay is simply
> +         the maximum values defined above.
> +
> +config KCSAN_WATCH_SKIP_INST
> +       int "KCSAN: watchpoint instruction skip"
> +       default 2000
> +       help
> +         The number of per-CPU memory operations to skip watching, before
> +         another watchpoint is set up; in other words, 1 in
> +         KCSAN_WATCH_SKIP_INST per-CPU memory operations are used to set up a
> +         watchpoint. A smaller value results in more aggressive race
> +         detection, whereas a larger value improves system performance at the
> +         cost of missing some races.
> +
> +config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> +       bool "KCSAN: report races of unknown origin"
> +       default y
> +       help
> +         If KCSAN should report races where only one access is known, and the
> +         conflicting access is of unknown origin. This type of race is
> +         reported if it was only possible to infer a race due to a data-value
> +         change while an access is being delayed on a watchpoint.
> +
> +config KCSAN_IGNORE_ATOMICS
> +       bool "KCSAN: do not instrument marked atomic accesses"
> +       default n
> +       help
> +         If enabled, never instruments marked atomic accesses. This results in
> +         not reporting data-races where one access is atomic and the other is
> +         a plain access.
> +
> +config KCSAN_PLAIN_WRITE_PRETEND_ONCE
> +       bool "KCSAN: pretend plain writes are WRITE_ONCE"
> +       default n
> +       help
> +         This option makes KCSAN pretend that all plain writes are WRITE_ONCE.
> +         This option should only be used to prune initial data-races found in
> +         existing code.
> +
> +config KCSAN_DEBUG
> +       bool "Debugging of KCSAN internals"
> +       default n
> +
> +endif # KCSAN
> diff --git a/lib/Makefile b/lib/Makefile
> index c5892807e06f..778ab704e3ad 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -24,6 +24,9 @@ KASAN_SANITIZE_string.o := n
>  CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
>  endif
>
> +# Used by KCSAN while enabled, avoid recursion.
> +KCSAN_SANITIZE_random32.o := n
> +
>  lib-y := ctype.o string.o vsprintf.o cmdline.o \
>          rbtree.o radix-tree.o timerqueue.o xarray.o \
>          idr.o extable.o \
> diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
> new file mode 100644
> index 000000000000..caf1111a28ae
> --- /dev/null
> +++ b/scripts/Makefile.kcsan
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +ifdef CONFIG_KCSAN
> +
> +CFLAGS_KCSAN := -fsanitize=thread
> +
> +endif # CONFIG_KCSAN
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 179d55af5852..0e78abab7d83 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -152,6 +152,16 @@ _c_flags += $(if $(patsubst n%,, \
>         $(CFLAGS_KCOV))
>  endif
>
> +#
> +# Enable ConcurrencySanitizer flags for kernel except some files or directories
> +# we don't want to check (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
> +#
> +ifeq ($(CONFIG_KCSAN),y)
> +_c_flags += $(if $(patsubst n%,, \
> +       $(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
> +       $(CFLAGS_KCSAN))
> +endif
> +
>  # $(srctree)/$(src) for including checkin headers from generated source files
>  # $(objtree)/$(obj) for including generated headers from checkin source files
>  ifeq ($(KBUILD_EXTMOD),)
> --
> 2.23.0.866.gb869b98d4c-goog
>
