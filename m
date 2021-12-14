Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374134747CA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhLNQXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbhLNQXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D77C061757
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:06 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so4878831wrc.22
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RCylrb6G91/E/2vtsmKFgkT1r5eRWWtCKOMrnaR3rS0=;
        b=SC1C+6vpXr8HhRaNadHiQrHplXa2kTitGVDtEEVvo/VrrTc0GKtS90GfxGyyjv/uIU
         Gl/r4wNi4cjwD4k7LpB8i9yt1uiBCrmAnLNIaiGGNAa5OoTgjezb10lfEPoQ/GaeQqmf
         5qUDDqWGueIOP/FgPPX7tknIguxeVvNUN++V/9a+2dDpTxqjWw4PQpyEc8noRfwFoXyv
         xy6PPtcuiudOOiEZccKacAw0PDC4zXCg+pdnGBrwgtN8FZ+qpJpxq26TBTjQXuIXJ0Mi
         1/jfDPSYbAYAUEVRomUDfFdagkdwem60SUAf9u9FUETpXnhkyTL+cqPlolp9b8UvxxVm
         y5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RCylrb6G91/E/2vtsmKFgkT1r5eRWWtCKOMrnaR3rS0=;
        b=dUMi3saiGFEIPMQD8vBfqwCCLzSEyZxEt1ESNs/AUOk+fQf4Cp6/BtLGWufgnsFJop
         0gF7326dCa8Q6I5HDQrRxEd70ZjGfTQAK2FM1n5DvGVkUkEBa2XUkqZi4FvHtd1SQ+Ca
         iMtIKpOanAGxRaj5z/+G0OyYq/6QyR0v3vM+QoBJ6mqxH/NQdAWYUuqOc3CmV5In1EqR
         vooZLrszxmb4riR0JQlaZ2O/KV4Nz4Ovgj0LV0nibgE15T6Mmi4x5149sMvakdKFIxB1
         TcN8oHaEl9+tDjtZDW4oOXpT3U2vxwEcHRVxG0Wm6eXwVGoyWfhwDyrP0hn9oDV1tC4z
         nGfg==
X-Gm-Message-State: AOAM531pNE9wndOgsRYPqcUQZ1s9QwTPvr4W8N704EU5NKQwfYocO9Iq
        qJPrM4FlmuehKvElFtR1Js0/LATq5Io=
X-Google-Smtp-Source: ABdhPJw9UBXdJlo13EpvnyI9qmtetaMmbSMsl/SrkoqoZXzI79hK6SLrS6tAUR/JTk3AKx81zpcHzTtcriI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:f088:: with SMTP id n8mr6603937wro.411.1639498984734;
 Tue, 14 Dec 2021 08:23:04 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:33 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-27-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 26/43] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If vring doesn't use the DMA API, KMSAN is unable to tell whether the
memory is initialized by hardware. Explicitly call kmsan_handle_dma()
from vring_map_one_sg() in this case to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6d2614e34470f..bf4d5b331e99d 100644
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
2.34.1.173.g76aa8bc2d0-goog

