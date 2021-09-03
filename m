Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FFF3FFD96
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbhICJ4g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhICJ4g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22FCC60FC4;
        Fri,  3 Sep 2021 09:55:32 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 04/22] LoongArch: Add writecombine support for drm
Date:   Fri,  3 Sep 2021 17:51:55 +0800
Message-Id: <20210903095213.797973-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch maintains cache coherency in hardware, but its WUC attribute
(Weak-ordered UnCached, which is similar to WC) is out of the scope of
cache coherency machanism. This means WUC can only used for write-only
memory regions.

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
index 7fcdef278c74..3dc43390e76b 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -60,7 +60,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
 		tmp = pgprot_noncached(tmp);
 #endif
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
-	defined(__powerpc__) || defined(__mips__)
+	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
 	if (caching == ttm_write_combined)
 		tmp = pgprot_writecombine(tmp);
 	else
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index cc9de1632dd3..5c1059435369 100644
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

