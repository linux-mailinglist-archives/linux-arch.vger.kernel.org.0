Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B957D563574
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGAO2L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiGAO05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:57 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFBE51B3D
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:40 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id kv9-20020a17090778c900b007262b461ecdso832315ejc.6
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5N9rqr7HITf8FFSE4yH2hCrYnonc5u0Mk2BxyWMh4Wc=;
        b=ReMSGptb1gOevOQA5KIOUI2r4Y7KHZlx+U+473Qz+0IYhBm7Zh60skPZL94IWrvGHe
         OD/b/T8E/9DRBnHYkCik0EMtmERYvMYLmNm2a9PZ3CXqtQvv3NgmYs9l7lSp7JKC2JNu
         asOUoRmUrLf+MBvhhA5FucNbpwjzToLRIKdYTiOAjk7d5eN8Pd3e+soWyP6PDlWUzRey
         6eKr6HZEm15XrcXNJMk7zw70qhG9SX/ZUCNS5t5YyEGHANeY85at4PO2xF7Ipa5N6imk
         72H7eRaKJCimZpAza45clzrOO1tWWs5oG5q/zZogSjW/5CpnZ1YyjjTkf+gFTDMx7GOA
         kGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5N9rqr7HITf8FFSE4yH2hCrYnonc5u0Mk2BxyWMh4Wc=;
        b=D0a09XNAnuXItExqPy3Xp36f5QERiiEAFXGPPbilaMa5gMbK5MN0UQH84+zSe4SbIg
         /T4f4TMwdLkR9PeQ+6rdT8JfDeES/RXQD/6Wx/KdCVHkFi8ns2EGlwvl1RRfAqTDtBKM
         EBd57Jq+98mrIbiYDzgZkmaVTVoOzZpZ8g+pvDlvTc+9XmDyGsqvV2gdWadnzBIrv4cH
         NtMnfRAzbiVhIhyf4H/iz1Edahj6P2nIfPronAsXdXrIb2gvwPhfKoq/X9qhWCKWR6JT
         VCHkyEVw85RypjnvznYS50/fekvG2SdV6ZAi+clQBmHXmmDl2DfjaNmoQsUBai0DdHYE
         RHsA==
X-Gm-Message-State: AJIora+OAvxpU/70GZr4o1l5Y4nK1nCdrcMXL9CrlodqmKN4Z068V8Fh
        GuP/FT4EEpS2xTeYSHZbzsohvPnVQZ8=
X-Google-Smtp-Source: AGRyM1uKM3hcXWEB+X983N8ZUuPx4ycBhxuOiVX+On/gdGCeZVb6tOlhn3CoZm88ilqSQUTNpJWyQUtAfdc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:906:8501:b0:711:bf65:2a47 with SMTP id
 i1-20020a170906850100b00711bf652a47mr14797955ejx.150.1656685479201; Fri, 01
 Jul 2022 07:24:39 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:55 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-31-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 30/45] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
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

KMSAN does not instrument kernel/kcov.c for performance reasons (with
CONFIG_KCOV=y virtually every place in the kernel invokes kcov
instrumentation). Therefore the tool may miss writes from kcov.c that
initialize memory.

When CONFIG_DEBUG_LIST is enabled, list pointers from kernel/kcov.c are
passed to instrumented helpers in lib/list_debug.c, resulting in false
positives.

To work around these reports, we unpoison the contents of area->list after
initializing it.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

v4:
 -- change sizeof(type) to sizeof(*ptr)
 -- swap kcov: and kmsan: in the subject

Link: https://linux-review.googlesource.com/id/Ie17f2ee47a7af58f5cdf716d585ebf0769348a5a
---
 kernel/kcov.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index e19c84b02452e..e5cd09fd8a050 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
@@ -152,6 +153,12 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
 	list_add(&area->list, &kcov_remote_areas);
+	/*
+	 * KMSAN doesn't instrument this file, so it may not know area->list
+	 * is initialized. Unpoison it explicitly to avoid reports in
+	 * kcov_remote_area_get().
+	 */
+	kmsan_unpoison_memory(&area->list, sizeof(area->list));
 }
 
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
-- 
2.37.0.rc0.161.g10f37bed90-goog

