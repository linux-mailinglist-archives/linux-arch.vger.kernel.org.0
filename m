Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC23102D00
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2019 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSTvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Nov 2019 14:51:06 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45846 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSTvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2019 14:51:05 -0500
Received: by mail-qv1-f67.google.com with SMTP id g12so8657157qvy.12
        for <linux-arch@vger.kernel.org>; Tue, 19 Nov 2019 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJkWiQS++k8drSI02mEHrqK7VAxEXqYSD3skFTgLnIk=;
        b=T1mhHDOSwFNvLSuuNxU346Rj4/TLbq4zqYQ4+phQee3AIsZik1mcHS4CpNzjfT1ENb
         M6Ro/jOUSTAeFYDEnMTN7jjNdbw+t5A3decKe5XgrR1ohw+3IUYa65Z4i/ePOjuYSH82
         aqhiOdx+eamWIdAf82f0cPmBCpPSZ4RUAW0VmKA9o9Ek74fe5sqE9gbPpIQU+o3MBpga
         B7pwywhkknVBDG36KdnzdcViFgg+c/9qvfRhutnGOp5a3SFyycJzRbFSf4Pz/qVp9rXO
         zrqaWM+NvsVMWya3d2XT+PwtocfxNCLKMikOCY9ziUSO6iTdPEiAPeZKEN6VI2nGpodm
         d7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJkWiQS++k8drSI02mEHrqK7VAxEXqYSD3skFTgLnIk=;
        b=dZhTHLjjXMOoe8g7/dCSm0QBiNdhoRzfxUXTZWF1KWXVPrV38RNpzGrVFuv9/5hwrm
         vAIL0vHdQEsZ8Uxag28puSaQDcHyfx8DZfFR3Xng7P7DIZR13/BCTIiGV4PXJ7Tc1MPG
         Gt0wF1fOUf/3XFRzeo2YNab2MzIXUu23et5IvpP7iAVya5knfQ67e9J0XoDL/+zOFDln
         1XBT+nZLJLnb+NL7QBwY5H079DrQTSJvGoEdlG87f9QJ9jsvzOjHfOrFN1vrHcR/pYun
         DMlhsAFds227jK+8Xqod2FPAcuyjCb+DTvuG86s4skjJs8na6XYg7jiX/PeirMIn6g1V
         Dxrg==
X-Gm-Message-State: APjAAAXAnb2YC9YA6xyXDsGvNye9fcS4Pj+3HSN8XPO9dIe2EpScCUsJ
        r/t0MxqYPlhyONvjrsd8URGJ2Q==
X-Google-Smtp-Source: APXvYqxxCAqo9RtGklNIbMoBFOzXnASLPiWGTquecJBf0e0W3gSp/u07oE4/fHgEJ0Rg0S68bdLdqA==
X-Received: by 2002:a0c:e847:: with SMTP id l7mr279965qvo.14.1574193064216;
        Tue, 19 Nov 2019 11:51:04 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y24sm10542040qki.104.2019.11.19.11.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:51:03 -0800 (PST)
Message-ID: <1574193059.9585.8.camel@lca.pw>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Date:   Tue, 19 Nov 2019 14:50:59 -0500
In-Reply-To: <20191114180303.66955-1-elver@google.com>
References: <20191114180303.66955-1-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
> This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> KCSAN is a sampling watchpoint-based *data race detector*. More details
> are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> only enables KCSAN for x86, but we expect adding support for other
> architectures is relatively straightforward (we are aware of
> experimental ARM64 and POWER support).

Just booting x86 systems because kcsan_setup_watchpoint() disabled hard irqs?

[    8.926145][    T0] ------------[ cut here ]------------
[    8.927850][    T0] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
[    80] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4406
check_flags.part.26+0x102/0x240
[    8.933072][    T0] Modules linked in:
[    8.933072][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc8-next-
20191119+ #2
[    8.933072][    T0] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
Gen9, BIOS U19 12/27/2015
[    8.933072][    T0] RIP: 0010:check_flags.part.26+0x102/0x240
[    8.933072][    T0] Code: 7b a2 e8 51 6d 15 00 44 8b 05 fa df 45 01 45 85 c0
0f 85 27 76 00 00 48 c7 c6 02 d6 3b a2 48 c7 c7 79 36 3b a2 e8 2f 9f f5 ff <0f>
e9 0d 76 00 00 65 48 8b 3c 25 40 3f 01 00 e8 89 f0 ff ff e8
[    8.933072][    T0] RSP: 0000:ffffffffa2603860 EFLAGS: 00010086
[    8.933072][    T0] RAX: 0000000000000000 RBX: ffffffffa2617b40 RCX:
0000000000000000
[    8.933072][    T0] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
0000000000000000
[    8.933072][    T0] RBP: ffffffffa2603868 R08: 0000000000000000 R09:
0000ffffa27bcad4
[    8.933072][    T0] R10: 0000ffffffffffff R11: 0000ffffa27bcad7 R12:
0000000000000168
[    8.933072][    T0] R13: 0000000000092cc0 R14: 0000000000000246 R15:
ffffffffa1664c89
[    8.933072][    T0] FS:  0000000000000000(0000) GS:ffff8987f3000000(0000)
knlGS:0000000000000000
[    8.933072][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.933072][    T0] CR2: ffff898bfc9ff000 CR3: 000000033dc0e001 CR4:
00000000001606f0
[    8.933072][    T0] Call Trace:
[    8.933072][    T0]  lock_is_held_type+0x66/0x13072][    T0]  ?
rcu_is_watching+0x79/0xa0
[    8.933072][    T0]  ? create_object+0x69/0x690
[    8.933072][    T0]  rcu_read_lock_sched_held+0x7f/0xa0
[    8.933072][    T0]  kmem_cache_alloc+0x3b2/0x420
[    8.933072][    T0]  ? create_object+0x69/0x690
[    8.933072][    T0]  create_object+0x69/0x690
[    8.933072][    T0]  ? find_next_bit+0x7b/0xa0
[    8.933072][    T0]  kmemleak_alloc_percpu+0xde/0x170
[    8.933072][    T0]  pcpu_alloc+0x683/0xc90
[    8.933072][    T0]  __alloc_percpu+0x2d/0x40
[    8.933072][    T0]  alloc_vfsmnt+0xd1/0x380
[    8.933072][    T0]  vfs_create_mount+0x7f/0x2e0
[    8.933072][    T0]  ? proc_get_tree+0x4d/0x60
[    8.933072][    T0]  fc_mount+0x6d/0x80
[    8.933072][    T0]  pid_ns_prepare_proc+0x133/0x190
[    8.933072][    T0]  alloc_pid+0x5c3/0x600
[    8.933072][    T0]  copy_process+0x1ca3/0x3480
[    8.933072][    T0]  ? __lock_acquire+0x739/0x25d0
[    8.933072][    T0]  _do_fork+0xaa/0x9c0
[    8.933072][    T0]  ? rcu_blocking_is_gp+0x83/0xb0
[    8.933072][    T0]  ? synchronize_rcu_expedited+0x80/0x6c0
[    8.933072][    T0]  ? rcu_blocking_is_gp+0x83/0xb0
[    8.933072][    T0]  ? rest_init+0x381/0x381
[    8.933072][    T0]  kernel_thread+0xb0/0xe0
[    8.933072][    T0]  ? rest_init+0x381/0x381
[    8.933072][    T0]  rest_init+0x31/0x381
[    8.933072][   st_init+0x17/0x29
[    8.933072][    T0]  start_kernel+0x6ac/0x6d0
[    8.933072][    T0]  x86_64_start_reservations+0x24/0x26
[    8.933072][    T0]  x86_64_start_kernel+0xef/0xf6
[    8.933072][    T0]  secondary_startup_64+0xb6/0xc0
[    8.933072][    T0] irq event stamp: 75594
[    8.933072][    T0] hardirqs last  enabled at (75593): [<ffffffffa1203d52>]
trace_hardirqs_on_thunk+0x1a/0x1c
[    8.933072][    T0] hardirqs last disabled at (75594): [<ffffffffa14b4f96>]
kcsan_setup_watchpoint+0x96/0x200
[    8.933072][    T0] softirqs last  enabled at (75592): [<ffffffffa200034c>]
__do_softirq+0x34c/0x57c
[    8.933072][    T0] softirqs last disabled at (75585): [<ffffffffa12c6fb2>]
irq_exit+0xa2/0xc0
[    8.933072][    T0] ---[ end trace f4a667495da45c20 ]---
[    8.933072][    T0] possible reason: unannotated irqs-on.
[    8.933072][    T0] irq event stamp: 75594
[    8.933072][    T0] hardirqs last  enabled at (75593): [<ffffffffa1203d52>]
trace_hardirqs_on_thunk+0x1a/0x1c
[    8.933072][    T0] hardirqs last disabled at (75594): [<ffffffffa14b4f96>]
kcsan_setup_watchpoint+0x96/0x200
[    8.933072][    T0] softirqs last  enabled at (75592): [<ffffffffa200034c>]
__do_softirq+0x34c/0x57c
[    8.933072][    T0] softirqs last disabled at (75585): [<ffffffffa12c6fb2>]
irq_exit+0xa2/0xc0


> 
> To gather early feedback, we announced KCSAN back in September, and have
> integrated the feedback where possible:
> http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> 
> The current list of known upstream fixes for data races found by KCSAN
> can be found here:
> https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> 
> We want to point out and acknowledge the work surrounding the LKMM,
> including several articles that motivate why data races are dangerous
> [1, 2], justifying a data race detector such as KCSAN.
> 
> [1] https://lwn.net/Articles/793253/
> [2] https://lwn.net/Articles/799218/
> 
> Race conditions vs. data races
> ------------------------------
> 
> Race conditions are logic bugs, where unexpected interleaving of racing
> concurrent operations result in an erroneous state.
> 
> Data races on the other hand are defined at the *memory model/language
> level*.  Many data races are also harmful race conditions, which a tool
> like KCSAN reports!  However, not all data races are race conditions and
> vice-versa.  KCSAN's intent is to report data races according to the
> LKMM. A data race detector can only work at the memory model/language
> level.
> 
> Deeper analysis, to find high-level race conditions only, requires
> conveying the intended kernel logic to a tool. This requires (1) the
> developer writing a specification or model of their code, and then (2)
> the tool verifying that the implementation matches. This has been done
> for small bits of code using model checkers and other formal methods,
> but does not scale to the level of what can be covered with a dynamic
> analysis based data race detector such as KCSAN.
> 
> For reasons outlined in [1, 2], data races can be much more subtle, but
> can cause no less harm than high-level race conditions.
> 
> Changelog
> ---------
> v4:
> * Major changes:
>  - Optimizations resulting in performance improvement of 33% (on
>    microbenchmark).
>  - Deal with nested interrupts for atomic_next.
>  - Simplify report.c (removing double-locking as well), in preparation
>    for KCSAN_REPORT_VALUE_CHANGE_ONLY.
>  - Add patch to introduce "data_race(expr)" macro.
>  - Introduce KCSAN_REPORT_VALUE_CHANGE_ONLY option for further filtering of data
>    races: if a conflicting write was observed via a watchpoint, only report the
>    data race if a value change was observed as well. The option will be enabled
>    by default on syzbot. (rcu-functions will be excluded from this filter at
>    request of Paul McKenney.) Context:
>    http://lkml.kernel.org/r/CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com
> 
> v3: http://lkml.kernel.org/r/20191104142745.14722-1-elver@google.com
> * Major changes:
>  - Add microbenchmark.
>  - Add instruction watchpoint skip randomization.
>  - Refactor API and core runtime fast-path and slow-path. Compared to
>    the previous version, with a default config and benchmarked using the
>    added microbenchmark, this version is 3.8x faster.
>  - Make __tsan_unaligned __alias of generic accesses.
>  - Rename kcsan_{begin,end}_atomic ->
>    kcsan_{nestable,flat}_atomic_{begin,end}
>  - For filter list in debugfs.c use kmalloc+krealloc instead of
>    kvmalloc.
>  - Split Documentation into separate patch.
> 
> v2: http://lkml.kernel.org/r/20191017141305.146193-1-elver@google.com
> * Major changes:
>  - Replace kcsan_check_access(.., {true, false}) with
>    kcsan_check_{read,write}.
>  - Change atomic-instrumented.h to use __atomic_check_{read,write}.
>  - Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
>    contexts.
> 
> v1: http://lkml.kernel.org/r/20191016083959.186860-1-elver@google.com
> 
> Marco Elver (10):
>   kcsan: Add Kernel Concurrency Sanitizer infrastructure
>   include/linux/compiler.h: Introduce data_race(expr) macro
>   kcsan: Add Documentation entry in dev-tools
>   objtool, kcsan: Add KCSAN runtime functions to whitelist
>   build, kcsan: Add KCSAN build exceptions
>   seqlock, kcsan: Add annotations for KCSAN
>   seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
>   asm-generic, kcsan: Add KCSAN instrumentation for bitops
>   locking/atomics, kcsan: Add KCSAN instrumentation
>   x86, kcsan: Enable KCSAN for x86
> 
>  Documentation/dev-tools/index.rst         |   1 +
>  Documentation/dev-tools/kcsan.rst         | 256 +++++++++
>  MAINTAINERS                               |  11 +
>  Makefile                                  |   3 +-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/boot/Makefile                    |   2 +
>  arch/x86/boot/compressed/Makefile         |   2 +
>  arch/x86/entry/vdso/Makefile              |   3 +
>  arch/x86/include/asm/bitops.h             |   6 +-
>  arch/x86/kernel/Makefile                  |   4 +
>  arch/x86/kernel/cpu/Makefile              |   3 +
>  arch/x86/lib/Makefile                     |   4 +
>  arch/x86/mm/Makefile                      |   4 +
>  arch/x86/purgatory/Makefile               |   2 +
>  arch/x86/realmode/Makefile                |   3 +
>  arch/x86/realmode/rm/Makefile             |   3 +
>  drivers/firmware/efi/libstub/Makefile     |   2 +
>  include/asm-generic/atomic-instrumented.h | 393 +++++++-------
>  include/asm-generic/bitops-instrumented.h |  18 +
>  include/linux/compiler-clang.h            |   9 +
>  include/linux/compiler-gcc.h              |   7 +
>  include/linux/compiler.h                  |  57 +-
>  include/linux/kcsan-checks.h              |  97 ++++
>  include/linux/kcsan.h                     | 115 ++++
>  include/linux/sched.h                     |   4 +
>  include/linux/seqlock.h                   |  51 +-
>  init/init_task.c                          |   8 +
>  init/main.c                               |   2 +
>  kernel/Makefile                           |   6 +
>  kernel/kcsan/Makefile                     |  11 +
>  kernel/kcsan/atomic.h                     |  27 +
>  kernel/kcsan/core.c                       | 626 ++++++++++++++++++++++
>  kernel/kcsan/debugfs.c                    | 275 ++++++++++
>  kernel/kcsan/encoding.h                   |  94 ++++
>  kernel/kcsan/kcsan.h                      | 108 ++++
>  kernel/kcsan/report.c                     | 320 +++++++++++
>  kernel/kcsan/test.c                       | 121 +++++
>  kernel/sched/Makefile                     |   6 +
>  lib/Kconfig.debug                         |   2 +
>  lib/Kconfig.kcsan                         | 118 ++++
>  lib/Makefile                              |   3 +
>  mm/Makefile                               |   8 +
>  scripts/Makefile.kcsan                    |   6 +
>  scripts/Makefile.lib                      |  10 +
>  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
>  tools/objtool/check.c                     |  18 +
>  46 files changed, 2641 insertions(+), 206 deletions(-)
>  create mode 100644 Documentation/dev-tools/kcsan.rst
>  create mode 100644 include/linux/kcsan-checks.h
>  create mode 100644 include/linux/kcsan.h
>  create mode 100644 kernel/kcsan/Makefile
>  create mode 100644 kernel/kcsan/atomic.h
>  create mode 100644 kernel/kcsan/core.c
>  create mode 100644 kernel/kcsan/debugfs.c
>  create mode 100644 kernel/kcsan/encoding.h
>  create mode 100644 kernel/kcsan/kcsan.h
>  create mode 100644 kernel/kcsan/report.c
>  create mode 100644 kernel/kcsan/test.c
>  create mode 100644 lib/Kconfig.kcsan
>  create mode 100644 scripts/Makefile.kcsan
> 
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
