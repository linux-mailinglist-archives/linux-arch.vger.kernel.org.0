Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7096563562
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiGAO1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiGAO0K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:26:10 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC545796
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id w5-20020a056402268500b0043980311a5fso1407218edd.3
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+K29lQHYx/QboL6+Fy2jFmZJqrUMV6q0RSetNFINlHU=;
        b=Lp2eEEvz0+TgiBntUx4ua/9fGqKccdfR6XH7uHLacnvYo4bPCaLpszQq+8mA0Y5gts
         YCzUjj3dnLK0eoahSun1hhzXa9zo2wYpNUMZwR4kY7OA35DYyKZ9LQhFeSUbQH6W8LBU
         cEi1G7HBTkR7zPLvT/TESyx9jjytrH3anjLjFrwMdooDJEmIyePYHuF/VlAGlAiBGHgQ
         /2HrW5IdeOp02Byommjy5nWcpNJpE2ztvAY4y3tZZGaGC81RVSmcis/j1833duSMcHp5
         Z+3w/2IiHJlg4Mg0b3tNbahk09J0jUi+gYRmg2qSYy97kQYMJVderfkH45qNQi5yNzLp
         8KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+K29lQHYx/QboL6+Fy2jFmZJqrUMV6q0RSetNFINlHU=;
        b=eSqJGR00QlliXQqEZpWMPlVjzY345E0tDnNLf3etZDBN5mk8MqaN1EZRkDKf1tasDJ
         kYMQ5aMMmMfl7zPsaYfaMl5MhY+9tu4QSnDpGNHtWJ7IdDfsusYNohNzUEHVQP5L1omo
         rfUpkRq+fdDUl/KSzR3fuZQU+2kDbNgGAA0M9J7SZmQj7tOT3ItiD+DO656kcIwW7RIx
         jLVWnWpd0PogtJvsUbSjEELtQVVN3W7OMFE2qoGcmF+36H/uPgrL0CCVAG8A2Gj15HxJ
         CmGXQAbRBKVKjKz+UJzMMUrD/M+9wqZpK6q1FWDrjpHTT1qFqsCM4f7xjVTnfuTvv1yn
         LsVA==
X-Gm-Message-State: AJIora/61ee2fBS+WjeLYrOYIr88wN0mc35ai6kYwn7cmhBp+seb5Mbl
        KVOB7V058g+QVh2BjndH5ow1xYZuB0Q=
X-Google-Smtp-Source: AGRyM1v+DIWwLp7Wzl6B8tncc37UxB9rTXYufdTzcwNSGLPhyYz8kU9A/vUtw7VqYleTmtYO9LI0fVniQsI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id
 s26-20020a056402015a00b0043171b986f3mr18869662edu.249.1656685459864; Fri, 01
 Jul 2022 07:24:19 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:48 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-24-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 23/45] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
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
index 13a7348cedfff..2d42a4b38e628 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan-checks.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
@@ -329,8 +330,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
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
2.37.0.rc0.161.g10f37bed90-goog

