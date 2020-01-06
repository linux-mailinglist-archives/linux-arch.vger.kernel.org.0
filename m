Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B763131245
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgAFMrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jan 2020 07:47:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgAFMrK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 07:47:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so71549320oty.6
        for <linux-arch@vger.kernel.org>; Mon, 06 Jan 2020 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cokz+TzxrpaxvG5nOS6eF++kPejXpiqRHh7qCMSQec=;
        b=VSPR1kNh7jcvbYeM40HUkgvv2juwOOJPMTYyKKYC5vhjpIsMb2xhi15fRuQgOvTPL5
         V1a7AS8J87afZ4yaptjdIoKtaI2Br/pox8NJ+XTBZ1VIx66jhfSBr4w2B+82VTr4ZpF8
         mTSLujM1kuGSTfnTqjV/UFcERGeFaLCLh7Dbp1EDXvkanPImgReiGuBkDcz2vOfcb5kZ
         bj59nBD2Z7qiiBxv+jZn/e4k7BNy1/AZgBVpHXrf5FZAAPPQ96r5YQp5z6EuxPbiwCRk
         UYOKLLzjTmm1R4heMg8ILqzLXpcvyspEAyZYqkGEo7fLDfqGiZxdo5WvSLSMgYK+HlN9
         AWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cokz+TzxrpaxvG5nOS6eF++kPejXpiqRHh7qCMSQec=;
        b=oTP1rhoFwlBblReBBmt09LDrxAMtjdE+W8K/MelXVQugw3IEpWG+qZg/dvUZ8Cuhue
         YidKiqTAHDMauBMzjcGjuqJ0n0aiCcd1mQLgpSdT6Zznpzl7+DtT6IE9QcnR5TLDiDS/
         bP7YSenIPjuxGlLvEekLfB4WDkNSZVvJV7lMR3/lNIHrNofCiem23P0jGUsk751r8gw2
         LY7xalBkr0aVu6y/vDOAkkxwKAhwKQbLlCcWxWqT9FUHC2bUNAO6TDfiAmwg/mqwZdVs
         lcl+mThFIUQD7hmzUuuln8u/sC6ci2BO6vZRQbeAKk+lPbOwDDpmprVtOlvGVAVTQjGS
         1SJg==
X-Gm-Message-State: APjAAAVZDHvnGjLGX2E6TcCT8SRA8hNeK6KI+eJ1tyw/Gy7kByQ1yWrD
        ivEnsjbPns8Zl+cfN9DscxzMiRj+sbNhyckO8XsKgQ==
X-Google-Smtp-Source: APXvYqxJirJ4tMUUigFwZuoGjSzrBh2H8+dLoDP3tFn248r//UtiG0zaVOpxu+0owZBKVVOZDGrCSsyTsAsTyUSybWE=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr103842622otk.23.1578314829026;
 Mon, 06 Jan 2020 04:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20191114180303.66955-1-elver@google.com> <20191114180303.66955-2-elver@google.com>
 <BAB5F853-95FA-4623-A067-4E62B90721D3@lca.pw>
In-Reply-To: <BAB5F853-95FA-4623-A067-4E62B90721D3@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Jan 2020 13:46:57 +0100
Message-ID: <CANpmjNOC2PYFsE_TK2SYmKcHxyG+2arWc8x_fmeWPOMi0+ot8g@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Qian Cai <cai@lca.pw>
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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

On Fri, 3 Jan 2020 at 06:13, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Nov 14, 2019, at 1:02 PM, 'Marco Elver' via kasan-dev <kasan-dev@googlegroups.com> wrote:
> > +static noinline void kcsan_setup_watchpoint(const volatile void *ptr,
> > +                                         size_t size, bool is_write)
> > +{
> > +     atomic_long_t *watchpoint;
> > +     union {
> > +             u8 _1;
> > +             u16 _2;
> > +             u32 _4;
> > +             u64 _8;
> > +     } expect_value;
> > +     bool value_change = false;
> > +     unsigned long ua_flags = user_access_save();
> > +     unsigned long irq_flags;
> > +
> > +     /*
> > +      * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> > +      * should_watch().
> > +      */
> > +     reset_kcsan_skip();
> > +
> > +     if (!kcsan_is_enabled())
> > +             goto out;
> > +
> > +     if (!check_encodable((unsigned long)ptr, size)) {
> > +             kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Disable interrupts & preemptions to avoid another thread on the same
> > +      * CPU accessing memory locations for the set up watchpoint; this is to
> > +      * avoid reporting races to e.g. CPU-local data.
> > +      *
> > +      * An alternative would be adding the source CPU to the watchpoint
> > +      * encoding, and checking that watchpoint-CPU != this-CPU. There are
> > +      * several problems with this:
> > +      *   1. we should avoid stealing more bits from the watchpoint encoding
> > +      *      as it would affect accuracy, as well as increase performance
> > +      *      overhead in the fast-path;
> > +      *   2. if we are preempted, but there *is* a genuine data race, we
> > +      *      would *not* report it -- since this is the common case (vs.
> > +      *      CPU-local data accesses), it makes more sense (from a data race
> > +      *      detection point of view) to simply disable preemptions to ensure
> > +      *      as many tasks as possible run on other CPUs.
> > +      */
> > +     local_irq_save(irq_flags);
>
> Enabling KCSAN will now generate a warning during boot here.
>
> Config (need to deselect KASAN and select KCSAN):
>
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Thanks, I'll look into KCSAN + lockdep compatibility. It's probably
missing some KCSAN_SANITIZE := n in some Makefile.

> [   13.358813][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [   13.361606][    T0] Speculative Store Bypass: Vulnerable
> [   13.363254][    T0] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> [   13.366836][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [   13.369877][    T0] debug: unmapping init [mem 0xffffffff8dd83000-0xffffffff8dd87fff]
> [   13.415028][    T1] ------------[ cut here ]------------
> [   13.416814][    T1] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
> [   13.416814][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4406 check_flags.part.26+0x102/0x240
> [   13.416814][    T1] Modules linked in:
> [   13.416814][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc2-next-20191220+ #4
> [   13.416814][    T1] Hardware name: HP ProLiant DL580 Gen9/ProLiant DL580 Gen9, BIOS U17 07/21/2016
> [   13.416814][    T1] RIP: 0010:check_flags.part.26+0x102/0x240
> [   13.416814][    T1] Code: bc 8d e8 51 a1 15 00 44 8b 05 2a a0 46 01 45 85 c0 0f 85 57 76 00 00 48 c7 c6 5d fa 7b 8d 48 c7 c7 b1 54 7b 8d e8 10 91 f5 ff <0f> 0b e9 3d 76 00 00 65 48 8b 3c 25 40 7f 01 00 e8 89 f0 ff ff e8
> [   13.416814][    T1] RSP: 0000:ffff9d3206287ce8 EFLAGS: 00010082
> [   13.416814][    T1] RAX: 0000000000000000 RBX: ffff8e5b8541e040 RCX: 0000000000000000
> [   13.416814][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> [   13.416814][    T1] RBP: ffff9d3206287cf0 R08: 0000000000000000 R09: 0000ffff8dbcc254
> [   13.416814][    T1] R10: 0000ffffffffffff R11: 0000ffff8dbcc257 R12: 0000000000000235
> [   13.416814][    T1] R13: 0000000000000000 R14: 0000000000000246 R15: 000000000000001b
> [   13.416814][    T1] FS:  0000000000000000(0000) GS:ffff8e61e3200000(0000) knlGS:0000000000000000
> [   13.416814][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.416814][    T1] CR2: ffff8e79f07ff000 CR3: 0000001284c0e001 CR4: 00000000003606f0
> [   13.416814][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   13.416814][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   13.416814][    T1] Call Trace:
> [   13.416814][    T1]  lock_is_held_type+0x66/0x160
> [   13.416814][    T1]  ___might_sleep+0xc1/0x1d0
> [   13.416814][    T1]  __might_sleep+0x5b/0xa0
> [   13.416814][    T1]  slab_pre_alloc_hook+0x7b/0xa0
> [   13.416814][    T1]  __kmalloc_node+0x60/0x300
> [   13.416814   T1]  ? alloc_cpumask_var_node+0x44/0x70
> [   13.416814][    T1]  ? topology_phys_to_logical_die+0x7e/0x180
> [   13.416814][    T1]  alloc_cpumask_var_node+0x44/0x70
> [   13.416814][    T1]  zalloc_cpumask_var+0x2a/0x40
> [   13.416814][    T1]  native_smp_prepare_cpus+0x246/0x425
> [   13.416814][    T1]  kernel_init_freeable+0x1b8/0x496
> [   13.416814][    T1]  ? rest_init+0x381/0x381
> [   13.416814][    T1]  kernel_init+0x18/0x17f
> [   13.416814][    T1]  ? rest_init+0x381/0x381
> [   13.416814][    T1]  ret_from_fork+0x3a/0x50
> [   13.416814][    T1] irq event stamp: 910
> [   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f3>] _raw_write_unlock_irqrestore+0x53/0x57
> [   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba76>] kcsan_setup_watchpoint+0x96/0x460
> [   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>] copy_process+0x11fa/0x34f0
> [   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   13.416814][    T1] ---[ end trace 7d1df66da055aa92 ]---
> [   13.416814][    T1] possible reason: unannotated irqs-on.
> [   13.416814][ent stamp: 910
> [   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f3>] _raw_write_unlock_irqrestore+0x53/0x57
> [   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba76>] kcsan_setup_watchpoint+0x96/0x460
> [   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>] copy_process+0x11fa/0x34f0
> [   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>] 0x0
>
>
> The other issue is that the system is unable to boot due to endless of those messages.

Apart from fixing the data races, I can add a feature to KCSAN to
limit reporting too often (will send patch).

> [   17.976814][  T578] Reported by Kernel Concurrency Sanitizer on:
> [   17.976814][  T578] CPU: 12 PID: 578 Comm: pgdatinit1 Tainted: G        W         5.5.0-rc2-next-20191220+ #4
> [   17.976814][  T578] Hardware name: HP ProLiant DL580 Gen9/ProLiant DL580 Gen9, BIOS U17 07/21/2016
> [   17.976814][  T578] ==================================================================
> [   17.976814][  T578] ==================================================================
> [   17.976814][  T578] BUG: KCSAN: data-race in __change_page_attr / __change_page_attr
> [   17.976814][  T578]
> [   17.976814][  T578] write to 0xffffffff8dda0de0 of 8 bytes by task 577 on cpu 2:
> [   17.976814][  T578]  __change_page_attr+0xef7/0x16a0
> [   17.976814][  T578]  __change_page_attr_set_clr+0xec/0x4f0
> [   17.97681pages_np+0xcc/0x100
> [   17.976814][  T578]  __kernel_map_pages+0xd6/0xdb
> [   17.976814][  T578]  __free_pages_ok+0x1a8/0x730
> [   17.976814][  T578]  __free_pages+0x51/0x90
> [   17.976814][  T578]  __free_pages_core+0x1c7/0x2c0
> [   17.976814][  T578]  deferred_free_range+0x59/0x8f
> [   17.976814][  T578]  deferred_init_maxorder+0x1d6/0x21d
> [   17.976814][  T578]  deferred_init_memmap+0x14a/0x1c1
> [   17.976814][  T578]  kthread+0x1e0/0x200
> [   17.976814][  T578]  ret_from_fork+0x3a/0x50
> [   17.976814][  T578]
> [   17.976814][  T578] read to 0xffffffff8dda0de0 of 8 bytes by task 578 on cpu 12:
> [   17.976814][  T578]  __change_page_attr+0xed1/0x16a0
> [   17.976814][  T578]  __change_page_attr_set_clr+0xec/0x4f0
> [   17.976814][  T578]  __set_pages_np+0xcc/0x100
> [   17.976814][  T578]  __kernel_map_pages+0xd6/0xdb
> [   17.976814][  T578]  __free_pages_ok+0x1a8/0x730
> [   17.976814][  T578]  __free_pages+0x51/0x90
> [   17.976814][  T578]  __free_pages_core+0x1c7/0x2c0
> [   17.976814][  T578]  deferred_free_range+0x59/0x8f
> [   17.976814][  T578]  deferred_init_maxorder+0x1aa/0x21d
> [   17.976814][  T578]  deferred_init_memmap+0x14a/0x1c1
> [   17.976814][  T578]  kthread+0x1e0/0x200
> [   17.976814][  T578]  ret_from_fork+0x3a/0x50
>
> # ./scripts/faddr2line vmlinux __change_page_attr+0xef7/0x16a0
> __change_page_attr+0xef7/0x16a0:
> static_protections at arch/x86/mm/pat/set_memory.c:528
> (inlined by) __change_page_attr at arch/x86/mm/pat/set_memory.c:1516
>
> # ./scripts/faddr2line vmlinux __change_page_attr+0xed1/0x16a0
> __change_page_attr+0xed1/0x16a0:
> cpa_inc_4k_install at arch/x86/mm/pat/set_memory.c:131
> (inlined by) __change_page_attr at arch/x86/mm/pat/set_memory.c:1514

Thanks,
-- Marco
