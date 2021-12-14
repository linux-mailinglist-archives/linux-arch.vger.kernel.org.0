Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6347479D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhLNQW1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhLNQWU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:20 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B8C06173E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:20 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso8128758wms.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jjmj3NfcL4RIWWcjIe7Qu67hp42cRss+aplyHHmWX6A=;
        b=dsYBdOhqGaaa9PjsEmjVgP7jb+SydcbxMgf/q2frLLdl6Ue4dxDmWMI1uSRnt9e4tl
         8EN6fuqAN1pB07ffVjLKp68NQkEugitoVyjaWEXGt5URJy4AJ0/K/EJIzia7a8ifLLHH
         Qdp5xARe4b4nPQ6LApIOirW8wjWL8FFt6TB/XT6z9uClOELYki2BZJTBvrbNuRnOix+n
         DJeTnfHEFEc8sdPd09Y1lSle0Vt/+oaJvlHX484kHFA9gE4h3Y7MyhCz4sy8ZJ1NfP5c
         8FYeQNEQyK3DKidsmLUkv+Q/Uw7+4laTzO9lkD8fN+gNuOLdKyKQ+sNof7Wvdz23qc7v
         w0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jjmj3NfcL4RIWWcjIe7Qu67hp42cRss+aplyHHmWX6A=;
        b=4aXd4KYXBSq2Bwthf9P4svyvclQ6pG4yZxgH8sng0QZtwCHWSNu4yLox+xNi6YKWsv
         RHisVCgihfZ92sbwwqkg36XfWr16MF2RmTPd/R4YGVkknWbrIOzgbsDMZrGYhJQ43pCn
         aJmNblEQRFtcmpERW7DwOJbeGblvOwvugqMIbGPRPZNTwJ8b8cFl7MHTdKIWv8TaNUrs
         /VFHXAabE4GpiBN9v83y9DE5nEu+/7pG9I5SUaEW4pPdubyHGynGrc+KZAAPTe36Lfq1
         gXdvazcYxUfkXDpza1vTgGcf/+Q8OInlCd6H5VGF/Lk5ztSNhtqNSbTOQBp1WwiMUvVU
         nt5g==
X-Gm-Message-State: AOAM531eBfu+rjwMCCNnD04AIlSH3R2rG+lW9Cwuja40w3LtxF0iwKwW
        psKSxIJg6b5WlpRqjXy+DHnLMQWt+wQ=
X-Google-Smtp-Source: ABdhPJx22gOJI63ONPs3T0E3/ieKvxRNELWcFZOjCmtKU2tJkN8ygCc56stf/zL88guIxkLENaHppDelx68=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a1c:23cb:: with SMTP id j194mr47944273wmj.13.1639498938088;
 Tue, 14 Dec 2021 08:22:18 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:16 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-10-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 09/43] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
not marked with it, and vice versa.

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
2.34.1.173.g76aa8bc2d0-goog

