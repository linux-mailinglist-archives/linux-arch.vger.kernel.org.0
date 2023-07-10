Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E474DFB0
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGJUpR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGJUo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C8E78;
        Mon, 10 Jul 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WrqzHXPjiFBpxLGjYvBy8RYTw/0aGQBc23U0HQPGcW8=; b=sIIIXaBAvEZhZh4uxJnWMQ5+Pc
        npP0DZ6HmpXBCr26kwW6ZIWEIYBFLBKcCXU9TqGQNOXKmiqEN+jKNSC8Z9HX/cPYfE7m02dacuYud
        wKh6ttMmQBuM/rIifVS2Pz+d0ohGhEqc3T2T0iJTuUH7KQi8v/ym+tGS9rOCyaeXObjgR3QqJOHxm
        8vIsImmc1dsWvnj/nSgi/1LxdYBySXkzS4DtzFU2k+ESBlnDRke/Ba9/+XMiz+v+soCRM0C5X4N3V
        tTqXfiq7fdOrx9OF8KiFD8hBxpdxBn9jN5+qDoBsFptNWgNjIxDZgn9D7oQBpla75++vL/cMKYYnN
        6r8rSi/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjV-00EurW-Bs; Mon, 10 Jul 2023 20:43:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 36/38] mm: Convert do_set_pte() to set_pte_range()
Date:   Mon, 10 Jul 2023 21:43:37 +0100
Message-Id: <20230710204339.3554919-37-willy@infradead.org>
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

set_pte_range() allows to setup page table entries for a specific
range.  It takes advantage of batched rmap update for large folio.
It now takes care of calling update_mmu_cache_range().

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  2 +-
 include/linux/mm.h                    |  3 ++-
 mm/filemap.c                          |  3 +--
 mm/memory.c                           | 37 +++++++++++++++++----------
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ed148919e11a..211a03053992 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -661,7 +661,7 @@ locked. The VM will unlock the page.
 Filesystem should find and map pages associated with offsets from "start_pgoff"
 till "end_pgoff". ->map_pages() is called with the RCU lock held and must
 not block.  If it's not possible to reach a page without blocking,
-filesystem should skip it. Filesystem should use do_set_pte() to setup
+filesystem should skip it. Filesystem should use set_pte_range() to setup
 page table entry. Pointer to entry associated with the page is passed in
 "pte" field in vm_fault structure. Pointers to entries for other offsets
 should be calculated relative to "pte".
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9687b48dfb1b..525a7e16850a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1314,7 +1314,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
-void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
+void set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
diff --git a/mm/filemap.c b/mm/filemap.c
index bdc1e0b811bf..c06e9d331416 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3501,8 +3501,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			ret = VM_FAULT_NOPAGE;
 
 		ref_count++;
-		do_set_pte(vmf, page, addr);
-		update_mmu_cache(vma, addr, vmf->pte);
+		set_pte_range(vmf, folio, page, 1, addr);
 	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
 
 	/* Restore the vmf->pte */
diff --git a/mm/memory.c b/mm/memory.c
index ebb4138acdb2..e712e5fda56e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4323,15 +4323,24 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 }
 #endif
 
-void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
+/**
+ * set_pte_range - Set a range of PTEs to point to pages in a folio.
+ * @vmf: Fault decription.
+ * @folio: The folio that contains @page.
+ * @page: The first page to create a PTE for.
+ * @nr: The number of PTEs to create.
+ * @addr: The first address to create a PTE for.
+ */
+void set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool prefault = vmf->address != addr;
+	bool prefault = in_range(vmf->address, addr, nr * PAGE_SIZE);
 	pte_t entry;
 
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr);
 	entry = mk_pte(page, vma->vm_page_prot);
 
 	if (prefault && arch_wants_old_prefaulted_pte())
@@ -4345,14 +4354,18 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, addr);
-		lru_cache_add_inactive_or_unevictable(page, vma);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
+		VM_BUG_ON_FOLIO(nr != 1, folio);
+		folio_add_new_anon_rmap(folio, vma, addr);
+		folio_add_lru_vma(folio, vma);
 	} else {
-		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
-		page_add_file_rmap(page, vma, false);
+		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
+		folio_add_file_rmap_range(folio, page, nr, vma, false);
 	}
-	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
+	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
+
+	/* no need to invalidate: a not-present page won't be cached */
+	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr);
 }
 
 static bool vmf_pte_changed(struct vm_fault *vmf)
@@ -4420,11 +4433,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	/* Re-check under ptl */
 	if (likely(!vmf_pte_changed(vmf))) {
-		do_set_pte(vmf, page, vmf->address);
-
-		/* no need to invalidate: a not-present page won't be cached */
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		struct folio *folio = page_folio(page);
 
+		set_pte_range(vmf, folio, page, 1, vmf->address);
 		ret = 0;
 	} else {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
-- 
2.39.2

