Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5095A2AC5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiHZPNB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbiHZPMB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:12:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E8DEB68
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dd097f993so29923707b3.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=XOIO6yMrJJaBLCVdiKJxecGrRstBRdkXKAU8JD1YObM=;
        b=RBRSbeDrL8qGQexUijKhcV3H7NuqN9uz8ZM5rQWAltRN3zhZJP9TKmmIf+p+yKdl6T
         3Am09npoAEtHEWxF/Bl4GBV+lvaWA+zyaViXoAoS6FK+zkjAU0V2E1ILS8x3lB5fXtKj
         9IHWzkzR0lKD9H/hxXtLbHPszHgU+gNR/ouI3pNZH7yhF0/W+C1cpcyiViY1J1iEBFY8
         /rQ0ukMFzwE2rHptS3PuB+v+/gBN3s2bGa1zvZC9PEceq+oso9Jptib23PUbkHkaJtUF
         ybmLJcK3rBbne7ulW3JpsBkspXiEuaq15wUwrHaqYN3CJnLRo71eoIyBsvku5gZs6p/s
         mp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XOIO6yMrJJaBLCVdiKJxecGrRstBRdkXKAU8JD1YObM=;
        b=UjKXv7g6J0Mczrvmj2j2lOIjvipTF0ux+HOU81GRMkf5X1l3Lad8VZbiJVKRqFUwGO
         fqs4vNRZ3Gd2whscGx2u6i6tnakFL/1xz5AKB7r9E+h+Q547uMacHrKJXDgSC1AEbhmL
         17+UwBpBYKX+mvtgdDcSmSptX9yUNm4uYJ5CS4dpcQ7GlRB5RbZTo6cuWCjlx7zJhVxq
         Kqg6F637Svmu1kDqaa5XavPSrTzG59viHmcyajZiRJ88l9ganW3SZVY+VVPTpVxPLh5V
         iQSj8Lu+zNdGjyC2RbdrxxJ5rRDN56j+iz8bTQ7QQ/7pVqhfnGCOCrnwQbkRps078Ns+
         NBgA==
X-Gm-Message-State: ACgBeo0fDbycsqcY9urRzbV34HNgI+huqCc7SVhJi1lXlGDihzB3yyAo
        OPK7HvCPEVMk/6PdA0kX+UMloYFkv58=
X-Google-Smtp-Source: AA6agR70pOgUYoVn/e77Ld0R/nqA9LDlWtFjFwsnYYnj15N1nfRnKaSK4PvjO0uXZsTDiRTt9eMo2zal+mA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a0d:e6cc:0:b0:338:c82b:9520 with SMTP id
 p195-20020a0de6cc000000b00338c82b9520mr151356ywe.66.1661526556996; Fri, 26
 Aug 2022 08:09:16 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:46 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-24-glider@google.com>
Subject: [PATCH v5 23/44] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
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

If vring doesn't use the DMA API, KMSAN is unable to tell whether the
memory is initialized by hardware. Explicitly call kmsan_handle_dma()
from vring_map_one_sg() in this case to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

---
v4:
 -- swap virtio: and kmsan: in the subject

Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4620e9d79dde8..a9f06ec5b3c27 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan-checks.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
@@ -352,8 +353,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
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
2.37.2.672.g94769d06f0-goog

