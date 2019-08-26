Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050DF9C9BC
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfHZG75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 02:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfHZG75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 02:59:57 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D782C217F4;
        Mon, 26 Aug 2019 06:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566802795;
        bh=a5Ew7eb6cqPDgQY6v0geKQo8QWx+WuyGsAB/zRhoQ/I=;
        h=From:To:Cc:Subject:Date:From;
        b=a2U8wbAFJLIR89Zxq31tq9JRzjmOOjQJHb7wO5PTtR/bOZKg+M/C6mhPXZDDh007f
         r8q1YkZE0lzMS1O8W5bStqwkfe3mXUzmWAbDTUr2qH96+VAsPzDuWkPioZu+WjAdhs
         kri6KgWXXub6+7p2hRaG7E2NsdgXBq+M+xgvOta8=
From:   guoren@kernel.org
To:     arnd@arndb.de, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mm@kvack.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [RESEND PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Date:   Mon, 26 Aug 2019 14:59:33 +0800
Message-Id: <1566802773-24707-1-git-send-email-guoren@kernel.org>
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

Change to V2:
 - Fixup compile error with xa_lock*(&mapping->i_pages)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/csky/abiv1/cacheflush.c         | 20 ++++++++++++++++++
 arch/csky/abiv1/inc/abi/cacheflush.h | 41 +++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 12 deletions(-)

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
index fce5604..79ef9e8 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -4,26 +4,49 @@
 #ifndef __ABI_CSKY_CACHEFLUSH_H
 #define __ABI_CSKY_CACHEFLUSH_H
 
-#include <linux/compiler.h>
+#include <linux/mm.h>
 #include <asm/string.h>
 #include <asm/cache.h>
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
-#define flush_cache_mm(mm)			cache_wbinv_all()
+#define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
 #define flush_cache_dup_mm(mm)			cache_wbinv_all()
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+extern void flush_kernel_dcache_page(struct page *);
+
+#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
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

