Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97FA510447
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353267AbiDZQvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353250AbiDZQtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:49:41 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718553CFCC
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:32 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso9377361ejc.18
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8+FTymzEXuQwrQ48VSTvyp6MK3t+ENPCVe5WmeEaVIc=;
        b=fcJ50fxU8vlV4Zt4ow5QLp80TC8c56IdxjhwU67LEgyBqe8j9VHcHGiTXWvty1WMSf
         1bPBfjkXUa51JG42+wVa+w3aHgsOYSrC1f9U8SZ2jz031VP/HC88wQw4NfXbVOoGdtcl
         SS8jFJBwA5MYs/dZR6sjMvgZtOfXiYQhrCsRhuTSkWp5gWJqFxoT0Go1VP32lUvN66NF
         QMYm/Pv7rIuLPqSnr2MRY4/KkU+A6liqUHe5KRLS7lCFdZ3JcG6G4DdynX7jifdqwnNt
         rgjoa8UfdHnj1e0EoDPPBI7pDd0IfYihgK9kALl0k/qSo8xllk+StsshEgAnxbfsnzPI
         nRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8+FTymzEXuQwrQ48VSTvyp6MK3t+ENPCVe5WmeEaVIc=;
        b=lW15y8AXkpWW435p1S4No+6ha2uKDWUa2XexG7xCY12zK+fWV0M0rj2mTGPvip4ma7
         39XKU/kwvc7BgsH03EF/N3xSJQ93hkDMEh2q9n6eyZNsMlCsOmkaKEat9HyKJxej7ZQr
         7U1NDi7/WKxWUwcf/+AtODGoMmdpBS+vbzFMVBovSaq8cf0slx4+FX/GUb31lzlmzYXJ
         BPErIQ8oa+xTdR4JREj1+lvgOAPwtWG1IpAZL/2aYqUJtcSpTFPPyJmWWamOWMXEhDfE
         hraodZve3+6y0x6vQ+TGEHGf+2cQaUy0AwkiGxVhUdgkdcfGILP50ghFV++12d+TQqkr
         m+aQ==
X-Gm-Message-State: AOAM531Br/NqobwFfcIUjSSUaLZXYRbCb9+vD6nKyJkZW5SOFQYBGdMV
        o7Fx8F4p2eZeqxbrVGOYMm+dMB4dkCw=
X-Google-Smtp-Source: ABdhPJzMNlQ7wgMMMKP2+ozorBxditMXEaVfv9SlYu5XvLbQQ4QNVo7xn2ciiuqzzcwq86sHWkzQRQWNmV4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a50:eb87:0:b0:425:c3e2:17a9 with SMTP id
 y7-20020a50eb87000000b00425c3e217a9mr22640245edr.109.1650991530577; Tue, 26
 Apr 2022 09:45:30 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:56 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-28-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 27/46] kmsan: instrumentation.h: add instrumentation_begin_with_regs()
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

When calling KMSAN-instrumented functions from non-instrumented
functions, function parameters may not be initialized properly, leading
to false positive reports. In particular, this happens all the time when
calling interrupt handlers from `noinstr` IDT entries.

We introduce instrumentation_begin_with_regs(), which calls
instrumentation_begin() and notifies KMSAN about the beginning of the
potentially instrumented region by calling
kmsan_instrumentation_begin(), which:
 - wipes the current KMSAN state at the beginning of the region, ensuring
   that the first call of an instrumented function receives initialized
   parameters (this is a pretty good approximation of having all other
   instrumented functions receive initialized parameters);
 - unpoisons the `struct pt_regs` set up by the non-instrumented assembly
   code.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I0f5e3372e00bd5fe25ddbf286f7260aae9011858
---
 include/linux/instrumentation.h |  6 ++++++
 include/linux/kmsan.h           | 11 +++++++++++
 mm/kmsan/hooks.c                | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 24359b4a96053..3bbce9d556381 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -15,6 +15,11 @@
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
+#define instrumentation_begin_with_regs(regs) do {			\
+	__instrumentation_begin(__COUNTER__);				\
+	kmsan_instrumentation_begin(regs);				\
+} while (0)
+
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation considers
  * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
@@ -55,6 +60,7 @@
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
 # define instrumentation_begin()	do { } while(0)
+# define instrumentation_begin_with_regs(regs) kmsan_instrumentation_begin(regs)
 # define instrumentation_end()		do { } while(0)
 #endif
 
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 55f976b721566..209a5a2192e22 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -247,6 +247,13 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
  */
 void kmsan_handle_urb(const struct urb *urb, bool is_out);
 
+/**
+ * kmsan_instrumentation_begin() - handle instrumentation_begin().
+ * @regs: pointer to struct pt_regs that non-instrumented code passes to
+ *        instrumented code.
+ */
+void kmsan_instrumentation_begin(struct pt_regs *regs);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -343,6 +350,10 @@ static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
 }
 
+static inline void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 9aecbf2825837..c20d105c143c1 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -366,3 +366,19 @@ void kmsan_check_memory(const void *addr, size_t size)
 					   REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+	struct kmsan_context_state *state = &kmsan_get_context()->cstate;
+
+	if (state)
+		__memset(state, 0, sizeof(struct kmsan_context_state));
+	if (!kmsan_enabled || !regs)
+		return;
+	/*
+	 * @regs may reside in cpu_entry_area, for which KMSAN does not allocate
+	 * metadata. Do not force an error in that case.
+	 */
+	kmsan_internal_unpoison_memory(regs, sizeof(*regs), /*checked*/ false);
+}
+EXPORT_SYMBOL(kmsan_instrumentation_begin);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

