Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1E6BA6D8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCOFQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCOFPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784F3B3D5;
        Tue, 14 Mar 2023 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Qw0Yc4WVV1Zo/whVBkY4SGQKG5WI2G272Aisa/gvvD0=; b=S8RSPV+LjPHtyJ+ZmGK5RpjWsO
        x9RMGY+gK6PDYY8ah5J55iodIm8ajJ9dYMel7Bzxl0mHem3mk6/MyBwozsoPXmw/vg7mDV7Fcbk4m
        zcoB1S8IuxVNd1FylJEl3kWT6+26QRF0BEtLTgseAZVqrUVwUeFY3d8otRcJCL5gTtENArL4nzm59
        6aH5mtUGvrKj3wUMHEEX9DkHcbUAttV07JpGgI7MtRsGuSCFWHqEUrIMsopV3MrUNu9axsQOALVo0
        WAwGliINhd73W+rtpXo6yMbZFX1HB9yXcet4rCWEcArGnrTuopm70g434W9/f7XXHL+snwmJkgzOn
        T0hOfrfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTO-00DYE9-Qm; Wed, 15 Mar 2023 05:14:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Date:   Wed, 15 Mar 2023 05:14:43 +0000
Message-Id: <20230315051444.3229621-36-willy@infradead.org>
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

set_pte_range() allows to setup page table entries for a specific
range.  It takes advantage of batched rmap update for large folio.
It now takes care of calling update_mmu_cache_range().

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  2 +-
 include/linux/mm.h                    |  3 ++-
 mm/filemap.c                          |  3 +--
 mm/memory.c                           | 27 +++++++++++++++------------
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 7de7a7272a5e..922886fefb7f 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -663,7 +663,7 @@ locked. The VM will unlock the page.
 Filesystem should find and map pages associated with offsets from "start_pgoff"
 till "end_pgoff". ->map_pages() is called with page table locked and must
 not block.  If it's not possible to reach a page without blocking,
-filesystem should skip it. Filesystem should use do_set_pte() to setup
+filesystem should skip it. Filesystem should use set_pte_range() to setup
 page table entry. Pointer to entry associated with the page is passed in
 "pte" field in vm_fault structure. Pointers to entries for other offsets
 should be calculated relative to "pte".
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee755bb4e1c1..81788c985a8c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1299,7 +1299,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
-void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
+void set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6e2b0778db45..e2317623dcbf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3504,8 +3504,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			ret = VM_FAULT_NOPAGE;
 
 		ref_count++;
-		do_set_pte(vmf, page, addr);
-		update_mmu_cache(vma, addr, vmf->pte);
+		set_pte_range(vmf, folio, page, 1, addr);
 	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
 
 	/* Restore the vmf->pte */
diff --git a/mm/memory.c b/mm/memory.c
index 6aa21e8f3753..9a654802f104 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4274,7 +4274,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 }
 #endif
 
-void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
+void set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
@@ -4282,7 +4283,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	bool prefault = vmf->address != addr;
 	pte_t entry;
 
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr);
 	entry = mk_pte(page, vma->vm_page_prot);
 
 	if (prefault && arch_wants_old_prefaulted_pte())
@@ -4296,14 +4297,18 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
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
+	update_mmu_cache_range(vma, addr, vmf->pte, nr);
 }
 
 static bool vmf_pte_changed(struct vm_fault *vmf)
@@ -4376,11 +4381,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
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

