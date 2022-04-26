Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768A751041D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353208AbiDZQtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353185AbiDZQso (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:44 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2716FD6
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:58 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id b33-20020a0565120ba100b004720174b354so3179063lfv.19
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QRr/YK4fONn3HTG8Fp9y+tnnWkzL1O1MoaFJezJL3sE=;
        b=GRtnB1LL/0WxvgZxxJD6lyURNXu6W8fs61POQbIbc0oumZ7k69NQoqD3tuCVl5yHj/
         Gx/zngh3XGQ7t3vv0vTrJzo1vEkQTQ/ZRo418CMleof5FGdj9l6StzKqWUtXQAScQwo5
         7P5qB/cvRckWW+BL+XiMdliFEO5yd4aWG7n9leQq17xa//Gzq2wBQTSCFsGG0JWGpu0+
         pqy91hZcYLp1jkzx4uiMbKUqjtEQl6oUHgMvxwlnBvwzVMZsM6AIx5QoYYlhWVc7tQxH
         mHkgIrHRenuJcacBwVLYMBUhS7EqeYlTJUvvLtw99sQakaUg4whscJWcJBjl5RDYQ691
         p17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QRr/YK4fONn3HTG8Fp9y+tnnWkzL1O1MoaFJezJL3sE=;
        b=Dg41FnFwePMeZ4dC1E42Vt/imPMAFFERquKDDL2xKmtBUbuZcK9BRFy7okJZ4nhpJP
         qsvcrNWK4RtfZgCHX4dG0T23ZaDTpKDt98pISh5/uyi5WvO2/tPbUMuMTNWclx/0gjS+
         tK5zGGnKj0uKuaCJvREFOVvoMP8txA24Crr5XQpMQuMpY9pKeIAYnGaTvJqtje01KNIP
         S+W3LttfUZEhiBhLkf5Xm5zo/ql8eVioxc8wX22n8Wd/XNdQWb0lMQQFHZtj+Q1BB9gg
         Fw3FUxTlOJRoMMDvdtgC/XPgsnoTMSgYlmU37NdBrsX2djjQ1QXf89gp3eCHtH02ekN2
         xBYg==
X-Gm-Message-State: AOAM533akRIF3IHe+vwH8sz0l/b05pqeg/oMxQcTg0A/2B+Sh3SwvlCg
        6LApalfR7vvldh/6WF8AU0Re7m2cGTA=
X-Google-Smtp-Source: ABdhPJxO/IzNek0yZm9+I1xLkkVDvFA7Rtx6U+bdK1jYJgO+mP11K/pbQde5ZHHXccF1PEslgOn1O7FKoX8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6512:104a:b0:471:f0c2:99ee with SMTP id
 c10-20020a056512104a00b00471f0c299eemr14014612lfb.142.1650991496992; Tue, 26
 Apr 2022 09:44:56 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:43 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-15-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 14/46] kmsan: disable instrumentation of unsupported common
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 847a82bfe0e3a..2a98e46479817 100644
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
index 6b9ffc1bd1eed..caeb55f661726 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

