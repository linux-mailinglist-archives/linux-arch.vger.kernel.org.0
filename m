Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B75AD2D0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiIEMbo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiIEMaT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:30:19 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF462606B4
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:32 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r17-20020adfbb11000000b00228663f217fso604173wrg.20
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TqyxH/L5MkAtosS0jWqWllGGzUIesiLdVg3wG3p7XtY=;
        b=SRHbIOUb4DGUSlckCuBIb5D5nY2hugScbD5wJSkj9+gz5MDYNGyreOoUjr426hDozZ
         eIZwnOJAR9QbuL6MBljpr+ef5VyWMq7LE+MGIMu63m/ooGwVOtY9Wymo4x+ItRsbPuMF
         3x3WktXqUtSalOy5ST4UA3C+QVvz/PUjD2mQzbD9n6SlVfmNFgRe+dRr3wA+uShralze
         F5IELO9fjYSA2cgSGi/7JeC9JLPRXPbVVnHX/AfgjNsTAchbmP+32JYRVNVmU8xLiZ/2
         5IjHNbRGxFz5C2uzmzWFN1Wc7yPI/jBEojh1hnBnCwk9zy4n2ozIysDaR+/OsHRccZvb
         k9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TqyxH/L5MkAtosS0jWqWllGGzUIesiLdVg3wG3p7XtY=;
        b=rTjj/jpBCWsCObIwFtf/zRj4s/u6uZhh3uulCI2fmtS/Fv4YeoT0wum5YikKTncNdc
         OA3svECNo3647aS6YZBQ0n2tkUzyq5BGJ9x3BA6E+M1o2o13hhRclHVc9bzYqUKgJH0J
         0nx+uedtiJzSjZ3cip82PYMZ55zPagG4SOC7quwaKyJ/A3U2r1thKG2MCeqq7arAxQOA
         8G06IXO6arUZ4axE41tI/Zxi8sX6GX8SQT6asTCNdw+/92bI8inQYnfASBkWNvmU1rfb
         BMqGTFZyhS9LnvEqmn7Q4HB7iCUKEWZ/AcFhB8OEFINGe25vv8RRcQ76lVFrKZvtx0o8
         pUrA==
X-Gm-Message-State: ACgBeo0YYQJD/Q5FuK4arHxf9Fr29GBD8Q7rIjMa8Ka1edTz+pKXcE7g
        J3Yf0KNttNYxMEZznkuDNdK2whQJRxQ=
X-Google-Smtp-Source: AA6agR7gpIA9Ys+R+97x8E6SItr56wFcMnWLG4Y2aVvt4HKxaJejCTap6PHw9s2SK+DWSs3ZsGMtcLcy1oM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a5d:584b:0:b0:220:7624:5aae with SMTP id
 i11-20020a5d584b000000b0022076245aaemr24101908wrf.119.1662380780114; Mon, 05
 Sep 2022 05:26:20 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:38 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-31-glider@google.com>
Subject: [PATCH v6 30/44] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
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
2.37.2.789.g6183377224-goog

