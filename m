Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439C476D186
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjHBPPm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjHBPOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812726AD;
        Wed,  2 Aug 2023 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b/IhDBaU8cZlRIdYXmEsOGIK2MyXItqBYHaddfMXiGg=; b=Zm+0CngxzGv2WvFuZEvaffMNDW
        900jXk5SzkrupjIQ7n3/oJO/nQpbRA9NgknwrvLWC1+mx/mOvwBSfT3ilnCcqtACLz178mHdY9NkG
        75MxbgLE0lPjlUnGR47kISHpFPDKxjK8ViGYw2CKWaJ6IgWrM/EWkLU/BR9/us7m+nvbwcLRH6sUz
        yRPoUS0oH/x8Or3Ab48V8Oxz5/nVXGB1XIhCpA8YumYbmL5/mCHv4P6mS2bblmJLQtnmXXGEILa3a
        BBt0ThaJ8CUzlQzl3xvJ/dvu125kH20h0I8NgtQ7ag7NhcndvuXo/merf9kqInQk900kJg8smhJHO
        jTowKZtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffik-Ce; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 05/38] mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
Date:   Wed,  2 Aug 2023 16:13:33 +0100
Message-Id: <20230802151406.3735276-6-willy@infradead.org>
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

Current best practice is to reuse the name of the function as a define
to indicate that the function is implemented by the architecture.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/core-api/cachetlb.rst | 24 +++++++++---------------
 include/linux/cacheflush.h          |  4 ++--
 mm/util.c                           |  2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index b645947954fb..889fc84ccd1b 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -273,7 +273,7 @@ maps this page at its virtual address.
 	If D-cache aliasing is not an issue, these two routines may
 	simply call memcpy/memset directly and do nothing more.
 
-  ``void flush_dcache_page(struct page *page)``
+  ``void flush_dcache_folio(struct folio *folio)``
 
         This routines must be called when:
 
@@ -281,7 +281,7 @@ maps this page at its virtual address.
 	     and / or in high memory
 	  b) the kernel is about to read from a page cache page and user space
 	     shared/writable mappings of this page potentially exist.  Note
-	     that {get,pin}_user_pages{_fast} already call flush_dcache_page
+	     that {get,pin}_user_pages{_fast} already call flush_dcache_folio
 	     on any page found in the user address space and thus driver
 	     code rarely needs to take this into account.
 
@@ -295,7 +295,7 @@ maps this page at its virtual address.
 
 	The phrase "kernel writes to a page cache page" means, specifically,
 	that the kernel executes store instructions that dirty data in that
-	page at the page->virtual mapping of that page.  It is important to
+	page at the kernel virtual mapping of that page.  It is important to
 	flush here to handle D-cache aliasing, to make sure these kernel stores
 	are visible to user space mappings of that page.
 
@@ -306,18 +306,18 @@ maps this page at its virtual address.
 	If D-cache aliasing is not an issue, this routine may simply be defined
 	as a nop on that architecture.
 
-        There is a bit set aside in page->flags (PG_arch_1) as "architecture
+        There is a bit set aside in folio->flags (PG_arch_1) as "architecture
 	private".  The kernel guarantees that, for pagecache pages, it will
 	clear this bit when such a page first enters the pagecache.
 
 	This allows these interfaces to be implemented much more
 	efficiently.  It allows one to "defer" (perhaps indefinitely) the
 	actual flush if there are currently no user processes mapping this
-	page.  See sparc64's flush_dcache_page and update_mmu_cache_range
+	page.  See sparc64's flush_dcache_folio and update_mmu_cache_range
 	implementations for an example of how to go about doing this.
 
-	The idea is, first at flush_dcache_page() time, if
-	page_file_mapping() returns a mapping, and mapping_mapped on that
+	The idea is, first at flush_dcache_folio() time, if
+	folio_flush_mapping() returns a mapping, and mapping_mapped() on that
 	mapping returns %false, just mark the architecture private page
 	flag bit.  Later, in update_mmu_cache_range(), a check is made
 	of this flag bit, and if set the flush is done and the flag bit
@@ -331,12 +331,6 @@ maps this page at its virtual address.
 			dirty.  Again, see sparc64 for examples of how
 			to deal with this.
 
-  ``void flush_dcache_folio(struct folio *folio)``
-	This function is called under the same circumstances as
-	flush_dcache_page().  It allows the architecture to
-	optimise for flushing the entire folio of pages instead
-	of flushing one page at a time.
-
   ``void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
   unsigned long user_vaddr, void *dst, void *src, int len)``
   ``void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
@@ -357,7 +351,7 @@ maps this page at its virtual address.
 
   	When the kernel needs to access the contents of an anonymous
 	page, it calls this function (currently only
-	get_user_pages()).  Note: flush_dcache_page() deliberately
+	get_user_pages()).  Note: flush_dcache_folio() deliberately
 	doesn't work for an anonymous page.  The default
 	implementation is a nop (and should remain so for all coherent
 	architectures).  For incoherent architectures, it should flush
@@ -374,7 +368,7 @@ maps this page at its virtual address.
   ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``
 
 	All the functionality of flush_icache_page can be implemented in
-	flush_dcache_page and update_mmu_cache_range. In the future, the hope
+	flush_dcache_folio and update_mmu_cache_range. In the future, the hope
 	is to remove this interface completely.
 
 The final category of APIs is for I/O to deliberately aliased address
diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
index a6189d21f2ba..82136f3fcf54 100644
--- a/include/linux/cacheflush.h
+++ b/include/linux/cacheflush.h
@@ -7,14 +7,14 @@
 struct folio;
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+#ifndef flush_dcache_folio
 void flush_dcache_folio(struct folio *folio);
 #endif
 #else
 static inline void flush_dcache_folio(struct folio *folio)
 {
 }
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
+#define flush_dcache_folio flush_dcache_folio
 #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
 
 #endif /* _LINUX_CACHEFLUSH_H */
diff --git a/mm/util.c b/mm/util.c
index 5e9305189c3f..cde229b05eb3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1119,7 +1119,7 @@ void page_offline_end(void)
 }
 EXPORT_SYMBOL(page_offline_end);
 
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+#ifndef flush_dcache_folio
 void flush_dcache_folio(struct folio *folio)
 {
 	long i, nr = folio_nr_pages(folio);
-- 
2.40.1

