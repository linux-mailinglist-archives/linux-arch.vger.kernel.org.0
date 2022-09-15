Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6325B9E62
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIOPKb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiIOPIv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:08:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FFD98CBE
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b18-20020a253412000000b006b0177978eeso4084951yba.21
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=mxKrKakNES2O6WNVUjUiVAG/aqg8NEyyXmfzwvDy3M8=;
        b=QcWSJZZkiYWs+sa+cokZ+5ih/3AigYwqha5oBzQKZX2ROZg6ZA3IUEgOs0eaSXO+su
         nynwTZxRJ3h5UK5bRt9ZIBKugOR9VD/wb2UQjdtResQ/B8p8IkXP6aGpAvmpsNj4uPDT
         g9XcO9t+eEd46cZjKpaZdtoo+KHYDdMPK4LApETzHxHqBUgFU1YKU7DIXGAmDZ5uwQk1
         VZTeF44KqcNIcSibzQDkTi6BRiZq+KBK3WRtjsxy+OtraDYZ7O7tuXbkHApnF4hjaeSB
         xkP3yPUIvRQJsGMky0kNRvZS+Rc0renoCDGlUJjq1GKjAS9Q6aHVUEG99/PfpTuNweGG
         CY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=mxKrKakNES2O6WNVUjUiVAG/aqg8NEyyXmfzwvDy3M8=;
        b=1npfxDB4J0GDfKgw05kft7ab/UNP4KJOzHeXXjZQjACmhZZGC97qITCpdEVaSiEKi0
         iHyz3YLiTaBQxTzC09zl9uISfgMirOTTb90H1d2DKS2BETnUkCbpYbq0AoahFn8m5kJ9
         EEWHaACVlhwQShHDT/pl30S/ElynwXhn+e3LlnZOTgJ3xNXYsG6IHAugC29ybGMt/lfm
         yhOrag1PktuLuCP5Rg0EUimCOj+/vIegSg0NQAbewKvPUB5GD+RAmC90KktWvnq6CjfT
         GV7+H02Prz1/WPLAKcLOf7yrUHJC8Y9D8sctfziUa9nZyEj6E8UkR+rZNrW7/eAAsXh6
         OdQw==
X-Gm-Message-State: ACrzQf1F6PEZ+Rii2VP1NdI8EP5K5Yjr5kny+W2cIf+Pdd6L3C0EC3BS
        w5RB+dlCEoZlIn3RUMk8QB08gAtfN/E=
X-Google-Smtp-Source: AMsMyM5QNy6iagLQZF5XlPAvUcWfp+eaYBogp+9cAeIdO1aa1vANNHLNyhp7U4YSK9OGDcBNDqZffj+MYXA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a81:a503:0:b0:349:f6c6:434 with SMTP id
 u3-20020a81a503000000b00349f6c60434mr248211ywg.70.1663254362758; Thu, 15 Sep
 2022 08:06:02 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:05 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-32-glider@google.com>
Subject: [PATCH v7 31/43] objtool: kmsan: list KMSAN API functions as uaccess-safe
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN inserts API function calls in a lot of places (function entries
and exits, local variables, memory accesses), so they may get called
from the uaccess regions as well.

KMSAN API functions are used to update the metadata (shadow/origin pages)
for kernel memory accesses. The metadata pages for kernel pointers are
also located in the kernel memory, so touching them is not a problem.
For userspace pointers, no metadata is allocated.

If an API function is supposed to read or modify the metadata, it does so
for kernel pointers and ignores userspace pointers.
If an API function is supposed to return a pair of metadata pointers for
the instrumentation to use (like all __msan_metadata_ptr_for_TYPE_SIZE()
functions do), it returns the allocated metadata for kernel pointers and
special dummy buffers residing in the kernel memory for userspace
pointers.

As a result, none of KMSAN API functions perform userspace accesses, but
since they might be called from UACCESS regions they use
user_access_save/restore().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v3:
 -- updated the patch description

v4:
 -- add kmsan_unpoison_entry_regs()

Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
---
 tools/objtool/check.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a1..7c048c11ce7da 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1062,6 +1062,26 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
 	"__sanitizer_cov_trace_switch",
+	/* KMSAN */
+	"kmsan_copy_to_user",
+	"kmsan_report",
+	"kmsan_unpoison_entry_regs",
+	"kmsan_unpoison_memory",
+	"__msan_chain_origin",
+	"__msan_get_context_state",
+	"__msan_instrument_asm_store",
+	"__msan_metadata_ptr_for_load_1",
+	"__msan_metadata_ptr_for_load_2",
+	"__msan_metadata_ptr_for_load_4",
+	"__msan_metadata_ptr_for_load_8",
+	"__msan_metadata_ptr_for_load_n",
+	"__msan_metadata_ptr_for_store_1",
+	"__msan_metadata_ptr_for_store_2",
+	"__msan_metadata_ptr_for_store_4",
+	"__msan_metadata_ptr_for_store_8",
+	"__msan_metadata_ptr_for_store_n",
+	"__msan_poison_alloca",
+	"__msan_warning",
 	/* UBSAN */
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
-- 
2.37.2.789.g6183377224-goog

