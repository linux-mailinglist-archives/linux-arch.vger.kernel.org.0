Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F4510443
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353277AbiDZQvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353267AbiDZQtd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:49:33 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6707634D
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:29 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hs26-20020a1709073e9a00b006f3b957ebb4so838084ejc.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kXck7gc8vUdG+uIpTKbHiyCLJU3V9DKcF3fYel7nQCw=;
        b=HKjl4po9qikfY5w7sANNOWF8wIYoTZhGhPfGpG2oRS5qaieTXeddZbMui9oEk30REF
         GfljSR8S1QIxGgAiHnxwjgEv6+EF2+8jJ7T7QZK2oSf8eJtoGjdxW0lf0sHwGI/lNoOh
         KSwqI4UvdZtVfWHWxZE/JKd/uRDNjbPmLMNeGT3iF7SCfBSOExZCHwBizTIx/FZ301Kf
         goPWSOE0bCzYKGYIAeB4b4w+/WYrsLZPjYvsQGeev90WIWm90jQbop08KYN+ktuukkjW
         eqLwPo+Y1By7UOL4GBv0clQvJfdJAgsm6ae+0ok9ios/vlSXb1rGqpnveoFRq063DiYQ
         GxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kXck7gc8vUdG+uIpTKbHiyCLJU3V9DKcF3fYel7nQCw=;
        b=lntSxiWjMcXbhU61Eque6WdClkrmdUHtq2IBgGUEeEMn3UHo0C4Dxt7X826nQUHBuu
         SIJQMreFgeOMyitm6jZGaT5Cp6uwjwLDgPFzEVjj57IKtObmSxbVoo3NPbxaicWp6DPx
         y3Eer+mIZGRkys6/dnNelTkEqgp17kVKVKBA7sBEmBzpDcIAShVBR9L16TIgzEG8Cwud
         vAUGL5y54klTAAd7JkrWzxwIS9HQfMv4SYAyX3p5CRy//PbQI3lQnAYi+dMBroNbPL9P
         q23USt/IEJ3Rv77Ug84j9Xwc4v1RB1Ww91XkyNHZObwHWRPn90Fu19NARw2+qVOanQl9
         p7iQ==
X-Gm-Message-State: AOAM53264BIuCQ5VpO8LjPtUSKlPJoA9rVTdU2TMvWijHNiF9wulVWTp
        qyPe4asDgWmFq79rFbu+r7bY9UKak+8=
X-Google-Smtp-Source: ABdhPJz2TfzAbBIJqBzng2cj5zaotZzRLvL6/wlz3cGmkr5GPkO9jG7+a46FVlyYEs+vMIVeqbruPJFqxPk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:907:1b15:b0:6d7:13bd:dd62 with SMTP id
 mp21-20020a1709071b1500b006d713bddd62mr21844408ejc.673.1650991528244; Tue, 26
 Apr 2022 09:45:28 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:55 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-27-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 26/46] kmsan: handle memory sent to/from USB
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

Depending on the value of is_out kmsan_handle_urb() KMSAN either
marks the data copied to the kernel from a USB device as initialized,
or checks the data sent to the device for being initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- move kmsan_handle_urb() implementation to this patch

Link: https://linux-review.googlesource.com/id/Ifa67fb72015d4de14c30e971556f99fc8b2ee506
---
 drivers/usb/core/urb.c |  2 ++
 include/linux/kmsan.h  | 15 +++++++++++++++
 mm/kmsan/hooks.c       | 17 +++++++++++++++++
 3 files changed, 34 insertions(+)

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
index d8667161a10c8..55f976b721566 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -20,6 +20,7 @@ struct page;
 struct kmem_cache;
 struct task_struct;
 struct scatterlist;
+struct urb;
 
 #ifdef CONFIG_KMSAN
 
@@ -236,6 +237,16 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
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
@@ -328,6 +339,10 @@ static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 {
 }
 
+static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 8a6947a2a2f22..9aecbf2825837 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -17,6 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/usb.h>
 
 #include "../internal.h"
 #include "../slab.h"
@@ -252,6 +253,22 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
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
+EXPORT_SYMBOL(kmsan_handle_urb);
+
 static void kmsan_handle_dma_page(const void *addr, size_t size,
 				  enum dma_data_direction dir)
 {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

