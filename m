Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12864EAD48
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiC2Mmv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiC2Mmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:46 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7821405E
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:51 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id jl19-20020a17090775d300b006dff5abe965so8143871ejc.18
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UaSjyZbuX4mRK40KL0zvcfvrCfayHvnW+1lMpNenzMM=;
        b=pT67FL+iJPznO4FlucflrliCBhKvTTg3KzQEhmg/BoDC0PIplw3vRbgledaaV+22QV
         PJ/2UpcagqAHZUoUmS6KMEOgg3Z7MJ6MkNWm1ZXIgZy3JMhpaXGLkAOvgIFYB1qAJ0KF
         I6NW2lJcnoBn97EYtu4eiCl6ODsGpg3JBpDnaoBDHnydn7JC8QLk7eLmg2KpVSgBLImy
         ia3dXD2aOt8PinRoXSw+HiAUjr2cNNWGiXvsfmcUXKj+k0Ec0UTSj4Yj90p9F6jv5nLE
         8q9nAN/NikHW+3ZZmHM89/rK8iQoXaim6KSGFGoalxm66Xa0wGT7M2cU/uJ7ZdLT9o7f
         Az0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UaSjyZbuX4mRK40KL0zvcfvrCfayHvnW+1lMpNenzMM=;
        b=a5rsL52x4pUjLzXzyfUfEwnYgC+cYu87RF1YH78Fnu5JGBTkDkNwGb90FUUM3Pfxx5
         0pnqr8oekSuokiML0QGkPGBWEiriPFmVL/HDnOwvgNBDoJBgHfee6cz1VG2bMzbRzWJn
         LYPDYXkZszdWGJ2CyEI8fGaxB7SQfnZM2oTfBhZRcG/hcPoQPmy2P+7LNjKpKf3wOD5n
         HaQNeK9aVKCadaP79S3yUbYAFLe8p7R0iaQG4+x/LmXou8iqy2EHxamrq92kZQlX9BJE
         A1iUAPq8o8DXqLBy5Yjgo4NvDu0PLTBWIKZDL/n+TYWDdbB6eyRJBXafvRQU7ayCk9lr
         el+w==
X-Gm-Message-State: AOAM530yDB8h66gBB7QZVVC36pyvQStHvpa9cZr5QVuJusCoHD0AuCL8
        +/8L4ETAKmWDSwx9uZLFTw8qchfonFU=
X-Google-Smtp-Source: ABdhPJzc7uQQqv9/qIuIbMIwaZGD04hNlnYkXly8TbXNnnJOwrMOtsjceNSNZRkURUbxFzT9/MpcuG+W9FY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a05:6402:1293:b0:418:fe9d:99c3 with SMTP id
 w19-20020a056402129300b00418fe9d99c3mr4374732edv.146.1648557649372; Tue, 29
 Mar 2022 05:40:49 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:37 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-9-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 08/48] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

__no_sanitize_memory is a function attribute that instructs KMSAN to
skip a function during instrumentation. This is needed to e.g. implement
the noinstr functions.

__no_kmsan_checks is a function attribute that makes KMSAN
ignore the uninitialized values coming from the function's
inputs, and initialize the function's outputs.

Functions marked with this attribute can't be inlined into functions
not marked with it, and vice versa. This behavior is overridden by
__always_inline.

__SANITIZE_MEMORY__ is a macro that's defined iff the file is
instrumented with KMSAN. This is not the same as CONFIG_KMSAN, which is
defined for every file.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I004ff0360c918d3cd8b18767ddd1381c6d3281be
---
 include/linux/compiler-clang.h | 23 +++++++++++++++++++++++
 include/linux/compiler-gcc.h   |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3c4de9b6c6e3e..5f11a6f269e28 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -51,6 +51,29 @@
 #define __no_sanitize_undefined
 #endif
 
+#if __has_feature(memory_sanitizer)
+#define __SANITIZE_MEMORY__
+/*
+ * Unlike other sanitizers, KMSAN still inserts code into functions marked with
+ * no_sanitize("kernel-memory"). Using disable_sanitizer_instrumentation
+ * provides the behavior consistent with other __no_sanitize_ attributes,
+ * guaranteeing that __no_sanitize_memory functions remain uninstrumented.
+ */
+#define __no_sanitize_memory __disable_sanitizer_instrumentation
+
+/*
+ * The __no_kmsan_checks attribute ensures that a function does not produce
+ * false positive reports by:
+ *  - initializing all local variables and memory stores in this function;
+ *  - skipping all shadow checks;
+ *  - passing initialized arguments to this function's callees.
+ */
+#define __no_kmsan_checks __attribute__((no_sanitize("kernel-memory")))
+#else
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+#endif
+
 /*
  * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
  * with no_sanitize("coverage"). Prior versions of Clang support coverage
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index ccbbd31b3aae5..f6e69387aad05 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -129,6 +129,12 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
+/*
+ * GCC does not support KMSAN.
+ */
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.35.1.1021.g381101b075-goog

