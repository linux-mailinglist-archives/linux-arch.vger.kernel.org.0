Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888B4632E3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhK3Lss (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbhK3Lsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:45 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E3C061746
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:26 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso13627717wmb.0
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rG1xNdPiM+b/19SfERFIEiLMABj+g1AA81VAk56ezfY=;
        b=P81cETHjfxAPwcXjxLEZoAKIClsMw0V0wD96HhwxcWsW+J35pjN4VZotJ0h51Pevyb
         G+wsHCsj6PaNbXpEzOb+mwsLQcl2U089MyHL5XWXa0CuIbGa89sbqWRlYWYT+qYvMhrF
         OQdjMifbE8i9BvuU784f2inF6Z6ZkIaBuprMWhQC/UYSsgI3wtWUrwHOwIa/Leqtefqq
         sJWWJfRoQx4l/22qMAsurBMJur+PevDjruCtLeW8hjawcRo+ERNcdhJWQv9EgGpMpM5H
         QtYhGhCW2Is32Dsg/YCLDxGCqA2Rh3TbFJUS8FeoHPV7CTCKP6M5fnXqNhK7KJioPWII
         h1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rG1xNdPiM+b/19SfERFIEiLMABj+g1AA81VAk56ezfY=;
        b=VT7ZIdiFlsbCMPTB1zLZBzALuBMGrHVw+JKppQyGAKs8P+LoEseOGQHDpi8qiNGvn5
         VV9wcpVizKg2tBP6h5WK25pP6UL2yW6KAaCqnXB2WRKz72sh/7qaBZEH/fRPR03RmhPf
         Nu7UqBRbXPIhTa8RVSgINOhwGqXaUURfKhTiRr5axhx4x6g3cqWebKgfjrKqojaINAKp
         yeFhbmlF1GZ5JsCVCgdyBMC798eQxrPTpYZrvEZLK0R9+XJ6bp9aBf2CbL6V3UWe4/RP
         Ykd8bAaK1VeonwA+XHOYZe3Y+Q+S0N4bgXCrhO9h+9Dbd9ysizyj+lT9O7kJzsYjWgkJ
         eq8Q==
X-Gm-Message-State: AOAM532AUP8TZt+ptJg066ednXwsYMPpLNOd5ZWCAPlLe/D43nsSqXwT
        Jz2TF2n90/b3eAFtd3FA3iAee6okTQ==
X-Google-Smtp-Source: ABdhPJxbkloraurf0oEulH3ag6+7yY6BzRbHK2TeZCzdaSdJW7S6qqAtdeXCdcM3HaCBmlZIxfVSP6YzOA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:adf:f0c8:: with SMTP id x8mr41133135wro.290.1638272725050;
 Tue, 30 Nov 2021 03:45:25 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:17 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-10-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 09/25] kcsan: Document modeling of weak memory
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
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Document how KCSAN models a subset of weak memory and the subset of
missing memory barriers it can detect as a result.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Note the reason that address or control dependencies do not require
  special handling.
---
 Documentation/dev-tools/kcsan.rst | 76 +++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 7db43c7c09b8..3ae866dcc924 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -204,17 +204,17 @@ Ultimately this allows to determine the possible executions of concurrent code,
 and if that code is free from data races.
 
 KCSAN is aware of *marked atomic operations* (``READ_ONCE``, ``WRITE_ONCE``,
-``atomic_*``, etc.), but is oblivious of any ordering guarantees and simply
-assumes that memory barriers are placed correctly. In other words, KCSAN
-assumes that as long as a plain access is not observed to race with another
-conflicting access, memory operations are correctly ordered.
-
-This means that KCSAN will not report *potential* data races due to missing
-memory ordering. Developers should therefore carefully consider the required
-memory ordering requirements that remain unchecked. If, however, missing
-memory ordering (that is observable with a particular compiler and
-architecture) leads to an observable data race (e.g. entering a critical
-section erroneously), KCSAN would report the resulting data race.
+``atomic_*``, etc.), and a subset of ordering guarantees implied by memory
+barriers. With ``CONFIG_KCSAN_WEAK_MEMORY=y``, KCSAN models load or store
+buffering, and can detect missing ``smp_mb()``, ``smp_wmb()``, ``smp_rmb()``,
+``smp_store_release()``, and all ``atomic_*`` operations with equivalent
+implied barriers.
+
+Note, KCSAN will not report all data races due to missing memory ordering,
+specifically where a memory barrier would be required to prohibit subsequent
+memory operation from reordering before the barrier. Developers should
+therefore carefully consider the required memory ordering requirements that
+remain unchecked.
 
 Race Detection Beyond Data Races
 --------------------------------
@@ -268,6 +268,56 @@ marked operations, if all accesses to a variable that is accessed concurrently
 are properly marked, KCSAN will never trigger a watchpoint and therefore never
 report the accesses.
 
+Modeling Weak Memory
+~~~~~~~~~~~~~~~~~~~~
+
+KCSAN's approach to detecting data races due to missing memory barriers is
+based on modeling access reordering (with ``CONFIG_KCSAN_WEAK_MEMORY=y``).
+Each plain memory access for which a watchpoint is set up, is also selected for
+simulated reordering within the scope of its function (at most 1 in-flight
+access).
+
+Once an access has been selected for reordering, it is checked along every
+other access until the end of the function scope. If an appropriate memory
+barrier is encountered, the access will no longer be considered for simulated
+reordering.
+
+When the result of a memory operation should be ordered by a barrier, KCSAN can
+then detect data races where the conflict only occurs as a result of a missing
+barrier. Consider the example::
+
+    int x, flag;
+    void T1(void)
+    {
+        x = 1;                  // data race!
+        WRITE_ONCE(flag, 1);    // correct: smp_store_release(&flag, 1)
+    }
+    void T2(void)
+    {
+        while (!READ_ONCE(flag));   // correct: smp_load_acquire(&flag)
+        ... = x;                    // data race!
+    }
+
+When weak memory modeling is enabled, KCSAN can consider ``x`` in ``T1`` for
+simulated reordering. After the write of ``flag``, ``x`` is again checked for
+concurrent accesses: because ``T2`` is able to proceed after the write of
+``flag``, a data race is detected. With the correct barriers in place, ``x``
+would not be considered for reordering after the proper release of ``flag``,
+and no data race would be detected.
+
+Deliberate trade-offs in complexity but also practical limitations mean only a
+subset of data races due to missing memory barriers can be detected. With
+currently available compiler support, the implementation is limited to modeling
+the effects of "buffering" (delaying accesses), since the runtime cannot
+"prefetch" accesses. Also recall that watchpoints are only set up for plain
+accesses, and the only access type for which KCSAN simulates reordering. This
+means reordering of marked accesses is not modeled.
+
+A consequence of the above is that acquire operations do not require barrier
+instrumentation (no prefetching). Furthermore, marked accesses introducing
+address or control dependencies do not require special handling (the marked
+access cannot be reordered, later dependent accesses cannot be prefetched).
+
 Key Properties
 ~~~~~~~~~~~~~~
 
@@ -290,8 +340,8 @@ Key Properties
 4. **Detects Racy Writes from Devices:** Due to checking data values upon
    setting up watchpoints, racy writes from devices can also be detected.
 
-5. **Memory Ordering:** KCSAN is *not* explicitly aware of the LKMM's ordering
-   rules; this may result in missed data races (false negatives).
+5. **Memory Ordering:** KCSAN is aware of only a subset of LKMM ordering rules;
+   this may result in missed data races (false negatives).
 
 6. **Analysis Accuracy:** For observed executions, due to using a sampling
    strategy, the analysis is *unsound* (false negatives possible), but aims to
-- 
2.34.0.rc2.393.gf8c9666880-goog

