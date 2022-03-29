Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE14EAD5E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiC2Mnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiC2Mm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:59 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD5220B1C
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:11 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id c22-20020a50f616000000b004196649d144so10956528edn.10
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sAExT7SSSN10XTsfQtAC8lmzod9gG+fvZFiYZO+nEYE=;
        b=D6F1SQpsqCx29Z1hyC0VZ9QPHGSIXqGIXoKTX1t41Ec2/BI7aZiEaJshNZSDnAZ7nS
         N0yqCJQ1PeJoGgtRjd8nBmpux8LP0+eBYvj27cf5rvJF2ttWc9OSvKWGhvOFaPjbxaN2
         iLVvCLMm9/YCzNogYHden+UNUQUg7Gu8PKy6sCZn5PGrBo+vg4vbm5DyaR/Hu6lfTDxe
         bBZIR0eLro+O+0mwMGrZMyVEi8Yrq+V0gNiY+vIntbaE/O8ubQGR276mculXvjUvzEt3
         F9sCA4kDsGFBoicnwuxq29jXZYbDMu4MZup8guVtOlSWws6VucaX5kmprRui40j9NH5o
         h+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sAExT7SSSN10XTsfQtAC8lmzod9gG+fvZFiYZO+nEYE=;
        b=nwNfJFtGxH9SNweyRIA+b1LOUcq7Rjs5s1G5VHD45pkteT/In14yFAmIESlieGCW6F
         48Sp+ZDKqVCHmHZ5zdOhLD23PMsSdkzDS2exY1YPCb2CKAk3AwcOXnQH1fJIquU4VUrn
         n5y1013K0qFactxNXFJ2QO2RdS1noZHEUgoWFmJG489JdUCOhM3Z1IrrYo2WCAf+2OOR
         phvA3wnjx9AgLT+NAEwIsJUx92TtRvOkhrItovQFmoNVND/GYusm9O9vPcVw0Es9Jl7D
         z7p/+SphfBKYxyLlpbNZ3PGFJiazCQaR9JMX62PH3B2GU4wDklON8S6g0jz0wPh7VEEX
         fOFQ==
X-Gm-Message-State: AOAM533NXxu+7YjokHYBnXa9+rfIJCurDV7hbx5tFHAphaNnK/cg+iK0
        ZFFjAHYRRd7V4yJau1rB5Kp3Lr8Juss=
X-Google-Smtp-Source: ABdhPJxiJ9oKFDmYGNh7Br69DkPJpOkn+XAOKfovDuKDd9aMeedhy/6xJEB6s/tleVFOHEB0WVg/Meo2NMo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a05:6402:d69:b0:418:f7bd:b076 with SMTP id
 ec41-20020a0564020d6900b00418f7bdb076mr4306755edb.268.1648557669972; Tue, 29
 Mar 2022 05:41:09 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:44 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-16-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 15/48] kmsan: disable instrumentation of unsupported common
 kernel code
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

EFI stub cannot be linked with KMSAN runtime, so we disable
instrumentation for it.

Instrumenting kcov, stackdepot or lockdep leads to infinite recursion
caused by instrumentation hooks calling instrumented code again.

This patch was previously part of "kmsan: disable KMSAN instrumentation
for certain kernel parts", but was split away per Mark Rutland's
request.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I41ae706bd3474f074f6a870bfc3f0f90e9c720f7
---
 drivers/firmware/efi/libstub/Makefile | 1 +
 kernel/Makefile                       | 1 +
 kernel/locking/Makefile               | 3 ++-
 lib/Makefile                          | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e9..81432d0c904b1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -46,6 +46,7 @@ GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 56f4ee97f3284..80f6cfb60c020 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -39,6 +39,7 @@ KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
 UBSAN_SANITIZE_kcov.o := n
+KMSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
 # Don't instrument error handlers
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index d51cabf28f382..ea925731fa40f 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,8 +5,9 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
-# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
+# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
 KCSAN_SANITIZE_lockdep.o := n
+KMSAN_SANITIZE_lockdep.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b0..0ac9b38ec172e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -269,6 +269,7 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 CFLAGS_stackdepot.o += -fno-builtin
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
+KMSAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
-- 
2.35.1.1021.g381101b075-goog

