Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621EAD930F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfJPNxK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 09:53:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39803 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393716AbfJPNxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 09:53:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so20193714otr.6
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXaUYTlHBDwej+JruJ2WTRxguQOYJLFuT4MqoWM48a4=;
        b=C9UK7bh+ztLhwBM8J33XqmOMriejaJ+0xBWQ6kKLjRvTfQIxk5p/YpBZGwm9t49f9O
         xrSm9+8G6fyjGt+qPRHVWarJDF/9bBUe05isRIgqUFacAMzOUJfCTVcJeiDjWPxOjHTm
         5sqfr+HZQHAW+K7huLX8uVp+FtOB+3cHS3DYiJegAId2vcxFnEQLLzv5aj1GhYHwEb3k
         tMqUv0gevFgRy3WOSk9EKLDeg21dXFnWX1U0zIKJlDA9zyPfJzApkRdMeAPAn/ZEXlCp
         eeaChM88DYDHx1QmnU19AZsQvEFi7LV9EgRPZKoI2iHv/uSey1DQoTW9mA92EzRyf/h1
         Wk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXaUYTlHBDwej+JruJ2WTRxguQOYJLFuT4MqoWM48a4=;
        b=FU712ysGek7rWmFeA5MYm2HHGUDP+uV/PCAAkjLXoZqnCYYh1dJsYKO4mUa8Ys4ueP
         4L6TSHlsS+ZCvlLoPvJuhIQaeRjcHudvhVTvbYaCh6IOoeXaIKS10j66gj6sF0kF263q
         L0enC7Nsf56Q6K/mPNsl0RIudX1n5TM8xiVUZ+JJ0fixzcbqE81cA4BoFwTDT6TjRIEk
         iITP8eWys9NSeraVuDIPwLMkWuwV2rMcI13Ny1TomCp9fgcDzMXj3XfdufPswXiccMbc
         a1kVfIUBhLuvSJablhRenbTMQaw+q7rtXJzkOAN46o6zyvWPnmgrkzTXbeJlpYTrBZqf
         ABVw==
X-Gm-Message-State: APjAAAUQdLHl3y/XczY4B+LdLEcbut0AAHRndZ/TVDGTMDjtio9eYlMJ
        MTrAZjc+yYKIMp6384/GWp5n0kmKEC9RMMS70j1Irw==
X-Google-Smtp-Source: APXvYqzFavdggnaXP/V8PoDQYCbLiuVoElErTrh7JNRIbFLWthPWSxHzXi/gtBRq+FPGjih37+pfVizePnpq6egTXfY=
X-Received: by 2002:a9d:724e:: with SMTP id a14mr34578027otk.23.1571233986798;
 Wed, 16 Oct 2019 06:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-2-elver@google.com>
 <CAAeHK+wO226yFsWw97wET_CY3aCiqX30JBYLtBspO5PbSV9FAA@mail.gmail.com>
In-Reply-To: <CAAeHK+wO226yFsWw97wET_CY3aCiqX30JBYLtBspO5PbSV9FAA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Oct 2019 15:52:53 +0200
Message-ID: <CANpmjNOcE=myHAC4xYOdssMUvJP2=1BeXmQ62O_tRQ-5cbiKMA@mail.gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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

> > diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> > new file mode 100644
> > index 000000000000..5b46cc5593c3
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kcsan.rst
> > @@ -0,0 +1,202 @@
> > +The Kernel Concurrency Sanitizer (KCSAN)
> > +========================================
> > +
> > +Overview
> > +--------
> > +
> > +*Kernel Concurrency Sanitizer (KCSAN)* is a dynamic data-race detector for
> > +kernel space. KCSAN is a sampling watchpoint-based data-race detector -- this
> > +is unlike Kernel Thread Sanitizer (KTSAN), which is a happens-before data-race
> > +detector. Key priorities in KCSAN's design are lack of false positives,
> > +scalability, and simplicity. More details can be found in `Implementation
> > +Details`_.
> > +
> > +KCSAN uses compile-time instrumentation to instrument memory accesses. KCSAN is
> > +supported in both GCC and Clang. With GCC it requires version 7.3.0 or later.
> > +With Clang it requires version 7.0.0 or later.
> > +
> > +Usage
> > +-----
> > +
> > +To enable KCSAN configure kernel with::
> > +
> > +    CONFIG_KCSAN = y
> > +
> > +KCSAN provides several other configuration options to customize behaviour (see
> > +their respective help text for more info).
> > +
> > +debugfs
> > +~~~~~~~
> > +
> > +* The file ``/sys/kernel/debug/kcsan`` can be read to get stats.
> > +
> > +* KCSAN can be turned on or off by writing ``on`` or ``off`` to
> > +  ``/sys/kernel/debug/kcsan``.
> > +
> > +* Writing ``!some_func_name`` to ``/sys/kernel/debug/kcsan`` adds
> > +  ``some_func_name`` to the report filter list, which (by default) blacklists
> > +  reporting data-races where either one of the top stackframes are a function
> > +  in the list.
> > +
> > +* Writing either ``blacklist`` or ``whitelist`` to ``/sys/kernel/debug/kcsan``
> > +  changes the report filtering behaviour. For example, the blacklist feature
> > +  can be used to silence frequently occurring data-races; the whitelist feature
> > +  can help with reproduction and testing of fixes.
> > +
> > +Error reports
> > +~~~~~~~~~~~~~
> > +
> > +A typical data-race report looks like this::
> > +
> > +    ==================================================================
> > +    BUG: KCSAN: data-race in generic_permission / kernfs_refresh_inode
> > +
> > +    write to 0xffff8fee4c40700c of 4 bytes by task 175 on cpu 4:
> > +     kernfs_refresh_inode+0x70/0x170
> > +     kernfs_iop_permission+0x4f/0x90
> > +     inode_permission+0x190/0x200
> > +     link_path_walk.part.0+0x503/0x8e0
> > +     path_lookupat.isra.0+0x69/0x4d0
> > +     filename_lookup+0x136/0x280
> > +     user_path_at_empty+0x47/0x60
> > +     vfs_statx+0x9b/0x130
> > +     __do_sys_newlstat+0x50/0xb0
> > +     __x64_sys_newlstat+0x37/0x50
> > +     do_syscall_64+0x85/0x260
> > +     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > +
> > +    read to 0xffff8fee4c40700c of 4 bytes by task 166 on cpu 6:
> > +     generic_permission+0x5b/0x2a0
> > +     kernfs_iop_permission+0x66/0x90
> > +     inode_permission+0x190/0x200
> > +     link_path_walk.part.0+0x503/0x8e0
> > +     path_lookupat.isra.0+0x69/0x4d0
> > +     filename_lookup+0x136/0x280
> > +     user_path_at_empty+0x47/0x60
> > +     do_faccessat+0x11a/0x390
> > +     __x64_sys_access+0x3c/0x50
> > +     do_syscall_64+0x85/0x260
> > +     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > +
> > +    Reported by Kernel Concurrency Sanitizer on:
> > +    CPU: 6 PID: 166 Comm: systemd-journal Not tainted 5.3.0-rc7+ #1
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +The header of the report provides a short summary of the functions involved in
> > +the race. It is followed by the access types and stack traces of the 2 threads
> > +involved in the data-race.
> > +
> > +The other less common type of data-race report looks like this::
> > +
> > +    ==================================================================
> > +    BUG: KCSAN: racing read in e1000_clean_rx_irq+0x551/0xb10
>
> Do we want to have a different bug title here? Can we also report this
> as a data-race to simplify report parsing rules?

Changed to just "data-race in" as well.

> > +
> > +    race at unknown origin, with read to 0xffff933db8a2ae6c of 1 bytes by interrupt on cpu 0:
> > +     e1000_clean_rx_irq+0x551/0xb10
> > +     e1000_clean+0x533/0xda0
> > +     net_rx_action+0x329/0x900
> > +     __do_softirq+0xdb/0x2db
> > +     irq_exit+0x9b/0xa0
> > +     do_IRQ+0x9c/0xf0
> > +     ret_from_intr+0x0/0x18
> > +     default_idle+0x3f/0x220
> > +     arch_cpu_idle+0x21/0x30
> > +     do_idle+0x1df/0x230
> > +     cpu_startup_entry+0x14/0x20
> > +     rest_init+0xc5/0xcb
> > +     arch_call_rest_init+0x13/0x2b
> > +     start_kernel+0x6db/0x700
> > +
> > +    Reported by Kernel Concurrency Sanitizer on:
> > +    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc7+ #2
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +This report is generated where it was not possible to determine the other
> > +racing thread, but a race was inferred due to the data-value of the watched
> > +memory location having changed. These can occur either due to missing
> > +instrumentation or e.g. DMA accesses.
> > +
> > +Data-Races
> > +----------
> > +
> > +Informally, two operations *conflict* if they access the same memory location,
> > +and at least one of them is a write operation. In an execution, two memory
> > +operations from different threads form a **data-race** if they *conflict*, at
> > +least one of them is a *plain access* (non-atomic), and they are *unordered* in
> > +the "happens-before" order according to the `LKMM
> > +<../../tools/memory-model/Documentation/explanation.txt>`_.
> > +
> > +Relationship with the Linux Kernel Memory Model (LKMM)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The LKMM defines the propagation and ordering rules of various memory
> > +operations, which gives developers the ability to reason about concurrent code.
> > +Ultimately this allows to determine the possible executions of concurrent code,
> > +and if that code is free from data-races.
> > +
> > +KCSAN is aware of *atomic* accesses (``READ_ONCE``, ``WRITE_ONCE``,
> > +``atomic_*``, etc.), but is oblivious of any ordering guarantees. In other
> > +words, KCSAN assumes that as long as a plain access is not observed to race
> > +with another conflicting access, memory operations are correctly ordered.
> > +
> > +This means that KCSAN will not report *potential* data-races due to missing
> > +memory ordering. If, however, missing memory ordering (that is observable with
> > +a particular compiler and architecture) leads to an observable data-race (e.g.
> > +entering a critical section erroneously), KCSAN would report the resulting
> > +data-race.
> > +
> > +Implementation Details
> > +----------------------
> > +
> > +The general approach is inspired by `DataCollider
> > +<http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>`_.
> > +Unlike DataCollider, KCSAN does not use hardware watchpoints, but instead
> > +relies on compiler instrumentation. Watchpoints are implemented using an
> > +efficient encoding that stores access type, size, and address in a long; the
> > +benefits of using "soft watchpoints" are portability and greater flexibility in
> > +limiting which accesses trigger a watchpoint.
> > +
> > +More specifically, KCSAN requires instrumenting plain (unmarked, non-atomic)
> > +memory operations; for each instrumented plain access:
> > +
> > +1. Check if a matching watchpoint exists; if yes, and at least one access is a
> > +   write, then we encountered a racing access.
> > +
> > +2. Periodically, if no matching watchpoint exists, set up a watchpoint and
> > +   stall some delay.
> > +
> > +3. Also check the data value before the delay, and re-check the data value
> > +   after delay; if the values mismatch, we infer a race of unknown origin.
> > +
> > +To detect data-races between plain and atomic memory operations, KCSAN also
> > +annotates atomic accesses, but only to check if a watchpoint exists
> > +(``kcsan_check_atomic(..)``); i.e.  KCSAN never sets up a watchpoint on atomic
> > +accesses.
> > +
> > +Key Properties
> > +~~~~~~~~~~~~~~
> > +
> > +1. **Performance Overhead:** KCSAN's runtime is minimal, and does not require
> > +   locking shared state for each access. This results in significantly better
> > +   performance in comparison with KTSAN.
> > +
> > +2. **Memory Overhead:** No shadow memory is required. The current
> > +   implementation uses a small array of longs to encode watchpoint information,
> > +   which is negligible.
> > +
> > +3. **Memory Ordering:** KCSAN is *not* aware of the LKMM's ordering rules. This
> > +   may result in missed data-races (false negatives), compared to a
> > +   happens-before data-race detector such as KTSAN.
> > +
> > +4. **Accuracy:** Imprecise, since it uses a sampling strategy.
> > +
> > +5. **Annotation Overheads:** Minimal annotation is required outside the KCSAN
> > +   runtime. With a happens-before data-race detector, any omission leads to
> > +   false positives, which is especially important in the context of the kernel
> > +   which includes numerous custom synchronization mechanisms. With KCSAN, as a
> > +   result, maintenance overheads are minimal as the kernel evolves.
> > +
> > +6. **Detects Racy Writes from Devices:** Due to checking data values upon
> > +   setting up watchpoints, racy writes from devices can also be detected.
>
> This part compares KCSAN with KTSAN, do we need it here? I think it
> might be better to move this to the cover letter as a rationale as to
> why we went with the watchpoint based approach, instead of the
> happens-before one.

Removed mentions of KTSAN where it doesn't add very much.

These are properties of the design that, if not summarized here, would
be lost and we'd have to look at the code. This is also for the
benefit of developers using KCSAN to detect races, highlighting the
pros and cons in the inherent design they should be aware of. I prefer
keeping this information here, as otherwise it will get lost and we
will have no central place to refer to.

> Some performance numbers comparing KCSAN with a non instrumented
> kernel would be more useful here.

I've added a sentence with some empirical data.

Changes queued for v2.

Many thanks,
-- Marco
