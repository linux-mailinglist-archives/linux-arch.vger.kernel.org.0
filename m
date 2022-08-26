Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDD5A2ACD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiHZPMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbiHZPLZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:11:25 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1141DEA7D
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:11 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso721587ejc.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=9AAV0khTKYQgqo5/UGS2nmhcIjrHMBeghL7l+ejLApU=;
        b=sDB5PJpJBZJ8zJUYHqSaroGLwunSs5Rwaz9QmpK5RO8+mlf1nYQAGNhjMXl1m0oFZH
         vzMQVlJHXNGU9aieZuBV0ihX2Xs7GeZCanFYLMBLdccTjtufIvPj0/C/g25QTIwI6/Qp
         sReL0ZmVrFu7c6GRkrze5jnIbC0eHcDyF/YHGMdyIlE3tPtruebYgAGRN7/qwGwqWIG0
         d7O6U7dzRkmvp5N9Pl4k3vT+ZH5Z9JXhcKEWunCg7MMWVXl8aGl5D3s28uVHexHgHJDm
         JLeAgRz2XBzUtSevuOYUNl/dsbWhlT4VB5dIjKptqOcveXztv31OO3ARcYOVZyimZv3m
         XuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=9AAV0khTKYQgqo5/UGS2nmhcIjrHMBeghL7l+ejLApU=;
        b=pvCtWrDPnqBXFiux/t0/uUslf907ogotDYOSdrBOLyC0welcI1dlAlif9i0Nql9QxY
         6bas68zphSywBLxQsAxPSseABEpjrqt+6ECQP/NI+2U/M2yaqq81bM1wfqOMiuX3NZ/G
         nfa8gsKuX01j1ecoQLmEcSQv8cA/IooGuQAJeZ3Wl7e5Cb6WDEKS6JHg/eEfIII1fcrJ
         YofJPTSh3/2Mh8xMiVsL0JZf0D+USlGW6I7Sp9Da+ppzub1wzCUdo0UFL/7JKpuTsxXY
         AFX6iYf4tvvUZvjroR9Sk/m9jnrUxAAWK+fJT8dkNYGciLPwvLCR4ON6M8PvZHZd9IDq
         gxQA==
X-Gm-Message-State: ACgBeo2xjsoUkFfZ9blQrIuVVVYBhTDIZsxU5M+p84FZqKtA/a+3O0ok
        6WKMV8/kgBvI8nifoFEOILBGIyixduo=
X-Google-Smtp-Source: AA6agR7OB7JfBU0FR/Gx7VVFS0BYXkDkX/D+5e1f7tZDKGDtu48HBg9ANVBecrhroNJG7bsthdjAB8Rc34M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:906:8a77:b0:73d:deef:8f76 with SMTP id
 hy23-20020a1709068a7700b0073ddeef8f76mr3332086ejc.765.1661526545890; Fri, 26
 Aug 2022 08:09:05 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:42 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-20-glider@google.com>
Subject: [PATCH v5 19/44] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an optimization to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Marco Elver <elver@google.com>

---
v5:
 -- updated description as suggested by Marco Elver

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
2.37.2.672.g94769d06f0-goog

