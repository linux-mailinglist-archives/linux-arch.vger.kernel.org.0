Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBC6BA6BA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCOFPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F32A99A;
        Tue, 14 Mar 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wGk85CR/Vctng7oBFjkMJq+NnlgBFRutHAfl1XoD7Y0=; b=g5mC1e+EyDeps/N6wOgNK48uE5
        NY6T5TtawAzHoLWsQhDILMRhrQX9ZM+D075XgvvrVQWkZJLn7Q8AhVPPqiyi4J11YgM7o+meENJAL
        Dw16eYKgzteuuxGMuXlRMTH+J9Q6cDtVus0ee7yF2jdGr63Wa0pkqZIiEIL13eC3ASjbCgBqw4l3P
        PH4awXOcSI2eluFl5bJc028cmRgeBqG1mkXRZyGtFp5+XsRMny84X5Q21WcTuzpnFcvjDwcI7V3M2
        vdQcdA8eIAXECldrZFJcR39/rd9cfuGhbwfRxGKw1tyhasbwt3TDiuF8/mntoH2cVEgfPhNQRwgF0
        56XMdsMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTO-00DYE0-MR; Wed, 15 Mar 2023 05:14:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
Date:   Wed, 15 Mar 2023 05:14:42 +0000
Message-Id: <20230315051444.3229621-35-willy@infradead.org>
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

From: Yin Fengwei <fengwei.yin@intel.com>

folio_add_file_rmap_range() allows to add pte mapping to a specific
range of file folio. Comparing to page_add_file_rmap(), it batched
updates __lruvec_stat for large folio.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  2 ++
 mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..a3825ce81102 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 void page_add_file_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
+		struct vm_area_struct *, bool compound);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 4898e10c569a..a91906b28835 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1301,31 +1301,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 }
 
 /**
- * page_add_file_rmap - add pte mapping to a file page
- * @page:	the page to add the mapping to
+ * folio_add_file_rmap_range - add pte mapping to page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @nr_pages:	The number of pages which will be mapped
  * @vma:	the vm area in which the mapping is added
  * @compound:	charge the page as compound or small page
  *
+ * The page range of folio is defined by [first_page, first_page + nr_pages)
+ *
  * The caller needs to hold the pte lock.
  */
-void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
-		bool compound)
+void folio_add_file_rmap_range(struct folio *folio, struct page *page,
+			unsigned int nr_pages, struct vm_area_struct *vma,
+			bool compound)
 {
-	struct folio *folio = page_folio(page);
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool first;
+	unsigned int nr_pmdmapped = 0, first;
+	int nr = 0;
 
-	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
+	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
-		first = atomic_inc_and_test(&page->_mapcount);
-		nr = first;
-		if (first && folio_test_large(folio)) {
-			nr = atomic_inc_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
+		do {
+			first = atomic_inc_and_test(&page->_mapcount);
+			if (first && folio_test_large(folio)) {
+				first = atomic_inc_return_relaxed(mapped);
+				first = (nr < COMPOUND_MAPPED);
+			}
+
+			if (first)
+				nr++;
+		} while (page++, --nr_pages > 0);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	mlock_vma_folio(folio, vma, compound);
 }
 
+/**
+ * page_add_file_rmap - add pte mapping to a file page
+ * @page:	the page to add the mapping to
+ * @vma:	the vm area in which the mapping is added
+ * @compound:	charge the page as compound or small page
+ *
+ * The caller needs to hold the pte lock.
+ */
+void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
+		bool compound)
+{
+	struct folio *folio = page_folio(page);
+	unsigned int nr_pages;
+
+	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
+
+	if (likely(!compound))
+		nr_pages = 1;
+	else
+		nr_pages = folio_nr_pages(folio);
+
+	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
+}
+
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
-- 
2.39.2

