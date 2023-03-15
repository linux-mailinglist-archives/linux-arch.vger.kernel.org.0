Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB26BA6E7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCOFQ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjCOFPj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A63E612;
        Tue, 14 Mar 2023 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PaqUJoSuStWz+a+eZ6H5Czv2RDkRGCSPMhY7d1rRpLQ=; b=vvhYyf+z+JwQ/j/pQJl+0gs8Cg
        Z7U9+n33E4ya8Rs6VKmmnqEH28jdQ4DqxJoZzM5mdflmtSMd+yi4QD5DY7G6MwTu/aY/fxbFfqpzA
        GNRHXJsPYag8wyB2MsDXq0FNR167SZ8hfIU8jfQYsAEEWY7xVUG2EUAiHGSR8zgrURZk0SBcC/tw3
        /zcFkUw5x8LSpC4C5WwfSqdey12gZW0dngWQsr7691RQiTnLYh7PJh4w2M+kkStz9lDF4v7fY+LUA
        HFBny6CHlaD22KncUJZ6rWt/MD07tTSoYRCHZOIQywVMEC83Jj2z/yp/0ev2MTAuRFR9j6kKg88OI
        cmYZqZ9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTO-00DYDm-Gh; Wed, 15 Mar 2023 05:14:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 33/36] filemap: Add filemap_map_folio_range()
Date:   Wed, 15 Mar 2023 05:14:41 +0000
Message-Id: <20230315051444.3229621-34-willy@infradead.org>
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

filemap_map_folio_range() maps partial/full folio. Comparing to original
filemap_map_pages(), it updates refcount once per folio instead of per
page and gets minor performance improvement for large folio.

With a will-it-scale.page_fault3 like app (change file write
fault testing to read fault testing. Trying to upstream it to
will-it-scale at [1]), got 2% performance gain on a 48C/96T
Cascade Lake test box with 96 processes running against xfs.

[1]: https://github.com/antonblanchard/will-it-scale/pull/37

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 98 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..6e2b0778db45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2199,16 +2199,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios);
 
-static inline
-bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
-{
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
-		return false;
-	if (index >= max)
-		return false;
-	return index < folio->index + folio_nr_pages(folio) - 1;
-}
-
 /**
  * filemap_get_folios_contig - Get a batch of contiguous folios
  * @mapping:	The address_space to search
@@ -3480,6 +3470,53 @@ static inline struct folio *next_map_page(struct address_space *mapping,
 				  mapping, xas, end_pgoff);
 }
 
+/*
+ * Map page range [start_page, start_page + nr_pages) of folio.
+ * start_page is gotten from start by folio_page(folio, start)
+ */
+static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
+			struct folio *folio, unsigned long start,
+			unsigned long addr, unsigned int nr_pages)
+{
+	vm_fault_t ret = 0;
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
+	struct page *page = folio_page(folio, start);
+	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+	unsigned int ref_count = 0, count = 0;
+
+	do {
+		if (PageHWPoison(page))
+			continue;
+
+		if (mmap_miss > 0)
+			mmap_miss--;
+
+		/*
+		 * NOTE: If there're PTE markers, we'll leave them to be
+		 * handled in the specific fault path, and it'll prohibit the
+		 * fault-around logic.
+		 */
+		if (!pte_none(*vmf->pte))
+			continue;
+
+		if (vmf->address == addr)
+			ret = VM_FAULT_NOPAGE;
+
+		ref_count++;
+		do_set_pte(vmf, page, addr);
+		update_mmu_cache(vma, addr, vmf->pte);
+	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
+
+	/* Restore the vmf->pte */
+	vmf->pte -= nr_pages;
+
+	folio_ref_add(folio, ref_count);
+	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
+
+	return ret;
+}
+
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			     pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -3490,9 +3527,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
-	struct page *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	int nr_pages = 0;
 
 	rcu_read_lock();
 	folio = first_map_page(mapping, &xas, end_pgoff);
@@ -3507,45 +3544,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
-again:
-		page = folio_file_page(folio, xas.xa_index);
-		if (PageHWPoison(page))
-			goto unlock;
-
-		if (mmap_miss > 0)
-			mmap_miss--;
+		unsigned long end;
 
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
+		end = folio->index + folio_nr_pages(folio) - 1;
+		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
 
-		/*
-		 * NOTE: If there're PTE markers, we'll leave them to be
-		 * handled in the specific fault path, and it'll prohibit the
-		 * fault-around logic.
-		 */
-		if (!pte_none(*vmf->pte))
-			goto unlock;
+		ret |= filemap_map_folio_range(vmf, folio,
+				xas.xa_index - folio->index, addr, nr_pages);
+		xas.xa_index += nr_pages;
 
-		/* We're about to handle the fault */
-		if (vmf->address == addr)
-			ret = VM_FAULT_NOPAGE;
-
-		do_set_pte(vmf, page, addr);
-		/* no need to invalidate: a not-present page won't be cached */
-		update_mmu_cache(vma, addr, vmf->pte);
-		if (folio_more_pages(folio, xas.xa_index, end_pgoff)) {
-			xas.xa_index++;
-			folio_ref_inc(folio);
-			goto again;
-		}
-		folio_unlock(folio);
-		continue;
-unlock:
-		if (folio_more_pages(folio, xas.xa_index, end_pgoff)) {
-			xas.xa_index++;
-			goto again;
-		}
 		folio_unlock(folio);
 		folio_put(folio);
 	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
-- 
2.39.2

