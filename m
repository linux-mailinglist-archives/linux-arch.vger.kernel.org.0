Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93D1FCC9B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKNSED (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 13:04:03 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:60303 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKNSEC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 13:04:02 -0500
Received: by mail-wm1-f74.google.com with SMTP id g14so4365047wmk.9
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1bg0Urry1BGwaxpDX8MHZFNgYP5IGRugkAlFUvPLa/I=;
        b=lr7v9t/b/nWB+oAlbYHlnG9ii8vIW9kKStfj1dl2F+rlYORyMHGnNhsdqh03G2C0//
         yZ5xgTbXsNNf3QwN0Qwga6q5nM/rxjeVaZ9U0zczdCT+0e79wzZS/U9XMus96cOP/QX/
         k+CVWVti+mZkubWF9QrVTJw5SEehpsKf4hZ7DQ09LIv3oofslpgizYbK8l6+ycIKA89x
         lJJ9GsqBG24Ur5vUOlwu59yaqPO0FZzn4qgShqmaoVE0Mt8y0BC4GS/WhwSSgu2zcAJI
         XG0iaZB3EWiAvVB2PFnjG7HFSd/bTbpARaMvFNvmSCEtNF2A9luiODjbY2pxefIlmYv8
         L4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1bg0Urry1BGwaxpDX8MHZFNgYP5IGRugkAlFUvPLa/I=;
        b=DF7B+Tv+GFO9033WJ615cWwTthAvOcBMgD8ByUF/Mib/FwFCKJwdUJz4qWQ8D6a2s8
         jOiOtROBmhib4Rpi+O8/kNd6qicKvsJTqP8fNd9y+6EQw+iNZQ3Z1TaXWIVi3+LNsVZ9
         hQDm095N899uvhOvof1FklGIsZK+uJ/UMa7ToOdWVXKAinjBTR5BvkPqECFpkk72/oE0
         EX+TVL8BfxjUD12UZF3mkS80vor78WpPvx5ggsabzEGrkm4GnTU2Kr7/Ykwh+AouD/jM
         pyCQELyzPmmbY9QvF0pFmA8SBy6dkrxfRJL++Ea0eAWD6lhALJTYXJucCLv9Oq4CrFIo
         Je+Q==
X-Gm-Message-State: APjAAAU+42qptec1U3E0qZdVdRb/HrBTcHyv6uRWaLaCg+8Tm8rHj5zh
        LPs1aEVFqcCDM5kt03r6221HOBDzUw==
X-Google-Smtp-Source: APXvYqyCRLhzabKP15Hc3I8tuyq3pOVGFzSfCNQc1mA04B8Z4nfTDX8KQ8VJZaVdt16PEvULqCx0tNT5ug==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr9720266wrq.134.1573754637105;
 Thu, 14 Nov 2019 10:03:57 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:02:53 +0100
Message-Id: <20191114180303.66955-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
From:   Marco Elver <elver@google.com>
To:     elver@google.com
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
KCSAN is a sampling watchpoint-based *data race detector*. More details
are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
only enables KCSAN for x86, but we expect adding support for other
architectures is relatively straightforward (we are aware of
experimental ARM64 and POWER support).

To gather early feedback, we announced KCSAN back in September, and have
integrated the feedback where possible:
http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com

The current list of known upstream fixes for data races found by KCSAN
can be found here:
https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

We want to point out and acknowledge the work surrounding the LKMM,
including several articles that motivate why data races are dangerous
[1, 2], justifying a data race detector such as KCSAN.

[1] https://lwn.net/Articles/793253/
[2] https://lwn.net/Articles/799218/

Race conditions vs. data races
------------------------------

Race conditions are logic bugs, where unexpected interleaving of racing
concurrent operations result in an erroneous state.

Data races on the other hand are defined at the *memory model/language
level*.  Many data races are also harmful race conditions, which a tool
like KCSAN reports!  However, not all data races are race conditions and
vice-versa.  KCSAN's intent is to report data races according to the
LKMM. A data race detector can only work at the memory model/language
level.

Deeper analysis, to find high-level race conditions only, requires
conveying the intended kernel logic to a tool. This requires (1) the
developer writing a specification or model of their code, and then (2)
the tool verifying that the implementation matches. This has been done
for small bits of code using model checkers and other formal methods,
but does not scale to the level of what can be covered with a dynamic
analysis based data race detector such as KCSAN.

For reasons outlined in [1, 2], data races can be much more subtle, but
can cause no less harm than high-level race conditions.

Changelog
---------
v4:
* Major changes:
 - Optimizations resulting in performance improvement of 33% (on
   microbenchmark).
 - Deal with nested interrupts for atomic_next.
 - Simplify report.c (removing double-locking as well), in preparation
   for KCSAN_REPORT_VALUE_CHANGE_ONLY.
 - Add patch to introduce "data_race(expr)" macro.
 - Introduce KCSAN_REPORT_VALUE_CHANGE_ONLY option for further filtering of data
   races: if a conflicting write was observed via a watchpoint, only report the
   data race if a value change was observed as well. The option will be enabled
   by default on syzbot. (rcu-functions will be excluded from this filter at
   request of Paul McKenney.) Context:
   http://lkml.kernel.org/r/CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com

v3: http://lkml.kernel.org/r/20191104142745.14722-1-elver@google.com
* Major changes:
 - Add microbenchmark.
 - Add instruction watchpoint skip randomization.
 - Refactor API and core runtime fast-path and slow-path. Compared to
   the previous version, with a default config and benchmarked using the
   added microbenchmark, this version is 3.8x faster.
 - Make __tsan_unaligned __alias of generic accesses.
 - Rename kcsan_{begin,end}_atomic ->
   kcsan_{nestable,flat}_atomic_{begin,end}
 - For filter list in debugfs.c use kmalloc+krealloc instead of
   kvmalloc.
 - Split Documentation into separate patch.

v2: http://lkml.kernel.org/r/20191017141305.146193-1-elver@google.com
* Major changes:
 - Replace kcsan_check_access(.., {true, false}) with
   kcsan_check_{read,write}.
 - Change atomic-instrumented.h to use __atomic_check_{read,write}.
 - Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
   contexts.

v1: http://lkml.kernel.org/r/20191016083959.186860-1-elver@google.com

Marco Elver (10):
  kcsan: Add Kernel Concurrency Sanitizer infrastructure
  include/linux/compiler.h: Introduce data_race(expr) macro
  kcsan: Add Documentation entry in dev-tools
  objtool, kcsan: Add KCSAN runtime functions to whitelist
  build, kcsan: Add KCSAN build exceptions
  seqlock, kcsan: Add annotations for KCSAN
  seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
  asm-generic, kcsan: Add KCSAN instrumentation for bitops
  locking/atomics, kcsan: Add KCSAN instrumentation
  x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/index.rst         |   1 +
 Documentation/dev-tools/kcsan.rst         | 256 +++++++++
 MAINTAINERS                               |  11 +
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   2 +
 arch/x86/boot/compressed/Makefile         |   2 +
 arch/x86/entry/vdso/Makefile              |   3 +
 arch/x86/include/asm/bitops.h             |   6 +-
 arch/x86/kernel/Makefile                  |   4 +
 arch/x86/kernel/cpu/Makefile              |   3 +
 arch/x86/lib/Makefile                     |   4 +
 arch/x86/mm/Makefile                      |   4 +
 arch/x86/purgatory/Makefile               |   2 +
 arch/x86/realmode/Makefile                |   3 +
 arch/x86/realmode/rm/Makefile             |   3 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 include/asm-generic/atomic-instrumented.h | 393 +++++++-------
 include/asm-generic/bitops-instrumented.h |  18 +
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  57 +-
 include/linux/kcsan-checks.h              |  97 ++++
 include/linux/kcsan.h                     | 115 ++++
 include/linux/sched.h                     |   4 +
 include/linux/seqlock.h                   |  51 +-
 init/init_task.c                          |   8 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  11 +
 kernel/kcsan/atomic.h                     |  27 +
 kernel/kcsan/core.c                       | 626 ++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 275 ++++++++++
 kernel/kcsan/encoding.h                   |  94 ++++
 kernel/kcsan/kcsan.h                      | 108 ++++
 kernel/kcsan/report.c                     | 320 +++++++++++
 kernel/kcsan/test.c                       | 121 +++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         | 118 ++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 tools/objtool/check.c                     |  18 +
 46 files changed, 2641 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

