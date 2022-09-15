Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24735B9E5F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIOPK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiIOPIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:08:39 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082D98CA1
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:58 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id h4-20020a05651211c400b00497abd0d657so5614942lfr.13
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TqyxH/L5MkAtosS0jWqWllGGzUIesiLdVg3wG3p7XtY=;
        b=LKBPWrq4xXW7nEQB2ZmDRYo6z5ym4Le1THr8Xz3k7EBYLNOSha3Vhju0WXExFwXMZf
         pX6jviKwXYf/T1MVZ+5qxS4JaETzqBr+L0yjL5rYhmxXUekA0TEsSA8YRxYi5D0uDvsb
         NYOOkM/oK63TRvOnG9gJka71MFo0nVJFHOFee0NXtYOWDnMFjeaNsT8i5fOuOTX0XMgC
         9VElsJE6GI8Iftk760oZrEHYu4XwhnR8azD6+iL8qrR3RuQo3Z8mAHYtnOhgWEQY18jM
         DMru+t4Du9cAUzTuKfSbPWE/QnbKa8dlrPg29e6mY17/hRx4CrdxOfA4n95mDK9E6Nlc
         EkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TqyxH/L5MkAtosS0jWqWllGGzUIesiLdVg3wG3p7XtY=;
        b=LsSLEz3/B3U6U+L5mTE9EI8qIXL0251HVmRJB/5zeTlqan07nqPclx76Xf/PWaQg7m
         /YxYI4LP6yHFXVdpPYlSA+yYg5nq5cXP/qgDYOT2y6b8IXrdU5eEiTFopsuZfN3POUq2
         +kVaJGkUZ+hnH3hvakrCNAMY88otLe5OZDh+DzKljG0VXljD2pn6idXFUV8KuNqVOwZ4
         5bd5RjVlTamcc3Tbm8G1MBPc2gJwIOuEsR7e87xs6xqQEULaiN9CWLFhKgm222VcD5Tt
         sBbIJCQqeqqm5VN9Q6PnBrkxtN1nP5My14fjLO2Edec+t+HRNpy/xWoOyAzEG7wJIgTf
         jK7g==
X-Gm-Message-State: ACrzQf3vJIgSXMYwPjaSzURGfHH0dk9emePb/h5CkG7y44GwSybwXKo7
        jq5U+YOY4bJiYvV0IcqCMwMfirzQkaQ=
X-Google-Smtp-Source: AMsMyM51rNDLMIp7ozypIEsAXT0sulEDSz8gW5q4dALqMyH7lyGzgXjlA9GkTEeN37i0dxQ1XBCtNaS0ipQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6512:3d2:b0:494:6546:dc1f with SMTP id
 w18-20020a05651203d200b004946546dc1fmr129949lfp.6.1663254357164; Thu, 15 Sep
 2022 08:05:57 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:03 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-30-glider@google.com>
Subject: [PATCH v7 29/43] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
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
2.37.2.789.g6183377224-goog

