Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA969510472
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353421AbiDZQv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353295AbiDZQu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:59 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364A48337
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:55 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so2044645ejy.8
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UzBVkSVOyNRYl4KHuto6hQklAwc82x2pMcEIZC5XiS8=;
        b=owv8rcv7uy/IjMK2oDHnzdeRikUPc32v+DR6vPabqmMBgOdq0UhvmmpjftMy8ytPNt
         HM3P5/DQ+pT5uKlWjCFQLCWuI9NAXILUzfH3+gwTr92gjb0OskwwBjPetTXSTIPD/6OL
         3KUV5a7F0Rw16/K17cTVV6HnNmzJ94eEPwwrT81RmiU5XvUiR8m/dPbUUMv64bYcnrfS
         8JLEMyNSW8k05BHKUBKubnloTQr7UOc9bvvDZfi1MjSOdb0FNIpfyPVgIpYfdedOBZYB
         K6n0Di2ypZYYijr3xtes9AkKQrrbDkPvtqX7ow2f4ddywq7YCN1BIaM7a/np99bjjIjy
         k1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UzBVkSVOyNRYl4KHuto6hQklAwc82x2pMcEIZC5XiS8=;
        b=yiAWKR8MF0QV5aRbkD3CDqoad7aoLoMfRWLkyR3f1kR3FYCEFOPKNzYGszP6qgU1R/
         rnt10e/S9y05b00nJzRQNiBG1MfC6OI4xKyIssUoJ0BwkxGx2WBfSvLl7OrQsL1tAcw5
         eD6hPueGM90XQGE9w+hkyETo/w3tQxr8pxMwGNmwwc0aR5kBXEeoFPz7Un5FJe7mTeXI
         7HS8CDo3Xu86SoBggTueMkg5USuJhDzdR6mDP0sS87DdQ1tbtG0Z0kQnZUvvEdeooUAl
         z/ME6LssBMHHcphjoLnw2Jnea+p1oEGhG5CaTL0vpHSeRQMIO93630KC0fu1yFV1OV2M
         xhgw==
X-Gm-Message-State: AOAM531uMc+RnAzwdC4YNDuW/UxtOmsM+Y2qEeRNNJCeGVshHdtxOpWL
        0CAKsS1SB1vfhAEF3o6gg+GWCbIo3es=
X-Google-Smtp-Source: ABdhPJyuq9+TYZNExRenypS/KX++WGny+sO+6oBDx1c907ZTGsidHormgyYiaYHSTUT0xaavjbt6mR9vHwU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr25365353edu.158.1650991553606; Tue, 26
 Apr 2022 09:45:53 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:05 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-37-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 36/46] objtool: kmsan: list KMSAN API functions as uaccess-safe
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

Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
---
 tools/objtool/check.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c828940a..44825a96adc7c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1008,6 +1008,25 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
 	"__sanitizer_cov_trace_switch",
+	/* KMSAN */
+	"kmsan_copy_to_user",
+	"kmsan_report",
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
2.36.0.rc2.479.g8af0fa9b8e-goog

