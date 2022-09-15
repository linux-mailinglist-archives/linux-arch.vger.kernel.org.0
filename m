Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A235B9E4F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiIOPIv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiIOPHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:07:15 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364779677E
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:40 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id x5-20020a05640226c500b00451ec193793so8530382edd.16
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=lOWe2UvDp+lzLw75WkGUXRoANIiWBb139LkOr44Ytus=;
        b=r8zwtK7nR6FXPBS442hkgib03/UyNe7gNUiweombLjUeUOwj8SF20sAORY+JgIxfJC
         xdQzkfFn7/UIZp6qs2BkVURbVTIpmVyq4CogUpIZzqnkOvB4czCVAsUxHuaXyYzg7wYj
         iSHZbV2gUMNZdtwTkVyP2zImSyDUIobXdqb3vW/gaStenqfHXMWXmhtPDGK7i0t2+x+V
         LX9ocp5gmEP0hXd6aLkG4expCb4w3nGprape1+X4fjnbTnlSElSS0OcneVvlkPCu1k1v
         zulBsEXPwjPW//HgEDA7XFR0M2WbDQmJA13wrulrEaaWrxCq8Z7S8FbCgch7VF6L5ax7
         LfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=lOWe2UvDp+lzLw75WkGUXRoANIiWBb139LkOr44Ytus=;
        b=tKySQdqh5JFcaCYqJBfoVMHD9R7r6+PFg5aSa8Cz6b+YXHNLgVMWfoJtmyQ+gCTr1I
         6DRHYb0/LN340THu80f1d1eRdR8m0ljOJBRqX7rSSjUT04kEUIegAz0aVHw02xDLUqb+
         RHwobQX/LvfWIppo3zc0cWSmOEDhDq0VFtONwIWNVeDqVr5rYrzIEWPXYPtCdps4FKIv
         RArVOO1Z7GSqvvsTv3wZ642/rZp8p19EL8SF8RAVFBC7be3PvxY9Ps8h7iPwYDBCtotV
         SQx/WTe3eqI94Om1IIyRyzvo+a9zO6gmYXJFG7pYOCIP/jGnMeGO/fnd9boJRYYr9P+q
         PC/A==
X-Gm-Message-State: ACrzQf34XrlveXP5hGgW1GGfb7M/+lXAAVLLmAsShq0dLXeJMl6ip8tv
        QIjqXiz5wTTGY/ncR63XGHEqWathTDw=
X-Google-Smtp-Source: AMsMyM6XUfiL29ncKe/ZK/EpTsQsoLddOpxaN22/2HU0VmNdXXQuif+Od6cd/SXFxh2r6j465cljcQVOjxc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr326676ejs.190.1663254338524; Thu, 15 Sep
 2022 08:05:38 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:56 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-23-glider@google.com>
Subject: [PATCH v7 22/43] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

v6:
 -- use <linux/kmsan.h> instead of <linux/kmsan-checks.h>

Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4620e9d79dde8..8974c34b40fda 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/kmsan.h>
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
2.37.2.789.g6183377224-goog

