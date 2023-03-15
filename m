Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47056BA6D7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCOFQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCOFPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80D34312;
        Tue, 14 Mar 2023 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y6UQRtApFRekBXOS3Hoo+JaDt5MuymsqP/Dtb80Hd68=; b=kMtfC4Y8cRwzxnyikLnmC+pXrF
        S08XyEXWi259m5wWZQqlD79SBIbUYDxcBLuSL86NVAnvtg4xXfUpltnS44mI+15iJXI9fg69EAtlg
        MFIUlzW9PHr3U1aoRU6P/B6aSLfq4i/oLgpIFnUfxfZ6d5qRVlFsATQUZdfABblJUxj02K64BvXpu
        nOhhgag7XC2+IC+wmMtRq5j7b59hvdYcelXnmrIYdRsXeq+SOSx6p7FPuyxFeXcRHgv5D5Bms1+Ni
        voGyM7rAG7rdO/7aF//y2RXEjckrpOfLiBlAJ7ioUYzG0feEklpTZUSI/jBHX5Pog4JA0O1BxkSV8
        Xm1kdeqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTK-00DYAt-IK; Wed, 15 Mar 2023 05:14:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/36] mm: Add generic flush_icache_pages() and documentation
Date:   Wed, 15 Mar 2023 05:14:10 +0000
Message-Id: <20230315051444.3229621-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

flush_icache_page() is deprecated but not yet removed, so add
a range version of it.  Change the documentation to refer to
update_mmu_cache_range() instead of update_mmu_cache().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/cachetlb.rst | 35 +++++++++++++++--------------
 include/asm-generic/cacheflush.h    |  5 +++++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 5c0552e78c58..d4c9e2a28d36 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -88,13 +88,13 @@ changes occur:
 
 	This is used primarily during fault processing.
 
-5) ``void update_mmu_cache(struct vm_area_struct *vma,
-   unsigned long address, pte_t *ptep)``
+5) ``void update_mmu_cache_range(struct vm_area_struct *vma,
+   unsigned long address, pte_t *ptep, unsigned int nr)``
 
-	At the end of every page fault, this routine is invoked to
-	tell the architecture specific code that a translation
-	now exists at virtual address "address" for address space
-	"vma->vm_mm", in the software page tables.
+	At the end of every page fault, this routine is invoked to tell
+	the architecture specific code that translations now exists
+	in the software page tables for address space "vma->vm_mm"
+	at virtual address "address" for "nr" consecutive pages.
 
 	A port may use this information in any way it so chooses.
 	For example, it could use this event to pre-load TLB
@@ -306,17 +306,18 @@ maps this page at its virtual address.
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
 
@@ -369,7 +370,7 @@ maps this page at its virtual address.
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
2.39.2

