Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C70DAF52
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439877AbfJQON3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:13:29 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55623 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQON3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:29 -0400
Received: by mail-qk1-f201.google.com with SMTP id q80so2185816qke.22
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ahMy3naCKZUNeyQrUsfvkWdO2IwHI3ehg2cI/CL0H68=;
        b=E3NOAAWoSp5dTlcTqruPb+cH4PFuBjXLsewnlVjecfeBooxgaCsyFAL8vBl4YeNT20
         YoLFJaTQQjJxVpax9nNayHjSAHQWsOgddwQzwVv9JYC2Au2zuxFrCmfiSl9eCwPUjiB/
         pk3jnb5D0FkO31sy7aMLhRtuJadpGsEwRytCDgR6jcXDBDOxJjFs0dwm0FdaDrDknV8x
         iZ4CEs9UkGQdbcr+x9W6pe8+HRjM1yuiBP8veMvjpf/zMPwj8nV1oMSQ5FPQT9RSoE+Q
         ZKOXMtWQzET90Ll9U8y/HRyW7pSXTSbMg792SlUvduaz7O4I5Ec1BPXkNa7CJ+bB12Z9
         42Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ahMy3naCKZUNeyQrUsfvkWdO2IwHI3ehg2cI/CL0H68=;
        b=ieK+PgO/EG44fnKNuXQXi9uIQ2SYknxAeOCSLKAetaDY9+/l2wqzIcF3w+DGZaWwC0
         NICzQf5j4UJrjwTH38vfBjGcTMY8DlcPtQ1SRlmWwGb9U2+tb2ImqNtSyuN080kBMvGf
         csIR+odVyMPy95NqpSJsf74gGNnze10jWHgXPXj7ZxG3Y6KjUw59ugMNsczrkwnLe7qJ
         LLrPgHc/KY3mDcBupHNGOQs8oUZ3FMbkdFbv0tnCsIwamRzYYrkZnl1n+1XCAczqHTJG
         bnNLsSFxgeXxTwBd0r6zO/8OHv39hd0jFbMdv0qapox4KkSEagTxNK6uLwzzqps8N6b1
         HHGw==
X-Gm-Message-State: APjAAAUbojC7HCl8iXsRQmqKGRgG6EhxPOv9ayEfOtmVBntxxRy7Ui08
        R1c1n3Wdpy7kqA6tgtC7jNZA4FsoFQ==
X-Google-Smtp-Source: APXvYqxtX9ypXjB03uUDF7iJQHTkx8t43nT/o1OPlwEgu5Pcb4Oyr25eGL9asgyz9sNtX0vCtLKQRCysMg==
X-Received: by 2002:ac8:1903:: with SMTP id t3mr4137772qtj.344.1571321605784;
 Thu, 17 Oct 2019 07:13:25 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:12:57 +0200
Message-Id: <20191017141305.146193-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/8] Add Kernel Concurrency Sanitizer (KCSAN)
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
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
KCSAN is a sampling watchpoint-based data-race detector. More details
are included in Documentation/dev-tools/kcsan.rst. This patch-series
only enables KCSAN for x86, but we expect adding support for other
architectures is relatively straightforward (we are aware of
experimental ARM64 and POWER support).

To gather early feedback, we announced KCSAN back in September, and
have integrated the feedback where possible:
http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com

We want to point out and acknowledge the work surrounding the LKMM,
including several articles that motivate why data-races are dangerous
[1, 2], justifying a data-race detector such as KCSAN.
[1] https://lwn.net/Articles/793253/
[2] https://lwn.net/Articles/799218/

The current list of known upstream fixes for data-races found by KCSAN
can be found here:
https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

Changelog
---------
v2:
* Elaborate comment about instrumentation calls emitted by compilers.
* Replace kcsan_check_access(.., {true, false}) with
  kcsan_check_{read,write} for improved readability.
* Introduce __atomic_check_{read,write} in atomic-instrumented.h [Suggested by
  Mark Rutland].
* Change bug title of race of unknown origin to just say "data-race in".
* Refine "Key Properties" in kcsan.rst, and mention observed slow-down.
* Add comment about safety of find_watchpoint without user_access_save.
* Remove unnecessary preempt_disable/enable and elaborate on comment why
  we want to disable interrupts and preemptions.
* Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
  contexts [Suggested by Mark Rutland].
* Document x86 build exceptions where no previous above comment
  explained why we cannot instrument.

v1: http://lkml.kernel.org/r/20191016083959.186860-1-elver@google.com


Marco Elver (8):
  kcsan: Add Kernel Concurrency Sanitizer infrastructure
  objtool, kcsan: Add KCSAN runtime functions to whitelist
  build, kcsan: Add KCSAN build exceptions
  seqlock, kcsan: Add annotations for KCSAN
  seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
  asm-generic, kcsan: Add KCSAN instrumentation for bitops
  locking/atomics, kcsan: Add KCSAN instrumentation
  x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/kcsan.rst         | 203 ++++++++++
 MAINTAINERS                               |  11 +
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   2 +
 arch/x86/boot/compressed/Makefile         |   2 +
 arch/x86/entry/vdso/Makefile              |   3 +
 arch/x86/include/asm/bitops.h             |   6 +-
 arch/x86/kernel/Makefile                  |   7 +
 arch/x86/kernel/cpu/Makefile              |   3 +
 arch/x86/lib/Makefile                     |   4 +
 arch/x86/mm/Makefile                      |   3 +
 arch/x86/purgatory/Makefile               |   2 +
 arch/x86/realmode/Makefile                |   3 +
 arch/x86/realmode/rm/Makefile             |   3 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 include/asm-generic/atomic-instrumented.h | 393 ++++++++++----------
 include/asm-generic/bitops-instrumented.h |  18 +
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  35 +-
 include/linux/kcsan-checks.h              | 147 ++++++++
 include/linux/kcsan.h                     | 108 ++++++
 include/linux/sched.h                     |   4 +
 include/linux/seqlock.h                   |  51 ++-
 init/init_task.c                          |   8 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  14 +
 kernel/kcsan/atomic.c                     |  21 ++
 kernel/kcsan/core.c                       | 428 ++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 225 ++++++++++++
 kernel/kcsan/encoding.h                   |  94 +++++
 kernel/kcsan/kcsan.c                      |  86 +++++
 kernel/kcsan/kcsan.h                      | 140 +++++++
 kernel/kcsan/report.c                     | 306 ++++++++++++++++
 kernel/kcsan/test.c                       | 117 ++++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         |  88 +++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 tools/objtool/check.c                     |  17 +
 46 files changed, 2428 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.c
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.c
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan

-- 
2.23.0.866.gb869b98d4c-goog

