Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693B85A2ABF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbiHZPND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244807AbiHZPME (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:12:04 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5213DEB72
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r20-20020a05640251d400b00446e3eee8a1so1242353edd.21
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=PLcPoxyp1Xs3M8CttNEhz4gH6ZMFq0yiGHMdwreSHbw=;
        b=eh86TxxX8CwLNIBltPXsm5933LECqY2eAlL/5pBl4nWbjLT9wwFJMOBUyie0dUx/gK
         N82SKr30PljWUvEhhV3/fUE7T4qgCesvwEM4KVHBlRwHJfYrj27gozIMUwRuSF5xcEdQ
         H894CHa15jZo0p4ubi/COw4OT1+/6PqIggnVwzZ+BFxk13rWrsC3JvKzP9SXV8kNUkWw
         FrowsNGwL8zWTGrIAcdj6cj5ZG+bP7h4Z/52tgm2GPymsQ498t6GXSFQ1gYV+/OZFD23
         v1gAArrhOq4so6cVSxA30W0GuwEXdIdz3gBKSYzqaYbpXdCyauICiavckkCPIg9Kvzky
         3pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=PLcPoxyp1Xs3M8CttNEhz4gH6ZMFq0yiGHMdwreSHbw=;
        b=I1DGAV+8YXisRvPl3aKMwD5MafkvESJPYEa2JRkZjzHJFVEjqz7JkMdTAN92ce714v
         h2VPXSChaXP2UAmQHAujvr/Go7uYxgxcd8QceHq9y8tuSCwMCKFNPsCjaJcfXsSPvXP0
         vQ39m0Ujc+ULtJ5vBLkXeRcTGGbAePzpBIvmfSfHlNMCXcDItnhKY08KViMDrU0HbkCR
         vuAwnqJVuTThRoC/spB6+GrAwvh5YYvDjLNCg2V0LK1WBxxLo9JxVuB6hvBk0txr51yU
         lDS2Hq45eZNPEhXjDOlK+y4zpTBDGHlk1eOEd/D5GhDKOhZpvkFhBvuSxz2Bg/LvvPoI
         dL8Q==
X-Gm-Message-State: ACgBeo2mPxXPoHsyFl90qfZ5APPu3owRmcWoSCQVtCA/cuB0zA6uPAXe
        Kr1kY2zrz9iEnRw0mOMmTlZH9IFREOc=
X-Google-Smtp-Source: AA6agR5Si5/g8lHkQ9CsnDZQfnsfIgUA6fce6EFE/ZPTPJJ8orAZDc8GQqAPENSTfPcrOej8JbL/c8L8O08=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:2804:b0:439:83c2:8be2 with SMTP id
 h4-20020a056402280400b0043983c28be2mr7114308ede.292.1661526559748; Fri, 26
 Aug 2022 08:09:19 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:47 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-25-glider@google.com>
Subject: [PATCH v5 24/44] kmsan: handle memory sent to/from USB
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

Depending on the value of is_out kmsan_handle_urb() KMSAN either
marks the data copied to the kernel from a USB device as initialized,
or checks the data sent to the device for being initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- move kmsan_handle_urb() implementation to this patch

v5:
 -- do not export KMSAN hooks that are not called from modules

Link: https://linux-review.googlesource.com/id/Ifa67fb72015d4de14c30e971556f99fc8b2ee506
---
 drivers/usb/core/urb.c |  2 ++
 include/linux/kmsan.h  | 15 +++++++++++++++
 mm/kmsan/hooks.c       | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929f..1fe3f23205624 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
+#include <linux/kmsan-checks.h>
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/usb/hcd.h>
@@ -426,6 +427,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 			URB_SETUP_MAP_SINGLE | URB_SETUP_MAP_LOCAL |
 			URB_DMA_SG_COMBINED);
 	urb->transfer_flags |= (is_out ? URB_DIR_OUT : URB_DIR_IN);
+	kmsan_handle_urb(urb, is_out);
 
 	if (xfertype != USB_ENDPOINT_XFER_CONTROL &&
 			dev->state < USB_STATE_CONFIGURED)
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index c6ae00e327e5e..84dddf3aa5f8b 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -19,6 +19,7 @@ struct page;
 struct kmem_cache;
 struct task_struct;
 struct scatterlist;
+struct urb;
 
 #ifdef CONFIG_KMSAN
 
@@ -227,6 +228,16 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir);
 
+/**
+ * kmsan_handle_urb() - Handle a USB data transfer.
+ * @urb:    struct urb pointer.
+ * @is_out: data transfer direction (true means output to hardware).
+ *
+ * If @is_out is true, KMSAN checks the transfer buffer of @urb. Otherwise,
+ * KMSAN initializes the transfer buffer.
+ */
+void kmsan_handle_urb(const struct urb *urb, bool is_out);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -319,6 +330,10 @@ static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 {
 }
 
+static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 41b6b41e6183a..58334fa32ff86 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -17,6 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/usb.h>
 
 #include "../internal.h"
 #include "../slab.h"
@@ -244,6 +245,21 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 }
 EXPORT_SYMBOL(kmsan_copy_to_user);
 
+/* Helper function to check an URB. */
+void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+	if (!urb)
+		return;
+	if (is_out)
+		kmsan_internal_check_memory(urb->transfer_buffer,
+					    urb->transfer_buffer_length,
+					    /*user_addr*/ 0, REASON_SUBMIT_URB);
+	else
+		kmsan_internal_unpoison_memory(urb->transfer_buffer,
+					       urb->transfer_buffer_length,
+					       /*checked*/ false);
+}
+
 static void kmsan_handle_dma_page(const void *addr, size_t size,
 				  enum dma_data_direction dir)
 {
-- 
2.37.2.672.g94769d06f0-goog

