Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5B78B46A
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjH1P0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjH1PZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 11:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D6E0;
        Mon, 28 Aug 2023 08:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0502B6159F;
        Mon, 28 Aug 2023 15:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87380C433C7;
        Mon, 28 Aug 2023 15:25:49 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiantao Shan <shanjiantao@loongson.cn>
Subject: [PATCH] LoongArch: Remove shm_align_mask and use SHMLBA instead
Date:   Mon, 28 Aug 2023 23:25:40 +0800
Message-Id: <20230828152540.1194317-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Both shm_align_mask and SHMLBA want to avoid cache alias. But they are
inconsistent: shm_align_mask is (PAGE_SIZE - 1) while SHMLBA is SZ_64K,
but PAGE_SIZE is not always equal to SZ_64K.

This may cause problems when shmat() twice. Fix this problem by removing
shm_align_mask and using SHMLBA (SHMLBA - 1, strctly) instead.

Reported-by: Jiantao Shan <shanjiantao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/cache.c      |  1 -
 arch/loongarch/mm/mmap.c       | 12 ++++--------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 72685a48eaf0..6be04d36ca07 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -156,7 +156,6 @@ void cpu_cache_init(void)
 
 	current_cpu_data.cache_leaves_present = leaf;
 	current_cpu_data.options |= LOONGARCH_CPU_PREFETCH;
-	shm_align_mask = PAGE_SIZE - 1;
 }
 
 static const pgprot_t protection_map[16] = {
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index fbe1a4856fc4..c99c8015651a 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -8,12 +8,8 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 
-unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
-EXPORT_SYMBOL(shm_align_mask);
-
-#define COLOUR_ALIGN(addr, pgoff)				\
-	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
-	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
+#define COLOUR_ALIGN(addr, pgoff)			\
+	((((addr) + (SHMLBA - 1)) & ~(SHMLBA - 1)) + (((pgoff) << PAGE_SHIFT) & (SHMLBA - 1)))
 
 enum mmap_allocation_direction {UP, DOWN};
 
@@ -40,7 +36,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		 * cache aliasing constraints.
 		 */
 		if ((flags & MAP_SHARED) &&
-		    ((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
+		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
 	}
@@ -63,7 +59,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	}
 
 	info.length = len;
-	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
+	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 
 	if (dir == DOWN) {
-- 
2.39.3

