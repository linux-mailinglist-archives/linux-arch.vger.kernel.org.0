Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA496422442
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhJELC3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhJELCA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:02:00 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940DC061793
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:05 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so26708316qkd.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VR1v+uOEj5JHWgZG/AjKjsmQRdRMH76n4CGK16N25tc=;
        b=OOmVz5m9sgHxZ5tpr/f91NKUEC1uc9rMyBTH60E4A2rtnobKjQUKS5BS5vP0IphX4h
         wZwGLnUaMH/gItLkkn3k+udKE5o/pECwpdVoaNBrXEfthT0ThUaifj4RWj+cabsTGBGf
         l1ZHm1JhkDyaGdhfJDbvEYYUbwneLAxtPO0KzSK63NWqe69yIu5BETJMFPUjGr/reJ5p
         8C70N/BQQzpJJdfVViy3y/O1XL0IgkIsY0a+Rycv8smMQBb9va/r8WGrDJttmTTfKgVt
         P/LE7k6AHKligqpuKS3WqrmkDoaFPkHsV8/Gm5n/MWjw9huBNrITLIWi2bSp/lTViEvC
         YuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VR1v+uOEj5JHWgZG/AjKjsmQRdRMH76n4CGK16N25tc=;
        b=aZwAoRnsLGQ3gKiUB/G4pCMIVkilIYxJGcqrW/blSkjx+2wtTmkSSlAjqy5HgLyiPh
         khtIuY+GPiM8Tcs0wJKZw3oktHQN5ZGtESItr4hRCyL9mu98TZYqpnBRD+yidowxWB37
         xGbwhaDKRUuMwYUdVIL0ICrqIF1fEv5fagx/2ukoopzn3JyK8rtkG9dsUcTnQl2yZv1P
         njRDSD1jpcEbJwaDs8dUhKtMinWlgSZsqxEs8oDuzEAUq6JKBADOLQyG3XvKY9AWpImg
         OTcOvHtAcafV2mDGxpTN24zubPPG49cTE7m1Hle3MfnO2prQVMG56cEo7WDBmASxtKh+
         QSgw==
X-Gm-Message-State: AOAM530VMUusKnosNUxIBkANRMNhgbu9r+o+qj89Q2K+7Xkwo1QoqVHG
        DWm3j52QVAEwuVQynqXNAnJek7VsMQ==
X-Google-Smtp-Source: ABdhPJzKD6+pLzVxtocJ8QXUwjt+bDfPEzIrOBgSPHmtyTm0gDoWxM9bjjQ9uNCP0wR03odJaPoCD9G9MA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1022:: with SMTP id
 k2mr27293030qvr.53.1633431604158; Tue, 05 Oct 2021 04:00:04 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:51 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-10-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 09/23] kcsan: Document modeling of weak memory
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

Document how KCSAN models a subset of weak memory and the subset of
missing memory barriers it can detect as a result.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kcsan.rst | 72 +++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 7db43c7c09b8..4fc3773fead9 100644
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
@@ -268,6 +268,52 @@ marked operations, if all accesses to a variable that is accessed concurrently
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
+subset of data races due to missing memory barriers can be detected. Recall
+that watchpoints are only set up for plain accesses, and the only access type
+for which KCSAN simulates reordering. This means reordering of marked accesses
+is not modeled. Furthermore, with the currently available compiler support, the
+implementation is limited to modeling the effects of "buffering" (delaying
+accesses), since the runtime cannot "prefetch" accesses. One implication of
+this is that acquire operations do not require barrier instrumentation.
+
 Key Properties
 ~~~~~~~~~~~~~~
 
@@ -290,8 +336,8 @@ Key Properties
 4. **Detects Racy Writes from Devices:** Due to checking data values upon
    setting up watchpoints, racy writes from devices can also be detected.
 
-5. **Memory Ordering:** KCSAN is *not* explicitly aware of the LKMM's ordering
-   rules; this may result in missed data races (false negatives).
+5. **Memory Ordering:** KCSAN is aware of only a subset of LKMM ordering rules;
+   this may result in missed data races (false negatives).
 
 6. **Analysis Accuracy:** For observed executions, due to using a sampling
    strategy, the analysis is *unsound* (false negatives possible), but aims to
-- 
2.33.0.800.g4c38ced690-goog

