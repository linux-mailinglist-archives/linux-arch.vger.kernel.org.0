Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406145AD2EA
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiIEMab (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiIEM37 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:29:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97C60538
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f12-20020a25b6cc000000b0069a9e36de26so6608056ybm.16
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2KqHkwy5ct3iw6Sq4tv6KYhLxwZCRI8E9SKEfBphS/w=;
        b=qNMo5+TEtHEFzd8X93C0KJLOfuW+bl/+NTRUdie3mml96pmEn+N4vH73TD76K9APOw
         x7lr9Ow00o8rBQaSj9JRLCw662OfSNPqEe7f0LMhZDSdpqWcmum4NxKT+HVgyu3RyfBD
         dIjUpK8ttDmqfrKCMUsqSsU8IJsy5EHQp/h4UYlDNXZbXTIcCguHSUJEjjrD3MIdBnjM
         ew66vj+qOTIITQCyAZ7Jxljq9KU96gFXJ0ue/bUGJurejXqSQnhg1ok6o1QRgjbXNuIp
         lffKoMG7G7gn7zuofcQknS310KI34IZsJjruVPp2PdPve0UziuK5oNrmj/4uXS8iYknC
         7H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2KqHkwy5ct3iw6Sq4tv6KYhLxwZCRI8E9SKEfBphS/w=;
        b=RphfwjKBgiYDIFnl8Gmf2E4nEdahROgWtMdKaD/sAaMlhKlHpzz3nj/lLnRTcGgdlH
         PSnGsd9aOeQoT7f4lxwlKTQf5P1Vci/zBhEZS3JTubE5W9KoC2Eg3sQ7UwBOGMrFgVD8
         IVufLyMrAMSLHPkISyAwy0+RxrjHHOC1J1W2AdxnbYdkm07GBL491wGaWSuXI0LFPIoy
         X3HLu8aNZxUGeKl+NDDTT51cyx/9wsnjZjrYkMvcMFzvjb0LNL8ainhBBmugvG/oNjsP
         t9UDk2132iw4sySCmoJBmDMyWP+7z/B0cOufALPfz3lQrCVEXr9m4L7vAmsAyJGYJ/3I
         cRhA==
X-Gm-Message-State: ACgBeo0W3DSP7yiN+wvMMZqY8KM/cdRMi48D4qzZq3k/LCDVNMuIfWjD
        CoEIrW6U3Gr0kvCnYqnN/Xik8K+2rhw=
X-Google-Smtp-Source: AA6agR51nX2bLBt0cmW3C7LjTsMe0MSSnl7E/OhkmGQFZLdUXmzJbRciuD6fyHf0emq6ppsHqPpy+bgoLPI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a5b:549:0:b0:677:768b:2784 with SMTP id
 r9-20020a5b0549000000b00677768b2784mr34118519ybp.296.1662380763627; Mon, 05
 Sep 2022 05:26:03 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:32 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-25-glider@google.com>
Subject: [PATCH v6 24/44] kmsan: handle memory sent to/from USB
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

Depending on the value of is_out kmsan_handle_urb() KMSAN either
marks the data copied to the kernel from a USB device as initialized,
or checks the data sent to the device for being initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- move kmsan_handle_urb() implementation to this patch

v5:
 -- do not export KMSAN hooks that are not called from modules

v6:
 -- use <linux/kmsan.h> instead of <linux/kmsan-checks.h>

Link: https://linux-review.googlesource.com/id/Ifa67fb72015d4de14c30e971556f99fc8b2ee506
---
 drivers/usb/core/urb.c |  2 ++
 include/linux/kmsan.h  | 15 +++++++++++++++
 mm/kmsan/hooks.c       | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929f..9f3c54032556e 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
+#include <linux/kmsan.h>
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
index dac296da45c55..c473e0e21683c 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -18,6 +18,7 @@ struct page;
 struct kmem_cache;
 struct task_struct;
 struct scatterlist;
+struct urb;
 
 #ifdef CONFIG_KMSAN
 
@@ -203,6 +204,16 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
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
@@ -295,6 +306,10 @@ static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 {
 }
 
+static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 563c09443a37a..79d7e73e2cfd8 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -18,6 +18,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/usb.h>
 
 #include "../internal.h"
 #include "../slab.h"
@@ -245,6 +246,21 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
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
2.37.2.789.g6183377224-goog

