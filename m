Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6853B843
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiFBLyI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiFBLyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 07:54:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429B1DA40;
        Thu,  2 Jun 2022 04:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8DD8B81F08;
        Thu,  2 Jun 2022 11:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B42DC385A5;
        Thu,  2 Jun 2022 11:53:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, WANG Xuerui <git@xen0n.name>
Subject: [PATCH V14 06/24] LoongArch: Add writecombine support for drm
Date:   Thu,  2 Jun 2022 19:51:23 +0800
Message-Id: <20220602115141.3962749-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220602115141.3962749-1-chenhuacai@loongson.cn>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch maintains cache coherency in hardware, but its WUC attribute
(Weak-ordered UnCached, which is similar to WC) is out of the scope of
cache coherency machanism. This means WUC can only used for write-only
memory regions.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/drm_vm.c         | 2 +-
 drivers/gpu/drm/ttm/ttm_module.c | 2 +-
 include/drm/drm_cache.h          | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index e957d4851dc0..f024dc93939e 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -69,7 +69,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
 	pgprot_t tmp = vm_get_page_prot(vma->vm_flags);
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
-    defined(__mips__)
+    defined(__mips__) || defined(__loongarch__)
 	if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
 		tmp = pgprot_noncached(tmp);
 	else
diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index a3ad7c9736ec..b3fffe7b5062 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -74,7 +74,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
 #endif /* CONFIG_UML */
 #endif /* __i386__ || __x86_64__ */
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
-	defined(__powerpc__) || defined(__mips__)
+	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
 	if (caching == ttm_write_combined)
 		tmp = pgprot_writecombine(tmp);
 	else
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index 22deb216b59c..08e0e3ffad13 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -67,6 +67,14 @@ static inline bool drm_arch_can_wc_memory(void)
 	 * optimization entirely for ARM and arm64.
 	 */
 	return false;
+#elif defined(CONFIG_LOONGARCH)
+	/*
+	 * LoongArch maintains cache coherency in hardware, but its WUC attribute
+	 * (Weak-ordered UnCached, which is similar to WC) is out of the scope of
+	 * cache coherency machanism. This means WUC can only used for write-only
+	 * memory regions.
+	 */
+	return false;
 #else
 	return true;
 #endif
-- 
2.27.0

