Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1934632BA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhK3LsZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhK3LsX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:23 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8547C061574
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:03 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so3516622wrw.9
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bYDosMGyIXEijQF2/XlnbLPYOrdGKyrE1hTUivhL4CU=;
        b=IL7CAFvV6MtE2OUgCCV8gKKrIRN0WWgpmR+A9AiWqxQ9V07X4YbGspXtC5Hd1Y2PBx
         D56r1S35xreiSdxVc7okaLumpKcw9ekhsDPEZzvnsFxcAB/1fGP6xe6vCSOp5uZpTEYm
         V8auU9N5p5ITPQoGMY9SXWAC+bv3a2JXvpTRuW2dbPcZSHECt2QH4YQ7NmDVpaOwhxby
         N60ovNQ0ZF78ST/emszDmXo/s4EY+JaEW98RwrKa+ZGzLKp7tVPM5NSIU/FJSZizz2+N
         NkpHpEsWEVdTqVhcbsYdV0IghKGuBDGKbjH/qvuS0kBUt3A6YJrbWASj5vSoOFjTMx7v
         YM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bYDosMGyIXEijQF2/XlnbLPYOrdGKyrE1hTUivhL4CU=;
        b=xkqOnuul5O/Vs+SmR/hPQGzgA2IthB5gmjpFT695nmoJs46mwtK3Wj+8h6i31E/r2K
         RYL+y+gcex0azxK4P5ROotn07PSdmYWkEocX0DgonoMw53q7KTTHWQJnxe0eTrDrepCa
         6nIU62JFzH0KMcBR2NWC5Z3V8L6b+wm3t/mV8qCBbc6hE/3PU+rmy+ZIxZYoKceB8PvA
         umr3LxdavBIZDuqBL33UBxgQubWqiIzf/vX9wvbwJQ/XezWwt9jZ4kcHK7YTRndWFumt
         NkdyFBpLW8HClWHYCVdrtOnB11iPm2u1ZYe07yjElodZsQ07SPuxWKUIhXMRrOCdPGyI
         F2wQ==
X-Gm-Message-State: AOAM531gT/nbYLJlTyIuHmGfk89PQRvSaFagnUEMoqyUAOu1sPt9hpOw
        WrksH2kZ6dJaBz0krkUeZhzsG0J6sA==
X-Google-Smtp-Source: ABdhPJxo37bMpbLJAv1RXHu3LO+qFm4HjYlDQ0I+/1FSDhE4J1p/G9WrWi0KsSeZbN76Kzr82TRPoUL1zA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:1990:: with SMTP id
 t16mr4315850wmq.48.1638272702321; Tue, 30 Nov 2021 03:45:02 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:08 +0100
Message-Id: <20211130114433.2580590-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 00/25] kcsan: Support detecting a subset of missing memory barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Detection of some missing memory barriers has been on the KCSAN feature
wishlist for some time: this series adds support for modeling a subset
of weak memory as defined by the LKMM, which enables detection of a
subset of data races due to missing memory barriers.

KCSAN's approach to detecting missing memory barriers is based on
modeling access reordering. Each memory access for which a watchpoint is
set up, is also selected for simulated reordering within the scope of
its function (at most 1 in-flight access).

We are limited to modeling the effects of "buffering" (delaying the
access), since the runtime cannot "prefetch" accesses. Once an access
has been selected for reordering, it is checked along every other access
until the end of the function scope. If an appropriate memory barrier is
encountered, the access will no longer be considered for reordering.

When the result of a memory operation should be ordered by a barrier,
KCSAN can then detect data races where the conflict only occurs as a
result of a missing barrier due to reordering accesses.

Some more details and an example are captured in the updated
<Documentation/dev-tools/kcsan.rst>.

Some light fuzzing with the feature also resulted in a discussion [1]
around an issue which appears to be allowed, but unlikely in practice.

[1] https://lkml.kernel.org/r/YRo58c+JGOvec7tc@elver.google.com


The first half of the series are core KCSAN changes, documentation
updates, and test changes. The second half adds instrumentation to
barriers, atomics, bitops, along with enabling barrier instrumentation
for some currently uninstrumented subsystems.

Followed by objtool changes to add the usual entries to the uaccess
whitelist, but also instruct objtool to remove memory barrier
instrumentation from noinstr code (on x86), given not all versions of
Clang currently respect __no_kcsan (== __no_sanitize_thread) for the new
instrumentation.

The last 2 patches (new in v3) fix up __no_kcsan for newer versions of
Clang, so that non-x86 architectures can enable weak memory modeling
with Clang 14.0 or newer.

Changelog
---------

v3:
* Rework to avoid kcsan_noinstr hackery, because it is unclear if
  this works on architectures like arm64. A better alternative exists
  where we can get __no_kcsan to work for barrier instrumentation, too.
  Clang's and GCC's __no_kcsan (== __no_sanitize_thread) behave slightly
  differently, which is reflected in KCSAN_WEAK_MEMORY's dependencies
  (either STACK_VALIDATION for older Clang, or GCC which works as-is).
* Rework to avoid inserting explicit calls for barrier instrumentation,
  and instead repurpose __atomic_signal_fence (see comment at
  __tsan_atomic_signal_fence), which is handled by fsanitize=thread
  instrumentation and can therefore be removed via __no_kcsan.
* objtool: s/removable_instr/profiling_func/, and more comments per
  Josh's suggestion.
* Minimize diff in patch removing zero-initialization of globals.
* Don't define kcsan_weak_memory bool if !KCSAN_WEAK_MEMORY.
* Apply Acks.
* 2 new patches to make it work with Clang >= 14.0 without objtool,
  which will be required on non-x86 architectures.

v2: https://lkml.kernel.org/r/20211118081027.3175699-1-elver@google.com
* Rewrite objtool patch after rebase to v5.16-rc1.
* Note the reason in documentation that address or control dependencies
  do not require special handling.
* Rename kcsan_atomic_release() to kcsan_atomic_builtin_memorder() to
  avoid confusion.
* Define kcsan_noinstr as noinline if we rely on objtool nop'ing out
  calls, to avoid things like LTO inlining it.

v1: https://lore.kernel.org/all/20211005105905.1994700-1-elver@google.com/
---

Alexander Potapenko (1):
  compiler_attributes.h: Add __disable_sanitizer_instrumentation

Marco Elver (24):
  kcsan: Refactor reading of instrumented memory
  kcsan: Remove redundant zero-initialization of globals
  kcsan: Avoid checking scoped accesses from nested contexts
  kcsan: Add core support for a subset of weak memory modeling
  kcsan: Add core memory barrier instrumentation functions
  kcsan, kbuild: Add option for barrier instrumentation only
  kcsan: Call scoped accesses reordered in reports
  kcsan: Show location access was reordered to
  kcsan: Document modeling of weak memory
  kcsan: test: Match reordered or normal accesses
  kcsan: test: Add test cases for memory barrier instrumentation
  kcsan: Ignore GCC 11+ warnings about TSan runtime support
  kcsan: selftest: Add test case to check memory barrier instrumentation
  locking/barriers, kcsan: Add instrumentation for barriers
  locking/barriers, kcsan: Support generic instrumentation
  locking/atomics, kcsan: Add instrumentation for barriers
  asm-generic/bitops, kcsan: Add instrumentation for barriers
  x86/barriers, kcsan: Use generic instrumentation for non-smp barriers
  x86/qspinlock, kcsan: Instrument barrier of pv_queued_spin_unlock()
  mm, kcsan: Enable barrier instrumentation
  sched, kcsan: Enable memory barrier instrumentation
  objtool, kcsan: Add memory barrier instrumentation to whitelist
  objtool, kcsan: Remove memory barrier instrumentation from noinstr
  kcsan: Support WEAK_MEMORY with Clang where no objtool support exists

 Documentation/dev-tools/kcsan.rst             |  76 +++-
 arch/x86/include/asm/barrier.h                |  10 +-
 arch/x86/include/asm/qspinlock.h              |   1 +
 include/asm-generic/barrier.h                 |  54 ++-
 .../asm-generic/bitops/instrumented-atomic.h  |   3 +
 .../asm-generic/bitops/instrumented-lock.h    |   3 +
 include/linux/atomic/atomic-instrumented.h    | 135 +++++-
 include/linux/compiler_attributes.h           |  18 +
 include/linux/compiler_types.h                |  13 +-
 include/linux/kcsan-checks.h                  |  81 +++-
 include/linux/kcsan.h                         |  11 +-
 include/linux/sched.h                         |   3 +
 include/linux/spinlock.h                      |   2 +-
 init/init_task.c                              |   5 -
 kernel/kcsan/Makefile                         |   2 +
 kernel/kcsan/core.c                           | 345 ++++++++++++---
 kernel/kcsan/kcsan_test.c                     | 415 ++++++++++++++++--
 kernel/kcsan/report.c                         |  51 ++-
 kernel/kcsan/selftest.c                       | 141 ++++++
 kernel/sched/Makefile                         |   7 +-
 lib/Kconfig.kcsan                             |  20 +
 mm/Makefile                                   |   2 +
 scripts/Makefile.kcsan                        |  15 +-
 scripts/Makefile.lib                          |   5 +
 scripts/atomic/gen-atomic-instrumented.sh     |  41 +-
 tools/objtool/check.c                         |  41 +-
 tools/objtool/include/objtool/elf.h           |   2 +-
 27 files changed, 1330 insertions(+), 172 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

