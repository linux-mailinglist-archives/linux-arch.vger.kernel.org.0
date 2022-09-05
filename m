Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AA5AD2E2
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiIEM2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiIEM1p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:27:45 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4E5F219
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:50 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qa35-20020a17090786a300b0073d4026a97dso2256421ejc.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=JDbXYbJWwPmgAZI0cqV5N9fdafuEA5LdQ6bM1NbJ2qU=;
        b=FI/NN8FVkqveVSoB6HG4Dkazuf6XYCk/EwCAfidqLj4dNPa0BRhM4P5S4TqXDGIZaI
         qrEKGE+r+7Jt5yWEty94dld142fuFuiBwTfOiFHQUY5nxSHJ+D8ob7Cf47AnhjKOGoR5
         Bklr3XpZrOoyXRce7z6Tw6kGBroRdXW/XXVfP6gsABeJuQtlQH3SmKvkiqAGb4lTB6cD
         7eYPHMVcX5DUnPnmRo4rO7LVehmhKNFjhaZP9RF8f0ksJZ1mSX0p7FROg8hQn24pzOBV
         K93l7+1ykcepxF58K6O1XQpgozdC1Jvz1hxtlrAemelvnVlo8kdLN50VY5GotqXyWFJ4
         nDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=JDbXYbJWwPmgAZI0cqV5N9fdafuEA5LdQ6bM1NbJ2qU=;
        b=LN4SzFuXFdvWBSW7WwyDX38hPFDBg8+NUuWTt5rPBjsaZGhGfkHD0+Qw4RA4HygshO
         G2llBIjfbfOYNTQ16GK17z0VLnQyFX3mz/lobxmy/ELn248NNP8u7q+woqoZunKr8TZk
         egcrG+DdV/M+50bMoXY/VOk+mjLvNZ3XrCk0crh4ddSWbwYgUR0QdNgmmrAsC8dFvl+a
         h2WLWjUP5MGCbRREMKSm0w3Pp1/n4wacvxVnEOqcqPKsBbzG9YXm8J9oe3wxc5NBnteV
         tYezcJzD3+8De3AQR1xD83pxujtUgCY1QRdek5z+ndZL+JdE+xweAcnwmfZd+SPiEUIZ
         b7yg==
X-Gm-Message-State: ACgBeo3YgN89+jSijXuh7LKvYpP5D9vV79V/9CL3bRwqlZcAvQvCE0TG
        AIKlHmmOTnx+T/I+NPqFyOH0XbJsUaI=
X-Google-Smtp-Source: AA6agR6EtI+wppo4BmYhDO6R8PujqfTGTJqoZccyFkAtKf4bzdO9HJQ/6nSdJYuTNsjvrOtwDoN6L9AHrrA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:7242:b0:741:7cd6:57d5 with SMTP id
 ds2-20020a170907724200b007417cd657d5mr25769275ejc.419.1662380749795; Mon, 05
 Sep 2022 05:25:49 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:27 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-20-glider@google.com>
Subject: [PATCH v6 19/44] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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
2.37.2.789.g6183377224-goog

