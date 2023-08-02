Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C976D153
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjHBPOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjHBPOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67F2D7D;
        Wed,  2 Aug 2023 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Af0pKntcHen16/GbGLW0gVbMd8qvjKEK9cTFOJ9hItI=; b=Nx+XGrXDyX+7IPFW52InB8hd3v
        JBTMECGl2tPQnjUQrpbSpBhmHuRwof8MT8yNJwW+igL7NVON13q9w2RTGoaCVDH7tdNzDylHRjQ5N
        hlUB/tOx9jtbpRir9lF2urFyYk6gAya+RSA1kd2UCucnXUTM7n/EY8jofH6CUJQp6Qn31I/Tppsjh
        jp3m/RWgtNBkJBEPhAMtayZ0u70H6ss/kMBjkpf7ty23QlWM//Rdgy9rnCovJF/TzKylE07cXH2bC
        DCre6zz7LfJ9gQ6M78YbecEqZJ9VqMqFp4RVvwIs/AG2RnhmPgA6/r3KPkVGRHLpu0cbveBEZ1Q3G
        f/EbcVMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYB-00FflE-GF; Wed, 02 Aug 2023 15:14:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 31/38] mm: Rationalise flush_icache_pages() and flush_icache_page()
Date:   Wed,  2 Aug 2023 16:13:59 +0100
Message-Id: <20230802151406.3735276-32-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/parisc/include/asm/cacheflush.h    |  2 +-
 arch/sh/include/asm/cacheflush.h        |  2 +-
 arch/sparc/include/asm/cacheflush_32.h  |  2 --
 arch/sparc/include/asm/cacheflush_64.h  |  3 ---
 arch/xtensa/include/asm/cacheflush.h    |  4 ----
 include/asm-generic/cacheflush.h        | 12 ------------
 include/linux/cacheflush.h              |  9 +++++++++
 17 files changed, 14 insertions(+), 56 deletions(-)

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
index dc3f500a5a01..bfff514a81c8 100644
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
index 88a44da50a3b..80bd74106985 100644
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
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 88eb85e81ef6..ed12358c4783 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -261,7 +261,6 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_pages(vma, page, nr)	\
 	__flush_pages_to_ram(page_address(page), nr)
-#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
 
 extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 				    unsigned long addr, int len);
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 0f389bc7cb90..f36c2519ed97 100644
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
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index b77c3e0c37d3..b4006f2a9705 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -60,7 +60,7 @@ static inline void flush_dcache_page(struct page *page)
 
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
index c8dd971f0e88..f3b7270bf71b 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -16,8 +16,6 @@
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
2.40.1

