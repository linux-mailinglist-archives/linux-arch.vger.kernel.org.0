Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF94EAD92
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiC2Mti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiC2Mr2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:47:28 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F5525C5A0
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:17 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso8126789ejj.4
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=06dyFy4NZEX890kyFUV8Iv1YE1gnoJOMR7Gzlteh8jY=;
        b=Q2viYIJcVvUQijU4U9D1Dj2AFiuH23Eb1Cg6kjs6VZINfQ//kbrjiRJ1yRFJzKaL95
         tQJlNRbpesfMyVc/wyOht/HynqAFff9Su6k44SSjUB8e2ASIhP69zbj05HIMXeK6L1OL
         ySYUfvObdacOc2wdAG0IyYrl2RHLnydnHHmfzRRrcKEWnpWTcd8jHV+TE7DNEa1UCekz
         6KJVzVYtGJ3IVan1hIEN3NujxMnzK82nblY1rg0IK6jZi+5p1Rf4+CXyXuOLIkxIKFLO
         1LM1HLYTxGIOL5VXdKr2d8uHtUFahOWpwBd/6N2sHJ5/7Wh6V+e3Ncbzfm+da1hhXAXU
         5dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=06dyFy4NZEX890kyFUV8Iv1YE1gnoJOMR7Gzlteh8jY=;
        b=bfcQiGAPuenDoi8Ckc8esl+dGyRUrPpmxFguzvCEUPYmLdltOJI6XPvriBtW1ou2a2
         ZtQwzmK84gRX62A0S0dy9R1DA1y4dAe2xZkeIQ730UbZMT7f+ovibMrbWVPaUqq3/gke
         Pd8xWpKuSqtUdR50jGZ+ZQaJZCB2LKLW8qYWuvczBOQUC6P3Gm1RbH+2cAyfdqMpQBbX
         QNuEyCpgjZFkL+KzLCu9n3WkqRl8PX8OFDrStN/kXeZ6ZG9e7O2RvTJUHLXwp0v2RG0Q
         Vfml/yJ6n91FS4FYoQhc9YmJduLz5lmdEzDFX7oinolLbUhti2Z79rMXFHtlrvi9AWOq
         xE1A==
X-Gm-Message-State: AOAM532nq1iDrq8mN5qMtcpBSYmcgmkmP9JLIXfP1oI3rjvCI72qGgUa
        lnxoX1L4+G/7/KfIFXhZlGSbbRHNyTg=
X-Google-Smtp-Source: ABdhPJyK+xCDqG5EBgv8UrRhuZ4ui8rzuRpy41w829H2Gd00Q0wKOzSf8/FZHSjDv6y2E59F+2K0K4M0Fus=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:57c1:b0:6d6:da73:e9c0 with SMTP id
 u1-20020a17090657c100b006d6da73e9c0mr35219641ejr.45.1648557735848; Tue, 29
 Mar 2022 05:42:15 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:09 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-41-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 40/48] x86: kmsan: disable instrumentation of unsupported code
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

Instrumenting some files with KMSAN will result in kernel being unable
to link, boot or crashing at runtime for various reasons (e.g. infinite
recursion caused by instrumentation hooks calling instrumented code again).

Completely omit KMSAN instrumentation in the following places:
 - arch/x86/boot and arch/x86/realmode/rm, as KMSAN doesn't work for i386;
 - arch/x86/entry/vdso, which isn't linked with KMSAN runtime;
 - three files in arch/x86/kernel - boot problems;
 - arch/x86/mm/cpu_entry_area.c - recursion.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 - moved the patch earlier in the series so that KMSAN can compile
 - split off the non-x86 part into a separate patch

Link: https://linux-review.googlesource.com/id/Id5e5c4a9f9d53c24a35ebb633b814c414628d81b
---
 arch/x86/boot/Makefile            | 1 +
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/entry/vdso/Makefile      | 3 +++
 arch/x86/kernel/Makefile          | 2 ++
 arch/x86/kernel/cpu/Makefile      | 1 +
 arch/x86/mm/Makefile              | 2 ++
 arch/x86/realmode/rm/Makefile     | 1 +
 7 files changed, 11 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index b5aecb524a8aa..d5623232b763f 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -12,6 +12,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6115274fe10fc..6e2e34d2655ce 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -20,6 +20,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb8..4f835eaa03ec1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -11,6 +11,9 @@ include $(srctree)/lib/vdso/Makefile
 
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KMSAN_SANITIZE_vclock_gettime.o := n
+KMSAN_SANITIZE_vgetcpu.o	:= n
+
 UBSAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee28a394..ad645fb8b02dd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -35,6 +35,8 @@ KASAN_SANITIZE_cc_platform.o				:= n
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
+KMSAN_SANITIZE_head$(BITS).o				:= n
+KMSAN_SANITIZE_nmi.o					:= n
 
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 9661e3e802be5..f10a921ee7565 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -12,6 +12,7 @@ endif
 # If these files are instrumented, boot hangs during the first second.
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
+KMSAN_SANITIZE_common.o := n
 
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index fe3d3061fc116..ada726784012f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -12,6 +12,8 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
 # reference __initdata sections.
 KCSAN_SANITIZE := n
+# Avoid recursion by not calling KMSAN hooks for CEA code.
+KMSAN_SANITIZE_cpu_entry_area.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 83f1b6a56449f..f614009d3e4e2 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -10,6 +10,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-- 
2.35.1.1021.g381101b075-goog

