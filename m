Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A9510459
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353196AbiDZQvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353212AbiDZQu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:58 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AD246642
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:50 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so865951wmn.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KHDnEJZlYbtguNecmw4Z0aoQP18cjcWXna880BlF2jg=;
        b=Ras6zX6zLyLhsIDtzjqqN9y4Bp5f6rPNvg/NlhbZeOJcSZ0W0h6WszebH9Jl+tDnIj
         1d8SC1JokEP9rj0/Uz/B0C8vgBdM75W2cOctkHAhkLUnzcLWel+aJ8n1Z2d27uToZyPD
         NXcsYuwWmfXUsoUSNdeFpNkCp8Mdmw2X2PM8Z0Xq3w/pvHZee2tgfSDClqP6w/GG0G6Z
         Mkg5MkTefNZEIo51rh3WSUC/xRWyYaKD3+5kRfKXRqTWJTGdKD34V/dogH3TIl3qdspb
         r/9R17wsy7X98UcL39rrXIx8RR/Zx48ZWvJVe4g3RHHZ1p7AGTIwvBiDniEVZixdJ1br
         ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KHDnEJZlYbtguNecmw4Z0aoQP18cjcWXna880BlF2jg=;
        b=XNX/5mVffJKuaqUNa1LOm3DF0g7KxEB92PBr9t/0ckbC0xezUtE4R6VJVBX41GumoJ
         q7qqVbf2d+5ExQUvYbutCTa9TX6XBqRTm7FdMUXaRVNMrTQmuLsh8ZvMNsSOiPu5KaFQ
         flNTs6rG5O9Rio3bi6BulAT/rtXoeRHQkjkY8AozZcoRO0cm6fHAz4KQWgcQTasA4j/G
         gYnupP5hwA5sNTzQRuY2Y3r/PzSnYGNAAW0CUbDUaMvCpqKsRvkPenHQeCmtz04NkO3F
         iAnapGc4sKbMVUKJrLv4w3pzKsln7gixFTiCopmc83wTIt5H5U9lfRE43gOEmBPrjfIq
         O4dw==
X-Gm-Message-State: AOAM530u1FX3+0NpXc+POXrtUrGSyLGM38v7Hb0nvolLZow0Sghk2UVp
        05BBIeuTFWgbLp3UMt7vGuT8J/0EoMw=
X-Google-Smtp-Source: ABdhPJwEbc2ldIDEpaUEaYnMNUbLZOo12zW9lcP4NsRCoKnifcBnuhUmGJEZqd7cMdPo2nqMrlaeyXx5FlQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:adf:e289:0:b0:1e3:14ad:75fe with SMTP id
 v9-20020adfe289000000b001e314ad75femr18987161wri.685.1650991548482; Tue, 26
 Apr 2022 09:45:48 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:03 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-35-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 34/46] kmsan: kcov: unpoison area->list in kcov_remote_area_put()
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
Link: https://linux-review.googlesource.com/id/Ie17f2ee47a7af58f5cdf716d585ebf0769348a5a
---
 kernel/kcov.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index b3732b2105930..9e38209a7e0a9 100644
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
+	kmsan_unpoison_memory(&area->list, sizeof(struct list_head));
 }
 
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

