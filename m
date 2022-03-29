Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B744EAD94
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiC2Mtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiC2MrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:47:24 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674AC25AED1
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:12 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id b71-20020a509f4d000000b00418d658e9d1so10844383edf.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T39GYI/vBjMdfMtH+Dx38ArgDU/LjDSVRO95NSUKYys=;
        b=Ga2g0KSm7zN5HCLMp88eZDrOW0thBYZOgl2SJsxhqq1/9JhR9hzR13gng3zeCxso+w
         i/qtco4gzCEgnTlb2mhL9BTKSiQMQJdKNozm6n1+hL+sDqOwULwTLCdwyrZELS+NA7W/
         c5qB98YvHHLJ3BMBq1pJMPQpE9RNLyE4eXN+o9MmFC6t7LQ+u14xMMOIVA+bA5naY+8s
         gRNrHJavp3e4jVaVQltJlMKiFbXubOTSrISRSTmFuJe4c/qmXIPakHSoPpaD9bKOA9pq
         oeNXL7OnbYXNrhPT7iXlkE3Z7JYvDzAHoBqV8prd4N81xr62OjBryDQm9qe/C7bS4tTD
         qDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T39GYI/vBjMdfMtH+Dx38ArgDU/LjDSVRO95NSUKYys=;
        b=ogeFaZ9vGVM33jQtDP66YA2bxAuWZCBhYcaCcCZivLLJO3bmRyYLlEWxdiwKesa3n1
         0YIQznftDsbYfZ0rBsHPWFLbd64FYFktjlVOuviGAifUJbhcgdowP21VtqspwQviv4yL
         nNEemToZUGgicKF/k5woP25jP1srPb9K1GNnG/DrTh4nTAGEBGID80JuNH511rZEaUSv
         f4zh8pQOIVi6Ojz5W4Y5wcFXhPx3K0jM4Ak66lAkrNDnYAXdOAk8sMtiQoJ3Mvqzy0cQ
         ZL9j6J3DnNNX/SCgWXtdxqAavc3/OCC1Lp8sSXcVJzEJSeMeqTiLkGYjlhoPozYOtfTm
         qTkw==
X-Gm-Message-State: AOAM530GGNxi8EYPlMhPxYS543xCy6YqehVth4sgRfiikv+AHHbppE8p
        AE3lktakdlzjTeJpE0uCYSLV2GbqE78=
X-Google-Smtp-Source: ABdhPJxnAD1WnRha3aT8bQpiv1ryLHN37wPgdzyd6u5jtCYTidxo5YWhjtFuZMhdjM/eFbjpolf6XzG13+Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id
 nb36-20020a1709071ca400b006da86a41ec7mr34900718ejc.556.1648557730788; Tue, 29
 Mar 2022 05:42:10 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:07 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-39-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 38/48] objtool: kmsan: list KMSAN API functions as uaccess-safe
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

KMSAN inserts API function calls in a lot of places (function entries
and exits, local variables, memory accesses), so they may get called
from the uaccess regions as well.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
---
 tools/objtool/check.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c33ec67c4a95..8518eaf05bff0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -943,6 +943,25 @@ static const char *uaccess_safe_builtin[] = {
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
2.35.1.1021.g381101b075-goog

