Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF556354E
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiGAOZN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGAOYd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:24:33 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2403D1D9
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:50 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id m8-20020a2eb6c8000000b0025aa0530107so504256ljo.6
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=prMZkaWSelYFGUo1Yp0oSlk2FGuv/jH48kix0SjfSqo=;
        b=hUrPjZ5xQAK1rq1Z9VjevL+FrrINSG0tRRhgiAbMolgJVMWGIx4r5RfIMIwzpxc6ms
         gUg7hKctDb4wQE3VOaCHWIV2LGy5Ucp2ZAB7kF9GJdFo1NEyX0t952wecwLOOKno1+2E
         1rgmYSk4NtJQfzw9K/W+3BAffRewOQGfttd7giwJGo9MV8LuZwy/QsokSAd/dtQcFE3M
         z+L8uHLCgsAlvhMmnJc8Wq3E2JUFEG6y6kF7zDOvDO2SeAdTgKBtF3nkCOG4j2QwCqre
         z530iem10UaCweSv2liUUURMK8s4nPk+0u5brQ3OdzHhBaeQjctMcqzwscixL/Fwjs+v
         C1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=prMZkaWSelYFGUo1Yp0oSlk2FGuv/jH48kix0SjfSqo=;
        b=zwnGHfguvNPkVkBBQ595bjXPHqw/1tExBWU3yt1A2GkYRe1CHkQyrFvdSUNqEQlFaV
         Ixwq33TL8ngrkvt21x0ouf6iw5Jn/g90TYmaj/0T768xkJJKPggJU/Ms/o2+QB1T+54z
         MOEyzmvTt1QxrXM/miZ0jTFGgJGFV0j4QGkKe7PnDF01ueJUWDEwOqNimHiS7dQVZzi2
         nDud4T51sHPRwb5lTPoxbMplL++JKNR5cIbGTqbVsVXiMAWcMbIODmYUqRav/Rr/Mir7
         1rZU3Roos56mUNVnxTJFvGvFJyW+gtWr9axc0E59/tgVyjDY4KAsHb1MTEDJH+6V9JI4
         1rIQ==
X-Gm-Message-State: AJIora/LpaKJvKOqNdzB2lBMH+CvxohnwfN2+SNrY+obBrVrUaGouPkH
        BTcZODj18MxvvOZP9Sy15bG9BI6xbyA=
X-Google-Smtp-Source: AGRyM1tkPv2qxZS7ch8ZP9uL8wXLQqYDrfQpsgzEv2crKp3uD9M2y3fPjLDqyCgehGEb/p3HkajEMnoQMWA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6512:2622:b0:481:5b17:58e7 with SMTP id
 bt34-20020a056512262200b004815b1758e7mr2552760lfb.600.1656685428893; Fri, 01
 Jul 2022 07:23:48 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:37 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-13-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 12/45] kmsan: disable instrumentation of unsupported common
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
index a7e1f49ab2b3b..e47f0526c987f 100644
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
index f99bf61f8bbc6..5056769d00bb6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -272,6 +272,7 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 CFLAGS_stackdepot.o += -fno-builtin
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
+KMSAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
-- 
2.37.0.rc0.161.g10f37bed90-goog

