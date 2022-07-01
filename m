Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4701756356E
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiGAO07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiGAO0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:09 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6945065
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:18 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso843773ejj.11
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q/n/OecEQokjv5vk7nJWmgO+y+lMcJIuX+yK+Jk36kg=;
        b=U5LnbAq/BfGg73b3hAPk1LGNT654UNP9cra9ckGKhN/P0fyT5dmbNa1GwGMC/VQSau
         kRRACO1kwseZjFl8pDjCJnqdw+CVsYmJalihZ0BfiiWO66sGbSWS/QGcsD8uZTf0fZVy
         6eRMZPVngQrj635M05w5qDdJQQzaIckJ8YJ7a9RY76OdD8EzT31PanbT0T3p4KWXGYQF
         +qmU1PTyJ4IBn8XSLLL2PEetWgBrtk9fkaI3OUzV7+LCeZNWoyFZA/kpqxczFaWlH/25
         jGYWS+j/JNFVmhC3ACDNxjLd8Gs1XS5BL6t/D7d5YG8xFOVszZWJNMj5ExZnAIg3/Kxj
         YuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q/n/OecEQokjv5vk7nJWmgO+y+lMcJIuX+yK+Jk36kg=;
        b=MGmcJRBPWxq/Yzheomgthlro1BozrRR4Vc8O4F6JimeROx3Y6yJv8ak8KrBrVNblj4
         uF37sxtx3yDcjexk4NaiNhhR8DfZuaAn32qFRYLJwucZBNayILC7uyQm3zCqZ1AT3469
         NUVDpPu50CKP1G4uEF4319LZUXq9m0cqYsx/APHqpwJWQjUyQMjdaVBcHjWG+07Avtdt
         80ObPxXYy6xOwfZfLp9tNuwz7vAdnDomeUC4z3QhIb4DGRYzTqejMwn7ge25V4tALKer
         1lzyUmDgGz+3M1ew8CtiIrS63Bd8tcnzXczXm0/RUDgse0qC2n1njtBiAq22Hs06+TR6
         goyg==
X-Gm-Message-State: AJIora99ykPMMkdBC8Wg7QU8WIlJL8y+5LjcwyXCAVBW96rc7xXhZ3C8
        cWCEqYoPJvShLxQUbx4iAumbSWIf//A=
X-Google-Smtp-Source: AGRyM1vh1xuSpd10aw8ZdO/pImp9DeAVweQvga8OQDtjXKfbnui60mltRkNXb/YJK5XPxxAY6bzLEimCmls=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:f1b:b0:436:d3c4:aef2 with SMTP id
 i27-20020a0564020f1b00b00436d3c4aef2mr19579345eda.27.1656685457025; Fri, 01
 Jul 2022 07:24:17 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:47 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-23-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 22/45] dma: kmsan: unpoison DMA mappings
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

KMSAN doesn't know about DMA memory writes performed by devices.
We unpoison such memory when it's mapped to avoid false positive
reports.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move implementation of kmsan_handle_dma() and kmsan_handle_dma_sg() here

v4:
 -- swap dma: and kmsan: int the subject

Link: https://linux-review.googlesource.com/id/Ia162dc4c5a92e74d4686c1be32a4dfeffc5c32cd
---
 include/linux/kmsan.h | 41 +++++++++++++++++++++++++++++
 kernel/dma/mapping.c  |  9 ++++---
 mm/kmsan/hooks.c      | 61 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 82fd564cc72e7..55fe673ee1e84 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_KMSAN_H
 #define _LINUX_KMSAN_H
 
+#include <linux/dma-direction.h>
 #include <linux/gfp.h>
 #include <linux/kmsan-checks.h>
 #include <linux/stackdepot.h>
@@ -17,6 +18,7 @@
 struct page;
 struct kmem_cache;
 struct task_struct;
+struct scatterlist;
 
 #ifdef CONFIG_KMSAN
 
@@ -204,6 +206,35 @@ void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
  */
 void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
+/**
+ * kmsan_handle_dma() - Handle a DMA data transfer.
+ * @page:   first page of the buffer.
+ * @offset: offset of the buffer within the first page.
+ * @size:   buffer size.
+ * @dir:    one of possible dma_data_direction values.
+ *
+ * Depending on @direction, KMSAN:
+ * * checks the buffer, if it is copied to device;
+ * * initializes the buffer, if it is copied from device;
+ * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ */
+void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+		      enum dma_data_direction dir);
+
+/**
+ * kmsan_handle_dma_sg() - Handle a DMA transfer using scatterlist.
+ * @sg:    scatterlist holding DMA buffers.
+ * @nents: number of scatterlist entries.
+ * @dir:   one of possible dma_data_direction values.
+ *
+ * Depending on @direction, KMSAN:
+ * * checks the buffers in the scatterlist, if they are copied to device;
+ * * initializes the buffers, if they are copied from device;
+ * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ */
+void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -286,6 +317,16 @@ static inline void kmsan_iounmap_page_range(unsigned long start,
 {
 }
 
+static inline void kmsan_handle_dma(struct page *page, size_t offset,
+				    size_t size, enum dma_data_direction dir)
+{
+}
+
+static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+				       enum dma_data_direction dir)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index db7244291b745..5d17d5d62166b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -156,6 +156,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	kmsan_handle_dma(page, offset, size, dir);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -194,11 +195,13 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 
-	if (ents > 0)
+	if (ents > 0) {
+		kmsan_handle_dma_sg(sg, nents, dir);
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
-	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
+				ents != -EIO)) {
 		return -EIO;
+	}
 
 	return ents;
 }
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 1cdb4420977f1..8a6947a2a2f22 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -10,9 +10,11 @@
  */
 
 #include <linux/cacheflush.h>
+#include <linux/dma-direction.h>
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/mm_types.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -250,6 +252,65 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 }
 EXPORT_SYMBOL(kmsan_copy_to_user);
 
+static void kmsan_handle_dma_page(const void *addr, size_t size,
+				  enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
+					    REASON_ANY);
+		kmsan_internal_unpoison_memory((void *)addr, size,
+					       /*checked*/ false);
+		break;
+	case DMA_TO_DEVICE:
+		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
+					    REASON_ANY);
+		break;
+	case DMA_FROM_DEVICE:
+		kmsan_internal_unpoison_memory((void *)addr, size,
+					       /*checked*/ false);
+		break;
+	case DMA_NONE:
+		break;
+	}
+}
+
+/* Helper function to handle DMA data transfers. */
+void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+		      enum dma_data_direction dir)
+{
+	u64 page_offset, to_go, addr;
+
+	if (PageHighMem(page))
+		return;
+	addr = (u64)page_address(page) + offset;
+	/*
+	 * The kernel may occasionally give us adjacent DMA pages not belonging
+	 * to the same allocation. Process them separately to avoid triggering
+	 * internal KMSAN checks.
+	 */
+	while (size > 0) {
+		page_offset = addr % PAGE_SIZE;
+		to_go = min(PAGE_SIZE - page_offset, (u64)size);
+		kmsan_handle_dma_page((void *)addr, to_go, dir);
+		addr += to_go;
+		size -= to_go;
+	}
+}
+EXPORT_SYMBOL(kmsan_handle_dma);
+
+void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir)
+{
+	struct scatterlist *item;
+	int i;
+
+	for_each_sg(sg, item, nents, i)
+		kmsan_handle_dma(sg_page(item), item->offset, item->length,
+				 dir);
+}
+EXPORT_SYMBOL(kmsan_handle_dma_sg);
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

