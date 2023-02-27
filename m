Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94F6A48E0
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0R6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjB0R6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:58:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF540F1;
        Mon, 27 Feb 2023 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i9ts6rBAYolQ1/FBCYccIPnlyslRrUlDUNhaTG0F47Y=; b=QtMpbNCSVu4JKKMG0QgiDe3O8b
        zrRrZY9W8ngOU1X3jxbL7EApreJb8qUkDPJT19/fxOodt64vAkKWFfFaLNqfHZ9+sdL3+c1vWQrRj
        2NE/0nH7B7nIR7QjcKZ0zYypB/xIPiolYiv8qRfxdPwrCrunm+GkZ0xcxRNnurK4JbdwEf6ySQSHe
        HgSLXgm6E8tMHFZeRIGzBIAn2fm9y7NXWTGF9RquGRacqm8JXvQimkq9D7yOlxauD3VPs9qbFF9qD
        QXolgPXHEX6cV8/guJRIeLHspJekp6ZNQK2p3ze3D8Es1HH1LLmJRIDlpPgh8//zrfMP0c+XO5YtU
        YsXZXUvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkw-000IYu-KK; Mon, 27 Feb 2023 17:57:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 27/30] filemap: Add filemap_map_folio_range()
Date:   Mon, 27 Feb 2023 17:57:38 +0000
Message-Id: <20230227175741.71216-28-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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
index 2723104cc06a..db86e459dde6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2202,16 +2202,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
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
@@ -3483,6 +3473,53 @@ static inline struct folio *next_map_page(struct address_space *mapping,
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
@@ -3493,9 +3530,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
-	struct page *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	int nr_pages = 0;
 
 	rcu_read_lock();
 	folio = first_map_page(mapping, &xas, end_pgoff);
@@ -3510,45 +3547,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
2.39.1

