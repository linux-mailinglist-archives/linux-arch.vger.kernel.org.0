Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B456D45564F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbhKRIN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbhKRIN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:13:57 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE5C061570
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:10:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so2253831wmb.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Xzmo5mL9yKPgm1lZgxwsGIqYX+i9650OydzQnMolJjY=;
        b=qEJtN/DkSyckbRSxlIM9urYoLsb2hj7lFIxxPrdCEa/J11GugPm++lQKPAoPPA/En1
         HAagnvpvld0c59y1nXQoSdU28kF6v7drYbyhjp6FCwRLAsX/zbPyFI5xXRjX8rc1oGu3
         n5feY5KpUMjB4gzg7AMoJZWwyizpAXiugdaNx2kE2ILSDG1LgPsLdzEJCucQPCrvbhqd
         8Hkype+TRhQp2L++fjjiYl8j4BG4Hz1E9HM5WKmImoj0fMbgcitWazJ9QMo6GxkbtIlw
         YB4XpISSa3H3WuSWwlvkFRqnezzu26Jka/PzoDc7lqgYBOcl/r+/Uc4wFXuLaCec3va2
         H87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Xzmo5mL9yKPgm1lZgxwsGIqYX+i9650OydzQnMolJjY=;
        b=jaKARDnOUpkZrdg0e+WXypdh4Q/Xt7QrxDk3VPa0cGWNfI3HH603SIz0P2f6EXM+An
         HH7Xfc1WUvo66lwgOc8CJ1w/ROM8KnOWxi7OCWSTxNDnezAId4BntClHfRvk3kFxR8li
         FsWhDN7FopxdXd8cB52TdxyODkXpAhU46YZmMfzTYl12sPBX6B5LsIyozYnblsO8GMYF
         FZftoo/bkR+A4VC1WwhIX3zTniydMO3V7DCBOb0yc15VCLcpEzXZYyYDzQwXSlJSJlwY
         Txhhqu/TX/0UXJBEEy0UEWxSOxb6eCtgimBJKFMdE93nrfHB9pGBzEdjzbQg5Nh0acvv
         3JnA==
X-Gm-Message-State: AOAM5313aTHe02DZ0kLMX28+PhULApWYOAxp1CYc8TnlCBTyfUg+sxds
        siCYqspulVigT+k8xeKyZA4g3q5kzg==
X-Google-Smtp-Source: ABdhPJzf0beCDskxs6TLI9QKNEqbgr6M0bT4DWDT314iI+YiTOIk1FtVgaYUzMPaVpD7QqDDgrzhRBUpaw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a5d:4e52:: with SMTP id r18mr26521150wrt.224.1637223056499;
 Thu, 18 Nov 2021 00:10:56 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:04 +0100
Message-Id: <20211118081027.3175699-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 00/23] kcsan: Support detecting a subset of missing memory barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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
for some currently uninstrumented subsystems. The last two patches are
objtool changes to add the usual entries to the uaccess whitelist, but
also instruct objtool to remove memory barrier instrumentation from
noinstr code (on x86).

---

v2:
* Rewrite objtool patch after rebase to v5.16-rc1.
* Note the reason in documentation that address or control dependencies
  do not require special handling.
* Rename kcsan_atomic_release() to kcsan_atomic_builtin_memorder() to
  avoid confusion.
* Define kcsan_noinstr as noinline if we rely on objtool nop'ing out
  calls, to avoid things like LTO inlining it.

v1: https://lore.kernel.org/all/20211005105905.1994700-1-elver@google.com/

Marco Elver (23):
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

 Documentation/dev-tools/kcsan.rst             |  76 +++-
 arch/x86/include/asm/barrier.h                |  10 +-
 arch/x86/include/asm/qspinlock.h              |   1 +
 include/asm-generic/barrier.h                 |  54 ++-
 .../asm-generic/bitops/instrumented-atomic.h  |   3 +
 .../asm-generic/bitops/instrumented-lock.h    |   3 +
 include/linux/atomic/atomic-instrumented.h    | 135 +++++-
 include/linux/kcsan-checks.h                  |  51 ++-
 include/linux/kcsan.h                         |  11 +-
 include/linux/sched.h                         |   3 +
 include/linux/spinlock.h                      |   2 +-
 init/init_task.c                              |   9 +-
 kernel/kcsan/Makefile                         |   2 +
 kernel/kcsan/core.c                           | 326 +++++++++++---
 kernel/kcsan/kcsan_test.c                     | 416 ++++++++++++++++--
 kernel/kcsan/report.c                         |  51 ++-
 kernel/kcsan/selftest.c                       | 141 ++++++
 kernel/sched/Makefile                         |   7 +-
 lib/Kconfig.kcsan                             |  16 +
 mm/Makefile                                   |   2 +
 scripts/Makefile.kcsan                        |  15 +-
 scripts/Makefile.lib                          |   5 +
 scripts/atomic/gen-atomic-instrumented.sh     |  41 +-
 tools/objtool/check.c                         |  41 +-
 tools/objtool/include/objtool/elf.h           |   2 +-
 25 files changed, 1248 insertions(+), 175 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

