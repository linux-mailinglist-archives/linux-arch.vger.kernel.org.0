Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1D4EAD78
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiC2Mps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiC2Mn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:43:57 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A8234578
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:40 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c22-20020a50f616000000b004196649d144so10957140edn.10
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Eb/Abij6XQ3iqbkwUGDaEHK0fSpQBifUF5HLZH6JcRc=;
        b=Krkj/S1jh5/H05+jCH+MSNkam2il8xetzlLh3mofzSw3z1EUZVLwTavHzuR07R13in
         fg9//+1CujBKky+Yg98dxF0i9pubcLdyg1zZweQ1XjNQleJiDN/XoHbConhYKPEsItrW
         Hqor3bLi18aLxBGMha4/9ZF65JCN2E/xs869FWNbVFPNZlCCTsmL0+sn19SYqkD+nycO
         8yokw7MAHVM6QSu96rl3jBfgqKH9wHHao396wVZYsEKnozljUrrFpvS6mVwzvzPs2PCk
         rZme07+nb4Ir4EhmUhbog2UgvqaC31UAfTNt+DsOKVK0oofUTAwJkiObvGLB48vzpwDI
         J6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eb/Abij6XQ3iqbkwUGDaEHK0fSpQBifUF5HLZH6JcRc=;
        b=ZKLPmfv4uiJvztn0XpUP4q1y1s80mliz378FWAFz4U2ZxjgqsbRk1f/4OGNxB2Ujpz
         gpRWeMJLoGizGZhn0Z7yerIu+OdI4NFSsp38J9rfSTnkp0nDT7uElyshuev55yEMmrty
         CyOVHdoqHo3TKfnp7taywmX4FOIAYt/hGNJxjDIbSO/9usHvR8zCINyQcA+pWjivbIlx
         TrPo3bHhHH/v8U0R5+w/4jXKCxyIzGnjqYLjyZvv1oBmEkGTPYMvlUgLyBRrJYTL9UUB
         NxSKL4Bj7+bs4QRQI4FY6pZDD2DTX3fQwJWOHhe3XDWXGHTS/FjDMZRC0hnhO1oSGI81
         gWNQ==
X-Gm-Message-State: AOAM532RRFbcCVpOgiqHYVA1L786hcb7YHoKR/e6oGCMW9FpvSVfOWQj
        yuvGf1u7jVqAvtevl/tSF0R/rryW830=
X-Google-Smtp-Source: ABdhPJxL1GeaEMAohn+FBay8BfgBp3WhpguNB4XCKO3e3e1LP1mlhUbZL/tt/mlN/CXlhJVrae+cgzEdiVU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:7f09:b0:6e0:395d:cc88 with SMTP id
 qf9-20020a1709077f0900b006e0395dcc88mr34433043ejc.566.1648557698741; Tue, 29
 Mar 2022 05:41:38 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:55 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-27-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 26/48] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
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

If vring doesn't use the DMA API, KMSAN is unable to tell whether the
memory is initialized by hardware. Explicitly call kmsan_handle_dma()
from vring_map_one_sg() in this case to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

---
Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fab..461e08f7f0a0f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan-checks.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
@@ -331,8 +332,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 				   struct scatterlist *sg,
 				   enum dma_data_direction direction)
 {
-	if (!vq->use_dma_api)
+	if (!vq->use_dma_api) {
+		/*
+		 * If DMA is not used, KMSAN doesn't know that the scatterlist
+		 * is initialized by the hardware. Explicitly check/unpoison it
+		 * depending on the direction.
+		 */
+		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
 		return (dma_addr_t)sg_phys(sg);
+	}
 
 	/*
 	 * We can't use dma_map_sg, because we don't use scatterlists in
-- 
2.35.1.1021.g381101b075-goog

