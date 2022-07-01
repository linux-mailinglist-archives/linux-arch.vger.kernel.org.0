Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA1563555
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGAO0Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiGAOZ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:25:28 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500DA344EE
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:09 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso1847767edx.19
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GNX0et0VeFDbRNtievhe/rlGdldiDAHSzzvJvy6PdeY=;
        b=sYf9Flp9INntHEwHp1o9tRTz2HbnWSqOM0+13jbX4U/+5ngXGJ1iU0hkzEzI7Yl6Jk
         jlH0nE7LDojywEMxRZBi0U0XGDKUUrXHG6C4Qt21C0ilgW5fLbkrrpGtDWltdc6Tw5Ya
         YHQJqpyVfLRTzczxIItYEgnay8aizN5mERMhqohjf+v62gF9XLNvQGeEcDq68s6syawh
         PIsw0Dg3A/+St8+47YO/SOm1rxeGm8eQwJ6SDQfP6Egws2HnP2QcRUDhdRO6+G85DaEs
         34UNhJTVc5cvYOHCVw3XrE8e3CVUh9QKirtDvWgSK8qukjSrnnfPDSXOiJU5cGqgyDHU
         tXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GNX0et0VeFDbRNtievhe/rlGdldiDAHSzzvJvy6PdeY=;
        b=dMfPFL0p00Di53Cxun7d4HOjPuYnZ/WwM6w272Y+cIbR6cYAPEI6LV9gVWnALcs1Ta
         IqD0gEKjpHFzsPU+D3yfDV0wJyCLFq1BxJ4pqa2hTam1HS+PNGgtozkPSvEC2sqx8Aej
         mm9oMSnvKlEIii6DuZ4DPDmU8E+jhTQA9+9z2qwLBJZRgbI0b+DAiw1808dDtwkhOtcw
         QSIY0xwMCVVsqXN3a230PgqEiFzXbD2yR+zfGptwNXu7qySGZqmMPxgBd6Jkbvt+FspG
         70vgwVBmkwv+LAVT/L1P8Hxa4oKkDdJozN6cKIPnoX3QyV+JFIdW4mAxb9ZBBqlJnhdT
         jgfw==
X-Gm-Message-State: AJIora9Pk3E2B7A7+l6+//suo5gQ20N2uLZSaXFXeAitgdNtgJtBjZnw
        vhR64L/0/YTu/MWiol0mbQJfcvpIqE8=
X-Google-Smtp-Source: AGRyM1uzH9PjvdEPicdkmuZyhlg/emV06zmVNYqY3j0pzDHXQSlgbpj3K/6MPdVlVtvQnC8U1qYagZgOlpg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id
 eq5-20020a056402298500b00439651bc1f4mr8429220edb.276.1656685448889; Fri, 01
 Jul 2022 07:24:08 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:44 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-20-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 19/45] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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

This is a hack to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
---
 mm/mmu_gather.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index a71924bd38c0d..add4244e5790d 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,6 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/mm_inline.h>
@@ -265,6 +266,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
+	/*
+	 * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
+	 * unsigned int value. The remaining 25 bits remain uninitialized
+	 * and are never used, but KMSAN updates the origin for them in
+	 * zap_pXX_range() in mm/memory.c, thus creating very long origin
+	 * chains. This is technically correct, but consumes too much memory.
+	 * Unpoisoning the whole structure will prevent creating such chains.
+	 */
+	kmsan_unpoison_memory(tlb, sizeof(*tlb));
 	tlb->mm = mm;
 	tlb->fullmm = fullmm;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

