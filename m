Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D195A2AAF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiHZPK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiHZPJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:09:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CFDD75A
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dd097f993so29897827b3.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=mLlFYFB/rgc9qqJnOoWYqSqEWYlWfzhxjk78c+cLuAA=;
        b=XiFqi+HvFYWVKfCkxZSEvaLp4dj6PJCrtRX+y89NfMTPZ6+goUHOrJlaygaqkuIGBr
         cdc5TBzN75bo5l86pnTnW79iKtt96Ou0SDdJM2YIL9g3uoi3Job0DZK7q/nIm6l/tWpV
         UNDqvTKx+/6Oadm/ZjmMPEuU3raZ5GAff/rF0sMmJtdeCbxKEsKayU6Bd3s50LCPKUcZ
         oMZ+RIGrr0zlDQke70b2ZaiBxuU5QGWCP+5v5NfPFB1kpt3JEHHNKAiGV5LkFVztHN6G
         +Uh7pGeyKXy0VtS5AtzRj9P6HtYc37b8quRD9x2XVb1xZapp20z/LcMX0wNNYJelokgN
         IPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=mLlFYFB/rgc9qqJnOoWYqSqEWYlWfzhxjk78c+cLuAA=;
        b=fOTYzMBnfNdKH5ZEvdacTU7BEEYHyuCWnSgTqmnP882EoILTfRYrQ+YodE4H/n3W+l
         83f6NrvXITjj1FZuS/wkGLudvlTy4Am+yFWdwcbhktEfRzCmV/PfaetVyBfDTe4je3qY
         re8o7vK9ZkcUGPTkJxDl/7Qflomw1kNKD0C145YHJzZi/jM4tNEu0+0HHFKP86qw2hMd
         c/G3YhhckNrDcqgQe7cEdDB9nkzw74my8PMomGjuFbxqHVCnzEvB1OiIMoaHQXxcS5Nu
         zrjjhhIUXOm4LTCLi7WGRWjLdrOBmTfkq20cj4Cz8GqgmDxJ3ebVeu0VIsrQfpNDx2Sb
         /suQ==
X-Gm-Message-State: ACgBeo3SG4EBLSSwMZjY655kqB96sHm0c4ZcTBIpcXws2UwBowVvSlph
        bQ7V/NvZ3igmtwWUWRgfnrmZFY9NAXM=
X-Google-Smtp-Source: AA6agR57RONmOxoyPLmSyjKKyC9XY3IjUGI1gX8npn/cM8EWP8iDs6QDrjkGDieykAPqCJaWURQiX5dgMQY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a0d:f144:0:b0:33d:a554:b9b6 with SMTP id
 a65-20020a0df144000000b0033da554b9b6mr135036ywf.172.1661526526267; Fri, 26
 Aug 2022 08:08:46 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:35 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-13-glider@google.com>
Subject: [PATCH v5 12/44] kmsan: disable instrumentation of unsupported common
 kernel code
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
v4:
 -- This patch was previously part of "kmsan: disable KMSAN
    instrumentation for certain kernel parts", but was split away per
    Mark Rutland's request.

v5:
 -- remove unnecessary comment belonging to another patch

Link: https://linux-review.googlesource.com/id/I41ae706bd3474f074f6a870bfc3f0f90e9c720f7
---
 drivers/firmware/efi/libstub/Makefile | 1 +
 kernel/Makefile                       | 1 +
 kernel/locking/Makefile               | 3 ++-
 lib/Makefile                          | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

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
index 318789c728d32..d754e0be1176d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -38,6 +38,7 @@ KCOV_INSTRUMENT_kcov.o := n
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
index 5927d7fa08063..22c064b61b3be 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -275,6 +275,9 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 CFLAGS_stackdepot.o += -fno-builtin
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
+# In particular, instrumenting stackdepot.c with KMSAN will result in infinite
+# recursion.
+KMSAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
-- 
2.37.2.672.g94769d06f0-goog

