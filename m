Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECF4F0F40
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377439AbiDDGWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbiDDGWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:34 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC13377D3;
        Sun,  3 Apr 2022 23:20:30 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Br008244;
        Mon, 4 Apr 2022 15:20:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Br008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053207;
        bh=0K4SM890AXVb9yL32lizEN5lNqgMqpVmCB0ZtXPBQyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9sOVL7DA9P1ovJNmmoz7LYEGMQKCHLFRHXEpGNhEXtt+Uy88Shx9J83GxKAgZL7O
         a0eW/hvcWw4w6A5g8udfkNRqpro8cNGENMVvQq8Pef0RkfvMPM5g1IOtNnQynfxBOB
         3eWHDPVwXH8t+3D/PA6Cs3OFs+Bfgh2XN5XSleshCAONgvIFeo7mYd1FSluNCMYKO1
         Xn2KJiyT7MBQFoXTVueG8ZD9TMPl04HoCpzBSBAykHG9bzoG+Mwp6pEC4AMiJtjLVh
         hG2d3j9Pc99bjsOUMhm7s8T36l2zu8Z2Pjg02tFwvrFDysrZcUBkRgkGu3Dy1m/hZP
         wDawh5v4NlwEQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from exported header
Date:   Mon,  4 Apr 2022 15:19:48 +0900
Message-Id: <20220404061948.2111820-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd mentioned a limitation when including <stdint.h> from UAPI
headers. [1]

Besides, I'd like exported headers to be as compliant with the
traditional C as possible.

In fact, the UAPI headers are compile-tested with -std=c90 (see
usr/include/Makefile) even though the kernel itself is now built
with -std=gnu11.

Currently, include/uapi/linux/virtio_ring.h includes <stdint.h>
presumably because it uses uintptr_t.

Replace it with __kernel_uintptr_t, and stop including <stdint.h>.

[1]: https://lore.kernel.org/all/CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/virtio_ring.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 476d3e5c0fe7..6329e4ff35f4 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -31,9 +31,7 @@
  * SUCH DAMAGE.
  *
  * Copyright Rusty Russell IBM Corporation 2007. */
-#ifndef __KERNEL__
-#include <stdint.h>
-#endif
+
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
@@ -196,7 +194,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
-	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
+	vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
 
-- 
2.32.0

