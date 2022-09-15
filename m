Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709DA5B9E3C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiIOPHN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiIOPFv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:05:51 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D086882
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:12 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so13537497ede.20
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7DSx6RI0rEPDhrbVIpPikNsWTzcR9RC7kojIoDN82TE=;
        b=Ei0ZOo1tqmI3niKdg+NjyFrYcuWag/zfWQm1yP23l3BnyrmeeyX9JElhu/ainPdOo+
         W/dywvadr04aecsU+ebZxNPOW9ICDqXTNUBOfu9kwz4f+GBrzmn4+l42PxeNQZxqW7qX
         Lc6kk/7HGejkAghJS9IEbkisG2lBRJSt45/r7bb7cF8xd11QNz4bx8M34JSwDTW4yhwt
         tJ78o05A6unsLVwF1wekgeIG4C2cUR1DKnuMtF3G53ElLkeVtM+TiQxtNlZWsycB4QVI
         EGJwbLtLFKkrnXnXXmVON0VvjQn5HAXmX0ge2JfPIbRLtNJmQD9OXFejAYW9ubOcI1mg
         OwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7DSx6RI0rEPDhrbVIpPikNsWTzcR9RC7kojIoDN82TE=;
        b=nR3ROKBH3217Rms3jliKRw+kGQoyk08ish8krTmSC3w1Hbn3UGaxshrpiqbBcTUGBz
         3E04uZWQb90ZdOJts9ymQjDtPemUjyCL9b9QlNrjMwhHtTrxYFIzKVLdJAgm+qRAeTA9
         X6PAqU7m/FBaK9LX21ceti1aluHGTtSmAWWJpxCMLGVwLXsLmjshdjiOU+2MlBMUNDMe
         RkDxVURb9bdyDvEJ0oyz50maolXHOnWclapBkfi1zvj6CcWiTa9Sp3SGH/gqhV6nrb2l
         UvBaVbM1r91eb7mKiDM64cTnxLm2aG4nbMEcsmvIkDtFGzpP1ZabSWeETA+QjRV1Mlqv
         F0JA==
X-Gm-Message-State: ACrzQf0xamCNqQdkskWByJVA/85T7KfuHGqZc1qyCsKwDHAcCcnQLHru
        MZlYgWm1TwfaxFosOg11SHtQaBhZ+CE=
X-Google-Smtp-Source: AMsMyM5UGtRZWEfRuSf8jc2keSvCdwG95jpOF1wSMEeWA1a/s2P04BTVQXHj5Bx/TIBtK5vybFlxr4pFIjQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:aa7:c74c:0:b0:44e:a7b9:d5c9 with SMTP id
 c12-20020aa7c74c000000b0044ea7b9d5c9mr264063eds.19.1663254311281; Thu, 15 Sep
 2022 08:05:11 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:46 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-13-glider@google.com>
Subject: [PATCH v7 12/43] kmsan: disable instrumentation of unsupported common
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
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 2c67f71f23753..2c1eb1fb0f226 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -53,6 +53,7 @@ GCOV_PROFILE			:= n
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
index ffabc30a27d4e..fcebece0f5b6f 100644
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
2.37.2.789.g6183377224-goog

