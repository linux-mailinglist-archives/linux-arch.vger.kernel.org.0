Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967475B9E4D
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiIOPIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIOPHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:07:13 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D19412F
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sc31-20020a1709078a1f00b0077ef3eec7d7so5441409ejc.16
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=oN1DmmB5hIGSextjMwU3Vnw2pm00V4zpd8aSRnyHf0Q=;
        b=HBcCaYgx3GOtGCD6vnRBTt3kop2ZY2C8h5F9Ts8g8FkVWY7Gs7+q7OujqY0j58mgyQ
         PpKv7dBrhRa+ULEFZpq6YIT9w4lLPJ3o23t1xy0FoDWMsuNH+5woxQMACI2EuJ0T06Fk
         TQpHI9dVcGN06VXZ17nt89f3hGpMkQO1B4jODqCAJBkjoP8KIDq6UcAT4rCV9jZa2ghf
         6IC/hqZCHCxTjCfjDa3/RbfIoLX91TF8zSHe2qs82MOMbXBLbenq9eBUsVb3VSvh8+SB
         RdQyFUC4o4BFHFnVb96baewEylVhQuM+iDRPQR9M1/qp1ZO94YJAenY82wc+l2ZQVZqV
         A61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=oN1DmmB5hIGSextjMwU3Vnw2pm00V4zpd8aSRnyHf0Q=;
        b=W2hNhJJboxrsRnxTtCIPkexiNKHHBybKu53IbOeVlKtVsv0ujdwv471PFurFdsuwkA
         YoQvHfZyVyCiTcNJFJuU4KNn0H7WY6voedP5+ihmPjnOfN+qVvTt/IC/dhCQUYNvDkFI
         TpphxeWucKCckr/zeKVOsu2HbZTy6zlmAsVvy5XiEBujE/C394C654gdB+eNUB+9YXez
         IPQBYKrezLk5xgTZ/N5bLhL8lcpCIe8LOD19Oai455mxLfIBhIQXYGkBFwX1pxyDKCrU
         fPXS3fmGGlQhfOwooUJTFRGA+z4QVGEcbzZxsZ3zaPyhY+2e3s2NB4p1RgxFbAHpJy4C
         6+QA==
X-Gm-Message-State: ACrzQf0IIY8VOAn5IHkrlCSUd/UM7ur5bAP6TPyLQD6bdKR+0EOi7G4G
        uDolFN/KzBu2xVeCUAR/SzLBOyaD+Wk=
X-Google-Smtp-Source: AMsMyM6lsL6b9WP5OjlGGCg3dKk2Bj9nZi0tLG7AoCO3goElJf/yGauNpy2SVmCPAv5cw8xVUpzz1lwDIpM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:2694:b0:450:d537:f6d6 with SMTP id
 w20-20020a056402269400b00450d537f6d6mr275499edd.344.1663254335996; Thu, 15
 Sep 2022 08:05:35 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:55 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-22-glider@google.com>
Subject: [PATCH v7 21/43] dma: kmsan: unpoison DMA mappings
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

KMSAN doesn't know about DMA memory writes performed by devices.
We unpoison such memory when it's mapped to avoid false positive
reports.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move implementation of kmsan_handle_dma() and kmsan_handle_dma_sg() here

v4:
 -- swap dma: and kmsan: int the subject

v5:
 -- do not export KMSAN hooks that are not called from modules

v6:
 -- add a missing #include <linux/kmsan.h>

Link: https://linux-review.googlesource.com/id/Ia162dc4c5a92e74d4686c1be32a4dfeffc5c32cd
---
 include/linux/kmsan.h | 41 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c  | 10 +++++---
 mm/kmsan/hooks.c      | 59 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e00de976ee438..dac296da45c55 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_KMSAN_H
 #define _LINUX_KMSAN_H
 
+#include <linux/dma-direction.h>
 #include <linux/gfp.h>
 #include <linux/kmsan-checks.h>
 #include <linux/types.h>
@@ -16,6 +17,7 @@
 struct page;
 struct kmem_cache;
 struct task_struct;
+struct scatterlist;
 
 #ifdef CONFIG_KMSAN
 
@@ -172,6 +174,35 @@ void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
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
@@ -254,6 +285,16 @@ static inline void kmsan_iounmap_page_range(unsigned long start,
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
index 27f272381cf27..33437d6206445 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -10,6 +10,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/kmsan.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -156,6 +157,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	kmsan_handle_dma(page, offset, size, dir);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -194,11 +196,13 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 
-	if (ents > 0)
+	if (ents > 0) {
+		kmsan_handle_dma_sg(sg, nents, dir);
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
-	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO && ents != -EREMOTEIO))
+	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
+				ents != -EIO && ents != -EREMOTEIO)) {
 		return -EIO;
+	}
 
 	return ents;
 }
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5c0eb25d984d7..563c09443a37a 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -10,10 +10,12 @@
  */
 
 #include <linux/cacheflush.h>
+#include <linux/dma-direction.h>
 #include <linux/gfp.h>
 #include <linux/kmsan.h>
 #include <linux/mm.h>
 #include <linux/mm_types.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -243,6 +245,63 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
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
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
-- 
2.37.2.789.g6183377224-goog

