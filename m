Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC0EE249
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKDO2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 09:28:50 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:57163 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDO2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Nov 2019 09:28:50 -0500
Received: by mail-ua1-f74.google.com with SMTP id t13so2645927uaj.23
        for <linux-arch@vger.kernel.org>; Mon, 04 Nov 2019 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gOZJXriFYaJqnLiXWIeTvOu6TRK/57oj4m43E1U5Ltw=;
        b=iYeCrSfzcJoqpFfx6PikIHg8ccjBlymGJnP7hoPQwkYwjCtI9GxlmAhDNPMboxoTVO
         x0r3aGeA4Mh55fN74DlnnyoKLCP5EYtGoDRC1iJxDUrLjdkzWX2Z8xkzsuyteDFKdMu7
         j9QngGU+Lh7YFeOyuqjYfowPE5w4CorcRwYknePhBEWSRm/ggfZyx7vY8L6GGJvAE6n8
         QE3y+1uf000U7nWOZ0L0iV5yDzjIaUGAZazZh5REdGHMjOBwQujSQBLtL81TMYPnLLHX
         WF4N/P47ZjSdXzqhY+tOV7QPWdrBIiS+PKoKfUHodGpyf5G8hdYY2YVVFvpQ4MyVAoxn
         ATxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gOZJXriFYaJqnLiXWIeTvOu6TRK/57oj4m43E1U5Ltw=;
        b=c/C9QSqujL8WKvdO5+Gfk2RtZvxa+upCch91B9zyNA0RzILtqNqndq74VbHmE9Uape
         RJI2J6TPIKHuWKyujGaGpt8t76TbuaGbfZL9vMqEVvsg4JtSg/2kIpdBoIXbqWB/2qr0
         /xHhBQNrA6mFHfGf5IzLLMb6g6YUSEn5oxL+N62dWwKoqJPlUc/zt04tfLVrx7BXrtvn
         gJhxn4+G48yNBtjRXvTDA6/s/vyU35pw9P6g883YNXoGYh5EDd8IWWvFyKdtbKfIjYA2
         3+gNOm+5hb3KxxxAUfoitH3Z58QodeAFtU4g/uVM15jZlkyusTYbRyAGk/aX3TT6tvPk
         iSqQ==
X-Gm-Message-State: APjAAAV70zFTYaX031j/iG5SOuJ0gRXc2FV8gioI4FMY1zTMssTlghU6
        xD+4ROPkMWSOzgp8EVWwSe6aw5g3Hg==
X-Google-Smtp-Source: APXvYqzSuwLczAxwseRWbVJPz3W76r9RPcuLhjVcCaAZtkQCbfSRQ1gJrmSs8glOqHVw0BLDi5YUSOLJcQ==
X-Received: by 2002:a67:fbd9:: with SMTP id o25mr5000794vsr.70.1572877728570;
 Mon, 04 Nov 2019 06:28:48 -0800 (PST)
Date:   Mon,  4 Nov 2019 15:27:36 +0100
Message-Id: <20191104142745.14722-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3 0/9] Add Kernel Concurrency Sanitizer (KCSAN)
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
v3:
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

Marco Elver (9):
  kcsan: Add Kernel Concurrency Sanitizer infrastructure
  kcsan: Add Documentation entry in dev-tools
  objtool, kcsan: Add KCSAN runtime functions to whitelist
  build, kcsan: Add KCSAN build exceptions
  seqlock, kcsan: Add annotations for KCSAN
  seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
  asm-generic, kcsan: Add KCSAN instrumentation for bitops
  locking/atomics, kcsan: Add KCSAN instrumentation
  x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/index.rst         |   1 +
 Documentation/dev-tools/kcsan.rst         | 217 +++++++++
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
 include/asm-generic/atomic-instrumented.h | 393 +++++++--------
 include/asm-generic/bitops-instrumented.h |  18 +
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  35 +-
 include/linux/kcsan-checks.h              |  97 ++++
 include/linux/kcsan.h                     | 115 +++++
 include/linux/sched.h                     |   4 +
 include/linux/seqlock.h                   |  51 +-
 init/init_task.c                          |   8 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  11 +
 kernel/kcsan/atomic.h                     |  27 ++
 kernel/kcsan/core.c                       | 560 ++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 275 +++++++++++
 kernel/kcsan/encoding.h                   |  94 ++++
 kernel/kcsan/kcsan.h                      | 131 +++++
 kernel/kcsan/report.c                     | 306 ++++++++++++
 kernel/kcsan/test.c                       | 121 +++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         | 119 +++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 tools/objtool/check.c                     |  18 +
 46 files changed, 2526 insertions(+), 206 deletions(-)
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

