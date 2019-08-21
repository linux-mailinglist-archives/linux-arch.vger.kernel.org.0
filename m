Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4397917
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHUMTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 08:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfHUMTJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 08:19:09 -0400
Received: from localhost.localdomain (unknown [115.192.185.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364E22064A;
        Wed, 21 Aug 2019 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566389948;
        bh=2vTVijIKerGwLwYL3OK2HwY2DFPeS1bOXJsN7S4xNGw=;
        h=From:To:Cc:Subject:Date:From;
        b=WCuKrc9o7kI2KV1JIfxjPbljZffvLhDuJTYAZwdcQQM125nzwWgEHMbJvde4lWE8w
         cLVM0ljVYRY2ZJZQ1lxTm7rc1kkzLg9uau4LEbBIYuEnf5SIt2S5fiCYcbaFYoTA42
         /4il9T6iT/48YLJ1yDhsoDD79Bf4ZZtdSI9twTPE=
From:   guoren@kernel.org
To:     arnd@arndb.de, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, douzhk@nationalchip.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Fixup 610 vipt cache flush mechanism
Date:   Wed, 21 Aug 2019 20:18:16 +0800
Message-Id: <1566389896-6972-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

610 has vipt aliasing issue, so we need to finish the cache flush
apis mentioned in cachetlb.rst to avoid data corruption.

Here is the list of modified apis in the patch:

 - flush_kernel_dcache_page      (new add)
 - flush_dcache_mmap_lock        (new add)
 - flush_dcache_mmap_unlock      (new add)
 - flush_kernel_vmap_range       (new add)
 - invalidate_kernel_vmap_range  (new add)
 - flush_anon_page               (new add)
 - flush_cache_range             (new add)
 - flush_cache_vmap              (flush all)
 - flush_cache_vunmap            (flush all)
 - flush_cache_mm                (only dcache flush)
 - flush_icache_page             (just nop)
 - copy_from_user_page           (remove no need flush)
 - copy_to_user_page             (remove no need flush)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/csky/abiv1/cacheflush.c         | 20 ++++++++++++++++++
 arch/csky/abiv1/inc/abi/cacheflush.h | 39 ++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index fee99fc..9f1fe80 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -54,3 +54,23 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 			icache_inv_all();
 	}
 }
+
+void flush_kernel_dcache_page(struct page *page)
+{
+	struct address_space *mapping;
+
+	mapping = page_mapping_file(page);
+
+	if (!mapping || mapping_mapped(mapping))
+		dcache_wbinv_all();
+}
+EXPORT_SYMBOL(flush_kernel_dcache_page);
+
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+	unsigned long end)
+{
+	dcache_wbinv_all();
+
+	if (vma->vm_flags & VM_EXEC)
+		icache_inv_all();
+}
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index fce5604..17eeebe 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -11,19 +11,42 @@
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
-#define flush_cache_mm(mm)			cache_wbinv_all()
+#define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
 #define flush_cache_dup_mm(mm)			cache_wbinv_all()
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+extern void flush_kernel_dcache_page(struct page *);
+
+#define flush_dcache_mmap_lock(mapping)   spin_lock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_unlock(mapping) spin_unlock_irq(&(mapping)->tree_lock)
+
+static inline void flush_kernel_vmap_range(void *addr, int size)
+{
+	dcache_wbinv_all();
+}
+static inline void invalidate_kernel_vmap_range(void *addr, int size)
+{
+	dcache_wbinv_all();
+}
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma,
+			 struct page *page, unsigned long vmaddr)
+{
+	if (PageAnon(page))
+		cache_wbinv_all();
+}
+
 /*
  * if (current_mm != vma->mm) cache_wbinv_range(start, end) will be broken.
  * Use cache_wbinv_all() here and need to be improved in future.
  */
-#define flush_cache_range(vma, start, end)	cache_wbinv_all()
-#define flush_cache_vmap(start, end)		cache_wbinv_range(start, end)
-#define flush_cache_vunmap(start, end)		cache_wbinv_range(start, end)
+extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+#define flush_cache_vmap(start, end)		cache_wbinv_all()
+#define flush_cache_vunmap(start, end)		cache_wbinv_all()
 
-#define flush_icache_page(vma, page)		cache_wbinv_all()
+#define flush_icache_page(vma, page)		do {} while (0);
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
 
 #define flush_icache_user_range(vma,page,addr,len) \
@@ -31,19 +54,13 @@ extern void flush_dcache_page(struct page *);
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	cache_wbinv_all(); \
 	memcpy(dst, src, len); \
-	cache_wbinv_all(); \
 } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-	cache_wbinv_all(); \
 	memcpy(dst, src, len); \
 	cache_wbinv_all(); \
 } while (0)
 
-#define flush_dcache_mmap_lock(mapping)		do {} while (0)
-#define flush_dcache_mmap_unlock(mapping)	do {} while (0)
-
 #endif /* __ABI_CSKY_CACHEFLUSH_H */
-- 
2.7.4

