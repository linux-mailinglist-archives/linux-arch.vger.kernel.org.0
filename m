Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD6D8B45
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391640AbfJPIlM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 04:41:12 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:55005 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391724AbfJPIlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:12 -0400
Received: by mail-wm1-f74.google.com with SMTP id g67so664722wmg.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IToO3TxaVYb6aPcdpP1nSr/83vwykcAUYMHrIbrPyZM=;
        b=bvnoMqX1QbYIiaLaOnBf6P75OThWz1ivuMxMGEARq3NxCSJ+Fp5ovc8mUyctAKbV9+
         0x8JxgVhIZcPWzSzL/8lez8bUvcQNX+Md4BUsE5TCxh7+0/3+YWfLBTxilKHr3DpUTOk
         mnMo0kiOJ48QAUSnHtn1K1gwA1BSeUcSVbWp1N5IMUZBbhD9h8eCgrrZ3inqJQdwJQMC
         KaUhLKPYbNdY0ooUMhr9GO67DbIY2AAiFnPVjxIKqAnkI9x0aqOWdR/PA2UWef+HriwL
         W68dazCkLZGO2SveHpLXcUgd1K2ZnTD5yBWVpy2KyEBd3QzX5XwHoF4fVaD/Oj19FTLG
         stmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IToO3TxaVYb6aPcdpP1nSr/83vwykcAUYMHrIbrPyZM=;
        b=mJW/yvjpkzrYHUgoaKt51x3VpXePR+LsH77XXtum7k7f2W8/23a3atEs/sx9JNSIYj
         ircw0+Md1EDHHJWI9jjs7plAOvIoVdQaR9HVbHfe+GBhC0b9k3Ds/BCEwj++C0nhX2Hw
         9KCAYAYozIlXliqPVc/R1LbdykY5fZzHG9gtydgyNhzAECi/ZVNdGKaqMIANsqkSVgkB
         ktrlggeRfz9lBBEWvRMiWiOWAlbhfTD2JKCS3M49APQBOhFGtRT+L0PXcpDojVV66M0K
         KLBntM4g8496I0jeqokrSs2qwC4rrGqF7rXvK42F1LZTanNClPtDaX0YktNu9BVwrney
         DhMQ==
X-Gm-Message-State: APjAAAWoYcVTp/KIexhoQK0FD9caKOazOv3ygzXzp25fK8CyYIsjxELa
        V8f7Bq4p2/k4Aho0Y6h6iBewoWwh9w==
X-Google-Smtp-Source: APXvYqyHvNTWgTxnCfClLrRto+zRyduNXbF6pzVpkyeF2JLNkWZbGCgN7GAHVojZ1Q6RPv4fAVI5ilkURw==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr1712303wrs.224.1571215267988;
 Wed, 16 Oct 2019 01:41:07 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:51 +0200
Message-Id: <20191016083959.186860-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 0/8] Add Kernel Concurrency Sanitizer (KCSAN)
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

Marco Elver (8):
  kcsan: Add Kernel Concurrency Sanitizer infrastructure
  objtool, kcsan: Add KCSAN runtime functions to whitelist
  build, kcsan: Add KCSAN build exceptions
  seqlock, kcsan: Add annotations for KCSAN
  seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
  asm-generic, kcsan: Add KCSAN instrumentation for bitops
  locking/atomics, kcsan: Add KCSAN instrumentation
  x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/kcsan.rst         | 202 ++++++++++
 MAINTAINERS                               |  11 +
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   1 +
 arch/x86/boot/compressed/Makefile         |   1 +
 arch/x86/entry/vdso/Makefile              |   1 +
 arch/x86/include/asm/bitops.h             |   2 +-
 arch/x86/kernel/Makefile                  |   6 +
 arch/x86/kernel/cpu/Makefile              |   3 +
 arch/x86/lib/Makefile                     |   2 +
 arch/x86/mm/Makefile                      |   3 +
 arch/x86/purgatory/Makefile               |   1 +
 arch/x86/realmode/Makefile                |   1 +
 arch/x86/realmode/rm/Makefile             |   1 +
 drivers/firmware/efi/libstub/Makefile     |   1 +
 include/asm-generic/atomic-instrumented.h | 192 ++++++++-
 include/asm-generic/bitops-instrumented.h |  18 +
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  35 +-
 include/linux/kcsan-checks.h              | 116 ++++++
 include/linux/kcsan.h                     |  85 ++++
 include/linux/sched.h                     |   7 +
 include/linux/seqlock.h                   |  51 ++-
 init/init_task.c                          |   6 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  14 +
 kernel/kcsan/atomic.c                     |  21 +
 kernel/kcsan/core.c                       | 458 ++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 225 +++++++++++
 kernel/kcsan/encoding.h                   |  94 +++++
 kernel/kcsan/kcsan.c                      |  81 ++++
 kernel/kcsan/kcsan.h                      | 140 +++++++
 kernel/kcsan/report.c                     | 307 +++++++++++++++
 kernel/kcsan/test.c                       | 117 ++++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         |  88 +++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |   9 +-
 tools/objtool/check.c                     |  17 +
 46 files changed, 2364 insertions(+), 16 deletions(-)
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
2.23.0.700.g56cf767bdb-goog

