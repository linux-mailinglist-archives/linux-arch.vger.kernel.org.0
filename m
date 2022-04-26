Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F344251040E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353165AbiDZQs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353181AbiDZQs1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:27 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D7191C61
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:47 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso9376368ejc.18
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H2XcU3OLx+0JTyyML32bzgUT5MJiV2tDmnYI11nI1dE=;
        b=m/GoUZBVtlZMRq+FF0SH5aCHlTGSvaapuxEDbVMKlEUnlusQPCCZ7ebjbcCdUrWYb5
         a8Bnd3p86A4nE5NEzf9NbCXsFTEls9lTknebhOvAE06AdOtYHsT4/XF7t90n+nJ5iebk
         sRGdLEAOOW9bUwdhOZndjscgKwN1eOVOb9hwxXJ7DP2x/BYwqNzZ6yzf2ohW5qzq+FEZ
         g3mr3p0uqiTWn5KToQ7MIQy5yDLS3i1YymgzGDrCkkGyLo8f/tQJWjvGzdC5snsMrVUx
         RKkkljd+V3QJEWhwnCDg+P32Vbl+YhkiLRuywjeqifPG0/ok+r70FeWu7XYIUm7eYfDk
         3sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H2XcU3OLx+0JTyyML32bzgUT5MJiV2tDmnYI11nI1dE=;
        b=YL+ckTy37d0FztApa8Z/dSvlTE6YecdDpNERVBsWcv9RFD1xuOoXsu3k4h/XVC3elQ
         VW4zy2p6gx4Bm0GkAUBW4DjuKdWYJITWXTXDaUln0dysSpX4+CH3mVB3LQIhkBRU6ewr
         bCkMo3JXfbAZUozxt4G5gGb8/Z+RPLwKxYJVFrw8gfA9X5HEvBFwV6rk4C8FNZMphxfN
         mJfn1FOVACZZZBA3mI/81MasYPT2Kvdl0T9PrSm1CEbjvnbDGXZUrNu7f5vuJvh9AR9H
         OY73t0h9Y9/RQRm6+AHSAMjt3x6RjVyydpFcFWrFQsA6Y2ekoAmaokABeJ7eB5czNHEN
         PqOg==
X-Gm-Message-State: AOAM531ufK4ZJK1sHr1jaCTdo3jPJfoHJUo6qgjyr164t+Oj/0cpJKVX
        4RSxDVbrVYHBsxZWC6gtC4AKHPOWByE=
X-Google-Smtp-Source: ABdhPJxuZFKkNdAIYxCe6Wr3rHxB/+GLrdr6eXOf7wzKyJPWcdL4QfIWrMfSB3fnw8xzMi6hwbSucSjlH8I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:4315:b0:426:155:e4a3 with SMTP id
 m21-20020a056402431500b004260155e4a3mr1554638edc.324.1650991485934; Tue, 26
 Apr 2022 09:44:45 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:39 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-11-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 10/46] x86: kmsan: pgtable: reduce vmalloc space
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN is going to use 3/4 of existing vmalloc space to hold the
metadata, therefore we lower VMALLOC_END to make sure vmalloc() doesn't
allocate past the first 1/4.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- added x86: to the title

Link: https://linux-review.googlesource.com/id/I9d8b7f0a88a639f1263bc693cbd5c136626f7efd
---
 arch/x86/include/asm/pgtable_64_types.h | 41 ++++++++++++++++++++++++-
 arch/x86/mm/init_64.c                   |  2 +-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 91ac106545703..7f15d43754a34 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -139,7 +139,46 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
-#define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
+#define VMEMORY_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
+
+#ifndef CONFIG_KMSAN
+#define VMALLOC_END		VMEMORY_END
+#else
+/*
+ * In KMSAN builds vmalloc area is four times smaller, and the remaining 3/4
+ * are used to keep the metadata for virtual pages. The memory formerly
+ * belonging to vmalloc area is now laid out as follows:
+ *
+ * 1st quarter: VMALLOC_START to VMALLOC_END - new vmalloc area
+ * 2nd quarter: KMSAN_VMALLOC_SHADOW_START to
+ *              VMALLOC_END+KMSAN_VMALLOC_SHADOW_OFFSET - vmalloc area shadow
+ * 3rd quarter: KMSAN_VMALLOC_ORIGIN_START to
+ *              VMALLOC_END+KMSAN_VMALLOC_ORIGIN_OFFSET - vmalloc area origins
+ * 4th quarter: KMSAN_MODULES_SHADOW_START to KMSAN_MODULES_ORIGIN_START
+ *              - shadow for modules,
+ *              KMSAN_MODULES_ORIGIN_START to
+ *              KMSAN_MODULES_ORIGIN_START + MODULES_LEN - origins for modules.
+ */
+#define VMALLOC_QUARTER_SIZE	((VMALLOC_SIZE_TB << 40) >> 2)
+#define VMALLOC_END		(VMALLOC_START + VMALLOC_QUARTER_SIZE - 1)
+
+/*
+ * vmalloc metadata addresses are calculated by adding shadow/origin offsets
+ * to vmalloc address.
+ */
+#define KMSAN_VMALLOC_SHADOW_OFFSET	VMALLOC_QUARTER_SIZE
+#define KMSAN_VMALLOC_ORIGIN_OFFSET	(VMALLOC_QUARTER_SIZE << 1)
+
+#define KMSAN_VMALLOC_SHADOW_START	(VMALLOC_START + KMSAN_VMALLOC_SHADOW_OFFSET)
+#define KMSAN_VMALLOC_ORIGIN_START	(VMALLOC_START + KMSAN_VMALLOC_ORIGIN_OFFSET)
+
+/*
+ * The shadow/origin for modules are placed one by one in the last 1/4 of
+ * vmalloc space.
+ */
+#define KMSAN_MODULES_SHADOW_START	(VMALLOC_END + KMSAN_VMALLOC_ORIGIN_OFFSET + 1)
+#define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
+#endif /* CONFIG_KMSAN */
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 96d34ebb20a9e..fcea37beb3911 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1287,7 +1287,7 @@ static void __init preallocate_vmalloc_pages(void)
 	unsigned long addr;
 	const char *lvl;
 
-	for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+	for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
 		pgd_t *pgd = pgd_offset_k(addr);
 		p4d_t *p4d;
 		pud_t *pud;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

