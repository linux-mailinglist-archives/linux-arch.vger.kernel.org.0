Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA574DF9B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGJUpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGJUoe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EDE47;
        Mon, 10 Jul 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LZXcBnkSopupOjRiXEH3IjaRoI8hYxfLxhTdnrJE7/E=; b=UZGRwuNvpDEO6LgiTtVda6Le3s
        8V37WDV4IfgqmT9LGcaQms1+Yk3cLoG2A9KbAfSe7Zu8NeuBDEN6ErcwCrCkw9dcBn4cYyRvuPRZr
        Jo9VtQkdKqShHWEOW0l06/c0HvvzKnZATErnunpUS8LoBMVlHlTOTIG2ZyBlqqylUDkogeF1xJwCf
        OlKJu7iSmyX7JGks9C0DDMHv1rEL48wUH5KRJcKgpx6pC2RbyT2o+ycJsWUwUKjbOaleBzWKenZ6u
        7PWFgAZCI1jLFzp9FbolUcv/FaJP8Jf9qxtRccd6BjYahFeP0VEV1rHYVQh6pa/NU/900MqLtqgCv
        jvEi83Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjV-00EurD-0w; Mon, 10 Jul 2023 20:43:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 34/38] filemap: Add filemap_map_folio_range()
Date:   Mon, 10 Jul 2023 21:43:35 +0100
Message-Id: <20230710204339.3554919-35-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 mm/filemap.c | 109 ++++++++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8040545954bc..bdc1e0b811bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2168,16 +2168,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios);
 
-static inline
-bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
-{
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
-		return false;
-	if (index >= max)
-		return false;
-	return index < folio_next_index(folio) - 1;
-}
-
 /**
  * filemap_get_folios_contig - Get a batch of contiguous folios
  * @mapping:	The address_space to search
@@ -3436,10 +3426,10 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	return false;
 }
 
-static struct folio *next_uptodate_page(struct folio *folio,
-				       struct address_space *mapping,
-				       struct xa_state *xas, pgoff_t end_pgoff)
+static struct folio *next_uptodate_folio(struct xa_state *xas,
+		struct address_space *mapping, pgoff_t end_pgoff)
 {
+	struct folio *folio = xas_next_entry(xas, end_pgoff);
 	unsigned long max_idx;
 
 	do {
@@ -3477,20 +3467,51 @@ static struct folio *next_uptodate_page(struct folio *folio,
 	return NULL;
 }
 
-static inline struct folio *first_map_page(struct address_space *mapping,
-					  struct xa_state *xas,
-					  pgoff_t end_pgoff)
+/*
+ * Map page range [start_page, start_page + nr_pages) of folio.
+ * start_page is gotten from start by folio_page(folio, start)
+ */
+static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
+			struct folio *folio, unsigned long start,
+			unsigned long addr, unsigned int nr_pages)
 {
-	return next_uptodate_page(xas_find(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
-}
+	vm_fault_t ret = 0;
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
+	struct page *page = folio_page(folio, start);
+	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+	unsigned int ref_count = 0, count = 0;
 
-static inline struct folio *next_map_page(struct address_space *mapping,
-					 struct xa_state *xas,
-					 pgoff_t end_pgoff)
-{
-	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
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
 }
 
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
@@ -3503,12 +3524,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
-	struct page *page;
-	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	int nr_pages = 0;
 
 	rcu_read_lock();
-	folio = first_map_page(mapping, &xas, end_pgoff);
+	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
@@ -3525,17 +3545,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
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
 
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
@@ -3545,32 +3561,17 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		if (!pte_none(ptep_get(vmf->pte)))
 			goto unlock;
 
-		/* We're about to handle the fault */
-		if (vmf->address == addr)
-			ret = VM_FAULT_NOPAGE;
+		ret |= filemap_map_folio_range(vmf, folio,
+				xas.xa_index - folio->index, addr, nr_pages);
 
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
 unlock:
-		if (folio_more_pages(folio, xas.xa_index, end_pgoff)) {
-			xas.xa_index++;
-			goto again;
-		}
 		folio_unlock(folio);
 		folio_put(folio);
-	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
+		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
+	} while (folio);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
-- 
2.39.2

