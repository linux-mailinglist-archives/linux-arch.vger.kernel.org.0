Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8178510442
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbiDZQvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353305AbiDZQtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:49:11 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9413D4BD
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:27 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso10618114edb.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n12oscJoQy25ZeJEgKUppRaHioaFclURl8PsqxmYCmo=;
        b=PIyBhpOCM8Ov1/+Aan+YSMRBfpf54pHX8ytL+CV9/1wxPrduFClfDo2MC25BFRGqUr
         LC5Hr2Ef8nJt4G1Cr30fbnTHYjTJ5Gax8GaKjFXG0iL+r/c29mApiZT+RSwu1Gv2kkOz
         34uVLpDsIsKTbG2q42gMn4a9Vr9GOVlaxiLfXa8b/4pWebY6TjT2x9JFCSEXRuOPPg3n
         b/OGc6pwoUP/SU7+PJ629KnVXCQHZctVc5m6qyPQPfIcXk7XKqS9AYp6qyxiblVFksU/
         vePEsS5V3b8GJxiZEtgsjh4z7hZSSCwDY93JM9PnMnCLZhZrlsTx6bFvrt7KV12fLlqe
         re3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n12oscJoQy25ZeJEgKUppRaHioaFclURl8PsqxmYCmo=;
        b=BfjcXfvMzZmDUZ7VLTYIlNZQN10OX1OKvRTJvMCocwXexnpaJ3tQWrvlISnfuWujP+
         Zwsqi3e2XFsR9VEIx3VQUFXfEoiBQi+dMmX3nMys38KXI/Py07xxqqjRSH2O4+14D1Yu
         4Sjc9fYveubVMI5530JtZx9DgjORVLU2XEPhS2cHzOiPIm8pVfMgG1cQ+KhUmwHbuvst
         zvrh+/nljj6KsttSdELDwTxckHBL7SCzUcd21ZXraRPBEhsnxWk/sWg6Nk7UgUQc+gWE
         sYZXt/rafOdIKJ+Gj484ddGQyhniHlGDhbZ+VO7cJxUkW7thJTkkhFqoWxp/VEgRj7Gw
         iTKA==
X-Gm-Message-State: AOAM530T4lRTkVS50pGcmHj5IxZTLlaEPklhc7OHSuL23pHvi3iFUWmI
        N8jC4T0rIwbuLQt7k4P30paV+3b8pWI=
X-Google-Smtp-Source: ABdhPJxU8JwPhcVfaOXEOS2U2ep3mvLwmmcZHEz36qAom9R3kEeJAH/9Z6s5Sw7k1Wv/sYn9qCbZoM2w78E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:5210:b0:423:de77:2a4d with SMTP id
 s16-20020a056402521000b00423de772a4dmr25186177edd.295.1650991525861; Tue, 26
 Apr 2022 09:45:25 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:54 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-26-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 25/46] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
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
Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
---
 drivers/virtio/virtio_ring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238eb..faecd9e3d6560 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

