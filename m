Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82F76D13E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjHBPOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjHBPOS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F82D61;
        Wed,  2 Aug 2023 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sWJNYdXqGD763FMdnHwt3YTZQSetHeelliQAJYOMW5U=; b=ODgX07LlP3sQFSkIbptb9AtJgc
        aaCt28wefXbzh+jzF+mtW4/M2MS161SOAexmrxiEJVBvfMf4Dfthf+3NjqhKyrcEkEOmRfLAgsr2o
        Zkk3vRGGJAs8v76/DT1wxvYQyQnslgAHIcM9NeAuGr3GAv3/i2oOdrGFNFI/d+ccyTKu6XPbqwSQ/
        COCod5aBIAQ7z+dXxFJMofhLgtjXZu5F77MSFSgoRMsJ+U9IlNsgp20zP/XVmaeDFFRbHwIgFndzb
        je7K0gzcmMJsibrqt1C/K6PDAIPqugOFgc4j7kRSb8OBNR4d9LS2i0IQZSZ4eJPK9V6Al4Zz1+ZOz
        Gqw0+z5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffig-6O; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 03/38] mm: Add generic flush_icache_pages() and documentation
Date:   Wed,  2 Aug 2023 16:13:31 +0100
Message-Id: <20230802151406.3735276-4-willy@infradead.org>
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

flush_icache_page() is deprecated but not yet removed, so add
a range version of it.  Change the documentation to refer to
update_mmu_cache_range() instead of update_mmu_cache().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/core-api/cachetlb.rst | 39 ++++++++++++++++-------------
 include/asm-generic/cacheflush.h    |  5 ++++
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 5c0552e78c58..b645947954fb 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -88,13 +88,17 @@ changes occur:
 
 	This is used primarily during fault processing.
 
-5) ``void update_mmu_cache(struct vm_area_struct *vma,
-   unsigned long address, pte_t *ptep)``
+5) ``void update_mmu_cache_range(struct vm_fault *vmf,
+   struct vm_area_struct *vma, unsigned long address, pte_t *ptep,
+   unsigned int nr)``
 
-	At the end of every page fault, this routine is invoked to
-	tell the architecture specific code that a translation
-	now exists at virtual address "address" for address space
-	"vma->vm_mm", in the software page tables.
+	At the end of every page fault, this routine is invoked to tell
+	the architecture specific code that translations now exists
+	in the software page tables for address space "vma->vm_mm"
+	at virtual address "address" for "nr" consecutive pages.
+
+	This routine is also invoked in various other places which pass
+	a NULL "vmf".
 
 	A port may use this information in any way it so chooses.
 	For example, it could use this event to pre-load TLB
@@ -306,17 +310,18 @@ maps this page at its virtual address.
 	private".  The kernel guarantees that, for pagecache pages, it will
 	clear this bit when such a page first enters the pagecache.
 
-	This allows these interfaces to be implemented much more efficiently.
-	It allows one to "defer" (perhaps indefinitely) the actual flush if
-	there are currently no user processes mapping this page.  See sparc64's
-	flush_dcache_page and update_mmu_cache implementations for an example
-	of how to go about doing this.
+	This allows these interfaces to be implemented much more
+	efficiently.  It allows one to "defer" (perhaps indefinitely) the
+	actual flush if there are currently no user processes mapping this
+	page.  See sparc64's flush_dcache_page and update_mmu_cache_range
+	implementations for an example of how to go about doing this.
 
-	The idea is, first at flush_dcache_page() time, if page_file_mapping()
-	returns a mapping, and mapping_mapped on that mapping returns %false,
-	just mark the architecture private page flag bit.  Later, in
-	update_mmu_cache(), a check is made of this flag bit, and if set the
-	flush is done and the flag bit is cleared.
+	The idea is, first at flush_dcache_page() time, if
+	page_file_mapping() returns a mapping, and mapping_mapped on that
+	mapping returns %false, just mark the architecture private page
+	flag bit.  Later, in update_mmu_cache_range(), a check is made
+	of this flag bit, and if set the flush is done and the flag bit
+	is cleared.
 
 	.. important::
 
@@ -369,7 +374,7 @@ maps this page at its virtual address.
   ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``
 
 	All the functionality of flush_icache_page can be implemented in
-	flush_dcache_page and update_mmu_cache. In the future, the hope
+	flush_dcache_page and update_mmu_cache_range. In the future, the hope
 	is to remove this interface completely.
 
 The final category of APIs is for I/O to deliberately aliased address
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index f46258d1a080..09d51a680765 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -78,6 +78,11 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 #endif
 
 #ifndef flush_icache_page
+static inline void flush_icache_pages(struct vm_area_struct *vma,
+				     struct page *page, unsigned int nr)
+{
+}
+
 static inline void flush_icache_page(struct vm_area_struct *vma,
 				     struct page *page)
 {
-- 
2.40.1

