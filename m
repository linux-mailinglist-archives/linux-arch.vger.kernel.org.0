Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD036A617C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjB1Vi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB1ViF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54C34318;
        Tue, 28 Feb 2023 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4+4t1rqEiuqyoKPIj2cQSmuuKOyYNvfnS04rFEq3Bbw=; b=YjerQ6PU7LAW9NfRpaTaBoZkTX
        5pRbBMRHM6R06nY/z+O+qG6+GWpR68xxpcIPvXdcUCNlAUWSWOTbNaKWLYJRhtQyT99fSTpYhNEFo
        PzNX/9hgALt9UELLjVFRwIdXhiiGp5zb3T5hzElFR/BwNho/6u2XXPW52bnSSkeszWHCb2AI18Voj
        S1IL6qTAZevsZ80YCiEoZq5/vnPYMimwDo7jUtkPRXXjiObPNp7PSqiJuyJr/3lTtQOtx7UjPu3rc
        GxtqnEDXN60JlFU4FkBAufdlkdpAjnO3+St2uny78qm+t6sI8yjFd9GLEVkPfcGV20QAo7em/xW/g
        j+Gms1IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fK-0018qf-S8; Tue, 28 Feb 2023 21:37:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 29/34] mm: Rationalise flush_icache_pages() and flush_icache_page()
Date:   Tue, 28 Feb 2023 21:37:32 +0000
Message-Id: <20230228213738.272178-30-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the default (no-op) implementation of flush_icache_pages()
to <linux/cacheflush.h> from <asm-generic/cacheflush.h>.
Remove the flush_icache_page() wrapper from each architecture
into <linux/cacheflush.h>.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/cacheflush.h     |  5 +----
 arch/arc/include/asm/cacheflush.h       |  9 ---------
 arch/arm/include/asm/cacheflush.h       |  7 -------
 arch/csky/abiv1/inc/abi/cacheflush.h    |  1 -
 arch/csky/abiv2/inc/abi/cacheflush.h    |  1 -
 arch/hexagon/include/asm/cacheflush.h   |  2 +-
 arch/loongarch/include/asm/cacheflush.h |  2 --
 arch/m68k/include/asm/cacheflush_mm.h   |  1 -
 arch/mips/include/asm/cacheflush.h      |  6 ------
 arch/nios2/include/asm/cacheflush.h     |  2 +-
 arch/nios2/mm/cacheflush.c              |  1 +
 arch/parisc/include/asm/cacheflush.h    |  2 +-
 arch/sh/include/asm/cacheflush.h        |  2 +-
 arch/sparc/include/asm/cacheflush_32.h  |  2 --
 arch/sparc/include/asm/cacheflush_64.h  |  3 ---
 arch/xtensa/include/asm/cacheflush.h    |  4 ----
 include/asm-generic/cacheflush.h        | 12 ------------
 include/linux/cacheflush.h              |  9 +++++++++
 18 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/arch/alpha/include/asm/cacheflush.h b/arch/alpha/include/asm/cacheflush.h
index 3956460e69e2..36a7e924c3b9 100644
--- a/arch/alpha/include/asm/cacheflush.h
+++ b/arch/alpha/include/asm/cacheflush.h
@@ -53,10 +53,6 @@ extern void flush_icache_user_page(struct vm_area_struct *vma,
 #define flush_icache_user_page flush_icache_user_page
 #endif /* CONFIG_SMP */
 
-/* This is used only in __do_fault and do_swap_page.  */
-#define flush_icache_page(vma, page) \
-	flush_icache_user_page((vma), (page), 0, 0)
-
 /*
  * Both implementations of flush_icache_user_page flush the entire
  * address space, so one call, no matter how many pages.
@@ -66,6 +62,7 @@ static inline void flush_icache_pages(struct vm_area_struct *vma,
 {
 	flush_icache_user_page(vma, page, 0, 0);
 }
+#define flush_icache_pages flush_icache_pages
 
 #include <asm-generic/cacheflush.h>
 
diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index 04f65f588510..bd5b1a9a0544 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -18,15 +18,6 @@
 #include <linux/mm.h>
 #include <asm/shmparam.h>
 
-/*
- * Semantically we need this because icache doesn't snoop dcache/dma.
- * However ARC Cache flush requires paddr as well as vaddr, latter not available
- * in the flush_icache_page() API. So we no-op it but do the equivalent work
- * in update_mmu_cache()
- */
-#define flush_icache_page(vma, page)
-#define flush_icache_pages(vma, page, nr)
-
 void flush_cache_all(void);
 
 void flush_icache_range(unsigned long kstart, unsigned long kend);
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 841e268d2374..f6181f69577f 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -321,13 +321,6 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
 
-/*
- * We don't appear to need to do anything here.  In fact, if we did, we'd
- * duplicate cache flushing elsewhere performed by flush_dcache_page().
- */
-#define flush_icache_page(vma,page)	do { } while (0)
-#define flush_icache_pages(vma, page, nr)	do { } while (0)
-
 /*
  * flush_cache_vmap() is used when creating mappings (eg, via vmap,
  * vmalloc, ioremap etc) in kernel space for pages.  On non-VIPT
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 0d6cb65624c4..908d8b0bc4fd 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -45,7 +45,6 @@ extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, u
 #define flush_cache_vmap(start, end)		cache_wbinv_all()
 #define flush_cache_vunmap(start, end)		cache_wbinv_all()
 
-#define flush_icache_page(vma, page)		do {} while (0);
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
 #define flush_icache_mm_range(mm, start, end)	cache_wbinv_range(start, end)
 #define flush_icache_deferred(mm)		do {} while (0);
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index 9c728933a776..40be16907267 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -33,7 +33,6 @@ static inline void flush_dcache_page(struct page *page)
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_page(vma, page)		do { } while (0)
 
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
 
diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index 63ca314ede89..bdacf72d97e1 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -18,7 +18,7 @@
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *  - flush_icache_range(start, end) flush a range of instructions
  *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
- *  - flush_icache_page(vma, pg) flushes(invalidates) a page for icache
+ *  - flush_icache_pages(vma, pg, nr) flushes(invalidates) nr pages for icache
  *
  *  Need to doublecheck which one is really needed for ptrace stuff to work.
  */
diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 7907eb42bfbd..326ac6f1b27c 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -46,8 +46,6 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
 #define flush_cache_vmap(start, end)			do { } while (0)
 #define flush_cache_vunmap(start, end)			do { } while (0)
-#define flush_icache_page(vma, page)			do { } while (0)
-#define flush_icache_pages(vma, page)			do { } while (0)
 #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
 #define flush_dcache_page(page)				do { } while (0)
 #define flush_dcache_folio(folio)			do { } while (0)
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index d43c8bce149b..c67a8d2e6d6a 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -260,7 +260,6 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_pages(vma, page, nr)	\
 	__flush_pages_to_ram(page_address(page), nr)
-#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
 
 extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 				    unsigned long addr, int len);
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 2683cade42ef..043e50effc62 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -82,12 +82,6 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 		__flush_anon_page(page, vmaddr);
 }
 
-static inline void flush_icache_pages(struct vm_area_struct *vma,
-		struct page *page, unsigned int nr)
-{
-}
-#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
-
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
 extern void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 extern void (*__flush_icache_user_range)(unsigned long start,
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
index 8624ca83cffe..7c48c5213fb7 100644
--- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -35,7 +35,7 @@ void flush_dcache_folio(struct folio *folio);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
 		unsigned int nr);
-#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1);
+#define flush_icache_pages flush_icache_pages
 
 #define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
 #define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 471485a84b2c..2565767b98a3 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -147,6 +147,7 @@ void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
 	__flush_dcache(start, end);
 	__flush_icache(start, end);
 }
+#define flush_icache_pages flush_icache_pages
 
 void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
 			unsigned long pfn)
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 0bf8b69d086b..e4fdce328dbd 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -59,7 +59,7 @@ static inline void flush_dcache_page(struct page *page)
 
 void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
 		unsigned int nr);
-#define flush_icache_page(vma, page)	flush_icache_pages(vma, page, 1)
+#define flush_icache_pages flush_icache_pages
 
 #define flush_icache_range(s,e)		do { 		\
 	flush_kernel_dcache_range_asm(s,e); 		\
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 9fceef6f3e00..878b6b551bd2 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -53,7 +53,7 @@ extern void flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_user_range flush_icache_range
 void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
 		unsigned int nr);
-#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
+#define flush_icache_pages flush_icache_pages
 extern void flush_cache_sigtramp(unsigned long address);
 
 struct flusher_data {
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 8dba35d63328..21f6c918238b 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -15,8 +15,6 @@
 #define flush_cache_page(vma,addr,pfn) \
 	sparc32_cachetlb_ops->cache_page(vma, addr)
 #define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma, pg)		do { } while (0)
-#define flush_icache_pages(vma, pg, nr)		do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index a9a719f04d06..0e879004efff 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -53,9 +53,6 @@ static inline void flush_dcache_page(struct page *page)
 	flush_dcache_folio(page_folio(page));
 }
 
-#define flush_icache_page(vma, pg)	do { } while(0)
-#define flush_icache_pages(vma, pg, nr)	do { } while(0)
-
 void flush_ptrace_access(struct vm_area_struct *, struct page *,
 			 unsigned long uaddr, void *kaddr,
 			 unsigned long len, int write);
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 35153f6725e4..785a00ce83c1 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -160,10 +160,6 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 		__invalidate_icache_range(start,(end) - (start));	\
 	} while (0)
 
-/* This is not required, see Documentation/core-api/cachetlb.rst */
-#define	flush_icache_page(vma,page)			do { } while (0)
-#define	flush_icache_pages(vma, page, nr)		do { } while (0)
-
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
 
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 09d51a680765..84ec53ccc450 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -77,18 +77,6 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 #define flush_icache_user_range flush_icache_range
 #endif
 
-#ifndef flush_icache_page
-static inline void flush_icache_pages(struct vm_area_struct *vma,
-				     struct page *page, unsigned int nr)
-{
-}
-
-static inline void flush_icache_page(struct vm_area_struct *vma,
-				     struct page *page)
-{
-}
-#endif
-
 #ifndef flush_icache_user_page
 static inline void flush_icache_user_page(struct vm_area_struct *vma,
 					   struct page *page,
diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
index 82136f3fcf54..55f297b2c23f 100644
--- a/include/linux/cacheflush.h
+++ b/include/linux/cacheflush.h
@@ -17,4 +17,13 @@ static inline void flush_dcache_folio(struct folio *folio)
 #define flush_dcache_folio flush_dcache_folio
 #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
 
+#ifndef flush_icache_pages
+static inline void flush_icache_pages(struct vm_area_struct *vma,
+				     struct page *page, unsigned int nr)
+{
+}
+#endif
+
+#define flush_icache_page(vma, page)	flush_icache_pages(vma, page, 1)
+
 #endif /* _LINUX_CACHEFLUSH_H */
-- 
2.39.1

