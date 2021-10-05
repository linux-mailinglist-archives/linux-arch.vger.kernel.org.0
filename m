Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77B422405
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJELBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhJELBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:01:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C94C06174E
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 03:59:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gi5-20020a056214248500b00382f7a7c7e6so3100043qvb.21
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7p97hglZNgfpwLYScP5gJSznCljkQgJf1oM6gC4sW1s=;
        b=C+l/ThvUROjSZj3WgNiRhFh/iKAes2tpTY59M3jBlJt1rMc1JuzxrSzdI6yfw+nSvX
         9/DIymhhEHv/WEyxbhbWp6jAdLJwcYr6ebOxFD9ffGEfKQWVutaM1kKYoOxqAzFCo0m+
         VUsJRx7fleGCq8czAZUq6m0rK4IcO2dl8DywRC2ZJOZtnaO/c5xvwp9pWEUmYYnfUWzD
         FTTrc8Np3ydXHObUwkrfxJDiJJK+oiVGXZhfP6huEaYO4eQnq0TTxJzBq51kvUjk3wyU
         AySN++yGjmq9dU838IWIdR+/E4kZSER9GqWlZzIDjO5G+k7pCP9aFNXp6pUC3NkimQ2D
         lY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7p97hglZNgfpwLYScP5gJSznCljkQgJf1oM6gC4sW1s=;
        b=rsyCZ/4wTpmdzLhGUyQKkbx+do6tg7uwjEa2TchBlXiboVZT9Yd+D3G169KGWT7PO1
         Mwzfv0MycpfbGiP+KUS9ke5HWU9/t9uqsdqX7gh5NdHRsM/38qjnK0twBIcf/SMdwCYR
         KHGOlae8eIqsCNgJImpJBp/tzwMhhO4kFHycZjxaLoUGFQN+9ODA16ksngnfYyA2JriX
         s73EREcz+H8b3gnFmMBPHRVGdQt+5UwefkZiWwizS9Gl9YogDepdIttM5/V5oFQhDJY7
         rEg3gDS138eekxK2i4trHIsEzdOmasQpfk/7DRz9ukm6kcwCVuBGm+5C347WNi3GMW5J
         2HUg==
X-Gm-Message-State: AOAM532wzGPiMBfTVYQ6PSoILU/dehqN4Oy2GhZm6USdqUMy6y9ioc5M
        6c8vBtyj3SdmWKUogUGMO+dBj7WeVw==
X-Google-Smtp-Source: ABdhPJxAJaG0cIPFEGzdLeaP0ICszNZi0oHL1XII6owt4EA7b097238oGaxzgagUHkjyFc9C5B3vYmiJxA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a0c:aa15:: with SMTP id d21mr26637930qvb.18.1633431583153;
 Tue, 05 Oct 2021 03:59:43 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:42 +0200
Message-Id: <20211005105905.1994700-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 00/23] kcsan: Support detecting a subset of missing
 memory barriers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
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

The series is rebased on -rcu/kcsan. The objtool patches currently
conflict with pending changes in -tip/objtool/core, which could be
separated from this series if needed.

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

 Documentation/dev-tools/kcsan.rst             |  72 ++-
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
 tools/objtool/check.c                         |  36 +-
 24 files changed, 1240 insertions(+), 172 deletions(-)

-- 
2.33.0.800.g4c38ced690-goog

