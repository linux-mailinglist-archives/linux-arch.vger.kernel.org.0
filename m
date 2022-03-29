Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DAA4EAD6E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiC2Mor (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiC2Mn4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:43:56 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA020232D1B
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:37 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z22-20020a50cd16000000b0041960ea8555so10961783edi.2
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kipmwjlnp7WROf90XDDYlpUL7HaVlKXhrZy7k38OjBk=;
        b=swBA+8/qBkvXXmxorMDqi6vUFeeZi3bN3raFZeA6IFlfLjInfXV+4iwKXj0XrLGgoC
         JQ7bqpVR4Aq6pLKUjKxxUVfZRxlPvshj9+PPkWZx9bHUxFIXGZ9Mq+01KZGeGQ12fXDH
         hkgtDJsBgTYCvyqeM4bo+uyBanKqRZjXekJyVVND/ULHYZSnwRSRhS0uDUYE2S32ihmM
         dc66EcjcYlTDsHsqTVtcqfQaGQIfQQjOUGnIkCiRunD8AdG9BsQx+9zQnqfMk6znpSBZ
         VdRLWG/DUzMLxudxXPvP6Z5TI95jhTKxcLr2iFonvlWLmVR44+5uS324vfekljJlpbJr
         pDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kipmwjlnp7WROf90XDDYlpUL7HaVlKXhrZy7k38OjBk=;
        b=mPwNdh+eRSh5NEdB52mmFVq430O75pUIt6mwpuufbI+Ukwp8ii/AN36lySXJujCj/F
         HYQTv52nx/5SRM1A3uHEXKeJTTbJ97TY1JRFZr/84xWVfnLcHIOiP6+S7BPLNpw2BSgZ
         y2E3m1ANJRcA7xFYzPphiheUWzNCljCdRI20BS5+4kHs4m4U2F8u20H63C+R73buS5Wt
         F84a7cfWGfhlk69mQ1H0ZrE5f+VAw44E9ylXa3+85KpMvffAGAA6K4av8eCIh/H1CP6u
         3VFXXS2aVE6Utn0puQG0HlbGMUqloHtffztuvpvkHJCu312/3EHZ3l9819afWXNxawAL
         DRsw==
X-Gm-Message-State: AOAM530V9Zze/fWedymZ0bvv/S7A4yGcw8V2gurnwc+r0fIMI0EXB+jp
        gSEWHc+QyIb6sTOaXJ2y7JRTj6jqoQ4=
X-Google-Smtp-Source: ABdhPJxtsqcpedBaD+pU00yaPAgOV5o7+L5K3nWzYJ9Q8ykrvoNlGaLEfr4A4ubrOrFSZ9FsAwRvka1gJuQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:1623:b0:6df:c9da:a6a8 with SMTP id
 hb35-20020a170907162300b006dfc9daa6a8mr33823933ejc.303.1648557696191; Tue, 29
 Mar 2022 05:41:36 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:54 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-26-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 25/48] kmsan: dma: unpoison DMA mappings
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Link: https://linux-review.googlesource.com/id/Ia162dc4c5a92e74d4686c1be32a4dfeffc5c32cd
---
 include/linux/kmsan.h | 41 +++++++++++++++++++++++++++++
 kernel/dma/mapping.c  |  9 ++++---
 mm/kmsan/hooks.c      | 61 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index a5767c728a46b..d8667161a10c8 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_KMSAN_H
 #define _LINUX_KMSAN_H
 
+#include <linux/dma-direction.h>
 #include <linux/gfp.h>
 #include <linux/kmsan-checks.h>
 #include <linux/stackdepot.h>
@@ -18,6 +19,7 @@
 struct page;
 struct kmem_cache;
 struct task_struct;
+struct scatterlist;
 
 #ifdef CONFIG_KMSAN
 
@@ -205,6 +207,35 @@ void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
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
@@ -287,6 +318,16 @@ static inline void kmsan_iounmap_page_range(unsigned long start,
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
index 9478eccd1c8e6..0560080813761 100644
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
index 365eedcb08953..cc3465bd69754 100644
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
2.35.1.1021.g381101b075-goog

